package org.triptogether.courses.service;

import org.triptogether.courses.vo.PlanSpotVO;
import org.triptogether.courses.vo.SpotTravelVO;
import org.triptogether.courses.vo.TravelPlanVO;

import java.util.List;

public interface TravelPlanService {
    List<TravelPlanVO> getTravelList(TravelPlanVO travelPlanVO);

    TravelPlanVO getTravelPlanDetail(TravelPlanVO travelPlanVO);

    List<SpotTravelVO> getSpotTravelList();

    void insertTravelPlan(TravelPlanVO travelPlanVO);

    void updateTravelPlan(TravelPlanVO travelPlanVO);

    void deleteTravelPlan(TravelPlanVO travelPlanVO);

    // TravelPlanService.java
    void insertPlanSpot(PlanSpotVO planSpotVO);
}
