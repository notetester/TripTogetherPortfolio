package org.triptogether.courses.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.triptogether.courses.mapper.TravelPlanMapper;
import org.triptogether.courses.vo.TravelPlanVO;

import java.util.List;

@Service
public class TravelPlanServiceImpl implements TravelPlanService {
    @Autowired
    private TravelPlanMapper travelPlanMapper;

    @Override
    public List<TravelPlanVO> getTravelList(TravelPlanVO travelPlanVO) {
        return travelPlanMapper.getTravelList(travelPlanVO);
    }
}
