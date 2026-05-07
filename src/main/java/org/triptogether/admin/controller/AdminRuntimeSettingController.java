package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponentsBuilder;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.config.RuntimeSettingService;
import org.triptogether.config.RuntimeSettingVO;

import java.util.Locale;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/runtime-settings")
public class AdminRuntimeSettingController {

    private final RuntimeSettingService runtimeSettingService;
    private final MessageSource messageSource;

    @GetMapping
    public String list(@RequestParam(value = "settingGroup", required = false) String settingGroup,
                       @RequestParam(value = "keyword", required = false) String keyword,
                       @RequestParam(value = "includeInactive", required = false) String includeInactive,
                       @RequestParam(value = "historyKey", required = false) String historyKey,
                       Model model) {
        boolean showInactive = includeInactive != null;
        model.addAttribute("settings", runtimeSettingService.getRuntimeSettings(settingGroup, keyword, showInactive));
        model.addAttribute("histories", runtimeSettingService.getRuntimeSettingHistories(historyKey, 50));
        model.addAttribute("settingGroup", settingGroup);
        model.addAttribute("keyword", keyword);
        model.addAttribute("includeInactive", showInactive);
        model.addAttribute("historyKey", historyKey);
        model.addAttribute("activeMenu", "runtimeSettings");
        model.addAttribute("pageTitleCode", "admin.runtimeSettings.title");
        return "admin/runtime-settings";
    }

    @PostMapping
    public String create(RuntimeSettingVO setting,
                         @RequestParam(value = "secret", required = false) String secret,
                         @RequestParam(value = "editable", required = false) String editable,
                         @RequestParam(value = "active", required = false) String active,
                         @RequestParam(value = "returnSettingGroup", required = false) String returnSettingGroup,
                         @RequestParam(value = "returnKeyword", required = false) String returnKeyword,
                         @RequestParam(value = "returnHistoryKey", required = false) String returnHistoryKey,
                         @RequestParam(value = "returnIncludeInactive", required = false) String returnIncludeInactive,
                         HttpSession session,
                         RedirectAttributes redirectAttributes,
                         Locale locale) {
        setting.setSecret(secret != null);
        setting.setEditable(editable != null);
        setting.setActive(active != null);
        runtimeSettingService.saveRuntimeSetting(setting, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "admin.runtimeSettings.flash.saved"));
        return redirectRuntimeSettings(returnSettingGroup, returnKeyword, returnHistoryKey, returnIncludeInactive != null);
    }

    @PostMapping("/{settingIdx}")
    public String update(@PathVariable Long settingIdx,
                         RuntimeSettingVO setting,
                         @RequestParam(value = "secret", required = false) String secret,
                         @RequestParam(value = "editable", required = false) String editable,
                         @RequestParam(value = "active", required = false) String active,
                         @RequestParam(value = "returnSettingGroup", required = false) String returnSettingGroup,
                         @RequestParam(value = "returnKeyword", required = false) String returnKeyword,
                         @RequestParam(value = "returnHistoryKey", required = false) String returnHistoryKey,
                         @RequestParam(value = "returnIncludeInactive", required = false) String returnIncludeInactive,
                         HttpSession session,
                         RedirectAttributes redirectAttributes,
                         Locale locale) {
        setting.setSettingIdx(settingIdx);
        setting.setSecret(secret != null);
        setting.setEditable(editable != null);
        setting.setActive(active != null);
        runtimeSettingService.saveRuntimeSetting(setting, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "admin.runtimeSettings.flash.saved"));
        return redirectRuntimeSettings(returnSettingGroup, returnKeyword, returnHistoryKey, returnIncludeInactive != null);
    }

    private String redirectRuntimeSettings(String settingGroup,
                                           String keyword,
                                           String historyKey,
                                           boolean includeInactive) {
        UriComponentsBuilder builder = UriComponentsBuilder.fromPath("/admin/runtime-settings");
        if (settingGroup != null && !settingGroup.isBlank()) {
            builder.queryParam("settingGroup", settingGroup);
        }
        if (keyword != null && !keyword.isBlank()) {
            builder.queryParam("keyword", keyword);
        }
        if (includeInactive) {
            builder.queryParam("includeInactive", "on");
        }
        if (historyKey != null && !historyKey.isBlank()) {
            builder.queryParam("historyKey", historyKey);
        }
        return "redirect:" + builder.toUriString();
    }

    private Long currentAdminIdx(HttpSession session) {
        Object loginUser = session == null ? null : session.getAttribute("loginUser");
        if (loginUser instanceof UsersVO user) {
            return user.getUserIdx();
        }
        return null;
    }

    private String msg(Locale locale, String code) {
        return messageSource.getMessage(code, null, code, locale);
    }
}
