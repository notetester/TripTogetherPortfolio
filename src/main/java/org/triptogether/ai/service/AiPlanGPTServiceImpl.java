package org.triptogether.ai.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.triptogether.ai.dto.AiPlanRequestDTO;
import org.triptogether.ai.dto.AiPlanResponseDTO;

import java.util.*;

@Service
public class AiPlanGPTServiceImpl implements AiPlanGPTService {
    private static final String TEST_API_KEY = "YOUR_OPENAI_API_KEY";

    @Value("${openai.api.key}")
    private String apiKey;

    @Value("${openai.model}")
    private String model;

    private static final String OPENAI_URL = "https://api.openai.com/v1/chat/completions";

    private final ObjectMapper objectMapper = new ObjectMapper();
    private final RestTemplate restTemplate = new RestTemplate();

    @Override
    public AiPlanResponseDTO generatePlan(AiPlanRequestDTO requestDTO) {

        System.out.println("apiKey exists = " + (apiKey != null && !apiKey.isBlank()));
        System.out.println("model = " + model);

        if (apiKey != null && !apiKey.isBlank()) {
            System.out.println("apiKey prefix = " + apiKey.substring(0, Math.min(12, apiKey.length())));
        }

        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            // headers.setBearerAuth(apiKey);
            headers.setBearerAuth(TEST_API_KEY.trim());

            Map<String, Object> body = new HashMap<>();
            body.put("model", model);
            body.put("messages", List.of(
                    Map.of(
                            "role", "developer",
                            "content", buildDeveloperPrompt()
                    ),
                    Map.of(
                            "role", "user",
                            "content", buildUserPrompt(requestDTO)
                    )
            ));

            // Structured Outputs
            body.put("response_format", buildJsonSchemaResponseFormat());

            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

            ResponseEntity<String> response = restTemplate.exchange(
                    OPENAI_URL,
                    HttpMethod.POST,
                    entity,
                    String.class
            );

            String responseBody = response.getBody();
            JsonNode root = objectMapper.readTree(responseBody);

            String content = root.path("choices")
                    .get(0)
                    .path("message")
                    .path("content")
                    .asText();

            return objectMapper.readValue(content, AiPlanResponseDTO.class);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("OpenAI 일정 생성 실패: " + e.getMessage(), e);
        }
    }

    private String buildDeveloperPrompt() {
        return """
                너는 여행 일정 플래너다.
                반드시 사용자의 조건에 맞는 현실적인 여행 일정을 생성한다.
                반드시 응답은 지정된 JSON 스키마만 따른다.
                JSON 외의 설명, 인사말, 코드블록, 마크다운은 절대 출력하지 않는다.
                days 배열에는 날짜 순서대로 일정을 넣고,
                각 day의 spots는 방문 순서대로 정렬한다.
                place 이름은 자연스럽고 구체적으로 작성한다.
                """;
    }

    private String buildUserPrompt(AiPlanRequestDTO requestDTO) {
        return """
                아래 조건으로 여행 일정을 생성해.

                [여행 조건]
                여행지: %s
                시작일: %s
                종료일: %s
                동행: %s
                여행스타일: %s
                예산: %s
                추가요청: %s

                요구사항:
                1. 일정 제목(title) 작성
                2. 전체 요약(summary) 작성
                3. days 배열에는 날짜별 일정 작성
                4. 각 날짜마다 theme 작성
                5. 각 날짜마다 최소 3개의 spots 작성
                6. 각 spot은 name, description, visitOrder 포함
                """.formatted(
                nullSafe(requestDTO.getDestination()),
                nullSafe(requestDTO.getStartDate()),
                nullSafe(requestDTO.getEndDate()),
                nullSafe(requestDTO.getCompanion()),
                nullSafe(requestDTO.getStyle()),
                nullSafe(requestDTO.getBudget()),
                nullSafe(requestDTO.getRequestText())
        );
    }

    private Map<String, Object> buildJsonSchemaResponseFormat() {
        Map<String, Object> schema = new LinkedHashMap<>();

        schema.put("type", "object");
        schema.put("additionalProperties", false);
        schema.put("properties", Map.of(
                "title", Map.of(
                        "type", "string"
                ),
                "summary", Map.of(
                        "type", "string"
                ),
                "days", Map.of(
                        "type", "array",
                        "items", Map.of(
                                "type", "object",
                                "additionalProperties", false,
                                "properties", Map.of(
                                        "dayNo", Map.of("type", "integer"),
                                        "date", Map.of("type", "string"),
                                        "theme", Map.of("type", "string"),
                                        "spots", Map.of(
                                                "type", "array",
                                                "items", Map.of(
                                                        "type", "object",
                                                        "additionalProperties", false,
                                                        "properties", Map.of(
                                                                "name", Map.of("type", "string"),
                                                                "description", Map.of("type", "string"),
                                                                "visitOrder", Map.of("type", "integer")
                                                        ),
                                                        "required", List.of("name", "description", "visitOrder")
                                                )
                                        )
                                ),
                                "required", List.of("dayNo", "date", "theme", "spots")
                        )
                )
        ));
        schema.put("required", List.of("title", "summary", "days"));

        return Map.of(
                "type", "json_schema",
                "json_schema", Map.of(
                        "name", "travel_plan_response",
                        "strict", true,
                        "schema", schema
                )
        );
    }

    private String nullSafe(String value) {
        return value == null ? "" : value.trim();
    }
}