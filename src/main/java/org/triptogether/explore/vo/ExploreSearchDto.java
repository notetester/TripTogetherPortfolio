package org.triptogether.explore.vo;

import lombok.Data;

/**
 * 여행지 탐색 검색 조건 DTO
 * Controller → Mapper 전달용
 */
@Data
public class ExploreSearchDto {

    // 탭 필터: all / region / theme / rating / likes
    private String tab     = "all";

    // 지역별 필터 (tab=region 일 때 사용)
    // 예: asia / europe / africa / north_america / south_america / oceania / etc
    private String region;

    // 테마별 필터 (tab=theme 일 때 사용, tag_name 과 매칭)
    private String theme;

    // 검색어 (name, region, address, description 통합 검색)
    private String keyword;

    // 페이지네이션
    private int page     = 1;
    private int pageSize = 12;
    private int offset;

    // offset 자동 계산
    public void calcOffset() {
        this.offset = (this.page - 1) * this.pageSize;
    }
}
