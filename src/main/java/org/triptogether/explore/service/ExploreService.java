package org.triptogether.explore.service;

import org.triptogether.explore.vo.ExploreSearchDto;
import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.explore.vo.ReviewVO;

import java.util.List;

public interface ExploreService {

    /** 여행지 목록 (전체 / 지역별 / 테마별) */
    List<ExploreVO> getSpotList(ExploreSearchDto search);

    /** 평점순 목록 */
    List<ExploreVO> getRatingSpotList(ExploreSearchDto search);

    /** 좋아요순 목록 */
    List<ExploreVO> getLikesSpotList(ExploreSearchDto search);

    /** 전체 건수 (탭에 따라 분기) */
    int getTotalCount(ExploreSearchDto search);

    /** 전체 페이지 수 */
    int getTotalPage(ExploreSearchDto search);

    /** 지역 목록 */
    List<String> getRegionList();

    /** 태그(테마) 목록 */
    List<String> getTagList();

    /** 여행지 상세 */
    ExploreVO getSpotDetail(Long spotIdx, Long loginUserIdx);

    /* ── 리뷰 ── */

    /** 리뷰 목록 조회 */
    List<ReviewVO> getReviewList(Long spotIdx);

    /** 리뷰 작성 가능 여부 (로그인 + 중복 작성 체크) */
    boolean canWriteReview(Long spotIdx, Long userIdx);

    /** 리뷰 작성 */
    void writeReview(ReviewVO review);

    /** 리뷰 삭제 */
    void deleteReview(Long reviewIdx, Long userIdx);

    /* ── 찜 / 좋아요 ── */

    boolean toggleFavorite(Long spotIdx, Long userIdx);
    boolean toggleLike(Long spotIdx, Long userIdx);
}
