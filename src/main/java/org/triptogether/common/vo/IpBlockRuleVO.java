package org.triptogether.common.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * IP 차단 규칙/현재 상태 조회용 VO.
 *
 * <p>IP_BLOCKLIST 의 현재 규칙과 USER_BLOCK_HISTORY 의 최근 이력을
 * 공통 형태로 다룰 수 있게 필요한 필드만 모아둔 객체다.</p>
 */
@Data
public class IpBlockRuleVO {
    private Long ipBlocklistIdx;
    private Long sourceHistoryBlockIdx;
    private Long sourceBlocklistIdx;
    private Long ipBlockBatchIdx;

    private String ipAddress;
    private String blockRequestId;
    private String blockTargetKey;
    private String ruleAction;
    private String controlMode;
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
    private String reason;
    private Integer riskScore;
    private boolean autoBlock;
    private String autoBlockSource;
    private String detailMessage;
    private String sourceActionType;
    private String sourceActionGroupId;
    private Long sourceUserIdx;
    private String sourceIpAddress;
    private int priority;
    private boolean active;
    private boolean effectiveActive;
    private String effectiveStatus;

    private LocalDateTime blockedAt;
    private LocalDateTime expiresAt;
    private LocalDateTime releasedAt;
    private Long releasedByUserIdx;
    private LocalDateTime lastSyncedAt;
    private LocalDateTime updatedAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getBlockedAtDate() {
        return fromLocalDateTime(blockedAt);
    }

    public Date getExpiresAtDate() {
        return fromLocalDateTime(expiresAt);
    }

    public Date getReleasedAtDate() {
        return fromLocalDateTime(releasedAt);
    }

    public Date getLastSyncedAtDate() {
        return fromLocalDateTime(lastSyncedAt);
    }

    public Date getUpdatedAtDate() {
        return fromLocalDateTime(updatedAt);
    }

}
