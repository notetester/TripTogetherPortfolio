package org.triptogether.admin.vo;

import lombok.Data;

/**
 * 관리자 여행지/리뷰 관리 검색 조건 VO.
 * 커뮤니티 관리자 검색 VO와 같은 패턴으로 맞춰 화면 재사용성을 높인다.
 */
@Data
public class AdminExploreSearchVO {

    private String keyword;
    private String searchType;   // all / name / region / address / description / nickname
    private String status;       // ALL / ACTIVE / DELETED
    private String reviewStatus; // ALL / ACTIVE / BLOCKED
    private String sortBy;       // createdAt / reviewCount / likeCount / ratingAvg

    private int page = 1;
    private int size = 20;

    public int getOffset() {
        return (page - 1) * size;
    }

    public String getSearchType() {
        return searchType != null ? searchType : "all";
    }

    public String getStatus() {
        return status != null ? status : "ALL";
    }

    public String getReviewStatus() {
        return reviewStatus != null ? reviewStatus : "ALL";
    }

    public String getSortBy() {
        return sortBy != null ? sortBy : "createdAt";
    }
}
