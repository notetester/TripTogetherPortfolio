package org.triptogether.assistant.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.assistant.service.AssistantService;
import org.triptogether.assistant.vo.ChatCommentVO;
import org.triptogether.assistant.vo.ChatPostVO;
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
    public String assistantPage(HttpSession session, Model model) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");

        boolean isLogin = loginUser != null;
        model.addAttribute("isLogin", isLogin);

        if (isLogin) {
            Long userIdx = loginUser.getUserIdx();
            List<ChatPostVO> chatPostList = assistantService.getRecentChatPosts(userIdx);
            model.addAttribute("chatPostList", chatPostList);
        } else {
            model.addAttribute("chatPostList", new ArrayList<>());
        }

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

<<<<<<< PARK-SEO-JIN
        Long userIdx = null;
        if (loginUser != null) {
            userIdx = loginUser.getUserIdx();
        }
=======
        Long userIdx = loginUser.getUserIdx();
>>>>>>> dev

        @SuppressWarnings("unchecked")
        List<Map<String, String>> history =
                (List<Map<String, String>>) session.getAttribute("chatHistory");

        Long chatPostIdx = (Long) session.getAttribute("currentChatPostIdx");

<<<<<<< PARK-SEO-JIN
        Object payloadChatPostIdx = payload.get("chatPostIdx");
        if (payloadChatPostIdx != null && !payloadChatPostIdx.toString().isBlank()) {
            chatPostIdx = Long.valueOf(payloadChatPostIdx.toString());
        }
=======
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
>>>>>>> dev

        Map<String, Object> result =
                assistantService.chat(userMessage, history, userIdx, chatPostIdx, lang);

        session.setAttribute("chatHistory", result.get("history"));

        if (result.get("chatPostIdx") != null) {
            session.setAttribute("currentChatPostIdx", result.get("chatPostIdx"));
        }

        return result;
    }

    @GetMapping("/history/{chatPostIdx}")
    @ResponseBody
    public Map<String, Object> getHistory(
            @PathVariable Long chatPostIdx,
            HttpSession session) {

        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return Map.of(
                    "success", false,
                    "message", "로그인 후 이용할 수 있습니다."
            );
        }

        Long userIdx = loginUser.getUserIdx();
        List<ChatCommentVO> comments = assistantService.getChatComments(chatPostIdx, userIdx);

        List<Map<String, String>> history = new ArrayList<>();

        for (ChatCommentVO comment : comments) {
            String role = "USER".equals(comment.getComment_role()) ? "user" : "assistant";

            history.add(Map.of(
                    "role", role,
                    "content", comment.getContent()
            ));
        }

        session.setAttribute("chatHistory", history);
        session.setAttribute("currentChatPostIdx", chatPostIdx);

        return Map.of(
                "success", true,
                "history", history,
                "chatPostIdx", chatPostIdx
        );
    }

    @PostMapping("/history/{chatPostIdx}/title")
    @ResponseBody
    public Map<String, Object> updateTitle(
            @PathVariable Long chatPostIdx,
            @RequestBody Map<String, Object> payload,
            HttpSession session) {

        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return Map.of("success", false, "message", "로그인 후 이용할 수 있습니다.");
        }

        String title = Objects.toString(payload.get("title"), "").trim();

        boolean success = assistantService.updateChatPostTitle(
                chatPostIdx,
                loginUser.getUserIdx(),
                title
        );

        return Map.of("success", success);
    }

    @PostMapping("/history/{chatPostIdx}/delete")
    @ResponseBody
    public Map<String, Object> deleteHistory(
            @PathVariable Long chatPostIdx,
            HttpSession session) {

        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return Map.of("success", false, "message", "로그인 후 이용할 수 있습니다.");
        }

        boolean success = assistantService.deleteChatPost(
                chatPostIdx,
                loginUser.getUserIdx()
        );

        Long currentChatPostIdx = (Long) session.getAttribute("currentChatPostIdx");
        if (currentChatPostIdx != null && currentChatPostIdx.equals(chatPostIdx)) {
            session.removeAttribute("chatHistory");
            session.removeAttribute("currentChatPostIdx");
        }

        return Map.of("success", success);
    }

    @PostMapping("/reset")
    @ResponseBody
    public Map<String, Object> resetChat(HttpSession session) {
        session.removeAttribute("chatHistory");
        session.removeAttribute("currentChatPostIdx");
        return Map.of("success", true);
    }
}
