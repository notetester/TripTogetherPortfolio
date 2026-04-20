package org.triptogether.reward.vo;

import lombok.Data;

/**
 * 포인트/경험치 정책 테이블을 공통 형태로 읽기 위한 DTO입니다.
 * reward_code 별 정책값을 서비스에서 동일한 방식으로 계산할 수 있게 맞춥니다.
 */
@Data
public class RewardPolicyDto {

    private Long policyIdx;
    private String rewardCode;
    private String policyName;
    private String rewardType;
    private Integer rewardValue;
    private Long unitAmount;
    private Boolean active;
    private String description;
    private Integer priority;
}
