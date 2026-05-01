package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.time.ZoneId;
import java.util.Date;

@Data
public class AdminTranslationVO {
    private Long translationIdx;
    private String sourceType;
    private Long sourceIdx;
    private String fieldName;
    private String sourceLang;
    private String targetLang;
    private String title;
    private String status;
    private String visibilityScope;
    private Boolean isPrimary;
    private Long forkedFromTranslationIdx;
    private Long currentRevisionIdx;
    private Long createdBy;
    private LocalDateTime createdAt;
    private Long updatedBy;
    private LocalDateTime updatedAt;
    private Boolean isDeleted;
    private LocalDateTime deletedAt;
    private Long deletedBy;

    private boolean outdated;
    private AdminTranslationRevisionVO currentRevision;
    private List<AdminTranslationRevisionVO> revisions = new ArrayList<>();

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

    public Date getDeletedAtDate() {
        return fromLocalDateTime(deletedAt);
    }

}
