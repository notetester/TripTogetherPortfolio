package org.triptogether.travelPackage.service;

import org.triptogether.travelPackage.vo.PackageSpotOptionVO;
import org.triptogether.travelPackage.vo.PackageBookingRequestVO;
import org.triptogether.travelPackage.vo.PackageBookingResultVO;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.travelPackage.vo.TravelPackageForm;
import org.triptogether.travelPackage.vo.TravelPackageRevisionVO;
import org.triptogether.travelPackage.vo.TravelPackageVO;

import java.util.List;

public interface TravelPackageService {

    List<TravelPackageVO> getSellerPackages(Long sellerUserIdx);

    TravelPackageVO getSellerPackage(Long packageIdx, Long sellerUserIdx);

    List<PackageSpotOptionVO> getSpotOptions();

    void createPackage(Long sellerUserIdx, TravelPackageForm form);

    void updatePackage(Long sellerUserIdx, TravelPackageForm form);

    void submitPackage(Long sellerUserIdx, Long packageIdx);

    List<TravelPackageVO> getAdminPackages(String status);

    void approvePackage(Long packageIdx, Long adminUserIdx);

    void rejectPackage(Long packageIdx, String rejectReason, Long adminUserIdx);

    List<TravelPackageRevisionVO> getAdminPackageRevisions(String status);

    void approvePackageRevision(Long packageRevisionIdx, Long adminUserIdx);

    void rejectPackageRevision(Long packageRevisionIdx, String rejectReason, Long adminUserIdx);

    List<TravelPackageVO> getApprovedPackages();

    List<TravelPackageVO> getHomeRecommendedPackages();

    List<TravelPackageVO> getApprovedPackagesBySpot(Long spotIdx);

    PackageBookingResultVO bookPackage(Long userIdx, PackageBookingRequestVO request);

    UsersVO cancelPackageBooking(Long userIdx, Long packageBookingIdx, String cancelReason);
}
