package org.triptogether.auth.vo;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class LoginRiskDecisionVO {
    private boolean denied;
    private boolean locked;
    private boolean reviewRequired;
    private String policyCode;
    private String actionType;
    private String failReason;
    private String userMessage;
    private Integer remainingAttempts;
    private LocalDateTime blockedUntil;
}
