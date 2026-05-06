package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class AdminActionAuditVO {
    private Long adminActionAuditIdx;
    private String actionType;
    private String actionDomain;
    private Long actorUserIdx;
    private String targetType;
    private String targetId;
    private String reasonCode;
    private String reasonArgs;
    private String detailSummary;
    private LocalDateTime createdAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        return value == null ? null : Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }
}
