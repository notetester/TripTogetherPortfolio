package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminCommunitySearchVO {

    private String keyword;
    private String searchType;  // all / title / content / userId / nickname
    private String status;      // ALL / ACTIVE / BLOCKED / DELETED
    private String postType;    // ALL / review / photo / tip / question
    private String flagged;     // ALL / FLAGGED (30일 내 신고 처리 이력 있는 작성자)
    private String sortBy;      // createdAt / reportCount

    private int page = 1;
    private int size = 20;

    public int getOffset() {
        return (page - 1) * size;
    }

    public String getSearchType() { return searchType != null ? searchType : "all"; }
    public String getStatus()     { return status    != null ? status    : "ALL"; }
    public String getPostType()   { return postType  != null ? postType  : "ALL"; }
    public String getFlagged()    { return flagged   != null ? flagged   : "ALL"; }
    public String getSortBy()     { return sortBy    != null ? sortBy    : "createdAt"; }
}
