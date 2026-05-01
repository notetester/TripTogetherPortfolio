package org.triptogether.auth.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.auth.vo.AdminNotificationPreferenceVO;
import org.triptogether.auth.vo.LoginRiskPolicyVO;
import org.triptogether.auth.vo.LoginRiskReviewVO;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface LoginRiskPolicyMapper {
    List<LoginRiskPolicyVO> findPolicies(@Param("includeInactive") boolean includeInactive);
    LoginRiskPolicyVO findActivePolicyByCode(@Param("policyCode") String policyCode);
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

    void insertAiAssessment(@Param("sourceType") String sourceType,
                            @Param("sourceId") Long sourceId,
                            @Param("riskScore") Integer riskScore,
                            @Param("riskLabel") String riskLabel,
                            @Param("modelName") String modelName,
                            @Param("summary") String summary,
                            @Param("rawPayload") String rawPayload);

    List<AdminNotificationPreferenceVO> findNotificationPreferences(@Param("userIdx") Long userIdx);
    void upsertNotificationPreference(@Param("userIdx") Long userIdx,
                                      @Param("notificationCategory") String notificationCategory,
                                      @Param("enabled") boolean enabled);
}
