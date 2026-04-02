package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.admin.service.AdminService;
import org.triptogether.admin.vo.AdminMemberVO;
import org.triptogether.admin.vo.AdminSearchVO;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;

    // ════════════════════════════════════════════
    // 대시보드
    // ════════════════════════════════════════════
    @GetMapping({"", "/"})
    public String dashboard(Model model) {
        model.addAttribute("stats",       adminService.getStats());
        model.addAttribute("activeMenu",  "dashboard");
        return "admin/dashboard";
    }

    // ════════════════════════════════════════════
    // 회원 관리 - 목록
    // ════════════════════════════════════════════
    @GetMapping("/members")
    public String memberList(AdminSearchVO search, Model model) {
        Map<String, Object> data = adminService.getMemberList(search);
        model.addAllAttributes(data);
        model.addAttribute("activeMenu", "members");
        return "admin/member/list";
    }

    // ════════════════════════════════════════════
    // 회원 관리 - 상세 (Ajax)
    // ════════════════════════════════════════════
    @GetMapping("/members/{userIdx}")
    @ResponseBody
    public Map<String, Object> memberDetail(@PathVariable Long userIdx) {
        Map<String, Object> result = new HashMap<>();
        AdminMemberVO member = adminService.getMemberDetail(userIdx);
        if (member == null) {
            result.put("success", false);
            result.put("message", "회원을 찾을 수 없습니다.");
            return result;
        }
        result.put("success", true);
        result.put("member",  member);
        result.put("history", adminService.getLoginHistory(userIdx));
        return result;
    }

    // ════════════════════════════════════════════
    // 회원 상태 변경 (Ajax)
    // ════════════════════════════════════════════
    @PostMapping("/members/{userIdx}/status")
    @ResponseBody
    public Map<String, Object> changeStatus(@PathVariable Long userIdx,
                                             @RequestParam String status,
                                             HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 자기 자신의 상태는 변경 불가
            var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
            if (loginUser != null && loginUser.getUserIdx().equals(userIdx)) {
                result.put("success", false);
                result.put("message", "자신의 계정 상태는 변경할 수 없습니다.");
                return result;
            }
            adminService.changeMemberStatus(userIdx, status);
            result.put("success", true);
            result.put("message", "상태가 변경되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    // ════════════════════════════════════════════
    // 회원 권한 변경 (Ajax)
    // ════════════════════════════════════════════
    @PostMapping("/members/{userIdx}/role")
    @ResponseBody
    public Map<String, Object> changeRole(@PathVariable Long userIdx,
                                           @RequestParam String role,
                                           HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
            if (loginUser != null && loginUser.getUserIdx().equals(userIdx)) {
                result.put("success", false);
                result.put("message", "자신의 권한은 변경할 수 없습니다.");
                return result;
            }
            adminService.changeMemberRole(userIdx, role);
            result.put("success", true);
            result.put("message", "권한이 변경되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    // ════════════════════════════════════════════
    // 향후 확장 placeholder
    // ════════════════════════════════════════════

    // 게시글 관리
    // @GetMapping("/posts") → "admin/post/list"

    // 여행지 관리
    // @GetMapping("/destinations") → "admin/destination/list"

    // 통계
    // @GetMapping("/stats") → "admin/stats"
}
