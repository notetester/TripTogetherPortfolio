package org.triptogether.courses.service;

import org.triptogether.courses.vo.TravelPlanVO;

import java.util.List;

public interface TravelPlanService {
    List<TravelPlanVO> getTravelList(TravelPlanVO travelPlanVO);
}
