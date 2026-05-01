package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@Data
public class AdminTranslationRevisionVO {
    private Long translationRevisionIdx;
    private Long translationIdx;
    private Integer versionNo;
    private Long parentRevisionIdx;
    private Long sourceSnapshotIdx;
    private String sourceTextSnapshot;
    private String sourceTextHash;
    private Integer sourceSnapshotSeq;
    private LocalDateTime sourceSnapshotAt;
    private String translatedText;
    private String translationType;
    private String translationEngine;
    private String translationEngineVersion;
    private String styleType;
    private String reviewStatus;
    private Long reviewedBy;
    private LocalDateTime reviewedAt;
    private String reviewComment;
    private String note;
    private Long createdBy;
    private LocalDateTime createdAt;
    private Long updatedBy;
    private LocalDateTime updatedAt;

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getSourceSnapshotAtDate() {
        return fromLocalDateTime(sourceSnapshotAt);
    }

    public Date getReviewedAtDate() {
        return fromLocalDateTime(reviewedAt);
    }

    public Date getCreatedAtDate() {
        return fromLocalDateTime(createdAt);
    }

    public Date getUpdatedAtDate() {
        return fromLocalDateTime(updatedAt);
    }

}
