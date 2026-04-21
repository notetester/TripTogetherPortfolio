package org.triptogether.auth.vo;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class LoginRequestContext {
    private String ipAddress;
    private String userAgent;
    private String requestId;
    private String flowTraceId;
    private String sessionId;
    private String requestUri;
    private String logoutCallbackUri;
}
