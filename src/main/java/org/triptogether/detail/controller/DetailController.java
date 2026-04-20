package org.triptogether.detail.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.explore.service.ExploreService;
import org.triptogether.explore.vo.ExploreCreateDto;
import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.explore.vo.ReviewVO;
import org.triptogether.flight.service.FlightService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/detail")
@RequiredArgsConstructor
public class DetailController {

    private final ExploreService exploreService;
    private final FlightService flightService;

    @Value("${google.maps.api-key}")
    private String mapsApiKey;

    @GetMapping("/{spotIdx}")
    public String detail(@PathVariable Long spotIdx,
                         Model model,
                         HttpSession session) {

        Long loginUserIdx = getLoginUserIdx(session);
        ExploreVO spot = exploreService.getSpotDetail(spotIdx, loginUserIdx);
        if (spot == null) return "redirect:/explore";

        List<ReviewVO> reviewList = exploreService.getReviewList(spotIdx, loginUserIdx);
        boolean canWrite = (loginUserIdx != null)
                && exploreService.canWriteReview(spotIdx, loginUserIdx);

        model.addAttribute("spot", spot);
        model.addAttribute("reviewList", reviewList);
        model.addAttribute("canWrite", canWrite);
        model.addAttribute("isLoggedIn", loginUserIdx != null);
        model.addAttribute("loginUserIdx", loginUserIdx);
        model.addAttribute("mapsApiKey", mapsApiKey);
        model.addAttribute("writeTagList", exploreService.getWriteTagList());
        model.addAttribute("isAdminMode", isAdminMode(session));
        model.addAttribute("canEditSpot", canEditSpot(session, spot));
        model.addAttribute("flightAvailable", flightService.isFlightAvailable(spotIdx));
        model.addAttribute("lowestFlightOffer", flightService.getLowestOffer(spotIdx).orElse(null));

        if (!model.containsAttribute("adminEditForm")) {
            model.addAttribute("adminEditForm", buildEditForm(spot));
        }
        if (!model.containsAttribute("openAdminEditModal")) {
            model.addAttribute("openAdminEditModal", false);
        }

        return "detail/detail";
    }

    @PostMapping("/{spotIdx}/admin/update")
    public String updateSpot(@PathVariable Long spotIdx,
                             @ModelAttribute("adminEditForm") ExploreCreateDto adminEditForm,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {

        ExploreVO spot = exploreService.getSpotDetail(spotIdx, getLoginUserIdx(session));
        if (spot == null || !canEditSpot(session, spot)) {
            redirectAttributes.addFlashAttribute("adminEditError", "관리자 또는 작성자 본인만 여행지를 수정할 수 있습니다.");
            return "redirect:/detail/" + spotIdx;
        }

        String validationError = validateSpotForm(adminEditForm);
        if (validationError != null) {
            redirectAttributes.addFlashAttribute("adminEditError", validationError);
            redirectAttributes.addFlashAttribute("openAdminEditModal", true);
            redirectAttributes.addFlashAttribute("adminEditForm", adminEditForm);
            return "redirect:/detail/" + spotIdx;
        }

        exploreService.updateSpot(spotIdx, adminEditForm, getLoginUser(session));
        redirectAttributes.addFlashAttribute("adminEditSuccess", "여행지 정보가 수정되었습니다.");
        return "redirect:/detail/" + spotIdx;
    }

    @PostMapping("/{spotIdx}/admin/delete")
    public String deleteSpot(@PathVariable Long spotIdx,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {

        if (!isAdminMode(session)) {
            redirectAttributes.addFlashAttribute("adminEditError", "관리자모드에서만 여행지를 삭제할 수 있습니다.");
            return "redirect:/detail/" + spotIdx;
        }

        exploreService.softDeleteSpot(spotIdx);
        redirectAttributes.addFlashAttribute("writeSuccess", "여행지가 삭제 처리되었습니다.");
        return "redirect:/explore";
    }

    @PostMapping("/{spotIdx}/review")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> writeReview(
            @PathVariable Long spotIdx,
            @RequestBody Map<String, Object> body,
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
            result.put("message", "이미 리뷰를 작성했습니다.");
            return ResponseEntity.ok(result);
        }

        int rating;
        String content;
        try {
            rating = Integer.parseInt(String.valueOf(body.get("rating")));
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
            result.put("message", "리뷰 내용은 1~500자로 입력해주세요.");
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

    @PostMapping("/{spotIdx}/review/{reviewIdx}/like")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleReviewLike(
            @PathVariable Long spotIdx,
            @PathVariable Long reviewIdx,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        Long userIdx = getLoginUserIdx(session);

        if (userIdx == null) {
            result.put("success", false);
            result.put("message", "濡쒓렇?몄씠 ?꾩슂?⑸땲??");
            return ResponseEntity.ok(result);
        }

        ReviewVO review = exploreService.getReview(reviewIdx);
        if (review == null || !spotIdx.equals(review.getSpotIdx())) {
            result.put("success", false);
            result.put("message", "由щ럭??李얠쓣 ???놁뒿?덈떎.");
            return ResponseEntity.ok(result);
        }

        boolean liked = exploreService.toggleReviewLike(reviewIdx, userIdx);
        ReviewVO updatedReview = exploreService.getReview(reviewIdx);

        result.put("success", true);
        result.put("liked", liked);
        result.put("likeCount", updatedReview != null && updatedReview.getLikeCount() != null
                ? updatedReview.getLikeCount() : 0);
        result.put("message", liked ? "由щ럭 醫뗭븘?붽? 諛섏쁺?섏뿀?듬땲??" : "由щ럭 醫뗭븘?붽? 痍⑥냼?섏뿀?듬땲??");
        return ResponseEntity.ok(result);
    }

    @PostMapping("/{spotIdx}/review/{reviewIdx}/block")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> blockReview(
            @PathVariable Long spotIdx,
            @PathVariable Long reviewIdx,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (!isAdminMode(session)) {
            result.put("success", false);
            result.put("message", "관리자모드에서만 리뷰를 차단할 수 있습니다.");
            return ResponseEntity.ok(result);
        }

        exploreService.blockReview(spotIdx, reviewIdx);
        result.put("success", true);
        result.put("message", "리뷰가 차단되었습니다.");
        return ResponseEntity.ok(result);
    }

    @PostMapping("/{spotIdx}/review/block-bulk")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> blockReviews(
            @PathVariable Long spotIdx,
            @RequestBody Map<String, Object> body,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        if (!isAdminMode(session)) {
            result.put("success", false);
            result.put("message", "관리자모드에서만 리뷰를 차단할 수 있습니다.");
            return ResponseEntity.ok(result);
        }

        Object rawIds = body.get("reviewIdxList");
        if (!(rawIds instanceof List<?> rawList) || rawList.isEmpty()) {
            result.put("success", false);
            result.put("message", "차단할 리뷰를 하나 이상 선택해주세요.");
            return ResponseEntity.ok(result);
        }

        List<Long> reviewIdxList = rawList.stream()
                .map(String::valueOf)
                .map(Long::parseLong)
                .toList();

        exploreService.blockReviews(spotIdx, reviewIdxList);
        result.put("success", true);
        result.put("blockedCount", reviewIdxList.size());
        result.put("message", "선택한 리뷰가 차단되었습니다.");
        return ResponseEntity.ok(result);
    }

    private Long getLoginUserIdx(HttpSession session) {
        UsersVO loginUser = getLoginUser(session);
        return loginUser != null ? loginUser.getUserIdx() : null;
    }

    private UsersVO getLoginUser(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser instanceof UsersVO) {
            return (UsersVO) loginUser;
        }
        return null;
    }

    private boolean isAdminMode(HttpSession session) {
        UsersVO loginUser = getLoginUser(session);
        if (loginUser == null || !"ADMIN".equals(loginUser.getUserRole())) {
            return false;
        }
        String viewMode = (String) session.getAttribute("viewMode");
        return !"user".equals(viewMode);
    }

    private boolean canEditSpot(HttpSession session, ExploreVO spot) {
        if (spot == null) {
            return false;
        }
        if (isAdminMode(session)) {
            return true;
        }

        UsersVO loginUser = getLoginUser(session);
        return loginUser != null
                && spot.getUserIdx() != null
                && spot.getUserIdx().equals(loginUser.getUserIdx());
    }

    private ExploreCreateDto buildEditForm(ExploreVO spot) {
        ExploreCreateDto dto = new ExploreCreateDto();
        dto.setName(spot.getName());
        dto.setRegion(spot.getRegion());
        dto.setAddress(spot.getAddress());
        dto.setLatitude(spot.getLatitude());
        dto.setLongitude(spot.getLongitude());
        dto.setDescription(spot.getDescription());
        dto.setTags(spot.getTags());
        return dto;
    }

    private String validateSpotForm(ExploreCreateDto form) {
        if (form == null) return "수정 정보가 올바르지 않습니다.";

        String name = form.getName() == null ? "" : form.getName().trim();
        String region = form.getRegion() == null ? "" : form.getRegion().trim();
        String address = form.getAddress() == null ? "" : form.getAddress().trim();
        String description = form.getDescription() == null ? "" : form.getDescription().trim();

        if (name.isEmpty() || name.length() > 100) {
            return "여행지 이름은 1자 이상 100자 이하로 입력해주세요.";
        }
        if (region.isEmpty() || region.length() > 100) {
            return "지역은 1자 이상 100자 이하로 입력해주세요.";
        }
        if (address.isEmpty() || address.length() > 255) {
            return "주소는 1자 이상 255자 이하로 입력해주세요.";
        }
        if (form.getLatitude() == null || form.getLongitude() == null) {
            return "위도와 경도를 모두 입력해주세요.";
        }
        if (form.getLatitude() < -90 || form.getLatitude() > 90
                || form.getLongitude() < -180 || form.getLongitude() > 180) {
            return "위도 또는 경도 값이 올바르지 않습니다.";
        }
        if (description.isEmpty() || description.length() > 2000) {
            return "설명은 1자 이상 2000자 이하로 입력해주세요.";
        }
        if (form.getTags() != null && form.getTags().size() > 4) {
            return "태그는 최대 4개까지 선택할 수 있습니다.";
        }
        return null;
    }
}
