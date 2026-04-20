package org.triptogether.perspective;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.triptogether.moderation.service.ModerationPolicyService;

import java.util.List;
import java.util.Map;

/**
 * Google Perspective API 연동 서비스.
 *
 * <p>댓글·게시글·문의 내용의 독성(혐오·욕설·비방) 여부를 판단한다.
 * 커뮤니티 댓글 작성 및 문의 등록 시 자동으로 호출된다.</p>
 *
 * <ul>
 *   <li>독성 점수가 정책 임계값 (ModerationPolicyService) 이상이면 {@code true} 반환</li>
 *   <li>API 호출 실패 시 {@code false} 반환 — 오류가 사용자 경험을 막지 않도록 fail-safe 처리</li>
 * </ul>
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class PerspectiveService {

    @Value("${perspective.api.key}")
    private String apiKey;

    private final RestTemplate restTemplate;
    private final ModerationPolicyService moderationPolicyService;

    /** Google Perspective API 엔드포인트 (뒤에 apiKey를 붙여 사용). */
    private static final String API_URL =
            "https://commentanalyzer.googleapis.com/v1alpha1/comments:analyze?key=";

    /**
     * 텍스트의 독성 여부를 판단한다.
     *
     * <p>API 호출 실패 시 {@code false}를 반환해 필터링을 건너뛴다 (fail-safe).</p>
     *
     * @param text 검사할 텍스트 (null 또는 빈 문자열이면 항상 {@code false})
     * @return 독성 점수가 정책 임계값 이상이면 {@code true}
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

            double threshold = moderationPolicyService.getPolicy().getToxicityThreshold();
            return score >= threshold;

        } catch (Exception e) {
            log.warn("Perspective API 호출 실패 (필터링 건너뜀): {}", e.getMessage());
            return false;
        }
    }
}
