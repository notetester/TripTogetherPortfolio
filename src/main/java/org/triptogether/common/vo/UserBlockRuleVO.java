package org.triptogether.common.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * USER_BLOCKLIST 현재 차단 규칙 캐시/판단용 VO.
 */
@Data
public class UserBlockRuleVO {
    private Long blockIdx;
    private Long sourceHistoryBlockIdx;
    private String blockRequestId;
    private String blockTargetKey;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String blockType;
    private String blockedIp;
    private boolean active;
    private String snapshotStatus;
    private String reason;
    private String ruleAction;
    private String controlMode;
    private String ruleOriginType;
    private String sourceScope;
    private String blockCategory;
    private Integer riskScore;
    private boolean autoBlock;
    private String autoBlockSource;
    private String detailMessage;
    private Integer priority;
    private boolean effectiveActive;
    private String effectiveStatus;
    private String effectiveStatusReason;
    private LocalDateTime effectiveSyncedAt;
    private String lastControlAction;
    private Long lastControlByUserIdx;
    private LocalDateTime lastControlAt;
    private String lastControlReason;
    private Long sourceAssessmentIdx;
    private String sourceActionType;
    private String sourceActionGroupId;
    private Long sourceUserIdx;
    private String sourceIpAddress;
    private Long blockedByUserIdx;
    private LocalDateTime blockedAt;
    private Long releasedByUserIdx;
    private LocalDateTime releasedAt;
    private LocalDateTime expiresAt;
    private LocalDateTime updatedAt;
    private LocalDateTime syncedAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getBlockedAtDate() {
        return fromLocalDateTime(blockedAt);
    }

    public Date getReleasedAtDate() {
        return fromLocalDateTime(releasedAt);
    }

    public Date getExpiresAtDate() {
        return fromLocalDateTime(expiresAt);
    }

    public Date getUpdatedAtDate() {
        return fromLocalDateTime(updatedAt);
    }

    public Date getSyncedAtDate() {
        return fromLocalDateTime(syncedAt);
    }

    public Date getEffectiveSyncedAtDate() {
        return fromLocalDateTime(effectiveSyncedAt);
    }

    public Date getLastControlAtDate() {
        return fromLocalDateTime(lastControlAt);
    }

}
