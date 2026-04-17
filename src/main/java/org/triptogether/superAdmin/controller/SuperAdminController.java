package org.triptogether.superAdmin.controller;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.superAdmin.service.SuperAdminService;
import org.triptogether.superAdmin.util.SalaryExcelExporter;
import org.triptogether.superAdmin.vo.SuperAdminEditVO;
import org.triptogether.superAdmin.vo.SuperAdminMemberVO;
import org.triptogether.superAdmin.vo.SuperAdminSalaryEditVO;
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
        model.addAttribute("positionPolicies",        superAdminService.getAllPositionPolicies());
        model.addAttribute("permissionCodePolicies",  superAdminService.getAllPermissionCodePolicies());
        model.addAttribute("allAdmins",               superAdminService.getAllAdmins());
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

    // ── 권한 변경 이력 (Ajax) ──
    @GetMapping("/members/{userIdx}/audit")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> auditLog(@PathVariable Long userIdx) {
        Map<String, Object> result = new HashMap<>();
        result.put("logs", superAdminService.getPermissionAuditLog(userIdx));
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

    // ── 일괄 관리자 해제 ──
    @PostMapping("/members/bulk-revoke")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> bulkRevokeAdmin(
            @RequestParam List<Long> userIdxList) {
        Map<String, Object> result = new HashMap<>();
        try {
            superAdminService.bulkRevokeAdmin(userIdxList);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    // ── 일괄 권한 설정 ──
    @PostMapping("/members/bulk-permissions")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> bulkUpdatePermissions(
            @RequestParam List<Long> userIdxList,
            @RequestParam(required = false) List<String> permissionCodes,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            superAdminService.bulkUpdatePermissions(userIdxList, permissionCodes, loginUser.getUserIdx());
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
        model.addAttribute("member",               superAdminService.getAdminDetail(userIdx));
        model.addAttribute("positionPolicies",     superAdminService.getAllPositionPolicies());
        model.addAttribute("permissionCodePolicies", superAdminService.getAllPermissionCodePolicies());
        model.addAttribute("allAdmins",            superAdminService.getAllAdmins());
        model.addAttribute("activeMenu",           "members");
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

    // ── 급여/역량 수정 ──
    @PostMapping("/members/{userIdx}/salary")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> salarySave(
            @PathVariable Long userIdx,
            SuperAdminSalaryEditVO salaryVO) {
        Map<String, Object> result = new HashMap<>();
        try {
            salaryVO.setUserIdx(userIdx);
            superAdminService.updateSalary(salaryVO);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    // ── 급여/역량 현황 일람표 ──
    @GetMapping("/salary")
    public String salaryTable(SuperAdminSearchVO search, Model model) {
        List<SuperAdminMemberVO> salaryList = superAdminService.getAllForSalaryTable(search);
        int total     = superAdminService.getSalaryTableCount(search);
        int totalPage = (int) Math.ceil((double) total / search.getPageSize());
        model.addAttribute("salaryList", salaryList);
        model.addAttribute("total",      total);
        model.addAttribute("totalPage",  totalPage);
        model.addAttribute("search",     search);
        model.addAttribute("activeMenu", "salary");
        return "superAdmin/salary";
    }

    // ── 급여/역량 Excel 내보내기 ──
    @GetMapping("/salary/export")
    public void salaryExport(SuperAdminSearchVO search, HttpServletResponse response) throws Exception {
        search.setPage(1);
        search.setPageSize(Integer.MAX_VALUE);
        List<SuperAdminMemberVO> list = superAdminService.getAllForSalaryTable(search);
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"salary_export.xlsx\"");
        SalaryExcelExporter.export(list, response.getOutputStream());
    }

    // ── 통계 대시보드 ──
    @GetMapping("/stats")
    public String statsPage(Model model) {
        model.addAllAttributes(superAdminService.getStatsData());
        model.addAttribute("dormantAdmins",           superAdminService.getDormantAdmins());
        model.addAttribute("adminsWithoutPermissions", superAdminService.getAdminsWithoutPermissions());
        model.addAttribute("adminsWithoutManager",    superAdminService.getAdminsWithoutManager());
        model.addAttribute("activeMenu", "stats");
        return "superAdmin/stats";
    }

    // ── 권한 업데이트 (직접 저장) ──
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

    // ── 권한 변경 요청 생성 ──
    @PostMapping("/members/{userIdx}/permissions/request")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> requestPermissions(
            @PathVariable Long userIdx,
            @RequestParam(required = false) List<String> permissionCodes,
            @RequestParam(required = false, defaultValue = "") String description,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            superAdminService.requestPermissions(userIdx, permissionCodes, loginUser.getUserIdx(), description);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    // ── 권한 그룹 목록 ──
    @GetMapping("/groups")
    public String groupsPage(Model model) {
        model.addAttribute("groupList", superAdminService.getAllGroupPolicies());
        model.addAttribute("permissionPolicies", superAdminService.getAllPermissionPolicies());
        model.addAttribute("activeMenu", "groups");
        return "superAdmin/groups";
    }

    // ── 그룹 상세 (Ajax) ──
    @GetMapping("/groups/{groupCode}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> groupDetail(@PathVariable String groupCode) {
        Map<String, Object> result = new HashMap<>();
        result.put("items", superAdminService.getGroupItems(groupCode));
        return ResponseEntity.ok(result);
    }

    // ── 그룹 생성 ──
    @PostMapping("/groups")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createGroup(
            @RequestParam String groupCode,
            @RequestParam String displayName,
            @RequestParam(required = false, defaultValue = "") String description,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            superAdminService.createGroup(groupCode, displayName, description, loginUser.getUserIdx());
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    // ── 그룹 활성/비활성 토글 ──
    @PostMapping("/groups/{groupCode}/toggle")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleGroup(
            @PathVariable String groupCode,
            @RequestParam boolean active,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            superAdminService.toggleGroupActive(groupCode, active, loginUser.getUserIdx());
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    // ── 그룹 권한 추가 ──
    @PostMapping("/groups/{groupCode}/items/add")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addGroupItem(
            @PathVariable String groupCode,
            @RequestParam String permissionCode,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            superAdminService.addGroupItem(groupCode, permissionCode, loginUser.getUserIdx());
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    // ── 그룹 권한 삭제 ──
    @PostMapping("/groups/{groupCode}/items/remove")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> removeGroupItem(
            @PathVariable String groupCode,
            @RequestParam String permissionCode) {
        Map<String, Object> result = new HashMap<>();
        try {
            superAdminService.removeGroupItem(groupCode, permissionCode);
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    // ── 권한 요청 목록 ──
    @GetMapping("/permissions/requests")
    public String requestsPage(Model model) {
        model.addAttribute("requestList", superAdminService.getPendingRequests());
        model.addAttribute("activeMenu", "requests");
        return "superAdmin/permissions/requests";
    }

    // ── 대기 요청 수 (Ajax, 사이드바 뱃지용) ──
    @GetMapping("/permissions/requests/count")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> pendingCount() {
        Map<String, Object> result = new HashMap<>();
        result.put("count", superAdminService.getPendingRequestCount());
        return ResponseEntity.ok(result);
    }

    // ── 권한 요청 승인 ──
    @PostMapping("/permissions/requests/{adminPermissionIdx}/approve")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> approveRequest(
            @PathVariable Long adminPermissionIdx,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            superAdminService.approvePermissionRequest(adminPermissionIdx, loginUser.getUserIdx());
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }

    // ── 권한 요청 거절 ──
    @PostMapping("/permissions/requests/{adminPermissionIdx}/reject")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> rejectRequest(
            @PathVariable Long adminPermissionIdx,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            superAdminService.rejectPermissionRequest(adminPermissionIdx, loginUser.getUserIdx());
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }
}
