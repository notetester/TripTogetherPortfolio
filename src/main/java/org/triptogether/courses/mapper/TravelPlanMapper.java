package org.triptogether.courses.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.triptogether.courses.vo.TravelPlanVO;

import java.util.List;

@Mapper
public interface TravelPlanMapper {
    List<TravelPlanVO> getTravelList(TravelPlanVO travelPlanVO);
}
