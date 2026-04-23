package org.triptogether.myPage.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.myPage.service.WalletService;
import org.triptogether.myPage.vo.WalletChargeResultDto;

@Controller
@RequiredArgsConstructor
@RequestMapping("/wallet")
public class WalletController {

    private final WalletService walletService;

    @GetMapping("")
    public String walletPage(HttpSession session, Model model) {
        UsersVO user = loginUser(session);
        if (user == null) {
            return "redirect:/auth/login";
        }

        UsersVO freshUser = walletService.getWalletUser(user.getUserIdx());
        if (freshUser == null) {
            session.invalidate();
            return "redirect:/auth/login";
        }

        session.setAttribute("loginUser", freshUser);
        model.addAttribute("user", freshUser);
        model.addAttribute("paymentHistory", walletService.getRecentPaymentHistory(freshUser.getUserIdx()));
        model.addAttribute("walletHistory", walletService.getRecentWalletHistory(freshUser.getUserIdx()));
        model.addAttribute("gradePolicies", walletService.getActiveMemberGradePolicies());
        return "wallet/index";
    }

    @PostMapping("/charge")
    public String simulateCharge(@RequestParam String amount,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        UsersVO user = loginUser(session);
        if (user == null) {
            return "redirect:/auth/login";
        }

        try {
            long chargeAmount = parseChargeAmount(amount);
            WalletChargeResultDto result = walletService.simulateCashCharge(user.getUserIdx(), chargeAmount);
            session.setAttribute("loginUser", result.getUser());
            redirectAttributes.addFlashAttribute(
                    "walletMessage",
                    String.format("캐시 %,d원이 충전되었고 마일리지 %,d원이 적립되었습니다.",
                            result.getChargedCash(),
                            result.getEarnedMileage())
            );
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("walletError", e.getMessage());
        }

        return "redirect:/wallet";
    }

    /**
     * 충전 금액은 브라우저에서 number input으로 받더라도 요청값은 조작될 수 있습니다.
     * long으로 바로 바인딩하면 Long 범위를 넘는 값에서 컨트롤러 진입 전에 변환 오류가 발생할 수 있으므로,
     * 문자열로 받은 뒤 직접 검증해서 Whitelabel 대신 지갑 화면 오류 메시지로 돌려줍니다.
     */
    private long parseChargeAmount(String rawAmount) {
        if (rawAmount == null || rawAmount.isBlank()) {
            throw new IllegalArgumentException("충전 금액을 입력해주세요.");
        }

        String normalizedAmount = rawAmount.trim();
        if (!normalizedAmount.matches("\\d+")) {
            throw new IllegalArgumentException("충전 금액은 숫자로만 입력해주세요.");
        }

        try {
            return Long.parseLong(normalizedAmount);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("1회 충전 한도는 1,000,000원입니다.");
        }
    }

    private UsersVO loginUser(HttpSession session) {
        return (UsersVO) session.getAttribute("loginUser");
    }
}
