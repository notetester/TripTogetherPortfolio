package org.triptogether.admin.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.admin.service.InitialSettingsService;
import org.triptogether.admin.service.AdminActionAuditService;
import org.triptogether.auth.vo.UsersVO;

import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/initial-settings")
public class AdminInitialSettingsController {

    private final InitialSettingsService initialSettingsService;
    private final AdminActionAuditService adminActionAuditService;
    private final ObjectMapper objectMapper;
    private final MessageSource messageSource;

    @GetMapping
    public String page(Model model) {
        model.addAttribute("activeMenu", "initialSettings");
        model.addAttribute("pageTitleCode", "admin.initialSettings.title");
        return "admin/initial-settings";
    }

    @GetMapping("/export")
    public ResponseEntity<byte[]> exportSettings(HttpSession session) throws Exception {
        Map<String, Object> payload = initialSettingsService.exportSettings();
        byte[] body = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsBytes(payload);
        adminActionAuditService.record(
                "INITIAL_SETTINGS_EXPORT",
                "SYSTEM_CONFIG",
                currentAdminIdx(session),
                "INITIAL_SETTINGS",
                "EXPORT",
                "ADMIN.INITIAL_SETTINGS.EXPORT",
                null,
                "initial settings exported"
        );
        String fileName = "triptogether-initial-settings-" +
                LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd-HHmmss")) + ".json";
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"")
                .contentType(MediaType.APPLICATION_JSON)
                .body(body);
    }

    @PostMapping("/import")
    public String importSettings(@RequestParam("file") MultipartFile file,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes,
                                 Locale locale) {
        try {
            if (file == null || file.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", msg(locale, "admin.initialSettings.error.emptyFile"));
                return "redirect:/admin/initial-settings";
            }
            InitialSettingsService.ImportResult result = initialSettingsService.importSettings(
                    initialSettingsService.parseJson(file.getBytes()),
                    currentAdminIdx(session)
            );
            redirectAttributes.addFlashAttribute("message", msg(locale, "admin.initialSettings.flash.imported",
                    result.totalApplied(), result.skipped));
            if (!result.skippedMessages.isEmpty()) {
                redirectAttributes.addFlashAttribute("warning", String.join(", ", result.skippedMessages));
            }
            adminActionAuditService.record(
                    "INITIAL_SETTINGS_IMPORT",
                    "SYSTEM_CONFIG",
                    currentAdminIdx(session),
                    "INITIAL_SETTINGS",
                    "IMPORT",
                    "ADMIN.INITIAL_SETTINGS.IMPORT",
                    "{\"applied\":" + result.totalApplied() + ",\"skipped\":" + result.skipped + "}",
                    "initial settings imported"
            );
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", msg(locale, "admin.initialSettings.error.importFailed") + ": " + e.getMessage());
        }
        return "redirect:/admin/initial-settings";
    }

    private Long currentAdminIdx(HttpSession session) {
        Object loginUser = session == null ? null : session.getAttribute("loginUser");
        if (loginUser instanceof UsersVO user) {
            return user.getUserIdx();
        }
        return null;
    }

    private String msg(Locale locale, String code, Object... args) {
        return messageSource.getMessage(code, args, code, locale);
    }
}
