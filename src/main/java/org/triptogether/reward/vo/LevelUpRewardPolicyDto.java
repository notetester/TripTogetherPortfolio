package org.triptogether.reward.vo;

import lombok.Data;

/**
 * 레벨업 보상 정책 1건을 담는 DTO입니다.
 * LEVEL_UP_REWARD_POLICY 테이블을 그대로 매핑합니다.
 */
@Data
public class LevelUpRewardPolicyDto {

    private Long levelUpRewardPolicyIdx;
    private String rewardCode;
    private String policyName;
    private Integer levelNo;
    private String rewardType;
    private Long rewardAmount;
    private String itemCode;
    private boolean repeatable;
    private boolean active;
    private Integer sortOrder;
    private String description;
    private Integer priority;
}
