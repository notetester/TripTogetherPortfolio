package org.triptogether.myPage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.myPage.vo.WalletMemberGradePolicyDto;
import org.triptogether.myPage.vo.WalletPaymentDto;

import java.util.List;

@Mapper
public interface WalletMapper {

    UsersVO selectUserByIdx(@Param("userIdx") Long userIdx);

    UsersVO selectUserByIdxForUpdate(@Param("userIdx") Long userIdx);

    void updateWalletBalances(@Param("userIdx") Long userIdx,
                              @Param("cashBalance") long cashBalance,
                              @Param("mileageBalance") long mileageBalance);

    void insertPaymentHistory(WalletPaymentDto payment);

    void insertWalletHistory(WalletHistoryDto history);

    List<WalletPaymentDto> selectRecentPaymentHistory(@Param("userIdx") Long userIdx);

    List<WalletHistoryDto> selectRecentWalletHistory(@Param("userIdx") Long userIdx);

    List<WalletMemberGradePolicyDto> selectActiveMemberGradePolicies();

    /**
     * 특정 유저의 직전 달(현재 기준) COMPLETED 결제 총액을 조회합니다.
     * 등급 재산정 시 사용됩니다.
     */
    long selectLastMonthPaymentTotal(@Param("userIdx") Long userIdx);

    /**
     * 특정 유저의 당월 COMPLETED 결제 총액을 조회합니다.
     * 마이페이지 등급 바에서 "이번 달 결제 → 다음 달 예상 등급" 표시에 사용됩니다.
     */
    long selectCurrentMonthPaymentTotal(@Param("userIdx") Long userIdx);

    /**
     * 유저의 회원 등급(member_grade)을 갱신합니다.
     */
    void updateMemberGrade(@Param("userIdx") Long userIdx,
                           @Param("memberGrade") String memberGrade);

    /**
     * 등급 변경 이력(USER_GRADE_HISTORY)을 저장합니다.
     */
    void insertGradeHistory(@Param("userIdx") Long userIdx,
                            @Param("baseYearMonth") String baseYearMonth,
                            @Param("prevGrade") String prevGrade,
                            @Param("newGrade") String newGrade,
                            @Param("monthlyPaidAmount") long monthlyPaidAmount,
                            @Param("appliedDiscountRate") java.math.BigDecimal appliedDiscountRate);
}
