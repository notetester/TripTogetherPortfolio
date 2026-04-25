package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdCampaignMapper;
import org.triptogether.admin.vo.AdCampaignVO;
import org.triptogether.travelPackage.service.TravelPackageService;
import org.triptogether.travelPackage.vo.TravelPackageVO;

import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdCampaignServiceImpl implements AdCampaignService {

    private final AdCampaignMapper adCampaignMapper;
    private final TravelPackageService travelPackageService;

    /**
     * 옵션 B: 광고 폼에서 패키지를 선택한 경우 spot으로 자동 변환.
     * 패키지는 직접 진입 페이지가 없고 여행지(spot) 상세를 거쳐 도달하는 구조이므로,
     * 저장 시점에 link_target_type='package' → 'explore' + spot_idx로 정규화한다.
     */
    private void normalizePackageToExplore(AdCampaignVO ad) {
        if (!"INTERNAL".equals(ad.getLinkType())) return;
        if (!"package".equals(ad.getLinkTargetType())) return;
        if (ad.getLinkTargetId() == null) return;

        List<TravelPackageVO> approved = travelPackageService.getApprovedPackages(null, 0, 10000);
        Long spotIdx = approved.stream()
                .filter(p -> ad.getLinkTargetId().equals(p.getPackageIdx()))
                .map(TravelPackageVO::getSpotIdx)
                .findFirst()
                .orElse(null);

        if (spotIdx != null) {
            ad.setLinkTargetType("explore");
            ad.setLinkTargetId(spotIdx);
        } else {
            log.warn("ad form: package={} 의 spot_idx 를 찾지 못해 변환 건너뜀", ad.getLinkTargetId());
        }
    }

    @Override
    public List<AdCampaignVO> listAll(String slotCode, boolean activeOnly) {
        return adCampaignMapper.selectAll(slotCode, activeOnly);
    }

    @Override
    public AdCampaignVO getById(Long adId) {
        if (adId == null) return null;
        return adCampaignMapper.selectById(adId);
    }

    @Override
    @Transactional
    public Long create(AdCampaignVO ad) {
        normalizePackageToExplore(ad);
        adCampaignMapper.insertAd(ad);
        return ad.getAdId();
    }

    @Override
    @Transactional
    public int update(AdCampaignVO ad) {
        normalizePackageToExplore(ad);
        return adCampaignMapper.updateAd(ad);
    }

    @Override
    @Transactional
    public int setActive(Long adId, boolean isActive) {
        if (adId == null) return 0;
        return adCampaignMapper.updateActive(adId, isActive);
    }

    @Override
    @Transactional
    public int delete(Long adId) {
        if (adId == null) return 0;
        return adCampaignMapper.deleteAd(adId);
    }

    @Override
    public AdCampaignVO pickForSlot(String slotCode) {
        if (slotCode == null || slotCode.isEmpty()) return null;
        List<AdCampaignVO> candidates = adCampaignMapper.selectActiveBySlot(slotCode);
        if (candidates == null || candidates.isEmpty()) return null;
        // 동일 sort_order 다수일 때 편향 방지용 랜덤 하나 선택
        int idx = ThreadLocalRandom.current().nextInt(candidates.size());
        return candidates.get(idx);
    }

    @Override
    public void increaseView(Long adId) {
        if (adId == null) return;
        try {
            adCampaignMapper.incrementView(adId);
        } catch (Exception e) {
            log.warn("ad view increment failed id={}: {}", adId, e.getMessage());
        }
    }

    @Override
    public void increaseClick(Long adId) {
        if (adId == null) return;
        try {
            adCampaignMapper.incrementClick(adId);
        } catch (Exception e) {
            log.warn("ad click increment failed id={}: {}", adId, e.getMessage());
        }
    }
}
