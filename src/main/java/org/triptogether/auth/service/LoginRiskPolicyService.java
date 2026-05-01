package org.triptogether.auth.service;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.auth.mapper.LoginRiskPolicyMapper;
import org.triptogether.auth.vo.AdminNotificationPreferenceVO;
import org.triptogether.auth.vo.LoginRequestContext;
import org.triptogether.auth.vo.LoginRiskDecisionVO;
import org.triptogether.auth.vo.LoginRiskPolicyVO;
import org.triptogether.auth.vo.LoginRiskReviewVO;
import org.triptogether.auth.vo.LoginRiskExternalAssessmentVO;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.config.BlockRuleCacheService;
import org.triptogether.auth.risk.LoginRiskAssessmentProvider;
import org.triptogether.auth.risk.LoginRiskAssessmentRequest;
import org.triptogether.auth.risk.LoginRiskAssessmentResult;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

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
    private final JavaMailSender mailSender;
    private final BlockRuleCacheService blockRuleCacheService;
    private final List<LoginRiskAssessmentProvider> assessmentProviders;

    @Value("${spring.mail.username:}")
    private String mailFrom;

    public List<LoginRiskPolicyVO> getPolicies(boolean includeInactive) {
        return loginRiskPolicyMapper.findPolicies(includeInactive);
    }

    @Transactional
    public void updatePolicy(LoginRiskPolicyVO policy) {
        loginRiskPolicyMapper.updatePolicy(policy);
    }

    public List<LoginRiskReviewVO> getReviewQueue(String status, String severity, String reviewType, String keyword) {
        return loginRiskPolicyMapper.findReviewQueue(emptyToNull(status), emptyToNull(severity), emptyToNull(reviewType), emptyToNull(keyword));
    }

    public LoginRiskReviewVO getReviewDetail(Long reviewIdx) {
        return loginRiskPolicyMapper.findReviewByIdx(reviewIdx);
    }

    public List<LoginRiskExternalAssessmentVO> getExternalAssessments(String sourceKind, String riskLevel, String decisionStatus, String keyword) {
        return loginRiskPolicyMapper.findExternalAssessments(emptyToNull(sourceKind), emptyToNull(riskLevel), emptyToNull(decisionStatus), emptyToNull(keyword));
    }

    public List<AdminNotificationPreferenceVO> getNotificationPreferences(Long adminUserIdx) {
        return loginRiskPolicyMapper.findNotificationPreferences(adminUserIdx);
    }

    @Transactional
    public void updateNotificationPreferences(Long adminUserIdx, List<String> enabledCategories) {
        List<String> categories = List.of("LOGIN_RISK", "BUSINESS_APPLICATION", "REPORT", "INQUIRY", "BLOCK_REVIEW");
        for (String category : categories) {
            loginRiskPolicyMapper.upsertNotificationPreference(adminUserIdx, category, enabledCategories != null && enabledCategories.contains(category));
        }
    }

    @Transactional
    public void decideReview(Long reviewIdx, String decision, Long adminUserIdx, String comment) {
        LoginRiskReviewVO review = loginRiskPolicyMapper.findReviewByIdx(reviewIdx);
        if (review == null) {
            throw new IllegalArgumentException("검토 대상을 찾을 수 없습니다.");
        }

        String normalized = normalizeDecision(decision);
        loginRiskPolicyMapper.updateReviewDecision(reviewIdx, normalized, adminUserIdx, comment);

        if ("APPROVED".equals(normalized)) {
            applyApprovedReview(review, adminUserIdx, comment);
        }

        loginRiskPolicyMapper.insertRiskEvent(
                review.getPolicyCode(),
                "REVIEW_" + normalized,
                review.getSubjectType(),
                review.getSubjectKey(),
                review.getUserIdx(),
                review.getIpAddress(),
                null,
                null,
                null,
                "ADMIN_REVIEW",
                normalized,
                false,
                null,
                review.getRequestId(),
                review.getFlowTraceId(),
                "관리자 검토 처리: " + normalized + (comment == null || comment.isBlank() ? "" : " / " + comment)
        );
    }

    private void applyApprovedReview(LoginRiskReviewVO review, Long adminUserIdx, String comment) {
        if (review.getReviewType() != null && review.getReviewType().contains("ACCOUNT") && review.getUserIdx() != null) {
            adminMapper.markMemberBlocked(review.getUserIdx(), null, "관리자 승인: 로그인 위험 검토에 따른 계정 보호 조치");
        }

        if ("IP".equalsIgnoreCase(review.getSubjectType()) || "IP_RANGE".equalsIgnoreCase(review.getSubjectType())) {
            String target = firstNonBlank(review.getSubjectKey(), review.getIpAddress());
            if (target != null && !target.isBlank()) {
                boolean cidr = target.contains("/");
                String matchType = cidr ? "CIDR" : "SINGLE_IP";
                String ipAddress = cidr ? target.substring(0, target.indexOf('/')) : target;
                String blockTargetKey = cidr ? "CIDR:" + target : "IP:" + target;
                String blockRequestId = UUID.randomUUID().toString();
                String reason = "관리자 승인: 로그인 위험 검토 기반 접근 환경 제한";
                loginRiskPolicyMapper.insertApprovedIpBlock(
                        ipAddress,
                        blockTargetKey,
                        matchType,
                        cidr ? target : null,
                        reason,
                        adminUserIdx,
                        blockRequestId,
                        "LOGIN_RISK_REVIEW_APPROVED",
                        firstNonBlank(review.getFlowTraceId(), blockRequestId),
                        review.getUserIdx(),
                        target
                );

                loginRiskPolicyMapper.insertWafSyncQueue(
                        "LOGIN_RISK_REVIEW",
                        review.getReviewIdx(),
                        "BLOCK",
                        cidr ? "CIDR" : "IP",
                        target,
                        "PENDING",
                        "관리자 승인된 로그인 위험 검토입니다. 외부 WAF/CDN 동기화 후보로 등록되었습니다."
                );

                try {
                    blockRuleCacheService.invalidateAndRefresh();
                } catch (Exception e) {
                    log.warn("[LoginRisk] 차단 규칙 캐시 갱신 실패 reviewIdx={}", review.getReviewIdx(), e);
                }
            }
        }
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
        LoginRiskPolicyVO policy = loginRiskPolicyMapper.findActivePolicyByCode(ACCOUNT_REPEAT_POLICY);
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
            sendProtectionNoticeIfPossible(user, context, reason);
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
        if (policy.isAiAssistEnabled()) {
            recordAssessmentCandidates(policy, "LOGIN_RISK_REVIEW", null, "IP", context.getIpAddress(),
                    user == null ? null : user.getUserIdx(), context.getIpAddress(), null, null,
                    failures, distinct, detail);
        }
    }


    private void recordAssessmentCandidates(LoginRiskPolicyVO policy,
                                            String sourceType,
                                            Long sourceId,
                                            String subjectType,
                                            String subjectKey,
                                            Long userIdx,
                                            String ipAddress,
                                            String countryCode,
                                            String asn,
                                            Integer observedCount,
                                            Integer distinctCount,
                                            String detail) {
        LoginRiskAssessmentRequest request = LoginRiskAssessmentRequest.builder()
                .policyCode(policy == null ? null : policy.getPolicyCode())
                .subjectType(subjectType)
                .subjectKey(subjectKey)
                .userIdx(userIdx)
                .ipAddress(ipAddress)
                .countryCode(countryCode)
                .asn(asn)
                .observedCount(observedCount)
                .distinctIdentifierCount(distinctCount)
                .detailMessage(detail)
                .build();

        boolean providerReturned = false;
        if (assessmentProviders != null) {
            for (LoginRiskAssessmentProvider provider : assessmentProviders) {
                try {
                    var result = provider.assess(request);
                    if (result.isPresent()) {
                        providerReturned = true;
                        insertExternalAssessmentResult(sourceType, sourceId, policy, subjectType, subjectKey,
                                userIdx, ipAddress, countryCode, asn, result.get());
                    }
                } catch (Exception e) {
                    log.warn("[LoginRisk] 외부 위험 평가 Provider 실행 실패 provider={}", provider.getClass().getName(), e);
                }
            }
        }

        if (!providerReturned) {
            loginRiskPolicyMapper.insertExternalAssessment(
                    "ASSESSMENT_PIPELINE",
                    "READY_FOR_PROVIDER",
                    "External assessment provider hook",
                    "0.0.0",
                    sourceType,
                    sourceId,
                    policy == null ? null : policy.getPolicyCode(),
                    subjectType,
                    subjectKey,
                    userIdx,
                    ipAddress,
                    countryCode,
                    asn,
                    null,
                    "PENDING",
                    null,
                    "REVIEW",
                    "실제 AI/알고리즘/상위 정책기관 모듈 연결 대기",
                    detail,
                    "PENDING",
                    "{\"provider\":\"not-connected\"}"
            );
        }
    }

    private void insertExternalAssessmentResult(String sourceType,
                                                Long sourceId,
                                                LoginRiskPolicyVO policy,
                                                String subjectType,
                                                String subjectKey,
                                                Long userIdx,
                                                String ipAddress,
                                                String countryCode,
                                                String asn,
                                                LoginRiskAssessmentResult result) {
        loginRiskPolicyMapper.insertExternalAssessment(
                result.getSourceKind(),
                result.getSourceCode(),
                result.getSourceName(),
                result.getSourceVersion(),
                sourceType,
                sourceId,
                policy == null ? null : policy.getPolicyCode(),
                subjectType,
                subjectKey,
                userIdx,
                ipAddress,
                countryCode,
                asn,
                result.getRiskScore(),
                result.getRiskLevel(),
                result.getConfidenceScore(),
                result.getRecommendationAction(),
                result.getRecommendationReason(),
                result.getEvidenceSummary(),
                "PROPOSED",
                result.getRawPayload()
        );
    }

    private void createAdminReview(LoginRiskPolicyVO policy, String reviewType, String subjectType, String subjectKey,
                                   Long userIdx, String ip, LoginRequestContext context, String summary, String detail) {
        loginRiskPolicyMapper.insertReviewQueue(policy.getPolicyCode(), reviewType, policy.getReviewSeverity(), subjectType, subjectKey,
                userIdx, ip, context.getRequestId(), context.getFlowTraceId(), summary, detail);
        for (Long adminIdx : loginRiskPolicyMapper.findAdminNotificationTargets(policy.getNotificationCategory())) {
            loginRiskPolicyMapper.insertAdminNotification(adminIdx, "LOGIN_RISK_REVIEW", null, summary, "/admin/login-risk/reviews");
        }
    }

    private void sendProtectionNoticeIfPossible(UsersVO user, LoginRequestContext context, String reason) {
        if (user == null || !user.isEmailVerified() || user.getUserEmail() == null || user.getUserEmail().isBlank()) {
            loginRiskPolicyMapper.insertRiskEvent(ACCOUNT_REPEAT_POLICY, "PROTECTION_MAIL_SKIPPED", "USER",
                    user == null ? null : String.valueOf(user.getUserIdx()),
                    user == null ? null : user.getUserIdx(),
                    context == null ? null : context.getIpAddress(),
                    null, null, null, "NOTIFY_USER", "MAIL_SKIPPED", false,
                    null,
                    context == null ? null : context.getRequestId(),
                    context == null ? null : context.getFlowTraceId(),
                    "인증된 이메일이 없어 계정 보호 조치 안내 메일을 발송하지 않았습니다.");
            return;
        }

        String lang = normalizeLang(user.getPreferredLang());
        String subject = protectionMailSubject(lang);
        String html = protectionMailHtml(lang, user.getNickname(), reason);
        boolean sent = sendMail(user.getUserEmail(), subject, html);
        loginRiskPolicyMapper.insertRiskEvent(ACCOUNT_REPEAT_POLICY, sent ? "PROTECTION_MAIL_SENT" : "PROTECTION_MAIL_FAILED",
                "USER", String.valueOf(user.getUserIdx()), user.getUserIdx(),
                context == null ? null : context.getIpAddress(),
                null, null, null, "NOTIFY_USER", sent ? "MAIL_SENT" : "MAIL_FAILED", false,
                null,
                context == null ? null : context.getRequestId(),
                context == null ? null : context.getFlowTraceId(),
                sent ? "계정 보호 조치 안내 메일 발송 완료" : "계정 보호 조치 안내 메일 발송 실패");
    }

    private boolean sendMail(String to, String subject, String html) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
            helper.setFrom(mailFrom);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(html, true);
            mailSender.send(message);
            return true;
        } catch (Exception e) {
            log.warn("[LoginRisk] 보호 조치 안내 메일 발송 실패 to={}", to, e);
            return false;
        }
    }

    private String protectionMailSubject(String lang) {
        return switch (lang) {
            case "en" -> "[TripTogether] Account protection notice";
            case "ja" -> "[TripTogether] アカウント保護措置のお知らせ";
            case "zh" -> "[TripTogether] 账户保护措施通知";
            default -> "[TripTogether] 계정 보호 조치 안내";
        };
    }

    private String protectionMailHtml(String lang, String nickname, String reason) {
        String safeName = nickname == null || nickname.isBlank() ? "TripTogether user" : nickname;
        String title;
        String body;
        String guide;
        switch (lang) {
            case "en" -> {
                title = "Account protection has been applied.";
                body = "For your security, sign-in to your TripTogether account has been restricted temporarily pending operator review.";
                guide = "If this was not expected, please contact customer support and provide your account information and recent sign-in context.";
            }
            case "ja" -> {
                title = "アカウント保護措置が適用されました。";
                body = "セキュリティ保護のため、運営者の確認が完了するまでTripTogetherアカウントのログインが制限されています。";
                guide = "心当たりがない場合は、カスタマーサポートまでお問い合わせください。";
            }
            case "zh" -> {
                title = "账户已进入保护状态。";
                body = "为保护账户安全，在运营人员确认之前，您的 TripTogether 账户登录将受到限制。";
                guide = "如果您认为这是误判，请联系客户支持并提供相关账户信息。";
            }
            default -> {
                title = "계정 보호 조치가 적용되었습니다.";
                body = "계정 보안을 위해 운영자 확인 전까지 TripTogether 계정 로그인이 제한됩니다.";
                guide = "본인이 요청하지 않은 상황이라면 고객센터로 문의해 주세요.";
            }
        }
        return """
                <!DOCTYPE html>
                <html><body style="font-family:Arial,'Noto Sans KR',sans-serif;background:#f8fafc;padding:32px">
                <div style="max-width:560px;margin:0 auto;background:white;border-radius:16px;padding:28px;border:1px solid #e5e7eb">
                    <h2 style="margin:0 0 16px;color:#111827">%s</h2>
                    <p style="line-height:1.7;color:#374151">%s</p>
                    <p style="line-height:1.7;color:#374151">%s</p>
                    <div style="margin-top:20px;padding:16px;border-radius:12px;background:#eff6ff;color:#1e3a8a">
                        <strong>User</strong>: %s<br>
                        <strong>Reason</strong>: %s
                    </div>
                </div>
                </body></html>
                """.formatted(title, body, guide, safeName, reason == null ? "-" : reason);
    }

    private String normalizeDecision(String decision) {
        if (decision == null) return "HOLD";
        return switch (decision.toLowerCase(Locale.ROOT)) {
            case "approve", "approved" -> "APPROVED";
            case "reject", "rejected" -> "REJECTED";
            case "hold", "pending" -> "HOLD";
            default -> "HOLD";
        };
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
        String lang = normalizeLang(preferredLang);
        if (lang.startsWith("en")) return "The password is incorrect. Remaining attempts before temporary restriction: " + remaining + ".";
        if (lang.startsWith("ja")) return "パスワードが正しくありません。一時的な制限まで残り " + remaining + " 回です。";
        if (lang.startsWith("zh")) return "密码不正确。距离临时限制还剩 " + remaining + " 次尝试。";
        return "비밀번호가 올바르지 않습니다. 일시 제한 전 남은 시도 횟수는 " + remaining + "회입니다.";
    }

    private String normalizeLang(String preferredLang) {
        if (preferredLang == null || preferredLang.isBlank()) return "ko";
        String lang = preferredLang.toLowerCase(Locale.ROOT);
        if (lang.startsWith("en")) return "en";
        if (lang.startsWith("ja")) return "ja";
        if (lang.startsWith("zh")) return "zh";
        return "ko";
    }

    private String firstNonBlank(String... values) {
        if (values == null) return null;
        for (String value : values) {
            if (value != null && !value.isBlank()) return value;
        }
        return null;
    }

    private String emptyToNull(String value) {
        return value == null || value.isBlank() ? null : value;
    }
}
