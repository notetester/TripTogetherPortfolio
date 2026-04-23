package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.common.mapper.ChatbotLinkClickMapper;
import org.triptogether.config.IpBlockMapper;
import org.triptogether.admin.vo.*;
import org.triptogether.auth.vo.UserRole;
import org.triptogether.auth.vo.UserLoginHistoryVO;
import org.triptogether.myPage.function.NotificationUrlBuilder;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.report.vo.ReportSearchDto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

/**
 * 관리자 서비스 구현체.
 *
 * <p>컨트롤러는 화면 흐름만 담당하고,</p>
 * <p>조회 조건 보정 / 허용값 검증 / 페이징 계산은 이 서비스에서 맡는다.</p>
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");

    private final AdminMapper adminMapper;
    private final IpBlockMapper ipBlockMapper;
    private final MyPageService myPageService;
    private final ChatbotLinkClickMapper chatbotLinkClickMapper;

    // ===== 대시보드 통계 =====

    @Override
    public AdminStatsVO getStats() {
        return adminMapper.getStats();
    }

    @Override
    public AdminDashboardChartVO getDashboardChart(int days) {
        if (days < 1) days = 7;
        int spanParam = days - 1;

        List<Map<String, Object>> nmRows    = adminMapper.findDailyNewMembers(spanParam);
        List<Map<String, Object>> loginRows = adminMapper.findDailyLoginStats(spanParam);

        Map<String, Long> nmMap = new HashMap<>();
        for (Map<String, Object> r : nmRows) {
            nmMap.put(String.valueOf(r.get("day")), toLong(r.get("cnt")));
        }
        Map<String, long[]> loginMap = new HashMap<>();
        for (Map<String, Object> r : loginRows) {
            long s = toLong(r.get("success_cnt"));
            long f = toLong(r.get("fail_cnt"));
            loginMap.put(String.valueOf(r.get("day")), new long[]{ s, f });
        }

        DateTimeFormatter keyFmt   = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        DateTimeFormatter labelFmt = DateTimeFormatter.ofPattern("MM/dd");

        LocalDate today = LocalDate.now();
        LocalDate start = today.minusDays(spanParam);

        List<String> labels   = new ArrayList<>(days);
        List<Long> newMembers = new ArrayList<>(days);
        List<Long> loginOk    = new ArrayList<>(days);
        List<Long> loginFail  = new ArrayList<>(days);

        for (int i = 0; i < days; i++) {
            LocalDate d = start.plusDays(i);
            String key  = d.format(keyFmt);
            labels.add(d.format(labelFmt));
            newMembers.add(nmMap.getOrDefault(key, 0L));
            long[] lv = loginMap.getOrDefault(key, new long[]{ 0L, 0L });
            loginOk.add(lv[0]);
            loginFail.add(lv[1]);
        }

        return AdminDashboardChartVO.builder()
                .labels(labels)
                .newMembers(newMembers)
                .loginSuccess(loginOk)
                .loginFail(loginFail)
                .build();
    }

    private static long toLong(Object v) {
        if (v == null) return 0L;
        if (v instanceof Number n) return n.longValue();
        try { return Long.parseLong(v.toString()); } catch (Exception e) { return 0L; }
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
    public Map<String, Object> getMemberContext(Long userIdx) {
        AdminMemberVO member = adminMapper.findMemberDetail(userIdx);
        if (member == null) {
            return null;
        }

        Map<String, Object> result = new HashMap<>();
        result.put("member", member);
        result.put("history", adminMapper.findLoginHistory(userIdx, 50));
        result.put("loginAudits", adminMapper.findLoginAuditsByUser(userIdx, 50));
        result.put("securityAudits", adminMapper.findSecurityAuditsByUser(userIdx, 40));
        result.put("emailRequests", adminMapper.findEmailVerificationRequestsByUser(userIdx, 30));
        result.put("emailTokens", adminMapper.findEmailVerificationsByUser(userIdx, 30));
        result.put("activityLogs", adminMapper.findActivityLogsByUser(userIdx, 40));
        result.put("recentBlocks", adminMapper.findRecentUserBlocksByUser(userIdx, 20));
        result.put("chatbotLinkClicks", chatbotLinkClickMapper.selectClicksByUser(userIdx, 20));
        return result;
    }

    @Override
    public Map<String, Object> getIpContext(String ipAddress) {
        String normalizedIp = normalizeIp(ipAddress);
        if (normalizedIp == null) {
            return null;
        }

        Map<String, Object> result = new HashMap<>();
        result.put("ipAddress", normalizedIp);
        result.put("loginAudits", adminMapper.findLoginAuditsByIp(normalizedIp, 50));
        result.put("securityAudits", adminMapper.findSecurityAuditsByIp(normalizedIp, 40));
        result.put("emailRequests", adminMapper.findEmailVerificationRequestsByIp(normalizedIp, 30));
        result.put("emailTokens", adminMapper.findEmailVerificationsByIp(normalizedIp, 30));
        result.put("activityLogs", adminMapper.findActivityLogsByIp(normalizedIp, 40));
        result.put("blockHistories", adminMapper.findBlockHistoriesByIp(normalizedIp, 30));
        result.put("ipRules", adminMapper.findExactIpRules(normalizedIp, 20));
        return result;
    }

    @Override
    public void updateMemberProfile(Long userIdx, String nickname, String nationality, String preferredLang) {
        AdminMemberVO member = adminMapper.findMemberDetail(userIdx);
        if (member == null) {
            throw new IllegalArgumentException("회원을 찾을 수 없습니다.");
        }

        String normalizedNickname = normalizeNickname(nickname);
        String normalizedNationality = normalizeOptionalText(nationality, 40);
        String normalizedPreferredLang = normalizeOptionalText(preferredLang, 10);

        adminMapper.updateMemberProfile(userIdx, normalizedNickname, normalizedNationality, normalizedPreferredLang);
    }

    @Override
    @Transactional
    public void updateMemberEmail(Long userIdx, String email) {
        AdminMemberVO member = adminMapper.findMemberDetail(userIdx);
        if (member == null) {
            throw new IllegalArgumentException("admin.members.memberNotFound");
        }

        String currentEmail = normalizeOptionalEmail(member.getUserEmail());
        String normalizedEmail = normalizeOptionalEmail(email);

        if (currentEmail != null && normalizedEmail != null && currentEmail.equalsIgnoreCase(normalizedEmail)) {
            return;
        }
        if (currentEmail == null && normalizedEmail == null) {
            return;
        }
        if (normalizedEmail != null && adminMapper.countOtherMembersByEmail(userIdx, normalizedEmail) > 0) {
            throw new IllegalArgumentException("admin.members.emailDuplicate");
        }

        adminMapper.updateMemberEmail(userIdx, normalizedEmail);
    }

    @Override
    public void changeMemberStatus(Long userIdx, String status) {
        List<String> allowed = List.of("ACTIVE", "DORMANT", "DELETED", "BLOCKED");
        if (!allowed.contains(status)) {
            throw new IllegalArgumentException("유효하지 않은 상태값: " + status);
        }
        switch (status) {
            case "ACTIVE" -> {
                // 이전 상태 조회 (BLOCKED → ACTIVE 전환 감지용)
                AdminMemberVO prev = adminMapper.findMemberDetail(userIdx);
                String prevStatus = prev != null ? prev.getAccountStatus() : null;

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

                // BLOCKED → ACTIVE 전환 시에만 알림 발송
                if ("BLOCKED".equals(prevStatus)) {
                    notifyAccountUnblocked(userIdx);
                }
            }
            case "DORMANT" -> adminMapper.markMemberDormant(userIdx);
            case "DELETED" -> adminMapper.updateMemberStatus(userIdx, "DELETED");
            case "BLOCKED" -> blockMember(userIdx, "USER_ONLY", null, "관리자 상태 변경 차단", null, null);
        }
    }

    // 계정 차단 해제 시 본인에게 알림 발송
    private void notifyAccountUnblocked(Long userIdx) {
        try {
            FeedNotificationDto notification = new FeedNotificationDto();
            notification.setUserIdx(userIdx);
            notification.setSourceType("account_block");
            notification.setSourceId(userIdx);
            notification.setMessage("계정 차단이 해제되었어요.");
            notification.setTargetUrl(NotificationUrlBuilder.mypage());
            myPageService.addNotification(notification);
        } catch (Exception e) {
            log.warn("계정 차단 해제 알림 발송 실패: userIdx={}", userIdx, e);
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
            ipBlockMapper.deactivateUserActionBlockedIpByTargetKey(ipRuleTargetKey, actorUserIdx);
            ipBlockMapper.upsertBlockedIpWithHistory(normalizedIp, ipRuleTargetKey, reason, userIdx, blockType, actorUserIdx, expiresAt, blockRequestId, historyBlockIdx, sourceBlocklistIdx);
        }

        // 계정 차단 알림 (USER_ONLY / USER_IP 일 때만, IP_ONLY 제외)
        if ("USER_ONLY".equals(blockType) || "USER_IP".equals(blockType)) {
            notifyAccountBlocked(userIdx, reason, expiresAt);
        }
    }

    // 계정 차단 시 본인에게 알림 발송
    private void notifyAccountBlocked(Long userIdx, String reason, LocalDateTime expiresAt) {
        try {
            String message;
            if (expiresAt != null) {
                String until = expiresAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
                message = "계정이 " + until + "까지 차단되었어요.";
            } else {
                message = "계정이 차단되었어요.";
            }
            if (reason != null && !reason.isBlank()) {
                message += " 사유: " + reason;
            }
            FeedNotificationDto notification = new FeedNotificationDto();
            notification.setUserIdx(userIdx);
            notification.setSourceType("account_block");
            notification.setSourceId(userIdx);
            notification.setMessage(message);
            notification.setTargetUrl(NotificationUrlBuilder.mypage());
            myPageService.addNotification(notification);
        } catch (Exception e) {
            log.warn("계정 차단 알림 발송 실패: userIdx={}", userIdx, e);
        }
    }

    private void refreshIpRuleFromHistory(String ipAddress) {
        if (ipAddress == null || ipAddress.isBlank()) return;
        String normalizedIp = normalizeIp(ipAddress);
        var latest = ipBlockMapper.findLatestActiveHistoryRuleByIp(normalizedIp);
        if (latest == null) {
            ipBlockMapper.deactivateUserActionBlockedIpByTargetKey(buildIpRuleTargetKey(normalizedIp), null);
            return;
        }
        ipBlockMapper.deactivateUserActionBlockedIpByTargetKey(buildIpRuleTargetKey(normalizedIp), null);
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

    private String normalizeNickname(String nickname) {
        if (nickname == null) {
            throw new IllegalArgumentException("닉네임을 입력해주세요.");
        }
        String trimmed = nickname.trim();
        if (trimmed.length() < 2 || trimmed.length() > 20) {
            throw new IllegalArgumentException("닉네임은 2~20자 사이로 입력해주세요.");
        }
        return trimmed;
    }

    private String normalizeOptionalText(String value, int maxLength) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        if (trimmed.isEmpty()) {
            return null;
        }
        return trimmed.length() > maxLength ? trimmed.substring(0, maxLength) : trimmed;
    }

    private String normalizeOptionalEmail(String email) {
        if (email == null) {
            return null;
        }
        String trimmed = email.trim();
        if (trimmed.isEmpty()) {
            return null;
        }
        if (trimmed.length() > 120) {
            throw new IllegalArgumentException("admin.members.emailTooLong");
        }
        if (!EMAIL_PATTERN.matcher(trimmed).matches()) {
            throw new IllegalArgumentException("admin.members.emailInvalid");
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

    // ===== 기업 회원 신청 =====

    @Override
    public List<BusinessAccountApplicationVO> getBusinessApplications(String status) {
        String normalizedStatus = normalizeApplicationStatus(status);
        return adminMapper.findBusinessApplications(normalizedStatus);
    }

    @Override
    @Transactional
    public void approveBusinessApplication(Long applicationIdx, Long reviewerUserIdx) {
        if (reviewerUserIdx == null) {
            throw new IllegalArgumentException("검토 관리자 정보를 찾을 수 없습니다.");
        }

        BusinessAccountApplicationVO application = adminMapper.findBusinessApplicationForUpdate(applicationIdx);
        if (application == null) {
            throw new IllegalArgumentException("기업 회원 신청을 찾을 수 없습니다.");
        }
        if (!"PENDING".equals(application.getApplicationStatus())) {
            throw new IllegalStateException("검토 대기 상태의 신청만 승인할 수 있습니다.");
        }

        UserRole requestedRole = UserRole.parse(application.getRequestedRole())
                .filter(role -> role == UserRole.BUSINESS || role == UserRole.PARTNER)
                .orElseThrow(() -> new IllegalArgumentException("신청 권한값이 올바르지 않습니다."));

        String reason = "기업 회원 신청 승인: " + application.getCompanyName();
        changeMemberRole(application.getUserIdx(), requestedRole.code(), reason, reviewerUserIdx);
        adminMapper.approveBusinessApplication(applicationIdx, reviewerUserIdx);
    }

    @Override
    @Transactional
    public void rejectBusinessApplication(Long applicationIdx, String rejectReason, Long reviewerUserIdx) {
        if (reviewerUserIdx == null) {
            throw new IllegalArgumentException("검토 관리자 정보를 찾을 수 없습니다.");
        }

        BusinessAccountApplicationVO application = adminMapper.findBusinessApplicationForUpdate(applicationIdx);
        if (application == null) {
            throw new IllegalArgumentException("기업 회원 신청을 찾을 수 없습니다.");
        }
        if (!"PENDING".equals(application.getApplicationStatus())) {
            throw new IllegalStateException("검토 대기 상태의 신청만 반려할 수 있습니다.");
        }

        String normalizedReason = normalizeRequiredRejectReason(rejectReason);
        adminMapper.rejectBusinessApplication(applicationIdx, normalizedReason, reviewerUserIdx);
    }

    private String normalizeApplicationStatus(String status) {
        if (status == null || status.isBlank() || "ALL".equalsIgnoreCase(status)) {
            return "ALL";
        }
        String normalized = status.trim().toUpperCase();
        List<String> allowed = List.of("PENDING", "APPROVED", "REJECTED");
        return allowed.contains(normalized) ? normalized : "ALL";
    }

    private String normalizeRequiredRejectReason(String reason) {
        String normalized = normalizeRoleChangeReason(reason);
        if (normalized == null) {
            throw new IllegalArgumentException("반려 사유를 입력해주세요.");
        }
        return normalized;
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
