package org.triptogether.superAdmin.vo;

import lombok.Data;

@Data
public class SuperAdminSearchVO {
    private String keyword;
    private String searchType = "all"; // all / userId / nickname / email
    private int page = 1;
    private int pageSize = 20;

    public int getOffset() {
        return (page - 1) * pageSize;
    }
}
