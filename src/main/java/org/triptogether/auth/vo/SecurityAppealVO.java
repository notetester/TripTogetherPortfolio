package org.triptogether.auth.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class SecurityAppealVO {
    private Long appealIdx;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String targetType;
    private String targetKey;
    private Long sourceAssessmentIdx;
    private String appealStatus;
    private String appealTitle;
    private String appealContent;
    private Long reviewedByUserIdx;
    private String reviewedByUserId;
    private LocalDateTime reviewedAt;
    private String reviewComment;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        return value == null ? null : Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }
    public Date getReviewedAtDate() { return fromLocalDateTime(reviewedAt); }
    public Date getCreatedAtDate() { return fromLocalDateTime(createdAt); }
    public Date getUpdatedAtDate() { return fromLocalDateTime(updatedAt); }
}
