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
import java.util.Collections;
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
       GET /explore  ?? ?ы뻾吏 ?먯깋 硫붿씤
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
        search.setLoginUserIdx(getLoginUserIdx(session));

        List<ExploreVO> spotList;
        if ("rating".equals(tab)) {
            spotList = exploreService.getRatingSpotList(search);
        } else if ("likes".equals(tab)) {
            spotList = exploreService.getLikesSpotList(search);
        } else if ("favorite".equals(tab)) {
            // 찜한 여행지 탭: 로그인 사용자가 SPOT_FAVORITE에 등록한 여행지 목록 조회
            spotList = exploreService.getFavoriteSpotList(search);
        } else if ("ai".equals(tab)) {
            // AI 추천 탭: 클라이언트 AJAX(/recommend/spots)로 데이터를 로드하므로
            // 서버에서는 빈 목록을 세팅하여 불필요한 페이징 블록이 생기지 않도록 처리
            spotList = Collections.emptyList();
        } else {
            spotList = exploreService.getSpotList(search);
        }

        // AI 탭은 AJAX 기반이므로, totalCount/totalPage를 0으로 세팅하여 페이징 블록 미표시
        int totalCount = "ai".equals(tab) ? 0 : exploreService.getTotalCount(search);
        int totalPage  = "ai".equals(tab) ? 0 : exploreService.getTotalPage(search);

        model.addAttribute("spotList",    spotList);
        model.addAttribute("totalCount",  totalCount);
        model.addAttribute("totalPage",   totalPage);
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
            redirectAttributes.addFlashAttribute("writeError", "?ы뻾吏 ?깅줉? 濡쒓렇?????댁슜?????덉뒿?덈떎.");
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
        redirectAttributes.addFlashAttribute("writeSuccess", "???ы뻾吏媛 ?깅줉?섏뿀?듬땲??");
        return "redirect:/detail/" + spotIdx;
    }

    /* ============================================================
       GET /explore/suggest  검색 자동완성 API (AJAX)
       - 사용자가 검색창에 입력할 때마다 호출
       - keyword로 name, region, address를 LIKE 검색하여 최대 7건 반환
       ============================================================ */
    @GetMapping("/suggest")
    @ResponseBody
    public ResponseEntity<List<Map<String, Object>>> suggest(
            @RequestParam(defaultValue = "") String q) {

        // 입력값이 비어있으면 빈 배열 반환
        List<Map<String, Object>> suggestions = exploreService.getSuggestList(q);
        return ResponseEntity.ok(suggestions);
    }

    /* ============================================================
       POST /explore/favorite/{spotIdx}  ?? 李??좉? (AJAX)
       ============================================================ */
    @PostMapping("/favorite/{spotIdx}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleFavorite(
            @PathVariable Long spotIdx, HttpSession session) {

        Long userIdx = getLoginUserIdx(session);
        Map<String, Object> result = new HashMap<>();

        if (userIdx == null) {
            result.put("success", false);
            result.put("message", "濡쒓렇?몄씠 ?꾩슂?⑸땲??");
            return ResponseEntity.ok(result);
        }

        boolean added = exploreService.toggleFavorite(spotIdx, userIdx);
        result.put("success",   true);
        result.put("favorited", added);
        result.put("message",   added ? "李?紐⑸줉??異붽??섏뿀?듬땲??" : "李?紐⑸줉?먯꽌 ?쒓굅?섏뿀?듬땲??");
        return ResponseEntity.ok(result);
    }

    /* ============================================================
       POST /explore/like/{spotIdx}  ?? 醫뗭븘???좉? (AJAX)
       ============================================================ */
    @PostMapping("/like/{spotIdx}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleLike(
            @PathVariable Long spotIdx, HttpSession session) {

        Long userIdx = getLoginUserIdx(session);
        Map<String, Object> result = new HashMap<>();

        if (userIdx == null) {
            result.put("success", false);
            result.put("message", "濡쒓렇?몄씠 ?꾩슂?⑸땲??");
            return ResponseEntity.ok(result);
        }

        boolean added = exploreService.toggleLike(spotIdx, userIdx);
        result.put("success", true);
        result.put("liked",   added);
        result.put("message", added ? "醫뗭븘?붾? ?뚮??듬땲??" : "醫뗭븘?붾? 痍⑥냼?덉뒿?덈떎.");
        return ResponseEntity.ok(result);
    }

    /* ?? ?대? ?좏떥 ?? */
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
        if (writeForm == null) return "?깅줉 ?뺣낫媛 ?щ컮瑜댁? ?딆뒿?덈떎.";

        String name = writeForm.getName() == null ? "" : writeForm.getName().trim();
        String region = writeForm.getRegion() == null ? "" : writeForm.getRegion().trim();
        String address = writeForm.getAddress() == null ? "" : writeForm.getAddress().trim();
        String description = writeForm.getDescription() == null ? "" : writeForm.getDescription().trim();

        if (name.isEmpty() || name.length() > 100) {
            return "?ы뻾吏 ?대쫫? 1???댁긽 100???댄븯濡??낅젰?댁＜?몄슂.";
        }
        if (region.isEmpty() || region.length() > 100) {
            return "吏??? 1???댁긽 100???댄븯濡??낅젰?댁＜?몄슂.";
        }
        if (address.isEmpty() || address.length() > 255) {
            return "二쇱냼瑜?寃?됲빐???낅젰?댁＜?몄슂.";
        }
        if (writeForm.getLatitude() == null || writeForm.getLongitude() == null) {
            return "吏?꾩뿉???꾩튂瑜?寃?됲빐 ?꾨룄? 寃쎈룄瑜??좏깮?댁＜?몄슂.";
        }
        if (writeForm.getLatitude() < -90 || writeForm.getLatitude() > 90
                || writeForm.getLongitude() < -180 || writeForm.getLongitude() > 180) {
            return "?꾩튂 醫뚰몴媛 ?щ컮瑜댁? ?딆뒿?덈떎.";
        }
        if (description.isEmpty() || description.length() > 2000) {
            return "?ㅻ챸? 1???댁긽 2000???댄븯濡??낅젰?댁＜?몄슂.";
        }
        return null;
    }
}
