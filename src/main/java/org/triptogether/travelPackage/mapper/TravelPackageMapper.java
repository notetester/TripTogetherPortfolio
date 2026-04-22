package org.triptogether.travelPackage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.travelPackage.vo.PackageReviewHistoryCreateVO;
import org.triptogether.travelPackage.vo.PackageSpotOptionVO;
import org.triptogether.travelPackage.vo.TravelPackageVO;

import java.util.List;

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
}
