package org.triptogether.admin.controller;

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

import java.net.URI;
import java.util.HashMap;
import java.util.Map;

/**
 * 공개용 광고 엔드포인트
 * - GET  /ad/{id}/click      : 클릭 카운트 + 실제 광고 링크로 리다이렉트
 * - POST /ad/{id}/impression : 노출 카운트 (렌더 시점에 JS 에서 fire-and-forget)
 */
@Slf4j
@Controller
@RequiredArgsConstructor
public class AdPublicController {

    private final AdCampaignService adCampaignService;

    @GetMapping("/ad/{adId}/click")
    public ResponseEntity<Void> click(@PathVariable Long adId) {
        AdCampaignVO ad = adCampaignService.getById(adId);
        if (ad == null) {
            return ResponseEntity.notFound().build();
        }
        adCampaignService.increaseClick(adId);
        String target = (ad.getLinkUrl() != null && !ad.getLinkUrl().isBlank())
                ? ad.getLinkUrl() : "/";
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
}
