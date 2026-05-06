package org.triptogether.admin.vo;

import lombok.Data;
import java.math.BigDecimal;
import java.util.Date;

/**
 * ADMIN_ASSISTANT_MODERATION 테이블 매핑.
 * CHAT_COMMENT 중 user 메시지에 대한 Perspective API 독성 판정 결과.
 * 스케줄러가 주기적으로 미검사 메시지 스캔 후 저장.
 */
@Data
public class AdminAssistantModerationVO {

    private Long moderationId;
    private Long chatCommentIdx;       // CHAT_COMMENT FK
    private Boolean isInappropriate;   // AI 독성 판정
    private BigDecimal toxicityScore;  // Perspective TOXICITY 점수 (0.000~1.000)
    private Date checkedAt;            // JSP fmt:formatDate 호환 위해 java.util.Date 사용

    /** JOIN으로 채움 (DB 컬럼 아님) - 관리자 목록/모달 표시용 */
    private Long chatPostIdx;
    private Long userIdx;
    private String nickname;
    private String content;
    private Date messageCreatedAt;
    public Date getCheckedAtDate() {
        return checkedAt;
    }

    public java.util.Date getMessageCreatedAtDate() {
        return messageCreatedAt;
    }

}
