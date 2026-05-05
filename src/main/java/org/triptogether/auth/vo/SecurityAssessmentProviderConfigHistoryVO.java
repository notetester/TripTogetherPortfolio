package org.triptogether.auth.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class SecurityAssessmentProviderConfigHistoryVO {
    private Long historyIdx;
    private Long providerIdx;
    private String providerCode;
    private String providerKind;
    private Integer versionNo;
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
