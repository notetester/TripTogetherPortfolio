package org.triptogether.auth.vo;
import lombok.*;
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class LoginHistoryCommand {
    private Long userIdx;
    private String eventType;
    private String authType;
    private String authProvider;
    private String authFlow;
    private String loginMethod;
    private String loginIdentifier;
    private boolean success;
    private String failReason;
    private String sessionId;
    private String requestUri;
    private String logoutCallbackUri;
    private String requestId;
    private String flowTraceId;
    private String ipAddress;
    private String userAgent;
}
