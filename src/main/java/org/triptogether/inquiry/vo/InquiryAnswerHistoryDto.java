package org.triptogether.inquiry.vo;

import lombok.Data;
import java.util.Date;

/**
 * =============================================
 * InquiryAnswerHistoryDto - 문의 답변 수정/삭제 이력
 * =============================================
 * DB의 INQUIRY_ANSWER_HISTORY 테이블과 매핑되는 VO.
 *
 * 정책: 답변 UPDATE / DELETE 시 이전 본문 + 변경자 + 시각을 별도 테이블에 보존.
 * 답변 삭제 후에도 이력은 남도록 answer_id 는 SET NULL.
 */
@Data
public class InquiryAnswerHistoryDto {

    /** 이력 PK */
    private Long historyIdx;

    /** 대상 답변 FK (답변 삭제 시 NULL) */
    private Long answerId;

    /** 문의 FK (조회 편의용) */
    private Long inquiryId;

    /** 변경 전 본문 */
    private String prevContent;

    /** 변경 전 답변자 user_idx */
    private Long prevAdminUserIdx;

    /** 변경 전 답변자 닉네임 (USERS JOIN) */
    private String prevAdminNickname;

    /** 변경 시각 */
    private Date changedAt;

    /** 변경/삭제 수행 어드민 user_idx */
    private Long changedBy;

    /** 변경자 닉네임 (USERS JOIN) */
    private String changedByNickname;

    /** UPDATE / DELETE */
    private String changeType;
    public Date getChangedAtDate() {
        return changedAt;
    }

}
