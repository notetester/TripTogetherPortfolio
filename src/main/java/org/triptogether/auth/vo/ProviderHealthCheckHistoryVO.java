package org.triptogether.auth.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class ProviderHealthCheckHistoryVO {
    private Long healthHistoryIdx;
    private Long providerIdx;
    private String providerCode;
    private String providerKind;
    private String checkSource;
    private String statusBefore;
    private String statusAfter;
    private Long actorUserIdx;
    private String detailMessage;
    private LocalDateTime checkedAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        return value == null ? null : Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCheckedAtDate() {
        return fromLocalDateTime(checkedAt);
    }
}
