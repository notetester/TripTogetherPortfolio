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

// 문의게시판 전용 Claude AI 답변 초안 생성 서비스
// inquiry.claude.api.key (Victor 개인 계정) 만 사용함
// 다른 팀원의 claude.api.key 와 완전히 독립됨
@Slf4j
@Service
@RequiredArgsConstructor
public class InquiryAiService {

    @Value("${inquiry.claude.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate;

    private static final String API_URL    = "https://api.anthropic.com/v1/messages";
    private static final String API_VER    = "2023-06-01";
    private static final String MODEL      = "claude-haiku-4-5-20251001";
    private static final int    MAX_TOKENS = 1024;

    private static final String SYSTEM_PROMPT =
            "당신은 TripTogether 여행 커뮤니티 플랫폼의 고객 서비스 담당자입니다.\n" +
            "사용자의 문의에 대해 친절하고 정중한 한국어로 답변 초안을 작성해주세요.\n" +
            "규칙:\n" +
            "- 인사말로 시작하세요.\n" +
            "- 문의 유형과 내용에 맞는 구체적인 안내를 제공하세요.\n" +
            "- 마무리 인사로 끝내세요.\n" +
            "- 초안 텍스트만 출력하고 다른 설명은 붙이지 마세요.";

    private static final Map<String, String> CATEGORY_LABEL = Map.of(
            "service", "서비스 이용",
            "payment", "결제/환불",
            "account", "계정/로그인",
            "bug",     "오류 신고",
            "etc",     "기타"
    );

    // 문의 내용을 바탕으로 답변 초안 생성함. 실패 시 빈 문자열 반환
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
