package org.triptogether.auth.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.service.AuthService;
import org.triptogether.auth.vo.LoginRequestContext;
import org.triptogether.auth.vo.SocialEmailNoticeVO;
import org.triptogether.auth.vo.SocialTempVO;
import org.triptogether.auth.vo.UserRole;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.config.ActivityLogInterceptor;
import org.triptogether.superAdmin.mapper.SuperAdminMapper;
import org.triptogether.superAdmin.vo.SuperAdminPermissionVO;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.Callable;
import java.util.stream.Collectors;

/**
 * 인증 관련 진입점 컨트롤러.
 *
 * <p>역할:</p>
 * <ul>
 *     <li>일반 로그인 / 로그아웃 / 회원가입</li>
 *     <li>아이디 찾기 / 비밀번호 재설정</li>
 *     <li>이메일 인증</li>
 *     <li>카카오 / 네이버 / 구글 OAuth 로그인 및 연동</li>
 * </ul>
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/auth")
public class AuthController {

    private static final String CURRENT_SOCIAL_PROVIDER_SESSION_KEY = "currentSocialProvider";
    private static final String CURRENT_SOCIAL_ACCESS_TOKEN_SESSION_KEY = "currentSocialAccessToken";
    private static final String SOCIAL_ACCESS_TOKEN_REQUEST_KEY = "socialAccessToken";
    private static final String LOGOUT_FLOW_TRACE_SESSION_KEY = "logoutFlowTraceId";
    private static final String LOGOUT_PROVIDER_SESSION_KEY = "logoutProvider";
    private static final String LOGOUT_CALLBACK_URI_SESSION_KEY = "logoutCallbackUri";
    private static final String LOGOUT_FAIL_REASON_SESSION_KEY = "logoutFailReason";

    private final AuthService authService;
    private final SuperAdminMapper superAdminMapper;
    private final RuntimeSettingService runtimeSettingService;

    @Value("${oauth.kakao.logout-redirect-uri:}")
    private String kakaoLogoutRedirectUri;

    @Value("${oauth.naver.logout-redirect-uri:}")
    private String naverLogoutRedirectUri;

    @Value("${oauth.google.logout-redirect-uri:}")
    private String googleLogoutRedirectUri;

    // ════════════════════════════════════════════
    // 로그인 페이지
    // ════════════════════════════════════════════

    /**
     * 로그인 화면 진입.
     *
     * <p>redirect 파라미터가 있으면 로그인 성공 후 해당 경로로 이동한다.</p>
     */
    @GetMapping("/login")
    public String loginPage(HttpSession session,
                            Model model,
                            @ModelAttribute("errorMsg") String errorMsg,
                            @RequestParam(value = "redirect", required = false) String redirect) {

        if (session.getAttribute("loginUser") != null) {
            return "redirect:/";
        }

        model.addAttribute("redirect", safeRedirect(redirect));
        model.addAttribute("errorMsg", errorMsg);
        prepareSocialAuthUrls(session, model);
        return "auth/login";
    }

    // ════════════════════════════════════════════
    // 로그인 처리 (Ajax JSON 응답)
    // ════════════════════════════════════════════

    @PostMapping("/login")
    @ResponseBody
    public Map<String, Object> loginProcess(@RequestParam String identifier,
                                            @RequestParam String password,
                                            @RequestParam(value = "redirect", required = false) String redirect,
                                            HttpServletRequest request,
                                            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        LoginRequestContext context = buildRequestContext(request, session, request.getRequestURI(), null, null);

        UsersVO user = authService.login(identifier, password, context);
        if (user == null) {
            result.put("success", false);
            result.put("message", hasText(context.getLoginRiskMessage())
                    ? context.getLoginRiskMessage()
                    : "아이디(이메일) 또는 비밀번호가 올바르지 않습니다.");
            if (context.getRemainingAttempts() != null) {
                result.put("remainingAttempts", context.getRemainingAttempts());
            }
            if (context.isLoginRiskDenied()) {
                result.put("loginRiskDenied", true);
            }
            if (context.isLoginRiskReviewRequired()) {
                result.put("loginRiskReviewRequired", true);
            }
            return result;
        }

        if ("DORMANT".equals(user.getAccountStatus())) {
            session.setAttribute("dormantPendingUserIdx", user.getUserIdx());
            result.put("success", false);
            result.put("dormantReleaseRequired", true);
            result.put("message", "휴면 계정입니다. 휴면을 해제한 뒤 로그인할 수 있습니다.");
            return result;
        }

        if ("BLOCKED".equals(user.getAccountStatus())) {
            result.put("success", false);
            result.put("blocked", true);
            result.put("message", user.getBlockedReason() != null && !user.getBlockedReason().isBlank()
                    ? "차단된 계정입니다. 사유: " + user.getBlockedReason()
                    : "차단된 계정입니다.");
            if (user.getBlockedUntil() != null) {
                result.put("blockedUntil", user.getBlockedUntil().toString());
            }
            return result;
        }

        session.setAttribute("loginUser", user);
        clearSocialSession(session);
        loadAdminPermissions(session, user);
        result.put("success", true);
        result.put("redirect", resolveLoginRedirect(request, safeRedirect(redirect)));
        return result;
    }

    @PostMapping("/dormant/release")
    @ResponseBody
    public Map<String, Object> releaseDormant(HttpServletRequest request, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        Long userIdx = (Long) session.getAttribute("dormantPendingUserIdx");
        if (userIdx == null) {
            result.put("success", false);
            result.put("message", "휴면 해제 대상 계정이 없습니다.");
            return result;
        }
        UsersVO released = authService.releaseDormantUser(userIdx, LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .build());
        session.removeAttribute("dormantPendingUserIdx");
        session.setAttribute("loginUser", released);
        loadAdminPermissions(session, released);
        result.put("success", true);
        result.put("redirect", request.getContextPath() + "/");
        return result;
    }

    // ════════════════════════════════════════════
    // 로그아웃
    // ════════════════════════════════════════════

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        String currentSocialProvider = (String) session.getAttribute(CURRENT_SOCIAL_PROVIDER_SESSION_KEY);
        if ("KAKAO".equals(currentSocialProvider)) {
            String flowTraceId = prepareLogoutFlow(session, "KAKAO", kakaoLogoutRedirectUri());
            applyLogoutActivityContext(request, session, loginUser, "KAKAO", flowTraceId, "LOGOUT_KAKAO_ENTRY");
            return "redirect:/auth/kakao/logout";
        }
        if ("NAVER".equals(currentSocialProvider)) {
            String flowTraceId = prepareLogoutFlow(session, "NAVER", naverLogoutRedirectUri());
            applyLogoutActivityContext(request, session, loginUser, "NAVER", flowTraceId, "LOGOUT_NAVER_ENTRY");
            return "redirect:/auth/naver/logout";
        }
        if ("GOOGLE".equals(currentSocialProvider)) {
            String flowTraceId = prepareLogoutFlow(session, "GOOGLE", googleLogoutRedirectUri());
            applyLogoutActivityContext(request, session, loginUser, "GOOGLE", flowTraceId, "LOGOUT_GOOGLE_ENTRY");
            return "redirect:/auth/google/logout";
        }

        String flowTraceId = UUID.randomUUID().toString();
        applyLogoutActivityContext(request, session, loginUser, "LOCAL", flowTraceId, "LOGOUT_LOCAL");
        authService.recordLogoutHistory(
                loginUser,
                "LOCAL",
                true,
                null,
                buildRequestContext(request, session, request.getRequestURI(), null, flowTraceId)
        );
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/kakao/logout")
    public String kakaoLogout(HttpServletRequest request, HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        String flowTraceId = prepareLogoutFlow(session, "KAKAO", kakaoLogoutRedirectUri());
        applyLogoutActivityContext(request, session, loginUser, "KAKAO", flowTraceId, "LOGOUT_KAKAO_REQUEST");
        String state = UUID.randomUUID().toString();
        session.setAttribute("kakaoLogoutState", state);
        return "redirect:" + authService.getKakaoLogoutUrl(state);
    }

    @GetMapping("/kakao/logout/callback")
    public String kakaoLogoutCallback(@RequestParam(required = false) String state,
                                      HttpServletRequest request,
                                      HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        String flowTraceId = getLogoutFlowTraceId(session);
        applyLogoutActivityContext(request, session, loginUser, "KAKAO", flowTraceId, "LOGOUT_KAKAO_CALLBACK");
        String savedState = (String) session.getAttribute("kakaoLogoutState");
        String failReason = null;

        if (savedState != null && state != null && !savedState.equals(state)) {
            log.warn("[Kakao Logout] state mismatch. saved={}, received={}", savedState, state);
            failReason = "STATE_MISMATCH";
        }

        session.removeAttribute("kakaoLogoutState");
        authService.recordLogoutHistory(
                loginUser,
                "KAKAO",
                failReason == null,
                failReason,
                buildRequestContext(request, session, request.getRequestURI(), kakaoLogoutRedirectUri(), flowTraceId)
        );
        clearLogoutFlowSession(session);
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/naver/logout")
    public String naverLogout(HttpServletRequest request, HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        String flowTraceId = prepareLogoutFlow(session, "NAVER", naverLogoutRedirectUri());
        applyLogoutActivityContext(request, session, loginUser, "NAVER", flowTraceId, "LOGOUT_NAVER_REQUEST");
        setLogoutFailReason(session, revokeSocialAccessToken("NAVER", session));
        return "redirect:" + naverLogoutRedirectUri();
    }

    @GetMapping("/naver/logout/callback")
    public String naverLogoutCallback(HttpServletRequest request, HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        String flowTraceId = getLogoutFlowTraceId(session);
        applyLogoutActivityContext(request, session, loginUser, "NAVER", flowTraceId, "LOGOUT_NAVER_CALLBACK");
        String failReason = (String) session.getAttribute(LOGOUT_FAIL_REASON_SESSION_KEY);
        authService.recordLogoutHistory(
                loginUser,
                "NAVER",
                failReason == null,
                failReason,
                buildRequestContext(request, session, request.getRequestURI(), naverLogoutRedirectUri(), flowTraceId)
        );
        clearLogoutFlowSession(session);
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/google/logout")
    public String googleLogout(HttpServletRequest request, HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        String flowTraceId = prepareLogoutFlow(session, "GOOGLE", googleLogoutRedirectUri());
        applyLogoutActivityContext(request, session, loginUser, "GOOGLE", flowTraceId, "LOGOUT_GOOGLE_REQUEST");
        setLogoutFailReason(session, revokeSocialAccessToken("GOOGLE", session));
        return "redirect:" + googleLogoutRedirectUri();
    }

    @GetMapping("/google/logout/callback")
    public String googleLogoutCallback(HttpServletRequest request, HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        String flowTraceId = getLogoutFlowTraceId(session);
        applyLogoutActivityContext(request, session, loginUser, "GOOGLE", flowTraceId, "LOGOUT_GOOGLE_CALLBACK");
        String failReason = (String) session.getAttribute(LOGOUT_FAIL_REASON_SESSION_KEY);
        authService.recordLogoutHistory(
                loginUser,
                "GOOGLE",
                failReason == null,
                failReason,
                buildRequestContext(request, session, request.getRequestURI(), googleLogoutRedirectUri(), flowTraceId)
        );
        clearLogoutFlowSession(session);
        session.invalidate();
        return "redirect:/";
    }

    // ════════════════════════════════════════════
    // 회원가입
    // ════════════════════════════════════════════

    @GetMapping("/register")
    public String registerPage(HttpSession session, Model model) {
        if (session.getAttribute("loginUser") != null) {
            return "redirect:/";
        }
        prepareSocialAuthUrls(session, model);
        return "auth/register";
    }

    @PostMapping("/register")
    @ResponseBody
    public Map<String, Object> registerProcess(@RequestParam String userId,
                                               @RequestParam(required = false) String userEmail,
                                               @RequestParam String password,
                                               @RequestParam String nickname,
                                               @RequestParam String nationality,
                                               @RequestParam String preferredLang,
                                               HttpServletRequest request,
                                               HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (authService.isUserIdDuplicate(userId)) {
            return error(result, "userId", "입력하신 아이디는 현재 사용할 수 없습니다. 다른 아이디를 입력해 주세요.");
        }
        if (userEmail != null && !userEmail.isBlank() && authService.isEmailDuplicate(userEmail)) {
            return error(result, "userEmail", "이미 사용 중인 이메일입니다.");
        }
        if (authService.isNicknameDuplicate(nickname)) {
            return error(result, "nickname", "이미 사용 중인 닉네임입니다.");
        }

        UsersVO newUser = UsersVO.builder()
                .userId(userId)
                .userEmail(hasText(userEmail) ? userEmail : null)
                .userPassword(password)
                .nickname(nickname)
                .nationality(nationality)
                .preferredLang(preferredLang)
                .build();

        authService.register(newUser);
        session.setAttribute("loginUser", newUser);
        clearSocialSession(session);

        result.put("success", true);
        result.put("redirect", request.getContextPath() + "/");
        return result;
    }

    // ════════════════════════════════════════════
    // 중복 체크 API
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
    public String findIdPage() {
        return "auth/find-id";
    }

    @PostMapping("/find-id/send")
    @ResponseBody
    public Map<String, Object> sendFindId(@RequestParam String email,
                                          HttpServletRequest request) {
        String reqId = (String) request.getAttribute(ActivityLogInterceptor.ATTR_REQUEST_ID);
        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .requestId(reqId)
                .flowTraceId(reqId)
                .build();

        authService.sendFindIdEmail(email, context);

        return Map.of("success", true,
                "message", "입력하신 정보와 일치하는 확인 가능한 계정이 있는 경우, 가입된 이메일 주소로 안내를 보내드렸습니다. 메일이 도착하지 않았다면 스팸함도 함께 확인해 주세요.");
    }

    @GetMapping("/find-id/verify")
    public String verifyFindId(@RequestParam String token,
                               Model model,
                               HttpServletRequest request) {
        String reqId = (String) request.getAttribute(ActivityLogInterceptor.ATTR_REQUEST_ID);
        String flowTraceId = authService.resolveFlowTraceIdByToken(token);
        if (hasText(flowTraceId)) {
            request.setAttribute(ActivityLogInterceptor.ATTR_FLOW_TRACE_ID_OVERRIDE, flowTraceId);
        }
        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .requestId(reqId)
                .flowTraceId(hasText(flowTraceId) ? flowTraceId : reqId)
                .build();

        String userId = authService.verifyFindIdToken(token, context);
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
    public String findPwPage() {
        return "auth/find-pw";
    }

    @PostMapping("/find-pw/send")
    @ResponseBody
    public Map<String, Object> sendResetPw(@RequestParam String identifier,
                                           HttpServletRequest request) {
        String reqId = (String) request.getAttribute(ActivityLogInterceptor.ATTR_REQUEST_ID);
        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .requestId(reqId)
                .flowTraceId(reqId)
                .build();

        authService.sendResetPasswordEmail(identifier, context);

        return Map.of("success", true,
                "message", "입력하신 정보와 일치하는 확인 가능한 계정이 있는 경우, 비밀번호 재설정 안내를 이메일로 보내드렸습니다. 메일이 도착하지 않았다면 스팸함도 함께 확인해 주세요.");
    }

    @GetMapping("/reset-pw")
    public String resetPwPage(@RequestParam String token,
                              Model model,
                              HttpServletRequest request) {
        String reqId = (String) request.getAttribute(ActivityLogInterceptor.ATTR_REQUEST_ID);
        String flowTraceId = authService.resolveFlowTraceIdByToken(token);
        if (hasText(flowTraceId)) {
            request.setAttribute(ActivityLogInterceptor.ATTR_FLOW_TRACE_ID_OVERRIDE, flowTraceId);
        }
        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .requestId(reqId)
                .flowTraceId(hasText(flowTraceId) ? flowTraceId : reqId)
                .build();

        UsersVO user = authService.verifyResetToken(token, context);
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
                                         @RequestParam String newPassword,
                                         HttpServletRequest request) {
        String reqId = (String) request.getAttribute(ActivityLogInterceptor.ATTR_REQUEST_ID);
        String flowTraceId = authService.resolveFlowTraceIdByToken(token);
        if (hasText(flowTraceId)) {
            request.setAttribute(ActivityLogInterceptor.ATTR_FLOW_TRACE_ID_OVERRIDE, flowTraceId);
        }
        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .requestId(reqId)
                .flowTraceId(hasText(flowTraceId) ? flowTraceId : reqId)
                .build();

        boolean ok = authService.resetPassword(token, newPassword, context);
        if (ok) {
            return Map.of("success", true, "redirect", request.getContextPath() + "/auth/login");
        }
        return Map.of("success", false, "message", "링크가 만료되었습니다. 다시 시도해주세요.");
    }

    // ════════════════════════════════════════════
    // 이메일 인증
    // ════════════════════════════════════════════

    @GetMapping("/verify-email")
    public String verifyEmail(@RequestParam String token,
                              Model model,
                              HttpSession session,
                              HttpServletRequest request) {
        String reqId = (String) request.getAttribute(ActivityLogInterceptor.ATTR_REQUEST_ID);
        String flowTraceId = authService.resolveFlowTraceIdByToken(token);
        if (hasText(flowTraceId)) {
            request.setAttribute(ActivityLogInterceptor.ATTR_FLOW_TRACE_ID_OVERRIDE, flowTraceId);
        }
        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .requestId(reqId)
                .flowTraceId(hasText(flowTraceId) ? flowTraceId : reqId)
                .build();

        boolean ok = authService.verifyEmail(token, context);
        model.addAttribute("success", ok);

        if (ok) {
            UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
            if (loginUser != null) {
                UsersVO freshUser = authService.getUserByIdx(loginUser.getUserIdx());
                if (freshUser != null) {
                    session.setAttribute("loginUser", freshUser);
                    loadAdminPermissions(session, freshUser);
                }
            }
        } else {
            model.addAttribute("error", "링크가 만료되었거나 유효하지 않습니다.");
        }

        return "auth/verify-email-result";
    }

    // ════════════════════════════════════════════
    // 카카오 OAuth
    // ════════════════════════════════════════════

    @GetMapping("/kakao")
    public String kakaoLogin(HttpSession session) {
        return "redirect:" + authService.getKakaoAuthUrl(false);
    }

    @GetMapping("/kakao/callback")
    public String kakaoCallback(@RequestParam String code,
                                HttpServletRequest request,
                                HttpSession session,
                                RedirectAttributes ra) {
        return handleSocialCallback("KAKAO", authService.handleKakaoCallback(code, request), request, session, ra);
    }

    // ════════════════════════════════════════════
    // 네이버 OAuth
    // ════════════════════════════════════════════

    @GetMapping("/naver")
    public String naverLogin(HttpSession session) {
        String state = issueOauthState(session, "NAVER", false);
        return "redirect:" + authService.getNaverAuthUrl(state, false);
    }

    @GetMapping("/naver/callback")
    public String naverCallback(@RequestParam String code,
                                @RequestParam String state,
                                HttpServletRequest request,
                                HttpSession session,
                                RedirectAttributes ra) {
        if (!consumeOauthState(session, "NAVER", false, state)) {
            ra.addFlashAttribute("errorMsg", "잘못된 접근입니다.");
            return "redirect:/auth/login";
        }
        return handleSocialCallback("NAVER", authService.handleNaverCallback(code, state, request), request, session, ra);
    }

    // ════════════════════════════════════════════
    // 구글 OAuth
    // ════════════════════════════════════════════

    @GetMapping("/google")
    public String googleLogin(HttpSession session) {
        String state = issueOauthState(session, "GOOGLE", false);
        return "redirect:" + authService.getGoogleAuthUrl(state, false);
    }

    @GetMapping("/google/callback")
    public String googleCallback(@RequestParam String code,
                                 @RequestParam(required = false) String state,
                                 HttpServletRequest request,
                                 HttpSession session,
                                 RedirectAttributes ra) {
        if (!consumeOauthState(session, "GOOGLE", false, state)) {
            ra.addFlashAttribute("errorMsg", "잘못된 접근입니다.");
            return "redirect:/auth/login";
        }
        return handleSocialCallback("GOOGLE", authService.handleGoogleCallback(code, request), request, session, ra);
    }

    // ════════════════════════════════════════════
    // 소셜 연동 (마이페이지)
    // ════════════════════════════════════════════

    @GetMapping("/link/kakao")
    public String linkKakao(HttpSession session) {
        requireLogin(session);
        return "redirect:" + authService.getKakaoAuthUrl(true);
    }

    @GetMapping("/link/naver")
    public String linkNaver(HttpSession session) {
        requireLogin(session);
        String state = issueOauthState(session, "NAVER", true);
        return "redirect:" + authService.getNaverAuthUrl(state, true);
    }

    @GetMapping("/link/google")
    public String linkGoogle(HttpSession session) {
        requireLogin(session);
        String state = issueOauthState(session, "GOOGLE", true);
        return "redirect:" + authService.getGoogleAuthUrl(state, true);
    }

    @GetMapping("/link/kakao/callback")
    public String linkKakaoCallback(@RequestParam String code,
                                    HttpSession session,
                                    RedirectAttributes ra) {
        return handleLinkCallback("KAKAO", () -> authService.extractKakaoInfo(code), session, ra);
    }

    @GetMapping("/link/naver/callback")
    public String linkNaverCallback(@RequestParam String code,
                                    @RequestParam String state,
                                    HttpSession session,
                                    RedirectAttributes ra) {
        if (!consumeOauthState(session, "NAVER", true, state)) {
            ra.addFlashAttribute("errorMsg", "잘못된 접근입니다.");
            return "redirect:/mypage/edit";
        }
        return handleLinkCallback("NAVER", () -> authService.extractNaverInfo(code, state), session, ra);
    }

    @GetMapping("/link/google/callback")
    public String linkGoogleCallback(@RequestParam String code,
                                     @RequestParam(required = false) String state,
                                     HttpSession session,
                                     RedirectAttributes ra) {
        if (!consumeOauthState(session, "GOOGLE", true, state)) {
            ra.addFlashAttribute("errorMsg", "잘못된 접근입니다.");
            return "redirect:/mypage/edit";
        }
        return handleLinkCallback("GOOGLE", () -> authService.extractGoogleInfo(code), session, ra);
    }

    @PostMapping("/unlink")
    @ResponseBody
    public Map<String, Object> unlinkSocial(@RequestParam String provider, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        try {
            authService.unlinkSocial(loginUser.getUserIdx(), provider);
            result.put("success", true);
        } catch (IllegalStateException e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    // ════════════════════════════════════════════
    // 소셜 추가 정보 입력
    // ════════════════════════════════════════════

    @GetMapping("/social/complete")
    public String socialCompletePage(HttpSession session, Model model) {
        SocialTempVO temp = (SocialTempVO) session.getAttribute("socialTemp");
        if (temp == null) {
            return "redirect:/auth/login";
        }
        SocialEmailNoticeVO socialEmailNotice = authService.getSocialEmailNotice(temp);
        model.addAttribute("socialTemp", temp);
        model.addAttribute("socialEmailNotice", socialEmailNotice);
        return "auth/social-complete";
    }

    @PostMapping("/social/complete")
    @ResponseBody
    public Map<String, Object> socialCompleteProcess(@RequestParam String nickname,
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
            return error(result, "nickname", "이미 사용 중인 닉네임입니다.");
        }

        UsersVO user = authService.completeSocialRegister(temp, nickname, nationality, preferredLang, request);
        session.removeAttribute("socialTemp");
        session.setAttribute("loginUser", user);
        session.setAttribute(CURRENT_SOCIAL_PROVIDER_SESSION_KEY, temp.getProvider());

        result.put("success", true);
        result.put("redirect", request.getContextPath() + "/");
        return result;
    }

    private void loadAdminPermissions(HttpSession session, UsersVO user) {
        if (!UserRole.from(user.getUserRole()).isAdminLike()) {
            session.removeAttribute("adminPermissions");
            return;
        }
        List<SuperAdminPermissionVO> perms = superAdminMapper.findPermissionsByUser(user.getUserIdx());
        Set<String> permSet = perms.stream()
                .map(SuperAdminPermissionVO::getPermissionCode)
                .collect(Collectors.toCollection(HashSet::new));
        session.setAttribute("adminPermissions", permSet);
    }

    // ════════════════════════════════════════════
    // 내부 유틸
    // ════════════════════════════════════════════

    private String handleSocialCallback(String provider,
                                        Object socialResult,
                                        HttpServletRequest request,
                                        HttpSession session,
                                        RedirectAttributes ra) {
        if (socialResult == null) {
            ra.addFlashAttribute("errorMsg", "소셜 로그인 처리 중 오류가 발생했습니다.");
            return "redirect:/auth/login";
        }
        syncSocialAccessToken(session, request);
        if (socialResult instanceof UsersVO user) {
            session.setAttribute("loginUser", user);
            session.setAttribute(CURRENT_SOCIAL_PROVIDER_SESSION_KEY, provider);
            loadAdminPermissions(session, user);
            return "redirect:/";
        }
        if (socialResult instanceof SocialTempVO temp) {
            session.setAttribute("socialTemp", temp);
            return "redirect:/auth/social/complete";
        }
        ra.addFlashAttribute("errorMsg", "알 수 없는 오류가 발생했습니다.");
        return "redirect:/auth/login";
    }

    private void prepareSocialAuthUrls(HttpSession session, Model model) {
        String naverState = issueOauthState(session, "NAVER", false);
        String googleState = issueOauthState(session, "GOOGLE", false);

        model.addAttribute("kakaoAuthUrl", authService.getKakaoAuthUrl(false));
        model.addAttribute("naverAuthUrl", authService.getNaverAuthUrl(naverState, false));
        model.addAttribute("googleAuthUrl", authService.getGoogleAuthUrl(googleState, false));
    }

    private String issueOauthState(HttpSession session, String provider, boolean linkMode) {
        String key = buildOauthStateKey(provider, linkMode);
        @SuppressWarnings("unchecked")
        Set<String> states = (Set<String>) session.getAttribute(key);
        Set<String> mutableStates = states != null ? new HashSet<>(states) : new HashSet<>();
        String state = UUID.randomUUID().toString();
        mutableStates.add(state);
        session.setAttribute(key, mutableStates);
        return state;
    }

    private boolean consumeOauthState(HttpSession session, String provider, boolean linkMode, String state) {
        if (!hasText(state)) {
            return false;
        }
        String key = buildOauthStateKey(provider, linkMode);
        @SuppressWarnings("unchecked")
        Set<String> states = (Set<String>) session.getAttribute(key);
        if (states == null || states.isEmpty()) {
            return false;
        }
        Set<String> mutableStates = new HashSet<>(states);
        boolean matched = mutableStates.remove(state);
        if (mutableStates.isEmpty()) {
            session.removeAttribute(key);
        } else {
            session.setAttribute(key, mutableStates);
        }
        return matched;
    }

    private String buildOauthStateKey(String provider, boolean linkMode) {
        return provider + (linkMode ? "_LINK" : "_LOGIN") + "_OAUTH_STATE";
    }

    private void syncSocialAccessToken(HttpSession session, HttpServletRequest request) {
        String accessToken = (String) request.getAttribute(SOCIAL_ACCESS_TOKEN_REQUEST_KEY);
        if (hasText(accessToken)) {
            session.setAttribute(CURRENT_SOCIAL_ACCESS_TOKEN_SESSION_KEY, accessToken);
        } else {
            session.removeAttribute(CURRENT_SOCIAL_ACCESS_TOKEN_SESSION_KEY);
        }
    }

    private String revokeSocialAccessToken(String provider, HttpSession session) {
        String accessToken = (String) session.getAttribute(CURRENT_SOCIAL_ACCESS_TOKEN_SESSION_KEY);
        if (!hasText(accessToken)) {
            return null;
        }
        if ("NAVER".equals(provider)) {
            return authService.revokeNaverAccessToken(accessToken) ? null : "TOKEN_REVOKE_FAILED";
        } else if ("GOOGLE".equals(provider)) {
            return authService.revokeGoogleAccessToken(accessToken) ? null : "TOKEN_REVOKE_FAILED";
        }
        return null;
    }

    private void clearSocialSession(HttpSession session) {
        session.removeAttribute(CURRENT_SOCIAL_PROVIDER_SESSION_KEY);
        session.removeAttribute(CURRENT_SOCIAL_ACCESS_TOKEN_SESSION_KEY);
    }

    private String handleLinkCallback(String provider,
                                      Callable<String[]> extractor,
                                      HttpSession session,
                                      RedirectAttributes ra) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/auth/login";
        }
        try {
            String[] info = extractor.call();
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
        if (session.getAttribute("loginUser") == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }
    }

    private Map<String, Object> error(Map<String, Object> result, String field, String message) {
        result.put("success", false);
        result.put("field", field);
        result.put("message", message);
        return result;
    }

    /**
     * 로그인 성공 후 이동할 경로를 결정한다.
     * redirect 가 비어 있으면 홈으로 이동한다.
     */
    private String resolveLoginRedirect(HttpServletRequest request, String redirect) {
        if (!hasText(redirect)) {
            return request.getContextPath() + "/";
        }
        if (redirect.startsWith(request.getContextPath())) {
            return redirect;
        }
        return request.getContextPath() + redirect;
    }

    /**
     * 오픈 리다이렉트 방지를 위한 최소 검증.
     * 외부 URL, 프로토콜 포함 문자열, javascript: 스킴은 모두 제거한다.
     */
    private String safeRedirect(String redirect) {
        if (!hasText(redirect)) {
            return null;
        }
        String value = redirect.trim();
        if (value.startsWith("http://") || value.startsWith("https://") || value.startsWith("javascript:")) {
            return null;
        }
        if (!value.startsWith("/")) {
            value = "/" + value;
        }
        return value;
    }

    private String prepareLogoutFlow(HttpSession session, String provider, String callbackUri) {
        String flowTraceId = (String) session.getAttribute(LOGOUT_FLOW_TRACE_SESSION_KEY);
        if (!hasText(flowTraceId)) {
            flowTraceId = UUID.randomUUID().toString();
        }
        session.setAttribute(LOGOUT_FLOW_TRACE_SESSION_KEY, flowTraceId);
        session.setAttribute(LOGOUT_PROVIDER_SESSION_KEY, provider);
        session.setAttribute(LOGOUT_CALLBACK_URI_SESSION_KEY, callbackUri);
        session.removeAttribute(LOGOUT_FAIL_REASON_SESSION_KEY);
        return flowTraceId;
    }

    private String getLogoutFlowTraceId(HttpSession session) {
        String flowTraceId = (String) session.getAttribute(LOGOUT_FLOW_TRACE_SESSION_KEY);
        return hasText(flowTraceId) ? flowTraceId : UUID.randomUUID().toString();
    }

    private void clearLogoutFlowSession(HttpSession session) {
        session.removeAttribute(LOGOUT_FLOW_TRACE_SESSION_KEY);
        session.removeAttribute(LOGOUT_PROVIDER_SESSION_KEY);
        session.removeAttribute(LOGOUT_CALLBACK_URI_SESSION_KEY);
        session.removeAttribute(LOGOUT_FAIL_REASON_SESSION_KEY);
    }

    private void setLogoutFailReason(HttpSession session, String failReason) {
        if (hasText(failReason)) {
            session.setAttribute(LOGOUT_FAIL_REASON_SESSION_KEY, failReason);
        } else {
            session.removeAttribute(LOGOUT_FAIL_REASON_SESSION_KEY);
        }
    }


    private String runtimeSetting(String key, String fallback) {
        return runtimeSettingService.getValue(key, fallback);
    }

    private String kakaoLogoutRedirectUri() {
        return runtimeSetting("oauth.kakao.logout-redirect-uri", kakaoLogoutRedirectUri);
    }

    private String naverLogoutRedirectUri() {
        return runtimeSetting("oauth.naver.logout-redirect-uri", naverLogoutRedirectUri);
    }

    private String googleLogoutRedirectUri() {
        return runtimeSetting("oauth.google.logout-redirect-uri", googleLogoutRedirectUri);
    }

    private LoginRequestContext buildRequestContext(HttpServletRequest request,
                                                    HttpSession session,
                                                    String requestUri,
                                                    String logoutCallbackUri,
                                                    String flowTraceId) {
        String requestId = (String) request.getAttribute(ActivityLogInterceptor.ATTR_REQUEST_ID);
        String effectiveFlowTraceId = hasText(flowTraceId)
                ? flowTraceId
                : (String) request.getAttribute(ActivityLogInterceptor.ATTR_FLOW_TRACE_ID_OVERRIDE);
        String sessionId = session != null ? session.getId() : request.getRequestedSessionId();

        return LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .requestId(requestId)
                .flowTraceId(hasText(effectiveFlowTraceId) ? effectiveFlowTraceId : requestId)
                .sessionId(sessionId)
                .requestUri(requestUri)
                .logoutCallbackUri(logoutCallbackUri)
                .build();
    }

    private void applyLogoutActivityContext(HttpServletRequest request,
                                            HttpSession session,
                                            UsersVO loginUser,
                                            String provider,
                                            String flowTraceId,
                                            String activityCode) {
        if (loginUser != null) {
            request.setAttribute(ActivityLogInterceptor.ATTR_FORCE_USER_IDX, loginUser.getUserIdx());
        }
        if (session != null) {
            request.setAttribute(ActivityLogInterceptor.ATTR_FORCE_SESSION_ID, session.getId());
        }
        request.setAttribute(ActivityLogInterceptor.ATTR_FLOW_TRACE_ID_OVERRIDE, flowTraceId);
        request.setAttribute(ActivityLogInterceptor.ATTR_ACTIVITY_DOMAIN_OVERRIDE, "AUTH");
        request.setAttribute(ActivityLogInterceptor.ATTR_ACTIVITY_PROVIDER_OVERRIDE, provider);
        request.setAttribute(ActivityLogInterceptor.ATTR_AUTH_EVENT_TYPE_OVERRIDE, "LOGOUT");
        request.setAttribute(ActivityLogInterceptor.ATTR_ACTIVITY_CODE_OVERRIDE, activityCode);
    }

    private boolean hasText(String value) {
        return value != null && !value.isBlank();
    }

    /**
     * 프록시/로드밸런서 환경까지 고려한 실제 클라이언트 IP 추출.
     */
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
}
