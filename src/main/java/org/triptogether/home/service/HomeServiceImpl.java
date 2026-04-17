package org.triptogether.home.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.community.service.CommunityImageScheduler;
import org.triptogether.home.mapper.HomeMapper;
import org.triptogether.home.vo.HomePlanVO;
import org.triptogether.home.vo.HomeSpotVO;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class HomeServiceImpl implements HomeService {

    private final HomeMapper homeMapper;
    private final CommunityImageScheduler communityImageScheduler;

    @Override
    public List<HomeSpotVO> getPopularSpots() {
        return homeMapper.getPopularSpots();
    }

    @Override
    public String getFallbackImageUrl() {
        return communityImageScheduler.getRandomImage("etc");
    }

    @Override
    public List<HomePlanVO> getTrendingPlans() {
        List<HomePlanVO> plans = homeMapper.getTrendingPlans();
        List<String> images = communityImageScheduler.getAllImages();
        Collections.shuffle(images);
        for (int i = 0; i < plans.size(); i++) {
            if (!images.isEmpty()) {
                plans.get(i).setImageUrl(images.get(i % images.size()));
            }
        }
        return plans;
    }
}
