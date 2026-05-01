package org.triptogether.common.vo;

import lombok.Builder;
import lombok.Data;

/**
 * IP/회원 차단 판단 결과.
 */
@Data
@Builder
public class BlockDecisionVO {
    private boolean blocked;
    private String blockKind;       // IP / USER
    private String ruleAction;      // BLOCK / ALLOW
    private String matchType;       // SINGLE_IP / CIDR / RANGE / COUNTRY / ASN / USER_ONLY / USER_IP / ACCOUNT_STATUS
    private String targetKey;
    private String requestId;
    private Long userIdx;
    private Long ruleIdx;
    private String reason;
    private String detailMessage;
    private Integer priority;
    private String sourceActionType;
    private String sourceActionGroupId;
    private Long sourceUserIdx;
    private String sourceIpAddress;

    public static BlockDecisionVO allow() {
        return BlockDecisionVO.builder().blocked(false).ruleAction("ALLOW").build();
    }

    public static BlockDecisionVO blockIp(IpBlockRuleVO rule, String matchType) {
        return BlockDecisionVO.builder()
                .blocked(true)
                .blockKind("IP")
                .ruleAction(rule == null ? "BLOCK" : rule.getRuleAction())
                .matchType(matchType)
                .targetKey(rule == null ? null : rule.getBlockTargetKey())
                .requestId(rule == null ? null : rule.getBlockRequestId())
                .userIdx(rule == null ? null : rule.getUserIdx())
                .ruleIdx(rule == null ? null : rule.getIpBlocklistIdx())
                .reason(rule == null ? null : rule.getReason())
                .detailMessage(rule == null ? null : rule.getDetailMessage())
                .priority(rule == null ? null : rule.getPriority())
                .sourceActionType(rule == null ? null : rule.getSourceActionType())
                .sourceActionGroupId(rule == null ? null : rule.getSourceActionGroupId())
                .sourceUserIdx(rule == null ? null : rule.getSourceUserIdx())
                .sourceIpAddress(rule == null ? null : rule.getSourceIpAddress())
                .build();
    }

    public static BlockDecisionVO blockUser(UserBlockRuleVO rule) {
        return BlockDecisionVO.builder()
                .blocked(true)
                .blockKind("USER")
                .ruleAction("BLOCK")
                .matchType(rule == null ? "ACCOUNT_STATUS" : rule.getBlockType())
                .targetKey(rule == null ? null : rule.getBlockTargetKey())
                .requestId(rule == null ? null : rule.getBlockRequestId())
                .userIdx(rule == null ? null : rule.getUserIdx())
                .ruleIdx(rule == null ? null : rule.getBlockIdx())
                .reason(rule == null ? null : rule.getReason())
                .detailMessage(rule == null ? null : rule.getReason())
                .priority(999)
                .sourceActionType(rule == null ? null : rule.getSourceActionType())
                .sourceActionGroupId(rule == null ? null : rule.getSourceActionGroupId())
                .sourceUserIdx(rule == null ? null : rule.getSourceUserIdx())
                .sourceIpAddress(rule == null ? null : rule.getSourceIpAddress())
                .build();
    }
}
