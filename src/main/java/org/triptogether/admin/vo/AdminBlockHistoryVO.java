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
    private Long userBlocklistIdx;
    private Long ipBlocklistIdx;
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

    public Date getListSyncedAtDate() {
        return listSyncedAt == null ? null : Date.from(listSyncedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getEffectiveSyncedAtDate() {
        return effectiveSyncedAt == null ? null : Date.from(effectiveSyncedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getLastControlAtDate() {
        return lastControlAt == null ? null : Date.from(lastControlAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
