package org.triptogether.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.triptogether.auth.vo.UsersVO;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.Set;

/**
 * 관리자 전용 페이지 보호 인터셉터.
 *
 * <p>처리 순서:</p>
 * <ol>
 *     <li>비로그인 사용자는 로그인 화면으로 이동</li>
 *     <li>로그인했지만 ADMIN 권한이 아니면 메인으로 이동</li>
 * </ol>
 */
@Slf4j
@Component
public class AdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        HttpSession session = request.getSession(false);
        UsersVO loginUser = (session != null)
                ? (UsersVO) session.getAttribute("loginUser")
                : null;

        if (loginUser == null) {
            String target = request.getRequestURI();
            String query = request.getQueryString();
            if (query != null && !query.isBlank()) {
                target += "?" + query;
            }

            String encodedTarget = URLEncoder.encode(target, StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/auth/login?redirect=" + encodedTarget);
            return false;
        }

        if (!"ADMIN".equals(loginUser.getUserRole())) {
            log.warn("[AdminInterceptor] 관리자 권한 없는 접근 - userIdx={}, path={}",
                    loginUser.getUserIdx(), request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/");
            return false;
        }

        @SuppressWarnings("unchecked")
        Set<String> adminPermissions = (Set<String>) session.getAttribute("adminPermissions");
        if (adminPermissions == null) adminPermissions = Set.of();

        if (adminPermissions.contains("SUPER_ADMIN")) return true;

        String uri = request.getRequestURI().replaceFirst(request.getContextPath(), "");

        if (uri.startsWith("/admin/blocks")) {
            boolean allowed = adminPermissions.contains("USER_BLOCK_ADMIN")
                    || adminPermissions.contains("IP_BLOCK_ADMIN")
                    || adminPermissions.contains("BLOCK_POLICY_ADMIN")
                    || adminPermissions.contains("BLOCK_AUDIT_ADMIN");
            if (!allowed) {
                log.warn("[AdminInterceptor] 차단 관리 권한 부족 - userIdx={}, path={}",
                        loginUser.getUserIdx(), uri);
                response.sendRedirect(request.getContextPath() + "/admin");
                return false;
            }
            return true;
        }

        String required = resolveRequiredPermission(uri);

        if (required != null && !adminPermissions.contains(required)) {
            log.warn("[AdminInterceptor] 권한 부족 - userIdx={}, path={}, required={}",
                    loginUser.getUserIdx(), uri, required);
            response.sendRedirect(request.getContextPath() + "/admin");
            return false;
        }

        return true;
    }

    private static final Map<String, String> URL_PERMISSION_MAP = Map.of(
        "/admin/community",   "COMMUNITY_ADMIN",
        "/admin/members",     "MEMBER_ADMIN",
        "/admin/reports",     "REPORT_ADMIN",
        "/admin/inquiries",   "INQUIRY_ADMIN",
        "/admin/explore",     "EXPLORE_ADMIN",
        "/admin/moderation",  "CONTENT_MODERATION_ADMIN"
    );

    private static final Map<String, String> AUDIT_URLS = Map.of(
        "/admin/logins",               "AUDIT_ADMIN",
        "/admin/security",             "AUDIT_ADMIN",
        "/admin/email-verifications",  "AUDIT_ADMIN",
        "/admin/email-tokens",         "AUDIT_ADMIN",
        "/admin/activity-logs",        "AUDIT_ADMIN"
    );

    private String resolveRequiredPermission(String uri) {
        for (Map.Entry<String, String> entry : URL_PERMISSION_MAP.entrySet()) {
            if (uri.startsWith(entry.getKey())) return entry.getValue();
        }
        for (Map.Entry<String, String> entry : AUDIT_URLS.entrySet()) {
            if (uri.startsWith(entry.getKey())) return entry.getValue();
        }
        return null;
    }
}
