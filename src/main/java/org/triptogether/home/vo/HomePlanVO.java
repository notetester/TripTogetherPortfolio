package org.triptogether.home.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 메인 홈 화면에 표시되는 트렌딩 여행 플랜 VO
 */
@Getter
@Setter
@NoArgsConstructor
public class HomePlanVO {
    private Long planId;        // 플랜 ID
    private String title;       // 플랜 제목
    private String destination; // 여행지
    private String nickname;    // 작성자 닉네임
    private Integer nights;     // 숙박일수 (박 수)
    private String imageUrl;    // 대표 이미지 URL (랜덤 배정)
}
