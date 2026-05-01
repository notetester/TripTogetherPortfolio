package org.triptogether.superAdmin.vo;

import lombok.Data;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class SuperAdminPermissionVO {

    // ── ADMIN_PERMISSION ──
    private Long   adminPermissionIdx;
    private Long   userIdx;
    private String permissionCode;
    private boolean active;
    private LocalDateTime createdAt;

    // ── ADMIN_PERMISSION_POLICY JOIN ──
    private String displayName;
    private String description;

    // ── ADMIN_PERMISSION_POLICY 전용 ──
    private int    priority;
    private int    usageCount;

    // ── 뷰 추가 컬럼 ──
    private String permissionSource;
    private String sourceGroupCode;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

}
