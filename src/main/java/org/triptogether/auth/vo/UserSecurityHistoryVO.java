package org.triptogether.auth.vo;

import lombok.*;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserSecurityHistoryVO {
    private Long securityIdx;
    private Long userIdx;
    private Long actorUserIdx;
    private String eventType;
    private String eventStage;
    private String inputIdentifier;
    private String targetEmail;
    private boolean success;
    private String failReason;
    private String detailMessage;
    private String requestId;
    private String flowTraceId;
    private String ipAddress;
    private String userAgent;
    private LocalDateTime occurredAt;
}
