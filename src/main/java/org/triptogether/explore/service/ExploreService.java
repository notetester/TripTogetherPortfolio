package org.triptogether.explore.service;

import org.triptogether.auth.vo.UsersVO;
import org.triptogether.explore.vo.ExploreSearchDto;
import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.explore.vo.ExploreCreateDto;
import org.triptogether.explore.vo.ReviewVO;

import java.util.List;

public interface ExploreService {

    /** 여행지 목록 조회 (전체 / 지역별 / 테마별) */
    List<ExploreVO> getSpotList(ExploreSearchDto search);

    /** 평점순 목록 조회 */
    List<ExploreVO> getRatingSpotList(ExploreSearchDto search);

    /** 좋아요순 목록 조회 */
    List<ExploreVO> getLikesSpotList(ExploreSearchDto search);

    /**
     * 찜한 여행지 목록
     * - 로그인 사용자가 찜(SPOT_FAVORITE)한 여행지를 조회
     * - 비로그인 상태에서는 빈 목록 반환
     */
    List<ExploreVO> getFavoriteSpotList(ExploreSearchDto search);

    /** 전체 건수 조회 (탭에 따라 분기) */
    int getTotalCount(ExploreSearchDto search);

    /** 전체 페이지 수 조회 */
    int getTotalPage(ExploreSearchDto search);

    /** 지역 목록 조회 */
    List<String> getRegionList();

    /** 태그(테마) 목록 조회 */
    List<String> getTagList();
    List<String> getWriteTagList();

    /** 여행지 상세 조회 */
    ExploreVO getSpotDetail(Long spotIdx, Long loginUserIdx);

    /** 여행지 등록 (이미지 포함) */
    Long createSpot(ExploreCreateDto spotCreateDto, UsersVO loginUser);

    /** 관리자 여행지 수정 */
    void updateSpot(Long spotIdx, ExploreCreateDto spotCreateDto, UsersVO loginUser);

    /** 관리자 여행지 삭제(soft delete) */
    void softDeleteSpot(Long spotIdx);

    /* 리뷰 관련 기능 */

    /** 리뷰 목록 조회 */
    List<ReviewVO> getReviewList(Long spotIdx);

    /** 리뷰 작성 가능 여부 확인 (로그인 + 중복 작성 체크) */
    boolean canWriteReview(Long spotIdx, Long userIdx);

    /** 리뷰 작성 */
    void writeReview(ReviewVO review);

    /** 리뷰 삭제 */
    void deleteReview(Long reviewIdx, Long userIdx);

    /** 관리자 리뷰 차단 */
    void blockReview(Long spotIdx, Long reviewIdx);

    /* 찜/좋아요 관련 기능 */

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
