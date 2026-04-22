package org.triptogether.travelPackage.vo;

import lombok.Data;

/**
 * TRAVEL_PACKAGE_REVIEW_HISTORY 저장용 DTO.
 *
 * <p>관리자가 패키지를 승인/반려할 때 이전 상태와 변경 상태를 남겨
 * 나중에 "누가, 언제, 왜 처리했는지"를 추적할 수 있게 한다.</p>
 */
@Data
public class PackageReviewHistoryCreateVO {
    private Long packageIdx;
    private String previousStatus;
    private String newStatus;
    private String reviewReason;
    private Long reviewedByUserIdx;
}
