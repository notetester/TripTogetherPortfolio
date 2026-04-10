package org.triptogether.report.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.report.service.ReportService;
import org.triptogether.report.vo.ReportSearchDto;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

/**
 * =============================================
 * ReportController - 신고 게시판 컨트롤러
 * =============================================
 * 담당 URL: /report/**
 *
 * [기능 목록]
 * - 신고 접수 (게시글/댓글/유저)
 * - 신고 목록 조회 (관리자 전용)
 * - 신고 상태 변경 (관리자 전용)
 *
 * [권한 구조]
 * - 비로그인  : 신고 접수 불가 (401)
 * - 일반 유저 : 신고 접수만 가능
 * - 관리자    : 신고 목록 열람 + 상태 변경 가능
 * =============================================
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/report")
public class ReportController {

    private final ReportService reportService;

    /* =============================================
       유틸 메서드 - 세션 기반 로그인 유저 정보 조회
       auth 모듈 VO를 직접 import 하지 않고
       리플렉션으로 접근 (담당자 간 의존성 최소화)
       ============================================= */

    /**
     * 세션에서 로그인한 유저의 idx를 꺼낸다.
     * 로그인 안 했거나 오류 시 null 반환.
     */
    private Long getLoginUserIdx(HttpSession session) {
        try {
            Object loginUser = session.getAttribute("loginUser");
            Method method = loginUser.getClass().getMethod("getUserIdx");
            return (Long) method.invoke(loginUser);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 세션에서 로그인한 유저가 관리자(ADMIN)인지 확인한다.
     */
    private boolean isAdmin(HttpSession session) {
        try {
            Object loginUser = session.getAttribute("loginUser");
            Method method = loginUser.getClass().getMethod("getUserRole");
            String role = (String) method.invoke(loginUser);
            return "ADMIN".equals(role);
        } catch (Exception e) {
            return false;
        }
    }

    /* =============================================
       GET /report/list - 신고 목록 (관리자 전용)
       ============================================= */

    /**
     * 신고 목록 페이지를 보여준다.
     * - 관리자가 아니면 403 페이지로 리다이렉트
     */
    @GetMapping("/list")
    public String list(@ModelAttribute ReportSearchDto search,
                       HttpSession session, Model model) {

        if (!isAdmin(session)) {
            return "redirect:/";
        }

        model.addAttribute("reportList", reportService.getReportList(search));
        model.addAttribute("totalCount", reportService.getTotalCount(search));
        model.addAttribute("totalPage",  reportService.getTotalPage(search));
        model.addAttribute("search",     search);

        return "report/list";
    }

    /* =============================================
       POST /report/{targetType}/{targetId} - 신고 접수
       targetType: post / comment
       ============================================= */

    /**
     * 게시글 또는 댓글에 대한 신고를 접수한다.
     * - 비로그인 시 401 반환
     * - 중복 신고 시 "이미 신고하셨습니다" 메시지 반환
     */
    @PostMapping("/{targetType}/{targetId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> reportTarget(
            @PathVariable String targetType,
            @PathVariable Long targetId,
            @RequestParam String reason,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        // 비로그인 체크
        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(result);
        }

        // 유효한 타입만 허용
        if (!"post".equals(targetType) && !"comment".equals(targetType)) {
            result.put("success", false);
            result.put("message", "잘못된 신고 대상입니다.");
            return ResponseEntity.status(400).body(result);
        }

        try {
            Long loginUserIdx = getLoginUserIdx(session);
            boolean submitted = reportService.submitReport(targetType, targetId, loginUserIdx, reason);

            if (!submitted) {
                result.put("success", false);
                result.put("message", "이미 신고하셨습니다.");
                return ResponseEntity.status(409).body(result);
            }

            result.put("success", true);
            result.put("message", "신고가 접수되었습니다.");

        } catch (Exception e) {
            log.error("신고 접수 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /report/user/{targetUserIdx} - 유저 신고
       ============================================= */

    /**
     * 특정 유저를 신고한다.
     * - 비로그인 시 401 반환
     * - 자기 자신 신고 불가
     * - 중복 신고 시 "이미 신고하셨습니다" 메시지 반환
     */
    @PostMapping("/user/{targetUserIdx}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> reportUser(
            @PathVariable Long targetUserIdx,
            @RequestParam(required = false) String reason,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        // 비로그인 체크
        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(result);
        }

        Long loginUserIdx = getLoginUserIdx(session);

        // 자기 자신 신고 방지
        if (loginUserIdx.equals(targetUserIdx)) {
            result.put("success", false);
            result.put("message", "자기 자신은 신고할 수 없습니다.");
            return ResponseEntity.status(400).body(result);
        }

        try {
            boolean submitted = reportService.submitReport("user", targetUserIdx, loginUserIdx, reason);

            if (!submitted) {
                result.put("success", false);
                result.put("message", "이미 신고하셨습니다.");
                return ResponseEntity.status(409).body(result);
            }

            result.put("success", true);
            result.put("message", "신고가 접수되었습니다.");

        } catch (Exception e) {
            log.error("유저 신고 접수 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /report/{reportId}/status - 신고 상태 변경 (관리자)
       status: RESOLVED / DISMISSED
       ============================================= */

    /**
     * 신고 처리 상태를 변경한다.
     * - 관리자만 가능 (403)
     */
    @PostMapping("/{reportId}/status")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> changeStatus(
            @PathVariable Long reportId,
            @RequestParam String status,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (!isAdmin(session)) {
            result.put("success", false);
            result.put("message", "관리자만 신고 상태를 변경할 수 있습니다.");
            return ResponseEntity.status(403).body(result);
        }

        if (!"RESOLVED".equals(status) && !"DISMISSED".equals(status)) {
            result.put("success", false);
            result.put("message", "유효하지 않은 상태값입니다.");
            return ResponseEntity.status(400).body(result);
        }

        try {
            Long adminUserIdx = getLoginUserIdx(session);
            reportService.updateReportStatus(reportId, status, adminUserIdx);
            result.put("success", true);

        } catch (Exception e) {
            log.error("신고 상태 변경 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }
}
