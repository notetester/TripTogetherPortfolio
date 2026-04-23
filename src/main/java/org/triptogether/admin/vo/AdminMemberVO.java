package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
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
    private String        accountStatus;    // ACTIVE / DORMANT / BLOCKED / DELETED
    private String        userRole;         // USER / BUSINESS / PARTNER / BOT / ADMIN / SUPERADMIN / SYSTEM
    private String        memberGrade;
    private boolean       verifiedMember;
    private long          cashBalance;
    private long          mileageBalance;
    private long          pointBalance;
    private int           levelNo;
    private long          expPoints;
    private int           totalPostCount;
    private int           totalCommentCount;
    private LocalDateTime dormantAt;
    private boolean       dormantReleaseRequired;
    private LocalDateTime blockedUntil;
    private String        blockedReason;
    private String        adminPositionCode;
    private String        adminPermissionCode;
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

    public Date getCreatedAtDate() {
        if (createdAt == null) return null;
        return Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAt() {
        if (createdAt == null) return null;
        return Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getStatusChangedAtDate() {
        if (statusChangedAt == null) return null;
        return Date.from(statusChangedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getStatusChangedAt() {
        if (statusChangedAt == null) return null;
        return Date.from(statusChangedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getLastLoginAtDate() {
        if (lastLoginAt == null) return null;
        return Date.from(lastLoginAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getLastLoginAt() {
        if (lastLoginAt == null) return null;
        return Date.from(lastLoginAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
