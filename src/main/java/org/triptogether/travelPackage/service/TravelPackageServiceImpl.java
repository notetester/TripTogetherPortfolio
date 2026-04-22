package org.triptogether.travelPackage.service;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.mapper.WalletMapper;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.myPage.vo.WalletPaymentDto;
import org.triptogether.travelPackage.vo.PackageBookingCreateVO;
import org.triptogether.travelPackage.vo.PackageBookingRequestVO;
import org.triptogether.travelPackage.vo.PackageBookingResultVO;
import org.triptogether.travelPackage.vo.PackageBookingVO;
import org.triptogether.travelPackage.mapper.TravelPackageMapper;
import org.triptogether.travelPackage.vo.PackageReviewHistoryCreateVO;
import org.triptogether.travelPackage.vo.PackageSpotOptionVO;
import org.triptogether.travelPackage.vo.TravelPackageForm;
import org.triptogether.travelPackage.vo.TravelPackageRevisionVO;
import org.triptogether.travelPackage.vo.TravelPackageVO;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Locale;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class TravelPackageServiceImpl implements TravelPackageService {

    private static final String STATUS_DRAFT = "DRAFT";
    private static final String STATUS_PENDING = "PENDING";
    private static final String STATUS_APPROVED = "APPROVED";
    private static final String STATUS_REJECTED = "REJECTED";
    private static final long MAX_MILEAGE_RATE = 30;
    private static final Set<String> ALLOWED_IMAGE_EXTENSIONS = Set.of(".jpg", ".jpeg", ".png", ".gif", ".webp");

    private final TravelPackageMapper travelPackageMapper;
    private final WalletMapper walletMapper;

    @Value("${file.upload.path}")
    private String uploadPath;

    @Override
    public List<TravelPackageVO> getSellerPackages(Long sellerUserIdx) {
        validateSeller(sellerUserIdx);
        return travelPackageMapper.selectSellerPackages(sellerUserIdx);
    }

    @Override
    public TravelPackageVO getSellerPackage(Long packageIdx, Long sellerUserIdx) {
        validateSeller(sellerUserIdx);
        if (packageIdx == null) {
            throw new IllegalArgumentException("패키지 상품 정보가 올바르지 않습니다.");
        }
        TravelPackageVO travelPackage = travelPackageMapper.selectSellerPackage(packageIdx, sellerUserIdx);
        if (travelPackage == null) {
            throw new IllegalArgumentException("수정 가능한 패키지 상품을 찾을 수 없습니다.");
        }
        return travelPackage;
    }

    @Override
    public List<PackageSpotOptionVO> getSpotOptions() {
        return travelPackageMapper.selectSpotOptions();
    }

    @Override
    @Transactional
    public void createPackage(Long sellerUserIdx, TravelPackageForm form) {
        validateSeller(sellerUserIdx);
        validateForm(form);

        TravelPackageVO travelPackage = toVO(form, null);
        travelPackage.setSellerUserIdx(sellerUserIdx);
        travelPackage.setPackageStatus(resolveRequestedStatus(form.getAction()));

        travelPackageMapper.insertPackage(travelPackage);
    }

    @Override
    @Transactional
    public void updatePackage(Long sellerUserIdx, TravelPackageForm form) {
        validateSeller(sellerUserIdx);
        validateForm(form);

        if (form.getPackageIdx() == null) {
            throw new IllegalArgumentException("수정할 패키지 상품 정보가 없습니다.");
        }

        TravelPackageVO currentPackage = travelPackageMapper.selectSellerPackage(form.getPackageIdx(), sellerUserIdx);
        if (currentPackage == null) {
            throw new IllegalArgumentException("수정 가능한 패키지 상품을 찾을 수 없습니다.");
        }

        if (STATUS_APPROVED.equals(currentPackage.getPackageStatus())) {
            createRevisionRequest(sellerUserIdx, form);
            return;
        }

        TravelPackageVO travelPackage = toVO(form, currentPackage.getMainImagePath());
        travelPackage.setSellerUserIdx(sellerUserIdx);
        travelPackage.setPackageStatus(resolveRequestedStatus(form.getAction()));

        int updated = travelPackageMapper.updatePackage(travelPackage);
        if (updated == 0) {
            throw new IllegalStateException("임시저장 또는 반려 상태의 패키지만 수정할 수 있습니다.");
        }
    }

    @Override
    @Transactional
    public void submitPackage(Long sellerUserIdx, Long packageIdx) {
        validateSeller(sellerUserIdx);
        if (packageIdx == null) {
            throw new IllegalArgumentException("승인 요청할 패키지 상품 정보가 없습니다.");
        }

        int updated = travelPackageMapper.submitPackage(packageIdx, sellerUserIdx);
        if (updated == 0) {
            throw new IllegalStateException("임시저장 또는 반려 상태의 패키지만 승인 요청할 수 있습니다.");
        }
    }

    @Override
    public List<TravelPackageVO> getAdminPackages(String status) {
        String normalizedStatus = normalizeAdminStatus(status);
        return travelPackageMapper.selectAdminPackages(normalizedStatus);
    }

    @Override
    @Transactional
    public void approvePackage(Long packageIdx, Long adminUserIdx) {
        validateReviewer(adminUserIdx);
        TravelPackageVO currentPackage = getReviewTarget(packageIdx);

        int updated = travelPackageMapper.approvePackage(packageIdx, adminUserIdx);
        if (updated == 0) {
            throw new IllegalStateException("승인 대기 상태의 패키지만 승인할 수 있습니다.");
        }

        insertReviewHistory(currentPackage, STATUS_APPROVED, "관리자 승인", adminUserIdx);
    }

    @Override
    @Transactional
    public void rejectPackage(Long packageIdx, String rejectReason, Long adminUserIdx) {
        validateReviewer(adminUserIdx);
        String reason = trimToNull(rejectReason);
        if (reason == null) {
            throw new IllegalArgumentException("반려 사유를 입력해주세요.");
        }
        if (reason.length() > 500) {
            throw new IllegalArgumentException("반려 사유는 500자 이하로 입력해주세요.");
        }

        TravelPackageVO currentPackage = getReviewTarget(packageIdx);

        int updated = travelPackageMapper.rejectPackage(packageIdx, reason);
        if (updated == 0) {
            throw new IllegalStateException("승인 대기 상태의 패키지만 반려할 수 있습니다.");
        }

        insertReviewHistory(currentPackage, STATUS_REJECTED, reason, adminUserIdx);
    }

    @Override
    public List<TravelPackageRevisionVO> getAdminPackageRevisions(String status) {
        String normalizedStatus = normalizeRevisionStatus(status);
        return travelPackageMapper.selectAdminPackageRevisions(normalizedStatus);
    }

    @Override
    @Transactional
    public void approvePackageRevision(Long packageRevisionIdx, Long adminUserIdx) {
        validateReviewer(adminUserIdx);
        TravelPackageRevisionVO revision = getRevisionReviewTarget(packageRevisionIdx);

        int applied = travelPackageMapper.applyPackageRevision(packageRevisionIdx);
        if (applied == 0) {
            throw new IllegalStateException("승인된 원본 패키지에만 수정 요청을 반영할 수 있습니다.");
        }

        int updated = travelPackageMapper.approvePackageRevision(packageRevisionIdx, adminUserIdx);
        if (updated == 0) {
            throw new IllegalStateException("검토 대기 상태의 수정 요청만 승인할 수 있습니다.");
        }

        PackageReviewHistoryCreateVO history = new PackageReviewHistoryCreateVO();
        history.setPackageIdx(revision.getPackageIdx());
        history.setPreviousStatus("REVISION_PENDING");
        history.setNewStatus("REVISION_APPROVED");
        history.setReviewReason("수정 요청 승인");
        history.setReviewedByUserIdx(adminUserIdx);
        travelPackageMapper.insertPackageReviewHistory(history);
    }

    @Override
    @Transactional
    public void rejectPackageRevision(Long packageRevisionIdx, String rejectReason, Long adminUserIdx) {
        validateReviewer(adminUserIdx);
        String reason = trimToNull(rejectReason);
        if (reason == null) {
            throw new IllegalArgumentException("반려 사유를 입력해주세요.");
        }
        if (reason.length() > 500) {
            throw new IllegalArgumentException("반려 사유는 500자 이하로 입력해주세요.");
        }

        TravelPackageRevisionVO revision = getRevisionReviewTarget(packageRevisionIdx);
        int updated = travelPackageMapper.rejectPackageRevision(packageRevisionIdx, reason, adminUserIdx);
        if (updated == 0) {
            throw new IllegalStateException("검토 대기 상태의 수정 요청만 반려할 수 있습니다.");
        }

        PackageReviewHistoryCreateVO history = new PackageReviewHistoryCreateVO();
        history.setPackageIdx(revision.getPackageIdx());
        history.setPreviousStatus("REVISION_PENDING");
        history.setNewStatus("REVISION_REJECTED");
        history.setReviewReason(reason);
        history.setReviewedByUserIdx(adminUserIdx);
        travelPackageMapper.insertPackageReviewHistory(history);
    }

    @Override
    public List<TravelPackageVO> getApprovedPackages() {
        return travelPackageMapper.selectApprovedPackages();
    }

    @Override
    public List<TravelPackageVO> getApprovedPackagesBySpot(Long spotIdx) {
        if (spotIdx == null) {
            return List.of();
        }
        return travelPackageMapper.selectApprovedPackagesBySpot(spotIdx);
    }

    @Override
    @Transactional
    public PackageBookingResultVO bookPackage(Long userIdx, PackageBookingRequestVO request) {
        validateBookingRequest(userIdx, request);

        TravelPackageVO travelPackage = travelPackageMapper.selectApprovedPackageForUpdate(request.getPackageIdx());
        if (travelPackage == null) {
            throw new IllegalArgumentException("package.booking.error.unavailableOrExpired");
        }

        int peopleCount = request.getPeopleCount();
        validatePeopleCount(travelPackage, peopleCount);

        UsersVO user = walletMapper.selectUserByIdxForUpdate(userIdx);
        if (user == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }

        long totalPrice = calculateTotalPrice(travelPackage.getPackagePrice(), peopleCount);
        long mileageAmount = request.getMileageAmount() != null ? request.getMileageAmount() : 0L;
        long maxMileageUse = floorToThousand(totalPrice * MAX_MILEAGE_RATE / 100);
        if (mileageAmount < 0) {
            throw new IllegalArgumentException("마일리지 사용 금액은 0 이상이어야 합니다.");
        }
        if (mileageAmount > maxMileageUse) {
            throw new IllegalArgumentException("마일리지는 패키지 결제 금액의 30%까지만 사용할 수 있습니다.");
        }
        if (user.getMileageBalance() < mileageAmount) {
            throw new IllegalStateException("마일리지 잔액이 부족합니다.");
        }

        long cashAmount = totalPrice - mileageAmount;
        if (user.getCashBalance() < cashAmount) {
            throw new IllegalStateException("캐시 잔액이 부족합니다.");
        }

        long cashAfter = user.getCashBalance() - cashAmount;
        long mileageAfter = user.getMileageBalance() - mileageAmount;
        walletMapper.updateWalletBalances(userIdx, cashAfter, mileageAfter);

        WalletPaymentDto payment = buildPackagePayment(userIdx, travelPackage, totalPrice, cashAmount, mileageAmount);
        walletMapper.insertPaymentHistory(payment);

        insertWalletHistory(userIdx, "CASH", cashAmount, cashAfter, payment.getPaymentIdx(),
                travelPackage.getPackageTitle() + " 패키지 캐시 결제");
        if (mileageAmount > 0) {
            insertWalletHistory(userIdx, "MILEAGE", mileageAmount, mileageAfter, payment.getPaymentIdx(),
                    travelPackage.getPackageTitle() + " 패키지 마일리지 결제");
        }

        PackageBookingCreateVO booking = buildPackageBooking(userIdx, travelPackage, peopleCount, totalPrice, cashAmount, mileageAmount);
        travelPackageMapper.insertPackageBooking(booking);
        travelPackageMapper.increasePackageBookingCount(travelPackage.getPackageIdx());

        UsersVO updatedUser = walletMapper.selectUserByIdx(userIdx);
        return new PackageBookingResultVO(
                booking.getPackageBookingIdx(),
                booking.getBookingNo(),
                totalPrice,
                cashAmount,
                mileageAmount,
                updatedUser
        );
    }

    @Override
    @Transactional
    public UsersVO cancelPackageBooking(Long userIdx, Long packageBookingIdx, String cancelReason) {
        if (userIdx == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }
        if (packageBookingIdx == null) {
            throw new IllegalArgumentException("취소할 패키지 예약 정보가 없습니다.");
        }

        PackageBookingVO booking = travelPackageMapper.selectPackageBookingForUpdate(packageBookingIdx, userIdx);
        if (booking == null) {
            throw new IllegalArgumentException("취소할 패키지 예약을 찾을 수 없습니다.");
        }
        if (!"BOOKED".equals(booking.getBookingStatus())) {
            throw new IllegalStateException("예약완료 상태의 패키지만 취소할 수 있습니다.");
        }

        UsersVO user = walletMapper.selectUserByIdxForUpdate(userIdx);
        if (user == null) {
            throw new IllegalStateException("회원 정보를 찾을 수 없습니다.");
        }

        long cashAfter = safeAdd(user.getCashBalance(), booking.getUsedCash());
        long mileageAfter = safeAdd(user.getMileageBalance(), booking.getUsedMileage());
        walletMapper.updateWalletBalances(userIdx, cashAfter, mileageAfter);

        String reason = normalizeCancelReason(cancelReason);
        int updated = travelPackageMapper.cancelPackageBooking(packageBookingIdx, userIdx, reason);
        if (updated == 0) {
            throw new IllegalStateException("이미 취소되었거나 취소할 수 없는 예약입니다.");
        }

        insertRefundWalletHistory(userIdx, "CASH", booking.getUsedCash(), cashAfter,
                booking.getBookingNo() + " 패키지 예약 취소 캐시 환불");
        if (booking.getUsedMileage() > 0) {
            insertRefundWalletHistory(userIdx, "MILEAGE", booking.getUsedMileage(), mileageAfter,
                    booking.getBookingNo() + " 패키지 예약 취소 마일리지 환불");
        }
        travelPackageMapper.decreasePackageBookingCount(booking.getPackageIdx());
        return walletMapper.selectUserByIdx(userIdx);
    }

    private TravelPackageVO toVO(TravelPackageForm form, String currentImagePath) {
        TravelPackageVO travelPackage = new TravelPackageVO();
        travelPackage.setPackageIdx(form.getPackageIdx());
        travelPackage.setSpotIdx(form.getSpotIdx());
        travelPackage.setPackageTitle(trim(form.getPackageTitle()));
        travelPackage.setPackageSummary(trimToNull(form.getPackageSummary()));
        travelPackage.setPackageContent(trim(form.getPackageContent()));
        travelPackage.setPackagePrice(form.getPackagePrice());
        travelPackage.setCurrencyCode(trimToDefault(form.getCurrencyCode(), "KRW"));
        travelPackage.setStartDate(form.getStartDate());
        travelPackage.setEndDate(form.getEndDate());
        travelPackage.setMinPeople(form.getMinPeople());
        travelPackage.setMaxPeople(form.getMaxPeople());
        travelPackage.setMainImagePath(resolveMainImagePath(form, currentImagePath));
        return travelPackage;
    }

    private void createRevisionRequest(Long sellerUserIdx, TravelPackageForm form) {
        if (travelPackageMapper.selectPendingRevisionByPackage(form.getPackageIdx()) != null) {
            throw new IllegalStateException("이미 관리자 검토 대기 중인 수정 요청이 있습니다.");
        }

        TravelPackageRevisionVO revision = new TravelPackageRevisionVO();
        revision.setPackageIdx(form.getPackageIdx());
        revision.setSellerUserIdx(sellerUserIdx);
        revision.setPackageTitle(trim(form.getPackageTitle()));
        revision.setPackageSummary(trimToNull(form.getPackageSummary()));
        revision.setPackageContent(trim(form.getPackageContent()));
        revision.setPackagePrice(form.getPackagePrice());
        revision.setCurrencyCode(trimToDefault(form.getCurrencyCode(), "KRW"));
        revision.setStartDate(form.getStartDate());
        revision.setEndDate(form.getEndDate());
        revision.setMinPeople(form.getMinPeople());
        revision.setMaxPeople(form.getMaxPeople());
        TravelPackageVO currentPackage = travelPackageMapper.selectSellerPackage(form.getPackageIdx(), sellerUserIdx);
        String currentImagePath = currentPackage != null ? currentPackage.getMainImagePath() : null;
        revision.setMainImagePath(resolveMainImagePath(form, currentImagePath));
        revision.setRevisionStatus(STATUS_PENDING);

        travelPackageMapper.insertPackageRevision(revision);
    }

    private String resolveMainImagePath(TravelPackageForm form, String currentImagePath) {
        MultipartFile imageFile = form.getMainImageFile();
        if (imageFile == null || imageFile.isEmpty()) {
            String submittedPath = trimToNull(form.getMainImagePath());
            return submittedPath != null ? submittedPath : currentImagePath;
        }
        return storePackageImage(imageFile);
    }

    private String storePackageImage(MultipartFile imageFile) {
        String originalFilename = imageFile.getOriginalFilename();
        String extension = extractExtension(originalFilename);
        if (!ALLOWED_IMAGE_EXTENSIONS.contains(extension)) {
            throw new IllegalArgumentException("패키지 대표 이미지는 JPG, PNG, GIF, WEBP 형식만 업로드할 수 있습니다.");
        }

        try {
            Path packageUploadDir = Path.of(System.getProperty("user.dir"), uploadPath, "package").normalize();
            Files.createDirectories(packageUploadDir);

            String savedFilename = UUID.randomUUID().toString().replace("-", "") + extension;
            Path targetPath = packageUploadDir.resolve(savedFilename).normalize();

            if (!targetPath.startsWith(packageUploadDir)) {
                throw new IllegalArgumentException("파일 저장 경로가 올바르지 않습니다.");
            }

            imageFile.transferTo(targetPath);
            return "/upload/package/" + savedFilename;
        } catch (IOException e) {
            throw new IllegalStateException("패키지 대표 이미지 업로드에 실패했습니다.");
        }
    }

    private String extractExtension(String filename) {
        if (filename == null) {
            return "";
        }
        int dotIndex = filename.lastIndexOf('.');
        if (dotIndex < 0) {
            return "";
        }
        return filename.substring(dotIndex).toLowerCase(Locale.ROOT);
    }

    private void validateSeller(Long sellerUserIdx) {
        if (sellerUserIdx == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }
    }

    private void validateReviewer(Long adminUserIdx) {
        if (adminUserIdx == null) {
            throw new IllegalStateException("관리자 로그인이 필요합니다.");
        }
    }

    private TravelPackageVO getReviewTarget(Long packageIdx) {
        if (packageIdx == null) {
            throw new IllegalArgumentException("검토할 패키지 상품 정보가 없습니다.");
        }
        TravelPackageVO currentPackage = travelPackageMapper.selectPackageForReview(packageIdx);
        if (currentPackage == null) {
            throw new IllegalArgumentException("검토할 패키지 상품을 찾을 수 없습니다.");
        }
        if (!STATUS_PENDING.equals(currentPackage.getPackageStatus())) {
            throw new IllegalStateException("승인 대기 상태의 패키지만 검토할 수 있습니다.");
        }
        return currentPackage;
    }

    private TravelPackageRevisionVO getRevisionReviewTarget(Long packageRevisionIdx) {
        if (packageRevisionIdx == null) {
            throw new IllegalArgumentException("검토할 패키지 수정 요청 정보가 없습니다.");
        }
        TravelPackageRevisionVO revision = travelPackageMapper.selectPackageRevisionForReview(packageRevisionIdx);
        if (revision == null) {
            throw new IllegalArgumentException("검토할 패키지 수정 요청을 찾을 수 없습니다.");
        }
        if (!STATUS_PENDING.equals(revision.getRevisionStatus())) {
            throw new IllegalStateException("검토 대기 상태의 수정 요청만 처리할 수 있습니다.");
        }
        return revision;
    }

    private void insertReviewHistory(TravelPackageVO currentPackage,
                                     String newStatus,
                                     String reviewReason,
                                     Long reviewerUserIdx) {
        PackageReviewHistoryCreateVO history = new PackageReviewHistoryCreateVO();
        history.setPackageIdx(currentPackage.getPackageIdx());
        history.setPreviousStatus(currentPackage.getPackageStatus());
        history.setNewStatus(newStatus);
        history.setReviewReason(reviewReason);
        history.setReviewedByUserIdx(reviewerUserIdx);
        travelPackageMapper.insertPackageReviewHistory(history);
    }

    private String normalizeAdminStatus(String status) {
        String normalized = trimToNull(status);
        if (normalized == null || "ALL".equalsIgnoreCase(normalized)) {
            return null;
        }

        String upperStatus = normalized.toUpperCase();
        if (List.of(STATUS_PENDING, STATUS_APPROVED, STATUS_REJECTED, "BLOCKED", STATUS_DRAFT).contains(upperStatus)) {
            return upperStatus;
        }
        return STATUS_PENDING;
    }

    private String normalizeRevisionStatus(String status) {
        String normalized = trimToNull(status);
        if (normalized == null || "ALL".equalsIgnoreCase(normalized)) {
            return STATUS_PENDING;
        }

        String upperStatus = normalized.toUpperCase();
        if (List.of(STATUS_PENDING, STATUS_APPROVED, STATUS_REJECTED).contains(upperStatus)) {
            return upperStatus;
        }
        return STATUS_PENDING;
    }

    private void validateForm(TravelPackageForm form) {
        if (form == null) {
            throw new IllegalArgumentException("패키지 상품 입력값이 없습니다.");
        }
        if (form.getSpotIdx() == null) {
            throw new IllegalArgumentException("연결할 여행지를 선택해주세요.");
        }
        if (isBlank(form.getPackageTitle())) {
            throw new IllegalArgumentException("패키지 상품명을 입력해주세요.");
        }
        if (trim(form.getPackageTitle()).length() > 150) {
            throw new IllegalArgumentException("패키지 상품명은 150자 이하로 입력해주세요.");
        }
        if (form.getPackageSummary() != null && trim(form.getPackageSummary()).length() > 300) {
            throw new IllegalArgumentException("짧은 소개는 300자 이하로 입력해주세요.");
        }
        if (isBlank(form.getPackageContent())) {
            throw new IllegalArgumentException("패키지 상세 설명을 입력해주세요.");
        }
        if (form.getPackagePrice() == null || form.getPackagePrice() < 0) {
            throw new IllegalArgumentException("패키지 가격은 0원 이상으로 입력해주세요.");
        }
        if (form.getMinPeople() == null || form.getMinPeople() < 1) {
            throw new IllegalArgumentException("최소 인원은 1명 이상이어야 합니다.");
        }
        if (form.getMaxPeople() != null && form.getMaxPeople() < form.getMinPeople()) {
            throw new IllegalArgumentException("최대 인원은 최소 인원보다 작을 수 없습니다.");
        }
        if (form.getStartDate() != null && form.getEndDate() != null && form.getEndDate().isBefore(form.getStartDate())) {
            throw new IllegalArgumentException("종료일은 시작일보다 빠를 수 없습니다.");
        }
    }

    private void validateBookingRequest(Long userIdx, PackageBookingRequestVO request) {
        if (userIdx == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }
        if (request == null || request.getPackageIdx() == null) {
            throw new IllegalArgumentException("예약할 패키지 상품 정보가 없습니다.");
        }
        if (request.getPeopleCount() == null) {
            throw new IllegalArgumentException("예약 인원을 선택해주세요.");
        }
    }

    private void validatePeopleCount(TravelPackageVO travelPackage, int peopleCount) {
        int minPeople = travelPackage.getMinPeople() != null ? travelPackage.getMinPeople() : 1;
        Integer maxPeople = travelPackage.getMaxPeople();
        if (peopleCount < minPeople) {
            throw new IllegalArgumentException("예약 인원은 최소 " + minPeople + "명 이상이어야 합니다.");
        }
        if (maxPeople != null && peopleCount > maxPeople) {
            throw new IllegalArgumentException("예약 인원은 최대 " + maxPeople + "명까지 가능합니다.");
        }
    }

    private long calculateTotalPrice(Long unitPrice, int peopleCount) {
        if (unitPrice == null || unitPrice < 0) {
            throw new IllegalStateException("패키지 가격 정보가 올바르지 않습니다.");
        }
        try {
            return Math.multiplyExact(unitPrice, peopleCount);
        } catch (ArithmeticException e) {
            throw new IllegalArgumentException("결제 금액이 너무 큽니다.");
        }
    }

    private WalletPaymentDto buildPackagePayment(Long userIdx,
                                                 TravelPackageVO travelPackage,
                                                 long totalPrice,
                                                 long cashAmount,
                                                 long mileageAmount) {
        WalletPaymentDto payment = new WalletPaymentDto();
        payment.setUserIdx(userIdx);
        payment.setPaymentType("PURCHASE");
        payment.setPaymentMethod(mileageAmount > 0 ? "CASH_MILEAGE" : "CASH");
        payment.setOrderName(travelPackage.getPackageTitle() + " 패키지 예약");
        payment.setSourceType("TRAVEL_PACKAGE");
        payment.setSourceId(travelPackage.getPackageIdx());
        payment.setOriginalAmount(totalPrice);
        payment.setDiscountRate(0.0);
        payment.setDiscountAmount(0L);
        payment.setFinalAmount(totalPrice);
        payment.setUsedCash(cashAmount);
        payment.setUsedMileage(mileageAmount);
        payment.setEarnedMileage(0L);
        payment.setPaymentStatus("COMPLETED");
        return payment;
    }

    private void insertWalletHistory(Long userIdx,
                                     String assetType,
                                     long amount,
                                     long balanceAfter,
                                     Long paymentIdx,
                                     String detailMessage) {
        if (amount <= 0) {
            return;
        }

        WalletHistoryDto history = new WalletHistoryDto();
        history.setUserIdx(userIdx);
        history.setAssetType(assetType);
        history.setChangeType("USE");
        history.setAmount(-amount);
        history.setBalanceAfter(balanceAfter);
        history.setRelatedPaymentIdx(paymentIdx);
        history.setDetailMessage(detailMessage);
        history.setActorUserIdx(userIdx);
        walletMapper.insertWalletHistory(history);
    }

    private void insertRefundWalletHistory(Long userIdx,
                                           String assetType,
                                           long amount,
                                           long balanceAfter,
                                           String detailMessage) {
        if (amount <= 0) {
            return;
        }

        WalletHistoryDto history = new WalletHistoryDto();
        history.setUserIdx(userIdx);
        history.setAssetType(assetType);
        history.setChangeType("REFUND");
        history.setAmount(amount);
        history.setBalanceAfter(balanceAfter);
        history.setDetailMessage(detailMessage);
        history.setActorUserIdx(userIdx);
        walletMapper.insertWalletHistory(history);
    }

    private PackageBookingCreateVO buildPackageBooking(Long userIdx,
                                                       TravelPackageVO travelPackage,
                                                       int peopleCount,
                                                       long totalPrice,
                                                       long cashAmount,
                                                       long mileageAmount) {
        PackageBookingCreateVO booking = new PackageBookingCreateVO();
        booking.setBookingNo("PKG-" + UUID.randomUUID().toString().replace("-", "").substring(0, 16).toUpperCase());
        booking.setPackageIdx(travelPackage.getPackageIdx());
        booking.setUserIdx(userIdx);
        booking.setPeopleCount(peopleCount);
        booking.setUnitPrice(travelPackage.getPackagePrice());
        booking.setTotalPrice(totalPrice);
        booking.setUsedCash(cashAmount);
        booking.setUsedMileage(mileageAmount);
        booking.setBookingStatus("BOOKED");
        return booking;
    }

    private long floorToThousand(long value) {
        return (value / 1000) * 1000;
    }

    private long safeAdd(long baseAmount, long refundAmount) {
        try {
            return Math.addExact(baseAmount, refundAmount);
        } catch (ArithmeticException e) {
            throw new IllegalStateException("환불 처리 후 잔액이 너무 큽니다.");
        }
    }

    private String normalizeCancelReason(String cancelReason) {
        String reason = trimToNull(cancelReason);
        if (reason == null) {
            return "사용자 직접 취소";
        }
        if (reason.length() > 500) {
            return reason.substring(0, 500);
        }
        return reason;
    }

    private String resolveRequestedStatus(String action) {
        if (STATUS_PENDING.equalsIgnoreCase(action)) {
            return STATUS_PENDING;
        }
        return STATUS_DRAFT;
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    private String trimToNull(String value) {
        String trimmed = trim(value);
        return trimmed == null || trimmed.isEmpty() ? null : trimmed;
    }

    private String trimToDefault(String value, String defaultValue) {
        String trimmed = trimToNull(value);
        return trimmed == null ? defaultValue : trimmed;
    }
}
