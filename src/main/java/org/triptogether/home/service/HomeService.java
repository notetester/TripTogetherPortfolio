package org.triptogether.home.service;

import org.triptogether.home.vo.HomePlanVO;
import org.triptogether.home.vo.HomeSpotVO;

import java.util.List;

/**
 * 메인 홈 화면에 필요한 데이터 제공 서비스
 */
public interface HomeService {
    // 인기 여행지 스팟 목록 가져옴
    List<HomeSpotVO> getPopularSpots();
    // 트렌딩 여행 플랜 목록 가져옴 (이미지는 랜덤으로 하나씩 배정됨)
    List<HomePlanVO> getTrendingPlans();
    // 이미지가 없을 때 쓸 대체 이미지 URL 가져옴
    String getFallbackImageUrl();
}
