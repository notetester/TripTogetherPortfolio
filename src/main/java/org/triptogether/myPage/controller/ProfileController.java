package org.triptogether.myPage.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.service.AuthServiceImpl;
import org.triptogether.auth.vo.LoginRequestContext;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.service.MyPageService;

import java.util.HashMap;
import java.util.Map;

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

        Map<String, Boolean> socialLinkMap = authService.getSocialLinkMap(freshUser.getUserIdx());
        long socialCount = socialLinkMap.values().stream().filter(Boolean::booleanValue).count();

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
        boolean sent = authService.sendEmailVerification(user.getUserIdx(), email, buildRequestContext(request));
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
    public Map<String, Object> checkEmailLoginToggle(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        return authService.checkEmailLoginAvailability(user.getUserIdx());
    }

    // ── 로컬 로그인 수단 저장 ─────────────────────
    @PostMapping("/edit/login-settings")
    @ResponseBody
    public Map<String, Object> saveLoginSettings(@RequestParam(required = false) String userId,
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
            UsersVO after = authService.saveLoginSettings(loginUser.getUserIdx(), userId, emailLoginEnabled, newPassword, buildRequestContext(request));
            session.setAttribute("loginUser", after);

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
        return "redirect:/mypage";
    }

    // ── 마이페이지 메인 ──────────────────────────
    @GetMapping("")
    public String myPage(HttpSession session, Model model) {
        UsersVO user = loginUser(session);
        if (user == null) return "redirect:/auth/login";

        model.addAttribute("user",           user);
        model.addAttribute("communityList",  myPageService.getMyCommunityList(user.getUserIdx()));
        model.addAttribute("communityCount", myPageService.getMyCommunityCount(user.getUserIdx()));
        model.addAttribute("inquiryList",    myPageService.getMyInquiryList(user.getUserIdx()));
        model.addAttribute("inquiryCount",   myPageService.getMyInquiryCount(user.getUserIdx()));
        return "mypage/index";
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
