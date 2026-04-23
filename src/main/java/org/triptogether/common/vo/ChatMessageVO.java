package org.triptogether.common.vo;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * CHATBOT_MESSAGE 테이블 매핑.
 * 대화 그룹 내 개별 메시지 (user 또는 assistant).
 */
@Data
public class ChatMessageVO {

    private Long messageId;
    private Long conversationId;
    private String role;              // "user" | "assistant"
    private String content;
    private Boolean isInappropriate;  // AI가 부적절 판단한 user 메시지
    private LocalDateTime createdAt;
}
