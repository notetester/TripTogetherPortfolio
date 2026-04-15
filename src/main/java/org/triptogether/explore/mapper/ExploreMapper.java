package org.triptogether.explore.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.explore.vo.ExploreSearchDto;
import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.explore.vo.ReviewVO;

import java.util.List;

@Mapper
public interface ExploreMapper {

    /* ============================================================
       목록 조회
       ============================================================ */

    /** 전체 / 지역별 / 테마별 목록 조회 */
    List<ExploreVO> selectSpotList(ExploreSearchDto search);

    /** 전체 건수 조회 (페이징용) */
    int selectTotalCount(ExploreSearchDto search);

    /** 평점순 목록 조회 (SPOT_REVIEW AVG rating DESC) */
    List<ExploreVO> selectRatingSpotList(ExploreSearchDto search);

    /** 평점순 전체 건수 조회 */
    int selectRatingTotalCount(ExploreSearchDto search);

    /** 좋아요순 목록 조회 (SPOT_LIKE COUNT DESC) */
    List<ExploreVO> selectLikesSpotList(ExploreSearchDto search);

    /** 좋아요순 전체 건수 조회 */
    int selectLikesTotalCount(ExploreSearchDto search);

    /* ============================================================
       찜한 여행지 (SPOT_FAVORITE 기반)
       - 로그인 사용자가 찜한 여행지 목록을 조회
       ============================================================ */

    /**
     * 찜한 여행지 목록 조회
     * - loginUserIdx(로그인 사용자 PK) 기준으로 SPOT_FAVORITE와 JOIN
     * @param search 검색 조건 DTO (loginUserIdx, keyword, 페이징 정보 포함)
     * @return 해당 사용자가 찜한 여행지 리스트
     */
    List<ExploreVO> selectFavoriteSpotList(ExploreSearchDto search);

    /**
     * 찜한 여행지 전체 건수 (페이징 계산용)
     * @param search 검색 조건 DTO (loginUserIdx 기준)
     * @return 찜한 여행지 총 개수
     */
    int selectFavoriteTotalCount(ExploreSearchDto search);


    /* ============================================================
       지역/태그 필터 목록
       ============================================================ */

    List<String> selectRegionList();
    List<String> selectTagList();
    List<String> selectAllTagList();

    /**
     * 자동완성 후보 목록 조회
     * - 사용자가 검색창에 입력한 키워드(keyword)와 매칭되는
     *   여행지의 name, region, address를 LIKE 검색하여 최대 7건 반환
     * - 결과는 Map<String, Object> 형태로 spotIdx, name, region을 포함
     * @param keyword 사용자가 입력한 검색어
     * @return 자동완성 후보 리스트 (최대 7건)
     */
    List<java.util.Map<String, Object>> selectSuggestList(@Param("keyword") String keyword);

    /* ============================================================
       상세 조회
       ============================================================ */

    ExploreVO selectSpotDetail(@Param("spotIdx") Long spotIdx);
    List<String> selectSpotTags(@Param("spotIdx") Long spotIdx);
    int countBySpotId(@Param("spotId") String spotId);
    void insertSpot(ExploreVO spot);
    void updateSpot(ExploreVO spot);
    void softDeleteSpot(@Param("spotIdx") Long spotIdx);

    /** 여행지 대표 이미지 저장 (SPOT_IMAGE 테이블) */
    void insertSpotImage(@Param("spotIdx") Long spotIdx,
                         @Param("imageId") String imageId,
                         @Param("imageUrl") String imageUrl);
    void deleteSpotImages(@Param("spotIdx") Long spotIdx);
    Integer selectTagIdxByName(@Param("tagName") String tagName);
    void insertSpotTag(@Param("spotIdx") Long spotIdx,
                       @Param("tagIdx") Integer tagIdx);
    void deleteSpotTags(@Param("spotIdx") Long spotIdx);

    /* ============================================================
       리뷰 (SPOT_REVIEW)
       ============================================================ */

    /** 해당 여행지의 리뷰 목록 조회 (최신순) */
    List<ReviewVO> selectReviewList(@Param("spotIdx") Long spotIdx);

    /** 현재 로그인 사용자가 이미 리뷰를 작성했는지 확인 */
    int selectMyReviewCount(@Param("spotIdx") Long spotIdx,
                            @Param("userIdx") Long userIdx);

    /** 리뷰 작성 */
    void insertReview(ReviewVO review);

    /** 리뷰 삭제 (본인만 가능) */
    void deleteReview(@Param("reviewIdx") Long reviewIdx,
                      @Param("userIdx")   Long userIdx);
    void blockReview(@Param("reviewIdx") Long reviewIdx,
                     @Param("spotIdx") Long spotIdx);
    void blockReviews(@Param("spotIdx") Long spotIdx,
                      @Param("reviewIdxList") List<Long> reviewIdxList);

    /* ============================================================
       찜 (SPOT_FAVORITE)
       ============================================================ */

    int  selectFavoriteCount(@Param("spotIdx") Long spotIdx,
                             @Param("userIdx") Long userIdx);
    void insertFavorite(@Param("spotIdx") Long spotIdx,
                        @Param("userIdx") Long userIdx);
    void deleteFavorite(@Param("spotIdx") Long spotIdx,
                        @Param("userIdx") Long userIdx);

    /* ============================================================
       좋아요 (SPOT_LIKE)
       ============================================================ */

    int  selectLikeCount(@Param("spotIdx") Long spotIdx,
                         @Param("userIdx") Long userIdx);
    void insertLike(@Param("spotIdx") Long spotIdx,
                    @Param("userIdx") Long userIdx);
    void deleteLike(@Param("spotIdx") Long spotIdx,
                    @Param("userIdx") Long userIdx);
}
