package org.triptogether.auth.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

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

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

    public Date getUpdatedAtDate() {
        return fromLocalDateTime(updatedAt);
    }

    public Date getSyncedAtDate() {
        return fromLocalDateTime(syncedAt);
    }
}
