package org.triptogether.inquiry.vo;

import lombok.Data;
import java.util.Date;

/**
 * =============================================
 * InquiryPostDto - 문의 게시글 데이터 객체
 * =============================================
 * DB의 INQUIRY_POST 테이블과 매핑되는 VO
 */
@Data
public class InquiryPostDto {

    /** 문의 고유 번호 (PK) */
    private Long inquiryId;

    /** 문의를 작성한 유저의 고유 번호 (FK → USERS.user_idx) */
    private Long userIdx;

    /** 문의를 작성한 유저의 닉네임 (USERS 테이블 JOIN) */
    private String nickname;

    /** 문의 제목 */
    private String title;

    /** 문의 내용 */
    private String content;

    /** 문의 유형 (service/payment/account/bug/etc) */
    private String category;

    /** 비공개 여부 (0: 공개, 1: 비공개) */
    private int isPrivate;

    /** 처리 상태 (PENDING: 대기중 / IN_PROGRESS: 처리중 / COMPLETED: 완료) */
    private String status;

    /** 조회수 */
    private int viewCount;

    /** 문의 등록 일시 */
    private Date createdAt;

    /** 문의 수정 일시 */
    private Date updatedAt;

    /** 처리 시작 일시 */
    private Date inProgressAt;

    /** 처리 완료 일시 */
    private Date completedAt;

    /** 취소 일시 */
    private Date cancelledAt;

    /** 삭제 요청 일시 */
    private Date deleteRequestedAt;

    /** 공개 전환 요청 일시 */
    private Date visibilityRequestedAt;

    /** AI 독성 감지 플래그 (0: 정상, 1: AI 독성 감지됨 → BLUR 처리) */
    private boolean aiFlagged;
}