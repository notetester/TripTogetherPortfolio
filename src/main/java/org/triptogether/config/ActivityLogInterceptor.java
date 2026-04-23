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

    public static final String ATTR_REQUEST_ID = "activityLog.requestId";
    public static final String ATTR_START_TIME = "activityLog.startTime";
    public static final String ATTR_FORCE_USER_IDX = "activityLog.forceUserIdx";
    public static final String ATTR_FORCE_SESSION_ID = "activityLog.forceSessionId";
    public static final String ATTR_FLOW_TRACE_ID_OVERRIDE = "activityLog.flowTraceId";
    public static final String ATTR_ACTIVITY_CODE_OVERRIDE = "activityLog.activityCode";
    public static final String ATTR_ACTIVITY_DOMAIN_OVERRIDE = "activityLog.activityDomain";
    public static final String ATTR_ACTIVITY_PROVIDER_OVERRIDE = "activityLog.activityProvider";
    public static final String ATTR_AUTH_EVENT_TYPE_OVERRIDE = "activityLog.authEventType";
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

            Long forcedUserIdx = asLong(request.getAttribute(ATTR_FORCE_USER_IDX));
            String forcedSessionId = asString(request.getAttribute(ATTR_FORCE_SESSION_ID));
            String flowTraceId = asString(request.getAttribute(ATTR_FLOW_TRACE_ID_OVERRIDE));
            String sessionId = forcedSessionId != null ? forcedSessionId : (session == null ? null : session.getId());
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
            String activityCode = firstNonBlank(asString(request.getAttribute(ATTR_ACTIVITY_CODE_OVERRIDE)), resolveActivityCode(request, handlerName));
            String activityDomain = firstNonBlank(asString(request.getAttribute(ATTR_ACTIVITY_DOMAIN_OVERRIDE)), resolveActivityDomain(uri, handlerName));
            String activityProvider = firstNonBlank(asString(request.getAttribute(ATTR_ACTIVITY_PROVIDER_OVERRIDE)), resolveActivityProvider(uri));
            String authEventType = firstNonBlank(asString(request.getAttribute(ATTR_AUTH_EVENT_TYPE_OVERRIDE)), resolveAuthEventType(uri, activityCode));
            String targetType = resolveTargetType(uri);
            String targetId = resolveTargetId(uri);
            String detailSummary = buildDetailSummary(request, activityCode, handlerName);

            activityLogMapper.insertActivityLog(UserActivityLogVO.builder()
                    .requestId(requestId)
                    .flowTraceId(firstNonBlank(flowTraceId, requestId))
                    .userIdx(forcedUserIdx != null ? forcedUserIdx : (loginUser != null ? loginUser.getUserIdx() : null))
                    .sessionId(sessionId)
                    .requestUri(uri)
                    .httpMethod(method)
                    .activityDomain(activityDomain)
                    .activityType(activityType)
                    .activityCode(activityCode)
                    .activityProvider(activityProvider)
                    .authEventType(authEventType)
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

    private String resolveActivityDomain(String uri, String handlerName) {
        if ((uri != null && uri.contains("/auth/")) || (handlerName != null && handlerName.startsWith("AuthController#"))) {
            return "AUTH";
        }
        if ((uri != null && uri.contains("/admin/")) || (handlerName != null && handlerName.startsWith("AdminController#"))) {
            return "ADMIN";
        }
        if ((uri != null && uri.contains("/community/")) || (handlerName != null && handlerName.startsWith("CommunityController#"))) {
            return "COMMUNITY";
        }
        if ((uri != null && uri.contains("/mypage/")) || (handlerName != null && (handlerName.startsWith("ProfileController#") || handlerName.startsWith("MyPageController#")))) {
            return "MYPAGE";
        }
        if ((uri != null && uri.contains("/inquiry/")) || (handlerName != null && handlerName.startsWith("InquiryController#"))) {
            return "INQUIRY";
        }
        return "GENERAL";
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
        if ("GET".equalsIgnoreCase(method) && uri.endsWith("/auth/logout")) return "LOGOUT_LOCAL";
        if ("GET".equalsIgnoreCase(method) && uri.endsWith("/auth/kakao/logout")) return "LOGOUT_KAKAO_REQUEST";
        if ("GET".equalsIgnoreCase(method) && uri.endsWith("/auth/kakao/logout/callback")) return "LOGOUT_KAKAO_CALLBACK";
        if ("GET".equalsIgnoreCase(method) && uri.endsWith("/auth/naver/logout")) return "LOGOUT_NAVER_REQUEST";
        if ("GET".equalsIgnoreCase(method) && uri.endsWith("/auth/naver/logout/callback")) return "LOGOUT_NAVER_CALLBACK";
        if ("GET".equalsIgnoreCase(method) && uri.endsWith("/auth/google/logout")) return "LOGOUT_GOOGLE_REQUEST";
        if ("GET".equalsIgnoreCase(method) && uri.endsWith("/auth/google/logout/callback")) return "LOGOUT_GOOGLE_CALLBACK";
        if (uri.contains("/auth/find-id")) return "FIND_ID_FLOW";
        if (uri.contains("/auth/find-pw") || uri.contains("/auth/reset-pw")) return "RESET_PASSWORD_FLOW";
        if (uri.contains("/mypage/edit/email/send")) return "SEND_PROFILE_EMAIL_VERIFY";
        if (uri.contains("/mypage/edit/login-settings")) return "SAVE_LOGIN_SETTINGS";
        if (uri.contains("/community") && "POST".equalsIgnoreCase(method)) return "COMMUNITY_ACTION";
        if (uri.contains("/admin/")) return "ADMIN_ACCESS";
        return handlerName;
    }

    private String resolveActivityProvider(String uri) {
        if (uri == null) return null;
        if (uri.contains("/auth/kakao")) return "KAKAO";
        if (uri.contains("/auth/naver")) return "NAVER";
        if (uri.contains("/auth/google")) return "GOOGLE";
        if (uri.contains("/auth/")) return "LOCAL";
        return null;
    }

    private String resolveAuthEventType(String uri, String activityCode) {
        if (uri != null && uri.contains("/auth/")) {
            if ((activityCode != null && activityCode.contains("LOGOUT")) || uri.contains("/logout")) {
                return "LOGOUT";
            }
            if ((activityCode != null && activityCode.contains("LOGIN")) || uri.contains("/login")) {
                return "LOGIN";
            }
            if (uri.contains("/auth/link")) {
                return uri.contains("/unlink") ? "UNLINK" : "LINK";
            }
        }
        return null;
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
            if (p != null && p.matches("\\d+")) {
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

    private Long asLong(Object value) {
        if (value instanceof Number number) {
            return number.longValue();
        }
        if (value instanceof String text && !text.isBlank()) {
            try {
                return Long.parseLong(text);
            } catch (NumberFormatException ignored) {
                return null;
            }
        }
        return null;
    }

    private String asString(Object value) {
        return value == null ? null : value.toString();
    }

    private String firstNonBlank(String primary, String fallback) {
        if (primary != null && !primary.isBlank()) {
            return primary;
        }
        return fallback;
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
