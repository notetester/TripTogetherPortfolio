package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.service.LoginRiskPolicyService;
import org.triptogether.auth.vo.AdminNotificationPreferenceVO;
import org.triptogether.auth.vo.LoginRiskExternalAssessmentVO;
import org.triptogether.auth.vo.LoginRiskPolicyVO;
import org.triptogether.auth.vo.LoginRiskReviewVO;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityAppealPolicyVO;
import org.triptogether.auth.vo.SecurityAppealVO;
import org.triptogether.auth.vo.SecurityReviewVO;
import org.triptogether.auth.vo.SecurityWafSyncQueueVO;
import org.triptogether.auth.vo.SecurityRiskAssessmentVO;
import org.triptogether.auth.vo.UsersVO;

import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/login-risk")
public class AdminLoginRiskPolicyController {

    private final LoginRiskPolicyService loginRiskPolicyService;
    private final MessageSource messageSource;

    @GetMapping("/policies")
    public String policies(Model model) {
        model.addAttribute("policies", loginRiskPolicyService.getPolicies(true));
        model.addAttribute("activeMenu", "loginRiskPolicies");
        model.addAttribute("pageTitleCode", "security.admin.policies.title");
        return "admin/login-risk/policies";
    }

    @PostMapping("/policies/{policyIdx}")
    public String updatePolicy(@PathVariable Long policyIdx,
                               LoginRiskPolicyVO policy,
                               @RequestParam(value = "active", required = false) String active,
                               @RequestParam(value = "resetOnSuccess", required = false) String resetOnSuccess,
                               @RequestParam(value = "requireAdminReview", required = false) String requireAdminReview,
                               @RequestParam(value = "aiAssistEnabled", required = false) String aiAssistEnabled,
                               @RequestParam(value = "wafSyncEnabled", required = false) String wafSyncEnabled,
                               HttpSession session,
                               RedirectAttributes redirectAttributes,
                               Locale locale) {
        policy.setPolicyIdx(policyIdx);
        policy.setActive(active != null);
        policy.setResetOnSuccess(resetOnSuccess != null);
        policy.setRequireAdminReview(requireAdminReview != null);
        policy.setAiAssistEnabled(aiAssistEnabled != null);
        policy.setWafSyncEnabled(wafSyncEnabled != null);
        loginRiskPolicyService.updatePolicy(policy, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.policySaved"));
        return "redirect:/admin/login-risk/policies";
    }


    @GetMapping("/appeal-policy")
    public String appealPolicy(Model model) {
        model.addAttribute("policy", loginRiskPolicyService.getSecurityAppealPolicy());
        model.addAttribute("policyHistories", loginRiskPolicyService.getSecurityAppealPolicyHistories(20));
        model.addAttribute("activeMenu", "securityAppealPolicy");
        model.addAttribute("pageTitleCode", "security.admin.appealPolicy.title");
        return "admin/login-risk/appeal-policy";
    }

    @PostMapping("/appeal-policy")
    public String updateAppealPolicy(SecurityAppealPolicyVO policy,
                                     @RequestParam(value = "active", required = false) String active,
                                     @RequestParam(value = "allowMultipleOpenAppeals", required = false) String allowMultipleOpenAppeals,
                                     @RequestParam(value = "closedBlocksNewAppeals", required = false) String closedBlocksNewAppeals,
                                     @RequestParam(value = "captchaEnabled", required = false) String captchaEnabled,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes,
                                     Locale locale) {
        policy.setActive(active != null);
        policy.setAllowMultipleOpenAppeals(allowMultipleOpenAppeals != null);
        policy.setClosedBlocksNewAppeals(closedBlocksNewAppeals != null);
        policy.setCaptchaEnabled(captchaEnabled != null);
        loginRiskPolicyService.updateSecurityAppealPolicy(policy, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.appealPolicySaved"));
        return "redirect:/admin/login-risk/appeal-policy";
    }

    @GetMapping("/reviews")
    public String reviews(@RequestParam(value = "status", required = false) String status,
                          @RequestParam(value = "severity", required = false) String severity,
                          @RequestParam(value = "reviewType", required = false) String reviewType,
                          @RequestParam(value = "keyword", required = false) String keyword,
                          @RequestParam(value = "searchType", required = false, defaultValue = "all") String searchType,
                          @RequestParam(value = "mode", required = false, defaultValue = "CLIENT") String mode,
                          @RequestParam(value = "page", required = false, defaultValue = "1") int page,
                          @RequestParam(value = "size", required = false, defaultValue = "20") int size,
                          @RequestParam(value = "sortBy", required = false) String sortBy,
                          @RequestParam(value = "sortDir", required = false, defaultValue = "ASC") String sortDir,
                          Model model) {
        String normalizedMode = "SERVER".equalsIgnoreCase(mode) ? "SERVER" : "CLIENT";
        int safeSize = "CLIENT".equals(normalizedMode) ? 10000 : Math.max(1, Math.min(size, 500));
        int safePage = Math.max(1, page);

        long total = loginRiskPolicyService.countReviewQueue(status, severity, reviewType, keyword, searchType);
        List<LoginRiskReviewVO> rows = loginRiskPolicyService.getReviewQueuePaged(
                status, severity, reviewType, keyword, searchType,
                sortBy, sortDir, safePage, safeSize);

        int totalPage = (int) Math.max(1, Math.ceil((double) total / safeSize));
        model.addAttribute("reviews", rows);
        model.addAttribute("total", total);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("currentPage", safePage);
        model.addAttribute("status", status);
        model.addAttribute("severity", severity);
        model.addAttribute("reviewType", reviewType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("searchType", searchType);
        model.addAttribute("mode", normalizedMode);
        model.addAttribute("pageSize", size);
        model.addAttribute("sortBy", sortBy);
        model.addAttribute("sortDir", sortDir);
        model.addAttribute("activeMenu", "loginRiskReviews");
        model.addAttribute("pageTitleCode", "security.admin.loginReviews.title");
        return "admin/login-risk/reviews";
    }

    @PostMapping("/reviews/{reviewIdx}/{decision}")
    public String decideReview(@PathVariable Long reviewIdx,
                               @PathVariable String decision,
                               @RequestParam(value = "comment", required = false) String comment,
                               HttpSession session,
                               RedirectAttributes redirectAttributes,
                               Locale locale) {
        loginRiskPolicyService.decideReview(reviewIdx, decision, currentAdminIdx(session), comment);
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.reviewProcessed"));
        return "redirect:/admin/login-risk/reviews";
    }

    @PostMapping("/reviews/bulk")
    public String bulkDecideReviews(@RequestParam("action") String action,
                                    @RequestParam(value = "ids", required = false) String idsCsv,
                                    @RequestParam(value = "comment", required = false) String comment,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes,
                                    Locale locale) {
        List<Long> ids = parseIds(idsCsv);
        int affected = loginRiskPolicyService.bulkDecideReviews(ids, action, currentAdminIdx(session), comment);
        redirectAttributes.addFlashAttribute("message",
                msg(locale, "security.admin.flash.bulkReviewProcessed") + " (" + affected + "/" + ids.size() + ")");
        return "redirect:/admin/login-risk/reviews";
    }

    @GetMapping("/reviews/export")
    public ResponseEntity<byte[]> exportLoginReviews(
            @RequestParam(value = "scope", required = false, defaultValue = "filtered") String scope,
            @RequestParam(value = "format", required = false, defaultValue = "csv") String format,
            @RequestParam(value = "selectedIds", required = false) String selectedIds,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "severity", required = false) String severity,
            @RequestParam(value = "reviewType", required = false) String reviewType,
            @RequestParam(value = "keyword", required = false) String keyword) {
        try {
            List<LoginRiskReviewVO> data;
            if ("all".equalsIgnoreCase(scope)) {
                data = loginRiskPolicyService.getReviewQueue(null, null, null, null);
            } else if ("selected".equalsIgnoreCase(scope)) {
                List<Long> ids = parseIds(selectedIds);
                if (ids.isEmpty()) {
                    return ResponseEntity.badRequest().build();
                }
                data = loginRiskPolicyService.getReviewQueue(null, null, null, null).stream()
                        .filter(r -> r.getReviewIdx() != null && ids.contains(r.getReviewIdx()))
                        .toList();
            } else {
                data = loginRiskPolicyService.getReviewQueue(status, severity, reviewType, keyword);
            }
            if ("excel".equalsIgnoreCase(format)) {
                byte[] bytes = buildLoginReviewExcel(data);
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"login-risk-reviews.xlsx\"")
                        .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                        .body(bytes);
            }
            byte[] bytes = buildLoginReviewCsv(data);
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"login-risk-reviews.csv\"")
                    .contentType(MediaType.parseMediaType("text/csv; charset=UTF-8"))
                    .body(bytes);
        } catch (Exception e) {
            log.error("로그인 위험 검토 내보내기 실패", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    private static final String[] LOGIN_REVIEW_EXPORT_HEADERS = {
            "reviewIdx", "reviewStatus", "severity", "reviewType", "policyCode",
            "subjectType", "subjectKey", "userId", "nickname", "ipAddress",
            "summary", "detailMessage", "reviewComment", "reviewedByUserId",
            "reviewedAt", "createdAt"
    };

    private byte[] buildLoginReviewCsv(List<LoginRiskReviewVO> data) {
        StringBuilder sb = new StringBuilder("﻿");
        sb.append(String.join(",", LOGIN_REVIEW_EXPORT_HEADERS)).append('\n');
        for (LoginRiskReviewVO r : data) {
            Object[] cols = loginReviewRow(r);
            for (int i = 0; i < cols.length; i++) {
                if (i > 0) sb.append(',');
                sb.append(csvVal(cols[i]));
            }
            sb.append('\n');
        }
        return sb.toString().getBytes(StandardCharsets.UTF_8);
    }

    private byte[] buildLoginReviewExcel(List<LoginRiskReviewVO> data) throws Exception {
        try (XSSFWorkbook wb = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            var sheet = wb.createSheet("login-risk-reviews");
            var hRow = sheet.createRow(0);
            for (int i = 0; i < LOGIN_REVIEW_EXPORT_HEADERS.length; i++) {
                hRow.createCell(i).setCellValue(LOGIN_REVIEW_EXPORT_HEADERS[i]);
            }
            int r = 1;
            for (LoginRiskReviewVO row : data) {
                Object[] cols = loginReviewRow(row);
                var sheetRow = sheet.createRow(r++);
                for (int i = 0; i < cols.length; i++) {
                    sheetRow.createCell(i).setCellValue(cols[i] == null ? "" : String.valueOf(cols[i]));
                }
            }
            wb.write(out);
            return out.toByteArray();
        }
    }

    private Object[] loginReviewRow(LoginRiskReviewVO r) {
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return new Object[]{
                r.getReviewIdx(),
                r.getReviewStatus(),
                r.getSeverity(),
                r.getReviewType(),
                r.getPolicyCode(),
                r.getSubjectType(),
                r.getSubjectKey(),
                r.getUserId(),
                r.getNickname(),
                r.getIpAddress(),
                r.getSummary(),
                r.getDetailMessage(),
                r.getReviewComment(),
                r.getReviewedByUserId(),
                r.getReviewedAt() == null ? "" : r.getReviewedAt().format(fmt),
                r.getCreatedAt() == null ? "" : r.getCreatedAt().format(fmt)
        };
    }

    @GetMapping("/assessments")
    public String assessments(@RequestParam(value = "sourceKind", required = false) String sourceKind,
                              @RequestParam(value = "riskLevel", required = false) String riskLevel,
                              @RequestParam(value = "decisionStatus", required = false) String decisionStatus,
                              @RequestParam(value = "keyword", required = false) String keyword,
                              Model model) {
        model.addAttribute("assessments", loginRiskPolicyService.getExternalAssessments(sourceKind, riskLevel, decisionStatus, keyword));
        model.addAttribute("sourceKind", sourceKind);
        model.addAttribute("riskLevel", riskLevel);
        model.addAttribute("decisionStatus", decisionStatus);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "loginRiskAssessments");
        model.addAttribute("pageTitleCode", "security.admin.externalAssessments.title");
        return "admin/login-risk/assessments";
    }

    @GetMapping("/assessments/export")
    public ResponseEntity<byte[]> exportExternalAssessments(
            @RequestParam(value = "scope", required = false, defaultValue = "filtered") String scope,
            @RequestParam(value = "format", required = false, defaultValue = "csv") String format,
            @RequestParam(value = "selectedIds", required = false) String selectedIds,
            @RequestParam(value = "sourceKind", required = false) String sourceKind,
            @RequestParam(value = "riskLevel", required = false) String riskLevel,
            @RequestParam(value = "decisionStatus", required = false) String decisionStatus,
            @RequestParam(value = "keyword", required = false) String keyword) {
        try {
            List<LoginRiskExternalAssessmentVO> data;
            if ("all".equalsIgnoreCase(scope)) {
                data = loginRiskPolicyService.getExternalAssessments(null, null, null, null);
            } else if ("selected".equalsIgnoreCase(scope)) {
                List<Long> ids = parseIds(selectedIds);
                if (ids.isEmpty()) {
                    return ResponseEntity.badRequest().build();
                }
                data = loginRiskPolicyService.getExternalAssessments(null, null, null, null).stream()
                        .filter(a -> a.getAssessmentIdx() != null && ids.contains(a.getAssessmentIdx()))
                        .toList();
            } else {
                data = loginRiskPolicyService.getExternalAssessments(sourceKind, riskLevel, decisionStatus, keyword);
            }
            if ("excel".equalsIgnoreCase(format)) {
                byte[] bytes = buildExternalAssessmentExcel(data);
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"external-assessments.xlsx\"")
                        .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                        .body(bytes);
            }
            byte[] bytes = buildExternalAssessmentCsv(data);
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"external-assessments.csv\"")
                    .contentType(MediaType.parseMediaType("text/csv; charset=UTF-8"))
                    .body(bytes);
        } catch (Exception e) {
            log.error("외부 위험 판단 내보내기 실패", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    private static final String[] EXTERNAL_ASSESSMENT_EXPORT_HEADERS = {
            "assessmentIdx", "sourceKind", "sourceCode", "sourceName", "sourceVersion",
            "policyCode", "subjectType", "subjectKey", "userId", "nickname", "ipAddress",
            "countryCode", "asn", "riskScore", "riskLevel", "confidenceScore",
            "recommendationAction", "recommendationReason", "evidenceSummary",
            "decisionStatus", "createdAt"
    };

    private byte[] buildExternalAssessmentCsv(List<LoginRiskExternalAssessmentVO> data) {
        StringBuilder sb = new StringBuilder("﻿");
        sb.append(String.join(",", EXTERNAL_ASSESSMENT_EXPORT_HEADERS)).append('\n');
        for (LoginRiskExternalAssessmentVO a : data) {
            Object[] cols = externalAssessmentRow(a);
            for (int i = 0; i < cols.length; i++) {
                if (i > 0) sb.append(',');
                sb.append(csvVal(cols[i]));
            }
            sb.append('\n');
        }
        return sb.toString().getBytes(StandardCharsets.UTF_8);
    }

    private byte[] buildExternalAssessmentExcel(List<LoginRiskExternalAssessmentVO> data) throws Exception {
        try (XSSFWorkbook wb = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            var sheet = wb.createSheet("external-assessments");
            var hRow = sheet.createRow(0);
            for (int i = 0; i < EXTERNAL_ASSESSMENT_EXPORT_HEADERS.length; i++) {
                hRow.createCell(i).setCellValue(EXTERNAL_ASSESSMENT_EXPORT_HEADERS[i]);
            }
            int r = 1;
            for (LoginRiskExternalAssessmentVO a : data) {
                Object[] cols = externalAssessmentRow(a);
                var row = sheet.createRow(r++);
                for (int i = 0; i < cols.length; i++) {
                    row.createCell(i).setCellValue(cols[i] == null ? "" : String.valueOf(cols[i]));
                }
            }
            wb.write(out);
            return out.toByteArray();
        }
    }

    private Object[] externalAssessmentRow(LoginRiskExternalAssessmentVO a) {
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return new Object[]{
                a.getAssessmentIdx(),
                a.getSourceKind(), a.getSourceCode(), a.getSourceName(), a.getSourceVersion(),
                a.getPolicyCode(), a.getSubjectType(), a.getSubjectKey(),
                a.getUserId(), a.getNickname(), a.getIpAddress(),
                a.getCountryCode(), a.getAsn(),
                a.getRiskScore(), a.getRiskLevel(), a.getConfidenceScore(),
                a.getRecommendationAction(), a.getRecommendationReason(), a.getEvidenceSummary(),
                a.getDecisionStatus(),
                a.getCreatedAt() == null ? "" : a.getCreatedAt().format(fmt)
        };
    }

    @GetMapping("/security-assessments")
    public String securityAssessments(@RequestParam(value = "assessmentScope", required = false) String assessmentScope,
                                      @RequestParam(value = "sourceKind", required = false) String sourceKind,
                                      @RequestParam(value = "riskLevel", required = false) String riskLevel,
                                      @RequestParam(value = "decisionStatus", required = false) String decisionStatus,
                                      @RequestParam(value = "keyword", required = false) String keyword,
                                      Model model) {
        model.addAttribute("assessments", loginRiskPolicyService.getSecurityRiskAssessments(assessmentScope, sourceKind, riskLevel, decisionStatus, keyword));
        model.addAttribute("assessmentScope", assessmentScope);
        model.addAttribute("sourceKind", sourceKind);
        model.addAttribute("riskLevel", riskLevel);
        model.addAttribute("decisionStatus", decisionStatus);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "securityRiskAssessments");
        model.addAttribute("pageTitleCode", "security.admin.securityAssessments.title");
        return "admin/login-risk/security-assessments";
    }

    @PostMapping("/security-assessments/{assessmentIdx}/apply-user-block")
    public String applyUserBlockFromAssessment(@PathVariable Long assessmentIdx,
                                               HttpSession session,
                                               RedirectAttributes redirectAttributes,
                                               Locale locale) {
        loginRiskPolicyService.applyUserBlockFromSecurityAssessment(assessmentIdx, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.assessmentUserBlockApplied"));
        return "redirect:/admin/login-risk/security-assessments";
    }

    @PostMapping("/security-assessments/{assessmentIdx}/create-review")
    public String createSecurityReview(@PathVariable Long assessmentIdx,
                                       @RequestParam(value = "severity", required = false) String severity,
                                       @RequestParam(value = "summary", required = false) String summary,
                                       @RequestParam(value = "detailMessage", required = false) String detailMessage,
                                       RedirectAttributes redirectAttributes,
                                       Locale locale) {
        loginRiskPolicyService.createSecurityReviewFromAssessment(assessmentIdx, severity, summary, detailMessage);
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.assessmentQueued"));
        return "redirect:/admin/login-risk/security-assessments";
    }

    @PostMapping("/security-assessments/bulk")
    public String bulkSecurityAssessmentAction(@RequestParam("action") String action,
                                               @RequestParam(value = "ids", required = false) String idsCsv,
                                               HttpSession session,
                                               RedirectAttributes redirectAttributes,
                                               Locale locale) {
        List<Long> ids = parseIds(idsCsv);
        int affected = loginRiskPolicyService.bulkActOnSecurityAssessments(ids, action, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message",
                msg(locale, "security.admin.flash.assessmentBulkProcessed") + " (" + affected + "/" + ids.size() + ")");
        return "redirect:/admin/login-risk/security-assessments";
    }

    @GetMapping("/security-assessments/export")
    public ResponseEntity<byte[]> exportSecurityAssessments(
            @RequestParam(value = "scope", required = false, defaultValue = "filtered") String scope,
            @RequestParam(value = "format", required = false, defaultValue = "csv") String format,
            @RequestParam(value = "selectedIds", required = false) String selectedIds,
            @RequestParam(value = "assessmentScope", required = false) String assessmentScope,
            @RequestParam(value = "sourceKind", required = false) String sourceKind,
            @RequestParam(value = "riskLevel", required = false) String riskLevel,
            @RequestParam(value = "decisionStatus", required = false) String decisionStatus,
            @RequestParam(value = "keyword", required = false) String keyword) {
        try {
            List<SecurityRiskAssessmentVO> data;
            if ("all".equalsIgnoreCase(scope)) {
                data = loginRiskPolicyService.getSecurityRiskAssessments(null, null, null, null, null);
            } else if ("selected".equalsIgnoreCase(scope)) {
                List<Long> ids = parseIds(selectedIds);
                if (ids.isEmpty()) {
                    return ResponseEntity.badRequest().build();
                }
                data = loginRiskPolicyService.getSecurityRiskAssessments(null, null, null, null, null).stream()
                        .filter(a -> a.getAssessmentIdx() != null && ids.contains(a.getAssessmentIdx()))
                        .toList();
            } else {
                data = loginRiskPolicyService.getSecurityRiskAssessments(assessmentScope, sourceKind, riskLevel, decisionStatus, keyword);
            }
            if ("excel".equalsIgnoreCase(format)) {
                byte[] bytes = buildSecurityAssessmentExcel(data);
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"security-assessments.xlsx\"")
                        .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                        .body(bytes);
            }
            byte[] bytes = buildSecurityAssessmentCsv(data);
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"security-assessments.csv\"")
                    .contentType(MediaType.parseMediaType("text/csv; charset=UTF-8"))
                    .body(bytes);
        } catch (Exception e) {
            log.error("보안 위험 판단 내보내기 실패", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    private static final String[] SECURITY_ASSESSMENT_EXPORT_HEADERS = {
            "assessmentIdx", "assessmentScope", "sourceKind", "sourceCode", "sourceName", "sourceVersion",
            "policyCode", "subjectType", "subjectKey", "userId", "nickname", "ipAddress",
            "countryCode", "asn", "contentType", "contentId",
            "riskScore", "riskLevel", "confidenceScore",
            "recommendationAction", "recommendationReason", "evidenceSummary",
            "decisionStatus", "createdAt"
    };

    private byte[] buildSecurityAssessmentCsv(List<SecurityRiskAssessmentVO> data) {
        StringBuilder sb = new StringBuilder("﻿");
        sb.append(String.join(",", SECURITY_ASSESSMENT_EXPORT_HEADERS)).append('\n');
        for (SecurityRiskAssessmentVO a : data) {
            Object[] cols = securityAssessmentRow(a);
            for (int i = 0; i < cols.length; i++) {
                if (i > 0) sb.append(',');
                sb.append(csvVal(cols[i]));
            }
            sb.append('\n');
        }
        return sb.toString().getBytes(StandardCharsets.UTF_8);
    }

    private byte[] buildSecurityAssessmentExcel(List<SecurityRiskAssessmentVO> data) throws Exception {
        try (XSSFWorkbook wb = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            var sheet = wb.createSheet("security-assessments");
            var hRow = sheet.createRow(0);
            for (int i = 0; i < SECURITY_ASSESSMENT_EXPORT_HEADERS.length; i++) {
                hRow.createCell(i).setCellValue(SECURITY_ASSESSMENT_EXPORT_HEADERS[i]);
            }
            int r = 1;
            for (SecurityRiskAssessmentVO a : data) {
                Object[] cols = securityAssessmentRow(a);
                var row = sheet.createRow(r++);
                for (int i = 0; i < cols.length; i++) {
                    row.createCell(i).setCellValue(cols[i] == null ? "" : String.valueOf(cols[i]));
                }
            }
            wb.write(out);
            return out.toByteArray();
        }
    }

    private Object[] securityAssessmentRow(SecurityRiskAssessmentVO a) {
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return new Object[]{
                a.getAssessmentIdx(),
                a.getAssessmentScope(),
                a.getSourceKind(), a.getSourceCode(), a.getSourceName(), a.getSourceVersion(),
                a.getPolicyCode(), a.getSubjectType(), a.getSubjectKey(),
                a.getUserId(), a.getNickname(), a.getIpAddress(),
                a.getCountryCode(), a.getAsn(),
                a.getContentType(), a.getContentId(),
                a.getRiskScore(), a.getRiskLevel(), a.getConfidenceScore(),
                a.getRecommendationAction(), a.getRecommendationReason(), a.getEvidenceSummary(),
                a.getDecisionStatus(),
                a.getCreatedAt() == null ? "" : a.getCreatedAt().format(fmt)
        };
    }

    @GetMapping("/security-reviews")
    public String securityReviews(@RequestParam(value = "status", required = false) String status,
                                  @RequestParam(value = "severity", required = false) String severity,
                                  @RequestParam(value = "reviewType", required = false) String reviewType,
                                  @RequestParam(value = "keyword", required = false) String keyword,
                                  Model model) {
        model.addAttribute("reviews", loginRiskPolicyService.getSecurityReviews(status, severity, reviewType, keyword));
        model.addAttribute("status", status);
        model.addAttribute("severity", severity);
        model.addAttribute("reviewType", reviewType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "securityReviews");
        model.addAttribute("pageTitleCode", "security.admin.securityReviews.title");
        return "admin/login-risk/security-reviews";
    }

    @PostMapping("/security-reviews/{reviewIdx}/{decision}")
    public String decideSecurityReview(@PathVariable Long reviewIdx,
                                       @PathVariable String decision,
                                       @RequestParam(value = "comment", required = false) String comment,
                                       HttpSession session,
                                       RedirectAttributes redirectAttributes,
                               Locale locale) {
        loginRiskPolicyService.decideSecurityReview(reviewIdx, decision, currentAdminIdx(session), comment);
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.securityReviewProcessed"));
        return "redirect:/admin/login-risk/security-reviews";
    }

    @PostMapping("/security-reviews/bulk")
    public String bulkDecideSecurityReviews(@RequestParam("action") String action,
                                            @RequestParam(value = "ids", required = false) String idsCsv,
                                            @RequestParam(value = "comment", required = false) String comment,
                                            HttpSession session,
                                            RedirectAttributes redirectAttributes,
                                            Locale locale) {
        List<Long> ids = parseIds(idsCsv);
        int affected = loginRiskPolicyService.bulkDecideSecurityReviews(ids, action, currentAdminIdx(session), comment);
        redirectAttributes.addFlashAttribute("message",
                msg(locale, "security.admin.flash.bulkSecurityReviewProcessed") + " (" + affected + "/" + ids.size() + ")");
        return "redirect:/admin/login-risk/security-reviews";
    }

    @GetMapping("/security-reviews/export")
    public ResponseEntity<byte[]> exportSecurityReviews(
            @RequestParam(value = "scope", required = false, defaultValue = "filtered") String scope,
            @RequestParam(value = "format", required = false, defaultValue = "csv") String format,
            @RequestParam(value = "selectedIds", required = false) String selectedIds,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "severity", required = false) String severity,
            @RequestParam(value = "reviewType", required = false) String reviewType,
            @RequestParam(value = "keyword", required = false) String keyword) {
        try {
            List<SecurityReviewVO> data;
            if ("all".equalsIgnoreCase(scope)) {
                data = loginRiskPolicyService.getSecurityReviews(null, null, null, null);
            } else if ("selected".equalsIgnoreCase(scope)) {
                List<Long> ids = parseIds(selectedIds);
                if (ids.isEmpty()) {
                    return ResponseEntity.badRequest().build();
                }
                data = loginRiskPolicyService.getSecurityReviews(null, null, null, null).stream()
                        .filter(r -> r.getReviewIdx() != null && ids.contains(r.getReviewIdx()))
                        .toList();
            } else {
                data = loginRiskPolicyService.getSecurityReviews(status, severity, reviewType, keyword);
            }
            if ("excel".equalsIgnoreCase(format)) {
                byte[] bytes = buildSecurityReviewExcel(data);
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"security-reviews.xlsx\"")
                        .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                        .body(bytes);
            }
            byte[] bytes = buildSecurityReviewCsv(data);
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"security-reviews.csv\"")
                    .contentType(MediaType.parseMediaType("text/csv; charset=UTF-8"))
                    .body(bytes);
        } catch (Exception e) {
            log.error("일반 검토 큐 내보내기 실패", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    private static final String[] SECURITY_REVIEW_EXPORT_HEADERS = {
            "reviewIdx", "reviewStatus", "severity", "reviewType", "assessmentScope",
            "subjectType", "subjectKey", "userId", "nickname", "ipAddress",
            "summary", "detailMessage", "reviewComment", "reviewedByUserId",
            "reviewedAt", "createdAt"
    };

    private byte[] buildSecurityReviewCsv(List<SecurityReviewVO> data) {
        StringBuilder sb = new StringBuilder("﻿");
        sb.append(String.join(",", SECURITY_REVIEW_EXPORT_HEADERS)).append('\n');
        for (SecurityReviewVO r : data) {
            Object[] cols = securityReviewRow(r);
            for (int i = 0; i < cols.length; i++) {
                if (i > 0) sb.append(',');
                sb.append(csvVal(cols[i]));
            }
            sb.append('\n');
        }
        return sb.toString().getBytes(StandardCharsets.UTF_8);
    }

    private byte[] buildSecurityReviewExcel(List<SecurityReviewVO> data) throws Exception {
        try (XSSFWorkbook wb = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            var sheet = wb.createSheet("security-reviews");
            var hRow = sheet.createRow(0);
            for (int i = 0; i < SECURITY_REVIEW_EXPORT_HEADERS.length; i++) {
                hRow.createCell(i).setCellValue(SECURITY_REVIEW_EXPORT_HEADERS[i]);
            }
            int r = 1;
            for (SecurityReviewVO row : data) {
                Object[] cols = securityReviewRow(row);
                var sheetRow = sheet.createRow(r++);
                for (int i = 0; i < cols.length; i++) {
                    sheetRow.createCell(i).setCellValue(cols[i] == null ? "" : String.valueOf(cols[i]));
                }
            }
            wb.write(out);
            return out.toByteArray();
        }
    }

    private Object[] securityReviewRow(SecurityReviewVO r) {
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return new Object[]{
                r.getReviewIdx(),
                r.getReviewStatus(),
                r.getSeverity(),
                r.getReviewType(),
                r.getAssessmentScope(),
                r.getSubjectType(),
                r.getSubjectKey(),
                r.getUserId(),
                r.getNickname(),
                r.getIpAddress(),
                r.getSummary(),
                r.getDetailMessage(),
                r.getReviewComment(),
                r.getReviewedByUserId(),
                r.getReviewedAt() == null ? "" : r.getReviewedAt().format(fmt),
                r.getCreatedAt() == null ? "" : r.getCreatedAt().format(fmt)
        };
    }

    @GetMapping("/appeals")
    public String securityAppeals(@RequestParam(value = "status", required = false) String status,
                                  @RequestParam(value = "targetType", required = false) String targetType,
                                  @RequestParam(value = "keyword", required = false) String keyword,
                                  Model model) {
        model.addAttribute("appeals", loginRiskPolicyService.getSecurityAppeals(status, targetType, keyword));
        model.addAttribute("status", status);
        model.addAttribute("targetType", targetType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "securityAppeals");
        model.addAttribute("pageTitleCode", "security.admin.appeals.title");
        return "admin/login-risk/appeals";
    }

    @PostMapping("/appeals/{appealIdx}/{decision}")
    public String decideSecurityAppeal(@PathVariable Long appealIdx,
                                       @PathVariable String decision,
                                       @RequestParam(value = "comment", required = false) String comment,
                                       HttpSession session,
                                       RedirectAttributes redirectAttributes,
                               Locale locale) {
        loginRiskPolicyService.decideSecurityAppeal(appealIdx, decision, currentAdminIdx(session), comment);
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.appealProcessed"));
        return "redirect:/admin/login-risk/appeals";
    }

    @PostMapping("/appeals/bulk")
    public String bulkDecideSecurityAppeals(@RequestParam("action") String action,
                                            @RequestParam(value = "ids", required = false) String idsCsv,
                                            @RequestParam(value = "comment", required = false) String comment,
                                            HttpSession session,
                                            RedirectAttributes redirectAttributes,
                                            Locale locale) {
        List<Long> ids = parseIds(idsCsv);
        int affected = loginRiskPolicyService.bulkDecideSecurityAppeals(ids, action, currentAdminIdx(session), comment);
        redirectAttributes.addFlashAttribute("message",
                msg(locale, "security.admin.flash.bulkAppealProcessed") + " (" + affected + "/" + ids.size() + ")");
        return "redirect:/admin/login-risk/appeals";
    }

    @GetMapping("/appeals/export")
    public ResponseEntity<byte[]> exportSecurityAppeals(
            @RequestParam(value = "scope", required = false, defaultValue = "filtered") String scope,
            @RequestParam(value = "format", required = false, defaultValue = "csv") String format,
            @RequestParam(value = "selectedIds", required = false) String selectedIds,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "targetType", required = false) String targetType,
            @RequestParam(value = "keyword", required = false) String keyword) {
        try {
            List<SecurityAppealVO> data;
            if ("all".equalsIgnoreCase(scope)) {
                data = loginRiskPolicyService.getSecurityAppeals(null, null, null);
            } else if ("selected".equalsIgnoreCase(scope)) {
                List<Long> ids = parseIds(selectedIds);
                if (ids.isEmpty()) {
                    return ResponseEntity.badRequest().build();
                }
                data = loginRiskPolicyService.getSecurityAppeals(null, null, null).stream()
                        .filter(a -> a.getAppealIdx() != null && ids.contains(a.getAppealIdx()))
                        .toList();
            } else {
                data = loginRiskPolicyService.getSecurityAppeals(status, targetType, keyword);
            }
            if ("excel".equalsIgnoreCase(format)) {
                byte[] bytes = buildAppealExcel(data);
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"security-appeals.xlsx\"")
                        .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                        .body(bytes);
            }
            byte[] bytes = buildAppealCsv(data);
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"security-appeals.csv\"")
                    .contentType(MediaType.parseMediaType("text/csv; charset=UTF-8"))
                    .body(bytes);
        } catch (Exception e) {
            log.error("이의제기 내보내기 실패", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    private static final String[] APPEAL_EXPORT_HEADERS = {
            "appealIdx", "appealStatus", "userId", "nickname", "targetType", "targetKey",
            "appealTitle", "appealContent", "reviewComment", "publicRequestId",
            "submitterEmail", "inquiryId", "blockRequestId", "blockAccessRequestId",
            "reviewedByUserId", "reviewedAt", "createdAt", "updatedAt"
    };

    private byte[] buildAppealCsv(List<SecurityAppealVO> data) {
        StringBuilder sb = new StringBuilder("﻿");
        sb.append(String.join(",", APPEAL_EXPORT_HEADERS)).append('\n');
        for (SecurityAppealVO a : data) {
            Object[] cols = appealRow(a);
            for (int i = 0; i < cols.length; i++) {
                if (i > 0) sb.append(',');
                sb.append(csvVal(cols[i]));
            }
            sb.append('\n');
        }
        return sb.toString().getBytes(StandardCharsets.UTF_8);
    }

    private byte[] buildAppealExcel(List<SecurityAppealVO> data) throws Exception {
        try (XSSFWorkbook wb = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            var sheet = wb.createSheet("security-appeals");
            var hRow = sheet.createRow(0);
            for (int i = 0; i < APPEAL_EXPORT_HEADERS.length; i++) {
                hRow.createCell(i).setCellValue(APPEAL_EXPORT_HEADERS[i]);
            }
            int r = 1;
            for (SecurityAppealVO a : data) {
                Object[] cols = appealRow(a);
                var row = sheet.createRow(r++);
                for (int i = 0; i < cols.length; i++) {
                    row.createCell(i).setCellValue(cols[i] == null ? "" : String.valueOf(cols[i]));
                }
            }
            wb.write(out);
            return out.toByteArray();
        }
    }

    private Object[] appealRow(SecurityAppealVO a) {
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return new Object[]{
                a.getAppealIdx(),
                a.getAppealStatus(),
                a.getUserId(),
                a.getNickname(),
                a.getTargetType(),
                a.getTargetKey(),
                a.getAppealTitle(),
                a.getAppealContent(),
                a.getReviewComment(),
                a.getPublicRequestId(),
                a.getSubmitterEmail(),
                a.getInquiryId(),
                a.getBlockRequestId(),
                a.getBlockAccessRequestId(),
                a.getReviewedByUserId(),
                a.getReviewedAt() == null ? "" : a.getReviewedAt().format(fmt),
                a.getCreatedAt() == null ? "" : a.getCreatedAt().format(fmt),
                a.getUpdatedAt() == null ? "" : a.getUpdatedAt().format(fmt)
        };
    }

    @GetMapping("/provider-configs")
    public String providerConfigs(Model model) {
        model.addAttribute("activeMenu", "securityProviderConfigs");
        model.addAttribute("pageTitleCode", "security.admin.provider.title");
        return "admin/login-risk/provider-configs";
    }

    @GetMapping("/provider-configs/api")
    @ResponseBody
    public Map<String, Object> searchProviderConfigsApi(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "kind", required = false) String kind,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "enabled", required = false) String enabled,
            @RequestParam(value = "failOpen", required = false) String failOpen,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "triggerEvent", required = false) String triggerEvent,
            @RequestParam(value = "includeDeleted", required = false, defaultValue = "false") boolean includeDeleted,
            @RequestParam(value = "onlyDeleted", required = false, defaultValue = "false") boolean onlyDeleted,
            @RequestParam(value = "sort", required = false, defaultValue = "priority_desc") String sort,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "pageSize", required = false, defaultValue = "20") int pageSize) {
        LoginRiskPolicyService.ProviderConfigFilter filter = new LoginRiskPolicyService.ProviderConfigFilter();
        filter.keyword = keyword;
        filter.kind = kind;
        filter.status = status;
        filter.enabled = enabled;
        filter.failOpen = failOpen;
        filter.category = category;
        filter.triggerEvent = triggerEvent;
        filter.includeDeleted = includeDeleted;
        filter.onlyDeleted = onlyDeleted;
        filter.sort = sort;
        filter.page = Math.max(1, page);
        filter.pageSize = Math.max(0, Math.min(pageSize, 500));

        LoginRiskPolicyService.ProviderConfigSearchResult result = loginRiskPolicyService.searchProviderConfigs(filter);
        Map<String, Object> body = new HashMap<>();
        body.put("rows", result.rows());
        body.put("total", result.total());
        body.put("page", result.page());
        body.put("pageSize", result.pageSize());
        int totalPage = filter.pageSize <= 0 ? 1 : Math.max(1, (int) Math.ceil((double) result.total() / filter.pageSize));
        body.put("totalPage", totalPage);
        return body;
    }

    @GetMapping("/provider-configs/{providerIdx}/api")
    @ResponseBody
    public SecurityAssessmentProviderConfigVO getProviderConfigApi(@PathVariable Long providerIdx) {
        return loginRiskPolicyService.getProviderConfigByIdx(providerIdx);
    }

    @PostMapping("/provider-configs")
    public String createProviderConfig(SecurityAssessmentProviderConfigVO config,
                                       @RequestParam(value = "enabled", required = false) String enabled,
                                       @RequestParam(value = "failOpen", required = false) Integer failOpen,
                                       HttpSession session,
                                       RedirectAttributes redirectAttributes,
                                       Locale locale) {
        config.setEnabled(enabled != null);
        config.setFailOpen(failOpen == null ? 1 : failOpen);
        try {
            SecurityAssessmentProviderConfigVO saved = loginRiskPolicyService.createProviderConfig(config, currentAdminIdx(session));
            redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.providerCreated") + " : " + saved.getProviderCode());
        } catch (IllegalArgumentException ex) {
            redirectAttributes.addFlashAttribute("errorMessage", ex.getMessage());
        }
        return "redirect:/admin/login-risk/provider-configs";
    }

    @PostMapping("/provider-configs/{providerIdx}")
    public String updateProviderConfig(@PathVariable Long providerIdx,
                                       SecurityAssessmentProviderConfigVO config,
                                       @RequestParam(value = "enabled", required = false) String enabled,
                                       @RequestParam(value = "failOpen", required = false) Integer failOpen,
                                       HttpSession session,
                                       RedirectAttributes redirectAttributes,
                                      Locale locale) {
        config.setProviderIdx(providerIdx);
        config.setEnabled(enabled != null);
        config.setFailOpen(failOpen == null ? 1 : failOpen);
        loginRiskPolicyService.updateProviderConfig(config, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.providerSaved"));
        return "redirect:/admin/login-risk/provider-configs";
    }

    @PostMapping("/provider-configs/{providerIdx}/delete")
    public String softDeleteProviderConfig(@PathVariable Long providerIdx,
                                           HttpSession session,
                                           RedirectAttributes redirectAttributes,
                                           Locale locale) {
        loginRiskPolicyService.softDeleteProviderConfig(providerIdx, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.providerDeleted"));
        return "redirect:/admin/login-risk/provider-configs";
    }

    @PostMapping("/provider-configs/{providerIdx}/restore")
    public String restoreProviderConfig(@PathVariable Long providerIdx,
                                        HttpSession session,
                                        RedirectAttributes redirectAttributes,
                                        Locale locale) {
        loginRiskPolicyService.restoreProviderConfig(providerIdx, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.providerRestored"));
        return "redirect:/admin/login-risk/provider-configs";
    }

    @PostMapping("/provider-configs/{providerIdx}/check")
    public String checkProviderConfig(@PathVariable Long providerIdx,
                                      HttpSession session,
                                      RedirectAttributes redirectAttributes,
                                      Locale locale) {
        loginRiskPolicyService.checkProviderHealth(providerIdx, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.providerChecked"));
        return "redirect:/admin/login-risk/provider-configs";
    }

    @PostMapping("/provider-configs/bulk")
    @ResponseBody
    public Map<String, Object> bulkProviderConfigs(@RequestParam("action") String action,
                                                   @RequestParam(value = "ids", required = false) String idsCsv,
                                                   HttpSession session) {
        List<Long> ids = parseIds(idsCsv);
        Long actor = currentAdminIdx(session);
        int affected = 0;
        switch (action == null ? "" : action) {
            case "enable" -> affected = loginRiskPolicyService.bulkUpdateProviderEnabled(ids, true, actor);
            case "disable" -> affected = loginRiskPolicyService.bulkUpdateProviderEnabled(ids, false, actor);
            case "delete" -> affected = loginRiskPolicyService.bulkSoftDeleteProviderConfigs(ids, actor);
            case "restore" -> affected = loginRiskPolicyService.bulkRestoreProviderConfigs(ids, actor);
            case "check" -> affected = loginRiskPolicyService.bulkCheckProviderHealth(ids, actor);
            default -> { /* unknown action */ }
        }
        Map<String, Object> body = new HashMap<>();
        body.put("affected", affected);
        body.put("requested", ids.size());
        body.put("action", action);
        return body;
    }

    @GetMapping("/provider-configs/export")
    public ResponseEntity<byte[]> exportProviderConfigs(
            @RequestParam(value = "scope", required = false, defaultValue = "filtered") String scope,
            @RequestParam(value = "format", required = false, defaultValue = "csv") String format,
            @RequestParam(value = "selectedIds", required = false) String selectedIds,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "kind", required = false) String kind,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "enabled", required = false) String enabled,
            @RequestParam(value = "failOpen", required = false) String failOpen,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "triggerEvent", required = false) String triggerEvent,
            @RequestParam(value = "includeDeleted", required = false, defaultValue = "false") boolean includeDeleted,
            @RequestParam(value = "onlyDeleted", required = false, defaultValue = "false") boolean onlyDeleted,
            @RequestParam(value = "sort", required = false, defaultValue = "priority_desc") String sort) {
        try {
            LoginRiskPolicyService.ProviderConfigFilter filter = new LoginRiskPolicyService.ProviderConfigFilter();
            filter.sort = sort;
            filter.pageSize = 0;
            if ("all".equals(scope)) {
                filter.includeDeleted = true;
            } else if ("selected".equals(scope)) {
                filter.idxList = parseIds(selectedIds);
                filter.includeDeleted = true;
                if (filter.idxList.isEmpty()) {
                    return ResponseEntity.badRequest().build();
                }
            } else {
                filter.keyword = keyword;
                filter.kind = kind;
                filter.status = status;
                filter.enabled = enabled;
                filter.failOpen = failOpen;
                filter.category = category;
                filter.triggerEvent = triggerEvent;
                filter.includeDeleted = includeDeleted;
                filter.onlyDeleted = onlyDeleted;
            }
            List<SecurityAssessmentProviderConfigVO> data = loginRiskPolicyService.exportProviderConfigs(filter);
            if ("excel".equalsIgnoreCase(format)) {
                byte[] bytes = buildProviderConfigExcel(data);
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"provider-configs.xlsx\"")
                        .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                        .body(bytes);
            }
            byte[] bytes = buildProviderConfigCsv(data);
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"provider-configs.csv\"")
                    .contentType(MediaType.parseMediaType("text/csv; charset=UTF-8"))
                    .body(bytes);
        } catch (Exception e) {
            log.error("Provider 설정 내보내기 실패", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    private static final String[] PROVIDER_EXPORT_HEADERS = {
            "providerIdx","providerCode","providerKind","providerName","enabled","status","priority",
            "endpointUrl","apiKeyRef","modelName","timeoutMillis","failOpen","requestMethod",
            "usageCategories","triggerEvents","maxConcurrent","ratePerMinute","retryCount","retryBackoffMs",
            "healthCheckIntervalSec","nextHealthCheckAt","lastCheckedAt","tags","description",
            "currentVersionNo","createdAt","updatedAt","deletedAt"
    };

    private byte[] buildProviderConfigCsv(List<SecurityAssessmentProviderConfigVO> data) {
        StringBuilder sb = new StringBuilder("﻿");
        sb.append(String.join(",", PROVIDER_EXPORT_HEADERS)).append('\n');
        for (SecurityAssessmentProviderConfigVO p : data) {
            sb.append(csvRowOf(p)).append('\n');
        }
        return sb.toString().getBytes(StandardCharsets.UTF_8);
    }

    private String csvRowOf(SecurityAssessmentProviderConfigVO p) {
        Object[] cols = providerExportColumns(p);
        StringBuilder row = new StringBuilder();
        for (int i = 0; i < cols.length; i++) {
            if (i > 0) row.append(',');
            row.append(csvVal(cols[i]));
        }
        return row.toString();
    }

    private byte[] buildProviderConfigExcel(List<SecurityAssessmentProviderConfigVO> data) throws Exception {
        try (XSSFWorkbook wb = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            var sheet = wb.createSheet("providers");
            var hRow = sheet.createRow(0);
            for (int i = 0; i < PROVIDER_EXPORT_HEADERS.length; i++) {
                hRow.createCell(i).setCellValue(PROVIDER_EXPORT_HEADERS[i]);
            }
            int r = 1;
            for (SecurityAssessmentProviderConfigVO p : data) {
                Object[] cols = providerExportColumns(p);
                var row = sheet.createRow(r++);
                for (int i = 0; i < cols.length; i++) {
                    row.createCell(i).setCellValue(cols[i] == null ? "" : String.valueOf(cols[i]));
                }
            }
            wb.write(out);
            return out.toByteArray();
        }
    }

    private Object[] providerExportColumns(SecurityAssessmentProviderConfigVO p) {
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return new Object[]{
                p.getProviderIdx(),
                p.getProviderCode(),
                p.getProviderKind(),
                p.getProviderName(),
                p.isEnabled() ? "1" : "0",
                p.getStatus(),
                p.getPriority(),
                p.getEndpointUrl(),
                p.getApiKeyRef(),
                p.getModelName(),
                p.getTimeoutMillis(),
                p.getFailOpen(),
                p.getRequestMethod(),
                p.getUsageCategories(),
                p.getTriggerEvents(),
                p.getMaxConcurrent(),
                p.getRatePerMinute(),
                p.getRetryCount(),
                p.getRetryBackoffMs(),
                p.getHealthCheckIntervalSec(),
                p.getNextHealthCheckAt() == null ? "" : p.getNextHealthCheckAt().format(fmt),
                p.getLastCheckedAt() == null ? "" : p.getLastCheckedAt().format(fmt),
                p.getTags(),
                p.getDescription(),
                p.getCurrentVersionNo(),
                p.getCreatedAt() == null ? "" : p.getCreatedAt().format(fmt),
                p.getUpdatedAt() == null ? "" : p.getUpdatedAt().format(fmt),
                p.getDeletedAt() == null ? "" : p.getDeletedAt().format(fmt)
        };
    }

    private String csvVal(Object value) {
        if (value == null) return "";
        String s = String.valueOf(value);
        boolean needsQuote = s.contains(",") || s.contains("\"") || s.contains("\n") || s.contains("\r");
        if (needsQuote) {
            return "\"" + s.replace("\"", "\"\"") + "\"";
        }
        return s;
    }

    private List<Long> parseIds(String idsCsv) {
        if (idsCsv == null || idsCsv.isBlank()) return Collections.emptyList();
        return Arrays.stream(idsCsv.split(","))
                .map(String::trim)
                .filter(s -> !s.isEmpty() && s.matches("\\d+"))
                .map(Long::parseLong)
                .distinct()
                .toList();
    }


    @GetMapping("/provider-health-history")
    public String providerHealthHistory(@RequestParam(value = "providerCode", required = false) String providerCode,
                                        @RequestParam(value = "limit", required = false, defaultValue = "100") int limit,
                                        Model model) {
        int safeLimit = Math.max(1, Math.min(limit, 200));
        model.addAttribute("histories", loginRiskPolicyService.getProviderHealthCheckHistories(providerCode, safeLimit));
        model.addAttribute("providerCode", providerCode);
        model.addAttribute("limit", safeLimit);
        model.addAttribute("activeMenu", "providerHealthHistory");
        model.addAttribute("pageTitleCode", "security.admin.providerHealth.title");
        return "admin/login-risk/provider-health-history";
    }

    @GetMapping("/provider-health-history/export")
    public ResponseEntity<byte[]> exportProviderHealthHistory(
            @RequestParam(value = "scope", required = false, defaultValue = "filtered") String scope,
            @RequestParam(value = "providerCode", required = false) String providerCode,
            @RequestParam(value = "selectedIds", required = false) String selectedIds,
            @RequestParam(value = "limit", required = false, defaultValue = "200") int limit,
            @RequestParam(value = "format", required = false, defaultValue = "csv") String format) {
        try {
            boolean exportAll = "all".equalsIgnoreCase(scope);
            boolean exportSelected = "selected".equalsIgnoreCase(scope);
            int safeLimit = (exportAll || exportSelected) ? 1000 : Math.max(1, Math.min(limit, 1000));
            List<org.triptogether.auth.vo.ProviderHealthCheckHistoryVO> data =
                    loginRiskPolicyService.getProviderHealthCheckHistories((exportAll || exportSelected) ? null : providerCode, safeLimit);
            if (exportSelected) {
                List<Long> ids = parseIds(selectedIds);
                if (ids.isEmpty()) {
                    return ResponseEntity.badRequest().build();
                }
                data = data.stream()
                        .filter(h -> ids.contains(h.getHealthHistoryIdx()))
                        .toList();
            }
            if ("excel".equalsIgnoreCase(format)) {
                byte[] bytes = buildProviderHealthExcel(data);
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"provider-health-history.xlsx\"")
                        .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                        .body(bytes);
            }
            byte[] bytes = buildProviderHealthCsv(data);
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"provider-health-history.csv\"")
                    .contentType(MediaType.parseMediaType("text/csv; charset=UTF-8"))
                    .body(bytes);
        } catch (Exception e) {
            log.error("Provider 헬스체크 이력 내보내기 실패", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    private static final String[] PROVIDER_HEALTH_EXPORT_HEADERS = {
            "checkedAt", "providerKind", "providerCode", "checkSource",
            "statusBefore", "statusAfter", "actorUserIdx", "detailMessage"
    };

    private byte[] buildProviderHealthCsv(List<org.triptogether.auth.vo.ProviderHealthCheckHistoryVO> data) {
        StringBuilder sb = new StringBuilder("﻿");
        sb.append(String.join(",", PROVIDER_HEALTH_EXPORT_HEADERS)).append('\n');
        for (org.triptogether.auth.vo.ProviderHealthCheckHistoryVO h : data) {
            Object[] cols = providerHealthRow(h);
            for (int i = 0; i < cols.length; i++) {
                if (i > 0) sb.append(',');
                sb.append(csvVal(cols[i]));
            }
            sb.append('\n');
        }
        return sb.toString().getBytes(StandardCharsets.UTF_8);
    }

    private byte[] buildProviderHealthExcel(List<org.triptogether.auth.vo.ProviderHealthCheckHistoryVO> data) throws Exception {
        try (XSSFWorkbook wb = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            var sheet = wb.createSheet("provider-health");
            var hRow = sheet.createRow(0);
            for (int i = 0; i < PROVIDER_HEALTH_EXPORT_HEADERS.length; i++) {
                hRow.createCell(i).setCellValue(PROVIDER_HEALTH_EXPORT_HEADERS[i]);
            }
            int r = 1;
            for (org.triptogether.auth.vo.ProviderHealthCheckHistoryVO h : data) {
                Object[] cols = providerHealthRow(h);
                var row = sheet.createRow(r++);
                for (int i = 0; i < cols.length; i++) {
                    row.createCell(i).setCellValue(cols[i] == null ? "" : String.valueOf(cols[i]));
                }
            }
            wb.write(out);
            return out.toByteArray();
        }
    }

    private Object[] providerHealthRow(org.triptogether.auth.vo.ProviderHealthCheckHistoryVO h) {
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return new Object[] {
                h.getCheckedAt() == null ? "" : h.getCheckedAt().format(fmt),
                h.getProviderKind(),
                h.getProviderCode(),
                h.getCheckSource(),
                h.getStatusBefore(),
                h.getStatusAfter(),
                h.getActorUserIdx(),
                h.getDetailMessage()
        };
    }

    @GetMapping("/waf-sync")
    public String wafSyncQueue(@RequestParam(value = "status", required = false) String status,
                               @RequestParam(value = "targetType", required = false) String targetType,
                               @RequestParam(value = "keyword", required = false) String keyword,
                               Model model) {
        model.addAttribute("items", loginRiskPolicyService.getWafSyncQueue(status, targetType, keyword));
        model.addAttribute("status", status);
        model.addAttribute("targetType", targetType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "securityWafSync");
        model.addAttribute("pageTitleCode", "security.admin.wafSync.title");
        return "admin/login-risk/waf-sync";
    }

    @PostMapping("/waf-sync/{syncIdx}/retry")
    public String retryWafSync(@PathVariable Long syncIdx,
                               HttpSession session,
                               RedirectAttributes redirectAttributes,
                               Locale locale) {
        loginRiskPolicyService.retryWafSync(syncIdx, currentAdminIdx(session));
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.wafSyncRetryQueued"));
        return "redirect:/admin/login-risk/waf-sync";
    }

    @PostMapping("/waf-sync/bulk")
    public String bulkWafSync(@RequestParam("action") String action,
                              @RequestParam(value = "ids", required = false) String idsCsv,
                              HttpSession session,
                              RedirectAttributes redirectAttributes,
                              Locale locale) {
        List<Long> ids = parseIds(idsCsv);
        int affected = 0;
        if ("retry".equalsIgnoreCase(action)) {
            affected = loginRiskPolicyService.bulkRetryWafSync(ids, currentAdminIdx(session));
        }
        redirectAttributes.addFlashAttribute("message",
                msg(locale, "security.admin.flash.bulkWafSyncProcessed") + " (" + affected + "/" + ids.size() + ")");
        return "redirect:/admin/login-risk/waf-sync";
    }

    @GetMapping("/waf-sync/export")
    public ResponseEntity<byte[]> exportWafSync(
            @RequestParam(value = "scope", required = false, defaultValue = "filtered") String scope,
            @RequestParam(value = "format", required = false, defaultValue = "csv") String format,
            @RequestParam(value = "selectedIds", required = false) String selectedIds,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "targetType", required = false) String targetType,
            @RequestParam(value = "keyword", required = false) String keyword) {
        try {
            List<SecurityWafSyncQueueVO> data;
            if ("all".equalsIgnoreCase(scope)) {
                data = loginRiskPolicyService.getWafSyncQueue(null, null, null);
            } else if ("selected".equalsIgnoreCase(scope)) {
                List<Long> ids = parseIds(selectedIds);
                if (ids.isEmpty()) {
                    return ResponseEntity.badRequest().build();
                }
                data = loginRiskPolicyService.getWafSyncQueue(null, null, null).stream()
                        .filter(w -> w.getSyncIdx() != null && ids.contains(w.getSyncIdx()))
                        .toList();
            } else {
                data = loginRiskPolicyService.getWafSyncQueue(status, targetType, keyword);
            }
            if ("excel".equalsIgnoreCase(format)) {
                byte[] bytes = buildWafSyncExcel(data);
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"waf-sync.xlsx\"")
                        .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                        .body(bytes);
            }
            byte[] bytes = buildWafSyncCsv(data);
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"waf-sync.csv\"")
                    .contentType(MediaType.parseMediaType("text/csv; charset=UTF-8"))
                    .body(bytes);
        } catch (Exception e) {
            log.error("WAF 동기화 큐 내보내기 실패", e);
            return ResponseEntity.internalServerError().build();
        }
    }

    private static final String[] WAF_SYNC_EXPORT_HEADERS = {
            "syncIdx", "status", "sourceType", "sourceId", "syncAction",
            "targetType", "targetValue", "detailMessage",
            "syncedAt", "createdAt", "updatedAt"
    };

    private byte[] buildWafSyncCsv(List<SecurityWafSyncQueueVO> data) {
        StringBuilder sb = new StringBuilder("﻿");
        sb.append(String.join(",", WAF_SYNC_EXPORT_HEADERS)).append('\n');
        for (SecurityWafSyncQueueVO w : data) {
            Object[] cols = wafSyncRow(w);
            for (int i = 0; i < cols.length; i++) {
                if (i > 0) sb.append(',');
                sb.append(csvVal(cols[i]));
            }
            sb.append('\n');
        }
        return sb.toString().getBytes(StandardCharsets.UTF_8);
    }

    private byte[] buildWafSyncExcel(List<SecurityWafSyncQueueVO> data) throws Exception {
        try (XSSFWorkbook wb = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            var sheet = wb.createSheet("waf-sync");
            var hRow = sheet.createRow(0);
            for (int i = 0; i < WAF_SYNC_EXPORT_HEADERS.length; i++) {
                hRow.createCell(i).setCellValue(WAF_SYNC_EXPORT_HEADERS[i]);
            }
            int r = 1;
            for (SecurityWafSyncQueueVO w : data) {
                Object[] cols = wafSyncRow(w);
                var row = sheet.createRow(r++);
                for (int i = 0; i < cols.length; i++) {
                    row.createCell(i).setCellValue(cols[i] == null ? "" : String.valueOf(cols[i]));
                }
            }
            wb.write(out);
            return out.toByteArray();
        }
    }

    private Object[] wafSyncRow(SecurityWafSyncQueueVO w) {
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return new Object[]{
                w.getSyncIdx(),
                w.getStatus(),
                w.getSourceType(),
                w.getSourceId(),
                w.getSyncAction(),
                w.getTargetType(),
                w.getTargetValue(),
                w.getDetailMessage(),
                w.getSyncedAt() == null ? "" : w.getSyncedAt().format(fmt),
                w.getCreatedAt() == null ? "" : w.getCreatedAt().format(fmt),
                w.getUpdatedAt() == null ? "" : w.getUpdatedAt().format(fmt)
        };
    }

    @GetMapping("/notification-preferences")
    public String notificationPreferences(HttpSession session, Model model) {
        Long adminIdx = currentAdminIdx(session);
        List<AdminNotificationPreferenceVO> preferences = loginRiskPolicyService.getNotificationPreferences(adminIdx);
        long enabledPreferenceCount = preferences.stream()
                .filter(AdminNotificationPreferenceVO::isEnabled)
                .count();
        model.addAttribute("preferences", preferences);
        model.addAttribute("enabledPreferenceCount", enabledPreferenceCount);
        model.addAttribute("activeMenu", "adminNotificationPreferences");
        model.addAttribute("pageTitleCode", "security.admin.notifications.title");
        return "admin/login-risk/notification-preferences";
    }

    @PostMapping("/notification-preferences")
    public String updateNotificationPreferences(@RequestParam(value = "enabledCategories", required = false) List<String> enabledCategories,
                                                HttpSession session,
                                                RedirectAttributes redirectAttributes,
                                                Locale locale) {
        loginRiskPolicyService.updateNotificationPreferences(currentAdminIdx(session),
                enabledCategories == null ? Collections.emptyList() : enabledCategories);
        redirectAttributes.addFlashAttribute("message", msg(locale, "security.admin.flash.notificationSaved"));
        return "redirect:/admin/login-risk/notification-preferences";
    }

    private String msg(Locale locale, String code) {
        return messageSource.getMessage(code, null, locale == null ? Locale.KOREAN : locale);
    }

    private Long currentAdminIdx(HttpSession session) {
        Object loginUser = session == null ? null : session.getAttribute("loginUser");
        if (loginUser instanceof UsersVO user) {
            return user.getUserIdx();
        }
        return null;
    }
}
