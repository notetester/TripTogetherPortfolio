package org.triptogether.auth.service;

import jakarta.servlet.http.HttpServletRequest;
import org.triptogether.auth.vo.SocialTempVO;
import org.triptogether.auth.vo.UsersVO;

public interface AuthService {

    // ─── 일반 로그인 ────────────────────────────
    /**
     * ID 또는 이메일 + 비밀번호로 로그인
     * @return 로그인 성공 시 UsersVO, 실패 시 null (+ 히스토리 기록)
     */
    UsersVO login(String identifier, String password, HttpServletRequest request);

    // ─── 일반 회원가입 ──────────────────────────
    void register(UsersVO user);

    // ─── 중복 체크 ──────────────────────────────
    boolean isUserIdDuplicate(String userId);
    boolean isEmailDuplicate(String email);
    boolean isNicknameDuplicate(String nickname);

    // ─── 소셜 OAuth URL 생성 ────────────────────
    String getKakaoAuthUrl();
    String getNaverAuthUrl(String state);
    String getGoogleAuthUrl(String state);

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

    // ─── 소셜 신규 회원 등록 ─────────────────────
    /**
     * socialTemp + 추가 입력 정보(닉네임·국적·언어)로 신규 가입 완료
     */
    UsersVO completeSocialRegister(SocialTempVO temp, String nickname,
                                   String nationality, String preferredLang,
                                   HttpServletRequest request);

    // ─── 기존 계정에 소셜 연동 ──────────────────
    void linkSocial(Long userIdx, String provider, String providerUserId);
}
