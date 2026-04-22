package org.triptogether.common.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.common.service.ChatbotService;
import org.triptogether.common.service.ConversationService;
import org.triptogether.common.vo.ChatMessageVO;
import org.triptogether.common.vo.ChatbotRequestVO;
import org.triptogether.common.vo.ChatbotResponseVO;
import org.triptogether.common.vo.ConversationVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/chatbot")
public class ChatbotController {

    private final ChatbotService chatbotService;
    private final ConversationService conversationService;

    /**
     * POST /chatbot/ask
     * 챗봇 질문 처리. 신규 대화면 conversationId=null, 이어하기면 기존 ID 전달.
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

    /**
     * GET /chatbot/conversations
     * 현재 유저/세션의 활성 대화 목록.
     */
    @GetMapping("/conversations")
    public ResponseEntity<Map<String, Object>> listConversations(HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        List<ConversationVO> list = loginUser != null
                ? conversationService.getUserConversations(loginUser.getUserIdx())
                : conversationService.getAnonConversations(session.getId());

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("conversations", list);
        return ResponseEntity.ok(result);
    }

    /**
     * GET /chatbot/conversations/{id}/messages
     * 특정 대화의 전체 메시지 (소유자 확인).
     */
    @GetMapping("/conversations/{id}/messages")
    public ResponseEntity<Map<String, Object>> getMessages(@PathVariable("id") Long conversationId,
                                                           HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        Long userIdx = loginUser != null ? loginUser.getUserIdx() : null;
        String anonSessionId = loginUser == null ? session.getId() : null;

        ConversationVO conv = conversationService.getConversation(conversationId);
        if (conv == null || Boolean.TRUE.equals(conv.getIsDeleted())
                || !conversationService.isOwner(conv, userIdx, anonSessionId)) {
            return forbidden();
        }

        List<ChatMessageVO> messages = conversationService.getAllMessages(conversationId);
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("conversation", conv);
        result.put("messages", messages);
        return ResponseEntity.ok(result);
    }

    /**
     * PATCH /chatbot/conversations/{id}/title
     * 대화 제목 수정.
     */
    @PatchMapping("/conversations/{id}/title")
    public ResponseEntity<Map<String, Object>> updateTitle(@PathVariable("id") Long conversationId,
                                                           @RequestBody Map<String, String> body,
                                                           HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        Long userIdx = loginUser != null ? loginUser.getUserIdx() : null;
        String anonSessionId = loginUser == null ? session.getId() : null;

        ConversationVO conv = conversationService.getConversation(conversationId);
        if (conv == null || Boolean.TRUE.equals(conv.getIsDeleted())
                || !conversationService.isOwner(conv, userIdx, anonSessionId)) {
            return forbidden();
        }

        conversationService.updateTitle(conversationId, body.get("title"));
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    /**
     * DELETE /chatbot/conversations/{id}
     * 소프트 삭제 (유저에겐 숨김, 관리자는 조회 가능).
     */
    @DeleteMapping("/conversations/{id}")
    public ResponseEntity<Map<String, Object>> deleteConversation(@PathVariable("id") Long conversationId,
                                                                  HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        Long userIdx = loginUser != null ? loginUser.getUserIdx() : null;
        String anonSessionId = loginUser == null ? session.getId() : null;

        ConversationVO conv = conversationService.getConversation(conversationId);
        if (conv == null || Boolean.TRUE.equals(conv.getIsDeleted())
                || !conversationService.isOwner(conv, userIdx, anonSessionId)) {
            return forbidden();
        }

        conversationService.softDelete(conversationId);
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    // ===== helpers =====
    private ResponseEntity<Map<String, Object>> forbidden() {
        Map<String, Object> result = new HashMap<>();
        result.put("success", false);
        result.put("message", "접근 권한이 없습니다.");
        return ResponseEntity.status(403).body(result);
    }

    private String extractIp(HttpServletRequest req) {
        String ip = req.getHeader("X-Forwarded-For");
        if (ip == null || ip.isBlank() || "unknown".equalsIgnoreCase(ip)) ip = req.getRemoteAddr();
        if (ip != null && ip.contains(",")) ip = ip.split(",")[0].trim();
        return ip;
    }
}
