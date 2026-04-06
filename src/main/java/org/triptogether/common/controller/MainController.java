package org.triptogether.common.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.triptogether.community.service.CommunityService;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MainController {
    private final CommunityService communityService;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("popularList", communityService.getPopularPostList());
        return "home/home";
    }
}
