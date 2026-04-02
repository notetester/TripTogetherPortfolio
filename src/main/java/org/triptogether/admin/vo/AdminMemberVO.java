package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 관리자 회원 목록/상세 VO
 * USERS + 소셜 연동 수 + 최근 로그인 정보를 JOIN해서 가져옴
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminMemberVO {

    // ── USERS 기본 정보 ──
    private Long          userIdx;
    private String        userId;
    private String        userEmail;
    private boolean       passwordEnabled;
    private boolean       emailVerified;
    private boolean       emailLoginEnabled;
    private String        accountStatus;    // ACTIVE / DORMANT / DELETED
    private String        userRole;         // USER / ADMIN
    private String        nickname;
    private String        nationality;
    private String        preferredLang;
    private LocalDateTime createdAt;
    private LocalDateTime statusChangedAt;

    // ── 집계 정보 (JOIN) ──
    private int           socialCount;      // 소셜 연동 수
    private String        linkedProviders;  // "KAKAO,NAVER" 형식
    private LocalDateTime lastLoginAt;      // 최근 로그인 시각
    private String        lastLoginMethod;  // 최근 로그인 방법
    private long          loginSuccessCount; // 로그인 성공 횟수
    private long          loginFailCount;   // 로그인 실패 횟수
}
