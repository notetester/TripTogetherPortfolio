package org.triptogether.auth.service;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.triptogether.auth.mapper.AuthMapper;
import org.triptogether.auth.vo.*;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final AuthMapper authMapper;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final RestTemplate restTemplate;
    private final JavaMailSender mailSender;

    @Value("${spring.mail.username}")           private String mailFrom;
    @Value("${app.base-url}")                   private String baseUrl;

    // ──── Kakao ────
    @Value("${oauth.kakao.client-id}")       private String kakaoClientId;
    @Value("${oauth.kakao.client-secret}")   private String kakaoClientSecret;
    @Value("${oauth.kakao.redirect-uri}")    private String kakaoRedirectUri;
    @Value("${oauth.kakao.link-redirect-uri}")  private String kakaoLinkRedirectUri;
    @Value("${oauth.kakao.logout-redirect-uri}") private String kakaoLogoutRedirectUri;

    // ──── Naver ────
    @Value("${oauth.naver.client-id}")       private String naverClientId;
    @Value("${oauth.naver.client-secret}")   private String naverClientSecret;
    @Value("${oauth.naver.redirect-uri}")    private String naverRedirectUri;
    @Value("${oauth.naver.link-redirect-uri}")  private String naverLinkRedirectUri;

    // ──── Google ───
    @Value("${oauth.google.client-id}")      private String googleClientId;
    @Value("${oauth.google.client-secret}")  private String googleClientSecret;
    @Value("${oauth.google.redirect-uri}")   private String googleRedirectUri;
    @Value("${oauth.google.link-redirect-uri}") private String googleLinkRedirectUri;

    // ════════════════════════════════════════════
    // 일반 로그인
    // ════════════════════════════════════════════
    @Override
    public UsersVO login(String identifier, String password, HttpServletRequest request) {
        // ID 또는 이메일 모두 허용
        UsersVO user = authMapper.findByUserId(identifier);
        if (user == null) user = authMapper.findByEmail(identifier);

        String loginMethod = (identifier != null && identifier.contains("@")) ? "EMAIL" : "ID";
        UserLoginHistoryVO.UserLoginHistoryVOBuilder historyBuilder = UserLoginHistoryVO.builder()
                .authType("PASSWORD")
                .loginMethod(loginMethod)
                .loginIdentifier(identifier)
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"));

        // 사용자 없음
        if (user == null) {
            authMapper.insertLoginHistory(historyBuilder.success(false).failReason("USER_NOT_FOUND").build());
            return null;
        }

        // 계정 상태 검사
        if ("DELETED".equals(user.getAccountStatus())) {
            authMapper.insertLoginHistory(historyBuilder.userIdx(user.getUserIdx()).success(false).failReason("ACCOUNT_DELETED").build());
            return null;
        }
        if ("DORMANT".equals(user.getAccountStatus())) {
            authMapper.insertLoginHistory(historyBuilder.userIdx(user.getUserIdx()).success(false).failReason("ACCOUNT_DORMANT").build());
            return null;
        }

        // 비밀번호 로그인 가능 여부
        if (!user.isPasswordEnabled()) {
            authMapper.insertLoginHistory(historyBuilder.userIdx(user.getUserIdx()).success(false).failReason("PASSWORD_LOGIN_DISABLED").build());
            return null;
        }

        // 비밀번호 검증
        if (!bCryptPasswordEncoder.matches(password, user.getUserPassword())) {
            authMapper.insertLoginHistory(historyBuilder.userIdx(user.getUserIdx()).success(false).failReason("WRONG_PASSWORD").build());
            return null;
        }

        // 로그인 성공
        authMapper.insertLoginHistory(historyBuilder.userIdx(user.getUserIdx()).success(true).build());
        return user;
    }

    @Override
    public UsersVO login(String identifier, String password, LoginRequestContext context) {

        boolean isEmail = isValidEmailFormat(identifier);
        String loginMethod = isEmail ? "EMAIL" : "ID";

        // 1. 사용자 조회
        UsersVO user = isEmail
                ? authMapper.findByEmail(identifier)
                : authMapper.findByUserId(identifier);

        // 2. 사용자 없음
        if (user == null) {
            recordLoginResult(null, loginMethod, identifier,
                    false, "USER_NOT_FOUND", context);
            return null;
        }

        // 3. 계정 상태
        if ("DELETED".equals(user.getAccountStatus())) {
            recordLoginResult(user.getUserIdx(), loginMethod, identifier,
                    false, "ACCOUNT_DELETED", context);
            return null;
        }

        if ("DORMANT".equals(user.getAccountStatus())) {
            recordLoginResult(user.getUserIdx(), loginMethod, identifier,
                    false, "ACCOUNT_DORMANT", context);
            return null;
        }

        // 4. 이메일 정책
        if (isEmail) {
            if (!user.isEmailVerified()) {
                recordLoginResult(user.getUserIdx(), loginMethod, identifier,
                        false, "EMAIL_NOT_VERIFIED", context);
                return null;
            }

            if (!user.isEmailLoginEnabled()) {
                recordLoginResult(user.getUserIdx(), loginMethod, identifier,
                        false, "EMAIL_LOGIN_DISABLED", context);
                return null;
            }
        }

        // 5. 비밀번호 로그인 가능 여부
        if (!user.isPasswordEnabled()) {
            recordLoginResult(user.getUserIdx(), loginMethod, identifier,
                    false, "PASSWORD_LOGIN_DISABLED", context);
            return null;
        }

        // 6. 비밀번호 검증
        if (!bCryptPasswordEncoder.matches(password, user.getUserPassword())) {
            recordLoginResult(user.getUserIdx(), loginMethod, identifier,
                    false, "WRONG_PASSWORD", context);
            return null;
        }

        // 7. 성공
        recordLoginResult(user.getUserIdx(), loginMethod, identifier,
                true, null, context);

        return user;
    }

    // ════════════════════════════════════════════
    // 일반 회원가입
    // ════════════════════════════════════════════
    @Override
    public void register(UsersVO user) {
        // 비밀번호 해싱
        if (user.getUserPassword() != null && !user.getUserPassword().isBlank()) {
            user.setUserPassword(bCryptPasswordEncoder.encode(user.getUserPassword()));
            user.setPasswordEnabled(true);
        }
        authMapper.insertUser(user);
    }

    // ════════════════════════════════════════════
    // 중복 체크
    // ════════════════════════════════════════════
    @Override public boolean isUserIdDuplicate(String userId)     { return authMapper.existsByUserId(userId); }
    @Override public boolean isEmailDuplicate(String email)       { return authMapper.existsByEmail(email); }
    @Override public boolean isNicknameDuplicate(String nickname) { return authMapper.existsByNickname(nickname); }

    // ════════════════════════════════════════════
    // 아이디 찾기
    // ════════════════════════════════════════════
    @Override
    public UsersVO getUserByIdx(Long userIdx) {
        return authMapper.findByIdx(userIdx);
    }

    @Override
    public void sendFindIdEmail(String email, LoginRequestContext context) {
        String normalizedEmail = email == null ? null : email.trim();
        UsersVO user = authMapper.findByEmail(normalizedEmail);

        recordSecurityEvent(user != null ? user.getUserIdx() : null,
                null,
                "FIND_ID",
                "REQUEST",
                normalizedEmail,
                normalizedEmail,
                true,
                null,
                null,
                context);

        if (user == null) {
            recordSecurityEvent(null, null, "FIND_ID", "ISSUE", normalizedEmail, normalizedEmail,
                    false, "EMAIL_NOT_FOUND", null, context);
            return;
        }

        if (!user.isEmailVerified()) {
            recordSecurityEvent(user.getUserIdx(), null, "FIND_ID", "ISSUE", normalizedEmail, normalizedEmail,
                    false, "EMAIL_NOT_VERIFIED", null, context);
            return;
        }

        if (user.getUserId() == null || user.getUserId().isBlank()) {
            recordSecurityEvent(user.getUserIdx(), null, "FIND_ID", "ISSUE", normalizedEmail, normalizedEmail,
                    false, "USER_ID_NOT_FOUND", null, context);
            return;
        }

        if (!isRecoverableAccountStatus(user.getAccountStatus())) {
            recordSecurityEvent(user.getUserIdx(), null, "FIND_ID", "ISSUE", normalizedEmail, normalizedEmail,
                    false, "ACCOUNT_NOT_RECOVERABLE", null, context);
            return;
        }

        authMapper.expireOldTokens(user.getUserEmail(), "FIND_ID");
        String token = UUID.randomUUID().toString();
        authMapper.insertEmailVerification(EmailVerificationVO.builder()
                .userIdx(user.getUserIdx())
                .email(user.getUserEmail())
                .token(token)
                .purpose("FIND_ID")
                .expiredAt(LocalDateTime.now().plusMinutes(30))
                .build());

        boolean sent = sendMail(normalizedEmail, "[TripTogether] 아이디 확인 요청 안내",
                buildEmailHtml(
                        "아이디 확인 요청",
                        "아래 버튼을 클릭하시면 로그인 아이디 힌트를 확인할 수 있습니다. 링크는 30분간 유효합니다. 요청하지 않으셨다면 이 메일을 무시해 주세요.",
                        baseUrl + "/auth/find-id/verify?token=" + token,
                        "아이디 힌트 확인하기"
                ));

        recordSecurityEvent(user.getUserIdx(), null, "FIND_ID", "ISSUE", normalizedEmail, normalizedEmail,
                sent, sent ? null : "MAIL_SEND_FAILED", null, context);
    }

    @Override
    public String verifyFindIdToken(String token, LoginRequestContext context) {
        EmailVerificationVO ev = authMapper.findValidToken(token, "FIND_ID");
        if (ev == null) {
            recordSecurityEvent(null, null, "FIND_ID", "VERIFY", null, null,
                    false, "TOKEN_INVALID_OR_EXPIRED", null, context);
            return null;
        }
        authMapper.markTokenUsed(ev.getVerifyIdx());

        String userId = authMapper.findUserIdByEmail(ev.getEmail());
        if (userId == null || userId.isBlank()) {
            recordSecurityEvent(ev.getUserIdx(), null, "FIND_ID", "VERIFY", ev.getEmail(), ev.getEmail(),
                    false, "USER_ID_NOT_FOUND", null, context);
            return null;
        }

        recordSecurityEvent(ev.getUserIdx(), null, "FIND_ID", "VERIFY", ev.getEmail(), ev.getEmail(),
                true, null, null, context);
        recordSecurityEvent(ev.getUserIdx(), null, "FIND_ID", "COMPLETE", ev.getEmail(), ev.getEmail(),
                true, null, null, context);
        return maskUserId(userId);
    }

    // ════════════════════════════════════════════
    // 비밀번호 찾기 / 재설정
    // ════════════════════════════════════════════
    @Override
    public void sendResetPasswordEmail(String identifier, LoginRequestContext context) {
        String normalizedIdentifier = identifier == null ? null : identifier.trim();
        UsersVO user = normalizedIdentifier != null && normalizedIdentifier.contains("@")
                ? authMapper.findByEmail(normalizedIdentifier)
                : authMapper.findByUserId(normalizedIdentifier);

        recordSecurityEvent(user != null ? user.getUserIdx() : null,
                null,
                "FIND_PASSWORD",
                "REQUEST",
                normalizedIdentifier,
                user != null ? user.getUserEmail() : null,
                true,
                null,
                null,
                context);

        if (user == null) {
            recordSecurityEvent(null, null, "FIND_PASSWORD", "ISSUE", normalizedIdentifier, null,
                    false, "USER_NOT_FOUND", null, context);
            return;
        }

        if (user.getUserEmail() == null || user.getUserEmail().isBlank()) {
            recordSecurityEvent(user.getUserIdx(), null, "FIND_PASSWORD", "ISSUE", normalizedIdentifier, null,
                    false, "EMAIL_NOT_REGISTERED", null, context);
            return;
        }

        if (!user.isEmailVerified()) {
            recordSecurityEvent(user.getUserIdx(), null, "FIND_PASSWORD", "ISSUE", normalizedIdentifier, user.getUserEmail(),
                    false, "EMAIL_NOT_VERIFIED", null, context);
            return;
        }

        if (!user.isPasswordEnabled()) {
            recordSecurityEvent(user.getUserIdx(), null, "FIND_PASSWORD", "ISSUE", normalizedIdentifier, user.getUserEmail(),
                    false, "PASSWORD_RESET_NOT_ALLOWED", null, context);
            return;
        }

        if (!isRecoverableAccountStatus(user.getAccountStatus())) {
            recordSecurityEvent(user.getUserIdx(), null, "FIND_PASSWORD", "ISSUE", normalizedIdentifier, user.getUserEmail(),
                    false, "ACCOUNT_NOT_RECOVERABLE", null, context);
            return;
        }

        authMapper.expireOldTokens(user.getUserEmail(), "RESET_PW");
        String token = UUID.randomUUID().toString();
        authMapper.insertEmailVerification(EmailVerificationVO.builder()
                .userIdx(user.getUserIdx())
                .email(user.getUserEmail())
                .token(token)
                .purpose("RESET_PW")
                .expiredAt(LocalDateTime.now().plusMinutes(30))
                .build());

        boolean sent = sendMail(user.getUserEmail(), "[TripTogether] 비밀번호 재설정",
                buildEmailHtml("비밀번호 재설정", "아래 버튼을 클릭하시면 비밀번호를 재설정할 수 있습니다. 링크는 30분간 유효합니다.",
                        baseUrl + "/auth/reset-pw?token=" + token, "비밀번호 재설정하기"));

        recordSecurityEvent(user.getUserIdx(), null, "FIND_PASSWORD", "ISSUE", normalizedIdentifier, user.getUserEmail(),
                sent, sent ? null : "MAIL_SEND_FAILED", null, context);
    }

    @Override
    public UsersVO verifyResetToken(String token, LoginRequestContext context) {
        EmailVerificationVO ev = authMapper.findValidToken(token, "RESET_PW");
        if (ev == null) {
            recordSecurityEvent(null, null, "FIND_PASSWORD", "VERIFY", null, null,
                    false, "TOKEN_INVALID_OR_EXPIRED", null, context);
            return null;
        }

        UsersVO user = authMapper.findByIdx(ev.getUserIdx());
        if (user == null) {
            recordSecurityEvent(ev.getUserIdx(), null, "FIND_PASSWORD", "VERIFY", ev.getEmail(), ev.getEmail(),
                    false, "USER_NOT_FOUND", null, context);
            return null;
        }

        recordSecurityEvent(ev.getUserIdx(), null, "FIND_PASSWORD", "VERIFY", ev.getEmail(), ev.getEmail(),
                true, null, null, context);
        return user;
    }

    @Override
    public boolean resetPassword(String token, String newPassword, LoginRequestContext context) {
        EmailVerificationVO ev = authMapper.findValidToken(token, "RESET_PW");
        if (ev == null) {
            recordSecurityEvent(null, null, "RESET_PASSWORD", "COMPLETE", null, null,
                    false, "TOKEN_INVALID_OR_EXPIRED", null, context);
            return false;
        }
        authMapper.markTokenUsed(ev.getVerifyIdx());
        authMapper.resetPassword(ev.getUserIdx(), bCryptPasswordEncoder.encode(newPassword));
        recordSecurityEvent(ev.getUserIdx(), ev.getUserIdx(), "RESET_PASSWORD", "COMPLETE", ev.getEmail(), ev.getEmail(),
                true, null, null, context);
        return true;
    }

    // ════════════════════════════════════════════
    // 프로필 수정
    // ════════════════════════════════════════════
    @Override
    public boolean checkPassword(Long userIdx, String rawPassword) {
        UsersVO user = authMapper.findByIdx(userIdx);
        if (user == null || !user.isPasswordEnabled()) return false;
        return bCryptPasswordEncoder.matches(rawPassword, user.getUserPassword());
    }

    @Override
    public void updateProfile(UsersVO user) {
        authMapper.updateProfile(user);
    }

    @Override
    public void updatePassword(Long userIdx, String newRawPassword, LoginRequestContext context) {
        authMapper.updatePassword(userIdx, bCryptPasswordEncoder.encode(newRawPassword));
        UsersVO user = authMapper.findByIdx(userIdx);
        recordSecurityEvent(userIdx, userIdx, "PASSWORD_CHANGE", "COMPLETE", user != null ? user.getUserId() : null,
                user != null ? user.getUserEmail() : null, true, null, null, context);
    }

    public void recordPasswordChangeFailure(Long userIdx, LoginRequestContext context, String failReason) {
        UsersVO user = authMapper.findByIdx(userIdx);
        recordSecurityEvent(userIdx, userIdx, "PASSWORD_CHANGE", "COMPLETE", user != null ? user.getUserId() : null,
                user != null ? user.getUserEmail() : null, false, failReason, null, context);
    }

    // ════════════════════════════════════════════
    // 이메일 인증
    // ════════════════════════════════════════════
    @Override
    public boolean sendEmailVerification(Long userIdx, String email, LoginRequestContext context) {
        recordSecurityEvent(userIdx, userIdx, "EMAIL_VERIFY", "REQUEST", email, email,
                true, null, null, context);

        authMapper.expireOldTokens(email, "VERIFY");

        String token = UUID.randomUUID().toString();
        authMapper.insertEmailVerification(EmailVerificationVO.builder()
                .userIdx(userIdx)
                .email(email)
                .token(token)
                .purpose("VERIFY")
                .expiredAt(LocalDateTime.now().plusMinutes(30))
                .build());

        boolean sent = sendMail(email, "[TripTogether] 이메일 인증",
                buildEmailHtml("이메일 인증", "아래 버튼을 클릭하시면 이메일 인증이 완료됩니다.",
                        baseUrl + "/auth/verify-email?token=" + token, "이메일 인증 완료"));

        recordSecurityEvent(userIdx, userIdx, "EMAIL_VERIFY", "ISSUE", email, email,
                sent, sent ? null : "MAIL_SEND_FAILED", null, context);
        return sent;
    }

    @Override
    public boolean verifyEmail(String token, LoginRequestContext context) {
        EmailVerificationVO ev = authMapper.findValidToken(token, "VERIFY");
        if (ev == null) {
            recordSecurityEvent(null, null, "EMAIL_VERIFY", "VERIFY", null, null,
                    false, "TOKEN_INVALID_OR_EXPIRED", null, context);
            return false;
        }

        recordSecurityEvent(ev.getUserIdx(), ev.getUserIdx(), "EMAIL_VERIFY", "VERIFY", ev.getEmail(), ev.getEmail(),
                true, null, null, context);

        try {
            authMapper.markTokenUsed(ev.getVerifyIdx());
            authMapper.updateEmail(ev.getUserIdx(), ev.getEmail(), true);
            UsersVO updated = authMapper.findByIdx(ev.getUserIdx());
            if (updated != null && !hasUsableLocalLogin(updated) && updated.isPasswordEnabled()) {
                authMapper.clearPasswordAndDisable(ev.getUserIdx());
            }
            recordSecurityEvent(ev.getUserIdx(), ev.getUserIdx(), "EMAIL_VERIFY", "COMPLETE", ev.getEmail(), ev.getEmail(),
                    true, null, null, context);
            return true;
        } catch (Exception e) {
            recordSecurityEvent(ev.getUserIdx(), ev.getUserIdx(), "EMAIL_VERIFY", "COMPLETE", ev.getEmail(), ev.getEmail(),
                    false, "EMAIL_VERIFY_UPDATE_FAIL", e.getMessage(), context);
            return false;
        }
    }

    @Override
    public void toggleEmailLogin(Long userIdx, boolean enable, LoginRequestContext context) {
        UsersVO user = authMapper.findByIdx(userIdx);
        if (user == null) {
            recordSecurityEvent(null, userIdx, "EMAIL_LOGIN_TOGGLE", "COMPLETE", null, null,
                    false, "USER_NOT_FOUND", null, context);
            throw new IllegalStateException("사용자 정보를 찾을 수 없습니다.");
        }
        if (!user.isEmailVerified()) {
            recordSecurityEvent(userIdx, userIdx, "EMAIL_LOGIN_TOGGLE", "COMPLETE", user.getUserEmail(), user.getUserEmail(),
                    false, "EMAIL_NOT_VERIFIED", enable ? "ENABLE" : "DISABLE", context);
            throw new IllegalStateException("이메일 인증이 완료되지 않았습니다.");
        }
        authMapper.updateEmailLoginEnabled(userIdx, enable);
        recordSecurityEvent(userIdx, userIdx, "EMAIL_LOGIN_TOGGLE", "COMPLETE", user.getUserEmail(), user.getUserEmail(),
                true, null, enable ? "ENABLE" : "DISABLE", context);
    }

    /**
     * 이메일 로그인 체크박스 변경 시점에 최신 인증 상태를 다시 확인한다.
     * 실제 반영은 저장 버튼에서만 수행하고, 여기서는 가능 여부만 판단한다.
     */
    public Map<String, Object> checkEmailLoginAvailability(Long userIdx) {
        UsersVO user = authMapper.findByIdx(userIdx);
        Map<String, Object> result = new LinkedHashMap<>();

        if (user == null) {
            result.put("success", false);
            result.put("message", "사용자 정보를 찾을 수 없습니다.");
            return result;
        }
        if (user.getUserEmail() == null || user.getUserEmail().isBlank()) {
            result.put("success", false);
            result.put("message", "먼저 이메일을 등록해 주세요.");
            return result;
        }
        if (!user.isEmailVerified()) {
            result.put("success", false);
            result.put("message", "이메일 인증을 먼저 완료해 주세요.");
            result.put("emailVerified", false);
            return result;
        }

        result.put("success", true);
        result.put("emailVerified", true);
        result.put("requiresPassword", !user.isPasswordEnabled());
        result.put("message", user.isPasswordEnabled()
                ? "저장하면 이메일 로그인이 활성화됩니다."
                : "저장 시 비밀번호를 함께 설정해야 이메일 로그인을 사용할 수 있습니다.");
        return result;
    }

    /**
     * 로컬 로그인 수단(아이디 / 이메일 로그인)을 저장한다.
     * 비밀번호는 로컬 로그인 수단이 처음 생길 때만 함께 설정한다.
     */
    public UsersVO saveLoginSettings(Long userIdx,
                                     String userIdToAdd,
                                     boolean enableEmailLogin,
                                     String newPassword,
                                     LoginRequestContext context) {
        UsersVO user = authMapper.findByIdx(userIdx);
        if (user == null) {
            throw new IllegalStateException("사용자 정보를 찾을 수 없습니다.");
        }

        String normalizedUserId = userIdToAdd == null ? null : userIdToAdd.trim();
        if (normalizedUserId != null && normalizedUserId.isBlank()) {
            normalizedUserId = null;
        }

        // 아이디는 1회만 등록 가능하다.
        if (user.getUserId() != null && normalizedUserId != null && !user.getUserId().equals(normalizedUserId)) {
            throw new IllegalStateException("아이디는 변경할 수 없습니다.");
        }
        if (user.getUserId() == null && normalizedUserId != null && authMapper.existsByUserId(normalizedUserId)) {
            throw new IllegalStateException("입력하신 아이디는 현재 사용할 수 없습니다. 다른 아이디를 입력해 주세요.");
        }

        boolean willHaveUserId = hasText(user.getUserId()) || hasText(normalizedUserId);
        boolean needsPasswordForFirstLocalLogin = !user.isPasswordEnabled() && (willHaveUserId || enableEmailLogin);

        if (enableEmailLogin) {
            if (!hasText(user.getUserEmail())) {
                throw new IllegalStateException("먼저 이메일을 등록해 주세요.");
            }
            if (!user.isEmailVerified()) {
                throw new IllegalStateException("이메일 인증을 먼저 완료해 주세요.");
            }
        }

        if (needsPasswordForFirstLocalLogin) {
            validateNewPassword(newPassword);
        }

        if (user.getUserId() == null && hasText(normalizedUserId)) {
            authMapper.updateUserId(userIdx, normalizedUserId);
            recordSecurityEvent(userIdx, userIdx, "ID_LOGIN_ADD", "COMPLETE", normalizedUserId,
                    user.getUserEmail(), true, null, null, context);
        }

        if (needsPasswordForFirstLocalLogin) {
            authMapper.updatePassword(userIdx, bCryptPasswordEncoder.encode(newPassword));
            recordSecurityEvent(userIdx, userIdx, "PASSWORD_CHANGE", "COMPLETE",
                    normalizedUserId != null ? normalizedUserId : user.getUserId(), user.getUserEmail(),
                    true, null, "LOCAL_LOGIN_INITIAL_SET", context);
        }

        boolean emailLoginChanged = user.isEmailLoginEnabled() != enableEmailLogin;
        authMapper.updateEmailLoginEnabled(userIdx, enableEmailLogin);
        if (emailLoginChanged) {
            recordSecurityEvent(userIdx, userIdx, "EMAIL_LOGIN_TOGGLE", "COMPLETE",
                    user.getUserEmail(), user.getUserEmail(), true, null,
                    enableEmailLogin ? "ENABLE" : "DISABLE", context);
        }

        UsersVO after = authMapper.findByIdx(userIdx);
        if (!hasUsableLocalLogin(after) && after.isPasswordEnabled()) {
            authMapper.clearPasswordAndDisable(userIdx);
            recordSecurityEvent(userIdx, userIdx, "PASSWORD_CHANGE", "COMPLETE",
                    after.getUserId(), after.getUserEmail(), true, null,
                    "LOCAL_LOGIN_METHOD_REMOVED_AUTO_CLEAR", context);
            after = authMapper.findByIdx(userIdx);
        }

        return after;
    }

    // ════════════════════════════════════════════
    // 소셜 OAuth URL 생성
    // ════════════════════════════════════════════
    @Override
    public String getKakaoAuthUrl() {
        return "https://kauth.kakao.com/oauth/authorize"
                + "?client_id=" + kakaoClientId
                + "&redirect_uri=" + encode(kakaoRedirectUri)
                + "&response_type=code";
    }

    @Override
    public String getKakaoAuthUrl(boolean linkMode) {
        String redirectUri = linkMode ? kakaoLinkRedirectUri : kakaoRedirectUri;
        return "https://kauth.kakao.com/oauth/authorize"
                + "?client_id=" + kakaoClientId
                + "&redirect_uri=" + encode(redirectUri)
                + "&response_type=code";
    }

    @Override
    public String getKakaoLogoutUrl(String state) {
        StringBuilder url = new StringBuilder("https://kauth.kakao.com/oauth/logout")
                .append("?client_id=").append(kakaoClientId)
                .append("&logout_redirect_uri=").append(encode(kakaoLogoutRedirectUri));

        if (state != null && !state.isBlank()) {
            url.append("&state=").append(encode(state));
        }
        return url.toString();
    }

    @Override
    public String getNaverAuthUrl(String state) {
        return "https://nid.naver.com/oauth2.0/authorize"
                + "?response_type=code"
                + "&client_id=" + naverClientId
                + "&redirect_uri=" + encode(naverRedirectUri)
                + "&state=" + encode(state);
    }

    @Override
    public String getNaverAuthUrl(String state, boolean linkMode) {
        String redirectUri = linkMode ? naverLinkRedirectUri : naverRedirectUri;
        return "https://nid.naver.com/oauth2.0/authorize"
                + "?response_type=code&client_id=" + naverClientId
                + "&redirect_uri=" + encode(redirectUri)
                + "&state=" + encode(state);
    }

    @Override
    public String getGoogleAuthUrl(String state) {
        return "https://accounts.google.com/o/oauth2/v2/auth"
                + "?client_id=" + googleClientId
                + "&redirect_uri=" + encode(googleRedirectUri)
                + "&response_type=code"
                + "&scope=" + encode("openid email profile")
                + "&state=" + encode(state);
    }

    @Override
    public String getGoogleAuthUrl(String state, boolean linkMode) {
        String redirectUri = linkMode ? googleLinkRedirectUri : googleRedirectUri;
        return "https://accounts.google.com/o/oauth2/v2/auth"
                + "?client_id=" + googleClientId
                + "&redirect_uri=" + encode(redirectUri)
                + "&response_type=code"
                + "&scope=" + encode("openid email profile")
                + "&state=" + encode(state);
    }

    // ════════════════════════════════════════════
    // 소셜 콜백 처리
    // ════════════════════════════════════════════

    /** 반환: UsersVO (기존 유저) | SocialTempVO (신규 유저) */
    @Override
    public Object handleKakaoCallback(String code, HttpServletRequest request) {
        try {
            // 1) 인가 코드(code)를 이용해서 카카오 access token을 발급받는다.
            //    - 사용자가 카카오 로그인 화면에서 인증을 완료하면
            //      카카오가 우리 서버의 redirect URI로 code를 넘겨준다.
            //    - 이 code 자체로는 사용자 정보를 바로 조회할 수 없고,
            //      반드시 access token으로 교환해야 한다.
            String token = getKakaoAccessToken(code);

            // 2) 발급받은 access token으로 카카오 사용자 정보를 조회한다.
            //    - 여기서 받아오는 info는 카카오가 내려주는 JSON 전체 객체다.
            //    - 예: id, kakao_account, profile 등의 정보가 들어있다.
            JsonObject info = getKakaoUserInfo(token);

            // 3) 카카오에서 받아온 JSON을 우리 서비스 내부에서 공통으로 쓰는
            //    SocialUserInfo 객체로 변환한다.
            //    - provider        : 어떤 소셜 플랫폼인지 식별
            //    - providerUserId  : 해당 플랫폼에서의 고유 사용자 ID
            //    - email           : 소셜에서 제공하는 이메일
            //    - nickname        : 소셜에서 제공하는 닉네임
            //
            //    왜 굳이 SocialUserInfo로 감싸는가?
            //    - 카카오/네이버/구글은 응답 JSON 구조가 서로 다르다.
            //    - 하지만 우리 서비스 입장에서는 결국
            //      "provider, providerUserId, email, nickname" 정도만 필요하다.
            //    - 따라서 각 플랫폼별 JSON 차이는 여기서 흡수하고,
            //      이후 공통 로직(processSocialLogin)에서는 동일한 형태의 객체만 사용한다.
            SocialUserInfo socialInfo = SocialUserInfo.builder()
                    // 어떤 소셜 로그인인지 기록하기 위한 값
                    .provider("KAKAO")

                    // 카카오 사용자 고유 ID
                    // 카카오는 최상위 "id" 값을 사용자 식별자로 준다.
                    .providerUserId(info.get("id").getAsString())

                    // 이메일 추출
                    // 카카오는 이메일이 없을 수도 있고, 응답 구조가 중첩되어 있어서
                    // 별도 메서드(extractKakaoEmail)로 분리해둔 것이다.
                    .email(extractKakaoEmail(info))

                    // 닉네임 추출
                    // 카카오는 profile 내부에 nickname이 들어갈 수 있으므로
                    // 이것도 별도 메서드로 분리해서 안전하게 꺼낸다.
                    .nickname(extractKakaoNickname(info))
                    .build();

            // 4) HttpServletRequest 전체를 서비스 공통 로직에 넘기지 않고,
            //    필요한 정보(ipAddress, userAgent)만 LoginRequestContext로 변환한다.
            //    - buildContext(request)는 request에서 필요한 최소 정보만 추출한다.
            //    - 이렇게 하면 processSocialLogin이 HttpServletRequest에 직접 의존하지 않게 된다.
            //
            // 5) 공통 소셜 로그인 처리 메서드 호출
            //    - 이미 연동된 계정이면 UsersVO 반환
            //    - 처음 로그인한 사용자면 SocialTempVO 반환
            //    - 실패하면 null 반환 가능
            return processSocialLogin(socialInfo, buildContext(request));

        } catch (Exception e) {
            // 예외 발생 시 로그 기록
            // - 토큰 발급 실패
            // - 사용자 정보 조회 실패
            // - JSON 구조 예상과 다름
            // 등의 문제가 여기로 들어온다.
            log.error("[Kakao] 콜백 오류", e);

            // 현재 구조에서는 실패 시 null 반환
            // 이후 Controller 쪽에서 null을 보고 실패 처리하게 된다.
            return null;
        }
    }

    @Override
    public Object handleNaverCallback(String code, String state, HttpServletRequest request) {
        try {
            // 1) 네이버 인가 코드(code)와 state를 이용해 access token을 발급받는다.
            //    - 네이버는 보안 검증용으로 state도 함께 사용한다.
            //    - 사용자가 네이버 로그인 후 돌아오면 code와 state를 함께 받는다.
            String token = getNaverAccessToken(code, state);

            // 2) access token으로 네이버 사용자 정보를 조회한다.
            //    - 네이버 응답은 보통 최상위에 response라는 객체가 있고,
            //      실제 사용자 정보는 그 안에 들어있다.
            //    - 그래서 바로 getAsJsonObject("response")를 호출해
            //      실제 사용자 정보 부분만 꺼낸다.
            JsonObject info = getNaverUserInfo(token).getAsJsonObject("response");

            // 3) 네이버 사용자 정보를 우리 서비스 공통 형식(SocialUserInfo)으로 변환한다.
            //    - 네이버도 플랫폼 구조는 다르지만
            //      최종적으로 필요한 데이터는 카카오/구글과 동일하다.
            SocialUserInfo socialInfo = SocialUserInfo.builder()
                    // 어떤 소셜 플랫폼인지 명시
                    .provider("NAVER")

                    // 네이버에서 제공하는 사용자 고유 ID
                    .providerUserId(info.get("id").getAsString())

                    // 이메일은 제공되지 않을 수 있으므로 has("email")로 먼저 존재 여부를 확인한다.
                    // 없으면 null 저장
                    .email(info.has("email") ? info.get("email").getAsString() : null)

                    // 닉네임도 마찬가지로 있을 수도 있고 없을 수도 있다.
                    .nickname(info.has("nickname") ? info.get("nickname").getAsString() : null)
                    .build();

            // 4) request에서 필요한 최소 정보만 뽑아 context로 만든 뒤
            //    공통 소셜 로그인 처리 메서드로 넘긴다.
            //    - 이후부터는 네이버인지 카카오인지 구글인지에 상관없이
            //      동일한 로직으로 처리된다.
            return processSocialLogin(socialInfo, buildContext(request));

        } catch (Exception e) {
            // 네이버 토큰 발급 실패, 사용자 정보 조회 실패, JSON 파싱 실패 등
            // 모든 예외는 여기서 로그를 남기고 null 반환
            log.error("[Naver] 콜백 오류", e);
            return null;
        }
    }

    @Override
    public Object handleGoogleCallback(String code, HttpServletRequest request) {
        try {
            // 1) 구글에서 전달받은 인가 코드(code)로 access token 발급
            //    - 구글도 OAuth2 방식이므로
            //      code -> token -> user info 조회 순서로 진행된다.
            String token = getGoogleAccessToken(code);

            // 2) access token으로 구글 사용자 정보 조회
            //    - 구글은 보통 sub, email, name 등의 값을 포함한 JSON을 준다.
            JsonObject info = getGoogleUserInfo(token);

            // 3) 구글 응답을 우리 서비스 공통 객체로 변환
            SocialUserInfo socialInfo = SocialUserInfo.builder()
                    // 어떤 플랫폼인지 구분
                    .provider("GOOGLE")

                    // 구글 사용자 고유 ID
                    // 구글에서는 일반적으로 "sub"가 고유 식별자 역할을 한다.
                    .providerUserId(info.get("sub").getAsString())

                    // 이메일이 있으면 사용, 없으면 null
                    .email(info.has("email") ? info.get("email").getAsString() : null)

                    // 이름(name)이 있으면 nickname 용도로 사용
                    .nickname(info.has("name") ? info.get("name").getAsString() : null)
                    .build();

            // 4) request -> context 변환 후 공통 소셜 로그인 로직 호출
            //    - 이미 가입된 소셜 계정이면 UsersVO
            //    - 아직 미가입이면 SocialTempVO
            return processSocialLogin(socialInfo, buildContext(request));

        } catch (Exception e) {
            // 구글 인증 과정에서 발생한 예외 처리
            log.error("[Google] 콜백 오류", e);
            return null;
        }
    }

    /**
     * 소셜 로그인 공통 처리
     *  - 기존 연동 → UsersVO 반환 + 히스토리
     *  - 신규    → SocialTempVO 반환
     */
    private Object processSocialLogin(String provider, String providerUserId,
                                      String email, String nickname,
                                      HttpServletRequest request) {
        UserLoginHistoryVO.UserLoginHistoryVOBuilder history = UserLoginHistoryVO.builder()
                .authType("SOCIAL")
                .loginMethod(provider)
                .loginIdentifier(providerUserId)
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"));

        UserSocialVO social = authMapper.findSocialByProviderAndId(provider, providerUserId);

        if (social != null) {
            // 기존 연동 계정 → 로그인 처리
            UsersVO user = authMapper.findByIdx(social.getUserIdx());
            if (user == null || "DELETED".equals(user.getAccountStatus())) {
                authMapper.insertLoginHistory(history.success(false).failReason("ACCOUNT_DELETED").build());
                return null;
            }
            if ("DORMANT".equals(user.getAccountStatus())) {
                authMapper.insertLoginHistory(history.userIdx(user.getUserIdx()).success(false).failReason("ACCOUNT_DORMANT").build());
                return null;
            }
            authMapper.insertLoginHistory(history.userIdx(user.getUserIdx()).success(true).build());
            return user;
        } else {
            // 신규 → 추가 정보 입력 필요
            return SocialTempVO.builder()
                    .provider(provider)
                    .providerUserId(providerUserId)
                    .email(email)
                    .nickname(nickname)
                    .build();
        }
    }

    private Object processSocialLogin(SocialUserInfo info, LoginRequestContext context) {

        UserSocialVO social = authMapper.findSocialByProviderAndId(
                info.getProvider(),
                info.getProviderUserId()
        );

        if (social != null) {
            UsersVO user = authMapper.findByIdx(social.getUserIdx());

            if (user == null || "DELETED".equals(user.getAccountStatus())) {
                recordLoginResult(null, info.getProvider(), info.getProviderUserId(),
                        false, "ACCOUNT_DELETED", context);
                return null;
            }

            if ("DORMANT".equals(user.getAccountStatus())) {
                recordLoginResult(user.getUserIdx(), info.getProvider(), info.getProviderUserId(),
                        false, "ACCOUNT_DORMANT", context);
                return null;
            }

            recordLoginResult(user.getUserIdx(), info.getProvider(), info.getProviderUserId(),
                    true, null, context);

            return user;
        }

        // 신규 유저
        return SocialTempVO.builder()
                .provider(info.getProvider())
                .providerUserId(info.getProviderUserId())
                .email(info.getEmail())
                .nickname(info.getNickname())
                .build();
    }

    // ════════════════════════════════════════════
    // 소셜 연동용 콜백 처리 (링크 모드)
    // ════════════════════════════════════════════
    public String[] extractKakaoInfo(String code) throws Exception {
        String token = getKakaoAccessToken(code, kakaoLinkRedirectUri);
        return extractKakao(getKakaoUserInfo(token));
    }
    public String[] extractNaverInfo(String code, String state) throws Exception {
        String token = getNaverAccessToken(code, state, naverLinkRedirectUri);
        JsonObject resp = getNaverUserInfo(token).getAsJsonObject("response");
        return new String[]{ resp.get("id").getAsString(),
                resp.has("email") ? resp.get("email").getAsString() : null, null };
    }
    public String[] extractGoogleInfo(String code) throws Exception {
        String token = getGoogleAccessToken(code, googleLinkRedirectUri);
        JsonObject info = getGoogleUserInfo(token);
        return new String[]{ info.get("sub").getAsString(),
                info.has("email") ? info.get("email").getAsString() : null, null };
    }
    private String extractKakaoEmail(JsonObject info) {

        // kakao_account 자체가 없을 수도 있음
        if (!info.has("kakao_account")) return null;

        JsonObject account = info.getAsJsonObject("kakao_account");

        // email 필드가 없는 경우도 있음 (사용자가 동의 안 했을 수도 있음)
        if (!account.has("email")) return null;

        return account.get("email").getAsString();
    }
    private String extractKakaoNickname(JsonObject info) {

        if (!info.has("kakao_account")) return null;

        JsonObject account = info.getAsJsonObject("kakao_account");

        if (!account.has("profile")) return null;

        JsonObject profile = account.getAsJsonObject("profile");

        if (!profile.has("nickname")) return null;

        return profile.get("nickname").getAsString();
    }

    // ════════════════════════════════════════════
    // 소셜 신규 회원 등록 완료
    // ════════════════════════════════════════════
    @Override
    public UsersVO completeSocialRegister(SocialTempVO temp, String nickname,
                                          String nationality, String preferredLang,
                                          HttpServletRequest request) {
        // 회원 생성 (비밀번호 없음)
        UsersVO newUser = UsersVO.builder()
                .userEmail(temp.getEmail())
                .passwordEnabled(false)
                .emailVerified(temp.getEmail() != null) // 소셜 이메일은 일단 인증된 것으로
                .nickname(nickname)
                .nationality(nationality)
                .preferredLang(preferredLang)
                .accountStatus("ACTIVE")
                .build();
        authMapper.insertUser(newUser);

        // 소셜 연동
        authMapper.insertSocial(UserSocialVO.builder()
                .userIdx(newUser.getUserIdx())
                .provider(temp.getProvider())
                .providerUserId(temp.getProviderUserId())
                .build());

        // 히스토리
        authMapper.insertLoginHistory(UserLoginHistoryVO.builder()
                .userIdx(newUser.getUserIdx())
                .authType("SOCIAL")
                .loginMethod(temp.getProvider())
                .loginIdentifier(temp.getProviderUserId())
                .success(true)
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .build());

        return newUser;
    }

    // ════════════════════════════════════════════
    // 기존 계정에 소셜 연동 / 해제
    // ════════════════════════════════════════════
    @Override
    public void linkSocial(Long userIdx, String provider, String providerUserId) {
        // 이미 다른 계정에 연동된 소셜인지 체크
        UserSocialVO existing = authMapper.findSocialByProviderAndId(provider, providerUserId);
        if (existing != null) {
            throw new IllegalStateException("이미 다른 계정에 연동된 소셜 계정입니다.");
        }

        UserSocialVO myExisting = authMapper.findSocialByUserIdxAndProvider(userIdx, provider);
        if (myExisting != null) {
            throw new IllegalStateException("이미 연동된 " + provider + " 계정이 있습니다.");
        }
        authMapper.insertSocial(UserSocialVO.builder()
                .userIdx(userIdx)
                .provider(provider)
                .providerUserId(providerUserId)
                .build());
    }

    @Override
    public void unlinkSocial(Long userIdx, String provider) {
        UsersVO user = authMapper.findByIdx(userIdx);
        List<UserSocialVO> socials = authMapper.findSocialsByUserIdx(userIdx);
        long remainingSocials = socials.stream()
                .filter(s -> !provider.equalsIgnoreCase(s.getProvider()))
                .count();

        boolean hasIdLogin = hasUsableIdLogin(user);
        boolean hasEmailLogin = hasUsableEmailLogin(user);

        if (!hasIdLogin && !hasEmailLogin && remainingSocials <= 0) {
            throw new IllegalStateException("연동 해제 후 사용할 수 있는 로그인 수단이 남아 있지 않아 처리할 수 없습니다. 먼저 아이디 로그인, 이메일 로그인 또는 다른 소셜 연동을 추가해 주세요.");
        }
        authMapper.deleteSocial(userIdx, provider);
    }

    @Override
    public List<UserSocialVO> getSocials(Long userIdx) {
        return authMapper.findSocialsByUserIdx(userIdx);
    }

    @Override
    public Map<String, Boolean> getSocialLinkMap(Long userIdx) {
        List<UserSocialVO> list = authMapper.findSocialsByUserIdx(userIdx);
        Map<String, Boolean> map = new LinkedHashMap<>();
        map.put("KAKAO",  false);
        map.put("NAVER",  false);
        map.put("GOOGLE", false);
        for (UserSocialVO s : list) map.put(s.getProvider(), true);
        return map;
    }

    // ════════════════════════════════════════════
    // OAuth2 토큰 교환 / 사용자 정보 조회 (내부)
    // ════════════════════════════════════════════

    private String getKakaoAccessToken(String code) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type",   "authorization_code");
        params.add("client_id",    kakaoClientId);
        params.add("client_secret", kakaoClientSecret);
        params.add("redirect_uri", kakaoRedirectUri);
        params.add("code",         code);

        ResponseEntity<String> res = restTemplate.postForEntity(
                "https://kauth.kakao.com/oauth/token",
                new HttpEntity<>(params, headers), String.class);

        return JsonParser.parseString(res.getBody())
                .getAsJsonObject().get("access_token").getAsString();
    }

    private String getKakaoAccessToken(String code, String redirectUri) {
        HttpHeaders h = new HttpHeaders();
        h.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        MultiValueMap<String, String> p = new LinkedMultiValueMap<>();
        p.add("grant_type", "authorization_code");
        p.add("client_id", kakaoClientId);
        p.add("client_secret", kakaoClientSecret);
        p.add("redirect_uri", redirectUri);
        p.add("code", code);
        ResponseEntity<String> res = restTemplate.postForEntity(
                "https://kauth.kakao.com/oauth/token", new HttpEntity<>(p, h), String.class);
        return JsonParser.parseString(res.getBody()).getAsJsonObject().get("access_token").getAsString();
    }

    private JsonObject getKakaoUserInfo(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        ResponseEntity<String> res = restTemplate.exchange(
                "https://kapi.kakao.com/v2/user/me",
                HttpMethod.GET, new HttpEntity<>(headers), String.class);
        return JsonParser.parseString(res.getBody()).getAsJsonObject();
    }

    private String[] extractKakao(JsonObject obj) {
        String id = obj.get("id").getAsString();
        String email = null, nickname = null;
        if (obj.has("kakao_account")) {
            JsonObject acc = obj.getAsJsonObject("kakao_account");
            if (acc.has("email")) email = acc.get("email").getAsString();
            if (acc.has("profile")) {
                JsonObject prof = acc.getAsJsonObject("profile");
                if (prof.has("nickname")) nickname = prof.get("nickname").getAsString();
            }
        }
        return new String[]{id, email, nickname};
    }

    private String getNaverAccessToken(String code, String state) {
        String url = "https://nid.naver.com/oauth2.0/token"
                + "?grant_type=authorization_code"
                + "&client_id=" + naverClientId
                + "&client_secret=" + naverClientSecret
                + "&redirect_uri=" + encode(naverRedirectUri)
                + "&code=" + code
                + "&state=" + encode(state);
        String res = restTemplate.getForObject(url, String.class);
        return JsonParser.parseString(res).getAsJsonObject().get("access_token").getAsString();
    }

    private String getNaverAccessToken(String code, String state, String redirectUri) {
        String url = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
                + "&client_id=" + naverClientId + "&client_secret=" + naverClientSecret
                + "&redirect_uri=" + encode(redirectUri) + "&code=" + code + "&state=" + encode(state);
        String res = restTemplate.getForObject(url, String.class);
        return JsonParser.parseString(res).getAsJsonObject().get("access_token").getAsString();
    }

    private JsonObject getNaverUserInfo(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        ResponseEntity<String> res = restTemplate.exchange(
                "https://openapi.naver.com/v1/nid/me",
                HttpMethod.GET, new HttpEntity<>(headers), String.class);
        return JsonParser.parseString(res.getBody()).getAsJsonObject();
    }

    private String getGoogleAccessToken(String code) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("code",          code);
        params.add("client_id",     googleClientId);
        params.add("client_secret", googleClientSecret);
        params.add("redirect_uri",  googleRedirectUri);
        params.add("grant_type",    "authorization_code");

        ResponseEntity<String> res = restTemplate.postForEntity(
                "https://oauth2.googleapis.com/token",
                new HttpEntity<>(params, headers), String.class);

        return JsonParser.parseString(res.getBody())
                .getAsJsonObject().get("access_token").getAsString();
    }

    private String getGoogleAccessToken(String code, String redirectUri) {
        HttpHeaders h = new HttpHeaders(); h.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        MultiValueMap<String, String> p = new LinkedMultiValueMap<>();
        p.add("code", code); p.add("client_id", googleClientId);
        p.add("client_secret", googleClientSecret); p.add("redirect_uri", redirectUri);
        p.add("grant_type", "authorization_code");
        ResponseEntity<String> res = restTemplate.postForEntity(
                "https://oauth2.googleapis.com/token", new HttpEntity<>(p, h), String.class);
        return JsonParser.parseString(res.getBody()).getAsJsonObject().get("access_token").getAsString();
    }

    private JsonObject getGoogleUserInfo(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        ResponseEntity<String> res = restTemplate.exchange(
                "https://www.googleapis.com/oauth2/v3/userinfo",
                HttpMethod.GET, new HttpEntity<>(headers), String.class);
        return JsonParser.parseString(res.getBody()).getAsJsonObject();
    }

    // ════════════════════════════════════════════
    // 이메일 발송
    // ════════════════════════════════════════════
    private boolean sendMail(String to, String subject, String html) {
        try {
            var msg = mailSender.createMimeMessage();
            var helper = new MimeMessageHelper(msg, false, "UTF-8");
            helper.setFrom(mailFrom);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(html, true);
            mailSender.send(msg);
            return true;
        } catch (Exception e) {
            log.error("메일 발송 실패 to={}", to, e);
            return false;
        }
    }

    private String buildInfoEmailHtml(String title, String desc, String bodyHtml) {
        return """
            <!DOCTYPE html>
            <html>
            <body style="font-family:'Apple SD Gothic Neo',sans-serif;background:#f3f4f6;margin:0;padding:40px 16px">
              <div style="max-width:480px;margin:0 auto;background:#fff;border-radius:16px;
                          box-shadow:0 4px 20px rgba(0,0,0,.08);overflow:hidden">
                <div style="background:linear-gradient(135deg,#2563eb,#7c3aed);padding:28px 32px">
                  <span style="font-size:22px;font-weight:700;color:#fff">🌐 TripTogether</span>
                </div>
                <div style="padding:32px">
                  <h2 style="font-size:20px;font-weight:700;color:#1f2937;margin:0 0 12px">%s</h2>
                  <p style="font-size:14px;color:#6b7280;line-height:1.7;margin:0 0 20px">%s</p>
                  <div style="font-size:15px;color:#374151;line-height:1.8;background:#eff6ff;border:1px solid #bfdbfe;
                              border-radius:12px;padding:18px 20px;">
                    %s
                  </div>
                </div>
              </div>
            </body>
            </html>
            """.formatted(title, desc, bodyHtml);
    }

    private String buildEmailHtml(String title, String desc, String link, String btnText) {
        return """
            <!DOCTYPE html>
            <html>
            <body style="font-family:'Apple SD Gothic Neo',sans-serif;background:#f3f4f6;margin:0;padding:40px 16px">
              <div style="max-width:480px;margin:0 auto;background:#fff;border-radius:16px;
                          box-shadow:0 4px 20px rgba(0,0,0,.08);overflow:hidden">
                <div style="background:linear-gradient(135deg,#2563eb,#7c3aed);padding:28px 32px">
                  <span style="font-size:22px;font-weight:700;color:#fff">🌐 TripTogether</span>
                </div>
                <div style="padding:32px">
                  <h2 style="font-size:20px;font-weight:700;color:#1f2937;margin:0 0 12px">%s</h2>
                  <p style="font-size:14px;color:#6b7280;line-height:1.7;margin:0 0 28px">%s</p>
                  <a href="%s"
                     style="display:inline-block;padding:13px 28px;background:linear-gradient(135deg,#2563eb,#7c3aed);
                            color:#fff;text-decoration:none;border-radius:10px;font-weight:700;font-size:15px">
                    %s
                  </a>
                  <p style="font-size:12px;color:#9ca3af;margin:24px 0 0">
                    링크는 30분 후 만료됩니다. 요청하지 않으셨다면 이 이메일을 무시해주세요.
                  </p>
                </div>
              </div>
            </body>
            </html>
            """.formatted(title, desc, link, btnText);
    }

    // ════════════════════════════════════════════
    // 유틸
    // ════════════════════════════════════════════
    private void recordHistory(Long userIdx, String authType, String method,
                               String identifier, boolean success,
                               String failReason, HttpServletRequest request) {
        authMapper.insertLoginHistory(UserLoginHistoryVO.builder()
                .userIdx(userIdx).authType(authType).loginMethod(method)
                .loginIdentifier(identifier).success(success).failReason(failReason)
                .ipAddress(getClientIp(request)).userAgent(request.getHeader("User-Agent"))
                .build());
    }

    private void recordHistory(LoginHistoryCommand command) {
        authMapper.insertLoginHistory(UserLoginHistoryVO.builder()
                .userIdx(command.getUserIdx())
                .authType(command.getAuthType())
                .loginMethod(command.getLoginMethod())
                .loginIdentifier(command.getLoginIdentifier())
                .success(command.isSuccess())
                .failReason(command.getFailReason())
                .ipAddress(command.getIpAddress())
                .userAgent(command.getUserAgent())
                .build());
    }

    private void recordLoginResult(
            Long userIdx,
            String loginMethod,
            String identifier,
            boolean success,
            String failReason,
            LoginRequestContext context
    ) {
        recordHistory(LoginHistoryCommand.builder()
                .userIdx(userIdx)
                .authType("PASSWORD")
                .loginMethod(loginMethod)
                .loginIdentifier(identifier)
                .success(success)
                .failReason(failReason)
                .ipAddress(context.getIpAddress())
                .userAgent(context.getUserAgent())
                .build());
    }

    private void recordSecurityEvent(Long userIdx,
                                     Long actorUserIdx,
                                     String eventType,
                                     String eventStage,
                                     String inputIdentifier,
                                     String targetEmail,
                                     boolean success,
                                     String failReason,
                                     String detailMessage,
                                     LoginRequestContext context) {
        if (context == null) {
            context = LoginRequestContext.builder().build();
        }

        authMapper.insertSecurityHistory(UserSecurityHistoryVO.builder()
                .userIdx(userIdx)
                .actorUserIdx(actorUserIdx)
                .eventType(eventType)
                .eventStage(eventStage)
                .inputIdentifier(inputIdentifier)
                .targetEmail(targetEmail)
                .success(success)
                .failReason(failReason)
                .detailMessage(detailMessage)
                .ipAddress(context.getIpAddress())
                .userAgent(context.getUserAgent())
                .build());
    }

    private boolean hasUsableIdLogin(UsersVO user) {
        return user != null && hasText(user.getUserId()) && user.isPasswordEnabled()
                && !"DELETED".equalsIgnoreCase(user.getAccountStatus());
    }

    private boolean hasUsableEmailLogin(UsersVO user) {
        return user != null
                && hasText(user.getUserEmail())
                && user.isEmailVerified()
                && user.isEmailLoginEnabled()
                && user.isPasswordEnabled()
                && !"DELETED".equalsIgnoreCase(user.getAccountStatus());
    }

    private boolean hasUsableLocalLogin(UsersVO user) {
        return hasUsableIdLogin(user) || hasUsableEmailLogin(user);
    }

    private void validateNewPassword(String newPassword) {
        if (!hasText(newPassword) || newPassword.length() < 8) {
            throw new IllegalStateException("비밀번호는 8자 이상으로 설정해 주세요.");
        }
    }

    private boolean isRecoverableAccountStatus(String accountStatus) {
        if (accountStatus == null || accountStatus.isBlank()) {
            return true;
        }
        return !"DELETED".equalsIgnoreCase(accountStatus)
                && !"BLOCKED".equalsIgnoreCase(accountStatus);
    }

    private String maskUserId(String userId) {
        if (userId == null || userId.isBlank()) {
            return "";
        }

        int length = userId.length();
        if (length <= 2) {
            return "*".repeat(length);
        }
        if (length <= 4) {
            return userId.substring(0, 1) + "*".repeat(length - 2) + userId.substring(length - 1);
        }

        int visibleFront = Math.min(3, Math.max(1, length / 3));
        int visibleBack = length >= 7 ? 2 : 1;
        int maskLength = Math.max(1, length - visibleFront - visibleBack);
        return userId.substring(0, visibleFront)
                + "*".repeat(maskLength)
                + userId.substring(length - visibleBack);
    }

    private boolean hasText(String value) {
        return value != null && !value.isBlank();
    }

    private boolean isValidEmailFormat(String identifier) {
        if (identifier == null) return false;
        return identifier.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    }

    private LoginRequestContext buildContext(HttpServletRequest request) {
        return LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .build();
    }

    private String encode(String value) {
        return URLEncoder.encode(value, StandardCharsets.UTF_8);
    }

    private String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isBlank()) ip = request.getHeader("X-Real-IP");
        if (ip == null || ip.isBlank()) ip = request.getRemoteAddr();
        // 다중 IP인 경우 첫 번째만 사용
        if (ip != null && ip.contains(",")) ip = ip.split(",")[0].trim();
        return ip;
    }
}
