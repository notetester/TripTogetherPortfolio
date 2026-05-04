package org.triptogether.auth.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.auth.vo.AdminNotificationPreferenceVO;
import org.triptogether.auth.vo.LoginRiskPolicyVO;
import org.triptogether.auth.vo.LoginRiskReviewVO;
import org.triptogether.auth.vo.LoginRiskExternalAssessmentVO;
import org.triptogether.auth.vo.SecurityRiskAssessmentVO;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityReviewVO;
import org.triptogether.auth.vo.SecurityWafSyncQueueVO;
import org.triptogether.auth.vo.SecurityAppealVO;
import org.triptogether.auth.vo.SecurityAppealTokenVO;
import org.triptogether.auth.vo.SecurityAppealFormVO;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface LoginRiskPolicyMapper {
    List<LoginRiskPolicyVO> findPolicies(@Param("includeInactive") boolean includeInactive);
    LoginRiskPolicyVO findActivePolicyByCode(@Param("policyCode") String policyCode);
    LoginRiskPolicyVO findPolicyByCode(@Param("policyCode") String policyCode);
    void updatePolicy(LoginRiskPolicyVO policy);

    Integer countRecentWrongPasswordByUser(@Param("userIdx") Long userIdx,
                                           @Param("since") LocalDateTime since);
    Integer countRecentWrongPasswordByIp(@Param("ipAddress") String ipAddress,
                                         @Param("since") LocalDateTime since);
    Integer countRecentDistinctIdentifiersByIp(@Param("ipAddress") String ipAddress,
                                               @Param("since") LocalDateTime since);
    Integer countRecentAccountLocks(@Param("userIdx") Long userIdx,
                                    @Param("since") LocalDateTime since);

    Integer countActiveIpLoginLocks(@Param("ipAddress") String ipAddress,
                                    @Param("now") LocalDateTime now);
    void insertIpLoginLockCounter(@Param("policyCode") String policyCode,
                                  @Param("ipAddress") String ipAddress,
                                  @Param("blockedUntil") LocalDateTime blockedUntil,
                                  @Param("detailMessage") String detailMessage);
    void clearCountersOnLoginSuccess(@Param("userIdx") Long userIdx,
                                     @Param("ipAddress") String ipAddress);

    void insertRiskEvent(@Param("policyCode") String policyCode,
                         @Param("eventType") String eventType,
                         @Param("subjectType") String subjectType,
                         @Param("subjectKey") String subjectKey,
                         @Param("userIdx") Long userIdx,
                         @Param("ipAddress") String ipAddress,
                         @Param("loginIdentifier") String loginIdentifier,
                         @Param("thresholdCount") Integer thresholdCount,
                         @Param("observedCount") Integer observedCount,
                         @Param("actionType") String actionType,
                         @Param("decisionStatus") String decisionStatus,
                         @Param("reviewRequired") boolean reviewRequired,
                         @Param("blockedUntil") LocalDateTime blockedUntil,
                         @Param("requestId") String requestId,
                         @Param("flowTraceId") String flowTraceId,
                         @Param("detailMessage") String detailMessage);

    void insertReviewQueue(@Param("policyCode") String policyCode,
                           @Param("reviewType") String reviewType,
                           @Param("severity") String severity,
                           @Param("subjectType") String subjectType,
                           @Param("subjectKey") String subjectKey,
                           @Param("userIdx") Long userIdx,
                           @Param("ipAddress") String ipAddress,
                           @Param("requestId") String requestId,
                           @Param("flowTraceId") String flowTraceId,
                           @Param("summary") String summary,
                           @Param("detailMessage") String detailMessage);

    List<Long> findAdminNotificationTargets(@Param("category") String category);
    void insertAdminNotification(@Param("userIdx") Long userIdx,
                                 @Param("sourceType") String sourceType,
                                 @Param("sourceId") Long sourceId,
                                 @Param("message") String message,
                                 @Param("targetUrl") String targetUrl);

    List<LoginRiskReviewVO> findReviewQueue(@Param("status") String status,
                                            @Param("severity") String severity,
                                            @Param("reviewType") String reviewType,
                                            @Param("keyword") String keyword);
    LoginRiskReviewVO findReviewByIdx(@Param("reviewIdx") Long reviewIdx);
    void updateReviewDecision(@Param("reviewIdx") Long reviewIdx,
                              @Param("reviewStatus") String reviewStatus,
                              @Param("reviewedByUserIdx") Long reviewedByUserIdx,
                              @Param("reviewComment") String reviewComment);

    void insertApprovedIpBlock(@Param("ipAddress") String ipAddress,
                               @Param("blockTargetKey") String blockTargetKey,
                               @Param("matchType") String matchType,
                               @Param("cidrNotation") String cidrNotation,
                               @Param("reason") String reason,
                               @Param("blockedByUserIdx") Long blockedByUserIdx,
                               @Param("blockRequestId") String blockRequestId,
                               @Param("sourceActionType") String sourceActionType,
                               @Param("sourceActionGroupId") String sourceActionGroupId,
                               @Param("sourceUserIdx") Long sourceUserIdx,
                               @Param("sourceIpAddress") String sourceIpAddress);

    void insertWafSyncQueue(@Param("sourceType") String sourceType,
                            @Param("sourceId") Long sourceId,
                            @Param("syncAction") String syncAction,
                            @Param("targetType") String targetType,
                            @Param("targetValue") String targetValue,
                            @Param("status") String status,
                            @Param("detailMessage") String detailMessage);

    List<SecurityWafSyncQueueVO> findPendingWafSyncQueue(@Param("limit") int limit);

    void updateWafSyncStatus(@Param("syncIdx") Long syncIdx,
                             @Param("status") String status,
                             @Param("detailMessage") String detailMessage);
    void insertAiAssessment(@Param("sourceType") String sourceType,
                            @Param("sourceId") Long sourceId,
                            @Param("riskScore") Integer riskScore,
                            @Param("riskLabel") String riskLabel,
                            @Param("modelName") String modelName,
                            @Param("summary") String summary,
                            @Param("rawPayload") String rawPayload);

    List<LoginRiskExternalAssessmentVO> findExternalAssessments(@Param("sourceKind") String sourceKind,
                                                               @Param("riskLevel") String riskLevel,
                                                               @Param("decisionStatus") String decisionStatus,
                                                               @Param("keyword") String keyword);

    void insertExternalAssessment(@Param("sourceKind") String sourceKind,
                                  @Param("sourceCode") String sourceCode,
                                  @Param("sourceName") String sourceName,
                                  @Param("sourceVersion") String sourceVersion,
                                  @Param("sourceType") String sourceType,
                                  @Param("sourceId") Long sourceId,
                                  @Param("policyCode") String policyCode,
                                  @Param("subjectType") String subjectType,
                                  @Param("subjectKey") String subjectKey,
                                  @Param("userIdx") Long userIdx,
                                  @Param("ipAddress") String ipAddress,
                                  @Param("countryCode") String countryCode,
                                  @Param("asn") String asn,
                                  @Param("riskScore") Integer riskScore,
                                  @Param("riskLevel") String riskLevel,
                                  @Param("confidenceScore") Integer confidenceScore,
                                  @Param("recommendationAction") String recommendationAction,
                                  @Param("recommendationReason") String recommendationReason,
                                  @Param("evidenceSummary") String evidenceSummary,
                                  @Param("decisionStatus") String decisionStatus,
                                  @Param("rawPayload") String rawPayload);

    List<AdminNotificationPreferenceVO> findNotificationPreferences(@Param("userIdx") Long userIdx);
    void upsertNotificationPreference(@Param("userIdx") Long userIdx,
                                      @Param("notificationCategory") String notificationCategory,
                                      @Param("enabled") boolean enabled);
    List<SecurityRiskAssessmentVO> findSecurityRiskAssessments(@Param("assessmentScope") String assessmentScope,
                                                               @Param("sourceKind") String sourceKind,
                                                               @Param("riskLevel") String riskLevel,
                                                               @Param("decisionStatus") String decisionStatus,
                                                               @Param("keyword") String keyword);

    SecurityRiskAssessmentVO findSecurityRiskAssessmentByIdx(@Param("assessmentIdx") Long assessmentIdx);

    Long findSystemUserIdxByUserId(@Param("userId") String userId);

    void insertUserBlockHistoryFromAssessment(@Param("assessmentIdx") Long assessmentIdx,
                                              @Param("blockRequestId") String blockRequestId,
                                              @Param("blockTargetKey") String blockTargetKey,
                                              @Param("userIdx") Long userIdx,
                                              @Param("reason") String reason,
                                              @Param("blockedByUserIdx") Long blockedByUserIdx,
                                              @Param("sourceActionGroupId") String sourceActionGroupId);

    Long findBlockHistoryIdxByRequestId(@Param("blockRequestId") String blockRequestId);

    void upsertUserBlocklistFromAssessment(@Param("sourceHistoryBlockIdx") Long sourceHistoryBlockIdx,
                                           @Param("assessmentIdx") Long assessmentIdx,
                                           @Param("blockRequestId") String blockRequestId,
                                           @Param("blockTargetKey") String blockTargetKey,
                                           @Param("userIdx") Long userIdx,
                                           @Param("reason") String reason,
                                           @Param("blockedByUserIdx") Long blockedByUserIdx,
                                           @Param("sourceActionGroupId") String sourceActionGroupId);

    void updateSecurityRiskAssessmentDecision(@Param("assessmentIdx") Long assessmentIdx,
                                              @Param("decisionStatus") String decisionStatus);

    void updateSecurityRiskAssessmentDecisionByReview(@Param("reviewIdx") Long reviewIdx,
                                                      @Param("decisionStatus") String decisionStatus);

    List<SecurityReviewVO> findSecurityReviews(@Param("status") String status,
                                               @Param("severity") String severity,
                                               @Param("reviewType") String reviewType,
                                               @Param("keyword") String keyword);

    SecurityReviewVO findSecurityReviewByIdx(@Param("reviewIdx") Long reviewIdx);

    void insertSecurityReviewFromAssessment(@Param("assessmentIdx") Long assessmentIdx,
                                            @Param("reviewType") String reviewType,
                                            @Param("severity") String severity,
                                            @Param("summary") String summary,
                                            @Param("detailMessage") String detailMessage);

    void updateSecurityReviewDecision(@Param("reviewIdx") Long reviewIdx,
                                      @Param("reviewStatus") String reviewStatus,
                                      @Param("reviewedByUserIdx") Long reviewedByUserIdx,
                                      @Param("reviewComment") String reviewComment);

    List<SecurityAssessmentProviderConfigVO> findProviderConfigs();

    SecurityAssessmentProviderConfigVO findProviderConfigByIdx(@Param("providerIdx") Long providerIdx);

    void updateProviderConfig(SecurityAssessmentProviderConfigVO config);

    void insertSecurityActionAudit(@Param("actionType") String actionType,
                                   @Param("actorUserIdx") Long actorUserIdx,
                                   @Param("targetType") String targetType,
                                   @Param("targetKey") String targetKey,
                                   @Param("sourceType") String sourceType,
                                   @Param("sourceId") Long sourceId,
                                   @Param("summary") String summary,
                                   @Param("detailMessage") String detailMessage);

    List<SecurityAppealVO> findSecurityAppeals(@Param("status") String status,
                                               @Param("targetType") String targetType,
                                               @Param("keyword") String keyword);

    void updateSecurityAppealDecision(@Param("appealIdx") Long appealIdx,
                                      @Param("appealStatus") String appealStatus,
                                      @Param("reviewedByUserIdx") Long reviewedByUserIdx,
                                      @Param("reviewComment") String reviewComment);


    void insertSecurityAppealToken(@Param("token") String token,
                                   @Param("userIdx") Long userIdx,
                                   @Param("targetType") String targetType,
                                   @Param("targetKey") String targetKey,
                                   @Param("sourceAssessmentIdx") Long sourceAssessmentIdx,
                                   @Param("blockRequestId") String blockRequestId,
                                   @Param("blockAccessRequestId") String blockAccessRequestId,
                                   @Param("expiresAt") java.time.LocalDateTime expiresAt);

    SecurityAppealTokenVO findAppealToken(@Param("token") String token,
                                          @Param("now") java.time.LocalDateTime now);

    void markAppealTokenUsed(@Param("tokenIdx") Long tokenIdx);

    SecurityAppealFormVO findBlockAccessAppealContext(@Param("requestId") String requestId);

    void insertSecurityAppealPublic(@Param("userIdx") Long userIdx,
                                    @Param("targetType") String targetType,
                                    @Param("targetKey") String targetKey,
                                    @Param("sourceAssessmentIdx") Long sourceAssessmentIdx,
                                    @Param("appealTokenIdx") Long appealTokenIdx,
                                    @Param("blockRequestId") String blockRequestId,
                                    @Param("blockAccessRequestId") String blockAccessRequestId,
                                    @Param("inquiryId") Long inquiryId,
                                    @Param("submitterEmail") String submitterEmail,
                                    @Param("publicRequestId") String publicRequestId,
                                    @Param("appealTitle") String appealTitle,
                                    @Param("appealContent") String appealContent);

    void insertSecurityAppealInquiry(@Param("userIdx") Long userIdx,
                                     @Param("title") String title,
                                     @Param("content") String content);

    Long findLatestInquiryIdByUserAndTitle(@Param("userIdx") Long userIdx,
                                           @Param("title") String title);

    SecurityAppealVO findSecurityAppealByIdx(@Param("appealIdx") Long appealIdx);

    void releaseUserBlockByTargetKey(@Param("targetKey") String targetKey,
                                     @Param("actorUserIdx") Long actorUserIdx,
                                     @Param("reason") String reason);

    void insertUserBlockReleaseHistoryFromAppeal(@Param("targetKey") String targetKey,
                                                 @Param("actorUserIdx") Long actorUserIdx,
                                                 @Param("reason") String reason,
                                                 @Param("appealIdx") Long appealIdx);

    void releaseIpBlockByTargetKey(@Param("targetKey") String targetKey,
                                   @Param("actorUserIdx") Long actorUserIdx,
                                   @Param("reason") String reason);

    void restoreUserStatusByTargetKey(@Param("targetKey") String targetKey,
                                      @Param("reason") String reason);


    List<SecurityAssessmentProviderConfigVO> findEnabledExternalAssessmentProviders();

    List<SecurityAssessmentProviderConfigVO> findEnabledWafProviderConfigs();


    List<SecurityWafSyncQueueVO> findWafSyncQueue(@Param("status") String status,
                                                 @Param("targetType") String targetType,
                                                 @Param("keyword") String keyword);

    void resetWafSyncStatus(@Param("syncIdx") Long syncIdx,
                            @Param("reason") String reason);


    Integer countDuplicatePendingAppeal(@Param("targetType") String targetType,
                                        @Param("targetKey") String targetKey,
                                        @Param("blockAccessRequestId") String blockAccessRequestId);

    Integer countRejectedAppealAfter(@Param("targetType") String targetType,
                                     @Param("targetKey") String targetKey,
                                     @Param("blockAccessRequestId") String blockAccessRequestId,
                                     @Param("after") java.time.LocalDateTime after);

    Integer countRejectedAppeals(@Param("targetType") String targetType,
                                 @Param("targetKey") String targetKey,
                                 @Param("blockAccessRequestId") String blockAccessRequestId);

    Integer countIpTargetAppealsToday(@Param("targetKey") String targetKey,
                                      @Param("todayStart") java.time.LocalDateTime todayStart);


    void insertSecurityActionAuditWithReason(@Param("actionType") String actionType,
                                             @Param("actorUserIdx") Long actorUserIdx,
                                             @Param("targetType") String targetType,
                                             @Param("targetKey") String targetKey,
                                             @Param("sourceType") String sourceType,
                                             @Param("sourceId") Long sourceId,
                                             @Param("reasonCode") String reasonCode,
                                             @Param("reasonArgs") String reasonArgs,
                                             @Param("detailMessage") String detailMessage);


    String findUserEmailByUserIdx(@Param("userIdx") Long userIdx);

    String findUserPreferredLangByUserIdx(@Param("userIdx") Long userIdx);
    String findUserAccountStatusByUserIdx(@Param("userIdx") Long userIdx);


}
