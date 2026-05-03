package org.triptogether.auth.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SecurityAppealTokenVO {
    private Long tokenIdx;
    private String token;
    private Long userIdx;
    private String targetType;
    private String targetKey;
    private Long sourceAssessmentIdx;
    private String blockRequestId;
    private String blockAccessRequestId;
    private String status;
    private LocalDateTime expiresAt;
    private LocalDateTime usedAt;
    private LocalDateTime createdAt;
}
