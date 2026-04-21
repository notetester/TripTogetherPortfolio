package org.triptogether.travelPackage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
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
}
