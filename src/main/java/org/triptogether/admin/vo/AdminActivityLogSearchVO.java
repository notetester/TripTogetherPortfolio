package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminActivityLogSearchVO {
    private String keyword;
    private String activityType; // ALL / PAGE_VIEW / ACTION / AJAX / API
    private String httpMethod;   // ALL / GET / POST / PUT / DELETE
    private String success;      // ALL / SUCCESS / FAIL
    private int page = 1;
    private int size = 30;

    public int getOffset() {
        return (page - 1) * size;
    }

    public String getActivityType() { return activityType != null ? activityType : "ALL"; }
    public String getHttpMethod() { return httpMethod != null ? httpMethod : "ALL"; }
    public String getSuccess() { return success != null ? success : "ALL"; }
}
