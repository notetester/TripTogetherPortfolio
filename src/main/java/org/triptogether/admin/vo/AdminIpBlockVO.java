package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class AdminIpBlockVO {
    private Long ipBlocklistIdx;
    private String ipAddress;
    private String blockTargetKey;
    private String matchType;
    private String cidrNotation;
    private String rangeStartIp;
    private String rangeEndIp;
    private String countryCode;
    private String asn;
    private String sourceScope;
    private String blockCategory;
    private Long userIdx;
    private String blockType;
    private Long blockedByUserIdx;
    private String blockedByNickname;
    private String reason;
    private boolean active;
    private LocalDateTime blockedAt;
    private LocalDateTime expiresAt;
    private LocalDateTime releasedAt;
    private Long releasedByUserIdx;
    private String releasedByNickname;
    private Integer riskScore;
    private boolean autoBlock;
    private String autoBlockSource;
    private String detailMessage;
    private int priority;
    private Long ipBlockBatchIdx;
    private String batchCode;
    private String batchName;
}
