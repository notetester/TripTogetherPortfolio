package org.triptogether.config;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class RuntimeSettingVO {
    private Long settingIdx;
    private String settingKey;
    private String settingGroup;
    private String displayName;
    private String settingValue;
    private String fallbackValue;
    private String valueType;
    private boolean secret;
    private boolean editable;
    private boolean active;
    private String description;
    private Long updatedByUserIdx;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        return value == null ? null : Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

    public Date getUpdatedAtDate() {
        return fromLocalDateTime(updatedAt);
    }
}
