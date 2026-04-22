package org.triptogether.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.myPage.vo.FeedNotificationDto;

import java.util.List;

/**
 * 헤더 알림 벨에 필요한 데이터(안읽음 개수, 최근 알림 목록)를
 * 모든 페이지의 Model에 주입한다.
 *
 * 주입되는 키:
 *  - headerUnreadCount         : 안읽은 알림 개수 (int)
 *  - headerRecentNotifications : 최근 5개 알림 (List&lt;FeedNotificationDto&gt;)
 *
 * 비로그인 시에는 주입하지 않는다. View가 없는 AJAX 응답에도 영향 없음.
 */
@Component
@RequiredArgsConstructor
public class NotificationInterceptor implements HandlerInterceptor {

    private static final int RECENT_LIMIT = 5;

    private final MyPageService myPageService;

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) {
        if (modelAndView == null) return;

        HttpSession session = request.getSession(false);
        if (session == null) return;

        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        if (loginUser == null) return;

        Long userIdx = loginUser.getUserIdx();
        int unreadCount = myPageService.getUnreadCount(userIdx);
        List<FeedNotificationDto> recent = myPageService.getRecentNotifications(userIdx, RECENT_LIMIT);

        modelAndView.addObject("headerUnreadCount", unreadCount);
        modelAndView.addObject("headerRecentNotifications", recent);
    }
}
