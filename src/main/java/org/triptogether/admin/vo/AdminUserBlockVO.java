package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.ZoneId;
import java.util.Date;

@Data
public class AdminUserBlockVO {
    private static final DateTimeFormatter INPUT_DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

    private Long blockIdx;
    private Long sourceHistoryBlockIdx;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String userEmail;
    private String blockType;
    private String blockedIp;
    private boolean active;
    private String reason;
    private Long blockedByUserIdx;
    private String blockedByNickname;
    private Long releasedByUserIdx;
    private String releasedByNickname;
    private LocalDateTime blockedAt;
    private LocalDateTime releasedAt;
    private LocalDateTime expiresAt;
    private String blockRequestId;
    private String blockTargetKey;
    private String snapshotStatus;
    private LocalDateTime lastHistoryAt;
    private LocalDateTime syncedAt;
    private Long updatedByUserIdx;
    private String blockScope;
    private String ipMatchType;
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
    private String lastControlByNickname;
    private LocalDateTime lastControlAt;
    private String lastControlReason;
    private Long sourceAssessmentIdx;
    private String sourceActionType;
    private String sourceActionGroupId;
    private Long sourceUserIdx;
    private String sourceIpAddress;

    public Date getBlockedAtDate() {
        return blockedAt == null ? null : Date.from(blockedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getReleasedAtDate() {
        return releasedAt == null ? null : Date.from(releasedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getExpiresAtDate() {
        return expiresAt == null ? null : Date.from(expiresAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getLastHistoryAtDate() {
        return lastHistoryAt == null ? null : Date.from(lastHistoryAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getSyncedAtDate() {
        return syncedAt == null ? null : Date.from(syncedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getEffectiveSyncedAtDate() {
        return effectiveSyncedAt == null ? null : Date.from(effectiveSyncedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getLastControlAtDate() {
        return lastControlAt == null ? null : Date.from(lastControlAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public String getExpiresAtInputValue() {
        return expiresAt == null ? "" : expiresAt.format(INPUT_DATE_TIME_FORMATTER);
    }
}
