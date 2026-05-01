package org.triptogether.auth.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class SecurityReviewVO {
    private Long reviewIdx;
    private Long assessmentIdx;
    private String assessmentScope;
    private String reviewType;
    private String severity;
    private String subjectType;
    private String subjectKey;
    private Long userIdx;
    private String userId;
    private String nickname;
    private String ipAddress;
    private String summary;
    private String detailMessage;
    private String reviewStatus;
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
