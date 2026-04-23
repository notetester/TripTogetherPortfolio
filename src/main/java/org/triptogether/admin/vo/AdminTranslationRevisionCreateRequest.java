package org.triptogether.admin.vo;

import lombok.Data;

@Data
public class AdminTranslationRevisionCreateRequest {
    private String sourceLang;
    private String sourceText;
    private String translatedText;
    private String title;
    private String status;
    private String visibilityScope;
    private Boolean markPrimary;
    private String note;
    private String sourceUpdatedAt;
}
