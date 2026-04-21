package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.config.IpBlockMapper;
import org.triptogether.admin.vo.*;
import org.triptogether.auth.vo.UserRole;
import org.triptogether.auth.vo.UserLoginHistoryVO;
import org.triptogether.report.vo.ReportSearchDto;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
                adminMapper.deactivateCurrentBlocklistByUser(userIdx, null);
                adminMapper.deactivateActiveBlocksByUser(userIdx, null);
                adminMapper.clearMemberBlockState(userIdx);
                adminMapper.releaseMemberDormant(userIdx);
                adminMapper.updateMemberStatus(userIdx, "ACTIVE");
                if (blockedIps != null) {
                    blockedIps.stream()
                            .filter(ip -> ip != null && !ip.isBlank())
                            .map(this::normalizeIp)
                            .distinct()
                            .forEach(this::refreshIpRuleFromHistory);
                }
            }
            case "DORMANT" -> adminMapper.markMemberDormant(userIdx);
            case "DELETED" -> adminMapper.updateMemberStatus(userIdx, "DELETED");
            case "BLOCKED" -> blockMember(userIdx, "USER_ONLY", null, "관리자 상태 변경 차단", null, null);
        }
    }

    @Override
    public void blockMember(Long userIdx, String blockType, String blockedIp, String reason, LocalDateTime expiresAt, Long actorUserIdx) {
        List<String> allowed = List.of("USER_ONLY", "IP_ONLY", "USER_IP");
        if (!allowed.contains(blockType)) {
            throw new IllegalArgumentException("유효하지 않은 차단 유형입니다.");
        }

        String normalizedIp = normalizeIp(blockedIp);
        if (("IP_ONLY".equals(blockType) || "USER_IP".equals(blockType)) && (normalizedIp == null || normalizedIp.isBlank())) {
            throw new IllegalArgumentException("IP 차단 유형은 차단 IP가 필요합니다.");
        }

        String blockRequestId = UUID.randomUUID().toString();
        String historyTargetKey = buildHistoryTargetKey(userIdx, blockType, normalizedIp);
        String ipMatchType = normalizedIp != null && !normalizedIp.isBlank() ? "SINGLE_IP" : null;

        if ("USER_ONLY".equals(blockType) || "USER_IP".equals(blockType)) {
            adminMapper.markMemberBlocked(userIdx, expiresAt, reason);
        }

        adminMapper.insertUserBlockHistory(blockRequestId, historyTargetKey, userIdx, blockType, normalizedIp, reason, actorUserIdx, expiresAt, ipMatchType);
        Long historyBlockIdx = adminMapper.findBlockHistoryIdxByRequestId(blockRequestId);

        Long sourceBlocklistIdx = null;
        if ("USER_ONLY".equals(blockType) || "USER_IP".equals(blockType)) {
            adminMapper.upsertUserBlocklist(historyBlockIdx, blockRequestId, historyTargetKey, userIdx, blockType, normalizedIp, reason, actorUserIdx, expiresAt);
            sourceBlocklistIdx = adminMapper.findUserBlocklistIdxByTargetKey(historyTargetKey);
        }

        if (("IP_ONLY".equals(blockType) || "USER_IP".equals(blockType)) && normalizedIp != null && !normalizedIp.isBlank()) {
            String ipRuleTargetKey = buildIpRuleTargetKey(normalizedIp);
            ipBlockMapper.upsertBlockedIpWithHistory(normalizedIp, ipRuleTargetKey, reason, userIdx, blockType, actorUserIdx, expiresAt, blockRequestId, historyBlockIdx, sourceBlocklistIdx);
        }
    }

    private void refreshIpRuleFromHistory(String ipAddress) {
        if (ipAddress == null || ipAddress.isBlank()) return;
        String normalizedIp = normalizeIp(ipAddress);
        var latest = ipBlockMapper.findLatestActiveHistoryRuleByIp(normalizedIp);
        if (latest == null) {
            ipBlockMapper.deactivateBlockedIpByTargetKey(buildIpRuleTargetKey(normalizedIp), null);
            return;
        }
        ipBlockMapper.upsertBlockedIpWithHistory(
                normalizedIp,
                buildIpRuleTargetKey(normalizedIp),
                latest.getReason(),
                latest.getUserIdx(),
                latest.getBlockType(),
                latest.getBlockedByUserIdx(),
                latest.getExpiresAt(),
                latest.getBlockRequestId(),
                latest.getSourceHistoryBlockIdx(),
                latest.getSourceBlocklistIdx()
        );
    }

    private String buildHistoryTargetKey(Long userIdx, String blockType, String blockedIp) {
        return switch (blockType) {
            case "USER_ONLY" -> "USER:" + userIdx;
            case "IP_ONLY" -> "IP:" + blockedIp;
            case "USER_IP" -> "USER_IP:" + userIdx + ":" + blockedIp;
            default -> throw new IllegalArgumentException("유효하지 않은 차단 유형입니다.");
        };
    }

    private String buildIpRuleTargetKey(String blockedIp) {
        return "IP:" + blockedIp;
    }

    private String normalizeIp(String ip) {
        if (ip == null) return null;
        String trimmed = ip.trim();
        if (trimmed.isBlank()) return null;
        if ("0:0:0:0:0:0:0:1".equals(trimmed) || "::1".equals(trimmed)) {
            return "127.0.0.1";
        }
        if (trimmed.startsWith("::ffff:")) {
            return trimmed.substring(7);
        }
        return trimmed;
    }

    @Override
    public void updateMemberMeta(AdminMemberVO member) {
        adminMapper.updateMemberMeta(member);
    }

    @Override
    @Transactional
    public void changeMemberRole(Long userIdx, String role, String reason, Long changedByUserIdx) {
        UserRole targetRole = UserRole.parse(role)
                .filter(UserRole::isMemberAdminAssignable)
                .orElseThrow(() -> new IllegalArgumentException("유효하지 않은 권한값: " + role));

        if (changedByUserIdx == null) {
            throw new IllegalArgumentException("권한 변경 관리자 정보를 찾을 수 없습니다.");
        }

        String previousRoleCode = adminMapper.findMemberRoleForUpdate(userIdx);
        if (previousRoleCode == null) {
            throw new IllegalArgumentException("회원을 찾을 수 없습니다.");
        }

        UserRole previousRole = UserRole.from(previousRoleCode);
        if (previousRole.isProtectedRole()) {
            throw new IllegalArgumentException("보호 계정의 권한은 일반 관리자 화면에서 변경할 수 없습니다.");
        }

        if (previousRole == targetRole) {
            throw new IllegalArgumentException("이미 동일한 권한입니다.");
        }

        adminMapper.updateMemberRole(userIdx, targetRole.code());
        adminMapper.insertMemberRoleChangeHistory(
                userIdx,
                previousRole.code(),
                targetRole.code(),
                normalizeRoleChangeReason(reason),
                changedByUserIdx
        );
    }

    private String normalizeRoleChangeReason(String reason) {
        if (reason == null) {
            return null;
        }
        String trimmed = reason.trim();
        if (trimmed.isEmpty()) {
            return null;
        }
        return trimmed.length() > 500 ? trimmed.substring(0, 500) : trimmed;
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
