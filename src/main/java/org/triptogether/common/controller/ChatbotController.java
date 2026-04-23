package org.triptogether.common.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.common.mapper.ChatbotMessageMapper;
import org.triptogether.common.service.ChatbotLinkClickService;
import org.triptogether.common.service.ChatbotQuotaService;
import org.triptogether.common.service.ChatbotService;
import org.triptogether.common.service.ConversationService;
import org.triptogether.common.vo.ChatMessageVO;
import org.triptogether.common.vo.ChatbotLinkClickVO;
import org.triptogether.common.vo.ChatbotQuotaVO;
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
    private final ChatbotLinkClickService linkClickService;
    private final ChatbotQuotaService quotaService;
    private final ChatbotMessageMapper messageMapper;

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
     * PATCH /chatbot/conversations/order
     * 대화 목록 정렬 순서 변경 (드래그앤드롭).
     * Body: { ids: [11, 7, 23, ...] } — 화면 상단부터 하단 순으로 나열된 conversationId 배열.
     */
    @PatchMapping("/conversations/order")
    public ResponseEntity<Map<String, Object>> reorderConversations(@RequestBody Map<String, Object> body,
                                                                     HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        Long userIdx = loginUser != null ? loginUser.getUserIdx() : null;
        String anonSessionId = loginUser == null ? session.getId() : null;

        Object raw = body.get("ids");
        if (!(raw instanceof List<?> rawList) || rawList.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        List<Long> ids = new java.util.ArrayList<>();
        for (Object v : rawList) {
            if (v == null) continue;
            if (v instanceof Number n) ids.add(n.longValue());
            else {
                try { ids.add(Long.parseLong(v.toString())); } catch (Exception e) { return ResponseEntity.badRequest().build(); }
            }
        }

        boolean ok = conversationService.reorderConversations(ids, userIdx, anonSessionId);
        if (!ok) return forbidden();

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
                                                                  HttpSession session,
                                                                  HttpServletRequest httpReq) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        Long userIdx = loginUser != null ? loginUser.getUserIdx() : null;
        String anonSessionId = loginUser == null ? session.getId() : null;

        ConversationVO conv = conversationService.getConversation(conversationId);
        if (conv == null || Boolean.TRUE.equals(conv.getIsDeleted())
                || !conversationService.isOwner(conv, userIdx, anonSessionId)) {
            return forbidden();
        }

        // 쿼터 환급 — ADMIN/SUPERADMIN 면제자는 원래 카운트 안 하므로 skip.
        // 등급별 quota_refund_enabled 플래그가 true 일 때만 실제 환급. 비로그인은 IP 기준으로 차감.
        boolean quotaExempt = quotaService.isQuotaExempt(loginUser);
        if (!quotaExempt) {
            String grade = quotaService.resolveGrade(loginUser);
            ChatbotQuotaVO quota = quotaService.getQuotaByGrade(grade);
            boolean refundEnabled = quota != null && Boolean.TRUE.equals(quota.getQuotaRefundEnabled());
            if (refundEnabled) {
                int todayUserMsgs = messageMapper.countTodayUserMessagesByConversation(conversationId);
                if (todayUserMsgs > 0) {
                    String ipAddress = loginUser == null ? extractIp(httpReq) : null;
                    quotaService.decreaseTodayUsage(userIdx, ipAddress, todayUserMsgs);
                }
            }
        }

        conversationService.softDelete(conversationId);
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    /**
     * POST /chatbot/link-click
     * 챗봇이 제시한 내부 링크의 클릭 이력을 기록. 대화 소유자만 기록 가능.
     * 프론트는 navigator.sendBeacon 으로 호출 — 응답은 빠르게 닫아도 무방.
     */
    @PostMapping("/link-click")
    public ResponseEntity<Map<String, Object>> logLinkClick(@RequestBody Map<String, Object> body,
                                                             HttpSession session,
                                                             HttpServletRequest httpReq) {
        Long messageId = toLong(body.get("messageId"));
        Long conversationId = toLong(body.get("conversationId"));
        Object urlObj = body.get("url");
        Object labelObj = body.get("label");

        if (messageId == null || conversationId == null || urlObj == null) {
            return ResponseEntity.badRequest().build();
        }

        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        Long userIdx = loginUser != null ? loginUser.getUserIdx() : null;
        String anonSessionId = loginUser == null ? session.getId() : null;

        // 대화 소유권 검증 — 타 유저/세션이 위조 로그 심는 것 방지
        ConversationVO conv = conversationService.getConversation(conversationId);
        if (conv == null || !conversationService.isOwner(conv, userIdx, anonSessionId)) {
            return forbidden();
        }

        ChatbotLinkClickVO click = new ChatbotLinkClickVO();
        click.setMessageId(messageId);
        click.setConversationId(conversationId);
        click.setUserIdx(userIdx);
        click.setAnonSessionId(anonSessionId);
        click.setUrl(urlObj.toString());
        click.setLabel(labelObj != null ? labelObj.toString() : null);
        click.setIpAddress(extractIp(httpReq));

        linkClickService.logClick(click);

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

    private Long toLong(Object v) {
        if (v == null) return null;
        if (v instanceof Number) return ((Number) v).longValue();
        try { return Long.parseLong(v.toString()); } catch (Exception e) { return null; }
    }
}
