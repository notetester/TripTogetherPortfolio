package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.admin.service.AdminExploreService;
import org.triptogether.admin.service.AdminService;
import org.triptogether.admin.vo.*;
import org.triptogether.community.service.CommunityService;
import org.triptogether.explore.service.ExploreService;
import org.triptogether.explore.vo.ReviewVO;
import org.triptogether.report.service.ReportService;
import org.triptogether.report.vo.ReportSearchDto;
import org.triptogether.travelPackage.service.TravelPackageService;

import java.time.LocalDateTime;
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
    private final TravelPackageService travelPackageService;
    private final ExploreService exploreService;
    private final AdminExploreService adminExploreService;

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

    @GetMapping("/business-applications")
    public String businessApplicationList(@RequestParam(defaultValue = "PENDING") String status,
                                          Model model) {
        model.addAttribute("applicationList", adminService.getBusinessApplications(status));
        model.addAttribute("status", status == null || status.isBlank() ? "PENDING" : status);
        model.addAttribute("activeMenu", "businessApplications");
        return "admin/member/business-applications";
    }

    @GetMapping("/packages")
    public String packageList(@RequestParam(defaultValue = "PENDING") String status,
                              Model model) {
        model.addAttribute("packageList", travelPackageService.getAdminPackages(status));
        model.addAttribute("status", status == null || status.isBlank() ? "PENDING" : status);
        model.addAttribute("activeMenu", "packages");
        return "admin/package/list";
    }

    @PostMapping("/packages/{packageIdx}/approve")
    public String approvePackage(@PathVariable Long packageIdx,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
        Long reviewerUserIdx = loginUser != null ? loginUser.getUserIdx() : null;
        try {
            travelPackageService.approvePackage(packageIdx, reviewerUserIdx);
            redirectAttributes.addFlashAttribute("packageReviewMessage", "패키지 상품을 승인했습니다.");
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("packageReviewError", e.getMessage());
        }
        return "redirect:/admin/packages";
    }

    @PostMapping("/packages/{packageIdx}/reject")
    public String rejectPackage(@PathVariable Long packageIdx,
                                @RequestParam String rejectReason,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
        Long reviewerUserIdx = loginUser != null ? loginUser.getUserIdx() : null;
        try {
            travelPackageService.rejectPackage(packageIdx, rejectReason, reviewerUserIdx);
            redirectAttributes.addFlashAttribute("packageReviewMessage", "패키지 상품을 반려했습니다.");
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("packageReviewError", e.getMessage());
        }
        return "redirect:/admin/packages";
    }

    @PostMapping("/business-applications/{applicationIdx}/approve")
    public String approveBusinessApplication(@PathVariable Long applicationIdx,
                                             HttpSession session,
                                             RedirectAttributes redirectAttributes) {
        var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
        Long reviewerUserIdx = loginUser != null ? loginUser.getUserIdx() : null;
        try {
            adminService.approveBusinessApplication(applicationIdx, reviewerUserIdx);
            redirectAttributes.addFlashAttribute("businessApplicationMessage", "기업 회원 신청을 승인했습니다.");
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("businessApplicationError", e.getMessage());
        }
        return "redirect:/admin/business-applications";
    }

    @PostMapping("/business-applications/{applicationIdx}/reject")
    public String rejectBusinessApplication(@PathVariable Long applicationIdx,
                                            @RequestParam String rejectReason,
                                            HttpSession session,
                                            RedirectAttributes redirectAttributes) {
        var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
        Long reviewerUserIdx = loginUser != null ? loginUser.getUserIdx() : null;
        try {
            adminService.rejectBusinessApplication(applicationIdx, rejectReason, reviewerUserIdx);
            redirectAttributes.addFlashAttribute("businessApplicationMessage", "기업 회원 신청을 반려했습니다.");
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("businessApplicationError", e.getMessage());
        }
        return "redirect:/admin/business-applications";
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

    @PostMapping("/members/{userIdx}/block")
    @ResponseBody
    public Map<String, Object> blockMember(@PathVariable Long userIdx,
                                           @RequestParam String blockType,
                                           @RequestParam(required = false) String blockedIp,
                                           @RequestParam(required = false) String reason,
                                           @RequestParam(required = false) String expiresAt,
                                           HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
            if (loginUser != null && loginUser.getUserIdx().equals(userIdx)) {
                result.put("success", false);
                result.put("message", "자신의 계정은 차단할 수 없습니다.");
                return result;
            }
            LocalDateTime parsed = (expiresAt != null && !expiresAt.isBlank()) ? LocalDateTime.parse(expiresAt) : null;
            adminService.blockMember(userIdx, blockType, blockedIp != null ? blockedIp.trim() : null, reason != null ? reason.trim() : null, parsed, loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", "차단이 적용되었습니다.");
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
                                          @RequestParam(required = false) String reason,
                                          HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
            if (loginUser != null && loginUser.getUserIdx().equals(userIdx)) {
                result.put("success", false);
                result.put("message", "자신의 권한은 변경할 수 없습니다.");
                return result;
            }
            Long changedByUserIdx = loginUser != null ? loginUser.getUserIdx() : null;
            adminService.changeMemberRole(userIdx, role, reason, changedByUserIdx);
            result.put("success", true);
            result.put("message", "권한이 변경되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/members/{userIdx}/meta")
    @ResponseBody
    public Map<String, Object> updateMemberMeta(@PathVariable Long userIdx,
                                                @RequestParam(required = false) String memberGrade,
                                                @RequestParam(defaultValue = "false") boolean verifiedMember,
                                                @RequestParam(defaultValue = "0") long cashBalance,
                                                @RequestParam(defaultValue = "0") long mileageBalance,
                                                @RequestParam(defaultValue = "0") long pointBalance,
                                                @RequestParam(defaultValue = "1") int levelNo,
                                                @RequestParam(defaultValue = "0") long expPoints,
                                                @RequestParam(required = false) String adminPositionCode,
                                                @RequestParam(required = false) String adminPermissionCode) {
        Map<String, Object> result = new HashMap<>();
        try {
            AdminMemberVO member = AdminMemberVO.builder()
                    .userIdx(userIdx)
                    .memberGrade(memberGrade)
                    .verifiedMember(verifiedMember)
                    .cashBalance(cashBalance)
                    .mileageBalance(mileageBalance)
                    .pointBalance(pointBalance)
                    .levelNo(levelNo)
                    .expPoints(expPoints)
                    .adminPositionCode(adminPositionCode)
                    .adminPermissionCode(adminPermissionCode)
                    .build();
            adminService.updateMemberMeta(member);
            result.put("success", true);
            result.put("message", "회원 부가 정보가 저장되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    /**
     * 문의 목록 페이지.
     */
    @GetMapping("/inquiries")
    public String inquiryList(AdminInquirySearchVO search, Model model) {
        model.addAllAttributes(adminService.getInquiryList(search));
        model.addAttribute("stats", adminService.getInquiryStats());
        model.addAttribute("activeMenu", "inquiries");
        return "admin/inquiry/list";
    }

    /**
     * 문의 상세 페이지.
     */
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

    /**
     * 문의 답변 등록/수정.
     */
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

    /**
     * 문의 답변 삭제.
     */
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

    /**
     * 문의 상태 변경 (PENDING / IN_PROGRESS / COMPLETED).
     */
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

    /**
     * 문의 삭제.
     */
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

    /**
     * 신고 목록 페이지.
     * - 검색 조건(status / targetType / reason / keyword)과 페이지네이션 적용
     * - 신고 현황 통계(stats)도 함께 전달
     */
    @GetMapping("/reports")
    public String reportList(@ModelAttribute ReportSearchDto search, Model model) {
        var data = adminService.getAdminReportList(search);
        model.addAttribute("reportList", data.get("list"));
        model.addAttribute("paging",     data.get("paging"));
        model.addAttribute("totalCount", data.get("total"));
        model.addAttribute("search",     search);
        model.addAttribute("stats",      reportService.getReportStats());
        model.addAttribute("activeMenu", "reports");
        return "admin/report/list";
    }

    /**
     * 신고 상세 페이지.
     */
    @GetMapping("/reports/{reportId}")
    public String reportDetail(@PathVariable Long reportId, Model model) {
        AdminReportVO report = adminService.getAdminReport(reportId);
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

        AdminReportVO report = adminService.getAdminReport(reportId);
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
                    // 게시물/댓글/리뷰 차단 후 신고 처리완료
                    String deleteActionLabel;
                    if ("post".equals(targetType)) {
                        communityService.deletePost(targetId);
                        deleteActionLabel = "게시글 삭제";
                    } else if ("comment".equals(targetType)) {
                        communityService.deleteComment(targetId);
                        deleteActionLabel = "댓글 삭제";
                    } else if ("review".equals(targetType)) {
                        adminExploreService.blockReview(targetId);
                        deleteActionLabel = "리뷰 차단";
                    } else {
                        result.put("success", false);
                        result.put("message", "해당 대상 유형에는 콘텐츠 삭제를 사용할 수 없습니다.");
                        return ResponseEntity.status(400).body(result);
                    }
                    reportService.updateReportStatus(reportId, "RESOLVED", resolverIdx, deleteActionLabel);
                    break;

                case "BLOCK_AUTHOR":
                    // 작성자 계정 차단 후 신고 처리완료
                    Long authorIdx = null;
                    if ("post".equals(targetType)) {
                        authorIdx = adminService.getPostAuthorIdx(targetId);
                    } else if ("comment".equals(targetType)) {
                        authorIdx = adminService.getCommentAuthorIdx(targetId);
                    } else if ("review".equals(targetType)) {
                        ReviewVO review = exploreService.getReview(targetId);
                        authorIdx = (review != null) ? review.getUserIdx() : null;
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
                    // 게시물/댓글/리뷰 차단 + 작성자 차단 후 신고 처리완료
                    Long authorIdxForBlock = null;
                    String deleteBlockLabel;
                    if ("post".equals(targetType)) {
                        authorIdxForBlock = adminService.getPostAuthorIdx(targetId);
                        communityService.deletePost(targetId);
                        deleteBlockLabel = "게시글 삭제 + 작성자 차단";
                    } else if ("comment".equals(targetType)) {
                        authorIdxForBlock = adminService.getCommentAuthorIdx(targetId);
                        communityService.deleteComment(targetId);
                        deleteBlockLabel = "댓글 삭제 + 작성자 차단";
                    } else if ("review".equals(targetType)) {
                        ReviewVO review = exploreService.getReview(targetId);
                        authorIdxForBlock = (review != null) ? review.getUserIdx() : null;
                        adminExploreService.blockReview(targetId);
                        deleteBlockLabel = "리뷰 차단 + 작성자 차단";
                    } else {
                        result.put("success", false);
                        result.put("message", "해당 대상 유형에는 이 처리를 사용할 수 없습니다.");
                        return ResponseEntity.status(400).body(result);
                    }
                    if (authorIdxForBlock != null) {
                        adminService.changeMemberStatus(authorIdxForBlock, "BLOCKED");
                    }
                    reportService.updateReportStatus(reportId, "RESOLVED", resolverIdx, deleteBlockLabel);
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
