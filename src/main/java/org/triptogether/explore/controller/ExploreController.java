package org.triptogether.explore.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.explore.service.ExploreService;
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

        return "explore/list";
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
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser instanceof UsersVO) {
            return ((UsersVO) loginUser).getUserIdx();
        }
        return null;
    }
}
