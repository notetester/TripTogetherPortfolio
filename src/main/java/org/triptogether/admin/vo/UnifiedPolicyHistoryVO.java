package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class UnifiedPolicyHistoryVO {
    private String sourceType;
    private Long sourceId;
    private String itemKey;
    private String changeType;
    private Long actorUserIdx;
    private String beforeConfigJson;
    private String afterConfigJson;
    private LocalDateTime createdAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        return value == null ? null : Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }
}
