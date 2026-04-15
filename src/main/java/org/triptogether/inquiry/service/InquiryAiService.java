package org.triptogether.inquiry.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;

/**
 * 문의 게시판 전용 Claude Haiku AI 답변 초안 생성 서비스.
 *
 * <p>관리자가 문의 답변 작성 시 AI 초안을 자동 생성하여 작성 부담을 낮춘다.
 * 단일 메시지(싱글턴) 호출 방식이며, 대화 히스토리는 유지하지 않는다.</p>
 *
 * <ul>
 *   <li>사용 키: {@code inquiry.claude.api.key} — Victor 개인 계정 키,
 *       다른 모듈의 {@code claude.api.key}와 완전히 독립</li>
 *   <li>모델: {@link #MODEL} (Claude Haiku — 속도·비용 최적화)</li>
 *   <li>실패 시 빈 문자열 반환 — 관리자 답변 작성을 막지 않도록 fail-safe 처리</li>
 * </ul>
 *
 * <p><b>팀원 AI 서비스와의 구분:</b><br>
 * - {@code AssistantServiceImpl} — 여행 플래닝 멀티턴 챗봇 (다른 팀원 담당)<br>
 * - {@code ChatbotService}       — 사이트 네비게이션 챗봇 (다른 팀원 담당)<br>
 * - 이 서비스만 Victor 담당 (inquiry 모듈)</p>
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class InquiryAiService {

    @Value("${inquiry.claude.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate;

    /** Anthropic Messages API 엔드포인트. */
    private static final String API_URL    = "https://api.anthropic.com/v1/messages";

    /** Anthropic API 버전 헤더 값. */
    private static final String API_VER    = "2023-06-01";

    /** 사용할 Claude 모델 ID. Haiku 계열로 속도·비용 최적화. */
    private static final String MODEL      = "claude-haiku-4-5-20251001";

    /** AI 응답의 최대 토큰 수. 답변 초안 한 건에 충분한 분량. */
    private static final int    MAX_TOKENS = 1024;

    /**
     * AI에게 부여하는 역할 지침.
     * TripTogether CS 담당자로서 친절한 한국어 답변 초안만 출력하도록 제약한다.
     */
    private static final String SYSTEM_PROMPT =
            "당신은 TripTogether 여행 커뮤니티 플랫폼의 고객 서비스 담당자입니다.\n" +
            "사용자의 문의에 대해 친절하고 정중한 한국어로 답변 초안을 작성해주세요.\n" +
            "규칙:\n" +
            "- 인사말로 시작하세요.\n" +
            "- 문의 유형과 내용에 맞는 구체적인 안내를 제공하세요.\n" +
            "- 마무리 인사로 끝내세요.\n" +
            "- 초안 텍스트만 출력하고 다른 설명은 붙이지 마세요.";

    /** 문의 카테고리 코드 → 한국어 레이블 매핑. AI 프롬프트에 포함된다. */
    private static final Map<String, String> CATEGORY_LABEL = Map.of(
            "service", "서비스 이용",
            "payment", "결제/환불",
            "account", "계정/로그인",
            "bug",     "오류 신고",
            "etc",     "기타"
    );

    /**
     * 문의 내용을 바탕으로 Claude AI 답변 초안을 생성한다.
     *
     * <p>카테고리·제목·본문을 조합해 단일 메시지 프롬프트를 구성하고 API를 호출한다.
     * 호출 실패 또는 응답 파싱 오류 시 빈 문자열을 반환한다 (fail-safe).</p>
     *
     * @param category 문의 카테고리 코드 (예: "service", "payment"). null이면 빈 문자열 처리
     * @param title    문의 제목. null이면 빈 문자열 처리
     * @param content  문의 본문. null이면 빈 문자열 처리
     * @return 생성된 답변 초안 텍스트. 실패 시 {@code ""}
     */
    @SuppressWarnings("unchecked")
    public String generateDraft(String category, String title, String content) {
        try {
            String categoryLabel = CATEGORY_LABEL.getOrDefault(
                    category != null ? category : "", category != null ? category : "");
            String userMessage = "문의 유형: " + categoryLabel + "\n"
                               + "제목: " + (title   != null ? title   : "") + "\n"
                               + "내용: " + (content != null ? content : "");

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("x-api-key",        apiKey);
            headers.set("anthropic-version", API_VER);

            Map<String, Object> body = Map.of(
                    "model",      MODEL,
                    "max_tokens", MAX_TOKENS,
                    "system",     SYSTEM_PROMPT,
                    "messages",   List.of(Map.of("role", "user", "content", userMessage))
            );

            HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);
            Map<?, ?> response = restTemplate.postForObject(API_URL, request, Map.class);

            if (response == null) return "";
            List<?> contentList = (List<?>) response.get("content");
            if (contentList == null || contentList.isEmpty()) return "";
            Map<?, ?> first = (Map<?, ?>) contentList.get(0);
            return (String) first.get("text");

        } catch (Exception e) {
            log.warn("AI 답변 초안 생성 실패: {}", e.getMessage());
            return "";
        }
    }

}
