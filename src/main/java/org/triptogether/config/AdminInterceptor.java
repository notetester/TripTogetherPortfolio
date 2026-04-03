package org.triptogether.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;
import org.triptogether.auth.vo.UsersVO;

@Slf4j
public class AdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response,
                             Object handler) throws Exception {

        HttpSession session = request.getSession(false);
        UsersVO loginUser = (session != null)
                ? (UsersVO) session.getAttribute("loginUser")
                : null;

        // 비로그인 → 로그인 페이지
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login?redirect=" +
                    request.getRequestURI());
            return false;
        }

        // 관리자 권한 없음 → 홈으로
        if (!"ADMIN".equals(loginUser.getUserRole())) {
            log.warn("[Admin] 권한 없는 접근 시도 - userIdx={}, path={}",
                    loginUser.getUserIdx(), request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/");
            return false;
        }

        return true;
    }
}
