package org.triptogether.auth.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class SecurityAssessmentProviderConfigVO {
    private Long providerIdx;
    private String providerCode;
    private String providerKind;
    private String providerName;
    private boolean enabled;
    private String endpointUrl;
    private String apiKeyRef;
    private String modelName;
    private Integer timeoutMillis;
    private Integer failOpen;
    private String status;
    private String description;
    private LocalDateTime lastCheckedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        return value == null ? null : Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getLastCheckedAtDate() { return fromLocalDateTime(lastCheckedAt); }
    public Date getCreatedAtDate() { return fromLocalDateTime(createdAt); }
    public Date getUpdatedAtDate() { return fromLocalDateTime(updatedAt); }
}
