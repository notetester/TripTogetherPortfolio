package org.triptogether.explore.vo;

import lombok.Data;

/**
 * Gemini AI 추천 후보 여행지 VO
 * visitedFlag:    0 = 미방문(우선), 1 = 방문(폴백)
 * tagMatchScore:  유저 관심 태그와 일치하는 태그 수 (높을수록 우선 추천)
 */
@Data
public class CandidateSpotVO {
    private Long   spotIdx;
    private String name;
    private String region;
    private String tagsConcat;    // "태그1,태그2,태그3"
    private int    visitedFlag;   // 0: 미방문, 1: 방문(폴백)
    private int    tagMatchScore; // 관심 태그 일치 수
}
