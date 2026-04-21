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
    private String ruleAction;
    private String controlMode;
    private String ruleOriginType;
    private Long sourceHistoryBlockIdx;
    private Long sourceBlocklistIdx;
    private String blockTargetKey;
    private String targetDisplayValue;
    private LocalDateTime batchBoundAt;
    private Long batchBoundByUserIdx;
    private LocalDateTime batchDetachedAt;
    private Long batchDetachedByUserIdx;
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
    private boolean effectiveActive;
    private String effectiveStatusReason;
    private LocalDateTime effectiveSyncedAt;
    private String effectiveSyncedBySource;
    private LocalDateTime blockedAt;
    private LocalDateTime expiresAt;
    private LocalDateTime releasedAt;
    private Long releasedByUserIdx;
    private String releasedByNickname;
    private Long manualOverrideByUserIdx;
    private String manualOverrideByNickname;
    private LocalDateTime manualOverrideAt;
    private String manualOverrideReason;
    private String lastControlAction;
    private Long lastControlByUserIdx;
    private String lastControlByNickname;
    private LocalDateTime lastControlAt;
    private String lastControlReason;
    private Integer riskScore;
    private boolean autoBlock;
    private String autoBlockSource;
    private String detailMessage;
    private int priority;
    private Long ipBlockBatchIdx;
    private String batchCode;
    private String batchName;
    private Boolean batchActive;
    private String batchSourceType;
    private String batchSourceName;
    private String effectiveStatus;

    public String getRuleActionLabel() {
        return "ALLOW".equalsIgnoreCase(ruleAction) ? "허용" : "차단";
    }

    public String getControlModeLabel() {
        if ("BATCH".equalsIgnoreCase(controlMode)) return "배치 제어";
        if ("MANUAL_OVERRIDE".equalsIgnoreCase(controlMode)) return "수동 예외";
        return "수동";
    }

    public String getEffectiveStatusLabel() {
        if ("EFFECTIVE".equals(effectiveStatus)) return effectiveActive ? "평가중" : "확인필요";
        if ("BATCH_INACTIVE".equals(effectiveStatus)) return "배치 미적용";
        if ("EXPIRED".equals(effectiveStatus)) return "만료";
        if ("RULE_INACTIVE".equals(effectiveStatus)) return "개별 OFF";
        return effectiveActive ? "평가중" : "미적용";
    }

    public String getEffectiveStatusBadgeClass() {
        return effectiveActive ? "ACTIVE" : "DORMANT";
    }

    public String getBatchStatusLabel() {
        if (ipBlockBatchIdx == null) return "개별 규칙";
        return Boolean.TRUE.equals(batchActive) ? "배치 활성" : "배치 비활성";
    }

    public String getRuleStateLabel() {
        return active ? "개별 ON" : "개별 OFF";
    }

    public String getFinalStateLabel() {
        return effectiveActive ? "최종 적용" : "최종 미적용";
    }

    public Date getBlockedAtDate() {
        return blockedAt == null ? null : Date.from(blockedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getBatchBoundAtDate() {
        return batchBoundAt == null ? null : Date.from(batchBoundAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getEffectiveSyncedAtDate() {
        return effectiveSyncedAt == null ? null : Date.from(effectiveSyncedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getExpiresAtDate() {
        return expiresAt == null ? null : Date.from(expiresAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getReleasedAtDate() {
        return releasedAt == null ? null : Date.from(releasedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getManualOverrideAtDate() {
        return manualOverrideAt == null ? null : Date.from(manualOverrideAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getLastControlAtDate() {
        return lastControlAt == null ? null : Date.from(lastControlAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
