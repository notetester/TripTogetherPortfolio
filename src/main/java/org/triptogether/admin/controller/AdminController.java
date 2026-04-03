package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.admin.service.AdminService;
import org.triptogether.admin.vo.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 관리자 화면 컨트롤러.
 *
 * <p>이번 정리 범위에서는 다음 화면을 제공한다.</p>
 * <ul>
 *     <li>대시보드</li>
 *     <li>회원 관리</li>
 *     <li>문의 관리</li>
 *     <li>로그인 감사</li>
 * </ul>
 */
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;

    @GetMapping({"", "/"})
    public String dashboard(Model model) {
        model.addAttribute("stats", adminService.getStats());
        model.addAttribute("activeMenu", "dashboard");
        return "admin/dashboard";
    }

    @GetMapping("/members")
    public String memberList(AdminSearchVO search, Model model) {
        model.addAllAttributes(adminService.getMemberList(search));
        model.addAttribute("activeMenu", "members");
        return "admin/member/list";
    }

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
        result.put("member", member);
        result.put("history", adminService.getLoginHistory(userIdx));
        return result;
    }

    @PostMapping("/members/{userIdx}/status")
    @ResponseBody
    public Map<String, Object> changeStatus(@PathVariable Long userIdx,
                                            @RequestParam String status,
                                            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
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

    @GetMapping("/inquiries")
    public String inquiryList(AdminInquirySearchVO search, Model model) {
        model.addAllAttributes(adminService.getInquiryList(search));
        model.addAttribute("activeMenu", "inquiries");
        return "admin/inquiry/list";
    }

    @GetMapping("/logins")
    public String loginAudit(AdminLoginAuditSearchVO search, Model model) {
        model.addAllAttributes(adminService.getLoginAuditList(search));
        model.addAttribute("activeMenu", "logins");
        return "admin/logs/list";
    }
}
