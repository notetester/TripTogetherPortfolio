package org.triptogether.explore.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.triptogether.explore.mapper.ExploreMapper;
import org.triptogether.explore.vo.ExploreSearchDto;
import org.triptogether.explore.vo.ExploreVO;
import org.triptogether.explore.vo.ReviewVO;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ExploreServiceImpl implements ExploreService {

    private final ExploreMapper exploreMapper;

    /* ============================================================
       목록 조회
       ============================================================ */

    @Override
    public List<ExploreVO> getSpotList(ExploreSearchDto search) {
        List<ExploreVO> list = exploreMapper.selectSpotList(search);
        splitTags(list);
        return list;
    }

    @Override
    public List<ExploreVO> getRatingSpotList(ExploreSearchDto search) {
        List<ExploreVO> list = exploreMapper.selectRatingSpotList(search);
        splitTags(list);
        return list;
    }

    @Override
    public List<ExploreVO> getLikesSpotList(ExploreSearchDto search) {
        List<ExploreVO> list = exploreMapper.selectLikesSpotList(search);
        splitTags(list);
        return list;
    }

    @Override
    public int getTotalCount(ExploreSearchDto search) {
        String tab = search.getTab();
        if ("rating".equals(tab)) {
            return exploreMapper.selectRatingTotalCount(search);
        } else if ("likes".equals(tab)) {
            return exploreMapper.selectLikesTotalCount(search);
        }
        return exploreMapper.selectTotalCount(search);
    }

    @Override
    public int getTotalPage(ExploreSearchDto search) {
        int total = getTotalCount(search);
        int size  = search.getPageSize();
        return (int) Math.ceil((double) total / size);
    }

    /* ============================================================
       필터 데이터
       ============================================================ */

    @Override
    public List<String> getRegionList() {
        return exploreMapper.selectRegionList();
    }

    @Override
    public List<String> getTagList() {
        return exploreMapper.selectTagList();
    }

    /* ============================================================
       상세 조회
       ============================================================ */

    @Override
    public ExploreVO getSpotDetail(Long spotIdx, Long loginUserIdx) {
        ExploreVO vo = exploreMapper.selectSpotDetail(spotIdx);
        if (vo == null) return null;

        vo.setTags(exploreMapper.selectSpotTags(spotIdx));

        if (loginUserIdx != null) {
            vo.setFavorited(exploreMapper.selectFavoriteCount(spotIdx, loginUserIdx) > 0);
            vo.setLiked(exploreMapper.selectLikeCount(spotIdx, loginUserIdx) > 0);
        }
        return vo;
    }

    /* ============================================================
       리뷰
       ============================================================ */

    @Override
    public List<ReviewVO> getReviewList(Long spotIdx) {
        return exploreMapper.selectReviewList(spotIdx);
    }

    @Override
    public boolean canWriteReview(Long spotIdx, Long userIdx) {
        // 이미 작성한 리뷰가 없어야 작성 가능
        return exploreMapper.selectMyReviewCount(spotIdx, userIdx) == 0;
    }

    @Override
    public void writeReview(ReviewVO review) {
        exploreMapper.insertReview(review);
    }

    @Override
    public void deleteReview(Long reviewIdx, Long userIdx) {
        exploreMapper.deleteReview(reviewIdx, userIdx);
    }

    /* ============================================================
       찜 / 좋아요 토글
       ============================================================ */

    @Override
    public boolean toggleFavorite(Long spotIdx, Long userIdx) {
        boolean already = exploreMapper.selectFavoriteCount(spotIdx, userIdx) > 0;
        if (already) { exploreMapper.deleteFavorite(spotIdx, userIdx); return false; }
        else          { exploreMapper.insertFavorite(spotIdx, userIdx); return true;  }
    }

    @Override
    public boolean toggleLike(Long spotIdx, Long userIdx) {
        boolean already = exploreMapper.selectLikeCount(spotIdx, userIdx) > 0;
        if (already) { exploreMapper.deleteLike(spotIdx, userIdx); return false; }
        else          { exploreMapper.insertLike(spotIdx, userIdx); return true;  }
    }

    /* ============================================================
       내부 유틸 - GROUP_CONCAT → List<String>
       ============================================================ */
    private void splitTags(List<ExploreVO> list) {
        if (list == null) return;
        for (ExploreVO vo : list) {
            String concat = vo.getTagsConcat();
            vo.setTags(concat != null && !concat.isBlank()
                    ? Arrays.asList(concat.split(","))
                    : Collections.emptyList());
        }
    }
}
