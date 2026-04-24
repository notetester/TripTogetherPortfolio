package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdCampaignVO;

import java.util.List;

public interface AdCampaignService {

    /** 슬롯 코드 상수 (하드코딩 슬롯 — 필요 시 여기만 추가) */
    String SLOT_COMMUNITY_LIST_TOP       = "community_list_top";
    String SLOT_COMMUNITY_DETAIL_BOTTOM  = "community_detail_bottom";

    // ===== 관리자용 =====

    /** 관리자 목록 (slotCode null=전체) */
    List<AdCampaignVO> listAll(String slotCode, boolean activeOnly);

    AdCampaignVO getById(Long adId);

    Long create(AdCampaignVO ad);

    int update(AdCampaignVO ad);

    int setActive(Long adId, boolean isActive);

    int delete(Long adId);

    // ===== 노출·트래킹용 =====

    /** 해당 슬롯의 노출 가능한 광고 1건 선택 (기간·활성 필터 후 sort_order+랜덤) */
    AdCampaignVO pickForSlot(String slotCode);

    void increaseView(Long adId);

    void increaseClick(Long adId);
}
