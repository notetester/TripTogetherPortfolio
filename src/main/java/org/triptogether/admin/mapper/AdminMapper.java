package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.AdminMemberVO;
import org.triptogether.admin.vo.AdminSearchVO;
import org.triptogether.admin.vo.AdminStatsVO;
import org.triptogether.auth.vo.UserLoginHistoryVO;

import java.util.List;

@Mapper
public interface AdminMapper {

    // ══════════════════════════════════════════
    // 회원 목록 / 검색
    // ══════════════════════════════════════════

    /** 회원 목록 조회 (검색 + 필터 + 정렬 + 페이징) */
    List<AdminMemberVO> findMembers(AdminSearchVO search);

    /** 전체 건수 (페이징 계산용) */
    int countMembers(AdminSearchVO search);

    /** 단건 상세 조회 */
    AdminMemberVO findMemberDetail(Long userIdx);

    // ══════════════════════════════════════════
    // 회원 상태 / 권한 변경
    // ══════════════════════════════════════════

    /** 계정 상태 변경 (ACTIVE / DORMANT / DELETED) */
    void updateMemberStatus(@Param("userIdx")  Long   userIdx,
                            @Param("status")   String status);

    /** 권한 변경 (USER / ADMIN) */
    void updateMemberRole(@Param("userIdx") Long   userIdx,
                          @Param("role")    String role);

    // ══════════════════════════════════════════
    // 로그인 이력
    // ══════════════════════════════════════════

    /** 특정 회원의 로그인 이력 (최근 50건) */
    List<UserLoginHistoryVO> findLoginHistory(@Param("userIdx") Long userIdx,
                                              @Param("limit")   int  limit);

    // ══════════════════════════════════════════
    // 통계
    // ══════════════════════════════════════════

    AdminStatsVO getStats();
}
