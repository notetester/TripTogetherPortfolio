package org.triptogether.admin.vo;

import lombok.Data;

import java.util.List;

@Data
public class AdminPolicyFeedImportRequest {
    private String sourceName;
    private String defaultRuleAction;
    private List<AdminPolicyFeedRuleVO> rules;
}
