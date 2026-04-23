package org.triptogether.common.vo;

import lombok.Data;

import java.time.LocalDateTime;

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
}
