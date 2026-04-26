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

    // 서버사이드 페이징/정렬 (B안 모드 전용)
    private int page = 1;          // 1-based
    private int size = 20;         // page size
    private String sortBy;         // whitelist key, null이면 기본 정렬
    private String sortDir = "DESC"; // ASC | DESC
    private String field;          // 검색 필드 (all/target/member/...)
}
