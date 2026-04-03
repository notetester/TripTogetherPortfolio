package org.triptogether.inquiry.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.inquiry.service.InquiryService;
import org.triptogether.inquiry.vo.InquiryPostDto;
import org.triptogether.inquiry.vo.InquirySearchDto;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/inquiry")
public class InquiryController {

    private final InquiryService inquiryService;

    // ===== 로그인 유저 idx 추출 =====
    private Long getLoginUserIdx(HttpSession session) {
        try {
            Object loginUser = session.getAttribute("loginUser");
            Method method = loginUser.getClass().getMethod("getUserIdx");
            return (Long) method.invoke(loginUser);
        } catch (Exception e) {
            return null;
        }
    }

    // ===== 운영진 여부 확인 =====
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
       GET /inquiry/list - 목록
       ============================================= */
    @GetMapping("/list")
    public String list(@ModelAttribute InquirySearchDto search,
                       HttpSession session, Model model) {


        Long loginUserIdx = getLoginUserIdx(session);
        boolean admin     = isAdmin(session);


        model.addAttribute("inquiryList", inquiryService.getInquiryList(search));
        model.addAttribute("totalCount",  inquiryService.getTotalCount(search));
        model.addAttribute("totalPage",   inquiryService.getTotalPage(search));
        model.addAttribute("search",      search);
        model.addAttribute("isAdmin",     admin);
        model.addAttribute("loginUserIdx", loginUserIdx);
        return "inquiry/list";
    }

    /* =============================================
       GET /inquiry/write - 글쓰기 폼
       ============================================= */
    @GetMapping("/write")
    public String writeForm(HttpSession session) {

        return "inquiry/write";
    }

    /* =============================================
       POST /inquiry/write - 글쓰기 등록
       ============================================= */
    @PostMapping("/write")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> write(
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam String category,
            @RequestParam(defaultValue = "0") int isPrivate,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

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

            Long inquiryId = inquiryService.writeInquiry(inquiry);
            result.put("success",   true);
            result.put("inquiryId", inquiryId);
        } catch (Exception e) {
            log.error("문의 등록 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }

    /* =============================================
       GET /inquiry/{inquiryId} - 상세
       ============================================= */
    @GetMapping("/{inquiryId}")
    public String detail(@PathVariable Long inquiryId,
                         HttpSession session, Model model) {



        Long loginUserIdx = getLoginUserIdx(session);
        boolean admin     = isAdmin(session);

        InquiryPostDto inquiry = inquiryService.getInquiry(inquiryId);
        if (inquiry == null) return "redirect:/inquiry/list";

        // 비공개 접근 제한
        if (inquiry.getIsPrivate() == 1 && !admin
                && !loginUserIdx.equals(inquiry.getUserIdx())) {
            return "redirect:/inquiry/list";
        }

        inquiryService.increaseViewCount(inquiryId);

        model.addAttribute("inquiry",  inquiry);
        model.addAttribute("answer",   inquiryService.getAnswer(inquiryId));
        model.addAttribute("isAdmin",  admin);
        model.addAttribute("isOwner",  loginUserIdx.equals(inquiry.getUserIdx()));
        return "inquiry/detail";
    }

    /* =============================================
       POST /inquiry/{inquiryId}/answer - 답변 등록
       ============================================= */
    @PostMapping("/{inquiryId}/answer")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> answer(
            @PathVariable Long inquiryId,
            @RequestParam String content,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (!isAdmin(session)) {
            result.put("success", false);
            result.put("message", "운영진만 답변할 수 있어요.");
            return ResponseEntity.status(403).body(result);
        }

        try {
            Long adminUserIdx = getLoginUserIdx(session);
            inquiryService.writeAnswer(inquiryId, adminUserIdx, content);
            result.put("success", true);
        } catch (Exception e) {
            log.error("답변 등록 오류", e);
            result.put("success", false);
            return ResponseEntity.status(500).body(result);
        }

        return ResponseEntity.ok(result);
    }
}
