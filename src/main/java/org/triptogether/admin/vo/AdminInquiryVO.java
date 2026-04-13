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
public class

AdminInquiryVO {
    private Long inquiryId;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String accountStatus;
    private String title;
    private String content;
    private String category;
    private boolean privateFlag;
    private String status;
    private int viewCount;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private Long answerId;
    private String answerContent;
    private String answerAdminNickname;
    private LocalDateTime answeredAt;

    public Date getCreatedAt() {
        return createdAt == null ? null : Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getUpdatedAt() {
        return updatedAt == null ? null : Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getAnsweredAt() {
        return answeredAt == null ? null : Date.from(answeredAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
