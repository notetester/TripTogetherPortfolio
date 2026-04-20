package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;

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
}
