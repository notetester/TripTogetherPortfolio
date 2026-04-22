package org.triptogether.admin.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.admin.service.AdminAssistantService;
import org.triptogether.admin.vo.AdminAssistantMessageVO;
import org.triptogether.admin.vo.AdminAssistantSessionVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 관리자 AI 도우미(assistant) 관리 컨트롤러.
 * URL: /admin/ai-helper (sub-tab: dashboard / sessions / messages)
 * SJ가 구현한 assistant 모듈(CHAT_POST/CHAT_COMMENT)의 관리 페이지.
 * AI 챗봇(common 모듈, Gemini) 관리는 AdminChatbotController가 담당.
 * 권한: AI_HELPER_ADMIN (AdminInterceptor가 체크)
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/ai-helper")
public class AdminAssistantController {

    private static final int PAGE_SIZE = 20;

    private final AdminAssistantService assistantService;

    /**
     * GET /admin/ai-helper
     * AI 도우미(assistant) 섹션 - sub-tab 렌더링.
     */
    @GetMapping
    public String assistantSection(@RequestParam(defaultValue = "dashboard") String tab,
                                   @RequestParam(defaultValue = "1") int page,
                                   @RequestParam(defaultValue = "") String keyword,
                                   Model model) {

        switch (tab) {
            case "messages" -> {
                List<AdminAssistantMessageVO> msgs = assistantService.getRecentMessages(page, PAGE_SIZE);
                int total = assistantService.countMessages();
                model.addAttribute("messages", msgs);
                model.addAttribute("total", total);
                model.addAttribute("totalPages", (int) Math.ceil((double) total / PAGE_SIZE));
            }
            default -> {
                model.addAttribute("stats", assistantService.getStats());
                List<AdminAssistantSessionVO> list = assistantService.getSessions(keyword, page, PAGE_SIZE);
                int total = assistantService.countSessions(keyword);
                model.addAttribute("sessions", list);
                model.addAttribute("total", total);
                model.addAttribute("totalPages", (int) Math.ceil((double) total / PAGE_SIZE));
                tab = "dashboard";
            }
        }

        model.addAttribute("section", "assistant");
        model.addAttribute("tab", tab);
        model.addAttribute("page", page);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "aiHelper");
        model.addAttribute("pageTitle", "AI 도우미 관리");
        return "admin/ai-helper/assistant";
    }

    /**
     * GET /admin/ai-helper/assistant/sessions/{id}/messages
     * 특정 세션의 메시지 전체 조회 (Ajax 모달용).
     */
    @GetMapping("/assistant/sessions/{id}/messages")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> viewMessages(@PathVariable("id") Long chatPostIdx) {
        Map<String, Object> result = new HashMap<>();
        AdminAssistantSessionVO session = assistantService.getSession(chatPostIdx);
        if (session == null) {
            result.put("success", false);
            return ResponseEntity.status(404).body(result);
        }
        result.put("success", true);
        result.put("session", session);
        result.put("messages", assistantService.getMessagesByPost(chatPostIdx));
        return ResponseEntity.ok(result);
    }

    /**
     * POST /admin/ai-helper/assistant/sessions/{id}/delete
     * 세션 삭제 (FK CASCADE로 CHAT_COMMENT도 함께 삭제됨).
     */
    @PostMapping("/assistant/sessions/{id}/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteSession(@PathVariable("id") Long chatPostIdx) {
        Map<String, Object> result = new HashMap<>();
        try {
            assistantService.deleteSession(chatPostIdx);
            result.put("success", true);
        } catch (Exception e) {
            log.error("AI 도우미 세션 삭제 실패: chatPostIdx={}", chatPostIdx, e);
            result.put("success", false);
            result.put("message", "삭제 중 오류 발생");
        }
        return ResponseEntity.ok(result);
    }
}
