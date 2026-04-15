package org.triptogether.admin.service;

import org.triptogether.admin.vo.AdminExploreSearchVO;
import org.triptogether.admin.vo.AdminExploreStatsVO;

import java.util.List;
import java.util.Map;

public interface AdminExploreService {

    AdminExploreStatsVO getStats();

    Map<String, Object> getSpotList(AdminExploreSearchVO search);

    Map<String, Object> getSpotDetail(Long spotIdx);

    Map<String, Object> getReviewList(AdminExploreSearchVO search);

    void deleteSpot(Long spotIdx);

    void bulkDeleteSpots(List<Long> ids);

    void blockReview(Long reviewIdx);

    void bulkBlockReviews(List<Long> ids);
}
