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
import org.triptogether.courses.vo.PlanSpotVO;
import org.triptogether.courses.vo.TravelPlanVO;
import org.triptogether.explore.mapper.SpotTextTranslationMapper;
import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.explore.vo.RecommendVO;
import org.triptogether.explore.vo.ReviewVO;
import org.triptogether.explore.vo.SpotTextTranslationVO;
import org.triptogether.myPage.vo.WalletHistoryDto;
/* ── 패키지 번역 기능에서 사용하는 VO import ── */
import org.triptogether.travelPackage.vo.TravelPackageVO;
import org.triptogether.travelPackage.vo.TravelPackageRevisionVO;
/* ── 패키지 등록/수정 폼의 여행지 드롭다운 옵션 번역에 사용 ── */
import org.triptogether.travelPackage.vo.PackageSpotOptionVO;

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
    /* ── 패키지 상품의 동적 텍스트(제목, 요약, 여행지명 등)를 번역하기 위한 소스 타입 ── */
    private static final String SOURCE_TYPE_PACKAGE = "TRAVEL_PACKAGE";
    /* ── 패키지 수정 요청본의 동적 텍스트를 번역하기 위한 소스 타입 ── */
    private static final String SOURCE_TYPE_PACKAGE_REVISION = "TRAVEL_PACKAGE_REVISION";
    private static final String SOURCE_TYPE_WALLET_HISTORY = "WALLET_HISTORY";
    private static final String SOURCE_TYPE_TRAVEL_PLAN = "TRAVEL_PLAN";
    private static final String SOURCE_TYPE_PLAN_SPOT = "PLAN_SPOT";
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

    /**
     * 내 지갑의 자산 변동 이력 상세 문구는 DB에 저장되는 동적 텍스트다.
     * 고정 메시지 번들이 아니라 번역 캐시에 저장해두면 기존 이력도 언어 전환 시 번역해서 보여줄 수 있다.
     */
    public void translateWalletHistories(List<WalletHistoryDto> histories) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || histories == null || histories.isEmpty()) {
            return;
        }

        for (WalletHistoryDto history : histories) {
            if (history == null) {
                continue;
            }
            Long sourcePk = history.getWalletHistoryIdx() == null ? 0L : history.getWalletHistoryIdx();
            history.setDetailMessage(translateText(
                    SOURCE_TYPE_WALLET_HISTORY,
                    sourcePk,
                    "detail_message",
                    history.getDetailMessage(),
                    targetLang
            ));
        }
    }

    /**
     * 여행 코스 목록에 표시되는 DB 입력 문구를 현재 언어로 번역한다.
     * 화면 고정 문구는 message properties가 담당하고, 사용자가 작성한 제목/목적지는 번역 캐시에 저장한다.
     */
    public void translateTravelPlans(List<TravelPlanVO> plans) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || plans == null || plans.isEmpty()) {
            return;
        }

        for (TravelPlanVO plan : plans) {
            translateTravelPlan(plan, targetLang);
        }
    }

    /**
     * 여행 코스 상세에 표시되는 일정 제목, 대표 목적지, 방문 장소명을 번역한다.
     */
    public void translateTravelPlan(TravelPlanVO plan) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || plan == null) {
            return;
        }
        translateTravelPlan(plan, targetLang);
    }

    private void translateTravelPlan(TravelPlanVO plan, String targetLang) {
        if (plan == null) {
            return;
        }

        Long sourcePk = plan.getPlan_id() == null ? 0L : plan.getPlan_id();
        plan.setTitle(translateText(SOURCE_TYPE_TRAVEL_PLAN, sourcePk, "title", plan.getTitle(), targetLang));
        plan.setDestination(translateText(SOURCE_TYPE_TRAVEL_PLAN, sourcePk, "destination", plan.getDestination(), targetLang));

        List<PlanSpotVO> spotList = plan.getSpotList();
        if (spotList == null || spotList.isEmpty()) {
            return;
        }

        for (PlanSpotVO spot : spotList) {
            if (spot == null) {
                continue;
            }
            Long spotSourcePk = spot.getPlan_spot_id() == null ? 0L : spot.getPlan_spot_id();
            spot.setPlace_name(translateText(SOURCE_TYPE_PLAN_SPOT, spotSourcePk, "place_name", spot.getPlace_name(), targetLang));
            spot.setName(translateText(SOURCE_TYPE_SPOT, extractLong(spot.getSpot_id()), "name", spot.getName(), targetLang));
            spot.setRegion(translateText(SOURCE_TYPE_SPOT, extractLong(spot.getSpot_id()), "region", spot.getRegion(), targetLang));
            spot.setAddress(translateText(SOURCE_TYPE_SPOT, extractLong(spot.getSpot_id()), "address", spot.getAddress(), targetLang));
        }
    }

    // ═══════════════════════════════════════════════════════════════════
    //  패키지 상품(TravelPackageVO) 동적 텍스트 번역
    //  - 패키지 제목(packageTitle), 요약(packageSummary), 반려 사유(rejectReason)
    //  - 연결된 여행지명(spotName), 여행지 지역(spotRegion), 판매자 닉네임(sellerNickname)
    //  이 필드들은 사용자/관리자가 직접 입력하거나 DB에서 조인된 동적 값이므로
    //  프로퍼티 파일이 아닌 Google Translation API + DB 캐싱으로 번역합니다.
    // ═══════════════════════════════════════════════════════════════════

    /**
     * 패키지 목록 전체를 현재 로케일에 맞게 번역합니다.
     * Controller에서 model에 넘기기 직전에 호출하면 됩니다.
     *
     * @param packages 번역할 패키지 목록 (null이거나 비어있으면 무시)
     */
    public void translatePackages(List<TravelPackageVO> packages) {
        // 현재 사용자의 언어를 확인 — ko(한국어)이면 원문 그대로 반환
        String targetLang = getTargetLanguage();
        if (targetLang == null || packages == null || packages.isEmpty()) {
            return;
        }

        for (TravelPackageVO pkg : packages) {
            translatePackage(pkg, targetLang);
        }
    }

    /**
     * 패키지 단건을 현재 로케일에 맞게 번역합니다.
     *
     * @param pkg 번역할 패키지 VO (null이면 무시)
     */
    public void translatePackage(TravelPackageVO pkg) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || pkg == null) {
            return;
        }
        translatePackage(pkg, targetLang);
    }

    /**
     * 패키지 단건의 각 동적 필드를 번역하는 내부 메서드입니다.
     * translateText()는 DB 캐시를 먼저 확인하고, 없으면 Google API를 호출한 뒤 캐싱합니다.
     *
     * @param pkg        번역 대상 패키지 VO
     * @param targetLang 번역 목표 언어 코드 (en, ja, zh)
     */
    private void translatePackage(TravelPackageVO pkg, String targetLang) {
        if (pkg == null) {
            return;
        }

        // sourcePk: 번역 캐시에서 같은 패키지의 같은 필드를 구분하기 위한 키
        Long sourcePk = pkg.getPackageIdx() == null ? 0L : pkg.getPackageIdx();

        // 패키지 제목 번역 (예: "동대문중 미식 패키지" → "Dongdaemun Gourmet Package")
        pkg.setPackageTitle(translateText(
                SOURCE_TYPE_PACKAGE, sourcePk, "package_title",
                pkg.getPackageTitle(), targetLang));

        // 패키지 요약 번역 (예: "도심 속 미식 여행을 떠나보세요")
        pkg.setPackageSummary(translateText(
                SOURCE_TYPE_PACKAGE, sourcePk, "package_summary",
                pkg.getPackageSummary(), targetLang));

        // 반려 사유 번역 — 관리자가 한국어로 작성한 반려 사유를 판매자 언어로 번역
        pkg.setRejectReason(translateText(
                SOURCE_TYPE_PACKAGE, sourcePk, "reject_reason",
                pkg.getRejectReason(), targetLang));

        // 연결 여행지명 번역 (예: "동대문중학교" → 조인된 spot 테이블의 name)
        pkg.setSpotName(translateText(
                SOURCE_TYPE_SPOT, pkg.getSpotIdx() == null ? 0L : pkg.getSpotIdx(), "name",
                pkg.getSpotName(), targetLang));

        // 여행지 지역 번역 (예: "대한민국" → "South Korea")
        pkg.setSpotRegion(translateText(
                SOURCE_TYPE_SPOT, pkg.getSpotIdx() == null ? 0L : pkg.getSpotIdx(), "region",
                pkg.getSpotRegion(), targetLang));
    }

    /**
     * 패키지 수정 요청(리비전) 목록 전체를 현재 로케일에 맞게 번역합니다.
     * AdminController에서 관리자 페이지 데이터를 넘기기 전에 호출합니다.
     *
     * @param revisions 번역할 수정 요청 목록 (null이거나 비어있으면 무시)
     */
    public void translatePackageRevisions(List<TravelPackageRevisionVO> revisions) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || revisions == null || revisions.isEmpty()) {
            return;
        }

        for (TravelPackageRevisionVO revision : revisions) {
            if (revision == null) {
                continue;
            }

            Long sourcePk = revision.getPackageRevisionIdx() == null ? 0L : revision.getPackageRevisionIdx();

            // 수정 요청본의 제목 번역
            revision.setPackageTitle(translateText(
                    SOURCE_TYPE_PACKAGE_REVISION, sourcePk, "package_title",
                    revision.getPackageTitle(), targetLang));

            // 수정 요청본의 요약 번역
            revision.setPackageSummary(translateText(
                    SOURCE_TYPE_PACKAGE_REVISION, sourcePk, "package_summary",
                    revision.getPackageSummary(), targetLang));

            // 현재 노출 중인 원본 패키지 제목 번역 (비교용으로 표시되는 값)
            revision.setCurrentPackageTitle(translateText(
                    SOURCE_TYPE_PACKAGE, revision.getPackageIdx() == null ? 0L : revision.getPackageIdx(),
                    "package_title",
                    revision.getCurrentPackageTitle(), targetLang));

            // 연결 여행지명/지역 번역
            revision.setSpotName(translateText(
                    SOURCE_TYPE_SPOT, 0L, "name",
                    revision.getSpotName(), targetLang));
            revision.setSpotRegion(translateText(
                    SOURCE_TYPE_SPOT, 0L, "region",
                    revision.getSpotRegion(), targetLang));
        }
    }

    /**
     * 패키지 등록/수정 폼의 여행지 선택 드롭다운에 표시되는 여행지 이름과 지역을 번역합니다.
     * form.jsp에서 "[대한민국] 동대문중학교" 같은 옵션이 현재 로케일에 맞게 번역됩니다.
     *
     * @param spotOptions 번역할 여행지 옵션 목록 (null이거나 비어있으면 무시)
     */
    public void translateSpotOptions(List<PackageSpotOptionVO> spotOptions) {
        String targetLang = getTargetLanguage();
        if (targetLang == null || spotOptions == null || spotOptions.isEmpty()) {
            return;
        }

        for (PackageSpotOptionVO option : spotOptions) {
            if (option == null) {
                continue;
            }

            Long sourcePk = option.getSpotIdx() == null ? 0L : option.getSpotIdx();

            // 여행지 이름 번역 (예: "동대문중학교" → "Dongdaemun Middle School")
            option.setName(translateText(
                    SOURCE_TYPE_SPOT, sourcePk, "name",
                    option.getName(), targetLang));

            // 지역 번역 (예: "대한민국" → "South Korea")
            option.setRegion(translateText(
                    SOURCE_TYPE_SPOT, sourcePk, "region",
                    option.getRegion(), targetLang));
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
