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
    private String authType;
    private String loginMethod;
    private String loginIdentifier;
    private boolean success;
    private String failReason;
    private String ipAddress;
    private String userAgent;
    private LocalDateTime loginAt;

    public Date getLoginAt() {
        return loginAt == null ? null : Date.from(loginAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
