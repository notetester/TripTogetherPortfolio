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
    public String loginPage(HttpSession session, Model model) {
        // 이미 로그인 중이면 홈으로
        if (session.getAttribute("loginUser") != null) return "redirect:/";

        // 소셜 로그인용 state (CSRF 방지)
        String state = UUID.randomUUID().toString();
        session.setAttribute("oauthState", state);

        model.addAttribute("naverAuthUrl", authService.getNaverAuthUrl(state));
        model.addAttribute("kakaoAuthUrl", authService.getKakaoAuthUrl());
        model.addAttribute("googleAuthUrl", authService.getGoogleAuthUrl(state));
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
        UsersVO user = authService.login(identifier, password, request);

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
    // 카카오 OAuth
    // ════════════════════════════════════════════

    @GetMapping("/kakao")
    public String kakaoLogin(HttpSession session) {
        String state = UUID.randomUUID().toString();
        session.setAttribute("oauthState", state);
        return "redirect:" + authService.getKakaoAuthUrl();
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
        return "redirect:" + authService.getNaverAuthUrl(state);
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
        return "redirect:" + authService.getGoogleAuthUrl(state);
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
}
