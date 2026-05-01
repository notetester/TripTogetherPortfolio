package org.triptogether.auth.risk;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class LoginRiskAssessmentRequest {
    private String policyCode;
    private String reviewType;
    private String subjectType;
    private String subjectKey;
    private Long userIdx;
    private String ipAddress;
    private String countryCode;
    private String asn;
    private Integer observedCount;
    private Integer distinctIdentifierCount;
    private String detailMessage;
}
