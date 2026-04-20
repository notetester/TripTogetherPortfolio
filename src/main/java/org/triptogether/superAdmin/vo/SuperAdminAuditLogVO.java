package org.triptogether.superAdmin.vo;

import lombok.Data;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class SuperAdminAuditLogVO {
    private Long adminPermissionIdx;
    private Long userIdx;
    private String permissionCode;
    private String displayName;
    private boolean active;
    private String grantedByNickname;
    private String requestedByNickname;
    private String approvedByNickname;
    private String description;
    private LocalDateTime grantedAt;
    private LocalDateTime revokedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Date getGrantedAtDate() {
        if (grantedAt == null) return null;
        return Date.from(grantedAt.atZone(ZoneId.systemDefault()).toInstant());
    }
    public Date getUpdatedAtDate() {
        if (updatedAt == null) return null;
        return Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
