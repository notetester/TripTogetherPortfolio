package org.triptogether.myPage.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.explore.service.SpotTextTranslationService;
import org.triptogether.myPage.service.WalletService;
import org.triptogether.myPage.vo.WalletChargeResultDto;
import org.triptogether.myPage.vo.WalletHistoryDto;
import org.triptogether.myPage.vo.WalletTossChargeRequestDto;

import java.util.List;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
@RequestMapping("/wallet")
public class WalletController {

    private static final long MANUAL_CHARGE_MAX = 1_000_000L;

    private final WalletService walletService;
    private final SpotTextTranslationService translationService;
    private final MessageSource messageSource;

    @Value("${app.base-url}")
    private String appBaseUrl;

    @Value("${toss.payments.client-key:}")
    private String tossClientKey;

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
        List<WalletHistoryDto> walletHistory = walletService.getRecentWalletHistory(freshUser.getUserIdx());
        translationService.translateWalletHistories(walletHistory);

        model.addAttribute("user", freshUser);
        model.addAttribute("paymentHistory", walletService.getRecentPaymentHistory(freshUser.getUserIdx()));
        model.addAttribute("walletHistory", walletHistory);
        model.addAttribute("gradePolicies", walletService.getActiveMemberGradePolicies());
        model.addAttribute("tossEnabled", hasText(tossClientKey));
        model.addAttribute("tossClientKey", tossClientKey);
        model.addAttribute("tossSuccessUrl", appBaseUrl + "/wallet/charge/success");
        model.addAttribute("tossFailUrl", appBaseUrl + "/wallet/charge/fail");
        model.addAttribute("tossCustomerKey", getOrCreateTossCustomerKey(session, freshUser.getUserIdx()));
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
                    messageSource.getMessage(
                            "wallet.charge.manual.success",
                            new Object[]{result.getChargedCash(), result.getEarnedMileage()},
                            LocaleContextHolder.getLocale()
                    )
            );
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("walletError", e.getMessage());
        }

        return "redirect:/wallet";
    }

    @PostMapping("/charge/prepare")
    @ResponseBody
    public ResponseEntity<WalletTossChargeRequestDto> prepareCharge(@RequestParam String amount,
                                                                    HttpSession session) {
        UsersVO user = loginUser(session);
        if (user == null) {
            return ResponseEntity.status(401).build();
        }
        if (!hasText(tossClientKey)) {
            return ResponseEntity.status(503).build();
        }

        try {
            long chargeAmount = parseChargeAmount(amount);
            WalletTossChargeRequestDto request = walletService.prepareTossCharge(
                    user.getUserIdx(),
                    chargeAmount,
                    getOrCreateTossCustomerKey(session, user.getUserIdx()),
                    appBaseUrl + "/wallet/charge/success",
                    appBaseUrl + "/wallet/charge/fail",
                    LocaleContextHolder.getLocale()
            );
            return ResponseEntity.ok(request);
        } catch (IllegalArgumentException | IllegalStateException e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/charge/success")
    public String tossChargeSuccess(@RequestParam String paymentKey,
                                    @RequestParam String orderId,
                                    @RequestParam long amount,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        try {
            WalletChargeResultDto result = walletService.completeTossCharge(orderId, amount, paymentKey);

            UsersVO loginUser = loginUser(session);
            if (loginUser != null && loginUser.getUserIdx().equals(result.getUser().getUserIdx())) {
                session.setAttribute("loginUser", result.getUser());
            }

            redirectAttributes.addFlashAttribute(
                    "walletMessage",
                    messageSource.getMessage(
                            "wallet.charge.toss.success",
                            new Object[]{result.getChargedCash(), result.getEarnedMileage()},
                            LocaleContextHolder.getLocale()
                    )
            );
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("walletError", e.getMessage());
        }

        return "redirect:/wallet";
    }

    @GetMapping("/charge/fail")
    public String tossChargeFail(@RequestParam(required = false) String errorCode,
                                 @RequestParam(required = false) String message,
                                 @RequestParam(required = false) String orderId,
                                 RedirectAttributes redirectAttributes) {
        if (hasText(orderId)) {
            walletService.cancelPendingTossCharge(orderId);
        }

        if (hasText(message)) {
            redirectAttributes.addFlashAttribute("walletError", message);
        } else if (hasText(errorCode)) {
            redirectAttributes.addFlashAttribute("walletError", errorCode);
        } else {
            redirectAttributes.addFlashAttribute(
                    "walletError",
                    messageSource.getMessage("wallet.charge.toss.fail", null, LocaleContextHolder.getLocale())
            );
        }
        return "redirect:/wallet";
    }

    /**
     * 브라우저 number input은 클라이언트 검증을 우회할 수 있으므로 서버에서 한 번 더 검증한다.
     * 문자열로 먼저 받아야 너무 큰 값이 들어와도 Whitelabel 대신 안내 메시지로 처리할 수 있다.
     */
    private long parseChargeAmount(String rawAmount) {
        if (!hasText(rawAmount)) {
            throw new IllegalArgumentException(messageSource.getMessage(
                    "wallet.charge.error.required",
                    null,
                    LocaleContextHolder.getLocale()
            ));
        }

        String normalizedAmount = rawAmount.trim();
        if (!normalizedAmount.matches("\\d+")) {
            throw new IllegalArgumentException(messageSource.getMessage(
                    "wallet.charge.error.numberOnly",
                    null,
                    LocaleContextHolder.getLocale()
            ));
        }

        try {
            return Long.parseLong(normalizedAmount);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(messageSource.getMessage(
                    "wallet.charge.limitMessage",
                    null,
                    LocaleContextHolder.getLocale()
            ));
        }
    }

    private UsersVO loginUser(HttpSession session) {
        return (UsersVO) session.getAttribute("loginUser");
    }

    private boolean hasText(String value) {
        return value != null && !value.isBlank();
    }

    private String getOrCreateTossCustomerKey(HttpSession session, Long userIdx) {
        String key = (String) session.getAttribute("walletTossCustomerKey");
        if (!hasText(key)) {
            key = "wallet-" + userIdx + "-" + UUID.randomUUID();
            session.setAttribute("walletTossCustomerKey", key);
        }
        return key;
    }
}
