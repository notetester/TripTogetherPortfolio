package org.triptogether.travelPackage.vo;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * TRAVEL_PACKAGE 테이블의 패키지 상품 정보를 담는 VO.
 *
 * <p>패키지는 BUSINESS/PARTNER 회원이 등록하고, 관리자가 승인한 뒤 사용자에게 노출하는 구조다.
 * 이번 1차 구현에서는 등록자 본인의 임시저장/승인요청 관리까지만 담당한다.</p>
 */
@Data
public class TravelPackageVO {

    private Long packageIdx;
    private Long sellerUserIdx;
    private Long spotIdx;

    private String packageTitle;
    private String packageSummary;
    private String packageContent;
    private Long packagePrice;
    private String currencyCode;

    private LocalDate startDate;
    private LocalDate endDate;
    private Integer minPeople;
    private Integer maxPeople;

    private String packageStatus;
    private String rejectReason;
    private String mainImagePath;

    private Integer viewCount;
    private Integer likeCount;
    private Integer bookingCount;

    private Long approvedByUserIdx;
    private LocalDateTime approvedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    /** 목록 화면 표시용 조인 컬럼 */
    private String spotName;
    private String spotRegion;
    private String sellerNickname;
}
