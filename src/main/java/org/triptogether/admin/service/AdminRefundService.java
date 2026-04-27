package org.triptogether.admin.service;

import org.triptogether.myPage.vo.WalletPaymentDto;
import org.triptogether.myPage.vo.WalletRefundLogVO;

import java.util.List;

/**
 * 어드민 환불 처리 서비스 (FINANCE_OPERATOR 권한 영역).
 *
 * <p>WalletService 본 코드는 변경하지 않고, TossPaymentsClient.cancelPayment 만 추가 호출한다.
 * 환불 audit 은 WALLET_REFUND_LOG 에 별도 기록.</p>
 */
public interface AdminRefundService {

    /** 환불 후보 결제 목록 (CHARGE / COMPLETED) */
    List<WalletPaymentDto> getRefundCandidates(String keyword);

    /**
     * 결제를 전액 환불한다.
     *
     * <ol>
     *     <li>결제 조회 (status, type 검증)</li>
     *     <li>토스 결제 취소 호출 (tossPaymentKey 가 있을 때만)</li>
     *     <li>USER_PAYMENT_HISTORY status → REFUNDED</li>
     *     <li>USERS.cash_balance 차감 + USER_WALLET_HISTORY 변동 행 추가</li>
     *     <li>WALLET_REFUND_LOG audit 추가</li>
     * </ol>
     *
     * @return 생성된 환불 audit 로그
     */
    WalletRefundLogVO refundPayment(Long paymentIdx, String reason, Long adminUserIdx);

    /** 최근 환불 audit 로그 (대시보드용) */
    List<WalletRefundLogVO> getRecentRefundLogs(int limit);
}
