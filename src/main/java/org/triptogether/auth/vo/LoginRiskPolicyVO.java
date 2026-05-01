package org.triptogether.auth.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

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
    private boolean aiAssistEnabled;
    private Integer aiRiskScoreThreshold;
    private boolean wafSyncEnabled;
    private String description;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

    public Date getUpdatedAtDate() {
        return fromLocalDateTime(updatedAt);
    }
}
