package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.admin.mapper.AdminExploreMapper;
import org.triptogether.admin.vo.AdminExploreReviewVO;
import org.triptogether.admin.vo.AdminExploreSearchVO;
import org.triptogether.admin.vo.AdminExploreSpotVO;
import org.triptogether.admin.vo.AdminExploreStatsVO;
import org.triptogether.admin.vo.AdminPageVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AdminExploreServiceImpl implements AdminExploreService {

    private final AdminExploreMapper adminExploreMapper;

    @Override
    public AdminExploreStatsVO getStats() {
        return adminExploreMapper.getStats();
    }

    @Override
    public Map<String, Object> getSpotList(AdminExploreSearchVO search) {
        List<AdminExploreSpotVO> list = adminExploreMapper.findSpots(search);
        int total = adminExploreMapper.countSpots(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    @Override
    public Map<String, Object> getSpotDetail(Long spotIdx) {
        AdminExploreSpotVO spot = adminExploreMapper.findSpotDetail(spotIdx);
        List<String> tags = adminExploreMapper.findSpotTags(spotIdx);
        List<AdminExploreReviewVO> reviews = adminExploreMapper.findReviewsBySpot(spotIdx);

        Map<String, Object> result = new HashMap<>();
        result.put("spot", spot);
        result.put("tags", tags);
        result.put("reviews", reviews);
        return result;
    }

    @Override
    public Map<String, Object> getReviewList(AdminExploreSearchVO search) {
        List<AdminExploreReviewVO> list = adminExploreMapper.findReviews(search);
        int total = adminExploreMapper.countReviews(search);
        AdminPageVO paging = AdminPageVO.of(total, search.getPage(), search.getSize(), 10);

        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        result.put("paging", paging);
        result.put("total", total);
        result.put("search", search);
        return result;
    }

    @Override
    public void deleteSpot(Long spotIdx) {
        adminExploreMapper.updateSpotActive(spotIdx, 1);
    }

    @Override
    public void bulkDeleteSpots(List<Long> ids) {
        if (ids != null && !ids.isEmpty()) {
            adminExploreMapper.bulkUpdateSpotActive(ids, 1);
        }
    }

    @Override
    public void blockReview(Long reviewIdx) {
        adminExploreMapper.updateReviewBlock(reviewIdx, 1);
    }

    @Override
    public void bulkBlockReviews(List<Long> ids) {
        if (ids != null && !ids.isEmpty()) {
            adminExploreMapper.bulkUpdateReviewBlock(ids, 1);
        }
    }
}
