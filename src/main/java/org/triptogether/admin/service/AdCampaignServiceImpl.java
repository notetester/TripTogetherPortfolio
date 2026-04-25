package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdCampaignMapper;
import org.triptogether.admin.vo.AdCampaignVO;

import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdCampaignServiceImpl implements AdCampaignService {

    private final AdCampaignMapper adCampaignMapper;

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
        adCampaignMapper.insertAd(ad);
        return ad.getAdId();
    }

    @Override
    @Transactional
    public int update(AdCampaignVO ad) {
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
