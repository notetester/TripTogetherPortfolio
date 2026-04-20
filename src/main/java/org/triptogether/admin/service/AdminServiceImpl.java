package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.config.IpBlockMapper;
import org.triptogether.admin.vo.*;
import org.triptogether.auth.vo.UserLoginHistoryVO;
import org.triptogether.report.vo.ReportSearchDto;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 관리자 서비스 구현체.
 *
 * <p>컨트롤러는 화면 흐름만 담당하고,</p>
 * <p>조회 조건 보정 / 허용값 검증 / 페이징 계산은 이 서비스에서 맡는다.</p>
 */
@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {

    private final AdminMapper adminMapper;
    private final IpBlockMapper ipBlockMapper;

    // ===== 대시보드 통계 =====

    @Override
    public AdminStatsVO getStats() {
        return adminMapper.getStats();
    }

    // ===== 회원 관리 =====

    @Override
    public Map<String, Object> getMemberList(AdminSearchVO search) {
        List<AdminMemberVO> list = adminMapper.findMembers(search);
        int total = adminMapper.countMembers(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    @Override
    public AdminMemberVO getMemberDetail(Long userIdx) {
        return adminMapper.findMemberDetail(userIdx);
    }

    @Override
    public List<UserLoginHistoryVO> getLoginHistory(Long userIdx) {
        return adminMapper.findLoginHistory(userIdx, 50);
    }

    @Override
    public void changeMemberStatus(Long userIdx, String status) {
        List<String> allowed = List.of("ACTIVE", "DORMANT", "DELETED", "BLOCKED");
        if (!allowed.contains(status)) {
            throw new IllegalArgumentException("유효하지 않은 상태값: " + status);
        }
        switch (status) {
            case "ACTIVE" -> {
                List<String> blockedIps = adminMapper.findActiveBlockedIpsByUser(userIdx);
                adminMapper.deactivateActiveBlocksByUser(userIdx, null);
                if (blockedIps != null) {
                    blockedIps.stream().filter(ip -> ip != null && !ip.isBlank()).distinct().forEach(ipBlockMapper::deleteBlockedIp);
                }
                adminMapper.clearMemberBlockState(userIdx);
                adminMapper.releaseMemberDormant(userIdx);
                adminMapper.updateMemberStatus(userIdx, "ACTIVE");
            }
            case "DORMANT" -> adminMapper.markMemberDormant(userIdx);
            case "DELETED" -> adminMapper.updateMemberStatus(userIdx, "DELETED");
            case "BLOCKED" -> adminMapper.markMemberBlocked(userIdx, null, null);
        }
    }

    @Override
    public void blockMember(Long userIdx, String blockType, String blockedIp, String reason, LocalDateTime expiresAt, Long actorUserIdx) {
        List<String> allowed = List.of("USER_ONLY", "IP_ONLY", "USER_IP");
        if (!allowed.contains(blockType)) {
            throw new IllegalArgumentException("유효하지 않은 차단 유형입니다.");
        }
        if (("IP_ONLY".equals(blockType) || "USER_IP".equals(blockType)) && (blockedIp == null || blockedIp.isBlank())) {
            throw new IllegalArgumentException("IP 차단 유형은 차단 IP가 필요합니다.");
        }
        if ("USER_ONLY".equals(blockType) || "USER_IP".equals(blockType)) {
            adminMapper.markMemberBlocked(userIdx, expiresAt, reason);
        }
        adminMapper.insertUserBlockHistory(userIdx, blockType, blockedIp, reason, actorUserIdx, expiresAt);
        if (("IP_ONLY".equals(blockType) || "USER_IP".equals(blockType)) && blockedIp != null && !blockedIp.isBlank()) {
            ipBlockMapper.insertBlockedIp(blockedIp, reason);
        }
    }

    @Override
    public void updateMemberMeta(AdminMemberVO member) {
        adminMapper.updateMemberMeta(member);
    }

    @Override
    public void changeMemberRole(Long userIdx, String role) {
        List<String> allowed = List.of("USER", "ADMIN");
        if (!allowed.contains(role)) {
            throw new IllegalArgumentException("유효하지 않은 권한값: " + role);
        }
        adminMapper.updateMemberRole(userIdx, role);
    }

    @Override
    public boolean hasEffectivePermission(Long userIdx, String permissionCode) {
        return adminMapper.hasEffectivePermission(userIdx, permissionCode);
    }

    @Override
    public Long getPostAuthorIdx(Long postId) {
        return adminMapper.findPostAuthorIdx(postId);
    }

    @Override
    public Long getCommentAuthorIdx(Long commentId) {
        return adminMapper.findCommentAuthorIdx(commentId);
    }

    // ===== 문의 관리 =====

    @Override
    public AdminInquiryVO getInquiryDetail(Long inquiryId) {
        return adminMapper.findInquiryDetail(inquiryId);
    }

    @Override
    public AdminInquiryStatsVO getInquiryStats() {
        return adminMapper.getInquiryStats();
    }

    @Override
    public void saveInquiryAnswer(Long inquiryId, Long adminUserIdx, String content) {
        AdminInquiryVO inquiry = adminMapper.findInquiryDetail(inquiryId);
        if (inquiry.getAnswerId() != null) {
            adminMapper.updateInquiryAnswer(inquiry.getAnswerId(), content);
        } else {
            adminMapper.insertInquiryAnswer(inquiryId, adminUserIdx, content);
            adminMapper.updateInquiryStatus(inquiryId, "COMPLETED");
        }
    }

    @Override
    public void deleteInquiryAnswer(Long inquiryId) {
        adminMapper.deleteInquiryAnswer(inquiryId);
        adminMapper.updateInquiryStatus(inquiryId, "PENDING");
    }

    @Override
    public void updateInquiryStatus(Long inquiryId, String status) {
        adminMapper.updateInquiryStatus(inquiryId, status);
    }

    @Override
    public void deleteInquiry(Long inquiryId) {
        adminMapper.deleteInquiry(inquiryId);
    }

    @Override
    public Map<String, Object> getInquiryList(AdminInquirySearchVO search) {
        List<AdminInquiryVO> list = adminMapper.findInquiries(search);
        int total = adminMapper.countInquiries(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    // ===== 로그인 감사 =====

    @Override
    public Map<String, Object> getLoginAuditList(AdminLoginAuditSearchVO search) {
        List<AdminLoginAuditVO> list = adminMapper.findLoginAudits(search);
        int total = adminMapper.countLoginAudits(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    // ===== 보안 이력 감사 =====

    @Override
    public Map<String, Object> getSecurityAuditList(AdminSecurityAuditSearchVO search) {
        List<AdminSecurityAuditVO> list = adminMapper.findSecurityAudits(search);
        int total = adminMapper.countSecurityAudits(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    // ===== 이메일 액션 요청 이력 =====

    @Override
    public Map<String, Object> getEmailVerificationRequestList(AdminEmailVerificationRequestSearchVO search) {
        List<AdminEmailVerificationRequestVO> list = adminMapper.findEmailVerificationRequests(search);
        int total = adminMapper.countEmailVerificationRequests(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    // ===== 이메일 액션 토큰 이력 =====

    @Override
    public Map<String, Object> getEmailVerificationList(AdminEmailVerificationSearchVO search) {
        List<AdminEmailVerificationVO> list = adminMapper.findEmailVerifications(search);
        int total = adminMapper.countEmailVerifications(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    // ===== 일반 활동 로그 =====

    @Override
    public Map<String, Object> getActivityLogList(AdminActivityLogSearchVO search) {
        List<AdminActivityLogVO> list = adminMapper.findActivityLogs(search);
        int total = adminMapper.countActivityLogs(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    // ===== 신고 관리 =====

    @Override
    public Map<String, Object> getAdminReportList(ReportSearchDto search) {
        List<AdminReportVO> list  = adminMapper.findReports(search);
        int total                 = adminMapper.countReports(search);
        AdminPageVO paging        = AdminPageVO.of(total, search.getPage(), search.getPageSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list",   list);
        result.put("paging", paging);
        result.put("total",  total);
        result.put("search", search);
        return result;
    }

    @Override
    public AdminReportVO getAdminReport(Long reportId) {
        return adminMapper.findReport(reportId);
    }
}
