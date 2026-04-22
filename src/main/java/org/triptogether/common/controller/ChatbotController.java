package org.triptogether.common.controller;

import jakarta.servlet.http.HttpServletRequest;
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
     * 챗봇 질문 처리. Gemini API 호출 → JSON 응답.
     * 신규 대화면 request.conversationId=null, 이어하기면 기존 ID 전달.
     */
    @PostMapping("/ask")
    public ChatbotResponseVO ask(@RequestBody ChatbotRequestVO request,
                                 HttpSession session,
                                 HttpServletRequest httpReq) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        request.setLoggedIn(loginUser != null);

        String anonSessionId = loginUser == null ? session.getId() : null;
        String ip = extractIp(httpReq);

        return chatbotService.ask(request, loginUser, anonSessionId, ip);
    }

    private String extractIp(HttpServletRequest req) {
        String ip = req.getHeader("X-Forwarded-For");
        if (ip == null || ip.isBlank() || "unknown".equalsIgnoreCase(ip)) ip = req.getRemoteAddr();
        if (ip != null && ip.contains(",")) ip = ip.split(",")[0].trim();
        return ip;
    }
}
