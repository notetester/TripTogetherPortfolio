package org.triptogether.common.vo;

import lombok.Data;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * CHATBOT_BLOCK 테이블 매핑 (챗봇 전용 차단).
 * 기존 USER_BLOCKLIST / BLOCKED_IP와 별개.
 */
@Data
public class ChatbotBlockVO {

    private Long blockId;
    private String blockType;          // "USER" | "IP"
    private String blockValue;         // user_idx(문자) 또는 IP
    private String reason;
    private Long blockedBy;            // admin user_idx
    private LocalDateTime blockedAt;
    private LocalDateTime expiresAt;   // NULL = 영구 차단
    private Boolean isActive;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getBlockedAtDate() {
        return fromLocalDateTime(blockedAt);
    }

    public Date getExpiresAtDate() {
        return fromLocalDateTime(expiresAt);
    }

}
