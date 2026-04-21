package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class AdminSystemPolicyHistoryVO {
    private Long systemPolicyHistoryIdx;
    private String policyCode;
    private String changeType;
    private String beforeConfigJson;
    private String afterConfigJson;
    private String beforeScheduleType;
    private String afterScheduleType;
    private Integer beforeScheduleIntervalHours;
    private Integer afterScheduleIntervalHours;
    private Integer beforeScheduleDayOfMonth;
    private Integer afterScheduleDayOfMonth;
    private String beforeScheduleTime;
    private String afterScheduleTime;
    private Boolean beforeActive;
    private Boolean afterActive;
    private String executionStatus;
    private String executionMessage;
    private Long changedByUserIdx;
    private String changedByNickname;
    private LocalDateTime changedAt;

    public Date getChangedAtDate() {
        return changedAt == null ? null : Date.from(changedAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
