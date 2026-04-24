package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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
}
