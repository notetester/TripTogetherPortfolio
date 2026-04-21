package org.triptogether.courses.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.ai.dto.AiPlanRequestDTO;
import org.triptogether.courses.service.AiPlanService;
import org.triptogether.auth.vo.UsersVO;

@Controller
@RequestMapping("/courses/ai")
@RequiredArgsConstructor
public class AiPlanController {
    private final AiPlanService aiPlanService;

    @GetMapping("/form")
    public String showPlanForm(Model model, RedirectAttributes redirectAttributes) {
        try{
            model.addAttribute("requestDto", new AiPlanRequestDTO());
            return "ai/planForm";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "AI 일정 생성 페이지를 불러오는 중 오류가 발생했습니다.");
            return "redirect:/courses/list";
        }
    }

    @PostMapping("/generate")
    public String generatePlan(@ModelAttribute("requestDTO") AiPlanRequestDTO requestDTO,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            if (loginUser == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "로그인 후 이용해주세요.");
                return "redirect:/login/loginForm";
            }

            aiPlanService.generateAndSavePlan(requestDTO, loginUser.getUserIdx());

            redirectAttributes.addFlashAttribute("successMessage", "AI 여행 일정이 생성되었습니다.");
            return "redirect:/courses/list";

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/courses/ai/form";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "AI 일정 생성 중 오류가 발생했습니다.");
            return "redirect:/courses/ai/form";
        }
    }
}