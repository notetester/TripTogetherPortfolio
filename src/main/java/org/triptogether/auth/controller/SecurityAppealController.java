package org.triptogether.auth.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.service.LoginRiskPolicyService;
import org.triptogether.auth.vo.SecurityAppealFormVO;
import org.triptogether.auth.vo.SecurityAppealVO;

@Controller
@RequiredArgsConstructor
@RequestMapping("/security/appeal")
public class SecurityAppealController {

    private final LoginRiskPolicyService loginRiskPolicyService;

    @GetMapping
    public String tokenForm(@RequestParam(value = "token", required = false) String token,
                            @RequestParam(value = "requestId", required = false) String requestId,
                            @RequestParam(value = "lang", required = false) String lang,
                            Model model) {
        SecurityAppealFormVO form = loginRiskPolicyService.getPublicAppealForm(token, requestId, lang);
        model.addAttribute("form", form);
        model.addAttribute("token", token);
        model.addAttribute("requestId", requestId);
        model.addAttribute("pageLang", form.getPageLang() == null ? "ko" : form.getPageLang());
        if ((token == null || token.isBlank()) && requestId != null && !requestId.isBlank()) {
            return "security/appeal/verify";
        }
        return "security/appeal/form";
    }

    @GetMapping("/new")
    public String requestForm(@RequestParam(value = "requestId", required = false) String requestId,
                              @RequestParam(value = "lang", required = false) String lang,
                              Model model) {
        return tokenForm(null, requestId, lang, model);
    }


    @PostMapping("/verify")
    public String requestVerification(@RequestParam("requestId") String requestId,
                                      @RequestParam("submitterEmail") String submitterEmail,
                                      @RequestParam(value = "lang", required = false) String lang,
                                      Model model) {
        String pageLang = lang == null || lang.isBlank() ? "ko" : lang;
        try {
            loginRiskPolicyService.requestPublicAppealEmailVerification(requestId, submitterEmail, pageLang);
            model.addAttribute("pageLang", pageLang);
            return "security/appeal/verify-sent";
        } catch (IllegalArgumentException e) {
            SecurityAppealFormVO form = loginRiskPolicyService.getPublicAppealForm(null, requestId, pageLang);
            form.setValid(false);
            form.setErrorMessage(e.getMessage());
            model.addAttribute("form", form);
            model.addAttribute("requestId", requestId);
            model.addAttribute("pageLang", pageLang);
            return "security/appeal/verify";
        }
    }

    @GetMapping("/result")
    public String resultForm(@RequestParam(value = "lang", required = false) String lang,
                             Model model) {
        model.addAttribute("pageLang", lang == null || lang.isBlank() ? "ko" : lang);
        return "security/appeal/result";
    }

    @PostMapping("/result")
    public String result(@RequestParam("publicRequestId") String publicRequestId,
                         @RequestParam("submitterEmail") String submitterEmail,
                         @RequestParam(value = "lang", required = false) String lang,
                         Model model) {
        String pageLang = lang == null || lang.isBlank() ? "ko" : lang;
        try {
            SecurityAppealVO appeal = loginRiskPolicyService.findPublicAppealResult(publicRequestId, submitterEmail, pageLang);
            model.addAttribute("appeal", appeal);
        } catch (IllegalArgumentException e) {
            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("publicRequestId", publicRequestId);
        }
        model.addAttribute("pageLang", pageLang);
        return "security/appeal/result";
    }

    @PostMapping
    public String submit(@RequestParam(value = "token", required = false) String token,
                         @RequestParam(value = "requestId", required = false) String requestId,
                         @RequestParam("appealTitle") String appealTitle,
                         @RequestParam("appealContent") String appealContent,
                         @RequestParam(value = "submitterEmail", required = false) String submitterEmail,
                         @RequestParam(value = "lang", required = false) String lang,
                         Model model) {
        try {
            String publicRequestId = loginRiskPolicyService.submitPublicSecurityAppeal(
                    token, requestId, appealTitle, appealContent, submitterEmail, lang);
            model.addAttribute("publicRequestId", publicRequestId);
            model.addAttribute("pageLang", lang == null || lang.isBlank() ? "ko" : lang);
            return "security/appeal/done";
        } catch (IllegalArgumentException e) {
            SecurityAppealFormVO form = SecurityAppealFormVO.builder()
                    .valid(false)
                    .errorMessage(e.getMessage())
                    .token(token)
                    .requestId(requestId)
                    .pageLang(lang == null || lang.isBlank() ? "ko" : lang)
                    .build();
            model.addAttribute("form", form);
            model.addAttribute("token", token);
            model.addAttribute("requestId", requestId);
            model.addAttribute("pageLang", form.getPageLang());
            return "security/appeal/form";
        }
    }
}
