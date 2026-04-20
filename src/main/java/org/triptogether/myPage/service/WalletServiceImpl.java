package org.triptogether.myPage.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.mapper.WalletMapper;
import org.triptogether.myPage.vo.WalletChargeResultDto;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.myPage.vo.WalletMemberGradePolicyDto;
import org.triptogether.myPage.vo.WalletPaymentDto;
import org.triptogether.reward.service.RewardService;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WalletServiceImpl implements WalletService {

    private static final long MIN_CHARGE_AMOUNT = 1_000L;
    private static final long MAX_CHARGE_AMOUNT = 1_000_000L;

    private final WalletMapper walletMapper;
    private final RewardService rewardService;

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

        UsersVO updatedUser = walletMapper.selectUserByIdx(userIdx);
        return new WalletChargeResultDto(updatedUser, amount, earnedMileage);
    }

    private void validateChargeAmount(long amount) {
        if (amount < MIN_CHARGE_AMOUNT) {
            throw new IllegalArgumentException("충전 금액은 1,000원 이상이어야 합니다.");
        }
        if (amount > MAX_CHARGE_AMOUNT) {
            throw new IllegalArgumentException("한 번에 충전할 수 있는 최대 금액은 1,000,000원입니다.");
        }
        if (amount % 100 != 0) {
            throw new IllegalArgumentException("충전 금액은 100원 단위로 입력해 주세요.");
        }
    }
}
