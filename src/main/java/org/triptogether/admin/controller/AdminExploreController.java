package org.triptogether.admin.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.admin.service.AdminExploreService;
import org.triptogether.admin.vo.AdminExploreSearchVO;
import org.triptogether.admin.vo.AdminExploreSpotVO;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.explore.service.ExploreService;
import org.triptogether.explore.vo.ExploreCreateDto;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/explore")
public class AdminExploreController {

    private final AdminExploreService adminExploreService;
    private final ExploreService exploreService;

    @GetMapping({"", "/"})
    public String spotList(AdminExploreSearchVO search, Model model) {
        model.addAllAttributes(adminExploreService.getSpotList(search));
        model.addAttribute("stats", adminExploreService.getStats());
        model.addAttribute("activeMenu", "explore");
        return "admin/explore/list";
    }

    @GetMapping("/spots/{spotIdx}")
    public String spotDetail(@PathVariable Long spotIdx,
                             @RequestParam(name = "edit", defaultValue = "false") boolean edit,
                             Model model) {
        model.addAllAttributes(adminExploreService.getSpotDetail(spotIdx));
        Object rawSpot = model.getAttribute("spot");
        if (rawSpot instanceof AdminExploreSpotVO spot) {
            Object rawTags = model.getAttribute("tags");
            List<String> tagList = rawTags instanceof List<?> list
                    ? list.stream().map(String::valueOf).toList()
                    : List.of();
            if (!model.containsAttribute("adminEditForm")) {
                model.addAttribute("adminEditForm", buildEditForm(spot, tagList));
            }
            model.addAttribute("writeTagList", exploreService.getWriteTagList());
        }
        model.addAttribute("openEditForm", edit);
        model.addAttribute("activeMenu", "explore");
        return "admin/explore/detail";
    }

    @PostMapping("/spots/{spotIdx}/update")
    public String updateSpot(@PathVariable Long spotIdx,
                             @ModelAttribute("adminEditForm") ExploreCreateDto adminEditForm,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {

        UsersVO loginUser = getLoginUser(session);
        if (loginUser == null || !"ADMIN".equals(loginUser.getUserRole())) {
            redirectAttributes.addFlashAttribute("adminEditError", "관리자만 여행지를 수정할 수 있습니다.");
            return "redirect:/admin/explore/spots/" + spotIdx;
        }

        String validationError = validateSpotForm(adminEditForm);
        if (validationError != null) {
            redirectAttributes.addFlashAttribute("adminEditError", validationError);
            redirectAttributes.addFlashAttribute("adminEditForm", adminEditForm);
            return "redirect:/admin/explore/spots/" + spotIdx;
        }

        try {
            // 관리자 페이지에서도 실제 수정 로직은 기존 여행지 서비스와 동일하게 재사용한다.
            // 이렇게 두면 공개 상세에서 쓰는 수정 규칙과 관리자 화면의 수정 규칙이 어긋나지 않는다.
            exploreService.updateSpot(spotIdx, adminEditForm, loginUser);
            redirectAttributes.addFlashAttribute("adminEditSuccess", "여행지 정보가 수정되었습니다.");
        } catch (Exception e) {
            log.error("여행지 수정 처리 오류 spotIdx={}", spotIdx, e);
            redirectAttributes.addFlashAttribute("adminEditError", "수정 중 오류가 발생했습니다.");
            redirectAttributes.addFlashAttribute("adminEditForm", adminEditForm);
        }

        return "redirect:/admin/explore/spots/" + spotIdx;
    }

    @GetMapping("/reviews")
    public String reviewList(AdminExploreSearchVO search, Model model) {
        model.addAllAttributes(adminExploreService.getReviewList(search));
        model.addAttribute("stats", adminExploreService.getStats());
        model.addAttribute("activeMenu", "explore");
        return "admin/explore/reviews";
    }

    @PostMapping("/spots/{spotIdx}/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteSpot(@PathVariable Long spotIdx) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminExploreService.deleteSpot(spotIdx);
            result.put("success", true);
        } catch (Exception e) {
            log.error("여행지 삭제 처리 오류 spotIdx={}", spotIdx, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    @PostMapping("/spots/bulk-action")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> bulkSpotAction(
            @RequestParam String action,
            @RequestParam(required = false) List<Long> ids) {

        Map<String, Object> result = new HashMap<>();
        if (ids == null || ids.isEmpty()) {
            result.put("success", false);
            result.put("message", "선택된 항목이 없습니다.");
            return ResponseEntity.badRequest().body(result);
        }

        try {
            if ("delete".equals(action)) {
                adminExploreService.bulkDeleteSpots(ids);
            } else {
                result.put("success", false);
                result.put("message", "알 수 없는 처리 옵션입니다.");
                return ResponseEntity.badRequest().body(result);
            }
            result.put("success", true);
            result.put("count", ids.size());
        } catch (Exception e) {
            log.error("여행지 일괄 처리 오류 action={}", action, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    @PostMapping("/reviews/{reviewIdx}/block")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> blockReview(@PathVariable Long reviewIdx) {
        Map<String, Object> result = new HashMap<>();
        try {
            adminExploreService.blockReview(reviewIdx);
            result.put("success", true);
        } catch (Exception e) {
            log.error("리뷰 차단 오류 reviewIdx={}", reviewIdx, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    @PostMapping("/reviews/bulk-action")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> bulkReviewAction(
            @RequestParam String action,
            @RequestParam(required = false) List<Long> ids) {

        Map<String, Object> result = new HashMap<>();
        if (ids == null || ids.isEmpty()) {
            result.put("success", false);
            result.put("message", "선택된 항목이 없습니다.");
            return ResponseEntity.badRequest().body(result);
        }

        try {
            if ("block".equals(action)) {
                adminExploreService.bulkBlockReviews(ids);
            } else {
                result.put("success", false);
                result.put("message", "알 수 없는 처리 옵션입니다.");
                return ResponseEntity.badRequest().body(result);
            }
            result.put("success", true);
            result.put("count", ids.size());
        } catch (Exception e) {
            log.error("리뷰 일괄 처리 오류 action={}", action, e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(result);
        }
        return ResponseEntity.ok(result);
    }

    private UsersVO getLoginUser(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser instanceof UsersVO usersVO) {
            return usersVO;
        }
        return null;
    }

    /**
     * 관리자 상세에 진입했을 때 수정 폼이 비어 보이지 않도록,
     * 현재 여행지 정보를 수정 DTO 형태로 한 번 감싸서 내려준다.
     */
    private ExploreCreateDto buildEditForm(AdminExploreSpotVO spot, List<String> tags) {
        ExploreCreateDto dto = new ExploreCreateDto();
        dto.setName(spot.getName());
        dto.setRegion(spot.getRegion());
        dto.setAddress(spot.getAddress());
        dto.setLatitude(spot.getLatitude());
        dto.setLongitude(spot.getLongitude());
        dto.setDescription(spot.getDescription());
        dto.setTags(tags);
        return dto;
    }

    /**
     * 관리자 페이지에서도 저장 전에 기본 형식을 먼저 점검한다.
     * DB 오류를 바로 맞기보다, 어떤 값이 잘못됐는지 화면에서 먼저 알려주기 위한 검증이다.
     */
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
