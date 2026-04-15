package org.triptogether.explore.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.explore.service.RecommendService;
import org.triptogether.explore.vo.RecommendVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * AI 여행지 추천 REST Controller
 *
 * POST /recommend/view-log       체류 시간 저장 (페이지 이탈 시 호출)
 * GET  /recommend/spots          추천 여행지 목록 조회 (AJAX)
 */
@Slf4j
@RestController
@RequestMapping("/recommend")
@RequiredArgsConstructor
public class RecommendController {

    private final RecommendService recommendService;

    /* ============================================================
       POST /recommend/view-log
       Body: { spotIdx, staySeconds }
       로그인 사용자의 페이지 체류 시간 저장
       ============================================================ */
    @PostMapping("/view-log")
    public ResponseEntity<Map<String, Object>> saveViewLog(
            @RequestBody Map<String, Object> body,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        Long userIdx = getLoginUserIdx(session);

        if (userIdx == null) {
            result.put("success", false);
            return ResponseEntity.ok(result);
        }

        try {
            Long spotIdx     = Long.parseLong(String.valueOf(body.get("spotIdx")));
            int  staySeconds = Integer.parseInt(String.valueOf(body.get("staySeconds")));
            recommendService.saveViewLog(userIdx, spotIdx, staySeconds);

            // ★ 체류 기록이 쌓이면 캐시를 즉시 무효화
            //   → 다음 /recommend/spots 호출 시 Gemini 재호출 (실시간 반영)
            recommendService.invalidateCache(userIdx);

            result.put("success", true);
        } catch (Exception e) {
            log.warn("[Recommend] view-log 저장 실패: {}", e.getMessage());
            result.put("success", false);
        }
        return ResponseEntity.ok(result);
    }

    /* ============================================================
       GET /recommend/spots
       로그인 사용자에게 AI 추천 여행지 목록 반환
       ============================================================ */
    @GetMapping("/spots")
    public ResponseEntity<Map<String, Object>> getRecommendations(
            @RequestParam(value = "currentSpotIdx", required = false) Long currentSpotIdx,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        Long userIdx = getLoginUserIdx(session);

        if (userIdx == null) {
            result.put("success", false);
            result.put("loggedIn", false);
            return ResponseEntity.ok(result);
        }

        try {
            List<RecommendVO> spots = recommendService.getRecommendations(userIdx, currentSpotIdx);
            boolean isTrending = !spots.isEmpty() && spots.get(0).getRecIdx() == 0;
            result.put("success",    true);
            result.put("loggedIn",   true);
            result.put("spots",      spots);
            result.put("isTrending", isTrending);
        } catch (Exception e) {
            log.error("[Recommend] 추천 조회 실패", e);
            result.put("success",    false);
            result.put("spots",      List.of());
            result.put("isTrending", false);
        }
        return ResponseEntity.ok(result);
    }

    /* ── 세션에서 userIdx ── */
    private Long getLoginUserIdx(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser instanceof UsersVO) {
            return ((UsersVO) loginUser).getUserIdx();
        }
        return null;
    }
}
