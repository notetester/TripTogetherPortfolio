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
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.regex.Pattern;
import org.triptogether.common.vo.ChatbotLinkClickVO;

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
    private static final Set<String> MEMBER_VALID_SEARCH_TYPES = Set.of("all", "userId", "nickname", "email");
    private static final Set<String> MEMBER_VALID_STATUS = Set.of("ALL", "ACTIVE", "DORMANT", "BLOCKED", "DELETED");
    private static final Set<String> MEMBER_MUTABLE_STATUS = Set.of("ACTIVE", "DORMANT", "BLOCKED", "DELETED");
    private static final Set<String> MEMBER_VALID_ROLE = Set.of("ALL", "USER", "BUSINESS", "PARTNER", "BOT", "ADMIN", "SUPERADMIN", "SYSTEM");
    private static final Set<String> MEMBER_VALID_PROVIDER = Set.of("ALL", "KAKAO", "NAVER", "GOOGLE", "NONE");
    private static final Set<String> MEMBER_VALID_SORT = Set.of(
            "createdAt", "lastLoginAt", "nickname", "email", "status", "role",
            "userIdx", "memberGrade", "levelNo", "loginSuccessCount", "loginFailCount", "social", "socialCount"
    );
    private static final Set<String> MEMBER_VALID_MODE = Set.of("SERVER", "CLIENT");
    private static final Set<String> BUSINESS_VALID_SEARCH_TYPES = Set.of("all", "applicant", "company", "manager", "businessNumber");
    private static final Set<String> BUSINESS_VALID_STATUS = Set.of("ALL", "PENDING", "APPROVED", "REJECTED");
    private static final Set<String> BUSINESS_VALID_ROLE = Set.of("ALL", "BUSINESS", "PARTNER");
    private static final Set<String> BUSINESS_VALID_SORT = Set.of("createdAt", "reviewedAt", "applicant", "requestedRole", "company", "status", "reviewer", "applicationIdx");
    private static final Set<String> BUSINESS_VALID_MODE = Set.of("SERVER", "CLIENT");

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

    @Override
    public List<AdminSalesDailyStatVO> getSalesDailyStats(int days) {
        int safeDays = normalizeSalesDays(days);
        int spanParam = safeDays - 1;

        List<AdminSalesDailyStatVO> rows = adminMapper.findDailySalesStats(spanParam);
        Map<LocalDate, AdminSalesDailyStatVO> rowMap = new HashMap<>();
        for (AdminSalesDailyStatVO row : rows) {
            if (row != null && row.getSalesDate() != null) {
                rowMap.put(row.getSalesDate(), row);
            }
        }

        LocalDate startDate = LocalDate.now().minusDays(spanParam);
        List<AdminSalesDailyStatVO> result = new ArrayList<>(safeDays);
        for (int i = 0; i < safeDays; i++) {
            LocalDate date = startDate.plusDays(i);
            result.add(rowMap.getOrDefault(date, emptySalesStat(date)));
        }
        return result;
    }

    private int normalizeSalesDays(int days) {
        if (days < 1) {
            return 30;
        }
        return Math.min(days, 365);
    }

    private AdminSalesDailyStatVO emptySalesStat(LocalDate salesDate) {
        AdminSalesDailyStatVO stat = new AdminSalesDailyStatVO();
        stat.setSalesDate(salesDate);
        return stat;
    }

    private static long toLong(Object v) {
        if (v == null) return 0L;
        if (v instanceof Number n) return n.longValue();
        try { return Long.parseLong(v.toString()); } catch (Exception e) { return 0L; }
    }

    private AdminSearchVO normalizeMemberSearch(AdminSearchVO source) {
        AdminSearchVO search = source != null ? source : new AdminSearchVO();

        search.setKeyword(trimToNull(search.getKeyword()));
        search.setSearchType(normalizeMemberSearchType(search.getSearchType()));
        search.setStatus(normalizeMemberFilter(search.getStatus(), MEMBER_VALID_STATUS, "ALL", true));
        search.setRole(normalizeMemberFilter(search.getRole(), MEMBER_VALID_ROLE, "ALL", true));
        search.setProvider(normalizeMemberFilter(search.getProvider(), MEMBER_VALID_PROVIDER, "ALL", true));

        LocalDate from = parseMemberDate(search.getDateFrom());
        LocalDate to = parseMemberDate(search.getDateTo());
        if (from != null && to != null && from.isAfter(to)) {
            LocalDate tmp = from;
            from = to;
            to = tmp;
        }
        search.setDateFrom(from != null ? from.toString() : null);
        search.setDateTo(to != null ? to.toString() : null);

        search.setSortBy(normalizeMemberSortBy(search.getSortBy()));
        search.setSortDir(normalizeMemberSortDir(search.getSortDir()));
        search.setMode(normalizeMemberMode(search.getMode()));
        search.setPage(Math.max(1, search.getPage()));
        search.setSize(normalizeMemberPageSize(search.getSize()));
        return search;
    }

    private Map<String, Object> buildMemberQueryParams(AdminSearchVO search, boolean paged) {
        AdminSearchVO normalized = normalizeMemberSearch(search);
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", normalized.getKeyword());
        params.put("searchType", normalized.getSearchType());
        params.put("status", normalized.getStatus());
        params.put("role", normalized.getRole());
        params.put("provider", normalized.getProvider());
        params.put("dateFrom", normalized.getDateFrom());
        params.put("dateTo", normalized.getDateTo());
        params.put("sortBy", normalized.getSortBy());
        params.put("sortDir", normalized.getSortDir());
        params.put("mode", normalized.getMode());
        params.put("page", normalized.getPage());
        params.put("size", normalized.getSize());
        params.put("offset", normalized.getOffset());
        params.put("paged", paged);
        return params;
    }

    private String normalizeMemberSearchType(String value) {
        String text = trimToNull(value);
        return text != null && MEMBER_VALID_SEARCH_TYPES.contains(text) ? text : "all";
    }

    private String normalizeMemberSortBy(String value) {
        String text = trimToNull(value);
        return text != null && MEMBER_VALID_SORT.contains(text) ? text : "createdAt";
    }

    private String normalizeMemberSortDir(String value) {
        return "ASC".equalsIgnoreCase(trimToNull(value)) ? "ASC" : "DESC";
    }

    private String normalizeMemberMode(String value) {
        String text = trimToNull(value);
        if (text == null) return "SERVER";
        text = text.toUpperCase();
        return MEMBER_VALID_MODE.contains(text) ? text : "SERVER";
    }

    private String normalizeMemberStatus(String value) {
        String text = trimToNull(value);
        if (text == null) return null;
        text = text.toUpperCase();
        return MEMBER_MUTABLE_STATUS.contains(text) ? text : null;
    }

    private String normalizeMemberFilter(String value, Set<String> validValues, String defaultValue, boolean upper) {
        String text = trimToNull(value);
        if (text == null) return defaultValue;
        if (upper) text = text.toUpperCase();
        return validValues.contains(text) ? text : defaultValue;
    }

    private int normalizeMemberPageSize(int size) {
        return (size == 10 || size == 20 || size == 50 || size == 100) ? size : 20;
    }

    private LocalDate parseMemberDate(String value) {
        String text = trimToNull(value);
        if (text == null) return null;
        try {
            return LocalDate.parse(text);
        } catch (Exception e) {
            return null;
        }
    }

    private List<Long> normalizeMemberIds(List<Long> ids) {
        if (ids == null || ids.isEmpty()) return Collections.emptyList();
        return ids.stream()
                .filter(id -> id != null && id > 0)
                .collect(java.util.stream.Collectors.collectingAndThen(
                        java.util.stream.Collectors.toCollection(LinkedHashSet::new),
                        ArrayList::new
                ));
    }

    private String trimToNull(String value) {
        if (value == null) return null;
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    // ===== 회원 관리 =====

    @Override
    public Map<String, Object> getMemberList(AdminSearchVO search) {
        AdminSearchVO normalizedSearch = normalizeMemberSearch(search);
        Map<String, Object> params = buildMemberQueryParams(normalizedSearch, true);

        int total = adminMapper.countMembers(params);
        boolean clientMode = "CLIENT".equals(normalizedSearch.getMode());
        AdminPageVO paging = clientMode
                ? AdminPageVO.of(total, 1, Math.max(total, 1), 10)
                : AdminPageVO.of(total, normalizedSearch.getPage(), normalizedSearch.getSize(), 10);

        // 검색 조건 변경 후 요청 page가 총 페이지를 넘어가면 보정된 마지막 페이지 기준으로 조회한다.
        normalizedSearch.setPage(paging.getCurrentPage());
        normalizedSearch.setSize(clientMode ? Math.max(total, 1) : paging.getPageSize());
        params = buildMemberQueryParams(normalizedSearch, !clientMode);

        List<AdminMemberVO> list = clientMode
                ? adminMapper.findMembersForExport(params)
                : adminMapper.findMembers(params);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("rows", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("page", paging.getCurrentPage());
        result.put("size", paging.getPageSize());
        result.put("totalPages", paging.getTotalPage());
        result.put("search", normalizedSearch);
        return result;
    }

    @Override
    @Transactional
    public void bulkChangeMemberStatus(List<Long> userIdxList, String status) {
        String normalizedStatus = normalizeMemberStatus(status);
        if (normalizedStatus == null) {
            throw new IllegalArgumentException("허용되지 않는 상태값입니다.");
        }
        List<Long> ids = normalizeMemberIds(userIdxList);
        if (ids.isEmpty()) return;
        adminMapper.bulkChangeMemberStatus(ids, normalizedStatus);
    }

    @Override
    public List<AdminMemberVO> getMembersForExport(AdminSearchVO search) {
        AdminSearchVO normalizedSearch = normalizeMemberSearch(search);
        return adminMapper.findMembersForExport(buildMemberQueryParams(normalizedSearch, false));
    }

    @Override
    public List<AdminMemberVO> getMembersByIds(List<Long> ids) {
        List<Long> normalizedIds = normalizeMemberIds(ids);
        if (normalizedIds.isEmpty()) return Collections.emptyList();
        return adminMapper.findMembersByIds(normalizedIds);
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
        result.put("chatbotLinkClicks", chatbotLinkClickMapper.selectClicksByIp(normalizedIp, 30));
        return result;
    }

    @Override
    public List<ChatbotLinkClickVO> getChatbotLinkClicks(Long userIdx, String ip, int mode) {
        switch (mode) {
            case 2: return chatbotLinkClickMapper.selectClicksByIp(ip, 30);
            case 3: return chatbotLinkClickMapper.selectClicksByUserAndIp(userIdx, ip, 30);
            case 4: return chatbotLinkClickMapper.selectClicksByUserOrIp(userIdx, ip, 30);
            case 5: return chatbotLinkClickMapper.selectClicksByIpExcludeOtherUsers(userIdx, ip, 30);
            default: return chatbotLinkClickMapper.selectClicksByUser(userIdx, 20);
        }
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
        if (userIdx == null || userIdx <= 0) {
            throw new IllegalArgumentException("유효하지 않은 회원 번호입니다.");
        }
        String normalizedStatus = normalizeMemberStatus(status);
        if (normalizedStatus == null) {
            throw new IllegalArgumentException("유효하지 않은 상태값: " + status);
        }
        switch (normalizedStatus) {
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
        if (blockType == null || !allowed.contains(blockType)) {
            throw new IllegalArgumentException("유효하지 않은 차단 유형입니다.");
        }

        String normalizedIp = normalizeIp(blockedIp);
        boolean includesUserBlock = "USER_ONLY".equals(blockType) || "USER_IP".equals(blockType);
        boolean includesIpBlock = "IP_ONLY".equals(blockType) || "USER_IP".equals(blockType);

        if (includesIpBlock && (normalizedIp == null || normalizedIp.isBlank())) {
            throw new IllegalArgumentException("IP 차단 유형은 차단 IP가 필요합니다.");
        }

        String sourceActionType = resolveSourceActionType(blockType);
        String sourceActionGroupId = UUID.randomUUID().toString();
        Long sourceUserIdx = userIdx;
        String sourceIpAddress = includesIpBlock ? normalizedIp : null;

        /*
         * USER_IP는 런타임의 교집합 조건으로 저장하지 않는다.
         *
         * 관리자 액션 의미:
         * - 악성 회원을 계정 차단하고, 같은 사건으로 해당 IP도 전역 차단한다.
         *
         * 실제 저장/평가 의미:
         * - USER_BLOCKLIST: USER_ONLY
         * - IP_BLOCKLIST: IP_ONLY(SINGLE_IP)
         *
         * 이렇게 분리해야 사용자 안내 화면에서도 현재 요청 기준으로
         * "계정 이용 제한" 또는 "접근 환경 제한"을 자연스럽게 보여줄 수 있다.
         */
        String userBlockRequestId = includesUserBlock ? UUID.randomUUID().toString() : null;
        Long userHistoryBlockIdx = null;

        if (includesUserBlock) {
            String userReason = "USER_IP".equals(blockType)
                    ? appendActionContext(reason, "계정 및 IP 동시 차단 중 계정 차단")
                    : reason;
            String userTargetKey = buildHistoryTargetKey(userIdx, "USER_ONLY", null);

            adminMapper.markMemberBlocked(userIdx, expiresAt, userReason);
            adminMapper.insertUserBlockHistory(userBlockRequestId, userTargetKey, userIdx, "USER_ONLY", null, userReason,
                    actorUserIdx, expiresAt, null,
                    sourceActionType, sourceActionGroupId, sourceUserIdx, sourceIpAddress);
            userHistoryBlockIdx = adminMapper.findBlockHistoryIdxByRequestId(userBlockRequestId);
            adminMapper.upsertUserBlocklist(userHistoryBlockIdx, userBlockRequestId, userTargetKey, userIdx, "USER_ONLY", null, userReason,
                    actorUserIdx, expiresAt,
                    sourceActionType, sourceActionGroupId, sourceUserIdx, sourceIpAddress);
        }

        if (includesIpBlock && normalizedIp != null && !normalizedIp.isBlank()) {
            String ipBlockRequestId = UUID.randomUUID().toString();
            String ipReason = "USER_IP".equals(blockType)
                    ? appendActionContext(reason, "계정 및 IP 동시 차단 중 IP 차단")
                    : reason;
            String ipHistoryTargetKey = buildHistoryTargetKey(userIdx, "IP_ONLY", normalizedIp);
            String ipRuleTargetKey = buildIpRuleTargetKey(normalizedIp);
            String ipMatchType = "SINGLE_IP";

            adminMapper.insertUserBlockHistory(ipBlockRequestId, ipHistoryTargetKey, userIdx, "IP_ONLY", normalizedIp, ipReason,
                    actorUserIdx, expiresAt, ipMatchType,
                    sourceActionType, sourceActionGroupId, sourceUserIdx, sourceIpAddress);
            Long ipHistoryBlockIdx = adminMapper.findBlockHistoryIdxByRequestId(ipBlockRequestId);

            ipBlockMapper.deactivateUserActionBlockedIpByTargetKey(ipRuleTargetKey, actorUserIdx);
            ipBlockMapper.upsertBlockedIpWithHistory(normalizedIp, ipRuleTargetKey, ipReason, userIdx, "IP_ONLY",
                    actorUserIdx, expiresAt, ipBlockRequestId, ipHistoryBlockIdx, null,
                    sourceActionType, sourceActionGroupId, sourceUserIdx, sourceIpAddress);
        }

        if (includesUserBlock) {
            notifyAccountBlocked(userIdx, reason, expiresAt);
        }
    }

    private String resolveSourceActionType(String blockType) {
        if ("USER_IP".equals(blockType)) {
            return "USER_AND_IP_BLOCK";
        }
        if ("USER_ONLY".equals(blockType)) {
            return "USER_BLOCK";
        }
        if ("IP_ONLY".equals(blockType)) {
            return "IP_BLOCK_FROM_MEMBER";
        }
        return "UNKNOWN_BLOCK_ACTION";
    }

    private String appendActionContext(String reason, String context) {
        if (context == null || context.isBlank()) return reason;
        if (reason == null || reason.isBlank()) return context;
        return reason + " (" + context + ")";
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
                latest.getSourceBlocklistIdx(),
                latest.getSourceActionType(),
                latest.getSourceActionGroupId(),
                latest.getSourceUserIdx(),
                latest.getSourceIpAddress()
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
    public Map<String, Object> getBusinessApplicationList(BusinessApplicationSearchVO search) {
        BusinessApplicationSearchVO normalized = normalizeBusinessApplicationSearch(search);
        Map<String, Object> params = buildBusinessApplicationParams(normalized, "CLIENT".equals(normalized.getMode()) ? false : true);
        int total = adminMapper.countBusinessApplications(params);
        AdminPageVO paging = AdminPageVO.of(total, normalized.getPage(), normalized.getSize(), 10);
        normalized.setPage(paging.getCurrentPage());
        params = buildBusinessApplicationParams(normalized, "CLIENT".equals(normalized.getMode()) ? false : true);

        List<BusinessAccountApplicationVO> list = adminMapper.findBusinessApplications(params);
        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("applicationList", list);
        result.put("search", normalized);
        result.put("status", normalized.getStatus());
        result.put("total", total);
        result.put("paging", paging);
        return result;
    }

    @Override
    public List<BusinessAccountApplicationVO> getBusinessApplications(String status) {
        BusinessApplicationSearchVO search = new BusinessApplicationSearchVO();
        search.setStatus(status);
        search.setMode("CLIENT");
        return adminMapper.findBusinessApplications(buildBusinessApplicationParams(normalizeBusinessApplicationSearch(search), false));
    }

    @Override
    public List<BusinessAccountApplicationVO> getBusinessApplicationsForExport(BusinessApplicationSearchVO search) {
        return adminMapper.findBusinessApplicationsForExport(buildBusinessApplicationParams(normalizeBusinessApplicationSearch(search), false));
    }

    @Override
    public List<BusinessAccountApplicationVO> getBusinessApplicationsByIds(List<Long> ids) {
        List<Long> normalized = normalizeBusinessApplicationIds(ids);
        if (normalized.isEmpty()) return Collections.emptyList();
        return adminMapper.findBusinessApplicationsByIds(normalized);
    }

    @Override
    @Transactional
    public void bulkApproveBusinessApplications(List<Long> applicationIdxList, Long reviewerUserIdx) {
        List<Long> ids = normalizeBusinessApplicationIds(applicationIdxList);
        if (ids.isEmpty()) {
            throw new IllegalArgumentException("선택된 신청이 없습니다.");
        }
        for (Long id : ids) {
            approveBusinessApplication(id, reviewerUserIdx);
        }
    }

    @Override
    @Transactional
    public void bulkRejectBusinessApplications(List<Long> applicationIdxList, String rejectReason, Long reviewerUserIdx) {
        List<Long> ids = normalizeBusinessApplicationIds(applicationIdxList);
        if (ids.isEmpty()) {
            throw new IllegalArgumentException("선택된 신청이 없습니다.");
        }
        String normalizedReason = normalizeRequiredRejectReason(rejectReason);
        for (Long id : ids) {
            rejectBusinessApplication(id, normalizedReason, reviewerUserIdx);
        }
    }

    private BusinessApplicationSearchVO normalizeBusinessApplicationSearch(BusinessApplicationSearchVO source) {
        BusinessApplicationSearchVO search = source != null ? source : new BusinessApplicationSearchVO();
        search.setKeyword(trimToNull(search.getKeyword()));
        search.setSearchType(normalizeBusinessSearchType(search.getSearchType()));
        search.setStatus(normalizeBusinessFilter(search.getStatus(), BUSINESS_VALID_STATUS, "PENDING", true));
        search.setRequestedRole(normalizeBusinessFilter(search.getRequestedRole(), BUSINESS_VALID_ROLE, "ALL", true));

        LocalDate from = parseMemberDate(search.getDateFrom());
        LocalDate to = parseMemberDate(search.getDateTo());
        if (from != null && to != null && from.isAfter(to)) {
            LocalDate tmp = from;
            from = to;
            to = tmp;
        }
        search.setDateFrom(from != null ? from.toString() : null);
        search.setDateTo(to != null ? to.toString() : null);
        search.setSortBy(normalizeBusinessSortBy(search.getSortBy()));
        search.setSortDir(normalizeBusinessSortDir(search.getSortDir()));
        search.setMode(normalizeBusinessMode(search.getMode()));
        search.setPage(Math.max(1, search.getPage()));
        search.setSize(normalizeMemberPageSize(search.getSize()));
        return search;
    }

    private Map<String, Object> buildBusinessApplicationParams(BusinessApplicationSearchVO search, boolean paged) {
        BusinessApplicationSearchVO normalized = normalizeBusinessApplicationSearch(search);
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", normalized.getKeyword());
        params.put("searchType", normalized.getSearchType());
        params.put("status", normalized.getStatus());
        params.put("requestedRole", normalized.getRequestedRole());
        params.put("dateFrom", normalized.getDateFrom());
        params.put("dateTo", normalized.getDateTo());
        params.put("sortBy", normalized.getSortBy());
        params.put("sortDir", normalized.getSortDir());
        params.put("mode", normalized.getMode());
        params.put("page", normalized.getPage());
        params.put("size", normalized.getSize());
        params.put("offset", normalized.getOffset());
        params.put("paged", paged);
        return params;
    }

    private String normalizeBusinessSearchType(String value) {
        String text = trimToNull(value);
        return text != null && BUSINESS_VALID_SEARCH_TYPES.contains(text) ? text : "all";
    }

    private String normalizeBusinessSortBy(String value) {
        String text = trimToNull(value);
        return text != null && BUSINESS_VALID_SORT.contains(text) ? text : "createdAt";
    }

    private String normalizeBusinessSortDir(String value) {
        return "ASC".equalsIgnoreCase(trimToNull(value)) ? "ASC" : "DESC";
    }

    private String normalizeBusinessMode(String value) {
        String text = trimToNull(value);
        if (text == null) return "SERVER";
        text = text.toUpperCase();
        return BUSINESS_VALID_MODE.contains(text) ? text : "SERVER";
    }

    private String normalizeBusinessFilter(String value, Set<String> validValues, String defaultValue, boolean upper) {
        String text = trimToNull(value);
        if (text == null) return defaultValue;
        if (upper) text = text.toUpperCase();
        return validValues.contains(text) ? text : defaultValue;
    }

    private List<Long> normalizeBusinessApplicationIds(List<Long> ids) {
        if (ids == null || ids.isEmpty()) return Collections.emptyList();
        return ids.stream()
                .filter(id -> id != null && id > 0)
                .collect(java.util.stream.Collectors.collectingAndThen(
                        java.util.stream.Collectors.toCollection(LinkedHashSet::new),
                        ArrayList::new
                ));
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
        AdminLoginAuditSearchVO normalized = search != null ? search : new AdminLoginAuditSearchVO();
        int total = adminMapper.countLoginAudits(normalized);
        AdminPageVO paging = AdminPageVO.of(total, normalized.getPage(), normalized.getSize(), 10);
        normalized.setPage(paging.getCurrentPage());

        List<AdminLoginAuditVO> list = adminMapper.findLoginAudits(normalized);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", normalized);
        return result;
    }

    // ===== 보안 이력 감사 =====

    @Override
    public Map<String, Object> getSecurityAuditList(AdminSecurityAuditSearchVO search) {
        AdminSecurityAuditSearchVO normalized = search != null ? search : new AdminSecurityAuditSearchVO();
        int requestedSize = normalized.getSize();
        if (requestedSize != 30 && requestedSize != 50 && requestedSize != 100 && requestedSize != 10000) {
            normalized.setSize(30);
        }
        if (normalized.getPage() < 1) {
            normalized.setPage(1);
        }

        int total = adminMapper.countSecurityAudits(normalized);
        AdminPageVO paging = AdminPageVO.of(total, normalized.getPage(), normalized.getSize(), 10);
        normalized.setPage(paging.getCurrentPage());

        List<AdminSecurityAuditVO> list = adminMapper.findSecurityAudits(normalized);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", normalized);
        return result;
    }

    // ===== 이메일 액션 요청 이력 =====

    @Override
    public Map<String, Object> getEmailVerificationRequestList(AdminEmailVerificationRequestSearchVO search) {
        AdminEmailVerificationRequestSearchVO normalized = normalizeEmailVerificationRequestSearch(search);
        int total = adminMapper.countEmailVerificationRequests(normalized);
        AdminPageVO paging = AdminPageVO.of(total, normalized.getPage(), normalized.getSize(), 10);
        normalized.setPage(paging.getCurrentPage());
        normalized.setPaged(!"CLIENT".equals(normalized.getMode()));

        List<AdminEmailVerificationRequestVO> list = adminMapper.findEmailVerificationRequests(normalized);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", normalized);
        return result;
    }

    @Override
    public List<AdminEmailVerificationRequestVO> getEmailVerificationRequestsForExport(AdminEmailVerificationRequestSearchVO search) {
        AdminEmailVerificationRequestSearchVO normalized = normalizeEmailVerificationRequestSearch(search);
        normalized.setPage(1);
        normalized.setPaged(false);
        return adminMapper.findEmailVerificationRequests(normalized);
    }

    private AdminEmailVerificationRequestSearchVO normalizeEmailVerificationRequestSearch(AdminEmailVerificationRequestSearchVO source) {
        AdminEmailVerificationRequestSearchVO search = source != null ? source : new AdminEmailVerificationRequestSearchVO();
        search.setKeyword(trimToNull(search.getKeyword()));
        search.setStatus(search.getStatus());
        search.setPurpose(search.getPurpose());
        search.setDateFilter(search.getDateFilter());
        search.setSortField(search.getSortField());
        search.setSortDir(search.getSortDir());
        search.setMode(search.getMode());
        search.setPage(search.getPage());
        search.setSize(search.getSize());
        search.setPaged(!"CLIENT".equals(search.getMode()));
        return search;
    }

    // ===== 이메일 액션 토큰 이력 =====

    @Override
    public Map<String, Object> getEmailVerificationList(AdminEmailVerificationSearchVO search) {
        AdminEmailVerificationSearchVO normalized = normalizeEmailVerificationSearch(search);
        int total = adminMapper.countEmailVerifications(normalized);
        AdminPageVO paging = AdminPageVO.of(total, normalized.getPage(), normalized.getSize(), 10);
        normalized.setPage(paging.getCurrentPage());
        normalized.setPaged(!"CLIENT".equals(normalized.getMode()));

        List<AdminEmailVerificationVO> list = adminMapper.findEmailVerifications(normalized);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", normalized);
        return result;
    }

    @Override
    public List<AdminEmailVerificationVO> getEmailVerificationsForExport(AdminEmailVerificationSearchVO search) {
        AdminEmailVerificationSearchVO normalized = normalizeEmailVerificationSearch(search);
        normalized.setPage(1);
        normalized.setPaged(false);
        return adminMapper.findEmailVerifications(normalized);
    }

    private AdminEmailVerificationSearchVO normalizeEmailVerificationSearch(AdminEmailVerificationSearchVO source) {
        AdminEmailVerificationSearchVO search = source != null ? source : new AdminEmailVerificationSearchVO();
        search.setKeyword(trimToNull(search.getKeyword()));
        search.setPurpose(search.getPurpose());
        search.setUsed(search.getUsed());
        search.setDateFilter(search.getDateFilter());
        search.setSortField(search.getSortField());
        search.setSortDir(search.getSortDir());
        search.setMode(search.getMode());
        search.setPage(search.getPage());
        search.setSize(search.getSize());
        search.setPaged(!"CLIENT".equals(search.getMode()));
        return search;
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
