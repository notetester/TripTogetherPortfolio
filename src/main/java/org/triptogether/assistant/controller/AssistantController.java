package org.triptogether.assistant.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.triptogether.assistant.service.AssistantService;
import org.triptogether.assistant.vo.ChatMessageVO;

import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/assistant")
public class AssistantController {

    private final AssistantService assistantService;

    // ─────────────────────────────────────────
    // AI 어시스턴트 페이지
    // ─────────────────────────────────────────
    @GetMapping("")
    public String assistantPage() {
        return "assistant/assistant";
    }

    // ─────────────────────────────────────────
    // 채팅 메시지 전송 (Ajax)
    // ─────────────────────────────────────────
    @PostMapping("/chat")
    @ResponseBody
    public Map<String, Object> chat(
            @RequestBody Map<String, Object> payload,
            HttpSession session) {

        String userMessage = (String) payload.get("message");

        // 세션에서 대화 기록 가져오기 (다중턴 지원)
        @SuppressWarnings("unchecked")
        List<Map<String, String>> history = (List<Map<String, String>>) session.getAttribute("chatHistory");

        Map<String, Object> result = assistantService.chat(userMessage, history);

        // 업데이트된 대화 기록 세션에 저장
        session.setAttribute("chatHistory", result.get("history"));

        return result;
    }

    // ─────────────────────────────────────────
    // 대화 기록 초기화 (Ajax)
    // ─────────────────────────────────────────
    @PostMapping("/reset")
    @ResponseBody
    public Map<String, Object> resetChat(HttpSession session) {
        session.removeAttribute("chatHistory");
        return Map.of("success", true);
    }
}
