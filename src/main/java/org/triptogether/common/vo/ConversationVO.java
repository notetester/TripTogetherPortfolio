package org.triptogether.common.vo;

import lombok.Data;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * CHATBOT_CONVERSATION 테이블 매핑.
 * 로그인 유저의 대화 그룹(user_idx) 또는 비로그인 유저의 세션 대화(anon_session_id) 중
 * 하나만 NOT NULL.
 */
@Data
public class ConversationVO {

    private Long conversationId;
    private Long userIdx;            // 로그인 유저 (anonSessionId와 XOR)
    private String anonSessionId;    // 비로그인 HTTP 세션 ID
    private String title;
    private String ipAddress;
    private LocalDateTime createdAt;
    private LocalDateTime lastActive;
    private Boolean isDeleted;
    private Integer sortOrder;       // 유저 드래그로 조정한 정렬값 (오름차순)

    /** 조회용 (JOIN으로 채움, DB 컬럼 아님) */
    private Integer messageCount;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

    public Date getLastActiveDate() {
        return fromLocalDateTime(lastActive);
    }

}
