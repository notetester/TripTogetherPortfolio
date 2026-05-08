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
import org.triptogether.auth.vo.ProviderHealthCheckHistoryVO;
import org.triptogether.auth.vo.SecurityReviewVO;
import org.triptogether.auth.vo.SecurityWafSyncQueueVO;
import org.triptogether.auth.vo.SecurityAppealVO;
import org.triptogether.auth.vo.SecurityAppealFormVO;
import org.triptogether.auth.vo.SecurityAppealTokenVO;
import org.triptogether.auth.vo.SecurityAppealPolicyVO;
import org.triptogether.auth.vo.SecurityAppealPolicyHistoryVO;
import org.triptogether.auth.vo.LoginRiskExternalAssessmentVO;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.config.BlockRuleCacheService;
import org.triptogether.config.RuntimeSettingService;
import org.triptogether.auth.risk.LoginRiskAssessmentProvider;
import org.triptogether.auth.risk.LoginRiskAssessmentRequest;
import org.triptogether.auth.risk.LoginRiskAssessmentResult;
import org.triptogether.auth.risk.WafSyncProvider;
import org.triptogether.auth.risk.WafSyncResult;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
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
    private final RuntimeSettingService runtimeSettingService;
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
        updatePolicy(policy, null);
    }

    @Transactional
    public void updatePolicy(LoginRiskPolicyVO policy, Long actorUserIdx) {
        LoginRiskPolicyVO before = loginRiskPolicyMapper.findPolicyByIdx(policy.getPolicyIdx());
        if (before == null) {
            loginRiskPolicyMapper.updatePolicy(policy);
            return;
        }
        policy.setPolicyCode(before.getPolicyCode());
        String beforeSnapshot = toLoginRiskPolicySnapshot(before);
        loginRiskPolicyMapper.updatePolicy(policy);
        LoginRiskPolicyVO after = loginRiskPolicyMapper.findPolicyByIdx(policy.getPolicyIdx());
        loginRiskPolicyMapper.insertLoginRiskPolicyHistory(
                before.getPolicyIdx(),
                before.getPolicyCode(),
                "UPDATE",
                actorUserIdx,
                beforeSnapshot,
                toLoginRiskPolicySnapshot(after == null ? policy : after)
        );
    }


    public SecurityAppealPolicyVO getSecurityAppealPolicy() {
        SecurityAppealPolicyVO policy = loginRiskPolicyMapper.findSecurityAppealPolicy();
        return policy == null ? defaultSecurityAppealPolicy() : policy;
    }

    public List<SecurityAppealPolicyHistoryVO> getSecurityAppealPolicyHistories(int limit) {
        int safeLimit = Math.max(1, Math.min(limit, 50));
        return loginRiskPolicyMapper.findSecurityAppealPolicyHistory(safeLimit);
    }

    @Transactional
    public void updateSecurityAppealPolicy(SecurityAppealPolicyVO policy) {
        updateSecurityAppealPolicy(policy, null);
    }

    @Transactional
    public void updateSecurityAppealPolicy(SecurityAppealPolicyVO policy, Long actorUserIdx) {
        SecurityAppealPolicyVO current = loginRiskPolicyMapper.findSecurityAppealPolicy();
        if (current == null) {
            throw new IllegalArgumentException(msg("ko", "security.appeal.policy.notFound"));
        }
        policy.setPolicyIdx(current.getPolicyIdx());
        policy.setPolicyCode(current.getPolicyCode());
        policy.setMaxOpenAppealsPerCase(positiveOrDefault(policy.getMaxOpenAppealsPerCase(), 1));
        policy.setRejectedCooldownMinutes(nonNegativeOrDefault(policy.getRejectedCooldownMinutes(), 10080));
        policy.setMaxRejectedCount(positiveOrDefault(policy.getMaxRejectedCount(), 2));
        policy.setIpDailyAppealLimit(positiveOrDefault(policy.getIpDailyAppealLimit(), 3));
        policy.setVerificationWindowMinutes(positiveOrDefault(policy.getVerificationWindowMinutes(), 60));
        policy.setMaxVerificationEmails(positiveOrDefault(policy.getMaxVerificationEmails(), 3));
        policy.setVerificationTokenTtlMinutes(positiveOrDefault(policy.getVerificationTokenTtlMinutes(), 30));
        policy.setProtectedAppealTokenTtlDays(positiveOrDefault(policy.getProtectedAppealTokenTtlDays(), 7));
        policy.setResultLookupWindowMinutes(positiveOrDefault(policy.getResultLookupWindowMinutes(), 60));
        policy.setMaxResultLookupFailures(positiveOrDefault(policy.getMaxResultLookupFailures(), 5));
        policy.setResultLookupRetentionDays(nonNegativeOrDefault(policy.getResultLookupRetentionDays(), 365));
        policy.setAllowedEmailDomains(emptyToNull(policy.getAllowedEmailDomains()));
        policy.setBlockedEmailDomains(emptyToNull(policy.getBlockedEmailDomains()));
        policy.setCaptchaProviderCode(emptyToNull(policy.getCaptchaProviderCode()));
        String beforeSnapshot = toAppealPolicySnapshot(current);
        loginRiskPolicyMapper.updateSecurityAppealPolicy(policy);
        SecurityAppealPolicyVO updated = loginRiskPolicyMapper.findSecurityAppealPolicy();
        String afterSnapshot = toAppealPolicySnapshot(updated == null ? policy : updated);
        loginRiskPolicyMapper.insertSecurityAppealPolicyHistory(
                current.getPolicyIdx(),
                current.getPolicyCode(),
                "UPDATE",
                actorUserIdx,
                beforeSnapshot,
                afterSnapshot
        );
        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                "SECURITY_APPEAL_POLICY_UPDATE",
                actorUserIdx,
                "SECURITY_APPEAL_POLICY",
                current.getPolicyCode(),
                "SECURITY_APPEAL_POLICY",
                current.getPolicyIdx(),
                "SECURITY.APPEAL_POLICY.UPDATE",
                jsonArg("policyIdx", current.getPolicyIdx(), "active", policy.isActive()),
                msg("ko", "security.appeal.policy.audit.updated")
        );
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
            case "close", "closed" -> "CLOSED";
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

    public SecurityAssessmentProviderConfigVO getProviderConfigByIdx(Long providerIdx) {
        return loginRiskPolicyMapper.findProviderConfigByIdx(providerIdx);
    }

    @Transactional
    public void updateProviderConfig(SecurityAssessmentProviderConfigVO config) {
        updateProviderConfig(config, null);
    }

    @Transactional
    public void updateProviderConfig(SecurityAssessmentProviderConfigVO config, Long actorUserIdx) {
        SecurityAssessmentProviderConfigVO before = loginRiskPolicyMapper.findProviderConfigByIdx(config.getProviderIdx());
        String beforeSnapshot = toProviderConfigSnapshot(before);
        config.setUpdatedByUserIdx(actorUserIdx);
        if (before != null) {
            if (config.getProviderCode() == null || config.getProviderCode().isBlank()) {
                config.setProviderCode(before.getProviderCode());
            }
            if (config.getProviderKind() == null || config.getProviderKind().isBlank()) {
                config.setProviderKind(before.getProviderKind());
            }
        }
        loginRiskPolicyMapper.updateProviderConfig(config);
        SecurityAssessmentProviderConfigVO after = loginRiskPolicyMapper.findProviderConfigByIdx(config.getProviderIdx());
        SecurityAssessmentProviderConfigVO effective = after == null ? config : after;
        loginRiskPolicyMapper.insertProviderConfigHistory(
                effective.getProviderIdx(),
                effective.getProviderCode(),
                effective.getProviderKind(),
                "UPDATE",
                actorUserIdx,
                beforeSnapshot,
                toProviderConfigSnapshot(effective)
        );
        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                "PROVIDER_CONFIG_UPDATE",
                actorUserIdx,
                "PROVIDER",
                effective.getProviderCode(),
                "SECURITY_ASSESSMENT_PROVIDER_CONFIG",
                effective.getProviderIdx(),
                "SECURITY.PROVIDER.CONFIG_UPDATE",
                jsonArg("providerIdx", effective.getProviderIdx(), "enabled", effective.isEnabled()),
                "enabled=" + effective.isEnabled() + ", endpoint=" + effective.getEndpointUrl()
        );
    }



    public List<ProviderHealthCheckHistoryVO> getProviderHealthCheckHistories(String providerCode, int limit) {
        int safeLimit = Math.max(1, Math.min(limit, 200));
        return loginRiskPolicyMapper.findProviderHealthCheckHistories(emptyToNull(providerCode), safeLimit);
    }

    public ProviderConfigSearchResult searchProviderConfigs(ProviderConfigFilter filter) {
        Map<String, Object> map = filter.toFilterMap();
        int total = loginRiskPolicyMapper.countProviderConfigs(map);
        List<SecurityAssessmentProviderConfigVO> rows = loginRiskPolicyMapper.searchProviderConfigs(map);
        return new ProviderConfigSearchResult(rows, total, filter.page, filter.pageSize);
    }

    public List<SecurityAssessmentProviderConfigVO> exportProviderConfigs(ProviderConfigFilter filter) {
        Map<String, Object> map = filter.toFilterMap();
        map.put("pageSize", null);
        map.put("offset", 0);
        return loginRiskPolicyMapper.searchProviderConfigs(map);
    }

    @Transactional
    public SecurityAssessmentProviderConfigVO createProviderConfig(SecurityAssessmentProviderConfigVO config, Long actorUserIdx) {
        if (config.getProviderCode() == null || config.getProviderCode().isBlank()) {
            config.setProviderCode(generateProviderCode(config.getProviderKind()));
        } else if (loginRiskPolicyMapper.countProviderConfigByCode(config.getProviderCode()) > 0) {
            throw new IllegalArgumentException(msg("ko", "security.provider.code.duplicate"));
        }
        if (config.getProviderKind() == null || config.getProviderKind().isBlank()) {
            throw new IllegalArgumentException(msg("ko", "security.provider.kind.required"));
        }
        if (config.getProviderName() == null || config.getProviderName().isBlank()) {
            throw new IllegalArgumentException(msg("ko", "security.provider.name.required"));
        }
        if (config.getTimeoutMillis() == null || config.getTimeoutMillis() <= 0) {
            config.setTimeoutMillis(3000);
        }
        if (config.getFailOpen() == null) {
            config.setFailOpen(1);
        }
        if (config.getPriority() == null) {
            config.setPriority(100);
        }
        if (config.getHealthCheckIntervalSec() == null || config.getHealthCheckIntervalSec() <= 0) {
            config.setHealthCheckIntervalSec(300);
        }
        if (config.getRetryCount() == null || config.getRetryCount() < 0) {
            config.setRetryCount(0);
        }
        if (config.getRetryBackoffMs() == null || config.getRetryBackoffMs() < 0) {
            config.setRetryBackoffMs(500);
        }
        if (config.getNextHealthCheckAt() == null) {
            config.setNextHealthCheckAt(LocalDateTime.now().plusSeconds((long)(Math.random() * config.getHealthCheckIntervalSec())));
        }
        config.setCreatedByUserIdx(actorUserIdx);
        config.setUpdatedByUserIdx(actorUserIdx);

        loginRiskPolicyMapper.insertProviderConfig(config);

        SecurityAssessmentProviderConfigVO after = loginRiskPolicyMapper.findProviderConfigByIdx(config.getProviderIdx());
        SecurityAssessmentProviderConfigVO effective = after == null ? config : after;
        loginRiskPolicyMapper.insertProviderConfigHistory(
                effective.getProviderIdx(),
                effective.getProviderCode(),
                effective.getProviderKind(),
                "CREATE",
                actorUserIdx,
                "{}",
                toProviderConfigSnapshot(effective)
        );
        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                "PROVIDER_CONFIG_CREATE",
                actorUserIdx,
                "PROVIDER",
                effective.getProviderCode(),
                "SECURITY_ASSESSMENT_PROVIDER_CONFIG",
                effective.getProviderIdx(),
                "SECURITY.PROVIDER.CONFIG_CREATE",
                jsonArg("providerIdx", effective.getProviderIdx(), "kind", effective.getProviderKind()),
                "code=" + effective.getProviderCode() + ", kind=" + effective.getProviderKind()
        );
        return effective;
    }

    @Transactional
    public void softDeleteProviderConfig(Long providerIdx, Long actorUserIdx) {
        SecurityAssessmentProviderConfigVO before = loginRiskPolicyMapper.findProviderConfigByIdx(providerIdx);
        if (before == null || before.getDeletedAt() != null) {
            return;
        }
        loginRiskPolicyMapper.softDeleteProviderConfig(providerIdx, actorUserIdx);
        loginRiskPolicyMapper.insertProviderConfigHistory(
                providerIdx,
                before.getProviderCode(),
                before.getProviderKind(),
                "SOFT_DELETE",
                actorUserIdx,
                toProviderConfigSnapshot(before),
                "{}"
        );
        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                "PROVIDER_CONFIG_DELETE",
                actorUserIdx,
                "PROVIDER",
                before.getProviderCode(),
                "SECURITY_ASSESSMENT_PROVIDER_CONFIG",
                providerIdx,
                "SECURITY.PROVIDER.CONFIG_DELETE",
                jsonArg("providerIdx", providerIdx, "code", before.getProviderCode()),
                "soft delete code=" + before.getProviderCode()
        );
    }

    @Transactional
    public void restoreProviderConfig(Long providerIdx, Long actorUserIdx) {
        SecurityAssessmentProviderConfigVO before = loginRiskPolicyMapper.findProviderConfigByIdx(providerIdx);
        if (before == null || before.getDeletedAt() == null) {
            return;
        }
        loginRiskPolicyMapper.restoreProviderConfig(providerIdx, actorUserIdx);
        SecurityAssessmentProviderConfigVO after = loginRiskPolicyMapper.findProviderConfigByIdx(providerIdx);
        loginRiskPolicyMapper.insertProviderConfigHistory(
                providerIdx,
                before.getProviderCode(),
                before.getProviderKind(),
                "RESTORE",
                actorUserIdx,
                toProviderConfigSnapshot(before),
                toProviderConfigSnapshot(after == null ? before : after)
        );
        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                "PROVIDER_CONFIG_RESTORE",
                actorUserIdx,
                "PROVIDER",
                before.getProviderCode(),
                "SECURITY_ASSESSMENT_PROVIDER_CONFIG",
                providerIdx,
                "SECURITY.PROVIDER.CONFIG_RESTORE",
                jsonArg("providerIdx", providerIdx, "code", before.getProviderCode()),
                "restore code=" + before.getProviderCode()
        );
    }

    @Transactional
    public int bulkUpdateProviderEnabled(List<Long> idxList, boolean enabled, Long actorUserIdx) {
        if (idxList == null || idxList.isEmpty()) return 0;
        int affected = 0;
        for (Long idx : idxList) {
            SecurityAssessmentProviderConfigVO before = loginRiskPolicyMapper.findProviderConfigByIdx(idx);
            if (before == null || before.getDeletedAt() != null) continue;
            if (before.isEnabled() == enabled) continue;
            before.setEnabled(enabled);
            before.setUpdatedByUserIdx(actorUserIdx);
            loginRiskPolicyMapper.updateProviderConfig(before);
            SecurityAssessmentProviderConfigVO after = loginRiskPolicyMapper.findProviderConfigByIdx(idx);
            loginRiskPolicyMapper.insertProviderConfigHistory(
                    idx,
                    before.getProviderCode(),
                    before.getProviderKind(),
                    enabled ? "BULK_ENABLE" : "BULK_DISABLE",
                    actorUserIdx,
                    toProviderConfigSnapshot(before),
                    toProviderConfigSnapshot(after == null ? before : after)
            );
            affected++;
        }
        return affected;
    }

    @Transactional
    public int bulkSoftDeleteProviderConfigs(List<Long> idxList, Long actorUserIdx) {
        if (idxList == null || idxList.isEmpty()) return 0;
        int affected = 0;
        for (Long idx : idxList) {
            SecurityAssessmentProviderConfigVO before = loginRiskPolicyMapper.findProviderConfigByIdx(idx);
            if (before == null || before.getDeletedAt() != null) continue;
            softDeleteProviderConfig(idx, actorUserIdx);
            affected++;
        }
        return affected;
    }

    @Transactional
    public int bulkRestoreProviderConfigs(List<Long> idxList, Long actorUserIdx) {
        if (idxList == null || idxList.isEmpty()) return 0;
        int affected = 0;
        for (Long idx : idxList) {
            SecurityAssessmentProviderConfigVO before = loginRiskPolicyMapper.findProviderConfigByIdx(idx);
            if (before == null || before.getDeletedAt() == null) continue;
            restoreProviderConfig(idx, actorUserIdx);
            affected++;
        }
        return affected;
    }

    @Transactional
    public int bulkCheckProviderHealth(List<Long> idxList, Long actorUserIdx) {
        if (idxList == null || idxList.isEmpty()) return 0;
        int affected = 0;
        for (Long idx : idxList) {
            try {
                checkProviderHealth(idx, actorUserIdx);
                affected++;
            } catch (Exception ignored) {}
        }
        return affected;
    }

    private String generateProviderCode(String kind) {
        String prefix = (kind == null || kind.isBlank()) ? "PROVIDER" : kind.toUpperCase(Locale.ROOT);
        for (int i = 0; i < 5; i++) {
            String suffix = UUID.randomUUID().toString().replace("-", "").substring(0, 8).toUpperCase(Locale.ROOT);
            String candidate = (prefix + "_" + suffix);
            if (candidate.length() > 80) candidate = candidate.substring(0, 80);
            if (loginRiskPolicyMapper.countProviderConfigByCode(candidate) == 0) {
                return candidate;
            }
        }
        return prefix + "_" + System.currentTimeMillis();
    }

    public static class ProviderConfigFilter {
        public String keyword;
        public String kind;
        public String status;
        public String enabled;
        public String failOpen;
        public String category;
        public String triggerEvent;
        public boolean includeDeleted;
        public boolean onlyDeleted;
        public String sort;
        public int page = 1;
        public int pageSize = 20;
        public List<Long> idxList;

        public Map<String, Object> toFilterMap() {
            Map<String, Object> m = new HashMap<>();
            m.put("keyword", emptyToNull(keyword));
            m.put("kind", emptyToNull(kind));
            m.put("status", emptyToNull(status));
            m.put("enabled", emptyToNull(enabled));
            m.put("failOpen", emptyToNull(failOpen));
            m.put("category", emptyToNull(category));
            m.put("triggerEvent", emptyToNull(triggerEvent));
            m.put("includeDeleted", includeDeleted);
            m.put("onlyDeleted", onlyDeleted);
            m.put("sort", emptyToNull(sort));
            m.put("idxList", (idxList == null || idxList.isEmpty()) ? null : idxList);
            int safePage = page < 1 ? 1 : page;
            int safeSize = pageSize;
            if (safeSize <= 0) {
                m.put("pageSize", null);
                m.put("offset", 0);
            } else {
                m.put("pageSize", safeSize);
                m.put("offset", (safePage - 1) * safeSize);
            }
            return m;
        }

        private static String emptyToNull(String value) {
            return (value == null || value.isBlank()) ? null : value.trim();
        }
    }

    public record ProviderConfigSearchResult(List<SecurityAssessmentProviderConfigVO> rows,
                                             int total,
                                             int page,
                                             int pageSize) {
    }

    @Scheduled(fixedDelayString = "${security.provider.healthcheck.fixed-delay-ms:300000}")
    @Transactional
    public void runProviderHealthCheckOnce() {
        LocalDateTime now = LocalDateTime.now();
        List<SecurityAssessmentProviderConfigVO> providers = loginRiskPolicyMapper.findProviderConfigsDueForHealthCheck(now);
        Long fallbackActorUserIdx = null;
        for (SecurityAssessmentProviderConfigVO provider : providers) {
            String beforeStatus = provider.getStatus();
            ProviderHealth health = evaluateProviderHealth(provider);
            String healthDetail = dbText(health.description(), 1000);
            Long actorUserIdx = provider.getUpdatedByUserIdx() != null
                    ? provider.getUpdatedByUserIdx()
                    : provider.getCreatedByUserIdx();
            if (actorUserIdx == null) {
                if (fallbackActorUserIdx == null) {
                    fallbackActorUserIdx = loginRiskPolicyMapper.findDefaultAdminActorUserIdx();
                }
                actorUserIdx = fallbackActorUserIdx;
            }
            loginRiskPolicyMapper.updateProviderHealth(provider.getProviderIdx(), health.status(), healthDetail);
            loginRiskPolicyMapper.insertProviderHealthCheckHistory(
                    provider.getProviderIdx(),
                    provider.getProviderCode(),
                    provider.getProviderKind(),
                    "SCHEDULED",
                    beforeStatus,
                    health.status(),
                    actorUserIdx,
                    healthDetail
            );
            int interval = provider.getHealthCheckIntervalSec() != null && provider.getHealthCheckIntervalSec() > 0
                    ? provider.getHealthCheckIntervalSec() : 300;
            loginRiskPolicyMapper.updateProviderNextHealthCheckAt(provider.getProviderIdx(), now.plusSeconds(interval));
        }
    }

    @Transactional
    public void checkProviderHealth(Long providerIdx, Long actorUserIdx) {
        SecurityAssessmentProviderConfigVO provider = loginRiskPolicyMapper.findProviderConfigs().stream()
                .filter(p -> providerIdx != null && providerIdx.equals(p.getProviderIdx()))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException(msg("ko", "security.provider.notFound")));

        String beforeStatus = provider.getStatus();
        ProviderHealth health = evaluateProviderHealth(provider);
        String healthDetail = dbText(health.description(), 1000);
        loginRiskPolicyMapper.updateProviderHealth(provider.getProviderIdx(), health.status(), healthDetail);
        loginRiskPolicyMapper.insertProviderHealthCheckHistory(
                provider.getProviderIdx(),
                provider.getProviderCode(),
                provider.getProviderKind(),
                "MANUAL",
                beforeStatus,
                health.status(),
                actorUserIdx,
                healthDetail
        );
        loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                "PROVIDER_HEALTH_CHECK",
                actorUserIdx,
                "PROVIDER",
                provider.getProviderCode(),
                "SECURITY_ASSESSMENT_PROVIDER_CONFIG",
                provider.getProviderIdx(),
                "SECURITY.PROVIDER.HEALTH_CHECK",
                jsonArg("providerIdx", provider.getProviderIdx(), "status", health.status()),
                healthDetail
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
                    safeWafStatus(result.getStatus()),
                    dbText(result.getMessage(), 1000)
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
        AppealRateLimitConfig ratePolicy = getAppealRateLimitConfig();
        if (!isEmailDomainAllowed(submitterEmail, ratePolicy.allowedEmailDomains(), ratePolicy.blockedEmailDomains())) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.error.emailDomainNotAllowed"));
        }

        SecurityAppealFormVO context = getPublicAppealForm(null, requestId, lang);
        if (!context.isValid()) {
            throw new IllegalArgumentException(context.getErrorMessage());
        }

        ensureAppealChannelOpen(context, firstNonBlank(context.getRequestId(), requestId), lang, ratePolicy);

        LocalDateTime verificationWindowStart = LocalDateTime.now().minusMinutes(ratePolicy.verificationWindowMinutes());
        Integer verificationCount = loginRiskPolicyMapper.countVerificationTokensAfter(
                firstNonBlank(context.getRequestId(), requestId),
                submitterEmail.trim(),
                verificationWindowStart
        );
        if (ratePolicy.enabled() && verificationCount != null && verificationCount >= ratePolicy.maxVerificationEmails()) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.error.verificationRateLimited"));
        }

        String token = createAppealToken(
                context.getUserIdx(),
                context.getTargetType(),
                context.getTargetKey(),
                context.getSourceAssessmentIdx(),
                null,
                firstNonBlank(context.getRequestId(), requestId),
                submitterEmail.trim(),
                LocalDateTime.now().plusMinutes(ratePolicy.verificationTokenTtlMinutes())
        );
        String appealUrl = publicBaseUrl() + "/security/appeal?token=" + token + "&lang=" + lang;
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

        AppealPolicyConfig appealPolicy = getAppealPolicyConfig();
        AppealRateLimitConfig ratePolicy = getAppealRateLimitConfig();
        ensureAppealChannelOpen(context, firstNonBlank(context.getRequestId(), requestId), lang, ratePolicy);
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


    private boolean isEmailDomainAllowed(String email, String allowedDomains, String blockedDomains) {
        if (email == null || !email.contains("@")) {
            return false;
        }
        String domain = email.substring(email.lastIndexOf('@') + 1).trim().toLowerCase(Locale.ROOT);
        if (matchesDomainList(domain, blockedDomains)) {
            return false;
        }
        return allowedDomains == null || allowedDomains.isBlank() || matchesDomainList(domain, allowedDomains);
    }

    private boolean matchesDomainList(String domain, String csvDomains) {
        if (domain == null || csvDomains == null || csvDomains.isBlank()) {
            return false;
        }
        for (String item : csvDomains.split(",")) {
            String rule = item == null ? "" : item.trim().toLowerCase(Locale.ROOT);
            if (rule.isBlank()) {
                continue;
            }
            if (rule.startsWith("*.")) {
                String suffix = rule.substring(1);
                if (domain.endsWith(suffix)) {
                    return true;
                }
            } else if (domain.equals(rule)) {
                return true;
            }
        }
        return false;
    }

    private AppealPolicyConfig getAppealPolicyConfig() {
        SecurityAppealPolicyVO policy = getSecurityAppealPolicy();
        return new AppealPolicyConfig(
                policy.isActive(),
                nonNegativeOrDefault(policy.getRejectedCooldownMinutes(), 10080),
                positiveOrDefault(policy.getMaxRejectedCount(), 2),
                positiveOrDefault(policy.getIpDailyAppealLimit(), 3)
        );
    }

    private AppealRateLimitConfig getAppealRateLimitConfig() {
        SecurityAppealPolicyVO policy = getSecurityAppealPolicy();
        return new AppealRateLimitConfig(
                policy.isActive(),
                positiveOrDefault(policy.getVerificationWindowMinutes(), 60),
                positiveOrDefault(policy.getMaxVerificationEmails(), 3),
                positiveOrDefault(policy.getResultLookupWindowMinutes(), 60),
                positiveOrDefault(policy.getMaxResultLookupFailures(), 5),
                positiveOrDefault(policy.getVerificationTokenTtlMinutes(), 30),
                positiveOrDefault(policy.getProtectedAppealTokenTtlDays(), 7),
                policy.isAllowMultipleOpenAppeals(),
                positiveOrDefault(policy.getMaxOpenAppealsPerCase(), 3),
                policy.isClosedBlocksNewAppeals(),
                nonNegativeOrDefault(policy.getResultLookupRetentionDays(), 365),
                policy.getAllowedEmailDomains(),
                policy.getBlockedEmailDomains()
        );
    }

    private void ensureAppealChannelOpen(SecurityAppealFormVO context,
                                         String requestId,
                                         String lang,
                                         AppealRateLimitConfig policy) {
        if (context == null || !policy.enabled()) {
            return;
        }
        if (policy.closedBlocksNewAppeals()) {
            Integer closedCount = loginRiskPolicyMapper.countClosedAppealsForCase(
                    context.getTargetType(),
                    context.getTargetKey(),
                    requestId
            );
            if (closedCount != null && closedCount > 0) {
                throw new IllegalArgumentException(msg(lang, "security.appeal.error.channelClosed"));
            }
        }

        Integer openCount = loginRiskPolicyMapper.countOpenAppealsForCase(
                context.getTargetType(),
                context.getTargetKey(),
                requestId
        );
        int openLimit = policy.allowMultipleOpenAppeals() ? policy.maxOpenAppealsPerCase() : 1;
        if (openCount != null && openCount >= openLimit) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.error.maxOpenAppeals"));
        }
    }



    private String toLoginRiskPolicySnapshot(LoginRiskPolicyVO policy) {
        if (policy == null) {
            return "{}";
        }
        return "{"
                + jsonPair("policyIdx", policy.getPolicyIdx()) + ","
                + jsonPair("policyCode", policy.getPolicyCode()) + ","
                + jsonPair("policyName", policy.getPolicyName()) + ","
                + jsonPair("policyType", policy.getPolicyType()) + ","
                + jsonPair("active", policy.isActive()) + ","
                + jsonPair("observationMinutes", policy.getObservationMinutes()) + ","
                + jsonPair("thresholdCount", policy.getThresholdCount()) + ","
                + jsonPair("distinctAccountThreshold", policy.getDistinctAccountThreshold()) + ","
                + jsonPair("lockDurationMinutes", policy.getLockDurationMinutes()) + ","
                + jsonPair("warningBeforeCount", policy.getWarningBeforeCount()) + ","
                + jsonPair("resetOnSuccess", policy.isResetOnSuccess()) + ","
                + jsonPair("actionType", policy.getActionType()) + ","
                + jsonPair("requireAdminReview", policy.isRequireAdminReview()) + ","
                + jsonPair("reviewSeverity", policy.getReviewSeverity()) + ","
                + jsonPair("notificationCategory", policy.getNotificationCategory()) + ","
                + jsonPair("aiAssistEnabled", policy.isAiAssistEnabled()) + ","
                + jsonPair("aiRiskScoreThreshold", policy.getAiRiskScoreThreshold()) + ","
                + jsonPair("wafSyncEnabled", policy.isWafSyncEnabled()) + ","
                + jsonPair("description", policy.getDescription())
                + "}";
    }

    private String toProviderConfigSnapshot(SecurityAssessmentProviderConfigVO provider) {
        if (provider == null) {
            return "{}";
        }
        return "{"
                + jsonPair("providerIdx", provider.getProviderIdx()) + ","
                + jsonPair("providerKind", provider.getProviderKind()) + ","
                + jsonPair("providerCode", provider.getProviderCode()) + ","
                + jsonPair("providerName", provider.getProviderName()) + ","
                + jsonPair("enabled", provider.isEnabled()) + ","
                + jsonPair("endpointUrl", provider.getEndpointUrl()) + ","
                + jsonPair("apiKeyRef", provider.getApiKeyRef()) + ","
                + jsonPair("modelName", provider.getModelName()) + ","
                + jsonPair("timeoutMillis", provider.getTimeoutMillis()) + ","
                + jsonPair("failOpen", provider.getFailOpen()) + ","
                + jsonPair("status", provider.getStatus()) + ","
                + jsonPair("description", provider.getDescription()) + ","
                + jsonPair("priority", provider.getPriority()) + ","
                + jsonPair("healthCheckIntervalSec", provider.getHealthCheckIntervalSec()) + ","
                + jsonPair("usageCategories", provider.getUsageCategories()) + ","
                + jsonPair("triggerEvents", provider.getTriggerEvents()) + ","
                + jsonPair("requestMethod", provider.getRequestMethod()) + ","
                + jsonPair("requestHeadersJson", provider.getRequestHeadersJson()) + ","
                + jsonPair("requestTemplateJson", provider.getRequestTemplateJson()) + ","
                + jsonPair("responseMappingJson", provider.getResponseMappingJson()) + ","
                + jsonPair("maxConcurrent", provider.getMaxConcurrent()) + ","
                + jsonPair("ratePerMinute", provider.getRatePerMinute()) + ","
                + jsonPair("retryCount", provider.getRetryCount()) + ","
                + jsonPair("retryBackoffMs", provider.getRetryBackoffMs()) + ","
                + jsonPair("tags", provider.getTags())
                + "}";
    }

    private String toAppealPolicySnapshot(SecurityAppealPolicyVO policy) {
        if (policy == null) {
            return "{}";
        }
        return "{"
                + jsonPair("policyCode", policy.getPolicyCode()) + ","
                + jsonPair("active", policy.isActive()) + ","
                + jsonPair("allowMultipleOpenAppeals", policy.isAllowMultipleOpenAppeals()) + ","
                + jsonPair("maxOpenAppealsPerCase", policy.getMaxOpenAppealsPerCase()) + ","
                + jsonPair("closedBlocksNewAppeals", policy.isClosedBlocksNewAppeals()) + ","
                + jsonPair("rejectedCooldownMinutes", policy.getRejectedCooldownMinutes()) + ","
                + jsonPair("maxRejectedCount", policy.getMaxRejectedCount()) + ","
                + jsonPair("ipDailyAppealLimit", policy.getIpDailyAppealLimit()) + ","
                + jsonPair("verificationWindowMinutes", policy.getVerificationWindowMinutes()) + ","
                + jsonPair("maxVerificationEmails", policy.getMaxVerificationEmails()) + ","
                + jsonPair("verificationTokenTtlMinutes", policy.getVerificationTokenTtlMinutes()) + ","
                + jsonPair("protectedAppealTokenTtlDays", policy.getProtectedAppealTokenTtlDays()) + ","
                + jsonPair("resultLookupWindowMinutes", policy.getResultLookupWindowMinutes()) + ","
                + jsonPair("maxResultLookupFailures", policy.getMaxResultLookupFailures()) + ","
                + jsonPair("resultLookupRetentionDays", policy.getResultLookupRetentionDays()) + ","
                + jsonPair("allowedEmailDomains", policy.getAllowedEmailDomains()) + ","
                + jsonPair("blockedEmailDomains", policy.getBlockedEmailDomains()) + ","
                + jsonPair("captchaEnabled", policy.isCaptchaEnabled()) + ","
                + jsonPair("captchaProviderCode", policy.getCaptchaProviderCode())
                + "}";
    }

    private String jsonPair(String key, Object value) {
        return "\"" + escapeJson(key) + "\":\"" + escapeJson(value == null ? "" : String.valueOf(value)) + "\"";
    }

    private String escapeJson(String value) {
        return value == null ? "" : value.replace("\\", "\\\\").replace("\"", "\\\"");
    }

    private int positiveOrDefault(Integer value, int fallback) {
        return value != null && value > 0 ? value : fallback;
    }

    private int nonNegativeOrDefault(Integer value, int fallback) {
        return value != null && value >= 0 ? value : fallback;
    }

    private SecurityAppealPolicyVO defaultSecurityAppealPolicy() {
        SecurityAppealPolicyVO policy = new SecurityAppealPolicyVO();
        policy.setPolicyCode("DEFAULT");
        policy.setActive(true);
        policy.setAllowMultipleOpenAppeals(true);
        policy.setMaxOpenAppealsPerCase(3);
        policy.setClosedBlocksNewAppeals(true);
        policy.setRejectedCooldownMinutes(10080);
        policy.setMaxRejectedCount(2);
        policy.setIpDailyAppealLimit(3);
        policy.setVerificationWindowMinutes(60);
        policy.setMaxVerificationEmails(3);
        policy.setVerificationTokenTtlMinutes(30);
        policy.setProtectedAppealTokenTtlDays(7);
        policy.setResultLookupWindowMinutes(60);
        policy.setMaxResultLookupFailures(5);
        policy.setResultLookupRetentionDays(365);
        policy.setCaptchaEnabled(false);
        policy.setCaptchaProviderCode("MOCK_TURNSTILE");
        return policy;
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

    private record AppealRateLimitConfig(boolean enabled,
                                         int verificationWindowMinutes,
                                         int maxVerificationEmails,
                                         int resultLookupWindowMinutes,
                                         int maxResultLookupFailures,
                                         int verificationTokenTtlMinutes,
                                         int protectedAppealTokenTtlDays,
                                         boolean allowMultipleOpenAppeals,
                                         int maxOpenAppealsPerCase,
                                         boolean closedBlocksNewAppeals,
                                         int resultLookupRetentionDays,
                                         String allowedEmailDomains,
                                         String blockedEmailDomains) {
    }

    private String createAppealToken(Long userIdx,
                                     String targetType,
                                     String targetKey,
                                     Long sourceAssessmentIdx,
                                     String blockRequestId,
                                     String blockAccessRequestId) {
        AppealRateLimitConfig ratePolicy = getAppealRateLimitConfig();
        return createAppealToken(userIdx, targetType, targetKey, sourceAssessmentIdx, blockRequestId,
                blockAccessRequestId, null, LocalDateTime.now().plusDays(ratePolicy.protectedAppealTokenTtlDays()));
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
        AppealRateLimitConfig ratePolicy = getAppealRateLimitConfig();
        String resultTargetKey = "PUBLIC_REQUEST:" + publicRequestId.trim();
        Integer failedLookupCount = loginRiskPolicyMapper.countSecurityActionAuditAfter(
                "SECURITY_APPEAL_RESULT_LOOKUP_FAILED",
                "SECURITY_APPEAL_RESULT",
                resultTargetKey,
                LocalDateTime.now().minusMinutes(ratePolicy.resultLookupWindowMinutes())
        );
        if (ratePolicy.enabled() && failedLookupCount != null && failedLookupCount >= ratePolicy.maxResultLookupFailures()) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.result.error.rateLimited"));
        }

        SecurityAppealVO appeal = loginRiskPolicyMapper.findSecurityAppealByPublicRequestId(publicRequestId);
        String storedEmail = appeal == null ? null : firstNonBlank(appeal.getSubmitterEmail(),
                appeal.getUserIdx() == null ? null : loginRiskPolicyMapper.findUserEmailByUserIdx(appeal.getUserIdx()));
        if (appeal != null && ratePolicy.resultLookupRetentionDays() > 0
                && appeal.getCreatedAt() != null
                && appeal.getCreatedAt().isBefore(LocalDateTime.now().minusDays(ratePolicy.resultLookupRetentionDays()))) {
            throw new IllegalArgumentException(msg(lang, "security.appeal.result.error.expired"));
        }
        if (appeal == null || storedEmail == null || !storedEmail.equalsIgnoreCase(submitterEmail.trim())) {
            loginRiskPolicyMapper.insertSecurityActionAuditWithReason(
                    "SECURITY_APPEAL_RESULT_LOOKUP_FAILED",
                    null,
                    "SECURITY_APPEAL_RESULT",
                    resultTargetKey,
                    "SECURITY_ACTION_APPEAL",
                    appeal == null ? null : appeal.getAppealIdx(),
                    "SECURITY.APPEAL.RESULT_LOOKUP_FAILED",
                    jsonArg("publicRequestId", publicRequestId, "email", maskEmail(submitterEmail)),
                    msg(lang, "security.appeal.result.audit.lookupFailed")
            );
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
                context == null ? null : context.getRequestId(), user.getUserEmail(),
                LocalDateTime.now().plusDays(getAppealRateLimitConfig().protectedAppealTokenTtlDays()));
        String appealUrl = publicBaseUrl() + "/security/appeal?token=" + token + "&lang=" + lang;
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


    private String runtimeSetting(String key, String fallback) {
        return runtimeSettingService.getValue(key, fallback);
    }

    private String mailFrom() {
        return runtimeSetting("spring.mail.username", mailFrom);
    }

    private String publicBaseUrl() {
        return runtimeSetting("app.public-base-url", publicBaseUrl);
    }

    private boolean sendMail(String to, String subject, String html) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
            helper.setFrom(mailFrom());
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

    private String safeWafStatus(String status) {
        if (status == null || status.isBlank()) {
            return "EXTERNAL_PROVIDER_PENDING";
        }
        return status.length() <= 40 ? status : status.substring(0, 40);
    }

    private String dbText(String value, int maxLength) {
        if (value == null || maxLength <= 0) {
            return value;
        }
        if (value.length() <= maxLength) {
            return value;
        }
        return value.substring(0, Math.max(0, maxLength - 20)) + "...[truncated]";
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
