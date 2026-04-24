package org.triptogether.courses.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.courses.vo.PlanSpotVO;
import org.triptogether.courses.vo.SpotTravelVO;
import org.triptogether.courses.vo.TravelPlanVO;

import java.util.List;
import java.util.Map;

@Mapper
public interface TravelPlanMapper {
    // 여행일정 목록
    List<TravelPlanVO> getTravelList(TravelPlanVO travelPlanVO);

    // 여행일정 상세
    TravelPlanVO getTravelPlanDetail(TravelPlanVO travelPlanVO);

    // 일정 안 장소 목록
    List<PlanSpotVO> getPlanSpotListByPlanId(Long plan_id);

    // 여행지 마스터 목록
    List<SpotTravelVO> getSpotTravelList();

    // 여행일정 생성
    void insertTravelPlan(TravelPlanVO travelPlanVO);

    // 여행일정 수정
    void editTravelPlan(TravelPlanVO travelPlanVO);

    // 여행일정 삭제
    void deleteTravelPlan(TravelPlanVO travelPlanVO);

    // 일정 안 장소 추가
    void insertPlanSpot(PlanSpotVO planSpotVO);

    // 일정 안 장소 전체 삭제
    void deletePlanSpotsByPlanId(Long plan_id);

    // 공개 일정 목록 조회
    List<TravelPlanVO> getPublicTravelList();

    // planId 기준 단건 조회 (공개 상세 조회용)
    TravelPlanVO getTravelPlanDetailByPlanId(Long planId);

    /**
     * 챗봇 컨텍스트용 공개 코스 다중 키워드 검색.
     * title/destination 에 OR LIKE, 최신순.
     */
    List<Map<String, Object>> searchPlansByKeywords(@Param("keywords") List<String> keywords,
                                                      @Param("limit") int limit);
}
