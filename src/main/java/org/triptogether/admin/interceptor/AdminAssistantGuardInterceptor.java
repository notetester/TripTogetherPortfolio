package org.triptogether.admin.interceptor;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.triptogether.admin.mapper.AdminAssistantMapper;
import org.triptogether.admin.service.AdminAssistantBlockService;
import org.triptogether.admin.service.AdminAssistantQuotaService;
import org.triptogether.admin.service.AdminAssistantUsageService;
import org.triptogether.admin.vo.AdminAssistantQuotaVO;
import org.triptogether.admin.vo.AdminAssistantUsageVO;
import org.triptogether.auth.vo.UsersVO;

import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * AI 도우미(/assistant/chat) 전용 가드 인터셉터.
 *
 * <p>SJ 담당 assistant 모듈을 수정할 수 없으므로 Spring Interceptor 로
 * 차단/한도 enforce 를 수행한다.</p>
 *
 * <ul>
 *   <li>preHandle: 차단 체크 → 세션수 한도 → 메시지 한도 순으로 검증. 실패 시 JSON 응답 후 false.</li>
 *   <li>afterCompletion: 응답 성공(status&lt;400) 시 session/message 카운터 upsert.</li>
 *   <li>ADMIN/SUPERADMIN 은 전부 bypass (카운터 증가 없음).</li>
 * </ul>
 *
 * 실패 응답은 AssistantController 패턴과 동일한 JSON 포맷:
 * {@code {"success":false, "answer":"...", "history":[]}}.
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class AdminAssistantGuardInterceptor implements HandlerInterceptor {

    private final AdminAssistantBlockService blockService;
    private final AdminAssistantQuotaService quotaService;
    private final AdminAssistantUsageService usageService;
    private final AdminAssistantMapper assistantMapper;

    private static final ObjectMapper JSON = new ObjectMapper();

    // request attribute keys
    private static final String ATTR_EXEMPT          = "aag_exempt";
    private static final String ATTR_USER_IDX        = "aag_userIdx";
    private static final String ATTR_GRADE           = "aag_grade";
    private static final String ATTR_PRE_POST_IDX    = "aag_preChatPostIdx";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // POST /assistant/chat 만 대상. 인터셉터 등록이 path로 좁혀져 있어도 method 확인.
        if (!"POST".equalsIgnoreCase(request.getMethod())) return true;

        HttpSession session = request.getSession(false);
        if (session == null) return true;  // AssistantController 가 비로그인 처리
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        if (loginUser == null) return true;

        // ADMIN/SUPERADMIN 은 차단/한도 전부 bypass + 카운터 증가도 없음
        if (quotaService.isQuotaExempt(loginUser)) {
            request.setAttribute(ATTR_EXEMPT, Boolean.TRUE);
            return true;
        }

        Long userIdx = loginUser.getUserIdx();
        String ip = getClientIp(request);
        Long preChatPostIdx = (Long) session.getAttribute("currentChatPostIdx");

        // 1. 차단 체크
        if (blockService.isBlocked(userIdx, ip)) {
            writeErrorJson(response, 403, "AI 도우미 이용이 차단되었습니다.");
            return false;
        }

        // 2. 등급/한도 로드
        String grade = quotaService.resolveGrade(loginUser);
        AdminAssistantQuotaVO quota = quotaService.getQuotaByGrade(grade);

        // 3. 세션(CHAT_POST) 한도 — 신규 세션 생성 예정일 때만 (preChatPostIdx == null)
        if (preChatPostIdx == null
                && quota != null && quota.getMaxSessions() != null
                && quota.getMaxSessions() >= 0) {
            int existing = assistantMapper.countChatPostsByUser(userIdx);
            if (existing >= quota.getMaxSessions()) {
                writeErrorJson(response, 429,
                        "세션 한도(" + quota.getMaxSessions() + ")에 도달했습니다. 기존 대화를 삭제한 뒤 다시 시도해주세요.");
                return false;
            }
        }

        // 4. 주기당 메시지 한도
        if (quota != null && quota.getMaxMessagesPerPeriod() != null
                && quota.getMaxMessagesPerPeriod() >= 0) {
            LocalDateTime periodStart = quotaService.calculateCurrentPeriodStart(quota);
            AdminAssistantUsageVO usage = usageService.getUsage(userIdx, null, periodStart);
            int used = (usage != null && usage.getMessageCount() != null) ? usage.getMessageCount() : 0;
            if (used >= quota.getMaxMessagesPerPeriod()) {
                writeErrorJson(response, 429,
                        "메시지 한도(" + quota.getMaxMessagesPerPeriod() + ")에 도달했습니다. 잠시 후 다시 시도해주세요.");
                return false;
            }
        }

        // afterCompletion 에서 재사용
        request.setAttribute(ATTR_USER_IDX, userIdx);
        request.setAttribute(ATTR_GRADE, grade);
        request.setAttribute(ATTR_PRE_POST_IDX, preChatPostIdx);
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
                                 Object handler, Exception ex) {
        // bypass(어드민) 또는 실패 응답 시 카운터 증가하지 않음
        if (Boolean.TRUE.equals(request.getAttribute(ATTR_EXEMPT))) return;
        if (response.getStatus() >= 400) return;

        Long userIdx = (Long) request.getAttribute(ATTR_USER_IDX);
        if (userIdx == null) return;  // preHandle 통과 못한 케이스 (비로그인 등)

        String grade = (String) request.getAttribute(ATTR_GRADE);
        AdminAssistantQuotaVO quota = quotaService.getQuotaByGrade(grade);
        LocalDateTime periodStart = quotaService.calculateCurrentPeriodStart(quota);

        // 세션 증가: pre 에서는 null 이었는데 post 에서 값 생김 → 신규 CHAT_POST 생성됨
        Long preChatPostIdx = (Long) request.getAttribute(ATTR_PRE_POST_IDX);
        HttpSession session = request.getSession(false);
        Long postChatPostIdx = (session != null) ? (Long) session.getAttribute("currentChatPostIdx") : null;
        if (preChatPostIdx == null && postChatPostIdx != null) {
            try {
                usageService.incrementSessionCount(userIdx, null, periodStart);
            } catch (Exception e) {
                log.warn("[AssistantGuard] 세션 카운트 증가 실패 userIdx={}, {}", userIdx, e.getMessage());
            }
        }

        // 메시지 카운터는 항상 증가
        try {
            usageService.incrementMessageCount(userIdx, null, periodStart);
        } catch (Exception e) {
            log.warn("[AssistantGuard] 메시지 카운트 증가 실패 userIdx={}, {}", userIdx, e.getMessage());
        }
    }

    // ─── helpers ───

    private void writeErrorJson(HttpServletResponse response, int status, String message) throws Exception {
        response.setStatus(status);
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());
        Map<String, Object> body = new HashMap<>();
        body.put("success", false);
        body.put("answer", message);
        body.put("history", new ArrayList<>());
        response.getWriter().write(JSON.writeValueAsString(body));
    }

    private String getClientIp(HttpServletRequest request) {
        String[] headers = {
                "X-Forwarded-For", "Proxy-Client-IP", "WL-Proxy-Client-IP",
                "HTTP_CLIENT_IP", "HTTP_X_FORWARDED_FOR"
        };
        for (String h : headers) {
            String ip = request.getHeader(h);
            if (ip != null && !ip.isBlank() && !"unknown".equalsIgnoreCase(ip)) {
                return ip.split(",")[0].trim();
            }
        }
        return request.getRemoteAddr();
    }
}
