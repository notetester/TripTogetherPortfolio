package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.HtmlUtils;
import org.triptogether.admin.mapper.AdminTranslationMapper;
import org.triptogether.admin.vo.*;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminTranslationServiceImpl implements AdminTranslationService {

    private static final String GOOGLE_TRANSLATE_URL = "https://translation.googleapis.com/language/translate/v2?key=%s";
    private static final String PROVIDER = "google-cloud-translation-v2";
    private static final String PROVIDER_VERSION = "v2";
    private static final List<String> SUPPORTED_LANGS = List.of("ko", "en", "ja", "zh");

    private final AdminTranslationMapper adminTranslationMapper;
    private final RestTemplate restTemplate;

    @Value("${gcp.translate.api.key:}")
    private String googleTranslateApiKey;

    @Override
    public List<AdminTranslationVO> getTranslations(String sourceType,
                                                    Long sourceIdx,
                                                    String fieldName,
                                                    String sourceText) {
        validateLookup(sourceType, sourceIdx, fieldName, sourceText);

        String currentHash = sha256(normalizeText(sourceText));
        List<AdminTranslationVO> translations = adminTranslationMapper.selectTranslations(sourceType, sourceIdx, fieldName);
        for (AdminTranslationVO translation : translations) {
            List<AdminTranslationRevisionVO> revisions = adminTranslationMapper.selectTranslationRevisions(translation.getTranslationIdx());
            translation.setRevisions(revisions);
            AdminTranslationRevisionVO currentRevision = null;
            if (translation.getCurrentRevisionIdx() != null) {
                for (AdminTranslationRevisionVO revision : revisions) {
                    if (Objects.equals(revision.getTranslationRevisionIdx(), translation.getCurrentRevisionIdx())) {
                        currentRevision = revision;
                        break;
                    }
                }
            }
            if (currentRevision == null && !revisions.isEmpty()) {
                currentRevision = revisions.get(0);
            }
            translation.setCurrentRevision(currentRevision);
            translation.setOutdated(currentRevision != null && currentRevision.getSourceTextHash() != null
                    && !currentHash.equals(currentRevision.getSourceTextHash()));
        }
        return translations;
    }

    @Override
    @Transactional
    public AdminTranslationVO createTranslation(AdminTranslationCreateRequest request, Long actorUserIdx) {
        validateCreateRequest(request);

        String sourceType = request.getSourceType().trim();
        Long sourceIdx = request.getSourceIdx();
        String fieldName = request.getFieldName().trim();
        String sourceLang = normalizeLanguage(request.getSourceLang());
        String targetLang = normalizeLanguage(request.getTargetLang());
        String normalizedSourceText = normalizeText(request.getSourceText());
        String title = normalizeTitle(request.getTitle(), sourceType, sourceIdx, fieldName, sourceLang, targetLang);
        boolean autoTranslate = request.getAutoTranslate() == null || request.getAutoTranslate();

        AdminTranslationSourceSnapshotVO snapshot = captureSnapshot(
                sourceType,
                sourceIdx,
                fieldName,
                sourceLang,
                normalizedSourceText,
                parseDateTime(request.getSourceUpdatedAt()),
                actorUserIdx
        );

        String translatedText;
        String translationType;
        String translationEngine = null;
        String translationEngineVersion = null;
        if (autoTranslate) {
            translatedText = requestTranslation(normalizedSourceText, sourceLang, targetLang);
            translationType = "AUTO";
            translationEngine = PROVIDER;
            translationEngineVersion = PROVIDER_VERSION;
        } else {
            translatedText = normalizeText(request.getTranslatedText());
            if (translatedText.isBlank()) {
                throw new IllegalArgumentException("수동 번역문을 입력해야 함");
            }
            translationType = "MANUAL";
        }

        AdminTranslationVO translation = new AdminTranslationVO();
        translation.setSourceType(sourceType);
        translation.setSourceIdx(sourceIdx);
        translation.setFieldName(fieldName);
        translation.setSourceLang(sourceLang);
        translation.setTargetLang(targetLang);
        translation.setTitle(title);
        translation.setStatus(normalizeStatus(request.getStatus()));
        translation.setVisibilityScope(normalizeVisibilityScope(request.getVisibilityScope()));

        boolean markPrimary = Boolean.TRUE.equals(request.getMarkPrimary())
                || adminTranslationMapper.countPrimaryTranslationsByLangPair(sourceType, sourceIdx, fieldName, sourceLang, targetLang) == 0;
        translation.setIsPrimary(markPrimary);
        translation.setCreatedBy(actorUserIdx);
        translation.setUpdatedBy(actorUserIdx);
        translation.setIsDeleted(false);
        adminTranslationMapper.insertTranslation(translation);

        AdminTranslationRevisionVO revision = new AdminTranslationRevisionVO();
        revision.setTranslationIdx(translation.getTranslationIdx());
        revision.setVersionNo(1);
        revision.setParentRevisionIdx(null);
        revision.setSourceSnapshotIdx(snapshot.getSourceSnapshotIdx());
        revision.setTranslatedText(translatedText);
        revision.setTranslationType(translationType);
        revision.setTranslationEngine(translationEngine);
        revision.setTranslationEngineVersion(translationEngineVersion);
        revision.setStyleType("DEFAULT");
        revision.setReviewStatus("NONE");
        revision.setNote(trimToNull(request.getNote()));
        revision.setCreatedBy(actorUserIdx);
        revision.setUpdatedBy(actorUserIdx);
        adminTranslationMapper.insertTranslationRevision(revision);

        if (markPrimary) {
            adminTranslationMapper.clearPrimaryByLangPair(sourceType, sourceIdx, fieldName, sourceLang, targetLang,
                    translation.getTranslationIdx(), actorUserIdx);
        }
        adminTranslationMapper.updateTranslationCurrentRevision(translation.getTranslationIdx(), revision.getTranslationRevisionIdx(), actorUserIdx);
        adminTranslationMapper.updateTranslationMeta(translation.getTranslationIdx(), title,
                translation.getStatus(), translation.getVisibilityScope(), markPrimary, actorUserIdx);

        return getTranslationDetail(translation.getTranslationIdx(), normalizedSourceText);
    }

    @Override
    @Transactional
    public AdminTranslationVO createRevision(Long translationIdx,
                                             AdminTranslationRevisionCreateRequest request,
                                             Long actorUserIdx) {
        if (translationIdx == null) {
            throw new IllegalArgumentException("translationIdx가 필요함");
        }
        if (request == null) {
            throw new IllegalArgumentException("요청 본문이 비어 있음");
        }

        AdminTranslationVO translation = requireTranslation(translationIdx);
        String sourceLang = normalizeLanguage(defaultIfBlank(request.getSourceLang(), translation.getSourceLang()));
        String normalizedSourceText = normalizeText(request.getSourceText());
        if (normalizedSourceText.isBlank()) {
            throw new IllegalArgumentException("원문이 비어 있음");
        }
        String translatedText = normalizeText(request.getTranslatedText());
        if (translatedText.isBlank()) {
            throw new IllegalArgumentException("번역문이 비어 있음");
        }

        AdminTranslationSourceSnapshotVO snapshot = captureSnapshot(
                translation.getSourceType(),
                translation.getSourceIdx(),
                translation.getFieldName(),
                sourceLang,
                normalizedSourceText,
                parseDateTime(request.getSourceUpdatedAt()),
                actorUserIdx
        );

        int nextVersion = adminTranslationMapper.selectMaxVersionNo(translationIdx) + 1;
        AdminTranslationRevisionVO currentRevision = adminTranslationMapper.selectTranslationRevision(translation.getCurrentRevisionIdx());

        AdminTranslationRevisionVO revision = new AdminTranslationRevisionVO();
        revision.setTranslationIdx(translationIdx);
        revision.setVersionNo(nextVersion);
        revision.setParentRevisionIdx(translation.getCurrentRevisionIdx());
        revision.setSourceSnapshotIdx(snapshot.getSourceSnapshotIdx());
        revision.setTranslatedText(translatedText);
        revision.setTranslationType(currentRevision == null ? "POST_EDIT" : normalizeRevisionType(currentRevision.getTranslationType()));
        revision.setTranslationEngine(currentRevision == null ? null : currentRevision.getTranslationEngine());
        revision.setTranslationEngineVersion(currentRevision == null ? null : currentRevision.getTranslationEngineVersion());
        revision.setStyleType(currentRevision == null ? "DEFAULT" : defaultIfBlank(currentRevision.getStyleType(), "DEFAULT"));
        revision.setReviewStatus("NONE");
        revision.setNote(trimToNull(request.getNote()));
        revision.setCreatedBy(actorUserIdx);
        revision.setUpdatedBy(actorUserIdx);
        adminTranslationMapper.insertTranslationRevision(revision);

        boolean markPrimary = Boolean.TRUE.equals(request.getMarkPrimary())
                || adminTranslationMapper.countPrimaryTranslationsByLangPair(
                translation.getSourceType(), translation.getSourceIdx(), translation.getFieldName(), translation.getSourceLang(), translation.getTargetLang()) == 0;
        if (markPrimary) {
            adminTranslationMapper.clearPrimaryByLangPair(translation.getSourceType(), translation.getSourceIdx(), translation.getFieldName(),
                    translation.getSourceLang(), translation.getTargetLang(), translationIdx, actorUserIdx);
        }

        adminTranslationMapper.updateTranslationCurrentRevision(translationIdx, revision.getTranslationRevisionIdx(), actorUserIdx);
        adminTranslationMapper.updateTranslationMeta(
                translationIdx,
                normalizeTitle(request.getTitle(), translation.getSourceType(), translation.getSourceIdx(), translation.getFieldName(), translation.getSourceLang(), translation.getTargetLang(), translation.getTitle()),
                normalizeStatus(defaultIfBlank(request.getStatus(), translation.getStatus())),
                normalizeVisibilityScope(defaultIfBlank(request.getVisibilityScope(), translation.getVisibilityScope())),
                markPrimary,
                actorUserIdx
        );

        return getTranslationDetail(translationIdx, normalizedSourceText);
    }

    @Override
    @Transactional
    public AdminTranslationVO restoreRevision(Long translationIdx,
                                              Long revisionIdx,
                                              Long actorUserIdx) {
        if (translationIdx == null || revisionIdx == null) {
            throw new IllegalArgumentException("translationIdx와 revisionIdx가 필요함");
        }

        AdminTranslationVO translation = requireTranslation(translationIdx);
        AdminTranslationRevisionVO revision = adminTranslationMapper.selectTranslationRevision(revisionIdx);
        if (revision == null || !Objects.equals(revision.getTranslationIdx(), translationIdx)) {
            throw new IllegalArgumentException("복원할 번역 버전을 찾을 수 없음");
        }

        adminTranslationMapper.updateTranslationCurrentRevision(translationIdx, revisionIdx, actorUserIdx);
        return getTranslationDetail(translationIdx, revision.getSourceTextSnapshot());
    }

    private AdminTranslationVO getTranslationDetail(Long translationIdx, String currentSourceText) {
        AdminTranslationVO translation = requireTranslation(translationIdx);
        List<AdminTranslationRevisionVO> revisions = adminTranslationMapper.selectTranslationRevisions(translationIdx);
        translation.setRevisions(revisions);
        AdminTranslationRevisionVO currentRevision = null;
        for (AdminTranslationRevisionVO revision : revisions) {
            if (Objects.equals(revision.getTranslationRevisionIdx(), translation.getCurrentRevisionIdx())) {
                currentRevision = revision;
                break;
            }
        }
        if (currentRevision == null && !revisions.isEmpty()) {
            currentRevision = revisions.get(0);
        }
        translation.setCurrentRevision(currentRevision);
        if (currentRevision != null && currentSourceText != null && !currentSourceText.isBlank()) {
            translation.setOutdated(!sha256(normalizeText(currentSourceText)).equals(currentRevision.getSourceTextHash()));
        }
        return translation;
    }

    private AdminTranslationVO requireTranslation(Long translationIdx) {
        AdminTranslationVO translation = adminTranslationMapper.selectTranslation(translationIdx);
        if (translation == null || Boolean.TRUE.equals(translation.getIsDeleted())) {
            throw new IllegalArgumentException("번역안을 찾을 수 없음");
        }
        return translation;
    }

    private AdminTranslationSourceSnapshotVO captureSnapshot(String sourceType,
                                                             Long sourceIdx,
                                                             String fieldName,
                                                             String sourceLang,
                                                             String sourceText,
                                                             LocalDateTime sourceUpdatedAt,
                                                             Long actorUserIdx) {
        AdminTranslationSourceSnapshotVO latest = adminTranslationMapper.selectLatestSourceSnapshot(sourceType, sourceIdx, fieldName);
        String hash = sha256(sourceText);
        if (latest != null && hash.equals(latest.getSourceTextHash())) {
            return latest;
        }

        AdminTranslationSourceSnapshotVO snapshot = new AdminTranslationSourceSnapshotVO();
        snapshot.setSourceType(sourceType);
        snapshot.setSourceIdx(sourceIdx);
        snapshot.setFieldName(fieldName);
        snapshot.setSourceLang(sourceLang);
        snapshot.setSourceText(sourceText);
        snapshot.setSourceTextHash(hash);
        snapshot.setSourceUpdatedAt(sourceUpdatedAt);
        snapshot.setSnapshotSeq(latest == null || latest.getSnapshotSeq() == null ? 1 : latest.getSnapshotSeq() + 1);
        snapshot.setCapturedByUserIdx(actorUserIdx);
        adminTranslationMapper.insertSourceSnapshot(snapshot);
        return snapshot;
    }

    private void validateLookup(String sourceType, Long sourceIdx, String fieldName, String sourceText) {
        if (sourceType == null || sourceType.isBlank()) {
            throw new IllegalArgumentException("sourceType이 필요함");
        }
        if (sourceIdx == null) {
            throw new IllegalArgumentException("sourceIdx가 필요함");
        }
        if (fieldName == null || fieldName.isBlank()) {
            throw new IllegalArgumentException("fieldName이 필요함");
        }
        if (sourceText == null || sourceText.isBlank()) {
            throw new IllegalArgumentException("원문이 비어 있음");
        }
    }

    private void validateCreateRequest(AdminTranslationCreateRequest request) {
        if (request == null) {
            throw new IllegalArgumentException("요청 본문이 비어 있음");
        }
        validateLookup(request.getSourceType(), request.getSourceIdx(), request.getFieldName(), request.getSourceText());
        normalizeLanguage(request.getSourceLang());
        normalizeLanguage(request.getTargetLang());
    }

    private String requestTranslation(String sourceText, String sourceLang, String targetLang) {
        if (sourceLang.equals(targetLang)) {
            return sourceText;
        }
        if (googleTranslateApiKey == null || googleTranslateApiKey.isBlank()) {
            throw new IllegalStateException("번역 API 키가 비어 있음");
        }

        try {
            String endpoint = String.format(GOOGLE_TRANSLATE_URL, googleTranslateApiKey);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            Map<String, Object> body = new LinkedHashMap<>();
            body.put("q", Collections.singletonList(sourceText));
            body.put("target", normalizeGoogleLanguage(targetLang));
            body.put("source", normalizeGoogleLanguage(sourceLang));
            body.put("format", "text");

            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);
            @SuppressWarnings("unchecked")
            Map<String, Object> response = restTemplate.postForObject(endpoint, entity, Map.class);
            if (response == null) {
                throw new IllegalStateException("번역 응답이 비어 있음");
            }

            Object dataObj = response.get("data");
            if (!(dataObj instanceof Map<?, ?> data)) {
                throw new IllegalStateException("번역 응답 형식이 올바르지 않음");
            }

            Object translationsObj = data.get("translations");
            if (!(translationsObj instanceof List<?> translations) || translations.isEmpty()) {
                throw new IllegalStateException("번역 결과가 비어 있음");
            }

            Object firstObj = translations.get(0);
            if (!(firstObj instanceof Map<?, ?> firstTranslation)) {
                throw new IllegalStateException("번역 결과 형식이 올바르지 않음");
            }

            Object translatedText = firstTranslation.get("translatedText");
            String result = HtmlUtils.htmlUnescape(asText(translatedText)).trim();
            if (result.isBlank()) {
                throw new IllegalStateException("번역 결과가 비어 있음");
            }
            return result;
        } catch (IllegalStateException e) {
            throw e;
        } catch (Exception e) {
            log.warn("[AdminTranslate] translation request failed: {}", e.getMessage());
            throw new IllegalStateException("번역 요청에 실패함", e);
        }
    }

    private String normalizeRevisionType(String previousType) {
        if ("MANUAL".equalsIgnoreCase(previousType)) {
            return "MANUAL";
        }
        return "POST_EDIT";
    }

    private String normalizeTitle(String title,
                                  String sourceType,
                                  Long sourceIdx,
                                  String fieldName,
                                  String sourceLang,
                                  String targetLang) {
        return normalizeTitle(title, sourceType, sourceIdx, fieldName, sourceLang, targetLang, null);
    }

    private String normalizeTitle(String title,
                                  String sourceType,
                                  Long sourceIdx,
                                  String fieldName,
                                  String sourceLang,
                                  String targetLang,
                                  String fallback) {
        String trimmed = trimToNull(title);
        if (trimmed != null) {
            return trimmed;
        }
        if (fallback != null && !fallback.isBlank()) {
            return fallback;
        }
        int pairCount = adminTranslationMapper.countTranslationsByLangPair(sourceType, sourceIdx, fieldName, sourceLang, targetLang);
        return sourceLang + "→" + targetLang + " 번역안 " + (pairCount + 1);
    }

    private String normalizeStatus(String status) {
        String normalized = defaultIfBlank(status, "DRAFT").trim().toUpperCase(Locale.ROOT);
        return switch (normalized) {
            case "DRAFT", "PUBLISHED", "ARCHIVED", "LEGACY", "HIDDEN" -> normalized;
            default -> "DRAFT";
        };
    }

    private String normalizeVisibilityScope(String visibilityScope) {
        String normalized = defaultIfBlank(visibilityScope, "ADMIN_ONLY").trim().toUpperCase(Locale.ROOT);
        return switch (normalized) {
            case "PUBLIC", "ADMIN_ONLY", "PRIVATE" -> normalized;
            default -> "ADMIN_ONLY";
        };
    }

    private String normalizeLanguage(String language) {
        String normalized = defaultIfBlank(language, "ko").trim().toLowerCase(Locale.ROOT);
        if (!SUPPORTED_LANGS.contains(normalized)) {
            throw new IllegalArgumentException("지원하지 않는 언어 코드임: " + language);
        }
        return normalized;
    }

    private String normalizeGoogleLanguage(String language) {
        return "zh".equals(language) ? "zh-CN" : language;
    }

    private LocalDateTime parseDateTime(String value) {
        String trimmed = trimToNull(value);
        if (trimmed == null) {
            return null;
        }
        try {
            return LocalDateTime.parse(trimmed);
        } catch (DateTimeParseException e) {
            return null;
        }
    }

    private String normalizeText(String text) {
        return text == null ? "" : text.trim();
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private String defaultIfBlank(String value, String defaultValue) {
        return value == null || value.isBlank() ? defaultValue : value;
    }

    private String asText(Object value) {
        return value == null ? "" : String.valueOf(value);
    }

    private String sha256(String value) {
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            byte[] digest = messageDigest.digest(value.getBytes(StandardCharsets.UTF_8));
            StringBuilder builder = new StringBuilder(digest.length * 2);
            for (byte b : digest) {
                builder.append(String.format("%02x", b));
            }
            return builder.toString();
        } catch (Exception e) {
            throw new IllegalStateException("SHA-256 해시 생성 실패", e);
        }
    }
}
