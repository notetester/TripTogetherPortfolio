package org.triptogether.superAdmin.vo;

import lombok.Data;

@Data
public class SuperAdminSearchVO {
    private String keyword;
    private String searchType = "all"; // all / userId / nickname / email
    private int page     = 1;
    private int pageSize = 20;

    // 추가 필터
    private String filterDepartment;
    private String filterPermissionCode;
    private String filterAccountStatus;

    public int getOffset() {
        return (page - 1) * pageSize;
    }
}
