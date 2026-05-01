package org.triptogether.reward.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * USER_POINT_HISTORY insert 전용 DTO입니다.
 */
@Data
public class PointHistoryCreateDto {

    private Long userIdx;
    private String changeType;
    private String sourceType;
    private Long sourceId;
    private long amount;
    private long balanceAfter;
    private String detailMessage;
    private Long actorUserIdx;
    private Long relatedPurchaseIdx;
    private LocalDateTime createdAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

}
