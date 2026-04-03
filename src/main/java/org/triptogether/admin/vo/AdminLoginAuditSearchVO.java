package org.triptogether.admin.vo;

import lombok.Data;

/**
 * 로그인 감사 검색 조건.
 */
@Data
public class AdminLoginAuditSearchVO {
    private String keyword;
    private String success;     // ALL / SUCCESS / FAIL
    private String authType;    // ALL / PASSWORD / SOCIAL
    private String loginMethod; // ALL / ID / EMAIL / KAKAO / NAVER / GOOGLE
    private int page = 1;
    private int size = 30;

    public int getOffset() {
        return (page - 1) * size;
    }

    public String getSuccess() { return success != null ? success : "ALL"; }
    public String getAuthType() { return authType != null ? authType : "ALL"; }
    public String getLoginMethod() { return loginMethod != null ? loginMethod : "ALL"; }
}
