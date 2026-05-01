package org.triptogether.common.vo;

import lombok.Data;

import java.time.LocalDateTime;

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
}
