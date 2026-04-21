package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class AdminBlockHistoryVO {
    private Long blockIdx;
    private String ruleAction;
    private String controlMode;
    private String operationSource;
    private Long userIdx;
    private String userId;
    private String nickname;
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
    private String historyKind;
    private String blockScope;
    private String ipMatchType;
    private String cidrNotation;
    private String rangeStartIp;
    private String rangeEndIp;
    private Long ipBlockBatchIdx;
    private Long batchOperationIdx;
    private String batchCode;
    private String batchName;
    private LocalDateTime listSyncedAt;
    private Boolean beforeRuleIsActive;
    private Boolean afterRuleIsActive;
    private Boolean beforeBatchIsActive;
    private Boolean afterBatchIsActive;
    private Boolean beforeEffectiveActive;
    private Boolean afterEffectiveActive;
    private String beforeEffectiveStatus;
    private String afterEffectiveStatus;
    private String effectiveResult;
    private String controlReason;

    public Date getBlockedAtDate() {
        return blockedAt == null ? null : Date.from(blockedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getReleasedAtDate() {
        return releasedAt == null ? null : Date.from(releasedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getExpiresAtDate() {
        return expiresAt == null ? null : Date.from(expiresAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getListSyncedAtDate() {
        return listSyncedAt == null ? null : Date.from(listSyncedAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
