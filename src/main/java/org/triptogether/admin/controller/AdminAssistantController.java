package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.admin.service.AdminAssistantBlockService;
import org.triptogether.admin.service.AdminAssistantModerationService;
import org.triptogether.admin.service.AdminAssistantQuotaService;
import org.triptogether.admin.service.AdminAssistantService;
import org.triptogether.admin.vo.AdminAssistantBlockVO;
import org.triptogether.admin.vo.AdminAssistantMessageVO;
import org.triptogether.admin.vo.AdminAssistantModerationVO;
import org.triptogether.admin.vo.AdminAssistantQuotaVO;
import org.triptogether.admin.vo.AdminAssistantSessionVO;
import org.triptogether.auth.vo.UsersVO;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 관리자 AI 도우미(assistant) 관리 컨트롤러.
 * URL: /admin/ai-helper (sub-tab: dashboard / sessions / messages)
 * SJ가 구현한 assistant 모듈(CHAT_POST/CHAT_COMMENT)의 관리 페이지.
 * AI 챗봇(common 모듈, Gemini) 관리는 AdminChatbotController가 담당.
 * 권한: ASSISTANT_ADMIN (AdminInterceptor가 /admin/ai-helper 서브패스별 분기하여 체크)
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/ai-helper")
public class AdminAssistantController {

    private static final int PAGE_SIZE = 20;

    private final AdminAssistantService assistantService;
    private final AdminAssistantBlockService blockService;
    private final AdminAssistantQuotaService quotaService;
    private final AdminAssistantModerationService moderationService;

    /**
     * GET /admin/ai-helper
     * AI 도우미(assistant) 섹션 - sub-tab 렌더링.
     */
    @GetMapping
    public String assistantSection(@RequestParam(defaultValue = "dashboard") String tab,
                                   @RequestParam(defaultValue = "1") int page,
                                   @RequestParam(defaultValue = "") String keyword,
                                   Model model) {

        switch (tab) {
            case "messages" -> {
                List<AdminAssistantMessageVO> msgs = assistantService.getRecentMessages(page, PAGE_SIZE);
                int total = assistantService.countMessages();
                model.addAttribute("messages", msgs);
                model.addAttribute("total", total);
                model.addAttribute("totalPages", (int) Math.ceil((double) total / PAGE_SIZE));
            }
            case "inappropriate" -> {
                List<AdminAssistantModerationVO> msgs = moderationService.getInappropriateMessages(page, PAGE_SIZE);
                int total = moderationService.countInappropriateMessages();
                model.addAttribute("messages", msgs);
                model.addAttribute("total", total);
                model.addAttribute("totalPages", (int) Math.ceil((double) total / PAGE_SIZE));
            }
            case "blocks" -> {
                List<AdminAssistantBlockVO> blocks = blockService.getBlocks(false);
                model.addAttribute("blocks", blocks);
            }
            case "quotas" -> {
                List<AdminAssistantQuotaVO> quotas = quotaService.getAllQuotas();
                model.addAttribute("quotas", quotas);
            }
            default -> {
                model.addAttribute("stats", assistantService.getStats());
                List<AdminAssistantSessionVO> list = assistantService.getSessions(keyword, page, PAGE_SIZE);
                int total = assistantService.countSessions(keyword);
                model.addAttribute("sessions", list);
                model.addAttribute("total", total);
                model.addAttribute("totalPages", (int) Math.ceil((double) total / PAGE_SIZE));
                tab = "dashboard";
            }
        }

        model.addAttribute("section", "assistant");
        model.addAttribute("tab", tab);
        model.addAttribute("page", page);
        model.addAttribute("keyword", keyword);
        model.addAttribute("activeMenu", "aiHelper");
        model.addAttribute("pageTitle", "AI 도우미 관리");
        return "admin/ai-helper/assistant";
    }

    /**
     * GET /admin/ai-helper/assistant/sessions/{id}/messages
     * 특정 세션의 메시지 전체 조회 (Ajax 모달용).
     */
    @GetMapping("/assistant/sessions/{id}/messages")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> viewMessages(@PathVariable("id") Long chatPostIdx) {
        Map<String, Object> result = new HashMap<>();
        AdminAssistantSessionVO session = assistantService.getSession(chatPostIdx);
        if (session == null) {
            result.put("success", false);
            return ResponseEntity.status(404).body(result);
        }
        result.put("success", true);
        result.put("session", session);
        result.put("messages", assistantService.getMessagesByPost(chatPostIdx));
        return ResponseEntity.ok(result);
    }

    /**
     * POST /admin/ai-helper/assistant/sessions/{id}/delete
     * 세션 삭제 (FK CASCADE로 CHAT_COMMENT도 함께 삭제됨).
     */
    @PostMapping("/assistant/sessions/{id}/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteSession(@PathVariable("id") Long chatPostIdx) {
        Map<String, Object> result = new HashMap<>();
        try {
            assistantService.deleteSession(chatPostIdx);
            result.put("success", true);
        } catch (Exception e) {
            log.error("AI 도우미 세션 삭제 실패: chatPostIdx={}", chatPostIdx, e);
            result.put("success", false);
            result.put("message", "삭제 중 오류 발생");
        }
        return ResponseEntity.ok(result);
    }

    /**
     * POST /admin/ai-helper/assistant/blocks
     * AI 도우미 차단 등록/갱신.
     * 경로는 assistant 하위에 두어 챗봇의 /admin/ai-helper/blocks 와 분리.
     */
    @PostMapping("/assistant/blocks")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createBlock(@RequestBody AdminAssistantBlockVO block,
                                                            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO admin = (UsersVO) session.getAttribute("loginUser");
        if (admin == null) {
            result.put("success", false);
            return ResponseEntity.status(401).body(result);
        }
        block.setBlockedBy(admin.getUserIdx());
        block.setBlockedAt(new Date());
        try {
            blockService.upsertBlock(block);
            result.put("success", true);
        } catch (Exception e) {
            log.error("AI 도우미 차단 등록 실패", e);
            result.put("success", false);
            result.put("message", "차단 등록 중 오류 발생");
        }
        return ResponseEntity.ok(result);
    }

    /**
     * POST /admin/ai-helper/assistant/blocks/{id}/deactivate
     * 차단 해제.
     */
    @PostMapping("/assistant/blocks/{id}/deactivate")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deactivateBlock(@PathVariable("id") Long blockId) {
        Map<String, Object> result = new HashMap<>();
        try {
            blockService.deactivateBlock(blockId);
            result.put("success", true);
        } catch (Exception e) {
            log.error("AI 도우미 차단 해제 실패", e);
            result.put("success", false);
        }
        return ResponseEntity.ok(result);
    }

    /**
     * POST /admin/ai-helper/assistant/quotas/{id}
     * 등급별 한도 수정.
     */
    @PostMapping("/assistant/quotas/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateQuota(@PathVariable("id") Integer quotaId,
                                                            @RequestBody AdminAssistantQuotaVO quota,
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
            log.error("AI 도우미 한도 수정 실패", e);
            result.put("success", false);
        }
        return ResponseEntity.ok(result);
    }
}
