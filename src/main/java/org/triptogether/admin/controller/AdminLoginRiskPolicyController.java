package org.triptogether.admin.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.service.LoginRiskPolicyService;
import org.triptogether.auth.vo.LoginRiskPolicyVO;

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
                               RedirectAttributes redirectAttributes) {
        policy.setPolicyIdx(policyIdx);
        policy.setActive(active != null);
        policy.setResetOnSuccess(resetOnSuccess != null);
        policy.setRequireAdminReview(requireAdminReview != null);
        loginRiskPolicyService.updatePolicy(policy);
        redirectAttributes.addFlashAttribute("message", "정책이 저장되었습니다.");
        return "redirect:/admin/login-risk/policies";
    }
}
