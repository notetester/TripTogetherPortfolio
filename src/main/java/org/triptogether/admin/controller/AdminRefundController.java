package org.triptogether.admin.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.admin.service.AdminRefundService;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.vo.WalletRefundLogVO;

/**
 * 어드민 — 결제 환불 처리 (FINANCE_OPERATOR 권한).
 *
 * <ul>
 *     <li>GET  /admin/finance/refund                 — 환불 후보 목록 + 최근 audit 로그</li>
 *     <li>POST /admin/finance/refund/{paymentIdx}    — 환불 실행</li>
 * </ul>
 */
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/finance/refund")
public class AdminRefundController {

    private final AdminRefundService refundService;

    @GetMapping
    public String refundHome(@RequestParam(required = false) String keyword, Model model) {
        model.addAttribute("activeMenu", "finance");
        model.addAttribute("section", "refund");
        model.addAttribute("keyword", keyword);
        model.addAttribute("candidates", refundService.getRefundCandidates(keyword));
        model.addAttribute("recentLogs", refundService.getRecentRefundLogs(30));
        return "admin/finance/refund";
    }

    @PostMapping("/{paymentIdx}")
    public String doRefund(@PathVariable Long paymentIdx,
                           @RequestParam String reason,
                           HttpSession session,
                           RedirectAttributes ra) {
        UsersVO admin = (UsersVO) session.getAttribute("loginUser");
        if (admin == null) return "redirect:/auth/login";

        try {
            WalletRefundLogVO logEntry = refundService.refundPayment(paymentIdx, reason, admin.getUserIdx());
            ra.addFlashAttribute("refundMessage",
                    "환불 완료 — paymentIdx=" + paymentIdx
                            + " / 금액 " + logEntry.getRefundAmount() + "원");
        } catch (IllegalArgumentException | IllegalStateException e) {
            log.warn("[AdminRefundController] 환불 실패 - paymentIdx={}, by={}, msg={}",
                    paymentIdx, admin.getUserIdx(), e.getMessage());
            ra.addFlashAttribute("refundError", e.getMessage());
        } catch (Exception e) {
            log.error("[AdminRefundController] 환불 처리 중 예외 - paymentIdx={}", paymentIdx, e);
            ra.addFlashAttribute("refundError", "환불 처리 중 오류: " + e.getMessage());
        }
        return "redirect:/admin/finance/refund";
    }
}
