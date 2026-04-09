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
       紐⑸줉 議고쉶
       ============================================================ */

    /** ?꾩껜 / 吏??퀎 / ?뚮쭏蹂?紐⑸줉 */
    List<ExploreVO> selectSpotList(ExploreSearchDto search);

    /** ?꾩껜 嫄댁닔 (?섏씠吏뺤슜) */
    int selectTotalCount(ExploreSearchDto search);

    /** ?됱젏??紐⑸줉 (SPOT_REVIEW AVG rating DESC) */
    List<ExploreVO> selectRatingSpotList(ExploreSearchDto search);

    /** ?됱젏???꾩껜 嫄댁닔 */
    int selectRatingTotalCount(ExploreSearchDto search);

    /** 醫뗭븘?붿닚 紐⑸줉 (SPOT_LIKE COUNT DESC) */
    List<ExploreVO> selectLikesSpotList(ExploreSearchDto search);

    /** 醫뗭븘?붿닚 ?꾩껜 嫄댁닔 */
    int selectLikesTotalCount(ExploreSearchDto search);


    /* ============================================================
       吏??/ ?쒓렇 ?꾪꽣 紐⑸줉
       ============================================================ */

    List<String> selectRegionList();
    List<String> selectTagList();
    List<String> selectAllTagList();

    /* ============================================================
       ?곸꽭 ?④굔
       ============================================================ */

    ExploreVO selectSpotDetail(@Param("spotIdx") Long spotIdx);
    List<String> selectSpotTags(@Param("spotIdx") Long spotIdx);
    int countBySpotId(@Param("spotId") String spotId);
    void insertSpot(ExploreVO spot);

    /** ?ы뻾吏 ????대?吏 ???(SPOT_IMAGE ?뚯씠釉? */
    void insertSpotImage(@Param("spotIdx") Long spotIdx,
                         @Param("imageId") String imageId,
                         @Param("imageUrl") String imageUrl);
    Integer selectTagIdxByName(@Param("tagName") String tagName);
    void insertSpotTag(@Param("spotIdx") Long spotIdx,
                       @Param("tagIdx") Integer tagIdx);

    /* ============================================================
       由щ럭 (SPOT_REVIEW)
       ============================================================ */

    /** ?대떦 ?ы뻾吏??由щ럭 紐⑸줉 (理쒖떊?? */
    List<ReviewVO> selectReviewList(@Param("spotIdx") Long spotIdx);

    /** ?꾩옱 濡쒓렇???ъ슜?먭? ?대? 由щ럭瑜??묒꽦?덈뒗吏 ?뺤씤 */
    int selectMyReviewCount(@Param("spotIdx") Long spotIdx,
                            @Param("userIdx") Long userIdx);

    /** 由щ럭 ?묒꽦 */
    void insertReview(ReviewVO review);

    /** 由щ럭 ??젣 (蹂몄씤留? */
    void deleteReview(@Param("reviewIdx") Long reviewIdx,
                      @Param("userIdx")   Long userIdx);

    /* ============================================================
       李?(SPOT_FAVORITE)
       ============================================================ */

    int  selectFavoriteCount(@Param("spotIdx") Long spotIdx,
                             @Param("userIdx") Long userIdx);
    void insertFavorite(@Param("spotIdx") Long spotIdx,
                        @Param("userIdx") Long userIdx);
    void deleteFavorite(@Param("spotIdx") Long spotIdx,
                        @Param("userIdx") Long userIdx);

    /* ============================================================
       醫뗭븘??(SPOT_LIKE)
       ============================================================ */

    int  selectLikeCount(@Param("spotIdx") Long spotIdx,
                         @Param("userIdx") Long userIdx);
    void insertLike(@Param("spotIdx") Long spotIdx,
                    @Param("userIdx") Long userIdx);
    void deleteLike(@Param("spotIdx") Long spotIdx,
                    @Param("userIdx") Long userIdx);
}
