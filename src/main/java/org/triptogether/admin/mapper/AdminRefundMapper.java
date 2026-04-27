package org.triptogether.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.triptogether.myPage.vo.WalletPaymentDto;
import org.triptogether.myPage.vo.WalletRefundLogVO;

import java.util.List;

/**
 * 어드민 환불 처리 매퍼.
 *
 * <p>{@link AdminFinanceMapper} 와 분리한 이유: read-only / 운영성 쓰기 권한 경계 명확화.</p>
 */
@Mapper
public interface AdminRefundMapper {

    /** 환불 가능 결제 후보 (CHARGE / COMPLETED) */
    List<WalletPaymentDto> selectRefundCandidates(@Param("keyword") String keyword);

    /** paymentIdx 단건 조회 (환불 처리용) */
    WalletPaymentDto selectPaymentForRefund(@Param("paymentIdx") Long paymentIdx);

    /** 결제 상태 → REFUNDED 갱신 + cancelled_at 기록 */
    int markPaymentRefunded(@Param("paymentIdx") Long paymentIdx);

    /** 회원 cash_balance 차감 */
    int decreaseCashBalance(@Param("userIdx") Long userIdx,
                            @Param("amount") long amount);

    /** USER_WALLET_HISTORY 에 REFUND 변동 기록 */
    int insertWalletHistoryRefund(@Param("userIdx") Long userIdx,
                                  @Param("amount") long amount,
                                  @Param("balanceAfter") long balanceAfter,
                                  @Param("relatedPaymentIdx") Long relatedPaymentIdx,
                                  @Param("detailMessage") String detailMessage,
                                  @Param("actorUserIdx") Long actorUserIdx);

    /** WALLET_REFUND_LOG audit 추가 */
    int insertRefundLog(WalletRefundLogVO log);

    /** 환불 audit 로그 조회 (최근 순) */
    List<WalletRefundLogVO> selectRecentRefundLogs(@Param("limit") int limit);
}
