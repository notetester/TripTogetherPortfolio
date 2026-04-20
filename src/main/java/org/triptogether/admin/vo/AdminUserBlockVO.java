package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class AdminUserBlockVO {
    private Long blockIdx;
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
    private String blockScope;
    private String ipMatchType;

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
}
