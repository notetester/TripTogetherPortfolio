package org.triptogether.reward.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * USER_EXP_HISTORY insert 전용 DTO입니다.
 */
@Data
public class ExpHistoryCreateDto {

    private Long userIdx;
    private String sourceType;
    private Long sourceId;
    private int expAmount;
    private int levelAfter;
    private long expAfter;
    private String detailMessage;
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
