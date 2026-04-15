package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 관리자 신고 관리 화면 VO.
 * - AdminInquiryVO와 동일한 구조로 admin 모듈 자체 VO 사용
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminReportVO {

    private Long   reportId;
    private Long   userIdx;           // 신고자 고유 번호 (FK → USERS.user_idx)
    private String userId;            // 신고자 로그인 ID (USERS JOIN)
    private String nickname;          // 신고자 닉네임 (USERS JOIN)
    private String accountStatus;     // 신고자 계정 상태 (ACTIVE / BLOCKED)

    private String targetType;        // 신고 대상 유형 (post / comment / user)
    private Long   targetId;          // 신고 대상 ID (post_id / comment_id / user_idx)
    private String sourceType;        // 댓글 신고 시 원글 유형 (post)
    private Long   sourceId;          // 댓글 신고 시 원글 ID (post_id) — null이면 원글보기 버튼 미표시

    private String reason;            // 신고 사유 (spam / abuse / privacy / adult / illegal / other / user)
    private String description;       // 신고 상세 설명

    private String status;            // 처리 상태 (IN_REVIEW / RESOLVED / DISMISSED)
    private String resolveAction;     // 처리 내용 (게시글 삭제 / 작성자 차단 등)
    private int    targetReportCount; // 동일 대상(post/comment/user) 총 신고 건수 (서브쿼리)

    private Date   createdAt;         // 신고 등록 일시
    private Date   resolvedAt;        // 처리 완료 일시
}
