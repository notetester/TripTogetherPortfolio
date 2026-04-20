package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;

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
}
