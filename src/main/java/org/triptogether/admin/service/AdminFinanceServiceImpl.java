package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.admin.mapper.AdminFinanceMapper;
import org.triptogether.admin.vo.AdminFinanceStatsDto;
import org.triptogether.admin.vo.AdminFinanceUserSearchDto;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.mapper.WalletMapper;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.myPage.vo.WalletPaymentDto;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminFinanceServiceImpl implements AdminFinanceService {

    private final AdminFinanceMapper adminFinanceMapper;
    private final WalletMapper walletMapper;  // 사용자 상세/이력은 기존 mapper 재사용

    @Override
    public AdminFinanceStatsDto getStats() {
        return adminFinanceMapper.selectFinanceStats();
    }

    @Override
    public List<UsersVO> getUserList(AdminFinanceUserSearchDto search) {
        return adminFinanceMapper.selectFinanceUserList(search);
    }

    @Override
    public int getTotalCount(AdminFinanceUserSearchDto search) {
        return adminFinanceMapper.selectFinanceTotalCount(search);
    }

    @Override
    public int getTotalPage(AdminFinanceUserSearchDto search) {
        int total = getTotalCount(search);
        return (int) Math.ceil((double) total / search.getPageSize());
    }

    @Override
    public UsersVO getUser(Long userIdx) {
        return walletMapper.selectUserByIdx(userIdx);
    }

    @Override
    public List<WalletHistoryDto> getWalletHistory(Long userIdx) {
        return walletMapper.selectRecentWalletHistory(userIdx);
    }

    @Override
    public List<WalletPaymentDto> getPaymentHistory(Long userIdx) {
        return walletMapper.selectRecentPaymentHistory(userIdx);
    }
}
