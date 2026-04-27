package org.triptogether.admin.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.admin.mapper.AdminRefundMapper;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.mapper.WalletMapper;
import org.triptogether.myPage.service.TossPaymentsClient;
import org.triptogether.myPage.vo.WalletPaymentDto;
import org.triptogether.myPage.vo.WalletRefundLogVO;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class AdminRefundServiceImpl implements AdminRefundService {

    private final AdminRefundMapper refundMapper;
    private final WalletMapper walletMapper;
    private final TossPaymentsClient tossPaymentsClient;

    @Override
    public List<WalletPaymentDto> getRefundCandidates(String keyword) {
        return refundMapper.selectRefundCandidates(keyword);
    }

    @Override
    @Transactional
    public WalletRefundLogVO refundPayment(Long paymentIdx, String reason, Long adminUserIdx) {
        if (paymentIdx == null) throw new IllegalArgumentException("paymentIdx required");
        if (adminUserIdx == null) throw new IllegalArgumentException("adminUserIdx required");
        if (reason == null || reason.isBlank()) {
            throw new IllegalArgumentException("환불 사유는 필수입니다.");
        }

        WalletPaymentDto payment = refundMapper.selectPaymentForRefund(paymentIdx);
        if (payment == null) {
            throw new IllegalStateException("결제 이력을 찾을 수 없습니다. paymentIdx=" + paymentIdx);
        }
        if (!"CHARGE".equals(payment.getPaymentType())) {
            throw new IllegalStateException("충전 결제만 환불할 수 있습니다.");
        }
        if (!"COMPLETED".equals(payment.getPaymentStatus())) {
            throw new IllegalStateException("이미 환불되었거나 완료되지 않은 결제입니다. status=" + payment.getPaymentStatus());
        }

        long refundAmount = payment.getFinalAmount();
        String tossCancelStatus = null;

        // 1) 토스 결제 취소 (실결제만)
        if (payment.getTossPaymentKey() != null && !payment.getTossPaymentKey().isBlank()) {
            try {
                tossPaymentsClient.cancelPayment(payment.getTossPaymentKey(), reason);
                tossCancelStatus = "CANCELED";
            } catch (Exception e) {
                log.error("[AdminRefundService] 토스 취소 실패 - paymentIdx={}, paymentKey={}",
                        paymentIdx, payment.getTossPaymentKey(), e);
                throw new IllegalStateException("토스 결제 취소 실패: " + e.getMessage(), e);
            }
        } else {
            tossCancelStatus = "SKIPPED_NON_TOSS";
        }

        // 2) 결제 상태 갱신
        int updated = refundMapper.markPaymentRefunded(paymentIdx);
        if (updated == 0) {
            throw new IllegalStateException("결제 상태 갱신 실패 (이미 환불되었을 수 있음)");
        }

        // 3) 잔액 차감 + 변동 이력
        refundMapper.decreaseCashBalance(payment.getUserIdx(), refundAmount);
        UsersVO user = walletMapper.selectUserByIdx(payment.getUserIdx());
        long balanceAfter = user != null ? user.getCashBalance() : 0L;

        refundMapper.insertWalletHistoryRefund(
                payment.getUserIdx(),
                -refundAmount,
                balanceAfter,
                payment.getPaymentIdx(),
                "어드민 환불: " + reason,
                adminUserIdx
        );

        // 4) audit 로그
        WalletRefundLogVO logEntry = WalletRefundLogVO.builder()
                .paymentIdx(payment.getPaymentIdx())
                .userIdx(payment.getUserIdx())
                .refundAmount(refundAmount)
                .refundReason(reason)
                .tossCancelStatus(tossCancelStatus)
                .refundedByUserIdx(adminUserIdx)
                .build();
        refundMapper.insertRefundLog(logEntry);

        log.info("[AdminRefundService] 환불 완료 - paymentIdx={}, userIdx={}, amount={}, by adminIdx={}",
                paymentIdx, payment.getUserIdx(), refundAmount, adminUserIdx);

        return logEntry;
    }

    @Override
    public List<WalletRefundLogVO> getRecentRefundLogs(int limit) {
        return refundMapper.selectRecentRefundLogs(limit > 0 ? limit : 30);
    }
}
