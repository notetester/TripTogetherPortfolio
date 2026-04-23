package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminCourseSearchVO {

    private String keyword;
    private String searchType;   // all / title / destination / nickname / userId
    private String status;       // ALL / ACTIVE / DELETED (is_deleted 기준)
    private String planSource;   // ALL / MANUAL / AI
    private String isPublic;     // ALL / PUBLIC / PRIVATE
    private String sortBy;       // createdAt / updatedAt / startDate

    private int page = 1;
    private int size = 20;

    public int getOffset() {
        return (page - 1) * size;
    }

    public String getSearchType() { return searchType != null ? searchType : "all"; }
    public String getStatus()     { return status     != null ? status     : "ALL"; }
    public String getPlanSource() { return planSource != null ? planSource : "ALL"; }
    public String getIsPublic()   { return isPublic   != null ? isPublic   : "ALL"; }
    public String getSortBy()     { return sortBy     != null ? sortBy     : "createdAt"; }
}
