package org.triptogether.home.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 메인 홈 화면에 표시되는 인기 여행지 스팟 VO
 */
@Getter
@Setter
@NoArgsConstructor
public class HomeSpotVO {
    private Long spotIdx;       // 스팟 고유번호
    private String name;        // 스팟 이름
    private String region;      // 지역 구분 (예: domestic/asia/europe...)
    private String description; // 스팟 설명
    private String imageUrl;    // 대표 이미지 URL
    private Float ratingAvg;    // 평균 평점
}
