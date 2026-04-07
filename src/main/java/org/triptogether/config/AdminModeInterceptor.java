package org.triptogether.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.lang.reflect.Method;

/**
 * =============================================
 * AdminModeInterceptor - 관리자 모드 전역 인터셉터
 * =============================================
 *
 * [역할]
 * 모든 페이지 요청 후(postHandle) 자동으로 아래 두 값을 Model에 주입한다.
 *   - isAdmin     : 현재 로그인한 유저가 ADMIN 권한인지 여부
 *   - isAdminMode : ADMIN이면서 '관리자모드'인지 여부
 *                   (유저경험모드로 전환 시 false)
 *
 * [사용 목적]
 * header.jsp에서 관리자 전용 토글 버튼(관리자모드 / 유저경험모드)을 표시하기 위해
 * 모든 페이지에서 isAdmin, isAdminMode 값이 필요하다.
 * 각 Controller마다 개별적으로 추가하는 대신 인터셉터로 전역 처리한다.
 *
 * [모드 전환]
 * POST /community/admin/viewmode 요청으로 세션의 viewMode 값을 토글한다.
 *   - viewMode = null  → 관리자모드 (기본값)
 *   - viewMode = "user" → 유저경험모드 (일반 유저처럼 보임)
 *
 * [JSP 사용법]
 * 모든 JSP에서 별도 설정 없이 바로 사용 가능:
 *   ${isAdmin}     → 관리자 여부
 *   ${isAdminMode} → 관리자모드 여부 (차단 기능, 관리 버튼 표시 조건)
 *
 * [담당자]
 * Victor (커뮤니티 모듈 담당)
 * =============================================
 */
@Component
public class AdminModeInterceptor implements HandlerInterceptor {

    /**
     * Controller 처리 완료 후, View 렌더링 전에 실행된다.
     * Model에 isAdmin, isAdminMode를 자동으로 추가한다.
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) {
        if (modelAndView == null) return;

        HttpSession session = request.getSession(false);
        if (session == null) return;

        boolean isAdmin = isAdminUser(session);
        // viewMode가 "user"이면 유저경험모드, 그 외(null 포함)는 관리자모드
        String viewMode = (String) session.getAttribute("viewMode");
        boolean isAdminMode = isAdmin && !"user".equals(viewMode);

        modelAndView.addObject("isAdmin", isAdmin);
        modelAndView.addObject("isAdminMode", isAdminMode);
    }

    /**
     * 세션의 loginUser 객체에서 getUserRole()을 호출해 ADMIN 여부를 확인한다.
     * loginUser VO는 auth 담당자가 관리하므로 리플렉션으로 접근한다.
     */
    private boolean isAdminUser(HttpSession session) {
        try {
            Object loginUser = session.getAttribute("loginUser");
            if (loginUser == null) return false;
            Method method = loginUser.getClass().getMethod("getUserRole");
            return "ADMIN".equals(method.invoke(loginUser));
        } catch (Exception e) {
            return false;
        }
    }
}