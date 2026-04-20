package org.triptogether.assistant.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.triptogether.assistant.service.AssistantService;
import org.triptogether.auth.vo.UsersVO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/assistant")
public class AssistantController {

    private final AssistantService assistantService;

    @GetMapping("")
    public String assistantPage() {
        return "assistant/assistant";
    }

    @PostMapping("/chat")
    @ResponseBody
    public Map<String, Object> chat(
            @RequestBody Map<String, Object> payload,
            HttpSession session) {

        String userMessage = Objects.toString(payload.get("message"), "").trim();

        if (userMessage.isEmpty()) {
            return Map.of(
                    "success", false,
                    "answer", "메시지를 입력해주세요.",
                    "history", new ArrayList<>()
            );
        }

        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return Map.of(
                    "success", false,
                    "answer", "로그인 후 이용해주세요.",
                    "history", new ArrayList<>()
            );
        }

        // 네 UsersVO getter명에 맞게 수정
        Long userIdx = loginUser.getUserIdx();

        @SuppressWarnings("unchecked")
        List<Map<String, String>> history =
                (List<Map<String, String>>) session.getAttribute("chatHistory");

        Long chatPostIdx = (Long) session.getAttribute("currentChatPostIdx");

        Map<String, Object> result =
                assistantService.chat(userMessage, history, userIdx, chatPostIdx);

        session.setAttribute("chatHistory", result.get("history"));

        if (result.get("chatPostIdx") != null) {
            session.setAttribute("currentChatPostIdx", result.get("chatPostIdx"));
        }

        return result;
    }

    @PostMapping("/reset")
    @ResponseBody
    public Map<String, Object> resetChat(HttpSession session) {
        session.removeAttribute("chatHistory");
        session.removeAttribute("currentChatPostIdx");
        return Map.of("success", true);
    }
}