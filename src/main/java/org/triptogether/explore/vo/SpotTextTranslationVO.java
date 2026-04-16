package org.triptogether.explore.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SpotTextTranslationVO {
    private Long cacheIdx;
    private String cacheId;
    private String sourceType;
    private Long sourcePk;
    private String fieldName;
    private String sourceText;
    private String sourceTextHash;
    private String targetLang;
    private String translatedText;
    private String provider;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
