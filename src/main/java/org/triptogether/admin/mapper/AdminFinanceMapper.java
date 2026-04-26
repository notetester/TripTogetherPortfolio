package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.triptogether.admin.vo.AdminFinanceStatsDto;
import org.triptogether.admin.vo.AdminFinanceUserSearchDto;
import org.triptogether.auth.vo.UsersVO;

import java.util.List;

/**
 * 어드민 내지갑 관리 전용 Mapper. 모두 read-only.
 * 정책: 자산 조정/환불은 미포함 (신성륜 영역 침범 회피)
 */
@Mapper
public interface AdminFinanceMapper {

    /** 대시보드 집계 통계 (자산 총합 + 회원 수 + 충전 합계) */
    AdminFinanceStatsDto selectFinanceStats();

    /** 사용자 목록 (자산 잔액 + 회원 등급 포함, 페이지네이션) */
    List<UsersVO> selectFinanceUserList(AdminFinanceUserSearchDto search);

    /** 사용자 목록 카운트 (페이지네이션용) */
    int selectFinanceTotalCount(AdminFinanceUserSearchDto search);
}
