package org.triptogether.courses.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.ai.dto.AiPlanRequestDTO;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.courses.service.AiPlanService;

@Controller
@RequestMapping("/courses/ai")
@RequiredArgsConstructor
public class AiPlanController {

    private final AiPlanService aiPlanService;
    private final MessageSource messageSource;

    private String msg(String code) {
        return messageSource.getMessage(code, null, LocaleContextHolder.getLocale());
    }

    @GetMapping("/form")
    public String showPlanForm(Model model, RedirectAttributes redirectAttributes) {
        try {
            model.addAttribute("requestDto", new AiPlanRequestDTO());
            return "ai/planForm";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.aiFormLoadFailed"));
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
                redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.loginRequired"));
                return "redirect:/login/loginForm";
            }

            aiPlanService.generateAndSavePlan(requestDTO, loginUser.getUserIdx());

            redirectAttributes.addFlashAttribute("successMessage", msg("course.message.aiCreateSuccess"));
            return "redirect:/courses/list";

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/courses/ai/form";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.aiCreateFailed"));
            return "redirect:/courses/ai/form";
        }
    }
}
