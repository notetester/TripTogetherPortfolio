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
    private boolean active;
    private String description;
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

    public String getActiveLabel() {
        return active ? "ACTIVE" : "INACTIVE";
    }

    public Date getCreatedAtDate() {
        return createdAt == null ? null : Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getUpdatedAtDate() {
        return updatedAt == null ? null : Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
