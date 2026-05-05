package org.triptogether.auth.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class SecurityAppealPolicyVO {
    private Long policyIdx;
    private String policyCode;
    private boolean active;
    private boolean allowMultipleOpenAppeals;
    private Integer maxOpenAppealsPerCase;
    private boolean closedBlocksNewAppeals;
    private Integer rejectedCooldownMinutes;
    private Integer maxRejectedCount;
    private Integer ipDailyAppealLimit;
    private Integer verificationWindowMinutes;
    private Integer maxVerificationEmails;
    private Integer verificationTokenTtlMinutes;
    private Integer resultLookupWindowMinutes;
    private Integer maxResultLookupFailures;
    private Integer resultLookupRetentionDays;
    private String allowedEmailDomains;
    private String blockedEmailDomains;
    private boolean captchaEnabled;
    private String captchaProviderCode;
    private String description;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        return value == null ? null : Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

    public Date getUpdatedAtDate() {
        return fromLocalDateTime(updatedAt);
    }
}
