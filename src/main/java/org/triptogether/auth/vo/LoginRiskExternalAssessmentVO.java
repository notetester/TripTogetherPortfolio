package org.triptogether.auth.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class LoginRiskExternalAssessmentVO {
    private Long assessmentIdx;
    private String sourceKind;
    private String sourceCode;
    private String sourceName;
    private String sourceVersion;
    private String sourceType;
    private Long sourceId;
    private String policyCode;
    private String subjectType;
    private String subjectKey;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String ipAddress;
    private String countryCode;
    private String asn;
    private Integer riskScore;
    private String riskLevel;
    private Integer confidenceScore;
    private String recommendationAction;
    private String recommendationReason;
    private String evidenceSummary;
    private String decisionStatus;
    private String rawPayload;
    private LocalDateTime createdAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }
}
