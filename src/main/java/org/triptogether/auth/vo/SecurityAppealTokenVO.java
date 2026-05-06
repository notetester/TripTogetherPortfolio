package org.triptogether.auth.vo;


import java.util.Date;
import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;

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
    private String submitterEmail;
    private String status;
    private LocalDateTime expiresAt;
    private LocalDateTime usedAt;
    private LocalDateTime createdAt;
    public Date getCreatedAtDate() {
        return createdAt == null ? null : Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getExpiresAtDate() {
        return expiresAt == null ? null : Date.from(expiresAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getUsedAtDate() {
        return usedAt == null ? null : Date.from(usedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

}
