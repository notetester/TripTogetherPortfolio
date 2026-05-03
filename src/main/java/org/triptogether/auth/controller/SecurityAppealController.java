package org.triptogether.auth.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.service.LoginRiskPolicyService;
import org.triptogether.auth.vo.SecurityAppealFormVO;

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
        return "security/appeal/form";
    }

    @GetMapping("/new")
    public String requestForm(@RequestParam(value = "requestId", required = false) String requestId,
                              @RequestParam(value = "lang", required = false) String lang,
                              Model model) {
        return tokenForm(null, requestId, lang, model);
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
