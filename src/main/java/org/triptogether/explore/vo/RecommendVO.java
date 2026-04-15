package org.triptogether.explore.vo;

import lombok.Data;
import java.util.List;

/**
 * SPOT_RECOMMEND 테이블 VO + SPOT_TRAVEL JOIN 정보
 */
@Data
public class RecommendVO {
    private Long   recIdx;
    private Long   userIdx;
    private Long   spotIdx;
    private String recReason;     // AI 추천 이유
    private int    recScore;      // Gemini 점수 1~10

    // SPOT_TRAVEL JOIN
    private String spotName;
    private String region;
    private String thumbUrl;
    private Float  ratingAvg;
    private int    reviewCount;
    private int    likeCount;
    private List<String> tags;

    // 사용자 관심 태그와의 실제 일치 수 (정렬 기준)
    private int    tagMatchCount;
}
