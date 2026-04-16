CREATE TABLE IF NOT EXISTS SPOT_TEXT_TRANSLATION_CACHE (
    cache_idx BIGINT NOT NULL AUTO_INCREMENT,
    cache_id VARCHAR(64) NOT NULL,
    source_type VARCHAR(40) NOT NULL,
    source_pk BIGINT NOT NULL DEFAULT 0,
    field_name VARCHAR(40) NOT NULL,
    source_text TEXT NOT NULL,
    source_text_hash CHAR(64) NOT NULL,
    target_lang VARCHAR(10) NOT NULL,
    translated_text TEXT NOT NULL,
    provider VARCHAR(50) NOT NULL DEFAULT 'google-cloud-translation-v2',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (cache_idx),
    UNIQUE KEY uk_spot_text_translation_cache (source_type, source_pk, field_name, source_text_hash, target_lang),
    UNIQUE KEY uk_spot_text_translation_cache_id (cache_id),
    KEY idx_spot_text_translation_lookup (source_type, field_name, target_lang, source_text_hash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
