package org.triptogether.admin.vo;

import lombok.Data;
import java.util.Date;

/**
 * ADMIN_ASSISTANT_BLOCK 테이블 매핑.
 * AI 도우미(assistant, Claude) 전용 차단 목록.
 * 기존 CHATBOT_BLOCK(챗봇 전용) / USER_BLOCKLIST / BLOCKED_IP와 별개.
 */
@Data
public class AdminAssistantBlockVO {

    private Long blockId;
    private String blockType;          // "USER" | "IP"
    private String blockValue;         // user_idx(문자) 또는 IP
    private String reason;
    private Long blockedBy;            // 처리 관리자 user_idx
    private Date blockedAt;            // JSP fmt:formatDate 호환 위해 java.util.Date 사용
    private Date expiresAt;            // NULL = 영구 차단
    private Boolean isActive;

    /** JOIN으로 채움 (DB 컬럼 아님) - 처리 관리자 닉네임 표시용 */
    private String blockedByNickname;
    /** JOIN으로 채움 (DB 컬럼 아님) - USER 차단일 때 대상 유저 닉네임 */
    private String targetNickname;
}
