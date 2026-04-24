package org.triptogether.common.service;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.triptogether.common.vo.ChatIntentVO;
import org.triptogether.community.mapper.CommunityMapper;
import org.triptogether.courses.mapper.TravelPlanMapper;
import org.triptogether.explore.mapper.ExploreMapper;
import org.triptogether.explore.service.SpotTextTranslationService;
import org.triptogether.travelPackage.mapper.TravelPackageMapper;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 챗봇 1차 분류(의도·키워드 추출) + 실시간 콘텐츠 컨텍스트 빌더.
 *
 * 흐름:
 *   1. classify(message)  — Gemini 를 짧게 호출해 의도/키워드 JSON 획득
 *   2. buildContextSection(intent) — 키워드로 DB 조회 후 프롬프트 섹션 생성
 *
 * Gemini 호출 실패·타임아웃 시 규칙 기반 fallback (기존 불용어·토큰화 로직 유지).
 * 캐시: 동일 메시지 재분류 방지 (ConcurrentHashMap, TTL 60초, 상한 500).
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class IntentContextService {

    private static final int MAX_KEYWORDS = 8;
    private static final int MIN_KEYWORD_LEN = 2;
    private static final int SPOT_CANDIDATE_LIMIT = 5;
    private static final int PLAN_CANDIDATE_LIMIT = 5;
    private static final int PACKAGE_CANDIDATE_LIMIT = 5;
    private static final int POST_CANDIDATE_LIMIT = 5;

    private static final long CACHE_TTL_MILLIS = 60_000L;
    private static final int CACHE_MAX_SIZE = 500;

    private static final String GEMINI_URL =
            "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=";

    // 분류 전용 시스템 프롬프트 (매우 짧고 결정적으로)
    private static final String CLASSIFY_SYSTEM_PROMPT = """
            다음 사용자 메시지를 분석해 JSON 으로만 답하세요. 다른 텍스트는 절대 포함하지 마세요.

            출력 형식:
            {
              "intent": "EXPLORE" | "COURSES" | "PACKAGES" | "COMMUNITY" | "GENERIC" | "INAPPROPRIATE",
              "keywords": ["검색용 핵심 명사 (지역명·장소명·테마·시기 등). 없으면 빈 배열"],
              "relatedTerms": ["유의어·관련어. 예: '신혼여행'→['로맨틱','커플','일몰']. 없으면 빈 배열"]
            }

            분류 기준:
            - EXPLORE: 여행지(도쿄·파리 등) 자체 탐색 의도
            - COURSES: 여행 일정·코스·며칠짜리 루트
            - PACKAGES: 판매 상품·가격·예약 관련
            - COMMUNITY: 후기·팁·다른 유저 경험
            - GENERIC: 위에 해당 없는 여행 관련 일반 질문 (사이트 이용법 포함)
            - INAPPROPRIATE: 욕설·여행 무관 잡담(주식·정치·연예인 등)·개인정보 요구

            keywords 는 DB LIKE 검색용이므로 짧은 명사만. 조사·동사·형용사 제외.
            ★ 중요: 사이트 DB 원본 언어가 **한국어** 이므로 keywords 는 반드시 한국어로 정규화하세요.
              예: 'Paris' → '파리', 'Tokyo' → '도쿄', 'Bali' → '발리',
                   '東京' → '도쿄', '巴黎' → '파리', 'Kyoto' → '교토'
              고유명사는 한국어 표기(도시명·관광지명)를 사용해야 DB 매칭이 가능합니다.
            relatedTerms 는 의미 확장용. 한국어 기준으로 최대 5개. (예: '신혼여행' → ['로맨틱','커플','일몰'])
            """;

    // 규칙 기반 fallback 용 불용어 사전
    private static final Set<String> STOPWORDS = Set.of(
            "가고", "가자", "갈래", "갈까", "간다", "가는", "갔다",
            "싶다", "싶어", "싶은데", "싶어요", "싶네",
            "해줘", "해줄래", "해주세요", "알려줘", "알려주세요",
            "있다", "있어", "있는", "있나", "없다", "없어", "없는",
            "하고", "하는", "하면", "한다", "하다", "함",
            "되는", "되나", "된다", "되서",
            "어떻게", "어떡해", "어떡하지", "어디", "어느", "어떤", "어쩌지",
            "뭐", "뭔가", "무엇", "무슨",
            "왜", "언제", "누가",
            "추천", "좋은", "좋아", "좋다", "좋을까", "최고", "최악",
            "인기", "유명", "핫한", "요즘", "요새",
            "나는", "내가", "저는", "제가", "우리",
            "많은", "적은", "조금", "약간", "많이",
            "지금", "오늘", "내일", "이번", "다음", "얼른", "당장",
            "그리고", "하지만", "또는", "혹은", "그런데", "근데",
            "여행", "여행지", "관광", "관광지", "일정", "계획",
            "정말", "엄청", "매우", "진짜", "아주", "완전",
            "근처", "주변", "어디든",
            "그냥"
    );

    private final ExploreMapper exploreMapper;
    private final TravelPlanMapper travelPlanMapper;
    private final TravelPackageMapper travelPackageMapper;
    private final CommunityMapper communityMapper;
    private final RestTemplate restTemplate;
    private final SpotTextTranslationService translationService;

    @Value("${gemini.api.key}")
    private String geminiApiKey;

    private final Map<String, CachedIntent> cache = new ConcurrentHashMap<>();

    // ══════════════════════════════════════════════════════════
    // 1. 분류 (LLM 호출 + fallback)
    // ══════════════════════════════════════════════════════════

    /**
     * 사용자 메시지를 LLM 으로 분류. 실패 시 규칙 기반으로 대체.
     * 동일 메시지는 60초간 캐시된다.
     */
    public ChatIntentVO classify(String userMessage) {
        if (userMessage == null || userMessage.isBlank()) {
            return ChatIntentVO.builder()
                    .intent(ChatIntentVO.INTENT_GENERIC)
                    .keywords(List.of())
                    .relatedTerms(List.of())
                    .build();
        }

        String cacheKey = userMessage.trim().toLowerCase();
        CachedIntent cached = cache.get(cacheKey);
        long now = System.currentTimeMillis();
        if (cached != null && now - cached.timestamp < CACHE_TTL_MILLIS) {
            return cached.intent;
        }

        ChatIntentVO intent;
        try {
            intent = classifyWithGemini(userMessage);
        } catch (Exception e) {
            log.warn("[Chatbot] 분류 호출 실패 → 규칙 기반 fallback 사용. 원인={}", e.getMessage());
            intent = fallbackClassification(userMessage);
        }

        // 단순 용량 관리 — 상한 초과 시 전체 clear
        if (cache.size() > CACHE_MAX_SIZE) cache.clear();
        cache.put(cacheKey, new CachedIntent(intent, now));
        return intent;
    }

    private ChatIntentVO classifyWithGemini(String userMessage) {
        JsonObject systemInstruction = new JsonObject();
        JsonArray systemParts = new JsonArray();
        JsonObject systemPart = new JsonObject();
        systemPart.addProperty("text", CLASSIFY_SYSTEM_PROMPT);
        systemParts.add(systemPart);
        systemInstruction.add("parts", systemParts);

        JsonArray contents = new JsonArray();
        JsonObject msg = new JsonObject();
        msg.addProperty("role", "user");
        JsonArray parts = new JsonArray();
        JsonObject part = new JsonObject();
        part.addProperty("text", userMessage);
        parts.add(part);
        msg.add("parts", parts);
        contents.add(msg);

        JsonObject generationConfig = new JsonObject();
        generationConfig.addProperty("responseMimeType", "application/json");
        generationConfig.addProperty("temperature", 0);
        generationConfig.addProperty("maxOutputTokens", 256);

        JsonObject payload = new JsonObject();
        payload.add("systemInstruction", systemInstruction);
        payload.add("contents", contents);
        payload.add("generationConfig", generationConfig);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        ResponseEntity<String> response = restTemplate.exchange(
                GEMINI_URL + geminiApiKey,
                HttpMethod.POST,
                new HttpEntity<>(payload.toString(), headers),
                String.class
        );
        return parseClassificationResponse(response.getBody());
    }

    private ChatIntentVO parseClassificationResponse(String body) {
        JsonObject root = JsonParser.parseString(body).getAsJsonObject();
        if (!root.has("candidates") || root.getAsJsonArray("candidates").isEmpty()) {
            throw new IllegalStateException("candidates 없음");
        }
        JsonObject candidate = root.getAsJsonArray("candidates").get(0).getAsJsonObject();
        if (!candidate.has("content")) {
            throw new IllegalStateException("content 없음 (safety block 가능성)");
        }
        JsonObject content = candidate.getAsJsonObject("content");
        if (!content.has("parts") || content.getAsJsonArray("parts").isEmpty()) {
            throw new IllegalStateException("parts 없음");
        }
        String text = content.getAsJsonArray("parts").get(0).getAsJsonObject()
                .get("text").getAsString().trim();
        // 혹시 모를 code fence 제거
        text = text.replaceAll("(?s)```json\\s*", "").replaceAll("```\\s*", "").trim();

        JsonObject obj = JsonParser.parseString(text).getAsJsonObject();

        String intent = obj.has("intent") ? obj.get("intent").getAsString() : ChatIntentVO.INTENT_GENERIC;
        if (!isValidIntent(intent)) intent = ChatIntentVO.INTENT_GENERIC;

        List<String> keywords = readStringArray(obj, "keywords");
        List<String> related  = readStringArray(obj, "relatedTerms");

        return ChatIntentVO.builder()
                .intent(intent)
                .keywords(keywords)
                .relatedTerms(related)
                .build();
    }

    private List<String> readStringArray(JsonObject obj, String key) {
        if (!obj.has(key) || obj.get(key).isJsonNull()) return List.of();
        JsonElement el = obj.get(key);
        if (!el.isJsonArray()) return List.of();
        List<String> out = new ArrayList<>();
        for (JsonElement e : el.getAsJsonArray()) {
            if (e == null || e.isJsonNull()) continue;
            String v = e.getAsString();
            if (v == null) continue;
            String cleaned = v.trim();
            if (!cleaned.isEmpty() && out.size() < MAX_KEYWORDS) out.add(cleaned);
        }
        return out;
    }

    private boolean isValidIntent(String s) {
        return ChatIntentVO.INTENT_EXPLORE.equals(s)
                || ChatIntentVO.INTENT_COURSES.equals(s)
                || ChatIntentVO.INTENT_PACKAGES.equals(s)
                || ChatIntentVO.INTENT_COMMUNITY.equals(s)
                || ChatIntentVO.INTENT_GENERIC.equals(s)
                || ChatIntentVO.INTENT_INAPPROPRIATE.equals(s);
    }

    /** LLM 호출 실패·파싱 실패 시 규칙 기반으로 최소한의 결과 생성 */
    private ChatIntentVO fallbackClassification(String message) {
        return ChatIntentVO.builder()
                .intent(ChatIntentVO.INTENT_GENERIC)
                .keywords(extractKeywordsByRule(message))
                .relatedTerms(List.of())
                .build();
    }

    // ══════════════════════════════════════════════════════════
    // 2. 컨텍스트 섹션 빌드 (intent 기반 DB 조회)
    // ══════════════════════════════════════════════════════════

    /**
     * 분류 결과의 키워드+관련어로 DB 조회해 프롬프트 섹션 문자열 생성.
     * 후보 0개 또는 키워드 0개면 빈 문자열.
     */
    public String buildContextSection(ChatIntentVO intent) {
        if (intent == null) return "";
        List<String> combined = combineKeywords(intent);
        if (combined.isEmpty()) return "";

        List<Map<String, Object>> spots    = safeSearchSpots(combined);
        List<Map<String, Object>> plans    = safeSearchPlans(combined);
        List<Map<String, Object>> packages = safeSearchPackages(combined);
        List<Map<String, Object>> posts    = safeSearchPosts(combined);

        if (spots.isEmpty() && plans.isEmpty() && packages.isEmpty() && posts.isEmpty()) return "";

        StringBuilder sb = new StringBuilder();
        sb.append("## 실시간 후보 데이터\n");
        sb.append("분류 의도: ").append(intent.getIntent()).append("\n");
        sb.append("사용자 언급 키워드: ").append(combined).append("\n");

        if (!spots.isEmpty())    appendSpotsSection(sb, spots);
        if (!plans.isEmpty())    appendPlansSection(sb, plans);
        if (!packages.isEmpty()) appendPackagesSection(sb, packages);
        if (!posts.isEmpty())    appendPostsSection(sb, posts);

        sb.append("\n중요 지침:\n");
        sb.append("- links 의 url 은 반드시 위 후보의 실제 id 를 사용하세요.\n");
        sb.append("- 여행지 상세: /detail/{spotIdx}, 코스 상세: /courses/detail?planId={planId}, 커뮤니티 글: /community/{postId}\n");
        sb.append("- 패키지는 공개 상세 페이지가 없으므로 url 은 항상 /packages (리스트 루트) 만 사용하고,\n");
        sb.append("  메시지 본문에 패키지 제목·가격·연결 여행지를 요약해 언급하세요.\n");
        sb.append("- 존재하지 않는 id 는 절대 만들지 마세요.\n");
        sb.append("- 후보가 비어있는 카테고리는 일반 list 페이지(/explore, /courses, /packages, /community/list)만 제시하세요.\n");
        return sb.toString();
    }

    private List<String> combineKeywords(ChatIntentVO intent) {
        Set<String> seen = new LinkedHashSet<>();
        if (intent.getKeywords() != null) {
            for (String k : intent.getKeywords()) {
                if (k != null && k.length() >= MIN_KEYWORD_LEN) seen.add(k.trim());
            }
        }
        if (intent.getRelatedTerms() != null) {
            for (String k : intent.getRelatedTerms()) {
                if (k != null && k.length() >= MIN_KEYWORD_LEN) seen.add(k.trim());
                if (seen.size() >= MAX_KEYWORDS) break;
            }
        }
        List<String> out = new ArrayList<>(seen);
        if (out.size() > MAX_KEYWORDS) return out.subList(0, MAX_KEYWORDS);
        return out;
    }

    // ── 모듈별 조회 (실패 시 빈 리스트) ──

    private List<Map<String, Object>> safeSearchSpots(List<String> keywords) {
        try {
            List<Map<String, Object>> rows = exploreMapper.searchSpotsByKeywords(keywords, SPOT_CANDIDATE_LIMIT);
            return rows != null ? rows : List.of();
        } catch (Exception e) {
            log.warn("[Chatbot] 여행지 후보 조회 실패 — keywords={}, 원인={}", keywords, e.getMessage());
            return List.of();
        }
    }

    private List<Map<String, Object>> safeSearchPlans(List<String> keywords) {
        try {
            List<Map<String, Object>> rows = travelPlanMapper.searchPlansByKeywords(keywords, PLAN_CANDIDATE_LIMIT);
            return rows != null ? rows : List.of();
        } catch (Exception e) {
            log.warn("[Chatbot] 코스 후보 조회 실패 — keywords={}, 원인={}", keywords, e.getMessage());
            return List.of();
        }
    }

    private List<Map<String, Object>> safeSearchPackages(List<String> keywords) {
        try {
            List<Map<String, Object>> rows = travelPackageMapper.searchPackagesByKeywords(keywords, PACKAGE_CANDIDATE_LIMIT);
            return rows != null ? rows : List.of();
        } catch (Exception e) {
            log.warn("[Chatbot] 패키지 후보 조회 실패 — keywords={}, 원인={}", keywords, e.getMessage());
            return List.of();
        }
    }

    private List<Map<String, Object>> safeSearchPosts(List<String> keywords) {
        try {
            List<Map<String, Object>> rows = communityMapper.searchPostsByKeywords(keywords, POST_CANDIDATE_LIMIT);
            return rows != null ? rows : List.of();
        } catch (Exception e) {
            log.warn("[Chatbot] 커뮤니티 후보 조회 실패 — keywords={}, 원인={}", keywords, e.getMessage());
            return List.of();
        }
    }

    // ── 섹션 빌더 ──

    private void appendSpotsSection(StringBuilder sb, List<Map<String, Object>> spots) {
        sb.append("\n### 여행지 후보 (링크 형식: /detail/{spotIdx})\n");
        for (Map<String, Object> row : spots) {
            Object idx = row.get("spotIdx");
            Long spotIdx = toLong(idx);
            String name = localized("SPOT", spotIdx, "name", asStr(row.get("name")));
            String region = localized("SPOT", spotIdx, "region", asStr(row.get("region")));
            String desc = localized("SPOT", spotIdx, "description", asStr(row.get("description")));
            Object rating = row.get("ratingAvg");
            Object reviewCount = row.get("reviewCount");

            sb.append("- spotIdx=").append(idx)
              .append(", \"").append(name).append("\"")
              .append(!isBlank(region) ? " (" + region + ")" : "")
              .append(rating != null ? " — ★" + rating : "")
              .append(reviewCount != null ? " · 리뷰 " + reviewCount : "")
              .append(!isBlank(desc) ? " — " + truncate(desc, 80) : "")
              .append("\n");
        }
    }

    private void appendPlansSection(StringBuilder sb, List<Map<String, Object>> plans) {
        sb.append("\n### 여행 코스 후보 (링크 형식: /courses/detail?planId={planId})\n");
        for (Map<String, Object> row : plans) {
            Object id = row.get("planId");
            Object title = row.get("title");
            Object destination = row.get("destination");
            Object start = row.get("startDate");
            Object end = row.get("endDate");

            sb.append("- planId=").append(id)
              .append(", \"").append(title).append("\"")
              .append(destination != null ? " (목적지: " + destination + ")" : "")
              .append((start != null && end != null) ? " · " + start + "~" + end : "")
              .append("\n");
        }
    }

    private void appendPostsSection(StringBuilder sb, List<Map<String, Object>> posts) {
        sb.append("\n### 커뮤니티 게시글 후보 (링크 형식: /community/{postId})\n");
        for (Map<String, Object> row : posts) {
            Object id = row.get("postId");
            Long postId = toLong(id);
            String title = localized("COMMUNITY_POST", postId, "title", asStr(row.get("title")));
            Object type = row.get("postType");
            Object nickname = row.get("nickname");
            Object likeCount = row.get("likeCount");
            Object commentCount = row.get("commentCount");

            sb.append("- postId=").append(id)
              .append(", \"").append(title).append("\"")
              .append(type != null ? " [" + type + "]" : "")
              .append(nickname != null ? " · by " + nickname : "")
              .append(likeCount != null ? " · ♥" + likeCount : "")
              .append(commentCount != null ? " · 댓글 " + commentCount : "")
              .append("\n");
        }
    }

    private void appendPackagesSection(StringBuilder sb, List<Map<String, Object>> packages) {
        sb.append("\n### 여행 패키지 후보 (링크는 반드시 /packages 루트 사용)\n");
        for (Map<String, Object> row : packages) {
            Object idx = row.get("packageIdx");
            Long packageIdx = toLong(idx);
            Long spotIdx = toLong(row.get("spotIdx"));
            String title = localized("TRAVEL_PACKAGE", packageIdx, "package_title", asStr(row.get("packageTitle")));
            String summary = localized("TRAVEL_PACKAGE", packageIdx, "package_summary", asStr(row.get("packageSummary")));
            String spotName = localized("SPOT", spotIdx, "name", asStr(row.get("spotName")));
            String spotRegion = localized("SPOT", spotIdx, "region", asStr(row.get("spotRegion")));
            Object price = row.get("packagePrice");
            Object currency = row.get("currencyCode");
            Object bookingCount = row.get("bookingCount");

            sb.append("- packageIdx=").append(idx)
              .append(", \"").append(title).append("\"");
            if (price != null) {
                sb.append(" · ").append(currency != null ? currency : "KRW").append(" ").append(price);
            }
            if (bookingCount != null) sb.append(" · 예약 ").append(bookingCount).append("건");
            if (!isBlank(spotName)) {
                sb.append(" · 연결 여행지: ").append(spotName);
                if (!isBlank(spotRegion)) sb.append("(").append(spotRegion).append(")");
            }
            if (!isBlank(summary)) sb.append(" — ").append(truncate(summary, 60));
            sb.append("\n");
        }
    }

    /**
     * EXPLORE 의도일 때 관련 패키지 자동 부착용 — 매칭 패키지가 1건 이상이면 첫 키워드 반환.
     * 없으면 null (부착 skip).
     */
    public String findRelatedPackageKeyword(ChatIntentVO intent) {
        if (intent == null) return null;
        List<String> keywords = combineKeywords(intent);
        if (keywords.isEmpty()) return null;
        try {
            List<Map<String, Object>> rows = travelPackageMapper.searchPackagesByKeywords(keywords, 1);
            if (rows == null || rows.isEmpty()) return null;
            return keywords.get(0);
        } catch (Exception e) {
            log.warn("[Chatbot] 관련 패키지 조회 실패 — 원인={}", e.getMessage());
            return null;
        }
    }

    // ══════════════════════════════════════════════════════════
    // 3. Fallback 유틸 (LLM 호출 실패 시 사용)
    // ══════════════════════════════════════════════════════════

    private List<String> extractKeywordsByRule(String message) {
        if (message == null || message.isBlank()) return List.of();

        String[] raw = message.split("\\s+");
        List<String> result = new ArrayList<>();
        Set<String> seen = new HashSet<>();

        for (String token : raw) {
            String cleaned = token.replaceAll("[^가-힣a-zA-Z0-9]", "");
            if (cleaned.length() < MIN_KEYWORD_LEN) continue;
            String lower = cleaned.toLowerCase();
            if (STOPWORDS.contains(lower)) continue;
            if (seen.contains(lower)) continue;
            seen.add(lower);
            result.add(cleaned);
            if (result.size() >= MAX_KEYWORDS) break;
        }
        return result;
    }

    private String truncate(String s, int max) {
        if (s == null) return "";
        String flat = s.replaceAll("\\s+", " ").trim();
        return flat.length() <= max ? flat : flat.substring(0, max) + "…";
    }

    /**
     * 현재 사용자 로케일이 ko 외(en/ja/zh) 이면 SpotTextTranslationService 의 번역 캐시를 거쳐 반환.
     * ko 이거나 텍스트가 비어있으면 원문 그대로.
     */
    private String localized(String sourceType, Long pk, String field, String text) {
        if (text == null || text.isBlank()) return text;
        String lang = LocaleContextHolder.getLocale().getLanguage();
        if (!"en".equals(lang) && !"ja".equals(lang) && !"zh".equals(lang)) return text;
        try {
            return translationService.translateText(sourceType, pk == null ? 0L : pk, field, text, lang);
        } catch (Exception e) {
            log.warn("[Chatbot] 번역 실패 → 원문 사용. sourceType={}, pk={}, field={}, 원인={}",
                    sourceType, pk, field, e.getMessage());
            return text;
        }
    }

    private Long toLong(Object v) {
        if (v == null) return 0L;
        if (v instanceof Number n) return n.longValue();
        try { return Long.parseLong(String.valueOf(v)); } catch (Exception e) { return 0L; }
    }

    private String asStr(Object v) {
        return v == null ? "" : String.valueOf(v);
    }

    private boolean isBlank(String s) {
        return s == null || s.isBlank();
    }

    // ── 캐시 엔트리 ──
    private static class CachedIntent {
        final ChatIntentVO intent;
        final long timestamp;
        CachedIntent(ChatIntentVO intent, long timestamp) {
            this.intent = intent;
            this.timestamp = timestamp;
        }
    }
}
