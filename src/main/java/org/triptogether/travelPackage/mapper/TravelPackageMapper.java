package org.triptogether.travelPackage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.travelPackage.vo.PackageReviewHistoryCreateVO;
import org.triptogether.travelPackage.vo.PackageBookingCreateVO;
import org.triptogether.travelPackage.vo.PackageBookingVO;
import org.triptogether.travelPackage.vo.PackageSpotOptionVO;
import org.triptogether.travelPackage.vo.TravelPackageRevisionVO;
import org.triptogether.travelPackage.vo.TravelPackageVO;

import java.util.List;
import java.util.Map;

@Mapper
public interface TravelPackageMapper {

    List<TravelPackageVO> selectSellerPackages(@Param("sellerUserIdx") Long sellerUserIdx);

    TravelPackageVO selectSellerPackage(@Param("packageIdx") Long packageIdx,
                                        @Param("sellerUserIdx") Long sellerUserIdx);

    void insertPackage(TravelPackageVO travelPackage);

    int updatePackage(TravelPackageVO travelPackage);

    int submitPackage(@Param("packageIdx") Long packageIdx,
                      @Param("sellerUserIdx") Long sellerUserIdx);

    List<PackageSpotOptionVO> selectSpotOptions();

    List<TravelPackageVO> selectAdminPackages(@Param("status") String status);

    TravelPackageVO selectPackageForReview(@Param("packageIdx") Long packageIdx);

    int approvePackage(@Param("packageIdx") Long packageIdx,
                       @Param("approvedByUserIdx") Long approvedByUserIdx);

    int rejectPackage(@Param("packageIdx") Long packageIdx,
                      @Param("rejectReason") String rejectReason);

    void insertPackageReviewHistory(PackageReviewHistoryCreateVO history);

    List<TravelPackageVO> selectApprovedPackages();

    List<TravelPackageVO> selectApprovedPackagesBySpot(@Param("spotIdx") Long spotIdx);

    TravelPackageVO selectApprovedPackageForUpdate(@Param("packageIdx") Long packageIdx);

    void insertPackageBooking(PackageBookingCreateVO booking);

    void increasePackageBookingCount(@Param("packageIdx") Long packageIdx);

    PackageBookingVO selectPackageBookingForUpdate(@Param("packageBookingIdx") Long packageBookingIdx,
                                                   @Param("userIdx") Long userIdx);

    int cancelPackageBooking(@Param("packageBookingIdx") Long packageBookingIdx,
                             @Param("userIdx") Long userIdx,
                             @Param("cancelReason") String cancelReason);

    void decreasePackageBookingCount(@Param("packageIdx") Long packageIdx);

    TravelPackageRevisionVO selectPendingRevisionByPackage(@Param("packageIdx") Long packageIdx);

    void insertPackageRevision(TravelPackageRevisionVO revision);

    List<TravelPackageRevisionVO> selectAdminPackageRevisions(@Param("status") String status);

    TravelPackageRevisionVO selectPackageRevisionForReview(@Param("packageRevisionIdx") Long packageRevisionIdx);

    int applyPackageRevision(@Param("packageRevisionIdx") Long packageRevisionIdx);

    int approvePackageRevision(@Param("packageRevisionIdx") Long packageRevisionIdx,
                               @Param("reviewedByUserIdx") Long reviewedByUserIdx);

    int rejectPackageRevision(@Param("packageRevisionIdx") Long packageRevisionIdx,
                              @Param("rejectReason") String rejectReason,
                              @Param("reviewedByUserIdx") Long reviewedByUserIdx);

    /**
     * 챗봇 컨텍스트용 승인 패키지 다중 키워드 검색.
     * package_title/package_summary/연결 SPOT_TRAVEL.name/region 에 OR LIKE.
     * 인기순(예약 수 DESC, 조회 수 DESC).
     */
    List<Map<String, Object>> searchPackagesByKeywords(@Param("keywords") List<String> keywords,
                                                         @Param("limit") int limit);
}
