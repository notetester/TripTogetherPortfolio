package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class AdminSystemPolicyVO {
    private String policyCode;
    private String policyName;
    private String policyGroup;
    private String configJson;
    private String scheduleType;
    private Integer scheduleIntervalHours;
    private Integer scheduleDayOfMonth;
    private String scheduleTime;
    private boolean active;
    private LocalDateTime lastExecutedAt;
    private LocalDateTime nextExecuteAt;
    private String lastExecutionStatus;
    private String lastExecutionMessage;
    private Long createdByUserIdx;
    private Long updatedByUserIdx;
    private String createdByNickname;
    private String updatedByNickname;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Date getLastExecutedAtDate() {
        return lastExecutedAt == null ? null : Date.from(lastExecutedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getNextExecuteAtDate() {
        return nextExecuteAt == null ? null : Date.from(nextExecuteAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return createdAt == null ? null : Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getUpdatedAtDate() {
        return updatedAt == null ? null : Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
