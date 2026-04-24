package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminEmailVerificationSearchVO {
    private String keyword;
    private String purpose; // ALL / FIND_ID / RESET_PW / VERIFY / PROFILE_EMAIL
    private String used;    // ALL / USED / UNUSED
    private String dateFilter;  // yyyy-MM-dd (created_at)
    private String sortField;   // time / purpose / used / usedAt / expiresAt
    private String sortDir;     // ASC / DESC
    private int page = 1;
    private int size = 30;

    public int getOffset() {
        return (page - 1) * size;
    }

    public String getPurpose() { return purpose != null ? purpose : "ALL"; }
    public String getUsed() { return used != null ? used : "ALL"; }
    public String getSortField() { return sortField != null ? sortField : ""; }
    public String getSortDir() { return "ASC".equals(sortDir) ? "ASC" : "DESC"; }
}
