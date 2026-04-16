package org.triptogether.home.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.triptogether.community.service.CommunityService;
import org.triptogether.home.service.HomeService;

@Controller
@RequiredArgsConstructor
public class HomeController {

    private final HomeService homeService;
    private final CommunityService communityService;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("popularSpots", homeService.getPopularSpots());
        model.addAttribute("trendingPlans", homeService.getTrendingPlans());
        model.addAttribute("fallbackImageUrl", homeService.getFallbackImageUrl());
        model.addAttribute("popularPosts", communityService.getPopularList(8));
        return "home/home";
    }
}
