package org.triptogether.common.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * CHATBOT_LINK_CLICK 테이블 매핑.
 * 챗봇이 제시한 링크를 사용자가 클릭한 이력.
 */
@Data
public class ChatbotLinkClickVO {

    private Long clickId;
    private Long messageId;         // 링크가 포함된 assistant 메시지
    private Long conversationId;
    private Long userIdx;           // 로그인 유저 (없으면 anonSessionId 사용)
    private String anonSessionId;
    private String url;
    private String label;
    private String ipAddress;
    private LocalDateTime clickedAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getClickedAtDate() {
        return fromLocalDateTime(clickedAt);
    }

}
