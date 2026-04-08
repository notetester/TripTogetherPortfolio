package org.triptogether.explore.controller;

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
import org.triptogether.explore.vo.ExploreSearchDto;
import org.triptogether.explore.vo.ExploreVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/explore")
@RequiredArgsConstructor
public class ExploreController {

    private final ExploreService exploreService;

    @Value("${google.maps.api-key}")
    private String mapsApiKey;

    /* ============================================================
       GET /explore  →  여행지 탐색 메인
       tab: all / region / theme / rating / likes
       ============================================================ */
    @GetMapping
    public String explore(
            @RequestParam(defaultValue = "all")  String tab,
            @RequestParam(defaultValue = "")     String keyword,
            @RequestParam(defaultValue = "")     String region,
            @RequestParam(defaultValue = "")     String theme,
            @RequestParam(defaultValue = "1")    int    page,
            Model model,
            HttpSession session) {

        ExploreSearchDto search = buildSearch(tab, keyword, region, theme, page);

        List<ExploreVO> spotList;
        if ("rating".equals(tab)) {
            spotList = exploreService.getRatingSpotList(search);
        } else if ("likes".equals(tab)) {
            spotList = exploreService.getLikesSpotList(search);
        } else {
            spotList = exploreService.getSpotList(search);
        }

        model.addAttribute("spotList",    spotList);
        model.addAttribute("totalCount",  exploreService.getTotalCount(search));
        model.addAttribute("totalPage",   exploreService.getTotalPage(search));
        model.addAttribute("currentPage", page);
        model.addAttribute("search",      search);
        model.addAttribute("regionList",  exploreService.getRegionList());
        model.addAttribute("tagList",     exploreService.getTagList());
        model.addAttribute("writeTagList", exploreService.getWriteTagList());
        model.addAttribute("mapsApiKey",  mapsApiKey);
        if (!model.containsAttribute("writeForm")) {
            model.addAttribute("writeForm", new ExploreCreateDto());
        }
        if (!model.containsAttribute("openWriteModal")) {
            model.addAttribute("openWriteModal", false);
        }

        return "explore/list";
    }

    @PostMapping("/write")
    public String writeSpot(@ModelAttribute("writeForm") ExploreCreateDto writeForm,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {

        UsersVO loginUser = getLoginUser(session);
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("writeError", "여행지 등록은 로그인 후 이용할 수 있습니다.");
            redirectAttributes.addFlashAttribute("openWriteModal", true);
            redirectAttributes.addFlashAttribute("writeForm", writeForm);
            return "redirect:/explore";
        }

        String validationError = validateWriteForm(writeForm);
        if (validationError != null) {
            redirectAttributes.addFlashAttribute("writeError", validationError);
            redirectAttributes.addFlashAttribute("openWriteModal", true);
            redirectAttributes.addFlashAttribute("writeForm", writeForm);
            return "redirect:/explore";
        }

        Long spotIdx = exploreService.createSpot(writeForm, loginUser);
        redirectAttributes.addFlashAttribute("writeSuccess", "새 여행지가 등록되었습니다.");
        return "redirect:/detail/" + spotIdx;
    }

    /* ============================================================
       POST /explore/favorite/{spotIdx}  →  찜 토글 (AJAX)
       ============================================================ */
    @PostMapping("/favorite/{spotIdx}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleFavorite(
            @PathVariable Long spotIdx, HttpSession session) {

        Long userIdx = getLoginUserIdx(session);
        Map<String, Object> result = new HashMap<>();

        if (userIdx == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return ResponseEntity.ok(result);
        }

        boolean added = exploreService.toggleFavorite(spotIdx, userIdx);
        result.put("success",   true);
        result.put("favorited", added);
        result.put("message",   added ? "찜 목록에 추가되었습니다." : "찜 목록에서 제거되었습니다.");
        return ResponseEntity.ok(result);
    }

    /* ============================================================
       POST /explore/like/{spotIdx}  →  좋아요 토글 (AJAX)
       ============================================================ */
    @PostMapping("/like/{spotIdx}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleLike(
            @PathVariable Long spotIdx, HttpSession session) {

        Long userIdx = getLoginUserIdx(session);
        Map<String, Object> result = new HashMap<>();

        if (userIdx == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return ResponseEntity.ok(result);
        }

        boolean added = exploreService.toggleLike(spotIdx, userIdx);
        result.put("success", true);
        result.put("liked",   added);
        result.put("message", added ? "좋아요를 눌렀습니다." : "좋아요를 취소했습니다.");
        return ResponseEntity.ok(result);
    }

    /* ── 내부 유틸 ── */
    private ExploreSearchDto buildSearch(String tab, String keyword,
                                         String region, String theme, int page) {
        ExploreSearchDto s = new ExploreSearchDto();
        s.setTab(tab.trim());
        s.setKeyword(keyword.trim());
        s.setRegion(region.trim());
        s.setTheme(theme.trim());
        s.setPage(page);
        s.calcOffset();
        return s;
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

    private String validateWriteForm(ExploreCreateDto writeForm) {
        if (writeForm == null) return "등록 정보가 올바르지 않습니다.";

        String name = writeForm.getName() == null ? "" : writeForm.getName().trim();
        String region = writeForm.getRegion() == null ? "" : writeForm.getRegion().trim();
        String address = writeForm.getAddress() == null ? "" : writeForm.getAddress().trim();
        String description = writeForm.getDescription() == null ? "" : writeForm.getDescription().trim();

        if (name.isEmpty() || name.length() > 100) {
            return "여행지 이름은 1자 이상 100자 이하로 입력해주세요.";
        }
        if (region.isEmpty() || region.length() > 100) {
            return "지역은 1자 이상 100자 이하로 입력해주세요.";
        }
        if (address.isEmpty() || address.length() > 255) {
            return "주소를 검색해서 입력해주세요.";
        }
        if (writeForm.getLatitude() == null || writeForm.getLongitude() == null) {
            return "지도에서 위치를 검색해 위도와 경도를 선택해주세요.";
        }
        if (writeForm.getLatitude() < -90 || writeForm.getLatitude() > 90
                || writeForm.getLongitude() < -180 || writeForm.getLongitude() > 180) {
            return "위치 좌표가 올바르지 않습니다.";
        }
        if (description.isEmpty() || description.length() > 2000) {
            return "설명은 1자 이상 2000자 이하로 입력해주세요.";
        }
        return null;
    }
}
