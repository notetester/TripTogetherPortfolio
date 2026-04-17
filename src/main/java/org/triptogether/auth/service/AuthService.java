package org.triptogether.auth.service;

import jakarta.servlet.http.HttpServletRequest;
import org.triptogether.auth.vo.LoginRequestContext;
import org.triptogether.auth.vo.SocialTempVO;
import org.triptogether.auth.vo.UserSocialVO;
import org.triptogether.auth.vo.UsersVO;

import java.util.List;
import java.util.Map;

public interface AuthService {

    // ─── 일반 로그인 ────────────────────────────
    /**
     * ID 또는 이메일 + 비밀번호로 로그인
     * @return 로그인 성공 시 UsersVO, 실패 시 null (+ 히스토리 기록)
     */
    UsersVO login(String identifier, String password, HttpServletRequest request);
    UsersVO login(String identifier, String password, LoginRequestContext context);

    // ─── 일반 회원가입 ──────────────────────────
    void register(UsersVO user);

    // ─── 중복 체크 ──────────────────────────────
    boolean isUserIdDuplicate(String userId);
    boolean isEmailDuplicate(String email);
    boolean isNicknameDuplicate(String nickname);

    // ── 아이디 찾기 ────────────────────────────
    UsersVO getUserByIdx(Long userIdx);

    /** 인증된 이메일 기준으로 아이디 힌트 안내 메일 발송 */
    void sendFindIdEmail(String email, LoginRequestContext context);

    /** FIND_ID 토큰 검증 → 마스킹된 userId 힌트 반환 (실패 시 null) */
    String verifyFindIdToken(String token, LoginRequestContext context);

    // ── 비밀번호 찾기 / 재설정 ─────────────────
    /** 아이디 또는 이메일 기준으로 비밀번호 재설정 안내 메일 발송 */
    void sendResetPasswordEmail(String identifier, LoginRequestContext context);

    /** RESET_PW 토큰 검증 → UsersVO 반환 (실패 시 null) */
    UsersVO verifyResetToken(String token, LoginRequestContext context);

    /** 토큰 검증 후 비밀번호 재설정 */
    boolean resetPassword(String token, String newPassword, LoginRequestContext context);

    // ── 프로필 수정 ────────────────────────────
    /** 비밀번호 재확인 (수정 페이지 진입 전) */
    boolean checkPassword(Long userIdx, String rawPassword);

    /** 기본 프로필 수정 (닉네임·국적·언어) */
    void updateProfile(UsersVO user);

    /** 비밀번호 변경 */
    void updatePassword(Long userIdx, String newRawPassword, LoginRequestContext context);

    // ── 이메일 인증 ────────────────────────────
    /** 회원정보 수정용 이메일 인증 메일 발송 (저장 전 인증 요청 생성) */
    boolean sendEmailVerification(Long userIdx, String requestId, String email, LoginRequestContext context);

    /** VERIFY 토큰 검증 → 이메일 인증 처리 */
    boolean verifyEmail(String token, LoginRequestContext context);

    /** 이메일 로그인 활성화/비활성화 토글 */
    void toggleEmailLogin(Long userIdx, boolean enable, LoginRequestContext context);

    /** 휴면 계정 해제 */
    UsersVO releaseDormantUser(Long userIdx, LoginRequestContext context);

    /** 1년 이상 미접속 회원을 휴면 전환 */
    void processDormantAccounts();

    // ─── 소셜 OAuth URL 생성 ────────────────────
    String getKakaoAuthUrl();
    String getKakaoAuthUrl(boolean linkMode);
    String getKakaoLogoutUrl(String state);
    String getNaverAuthUrl(String state);
    String getNaverAuthUrl(String state, boolean linkMode);
    String getGoogleAuthUrl(String state);
    String getGoogleAuthUrl(String state, boolean linkMode);

    // ─── 소셜 콜백 처리 ─────────────────────────
    /**
     * 소셜 code를 받아 사용자 정보를 가져오고
     *  - 기존 연동 계정 → UsersVO 반환
     *  - 신규 → SocialTempVO 반환 (추가 정보 입력 필요)
     * → 반환 타입을 Object로 두고 컨트롤러에서 instanceof 분기
     */
    Object handleKakaoCallback(String code, HttpServletRequest request);
    Object handleNaverCallback(String code, String state, HttpServletRequest request);
    Object handleGoogleCallback(String code, HttpServletRequest request);

    // ════════════════════════════════════════════
    // 소셜 연동용 콜백 처리 (링크 모드)
    // ════════════════════════════════════════════
    String[] extractKakaoInfo(String code) throws Exception;
    String[] extractNaverInfo(String code, String state) throws Exception;
    String[] extractGoogleInfo(String code) throws Exception;

    // ─── 소셜 신규 회원 등록 ─────────────────────
    /**
     * socialTemp + 추가 입력 정보(닉네임·국적·언어)로 신규 가입 완료
     */
    UsersVO completeSocialRegister(SocialTempVO temp, String nickname,
                                   String nationality, String preferredLang,
                                   HttpServletRequest request);

    // ─── 기존 계정에 소셜 연동 / 해제 ──────────────────
    void linkSocial(Long userIdx, String provider, String providerUserId);
    void unlinkSocial(Long userIdx, String provider);

    /** 특정 유저의 소셜 연동 목록 */
    List<UserSocialVO> getSocials(Long userIdx);

    /** provider → provider별 연동 여부 Map (KAKAO/NAVER/GOOGLE) */
    Map<String, Boolean> getSocialLinkMap(Long userIdx);
}
