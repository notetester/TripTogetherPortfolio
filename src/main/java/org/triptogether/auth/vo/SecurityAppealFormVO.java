package org.triptogether.auth.vo;

import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SecurityAppealFormVO {
    private boolean valid;
    private String errorMessage;
    private String token;
    private String requestId;
    private String submitterEmail;
    private boolean emailVerified;
    private String targetType;
    private String targetKey;
    private Long userIdx;
    private Long sourceAssessmentIdx;
    private String blockKind;
    private String blockMatchType;
    private String blockReason;
    private String ipAddress;
    private String pageLang;
}
