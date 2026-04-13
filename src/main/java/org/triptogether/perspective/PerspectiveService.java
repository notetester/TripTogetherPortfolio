package org.triptogether.perspective;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class PerspectiveService {

    @Value("${perspective.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate;

    private static final double TOXICITY_THRESHOLD = 0.8;
    private static final String API_URL =
            "https://commentanalyzer.googleapis.com/v1alpha1/comments:analyze?key=";

    /**
     * 텍스트의 독성 여부를 판단한다.
     * API 호출 실패 시 false 반환 (필터링 안 함).
     */
    @SuppressWarnings("unchecked")
    public boolean isToxic(String text) {
        if (text == null || text.trim().isEmpty()) return false;

        try {
            Map<String, Object> body = Map.of(
                    "comment",             Map.of("text", text),
                    "languages",           List.of("ko"),
                    "requestedAttributes", Map.of("TOXICITY", Map.of())
            );

            Map<?, ?> response = restTemplate.postForObject(API_URL + apiKey, body, Map.class);
            if (response == null) return false;

            Map<?, ?> attributeScores = (Map<?, ?>) response.get("attributeScores");
            Map<?, ?> toxicity        = (Map<?, ?>) attributeScores.get("TOXICITY");
            Map<?, ?> summaryScore    = (Map<?, ?>) toxicity.get("summaryScore");
            double score = ((Number) summaryScore.get("value")).doubleValue();

            return score >= TOXICITY_THRESHOLD;

        } catch (Exception e) {
            log.warn("Perspective API 호출 실패 (필터링 건너뜀): {}", e.getMessage());
            return false;
        }
    }
}
