package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdminMemberVO;
import org.triptogether.admin.vo.AdminSearchVO;
import org.triptogether.admin.vo.AdminStatsVO;
import org.triptogether.auth.vo.UserLoginHistoryVO;
import org.triptogether.common.function.Paging;

import java.util.List;
import java.util.Map;

public interface AdminService {

    // ── 통계 ──────────────────────────────────
    AdminStatsVO getStats();

    // ── 회원 목록 ──────────────────────────────
    Map<String, Object> getMemberList(AdminSearchVO search);

    // ── 회원 상세 ──────────────────────────────
    AdminMemberVO getMemberDetail(Long userIdx);

    /** 특정 회원의 로그인 이력 */
    List<UserLoginHistoryVO> getLoginHistory(Long userIdx);

    // ── 회원 상태/권한 변경 ─────────────────────
    void changeMemberStatus(Long userIdx, String status);
    void changeMemberRole(Long userIdx, String role);
}
