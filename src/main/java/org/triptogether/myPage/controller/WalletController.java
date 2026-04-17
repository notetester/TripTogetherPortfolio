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
        return "wallet/index";
    }

    @PostMapping("/charge")
    public String simulateCharge(@RequestParam long amount,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        UsersVO user = loginUser(session);
        if (user == null) {
            return "redirect:/auth/login";
        }

        try {
            WalletChargeResultDto result = walletService.simulateCashCharge(user.getUserIdx(), amount);
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

    private UsersVO loginUser(HttpSession session) {
        return (UsersVO) session.getAttribute("loginUser");
    }
}
