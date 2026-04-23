package org.triptogether.common.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.triptogether.explore.mapper.ExploreMapper;

import java.util.*;

/**
 * 챗봇 시스템 프롬프트에 실시간 사이트 콘텐츠를 주입하기 위한 컨텍스트 빌더.
 *
 * 흐름:
 *   1. 사용자 메시지에서 키워드 추출 (토큰화 + 불용어 제거)
 *   2. 모듈별 Mapper 로 후보 조회 (현재: Explore)
 *   3. Gemini 프롬프트에 append 할 문자열 섹션 생성
 *
 * 후보가 0개이거나 키워드가 0개면 빈 문자열 반환 → 기존 동작과 동일.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class IntentContextService {

    private static final int MAX_KEYWORDS = 5;        // 너무 많은 토큰은 LIKE 비용 커짐
    private static final int MIN_KEYWORD_LEN = 2;
    private static final int SPOT_CANDIDATE_LIMIT = 5;

    // 여행 질문에 흔히 섞이는 불용어. 키워드로서 의미 없는 것만 제외.
    // 대소문자 무시 비교를 위해 소문자로 저장.
    private static final Set<String> STOPWORDS = Set.of(
            // 일반 동사/조사류
            "가고", "가자", "갈래", "갈까", "간다", "가는", "갔다",
            "싶다", "싶어", "싶은데", "싶어요", "싶네",
            "해줘", "해줄래", "해주세요", "알려줘", "알려주세요",
            "있다", "있어", "있는", "있나", "없다", "없어", "없는",
            "하고", "하는", "하면", "한다", "하다", "함",
            "되는", "되나", "된다", "되서",
            // 질문어
            "어떻게", "어떡해", "어떡하지", "어디", "어느", "어떤", "어쩌지",
            "뭐", "뭔가", "무엇", "무슨",
            "왜", "언제", "누가",
            // 추천/선호 류
            "추천", "좋은", "좋아", "좋다", "좋을까", "최고", "최악",
            "인기", "유명", "핫한", "요즘", "요새",
            // 수량/대명사
            "나는", "내가", "저는", "제가", "우리",
            "그", "저", "이", "그런", "저런", "이런",
            "많은", "적은", "조금", "약간", "많이",
            // 시간
            "지금", "오늘", "내일", "이번", "다음", "얼른", "당장",
            // 연결어
            "그리고", "하지만", "또는", "혹은", "그런데", "근데",
            // 여행 공통 단어 (자체로 구별력 낮음)
            "여행", "여행지", "관광", "관광지", "일정", "계획",
            "정말", "엄청", "매우", "진짜", "아주", "완전",
            "근처", "주변", "어디든",
            // 단일 종결
            "요", "네", "음", "좀", "그냥"
    );

    private final ExploreMapper exploreMapper;

    /**
     * 메시지에서 키워드 추출 후 매칭되는 사이트 콘텐츠를 조회해 프롬프트 섹션 문자열을 만든다.
     * 매칭 없음 → 빈 문자열.
     */
    public String buildContextSection(String userMessage) {
        List<String> keywords = extractKeywords(userMessage);
        if (keywords.isEmpty()) return "";

        List<Map<String, Object>> spots;
        try {
            spots = exploreMapper.searchSpotsByKeywords(keywords, SPOT_CANDIDATE_LIMIT);
        } catch (Exception e) {
            log.warn("[Chatbot] 여행지 후보 조회 실패 — keywords={}, 원인={}", keywords, e.getMessage());
            return "";
        }

        if (spots == null || spots.isEmpty()) return "";

        StringBuilder sb = new StringBuilder();
        sb.append("## 실시간 후보 데이터\n");
        sb.append("사용자 언급 키워드: ").append(keywords).append("\n\n");

        sb.append("### 여행지 후보 (링크 형식: /detail/{spotIdx})\n");
        for (Map<String, Object> row : spots) {
            Object idx = row.get("spotIdx");
            Object name = row.get("name");
            Object region = row.get("region");
            Object rating = row.get("ratingAvg");
            Object reviewCount = row.get("reviewCount");
            Object desc = row.get("description");

            sb.append("- spotIdx=").append(idx)
              .append(", \"").append(name).append("\"")
              .append(region != null ? " (" + region + ")" : "")
              .append(rating != null ? " — ★" + rating : "")
              .append(reviewCount != null ? " · 리뷰 " + reviewCount : "")
              .append(desc != null ? " — " + truncate(String.valueOf(desc), 80) : "")
              .append("\n");
        }

        sb.append("\n중요 지침:\n");
        sb.append("- links 의 url 은 반드시 위 후보의 실제 spotIdx 를 사용하세요. 예: /detail/2\n");
        sb.append("- 존재하지 않는 id 는 절대 만들지 마세요.\n");
        sb.append("- 후보가 비어있으면 일반 list 페이지(/explore)만 제시하세요.\n");
        return sb.toString();
    }

    // ── 내부 유틸 ──

    /** 메시지 토큰화 + 불용어 제거 + 길이 필터 */
    private List<String> extractKeywords(String message) {
        if (message == null || message.isBlank()) return List.of();

        String[] raw = message.split("\\s+");
        List<String> result = new ArrayList<>();
        Set<String> seen = new HashSet<>();

        for (String token : raw) {
            // 특수문자 제거 (한글/영문/숫자만 남김)
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
}
