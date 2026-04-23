package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class AdminTranslationSourceSnapshotVO {
    private Long sourceSnapshotIdx;
    private String sourceType;
    private Long sourceIdx;
    private String fieldName;
    private String sourceLang;
    private String sourceText;
    private String sourceTextHash;
    private LocalDateTime sourceUpdatedAt;
    private Integer snapshotSeq;
    private LocalDateTime capturedAt;
    private Long capturedByUserIdx;
}
