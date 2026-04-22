package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.common.service.ChatbotBlockService;
import org.triptogether.common.service.ChatbotQuotaService;
import org.triptogether.common.service.ConversationService;
import org.triptogether.common.vo.ChatMessageVO;
import org.triptogether.common.vo.ChatbotBlockVO;
import org.triptogether.common.vo.ChatbotQuotaVO;
import org.triptogether.common.vo.ConversationVO;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 관리자 AI 도우미 관리 컨트롤러.
 * 최상위 섹션: AI 도우미(assistant) / AI 챗봇(chatbot)
 * 권한: AI_HELPER_ADMIN (AdminInterceptor가 체크)
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/ai-helper")
public class AdminChatbotController {

    private final ConversationService conversationService;
    private final ChatbotBlockService blockService;
    private final ChatbotQuotaService quotaService;
    private final org.triptogether.common.mapper.ChatbotMessageMapper messageMapper;

    /**
     * GET /admin/ai-helper
     * AI 도우미(assistant) 섹션 - Claude 기반 여행 일정 생성 모듈 관리.
     * 현재는 안내 placeholder. 추후 기능 확장.
     */
    @GetMapping
    public String assistantSection(Model model) {
        model.addAttribute("section", "assistant");
        model.addAttribute("activeMenu", "aiHelper");
        model.addAttribute("pageTitle", "AI 도우미 관리");
        return "admin/ai-helper/assistant";
    }

    /**
     * GET /admin/ai-helper/chatbot
     * AI 챗봇(footer chatbot) 섹션 - 내부 sub-tab: dashboard / conversations / inappropriate / blocks / quotas.
     */
    @GetMapping("/chatbot")
    public String chatbotSection(@RequestParam(defaultValue = "dashboard") String tab,
                                 @RequestParam(defaultValue = "1") int page,
                                 @RequestParam(defaultValue = "") String keyword,
                                 Model model) {

        int pageSize = 20;
        int offset = (page - 1) * pageSize;

        switch (tab) {
            case "conversations" -> {
                List<ConversationVO> list = conversationService.searchConversations(keyword, offset, pageSize);
                int total = conversationService.countAllConversations(keyword);
                model.addAttribute("conversations", list);
                model.addAttribute("total", total);
                model.addAttribute("totalPages", (int) Math.ceil((double) total / pageSize));
            }
            case "inappropriate" -> {
                List<ChatMessageVO> msgs = messageMapper.selectInappropriateMessages(offset, pageSize);
                int total = messageMapper.countInappropriateMessages();
                model.addAttribute("messages", msgs);
                model.addAttribute("total", total);
                model.addAttribute("totalPages", (int) Math.ceil((double) total / pageSize));
            }
            case "blocks" -> {
                List<ChatbotBlockVO> blocks = blockService.getBlocks(false);
                model.addAttribute("blocks", blocks);
            }
            case "quotas" -> {
                List<ChatbotQuotaVO> quotas = quotaService.getAllQuotas();
                model.addAttribute("quotas", quotas);
            }
            default -> {
                model.addAttribute("totalConversations", conversationService.countAllConversations(""));
                model.addAttribute("inappropriateCount", messageMapper.countInappropriateMessages());
                model.addAttribute("activeBlockCount", blockService.getBlocks(true).size());
            }
        }

        model.addAttribute("section", "chatbot");
        model.addAttribute("tab", tab);
        model.addAttribute("page", page);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "aiHelper");
        model.addAttribute("pageTitle", "AI 도우미 관리");
        return "admin/ai-helper/chatbot";
    }

    /**
     * GET /admin/ai-helper/conversations/{id}/messages
     * 특정 대화의 메시지 전체 조회 (Ajax 모달용).
     */
    @GetMapping("/conversations/{id}/messages")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> viewMessages(@PathVariable("id") Long conversationId) {
        Map<String, Object> result = new HashMap<>();
        ConversationVO conv = conversationService.getConversation(conversationId);
        if (conv == null) {
            result.put("success", false);
            return ResponseEntity.status(404).body(result);
        }
        result.put("success", true);
        result.put("conversation", conv);
        result.put("messages", conversationService.getAllMessages(conversationId));
        return ResponseEntity.ok(result);
    }

    /**
     * POST /admin/ai-helper/blocks
     * 차단 등록/갱신.
     */
    @PostMapping("/blocks")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createBlock(@RequestBody ChatbotBlockVO block,
                                                            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO admin = (UsersVO) session.getAttribute("loginUser");
        if (admin == null) {
            result.put("success", false);
            return ResponseEntity.status(401).body(result);
        }
        block.setBlockedBy(admin.getUserIdx());
        block.setBlockedAt(LocalDateTime.now());
        try {
            blockService.upsertBlock(block);
            result.put("success", true);
        } catch (Exception e) {
            log.error("차단 등록 실패", e);
            result.put("success", false);
            result.put("message", "차단 등록 중 오류 발생");
        }
        return ResponseEntity.ok(result);
    }

    /**
     * POST /admin/ai-helper/blocks/{id}/deactivate
     * 차단 해제.
     */
    @PostMapping("/blocks/{id}/deactivate")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deactivateBlock(@PathVariable("id") Long blockId) {
        Map<String, Object> result = new HashMap<>();
        try {
            blockService.deactivateBlock(blockId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("차단 해제 실패", e);
            result.put("success", false);
        }
        return ResponseEntity.ok(result);
    }

    /**
     * POST /admin/ai-helper/quotas/{id}
     * 등급별 한도 수정.
     */
    @PostMapping("/quotas/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateQuota(@PathVariable("id") Integer quotaId,
                                                            @RequestBody ChatbotQuotaVO quota,
                                                            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO admin = (UsersVO) session.getAttribute("loginUser");
        if (admin == null) {
            result.put("success", false);
            return ResponseEntity.status(401).body(result);
        }
        quota.setQuotaId(quotaId);
        quota.setUpdatedBy(admin.getUserIdx());
        try {
            quotaService.updateQuota(quota);
            result.put("success", true);
        } catch (Exception e) {
            log.error("한도 수정 실패", e);
            result.put("success", false);
        }
        return ResponseEntity.ok(result);
    }
}
