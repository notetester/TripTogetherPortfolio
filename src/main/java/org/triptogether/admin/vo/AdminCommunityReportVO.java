package org.triptogether.admin.vo;

import lombok.Data;

import java.util.Date;

@Data
public class AdminCommunityReportVO {
    private Long reportId;
    private Long reporterIdx;           // 신고자 user_idx
    private String reporterUserId;      // 신고자 로그인 ID
    private String reporterNickname;    // 신고자 닉네임
    private String reason;              // 신고 사유
    private String status;              // 신고 상태 (IN_REVIEW / RESOLVED / DISMISSED)
    private Date createdAt;
    private Date resolvedAt;            // 처리 완료 시각
    private String resolveAction;       // 처리 내용 (게시글 삭제 / 작성자 차단 등)
    public Date getCreatedAtDate() {
        return createdAt;
    }

    public java.util.Date getResolvedAtDate() {
        return resolvedAt;
    }

}
