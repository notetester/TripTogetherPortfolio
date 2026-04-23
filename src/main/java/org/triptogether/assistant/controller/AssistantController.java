package org.triptogether.assistant.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.i18n.LocaleContextHolder;
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

        Long userIdx = loginUser.getUserIdx();

        @SuppressWarnings("unchecked")
        List<Map<String, String>> history =
                (List<Map<String, String>>) session.getAttribute("chatHistory");

        Long chatPostIdx = (Long) session.getAttribute("currentChatPostIdx");

        /* ──────────────────────────────────────────────────────────────
         * [다국어] 현재 사용자의 세션 locale에서 언어 코드를 꺼낸다.
         *
         * LocaleContextHolder는 WebConfig에서 설정한 SessionLocaleResolver와
         * LocaleChangeInterceptor가 관리하는 값을 읽어온다.
         * 사용자가 헤더에서 ?lang=en 으로 언어를 바꾸면
         * 이 값도 자동으로 "en"으로 변경된다.
         *
         * 이 lang 값을 Service에 넘기면, GPT 시스템 프롬프트에서
         * "항상 English로 답변하세요" 같은 지시로 변환된다.
         * ────────────────────────────────────────────────────────────── */
        String lang = LocaleContextHolder.getLocale().getLanguage();

        Map<String, Object> result =
                assistantService.chat(userMessage, history, userIdx, chatPostIdx, lang);

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
