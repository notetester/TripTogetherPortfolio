package org.triptogether.auth.vo;

import lombok.Data;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

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
    /** 이메일 인증 완료 + 사용자 직접 활성화 시 이메일로도 로그인 가능 */
    private boolean emailLoginEnabled;

    /** 계정 상태: ACTIVE / DORMANT / BLOCKED / DELETED */
    @Builder.Default
    private String accountStatus = "ACTIVE";
    @Builder.Default
    private String userRole="USER";

    private String memberGrade;      // BRONZE / SILVER / GOLD / DIAMOND / PLATINUM
    private boolean verifiedMember;  // 소셜 연동 회원 또는 이메일 인증 회원
    private long cashBalance;        // 보유 캐쉬
    private long mileageBalance;     // 보유 마일리지
    private long pointBalance;       // 커뮤니티 포인트
    private int levelNo;             // 현재 레벨
    private long expPoints;          // 누적 경험치
    private int totalPostCount;      // 작성 게시글 수
    private int totalCommentCount;   // 작성 댓글 수
    private LocalDateTime lastLoginAt;
    private LocalDateTime dormantAt;
    private boolean dormantReleaseRequired;
    private LocalDateTime blockedUntil;
    private String blockedReason;

    private String adminPositionCode; // 관리자 직책 코드
    private String adminPermissionCode; // 실효 권한 코드

    private LocalDateTime statusChangedAt;

    private String nickname;        // 닉네임 (UNIQUE)
    private String nationality;     // 국적
    private String preferredLang;   // 선호 언어 (ko, en, ja, zh)

    private LocalDateTime createdAt;

    /**
     * DB에는 user_role이 문자열로 저장되므로, Java 정책 판단이 필요할 때 enum으로 변환해서 사용한다.
     */
    public UserRole role() {
        return UserRole.from(userRole);
    }

    public boolean hasAdminRole() {
        return role().isAdminLike();
    }

    public boolean hasUserLikeRole() {
        return role().isUserLike();
    }

    public boolean canManagePackage() {
        return role().canManagePackage();
    }

    public boolean canApprovePackage() {
        return role().canApprovePackage();
    }

    public boolean isProtectedRole() {
        return role().isProtectedRole();
    }

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getLastLoginAtDate() {
        return fromLocalDateTime(lastLoginAt);
    }

    public Date getDormantAtDate() {
        return fromLocalDateTime(dormantAt);
    }

    public Date getBlockedUntilDate() {
        return fromLocalDateTime(blockedUntil);
    }

    public Date getStatusChangedAtDate() {
        return fromLocalDateTime(statusChangedAt);
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

}
