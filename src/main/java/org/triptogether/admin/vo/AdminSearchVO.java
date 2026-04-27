package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Set;

/**
 * 관리자 회원 목록 검색/정렬/페이징 파라미터 VO.
 *
 * <p>MyBatis ORDER BY에 들어갈 수 있는 값은 getter에서 whitelist로 보정한다.
 * 컨트롤러/Mapper가 외부 요청값을 그대로 신뢰하지 않도록 이 VO에서 1차 정규화한다.</p>
 */
@Data
public class AdminSearchVO {

    private static final Set<String> VALID_SEARCH_TYPES = Set.of("all", "userId", "nickname", "email");
    private static final Set<String> VALID_STATUS = Set.of("ALL", "ACTIVE", "DORMANT", "BLOCKED", "DELETED");
    private static final Set<String> VALID_ROLE = Set.of("ALL", "USER", "BUSINESS", "PARTNER", "BOT", "ADMIN", "SUPERADMIN", "SYSTEM");
    private static final Set<String> VALID_PROVIDER = Set.of("ALL", "KAKAO", "NAVER", "GOOGLE", "NONE");
    private static final Set<String> VALID_SORT = Set.of(
        "createdAt", "lastLoginAt", "nickname", "email", "status", "role",
        "userIdx", "memberGrade", "levelNo", "loginSuccessCount", "loginFailCount", "social", "socialCount"
    );
    private static final Set<String> VALID_MODE = Set.of("SERVER", "CLIENT");

    private String keyword;
    private String searchType;

    private String status;
    private String role;
    private String provider;
    private String dateFrom;
    private String dateTo;

    private String sortBy;
    private String sortDir;
    private String mode;

    private int page = 1;
    private int size = 20;

    public int getOffset() {
        return (getPage() - 1) * getSize();
    }

    public String getKeyword() {
        return normalizeText(keyword);
    }

    public String getSearchType() {
        String value = normalizeText(searchType);
        return value != null && VALID_SEARCH_TYPES.contains(value) ? value : "all";
    }

    public String getStatus() {
        String value = normalizeUpper(status);
        return value != null && VALID_STATUS.contains(value) ? value : "ALL";
    }

    public String getRole() {
        String value = normalizeUpper(role);
        return value != null && VALID_ROLE.contains(value) ? value : "ALL";
    }

    public String getProvider() {
        String value = normalizeUpper(provider);
        return value != null && VALID_PROVIDER.contains(value) ? value : "ALL";
    }

    public String getDateFrom() {
        return normalizeDate(dateFrom);
    }

    public String getDateTo() {
        return normalizeDate(dateTo);
    }

    public String getSortBy() {
        String value = normalizeText(sortBy);
        return value != null && VALID_SORT.contains(value) ? value : "createdAt";
    }

    public String getSortDir() {
        return "ASC".equalsIgnoreCase(normalizeText(sortDir)) ? "ASC" : "DESC";
    }

    public String getMode() {
        String value = normalizeUpper(mode);
        return value != null && VALID_MODE.contains(value) ? value : "SERVER";
    }

    public int getPage() {
        return Math.max(page, 1);
    }

    public int getSize() {
        if (size == 10 || size == 20 || size == 50 || size == 100) {
            return size;
        }
        return 20;
    }

    private String normalizeDate(String value) {
        String trimmed = normalizeText(value);
        return trimmed != null && trimmed.matches("\\d{4}-\\d{2}-\\d{2}") ? trimmed : null;
    }

    private String normalizeText(String value) {
        if (value == null) return null;
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private String normalizeUpper(String value) {
        String trimmed = normalizeText(value);
        return trimmed == null ? null : trimmed.toUpperCase();
    }
}
