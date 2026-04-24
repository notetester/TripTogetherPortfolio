package org.triptogether.myPage.service;

import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.vo.WalletChargeResultDto;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.myPage.vo.WalletMemberGradePolicyDto;
import org.triptogether.myPage.vo.WalletPaymentDto;
import org.triptogether.myPage.vo.WalletTossChargeRequestDto;

import java.util.List;

public interface WalletService {

    UsersVO getWalletUser(Long userIdx);

    List<WalletPaymentDto> getRecentPaymentHistory(Long userIdx);

    List<WalletHistoryDto> getRecentWalletHistory(Long userIdx);

    List<WalletMemberGradePolicyDto> getActiveMemberGradePolicies();

    WalletChargeResultDto simulateCashCharge(Long userIdx, long amount);

    WalletChargeResultDto completeTossCharge(Long userIdx,
                                             WalletTossChargeRequestDto request,
                                             String paymentKey);

    /**
     * 직전 달 결제 총액을 조회합니다.
     * (등급 재산정 로직에서 사용)
     */
    long getLastMonthPaymentTotal(Long userIdx);

    /**
     * 당월 결제 총액을 조회합니다.
     * (마이페이지 등급 바에서 "이번 달 → 다음 달 예상 등급" 표시에 사용)
     */
    long getCurrentMonthPaymentTotal(Long userIdx);

    /**
     * 직전 달 결제 총액을 기반으로 유저의 회원 등급을 재산정합니다.
     * 등급이 변경되면 USER_GRADE_HISTORY에 이력을 남기고,
     * 마이페이지 알림을 생성합니다.
     */
    void recalculateMemberGrade(Long userIdx);
}
