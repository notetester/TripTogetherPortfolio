package org.triptogether.myPage.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.service.AuthServiceImpl;
import org.triptogether.auth.vo.LoginRequestContext;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.myPage.vo.FeedNotificationDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
public class ProfileController {

    private final AuthServiceImpl authService;
    private final MyPageService myPageService;

    // ── 수정 전 비밀번호 확인 페이지 ──────────────
    @GetMapping("/edit-confirm")
    public String editConfirmPage(HttpSession session) {
        UsersVO user = loginUser(session);
        if (user == null) return "redirect:/auth/login";
        // 비밀번호 없는 계정(소셜 전용)은 바로 수정 페이지로
        if (!user.isPasswordEnabled()) return "redirect:/mypage/edit";
        return "mypage/edit-confirm";
    }

    @PostMapping("/edit-confirm")
    @ResponseBody
    public Map<String, Object> checkPassword(@RequestParam String password,
                                             HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) { result.put("success", false); result.put("message", "로그인이 필요합니다."); return result; }

        if (authService.checkPassword(user.getUserIdx(), password)) {
            session.setAttribute("editVerified", true);
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("message", "비밀번호가 올바르지 않습니다.");
        }
        return result;
    }

    // ── 회원정보 수정 페이지 ──────────────────────
    @GetMapping("/edit")
    public String editPage(HttpSession session, Model model) {
        UsersVO user = loginUser(session);
        if (user == null) return "redirect:/auth/login";

        // 항상 최신 사용자 정보를 DB에서 다시 조회
        UsersVO freshUser = authService.getUserByIdx(user.getUserIdx());
        if (freshUser == null) {
            session.invalidate();
            return "redirect:/auth/login";
        }

        // 비밀번호 있는 계정은 확인 절차 거쳤는지 체크
        if (freshUser.isPasswordEnabled() && !Boolean.TRUE.equals(session.getAttribute("editVerified"))) {
            return "redirect:/mypage/edit-confirm";
        }

        // 세션도 최신값으로 갱신
        session.setAttribute("loginUser", freshUser);

        String profileEmailRequestId = (String) session.getAttribute("profileEmailRequestId");
        if (profileEmailRequestId == null || profileEmailRequestId.isBlank()) {
            profileEmailRequestId = UUID.randomUUID().toString();
            session.setAttribute("profileEmailRequestId", profileEmailRequestId);
        }

        Map<String, Boolean> socialLinkMap = authService.getSocialLinkMap(freshUser.getUserIdx());
        long socialCount = socialLinkMap.values().stream().filter(Boolean::booleanValue).count();

        model.addAttribute("profileEmailRequestId", profileEmailRequestId);
        model.addAttribute("user", freshUser);
        model.addAttribute("socialLinkMap", socialLinkMap);
        model.addAttribute("socialCount", socialCount);
        model.addAttribute("hasUsableIdLogin", freshUser.getUserId() != null && !freshUser.getUserId().isBlank() && freshUser.isPasswordEnabled());
        model.addAttribute("hasUsableEmailLogin", freshUser.getUserEmail() != null && !freshUser.getUserEmail().isBlank()
                && freshUser.isEmailVerified() && freshUser.isEmailLoginEnabled() && freshUser.isPasswordEnabled());
        return "mypage/edit";
    }


    // ── 기본 프로필 수정 ──────────────────────────
    @PostMapping("/edit/profile")
    @ResponseBody
    public Map<String, Object> updateProfile(
            @RequestParam String nickname,
            @RequestParam String nationality,
            @RequestParam String preferredLang,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) { result.put("success", false); return result; }

        if (!nickname.equals(user.getNickname()) && authService.isNicknameDuplicate(nickname)) {
            result.put("success", false); result.put("field", "nickname");
            result.put("message", "이미 사용 중인 닉네임입니다."); return result;
        }

        UsersVO update = UsersVO.builder()
                .userIdx(user.getUserIdx())
                .nickname(nickname).nationality(nationality).preferredLang(preferredLang)
                .build();
        authService.updateProfile(update);

        // 세션 갱신
        user.setNickname(nickname); user.setNationality(nationality); user.setPreferredLang(preferredLang);
        result.put("success", true); result.put("message", "프로필이 수정되었습니다.");
        return result;
    }

    // ── 비밀번호 변경 ─────────────────────────────
    @PostMapping("/edit/password")
    @ResponseBody
    public Map<String, Object> updatePassword(
            @RequestParam(required = false) String currentPassword,
            @RequestParam String newPassword,
            HttpServletRequest request,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) { result.put("success", false); return result; }

        if (!user.isPasswordEnabled()) {
            result.put("success", false);
            result.put("message", "비밀번호는 로그인 수단을 추가하는 과정에서 함께 설정해 주세요.");
            return result;
        }

        if (!authService.checkPassword(user.getUserIdx(), currentPassword)) {
            authService.recordPasswordChangeFailure(user.getUserIdx(), buildRequestContext(request), "WRONG_CURRENT_PASSWORD");
            result.put("success", false); result.put("field", "currentPassword");
            result.put("message", "현재 비밀번호가 올바르지 않습니다."); return result;
        }
        if (newPassword.length() < 8) {
            authService.recordPasswordChangeFailure(user.getUserIdx(), buildRequestContext(request), "NEW_PASSWORD_TOO_SHORT");
            result.put("success", false); result.put("message", "새 비밀번호는 8자 이상이어야 합니다."); return result;
        }
        authService.updatePassword(user.getUserIdx(), newPassword, buildRequestContext(request));
        user.setPasswordEnabled(true);
        result.put("success", true); result.put("message", "비밀번호가 변경되었습니다.");
        return result;
    }

    // ── 이메일 인증 메일 발송 ─────────────────────
    @PostMapping("/edit/email/send")
    @ResponseBody
    public Map<String, Object> sendEmailVerification(
            @RequestParam String email,
            HttpServletRequest request,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) { result.put("success", false); return result; }

        if (authService.isEmailDuplicate(email) &&
                (user.getUserEmail() == null || !user.getUserEmail().equals(email))) {
            result.put("success", false); result.put("message", "이미 사용 중인 이메일입니다."); return result;
        }
        String profileEmailRequestId = (String) session.getAttribute("profileEmailRequestId");
        if (profileEmailRequestId == null || profileEmailRequestId.isBlank()) {
            profileEmailRequestId = UUID.randomUUID().toString();
            session.setAttribute("profileEmailRequestId", profileEmailRequestId);
        }

        boolean sent = authService.sendEmailVerification(user.getUserIdx(), profileEmailRequestId, email, buildRequestContext(request));
        if (!sent) {
            result.put("success", false);
            result.put("message", "인증 이메일 발송에 실패했습니다. 잠시 후 다시 시도해주세요.");
            return result;
        }

        result.put("success", true); result.put("message", "인증 이메일을 발송했습니다. 메일을 확인해주세요.");
        return result;
    }

    // ── 이메일 로그인 체크 시점 검증 (실시간 확인용) ─────
    @PostMapping("/edit/email/login-toggle")
    @ResponseBody
    public Map<String, Object> checkEmailLoginToggle(@RequestParam String email, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        String profileEmailRequestId = (String) session.getAttribute("profileEmailRequestId");
        return authService.checkEmailLoginAvailability(user.getUserIdx(), profileEmailRequestId, email);
    }

    @PostMapping("/edit/email/status")
    @ResponseBody
    public Map<String, Object> checkEmailStatus(@RequestParam String email, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        String profileEmailRequestId = (String) session.getAttribute("profileEmailRequestId");
        return authService.checkEmailLoginAvailability(user.getUserIdx(), profileEmailRequestId, email);
    }

    // ── 로컬 로그인 수단 저장 ─────────────────────
    @PostMapping("/edit/login-settings")
    @ResponseBody
    public Map<String, Object> saveLoginSettings(@RequestParam(required = false) String userId,
                                                 @RequestParam(required = false) String email,
                                                 @RequestParam(defaultValue = "false") boolean emailLoginEnabled,
                                                 @RequestParam(required = false) String newPassword,
                                                 HttpServletRequest request,
                                                 HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO loginUser = loginUser(session);
        if (loginUser == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        UsersVO before = authService.getUserByIdx(loginUser.getUserIdx());
        try {
            String profileEmailRequestId = (String) session.getAttribute("profileEmailRequestId");
            UsersVO after = authService.saveLoginSettings(loginUser.getUserIdx(), profileEmailRequestId, userId, email, emailLoginEnabled, newPassword, buildRequestContext(request));
            session.setAttribute("loginUser", after);
            session.setAttribute("profileEmailRequestId", UUID.randomUUID().toString());

            boolean passwordCleared = before != null && before.isPasswordEnabled() && !after.isPasswordEnabled();
            result.put("success", true);
            result.put("userId", after.getUserId());
            result.put("emailLoginEnabled", after.isEmailLoginEnabled());
            result.put("passwordEnabled", after.isPasswordEnabled());
            result.put("passwordCleared", passwordCleared);
            result.put("message", passwordCleared
                    ? "로그인 수단이 변경되었습니다. 현재 사용할 수 있는 로컬 로그인 수단이 없어 비밀번호가 함께 해제되었습니다. 다시 사용하려면 비밀번호를 새로 설정해 주세요."
                    : "로그인 수단 설정이 저장되었습니다.");
        } catch (IllegalStateException e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    // ── 수정 완료 후 확인 세션 제거 ─────────────────
    @PostMapping("/edit/done")
    public String editDone(HttpSession session) {
        session.removeAttribute("editVerified");
        session.removeAttribute("profileEmailRequestId");
        return "redirect:/mypage";
    }

    // ── 마이페이지 메인 ──────────────────────────

    /**
     * 마이페이지 메인 페이지.
     * 커뮤니티/문의/신고 최근 목록·개수, 알림 목록·개수를 모델에 담아 반환한다.
     */
    @GetMapping("")
    public String myPage(HttpSession session, Model model) {
        UsersVO user = loginUser(session);
        if (user == null) return "redirect:/auth/login";

        model.addAttribute("user",           user);
        model.addAttribute("communityList",  myPageService.getMyCommunityList(user.getUserIdx()));
        model.addAttribute("communityCount", myPageService.getMyCommunityCount(user.getUserIdx()));
        model.addAttribute("inquiryList",    myPageService.getMyInquiryList(user.getUserIdx()));
        model.addAttribute("inquiryCount",   myPageService.getMyInquiryCount(user.getUserIdx()));
        model.addAttribute("reportList",     myPageService.getMyReportList(user.getUserIdx()));
        model.addAttribute("reportCount",    myPageService.getMyReportCount(user.getUserIdx()));
        model.addAttribute("notifications", myPageService.getNotifications(user.getUserIdx()));
        model.addAttribute("totalNotificationCount", myPageService.getNotificationCount(user.getUserIdx()));
        return "mypage/index";
    }

    /* =============================================
   POST /mypage/notification/{notificationId}/read - 알림 삭제 및 리다이렉트 URL 반환
   ============================================= */

    /**
     * 알림 클릭 처리.
     * 알림을 삭제하고 연결된 콘텐츠(커뮤니티/문의/신고)의 리다이렉트 URL을 반환한다.
     */
    @PostMapping("/notification/{notificationId}/read")
    @ResponseBody
    public Map<String, Object> deleteNotification(@PathVariable Long notificationId) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 1. 알림 조회 (sourceType, sourceId 확인)
            FeedNotificationDto notification = myPageService.getNotification(notificationId);

            if (notification == null) {
                result.put("success", false);
                result.put("message", "알림을 찾을 수 없습니다.");
                return result;
            }

            // 2. 알림 삭제
            myPageService.deleteNotification(notificationId);

            // 3. redirectUrl 생성
            String redirectUrl = buildRedirectUrl(notification.getSourceType(), notification.getSourceId());

            result.put("success", true);
            result.put("redirectUrl", redirectUrl);
        } catch (Exception e) {
            log.error("알림 삭제 중 오류", e);
            result.put("success", false);
            result.put("message", "오류가 발생했습니다.");
        }
        return result;
    }

    /**
     * sourceType과 sourceId를 기반으로 리다이렉트 URL 생성
     */
    private String buildRedirectUrl(String sourceType, Long sourceId) {
        if ("community".equals(sourceType)) {
            return "/community/" + sourceId;
        } else if ("inquiry".equals(sourceType)) {
            return "/inquiry/" + sourceId;
        } else if ("report".equals(sourceType)) {
            return "/report/" + sourceId;
        }

        return "/mypage";
    }

    /* =============================================
   GET /mypage/notifications/all - 모든 알림 조회 (무제한)
   ============================================= */

    /**
     * 전체 알림 목록 조회 (무제한).
     * 메인에서 최신 10개만 보여주고, 더보기 시 이 API로 전체를 불러온다.
     */
    @GetMapping("/notifications/all")
    @ResponseBody
    public Map<String, Object> getAllNotifications(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) {
            result.put("success", false);
            return result;
        }
        try {
            List<FeedNotificationDto> notifications = myPageService.getAllNotifications(user.getUserIdx());
            result.put("success", true);
            result.put("notifications", notifications);
        } catch (Exception e) {
            result.put("success", false);
        }
        return result;
    }

    /* =============================================
   POST /mypage/notifications/read-all - 모든 알림 삭제
   ============================================= */

    /**
     * 모든 알림 삭제.
     * 해당 유저의 알림을 전부 삭제한다.
     */
    @PostMapping("/notifications/read-all")
    @ResponseBody
    public Map<String, Object> deleteAllNotifications(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) {
            result.put("success", false);
            return result;
        }
        try {
            myPageService.deleteAllNotifications(user.getUserIdx());
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
        }
        return result;
    }

    // ── 유틸 ──────────────────────────────────────
    private LoginRequestContext buildRequestContext(HttpServletRequest request) {
        return LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .build();
    }

    private String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }
        return ip;
    }

    private UsersVO loginUser(HttpSession session) {
        return (UsersVO) session.getAttribute("loginUser");
    }
}
