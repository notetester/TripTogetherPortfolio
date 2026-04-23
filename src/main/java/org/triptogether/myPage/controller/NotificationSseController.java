package org.triptogether.myPage.controller;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.service.NotificationSseService;

/**
 * 알림 SSE 구독 컨트롤러.
 *
 * 브라우저는 {@code new EventSource('/TripTogether/sse/notifications')} 로 구독하며,
 * 연결이 끊기면 기본 3초 간격으로 자동 재연결한다.
 */
@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/sse")
public class NotificationSseController {

    private final NotificationSseService sseService;

    @GetMapping(value = "/notifications", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter subscribe(HttpSession session, HttpServletResponse response) {
        UsersVO user = (UsersVO) session.getAttribute("loginUser");
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return null;
        }

        // Nginx 등 역방향 프록시가 응답을 버퍼링하지 않도록 강제
        response.setHeader("X-Accel-Buffering", "no");
        response.setHeader("Cache-Control", "no-cache");

        return sseService.subscribe(user.getUserIdx());
    }
}
