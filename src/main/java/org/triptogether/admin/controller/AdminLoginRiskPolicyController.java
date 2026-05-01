package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.service.LoginRiskPolicyService;
import org.triptogether.auth.vo.LoginRiskPolicyVO;
import org.triptogether.auth.vo.UsersVO;

import java.util.Collections;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/login-risk")
public class AdminLoginRiskPolicyController {

    private final LoginRiskPolicyService loginRiskPolicyService;

    @GetMapping("/policies")
    public String policies(Model model) {
        model.addAttribute("policies", loginRiskPolicyService.getPolicies(true));
        model.addAttribute("activeMenu", "loginRiskPolicies");
        model.addAttribute("pageTitle", "로그인 위험 정책");
        return "admin/login-risk/policies";
    }

    @PostMapping("/policies/{policyIdx}")
    public String updatePolicy(@PathVariable Long policyIdx,
                               LoginRiskPolicyVO policy,
                               @RequestParam(value = "active", required = false) String active,
                               @RequestParam(value = "resetOnSuccess", required = false) String resetOnSuccess,
                               @RequestParam(value = "requireAdminReview", required = false) String requireAdminReview,
                               @RequestParam(value = "aiAssistEnabled", required = false) String aiAssistEnabled,
                               @RequestParam(value = "wafSyncEnabled", required = false) String wafSyncEnabled,
                               RedirectAttributes redirectAttributes) {
        policy.setPolicyIdx(policyIdx);
        policy.setActive(active != null);
        policy.setResetOnSuccess(resetOnSuccess != null);
        policy.setRequireAdminReview(requireAdminReview != null);
        policy.setAiAssistEnabled(aiAssistEnabled != null);
        policy.setWafSyncEnabled(wafSyncEnabled != null);
        loginRiskPolicyService.updatePolicy(policy);
        redirectAttributes.addFlashAttribute("message", "정책이 저장되었습니다.");
        return "redirect:/admin/login-risk/policies";
    }

    @GetMapping("/reviews")
    public String reviews(@RequestParam(value = "status", required = false) String status,
                          @RequestParam(value = "severity", required = false) String severity,
                          @RequestParam(value = "reviewType", required = false) String reviewType,
                          @RequestParam(value = "keyword", required = false) String keyword,
                          Model model) {
        model.addAttribute("reviews", loginRiskPolicyService.getReviewQueue(status, severity, reviewType, keyword));
        model.addAttribute("status", status);
        model.addAttribute("severity", severity);
        model.addAttribute("reviewType", reviewType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "loginRiskReviews");
        model.addAttribute("pageTitle", "로그인 위험 검토 큐");
        return "admin/login-risk/reviews";
    }

    @PostMapping("/reviews/{reviewIdx}/{decision}")
    public String decideReview(@PathVariable Long reviewIdx,
                               @PathVariable String decision,
                               @RequestParam(value = "comment", required = false) String comment,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        loginRiskPolicyService.decideReview(reviewIdx, decision, currentAdminIdx(session), comment);
        redirectAttributes.addFlashAttribute("message", "검토 상태가 처리되었습니다.");
        return "redirect:/admin/login-risk/reviews";
    }

    @GetMapping("/assessments")
    public String assessments(@RequestParam(value = "sourceKind", required = false) String sourceKind,
                              @RequestParam(value = "riskLevel", required = false) String riskLevel,
                              @RequestParam(value = "decisionStatus", required = false) String decisionStatus,
                              @RequestParam(value = "keyword", required = false) String keyword,
                              Model model) {
        model.addAttribute("assessments", loginRiskPolicyService.getExternalAssessments(sourceKind, riskLevel, decisionStatus, keyword));
        model.addAttribute("sourceKind", sourceKind);
        model.addAttribute("riskLevel", riskLevel);
        model.addAttribute("decisionStatus", decisionStatus);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "loginRiskAssessments");
        model.addAttribute("pageTitle", "로그인 위험 외부 판단");
        return "admin/login-risk/assessments";
    }

    @GetMapping("/notification-preferences")
    public String notificationPreferences(HttpSession session, Model model) {
        Long adminIdx = currentAdminIdx(session);
        model.addAttribute("preferences", loginRiskPolicyService.getNotificationPreferences(adminIdx));
        model.addAttribute("activeMenu", "adminNotificationPreferences");
        model.addAttribute("pageTitle", "관리자 알림 설정");
        return "admin/login-risk/notification-preferences";
    }

    @PostMapping("/notification-preferences")
    public String updateNotificationPreferences(@RequestParam(value = "enabledCategories", required = false) List<String> enabledCategories,
                                                HttpSession session,
                                                RedirectAttributes redirectAttributes) {
        loginRiskPolicyService.updateNotificationPreferences(currentAdminIdx(session),
                enabledCategories == null ? Collections.emptyList() : enabledCategories);
        redirectAttributes.addFlashAttribute("message", "알림 설정이 저장되었습니다.");
        return "redirect:/admin/login-risk/notification-preferences";
    }

    private Long currentAdminIdx(HttpSession session) {
        Object loginUser = session == null ? null : session.getAttribute("loginUser");
        if (loginUser instanceof UsersVO user) {
            return user.getUserIdx();
        }
        return null;
    }
}
