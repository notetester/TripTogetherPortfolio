package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class AdminIpBlockBatchVO {
    private Long ipBlockBatchIdx;
    private String batchCode;
    private String batchName;
    private String sourceType;
    private String sourceName;
    private String batchRuleAction;
    private Integer defaultRulePriority;
    private boolean active;
    private String description;
    private String defaultDisableStrategy;
    private String defaultEnableStrategy;
    private Long createdByUserIdx;
    private String createdByNickname;
    private Long updatedByUserIdx;
    private String updatedByNickname;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private long totalRuleCount;
    private long activeRuleCount;
    private long effectiveRuleCount;
    private long expiredRuleCount;
    private long batchManagedRuleCount;
    private long manualOverrideRuleCount;
    private long allowRuleCount;
    private long blockRuleCount;

    public String getActiveLabel() {
        return active ? "ACTIVE" : "INACTIVE";
    }

    public String getBatchRuleActionLabel() {
        return "ALLOW".equalsIgnoreCase(batchRuleAction) ? "허용 기본" : "차단 기본";
    }

    public String getDefaultDisableStrategyLabel() {
        if ("CASCADE_ACTIVE_RULES".equalsIgnoreCase(defaultDisableStrategy)) return "규칙도 함께 OFF";
        return "배치만 OFF";
    }

    public String getDefaultEnableStrategyLabel() {
        if ("RESTORE_BATCH_CONTROL".equalsIgnoreCase(defaultEnableStrategy)) return "배치 복구";
        if ("FORCE_ENABLE_ALL".equalsIgnoreCase(defaultEnableStrategy)) return "전부 ON";
        return "배치만 ON";
    }

    public Date getCreatedAtDate() {
        return createdAt == null ? null : Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getUpdatedAtDate() {
        return updatedAt == null ? null : Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
