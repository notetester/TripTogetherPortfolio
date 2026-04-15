package org.triptogether.explore.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.explore.vo.CandidateSpotVO;
import org.triptogether.explore.vo.RecommendVO;
import org.triptogether.explore.vo.SpotViewLogVO;

import java.util.List;

@Mapper
public interface RecommendMapper {

    /* ── SPOT_VIEW_LOG ── */

    /** 조회 로그 저장 */
    void insertViewLog(SpotViewLogVO log);

    /** 최근 N개 로그 조회 (spot 태그 포함) */
    List<SpotViewLogVO> selectRecentViewLogs(@Param("userIdx") Long userIdx,
                                             @Param("limit")   int  limit);

    /* ── 추천 후보 ── */

    /**
     * 미방문 후보 여행지 목록 - 태그 매칭 점수 포함
     * currentSpotIdx: 현재 보고 있는 여행지 (후보에서 제외)
     */
    List<CandidateSpotVO> selectCandidateSpots(
            @Param("userIdx")       Long   userIdx,
            @Param("interestTags")  String interestTags,
            @Param("currentSpotIdx") Long  currentSpotIdx);

    /**
     * 요즘 뜨는 여행지 (폴백)
     * currentSpotIdx: 현재 보고 있는 여행지 (제외)
     */
    List<RecommendVO> selectTrendingSpots(
            @Param("currentSpotIdx") Long currentSpotIdx);

    /** 유효한 추천 캐시 조회 (5분 이내) */
    List<RecommendVO> selectCachedRecommends(@Param("userIdx") Long userIdx);

    /** 이전 추천 spot_idx 목록 (반복 방지용) */
    List<Long> selectPreviousRecommendSpotIds(@Param("userIdx") Long userIdx);

    /** 기존 추천 캐시 삭제 */
    void deleteRecommends(@Param("userIdx") Long userIdx);

    /** 추천 결과 저장 */
    void insertRecommend(RecommendVO rec);

    /** 추천 spot 상세 정보 조회 - 기본 */
    List<RecommendVO> selectRecommendSpots(@Param("userIdx") Long userIdx);

    /**
     * 추천 spot 조회 + 태그 일치 수 계산 (tag_match_count DESC 정렬)
     * currentSpotIdx: 현재 보고 있는 여행지 (결과에서 제외)
     */
    List<RecommendVO> selectRecommendSpotsWithTagMatch(
            @Param("userIdx")        Long   userIdx,
            @Param("interestTags")   String interestTags,
            @Param("currentSpotIdx") Long   currentSpotIdx);
}
