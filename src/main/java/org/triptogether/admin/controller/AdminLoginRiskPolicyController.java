package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.context.MessageSource;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.service.LoginRiskPolicyService;
import org.triptogether.auth.vo.LoginRiskPolicyVO;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityAppealPolicyVO;
import org.triptogether.auth.vo.UsersVO;

import java.util.Collections;
import java.util.List;
import java.util.Locale;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/login-risk")
public class AdminLoginRiskPolicyController {

    private final LoginRiskPolicyService loginRiskPolicyService;
    private final MessageSource messageSource;

    @GetMapping("/policies")
    public String policies(Model model) {
        model.addAttribute("policies", loginRiskPolicyService.getPolicies(true));
        model.addAttribute("activeMenu", "loginRiskPolicies");
        model.addAttribute("pageTitleCode", "security.admin.policies.title");
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
                               RedirectAttributes redirectAttributes,
                               Locale locale) {
        policy.setPolicyIdx(policyIdx);
        policy.setActive(active != null);
        policy.setResetOnSuccess(resetOnSuccess != null);
        policy.setRequireAdminReview(requireAdminReview != null);
        policy.setAiAssistEnabled(aiAssistEnabled != null);
        policy.setWafSyncEnabled(wafSyncEnabled != null);
        loginRiskPolicyService.updatePolicy(policy);
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.policySaved"));
        return "redirect:/admin/login-risk/policies";
    }


    @GetMapping("/appeal-policy")
    public String appealPolicy(Model model) {
        model.addAttribute("policy", loginRiskPolicyService.getSecurityAppealPolicy());
        model.addAttribute("policyHistories", loginRiskPolicyService.getSecurityAppealPolicyHistories(20));
        model.addAttribute("activeMenu", "securityAppealPolicy");
        model.addAttribute("pageTitleCode", "security.admin.appealPolicy.title");
        return "admin/login-risk/appeal-policy";
    }

    @PostMapping("/appeal-policy")
    public String updateAppealPolicy(SecurityAppealPolicyVO policy,
                                     @RequestParam(value = "active", required = false) String active,
                                     @RequestParam(value = "allowMultipleOpenAppeals", required = false) String allowMultipleOpenAppeals,
                                     @RequestParam(value = "closedBlocksNewAppeals", required = false) String closedBlocksNewAppeals,
                                     @RequestParam(value = "captchaEnabled", required = false) String captchaEnabled,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes,
                                     Locale locale) {
        policy.setActive(active != null);
        policy.setAllowMultipleOpenAppeals(allowMultipleOpenAppeals != null);
        policy.setClosedBlocksNewAppeals(closedBlocksNewAppeals != null);
        policy.setCaptchaEnabled(captchaEnabled != null);
        loginRiskPolicyService.updateSecurityAppealPolicy(policy, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.appealPolicySaved"));
        return "redirect:/admin/login-risk/appeal-policy";
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
        model.addAttribute("pageTitleCode", "security.admin.loginReviews.title");
        return "admin/login-risk/reviews";
    }

    @PostMapping("/reviews/{reviewIdx}/{decision}")
    public String decideReview(@PathVariable Long reviewIdx,
                               @PathVariable String decision,
                               @RequestParam(value = "comment", required = false) String comment,
                               HttpSession session,
                               RedirectAttributes redirectAttributes,
                               Locale locale) {
        loginRiskPolicyService.decideReview(reviewIdx, decision, currentAdminIdx(session), comment);
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.reviewProcessed"));
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
        model.addAttribute("pageTitleCode", "security.admin.externalAssessments.title");
        return "admin/login-risk/assessments";
    }

    @GetMapping("/security-assessments")
    public String securityAssessments(@RequestParam(value = "assessmentScope", required = false) String assessmentScope,
                                      @RequestParam(value = "sourceKind", required = false) String sourceKind,
                                      @RequestParam(value = "riskLevel", required = false) String riskLevel,
                                      @RequestParam(value = "decisionStatus", required = false) String decisionStatus,
                                      @RequestParam(value = "keyword", required = false) String keyword,
                                      Model model) {
        model.addAttribute("assessments", loginRiskPolicyService.getSecurityRiskAssessments(assessmentScope, sourceKind, riskLevel, decisionStatus, keyword));
        model.addAttribute("assessmentScope", assessmentScope);
        model.addAttribute("sourceKind", sourceKind);
        model.addAttribute("riskLevel", riskLevel);
        model.addAttribute("decisionStatus", decisionStatus);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "securityRiskAssessments");
        model.addAttribute("pageTitleCode", "security.admin.securityAssessments.title");
        return "admin/login-risk/security-assessments";
    }

    @PostMapping("/security-assessments/{assessmentIdx}/apply-user-block")
    public String applyUserBlockFromAssessment(@PathVariable Long assessmentIdx,
                                               HttpSession session,
                                               RedirectAttributes redirectAttributes,
                                               Locale locale) {
        loginRiskPolicyService.applyUserBlockFromSecurityAssessment(assessmentIdx, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.assessmentUserBlockApplied"));
        return "redirect:/admin/login-risk/security-assessments";
    }

    @PostMapping("/security-assessments/{assessmentIdx}/create-review")
    public String createSecurityReview(@PathVariable Long assessmentIdx,
                                       @RequestParam(value = "severity", required = false) String severity,
                                       @RequestParam(value = "summary", required = false) String summary,
                                       @RequestParam(value = "detailMessage", required = false) String detailMessage,
                                       RedirectAttributes redirectAttributes,
                                       Locale locale) {
        loginRiskPolicyService.createSecurityReviewFromAssessment(assessmentIdx, severity, summary, detailMessage);
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.assessmentQueued"));
        return "redirect:/admin/login-risk/security-assessments";
    }

    @GetMapping("/security-reviews")
    public String securityReviews(@RequestParam(value = "status", required = false) String status,
                                  @RequestParam(value = "severity", required = false) String severity,
                                  @RequestParam(value = "reviewType", required = false) String reviewType,
                                  @RequestParam(value = "keyword", required = false) String keyword,
                                  Model model) {
        model.addAttribute("reviews", loginRiskPolicyService.getSecurityReviews(status, severity, reviewType, keyword));
        model.addAttribute("status", status);
        model.addAttribute("severity", severity);
        model.addAttribute("reviewType", reviewType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "securityReviews");
        model.addAttribute("pageTitleCode", "security.admin.securityReviews.title");
        return "admin/login-risk/security-reviews";
    }

    @PostMapping("/security-reviews/{reviewIdx}/{decision}")
    public String decideSecurityReview(@PathVariable Long reviewIdx,
                                       @PathVariable String decision,
                                       @RequestParam(value = "comment", required = false) String comment,
                                       HttpSession session,
                                       RedirectAttributes redirectAttributes,
                               Locale locale) {
        loginRiskPolicyService.decideSecurityReview(reviewIdx, decision, currentAdminIdx(session), comment);
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.securityReviewProcessed"));
        return "redirect:/admin/login-risk/security-reviews";
    }

    @GetMapping("/appeals")
    public String securityAppeals(@RequestParam(value = "status", required = false) String status,
                                  @RequestParam(value = "targetType", required = false) String targetType,
                                  @RequestParam(value = "keyword", required = false) String keyword,
                                  Model model) {
        model.addAttribute("appeals", loginRiskPolicyService.getSecurityAppeals(status, targetType, keyword));
        model.addAttribute("status", status);
        model.addAttribute("targetType", targetType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "securityAppeals");
        model.addAttribute("pageTitleCode", "security.admin.appeals.title");
        return "admin/login-risk/appeals";
    }

    @PostMapping("/appeals/{appealIdx}/{decision}")
    public String decideSecurityAppeal(@PathVariable Long appealIdx,
                                       @PathVariable String decision,
                                       @RequestParam(value = "comment", required = false) String comment,
                                       HttpSession session,
                                       RedirectAttributes redirectAttributes,
                               Locale locale) {
        loginRiskPolicyService.decideSecurityAppeal(appealIdx, decision, currentAdminIdx(session), comment);
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.appealProcessed"));
        return "redirect:/admin/login-risk/appeals";
    }

    @GetMapping("/provider-configs")
    public String providerConfigs(Model model) {
        model.addAttribute("providers", loginRiskPolicyService.getProviderConfigs());
        model.addAttribute("activeMenu", "securityProviderConfigs");
        model.addAttribute("pageTitleCode", "security.admin.provider.title");
        return "admin/login-risk/provider-configs";
    }

    @PostMapping("/provider-configs/{providerIdx}")
    public String updateProviderConfig(@PathVariable Long providerIdx,
                                       SecurityAssessmentProviderConfigVO config,
                                       @RequestParam(value = "enabled", required = false) String enabled,
                                       @RequestParam(value = "failOpen", required = false) Integer failOpen,
                                       RedirectAttributes redirectAttributes,
                                      Locale locale) {
        config.setProviderIdx(providerIdx);
        config.setEnabled(enabled != null);
        config.setFailOpen(failOpen == null ? 1 : failOpen);
        loginRiskPolicyService.updateProviderConfig(config);
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.providerSaved"));
        return "redirect:/admin/login-risk/provider-configs";
    }

    @PostMapping("/provider-configs/{providerIdx}/check")
    public String checkProviderConfig(@PathVariable Long providerIdx,
                                      HttpSession session,
                                      RedirectAttributes redirectAttributes,
                                      Locale locale) {
        loginRiskPolicyService.checkProviderHealth(providerIdx, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.providerChecked"));
        return "redirect:/admin/login-risk/provider-configs";
    }

    @GetMapping("/waf-sync")
    public String wafSyncQueue(@RequestParam(value = "status", required = false) String status,
                               @RequestParam(value = "targetType", required = false) String targetType,
                               @RequestParam(value = "keyword", required = false) String keyword,
                               Model model) {
        model.addAttribute("items", loginRiskPolicyService.getWafSyncQueue(status, targetType, keyword));
        model.addAttribute("status", status);
        model.addAttribute("targetType", targetType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "securityWafSync");
        model.addAttribute("pageTitleCode", "security.admin.wafSync.title");
        return "admin/login-risk/waf-sync";
    }

    @PostMapping("/waf-sync/{syncIdx}/retry")
    public String retryWafSync(@PathVariable Long syncIdx,
                               HttpSession session,
                               RedirectAttributes redirectAttributes,
                               Locale locale) {
        loginRiskPolicyService.retryWafSync(syncIdx, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.wafSyncRetryQueued"));
        return "redirect:/admin/login-risk/waf-sync";
    }

    @GetMapping("/notification-preferences")
    public String notificationPreferences(HttpSession session, Model model) {
        Long adminIdx = currentAdminIdx(session);
        model.addAttribute("preferences", loginRiskPolicyService.getNotificationPreferences(adminIdx));
        model.addAttribute("activeMenu", "adminNotificationPreferences");
        model.addAttribute("pageTitleCode", "security.admin.notifications.title");
        return "admin/login-risk/notification-preferences";
    }

    @PostMapping("/notification-preferences")
    public String updateNotificationPreferences(@RequestParam(value = "enabledCategories", required = false) List<String> enabledCategories,
                                                HttpSession session,
                                                RedirectAttributes redirectAttributes,
                                                Locale locale) {
        loginRiskPolicyService.updateNotificationPreferences(currentAdminIdx(session),
                enabledCategories == null ? Collections.emptyList() : enabledCategories);
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.notificationSaved"));
        return "redirect:/admin/login-risk/notification-preferences";
    }

    private String msg(Locale locale, String code) {
        return messageSource.getMessage(code, null, locale == null ? Locale.KOREAN : locale);
    }

    private Long currentAdminIdx(HttpSession session) {
        Object loginUser = session == null ? null : session.getAttribute("loginUser");
        if (loginUser instanceof UsersVO user) {
            return user.getUserIdx();
        }
        return null;
    }
}
