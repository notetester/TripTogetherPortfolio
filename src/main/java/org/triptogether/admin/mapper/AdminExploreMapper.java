package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.admin.vo.AdminExploreReviewVO;
import org.triptogether.admin.vo.AdminExploreSearchVO;
import org.triptogether.admin.vo.AdminExploreSpotVO;
import org.triptogether.admin.vo.AdminExploreStatsVO;

import java.util.List;

@Mapper
public interface AdminExploreMapper {

    AdminExploreStatsVO getStats();

    List<AdminExploreSpotVO> findSpots(AdminExploreSearchVO search);

    int countSpots(AdminExploreSearchVO search);

    AdminExploreSpotVO findSpotDetail(@Param("spotIdx") Long spotIdx);

    List<String> findSpotTags(@Param("spotIdx") Long spotIdx);

    List<AdminExploreReviewVO> findReviews(AdminExploreSearchVO search);

    int countReviews(AdminExploreSearchVO search);

    List<AdminExploreReviewVO> findReviewsBySpot(@Param("spotIdx") Long spotIdx);

    void updateSpotActive(@Param("spotIdx") Long spotIdx,
                          @Param("spotActive") int spotActive);

    void bulkUpdateSpotActive(@Param("ids") List<Long> ids,
                              @Param("spotActive") int spotActive);

    void updateReviewBlock(@Param("reviewIdx") Long reviewIdx,
                           @Param("reviewBlock") int reviewBlock);

    void bulkUpdateReviewBlock(@Param("ids") List<Long> ids,
                               @Param("reviewBlock") int reviewBlock);
}
