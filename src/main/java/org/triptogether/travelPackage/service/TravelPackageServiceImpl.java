package org.triptogether.travelPackage.service;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
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
    private final MessageSource messageSource;

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
            throw new IllegalArgumentException(msg("package.error.infoInvalid"));
        }
        TravelPackageVO travelPackage = travelPackageMapper.selectSellerPackage(packageIdx, sellerUserIdx);
        if (travelPackage == null) {
            throw new IllegalArgumentException(msg("package.error.editableNotFound"));
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
            throw new IllegalArgumentException(msg("package.error.updateInfoMissing"));
        }

        TravelPackageVO currentPackage = travelPackageMapper.selectSellerPackage(form.getPackageIdx(), sellerUserIdx);
        if (currentPackage == null) {
            throw new IllegalArgumentException(msg("package.error.editableNotFound"));
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
            throw new IllegalStateException(msg("package.error.updateAllowedOnlyDraftRejected"));
        }
    }

    @Override
    @Transactional
    public void submitPackage(Long sellerUserIdx, Long packageIdx) {
        validateSeller(sellerUserIdx);
        if (packageIdx == null) {
            throw new IllegalArgumentException(msg("package.error.submitInfoMissing"));
        }

        int updated = travelPackageMapper.submitPackage(packageIdx, sellerUserIdx);
        if (updated == 0) {
            throw new IllegalStateException(msg("package.error.submitAllowedOnlyDraftRejected"));
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
            throw new IllegalStateException(msg("package.error.pendingOnlyApprove"));
        }

        insertReviewHistory(currentPackage, STATUS_APPROVED, msg("package.history.adminApproved"), adminUserIdx);
    }

    @Override
    @Transactional
    public void rejectPackage(Long packageIdx, String rejectReason, Long adminUserIdx) {
        validateReviewer(adminUserIdx);
        String reason = trimToNull(rejectReason);
        if (reason == null) {
            throw new IllegalArgumentException(msg("package.error.rejectReasonRequired"));
        }
        if (reason.length() > 500) {
            throw new IllegalArgumentException(msg("package.error.rejectReasonTooLong"));
        }

        TravelPackageVO currentPackage = getReviewTarget(packageIdx);

        int updated = travelPackageMapper.rejectPackage(packageIdx, reason);
        if (updated == 0) {
            throw new IllegalStateException(msg("package.error.pendingOnlyReview"));
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
            throw new IllegalStateException(msg("package.error.revisionApplyApprovedOnly"));
        }

        int updated = travelPackageMapper.approvePackageRevision(packageRevisionIdx, adminUserIdx);
        if (updated == 0) {
            throw new IllegalStateException(msg("package.error.revisionPendingOnlyApprove"));
        }

        PackageReviewHistoryCreateVO history = new PackageReviewHistoryCreateVO();
        history.setPackageIdx(revision.getPackageIdx());
        history.setPreviousStatus("REVISION_PENDING");
        history.setNewStatus("REVISION_APPROVED");
        history.setReviewReason(msg("package.history.revisionApproved"));
        history.setReviewedByUserIdx(adminUserIdx);
        travelPackageMapper.insertPackageReviewHistory(history);
    }

    @Override
    @Transactional
    public void rejectPackageRevision(Long packageRevisionIdx, String rejectReason, Long adminUserIdx) {
        validateReviewer(adminUserIdx);
        String reason = trimToNull(rejectReason);
        if (reason == null) {
            throw new IllegalArgumentException(msg("package.error.rejectReasonRequired"));
        }
        if (reason.length() > 500) {
            throw new IllegalArgumentException(msg("package.error.rejectReasonTooLong"));
        }

        TravelPackageRevisionVO revision = getRevisionReviewTarget(packageRevisionIdx);
        int updated = travelPackageMapper.rejectPackageRevision(packageRevisionIdx, reason, adminUserIdx);
        if (updated == 0) {
            throw new IllegalStateException(msg("package.error.revisionPendingOnlyReject"));
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
    public List<TravelPackageVO> getApprovedPackages(String keyword, int page, int pageSize) {
        int safePage = Math.max(page, 1);
        int safePageSize = Math.max(pageSize, 1);
        int offset = (safePage - 1) * safePageSize;
        return travelPackageMapper.selectApprovedPackages(normalizeKeyword(keyword), offset, safePageSize);
    }

    @Override
    public int countApprovedPackages(String keyword) {
        return travelPackageMapper.countApprovedPackages(normalizeKeyword(keyword));
    }

    @Override
    public List<TravelPackageVO> getHomeRecommendedPackages() {
        return travelPackageMapper.selectHomeRecommendedPackages();
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
            throw new IllegalStateException(msg("package.error.loginRequired"));
        }

        long totalPrice = calculateTotalPrice(travelPackage.getPackagePrice(), peopleCount);
        long mileageAmount = request.getMileageAmount() != null ? request.getMileageAmount() : 0L;
        long maxMileageUse = floorToThousand(totalPrice * MAX_MILEAGE_RATE / 100);
        if (mileageAmount < 0) {
            throw new IllegalArgumentException(msg("package.error.mileageNegative"));
        }
        if (mileageAmount > maxMileageUse) {
            throw new IllegalArgumentException(msg("package.error.mileageLimit"));
        }
        if (user.getMileageBalance() < mileageAmount) {
            throw new IllegalStateException(msg("package.error.mileageInsufficient"));
        }

        long cashAmount = totalPrice - mileageAmount;
        if (user.getCashBalance() < cashAmount) {
            throw new IllegalStateException(msg("package.error.cashInsufficient"));
        }

        long cashAfter = user.getCashBalance() - cashAmount;
        long mileageAfter = user.getMileageBalance() - mileageAmount;
        walletMapper.updateWalletBalances(userIdx, cashAfter, mileageAfter);

        WalletPaymentDto payment = buildPackagePayment(userIdx, travelPackage, totalPrice, cashAmount, mileageAmount);
        walletMapper.insertPaymentHistory(payment);

        insertWalletHistory(userIdx, "CASH", cashAmount, cashAfter, payment.getPaymentIdx(),
                msg("package.history.cashPayment", travelPackage.getPackageTitle()));
        if (mileageAmount > 0) {
            insertWalletHistory(userIdx, "MILEAGE", mileageAmount, mileageAfter, payment.getPaymentIdx(),
                    msg("package.history.mileagePayment", travelPackage.getPackageTitle()));
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
            throw new IllegalStateException(msg("package.error.loginRequired"));
        }
        if (packageBookingIdx == null) {
            throw new IllegalArgumentException(msg("package.error.cancelInfoMissing"));
        }

        PackageBookingVO booking = travelPackageMapper.selectPackageBookingForUpdate(packageBookingIdx, userIdx);
        if (booking == null) {
            throw new IllegalArgumentException(msg("package.error.cancelNotFound"));
        }
        if (!"BOOKED".equals(booking.getBookingStatus())) {
            throw new IllegalStateException(msg("package.error.cancelOnlyBooked"));
        }

        UsersVO user = walletMapper.selectUserByIdxForUpdate(userIdx);
        if (user == null) {
            throw new IllegalStateException(msg("package.error.userNotFound"));
        }

        long cashAfter = safeAdd(user.getCashBalance(), booking.getUsedCash());
        long mileageAfter = safeAdd(user.getMileageBalance(), booking.getUsedMileage());
        walletMapper.updateWalletBalances(userIdx, cashAfter, mileageAfter);

        String reason = normalizeCancelReason(cancelReason);
        int updated = travelPackageMapper.cancelPackageBooking(packageBookingIdx, userIdx, reason);
        if (updated == 0) {
            throw new IllegalStateException(msg("package.error.cancelUnavailable"));
        }

        insertRefundWalletHistory(userIdx, "CASH", booking.getUsedCash(), cashAfter,
                msg("package.history.refundCash", booking.getBookingNo()));
        if (booking.getUsedMileage() > 0) {
            insertRefundWalletHistory(userIdx, "MILEAGE", booking.getUsedMileage(), mileageAfter,
                    msg("package.history.refundMileage", booking.getBookingNo()));
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
            throw new IllegalStateException(msg("package.error.pendingRevisionExists"));
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
            throw new IllegalArgumentException(msg("package.error.imageInvalidType"));
        }

        try {
            Path packageUploadDir = Path.of(System.getProperty("user.dir"), uploadPath, "package").normalize();
            Files.createDirectories(packageUploadDir);

            String savedFilename = UUID.randomUUID().toString().replace("-", "") + extension;
            Path targetPath = packageUploadDir.resolve(savedFilename).normalize();

            if (!targetPath.startsWith(packageUploadDir)) {
                throw new IllegalArgumentException(msg("package.error.filePathInvalid"));
            }

            imageFile.transferTo(targetPath);
            return "/upload/package/" + savedFilename;
        } catch (IOException e) {
            throw new IllegalStateException(msg("package.error.imageUploadFailed"));
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
            throw new IllegalStateException(msg("package.error.sellerRequired"));
        }
    }

    private void validateReviewer(Long adminUserIdx) {
        if (adminUserIdx == null) {
            throw new IllegalStateException(msg("package.error.adminRequired"));
        }
    }

    private TravelPackageVO getReviewTarget(Long packageIdx) {
        if (packageIdx == null) {
            throw new IllegalArgumentException(msg("package.error.reviewInfoMissing"));
        }
        TravelPackageVO currentPackage = travelPackageMapper.selectPackageForReview(packageIdx);
        if (currentPackage == null) {
            throw new IllegalArgumentException(msg("package.error.reviewNotFound"));
        }
        if (!STATUS_PENDING.equals(currentPackage.getPackageStatus())) {
            throw new IllegalStateException(msg("package.error.pendingOnlyReview"));
        }
        return currentPackage;
    }

    private TravelPackageRevisionVO getRevisionReviewTarget(Long packageRevisionIdx) {
        if (packageRevisionIdx == null) {
            throw new IllegalArgumentException(msg("package.error.revisionReviewInfoMissing"));
        }
        TravelPackageRevisionVO revision = travelPackageMapper.selectPackageRevisionForReview(packageRevisionIdx);
        if (revision == null) {
            throw new IllegalArgumentException(msg("package.error.revisionReviewNotFound"));
        }
        if (!STATUS_PENDING.equals(revision.getRevisionStatus())) {
            throw new IllegalStateException(msg("package.error.revisionPendingOnlyProcess"));
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
            throw new IllegalArgumentException(msg("package.error.formMissing"));
        }
        if (form.getSpotIdx() == null) {
            throw new IllegalArgumentException(msg("package.error.spotRequired"));
        }
        if (isBlank(form.getPackageTitle())) {
            throw new IllegalArgumentException(msg("package.error.titleRequired"));
        }
        if (trim(form.getPackageTitle()).length() > 150) {
            throw new IllegalArgumentException(msg("package.error.titleTooLong"));
        }
        if (form.getPackageSummary() != null && trim(form.getPackageSummary()).length() > 300) {
            throw new IllegalArgumentException(msg("package.error.summaryTooLong"));
        }
        if (isBlank(form.getPackageContent())) {
            throw new IllegalArgumentException(msg("package.error.contentRequired"));
        }
        if (form.getPackagePrice() == null || form.getPackagePrice() < 0) {
            throw new IllegalArgumentException(msg("package.error.priceInvalid"));
        }
        if (form.getMinPeople() == null || form.getMinPeople() < 1) {
            throw new IllegalArgumentException(msg("package.error.minPeopleInvalid"));
        }
        if (form.getMaxPeople() != null && form.getMaxPeople() < form.getMinPeople()) {
            throw new IllegalArgumentException(msg("package.error.maxPeopleInvalid"));
        }
        if (form.getStartDate() != null && form.getEndDate() != null && form.getEndDate().isBefore(form.getStartDate())) {
            throw new IllegalArgumentException(msg("package.error.endBeforeStart"));
        }
    }

    private void validateBookingRequest(Long userIdx, PackageBookingRequestVO request) {
        if (userIdx == null) {
            throw new IllegalStateException(msg("package.error.loginRequired"));
        }
        if (request == null || request.getPackageIdx() == null) {
            throw new IllegalArgumentException(msg("package.error.bookingInfoMissing"));
        }
        if (request.getPeopleCount() == null) {
            throw new IllegalArgumentException(msg("package.error.peopleRequired"));
        }
    }

    private void validatePeopleCount(TravelPackageVO travelPackage, int peopleCount) {
        int minPeople = travelPackage.getMinPeople() != null ? travelPackage.getMinPeople() : 1;
        Integer maxPeople = travelPackage.getMaxPeople();
        if (peopleCount < minPeople) {
            throw new IllegalArgumentException(msg("package.error.peopleMin", minPeople));
        }
        if (maxPeople != null && peopleCount > maxPeople) {
            throw new IllegalArgumentException(msg("package.error.peopleMax", maxPeople));
        }
    }

    private long calculateTotalPrice(Long unitPrice, int peopleCount) {
        if (unitPrice == null || unitPrice < 0) {
            throw new IllegalStateException(msg("package.error.priceInfoInvalid"));
        }
        try {
            return Math.multiplyExact(unitPrice, peopleCount);
        } catch (ArithmeticException e) {
            throw new IllegalArgumentException(msg("package.error.amountTooLarge"));
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
        payment.setOrderName(msg("package.payment.orderName", travelPackage.getPackageTitle()));
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
            throw new IllegalStateException(msg("package.error.refundBalanceTooLarge"));
        }
    }

    private String normalizeCancelReason(String cancelReason) {
        String reason = trimToNull(cancelReason);
        if (reason == null) {
            return msg("package.history.defaultCancelReason");
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

    private String normalizeKeyword(String keyword) {
        return trimToNull(keyword);
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

    private String msg(String code, Object... args) {
        return messageSource.getMessage(code, args, code, LocaleContextHolder.getLocale());
    }
}
