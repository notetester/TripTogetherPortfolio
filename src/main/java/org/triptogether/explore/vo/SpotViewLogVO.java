package org.triptogether.explore.vo;

import lombok.Data;
import java.util.Date;

/**
 * SPOT_VIEW_LOG 테이블 VO
 * 사용자의 여행지 페이지 체류 기록
 */
@Data
public class SpotViewLogVO {
    private Long   logIdx;
    private Long   userIdx;
    private Long   spotIdx;
    private int    staySeconds;  // 체류 시간(초)
    private Date   viewedAt;

    // JOIN 용
    private String spotName;
    private String tagsConcat;   // GROUP_CONCAT 으로 받아 Service에서 split
    private int    visitCount;   // 동일 spot 방문 횟수 집계용

    public java.util.Date getViewedAtDate() {
        return viewedAt;
    }

}
