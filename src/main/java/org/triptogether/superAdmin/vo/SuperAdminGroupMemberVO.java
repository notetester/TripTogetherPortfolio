package org.triptogether.superAdmin.vo;

import lombok.Data;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class SuperAdminGroupMemberVO {
    private Long adminPermissionGroupIdx;
    private Long userIdx;
    private String groupCode;
    private String nickname;
    private String userId;
    private boolean active;
    private String grantedByNickname;
    private LocalDateTime grantedAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getGrantedAtDate() {
        return fromLocalDateTime(grantedAt);
    }

}
