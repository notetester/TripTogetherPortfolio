package org.triptogether.auth.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SecurityWafSyncQueueVO {
    private Long syncIdx;
    private String sourceType;
    private Long sourceId;
    private String syncAction;
    private String targetType;
    private String targetValue;
    private String status;
    private String detailMessage;
    private LocalDateTime syncedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
