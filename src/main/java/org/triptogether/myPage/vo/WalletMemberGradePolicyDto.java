package org.triptogether.myPage.vo;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

/**
 * 내 지갑 화면에서 회원 등급 정책 표를 출력할 때 사용하는 DTO입니다.
 * MEMBER_GRADE_POLICY의 사용자 표시용 컬럼만 담습니다.
 */
@Getter
@Setter
public class WalletMemberGradePolicyDto {

    private Long memberGradeIdx;
    private String policyName;
    private String memberGrade;
    private Long minMonthlyPayment;
    private BigDecimal discountRate;
    private Integer sortOrder;
    private Boolean active;
    private String description;
    private Integer priority;
}
