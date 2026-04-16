package org.triptogether.courses.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.triptogether.courses.vo.PlanSpotVO;
import org.triptogether.courses.vo.SpotTravelVO;
import org.triptogether.courses.vo.TravelPlanVO;

import java.util.List;

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
    void updateTravelPlan(TravelPlanVO travelPlanVO);

    // 여행일정 삭제
    void deleteTravelPlan(TravelPlanVO travelPlanVO);

    // 일정 안 장소 추가
    void insertPlanSpot(PlanSpotVO planSpotVO);

    // 일정 안 장소 전체 삭제
    void deletePlanSpotsByPlanId(Long plan_id);
}
