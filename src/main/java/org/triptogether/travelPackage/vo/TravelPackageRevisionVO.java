package org.triptogether.travelPackage.vo;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 승인된 패키지 상품의 수정 요청본을 담는 VO.
 *
 * <p>APPROVED 원본은 사용자에게 계속 노출하고, 판매자가 바꾸려는 내용은 이 객체로
 * TRAVEL_PACKAGE_REVISION에 저장한다. 관리자가 승인한 순간에만 원본 TRAVEL_PACKAGE로 반영된다.</p>
 */
@Data
public class TravelPackageRevisionVO {

    private Long packageRevisionIdx;
    private Long packageIdx;
    private Long sellerUserIdx;

    private String packageTitle;
    private String packageSummary;
    private String packageContent;
    private Long packagePrice;
    private String currencyCode;
    private LocalDate startDate;
    private LocalDate endDate;
    private Integer minPeople;
    private Integer maxPeople;
    private String mainImagePath;

    private String revisionStatus;
    private String rejectReason;
    private LocalDateTime requestedAt;
    private Long reviewedByUserIdx;
    private LocalDateTime reviewedAt;

    /** 관리자/판매자 화면 표시용 조인 컬럼 */
    private String currentPackageTitle;
    private String spotName;
    private String spotRegion;
    private String sellerNickname;
}
