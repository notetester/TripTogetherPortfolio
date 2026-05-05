package org.triptogether.auth.service;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdminMapper;
import org.triptogether.auth.mapper.LoginRiskPolicyMapper;
import org.triptogether.auth.vo.AdminNotificationPreferenceVO;
import org.triptogether.auth.vo.LoginRequestContext;
import org.triptogether.auth.vo.LoginRiskDecisionVO;
import org.triptogether.auth.vo.LoginRiskPolicyVO;
import org.triptogether.auth.vo.LoginRiskReviewVO;
import org.triptogether.auth.vo.SecurityRiskAssessmentVO;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityReviewVO;
import org.triptogether.auth.vo.SecurityWafSyncQueueVO;
import org.triptogether.auth.vo.SecurityAppealVO;
import org.triptogether.auth.vo.SecurityAppealFormVO;
import org.triptogether.auth.vo.SecurityAppealTokenVO;
import org.triptogether.auth.vo.LoginRiskExternalAssessmentVO;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.config.BlockRuleCacheService;
import org.triptogether.auth.risk.LoginRiskAssessmentProvider;
import org.triptogether.auth.risk.LoginRiskAssessmentRequest;
import org.triptogether.auth.risk.LoginRiskAssessmentResult;
import org.triptogether.auth.risk.WafSyncProvider;
import org.triptogether.auth.risk.WafSyncResult;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Locale;
import java.util.UUID;
import java.util.regex.Pattern;

@Slf4j
@Service
@RequiredArgsConstructor
public class LoginRiskPolicyService {

    private static final String ACCOUNT_POLICY = "ACCOUNT_PASSWORD_FAILURE_LOCK";
    private static final String ACCOUNT_REPEAT_POLICY = "ACCOUNT_REPEATED_LOCK_PROTECTION";
    private static final String IP_POLICY = "IP_FAILED_LOGIN_LOCK";
    private static final String IP_REVIEW_POLICY = "IP_SUSPICIOUS_LOGIN_REVIEW";
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$");

    private final LoginRiskPolicyMapper loginRiskPolicyMapper;
    private final AdminMapper adminMapper;
    private final JavaMailSender mailSender;
    private final MessageSource messageSource;
    private final BlockRuleCacheService blockRuleCacheService;
    private final List<LoginRiskAssessmentProvider> assessmentProviders;
    private final List<WafSyncProvider> wafSyncProviders;

    @Value("${spring.mail.username:}")
    private String mailFrom;

    @Value("${app.public-base-url:http://localhost:8080/TripTogether}")
    private String publicBaseUrl;

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

    public List<SecurityRiskAssessmentVO> getSecurityRiskAssessments(String assessmentScope,
                                                                    String sourceKind,
                                                                    String riskLevel,
                                                                    String decisionStatus,
                                                                    String keyword) {
        return loginRiskPolicyMapper.findSecurityRiskAssessments(
                emptyToNull(assessmentScope),
                emptyToNull(sourceKind),
                emptyToNull(riskLevel),
                emptyToNull(decisionStatus),
                emptyToNull(keyword)
        );
    }

    public List<SecurityReviewVO> getSecurityReviews(String status, String severity, String reviewType, String keyword) {
        return loginRiskPolicyMapper.findSecurityReviews(emptyToNull(status), emptyToNull(severity), emptyToNull(reviewType), emptyToNull(keyword));
    }

    @Transactional
    public void createSecurityReviewFromAssessment(Long assessmentIdx, String severity, String summary, String detailMessage) {
        SecurityRiskAssessmentVO assessment = loginRiskPolicyMapper.findSecurityRiskAssessmentByIdx(assessmentIdx);
        if (assessment == null) {
            throw new IllegalArgumentException(msg("ko", "security.assessment.notFound"));
        }
        String reviewType = switch (assessment.getSubjectType() == null ? "" : assessment.getSubjectType()) {
            case "USER" -> "USER_SECURITY_REVIEW";
            case "IP", "IP_RANGE", "ASN", "COUNTRY" -> "ACCESS_ENVIRONMENT_REVIEW";
            case "CONTENT" -> "CONTENT_MODERATION_REVIEW";
            default -> "GENERAL_SECURITY_REVIEW";
        };
        loginRiskPolicyMapper.insertSecurityReviewFromAssessment(
                assessmentIdx,
                reviewType,
                firstNonBlank(severity, assessment.getRiskLevel(), "MEDIUM"),
                firstNonBlank(summary, assessment.getRecommendationAction(), msg("ko", "security.review.required.default")),
                firstNonBlank(detailMessage, assessment.getEvidenceSummary(), assessment.getRecommendationReason())
        );
        for (Long adminIdx : loginRiskPolicyMapper.findAdminNotificationTargets("BLOCK_REVIEW")) {
            loginRiskPolicyMapper.insertAdminNotification(adminIdx, "SECURITY_REVIEW", assessmentIdx,
                    msg("ko", "security.review.notification.prefix") + " " + firstNonBlank(summary, assessment.getSubjectKey(), msg("ko", "security.review.required.default")),
                    "/admin/login-risk/security-reviews");
        }
    }

    @Transactional
    public void decideSecurityReview(Long reviewIdx, String decision, Long actorUserIdx, String comment) {
        SecurityReviewVO review = loginRiskPolicyMapper.findSecurityReviewByIdx(reviewIdx);
        if (review == null) {
            throw new IllegalArgumentException(msg("ko", "security.review.notFound"));
        }
        String normalized = normalizeDecision(decision);
        loginRiskPolicyMapper.updateSecurityReviewDecision(reviewIdx, normalized, actorUserIdx, comment);
        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                "SECURITY_REVIEW_" + normalized,
                actorUserIdx,
                review.getSubjectType(),
                review.getSubjectKey(),
                "SECURITY_REVIEW_QUEUE",
                reviewIdx,
                "SECURITY.REVIEW." + normalized,
                jsonArg("reviewIdx", reviewIdx, "decision", normalized),
                firstNonBlank(comment, msg("ko", "security.review.audit.decision"))
        );

        if ("APPROVED".equals(normalized) && review.getAssessmentIdx() != null) {
            SecurityRiskAssessmentVO assessment = loginRiskPolicyMapper.findSecurityRiskAssessmentByIdx(review.getAssessmentIdx());
            if (assessment != null) {
                applyApprovedSecurityAssessment(assessment, actorUserIdx);
            }
        } else if ("REJECTED".equals(normalized) && review.getAssessmentIdx() != null) {
            loginRiskPolicyMapper.updateSecurityRiskAssessmentDecision(review.getAssessmentIdx(), "IGNORED");
        } else if ("HOLD".equals(normalized) && review.getAssessmentIdx() != null) {
            loginRiskPolicyMapper.updateSecurityRiskAssessmentDecision(review.getAssessmentIdx(), "PENDING");
        }
    }

    private void applyApprovedSecurityAssessment(SecurityRiskAssessmentVO assessment, Long actorUserIdx) {
        if ("USER".equals(assessment.getSubjectType())) {
            applyUserBlockFromSecurityAssessment(assessment.getAssessmentIdx(), actorUserIdx);
            return;
        }

        String subjectType = assessment.getSubjectType();
        String target = firstNonBlank(assessment.getSubjectKey(), assessment.getIpAddress());
        if (target == null || target.isBlank()) {
            loginRiskPolicyMapper.updateSecurityRiskAssessmentDecision(assessment.getAssessmentIdx(), "APPLIED");
            return;
        }

        boolean cidr = "IP_RANGE".equals(subjectType) || target.contains("/");
        boolean ipLike = "IP".equals(subjectType) || "IP_RANGE".equals(subjectType);
        if (ipLike) {
            String ipAddress = cidr && target.contains("/") ? target.substring(0, target.indexOf('/')) : target;
            String matchType = cidr ? "CIDR" : "SINGLE_IP";
            String blockTargetKey = cidr ? "CIDR:" + target : "IP:" + target;
            String requestId = UUID.randomUUID().toString();
            loginRiskPolicyMapper.insertApprovedIpBlock(
                    ipAddress,
                    blockTargetKey,
                    matchType,
                    cidr ? target : null,
                    firstNonBlank(assessment.getRecommendationReason(), assessment.getEvidenceSummary(), msg("ko", "security.review.approved.accessRestriction")),
                    actorUserIdx,
                    requestId,
                    "SECURITY_REVIEW_APPROVED",
                    firstNonBlank(assessment.getSourceType(), requestId) + ":" + assessment.getAssessmentIdx(),
                    assessment.getUserIdx(),
                    target
            );
            try {
                blockRuleCacheService.invalidateAndRefresh();
            } catch (Exception e) {
                log.warn("[SecurityReview] Failed to refresh block-rule cache after approval. assessmentIdx={}", assessment.getAssessmentIdx(), e);
            }
        }

        if ("IP".equals(subjectType) || "IP_RANGE".equals(subjectType) || "ASN".equals(subjectType) || "COUNTRY".equals(subjectType)) {
            loginRiskPolicyMapper.insertWafSyncQueue(
                    "SECURITY_RISK_ASSESSMENT",
                    assessment.getAssessmentIdx(),
                    "BLOCK",
                    "IP_RANGE".equals(subjectType) ? "CIDR" : subjectType,
                    target,
                    "PENDING",
                    msg("ko", "security.review.wafCandidate")
            );
        }

        loginRiskPolicyMapper.updateSecurityRiskAssessmentDecision(assessment.getAssessmentIdx(), "APPLIED");
    }

    public List<SecurityAppealVO> getSecurityAppeals(String status, String targetType, String keyword) {
        return loginRiskPolicyMapper.findSecurityAppeals(emptyToNull(status), emptyToNull(targetType), emptyToNull(keyword));
    }

    @Transactional
    public void decideSecurityAppeal(Long appealIdx, String decision, Long actorUserIdx, String comment) {
        String normalized = switch (decision == null ? "" : decision.toLowerCase(Locale.ROOT)) {
            case "accept", "accepted" -> "ACCEPTED";
            case "reject", "rejected" -> "REJECTED";
            case "hold" -> "HOLD";
            default -> "HOLD";
        };
        SecurityAppealVO appeal = loginRiskPolicyMapper.findSecurityAppealByIdx(appealIdx);
        loginRiskPolicyMapper.updateSecurityAppealDecision(appealIdx, normalized, actorUserIdx, comment);
        if ("ACCEPTED".equals(normalized) && appeal != null) {
            applyAcceptedSecurityAppeal(appeal, actorUserIdx, firstNonBlank(comment, msg("ko", "security.appeal.release.defaultReason")));
        }
        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                "SECURITY_APPEAL_" + normalized,
                actorUserIdx,
                appeal == null ? "APPEAL" : appeal.getTargetType(),
                appeal == null ? String.valueOf(appealIdx) : appeal.getTargetKey(),
                "SECURITY_ACTION_APPEAL",
                appealIdx,
                "SECURITY.APPEAL." + normalized,
                jsonArg("appealIdx", appealIdx, "decision", normalized),
                firstNonBlank(comment, msg("ko", "security.appeal.audit.decision"))
        );
        sendAppealDecisionNoticeIfPossible(appeal, normalized, comment);
    }

    private void sendAppealDecisionNoticeIfPossible(SecurityAppealVO appeal, String status, String comment) {
        if (appeal == null) {
            return;
        }
        String to = firstNonBlank(appeal.getSubmitterEmail(),
                appeal.getUserIdx() == null ? null : loginRiskPolicyMapper.findUserEmailByUserIdx(appeal.getUserIdx()));
        String lang = normalizeLang(appeal.getUserIdx() == null ? null : loginRiskPolicyMapper.findUserPreferredLangByUserIdx(appeal.getUserIdx()));
        if (shouldWriteAppealSiteNotification(appeal, status)) {
            loginRiskPolicyMapper.insertAdminNotification(
                    appeal.getUserIdx(),
                    "SECURITY_APPEAL",
                    appeal.getAppealIdx(),
                    msg(lang, "security.appeal.result.notification"),
                    "/mypage"
            );
        }
        if (to == null || to.isBlank()) {
            return;
        }
        String subject = msg(lang, "security.appeal.result.mail.subject");
        String body = """
                <div style="font-family:Arial,'Noto Sans KR',sans-serif;line-height:1.7;color:#111827">
                  <h2>%s</h2>
                  <p>%s</p>
                  <div style="padding:14px;border-radius:12px;background:#f1f5f9">
                    <strong>%s</strong>: %s<br>
                    <strong>%s</strong>: %s<br>
                    <strong>%s</strong>: %s
                  </div>
                </div>
                """.formatted(
                msg(lang, "security.appeal.result.mail.title"),
                msg(lang, "security.appeal.result.mail.body"),
                msg(lang, "security.appeal.result.mail.publicRequestId"), firstNonBlank(appeal.getPublicRequestId(), "-"),
                msg(lang, "security.appeal.result.mail.status"), status,
                msg(lang, "security.appeal.result.mail.comment"), firstNonBlank(comment, "-")
        );
        sendMail(to, subject, body);
    }


    private void applyAcceptedSecurityAppeal(SecurityAppealVO appeal, Long actorUserIdx, String reason) {
        if (appeal.getTargetType() == null || appeal.getTargetKey() == null) {
            return;
        }
        if (appeal.getTargetType().contains("USER")) {
            loginRiskPolicyMapper.insertUserBlockReleaseHistoryFromAppeal(appeal.getTargetKey(), actorUserIdx, reason, appeal.getAppealIdx());
            loginRiskPolicyMapper.releaseUserBlockByTargetKey(appeal.getTargetKey(), actorUserIdx, reason);
            loginRiskPolicyMapper.restoreUserStatusByTargetKey(appeal.getTargetKey(), reason);
        } else if (appeal.getTargetType().contains("IP")) {
            loginRiskPolicyMapper.releaseIpBlockByTargetKey(appeal.getTargetKey(), actorUserIdx, reason);
            try {
                blockRuleCacheService.invalidateAndRefresh();
            } catch (Exception e) {
                log.warn("[SecurityAppeal] Failed to refresh block-rule cache after accepted appeal. appealIdx={}", appeal.getAppealIdx(), e);
            }
        }

        if (appeal.getSourceAssessmentIdx() != null) {
            loginRiskPolicyMapper.updateSecurityRiskAssessmentDecision(appeal.getSourceAssessmentIdx(), "REVERSED");
        }
    }


    public List<SecurityWafSyncQueueVO> getWafSyncQueue(String status, String targetType, String keyword) {
        return loginRiskPolicyMapper.findWafSyncQueue(emptyToNull(status), emptyToNull(targetType), emptyToNull(keyword));
    }

    @Transactional
    public void retryWafSync(Long syncIdx, Long actorUserIdx) {
        loginRiskPolicyMapper.resetWafSyncStatus(syncIdx, msg("ko", "security.waf.sync.retryRequested"));
        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                "WAF_SYNC_RETRY_REQUESTED",
                actorUserIdx,
                "WAF_SYNC",
                String.valueOf(syncIdx),
                "LOGIN_RISK_WAF_SYNC_QUEUE",
                syncIdx,
                "SECURITY.WAF_SYNC.RETRY_REQUESTED",
                "{\"syncIdx\":" + syncIdx + "}",
                msg("ko", "security.waf.sync.retryRequested")
        );
    }

    public List<SecurityAssessmentProviderConfigVO> getProviderConfigs() {
        return loginRiskPolicyMapper.findProviderConfigs();
    }

    @Transactional
    public void updateProviderConfig(SecurityAssessmentProviderConfigVO config) {
        loginRiskPolicyMapper.updateProviderConfig(config);
        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                "PROVIDER_CONFIG_UPDATE",
                null,
                "PROVIDER",
                config.getProviderCode(),
                "SECURITY_ASSESSMENT_PROVIDER_CONFIG",
                config.getProviderIdx(),
                "SECURITY.PROVIDER.CONFIG_UPDATE",
                jsonArg("providerIdx", config.getProviderIdx(), "enabled", config.isEnabled()),
                "enabled=" + config.isEnabled() + ", endpoint=" + config.getEndpointUrl()
        );
    }


    @Scheduled(fixedDelayString = "${security.provider.healthcheck.fixed-delay-ms:300000}")
    @Transactional
    public void runProviderHealthCheckOnce() {
        List<SecurityAssessmentProviderConfigVO> providers = loginRiskPolicyMapper.findProviderConfigsForHealthCheck();
        for (SecurityAssessmentProviderConfigVO provider : providers) {
            ProviderHealth health = evaluateProviderHealth(provider);
            loginRiskPolicyMapper.updateProviderHealth(provider.getProviderIdx(), health.status(), health.description());
        }
    }

    @Transactional
    public void checkProviderHealth(Long providerIdx, Long actorUserIdx) {
        SecurityAssessmentProviderConfigVO provider = loginRiskPolicyMapper.findProviderConfigs().stream()
                .filter(p -> providerIdx != null && providerIdx.equals(p.getProviderIdx()))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException(msg("ko", "security.provider.notFound")));

        ProviderHealth health = evaluateProviderHealth(provider);
        loginRiskPolicyMapper.updateProviderHealth(provider.getProviderIdx(), health.status(), health.description());
        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                "PROVIDER_HEALTH_CHECK",
                actorUserIdx,
                "PROVIDER",
                provider.getProviderCode(),
                "SECURITY_ASSESSMENT_PROVIDER_CONFIG",
                provider.getProviderIdx(),
                "SECURITY.PROVIDER.HEALTH_CHECK",
                jsonArg("providerIdx", provider.getProviderIdx(), "status", health.status()),
                health.description()
        );
    }

    private ProviderHealth evaluateProviderHealth(SecurityAssessmentProviderConfigVO provider) {
        if (!provider.isEnabled()) {
            return new ProviderHealth("DISABLED", msg("ko", "security.provider.health.disabled"));
        }
        if (provider.getEndpointUrl() == null || provider.getEndpointUrl().isBlank()) {
            return new ProviderHealth("READY", msg("ko", "security.provider.health.readyNoEndpoint"));
        }
        return new ProviderHealth("READY", msg("ko", "security.provider.health.readyExternalPending"));
    }

    private record ProviderHealth(String status, String description) {
    }

    @Scheduled(fixedDelayString = "${security.waf.sync.fixed-delay-ms:300000}")
    @Transactional
    public void processWafSyncQueueOnce() {
        List<SecurityWafSyncQueueVO> pendingItems = loginRiskPolicyMapper.findPendingWafSyncQueue(20);
        for (SecurityWafSyncQueueVO item : pendingItems) {
            WafSyncResult result = applyWafSyncProviders(item);
            loginRiskPolicyMapper.updateWafSyncStatus(
                    item.getSyncIdx(),
                    result.getStatus(),
                    result.getMessage()
            );
        }
    }

    private WafSyncResult applyWafSyncProviders(SecurityWafSyncQueueVO item) {
        if (wafSyncProviders == null || wafSyncProviders.isEmpty()) {
            return WafSyncResult.builder()
                    .handled(false)
                    .success(false)
                    .status("EXTERNAL_PROVIDER_PENDING")
                    .message(msg("ko", "security.waf.sync.providerPending"))
                    .build();
        }
        for (WafSyncProvider provider : wafSyncProviders) {
            try {
                if (provider.supports(item)) {
                    return provider.sync(item);
                }
            } catch (Exception e) {
                log.warn("[WAF] sync provider execution failed syncIdx={} provider={}",
                        item.getSyncIdx(), provider.getClass().getName(), e);
                return WafSyncResult.builder()
                        .handled(true)
                        .success(false)
                        .status("FAILED")
                        .message(e.getMessage())
                        .build();
            }
        }
        return WafSyncResult.builder()
                .handled(false)
                .success(false)
                .status("EXTERNAL_PROVIDER_PENDING")
                .message(msg("ko", "security.waf.sync.providerPending"))
                .build();
    }

    @Transactional
    public void applyUserBlockFromSecurityAssessment(Long assessmentIdx, Long actorUserIdx) {
        SecurityRiskAssessmentVO assessment = loginRiskPolicyMapper.findSecurityRiskAssessmentByIdx(assessmentIdx);
        if (assessment == null) {
            throw new IllegalArgumentException(msg("ko", "security.assessment.notFound"));
        }
        if (assessment.getUserIdx() == null) {
            throw new IllegalArgumentException(msg("ko", "security.assessment.userBlockNotApplicable"));
        }

        Long systemUserIdx = loginRiskPolicyMapper.findSystemUserIdxByUserId("system_ai_security");
        Long blockedBy = actorUserIdx != null ? actorUserIdx : systemUserIdx;
        if (blockedBy == null) {
            blockedBy = loginRiskPolicyMapper.findSystemUserIdxByUserId("system_policy_engine");
        }

        String blockRequestId = UUID.randomUUID().toString();
        String actionGroupId = UUID.randomUUID().toString();
        String targetKey = "USER:" + assessment.getUserIdx();
        String reason = firstNonBlank(
                assessment.getRecommendationReason(),
                assessment.getEvidenceSummary(),
                msg("ko", "security.assessment.userBlock.defaultReason")
        );

        loginRiskPolicyMapper.insertUserBlockHistoryFromAssessment(
                assessmentIdx,
                blockRequestId,
                targetKey,
                assessment.getUserIdx(),
                reason,
                blockedBy,
                actionGroupId
        );
        Long historyIdx = loginRiskPolicyMapper.findBlockHistoryIdxByRequestId(blockRequestId);
        loginRiskPolicyMapper.upsertUserBlocklistFromAssessment(
                historyIdx,
                assessmentIdx,
                blockRequestId,
                targetKey,
                assessment.getUserIdx(),
                reason,
                blockedBy,
                actionGroupId
        );
        adminMapper.markMemberBlocked(assessment.getUserIdx(), null, reason);
        loginRiskPolicyMapper.updateSecurityRiskAssessmentDecision(assessmentIdx, "APPLIED");
        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                "ASSESSMENT_USER_BLOCK_APPLIED",
                actorUserIdx,
                "USER",
                assessment.getSubjectKey(),
                "SECURITY_RISK_ASSESSMENT",
                assessmentIdx,
                "SECURITY.ASSESSMENT.USER_BLOCK_APPLIED",
                jsonArg("assessmentIdx", assessmentIdx, "targetKey", targetKey),
                firstNonBlank(reason, msg("ko", "security.assessment.audit.userBlockApplied"))
        );
    }


    public SecurityAppealFormVO getPublicAppealForm(String token, String requestId, String lang) {
        if (token != null && !token.isBlank()) {
            SecurityAppealTokenVO tokenVO = loginRiskPolicyMapper.findAppealToken(token, LocalDateTime.now());
            if (tokenVO == null) {
                return SecurityAppealFormVO.builder()
                        .valid(false)
                        .errorMessage(msg(lang, "security.appeal.error.tokenInvalid"))
                        .pageLang(normalizeLang(lang))
                        .build();
            }
            return SecurityAppealFormVO.builder()
                    .valid(true)
                    .token(token)
                    .targetType(tokenVO.getTargetType())
                    .targetKey(tokenVO.getTargetKey())
                    .userIdx(tokenVO.getUserIdx())
                    .sourceAssessmentIdx(tokenVO.getSourceAssessmentIdx())
                    .requestId(tokenVO.getBlockAccessRequestId())
                    .submitterEmail(tokenVO.getSubmitterEmail())
                    .emailVerified(tokenVO.getSubmitterEmail() != null && !tokenVO.getSubmitterEmail().isBlank())
                    .pageLang(normalizeLang(lang))
                    .build();
        }

        if (requestId != null && !requestId.isBlank()) {
            SecurityAppealFormVO context = loginRiskPolicyMapper.findBlockAccessAppealContext(requestId);
            if (context == null) {
                return SecurityAppealFormVO.builder()
                        .valid(false)
                        .errorMessage(msg(lang, "security.appeal.error.requestNotFound"))
                        .requestId(requestId)
                        .pageLang(normalizeLang(lang))
                        .build();
            }
            context.setValid(true);
            context.setPageLang(normalizeLang(lang));
            return context;
        }

        return SecurityAppealFormVO.builder()
                .valid(false)
                .errorMessage(msg(lang, "security.appeal.error.targetMissing"))
                .pageLang(normalizeLang(lang))
                .build();
    }


    @Transactional
    public void requestPublicAppealEmailVerification(String requestId,
                                                     String submitterEmail,
                                                     String pageLang) {
        String lang = normalizeLang(pageLang);
        if (requestId == null || requestId.isBlank()) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.error.targetMissing"));
        }
        if (!isValidEmail(submitterEmail)) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.error.emailInvalid"));
        }

        SecurityAppealFormVO context = getPublicAppealForm(null, requestId, lang);
        if (!context.isValid()) {
            throw new IllegalArgumentException(context.getErrorMessage());
        }

        String token = createAppealToken(
                context.getUserIdx(),
                context.getTargetType(),
                context.getTargetKey(),
                context.getSourceAssessmentIdx(),
                null,
                firstNonBlank(context.getRequestId(), requestId),
                submitterEmail,
                LocalDateTime.now().plusMinutes(30)
        );
        String appealUrl = publicBaseUrl + "/security/appeal?token=" + token + "&lang=" + lang;
        String subject = msg(lang, "security.appeal.verify.mail.subject");
        String body = """
                <div style="font-family:Arial,'Noto Sans KR',sans-serif;line-height:1.7;color:#111827">
                  <h2>%s</h2>
                  <p>%s</p>
                  <div style="padding:14px;border-radius:12px;background:#f1f5f9">
                    <strong>%s</strong>: %s
                  </div>
                  <p><a href="%s" style="display:inline-block;padding:12px 18px;border-radius:10px;background:#2563eb;color:#fff;text-decoration:none;font-weight:700">%s</a></p>
                  <p style="font-size:12px;color:#64748b">%s</p>
                </div>
                """.formatted(
                msg(lang, "security.appeal.verify.mail.title"),
                msg(lang, "security.appeal.verify.mail.body"),
                msg(lang, "security.appeal.form.requestId"), requestId,
                appealUrl,
                msg(lang, "security.appeal.verify.mail.cta"),
                msg(lang, "security.appeal.verify.mail.notice")
        );
        boolean sent = sendMail(submitterEmail, subject, body);
        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                sent ? "SECURITY_APPEAL_VERIFICATION_SENT" : "SECURITY_APPEAL_VERIFICATION_FAILED",
                context.getUserIdx(),
                context.getTargetType(),
                context.getTargetKey(),
                "SECURITY_ACTION_APPEAL_TOKEN",
                null,
                sent ? "SECURITY.APPEAL.VERIFICATION_SENT" : "SECURITY.APPEAL.VERIFICATION_FAILED",
                jsonArg("requestId", requestId, "email", maskEmail(submitterEmail)),
                sent ? msg(lang, "security.appeal.verify.audit.sent") : msg(lang, "security.appeal.verify.audit.failed")
        );
        if (!sent) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.error.mailSendFailed"));
        }
    }

    @Transactional
    public String submitPublicSecurityAppeal(String token,
                                             String requestId,
                                             String appealTitle,
                                             String appealContent,
                                             String submitterEmail,
                                             String pageLang) {
        String lang = normalizeLang(pageLang);
        if (token == null || token.isBlank()) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.error.emailVerificationRequired"));
        }

        SecurityAppealFormVO context = getPublicAppealForm(token, requestId, lang);
        if (!context.isValid()) {
            throw new IllegalArgumentException(context.getErrorMessage());
        }

        SecurityAppealTokenVO tokenVO = loginRiskPolicyMapper.findAppealToken(token, LocalDateTime.now());
        if (tokenVO == null) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.error.tokenInvalid"));
        }
        submitterEmail = firstNonBlank(tokenVO.getSubmitterEmail(), submitterEmail);
        if (!isValidEmail(submitterEmail)) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.error.emailVerificationRequired"));
        }

        Integer duplicateCount = loginRiskPolicyMapper.countDuplicatePendingAppeal(
                context.getTargetType(),
                context.getTargetKey(),
                firstNonBlank(context.getRequestId(), requestId)
        );
        if (duplicateCount != null && duplicateCount > 0) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.error.duplicatePending"));
        }

        AppealPolicyConfig appealPolicy = getAppealPolicyConfig();
        if (appealPolicy.enabled()) {
            Integer recentRejectedCount = loginRiskPolicyMapper.countRejectedAppealAfter(
                    context.getTargetType(),
                    context.getTargetKey(),
                    firstNonBlank(context.getRequestId(), requestId),
                    LocalDateTime.now().minusMinutes(appealPolicy.rejectedCooldownMinutes())
            );
            if (recentRejectedCount != null && recentRejectedCount > 0) {
                throw new IllegalArgumentException(msg(lang, "security.appeal.error.rejectedCooldown"));
            }

            Integer totalRejectedCount = loginRiskPolicyMapper.countRejectedAppeals(
                    context.getTargetType(),
                    context.getTargetKey(),
                    firstNonBlank(context.getRequestId(), requestId)
            );
            if (totalRejectedCount != null && totalRejectedCount >= appealPolicy.maxRejectedCount()) {
                throw new IllegalArgumentException(msg(lang, "security.appeal.error.permanentlyClosed"));
            }

            if (context.getTargetKey() != null && context.getTargetKey().startsWith("IP:")) {
                Integer todayIpAppealCount = loginRiskPolicyMapper.countIpTargetAppealsToday(
                        context.getTargetKey(),
                        LocalDateTime.now().toLocalDate().atStartOfDay()
                );
                if (todayIpAppealCount != null && todayIpAppealCount >= appealPolicy.ipDailyLimit()) {
                    throw new IllegalArgumentException(msg(lang, "security.appeal.error.ipDailyLimit"));
                }
            }
        }

        String publicRequestId = "SAP-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase(Locale.ROOT);
        Long inquiryId = null;
        String title = firstNonBlank(appealTitle, msg(lang, "security.appeal.form.defaultTitle"));
        String content = firstNonBlank(appealContent, "");
        String enrichedContent = """
                %s
                %s: %s
                %s: %s
                %s: %s
                %s: %s
                %s: %s
                %s: %s

                %s
                """.formatted(
                msg(lang, "security.appeal.inquiry.header"),
                msg(lang, "security.appeal.inquiry.publicRequestId"), publicRequestId,
                msg(lang, "security.appeal.inquiry.targetType"), context.getTargetType(),
                msg(lang, "security.appeal.inquiry.targetKey"), context.getTargetKey(),
                msg(lang, "security.appeal.inquiry.blockRequestId"), tokenVO == null ? null : tokenVO.getBlockRequestId(),
                msg(lang, "security.appeal.inquiry.blockAccessRequestId"), firstNonBlank(context.getRequestId(), requestId),
                msg(lang, "security.appeal.inquiry.contactEmail"), firstNonBlank(submitterEmail, "-"),
                content
        );

        if (context.getUserIdx() != null) {
            loginRiskPolicyMapper.insertSecurityAppealInquiry(context.getUserIdx(), msg(lang, "security.appeal.inquiry.titlePrefix") + " " + title, enrichedContent);
            inquiryId = loginRiskPolicyMapper.findLatestInquiryIdByUserAndTitle(context.getUserIdx(), msg(lang, "security.appeal.inquiry.titlePrefix") + " " + title);
        }

        loginRiskPolicyMapper.insertSecurityAppealPublic(
                context.getUserIdx(),
                context.getTargetType(),
                context.getTargetKey(),
                context.getSourceAssessmentIdx(),
                tokenVO == null ? null : tokenVO.getTokenIdx(),
                tokenVO == null ? null : tokenVO.getBlockRequestId(),
                firstNonBlank(context.getRequestId(), requestId),
                inquiryId,
                submitterEmail,
                publicRequestId,
                title,
                enrichedContent
        );

        if (tokenVO != null) {
            loginRiskPolicyMapper.markAppealTokenUsed(tokenVO.getTokenIdx());
        }

        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                "SECURITY_APPEAL_SUBMITTED",
                context.getUserIdx(),
                context.getTargetType(),
                context.getTargetKey(),
                "SECURITY_ACTION_APPEAL",
                null,
                "SECURITY.APPEAL.SUBMITTED",
                jsonArg("publicRequestId", publicRequestId, "requestId", firstNonBlank(context.getRequestId(), requestId)),
                msg(lang, "security.appeal.audit.submitted")
        );

        for (Long adminIdx : loginRiskPolicyMapper.findAdminNotificationTargets("BLOCK_REVIEW")) {
            loginRiskPolicyMapper.insertAdminNotification(adminIdx, "SECURITY_APPEAL", null,
                    msg(lang, "security.appeal.inquiry.titlePrefix") + " " + title,
                    "/admin/login-risk/appeals");
        }

        return publicRequestId;
    }



    private boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    private String maskEmail(String email) {
        if (email == null || email.isBlank() || !email.contains("@")) {
            return "";
        }
        String[] parts = email.split("@", 2);
        String name = parts[0];
        String maskedName = name.length() <= 2 ? name.charAt(0) + "*" : name.substring(0, 2) + "***";
        return maskedName + "@" + parts[1];
    }

    private AppealPolicyConfig getAppealPolicyConfig() {
        LoginRiskPolicyVO policy = loginRiskPolicyMapper.findPolicyByCode("SECURITY_APPEAL_COOLDOWN");
        if (policy == null) {
            return new AppealPolicyConfig(true, 10080, 2, 3);
        }
        return new AppealPolicyConfig(
                policy.isActive(),
                positiveOrDefault(policy.getObservationMinutes(), 10080),
                positiveOrDefault(policy.getThresholdCount(), 2),
                positiveOrDefault(policy.getDistinctAccountThreshold(), 3)
        );
    }

    private int positiveOrDefault(Integer value, int fallback) {
        return value != null && value > 0 ? value : fallback;
    }

    private boolean shouldWriteAppealSiteNotification(SecurityAppealVO appeal, String status) {
        if (appeal == null || appeal.getUserIdx() == null) {
            return false;
        }
        if ("ACCEPTED".equals(status)) {
            return true;
        }
        String accountStatus = loginRiskPolicyMapper.findUserAccountStatusByUserIdx(appeal.getUserIdx());
        return "ACTIVE".equalsIgnoreCase(accountStatus);
    }

    private record AppealPolicyConfig(boolean enabled,
                                      int rejectedCooldownMinutes,
                                      int maxRejectedCount,
                                      int ipDailyLimit) {
    }

    private String createAppealToken(Long userIdx,
                                     String targetType,
                                     String targetKey,
                                     Long sourceAssessmentIdx,
                                     String blockRequestId,
                                     String blockAccessRequestId) {
        return createAppealToken(userIdx, targetType, targetKey, sourceAssessmentIdx, blockRequestId,
                blockAccessRequestId, null, LocalDateTime.now().plusDays(7));
    }

    private String createAppealToken(Long userIdx,
                                     String targetType,
                                     String targetKey,
                                     Long sourceAssessmentIdx,
                                     String blockRequestId,
                                     String blockAccessRequestId,
                                     String submitterEmail,
                                     LocalDateTime expiresAt) {
        String token = UUID.randomUUID().toString().replace("-", "") + UUID.randomUUID().toString().replace("-", "");
        loginRiskPolicyMapper.insertSecurityAppealToken(
                token,
                userIdx,
                targetType,
                targetKey,
                sourceAssessmentIdx,
                blockRequestId,
                blockAccessRequestId,
                submitterEmail,
                expiresAt
        );
        return token;
    }


    public SecurityAppealVO findPublicAppealResult(String publicRequestId,
                                                   String submitterEmail,
                                                   String pageLang) {
        String lang = normalizeLang(pageLang);
        if (publicRequestId == null || publicRequestId.isBlank()) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.result.error.requestRequired"));
        }
        if (!isValidEmail(submitterEmail)) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.error.emailInvalid"));
        }
        SecurityAppealVO appeal = loginRiskPolicyMapper.findSecurityAppealByPublicRequestId(publicRequestId);
        if (appeal == null) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.result.error.notFound"));
        }
        String storedEmail = firstNonBlank(appeal.getSubmitterEmail(),
                appeal.getUserIdx() == null ? null : loginRiskPolicyMapper.findUserEmailByUserIdx(appeal.getUserIdx()));
        if (storedEmail == null || !storedEmail.equalsIgnoreCase(submitterEmail.trim())) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.result.error.notFound"));
        }
        return appeal;
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
            throw new IllegalArgumentException(msg("ko", "security.login.review.notFound"));
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
                msg("ko", "security.login.audit.adminReviewDecision") + ": " + normalized + (comment == null || comment.isBlank() ? "" : " / " + comment)
        );
    }

    private void applyApprovedReview(LoginRiskReviewVO review, Long adminUserIdx, String comment) {
        if (review.getReviewType() != null && review.getReviewType().contains("ACCOUNT") && review.getUserIdx() != null) {
            adminMapper.markMemberBlocked(review.getUserIdx(), null, msg("ko", "security.login.accountReviewApprovedReason"));
        }

        if ("IP".equalsIgnoreCase(review.getSubjectType()) || "IP_RANGE".equalsIgnoreCase(review.getSubjectType())) {
            String target = firstNonBlank(review.getSubjectKey(), review.getIpAddress());
            if (target != null && !target.isBlank()) {
                boolean cidr = target.contains("/");
                String matchType = cidr ? "CIDR" : "SINGLE_IP";
                String ipAddress = cidr ? target.substring(0, target.indexOf('/')) : target;
                String blockTargetKey = cidr ? "CIDR:" + target : "IP:" + target;
                String blockRequestId = UUID.randomUUID().toString();
                String reason = msg("ko", "security.login.ipReviewApprovedReason");
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
                        msg("ko", "security.login.ipReviewWafCandidate")
                );

                try {
                    blockRuleCacheService.invalidateAndRefresh();
                } catch (Exception e) {
                    log.warn("[LoginRisk] Failed to refresh block-rule cache. reviewIdx={}", review.getReviewIdx(), e);
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
                String message = msg(user == null ? null : user.getPreferredLang(), "security.login.ipLockMessage");
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
            String reason = msg(user.getPreferredLang(), "security.login.accountTempLockReason");
            adminMapper.markMemberBlocked(user.getUserIdx(), blockedUntil, reason);
            loginRiskPolicyMapper.insertRiskEvent(policy.getPolicyCode(), "THRESHOLD_REACHED", "USER", String.valueOf(user.getUserIdx()),
                    user.getUserIdx(), context.getIpAddress(), identifier, threshold, observed, "ACCOUNT_TEMP_LOCK", "AUTO_APPLIED",
                    false, blockedUntil, context.getRequestId(), context.getFlowTraceId(), reason);
            maybeProtectAccount(user, identifier, context);
            String message = msg(user.getPreferredLang(), "security.login.accountTempLockMessage");
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
            String reason = msg(user.getPreferredLang(), "security.login.repeatProtectionReason");
            adminMapper.markMemberBlocked(user.getUserIdx(), null, reason);
            loginRiskPolicyMapper.insertRiskEvent(policy.getPolicyCode(), "PROTECTION_REQUIRED", "USER", String.valueOf(user.getUserIdx()),
                    user.getUserIdx(), context.getIpAddress(), identifier, threshold, lockCount, "ACCOUNT_PROTECTION_REQUIRED", "AUTO_APPLIED",
                    true, null, context.getRequestId(), context.getFlowTraceId(), reason);
            createAdminReview(policy, "ACCOUNT_PROTECTION", "USER", String.valueOf(user.getUserIdx()), user.getUserIdx(), context.getIpAddress(), context,
                    msg(user.getPreferredLang(), "security.login.protectionReviewSummary"), reason);
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
        String reason = msg(user == null ? null : user.getPreferredLang(), "security.login.ipLockReason");
        loginRiskPolicyMapper.insertIpLoginLockCounter(policy.getPolicyCode(), ip, blockedUntil, reason);
        loginRiskPolicyMapper.insertRiskEvent(policy.getPolicyCode(), "THRESHOLD_REACHED", "IP", ip,
                user == null ? null : user.getUserIdx(), ip, identifier, threshold, failures, "IP_LOGIN_LOCK", "AUTO_APPLIED",
                false, blockedUntil, context.getRequestId(), context.getFlowTraceId(), reason);
        String message = msg(user == null ? null : user.getPreferredLang(), "security.login.ipLockMessage");
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
        String summary = msg(user == null ? null : user.getPreferredLang(), "security.login.ipReviewSummary");
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
                    log.warn("[LoginRisk] Failed to run external risk assessment provider. provider={}", provider.getClass().getName(), e);
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
                    msg("ko", "security.assessment.provider.pendingReason"),
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
                    msg(user == null ? null : user.getPreferredLang(), "security.mail.protection.skipped"));
            return;
        }

        String lang = normalizeLang(user.getPreferredLang());
        String subject = protectionMailSubject(lang);
        String token = createAppealToken(user.getUserIdx(), "USER_BLOCK", "USER:" + user.getUserIdx(), null, null,
                context == null ? null : context.getRequestId(), user.getUserEmail(), LocalDateTime.now().plusDays(7));
        String appealUrl = publicBaseUrl + "/security/appeal?token=" + token + "&lang=" + lang;
        String html = protectionMailHtml(lang, user.getNickname(), reason, appealUrl);
        boolean sent = sendMail(user.getUserEmail(), subject, html);
        loginRiskPolicyMapper.insertRiskEvent(ACCOUNT_REPEAT_POLICY, sent ? "PROTECTION_MAIL_SENT" : "PROTECTION_MAIL_FAILED",
                "USER", String.valueOf(user.getUserIdx()), user.getUserIdx(),
                context == null ? null : context.getIpAddress(),
                null, null, null, "NOTIFY_USER", sent ? "MAIL_SENT" : "MAIL_FAILED", false,
                null,
                context == null ? null : context.getRequestId(),
                context == null ? null : context.getFlowTraceId(),
                sent ? msg(user.getPreferredLang(), "security.mail.protection.sent") : msg(user.getPreferredLang(), "security.mail.protection.failed"));
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
            log.warn("[LoginRisk] Failed to send account protection notice email. to={}", to, e);
            return false;
        }
    }

    private String protectionMailSubject(String lang) {
        return msg(lang, "security.mail.protection.subject");
    }

    private String protectionMailHtml(String lang, String nickname, String reason, String appealUrl) {
        String safeName = nickname == null || nickname.isBlank() ? "TripTogether user" : nickname;
        String title = msg(lang, "security.mail.protection.title");
        String body = msg(lang, "security.mail.protection.body");
        String guide = msg(lang, "security.mail.protection.guide");
        String userLabel = msg(lang, "security.mail.protection.user");
        String reasonLabel = msg(lang, "security.mail.protection.reason");
        String appealButton = msg(lang, "security.mail.protection.appealButton");
        return """
                <!DOCTYPE html>
                <html><body style="font-family:Arial,'Noto Sans KR',sans-serif;background:#f8fafc;padding:32px">
                <div style="max-width:560px;margin:0 auto;background:white;border-radius:16px;padding:28px;border:1px solid #e5e7eb">
                    <h2 style="margin:0 0 16px;color:#111827">%s</h2>
                    <p style="line-height:1.7;color:#374151">%s</p>
                    <p style="line-height:1.7;color:#374151">%s</p>
                    <div style="margin-top:20px;padding:16px;border-radius:12px;background:#eff6ff;color:#1e3a8a">
                        <strong>%s</strong>: %s<br>
                        <strong>%s</strong>: %s
                    </div>
                    <p style="margin-top:20px">
                        <a href="%s" style="display:inline-block;background:#2563eb;color:white;text-decoration:none;padding:12px 18px;border-radius:10px;font-weight:700">
                            %s
                        </a>
                    </p>
                </div>
                </body></html>
                """.formatted(title, body, guide, userLabel, safeName, reasonLabel, reason == null ? "-" : reason, appealUrl, appealButton);
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
        return msg(preferredLang, "security.login.remainingAttempts", remaining);
    }

    private String msg(String lang, String code, Object... args) {
        Locale locale = Locale.forLanguageTag(normalizeLang(lang));
        return messageSource.getMessage(code, args, locale);
    }

    private String normalizeLang(String preferredLang) {
        if (preferredLang == null || preferredLang.isBlank()) return "ko";
        String lang = preferredLang.toLowerCase(Locale.ROOT);
        if (lang.startsWith("en")) return "en";
        if (lang.startsWith("ja")) return "ja";
        if (lang.startsWith("zh")) return "zh";
        return "ko";
    }

    private String jsonArg(String firstKey, Object firstValue, String secondKey, Object secondValue) {
        return "{\"%s\":\"%s\",\"%s\":\"%s\"}".formatted(
                firstKey,
                firstValue == null ? "" : String.valueOf(firstValue).replace("\"", "\\\""),
                secondKey,
                secondValue == null ? "" : String.valueOf(secondValue).replace("\"", "\\\"")
        );
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
