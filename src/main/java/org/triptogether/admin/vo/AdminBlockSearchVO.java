package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminBlockSearchVO {
    private String keyword;
    private String status = "ACTIVE"; // ALL / ACTIVE / INACTIVE
    private String scope = "ALL";     // ALL / USER_ACTION / GLOBAL / AUTO_DETECTION
    private String matchType = "ALL"; // ALL / SINGLE_IP / CIDR / RANGE / COUNTRY / ASN
    private String blockType = "ALL"; // ALL / USER_ONLY / IP_ONLY / USER_IP
    private int limit = 100;
}
