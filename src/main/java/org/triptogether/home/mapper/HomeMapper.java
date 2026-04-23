package org.triptogether.home.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.triptogether.home.vo.HomePlanVO;
import org.triptogether.home.vo.HomeSpotVO;

import java.util.List;

/**
 * 메인 홈 화면용 MyBatis 매퍼
 */
@Mapper
public interface HomeMapper {
    // 인기 여행지 스팟 목록 조회
    List<HomeSpotVO> getPopularSpots();
    // 트렌딩 여행 플랜 목록 조회
    List<HomePlanVO> getTrendingPlans();
}
