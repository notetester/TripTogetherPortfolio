package org.triptogether.assistant.service;

import com.google.gson.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class AssistantServiceImpl implements AssistantService {

    private final RestTemplate restTemplate;

    @Value("${claude.api.key}")
    private String claudeApiKey;

    // Claude API 설정
    private static final String CLAUDE_API_URL = "https://api.anthropic.com/v1/messages";
    private static final String CLAUDE_MODEL    = "claude-3-5-haiku-20241022";
    private static final int    MAX_TOKENS      = 1024;
    private static final int    MAX_HISTORY     = 20; // 최대 대화 기록 수 (메모리 관리)

    // 시스템 프롬프트: AI 여행 어시스턴트 역할 정의
    private static final String SYSTEM_PROMPT = """
            당신은 TripTogether의 AI 여행 어시스턴트입니다.
            여행 계획, 여행지 추천, 여행 팁, 현지 문화, 음식, 교통, 숙박 등 모든 여행 관련 질문에 친절하고 전문적으로 답변해주세요.
            
            답변 규칙:
            1. 항상 한국어로 답변하세요 (사용자가 다른 언어로 질문해도 한국어로 답변).
            2. 여행 관련 질문에만 답변하고, 관련 없는 주제는 정중히 거절하세요.
            3. 구체적이고 실용적인 정보를 제공하세요 (예: 추천 음식점, 이동 방법, 예산 등).
            4. 답변은 읽기 쉽게 구조화하세요. 긴 답변은 섹션으로 나누고 이모지를 적절히 사용하세요.
            5. 여행지 추천 시 계절, 예산, 여행 스타일을 고려하세요.
            6. 안전 정보나 주의사항이 있으면 반드시 포함하세요.
            """;

    @Override
    public Map<String, Object> chat(String userMessage, List<Map<String, String>> history) {
        Map<String, Object> result = new HashMap<>();

        try {
            // 대화 기록 초기화 또는 유지
            List<Map<String, String>> messages = history != null
                    ? new ArrayList<>(history) : new ArrayList<>();

            // 사용자 메시지 추가
            Map<String, String> userMsg = new HashMap<>();
            userMsg.put("role", "user");
            userMsg.put("content", userMessage);
            messages.add(userMsg);

            // Claude API 요청 본문 구성
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("model", CLAUDE_MODEL);
            requestBody.put("max_tokens", MAX_TOKENS);
            requestBody.put("system", SYSTEM_PROMPT);
            requestBody.put("messages", messages);

            // HTTP 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("x-api-key", claudeApiKey);
            headers.set("anthropic-version", "2023-06-01");

            // Gson으로 직렬화
            String requestJson = new Gson().toJson(requestBody);
            HttpEntity<String> entity = new HttpEntity<>(requestJson, headers);

            // API 호출
            ResponseEntity<String> response = restTemplate.exchange(
                    CLAUDE_API_URL, HttpMethod.POST, entity, String.class);

            // 응답 파싱
            JsonObject responseJson = JsonParser.parseString(response.getBody()).getAsJsonObject();
            JsonArray content = responseJson.getAsJsonArray("content");
            String assistantAnswer = content.get(0).getAsJsonObject()
                    .get("text").getAsString();

            // 어시스턴트 응답을 대화 기록에 추가
            Map<String, String> assistantMsg = new HashMap<>();
            assistantMsg.put("role", "assistant");
            assistantMsg.put("content", assistantAnswer);
            messages.add(assistantMsg);

            // 대화 기록이 너무 길어지면 오래된 것 제거 (시스템 메모리 관리)
            while (messages.size() > MAX_HISTORY) {
                messages.remove(0);
            }

            result.put("success", true);
            result.put("answer", assistantAnswer);
            result.put("history", messages);

        } catch (Exception e) {
            log.error("[AssistantService] Claude API 호출 실패: {}", e.getMessage(), e);
            result.put("success", false);
            result.put("answer", "죄송합니다. 일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
            result.put("history", history != null ? history : new ArrayList<>());
        }

        return result;
    }
}
