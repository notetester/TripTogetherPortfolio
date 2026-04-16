package org.triptogether.home.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.triptogether.home.vo.HomePlanVO;
import org.triptogether.home.vo.HomeSpotVO;

import java.util.List;

@Mapper
public interface HomeMapper {
    List<HomeSpotVO> getPopularSpots();
    List<HomePlanVO> getTrendingPlans();
}
