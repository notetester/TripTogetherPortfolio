package org.triptogether.reward.vo;

import lombok.Data;

import java.math.BigDecimal;

/**
 * 활성 레벨 성장 정책 1건을 담는 DTO입니다.
 */
@Data
public class LevelPolicyDto {

    private Long expLevelPolicyIdx;
    private String policyName;
    private String policyMode;
    private BigDecimal quadraticA;
    private BigDecimal quadraticB;
    private BigDecimal quadraticC;
    private BigDecimal expBase;
    private BigDecimal expRate;
    private Integer hybridSwitchLevel;
    private Boolean active;
    private String description;
    private Integer priority;
}
