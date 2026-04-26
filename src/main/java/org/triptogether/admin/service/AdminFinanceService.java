package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdminFinanceStatsDto;
import org.triptogether.admin.vo.AdminFinanceUserSearchDto;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.myPage.vo.WalletPaymentDto;

import java.util.List;

/**
 * 어드민 내지갑 관리 서비스 (FINANCE_ADMIN 권한 영역, MVP read-only).
 */
public interface AdminFinanceService {

    /** 대시보드 집계 */
    AdminFinanceStatsDto getStats();

    /** 사용자 목록 + 자산 (페이지네이션) */
    List<UsersVO> getUserList(AdminFinanceUserSearchDto search);

    /** 사용자 목록 총 개수 */
    int getTotalCount(AdminFinanceUserSearchDto search);

    /** 총 페이지 수 */
    int getTotalPage(AdminFinanceUserSearchDto search);

    /** 사용자 상세 (자산 + 등급) */
    UsersVO getUser(Long userIdx);

    /** 사용자별 자산 변동 이력 */
    List<WalletHistoryDto> getWalletHistory(Long userIdx);

    /** 사용자별 결제 이력 */
    List<WalletPaymentDto> getPaymentHistory(Long userIdx);
}
