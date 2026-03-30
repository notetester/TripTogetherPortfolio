package org.triptogether.auth.service;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
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

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final AuthMapper authMapper;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final RestTemplate restTemplate;

    // ──── Kakao ────
    @Value("${oauth.kakao.client-id}")       private String kakaoClientId;
    @Value("${oauth.kakao.client-secret}")   private String kakaoClientSecret;
    @Value("${oauth.kakao.redirect-uri}")    private String kakaoRedirectUri;

    // ──── Naver ────
    @Value("${oauth.naver.client-id}")       private String naverClientId;
    @Value("${oauth.naver.client-secret}")   private String naverClientSecret;
    @Value("${oauth.naver.redirect-uri}")    private String naverRedirectUri;

    // ──── Google ───
    @Value("${oauth.google.client-id}")      private String googleClientId;
    @Value("${oauth.google.client-secret}")  private String googleClientSecret;
    @Value("${oauth.google.redirect-uri}")   private String googleRedirectUri;

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
    public String getNaverAuthUrl(String state) {
        return "https://nid.naver.com/oauth2.0/authorize"
                + "?response_type=code"
                + "&client_id=" + naverClientId
                + "&redirect_uri=" + encode(naverRedirectUri)
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

    // ════════════════════════════════════════════
    // 소셜 콜백 처리
    // ════════════════════════════════════════════

    /** 반환: UsersVO (기존 유저) | SocialTempVO (신규 유저) */
    @Override
    public Object handleKakaoCallback(String code, HttpServletRequest request) {
        try {
            // 1) 토큰 교환
            String accessToken = getKakaoAccessToken(code);

            // 2) 사용자 정보
            JsonObject userInfo = getKakaoUserInfo(accessToken);
            String providerUserId = userInfo.get("id").getAsString();

            String email    = null;
            String nickname = null;
            if (userInfo.has("kakao_account")) {
                JsonObject account = userInfo.getAsJsonObject("kakao_account");
                if (account.has("email")) email = account.get("email").getAsString();
                if (account.has("profile")) {
                    JsonObject profile = account.getAsJsonObject("profile");
                    if (profile.has("nickname")) nickname = profile.get("nickname").getAsString();
                }
            }

            return processSocialLogin("KAKAO", providerUserId, email, nickname, request);

        } catch (Exception e) {
            log.error("[Kakao] 콜백 처리 실패: {}", e.getMessage(), e);
            return null;
        }
    }

    @Override
    public Object handleNaverCallback(String code, String state, HttpServletRequest request) {
        try {
            String accessToken = getNaverAccessToken(code, state);
            JsonObject userInfo = getNaverUserInfo(accessToken);
            JsonObject response = userInfo.getAsJsonObject("response");

            String providerUserId = response.get("id").getAsString();
            String email    = response.has("email")    ? response.get("email").getAsString()    : null;
            String nickname = response.has("nickname") ? response.get("nickname").getAsString() : null;

            return processSocialLogin("NAVER", providerUserId, email, nickname, request);

        } catch (Exception e) {
            log.error("[Naver] 콜백 처리 실패: {}", e.getMessage(), e);
            return null;
        }
    }

    @Override
    public Object handleGoogleCallback(String code, HttpServletRequest request) {
        try {
            String accessToken = getGoogleAccessToken(code);
            JsonObject userInfo = getGoogleUserInfo(accessToken);

            String providerUserId = userInfo.get("sub").getAsString();
            String email    = userInfo.has("email")  ? userInfo.get("email").getAsString()  : null;
            String nickname = userInfo.has("name")   ? userInfo.get("name").getAsString()   : null;

            return processSocialLogin("GOOGLE", providerUserId, email, nickname, request);

        } catch (Exception e) {
            log.error("[Google] 콜백 처리 실패: {}", e.getMessage(), e);
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
    // 기존 계정에 소셜 연동
    // ════════════════════════════════════════════
    @Override
    public void linkSocial(Long userIdx, String provider, String providerUserId) {
        UserSocialVO existing = authMapper.findSocialByUserIdxAndProvider(userIdx, provider);
        if (existing != null) {
            throw new IllegalStateException("이미 연동된 " + provider + " 계정이 있습니다.");
        }
        authMapper.insertSocial(UserSocialVO.builder()
                .userIdx(userIdx)
                .provider(provider)
                .providerUserId(providerUserId)
                .build());
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

    private JsonObject getKakaoUserInfo(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        ResponseEntity<String> res = restTemplate.exchange(
                "https://kapi.kakao.com/v2/user/me",
                HttpMethod.GET, new HttpEntity<>(headers), String.class);
        return JsonParser.parseString(res.getBody()).getAsJsonObject();
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

    private JsonObject getGoogleUserInfo(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        ResponseEntity<String> res = restTemplate.exchange(
                "https://www.googleapis.com/oauth2/v3/userinfo",
                HttpMethod.GET, new HttpEntity<>(headers), String.class);
        return JsonParser.parseString(res.getBody()).getAsJsonObject();
    }

    // ════════════════════════════════════════════
    // 유틸
    // ════════════════════════════════════════════
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
