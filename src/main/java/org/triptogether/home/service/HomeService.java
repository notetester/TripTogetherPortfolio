package org.triptogether.home.service;

import org.triptogether.home.vo.HomePlanVO;
import org.triptogether.home.vo.HomeSpotVO;

import java.util.List;

public interface HomeService {
    List<HomeSpotVO> getPopularSpots();
    List<HomePlanVO> getTrendingPlans();
    String getFallbackImageUrl();
}
