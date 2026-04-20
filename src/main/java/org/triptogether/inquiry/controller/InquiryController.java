package org.triptogether.inquiry.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.triptogether.inquiry.service.InquiryAiService;
import org.triptogether.inquiry.service.InquiryService;
import org.triptogether.inquiry.vo.InquiryPostDto;
import org.triptogether.inquiry.vo.InquirySearchDto;
import org.triptogether.inquiry.vo.InquiryAttachmentDto;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.perspective.PerspectiveService;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * =============================================
 * InquiryController - 고객 문의 게시판 컨트롤러
 * =============================================
 * 담당 URL: /inquiry/**
 *
 * [기능 목록]
 * - 문의 목록 조회
 * - 문의 작성
 * - 문의 상세 조회
 * - 운영진 답변 등록
 * - 문의 수정 (PENDING 상태일 때만 가능)
 * - 문의 삭제 (PENDING 상태일 때만 가능)
 *
 * [권한 구조]
 * - 일반 유저 : 본인 문의만 수정/삭제 가능, 비공개 글은 본인만 열람
 * - 운영진(ADMIN) : 모든 문의 열람/답변/수정/삭제 가능
 * =============================================
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/inquiry")
public class InquiryController {

    private final InquiryService inquiryService;
    private final MyPageService myPageService;
    private final PerspectiveService perspectiveService;
    private final InquiryAiService inquiryAiService;

    /* =============================================
       유틸 메서드
       - 세션에서 로그인 유저 정보를 꺼낼 때 사용
       - auth 담당자의 VO를 직접 import 하지 않고
         리플렉션으로 접근 (담당자간 의존성 최소화)
       ============================================= */

    /**
     * 세션에서 로그인한 유저의 idx(고유번호)를 꺼낸다.
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
     * 세션에서 로그인한 유저가 운영진(ADMIN)인지 확인한다.
     * 운영진이면 true, 아니면 false 반환.
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
       GET /inquiry/list - 문의 목록
       ============================================= */

    /**
     * 문의 목록 페이지를 보여준다.
     * - 검색/페이지네이션 지원
     * - 운영진은 모든 문의, 일반 유저도 전체 목록 열람 가능
     *   (단 비공개 글 내용은 상세에서 제한)
     */
    @GetMapping("/list")
    public String list(@ModelAttribute InquirySearchDto search,
                       HttpSession session, Model model) {

        Long loginUserIdx = getLoginUserIdx(session);
        boolean admin     = isAdmin(session);

        model.addAttribute("inquiryList",  inquiryService.getInquiryList(search));
        model.addAttribute("totalCount",   inquiryService.getTotalCount(search));
        model.addAttribute("totalPage",    inquiryService.getTotalPage(search));
        model.addAttribute("search",       search);
        model.addAttribute("isAdmin",      admin);
        model.addAttribute("loginUserIdx", loginUserIdx);

        return "inquiry/list";
    }

    /* =============================================
       GET /inquiry/write - 문의 작성 폼
       ============================================= */

    /**
     * 문의 작성 페이지를 보여준다.
     * (로그인 체크는 WebConfig 인터셉터에서 처리)
     */
    @GetMapping("/write")
    public String writeForm(HttpSession session) {
        return "inquiry/write";
    }

    /* =============================================
       POST /inquiry/write - 문의 등록
       ============================================= */

    /**
     * 작성한 문의를 DB에 저장한다.
     * - 로그인하지 않으면 401 반환
     * - 성공 시 생성된 inquiryId 반환
     */
    @PostMapping("/write")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> write(
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam String category,
            @RequestParam(defaultValue = "0") int isPrivate,
            @RequestParam(value = "images", required = false) List<MultipartFile> images,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        // 로그인 체크
        if (session.getAttribute("loginUser") == null) {
            result.put("success", false);
            return ResponseEntity.status(401).body(result);
        }

        try {
            Long loginUserIdx = getLoginUserIdx(session);

            InquiryPostDto inquiry = new InquiryPostDto();
            inquiry.setUserIdx(loginUserIdx);
            inquiry.setTitle(title);
            inquiry.setContent(content);
            inquiry.setCategory(category);
            inquiry.setIsPrivate(isPrivate);

            Long inquiryId = inquiryService.writeInquiry(inquiry, images);

            perspectiveService.checkAndFlagInquiryAsync(inquiryId, title + " " + content);

            result.put("success",   true);
            result.put("inquiryId", inquiryId);

        } catch (IllegalStateException e) {
            result.put("success", false);
            result.put("message", e.getMessage());
            return ResponseEntity.status(429).body(result);
        } catch (Exception e) {
            log.error("문의 등록 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }

    /* =============================================
       GET /inquiry/{inquiryId} - 문의 상세
       ============================================= */

    /**
     * 문의 상세 페이지를 보여준다.
     * - 비공개 글: 본인 또는 운영진만 열람 가능
     * - 조회수 증가 처리
     */
    @GetMapping("/{inquiryId}")
    public String detail(@PathVariable Long inquiryId,
                         HttpSession session, Model model) {

        Long loginUserIdx = getLoginUserIdx(session);
        boolean admin     = isAdmin(session);

        InquiryPostDto inquiry = inquiryService.getInquiry(inquiryId);
        if (inquiry == null) return "redirect:/inquiry/list";

        // 비공개 글 접근 제한 (운영진 또는 작성자만 열람 가능)
        if (inquiry.getIsPrivate() == 1 && !admin
                && !loginUserIdx.equals(inquiry.getUserIdx())) {
            return "redirect:/inquiry/list";
        }

        inquiryService.increaseViewCount(inquiryId);

        model.addAttribute("inquiry",        inquiry);
        model.addAttribute("answer",         inquiryService.getAnswer(inquiryId));
        model.addAttribute("attachmentList", inquiryService.getAttachmentList(inquiryId));
        model.addAttribute("isAdmin",        admin);
        model.addAttribute("isOwner",        loginUserIdx.equals(inquiry.getUserIdx()));

        return "inquiry/detail";
    }

    /* =============================================
       POST /inquiry/{inquiryId}/answer - 답변 등록
       ============================================= */

    /**
     * 운영진이 문의에 답변을 등록한다.
     * - 운영진이 아니면 403 반환
     */
    @PostMapping("/{inquiryId}/answer")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> answer(
            @PathVariable Long inquiryId,
            @RequestParam String content,
            @RequestParam(defaultValue = "false") boolean complete,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        // 운영진 권한 체크
        if (!isAdmin(session)) {
            result.put("success", false);
            result.put("message", "운영진만 답변할 수 있어요.");
            return ResponseEntity.status(403).body(result);
        }

        try {
            Long adminUserIdx = getLoginUserIdx(session);
            InquiryPostDto inquiry = inquiryService.getInquiry(inquiryId);
            inquiryService.writeAnswer(inquiryId, adminUserIdx, content, complete);

            // 유저에게 알림 전송
            FeedNotificationDto notification = new FeedNotificationDto();
            notification.setUserIdx(inquiry.getUserIdx());
            notification.setSourceType("inquiry");
            notification.setSourceId(inquiryId);
            notification.setMessage("문의에 답변이 등록되었습니다.");
            myPageService.addNotification(notification);

            result.put("success", true);

        } catch (Exception e) {
            log.error("답변 등록 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /inquiry/{inquiryId}/edit - 문의 수정
       ============================================= */

    /**
     * 문의 내용을 수정한다.
     * - 본인 또는 운영진만 수정 가능
     * - PENDING(대기중) 상태일 때만 수정 가능
     *   (답변 완료된 글은 수정 불가)
     */
    @PostMapping("/{inquiryId}/edit")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> edit(
            @PathVariable Long inquiryId,
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam String category,
            @RequestParam(defaultValue = "0") int isPrivate,
            @RequestParam(value = "images", required = false) List<MultipartFile> images,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        Long loginUserIdx = getLoginUserIdx(session);

        InquiryPostDto inquiry = inquiryService.getInquiry(inquiryId);
        if (inquiry == null) {
            result.put("success", false);
            return ResponseEntity.status(404).body(result);
        }

        // 본인 또는 운영진만 수정 가능
        if (!loginUserIdx.equals(inquiry.getUserIdx()) && !isAdmin(session)) {
            result.put("success", false);
            return ResponseEntity.status(403).body(result);
        }

        // PENDING 상태일 때만 수정 가능
        if (!"PENDING".equals(inquiry.getStatus())) {
            result.put("success", false);
            result.put("message", "답변이 완료된 글은 수정할 수 없습니다.");
            return ResponseEntity.status(400).body(result);
        }

        inquiry.setTitle(title);
        inquiry.setContent(content);
        inquiry.setCategory(category);
        inquiry.setIsPrivate(isPrivate);
        inquiryService.updateInquiry(inquiry);

        perspectiveService.checkAndFlagInquiryAsync(inquiryId, title + " " + content);

        // 새로 추가된 파일 저장
        if (images != null) {
            for (MultipartFile file : images) {
                if (file == null || file.isEmpty()) continue;
                inquiryService.addAttachment(inquiryId, file);
            }
        }
        result.put("success", true);

        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /inquiry/{inquiryId}/delete - 문의 삭제
       ============================================= */

    /**
     * 문의를 삭제한다.
     * - 본인 또는 운영진만 삭제 가능
     * - PENDING(대기중) 상태일 때만 삭제 가능
     *   (답변 완료된 글은 삭제 불가)
     */
    @PostMapping("/{inquiryId}/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> delete(
            @PathVariable Long inquiryId,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        Long loginUserIdx = getLoginUserIdx(session);

        InquiryPostDto inquiry = inquiryService.getInquiry(inquiryId);
        if (inquiry == null) {
            result.put("success", false);
            return ResponseEntity.status(404).body(result);
        }

        // 본인 또는 운영진만 삭제 가능
        if (!loginUserIdx.equals(inquiry.getUserIdx()) && !isAdmin(session)) {
            result.put("success", false);
            return ResponseEntity.status(403).body(result);
        }

        // PENDING 또는 CANCELLED 상태일 때만 삭제 가능
        String st = inquiry.getStatus();
        if (!"PENDING".equals(st) && !"CANCELLED".equals(st)) {
            result.put("success", false);
            result.put("message", "삭제할 수 없는 상태입니다.");
            return ResponseEntity.status(400).body(result);
        }

        inquiryService.deleteInquiry(inquiryId);
        result.put("success", true);

        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /inquiry/{inquiryId}/status - 관리자 상태 변경
       ============================================= */
    /**
     * 관리자가 문의 처리 상태를 변경한다.
     * - 운영진이 아니면 403 반환
     */
    @PostMapping("/{inquiryId}/status")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> changeStatus(
            @PathVariable Long inquiryId,
            @RequestParam String status,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdmin(session)) {
            result.put("success", false);
            result.put("message", "운영진만 상태를 변경할 수 있어요.");
            return ResponseEntity.status(403).body(result);
        }
        try {
            inquiryService.updateStatusWithTime(inquiryId, status);
            result.put("success", true);
        } catch (Exception e) {
            log.error("상태 변경 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /inquiry/{inquiryId}/answer/edit - 관리자 답변 수정
       ============================================= */
    /**
     * 관리자가 기존 답변 내용을 수정한다.
     * - 운영진이 아니면 403 반환
     */
    @PostMapping("/{inquiryId}/answer/edit")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> editAnswer(
            @PathVariable Long inquiryId,
            @RequestParam String content,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdmin(session)) {
            result.put("success", false);
            result.put("message", "운영진만 답변을 수정할 수 있어요.");
            return ResponseEntity.status(403).body(result);
        }
        try {
            inquiryService.updateAnswer(inquiryId, content);
            result.put("success", true);
        } catch (Exception e) {
            log.error("답변 수정 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /inquiry/{inquiryId}/user-complete - 유저 직접 완료 처리
       ============================================= */
    /**
     * 유저가 직접 문의를 완료 처리한다.
     * - 본인만 가능 (403), IN_PROGRESS 또는 COMPLETED 상태일 때만 가능
     */
    @PostMapping("/{inquiryId}/user-complete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> userComplete(
            @PathVariable Long inquiryId,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        Long loginUserIdx = getLoginUserIdx(session);
        InquiryPostDto inquiry = inquiryService.getInquiry(inquiryId);
        if (inquiry == null) {
            result.put("success", false);
            return ResponseEntity.status(404).body(result);
        }
        if (!loginUserIdx.equals(inquiry.getUserIdx())) {
            result.put("success", false);
            return ResponseEntity.status(403).body(result);
        }
        String st = inquiry.getStatus();
        if (!"IN_PROGRESS".equals(st) && !"COMPLETED".equals(st)) {
            result.put("success", false);
            result.put("message", "처리중 또는 답변완료 상태에서만 완료 처리할 수 있습니다.");
            return ResponseEntity.status(400).body(result);
        }
        inquiryService.updateStatusWithTime(inquiryId, "USER_COMPLETED");
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /inquiry/{inquiryId}/cancel - 유저 문의 취소
       ============================================= */
    /**
     * 유저가 문의를 취소한다.
     * - 본인만 가능 (403), PENDING 또는 IN_PROGRESS 상태일 때만 가능
     */
    @PostMapping("/{inquiryId}/cancel")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> cancelInquiry(
            @PathVariable Long inquiryId,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        Long loginUserIdx = getLoginUserIdx(session);
        InquiryPostDto inquiry = inquiryService.getInquiry(inquiryId);
        if (inquiry == null) {
            result.put("success", false);
            return ResponseEntity.status(404).body(result);
        }
        if (!loginUserIdx.equals(inquiry.getUserIdx())) {
            result.put("success", false);
            return ResponseEntity.status(403).body(result);
        }
        if (!"PENDING".equals(inquiry.getStatus()) && !"IN_PROGRESS".equals(inquiry.getStatus())) {
            result.put("success", false);
            result.put("message", "취소할 수 없는 상태입니다.");
            return ResponseEntity.status(400).body(result);
        }
        inquiryService.updateStatusWithTime(inquiryId, "CANCELLED");
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /inquiry/{inquiryId}/delete-request - 유저 삭제 요청
       ============================================= */
    /**
     * 유저가 문의 삭제를 요청한다.
     * - 본인만 가능 (403), COMPLETED 상태일 때만 가능
     */
    @PostMapping("/{inquiryId}/delete-request")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteRequest(
            @PathVariable Long inquiryId,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        Long loginUserIdx = getLoginUserIdx(session);
        InquiryPostDto inquiry = inquiryService.getInquiry(inquiryId);
        if (inquiry == null) {
            result.put("success", false);
            return ResponseEntity.status(404).body(result);
        }
        if (!loginUserIdx.equals(inquiry.getUserIdx())) {
            result.put("success", false);
            return ResponseEntity.status(403).body(result);
        }
        if (!"COMPLETED".equals(inquiry.getStatus())) {
            result.put("success", false);
            result.put("message", "답변완료 상태에서만 삭제 요청이 가능합니다.");
            return ResponseEntity.status(400).body(result);
        }
        inquiryService.updateStatusWithTime(inquiryId, "DELETE_REQUESTED");
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /inquiry/{inquiryId}/visibility-request - 유저 비공개/공개 요청
       ============================================= */
    /**
     * 유저가 문의 공개·비공개 전환을 요청한다.
     * - 본인만 가능 (403), type: "public" / "private"
     */
    @PostMapping("/{inquiryId}/visibility-request")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> visibilityRequest(
            @PathVariable Long inquiryId,
            @RequestParam String type,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        Long loginUserIdx = getLoginUserIdx(session);
        InquiryPostDto inquiry = inquiryService.getInquiry(inquiryId);
        if (inquiry == null) {
            result.put("success", false);
            return ResponseEntity.status(404).body(result);
        }
        if (!loginUserIdx.equals(inquiry.getUserIdx())) {
            result.put("success", false);
            return ResponseEntity.status(403).body(result);
        }
        String status = "private".equals(type) ? "PRIVATE_REQUESTED" : "PUBLIC_REQUESTED";
        inquiryService.updateStatusWithTime(inquiryId, status);
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /inquiry/{inquiryId}/delete-approve - 관리자 삭제 요청 수락
       ============================================= */
    /**
     * 관리자가 유저의 삭제 요청을 수락하여 문의를 삭제한다.
     * - 운영진이 아니면 403 반환, DELETE_REQUESTED 상태일 때만 가능
     */
    @PostMapping("/{inquiryId}/delete-approve")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteApprove(
            @PathVariable Long inquiryId,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdmin(session)) {
            result.put("success", false);
            result.put("message", "운영진만 수락할 수 있어요.");
            return ResponseEntity.status(403).body(result);
        }
        InquiryPostDto inquiry = inquiryService.getInquiry(inquiryId);
        if (inquiry == null) {
            result.put("success", false);
            return ResponseEntity.status(404).body(result);
        }
        if (!"DELETE_REQUESTED".equals(inquiry.getStatus())) {
            result.put("success", false);
            result.put("message", "삭제 요청 상태가 아닙니다.");
            return ResponseEntity.status(400).body(result);
        }
        try {
            inquiryService.deleteInquiry(inquiryId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("삭제 요청 수락 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /inquiry/{inquiryId}/ai-draft - 관리자 AI 답변 초안 생성
       ============================================= */

    /**
     * Claude Haiku(Victor 개인 계정)로 답변 초안을 생성한다.
     * 관리자만 호출 가능.
     */
    @PostMapping("/{inquiryId}/ai-draft")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> aiDraft(
            @PathVariable Long inquiryId,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (!isAdmin(session)) {
            result.put("success", false);
            result.put("message", "관리자만 사용할 수 있습니다.");
            return ResponseEntity.status(403).body(result);
        }

        InquiryPostDto inquiry = inquiryService.getInquiry(inquiryId);
        if (inquiry == null) {
            result.put("success", false);
            return ResponseEntity.status(404).body(result);
        }

        String draft = inquiryAiService.generateDraft(
                inquiry.getCategory(),
                inquiry.getTitle(),
                inquiry.getContent()
        );

        if (draft == null || draft.isBlank()) {
            result.put("success", false);
            result.put("message", "AI 초안 생성에 실패했습니다. 잠시 후 다시 시도해주세요.");
            return ResponseEntity.status(500).body(result);
        }

        result.put("success", true);
        result.put("draft", draft);
        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /inquiry/{inquiryId}/visibility-approve - 관리자 공개/비공개 수락
       ============================================= */
    /**
     * 관리자가 유저의 공개·비공개 전환 요청을 수락한다.
     * - 운영진이 아니면 403 반환, type: "public" / "private"
     */
    @PostMapping("/{inquiryId}/visibility-approve")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> visibilityApprove(
            @PathVariable Long inquiryId,
            @RequestParam String type,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdmin(session)) {
            result.put("success", false);
            result.put("message", "운영진만 수락할 수 있어요.");
            return ResponseEntity.status(403).body(result);
        }
        try {
            inquiryService.approveVisibility(inquiryId, type);
            result.put("success", true);
        } catch (Exception e) {
            log.error("공개여부 수락 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    /* =============================================
       POST /inquiry/{inquiryId}/clear-blur - 관리자 BLUR 해제
       ai_flagged=0 처리 (신고 3회 누적이 아니므로 report_count는 없음)
       ============================================= */
    @PostMapping("/{inquiryId}/clear-blur")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> clearBlur(
            @PathVariable Long inquiryId,
            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        if (!isAdmin(session)) {
            result.put("success", false);
            result.put("message", "운영진만 해제할 수 있어요.");
            return ResponseEntity.status(403).body(result);
        }
        try {
            inquiryService.clearInquiryBlur(inquiryId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("BLUR 해제 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }
}
