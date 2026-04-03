package org.triptogether.admin.vo;

import lombok.Data;

/**
 * 문의 관리 검색 조건.
 */
@Data
public class AdminInquirySearchVO {
    private String keyword;
    private String searchType; // all / title / content / nickname
    private String status;     // ALL / PENDING / IN_PROGRESS / COMPLETED
    private String category;   // ALL / service / payment / account / bug / etc
    private String answered;   // ALL / ANSWERED / UNANSWERED
    private int page = 1;
    private int size = 20;

    public int getOffset() {
        return (page - 1) * size;
    }

    public String getSearchType() { return searchType != null ? searchType : "all"; }
    public String getStatus() { return status != null ? status : "ALL"; }
    public String getCategory() { return category != null ? category : "ALL"; }
    public String getAnswered() { return answered != null ? answered : "ALL"; }
}
