package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminActivityLogSearchVO {
    private String keyword;
    private String activityDomain; // ALL / GENERAL / AUTH / ADMIN / ...
    private String activityType; // ALL / PAGE_VIEW / ACTION / AJAX / API
    private String activityProvider; // ALL / LOCAL / KAKAO / NAVER / GOOGLE
    private String authEventType; // ALL / LOGIN / LOGOUT / LINK / UNLINK
    private String httpMethod;   // ALL / GET / POST / PUT / DELETE
    private String success;      // ALL / SUCCESS / FAIL
    private String dateFilter;   // yyyy-MM-dd
    private String sortField;    // time / domain / type / method / status / ip
    private String sortDir;      // ASC / DESC
    private int page = 1;
    private int size = 30;

    public int getOffset() {
        return (page - 1) * size;
    }

    public String getActivityDomain() { return activityDomain != null ? activityDomain : "ALL"; }
    public String getActivityType() { return activityType != null ? activityType : "ALL"; }
    public String getActivityProvider() { return activityProvider != null ? activityProvider : "ALL"; }
    public String getAuthEventType() { return authEventType != null ? authEventType : "ALL"; }
    public String getHttpMethod() { return httpMethod != null ? httpMethod : "ALL"; }
    public String getSuccess() { return success != null ? success : "ALL"; }
    public String getSortField() { return sortField != null ? sortField : ""; }
    public String getSortDir() { return "ASC".equals(sortDir) ? "ASC" : "DESC"; }
}
