package org.triptogether.common.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.common.service.ChatbotService;
import org.triptogether.common.vo.ChatbotRequestVO;
import org.triptogether.common.vo.ChatbotResponseVO;

@RestController
@RequiredArgsConstructor
@RequestMapping("/chatbot")
public class ChatbotController {

    private final ChatbotService chatbotService;

    /**
     * POST /chatbot/ask
     * 챗봇 질문 처리 → Claude API 호출 → JSON 응답
     */
    @PostMapping("/ask")
    public ChatbotResponseVO ask(@RequestBody ChatbotRequestVO request,
                                  HttpSession session) {
        // 로그인 여부를 세션에서 판단
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        request.setLoggedIn(loginUser != null);

        return chatbotService.ask(request);
    }
}
