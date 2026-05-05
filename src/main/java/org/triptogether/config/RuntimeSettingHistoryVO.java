package org.triptogether.config;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class RuntimeSettingHistoryVO {
    private Long historyIdx;
    private Long settingIdx;
    private String settingKey;
    private Integer versionNo;
    private String changeType;
    private Long actorUserIdx;
    private String beforeValue;
    private String afterValue;
    private String beforeFallbackValue;
    private String afterFallbackValue;
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
