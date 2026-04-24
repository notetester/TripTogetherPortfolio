package org.triptogether.auth.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.auth.vo.EmailVerificationRequestVO;
import org.triptogether.auth.vo.EmailVerificationVO;
import org.triptogether.auth.vo.UserLoginHistoryVO;
import org.triptogether.auth.vo.UserSecurityHistoryVO;
import org.triptogether.auth.vo.UserSocialVO;
import org.triptogether.auth.vo.UsersVO;

import java.util.List;

@Mapper
public interface AuthMapper {

    // ─────────────────────────────────────────
    // USERS
    // ─────────────────────────────────────────

    /** ID로 회원 조회 */
    UsersVO findByUserId(String userId);

    /** 이메일로 회원 조회 */
    UsersVO findByEmail(String email);

    /** PK로 회원 조회 */
    UsersVO findByIdx(Long userIdx);

    /** userId 중복 여부 */
    boolean existsByUserId(String userId);

    /** email 중복 여부 */
    boolean existsByEmail(String email);

    /** nickname 중복 여부 */
    boolean existsByNickname(String nickname);

    /** 이메일로 userId 반환 (아이디 찾기용 - 인증 완료 이메일만) */
    String findUserIdByEmail(String email);

    // ══════════════════════════════════════════
    // USERS - 등록 / 수정
    // ══════════════════════════════════════════

    /** 회원 가입 (insertId → userIdx 자동 세팅) */
    void insertUser(UsersVO user);

    /** 프로필 기본정보 수정 (닉네임·국적·언어) */
    void updateProfile(UsersVO user);

    /** 비밀번호 변경 */
    void updatePassword(@Param("userIdx") Long userIdx,
                        @Param("encodedPassword") String encodedPassword);

    /** 로컬 비밀번호 제거 및 비밀번호 로그인 비활성화 */
    void clearPasswordAndDisable(Long userIdx);

    /** 아이디 1회 등록 */
    void updateUserId(@Param("userIdx") Long userIdx,
                      @Param("userId") String userId);

    /** 이메일 + 인증 상태 업데이트 */
    void updateEmail(@Param("userIdx") Long userIdx,
                     @Param("email") String email,
                     @Param("emailVerified") boolean emailVerified);

    /** 이메일 인증 여부만 업데이트 */
    void updateEmailVerified(@Param("userIdx") Long userIdx,
                             @Param("emailVerified") boolean emailVerified);

    /** 이메일 로그인 활성화 토글 */
    void updateEmailLoginEnabled(@Param("userIdx") Long userIdx,
                                 @Param("enabled") boolean enabled);

    /** 비밀번호 직접 리셋 (토큰 검증 후) */
    void resetPassword(@Param("userIdx") Long userIdx,
                       @Param("encodedPassword") String encodedPassword);

    /** 마지막 로그인 시각 업데이트 */
    void updateLastLoginAt(Long userIdx);

    /** 인증 회원 여부 재계산 */
    void refreshVerifiedMemberFlag(Long userIdx);

    /** 휴면 자동 전환 대상 조회 */
    List<UsersVO> findDormantCandidates(@Param("cutoff") java.time.LocalDateTime cutoff);

    /** ACTIVE -> DORMANT 전환 */
    void markUserDormant(Long userIdx);

    /** DORMANT -> ACTIVE 해제 */
    void releaseDormantUser(Long userIdx);

    /** 차단 상태 해제 */
    void clearBlockState(Long userIdx);

    // ─────────────────────────────────────────
    // USER_SOCIAL
    // ─────────────────────────────────────────

    /** provider + providerUserId로 소셜 연동 조회 */
    UserSocialVO findSocialByProviderAndId(
            @Param("provider") String provider,
            @Param("providerUserId") String providerUserId);

    /** userIdx + provider로 소셜 연동 조회 */
    UserSocialVO findSocialByUserIdxAndProvider(
            @Param("userIdx") Long userIdx,
            @Param("provider") String provider);

    /** 특정 유저의 소셜 연동 전체 조회 */
    List<UserSocialVO> findSocialsByUserIdx(Long userIdx);

    /** 소셜 연동 추가 */
    void insertSocial(UserSocialVO social);

    /** 소셜 연동 해제 */
    void deleteSocial(@Param("userIdx") Long userIdx,
                      @Param("provider") String provider);

    // ─────────────────────────────────────────
    // USER_LOGIN_HISTORY
    // ─────────────────────────────────────────

    /** 로그인 이력 저장 */
    void insertLoginHistory(UserLoginHistoryVO history);

    /** 계정 보안 / 복구 이벤트 이력 저장 */
    void insertSecurityHistory(UserSecurityHistoryVO history);

    // ══════════════════════════════════════════
    // EMAIL_VERIFICATION_REQUEST
    // ══════════════════════════════════════════

    /** 이메일 액션 요청 헤더 생성 */
    void insertEmailVerificationRequest(EmailVerificationRequestVO request);

    /** 동일 user/purpose 의 미적용 요청 취소 */
    void cancelActiveEmailVerificationRequests(@Param("userIdx") Long userIdx,
                                               @Param("purpose") String purpose);

    /** 토큰 기준 유효한 이메일 액션 요청 조회 */
    EmailVerificationRequestVO findValidEmailVerificationRequestByToken(@Param("token") String token,
                                                                        @Param("purpose") String purpose);

    /** 특정 이메일 인증 요청 취소 */
    void cancelEmailVerificationRequest(Long emailVerificationRequestIdx);

    /** 사용자/요청/request 이메일 기준 저장 가능 상태 조회 (주로 PROFILE_EMAIL) */
    EmailVerificationRequestVO findApplicableEmailVerificationRequest(@Param("userIdx") Long userIdx,
                                                                      @Param("requestId") String requestId,
                                                                      @Param("purpose") String purpose,
                                                                      @Param("pendingEmail") String pendingEmail);

    /** 사용자/요청/request 이메일 기준 최신 요청 상태 조회 */
    EmailVerificationRequestVO findLatestEmailVerificationRequest(@Param("userIdx") Long userIdx,
                                                                  @Param("requestId") String requestId,
                                                                  @Param("purpose") String purpose,
                                                                  @Param("pendingEmail") String pendingEmail);

    /** 이메일 인증 요청을 VERIFIED 로 변경 */
    void markEmailVerificationRequestVerified(Long emailVerificationRequestIdx);

    /** 이메일 인증 요청을 APPLIED 로 변경 */
    void markEmailVerificationRequestApplied(Long emailVerificationRequestIdx);

    // ══════════════════════════════════════════
    // EMAIL_VERIFICATION
    // ══════════════════════════════════════════

    void insertEmailVerification(EmailVerificationVO ev);

    /** 유효한 토큰 조회 (만료 전 + 미사용) */
    EmailVerificationVO findValidToken(@Param("token") String token,
                                       @Param("purpose") String purpose);

    /** 토큰 사용 처리 */
    void markTokenUsed(Long verifyIdx);

    /** 요청 ID 기준으로 연결된 토큰을 취소(무효) 처리 */
    void cancelTokensByRequestId(String requestId);

    /** 동일 이메일+목적의 미사용 토큰 전체 만료 처리 (중복 발급 방지) */
    void expireOldTokens(@Param("email") String email,
                         @Param("purpose") String purpose);

    /** 이메일 인증 토큰으로 flowTraceId 조회 (만료/사용 여부 무관 — 흐름 추적 복원용) */
    String findFlowTraceIdByToken(String token);
}
