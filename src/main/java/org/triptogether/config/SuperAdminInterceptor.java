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
 * 현재 프로젝트 흐름은 ADMIN 계열 계정이 superAdmin 화면에 진입한 뒤,
 * 세부 권한은 superAdmin 권한 정책 테이블/화면에서 관리하는 구조다.
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

        if (!loginUser.hasAdminRole()) {
            log.warn("[SuperAdminInterceptor] 접근 거부 - userIdx={}, role={}, path={}",
                    loginUser.getUserIdx(), loginUser.getUserRole(), request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/");
            return false;
        }

        return true;
    }
}
