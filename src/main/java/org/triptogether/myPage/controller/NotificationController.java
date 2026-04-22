package org.triptogether.myPage.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.myPage.vo.FeedNotificationDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/notifications")
public class NotificationController {

    private final MyPageService myPageService;

    // 헤더 드롭다운용 최근 N개
    @GetMapping("/recent")
    public ResponseEntity<Map<String, Object>> recent(
            @RequestParam(defaultValue = "5") int limit,
            HttpSession session) {
        UsersVO user = loginUser(session);
        if (user == null) return unauthorized();

        Map<String, Object> result = new HashMap<>();
        List<FeedNotificationDto> list = myPageService.getRecentNotifications(user.getUserIdx(), limit);
        result.put("success", true);
        result.put("notifications", list);
        return ResponseEntity.ok(result);
    }

    // 전체 알림 목록 (마이페이지 더보기용)
    @GetMapping("/all")
    public ResponseEntity<Map<String, Object>> all(HttpSession session) {
        UsersVO user = loginUser(session);
        if (user == null) return unauthorized();

        Map<String, Object> result = new HashMap<>();
        List<FeedNotificationDto> list = myPageService.getAllNotifications(user.getUserIdx());
        result.put("success", true);
        result.put("notifications", list);
        return ResponseEntity.ok(result);
    }

    // 배지용 안읽음 개수
    @GetMapping("/unread-count")
    public ResponseEntity<Map<String, Object>> unreadCount(HttpSession session) {
        UsersVO user = loginUser(session);
        if (user == null) return unauthorized();

        Map<String, Object> result = new HashMap<>();
        int count = myPageService.getUnreadCount(user.getUserIdx());
        result.put("success", true);
        result.put("count", count);
        return ResponseEntity.ok(result);
    }

    // 개별 읽음 처리 + targetUrl 반환
    @PostMapping("/{notificationId}/read")
    public ResponseEntity<Map<String, Object>> markAsRead(
            @PathVariable Long notificationId,
            HttpSession session) {
        UsersVO user = loginUser(session);
        if (user == null) return unauthorized();

        Map<String, Object> result = new HashMap<>();
        FeedNotificationDto noti = myPageService.getNotification(notificationId);
        if (noti == null) {
            result.put("success", false);
            result.put("message", "알림을 찾을 수 없습니다.");
            return ResponseEntity.status(404).body(result);
        }
        if (!noti.getUserIdx().equals(user.getUserIdx())) {
            result.put("success", false);
            return ResponseEntity.status(403).body(result);
        }

        myPageService.markAsRead(notificationId);
        result.put("success", true);
        result.put("targetUrl", noti.getTargetUrl() != null ? noti.getTargetUrl() : "/mypage");
        return ResponseEntity.ok(result);
    }

    // 전체 읽음 처리
    @PostMapping("/read-all")
    public ResponseEntity<Map<String, Object>> markAllAsRead(HttpSession session) {
        UsersVO user = loginUser(session);
        if (user == null) return unauthorized();

        myPageService.markAllAsRead(user.getUserIdx());
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    // 개별 삭제
    @DeleteMapping("/{notificationId}")
    public ResponseEntity<Map<String, Object>> delete(
            @PathVariable Long notificationId,
            HttpSession session) {
        UsersVO user = loginUser(session);
        if (user == null) return unauthorized();

        Map<String, Object> result = new HashMap<>();
        FeedNotificationDto noti = myPageService.getNotification(notificationId);
        if (noti == null) {
            result.put("success", false);
            return ResponseEntity.status(404).body(result);
        }
        if (!noti.getUserIdx().equals(user.getUserIdx())) {
            result.put("success", false);
            return ResponseEntity.status(403).body(result);
        }

        myPageService.deleteNotification(notificationId);
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    // 전체 삭제
    @DeleteMapping
    public ResponseEntity<Map<String, Object>> deleteAll(HttpSession session) {
        UsersVO user = loginUser(session);
        if (user == null) return unauthorized();

        myPageService.deleteAllNotifications(user.getUserIdx());
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    // ===== helpers =====
    private UsersVO loginUser(HttpSession session) {
        return (UsersVO) session.getAttribute("loginUser");
    }

    private ResponseEntity<Map<String, Object>> unauthorized() {
        Map<String, Object> result = new HashMap<>();
        result.put("success", false);
        result.put("message", "로그인이 필요합니다.");
        return ResponseEntity.status(401).body(result);
    }
}
