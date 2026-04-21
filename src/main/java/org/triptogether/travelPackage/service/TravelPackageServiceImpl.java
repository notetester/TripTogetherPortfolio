package org.triptogether.travelPackage.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.travelPackage.mapper.TravelPackageMapper;
import org.triptogether.travelPackage.vo.PackageSpotOptionVO;
import org.triptogether.travelPackage.vo.TravelPackageForm;
import org.triptogether.travelPackage.vo.TravelPackageVO;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TravelPackageServiceImpl implements TravelPackageService {

    private static final String STATUS_DRAFT = "DRAFT";
    private static final String STATUS_PENDING = "PENDING";

    private final TravelPackageMapper travelPackageMapper;

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

        TravelPackageVO travelPackage = toVO(form);
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

        TravelPackageVO travelPackage = toVO(form);
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

    private TravelPackageVO toVO(TravelPackageForm form) {
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
        travelPackage.setMainImagePath(trimToNull(form.getMainImagePath()));
        return travelPackage;
    }

    private void validateSeller(Long sellerUserIdx) {
        if (sellerUserIdx == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }
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
