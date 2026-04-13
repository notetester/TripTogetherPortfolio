package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminEmailVerificationSearchVO {
    private String keyword;
    private String purpose; // ALL / FIND_ID / RESET_PW / VERIFY / PROFILE_EMAIL
    private String used;    // ALL / USED / UNUSED
    private int page = 1;
    private int size = 30;

    public int getOffset() {
        return (page - 1) * size;
    }

    public String getPurpose() { return purpose != null ? purpose : "ALL"; }
    public String getUsed() { return used != null ? used : "ALL"; }
}
