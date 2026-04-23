package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.triptogether.admin.service.AdminTranslationService;
import org.triptogether.admin.vo.*;
import org.triptogether.auth.vo.UsersVO;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/admin/translations")
public class AdminTranslationController {

    private final AdminTranslationService adminTranslationService;

    @GetMapping("/lookup")
    public ResponseEntity<Map<String, Object>> lookup(@RequestParam String sourceType,
                                                      @RequestParam Long sourceIdx,
                                                      @RequestParam String fieldName,
                                                      @RequestParam String sourceText) {
        Map<String, Object> result = new HashMap<>();
        try {
            result.put("success", true);
            result.put("translations", adminTranslationService.getTranslations(sourceType, sourceIdx, fieldName, sourceText));
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            log.warn("translation lookup failed sourceType={} sourceIdx={} fieldName={}: {}",
                    sourceType, sourceIdx, fieldName, e.getMessage());
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(result);
        }
    }

    @PostMapping
    public ResponseEntity<Map<String, Object>> create(@RequestBody AdminTranslationCreateRequest request,
                                                      HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            result.put("success", true);
            result.put("translation", adminTranslationService.createTranslation(request, getActorUserIdx(session)));
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            log.warn("translation create failed: {}", e.getMessage());
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(result);
        }
    }

    @PostMapping("/{translationIdx}/revisions")
    public ResponseEntity<Map<String, Object>> createRevision(@PathVariable Long translationIdx,
                                                              @RequestBody AdminTranslationRevisionCreateRequest request,
                                                              HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            result.put("success", true);
            result.put("translation", adminTranslationService.createRevision(translationIdx, request, getActorUserIdx(session)));
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            log.warn("translation revision create failed translationIdx={}: {}", translationIdx, e.getMessage());
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(result);
        }
    }

    @PostMapping("/{translationIdx}/restore")
    public ResponseEntity<Map<String, Object>> restore(@PathVariable Long translationIdx,
                                                       @RequestBody AdminTranslationRestoreRequest request,
                                                       HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            result.put("success", true);
            result.put("translation", adminTranslationService.restoreRevision(translationIdx, request.getRevisionIdx(), getActorUserIdx(session)));
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            log.warn("translation restore failed translationIdx={}: {}", translationIdx, e.getMessage());
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(result);
        }
    }

    private Long getActorUserIdx(HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        return loginUser == null ? null : loginUser.getUserIdx();
    }
}
