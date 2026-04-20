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

    private final AuthService authService;
    private final SuperAdminMapper superAdminMapper;

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

        // 네이버 / 구글 state 는 CSRF 방지를 위해 세션에 저장한다.
        String state = UUID.randomUUID().toString();
        session.setAttribute("oauthState", state);

        model.addAttribute("redirect", safeRedirect(redirect));
        model.addAttribute("errorMsg", errorMsg);
        model.addAttribute("kakaoAuthUrl", authService.getKakaoAuthUrl(false));
        model.addAttribute("naverAuthUrl", authService.getNaverAuthUrl(state, false));
        model.addAttribute("googleAuthUrl", authService.getGoogleAuthUrl(state, false));
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

        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .build();

        UsersVO user = authService.login(identifier, password, context);
        if (user == null) {
            result.put("success", false);
            result.put("message", "아이디(이메일) 또는 비밀번호가 올바르지 않습니다.");
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
        session.removeAttribute("currentSocialProvider");
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
    public String logout(HttpSession session) {
        String currentSocialProvider = (String) session.getAttribute("currentSocialProvider");
        if ("KAKAO".equals(currentSocialProvider)) {
            return "redirect:/auth/kakao/logout";
        }

        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/kakao/logout")
    public String kakaoLogout(HttpSession session) {
        String state = UUID.randomUUID().toString();
        session.setAttribute("kakaoLogoutState", state);
        return "redirect:" + authService.getKakaoLogoutUrl(state);
    }

    @GetMapping("/kakao/logout/callback")
    public String kakaoLogoutCallback(@RequestParam(required = false) String state, HttpSession session) {
        String savedState = (String) session.getAttribute("kakaoLogoutState");

        if (savedState != null && state != null && !savedState.equals(state)) {
            log.warn("[Kakao Logout] state mismatch. saved={}, received={}", savedState, state);
        }

        session.removeAttribute("kakaoLogoutState");
        session.invalidate();
        return "redirect:/";
    }

    // ════════════════════════════════════════════
    // 회원가입
    // ════════════════════════════════════════════

    @GetMapping("/register")
    public String registerPage(HttpSession session) {
        if (session.getAttribute("loginUser") != null) {
            return "redirect:/";
        }
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
        session.removeAttribute("currentSocialProvider");

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

        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .build();

        authService.sendFindIdEmail(email, context);

        return Map.of("success", true,
                "message", "입력하신 정보와 일치하는 확인 가능한 계정이 있는 경우, 가입된 이메일 주소로 안내를 보내드렸습니다. 메일이 도착하지 않았다면 스팸함도 함께 확인해 주세요.");
    }

    @GetMapping("/find-id/verify")
    public String verifyFindId(@RequestParam String token,
                               Model model,
                               HttpServletRequest request) {
        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
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

        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .build();

        authService.sendResetPasswordEmail(identifier, context);

        return Map.of("success", true,
                "message", "입력하신 정보와 일치하는 확인 가능한 계정이 있는 경우, 비밀번호 재설정 안내를 이메일로 보내드렸습니다. 메일이 도착하지 않았다면 스팸함도 함께 확인해 주세요.");
    }

    @GetMapping("/reset-pw")
    public String resetPwPage(@RequestParam String token,
                              Model model,
                              HttpServletRequest request) {
        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
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
        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
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
        LoginRequestContext context = LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
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
        String state = UUID.randomUUID().toString();
        session.setAttribute("oauthState", state);
        return "redirect:" + authService.getKakaoAuthUrl(false);
    }

    @GetMapping("/kakao/callback")
    public String kakaoCallback(@RequestParam String code,
                                HttpServletRequest request,
                                HttpSession session,
                                RedirectAttributes ra) {
        return handleSocialCallback("KAKAO", authService.handleKakaoCallback(code, request), session, ra);
    }

    // ════════════════════════════════════════════
    // 네이버 OAuth
    // ════════════════════════════════════════════

    @GetMapping("/naver")
    public String naverLogin(HttpSession session) {
        String state = UUID.randomUUID().toString();
        session.setAttribute("oauthState", state);
        return "redirect:" + authService.getNaverAuthUrl(state, false);
    }

    @GetMapping("/naver/callback")
    public String naverCallback(@RequestParam String code,
                                @RequestParam String state,
                                HttpServletRequest request,
                                HttpSession session,
                                RedirectAttributes ra) {
        String savedState = (String) session.getAttribute("oauthState");
        if (savedState == null || !savedState.equals(state)) {
            ra.addFlashAttribute("errorMsg", "잘못된 접근입니다.");
            return "redirect:/auth/login";
        }
        return handleSocialCallback("NAVER", authService.handleNaverCallback(code, state, request), session, ra);
    }

    // ════════════════════════════════════════════
    // 구글 OAuth
    // ════════════════════════════════════════════

    @GetMapping("/google")
    public String googleLogin(HttpSession session) {
        String state = UUID.randomUUID().toString();
        session.setAttribute("oauthState", state);
        return "redirect:" + authService.getGoogleAuthUrl(state, false);
    }

    @GetMapping("/google/callback")
    public String googleCallback(@RequestParam String code,
                                 @RequestParam(required = false) String state,
                                 HttpServletRequest request,
                                 HttpSession session,
                                 RedirectAttributes ra) {
        return handleSocialCallback("GOOGLE", authService.handleGoogleCallback(code, request), session, ra);
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
        return handleLinkCallback("NAVER", () -> authService.extractNaverInfo(code, state), session, ra);
    }

    @GetMapping("/link/google/callback")
    public String linkGoogleCallback(@RequestParam String code,
                                     HttpSession session,
                                     RedirectAttributes ra) {
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
        model.addAttribute("socialTemp", temp);
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
        session.setAttribute("currentSocialProvider", temp.getProvider());

        result.put("success", true);
        result.put("redirect", request.getContextPath() + "/");
        return result;
    }

    // ════════════════════════════════════════════
    private void loadAdminPermissions(HttpSession session, UsersVO user) {
        if (!"ADMIN".equals(user.getUserRole())) {
            session.removeAttribute("adminPermissions");
            return;
        }
        List<SuperAdminPermissionVO> perms = superAdminMapper.findPermissionsByUser(user.getUserIdx());
        Set<String> permSet = perms.stream()
                .map(SuperAdminPermissionVO::getPermissionCode)
                .collect(Collectors.toCollection(HashSet::new));
        session.setAttribute("adminPermissions", permSet);
    }

    // 내부 유틸
    // ════════════════════════════════════════════

    private String handleSocialCallback(String provider,
                                        Object socialResult,
                                        HttpSession session,
                                        RedirectAttributes ra) {
        if (socialResult == null) {
            ra.addFlashAttribute("errorMsg", "소셜 로그인 처리 중 오류가 발생했습니다.");
            return "redirect:/auth/login";
        }
        if (socialResult instanceof UsersVO user) {
            session.setAttribute("loginUser", user);
            session.setAttribute("currentSocialProvider", provider);
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
