package org.triptogether.explore.service;

import org.triptogether.auth.vo.UsersVO;
import org.triptogether.explore.vo.ExploreSearchDto;
import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.explore.vo.ExploreCreateDto;
import org.triptogether.explore.vo.ReviewVO;

import java.util.List;

public interface ExploreService {

    /** ?ы뻾吏 紐⑸줉 (?꾩껜 / 吏??퀎 / ?뚮쭏蹂? */
    List<ExploreVO> getSpotList(ExploreSearchDto search);

    /** ?됱젏??紐⑸줉 */
    List<ExploreVO> getRatingSpotList(ExploreSearchDto search);

    /** 醫뗭븘?붿닚 紐⑸줉 */
    List<ExploreVO> getLikesSpotList(ExploreSearchDto search);

    /**
     * 찜한 여행지 목록
     * - 로그인 사용자가 찜(SPOT_FAVORITE)한 여행지를 조회
     * - 비로그인 상태에서는 빈 목록 반환
     */
    List<ExploreVO> getFavoriteSpotList(ExploreSearchDto search);

    /** ?꾩껜 嫄댁닔 (??뿉 ?곕씪 遺꾧린) */
    int getTotalCount(ExploreSearchDto search);

    /** ?꾩껜 ?섏씠吏 ??*/
    int getTotalPage(ExploreSearchDto search);

    /** 吏??紐⑸줉 */
    List<String> getRegionList();

    /** ?쒓렇(?뚮쭏) 紐⑸줉 */
    List<String> getTagList();
    List<String> getWriteTagList();

    /** ?ы뻾吏 ?곸꽭 */
    ExploreVO getSpotDetail(Long spotIdx, Long loginUserIdx);

    /** ?ы뻾吏 ?깅줉 (?대?吏 ?ы븿) */
    Long createSpot(ExploreCreateDto spotCreateDto, UsersVO loginUser);

    /* ?? 由щ럭 ?? */

    /** 由щ럭 紐⑸줉 議고쉶 */
    List<ReviewVO> getReviewList(Long spotIdx);

    /** 由щ럭 ?묒꽦 媛???щ? (濡쒓렇??+ 以묐났 ?묒꽦 泥댄겕) */
    boolean canWriteReview(Long spotIdx, Long userIdx);

    /** 由щ럭 ?묒꽦 */
    void writeReview(ReviewVO review);

    /** 由щ럭 ??젣 */
    void deleteReview(Long reviewIdx, Long userIdx);

    /* ?? 李?/ 醫뗭븘???? */

    /**
     * 검색 자동완성 후보 목록
     * - 입력된 키워드로 name, region, address를 LIKE 검색
     * - 최대 7건의 후보를 Map(spotIdx, name, region, address) 형태로 반환
     * @param keyword 사용자가 검색창에 입력한 문자열
     * @return 자동완성 후보 리스트
     */
    java.util.List<java.util.Map<String, Object>> getSuggestList(String keyword);

    boolean toggleFavorite(Long spotIdx, Long userIdx);
    boolean toggleLike(Long spotIdx, Long userIdx);
}
