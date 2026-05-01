package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

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

    private Date fromLocalDateTime(LocalDateTime value) {
        if (value == null) {
            return null;
        }
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getSourceUpdatedAtDate() {
        return fromLocalDateTime(sourceUpdatedAt);
    }

    public Date getCapturedAtDate() {
        return fromLocalDateTime(capturedAt);
    }

}
