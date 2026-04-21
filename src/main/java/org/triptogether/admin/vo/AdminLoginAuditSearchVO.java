package org.triptogether.admin.vo;

import lombok.Data;

/**
 * 로그인 감사 검색 조건.
 */
@Data
public class AdminLoginAuditSearchVO {
    private String keyword;
    private String success;     // ALL / SUCCESS / FAIL
    private String eventType;   // ALL / LOGIN / LOGOUT
    private String authType;    // ALL / PASSWORD / SOCIAL
    private String authProvider; // ALL / LOCAL / KAKAO / NAVER / GOOGLE
    private String loginMethod; // ALL / ID / EMAIL / KAKAO / NAVER / GOOGLE
    private int page = 1;
    private int size = 30;

    public int getOffset() {
        return (page - 1) * size;
    }

    public String getSuccess() { return success != null ? success : "ALL"; }
    public String getEventType() { return eventType != null ? eventType : "ALL"; }
    public String getAuthType() { return authType != null ? authType : "ALL"; }
    public String getAuthProvider() { return authProvider != null ? authProvider : "ALL"; }
    public String getLoginMethod() { return loginMethod != null ? loginMethod : "ALL"; }
}
