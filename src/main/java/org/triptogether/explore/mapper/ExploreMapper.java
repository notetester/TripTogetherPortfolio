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

    /** 전체 / 지역별 / 테마별 목록 */
    List<ExploreVO> selectSpotList(ExploreSearchDto search);

    /** 전체 건수 (페이징용) */
    int selectTotalCount(ExploreSearchDto search);

    /** 평점순 목록 (SPOT_REVIEW AVG rating DESC) */
    List<ExploreVO> selectRatingSpotList(ExploreSearchDto search);

    /** 평점순 전체 건수 */
    int selectRatingTotalCount(ExploreSearchDto search);

    /** 좋아요순 목록 (SPOT_LIKE COUNT DESC) */
    List<ExploreVO> selectLikesSpotList(ExploreSearchDto search);

    /** 좋아요순 전체 건수 */
    int selectLikesTotalCount(ExploreSearchDto search);

    /* ============================================================
       지역 / 태그 필터 목록
       ============================================================ */

    List<String> selectRegionList();
    List<String> selectTagList();
    List<String> selectAllTagList();

    /* ============================================================
       상세 단건
       ============================================================ */

    ExploreVO selectSpotDetail(@Param("spotIdx") Long spotIdx);
    List<String> selectSpotTags(@Param("spotIdx") Long spotIdx);
    int countBySpotId(@Param("spotId") String spotId);
    void insertSpot(ExploreVO spot);

    /** 여행지 대표 이미지 저장 (SPOT_IMAGE 테이블) */
    void insertSpotImage(@Param("spotIdx") Long spotIdx,
                         @Param("imageId") String imageId,
                         @Param("imageUrl") String imageUrl);
    Integer selectTagIdxByName(@Param("tagName") String tagName);
    void insertSpotTag(@Param("spotIdx") Long spotIdx,
                       @Param("tagIdx") Integer tagIdx);

    /* ============================================================
       리뷰 (SPOT_REVIEW)
       ============================================================ */

    /** 해당 여행지의 리뷰 목록 (최신순) */
    List<ReviewVO> selectReviewList(@Param("spotIdx") Long spotIdx);

    /** 현재 로그인 사용자가 이미 리뷰를 작성했는지 확인 */
    int selectMyReviewCount(@Param("spotIdx") Long spotIdx,
                            @Param("userIdx") Long userIdx);

    /** 리뷰 작성 */
    void insertReview(ReviewVO review);

    /** 리뷰 삭제 (본인만) */
    void deleteReview(@Param("reviewIdx") Long reviewIdx,
                      @Param("userIdx")   Long userIdx);

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
