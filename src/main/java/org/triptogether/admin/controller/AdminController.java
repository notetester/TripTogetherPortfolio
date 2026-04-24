package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.admin.service.AdminExploreService;
import org.triptogether.admin.service.AdminPolicyService;
import org.triptogether.admin.service.AdminService;
import org.triptogether.admin.vo.*;
import org.triptogether.community.service.CommunityService;
import org.triptogether.explore.service.ExploreService;
import org.triptogether.explore.vo.ReviewVO;
import org.triptogether.report.service.ReportService;
import org.triptogether.report.vo.ReportSearchDto;
import org.triptogether.travelPackage.service.TravelPackageService;
/* ── 패키지의 동적 텍스트(제목, 요약, 여행지명 등)를 번역하기 위한 서비스 ── */
import org.triptogether.explore.service.SpotTextTranslationService;
import org.triptogether.travelPackage.vo.TravelPackageVO;
import org.triptogether.travelPackage.vo.TravelPackageRevisionVO;

import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.triptogether.admin.vo.AdminMemberVO;

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
    private final AdminPolicyService adminPolicyService;
    private final ReportService reportService;
    private final CommunityService communityService;
    private final TravelPackageService travelPackageService;
    /* ── 다국어 flash message를 위한 MessageSource ── */
    private final MessageSource messageSource;
    /* ── 동적 텍스트 번역 서비스 — 관리자 페이지에서도 패키지 제목/여행지명 등을 로케일에 맞게 번역 ── */
    private final SpotTextTranslationService translationService;
    private final ExploreService exploreService;
    private final AdminExploreService adminExploreService;

    @GetMapping({"", "/"})
    public String dashboard(Model model) {
        model.addAttribute("stats", adminService.getStats());
        model.addAttribute("chart", adminService.getDashboardChart(7));
        model.addAttribute("salesStats", adminService.getSalesDailyStats(30));
        model.addAttribute("activeMenu", "dashboard");
        return "admin/dashboard";
    }

    @GetMapping("/sales/stats")
    @ResponseBody
    public ResponseEntity<List<AdminSalesDailyStatVO>> salesStats(@RequestParam(defaultValue = "30") int days) {
        return ResponseEntity.ok(adminService.getSalesDailyStats(days));
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
        // ── 패키지 목록 조회 후, 동적 텍스트(제목/여행지명 등)를 현재 로케일에 맞게 번역 ──
        java.util.List<TravelPackageVO> packages = travelPackageService.getAdminPackages(status);
        translationService.translatePackages(packages);
        model.addAttribute("packageList", packages);

        // ── 수정 요청(리비전) 목록도 동일하게 번역 처리 ──
        java.util.List<TravelPackageRevisionVO> revisions = travelPackageService.getAdminPackageRevisions("PENDING");
        translationService.translatePackageRevisions(revisions);
        model.addAttribute("revisionList", revisions);

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
            redirectAttributes.addFlashAttribute("packageReviewMessage", msg("package.admin.message.approved"));
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
            redirectAttributes.addFlashAttribute("packageReviewMessage", msg("package.admin.message.rejected"));
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("packageReviewError", e.getMessage());
        }
        return "redirect:/admin/packages";
    }

    @PostMapping("/packages/revisions/{packageRevisionIdx}/approve")
    public String approvePackageRevision(@PathVariable Long packageRevisionIdx,
                                         HttpSession session,
                                         RedirectAttributes redirectAttributes) {
        var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
        Long reviewerUserIdx = loginUser != null ? loginUser.getUserIdx() : null;
        try {
            travelPackageService.approvePackageRevision(packageRevisionIdx, reviewerUserIdx);
            redirectAttributes.addFlashAttribute("packageReviewMessage", msg("package.admin.message.revisionApproved"));
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("packageReviewError", e.getMessage());
        }
        return "redirect:/admin/packages";
    }

    @PostMapping("/packages/revisions/{packageRevisionIdx}/reject")
    public String rejectPackageRevision(@PathVariable Long packageRevisionIdx,
                                        @RequestParam String rejectReason,
                                        HttpSession session,
                                        RedirectAttributes redirectAttributes) {
        var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
        Long reviewerUserIdx = loginUser != null ? loginUser.getUserIdx() : null;
        try {
            travelPackageService.rejectPackageRevision(packageRevisionIdx, rejectReason, reviewerUserIdx);
            redirectAttributes.addFlashAttribute("packageReviewMessage", msg("package.admin.message.revisionRejected"));
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
        Map<String, Object> context = adminService.getMemberContext(userIdx);
        Map<String, Object> result = new HashMap<>();
        if (context == null) {
            result.put("success", false);
            result.put("message", "회원을 찾을 수 없습니다.");
            return result;
        }
        result.put("success", true);
        result.putAll(context);
        return result;
    }

    @PostMapping("/members/{userIdx}/profile")
    @ResponseBody
    public Map<String, Object> updateMemberProfile(@PathVariable Long userIdx,
                                                   @RequestParam String nickname,
                                                   @RequestParam(required = false) String nationality,
                                                   @RequestParam(required = false) String preferredLang) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminService.updateMemberProfile(userIdx, nickname, nationality, preferredLang);
            result.put("success", true);
            result.put("message", "회원 기본 정보를 저장했습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/members/{userIdx}/email")
    @ResponseBody
    public Map<String, Object> updateMemberEmail(@PathVariable Long userIdx,
                                                 @RequestParam(required = false) String email) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminService.updateMemberEmail(userIdx, email);
            result.put("success", true);
            result.put("message", msg("admin.members.emailUpdated"));
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", msg(e.getMessage()));
        }
        return result;
    }

    @GetMapping("/ips/context")
    @ResponseBody
    public Map<String, Object> ipContext(@RequestParam String ipAddress) {
        Map<String, Object> context = adminService.getIpContext(ipAddress);
        Map<String, Object> result = new HashMap<>();
        if (context == null) {
            result.put("success", false);
            result.put("message", "IP 정보를 찾을 수 없습니다.");
            return result;
        }
        result.put("success", true);
        result.putAll(context);
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

    @PostMapping("/members/bulk/status")
    @ResponseBody
    public Map<String, Object> bulkMemberStatus(@RequestParam List<Long> userIdxList,
                                                @RequestParam String status,
                                                HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
            if (loginUser != null && userIdxList.contains(loginUser.getUserIdx())) {
                result.put("success", false);
                result.put("message", "자신의 계정 상태는 변경할 수 없습니다.");
                return result;
            }
            adminService.bulkChangeMemberStatus(userIdxList, status);
            result.put("success", true);
            result.put("message", userIdxList.size() + "명의 상태가 변경되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @GetMapping("/members/export")
    public ResponseEntity<byte[]> exportMembers(AdminSearchVO search,
                                                @RequestParam(defaultValue = "search") String scope,
                                                @RequestParam(required = false) String selectedIds,
                                                @RequestParam(defaultValue = "csv") String format) {
        try {
            List<AdminMemberVO> data;
            if ("all".equals(scope)) {
                data = adminService.getMembersForExport(new AdminSearchVO());
            } else if ("selected".equals(scope)) {
                List<Long> ids = (selectedIds == null || selectedIds.isBlank())
                    ? Collections.emptyList()
                    : Arrays.stream(selectedIds.split(","))
                        .map(String::trim).filter(s -> !s.isEmpty())
                        .map(Long::parseLong).collect(Collectors.toList());
                data = adminService.getMembersByIds(ids);
            } else {
                data = adminService.getMembersForExport(search);
            }

            if ("excel".equals(format)) {
                byte[] bytes = buildMemberExcel(data);
                return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"members.xlsx\"")
                    .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                    .body(bytes);
            } else {
                byte[] bytes = buildMemberCsv(data);
                return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"members.csv\"")
                    .contentType(MediaType.parseMediaType("text/csv; charset=UTF-8"))
                    .body(bytes);
            }
        } catch (Exception e) {
            log.error("회원 내보내기 실패", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    private byte[] buildMemberCsv(List<AdminMemberVO> data) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        StringBuilder sb = new StringBuilder("﻿");
        sb.append("번호,닉네임,아이디,이메일,상태,권한,등급,인증회원,이메일인증,가입일,최근로그인,로그인성공,로그인실패,소셜연동\n");
        for (AdminMemberVO m : data) {
            sb.append(csvVal(m.getUserIdx())).append(',')
              .append(csvVal(m.getNickname())).append(',')
              .append(csvVal(m.getUserId())).append(',')
              .append(csvVal(m.getUserEmail())).append(',')
              .append(csvVal(m.getAccountStatus())).append(',')
              .append(csvVal(m.getUserRole())).append(',')
              .append(csvVal(m.getMemberGrade())).append(',')
              .append(m.isVerifiedMember() ? "Y" : "N").append(',')
              .append(m.isEmailVerified() ? "Y" : "N").append(',')
              .append(m.getCreatedAt() != null ? sdf.format(m.getCreatedAt()) : "").append(',')
              .append(m.getLastLoginAt() != null ? sdf.format(m.getLastLoginAt()) : "").append(',')
              .append(m.getLoginSuccessCount()).append(',')
              .append(m.getLoginFailCount()).append(',')
              .append(csvVal(m.getLinkedProviders())).append('\n');
        }
        return sb.toString().getBytes(StandardCharsets.UTF_8);
    }

    private byte[] buildMemberExcel(List<AdminMemberVO> data) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try (XSSFWorkbook wb = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            var sheet = wb.createSheet("회원목록");
            String[] headers = {"번호","닉네임","아이디","이메일","상태","권한","등급","인증회원","이메일인증","가입일","최근로그인","로그인성공","로그인실패","소셜연동"};
            var hRow = sheet.createRow(0);
            for (int i = 0; i < headers.length; i++) hRow.createCell(i).setCellValue(headers[i]);
            int r = 1;
            for (AdminMemberVO m : data) {
                var row = sheet.createRow(r++);
                row.createCell(0).setCellValue(m.getUserIdx() != null ? m.getUserIdx() : 0);
                row.createCell(1).setCellValue(safe(m.getNickname()));
                row.createCell(2).setCellValue(safe(m.getUserId()));
                row.createCell(3).setCellValue(safe(m.getUserEmail()));
                row.createCell(4).setCellValue(safe(m.getAccountStatus()));
                row.createCell(5).setCellValue(safe(m.getUserRole()));
                row.createCell(6).setCellValue(safe(m.getMemberGrade()));
                row.createCell(7).setCellValue(m.isVerifiedMember() ? "Y" : "N");
                row.createCell(8).setCellValue(m.isEmailVerified() ? "Y" : "N");
                row.createCell(9).setCellValue(m.getCreatedAt() != null ? sdf.format(m.getCreatedAt()) : "");
                row.createCell(10).setCellValue(m.getLastLoginAt() != null ? sdf.format(m.getLastLoginAt()) : "");
                row.createCell(11).setCellValue(m.getLoginSuccessCount());
                row.createCell(12).setCellValue(m.getLoginFailCount());
                row.createCell(13).setCellValue(safe(m.getLinkedProviders()));
            }
            wb.write(out);
            return out.toByteArray();
        }
    }

    private String csvVal(Object v) {
        if (v == null) return "";
        String s = v.toString();
        if (s.contains(",") || s.contains("\"") || s.contains("\n"))
            s = "\"" + s.replace("\"", "\"\"") + "\"";
        return s;
    }

    private String safe(String s) { return s != null ? s : ""; }

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

    @GetMapping("/policies")
    public String policyList(Model model) {
        model.addAllAttributes(adminPolicyService.getPolicyDashboard());
        model.addAttribute("activeMenu", "policies");
        return "admin/policy/list";
    }

    @PostMapping("/policies/{policyCode}")
    @ResponseBody
    public Map<String, Object> updatePolicy(@PathVariable String policyCode,
                                            @RequestParam String configJson,
                                            @RequestParam String scheduleType,
                                            @RequestParam(required = false) Integer scheduleIntervalHours,
                                            @RequestParam(required = false) Integer scheduleDayOfMonth,
                                            @RequestParam(required = false) String scheduleTime,
                                            @RequestParam(defaultValue = "false") boolean active,
                                            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
            adminPolicyService.updatePolicy(policyCode, configJson, scheduleType, scheduleIntervalHours, scheduleDayOfMonth,
                    scheduleTime, active, loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", "운영 정책을 저장했습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/policies/{policyCode}/run")
    @ResponseBody
    public Map<String, Object> runPolicy(@PathVariable String policyCode, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            var loginUser = (org.triptogether.auth.vo.UsersVO) session.getAttribute("loginUser");
            adminPolicyService.runPolicyNow(policyCode, loginUser != null ? loginUser.getUserIdx() : null);
            result.put("success", true);
            result.put("message", "정책을 즉시 실행했습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    /**
     * 프로퍼티 키에 해당하는 메시지를 현재 로케일에 맞게 반환합니다.
     * 키가 없으면 키 문자열 자체를 반환합니다 (fallback).
     */
    private String msg(String code) {
        return messageSource.getMessage(code, null, code, LocaleContextHolder.getLocale());
    }

}
