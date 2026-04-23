package org.triptogether.home.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.community.service.CommunityImageScheduler;
import org.triptogether.home.mapper.HomeMapper;
import org.triptogether.home.vo.HomePlanVO;
import org.triptogether.home.vo.HomeSpotVO;

import java.util.Collections;
import java.util.List;

/**
 * HomeService 구현체
 * - 스팟/플랜 목록은 DB에서 가져오고, 이미지는 CommunityImageScheduler에서 제공받음
 */
@Service
@RequiredArgsConstructor
public class HomeServiceImpl implements HomeService {

    private final HomeMapper homeMapper;
    private final CommunityImageScheduler communityImageScheduler;

    // 인기 여행지 스팟 목록을 DB에서 그대로 가져옴
    @Override
    public List<HomeSpotVO> getPopularSpots() {
        return homeMapper.getPopularSpots();
    }

    // 이미지가 없을 때 쓸 대체 이미지 URL (etc 카테고리 랜덤 이미지)
    @Override
    public String getFallbackImageUrl() {
        return communityImageScheduler.getRandomImage("etc");
    }

    // 트렌딩 플랜 목록을 가져온 뒤, 각 플랜마다 랜덤 이미지를 하나씩 붙여서 반환
    @Override
    public List<HomePlanVO> getTrendingPlans() {
        // 1) DB에서 트렌딩 플랜 목록 조회
        List<HomePlanVO> plans = homeMapper.getTrendingPlans();
        // 2) 사용 가능한 이미지 전체를 가져와 순서를 섞음
        List<String> images = communityImageScheduler.getAllImages();
        Collections.shuffle(images);
        // 3) 플랜 개수만큼 돌면서 이미지를 하나씩 배정 (이미지가 모자라면 처음부터 다시 사용)
        for (int i = 0; i < plans.size(); i++) {
            if (!images.isEmpty()) {
                plans.get(i).setImageUrl(images.get(i % images.size()));
            }
        }
        return plans;
    }
}
