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
 * 로그인 여부를 검사하는 인터셉터.
 *
 * <p>마이페이지, 소셜 연동처럼 "비로그인 상태로 접근하면 안 되는" URL을
 * 컨트롤러 이전 단계에서 일괄 차단한다.</p>
 */
@Slf4j
@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        HttpSession session = request.getSession(false);
        UsersVO loginUser = (session != null)
                ? (UsersVO) session.getAttribute("loginUser")
                : null;

        if (loginUser != null) {
            return true;
        }

        // 원래 가려던 경로를 redirect 파라미터로 넘겨 로그인 후 되돌아오게 한다.
        String target = request.getRequestURI();
        String query = request.getQueryString();
        if (query != null && !query.isBlank()) {
            target += "?" + query;
        }

        String encodedTarget = URLEncoder.encode(target, StandardCharsets.UTF_8);
        String redirectUrl = request.getContextPath() + "/auth/login?redirect=" + encodedTarget;

        log.debug("[LoginInterceptor] 비로그인 접근 차단 - path={}", target);
        response.sendRedirect(redirectUrl);
        return false;
    }
}
