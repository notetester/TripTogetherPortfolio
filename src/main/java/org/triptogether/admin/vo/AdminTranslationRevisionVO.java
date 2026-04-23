package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;

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
}
