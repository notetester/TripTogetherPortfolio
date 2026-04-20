package org.triptogether.courses.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.triptogether.ai.dto.AiPlanRequestDTO;
import org.triptogether.courses.service.AiPlanService;
import org.triptogether.auth.vo.UsersVO;

@Controller
@RequestMapping("/courses/ai")
@RequiredArgsConstructor
public class AiPlanController {
    private final AiPlanService aiPlanService;

    @GetMapping("/form")
    public String showPlanForm(Model model) {
        model.addAttribute("requestDto", new AiPlanRequestDTO());
        return "ai/planForm";
    }

    @PostMapping("/generate")
    public String generatePlan(@ModelAttribute("requestDTO") AiPlanRequestDTO requestDTO,
                               HttpSession session) {

        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login/loginForm";
        }

        aiPlanService.generateAndSavePlan(requestDTO, loginUser.getUserIdx());
        return "redirect:/courses/list";
    }

}