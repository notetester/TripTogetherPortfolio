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
 * 최고관리자 전용 페이지 보호 인터셉터.
 * user_role = 'ADMIN' 이상만 접근 허용.
 * SUPERADMIN 역할이 DB에 추가되면 해당 역할로 조건을 강화할 것.
 */
@Slf4j
@Component
public class SuperAdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        HttpSession session = request.getSession(false);
        UsersVO loginUser = (session != null)
                ? (UsersVO) session.getAttribute("loginUser")
                : null;

        if (loginUser == null) {
            String target = URLEncoder.encode(request.getRequestURI(), StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/auth/login?redirect=" + target);
            return false;
        }

        if (!"ADMIN".equals(loginUser.getUserRole())) {
            log.warn("[SuperAdminInterceptor] 접근 거부 - userIdx={}, role={}, path={}",
                    loginUser.getUserIdx(), loginUser.getUserRole(), request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/");
            return false;
        }

        return true;
    }
}
