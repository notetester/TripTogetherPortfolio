package org.triptogether.explore.service;

import com.google.gson.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.triptogether.explore.mapper.ExploreMapper;
import org.triptogether.explore.mapper.RecommendMapper;
import org.triptogether.explore.vo.CandidateSpotVO;
import org.triptogether.explore.vo.RecommendVO;
import org.triptogether.explore.vo.SpotViewLogVO;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Google Gemini API 기반 여행지 개인화 추천 서비스
 *
 * 수정 사항:
 * 1. 관심 태그 추출 → DB에서 태그 매칭 점수(tag_match_score) 계산 후 후보 정렬
 * 2. 이전 추천 spot 제외 (반복 방지) → mapper 쿼리 레벨에서 처리
 * 3. AI 추천 없을 때 "요즘 뜨는 여행지" 폴백 반환
 * 4. 프롬프트: 태그 유사도 기반 선택 + 반복 금지 강화
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class RecommendService {

    private final RecommendMapper recommendMapper;
    private final ExploreMapper   exploreMapper;
    private final SpotTextTranslationService spotTextTranslationService;
    private final RestTemplate    restTemplate;

    @Value("${gemini.api.key}")
    private String geminiApiKey;

    private static final String GEMINI_URL =
            "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=%s";

    private static final int VIEW_LOG_LIMIT = 30;
    private static final int RECOMMENDATION_LIMIT = 3;

    /* ============================================================
       체류 시간 기록
       ============================================================ */
    public void saveViewLog(Long userIdx, Long spotIdx, int staySeconds) {
        SpotViewLogVO viewLog = new SpotViewLogVO();
        viewLog.setUserIdx(userIdx);
        viewLog.setSpotIdx(spotIdx);
        viewLog.setStaySeconds(Math.max(1, Math.min(staySeconds, 3600)));
        try {
            recommendMapper.insertViewLog(viewLog);
            log.info("[Recommend] 체류 기록: userIdx={}, spotIdx={}, stay={}s",
                    userIdx, spotIdx, viewLog.getStaySeconds());
        } catch (Exception e) {
            log.error("[Recommend] 체류 기록 저장 실패", e);
        }
    }

    /* ============================================================
       캐시 무효화
       ============================================================ */
    public void invalidateCache(Long userIdx) {
        try {
            recommendMapper.deleteRecommends(userIdx);
            log.info("[Recommend] 캐시 무효화: userIdx={}", userIdx);
        } catch (Exception e) {
            log.warn("[Recommend] 캐시 무효화 실패: {}", e.getMessage());
        }
    }

    /* ============================================================
       AI 추천 조회 메인 (캐시 → Gemini → 트렌딩 폴백)
       ============================================================ */
    public List<RecommendVO> getRecommendations(Long userIdx, Long currentSpotIdx) {

        // 1. 5분 캐시 확인 (관심 태그 기반 재정렬 포함)
        List<SpotViewLogVO> logsForCache = recommendMapper.selectRecentViewLogs(userIdx, VIEW_LOG_LIMIT);
        Map<Long, Integer>  stayMapCache  = aggregateStay(logsForCache);
        Map<Long, Integer>  visitMapCache = buildVisitCountMap(logsForCache);
        Map<Long, String>   tagsMapCache  = buildTagsMap(logsForCache);
        Map<String, Integer> interestProfileCache = buildInterestProfile(stayMapCache, visitMapCache, tagsMapCache);
        String interestTagsCache = extractInterestTags(interestProfileCache);

        List<RecommendVO> cached = interestTagsCache.isEmpty()
                ? recommendMapper.selectRecommendSpots(userIdx)
                : recommendMapper.selectRecommendSpotsWithTagMatch(userIdx, interestTagsCache, currentSpotIdx);
        if (cached.size() >= RECOMMENDATION_LIMIT) {
            log.info("[Recommend] 캐시 적중: userIdx={}, {}건 (관심태그 정렬 적용)", userIdx, cached.size());
            splitTags(cached);
            spotTextTranslationService.translateRecommendSpots(cached);
            return cached.stream().limit(RECOMMENDATION_LIMIT).collect(Collectors.toList());
        }

        // 2. 조회 로그 수집 + 관심 태그 추출
        List<SpotViewLogVO> logs    = recommendMapper.selectRecentViewLogs(userIdx, VIEW_LOG_LIMIT);
        Map<Long, Integer>  stayMap  = aggregateStay(logs);
        Map<Long, Integer>  visitMap = buildVisitCountMap(logs);
        Map<Long, String>   nameMap  = buildNameMap(logs);
        Map<Long, String>   tagsMap  = buildTagsMap(logs);

        // ★ 관심 태그 추출 (체류시간 + 방문빈도 가중치 적용)
        Map<String, Integer> interestProfile = buildInterestProfile(stayMap, visitMap, tagsMap);
        String interestTags = extractInterestTags(interestProfile);
        log.info("[Recommend] 관심 태그: {}", interestTags);

        // 3. 태그 매칭 점수 포함 후보 조회
        List<String> currentSpotTags = getCurrentSpotTags(currentSpotIdx);
        List<CandidateSpotVO> candidates = recommendMapper.selectCandidateSpots(userIdx, interestTags, currentSpotIdx);
        candidates = rerankCandidates(candidates, currentSpotTags, interestProfile);

        // SPOT_TRAVEL 자체 없는 극단적 케이스
        if (candidates.isEmpty()) {
            log.warn("[Recommend] 후보 없음 → 트렌딩 폴백: userIdx={}", userIdx);
            return getTrendingSpots(currentSpotIdx);
        }

        long unvisited = candidates.stream().filter(c -> c.getVisitedFlag() == 0).count();
        long matched   = candidates.stream().filter(c -> c.getTagMatchScore() > 0).count();
        log.info("[Recommend] 후보: 미방문={}건, 태그매칭={}건, 합계={}건",
                unvisited, matched, candidates.size());

        // 4. Gemini 호출
        List<Long> previousIds = recommendMapper.selectPreviousRecommendSpotIds(userIdx);
        List<RecommendVO> aiResults = callGemini(
                userIdx, stayMap, nameMap, tagsMap, interestTags, currentSpotTags, candidates, previousIds);
        aiResults = mergeWithTopCandidates(aiResults, candidates, currentSpotTags, interestProfile, RECOMMENDATION_LIMIT);
        aiResults = ensureExactRecommendationCount(aiResults, candidates, currentSpotTags, interestProfile, currentSpotIdx);

        // 5. Gemini 결과 없으면 트렌딩 폴백
        if (aiResults.isEmpty()) {
            log.warn("[Recommend] Gemini 결과 없음 → 트렌딩 폴백: userIdx={}", userIdx);
            return getTrendingSpots(currentSpotIdx);
        }

        // 6. FK 검증 후 저장
        Set<Long> validIdx = candidates.stream()
                .map(CandidateSpotVO::getSpotIdx)
                .collect(Collectors.toSet());

        recommendMapper.deleteRecommends(userIdx);
        int saved = 0;
        for (RecommendVO rec : aiResults) {
            if (!validIdx.contains(rec.getSpotIdx())) {
                log.warn("[Recommend] 유효하지 않은 spot_idx 제외: {}", rec.getSpotIdx());
                continue;
            }
            try {
                rec.setUserIdx(userIdx);
                recommendMapper.insertRecommend(rec);
                saved++;
            } catch (Exception e) {
                log.warn("[Recommend] 저장 실패 spot_idx={}: {}", rec.getSpotIdx(), e.getMessage());
            }
        }
        log.info("[Recommend] 저장 완료: userIdx={}, {}건", userIdx, saved);

        if (saved == 0) {
            log.warn("[Recommend] 저장된 추천 없음 → 트렌딩 폴백");
            return getTrendingSpots(currentSpotIdx);
        }

        // 태그 일치 수 기준 재정렬하여 반환
        List<RecommendVO> result = interestTags.isEmpty()
                ? recommendMapper.selectRecommendSpots(userIdx)
                : recommendMapper.selectRecommendSpotsWithTagMatch(userIdx, interestTags, currentSpotIdx);
        result = ensureExactRecommendationCount(result, candidates, currentSpotTags, interestProfile, currentSpotIdx);
        splitTags(result);
        spotTextTranslationService.translateRecommendSpots(result);
        log.info("[Recommend] 최종 반환: {}건 (tagMatchCount 기준 정렬)", result.size());
        if (!result.isEmpty()) {
            result.forEach(r -> log.info("  → spot_idx={}, 이름={}, tagMatch={}, score={}",
                    r.getSpotIdx(), r.getSpotName(), r.getTagMatchCount(), r.getRecScore()));
        }
        return result.stream().limit(RECOMMENDATION_LIMIT).collect(Collectors.toList());
    }

    /* ============================================================
       "요즘 뜨는 여행지" 폴백
       ============================================================ */
    private List<RecommendVO> getTrendingSpots(Long currentSpotIdx) {
        try {
            List<RecommendVO> trending = recommendMapper.selectTrendingSpots(currentSpotIdx);
            splitTags(trending);
            spotTextTranslationService.translateRecommendSpots(trending);
            log.info("[Recommend] 트렌딩 폴백 반환: {}건", trending.size());
            return trending.stream().limit(RECOMMENDATION_LIMIT).collect(Collectors.toList());
        } catch (Exception e) {
            log.error("[Recommend] 트렌딩 조회 실패", e);
            return Collections.emptyList();
        }
    }

    /* ============================================================
       체류시간 가중치 적용 관심 태그 추출
       - spot별 총 체류시간을 가중치로 태그 빈도 계산
       - 상위 8개 태그 반환 (쉼표 구분)
       ============================================================ */
    private String extractInterestTags(Map<String, Integer> interestProfile) {
        if (interestProfile == null || interestProfile.isEmpty()) return "";
        return interestProfile.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .limit(8)
                .map(Map.Entry::getKey)
                .collect(Collectors.joining(","));
    }

    /* ============================================================
       stay_seconds 집계
       ============================================================ */
    private Map<Long, Integer> aggregateStay(List<SpotViewLogVO> logs) {
        Map<Long, Integer> m = new LinkedHashMap<>();
        for (SpotViewLogVO l : logs) m.merge(l.getSpotIdx(), l.getStaySeconds(), Integer::sum);
        return m;
    }

    private Map<Long, Integer> buildVisitCountMap(List<SpotViewLogVO> logs) {
        Map<Long, Integer> m = new LinkedHashMap<>();
        for (SpotViewLogVO l : logs) {
            m.merge(l.getSpotIdx(), Math.max(1, l.getVisitCount()), Math::max);
        }
        return m;
    }

    private Map<String, Integer> buildInterestProfile(Map<Long, Integer> stayMap,
                                                      Map<Long, Integer> visitMap,
                                                      Map<Long, String> tagsMap) {
        Map<String, Integer> profile = new LinkedHashMap<>();
        for (Map.Entry<Long, Integer> e : stayMap.entrySet()) {
            Long spotIdx = e.getKey();
            String tags = tagsMap.get(spotIdx);
            if (tags == null || tags.isBlank()) continue;

            int stayScore = Math.max(1, e.getValue());
            int visitScore = Math.max(1, visitMap.getOrDefault(spotIdx, 1)) * 180;
            int totalWeight = stayScore + visitScore;

            for (String tag : splitTagString(tags)) {
                profile.merge(tag, totalWeight, Integer::sum);
            }
        }
        return profile;
    }

    private Map<Long, String> buildNameMap(List<SpotViewLogVO> logs) {
        Map<Long, String> m = new LinkedHashMap<>();
        for (SpotViewLogVO l : logs) m.putIfAbsent(l.getSpotIdx(), l.getSpotName());
        return m;
    }

    private Map<Long, String> buildTagsMap(List<SpotViewLogVO> logs) {
        Map<Long, String> m = new LinkedHashMap<>();
        for (SpotViewLogVO l : logs)
            if (l.getTagsConcat() != null) m.putIfAbsent(l.getSpotIdx(), l.getTagsConcat());
        return m;
    }

    /* ============================================================
       Gemini API 호출
       ============================================================ */
    private List<RecommendVO> callGemini(Long userIdx,
                                          Map<Long, Integer>    stayMap,
                                          Map<Long, String>     nameMap,
                                          Map<Long, String>     tagsMap,
                                          String                interestTags,
                                          List<String>          currentSpotTags,
                                          List<CandidateSpotVO> candidates,
                                          List<Long>            previousIds) {
        try {
            String prompt = buildPrompt(stayMap, nameMap, tagsMap, interestTags, currentSpotTags, candidates, previousIds);
            String url    = String.format(GEMINI_URL, geminiApiKey);

            JsonObject part = new JsonObject();
            part.addProperty("text", prompt);
            JsonArray parts = new JsonArray();
            parts.add(part);
            JsonObject content = new JsonObject();
            content.add("parts", parts);
            JsonArray contents = new JsonArray();
            contents.add(content);

            JsonObject genConfig = new JsonObject();
            genConfig.addProperty("temperature",     1.0);
            genConfig.addProperty("topP",            0.95);
            genConfig.addProperty("maxOutputTokens", 2048);

            JsonObject payload = new JsonObject();
            payload.add("contents",        contents);
            payload.add("generationConfig", genConfig);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            log.info("[Recommend] Gemini 호출: userIdx={}, 후보={}건, 관심태그=[{}]",
                    userIdx, candidates.size(), interestTags);

            ResponseEntity<String> response = restTemplate.exchange(
                    url, HttpMethod.POST,
                    new HttpEntity<>(payload.toString(), headers),
                    String.class
            );
            return parseGeminiResponse(userIdx, response.getBody());

        } catch (Exception e) {
            log.error("[Recommend] Gemini 호출 실패: {}", e.getMessage(), e);
            return Collections.emptyList();
        }
    }

    /* ============================================================
       프롬프트 생성
       - 관심 태그 명시 (태그 매칭 기반 선택 유도)
       - 이전 추천 spot 반복 금지 명시
       - 다양성 조건 5가지
       ============================================================ */
    private String buildPrompt(Map<Long, Integer>    stayMap,
                                Map<Long, String>     nameMap,
                                Map<Long, String>     tagsMap,
                                String                interestTags,
                                List<String>          currentSpotTags,
                                List<CandidateSpotVO> candidates,
                                List<Long>            previousIds) {

        String now          = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        String prefSection  = buildPreferenceSection(stayMap, nameMap, tagsMap);
        String candSection  = buildCandidateSection(candidates);
        String recentVisited = nameMap.values().stream().limit(10)
                .map(this::sanitize).collect(Collectors.joining(", "));
        String prevSpotIds  = previousIds.isEmpty() ? "(없음)"
                : previousIds.stream().map(String::valueOf).collect(Collectors.joining(", "));

        return "당신은 개인화 여행지 추천 AI입니다.\n" +
               "현재 시각: " + now + "\n\n" +

               "## 사용자 관심 태그 (체류시간 + 방문빈도 가중치 추출)\n" +
               (interestTags.isEmpty() ? "(이력 없음)" : interestTags) + "\n\n" +

               "## 현재 보고 있는 여행지 태그 (가장 우선적으로 비슷해야 함)\n" +
               (currentSpotTags.isEmpty() ? "(없음)" : String.join(", ", currentSpotTags)) + "\n\n" +

               "## 사용자 체류 이력 (체류시간 + 방문빈도 기준 관심도)\n" +
               prefSection + "\n" +

               "## 추천 후보 목록 (spot_idx, tag_match_score 포함 - 이 중에서만 선택)\n" +
               "현재 보고 있는 여행지 태그와 직접 겹치는 후보를 가장 우선으로 보고, 그 다음으로 전체 관심 태그를 반영하라.\n" +
               candSection + "\n" +

               "## 절대 포함 금지\n" +
               "최근 방문: " + (recentVisited.isEmpty() ? "(없음)" : recentVisited) + "\n" +
               "이전 추천 spot_idx: " + prevSpotIds + "\n\n" +

               "## [요청] 지금 시점에서 새롭게 흥미를 느낄 가능성이 높은 여행지 3개 추천\n\n" +
               "중요 조건:\n" +
               "1. 현재 보고 있는 여행지 태그와 겹치는 후보를 가장 먼저 검토할 것\n" +
               "2. 그 다음으로 사용자 관심 태그와 tag_match_score가 높은 후보 우선 선택\n" +
               "3. 이전 추천 spot_idx에 있는 여행지는 절대 포함하지 말 것\n" +
               "4. 최근 방문 장소는 절대 포함하지 말 것\n" +
               "5. 각 추천은 서로 다른 지역/분위기를 갖도록 노력할 것\n\n" +
               "## 출력 형식 (JSON 배열만, 다른 텍스트 없이)\n" +
               "[{\"spot_idx\":숫자,\"reason\":\"10자이내\",\"score\":숫자}]\n" +
               "reason: 쌍따옴표·줄바꿈·특수문자 없이 10자 이내 한국어.";
    }

    /** 체류시간 기준 선호도 섹션 */
    private String buildPreferenceSection(Map<Long, Integer> stayMap,
                                           Map<Long, String>  nameMap,
                                           Map<Long, String>  tagsMap) {
        if (stayMap.isEmpty()) return "(조회 이력 없음)\n";
        int maxStay = stayMap.values().stream().max(Integer::compare).orElse(1);
        StringBuilder sb = new StringBuilder();
        int rank = 1;
        for (Map.Entry<Long, Integer> e :
                stayMap.entrySet().stream()
                        .sorted(Map.Entry.<Long, Integer>comparingByValue().reversed())
                        .limit(10).collect(Collectors.toList())) {
            int interest = Math.max(1, (int) Math.round(e.getValue() * 10.0 / maxStay));
            sb.append(String.format("  %d위. %s (체류:%d초, 관심도:%d/10, 태그:%s)\n",
                    rank++,
                    sanitize(nameMap.getOrDefault(e.getKey(), "?")),
                    e.getValue(), interest,
                    sanitize(tagsMap.getOrDefault(e.getKey(), "-"))));
        }
        return sb.toString();
    }

    /** 후보 여행지 섹션 (태그 매칭 점수 포함) */
    private String buildCandidateSection(List<CandidateSpotVO> candidates) {
        StringBuilder sb = new StringBuilder();
        for (CandidateSpotVO c : candidates) {
            sb.append(String.format("spot_idx=%d, 이름=%s, 지역=%s, 태그=%s, tag_match_score=%d\n",
                    c.getSpotIdx(),
                    sanitize(c.getName()),
                    sanitize(c.getRegion()),
                    sanitize(c.getTagsConcat()),
                    c.getTagMatchScore()));
        }
        return sb.toString();
    }

    private List<String> getCurrentSpotTags(Long currentSpotIdx) {
        if (currentSpotIdx == null) return Collections.emptyList();
        try {
            List<String> tags = exploreMapper.selectSpotTags(currentSpotIdx);
            return tags == null ? Collections.emptyList() : tags.stream()
                    .filter(Objects::nonNull)
                    .map(String::trim)
                    .filter(s -> !s.isEmpty())
                    .distinct()
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.warn("[Recommend] 현재 spot 태그 조회 실패: {}", e.getMessage());
            return Collections.emptyList();
        }
    }

    private List<CandidateSpotVO> rerankCandidates(List<CandidateSpotVO> candidates,
                                                   List<String> currentSpotTags,
                                                   Map<String, Integer> interestProfile) {
        if (candidates == null || candidates.isEmpty()) return Collections.emptyList();

        Comparator<CandidateSpotVO> comparator = Comparator
                .comparingLong((CandidateSpotVO c) -> computeCandidatePriority(c, currentSpotTags, interestProfile)).reversed()
                .thenComparingInt(CandidateSpotVO::getVisitedFlag)
                .thenComparing(CandidateSpotVO::getName, Comparator.nullsLast(String::compareTo));

        return candidates.stream()
                .sorted(comparator)
                .limit(30)
                .collect(Collectors.toList());
    }

    private List<RecommendVO> mergeWithTopCandidates(List<RecommendVO> aiResults,
                                                     List<CandidateSpotVO> rankedCandidates,
                                                     List<String> currentSpotTags,
                                                     Map<String, Integer> interestProfile,
                                                     int limit) {
        Map<Long, CandidateSpotVO> candidateMap = rankedCandidates.stream()
                .collect(Collectors.toMap(CandidateSpotVO::getSpotIdx, c -> c, (a, b) -> a, LinkedHashMap::new));

        LinkedHashMap<Long, RecommendVO> merged = new LinkedHashMap<>();

        if (aiResults != null) {
            aiResults.stream()
                    .filter(Objects::nonNull)
                    .filter(r -> candidateMap.containsKey(r.getSpotIdx()))
                    .sorted(Comparator
                            .comparingLong((RecommendVO r) -> computeCandidatePriority(candidateMap.get(r.getSpotIdx()), currentSpotTags, interestProfile)).reversed()
                            .thenComparingInt(RecommendVO::getRecScore).reversed())
                    .forEach(r -> merged.putIfAbsent(r.getSpotIdx(), r));
        }

        for (CandidateSpotVO candidate : rankedCandidates) {
            if (merged.size() >= limit) break;
            merged.computeIfAbsent(candidate.getSpotIdx(), spotIdx -> {
                RecommendVO rec = new RecommendVO();
                rec.setSpotIdx(candidate.getSpotIdx());
                rec.setRecReason(candidate.getTagMatchScore() > 0 ? "태그유사" : "취향반영");
                rec.setRecScore(normalizePriority(computeCandidatePriority(candidate, currentSpotTags, interestProfile)));
                return rec;
            });
        }
        return merged.values().stream().limit(limit).collect(Collectors.toList());
    }

    private List<RecommendVO> ensureExactRecommendationCount(List<RecommendVO> baseResults,
                                                             List<CandidateSpotVO> rankedCandidates,
                                                             List<String> currentSpotTags,
                                                             Map<String, Integer> interestProfile,
                                                             Long currentSpotIdx) {
        LinkedHashMap<Long, RecommendVO> merged = new LinkedHashMap<>();

        if (baseResults != null) {
            for (RecommendVO rec : baseResults) {
                if (rec == null || rec.getSpotIdx() == null) continue;
                if (currentSpotIdx != null && currentSpotIdx.equals(rec.getSpotIdx())) continue;
                merged.putIfAbsent(rec.getSpotIdx(), rec);
            }
        }

        if (rankedCandidates != null) {
            for (CandidateSpotVO candidate : rankedCandidates) {
                if (merged.size() >= RECOMMENDATION_LIMIT) break;
                if (candidate == null || candidate.getSpotIdx() == null) continue;
                if (currentSpotIdx != null && currentSpotIdx.equals(candidate.getSpotIdx())) continue;

                merged.computeIfAbsent(candidate.getSpotIdx(), spotIdx -> {
                    RecommendVO rec = new RecommendVO();
                    rec.setSpotIdx(candidate.getSpotIdx());
                    rec.setSpotName(candidate.getName());
                    rec.setRegion(candidate.getRegion());
                    rec.setRecReason(candidate.getTagMatchScore() > 0 ? "태그 유사" : "취향 반영");
                    rec.setRecScore(normalizePriority(
                            computeCandidatePriority(candidate, currentSpotTags, interestProfile)));
                    return rec;
                });
            }
        }

        if (merged.size() < RECOMMENDATION_LIMIT) {
            List<RecommendVO> trending = getTrendingSpots(currentSpotIdx);
            for (RecommendVO rec : trending) {
                if (merged.size() >= RECOMMENDATION_LIMIT) break;
                if (rec == null || rec.getSpotIdx() == null) continue;
                merged.putIfAbsent(rec.getSpotIdx(), rec);
            }
        }

        return merged.values().stream().limit(RECOMMENDATION_LIMIT).collect(Collectors.toList());
    }

    private int normalizePriority(long priority) {
        if (priority <= 0) return 1;
        if (priority >= 1_000_000) return 10;
        return (int) Math.max(1, Math.min(10, (priority / 100_000) + 1));
    }

    private long computeCandidatePriority(CandidateSpotVO candidate,
                                          List<String> currentSpotTags,
                                          Map<String, Integer> interestProfile) {
        if (candidate == null) return Long.MIN_VALUE;

        Set<String> candidateTags = splitTagString(candidate.getTagsConcat());
        Set<String> currentTags = currentSpotTags == null ? Collections.emptySet() : new LinkedHashSet<>(currentSpotTags);

        long currentOverlap = candidateTags.stream().filter(currentTags::contains).count();
        long profileWeight = candidateTags.stream()
                .mapToLong(tag -> interestProfile.getOrDefault(tag, 0))
                .sum();

        return currentOverlap * 1_000_000L
                + (long) candidate.getTagMatchScore() * 100_000L
                + profileWeight
                - (long) candidate.getVisitedFlag() * 10_000L;
    }

    private Set<String> splitTagString(String tags) {
        if (tags == null || tags.isBlank()) return Collections.emptySet();
        return Arrays.stream(tags.split(","))
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .collect(Collectors.toCollection(LinkedHashSet::new));
    }

    private String sanitize(String s) {
        if (s == null || s.isBlank()) return "-";
        return s.replace("|", " ").replace("\n", " ").replace("\r", "")
                .replace("\"", "'").trim();
    }

    /* ============================================================
       Gemini 응답 파싱 (잘린 JSON 복구 포함)
       ============================================================ */
    private List<RecommendVO> parseGeminiResponse(Long userIdx, String body) {
        List<RecommendVO> result = new ArrayList<>();
        try {
            JsonObject root = JsonParser.parseString(body).getAsJsonObject();
            String text = root.getAsJsonArray("candidates").get(0).getAsJsonObject()
                    .getAsJsonObject("content").getAsJsonArray("parts").get(0).getAsJsonObject()
                    .get("text").getAsString().trim();

            log.info("[Recommend] Gemini 원문: {}", text);

            text = text.replaceAll("(?s)```json\\s*", "")
                       .replaceAll("(?s)```\\s*", "").trim();
            text = text.replaceAll("(?<!\\\\)\n", " ")
                       .replaceAll("(?<!\\\\)\r", "")
                       .replaceAll("(?<!\\\\)\t", " ");

            int arrStart = text.indexOf('[');
            if (arrStart < 0) {
                log.warn("[Recommend] JSON 배열 없음: {}", text);
                return result;
            }
            text = text.substring(arrStart);

            result = extractCompletedObjects(userIdx, text);
            log.info("[Recommend] 파싱 완료: {}건", result.size());

        } catch (Exception e) {
            log.error("[Recommend] 파싱 에러: {}", e.getMessage());
        }
        return result;
    }

    /** 잘린 JSON에서 완성된 객체만 추출 */
    private List<RecommendVO> extractCompletedObjects(Long userIdx, String text) {
        List<RecommendVO> result = new ArrayList<>();
        int i = 0, len = text.length();
        while (i < len) {
            int objStart = text.indexOf('{', i);
            if (objStart < 0) break;
            int depth = 0, objEnd = -1;
            boolean inStr = false, escape = false;
            for (int j = objStart; j < len; j++) {
                char c = text.charAt(j);
                if (escape)       { escape = false; continue; }
                if (c == '\\')    { escape = true;  continue; }
                if (c == '"')     { inStr = !inStr; continue; }
                if (inStr)        continue;
                if (c == '{')     depth++;
                else if (c == '}') { if (--depth == 0) { objEnd = j; break; } }
            }
            if (objEnd < 0) { log.info("[Recommend] 잘린 객체 감지, 중단"); break; }
            try {
                JsonObject obj = JsonParser.parseString(text.substring(objStart, objEnd + 1)).getAsJsonObject();
                if (obj.has("spot_idx")) {
                    RecommendVO rec = new RecommendVO();
                    rec.setUserIdx(userIdx);
                    rec.setSpotIdx(obj.get("spot_idx").getAsLong());
                    rec.setRecReason(obj.has("reason") ? obj.get("reason").getAsString() : "");
                    rec.setRecScore(obj.has("score")   ? obj.get("score").getAsInt()    : 5);
                    result.add(rec);
                }
            } catch (Exception e) {
                log.warn("[Recommend] 항목 파싱 실패: {}", e.getMessage());
            }
            i = objEnd + 1;
        }
        return result;
    }

    /* ============================================================
       태그 목록 채우기
       ============================================================ */
    private void splitTags(List<RecommendVO> list) {
        if (list == null) return;
        for (RecommendVO rec : list) {
            try {
                List<String> tags = exploreMapper.selectSpotTags(rec.getSpotIdx());
                rec.setTags(tags != null ? tags : Collections.emptyList());
            } catch (Exception e) {
                rec.setTags(Collections.emptyList());
            }
        }
    }
}
