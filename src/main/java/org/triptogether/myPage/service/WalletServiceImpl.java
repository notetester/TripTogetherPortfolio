package org.triptogether.myPage.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.function.NotificationUrlBuilder;
import org.triptogether.myPage.mapper.WalletMapper;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.myPage.vo.TossPaymentConfirmResponse;
import org.triptogether.myPage.vo.WalletChargeResultDto;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.myPage.vo.WalletMemberGradePolicyDto;
import org.triptogether.myPage.vo.WalletPaymentDto;
import org.triptogether.myPage.vo.WalletTossChargeRequestDto;
import org.triptogether.reward.service.RewardService;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class WalletServiceImpl implements WalletService {

    private static final long MIN_CHARGE_AMOUNT = 1_000L;
    private static final long MAX_CHARGE_AMOUNT = 1_000_000L;

    private final WalletMapper walletMapper;
    private final RewardService rewardService;
    private final MyPageService myPageService;
    private final TossPaymentsClient tossPaymentsClient;
    private final MessageSource messageSource;

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
     * 기존 시뮬레이션 충전은 DB에 바로 COMPLETED 결제 이력을 남긴 뒤
     * 사용자 캐시/마일리지와 지갑 이력을 함께 반영한다.
     */
    @Override
    @Transactional
    public WalletChargeResultDto simulateCashCharge(Long userIdx, long amount) {
        validateChargeAmount(amount);

        UsersVO user = requireWalletUserForUpdate(userIdx);
        WalletPaymentDto payment = buildCompletedChargePayment(
                userIdx,
                amount,
                "TEST",
                "MANUAL_CHARGE",
                message("wallet.payment.order.manualCharge")
        );
        walletMapper.insertPaymentHistory(payment);

        return applyChargeSideEffects(
                user,
                payment,
                message("wallet.history.detail.cashCharge"),
                message("wallet.history.detail.mileageReward")
        );
    }

    /**
     * 결제창을 열기 전에 READY 상태 주문을 먼저 DB에 저장한다.
     * 이렇게 해두면 성공 콜백이 세션에 의존하지 않고 orderId 기준으로
     * 정확히 어떤 충전 건인지 다시 찾을 수 있다.
     */
    @Override
    @Transactional
    public WalletTossChargeRequestDto prepareTossCharge(Long userIdx,
                                                        long amount,
                                                        String customerKey,
                                                        String successUrl,
                                                        String failUrl,
                                                        Locale locale) {
        validateChargeAmount(amount);

        String orderId = "WALLET-" + UUID.randomUUID().toString().replace("-", "").toUpperCase(Locale.ROOT);
        String orderName = message("wallet.payment.order.tossCharge", locale);

        WalletPaymentDto payment = new WalletPaymentDto();
        payment.setUserIdx(userIdx);
        payment.setPaymentType("CHARGE");
        payment.setPaymentMethod("TOSS");
        payment.setOrderName(orderName);
        payment.setSourceType("TOSS_CHARGE");
        payment.setOriginalAmount(amount);
        payment.setDiscountRate(0.0);
        payment.setDiscountAmount(0L);
        payment.setFinalAmount(amount);
        payment.setUsedCash(0L);
        payment.setUsedMileage(0L);
        payment.setEarnedMileage(0L);
        payment.setPaymentStatus("READY");
        payment.setTossOrderId(orderId);
        payment.setTossStatus("READY");
        payment.setCreatedAt(LocalDateTime.now());
        payment.setPaidAt(LocalDateTime.now());
        walletMapper.insertPaymentHistory(payment);

        WalletTossChargeRequestDto request = new WalletTossChargeRequestDto();
        request.setUserIdx(userIdx);
        request.setAmount(amount);
        request.setOrderId(orderId);
        request.setOrderName(orderName);
        request.setCustomerKey(customerKey);
        request.setSuccessUrl(successUrl);
        request.setFailUrl(failUrl);
        request.setCreatedAt(LocalDateTime.now());
        return request;
    }

    /**
     * success 콜백에서는 orderId로 READY 결제 건을 잠그고,
     * Toss 승인 확인이 끝난 뒤에만 COMPLETED로 바꾸면서 캐시를 지급한다.
     * 이미 COMPLETED라면 중복 적립 없이 기존 결과만 돌려준다.
     */
    @Override
    @Transactional
    public WalletChargeResultDto completeTossCharge(String orderId,
                                                    long amount,
                                                    String paymentKey) {
        if (!hasText(orderId)) {
            throw new IllegalArgumentException(message("wallet.charge.error.orderIdMissing"));
        }
        if (!hasText(paymentKey)) {
            throw new IllegalArgumentException(message("wallet.charge.error.paymentKeyMissing"));
        }

        WalletPaymentDto payment = walletMapper.selectPaymentByTossOrderIdForUpdate(orderId);
        if (payment == null) {
            throw new IllegalStateException(message("wallet.charge.error.pendingNotFound"));
        }

        if ("COMPLETED".equals(payment.getPaymentStatus())) {
            UsersVO alreadyUpdatedUser = walletMapper.selectUserByIdx(payment.getUserIdx());
            return new WalletChargeResultDto(alreadyUpdatedUser, payment.getFinalAmount(), payment.getEarnedMileage());
        }

        if (!"READY".equals(payment.getPaymentStatus())) {
            throw new IllegalStateException(message("wallet.charge.error.invalidStatus"));
        }
        if (payment.getFinalAmount() != amount) {
            throw new IllegalStateException(message("wallet.charge.error.amountMismatch"));
        }

        TossPaymentConfirmResponse response = tossPaymentsClient.confirmPayment(
                paymentKey,
                orderId,
                amount,
                LocaleContextHolder.getLocale()
        );

        if (response == null) {
            throw new IllegalStateException(message("wallet.charge.error.confirmEmpty"));
        }
        if (response.getTotalAmount() != payment.getFinalAmount()) {
            throw new IllegalStateException(message("wallet.charge.error.amountMismatch"));
        }
        if (hasText(response.getOrderId()) && !orderId.equals(response.getOrderId())) {
            throw new IllegalStateException(message("wallet.charge.error.orderMismatch"));
        }
        if (hasText(response.getStatus()) && !"DONE".equalsIgnoreCase(response.getStatus())) {
            throw new IllegalStateException(message("wallet.charge.error.invalidProviderStatus"));
        }

        UsersVO user = requireWalletUserForUpdate(payment.getUserIdx());
        long earnedMileage = payment.getFinalAmount() / 10;

        payment.setPaymentMethod(hasText(response.getMethod()) ? response.getMethod() : "CARD");
        payment.setOrderName(hasText(response.getOrderName()) ? response.getOrderName() : payment.getOrderName());
        payment.setEarnedMileage(earnedMileage);
        payment.setPaymentStatus("COMPLETED");
        payment.setTossPaymentKey(paymentKey);
        payment.setTossStatus(hasText(response.getStatus()) ? response.getStatus() : "DONE");
        payment.setTossApprovedAt(parseApprovedAt(response.getApprovedAt()));

        int updated = walletMapper.updateReadyTossPaymentAsCompleted(payment);
        if (updated == 0) {
            WalletPaymentDto latest = walletMapper.selectPaymentByTossOrderId(orderId);
            if (latest != null && "COMPLETED".equals(latest.getPaymentStatus())) {
                UsersVO alreadyUpdatedUser = walletMapper.selectUserByIdx(latest.getUserIdx());
                return new WalletChargeResultDto(alreadyUpdatedUser, latest.getFinalAmount(), latest.getEarnedMileage());
            }
            throw new IllegalStateException(message("wallet.charge.error.invalidStatus"));
        }

        return applyChargeSideEffects(
                user,
                payment,
                message("wallet.history.detail.cashCharge"),
                message("wallet.history.detail.mileageReward")
        );
    }

    @Override
    @Transactional
    public void cancelPendingTossCharge(String orderId) {
        if (!hasText(orderId)) {
            return;
        }
        walletMapper.deleteReadyTossPaymentByTossOrderId(orderId);
    }

    private WalletChargeResultDto applyChargeSideEffects(UsersVO user,
                                                         WalletPaymentDto payment,
                                                         String cashHistoryMessage,
                                                         String mileageHistoryMessage) {
        long chargeAmount = payment.getFinalAmount();
        long earnedMileage = payment.getEarnedMileage();
        long newCashBalance = user.getCashBalance() + chargeAmount;
        long newMileageBalance = user.getMileageBalance() + earnedMileage;

        walletMapper.updateWalletBalances(user.getUserIdx(), newCashBalance, newMileageBalance);

        rewardService.awardAction(
                user.getUserIdx(),
                "PAYMENT",
                payment.getPaymentIdx(),
                chargeAmount,
                payment.getOrderName() + " " + message("wallet.reward.description")
        );

        WalletHistoryDto cashHistory = new WalletHistoryDto();
        cashHistory.setUserIdx(user.getUserIdx());
        cashHistory.setAssetType("CASH");
        cashHistory.setChangeType("CHARGE");
        cashHistory.setAmount(chargeAmount);
        cashHistory.setBalanceAfter(newCashBalance);
        cashHistory.setRelatedPaymentIdx(payment.getPaymentIdx());
        cashHistory.setDetailMessage(cashHistoryMessage);
        walletMapper.insertWalletHistory(cashHistory);

        if (earnedMileage > 0) {
            WalletHistoryDto mileageHistory = new WalletHistoryDto();
            mileageHistory.setUserIdx(user.getUserIdx());
            mileageHistory.setAssetType("MILEAGE");
            mileageHistory.setChangeType("EARN");
            mileageHistory.setAmount(earnedMileage);
            mileageHistory.setBalanceAfter(newMileageBalance);
            mileageHistory.setRelatedPaymentIdx(payment.getPaymentIdx());
            mileageHistory.setDetailMessage(mileageHistoryMessage);
            walletMapper.insertWalletHistory(mileageHistory);
        }

        recalculateMemberGrade(user.getUserIdx());

        UsersVO updatedUser = walletMapper.selectUserByIdx(user.getUserIdx());
        return new WalletChargeResultDto(updatedUser, chargeAmount, earnedMileage);
    }

    private WalletPaymentDto buildCompletedChargePayment(Long userIdx,
                                                         long amount,
                                                         String paymentMethod,
                                                         String sourceType,
                                                         String orderName) {
        WalletPaymentDto payment = new WalletPaymentDto();
        payment.setUserIdx(userIdx);
        payment.setPaymentType("CHARGE");
        payment.setPaymentMethod(paymentMethod);
        payment.setOrderName(orderName);
        payment.setSourceType(sourceType);
        payment.setOriginalAmount(amount);
        payment.setDiscountRate(0.0);
        payment.setDiscountAmount(0L);
        payment.setFinalAmount(amount);
        payment.setUsedCash(0L);
        payment.setUsedMileage(0L);
        payment.setEarnedMileage(amount / 10);
        payment.setPaymentStatus("COMPLETED");
        payment.setPaidAt(LocalDateTime.now());
        payment.setCreatedAt(LocalDateTime.now());
        return payment;
    }

    private UsersVO requireWalletUserForUpdate(Long userIdx) {
        UsersVO user = walletMapper.selectUserByIdxForUpdate(userIdx);
        if (user == null) {
            throw new IllegalStateException(message("wallet.charge.error.userNotFound"));
        }
        return user;
    }

    private LocalDateTime parseApprovedAt(String approvedAt) {
        if (!hasText(approvedAt)) {
            return null;
        }

        try {
            return OffsetDateTime.parse(approvedAt).toLocalDateTime();
        } catch (DateTimeParseException ignored) {
            try {
                return LocalDateTime.parse(approvedAt);
            } catch (DateTimeParseException ignoredAgain) {
                return null;
            }
        }
    }

    /**
     * 직전 달 결제 총액을 기준으로 사용자의 회원 등급을 다시 계산한다.
     *
     * 처리 흐름:
     * 1. 현재 사용자 조회
     * 2. 직전 달 COMPLETED 결제 총액 합산
     * 3. 활성 등급 정책 조회
     * 4. 조건을 만족하는 최고 등급 결정
     * 5. USERS.member_grade 갱신
     * 6. USER_GRADE_HISTORY 기록
     * 7. 마이페이지 알림 생성
     */
    @Override
    @Transactional
    public void recalculateMemberGrade(Long userIdx) {
        UsersVO user = walletMapper.selectUserByIdx(userIdx);
        if (user == null) {
            return;
        }

        long lastMonthTotal = walletMapper.selectLastMonthPaymentTotal(userIdx);
        List<WalletMemberGradePolicyDto> policies = walletMapper.selectActiveMemberGradePolicies();
        if (policies == null || policies.isEmpty()) {
            return;
        }

        String newGrade = "BRONZE";
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
        if (!newGrade.equals(prevGrade)) {
            walletMapper.updateMemberGrade(userIdx, newGrade);

            boolean isUpgrade = getGradeOrder(newGrade) > getGradeOrder(prevGrade);
            FeedNotificationDto noti = new FeedNotificationDto();
            noti.setUserIdx(userIdx);
            noti.setSourceType("grade");
            noti.setSourceId(0L);
            noti.setMessage(isUpgrade
                    ? "회원 등급이 " + prevGrade + " 에서 " + newGrade + " 으로 상승했습니다."
                    : "회원 등급이 " + prevGrade + " 에서 " + newGrade + " 으로 변경되었습니다.");
            noti.setTargetUrl(NotificationUrlBuilder.grade());
            myPageService.addNotification(noti);

            log.info("[등급변경] userIdx={}, {} -> {}, 직전달 결제={}", userIdx, prevGrade, newGrade, lastMonthTotal);
        }

        String baseYearMonth = LocalDate.now()
                .minusMonths(1)
                .format(DateTimeFormatter.ofPattern("yyyyMM"));
        walletMapper.insertGradeHistory(
                userIdx, baseYearMonth, prevGrade, newGrade,
                lastMonthTotal, newDiscountRate
        );
    }

    private int getGradeOrder(String grade) {
        return switch (grade) {
            case "BRONZE" -> 1;
            case "SILVER" -> 2;
            case "GOLD" -> 3;
            case "DIAMOND" -> 4;
            case "PLATINUM" -> 5;
            default -> 0;
        };
    }

    private void validateChargeAmount(long amount) {
        if (amount < MIN_CHARGE_AMOUNT) {
            throw new IllegalArgumentException(message("wallet.charge.error.min", MIN_CHARGE_AMOUNT));
        }
        if (amount > MAX_CHARGE_AMOUNT) {
            throw new IllegalArgumentException(message("wallet.charge.limitMessage"));
        }
        if (amount % 100 != 0) {
            throw new IllegalArgumentException(message("wallet.charge.error.step"));
        }
    }

    private boolean hasText(String value) {
        return value != null && !value.isBlank();
    }

    private String message(String code, Object... args) {
        return messageSource.getMessage(code, args, LocaleContextHolder.getLocale());
    }

    private String message(String code, Locale locale, Object... args) {
        return messageSource.getMessage(code, args, locale);
    }
}
