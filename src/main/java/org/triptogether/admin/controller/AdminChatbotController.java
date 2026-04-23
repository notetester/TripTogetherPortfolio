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
import org.triptogether.common.service.ChatbotLinkClickService;
import org.triptogether.common.service.ChatbotQuotaService;
import org.triptogether.common.service.ConversationService;
import org.triptogether.common.vo.ChatMessageVO;
import org.triptogether.common.vo.ChatbotBlockVO;
import org.triptogether.common.vo.ChatbotQuotaVO;
import org.triptogether.common.vo.ConversationVO;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 관리자 AI 챗봇(common 모듈, Gemini) 관리 컨트롤러.
 * URL: /admin/ai-helper/chatbot (sub-tab: dashboard / conversations / inappropriate / blocks / quotas)
 * AI 도우미(assistant 모듈, Claude) 관리는 AdminAssistantController가 담당.
 * 권한: AI_CHATBOT_ADMIN (AdminInterceptor가 /admin/ai-helper 서브패스별 분기하여 체크)
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/ai-helper")
public class AdminChatbotController {

    private final ConversationService conversationService;
    private final ChatbotBlockService blockService;
    private final ChatbotQuotaService quotaService;
    private final ChatbotLinkClickService linkClickService;
    private final org.triptogether.common.mapper.ChatbotMessageMapper messageMapper;

    /**
     * GET /admin/ai-helper/chatbot
     * AI 챗봇(footer chatbot) 섹션 - 내부 sub-tab: dashboard / conversations / inappropriate / blocks / quotas.
     */
    @GetMapping("/chatbot")
    public String chatbotSection(@RequestParam(defaultValue = "dashboard") String tab,
                                 @RequestParam(defaultValue = "1") int page,
                                 @RequestParam(defaultValue = "") String keyword,
                                 @RequestParam(defaultValue = "30") int days,
                                 Model model) {

        int pageSize = 20;
        int offset = (page - 1) * pageSize;

        switch (tab) {
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
            case "links" -> {
                int rangeDays = Math.max(1, Math.min(days, 365));
                LocalDate today = LocalDate.now();
                LocalDateTime from = today.minusDays(rangeDays - 1L).atStartOfDay();
                LocalDateTime to = today.plusDays(1).atStartOfDay();

                int totalClicks = linkClickService.countClicks(from, to);
                List<Map<String, Object>> topUrls = linkClickService.getTopUrls(from, to, 20);
                List<Map<String, Object>> dailyTrend = linkClickService.getDailyTrend(from, to);

                model.addAttribute("totalClicks", totalClicks);
                model.addAttribute("topUrls", topUrls);
                model.addAttribute("dailyTrend", dailyTrend);
                model.addAttribute("rangeDays", rangeDays);
            }
            default -> {
                model.addAttribute("totalConversations", conversationService.countAllConversations(""));
                model.addAttribute("todayConversations", conversationService.countTodayConversations());
                model.addAttribute("inappropriateCount", messageMapper.countInappropriateMessages());
                model.addAttribute("activeBlockCount", blockService.getBlocks(true).size());

                List<ConversationVO> list = conversationService.searchConversations(keyword, offset, pageSize);
                int total = conversationService.countAllConversations(keyword);
                model.addAttribute("conversations", list);
                model.addAttribute("total", total);
                model.addAttribute("totalPages", (int) Math.ceil((double) total / pageSize));
                tab = "dashboard";
            }
        }

        model.addAttribute("section", "chatbot");
        model.addAttribute("tab", tab);
        model.addAttribute("page", page);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "aiHelper");
        model.addAttribute("pageTitle", "AI 챗봇 관리");
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
        result.put("linkClicks", linkClickService.getClicksByConversation(conversationId));
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
