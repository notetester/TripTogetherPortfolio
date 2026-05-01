package org.triptogether.explore.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

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

}
