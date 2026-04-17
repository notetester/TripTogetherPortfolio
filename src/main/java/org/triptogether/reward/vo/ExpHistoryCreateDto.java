package org.triptogether.reward.vo;

import lombok.Data;

import java.time.LocalDateTime;

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
}
