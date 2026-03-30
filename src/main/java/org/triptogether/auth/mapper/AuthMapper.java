package org.triptogether.auth.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.auth.vo.UserLoginHistoryVO;
import org.triptogether.auth.vo.UserSocialVO;
import org.triptogether.auth.vo.UsersVO;

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

    /** 회원 가입 (insertId → userIdx 자동 세팅) */
    void insertUser(UsersVO user);

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

    /** 소셜 연동 추가 */
    void insertSocial(UserSocialVO social);

    // ─────────────────────────────────────────
    // USER_LOGIN_HISTORY
    // ─────────────────────────────────────────

    /** 로그인 이력 저장 */
    void insertLoginHistory(UserLoginHistoryVO history);
}
