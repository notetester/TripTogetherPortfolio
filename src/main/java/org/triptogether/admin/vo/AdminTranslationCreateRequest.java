package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminTranslationCreateRequest {
    private String sourceType;
    private Long sourceIdx;
    private String fieldName;
    private String sourceLang;
    private String targetLang;
    private String sourceText;
    private String title;
    private Boolean autoTranslate;
    private String translatedText;
    private String status;
    private String visibilityScope;
    private Boolean markPrimary;
    private String note;
    private String sourceUpdatedAt;
}
