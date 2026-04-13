package org.triptogether.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.common.mapper.ActivityLogMapper;
import org.triptogether.common.vo.UserActivityLogVO;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

/**
 * 일반 활동 로그 인터셉터.
 *
 * <p>정적 리소스를 제외한 주요 요청에 대해 누가 / 어디를 / 어떤 방식으로 호출했는지 남긴다.</p>
 * <p>보안 이력(USER_SECURITY_HISTORY)이 계정/인증 관련 민감 이벤트를 다룬다면,
 * 이 인터셉터는 서비스 전반의 일반 활동 흐름을 넓게 기록하는 역할을 맡는다.</p>
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class ActivityLogInterceptor implements HandlerInterceptor {

    private static final String ATTR_REQUEST_ID = "activityLog.requestId";
    private static final String ATTR_START_TIME = "activityLog.startTime";
    private static final Set<String> SENSITIVE_KEYS = new HashSet<>(Arrays.asList(
            "token", "password", "newPassword", "currentPassword", "code", "state"
    ));

    private final ActivityLogMapper activityLogMapper;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        request.setAttribute(ATTR_REQUEST_ID, UUID.randomUUID().toString());
        request.setAttribute(ATTR_START_TIME, System.currentTimeMillis());
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        try {
            HttpSession session = request.getSession(false);
            UsersVO loginUser = session == null ? null : (UsersVO) session.getAttribute("loginUser");

            String sessionId = session == null ? null : session.getId();
            String uri = request.getRequestURI();
            String method = request.getMethod();
            String queryString = sanitizeQueryString(request.getQueryString());
            String referer = sanitizeReferer(request.getHeader("Referer"));
            String userAgent = request.getHeader("User-Agent");
            String ip = getClientIp(request);
            Integer status = response.getStatus();
            boolean success = ex == null && status != null && status < 400;
            String requestId = (String) request.getAttribute(ATTR_REQUEST_ID);
            Long startTime = (Long) request.getAttribute(ATTR_START_TIME);
            Integer responseTimeMs = startTime == null ? null : Math.toIntExact(Math.max(0L, System.currentTimeMillis() - startTime));

            String handlerName = null;
            if (handler instanceof HandlerMethod hm) {
                handlerName = hm.getBeanType().getSimpleName() + "#" + hm.getMethod().getName();
            }

            String activityType = resolveActivityType(request);
            String activityCode = resolveActivityCode(request, handlerName);
            String targetType = resolveTargetType(uri);
            String targetId = resolveTargetId(uri);
            String detailSummary = buildDetailSummary(request, activityCode, handlerName);

            activityLogMapper.insertActivityLog(UserActivityLogVO.builder()
                    .requestId(requestId)
                    .userIdx(loginUser != null ? loginUser.getUserIdx() : null)
                    .sessionId(sessionId)
                    .requestUri(uri)
                    .httpMethod(method)
                    .activityType(activityType)
                    .activityCode(activityCode)
                    .targetType(targetType)
                    .targetId(targetId)
                    .handlerName(handlerName)
                    .queryString(queryString)
                    .referer(referer)
                    .ipAddress(ip)
                    .userAgent(userAgent)
                    .responseStatus(status)
                    .responseTimeMs(responseTimeMs)
                    .success(success)
                    .detailSummary(detailSummary)
                    .build());
        } catch (Exception loggingEx) {
            log.warn("[ActivityLog] 활동 로그 저장 실패: {}", loggingEx.getMessage());
        }
    }

    private String resolveActivityType(HttpServletRequest request) {
        String method = request.getMethod();
        String xrw = request.getHeader("X-Requested-With");
        String uri = request.getRequestURI();

        if (uri != null && uri.contains("/api/")) {
            return "API";
        }
        if ("XMLHttpRequest".equalsIgnoreCase(xrw)) {
            return "AJAX";
        }
        if ("GET".equalsIgnoreCase(method)) {
            return "PAGE_VIEW";
        }
        return "ACTION";
    }

    private String resolveActivityCode(HttpServletRequest request, String handlerName) {
        String uri = request.getRequestURI();
        String method = request.getMethod();
        if (uri == null) return handlerName;
        if ("GET".equalsIgnoreCase(method) && uri.endsWith("/auth/login")) return "VIEW_LOGIN_PAGE";
        if ("POST".equalsIgnoreCase(method) && uri.endsWith("/auth/login")) return "SUBMIT_LOGIN";
        if (uri.contains("/auth/find-id")) return "FIND_ID_FLOW";
        if (uri.contains("/auth/find-pw") || uri.contains("/auth/reset-pw")) return "RESET_PASSWORD_FLOW";
        if (uri.contains("/mypage/edit/email/send")) return "SEND_PROFILE_EMAIL_VERIFY";
        if (uri.contains("/mypage/edit/login-settings")) return "SAVE_LOGIN_SETTINGS";
        if (uri.contains("/community") && "POST".equalsIgnoreCase(method)) return "COMMUNITY_ACTION";
        if (uri.contains("/admin/")) return "ADMIN_ACCESS";
        return handlerName;
    }

    private String resolveTargetType(String uri) {
        if (uri == null) return null;
        if (uri.contains("/community/post")) return "POST";
        if (uri.contains("/community/comment")) return "COMMENT";
        if (uri.contains("/inquiry")) return "INQUIRY";
        if (uri.contains("/auth/link")) return "SOCIAL";
        if (uri.contains("/mypage/edit/email")) return "EMAIL_VERIFICATION_REQUEST";
        return null;
    }

    private String resolveTargetId(String uri) {
        if (uri == null) return null;
        String[] parts = uri.split("/");
        for (int i = parts.length - 1; i >= 0; i--) {
            String p = parts[i];
            if (p != null && p.matches("\d+")) {
                return p;
            }
        }
        return null;
    }

    private String buildDetailSummary(HttpServletRequest request, String activityCode, String handlerName) {
        StringBuilder sb = new StringBuilder();
        if (activityCode != null) sb.append("code=").append(activityCode);
        if (handlerName != null) {
            if (!sb.isEmpty()) sb.append(", ");
            sb.append("handler=").append(handlerName);
        }
        String xrw = request.getHeader("X-Requested-With");
        if (xrw != null && !xrw.isBlank()) {
            if (!sb.isEmpty()) sb.append(", ");
            sb.append("xrw=").append(xrw);
        }
        return sb.isEmpty() ? null : sb.toString();
    }

    private String sanitizeQueryString(String queryString) {
        if (queryString == null || queryString.isBlank()) return queryString;
        StringBuilder sb = new StringBuilder();
        for (String pair : queryString.split("&")) {
            String[] kv = pair.split("=", 2);
            String key = kv[0];
            String value = kv.length > 1 ? kv[1] : "";
            if (SENSITIVE_KEYS.contains(key)) {
                value = "***";
            }
            if (sb.length() > 0) sb.append('&');
            sb.append(key);
            if (!value.isEmpty()) sb.append('=').append(value);
        }
        return sb.toString();
    }

    private String sanitizeReferer(String referer) {
        if (referer == null || referer.isBlank()) return referer;
        int q = referer.indexOf('?');
        if (q < 0) return referer;
        return referer.substring(0, q) + "?***";
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
