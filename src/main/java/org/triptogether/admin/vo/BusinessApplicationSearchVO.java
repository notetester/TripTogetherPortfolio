package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Set;

/**
 * 관리자 기업 신청 목록 검색/정렬/페이징 파라미터.
 *
 * <p>차단 관리/회원 관리와 동일하게 외부 요청값은 이 VO와 서비스 계층에서
 * 허용값 기준으로 정규화한 뒤 Mapper로 전달한다.</p>
 */
@Data
public class BusinessApplicationSearchVO {

    private static final Set<String> VALID_SEARCH_TYPES = Set.of("all", "applicant", "company", "manager", "businessNumber");
    private static final Set<String> VALID_STATUS = Set.of("ALL", "PENDING", "APPROVED", "REJECTED");
    private static final Set<String> VALID_REQUESTED_ROLE = Set.of("ALL", "BUSINESS", "PARTNER");
    private static final Set<String> VALID_SORT = Set.of(
            "createdAt", "reviewedAt", "applicant", "requestedRole", "company", "status", "reviewer", "applicationIdx"
    );
    private static final Set<String> VALID_MODE = Set.of("SERVER", "CLIENT");

    private String keyword;
    private String searchType;
    private String status;
    private String requestedRole;
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
        return value != null && VALID_STATUS.contains(value) ? value : "PENDING";
    }

    public String getRequestedRole() {
        String value = normalizeUpper(requestedRole);
        return value != null && VALID_REQUESTED_ROLE.contains(value) ? value : "ALL";
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
        return (size == 10 || size == 20 || size == 50 || size == 100) ? size : 20;
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
