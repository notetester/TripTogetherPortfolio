package org.triptogether.admin.vo;

import lombok.Data;

/**
 * 관리자 이메일 인증 요청 이력 검색 조건.
 */
@Data
public class AdminEmailVerificationRequestSearchVO {
    private String keyword;
    private String status;   // ALL / REQUESTED / VERIFIED / APPLIED / EXPIRED / CANCELLED
    private String purpose;  // ALL / PROFILE_EMAIL
    private String dateFilter;  // yyyy-MM-dd (requested_at)
    private String sortField;   // time / purpose / status / verifiedAt / appliedAt / expiresAt / ip
    private String sortDir;     // ASC / DESC
    private int page = 1;
    private int size = 30;

    public int getOffset() {
        return (page - 1) * size;
    }

    public String getStatus() { return status != null ? status : "ALL"; }
    public String getPurpose() { return purpose != null ? purpose : "ALL"; }
    public String getSortField() { return sortField != null ? sortField : ""; }
    public String getSortDir() { return "ASC".equals(sortDir) ? "ASC" : "DESC"; }
}
