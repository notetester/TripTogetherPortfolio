package org.triptogether.home.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.triptogether.community.service.CommunityService;
import org.triptogether.explore.service.SpotTextTranslationService;
import org.triptogether.home.service.HomeService;
import org.triptogether.travelPackage.service.TravelPackageService;
import org.triptogether.travelPackage.vo.TravelPackageVO;

import java.util.List;

/**
 * =============================================
 * HomeController - 메인 홈 화면 컨트롤러
 * =============================================
 * 담당 URL: /
 *
 * [기능 목록]
 * - 메인 홈 화면 렌더링 (home/home.jsp)
 * - 인기 여행지 / 트렌딩 플랜 / 인기 게시글 / 대체 이미지를 모델에 담아 전달
 * =============================================
 */
@Controller
@RequiredArgsConstructor
public class HomeController {

    private final HomeService homeService;
    private final CommunityService communityService;
    private final TravelPackageService travelPackageService;
    private final SpotTextTranslationService translationService;

    /**
     * 메인 홈 화면을 보여준다.
     * - popularSpots     : 인기 여행지 스팟 목록
     * - trendingPlans    : 트렌딩 여행 플랜 목록 (이미지는 랜덤 배정)
     * - fallbackImageUrl : 이미지가 없을 때 쓸 대체 이미지 URL
     * - popularPosts     : 커뮤니티 인기 게시글 4개
     */
    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("popularSpots", homeService.getPopularSpots());
        model.addAttribute("trendingPlans", homeService.getTrendingPlans());
        model.addAttribute("fallbackImageUrl", homeService.getFallbackImageUrl());
        model.addAttribute("popularPosts", communityService.getPopularList(4));

        List<TravelPackageVO> recommendedPackages = travelPackageService.getHomeRecommendedPackages();
        translationService.translatePackages(recommendedPackages);
        model.addAttribute("recommendedPackages", recommendedPackages);

        return "home/home";
    }
}
