package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Map;

@Data
public class AdminPolicyFeedRuleVO {
    private String matchType;
    private String targetValue;
    private String ruleAction;
    private String reason;
    private String detailMessage;
    private Integer priority;
    private Map<String, Object> attributes;
}
