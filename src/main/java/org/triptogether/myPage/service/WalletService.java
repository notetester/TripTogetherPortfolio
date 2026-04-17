package org.triptogether.myPage.service;

import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.vo.WalletChargeResultDto;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.myPage.vo.WalletMemberGradePolicyDto;
import org.triptogether.myPage.vo.WalletPaymentDto;

import java.util.List;

public interface WalletService {

    UsersVO getWalletUser(Long userIdx);

    List<WalletPaymentDto> getRecentPaymentHistory(Long userIdx);

    List<WalletHistoryDto> getRecentWalletHistory(Long userIdx);

    List<WalletMemberGradePolicyDto> getActiveMemberGradePolicies();

    WalletChargeResultDto simulateCashCharge(Long userIdx, long amount);
}
