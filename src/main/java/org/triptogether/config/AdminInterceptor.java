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

        return true;
    }
}
