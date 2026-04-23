package org.triptogether.admin.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.admin.service.AdminCourseService;
import org.triptogether.admin.vo.AdminCourseSearchVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 어드민 여행코스 관리 컨트롤러.
 * SJ팀원의 courses 모듈과 분리된 별도 관리 인터페이스이며,
 * TRAVEL_PLAN 읽기 + is_deleted 토글(소프트 삭제/복구)만 지원한다.
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/courses")
public class AdminCoursesController {

    private final AdminCourseService adminCourseService;

    /**
     * 여행코스 목록 페이지.
     */
    @GetMapping({"", "/"})
    public String planList(AdminCourseSearchVO search, Model model) {
        model.addAllAttributes(adminCourseService.getPlanList(search));
        model.addAttribute("stats", adminCourseService.getStats());
        model.addAttribute("activeMenu", "courses");
        return "admin/courses/list";
    }

    /**
     * 여행코스 상세 페이지.
     */
    @GetMapping("/{planId}")
    public String planDetail(@PathVariable Long planId, Model model) {
        model.addAllAttributes(adminCourseService.getPlanDetail(planId));
        model.addAttribute("activeMenu", "courses");
        return "admin/courses/detail";
    }

    // ── 단건 소프트 삭제 ────────────────────────────────

    @PostMapping("/{planId}/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deletePlan(@PathVariable Long planId) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminCourseService.deletePlan(planId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("여행코스 삭제 오류 planId={}", planId, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    // ── 단건 복구 ──────────────────────────────────────

    @PostMapping("/{planId}/restore")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> restorePlan(@PathVariable Long planId) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminCourseService.restorePlan(planId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("여행코스 복구 오류 planId={}", planId, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    // ── 일괄 처리 ──────────────────────────────────────

    /**
     * 일괄 처리. action: delete(삭제) / restore(복구).
     */
    @PostMapping("/bulk-action")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> bulkAction(
            @RequestParam String action,
            @RequestParam(required = false) List<Long> ids) {

        Map<String, Object> result = new HashMap<>();
        if (ids == null || ids.isEmpty()) {
            result.put("success", false);
            result.put("message", "선택된 항목이 없습니다.");
            return ResponseEntity.badRequest().body(result);
        }
        try {
            if ("delete".equals(action)) {
                adminCourseService.bulkDelete(ids);
            } else if ("restore".equals(action)) {
                adminCourseService.bulkRestore(ids);
            } else {
                result.put("success", false);
                result.put("message", "알 수 없는 처리 옵션입니다.");
                return ResponseEntity.badRequest().body(result);
            }
            result.put("success", true);
            result.put("count", ids.size());
        } catch (Exception e) {
            log.error("여행코스 일괄 처리 오류 action={}", action, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }
}
