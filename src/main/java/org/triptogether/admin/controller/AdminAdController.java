package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponentsBuilder;
import org.triptogether.admin.service.AdCampaignService;
import org.triptogether.admin.vo.AdCampaignVO;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.cloudinary.CloudinaryService;
import org.triptogether.community.service.CommunityService;
import org.triptogether.community.vo.CommunityPostDto;
import org.triptogether.community.vo.CommunitySearchDto;
import org.triptogether.courses.service.TravelPlanService;
import org.triptogether.courses.vo.TravelPlanVO;
import org.triptogether.explore.service.ExploreService;
import org.triptogether.explore.vo.ExploreSearchDto;
import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.travelPackage.service.TravelPackageService;
import org.triptogether.travelPackage.vo.TravelPackageVO;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 관리자 — 광고 관리
 * URL: /admin/ads/**
 * 권한: AdminInterceptor 에서 ADMIN 역할 체크. 추가로 COMMUNITY_ADMIN or SUPER_ADMIN 필요.
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/ads")
public class AdminAdController {

    private final AdCampaignService adCampaignService;
    private final CloudinaryService cloudinaryService;
    private final TravelPackageService travelPackageService;
    private final CommunityService communityService;
    private final ExploreService exploreService;
    private final TravelPlanService travelPlanService;

    /** 광고 목록 */
    @GetMapping
    public String list(@RequestParam(required = false) String slotCode,
                       @RequestParam(required = false, defaultValue = "false") boolean activeOnly,
                       Model model) {
        List<AdCampaignVO> ads = adCampaignService.listAll(slotCode, activeOnly);
        model.addAttribute("adList", ads);
        model.addAttribute("slotCodeFilter", slotCode);
        model.addAttribute("activeOnly", activeOnly);
        model.addAttribute("activeMenu", "ads");
        model.addAttribute("pageTitle", "광고 관리");
        return "admin/ad/list";
    }

    /** 등록 폼 */
    @GetMapping("/new")
    public String createForm(Model model) {
        AdCampaignVO blank = new AdCampaignVO();
        blank.setLinkType("EXTERNAL");
        model.addAttribute("ad", blank);
        model.addAttribute("mode", "new");
        model.addAttribute("activeMenu", "ads");
        model.addAttribute("pageTitle", "광고 등록");
        injectTargetOptions(model);
        return "admin/ad/form";
    }

    /** 등록 */
    @PostMapping
    public String create(@ModelAttribute AdCampaignVO form,
                         @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") Date startAtInput,
                         @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") Date endAtInput,
                         @RequestParam(required = false) String returnSlotCode,
                         @RequestParam(required = false, defaultValue = "false") boolean returnActiveOnly,
                         HttpSession session,
                         RedirectAttributes redirectAttributes) {
        UsersVO user = (UsersVO) session.getAttribute("loginUser");
        form.setStartAt(startAtInput);
        form.setEndAt(endAtInput);
        if (user != null) form.setCreatedBy(user.getUserIdx());
        if (form.getIsActive() == null) form.setIsActive(true);
        if (form.getSortOrder() == null) form.setSortOrder(0);
        try {
            adCampaignService.create(form);
            redirectAttributes.addFlashAttribute("adMessage", "광고가 등록되었습니다.");
        } catch (Exception e) {
            log.error("광고 등록 오류", e);
            redirectAttributes.addFlashAttribute("adError", "등록 중 오류가 발생했습니다.");
        }
        return redirectAdList(returnSlotCode, returnActiveOnly);
    }

    /** 수정 폼 */
    @GetMapping("/{adId}/edit")
    public String editForm(@PathVariable Long adId, Model model) {
        AdCampaignVO ad = adCampaignService.getById(adId);
        if (ad == null) return "redirect:/admin/ads";
        model.addAttribute("ad", ad);
        model.addAttribute("mode", "edit");
        model.addAttribute("activeMenu", "ads");
        model.addAttribute("pageTitle", "광고 수정");
        injectTargetOptions(model);
        return "admin/ad/form";
    }

    /** 폼 드롭다운 옵션(승인된 패키지 / 게시글 / 여행지 목록) 주입. */
    private void injectTargetOptions(Model model) {
        // 승인된 패키지
        try {
            List<TravelPackageVO> approvedPackages =
                    travelPackageService.getApprovedPackages(null, 0, 1000);
            model.addAttribute("approvedPackages", approvedPackages);
        } catch (Exception e) {
            log.warn("광고 폼 패키지 옵션 로드 실패: {}", e.getMessage());
            model.addAttribute("approvedPackages", List.of());
        }
        // 활성 커뮤니티 게시글 (최근 500개)
        try {
            CommunitySearchDto postSearch = new CommunitySearchDto();
            postSearch.setPageSize(500);
            postSearch.setPage(1);
            postSearch.calcOffset();
            List<CommunityPostDto> posts = communityService.getPostList(postSearch);
            model.addAttribute("communityPosts", posts);
        } catch (Exception e) {
            log.warn("광고 폼 게시글 옵션 로드 실패: {}", e.getMessage());
            model.addAttribute("communityPosts", List.of());
        }
        // 활성 여행지
        try {
            ExploreSearchDto spotSearch = new ExploreSearchDto();
            spotSearch.setPageSize(500);
            spotSearch.setPage(1);
            spotSearch.calcOffset();
            List<ExploreVO> spots = exploreService.getSpotList(spotSearch);
            model.addAttribute("exploreSpots", spots);
        } catch (Exception e) {
            log.warn("광고 폼 여행지 옵션 로드 실패: {}", e.getMessage());
            model.addAttribute("exploreSpots", List.of());
        }
        // 공개 여행 코스
        try {
            List<TravelPlanVO> publicPlans = travelPlanService.getPublicTravelList();
            model.addAttribute("publicTravelPlans", publicPlans);
        } catch (Exception e) {
            log.warn("광고 폼 여행 코스 옵션 로드 실패: {}", e.getMessage());
            model.addAttribute("publicTravelPlans", List.of());
        }
    }

    /** 수정 */
    @PostMapping("/{adId}/update")
    public String update(@PathVariable Long adId,
                         @ModelAttribute AdCampaignVO form,
                         @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") Date startAtInput,
                         @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") Date endAtInput,
                         @RequestParam(required = false) String returnSlotCode,
                         @RequestParam(required = false, defaultValue = "false") boolean returnActiveOnly,
                         RedirectAttributes redirectAttributes) {
        form.setAdId(adId);
        form.setStartAt(startAtInput);
        form.setEndAt(endAtInput);
        if (form.getIsActive() == null) form.setIsActive(false);
        if (form.getSortOrder() == null) form.setSortOrder(0);
        try {
            adCampaignService.update(form);
            redirectAttributes.addFlashAttribute("adMessage", "광고가 수정되었습니다.");
        } catch (Exception e) {
            log.error("광고 수정 오류", e);
            redirectAttributes.addFlashAttribute("adError", "수정 중 오류가 발생했습니다.");
        }
        return redirectAdList(returnSlotCode, returnActiveOnly);
    }

    /** 활성 토글 (AJAX) */
    @PostMapping("/{adId}/toggle-active")
    @ResponseBody
    public Map<String, Object> toggleActive(@PathVariable Long adId,
                                            @RequestParam boolean isActive) {
        Map<String, Object> res = new HashMap<>();
        try {
            int affected = adCampaignService.setActive(adId, isActive);
            res.put("success", affected > 0);
        } catch (Exception e) {
            res.put("success", false);
            res.put("message", e.getMessage());
        }
        return res;
    }

    /** 삭제 */
    @PostMapping("/{adId}/delete")
    public String delete(@PathVariable Long adId,
                         @RequestParam(required = false) String slotCode,
                         @RequestParam(required = false, defaultValue = "false") boolean activeOnly,
                         RedirectAttributes redirectAttributes) {
        try {
            adCampaignService.delete(adId);
            redirectAttributes.addFlashAttribute("adMessage", "광고가 삭제되었습니다.");
        } catch (Exception e) {
            log.error("광고 삭제 오류", e);
            redirectAttributes.addFlashAttribute("adError", "삭제 중 오류가 발생했습니다.");
        }
        return redirectAdList(slotCode, activeOnly);
    }

    private String redirectAdList(String slotCode, boolean activeOnly) {
        UriComponentsBuilder builder = UriComponentsBuilder.fromPath("/admin/ads");
        if (slotCode != null && !slotCode.isBlank()) {
            builder.queryParam("slotCode", slotCode);
        }
        if (activeOnly) {
            builder.queryParam("activeOnly", "true");
        }
        return "redirect:" + builder.toUriString();
    }

    /** 이미지 업로드 (Cloudinary) */
    @PostMapping("/upload-image")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> uploadImage(@RequestParam("file") MultipartFile file) {
        Map<String, Object> res = new HashMap<>();
        if (file == null || file.isEmpty()) {
            res.put("success", false);
            res.put("message", "파일이 비어있습니다.");
            return ResponseEntity.badRequest().body(res);
        }
        try {
            String url = cloudinaryService.uploadImage(file, "ads");
            if (url == null || url.isBlank()) {
                res.put("success", false);
                res.put("message", "이미지 업로드에 실패했습니다.");
                return ResponseEntity.status(500).body(res);
            }
            res.put("success", true);
            res.put("url", url);
            return ResponseEntity.ok(res);
        } catch (Exception e) {
            log.error("광고 이미지 업로드 오류", e);
            res.put("success", false);
            res.put("message", "업로드 중 오류가 발생했습니다.");
            return ResponseEntity.status(500).body(res);
        }
    }
}
