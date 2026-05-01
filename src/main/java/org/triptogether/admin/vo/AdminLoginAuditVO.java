package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * 관리자 로그인 감사 화면 VO.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminLoginAuditVO {
    private Long loginIdx;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String eventType;
    private String authType;
    private String authProvider;
    private String authFlow;
    private String loginMethod;
    private String loginIdentifier;
    private String sessionId;
    private String requestUri;
    private String logoutCallbackUri;
    private String requestId;
    private String flowTraceId;
    private boolean success;
    private String failReason;
    private String ipAddress;
    private String userAgent;
    private LocalDateTime loginAt;

    public Date getLoginAt() {
        return loginAt == null ? null : Date.from(loginAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getLoginAtDate() {
        return fromLocalDateTime(loginAt);
    }

}
