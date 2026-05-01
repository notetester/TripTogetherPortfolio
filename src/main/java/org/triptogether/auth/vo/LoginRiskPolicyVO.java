package org.triptogether.auth.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class LoginRiskPolicyVO {
    private Long policyIdx;
    private String policyCode;
    private String policyName;
    private String policyType;
    private boolean active;
    private Integer observationMinutes;
    private Integer thresholdCount;
    private Integer distinctAccountThreshold;
    private Integer lockDurationMinutes;
    private Integer warningBeforeCount;
    private boolean resetOnSuccess;
    private String actionType;
    private boolean requireAdminReview;
    private String reviewSeverity;
    private String notificationCategory;
    private String description;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
