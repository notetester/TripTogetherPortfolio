package org.triptogether.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.triptogether.auth.vo.UserRole;

import java.lang.reflect.Method;
import java.util.Set;

/**
 * =============================================
 * AdminModeInterceptor - 관리자 모드 전역 인터셉터 설명
 * =============================================
 *
 * [목적]
 * 모든 페이지에서 "이 사람이 관리자인가?" 를 알아야 관리자 모드 전환이 가능함. 그래서 이 인터셉터를 씀
 *
 * [하는일]
 *  모든 페이지 요청 후(postHandle) 자동으로 아래 두 값을 Model에 주입한다.
 *   - isAdmin     : 현재 로그인한 유저가 ADMIN 권한인지 여부
 *   - isAdminMode : ADMIN이면서 '관리자모드'인지 여부
 *                 (유저경험모드로 전환 시 false)
 *
 * [전달하는 값]
 *  - isAdmin     : 관리자면 true, 아니면 false
 *  - isAdminMode : 관리자모드면 true, 유저경험모드면 false
 *
 * [모드 전환 과정]
 * 헤더의 토글 버튼 클릭
 *  → POST /community/admin/viewmode 호출
 *  → 세션에 viewMode 값 저장
 *    - viewMode = null  → 관리자모드 (기본값)
 *    - viewMode = "user" → 유저경험모드
 *
 *  [JSP에서 사용법]
 *  모든 JSP에서 그냥 바로 쓰면 됨:
 *    ${isAdmin}     → 관리자 여부
 *    ${isAdminMode} → 현재 관리자모드 여부
 *
 *  [예시]
 *  <%-- 관리자모드일때만 차단 뱃지 보이게 --%>
 * <c:if test="${isAdminMode}">
 *     <span class="blocked-badge">🚫 차단된 게시글</span>
 * </c:if>
 *
 *  [담당자] Victor (커뮤니티 모듈)
 *  =============================================
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

        if (isAdmin) {
            @SuppressWarnings("unchecked")
            Set<String> perms = (Set<String>) session.getAttribute("adminPermissions");
            if (perms == null) perms = Set.of();
            boolean isSuperAdmin = perms.contains("SUPER_ADMIN");
            boolean hasUserBlockAdmin = isSuperAdmin || perms.contains("USER_BLOCK_ADMIN");
            boolean hasIpBlockAdmin = isSuperAdmin || perms.contains("IP_BLOCK_ADMIN");
            boolean hasBlockPolicyAdmin = isSuperAdmin || perms.contains("BLOCK_POLICY_ADMIN");
            boolean hasBlockAuditAdmin = isSuperAdmin || perms.contains("BLOCK_AUDIT_ADMIN");

            modelAndView.addObject("hasCommunityAdmin", isSuperAdmin || perms.contains("COMMUNITY_ADMIN"));
            modelAndView.addObject("hasMemberAdmin",    isSuperAdmin || perms.contains("MEMBER_ADMIN"));
            modelAndView.addObject("hasReportAdmin",    isSuperAdmin || perms.contains("REPORT_ADMIN"));
            modelAndView.addObject("hasInquiryAdmin",   isSuperAdmin || perms.contains("INQUIRY_ADMIN"));
            modelAndView.addObject("hasExploreAdmin",   isSuperAdmin || perms.contains("EXPLORE_ADMIN"));
            modelAndView.addObject("hasAuditAdmin",     isSuperAdmin || perms.contains("AUDIT_ADMIN"));
            modelAndView.addObject("hasContentModerationAdmin", isSuperAdmin || perms.contains("CONTENT_MODERATION_ADMIN"));
            modelAndView.addObject("hasUserBlockAdmin", hasUserBlockAdmin);
            modelAndView.addObject("hasIpBlockAdmin", hasIpBlockAdmin);
            modelAndView.addObject("hasBlockPolicyAdmin", hasBlockPolicyAdmin);
            modelAndView.addObject("hasBlockAuditAdmin", hasBlockAuditAdmin);
            modelAndView.addObject("hasAnyBlockAdmin", hasUserBlockAdmin || hasIpBlockAdmin || hasBlockPolicyAdmin || hasBlockAuditAdmin);
        }
    }

    /**
     * 세션의 loginUser 객체에서 getUserRole()을 호출해 관리자 계열 여부를 확인한다.
     * loginUser VO는 auth 담당자가 관리하므로 리플렉션으로 접근한다.
     */
    private boolean isAdminUser(HttpSession session) {
        try {
            Object loginUser = session.getAttribute("loginUser");
            if (loginUser == null) return false;
            Method method = loginUser.getClass().getMethod("getUserRole");
            return UserRole.from(String.valueOf(method.invoke(loginUser))).isAdminLike();
        } catch (Exception e) {
            return false;
        }
    }
}
