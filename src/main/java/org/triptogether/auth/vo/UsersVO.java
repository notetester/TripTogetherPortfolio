package org.triptogether.auth.vo;

import lombok.Data;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

/**
 * USERS 테이블 VO
 * - 일반 로그인 / 소셜 로그인 모두 사용
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UsersVO {

    private Long userIdx;           // PK (AUTO_INCREMENT)

    private String userId;          // 일반 로그인 ID (소셜 전용 계정은 null)
    private String userEmail;       // 이메일 (선택)
    private String userPassword;    // BCrypt 해시 비밀번호
    private boolean passwordEnabled; // 비밀번호 로그인 가능 여부

    private boolean emailVerified;  // 이메일 인증 여부

    /** 계정 상태: ACTIVE / DORMANT / DELETED */
    @Builder.Default
    private String accountStatus = "ACTIVE";

    private LocalDateTime statusChangedAt;

    private String nickname;        // 닉네임 (UNIQUE)
    private String nationality;     // 국적
    private String preferredLang;   // 선호 언어 (ko, en, ja, zh)

    private LocalDateTime createdAt;
}
