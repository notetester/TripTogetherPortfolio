package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.triptogether.admin.service.AdCampaignService;
import org.triptogether.admin.vo.AdCampaignVO;
import org.triptogether.travelPackage.service.TravelPackageService;
import org.triptogether.travelPackage.vo.TravelPackageVO;

import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 공개용 광고 엔드포인트
 * - GET  /ad/{id}/click      : 클릭 카운트 + 실제 광고 링크로 리다이렉트
 * - POST /ad/{id}/impression : 노출 카운트 (렌더 시점에 JS 에서 fire-and-forget)
 *
 * 링크 동작 분기 (link_type):
 *  - EXTERNAL : link_url 로 리다이렉트
 *  - INTERNAL : link_target_type/link_target_id 로 내부 라우트 매핑
 *  - NONE     : 카운트만 +1, 홈으로 리다이렉트
 */
@Slf4j
@Controller
@RequiredArgsConstructor
public class AdPublicController {

    private final AdCampaignService adCampaignService;
    private final TravelPackageService travelPackageService;

    @GetMapping("/ad/{adId}/click")
    public ResponseEntity<Void> click(@PathVariable Long adId, HttpServletRequest request) {
        AdCampaignVO ad = adCampaignService.getById(adId);
        if (ad == null) {
            return ResponseEntity.notFound().build();
        }
        adCampaignService.increaseClick(adId);
        String target = resolveClickTarget(ad, request.getContextPath());
        return ResponseEntity.status(302).location(URI.create(target)).build();
    }

    @PostMapping("/ad/{adId}/impression")
    @ResponseBody
    public Map<String, Object> impression(@PathVariable Long adId) {
        Map<String, Object> res = new HashMap<>();
        adCampaignService.increaseView(adId);
        res.put("success", true);
        return res;
    }

    private String resolveClickTarget(AdCampaignVO ad, String contextPath) {
        String type = (ad.getLinkType() != null) ? ad.getLinkType() : "EXTERNAL";
        switch (type) {
            case "EXTERNAL":
                return (ad.getLinkUrl() != null && !ad.getLinkUrl().isBlank())
                        ? ad.getLinkUrl()
                        : contextPath + "/";
            case "INTERNAL":
                return contextPath + resolveInternalPath(ad.getLinkTargetType(), ad.getLinkTargetId());
            case "NONE":
            default:
                return contextPath + "/";
        }
    }

    /**
     * link_target_type 별 내부 라우트 매핑.
     * id 가 null 이면 해당 모듈의 목록 페이지로, 있으면 상세 페이지로.
     *
     * package 타입은 패키지 직접 진입 페이지가 없으므로, 클릭 시점에
     * spot_idx 를 조회해 detail 페이지로 보내고 ?openPackage 쿼리로
     * 모달 자동 오픈을 트리거한다.
     */
    private String resolveInternalPath(String targetType, Long targetId) {
        if (targetType == null || targetType.isBlank()) return "/";
        switch (targetType) {
            case "package":
                return resolvePackagePath(targetId);
            case "community":
                return (targetId != null) ? ("/community/" + targetId) : "/community";
            case "courses":
                return (targetId != null) ? ("/courses/detail?planId=" + targetId) : "/courses";
            case "explore":
                return (targetId != null) ? ("/detail/" + targetId) : "/explore";
            case "flight":
                return "/flight/offers";
            case "shop":
                return "/shop";
            case "mypage":
                return "/mypage";
            case "inquiry":
                return (targetId != null) ? ("/inquiry/" + targetId) : "/inquiry";
            default:
                return "/";
        }
    }

    /**
     * package 타입 클릭 시 spot_idx 조회 → detail 페이지 + openPackage 쿼리.
     * 패키지를 못 찾으면 패키지 목록으로 fallback.
     */
    private String resolvePackagePath(Long packageIdx) {
        if (packageIdx == null) return "/packages";
        try {
            List<TravelPackageVO> approved = travelPackageService.getApprovedPackages(null, 0, 10000);
            Long spotIdx = approved.stream()
                    .filter(p -> packageIdx.equals(p.getPackageIdx()))
                    .map(TravelPackageVO::getSpotIdx)
                    .findFirst()
                    .orElse(null);
            if (spotIdx != null) {
                return "/detail/" + spotIdx + "?openPackage=" + packageIdx;
            }
            log.warn("ad click: package={} 의 spot_idx 조회 실패 — 목록으로 fallback", packageIdx);
        } catch (Exception e) {
            log.warn("ad click: package={} 변환 실패 — {}", packageIdx, e.getMessage());
        }
        return "/packages";
    }
}
