package org.triptogether.admin.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * BUSINESS_ACCOUNT_APPLICATION 테이블 VO.
 *
 * <p>일반 회원이 비즈니스/파트너 권한을 요청하고,
 * 관리자가 승인/반려하는 흐름에서 공통으로 사용한다.</p>
 */
@Data
public class BusinessAccountApplicationVO {

    private Long applicationIdx;
    private Long userIdx;
    private String requestedRole;
    private String companyName;
    private String businessNumber;
    private String managerName;
    private String managerPhone;
    private String description;
    private String applicationStatus;
    private String rejectReason;
    private Long reviewedByUserIdx;
    private LocalDateTime reviewedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private String userId;
    private String nickname;
    private String userEmail;
    private String currentUserRole;
    private String reviewerNickname;

    public Date getReviewedAtDate() {
        return toDate(reviewedAt);
    }

    public Date getCreatedAtDate() {
        return toDate(createdAt);
    }

    public Date getUpdatedAtDate() {
        return toDate(updatedAt);
    }

    private Date toDate(LocalDateTime value) {
        if (value == null) return null;
        return Date.from(value.atZone(ZoneId.systemDefault()).toInstant());
    }
}
