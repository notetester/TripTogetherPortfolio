package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.AdCampaignVO;

import java.util.List;

@Mapper
public interface AdCampaignMapper {

    /** 관리자 목록 조회 (필터: slotCode=null 이면 전체, activeOnly=true 면 활성만) */
    List<AdCampaignVO> selectAll(@Param("slotCode")   String  slotCode,
                                 @Param("activeOnly") boolean activeOnly);

    /** 단건 조회 */
    AdCampaignVO selectById(@Param("adId") Long adId);

    /** 노출용: 슬롯의 활성·유효기간 조건 맞는 광고 목록 (sort_order, created_at DESC) */
    List<AdCampaignVO> selectActiveBySlot(@Param("slotCode") String slotCode);

    /** 신규 등록 */
    int insertAd(AdCampaignVO ad);

    /** 수정 */
    int updateAd(AdCampaignVO ad);

    /** 활성 토글 */
    int updateActive(@Param("adId")     Long    adId,
                     @Param("isActive") boolean isActive);

    /** 삭제 */
    int deleteAd(@Param("adId") Long adId);

    /** 노출 카운트 증가 */
    int incrementView(@Param("adId") Long adId);

    /** 클릭 카운트 증가 */
    int incrementClick(@Param("adId") Long adId);
}
