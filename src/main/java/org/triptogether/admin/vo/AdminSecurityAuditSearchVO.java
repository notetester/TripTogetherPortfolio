package org.triptogether.admin.vo;

import lombok.Data;

/**
 * 보안 이력 감사 검색 조건.
 *
 * <p>USER_SECURITY_HISTORY 전용 검색 VO이며,</p>
 * <p>로그인 이력(USER_LOGIN_HISTORY) 검색과 분리해서 사용한다.</p>
 */
@Data
public class AdminSecurityAuditSearchVO {
    private String keyword;
    private String success;     // ALL / SUCCESS / FAIL
    private String eventType;   // ALL / FIND_ID / FIND_PASSWORD / RESET_PASSWORD / PASSWORD_CHANGE / EMAIL_VERIFY / EMAIL_LOGIN_TOGGLE
    private String eventStage;  // ALL / REQUEST / ISSUE / VERIFY / COMPLETE
    private int page = 1;
    private int size = 30;

    public int getOffset() {
        return (page - 1) * size;
    }

    public String getSuccess() { return success != null ? success : "ALL"; }
    public String getEventType() { return eventType != null ? eventType : "ALL"; }
    public String getEventStage() { return eventStage != null ? eventStage : "ALL"; }
}
