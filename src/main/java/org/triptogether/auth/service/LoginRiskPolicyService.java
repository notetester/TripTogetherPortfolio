package org.triptogether.auth.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.auth.mapper.LoginRiskPolicyMapper;
import org.triptogether.auth.vo.LoginRequestContext;
import org.triptogether.auth.vo.LoginRiskDecisionVO;
import org.triptogether.auth.vo.LoginRiskPolicyVO;
import org.triptogether.auth.vo.UsersVO;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Locale;

@Slf4j
@Service
@RequiredArgsConstructor
public class LoginRiskPolicyService {

    private static final String ACCOUNT_POLICY = "ACCOUNT_PASSWORD_FAILURE_LOCK";
    private static final String ACCOUNT_REPEAT_POLICY = "ACCOUNT_REPEATED_LOCK_PROTECTION";
    private static final String IP_POLICY = "IP_FAILED_LOGIN_LOCK";
    private static final String IP_REVIEW_POLICY = "IP_SUSPICIOUS_LOGIN_REVIEW";

    private final LoginRiskPolicyMapper loginRiskPolicyMapper;
    private final AdminMapper adminMapper;

    public List<LoginRiskPolicyVO> getPolicies(boolean includeInactive) {
        return loginRiskPolicyMapper.findPolicies(includeInactive);
    }

    @Transactional
    public void updatePolicy(LoginRiskPolicyVO policy) {
        loginRiskPolicyMapper.updatePolicy(policy);
    }

    public LoginRiskDecisionVO checkPreLogin(String identifier, UsersVO user, String loginMethod, LoginRequestContext context) {
        if (context == null) return null;
        String ip = context.getIpAddress();
        if (ip != null && !ip.isBlank()) {
            int ipLocks = n(loginRiskPolicyMapper.countActiveIpLoginLocks(ip, LocalDateTime.now()));
            if (ipLocks > 0) {
                String message = "현재 접속 환경에서 로그인 시도가 일시적으로 제한되었습니다. 잠시 후 다시 시도해 주세요.";
                applyContext(context, "IP_LOGIN_LOCK", message, null, true, true);
                return LoginRiskDecisionVO.builder()
                        .denied(true)
                        .locked(true)
                        .policyCode(IP_POLICY)
                        .actionType("IP_LOGIN_LOCK")
                        .failReason("IP_LOGIN_LOCKED")
                        .userMessage(message)
                        .build();
            }
        }
        return null;
    }

    @Transactional
    public LoginRiskDecisionVO handleWrongPassword(UsersVO user, String identifier, String loginMethod, LoginRequestContext context) {
        if (context == null) context = LoginRequestContext.builder().build();
        LoginRiskDecisionVO accountDecision = evaluateAccountWrongPassword(user, identifier, context);
        LoginRiskDecisionVO ipDecision = evaluateIpWrongPassword(user, identifier, context);
        return accountDecision != null ? accountDecision : ipDecision;
    }

    @Transactional
    public void handleLoginSuccess(UsersVO user, String identifier, LoginRequestContext context) {
        if (user == null || context == null) return;
        loginRiskPolicyMapper.clearCountersOnLoginSuccess(user.getUserIdx(), context.getIpAddress());
    }

    private LoginRiskDecisionVO evaluateAccountWrongPassword(UsersVO user, String identifier, LoginRequestContext context) {
        if (user == null || user.getUserIdx() == null) return null;
        LoginRiskPolicyVO policy = loginRiskPolicyMapper.findActivePolicyByCode(ACCOUNT_POLICY);
        if (policy == null) return null;

        LocalDateTime since = since(policy);
        int observed = n(loginRiskPolicyMapper.countRecentWrongPasswordByUser(user.getUserIdx(), since));
        int threshold = safeThreshold(policy, 5);
        int remaining = Math.max(0, threshold - observed);

        if (observed >= threshold) {
            LocalDateTime blockedUntil = lockUntil(policy);
            String reason = "비밀번호 오류 횟수 초과로 로그인 일시 제한";
            adminMapper.markMemberBlocked(user.getUserIdx(), blockedUntil, reason);
            loginRiskPolicyMapper.insertRiskEvent(policy.getPolicyCode(), "THRESHOLD_REACHED", "USER", String.valueOf(user.getUserIdx()),
                    user.getUserIdx(), context.getIpAddress(), identifier, threshold, observed, "ACCOUNT_TEMP_LOCK", "AUTO_APPLIED",
                    false, blockedUntil, context.getRequestId(), context.getFlowTraceId(), reason);
            maybeProtectAccount(user, identifier, context);
            String message = "비밀번호 오류 횟수 초과로 로그인이 일시적으로 제한되었습니다. 일정 시간 후 다시 시도해 주세요.";
            applyContext(context, policy.getPolicyCode(), message, 0, true, false);
            return LoginRiskDecisionVO.builder().denied(true).locked(true).policyCode(policy.getPolicyCode())
                    .actionType("ACCOUNT_TEMP_LOCK").failReason("ACCOUNT_TEMP_LOCKED")
                    .userMessage(message).remainingAttempts(0).blockedUntil(blockedUntil).build();
        }

        int warningBefore = policy.getWarningBeforeCount() == null ? 0 : policy.getWarningBeforeCount();
        if (warningBefore > 0 && remaining <= warningBefore) {
            String message = localizedRemainingMessage(user.getPreferredLang(), remaining);
            applyContext(context, policy.getPolicyCode(), message, remaining, false, false);
            loginRiskPolicyMapper.insertRiskEvent(policy.getPolicyCode(), "WARNING", "USER", String.valueOf(user.getUserIdx()),
                    user.getUserIdx(), context.getIpAddress(), identifier, threshold, observed, "WARN", "RECORDED",
                    false, null, context.getRequestId(), context.getFlowTraceId(), message);
            return LoginRiskDecisionVO.builder().policyCode(policy.getPolicyCode()).actionType("WARN")
                    .userMessage(message).remainingAttempts(remaining).build();
        }
        return null;
    }

    private void maybeProtectAccount(UsersVO user, String identifier, LoginRequestContext context) {
        LoginRiskPolicyVO policy = loginRiskPolicyMapper.findActivePolicyByCode(ACCOUNT_REPEATED_LOCK_PROTECTION);
        if (policy == null) return;
        int lockCount = n(loginRiskPolicyMapper.countRecentAccountLocks(user.getUserIdx(), since(policy)));
        int threshold = safeThreshold(policy, 3);
        if (lockCount >= threshold) {
            String reason = "반복된 로그인 제한으로 계정 보호 조치 전환";
            adminMapper.markMemberBlocked(user.getUserIdx(), null, reason);
            loginRiskPolicyMapper.insertRiskEvent(policy.getPolicyCode(), "PROTECTION_REQUIRED", "USER", String.valueOf(user.getUserIdx()),
                    user.getUserIdx(), context.getIpAddress(), identifier, threshold, lockCount, "ACCOUNT_PROTECTION_REQUIRED", "AUTO_APPLIED",
                    true, null, context.getRequestId(), context.getFlowTraceId(), reason);
            createAdminReview(policy, "ACCOUNT_PROTECTION", "USER", String.valueOf(user.getUserIdx()), user.getUserIdx(), context.getIpAddress(), context,
                    "계정 보호 조치 검토 필요", reason);
        }
    }

    private LoginRiskDecisionVO evaluateIpWrongPassword(UsersVO user, String identifier, LoginRequestContext context) {
        String ip = context.getIpAddress();
        if (ip == null || ip.isBlank()) return null;
        LoginRiskPolicyVO policy = loginRiskPolicyMapper.findActivePolicyByCode(IP_POLICY);
        if (policy == null) return null;
        LocalDateTime since = since(policy);
        int failures = n(loginRiskPolicyMapper.countRecentWrongPasswordByIp(ip, since));
        int distinct = n(loginRiskPolicyMapper.countRecentDistinctIdentifiersByIp(ip, since));
        int threshold = safeThreshold(policy, 10);
        int distinctThreshold = policy.getDistinctAccountThreshold() == null ? 0 : policy.getDistinctAccountThreshold();
        boolean reached = failures >= threshold && (distinctThreshold <= 0 || distinct >= distinctThreshold);
        if (!reached) {
            maybeCreateIpReview(user, identifier, context, failures, distinct);
            return null;
        }
        LocalDateTime blockedUntil = lockUntil(policy);
        String reason = "동일 IP의 반복 로그인 실패로 로그인 일시 제한";
        loginRiskPolicyMapper.insertIpLoginLockCounter(policy.getPolicyCode(), ip, blockedUntil, reason);
        loginRiskPolicyMapper.insertRiskEvent(policy.getPolicyCode(), "THRESHOLD_REACHED", "IP", ip,
                user == null ? null : user.getUserIdx(), ip, identifier, threshold, failures, "IP_LOGIN_LOCK", "AUTO_APPLIED",
                false, blockedUntil, context.getRequestId(), context.getFlowTraceId(), reason);
        String message = "현재 접속 환경에서 로그인 시도가 일시적으로 제한되었습니다. 잠시 후 다시 시도해 주세요.";
        applyContext(context, policy.getPolicyCode(), message, 0, true, false);
        return LoginRiskDecisionVO.builder().denied(true).locked(true).policyCode(policy.getPolicyCode()).actionType("IP_LOGIN_LOCK")
                .failReason("IP_LOGIN_LOCKED").userMessage(message).remainingAttempts(0).blockedUntil(blockedUntil).build();
    }

    private void maybeCreateIpReview(UsersVO user, String identifier, LoginRequestContext context, int failures, int distinct) {
        LoginRiskPolicyVO policy = loginRiskPolicyMapper.findActivePolicyByCode(IP_REVIEW_POLICY);
        if (policy == null || !policy.isRequireAdminReview()) return;
        int threshold = safeThreshold(policy, 20);
        int distinctThreshold = policy.getDistinctAccountThreshold() == null ? 0 : policy.getDistinctAccountThreshold();
        if (failures < threshold || (distinctThreshold > 0 && distinct < distinctThreshold)) return;
        String summary = "반복 로그인 실패 IP 검토 필요";
        String detail = "IP=" + context.getIpAddress() + ", failures=" + failures + ", distinctIdentifiers=" + distinct;
        createAdminReview(policy, "IP_LOGIN_RISK", "IP", context.getIpAddress(), user == null ? null : user.getUserIdx(), context.getIpAddress(), context, summary, detail);
    }

    private void createAdminReview(LoginRiskPolicyVO policy, String reviewType, String subjectType, String subjectKey,
                                   Long userIdx, String ip, LoginRequestContext context, String summary, String detail) {
        loginRiskPolicyMapper.insertReviewQueue(policy.getPolicyCode(), reviewType, policy.getReviewSeverity(), subjectType, subjectKey,
                userIdx, ip, context.getRequestId(), context.getFlowTraceId(), summary, detail);
        for (Long adminIdx : loginRiskPolicyMapper.findAdminNotificationTargets(policy.getNotificationCategory())) {
            loginRiskPolicyMapper.insertAdminNotification(adminIdx, "LOGIN_RISK_REVIEW", null, summary, "/admin/login-risk/policies");
        }
    }

    private LocalDateTime since(LoginRiskPolicyVO policy) {
        if (policy == null || policy.getObservationMinutes() == null || policy.getObservationMinutes() <= 0) return null;
        return LocalDateTime.now().minusMinutes(policy.getObservationMinutes());
    }

    private LocalDateTime lockUntil(LoginRiskPolicyVO policy) {
        if (policy == null || policy.getLockDurationMinutes() == null || policy.getLockDurationMinutes() <= 0) return null;
        return LocalDateTime.now().plusMinutes(policy.getLockDurationMinutes());
    }

    private int safeThreshold(LoginRiskPolicyVO policy, int fallback) {
        return policy.getThresholdCount() == null || policy.getThresholdCount() <= 0 ? fallback : policy.getThresholdCount();
    }

    private int n(Integer value) { return value == null ? 0 : value; }

    private void applyContext(LoginRequestContext context, String policyCode, String message, Integer remaining, boolean denied, boolean review) {
        context.setLoginRiskPolicyCode(policyCode);
        context.setLoginRiskMessage(message);
        context.setRemainingAttempts(remaining);
        context.setLoginRiskDenied(denied);
        context.setLoginRiskReviewRequired(review);
    }

    private String localizedRemainingMessage(String preferredLang, int remaining) {
        String lang = preferredLang == null ? "ko" : preferredLang.toLowerCase(Locale.ROOT);
        if (lang.startsWith("en")) return "The password is incorrect. Remaining attempts before temporary restriction: " + remaining + ".";
        if (lang.startsWith("ja")) return "パスワードが正しくありません。一時的な制限まで残り " + remaining + " 回です。";
        if (lang.startsWith("zh")) return "密码不正确。距离临时限制还剩 " + remaining + " 次尝试。";
        return "비밀번호가 올바르지 않습니다. 일시 제한 전 남은 시도 횟수는 " + remaining + "회입니다.";
    }
}
