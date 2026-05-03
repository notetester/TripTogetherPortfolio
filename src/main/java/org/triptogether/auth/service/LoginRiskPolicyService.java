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
import org.triptogether.auth.vo.SecurityRiskAssessmentVO;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityReviewVO;
import org.triptogether.auth.vo.SecurityAppealVO;
import org.triptogether.auth.vo.SecurityAppealFormVO;
import org.triptogether.auth.vo.SecurityAppealTokenVO;
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
            throw new IllegalArgumentException("보안 판단 근거를 찾을 수 없습니다.");
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
                firstNonBlank(summary, assessment.getRecommendationAction(), "보안 위험 판단 검토 필요"),
                firstNonBlank(detailMessage, assessment.getEvidenceSummary(), assessment.getRecommendationReason())
        );
        for (Long adminIdx : loginRiskPolicyMapper.findAdminNotificationTargets("BLOCK_REVIEW")) {
            loginRiskPolicyMapper.insertAdminNotification(adminIdx, "SECURITY_REVIEW", assessmentIdx,
                    "[보안 검토] " + firstNonBlank(summary, assessment.getSubjectKey(), "보안 위험 판단 검토 필요"),
                    "/admin/login-risk/security-reviews");
        }
    }

    @Transactional
    public void decideSecurityReview(Long reviewIdx, String decision, Long actorUserIdx, String comment) {
        SecurityReviewVO review = loginRiskPolicyMapper.findSecurityReviewByIdx(reviewIdx);
        if (review == null) {
            throw new IllegalArgumentException("보안 검토 대상을 찾을 수 없습니다.");
        }
        String normalized = normalizeDecision(decision);
        loginRiskPolicyMapper.updateSecurityReviewDecision(reviewIdx, normalized, actorUserIdx, comment);
        loginRiskPolicyMapper.insertSecurityActionAudit(
                "SECURITY_REVIEW_" + normalized,
                actorUserIdx,
                review.getSubjectType(),
                review.getSubjectKey(),
                "SECURITY_REVIEW_QUEUE",
                reviewIdx,
                "일반 보안 검토 처리",
                comment
        );

        if ("APPROVED".equals(normalized) && review.getAssessmentIdx() != null) {
            SecurityRiskAssessmentVO assessment = loginRiskPolicyMapper.findSecurityRiskAssessmentByIdx(review.getAssessmentIdx());
            if (assessment != null) {
                applyApprovedSecurityAssessment(assessment, actorUserIdx);
            }
        } else if ("REJECTED".equals(normalized) && review.getAssessmentIdx() != null) {
            loginRiskPolicyMapper.updateSecurityRiskAssessmentDecision(review.getAssessmentIdx(), "IGNORED");
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
                    firstNonBlank(assessment.getRecommendationReason(), assessment.getEvidenceSummary(), "보안 판단 승인 기반 접근 환경 제한"),
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
                log.warn("[SecurityReview] 보안 검토 승인 후 차단 캐시 갱신 실패 assessmentIdx={}", assessment.getAssessmentIdx(), e);
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
                    "보안 검토 승인에 따른 외부 WAF/CDN 동기화 후보입니다."
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
            applyAcceptedSecurityAppeal(appeal, actorUserIdx, firstNonBlank(comment, "이의제기 수용에 따른 보안 조치 해제"));
        }
        loginRiskPolicyMapper.insertSecurityActionAudit(
                "SECURITY_APPEAL_" + normalized,
                actorUserIdx,
                appeal == null ? "APPEAL" : appeal.getTargetType(),
                appeal == null ? String.valueOf(appealIdx) : appeal.getTargetKey(),
                "SECURITY_ACTION_APPEAL",
                appealIdx,
                "보안 조치 이의제기 처리",
                comment
        );
    }


    private void applyAcceptedSecurityAppeal(SecurityAppealVO appeal, Long actorUserIdx, String reason) {
        if (appeal.getTargetType() == null || appeal.getTargetKey() == null) {
            return;
        }
        if (appeal.getTargetType().contains("USER")) {
            loginRiskPolicyMapper.releaseUserBlockByTargetKey(appeal.getTargetKey(), actorUserIdx, reason);
            loginRiskPolicyMapper.restoreUserStatusByTargetKey(appeal.getTargetKey(), reason);
        } else if (appeal.getTargetType().contains("IP")) {
            loginRiskPolicyMapper.releaseIpBlockByTargetKey(appeal.getTargetKey(), actorUserIdx, reason);
            try {
                blockRuleCacheService.invalidateAndRefresh();
            } catch (Exception e) {
                log.warn("[SecurityAppeal] 이의제기 수용 후 차단 캐시 갱신 실패 appealIdx={}", appeal.getAppealIdx(), e);
            }
        }

        if (appeal.getSourceAssessmentIdx() != null) {
            loginRiskPolicyMapper.updateSecurityRiskAssessmentDecision(appeal.getSourceAssessmentIdx(), "REVERSED");
        }
    }

    public List<SecurityAssessmentProviderConfigVO> getProviderConfigs() {
        return loginRiskPolicyMapper.findProviderConfigs();
    }

    @Transactional
    public void updateProviderConfig(SecurityAssessmentProviderConfigVO config) {
        loginRiskPolicyMapper.updateProviderConfig(config);
        loginRiskPolicyMapper.insertSecurityActionAudit(
                "PROVIDER_CONFIG_UPDATE",
                null,
                "PROVIDER",
                config.getProviderCode(),
                "SECURITY_ASSESSMENT_PROVIDER_CONFIG",
                config.getProviderIdx(),
                "보안 판단 Provider 설정 변경",
                "enabled=" + config.isEnabled() + ", endpoint=" + config.getEndpointUrl()
        );
    }

    @Transactional
    public void applyUserBlockFromSecurityAssessment(Long assessmentIdx, Long actorUserIdx) {
        SecurityRiskAssessmentVO assessment = loginRiskPolicyMapper.findSecurityRiskAssessmentByIdx(assessmentIdx);
        if (assessment == null) {
            throw new IllegalArgumentException("보안 판단 근거를 찾을 수 없습니다.");
        }
        if (assessment.getUserIdx() == null) {
            throw new IllegalArgumentException("사용자 차단으로 적용할 수 없는 판단 근거입니다.");
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
                "외부/보조 보안 판단에 따른 계정 차단"
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
        loginRiskPolicyMapper.insertSecurityActionAudit(
                "ASSESSMENT_USER_BLOCK_APPLIED",
                actorUserIdx,
                "USER",
                assessment.getSubjectKey(),
                "SECURITY_RISK_ASSESSMENT",
                assessmentIdx,
                "보안 판단 근거 기반 계정 차단 적용",
                reason
        );
    }


    public SecurityAppealFormVO getPublicAppealForm(String token, String requestId, String lang) {
        if (token != null && !token.isBlank()) {
            SecurityAppealTokenVO tokenVO = loginRiskPolicyMapper.findAppealToken(token, LocalDateTime.now());
            if (tokenVO == null) {
                return SecurityAppealFormVO.builder()
                        .valid(false)
                        .errorMessage("이의제기 링크가 만료되었거나 이미 사용되었습니다.")
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
                    .pageLang(normalizeLang(lang))
                    .build();
        }

        if (requestId != null && !requestId.isBlank()) {
            SecurityAppealFormVO context = loginRiskPolicyMapper.findBlockAccessAppealContext(requestId);
            if (context == null) {
                return SecurityAppealFormVO.builder()
                        .valid(false)
                        .errorMessage("해당 요청 ID의 차단 기록을 찾을 수 없습니다.")
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
                .errorMessage("이의제기 대상 정보가 없습니다.")
                .pageLang(normalizeLang(lang))
                .build();
    }

    @Transactional
    public String submitPublicSecurityAppeal(String token,
                                             String requestId,
                                             String appealTitle,
                                             String appealContent,
                                             String submitterEmail,
                                             String pageLang) {
        SecurityAppealFormVO context = getPublicAppealForm(token, requestId, pageLang);
        if (!context.isValid()) {
            throw new IllegalArgumentException(context.getErrorMessage());
        }

        SecurityAppealTokenVO tokenVO = null;
        if (token != null && !token.isBlank()) {
            tokenVO = loginRiskPolicyMapper.findAppealToken(token, LocalDateTime.now());
            if (tokenVO == null) {
                throw new IllegalArgumentException("이의제기 링크가 만료되었거나 이미 사용되었습니다.");
            }
        }

        String publicRequestId = "SAP-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase(Locale.ROOT);
        Long inquiryId = null;
        String title = firstNonBlank(appealTitle, "보안 조치 이의제기");
        String content = firstNonBlank(appealContent, "");
        String enrichedContent = """
                [보안 조치 이의제기]
                공개 접수번호: %s
                대상 유형: %s
                대상 키: %s
                차단 요청 ID: %s
                차단 접근 요청 ID: %s
                연락 이메일: %s

                %s
                """.formatted(
                publicRequestId,
                context.getTargetType(),
                context.getTargetKey(),
                tokenVO == null ? null : tokenVO.getBlockRequestId(),
                firstNonBlank(context.getRequestId(), requestId),
                firstNonBlank(submitterEmail, "-"),
                content
        );

        if (context.getUserIdx() != null) {
            loginRiskPolicyMapper.insertSecurityAppealInquiry(context.getUserIdx(), "[보안 이의제기] " + title, enrichedContent);
            inquiryId = loginRiskPolicyMapper.findLatestInquiryIdByUserAndTitle(context.getUserIdx(), "[보안 이의제기] " + title);
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

        loginRiskPolicyMapper.insertSecurityActionAudit(
                "SECURITY_APPEAL_SUBMITTED",
                context.getUserIdx(),
                context.getTargetType(),
                context.getTargetKey(),
                "SECURITY_ACTION_APPEAL",
                null,
                "사용자 보안 조치 이의제기 접수",
                "publicRequestId=" + publicRequestId + ", requestId=" + firstNonBlank(context.getRequestId(), requestId)
        );

        for (Long adminIdx : loginRiskPolicyMapper.findAdminNotificationTargets("BLOCK_REVIEW")) {
            loginRiskPolicyMapper.insertAdminNotification(adminIdx, "SECURITY_APPEAL", null,
                    "[보안 이의제기] " + title,
                    "/admin/login-risk/appeals");
        }

        return publicRequestId;
    }

    private String createAppealToken(Long userIdx,
                                     String targetType,
                                     String targetKey,
                                     Long sourceAssessmentIdx,
                                     String blockRequestId,
                                     String blockAccessRequestId) {
        String token = UUID.randomUUID().toString().replace("-", "") + UUID.randomUUID().toString().replace("-", "");
        loginRiskPolicyMapper.insertSecurityAppealToken(
                token,
                userIdx,
                targetType,
                targetKey,
                sourceAssessmentIdx,
                blockRequestId,
                blockAccessRequestId,
                LocalDateTime.now().plusDays(7)
        );
        return token;
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
        String token = createAppealToken(user.getUserIdx(), "USER_BLOCK", "USER:" + user.getUserIdx(), null, null, context == null ? null : context.getRequestId());
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

    private String protectionMailHtml(String lang, String nickname, String reason, String appealUrl) {
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
                    <p style="margin-top:20px">
                        <a href="%s" style="display:inline-block;background:#2563eb;color:white;text-decoration:none;padding:12px 18px;border-radius:10px;font-weight:700">
                            Appeal / Contact Support
                        </a>
                    </p>
                </div>
                </body></html>
                """.formatted(title, body, guide, safeName, reason == null ? "-" : reason, appealUrl);
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
