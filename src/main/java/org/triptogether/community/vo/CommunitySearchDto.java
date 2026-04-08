package org.triptogether.community.vo;

import lombok.Data;

/**
 * 커뮤니티 목록 검색 조건 DTO
 * Controller에서 파라미터를 담아 Mapper로 전달
 */
@Data
public class CommunitySearchDto {

    // 필터 조건
    private String  region   = "all";    // all/asia/europe/africa/north_america/south_america/oceania/etc
    private String  type     = "all";    // all/review/photo/tip/question
    private String  sort     = "latest"; // latest/popular/views

    // 검색 조건 (태그 + 제목 + 본문 동시 검색)
    private String  keyword;             // 검색어

    // 페이지네이션
    private int     page     = 1;
    private int     pageSize = 10;
    private int     offset;              // Mapper에서 사용 (page-1) * pageSize

    private boolean adminMode;

    // offset 자동 계산
    public void calcOffset() {
        this.offset = (this.page - 1) * this.pageSize;
    }
}
