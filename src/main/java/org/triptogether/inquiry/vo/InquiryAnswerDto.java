package org.triptogether.inquiry.vo;

import lombok.Data;
import java.util.Date;

/**
 * =============================================
 * InquiryAnswerDto - 문의 답변 데이터 객체
 * =============================================
 * DB의 INQUIRY_ANSWER 테이블과 매핑되는 VO
 */
@Data
public class InquiryAnswerDto {

    /** 답변 고유 번호 (PK) */
    private Long answerId;

    /** 어떤 문의에 대한 답변인지 (FK → INQUIRY_POST.inquiry_id) */
    private Long inquiryId;

    /** 답변을 작성한 운영진의 고유 번호 (FK → USERS.user_idx) */
    private Long adminUserIdx;

    /** 답변을 작성한 운영진의 닉네임 (USERS 테이블 JOIN) */
    private String adminNickname;

    /** 답변 내용 */
    private String content;

    /** 답변 등록 일시 */
    private Date createdAt;

    /** 답변 수정 일시 */
    private Date updatedAt;
}