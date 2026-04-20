package org.triptogether.superAdmin.vo;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;

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
}
