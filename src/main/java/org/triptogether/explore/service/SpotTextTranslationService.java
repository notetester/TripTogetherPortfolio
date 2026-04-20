package org.triptogether.explore.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.HtmlUtils;
import org.triptogether.community.vo.CommunityCommentDto;
import org.triptogether.community.vo.CommunityPostDto;
import org.triptogether.explore.mapper.SpotTextTranslationMapper;
import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.explore.vo.RecommendVO;
import org.triptogether.explore.vo.ReviewVO;
import org.triptogether.explore.vo.SpotTextTranslationVO;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class SpotTextTranslationService {

    private static final String SOURCE_TYPE_SPOT = "SPOT";
    private static final String SOURCE_TYPE_REGION = "SPOT_REGION";
    private static final String SOURCE_TYPE_TAG = "SPOT_TAG";
    private static final String SOURCE_TYPE_REVIEW = "SPOT_REVIEW";
    private static final String SOURCE_TYPE_COMMUNITY_POST = "COMMUNITY_POST";
    private static final String SOURCE_TYPE_COMMUNITY_COMMENT = "COMMUNITY_COMMENT";
    private static final String SOURCE_TYPE_COMMUNITY_TAG = "COMMUNITY_TAG";
    private static final String SOURCE_TYPE_RECOMMEND = "RECOMMEND";
    private static final String PROVIDER = "google-cloud-translation-v2";
    private static final String GOOGLE_TRANSLATE_URL = "https://translation.googleapis.com/language/translate/v2?key=%s";

    private final SpotTextTranslationMapper translationMapper;
    private final RestTemplate restTemplate;
    private final MessageSource messageSource;

    @Value("${gcp.translate.api.key:}")
    private String googleTranslateApiKey;

    public void translateExploreSpots(List<ExploreVO> spots) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || spots == null || spots.isEmpty()) {
            return;
        }

        for (ExploreVO spot : spots) {
            translateExploreSpot(spot, targetLang);
        }
    }

    public void translateExploreSpot(ExploreVO spot) {
        String targetLang = getTargetLanguage();
        if (targetLang == null) {
            return;
        }
        translateExploreSpot(spot, targetLang);
    }

    public List<String> translateCommonTexts(List<String> sourceTexts, String sourceType, String fieldName) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || sourceTexts == null || sourceTexts.isEmpty()) {
            return sourceTexts;
        }

        List<String> translated = new ArrayList<>(sourceTexts.size());
        for (String sourceText : sourceTexts) {
            translated.add(translateText(sourceType, 0L, fieldName, sourceText, targetLang));
        }
        return translated;
    }

    public List<Map<String, Object>> translateSuggestList(List<Map<String, Object>> suggestions) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || suggestions == null || suggestions.isEmpty()) {
            return suggestions;
        }

        for (Map<String, Object> suggestion : suggestions) {
            if (suggestion == null) {
                continue;
            }
            suggestion.put("name", translateText(SOURCE_TYPE_SPOT, extractLong(suggestion.get("spotIdx")), "name",
                    asText(suggestion.get("name")), targetLang));
            suggestion.put("region", translateText(SOURCE_TYPE_SPOT, extractLong(suggestion.get("spotIdx")), "region",
                    asText(suggestion.get("region")), targetLang));
            suggestion.put("address", translateText(SOURCE_TYPE_SPOT, extractLong(suggestion.get("spotIdx")), "address",
                    asText(suggestion.get("address")), targetLang));
        }
        return suggestions;
    }

    public void translateRecommendSpots(List<RecommendVO> recommends) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || recommends == null || recommends.isEmpty()) {
            return;
        }

        for (RecommendVO recommend : recommends) {
            if (recommend == null) {
                continue;
            }
            recommend.setSpotName(translateText(SOURCE_TYPE_SPOT, recommend.getSpotIdx(), "name",
                    recommend.getSpotName(), targetLang));
            recommend.setRegion(translateText(SOURCE_TYPE_SPOT, recommend.getSpotIdx(), "region",
                    recommend.getRegion(), targetLang));
            recommend.setRecReason(translateRecommendReason(recommend, targetLang));
            if (recommend.getTags() != null && !recommend.getTags().isEmpty()) {
                List<String> translatedTags = new ArrayList<>(recommend.getTags().size());
                for (String tag : recommend.getTags()) {
                    translatedTags.add(translateText(SOURCE_TYPE_TAG, 0L, "tag_name", tag, targetLang));
                }
                recommend.setTags(translatedTags);
            }
        }
    }

    public void translateReviews(List<ReviewVO> reviews) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || reviews == null || reviews.isEmpty()) {
            return;
        }

        for (ReviewVO review : reviews) {
            if (review == null) {
                continue;
            }
            Long sourcePk = review.getReviewIdx() == null ? 0L : review.getReviewIdx();
            review.setContent(translateText(SOURCE_TYPE_REVIEW, sourcePk, "content",
                    review.getContent(), targetLang));
        }
    }

    public void translateCommunityPost(CommunityPostDto post) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || post == null) {
            return;
        }

        Long sourcePk = post.getPostId() == null ? 0L : post.getPostId();
        post.setTitle(translateText(
                SOURCE_TYPE_COMMUNITY_POST,
                sourcePk,
                "title",
                post.getTitle(),
                targetLang
        ));
        post.setContent(translateText(
                SOURCE_TYPE_COMMUNITY_POST,
                sourcePk,
                "content",
                post.getContent(),
                targetLang
        ));
    }

    public void translateCommunityPosts(List<CommunityPostDto> posts) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || posts == null || posts.isEmpty()) {
            return;
        }

        for (CommunityPostDto post : posts) {
            translateCommunityPost(post);
        }
    }

    public void translateCommunityComments(List<CommunityCommentDto> comments) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || comments == null || comments.isEmpty()) {
            return;
        }

        for (CommunityCommentDto comment : comments) {
            if (comment == null) {
                continue;
            }
            Long sourcePk = comment.getCommentId() == null ? 0L : comment.getCommentId();
            comment.setContent(translateText(
                    SOURCE_TYPE_COMMUNITY_COMMENT,
                    sourcePk,
                    "content",
                    comment.getContent(),
                    targetLang
            ));
        }
    }

    public List<String> translateCommunityTags(List<String> tags) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || tags == null || tags.isEmpty()) {
            return tags;
        }

        List<String> translated = new ArrayList<>(tags.size());
        for (String tag : tags) {
            translated.add(translateCommunityTag(tag, targetLang));
        }
        return translated;
    }

    public String translateText(String sourceType, Long sourcePk, String fieldName, String sourceText, String targetLang) {
        if (sourceText == null || sourceText.isBlank()) {
            return sourceText;
        }
        if (targetLang == null || targetLang.isBlank() || "ko".equals(targetLang)) {
            return sourceText;
        }
        if (googleTranslateApiKey == null || googleTranslateApiKey.isBlank()) {
            log.warn("[Translate] API key is empty. Skip translation for {} / {}", sourceType, fieldName);
            return sourceText;
        }

        String normalizedText = sourceText.trim();
        String sourceTextHash = sha256(normalizedText);
        Long normalizedPk = sourcePk == null ? 0L : sourcePk;

        SpotTextTranslationVO cached = translationMapper.selectCache(
                sourceType, normalizedPk, fieldName, sourceTextHash, targetLang);
        if (cached != null && cached.getTranslatedText() != null && !cached.getTranslatedText().isBlank()) {
            return cached.getTranslatedText();
        }

        String translatedText = requestTranslation(normalizedText, targetLang);
        if (translatedText == null || translatedText.isBlank()) {
            translatedText = normalizedText;
        }

        SpotTextTranslationVO cache = new SpotTextTranslationVO();
        cache.setCacheId(UUID.randomUUID().toString());
        cache.setSourceType(sourceType);
        cache.setSourcePk(normalizedPk);
        cache.setFieldName(fieldName);
        cache.setSourceText(normalizedText);
        cache.setSourceTextHash(sourceTextHash);
        cache.setTargetLang(targetLang);
        cache.setTranslatedText(translatedText);
        cache.setProvider(PROVIDER);
        translationMapper.upsertCache(cache);

        return translatedText;
    }

    /**
     * 추천 사유는 일부가 고정 코드값이고, 일부는 AI가 만든 자유 문장이다.
     * 고정값은 메시지 번들로 우선 번역하고, 나머지는 일반 번역 캐시를 사용한다.
     */
    private String translateRecommendReason(RecommendVO recommend, String targetLang) {
        if (recommend == null || recommend.getRecReason() == null || recommend.getRecReason().isBlank()) {
            return recommend == null ? null : recommend.getRecReason();
        }

        String localizedReason = resolveRecommendReasonMessage(recommend.getRecReason());
        if (!localizedReason.equals(recommend.getRecReason())) {
            return localizedReason;
        }

        Long sourcePk = recommend.getSpotIdx() == null ? 0L : recommend.getSpotIdx();
        return translateText(SOURCE_TYPE_RECOMMEND, sourcePk, "rec_reason", recommend.getRecReason(), targetLang);
    }

    private String resolveRecommendReasonMessage(String reason) {
        if (reason == null) {
            return "";
        }

        String normalized = reason.trim().replace(" ", "");
        String messageCode = switch (normalized) {
            case "태그유사" -> "recommend.reason.tagMatch";
            case "취향반영" -> "recommend.reason.preference";
            default -> null;
        };

        if (messageCode == null) {
            return reason;
        }

        return messageSource.getMessage(messageCode, null, reason, LocaleContextHolder.getLocale());
    }

    /**
     * 커뮤니티 태그는 한두 글자짜리 짧은 값이 많아서 기계 번역 품질이 흔들릴 수 있다.
     * 자주 쓰는 고정 태그는 메시지 번들로 먼저 처리하고, 나머지만 일반 번역 API를 사용한다.
     */
    private String translateCommunityTag(String tag, String targetLang) {
        if (tag == null || tag.isBlank()) {
            return tag;
        }

        String localizedTag = resolveCommunityTagMessage(tag);
        if (!localizedTag.equals(tag)) {
            return localizedTag;
        }

        return translateText(SOURCE_TYPE_COMMUNITY_TAG, 0L, "tag_name", tag, targetLang);
    }

    private String resolveCommunityTagMessage(String tag) {
        if (tag == null) {
            return "";
        }

        String normalized = tag.trim().replace(" ", "");
        String messageCode = switch (normalized) {
            case "후기" -> "community.tag.review";
            default -> null;
        };

        if (messageCode == null) {
            return tag;
        }

        return messageSource.getMessage(messageCode, null, tag, LocaleContextHolder.getLocale());
    }

    private void translateExploreSpot(ExploreVO spot, String targetLang) {
        if (spot == null) {
            return;
        }

        Long sourcePk = spot.getSpotIdx() == null ? 0L : spot.getSpotIdx();
        spot.setName(translateText(SOURCE_TYPE_SPOT, sourcePk, "name", spot.getName(), targetLang));
        spot.setRegion(translateText(SOURCE_TYPE_SPOT, sourcePk, "region", spot.getRegion(), targetLang));
        spot.setAddress(translateText(SOURCE_TYPE_SPOT, sourcePk, "address", spot.getAddress(), targetLang));
        spot.setDescription(translateText(SOURCE_TYPE_SPOT, sourcePk, "description", spot.getDescription(), targetLang));

        if (spot.getTags() != null && !spot.getTags().isEmpty()) {
            List<String> translatedTags = new ArrayList<>(spot.getTags().size());
            for (String tag : spot.getTags()) {
                translatedTags.add(translateText(SOURCE_TYPE_TAG, 0L, "tag_name", tag, targetLang));
            }
            spot.setTags(translatedTags);
        }
    }

    private String requestTranslation(String sourceText, String targetLang) {
        try {
            String endpoint = String.format(GOOGLE_TRANSLATE_URL, googleTranslateApiKey);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            Map<String, Object> body = new LinkedHashMap<>();
            body.put("q", Collections.singletonList(sourceText));
            body.put("target", normalizeTargetLanguage(targetLang));
            body.put("format", "text");

            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);
            @SuppressWarnings("unchecked")
            Map<String, Object> response = restTemplate.postForObject(endpoint, entity, Map.class);
            if (response == null) {
                return sourceText;
            }

            Object dataObj = response.get("data");
            if (!(dataObj instanceof Map<?, ?> data)) {
                return sourceText;
            }
            Object translationsObj = data.get("translations");
            if (!(translationsObj instanceof List<?> translations) || translations.isEmpty()) {
                return sourceText;
            }
            Object firstObj = translations.get(0);
            if (!(firstObj instanceof Map<?, ?> firstTranslation)) {
                return sourceText;
            }
            Object translatedText = firstTranslation.get("translatedText");
            return HtmlUtils.htmlUnescape(asText(translatedText));
        } catch (Exception e) {
            log.warn("[Translate] Google Cloud Translation request failed: {}", e.getMessage());
            return sourceText;
        }
    }

    private String getTargetLanguage() {
        String language = LocaleContextHolder.getLocale().getLanguage();
        if ("en".equals(language) || "ja".equals(language) || "zh".equals(language)) {
            return language;
        }
        return null;
    }

    private String normalizeTargetLanguage(String targetLang) {
        if ("zh".equals(targetLang)) {
            return "zh-CN";
        }
        return targetLang;
    }

    private Long extractLong(Object value) {
        try {
            return value == null ? 0L : Long.parseLong(String.valueOf(value));
        } catch (Exception e) {
            return 0L;
        }
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
            throw new IllegalStateException("Failed to create SHA-256 hash.", e);
        }
    }
}
