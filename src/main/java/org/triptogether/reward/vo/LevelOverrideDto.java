package org.triptogether.reward.vo;

import lombok.Data;

/**
 * 특정 레벨의 필요 누적 경험치 오버라이드 정책을 담는 DTO입니다.
 */
@Data
public class LevelOverrideDto {

    private Long expLevelOverrideIdx;
    private Integer levelNo;
    private Long requiredTotalExp;
    private Boolean active;
    private Integer priority;
}
