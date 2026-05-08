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

    private LocalDateTime deletedAt;
    private Long deletedByUserIdx;
    private Long createdByUserIdx;
    private Long updatedByUserIdx;
    private Integer currentVersionNo;
    private Integer priority;
    private Integer healthCheckIntervalSec;
    private LocalDateTime nextHealthCheckAt;
    private String usageCategories;
    private String triggerEvents;
    private String requestMethod;
    private String requestHeadersJson;
    private String requestTemplateJson;
    private String responseMappingJson;
    private Integer maxConcurrent;
    private Integer ratePerMinute;
    private Integer retryCount;
    private Integer retryBackoffMs;
    private String tags;

    private String createdByUserId;
    private String updatedByUserId;
    private String deletedByUserId;

    private Date fromLocalDateTime(LocalDateTime value) {
        return value == null ? null : Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getLastCheckedAtDate() { return fromLocalDateTime(lastCheckedAt); }
    public Date getCreatedAtDate() { return fromLocalDateTime(createdAt); }
    public Date getUpdatedAtDate() { return fromLocalDateTime(updatedAt); }
    public Date getDeletedAtDate() { return fromLocalDateTime(deletedAt); }
    public Date getNextHealthCheckAtDate() { return fromLocalDateTime(nextHealthCheckAt); }

    public boolean isDeleted() { return deletedAt != null; }
}
