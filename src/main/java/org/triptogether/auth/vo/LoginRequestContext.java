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

    /** 로그인 위험 정책으로 사용자에게 안내할 메시지 */
    private String loginRiskMessage;

    /** 로그인 위험 정책 코드 */
    private String loginRiskPolicyCode;

    /** 남은 로그인 시도 횟수. 안내 목적 */
    private Integer remainingAttempts;

    /** 정책에 의해 현재 로그인 시도 자체가 거부되었는지 */
    private boolean loginRiskDenied;

    /** 관리자 검토 또는 보호 조치가 필요한지 */
    private boolean loginRiskReviewRequired;
}
