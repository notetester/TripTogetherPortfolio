package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminBlockSearchVO {
    private String keyword;
    private String status = "ALL"; // ALL / ACTIVE / INACTIVE
    private String scope = "ALL";     // ALL / USER_ACTION / GLOBAL / AUTO_DETECTION
    private String matchType = "ALL"; // ALL / SINGLE_IP / CIDR / RANGE / COUNTRY / ASN
    private String blockType = "ALL"; // ALL / USER_ONLY / IP_ONLY / USER_IP
    private String ruleAction = "ALL"; // ALL / BLOCK / ALLOW
    private String controlMode = "ALL"; // ALL / MANUAL / BATCH / MANUAL_OVERRIDE
    private String category = "ALL";  // ALL / SPAM / ABUSE / BRUTE_FORCE / GEO / VPN / MANUAL / SECURITY
    private String effectiveStatus = "ALL"; // ALL / EFFECTIVE / RULE_INACTIVE / BATCH_INACTIVE / EXPIRED
    private Long batchId;
    private int limit = 100;
}
