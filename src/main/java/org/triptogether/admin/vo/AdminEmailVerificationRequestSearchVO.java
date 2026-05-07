package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Set;

/**
 * 관리자 이메일 인증 요청 이력 검색 조건.
 */
@Data
public class AdminEmailVerificationRequestSearchVO {
    private static final Set<String> VALID_STATUS = Set.of("ALL", "REQUESTED", "VERIFIED", "APPLIED", "EXPIRED", "CANCELLED");
    private static final Set<String> VALID_PURPOSE = Set.of("ALL", "PROFILE_EMAIL", "FIND_ID", "RESET_PW", "VERIFY");
    private static final Set<String> VALID_SORT = Set.of("time", "member", "requestEmail", "requestId", "purpose", "status", "verifiedAt", "appliedAt", "expiresAt", "ip");
    private static final Set<String> VALID_MODE = Set.of("SERVER", "CLIENT");

    private String keyword;
    private String status;   // ALL / REQUESTED / VERIFIED / APPLIED / EXPIRED / CANCELLED
    private String purpose;  // ALL / PROFILE_EMAIL
    private String dateFilter;  // yyyy-MM-dd (requested_at)
    private String sortField;   // time / member / requestEmail / requestId / purpose / status / verifiedAt / appliedAt / expiresAt / ip
    private String sortDir;     // ASC / DESC
    private String mode;        // SERVER / CLIENT
    private boolean paged = true;
    private int page = 1;
    private int size = 30;

    public int getOffset() {
        return (getPage() - 1) * getSize();
    }

    public String getKeyword() {
        return normalizeText(keyword);
    }

    public String getStatus() {
        String value = normalizeUpper(status);
        return value != null && VALID_STATUS.contains(value) ? value : "ALL";
    }

    public String getPurpose() {
        String value = normalizeUpper(purpose);
        return value != null && VALID_PURPOSE.contains(value) ? value : "ALL";
    }

    public String getDateFilter() {
        String value = normalizeText(dateFilter);
        return value != null && value.matches("\\d{4}-\\d{2}-\\d{2}") ? value : null;
    }

    public String getSortField() {
        String value = normalizeText(sortField);
        return value != null && VALID_SORT.contains(value) ? value : "";
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
        return (size == 15 || size == 30 || size == 50 || size == 100) ? size : 30;
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
