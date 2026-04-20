package org.triptogether.perspective;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.triptogether.community.service.CommunityService;

import java.util.List;
import java.util.Map;

/**
 * Google Perspective API 연동 서비스.
 *
 * <p>댓글·게시글·문의 내용의 독성(혐오·욕설·비방) 여부를 판단한다.
 * 커뮤니티 댓글 작성 및 문의 등록 시 자동으로 호출된다.</p>
 *
 * <ul>
 *   <li>독성 점수가 {@link #TOXICITY_THRESHOLD} 이상이면 {@code true} 반환</li>
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
    private final CommunityService communityService;

    /** 독성 판정 임계값. 0.0 ~ 1.0 중 0.8 이상이면 독성으로 간주한다. */
    private static final double TOXICITY_THRESHOLD = 0.8;

    /** Google Perspective API 엔드포인트 (뒤에 apiKey를 붙여 사용). */
    private static final String API_URL =
            "https://commentanalyzer.googleapis.com/v1alpha1/comments:analyze?key=";

    /**
     * 텍스트의 독성 여부를 판단한다.
     *
     * <p>API 호출 실패 시 {@code false}를 반환해 필터링을 건너뛴다 (fail-safe).</p>
     *
     * @param text 검사할 텍스트 (null 또는 빈 문자열이면 항상 {@code false})
     * @return 독성 점수가 {@link #TOXICITY_THRESHOLD} 이상이면 {@code true}
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

    /**
     * 게시글 본문을 비동기로 독성 검사함. 독성 감지 시 ai_flagged=1 세팅.
     * 글 등록 응답을 막지 않도록 @Async 로 돌림 (Perspective API 1~5초 지연 회피).
     */
    @Async
    public void checkAndFlagPostAsync(Long postId, String text) {
        try {
            if (isToxic(text)) {
                communityService.flagPostAsToxic(postId);
                log.info("AI 독성 감지 → 게시글 ai_flagged=1 처리 (postId={})", postId);
            }
        } catch (Exception e) {
            log.warn("비동기 게시글 독성 검사 실패 (postId={}): {}", postId, e.getMessage());
        }
    }

    /**
     * 댓글 본문을 비동기로 독성 검사함. 독성 감지 시 ai_flagged=1 세팅.
     */
    @Async
    public void checkAndFlagCommentAsync(Long commentId, String text) {
        try {
            if (isToxic(text)) {
                communityService.flagCommentAsToxic(commentId);
                log.info("AI 독성 감지 → 댓글 ai_flagged=1 처리 (commentId={})", commentId);
            }
        } catch (Exception e) {
            log.warn("비동기 댓글 독성 검사 실패 (commentId={}): {}", commentId, e.getMessage());
        }
    }
}
