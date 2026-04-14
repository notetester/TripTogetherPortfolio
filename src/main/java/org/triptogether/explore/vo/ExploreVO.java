package org.triptogether.explore.vo;

import lombok.Data;
import java.util.List;

/**
 * SPOT_TRAVEL 테이블 + 관련 정보 VO
 */
@Data
public class ExploreVO {

    // SPOT_TRAVEL
    private Long   spotIdx;
    private String spotId;
    private Long   userIdx;
    private String name;
    private String region;
    private String address;
    private Double latitude;
    private Double longitude;
    private String description;
    private Integer spotActive; // 0: 노출, 1: 삭제(비노출)

    // SPOT_REVIEW 실시간 집계값 (Mapper에서 서브쿼리로 계산)
    private Float  ratingAvg;
    private int    reviewCount;

    // SPOT_LIKE 실시간 집계값
    private int    likeCount;

    // SPOT_IMAGE (대표 이미지 1장)
    private String thumbUrl;

    // SPOT_TAG (태그 목록 - JOIN 후 GROUP_CONCAT → List 변환)
    private String  tagsConcat;   // Mapper에서 GROUP_CONCAT으로 받음
    private List<String> tags;    // Service에서 split 처리

    // SPOT_FAVORITE (현재 로그인 사용자의 찜 여부)
    private boolean favorited;

    // SPOT_LIKE (현재 로그인 사용자의 좋아요 여부)
    private boolean liked;
}

