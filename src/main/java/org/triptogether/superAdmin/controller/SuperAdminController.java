package org.triptogether.superAdmin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.superAdmin.service.SuperAdminService;
import org.triptogether.superAdmin.vo.SuperAdminEditVO;
import org.triptogether.superAdmin.vo.SuperAdminSearchVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/superAdmin")
public class SuperAdminController {

    private final SuperAdminService superAdminService;

    @GetMapping({"", "/"})
    public String index() {
        return "redirect:/superAdmin/members";
    }

    // ── 관리자 목록 ──
    @GetMapping("/members")
    public String memberList(SuperAdminSearchVO search, Model model) {
        model.addAllAttributes(superAdminService.getAdminList(search));
        model.addAttribute("activeMenu", "members");
        return "superAdmin/member/list";
    }

    // ── 관리자 상세 (Ajax) ──
    @GetMapping("/members/{userIdx}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> memberDetail(@PathVariable Long userIdx) {
        Map<String, Object> result = new HashMap<>();
        result.put("member", superAdminService.getAdminDetail(userIdx));
        result.put("permissionPolicies", superAdminService.getAllPermissionPolicies());
        return ResponseEntity.ok(result);
    }

    // ── 일반 유저 검색 (관리자 등록 모달용, Ajax) ──
    @GetMapping("/users/search")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> searchUsers(SuperAdminSearchVO search) {
        Map<String, Object> result = new HashMap<>();
        result.put("users", superAdminService.searchUsers(search));
        return ResponseEntity.ok(result);
    }

    // ── 관리자 등록 ──
    @PostMapping("/members/grant")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> grantAdmin(@RequestParam Long userIdx) {
        Map<String, Object> result = new HashMap<>();
        try {
            superAdminService.grantAdmin(userIdx);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    // ── 관리자 해제 ──
    @PostMapping("/members/revoke")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> revokeAdmin(@RequestParam Long userIdx) {
        Map<String, Object> result = new HashMap<>();
        try {
            superAdminService.revokeAdmin(userIdx);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    // ── 조직도 ──
    @GetMapping("/org")
    public String orgChart(Model model) {
        model.addAttribute("adminList", superAdminService.getAdminsForOrgChart());
        model.addAttribute("activeMenu", "org");
        return "superAdmin/org";
    }

    // ── 편집 페이지 ──
    @GetMapping("/members/{userIdx}/edit")
    public String editPage(@PathVariable Long userIdx, Model model) {
        model.addAttribute("member", superAdminService.getAdminDetail(userIdx));
        model.addAttribute("positionPolicies", superAdminService.getAllPositionPolicies());
        model.addAttribute("permissionCodePolicies", superAdminService.getAllPermissionCodePolicies());
        model.addAttribute("adminList", superAdminService.getAllAdmins());
        model.addAttribute("activeMenu", "members");
        return "superAdmin/member/edit";
    }

    @PostMapping("/members/{userIdx}/edit")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> editSave(
            @PathVariable Long userIdx,
            SuperAdminEditVO editVO) {
        Map<String, Object> result = new HashMap<>();
        try {
            editVO.setUserIdx(userIdx);
            superAdminService.updateAdminInfo(editVO);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    // ── 급여/역량 현황 일람표 ──
    @GetMapping("/salary")
    public String salaryTable(Model model) {
        model.addAttribute("salaryList", superAdminService.getAllForSalaryTable());
        model.addAttribute("activeMenu", "salary");
        return "superAdmin/salary";
    }

    // ── 통계 대시보드 ──
    @GetMapping("/stats")
    public String statsPage(Model model) {
        model.addAllAttributes(superAdminService.getStatsData());
        model.addAttribute("activeMenu", "stats");
        return "superAdmin/stats";
    }

    // ── 권한 업데이트 ──
    @PostMapping("/members/{userIdx}/permissions")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updatePermissions(
            @PathVariable Long userIdx,
            @RequestParam(required = false) List<String> permissionCodes,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            superAdminService.updatePermissions(userIdx, permissionCodes, loginUser.getUserIdx());
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }
}
