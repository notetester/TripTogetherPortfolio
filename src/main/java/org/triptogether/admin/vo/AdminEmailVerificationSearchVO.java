package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Set;

@Data
public class AdminEmailVerificationSearchVO {
    private static final Set<String> VALID_PURPOSE = Set.of("ALL", "FIND_ID", "RESET_PW", "VERIFY", "PROFILE_EMAIL");
    private static final Set<String> VALID_USED = Set.of("ALL", "USED", "UNUSED");
    private static final Set<String> VALID_SORT = Set.of("time", "member", "targetEmail", "requestId", "purpose", "used", "usedAt", "expiresAt");
    private static final Set<String> VALID_MODE = Set.of("SERVER", "CLIENT");

    private String keyword;
    private String purpose; // ALL / FIND_ID / RESET_PW / VERIFY / PROFILE_EMAIL
    private String used;    // ALL / USED / UNUSED
    private String dateFilter;  // yyyy-MM-dd (created_at)
    private String sortField;   // time / member / targetEmail / requestId / purpose / used / usedAt / expiresAt
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

    public String getPurpose() {
        String value = normalizeUpper(purpose);
        return value != null && VALID_PURPOSE.contains(value) ? value : "ALL";
    }

    public String getUsed() {
        String value = normalizeUpper(used);
        return value != null && VALID_USED.contains(value) ? value : "ALL";
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
