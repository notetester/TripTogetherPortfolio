package org.triptogether.report.vo;

import lombok.Data;
import java.util.Date;

/**
 * =============================================
 * ReportDto - 신고 데이터 객체
 * =============================================
 * DB의 REPORT 테이블과 매핑되는 VO
 */
@Data
public class ReportDto {

    /** 신고 고유 번호 (PK) */
    private Long reportId;

    /** 신고한 유저의 고유 번호 (FK → USERS.user_idx) */
    private Long userIdx;

    /** 신고 대상 유형 (post / comment / user) */
    private String targetType;

    /** 신고 대상 ID (post_id / comment_id / user_idx) */
    private Long targetId;

    /** 신고 사유 (선택 항목) */
    private String reason;

    /** 신고 상세 설명 */
    private String description;

    /** 처리 상태 (PENDING / RESOLVED / DISMISSED) */
    private String status;

    /** 신고 등록 일시 */
    private Date createdAt;

    /** 처리 완료 일시 */
    private Date resolvedAt;

    /** 신고 수정 일시 */
    private Date updatedAt;

    /** 처리한 관리자의 고유 번호 (FK → USERS.user_idx) */
    private Long resolverIdx;

    /** 신고한 유저의 닉네임 (USERS 테이블 JOIN) */
    private String nickname;

    /** 동일 대상(post/comment/user)의 총 신고 접수 건수 (서브쿼리 조회) */
    private int targetReportCount;

    /** 처리 액션 텍스트 (게시글 삭제 / 작성자 차단 등) */
    private String resolveAction;

    /** 유저 신고 출처 유형 (post / comment) */
    private String sourceType;

    /** 유저 신고 출처 ID (post_id / comment_id) */
    private Long sourceId;
}
