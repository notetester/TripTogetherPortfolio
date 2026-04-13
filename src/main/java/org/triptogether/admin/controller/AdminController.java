package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.admin.service.AdminService;
import org.triptogether.admin.vo.*;
import org.triptogether.community.service.CommunityService;
import org.triptogether.report.service.ReportService;
import org.triptogether.report.vo.ReportDto;
import org.triptogether.report.vo.ReportSearchDto;

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
 *     <li>보안 이력</li>
 * </ul>
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;
    private final ReportService reportService;
    private final CommunityService communityService;

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
        model.addAttribute("stats", adminService.getInquiryStats());
        model.addAttribute("activeMenu", "inquiries");
        return "admin/inquiry/list";
    }

    @GetMapping("/inquiries/{inquiryId}")
    public String inquiryDetail(@PathVariable Long inquiryId, Model model) {
        AdminInquiryVO inquiry = adminService.getInquiryDetail(inquiryId);
        if (inquiry == null) {
            return "redirect:/admin/inquiries";
        }
        model.addAttribute("inquiry", inquiry);
        model.addAttribute("activeMenu", "inquiries");
        return "admin/inquiry/detail";
    }

    @PostMapping("/inquiries/{inquiryId}/answer")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> saveInquiryAnswer(
            @PathVariable Long inquiryId,
            @RequestParam String content,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
        try {
            adminService.saveInquiryAnswer(inquiryId, loginUser.getUserIdx(), content);
            result.put("success", true);
        } catch (Exception e) {
            log.error("답변 저장 오류 inquiryId={}", inquiryId, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    @PostMapping("/inquiries/{inquiryId}/answer/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteInquiryAnswer(@PathVariable Long inquiryId) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminService.deleteInquiryAnswer(inquiryId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("답변 삭제 오류 inquiryId={}", inquiryId, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    @PostMapping("/inquiries/{inquiryId}/status")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> changeInquiryStatus(
            @PathVariable Long inquiryId,
            @RequestParam String status) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminService.updateInquiryStatus(inquiryId, status);
            result.put("success", true);
        } catch (Exception e) {
            log.error("문의 상태 변경 오류 inquiryId={}", inquiryId, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    @PostMapping("/inquiries/{inquiryId}/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteInquiry(@PathVariable Long inquiryId) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminService.deleteInquiry(inquiryId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("문의 삭제 오류 inquiryId={}", inquiryId, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    @GetMapping("/reports")
    public String reportList(@ModelAttribute ReportSearchDto search, Model model) {
        model.addAttribute("reportList",  reportService.getReportList(search));
        model.addAttribute("totalCount",  reportService.getTotalCount(search));
        model.addAttribute("totalPage",   reportService.getTotalPage(search));
        model.addAttribute("search",      search);
        model.addAttribute("stats",       reportService.getReportStats());
        model.addAttribute("activeMenu",  "reports");
        return "admin/report/list";
    }

    @GetMapping("/reports/{reportId}")
    public String reportDetail(@PathVariable Long reportId, Model model) {
        var report = reportService.getReport(reportId);
        if (report == null) {
            return "redirect:/admin/reports";
        }
        model.addAttribute("report", report);
        model.addAttribute("activeMenu", "reports");
        return "admin/report/detail";
    }

    /**
     * 신고 처리
     *
     * action 값에 따른 처리:
     *   REJECTED      → 신고 반려 (DISMISSED), 콘텐츠/계정 유지
     *   DELETE_CONTENT → 게시물/댓글 삭제 후 RESOLVED  (POST·COMMENT 전용)
     *   BLOCK_AUTHOR  → 작성자 계정 차단 후 RESOLVED   (POST·COMMENT 전용)
     *   BLOCK_USER    → 신고 대상 유저 차단 후 RESOLVED (USER 전용)
     */
    @PostMapping("/report/{reportId}/resolve")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> resolveReport(
            @PathVariable Long reportId,
            @RequestParam String action,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        ReportDto report = reportService.getReport(reportId);
        if (report == null) {
            result.put("success", false);
            result.put("message", "신고를 찾을 수 없습니다.");
            return ResponseEntity.status(404).body(result);
        }

        var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
        Long resolverIdx = loginUser.getUserIdx();

        try {
            String targetType = report.getTargetType();
            Long   targetId   = report.getTargetId();

            switch (action) {

                case "REJECTED":
                    // 콘텐츠·계정 유지, 신고 반려
                    reportService.updateReportStatus(reportId, "DISMISSED", resolverIdx, null);
                    break;

                case "DELETE_CONTENT":
                    // 게시물 또는 댓글 삭제 후 신고 처리완료
                    if ("post".equals(targetType)) {
                        communityService.deletePost(targetId);
                    } else if ("comment".equals(targetType)) {
                        communityService.deleteComment(targetId);
                    } else {
                        result.put("success", false);
                        result.put("message", "해당 대상 유형에는 콘텐츠 삭제를 사용할 수 없습니다.");
                        return ResponseEntity.status(400).body(result);
                    }
                    reportService.updateReportStatus(reportId, "RESOLVED", resolverIdx,
                            "post".equals(targetType) ? "게시글 삭제" : "댓글 삭제");
                    break;

                case "BLOCK_AUTHOR":
                    // 작성자 계정 차단 후 신고 처리완료
                    Long authorIdx = null;
                    if ("post".equals(targetType)) {
                        authorIdx = adminService.getPostAuthorIdx(targetId);
                    } else if ("comment".equals(targetType)) {
                        authorIdx = adminService.getCommentAuthorIdx(targetId);
                    } else {
                        result.put("success", false);
                        result.put("message", "해당 대상 유형에는 작성자 차단을 사용할 수 없습니다.");
                        return ResponseEntity.status(400).body(result);
                    }
                    if (authorIdx == null) {
                        result.put("success", false);
                        result.put("message", "작성자를 찾을 수 없습니다.");
                        return ResponseEntity.status(404).body(result);
                    }
                    adminService.changeMemberStatus(authorIdx, "BLOCKED");
                    reportService.updateReportStatus(reportId, "RESOLVED", resolverIdx, "작성자 차단");
                    break;

                case "BLOCK_USER":
                    // 신고 대상 유저 차단 후 신고 처리완료 (USER 전용)
                    if (!"user".equals(targetType)) {
                        result.put("success", false);
                        result.put("message", "해당 대상 유형에는 유저 차단을 사용할 수 없습니다.");
                        return ResponseEntity.status(400).body(result);
                    }
                    adminService.changeMemberStatus(targetId, "BLOCKED");
                    reportService.updateReportStatus(reportId, "RESOLVED", resolverIdx, "유저 계정 차단");
                    break;

                case "DELETE_AND_BLOCK":
                    // 게시물/댓글 삭제 + 작성자 차단 후 신고 처리완료
                    Long authorIdxForBlock = null;
                    if ("post".equals(targetType)) {
                        authorIdxForBlock = adminService.getPostAuthorIdx(targetId);
                        communityService.deletePost(targetId);
                    } else if ("comment".equals(targetType)) {
                        authorIdxForBlock = adminService.getCommentAuthorIdx(targetId);
                        communityService.deleteComment(targetId);
                    } else {
                        result.put("success", false);
                        result.put("message", "해당 대상 유형에는 이 처리를 사용할 수 없습니다.");
                        return ResponseEntity.status(400).body(result);
                    }
                    if (authorIdxForBlock != null) {
                        adminService.changeMemberStatus(authorIdxForBlock, "BLOCKED");
                    }
                    reportService.updateReportStatus(reportId, "RESOLVED", resolverIdx,
                            "post".equals(targetType) ? "게시글 삭제 + 작성자 차단" : "댓글 삭제 + 작성자 차단");
                    break;

                case "REVERT_TO_PENDING":
                    // 반려/처리완료 → IN_REVIEW 복원
                    if ("IN_REVIEW".equals(report.getStatus())) {
                        result.put("success", false);
                        result.put("message", "이미 검토중 상태입니다.");
                        return ResponseEntity.status(400).body(result);
                    }
                    reportService.revertReportToPending(reportId);
                    break;

                default:
                    result.put("success", false);
                    result.put("message", "알 수 없는 처리 옵션입니다.");
                    return ResponseEntity.status(400).body(result);
            }

            result.put("success", true);

        } catch (Exception e) {
            log.error("신고 처리 오류 reportId={}", reportId, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }

    @GetMapping("/logins")
    public String loginAudit(AdminLoginAuditSearchVO search, Model model) {
        model.addAllAttributes(adminService.getLoginAuditList(search));
        model.addAttribute("activeMenu", "logins");
        return "admin/logs/list";
    }

    @GetMapping("/security")
    public String securityAudit(AdminSecurityAuditSearchVO search, Model model) {
        model.addAllAttributes(adminService.getSecurityAuditList(search));
        model.addAttribute("activeMenu", "security");
        return "admin/security/list";
    }

    @GetMapping("/email-verifications")
    public String emailVerificationRequests(AdminEmailVerificationRequestSearchVO search, Model model) {
        model.addAllAttributes(adminService.getEmailVerificationRequestList(search));
        model.addAttribute("activeMenu", "emailVerifications");
        return "admin/email-verification/list";
    }

    @GetMapping("/email-tokens")
    public String emailVerifications(AdminEmailVerificationSearchVO search, Model model) {
        model.addAllAttributes(adminService.getEmailVerificationList(search));
        model.addAttribute("activeMenu", "emailTokens");
        return "admin/email-token/list";
    }

    @GetMapping("/activity-logs")
    public String activityLogs(AdminActivityLogSearchVO search, Model model) {
        model.addAllAttributes(adminService.getActivityLogList(search));
        model.addAttribute("activeMenu", "activityLogs");
        return "admin/activity-log/list";
    }

}
