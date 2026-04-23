package org.triptogether.auth.vo;

import java.util.Arrays;
import java.util.Optional;
import java.util.Set;

/**
 * USERS.user_role 값의 기준 enum.
 *
 * <p>DB에는 문자열 코드(USER, ADMIN 등)로 저장하지만, Java 코드에서는 이 enum을 통해
 * "관리자 계열인지", "일반 사용자 성격인지", "패키지 상품을 등록할 수 있는지" 같은 정책을 판단한다.</p>
 *
 * <p>중요: role이 하나 늘어날 때마다 각 컨트롤러에서 문자열 비교를 추가하지 말고,
 * 이 enum의 정책 메서드만 먼저 점검하는 방향으로 관리한다.</p>
 */
public enum UserRole {
    USER,
    BUSINESS,
    PARTNER,
    BOT,
    ADMIN,
    SUPERADMIN,
    SYSTEM;

    /**
     * 일반 사용자처럼 서비스에 참여할 수 있는 계정 성격.
     * 커뮤니티 글쓰기, 리뷰 작성, 일반 화면 사용 같은 "유저 활동" 기준으로 묶는다.
     */
    private static final Set<UserRole> USER_LIKE_ROLES = Set.of(
            USER,
            BUSINESS,
            PARTNER,
            BOT
    );

    /**
     * 관리자 화면이나 운영 기능에 접근 가능한 계정 성격.
     */
    private static final Set<UserRole> ADMIN_LIKE_ROLES = Set.of(
            ADMIN,
            SUPERADMIN
    );

    /**
     * 패키지 상품을 직접 등록/관리할 수 있는 기업 계정 성격.
     */
    private static final Set<UserRole> PACKAGE_MANAGER_ROLES = Set.of(
            BUSINESS,
            PARTNER
    );

    /**
     * 기업/파트너가 등록한 패키지 상품을 승인하거나 반려할 수 있는 운영 계정 성격.
     */
    private static final Set<UserRole> PACKAGE_APPROVER_ROLES = ADMIN_LIKE_ROLES;

    /**
     * 일반 관리자 페이지에서 회원 role 변경 시 허용할 수 있는 값.
     * SUPERADMIN / SYSTEM은 별도 최고관리자 흐름에서만 다루는 것이 안전하다.
     */
    private static final Set<UserRole> MEMBER_ADMIN_ASSIGNABLE_ROLES = Set.of(
            USER,
            BUSINESS,
            PARTNER,
            BOT,
            ADMIN
    );

    /**
     * 일반 관리자 화면에서 상태 변경/차단/role 변경 대상으로 삼으면 위험한 내부 보호 계정.
     */
    private static final Set<UserRole> PROTECTED_ROLES = Set.of(
            SUPERADMIN,
            SYSTEM
    );

    public String code() {
        return name();
    }

    public boolean isUserLike() {
        return USER_LIKE_ROLES.contains(this);
    }

    public boolean isAdminLike() {
        return ADMIN_LIKE_ROLES.contains(this);
    }

    public boolean isSuperAdmin() {
        return this == SUPERADMIN;
    }

    public boolean isBot() {
        return this == BOT;
    }

    public boolean isSystemRole() {
        return this == SYSTEM;
    }

    public boolean isProtectedRole() {
        return PROTECTED_ROLES.contains(this);
    }

    public boolean canManagePackage() {
        return PACKAGE_MANAGER_ROLES.contains(this);
    }

    public boolean canApprovePackage() {
        return PACKAGE_APPROVER_ROLES.contains(this);
    }

    public boolean isMemberAdminAssignable() {
        return MEMBER_ADMIN_ASSIGNABLE_ROLES.contains(this);
    }

    /**
     * 외부 입력값을 enum으로 엄격하게 변환한다.
     * 잘못된 role 변경 요청을 USER로 조용히 바꾸면 권한 버그가 생길 수 있으므로 Optional로 반환한다.
     */
    public static Optional<UserRole> parse(String value) {
        if (value == null || value.isBlank()) {
            return Optional.empty();
        }
        String normalized = value.trim().toUpperCase();
        return Arrays.stream(values())
                .filter(role -> role.name().equals(normalized))
                .findFirst();
    }

    /**
     * 세션/DB 조회값을 권한 판단에 사용할 때의 안전 변환.
     * 기존 계정의 role 값이 null이거나 알 수 없는 값이면 일반 사용자로 간주해 과권한을 방지한다.
     */
    public static UserRole from(String value) {
        return parse(value).orElse(USER);
    }
}
