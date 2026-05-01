package org.triptogether.auth.risk;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class LoginRiskAssessmentResult {
    private String sourceKind;
    private String sourceCode;
    private String sourceName;
    private String sourceVersion;
    private Integer riskScore;
    private String riskLevel;
    private Integer confidenceScore;
    private String recommendationAction;
    private String recommendationReason;
    private String evidenceSummary;
    private String rawPayload;
}
