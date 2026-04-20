package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class AdminIpBlockVO {
    private Long ipBlocklistIdx;
    private String ipAddress;
    private String blockRequestId;
    private Long sourceHistoryBlockIdx;
    private Long sourceBlocklistIdx;
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
    private Boolean batchActive;
    private String effectiveStatus;

    public String getEffectiveStatusLabel() {
        if ("APPLIED".equals(effectiveStatus)) return "적용중";
        if ("BATCH_INACTIVE".equals(effectiveStatus)) return "배치꺼짐";
        if ("EXPIRED".equals(effectiveStatus)) return "만료";
        if ("RULE_INACTIVE".equals(effectiveStatus)) return "규칙꺼짐";
        return active ? "확인필요" : "규칙꺼짐";
    }

    public String getEffectiveStatusBadgeClass() {
        return "APPLIED".equals(effectiveStatus) ? "ACTIVE" : "DORMANT";
    }

    public String getBatchStatusLabel() {
        if (ipBlockBatchIdx == null) return "개별 규칙";
        return Boolean.TRUE.equals(batchActive) ? "배치 활성" : "배치 비활성";
    }

    public Date getBlockedAtDate() {
        return blockedAt == null ? null : Date.from(blockedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getExpiresAtDate() {
        return expiresAt == null ? null : Date.from(expiresAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getReleasedAtDate() {
        return releasedAt == null ? null : Date.from(releasedAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
