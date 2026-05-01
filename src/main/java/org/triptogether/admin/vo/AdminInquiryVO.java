package org.triptogether.admin.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * 관리자 문의 관리 화면 VO.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AdminInquiryVO {
    private Long inquiryId;
    private Long userIdx;
    private String userId;              // 작성자 로그인 ID
    private String nickname;            // 작성자 닉네임
    private String accountStatus;       // 작성자 계정 상태 (ACTIVE / BLOCKED)
    private String title;
    private String content;
    private String category;            // 문의 카테고리 (service / payment / account / bug / etc)
    private boolean privateFlag;        // 비공개 여부
    private String status;              // 문의 상태 (PENDING / IN_PROGRESS / COMPLETED)
    private int viewCount;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private Long answerId;              // 답변 ID (답변 없으면 null)
    private String answerContent;       // 답변 내용
    private String answerAdminNickname; // 답변 작성 관리자 닉네임
    private LocalDateTime answeredAt;   // 답변 작성 시각

    public Date getCreatedAt() {
        return createdAt == null ? null : Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getUpdatedAt() {
        return updatedAt == null ? null : Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getAnsweredAt() {
        return answeredAt == null ? null : Date.from(answeredAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

    public Date getUpdatedAtDate() {
        return fromLocalDateTime(updatedAt);
    }

    public Date getAnsweredAtDate() {
        return fromLocalDateTime(answeredAt);
    }

}
