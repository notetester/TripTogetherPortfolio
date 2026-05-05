package org.triptogether.auth.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class SecurityAppealPolicyHistoryVO {
    private Long historyIdx;
    private Long policyIdx;
    private String policyCode;
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
