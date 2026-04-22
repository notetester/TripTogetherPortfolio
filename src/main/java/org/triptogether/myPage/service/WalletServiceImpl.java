package org.triptogether.myPage.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.function.NotificationUrlBuilder;
import org.triptogether.myPage.mapper.WalletMapper;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.myPage.vo.WalletChargeResultDto;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.myPage.vo.WalletMemberGradePolicyDto;
import org.triptogether.myPage.vo.WalletPaymentDto;
import org.triptogether.reward.service.RewardService;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Slf4j


@Service
@RequiredArgsConstructor
public class WalletServiceImpl implements WalletService {

    private static final long MIN_CHARGE_AMOUNT = 1_000L;
    private static final long MAX_CHARGE_AMOUNT = 1_000_000L;

    private final WalletMapper walletMapper;
    private final RewardService rewardService;
    private final MyPageService myPageService;

    @Override
    public UsersVO getWalletUser(Long userIdx) {
        return walletMapper.selectUserByIdx(userIdx);
    }

    @Override
    public List<WalletPaymentDto> getRecentPaymentHistory(Long userIdx) {
        return walletMapper.selectRecentPaymentHistory(userIdx);
    }

    @Override
    public List<WalletHistoryDto> getRecentWalletHistory(Long userIdx) {
        return walletMapper.selectRecentWalletHistory(userIdx);
    }

    @Override
    public List<WalletMemberGradePolicyDto> getActiveMemberGradePolicies() {
        return walletMapper.selectActiveMemberGradePolicies();
    }

    @Override
    public long getLastMonthPaymentTotal(Long userIdx) {
        return walletMapper.selectLastMonthPaymentTotal(userIdx);
    }

    @Override
    public long getCurrentMonthPaymentTotal(Long userIdx) {
        return walletMapper.selectCurrentMonthPaymentTotal(userIdx);
    }

    /**
     * 실제 PG 없이 충전 완료로 처리한다.
     * 캐시는 입력 금액만큼 증가하고, 마일리지는 충전 금액의 10%를 적립한다.
     */
    @Override
    @Transactional
    public WalletChargeResultDto simulateCashCharge(Long userIdx, long amount) {
        validateChargeAmount(amount);

        UsersVO user = walletMapper.selectUserByIdxForUpdate(userIdx);
        if (user == null) {
            throw new IllegalStateException("로그인 정보가 유효하지 않습니다.");
        }

        long earnedMileage = amount / 10;
        long newCashBalance = user.getCashBalance() + amount;
        long newMileageBalance = user.getMileageBalance() + earnedMileage;

        walletMapper.updateWalletBalances(userIdx, newCashBalance, newMileageBalance);

        WalletPaymentDto payment = new WalletPaymentDto();
        payment.setUserIdx(userIdx);
        payment.setPaymentType("CHARGE");
        payment.setPaymentMethod("TEST");
        payment.setOrderName("캐시 충전 시뮬레이션");
        payment.setSourceType("MANUAL_CHARGE");
        payment.setOriginalAmount(amount);
        payment.setDiscountRate(0.0);
        payment.setDiscountAmount(0L);
        payment.setFinalAmount(amount);
        payment.setUsedCash(0L);
        payment.setUsedMileage(0L);
        payment.setEarnedMileage(earnedMileage);
        payment.setPaymentStatus("COMPLETED");
        walletMapper.insertPaymentHistory(payment);

        rewardService.awardAction(
                userIdx,
                "PAYMENT",
                payment.getPaymentIdx(),
                amount,
                "캐시 충전 시뮬레이션 결제 경험치"
        );

        WalletHistoryDto cashHistory = new WalletHistoryDto();
        cashHistory.setUserIdx(userIdx);
        cashHistory.setAssetType("CASH");
        cashHistory.setChangeType("CHARGE");
        cashHistory.setAmount(amount);
        cashHistory.setBalanceAfter(newCashBalance);
        cashHistory.setRelatedPaymentIdx(payment.getPaymentIdx());
        cashHistory.setDetailMessage("테스트 충전으로 캐시가 지급되었습니다.");
        walletMapper.insertWalletHistory(cashHistory);

        if (earnedMileage > 0) {
            WalletHistoryDto mileageHistory = new WalletHistoryDto();
            mileageHistory.setUserIdx(userIdx);
            mileageHistory.setAssetType("MILEAGE");
            mileageHistory.setChangeType("EARN");
            mileageHistory.setAmount(earnedMileage);
            mileageHistory.setBalanceAfter(newMileageBalance);
            mileageHistory.setRelatedPaymentIdx(payment.getPaymentIdx());
            mileageHistory.setDetailMessage("캐시 충전 10% 적립 마일리지가 지급되었습니다.");
            walletMapper.insertWalletHistory(mileageHistory);
        }

        // ── 결제 완료 후 직전 달 결제 총액 기준으로 회원 등급 재산정 ──
        recalculateMemberGrade(userIdx);

        UsersVO updatedUser = walletMapper.selectUserByIdx(userIdx);
        return new WalletChargeResultDto(updatedUser, amount, earnedMileage);
    }

    /**
     * 직전 달 결제 총액을 기반으로 유저의 회원 등급을 재산정합니다.
     *
     * 처리 흐름:
     * 1. 직전 달 결제 총액 조회 (USER_PAYMENT_HISTORY에서 합산)
     * 2. 활성화된 등급 정책(MEMBER_GRADE_POLICY) 조회
     * 3. 결제 총액이 충족하는 가장 높은 등급 결정
     * 4. 등급이 변경되었으면 USERS.member_grade 갱신
     * 5. USER_GRADE_HISTORY에 이력 저장
     * 6. 마이페이지 알림 생성 (등급 상승/하락 모두)
     */
    @Override
    @Transactional
    public void recalculateMemberGrade(Long userIdx) {
        // 1. 현재 유저 정보 조회
        UsersVO user = walletMapper.selectUserByIdx(userIdx);
        if (user == null) return;

        // 2. 직전 달 결제 총액 합산
        long lastMonthTotal = walletMapper.selectLastMonthPaymentTotal(userIdx);

        // 3. 활성 등급 정책 조회 (sort_order 오름차순: BRONZE → PLATINUM)
        List<WalletMemberGradePolicyDto> policies = walletMapper.selectActiveMemberGradePolicies();
        if (policies == null || policies.isEmpty()) return;

        // 4. 결제 총액이 충족하는 가장 높은 등급 결정
        //    정책은 sort_order ASC (낮은 등급부터) 정렬되어 있으므로
        //    뒤에서부터 역순으로 탐색하여 조건 충족하는 첫 번째(=최고) 등급을 찾음
        String newGrade = "BRONZE";                // 기본값
        BigDecimal newDiscountRate = BigDecimal.ZERO;
        for (int i = policies.size() - 1; i >= 0; i--) {
            WalletMemberGradePolicyDto policy = policies.get(i);
            if (lastMonthTotal >= policy.getMinMonthlyPayment()) {
                newGrade = policy.getMemberGrade();
                newDiscountRate = policy.getDiscountRate();
                break;
            }
        }

        String prevGrade = user.getMemberGrade();

        // 5. 등급이 변경되었으면 USERS 테이블 갱신
        if (!newGrade.equals(prevGrade)) {
            walletMapper.updateMemberGrade(userIdx, newGrade);

            // 6. 마이페이지 알림 생성
            boolean isUpgrade = getGradeOrder(newGrade) > getGradeOrder(prevGrade);
            FeedNotificationDto noti = new FeedNotificationDto();
            noti.setUserIdx(userIdx);
            noti.setSourceType("grade");
            noti.setSourceId(0L);
            noti.setMessage(isUpgrade
                    ? "회원 등급이 " + prevGrade + " → " + newGrade + "으로 승급되었습니다!"
                    : "회원 등급이 " + prevGrade + " → " + newGrade + "으로 변경되었습니다.");
            noti.setTargetUrl(NotificationUrlBuilder.grade());
            myPageService.addNotification(noti);

            log.info("[등급변경] userIdx={}, {} → {}, 직전달 결제={}", userIdx, prevGrade, newGrade, lastMonthTotal);
        }

        // 7. 등급 변경 이력 저장 (변경 여부와 관계없이 산정 기록 남김)
        String baseYearMonth = LocalDate.now()
                .minusMonths(1)
                .format(DateTimeFormatter.ofPattern("yyyyMM"));
        walletMapper.insertGradeHistory(
                userIdx, baseYearMonth, prevGrade, newGrade,
                lastMonthTotal, newDiscountRate
        );
    }

    /**
     * 등급 코드를 숫자 순서로 변환합니다. (승급/강등 판별용)
     */
    private int getGradeOrder(String grade) {
        return switch (grade) {
            case "BRONZE"   -> 1;
            case "SILVER"   -> 2;
            case "GOLD"     -> 3;
            case "DIAMOND"  -> 4;
            case "PLATINUM" -> 5;
            default         -> 0;
        };
    }

    private void validateChargeAmount(long amount) {
        if (amount < MIN_CHARGE_AMOUNT) {
            throw new IllegalArgumentException("충전 금액은 1,000원 이상이어야 합니다.");
        }
        if (amount > MAX_CHARGE_AMOUNT) {
            throw new IllegalArgumentException("1회 충전 한도는 1,000,000원입니다.");
        }
        if (amount % 100 != 0) {
            throw new IllegalArgumentException("충전 금액은 100원 단위로 입력해 주세요.");
        }
    }
}
