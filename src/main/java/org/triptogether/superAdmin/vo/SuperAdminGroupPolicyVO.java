package org.triptogether.superAdmin.vo;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;
import java.time.ZoneId;
import java.util.Date;

@Data
public class SuperAdminGroupPolicyVO {
    private Long adminPermissionGroupPolicyIdx;
    private String groupCode;
    private String displayName;
    private String description;
    private boolean active;
    private int priority;
    private LocalDateTime createdAt;
    private int itemCount;
    private List<SuperAdminGroupItemVO> items;

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
