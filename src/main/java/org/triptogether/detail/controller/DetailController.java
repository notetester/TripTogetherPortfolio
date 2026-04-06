package org.triptogether.detail.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.explore.service.ExploreService;
import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.explore.vo.ReviewVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/detail")
@RequiredArgsConstructor
public class DetailController {

    private final ExploreService exploreService;

    @Value("${google.maps.api-key}")
    private String mapsApiKey;

    /* ============================================================
       GET /detail/{spotIdx}  →  여행지 상세 페이지
       ============================================================ */
    @GetMapping("/{spotIdx}")
    public String detail(@PathVariable Long spotIdx,
                         Model model,
                         HttpSession session) {

        Long loginUserIdx = getLoginUserIdx(session);
        ExploreVO spot = exploreService.getSpotDetail(spotIdx, loginUserIdx);
        if (spot == null) return "redirect:/explore";

        List<ReviewVO> reviewList = exploreService.getReviewList(spotIdx);
        boolean canWrite = (loginUserIdx != null)
                && exploreService.canWriteReview(spotIdx, loginUserIdx);

        model.addAttribute("spot",         spot);
        model.addAttribute("reviewList",   reviewList);
        model.addAttribute("canWrite",     canWrite);
        model.addAttribute("isLoggedIn",   loginUserIdx != null);
        model.addAttribute("loginUserIdx", loginUserIdx);
        model.addAttribute("mapsApiKey",   mapsApiKey);

        return "detail/detail";
    }

    /* ============================================================
       POST /detail/{spotIdx}/review  →  리뷰 작성 (AJAX)
       ============================================================ */
    @PostMapping("/{spotIdx}/review")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> writeReview(
            @PathVariable Long spotIdx,
            @RequestBody  Map<String, Object> body,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        Long userIdx = getLoginUserIdx(session);

        if (userIdx == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return ResponseEntity.ok(result);
        }
        if (!exploreService.canWriteReview(spotIdx, userIdx)) {
            result.put("success", false);
            result.put("message", "이미 리뷰를 작성하셨습니다.");
            return ResponseEntity.ok(result);
        }

        int rating;
        String content;
        try {
            rating  = Integer.parseInt(String.valueOf(body.get("rating")));
            content = String.valueOf(body.get("content")).trim();
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "입력값이 올바르지 않습니다.");
            return ResponseEntity.ok(result);
        }

        if (rating < 1 || rating > 5) {
            result.put("success", false);
            result.put("message", "별점은 1~5 사이여야 합니다.");
            return ResponseEntity.ok(result);
        }
        if (content.isEmpty() || content.length() > 500) {
            result.put("success", false);
            result.put("message", "리뷰 내용을 1~500자로 입력해 주세요.");
            return ResponseEntity.ok(result);
        }

        ReviewVO review = new ReviewVO();
        review.setSpotIdx(spotIdx);
        review.setUserIdx(userIdx);
        review.setRating(rating);
        review.setContent(content);

        exploreService.writeReview(review);
        result.put("success", true);
        result.put("message", "리뷰가 등록되었습니다.");
        return ResponseEntity.ok(result);
    }

    /* ============================================================
       DELETE /detail/{spotIdx}/review/{reviewIdx}  →  리뷰 삭제
       ============================================================ */
    @DeleteMapping("/{spotIdx}/review/{reviewIdx}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteReview(
            @PathVariable Long spotIdx,
            @PathVariable Long reviewIdx,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        Long userIdx = getLoginUserIdx(session);

        if (userIdx == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return ResponseEntity.ok(result);
        }

        exploreService.deleteReview(reviewIdx, userIdx);
        result.put("success", true);
        result.put("message", "리뷰가 삭제되었습니다.");
        return ResponseEntity.ok(result);
    }

    /* ── 세션에서 로그인 사용자 idx ── */
    private Long getLoginUserIdx(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser instanceof UsersVO) {
            return ((UsersVO) loginUser).getUserIdx();
        }
        return null;
    }
}
