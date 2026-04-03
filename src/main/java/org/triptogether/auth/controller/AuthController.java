package org.triptogether.auth.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.service.AuthService;
import org.triptogether.auth.vo.LoginRequestContext;
import org.triptogether.auth.vo.SocialTempVO;
import org.triptogether.auth.vo.UsersVO;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/auth")
public class AuthController {

    private final AuthService authService;

    // ════════════════════════════════════════════
    // 로그인 페이지
    // ════════════════════════════════════════════

    @GetMapping("/login")
    public String loginPage(HttpSession session, Model model,@ModelAttribute("errorMsg") String errorMsg) {
        // 이미 로그인 중이면 홈으로
        if (session.getAttribute("loginUser") != null) return "redirect:/";

        // 소셜 로그인용 state (CSRF 방지)
        String state = UUID.randomUUID().toString();
        session.setAttribute("oauthState", state);

        model.addAttribute("kakaoAuthUrl", authService.getKakaoAuthUrl(false));
        model.addAttribute("naverAuthUrl",  authService.getNaverAuthUrl(state, false));
        model.addAttribute("googleAuthUrl", authService.getGoogleAuthUrl(state, false));
        return "auth/login";
    }

    // ════════════════════════════════════════════
    // 로그인 처리 (Ajax JSON 응답)
    // ════════════════════════════════════════════

    @PostMapping("/login")
    @ResponseBody
    public Map<String, Object> loginProcess(
            @RequestParam String identifier,
            @RequestParam String password,
            HttpServletRequest request,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .build();

        UsersVO user = authService.login(identifier, password, context);
//        UsersVO user = authService.login(identifier, password, request);

        if (user != null) {
            session.setAttribute("loginUser", user);
            result.put("success", true);
            result.put("redirect", request.getContextPath() + "/");
        } else {
            result.put("success", false);
            result.put("message", "아이디(이메일) 또는 비밀번호가 올바르지 않습니다.");
        }
        return result;
    }

    // ════════════════════════════════════════════
    // 로그아웃
    // ════════════════════════════════════════════

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    // ════════════════════════════════════════════
    // 회원가입 페이지
    // ════════════════════════════════════════════

    @GetMapping("/register")
    public String registerPage(HttpSession session) {
        if (session.getAttribute("loginUser") != null) return "redirect:/";
        return "auth/register";
    }

    // ════════════════════════════════════════════
    // 회원가입 처리 (Ajax JSON 응답)
    // ════════════════════════════════════════════

    @PostMapping("/register")
    @ResponseBody
    public Map<String, Object> registerProcess(
            @RequestParam String userId,
            @RequestParam(required = false) String userEmail,
            @RequestParam String password,
            @RequestParam String nickname,
            @RequestParam String nationality,
            @RequestParam String preferredLang,
            HttpServletRequest request,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        // 중복 체크
        if (authService.isUserIdDuplicate(userId)) {
            result.put("success", false); result.put("field", "userId");
            result.put("message", "이미 사용 중인 아이디입니다."); return result;
        }
        if (userEmail != null && !userEmail.isBlank() && authService.isEmailDuplicate(userEmail)) {
            result.put("success", false); result.put("field", "userEmail");
            result.put("message", "이미 사용 중인 이메일입니다."); return result;
        }
        if (authService.isNicknameDuplicate(nickname)) {
            result.put("success", false); result.put("field", "nickname");
            result.put("message", "이미 사용 중인 닉네임입니다."); return result;
        }

        UsersVO newUser = UsersVO.builder()
                .userId(userId)
                .userEmail(userEmail != null && !userEmail.isBlank() ? userEmail : null)
                .userPassword(password)
                .nickname(nickname)
                .nationality(nationality)
                .preferredLang(preferredLang)
                .build();

        authService.register(newUser);
        session.setAttribute("loginUser", newUser);

        result.put("success", true);
        result.put("redirect", request.getContextPath() + "/");
        return result;
    }

    // ════════════════════════════════════════════
    // 중복 체크 API (Ajax)
    // ════════════════════════════════════════════

    @GetMapping("/check/userId")
    @ResponseBody
    public Map<String, Boolean> checkUserId(@RequestParam String value) {
        return Map.of("duplicate", authService.isUserIdDuplicate(value));
    }

    @GetMapping("/check/email")
    @ResponseBody
    public Map<String, Boolean> checkEmail(@RequestParam String value) {
        return Map.of("duplicate", authService.isEmailDuplicate(value));
    }

    @GetMapping("/check/nickname")
    @ResponseBody
    public Map<String, Boolean> checkNickname(@RequestParam String value) {
        return Map.of("duplicate", authService.isNicknameDuplicate(value));
    }

    // ════════════════════════════════════════════
    // 아이디 찾기
    // ════════════════════════════════════════════
    @GetMapping("/find-id")
    public String findIdPage() { return "auth/find-id"; }

    @PostMapping("/find-id/send")
    @ResponseBody
    public Map<String, Object> sendFindId(@RequestParam String email) {
        authService.sendFindIdEmail(email);
        // 보안상 이메일 존재 여부 노출 안 함
        return Map.of("success", true, "message", "해당 이메일로 아이디 확인 링크를 발송했습니다.");
    }

    @GetMapping("/find-id/verify")
    public String verifyFindId(@RequestParam String token, Model model) {
        String userId = authService.verifyFindIdToken(token);
        if (userId == null) {
            model.addAttribute("error", "링크가 만료되었거나 유효하지 않습니다.");
        } else {
            model.addAttribute("foundUserId", userId);
        }
        return "auth/find-id-result";
    }

    // ════════════════════════════════════════════
    // 비밀번호 찾기 / 재설정
    // ════════════════════════════════════════════
    @GetMapping("/find-pw")
    public String findPwPage() { return "auth/find-pw"; }

    @PostMapping("/find-pw/send")
    @ResponseBody
    public Map<String, Object> sendResetPw(@RequestParam String identifier) {
        authService.sendResetPasswordEmail(identifier);
        return Map.of("success", true, "message", "비밀번호 재설정 링크를 이메일로 발송했습니다.");
    }

    @GetMapping("/reset-pw")
    public String resetPwPage(@RequestParam String token, Model model) {
        UsersVO user = authService.verifyResetToken(token);
        if (user == null) {
            model.addAttribute("error", "링크가 만료되었거나 유효하지 않습니다.");
        } else {
            model.addAttribute("token", token);
            model.addAttribute("nickname", user.getNickname());
        }
        return "auth/reset-pw";
    }

    @PostMapping("/reset-pw")
    @ResponseBody
    public Map<String, Object> doResetPw(@RequestParam String token,
                                         @RequestParam String newPassword) {
        boolean ok = authService.resetPassword(token, newPassword);
        if (ok) return Map.of("success", true, "redirect", "/auth/login");
        return Map.of("success", false, "message", "링크가 만료되었습니다. 다시 시도해주세요.");
    }

    // ════════════════════════════════════════════
    // 이메일 인증 (링크 클릭)
    // ════════════════════════════════════════════
    @GetMapping("/verify-email")
    public String verifyEmail(@RequestParam String token, Model model) {
        boolean ok = authService.verifyEmail(token);
        model.addAttribute("success", ok);
        if (!ok) model.addAttribute("error", "링크가 만료되었거나 유효하지 않습니다.");
        return "auth/verify-email-result";
    }

    // ════════════════════════════════════════════
    // 카카오 OAuth
    // ════════════════════════════════════════════

    @GetMapping("/kakao")
    public String kakaoLogin(HttpSession session) {
        String state = UUID.randomUUID().toString();
        session.setAttribute("oauthState", state);
        return "redirect:" + authService.getKakaoAuthUrl(false);
    }

    @GetMapping("/kakao/callback")
    public String kakaoCallback(@RequestParam String code,
                                 HttpServletRequest request, HttpSession session,
                                 RedirectAttributes ra) {
        return handleSocialCallback(authService.handleKakaoCallback(code, request),
                session, request, ra);
    }

    // ════════════════════════════════════════════
    // 네이버 OAuth
    // ════════════════════════════════════════════

    @GetMapping("/naver")
    public String naverLogin(HttpSession session) {
        String state = UUID.randomUUID().toString();
        session.setAttribute("oauthState", state);
        return "redirect:" + authService.getNaverAuthUrl(state,false);
    }

    @GetMapping("/naver/callback")
    public String naverCallback(@RequestParam String code,
                                 @RequestParam String state,
                                 HttpServletRequest request, HttpSession session,
                                 RedirectAttributes ra) {
        // state 검증
        String savedState = (String) session.getAttribute("oauthState");
        if (savedState == null || !savedState.equals(state)) {
            ra.addFlashAttribute("errorMsg", "잘못된 접근입니다.");
            return "redirect:/auth/login";
        }
        return handleSocialCallback(authService.handleNaverCallback(code, state, request),
                session, request, ra);
    }

    // ════════════════════════════════════════════
    // 구글 OAuth
    // ════════════════════════════════════════════

    @GetMapping("/google")
    public String googleLogin(HttpSession session) {
        String state = UUID.randomUUID().toString();
        session.setAttribute("oauthState", state);
        return "redirect:" + authService.getGoogleAuthUrl(state,false);
    }

    @GetMapping("/google/callback")
    public String googleCallback(@RequestParam String code,
                                  @RequestParam(required = false) String state,
                                  HttpServletRequest request, HttpSession session,
                                  RedirectAttributes ra) {
        return handleSocialCallback(authService.handleGoogleCallback(code, request),
                session, request, ra);
    }

    // ════════════════════════════════════════════
    // 소셜 연동 (LINK 모드 - 마이페이지에서 시작)
    // ════════════════════════════════════════════
    @GetMapping("/link/kakao")
    public String linkKakao(HttpSession session) {
        requireLogin(session);
        return "redirect:" + authService.getKakaoAuthUrl(true);
    }

    @GetMapping("/link/naver")
    public String linkNaver(HttpSession session) {
        requireLogin(session);
        String state = UUID.randomUUID().toString();
        session.setAttribute("oauthState", state);
        return "redirect:" + authService.getNaverAuthUrl(state, true);
    }

    @GetMapping("/link/google")
    public String linkGoogle(HttpSession session) {
        requireLogin(session);
        String state = UUID.randomUUID().toString();
        session.setAttribute("oauthState", state);
        return "redirect:" + authService.getGoogleAuthUrl(state, true);
    }

    // 연동 콜백
    @GetMapping("/link/kakao/callback")
    public String linkKakaoCallback(@RequestParam String code, HttpSession session, RedirectAttributes ra) {
        return handleLinkCallback("KAKAO", () -> authService.extractKakaoInfo(code), session, ra);
    }

    @GetMapping("/link/naver/callback")
    public String linkNaverCallback(@RequestParam String code, @RequestParam String state,
                                    HttpSession session, RedirectAttributes ra) {
        return handleLinkCallback("NAVER", () -> authService.extractNaverInfo(code, state), session, ra);
    }

    @GetMapping("/link/google/callback")
    public String linkGoogleCallback(@RequestParam String code, HttpSession session, RedirectAttributes ra) {
        return handleLinkCallback("GOOGLE", () -> authService.extractGoogleInfo(code), session, ra);
    }

    // 소셜 해제 (Ajax)
    @PostMapping("/unlink")
    @ResponseBody
    public Map<String, Object> unlinkSocial(@RequestParam String provider, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        if (loginUser == null) { result.put("success", false); result.put("message", "로그인이 필요합니다."); return result; }
        try {
            authService.unlinkSocial(loginUser.getUserIdx(), provider);
            result.put("success", true);
        } catch (IllegalStateException e) {
            result.put("success", false); result.put("message", e.getMessage());
        }
        return result;
    }

    // ════════════════════════════════════════════
    // 소셜 신규 회원 추가 정보 입력 페이지
    // ════════════════════════════════════════════

    @GetMapping("/social/complete")
    public String socialCompletePage(HttpSession session, Model model) {
        SocialTempVO temp = (SocialTempVO) session.getAttribute("socialTemp");
        if (temp == null) return "redirect:/auth/login";
        model.addAttribute("socialTemp", temp);
        return "auth/social-complete";
    }

    @PostMapping("/social/complete")
    @ResponseBody
    public Map<String, Object> socialCompleteProcess(
            @RequestParam String nickname,
            @RequestParam String nationality,
            @RequestParam String preferredLang,
            HttpServletRequest request,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        SocialTempVO temp = (SocialTempVO) session.getAttribute("socialTemp");

        if (temp == null) {
            result.put("success", false);
            result.put("message", "세션이 만료되었습니다. 다시 시도해주세요.");
            return result;
        }
        if (authService.isNicknameDuplicate(nickname)) {
            result.put("success", false); result.put("field", "nickname");
            result.put("message", "이미 사용 중인 닉네임입니다."); return result;
        }

        UsersVO user = authService.completeSocialRegister(temp, nickname, nationality, preferredLang, request);
        session.removeAttribute("socialTemp");
        session.setAttribute("loginUser", user);

        result.put("success", true);
        result.put("redirect", request.getContextPath() + "/");
        return result;
    }

    // ════════════════════════════════════════════
    // 소셜 콜백 공통 분기 처리
    // ════════════════════════════════════════════
    private String handleSocialCallback(Object socialResult, HttpSession session,
                                         HttpServletRequest request, RedirectAttributes ra) {
        if (socialResult == null) {
            ra.addFlashAttribute("errorMsg", "소셜 로그인 처리 중 오류가 발생했습니다.");
            return "redirect:/auth/login";
        }
        if (socialResult instanceof UsersVO user) {
            // 기존 회원 → 바로 로그인
            session.setAttribute("loginUser", user);
            return "redirect:/";
        }
        if (socialResult instanceof SocialTempVO temp) {
            // 신규 회원 → 추가 정보 입력 페이지
            session.setAttribute("socialTemp", temp);
            return "redirect:/auth/social/complete";
        }
        ra.addFlashAttribute("errorMsg", "알 수 없는 오류가 발생했습니다.");
        return "redirect:/auth/login";
    }

    // ════════════════════════════════════════════
    // 내부 유틸
    // ════════════════════════════════════════════
    private String handleLoginCallback(Object socialResult, HttpSession session,
                                       HttpServletRequest request, RedirectAttributes ra) {
        if (socialResult instanceof UsersVO user) {
            session.setAttribute("loginUser", user); return "redirect:/";
        }
        if (socialResult instanceof SocialTempVO temp) {
            session.setAttribute("socialTemp", temp); return "redirect:/auth/social/complete";
        }
        ra.addFlashAttribute("errorMsg", "소셜 로그인 중 오류가 발생했습니다.");
        return "redirect:/auth/login";
    }

    @FunctionalInterface
    interface InfoExtractor { String[] extract() throws Exception; }

    private String handleLinkCallback(String provider, InfoExtractor extractor,
                                      HttpSession session, RedirectAttributes ra) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/auth/login";
        try {
            String[] info = extractor.extract();
            authService.linkSocial(loginUser.getUserIdx(), provider, info[0]);
            ra.addFlashAttribute("successMsg", provider + " 계정이 연동되었습니다.");
        } catch (IllegalStateException e) {
            ra.addFlashAttribute("errorMsg", e.getMessage());
        } catch (Exception e) {
            log.error("[{}] 연동 콜백 오류", provider, e);
            ra.addFlashAttribute("errorMsg", "소셜 연동 중 오류가 발생했습니다.");
        }
        return "redirect:/mypage/edit";
    }

    private void requireLogin(HttpSession session) {
        if (session.getAttribute("loginUser") == null)
            throw new IllegalStateException("로그인이 필요합니다.");
    }

    private Map<String, Object> err(Map<String, Object> r, String field, String msg) {
        r.put("success", false); r.put("field", field); r.put("message", msg); return r;
    }

    private String getClientIp(HttpServletRequest request) {
        // 프록시/로드밸런서 환경 고려 (실무 필수)
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

        // 여러 IP가 들어올 경우 첫 번째 값만 사용
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }

        return ip;
    }
}
