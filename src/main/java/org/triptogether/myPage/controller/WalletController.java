package org.triptogether.myPage.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
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

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
@RequestMapping("/wallet")
public class WalletController {

    private static final String TOSS_PENDING_SESSION_KEY = "walletTossPendingCharges";
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
                    String.format("캐시 %,d원이 충전되었고 마일리지 %,d원이 적립되었습니다.",
                            result.getChargedCash(),
                            result.getEarnedMileage())
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

        long chargeAmount = parseChargeAmount(amount);
        WalletTossChargeRequestDto request = buildTossChargeRequest(session, user.getUserIdx(), chargeAmount);
        return ResponseEntity.ok(request);
    }

    @GetMapping("/charge/success")
    public String tossChargeSuccess(@RequestParam String paymentKey,
                                    @RequestParam String orderId,
                                    @RequestParam long amount,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        UsersVO user = loginUser(session);
        if (user == null) {
            return "redirect:/auth/login";
        }

        try {
            WalletTossChargeRequestDto request = takePendingTossCharge(session, orderId);
            if (request == null) {
                throw new IllegalStateException("결제 요청 정보를 찾을 수 없습니다.");
            }
            if (request.getAmount() != amount) {
                throw new IllegalStateException("결제 금액이 요청 금액과 일치하지 않습니다.");
            }

            WalletChargeResultDto result = walletService.completeTossCharge(user.getUserIdx(), request, paymentKey);
            session.setAttribute("loginUser", result.getUser());
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
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        if (orderId != null && !orderId.isBlank()) {
            removePendingTossCharge(session, orderId);
        }

        if (message != null && !message.isBlank()) {
            redirectAttributes.addFlashAttribute("walletError", message);
        } else if (errorCode != null && !errorCode.isBlank()) {
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

    private WalletTossChargeRequestDto buildTossChargeRequest(HttpSession session,
                                                              Long userIdx,
                                                              long amount) {
        WalletTossChargeRequestDto request = new WalletTossChargeRequestDto();
        request.setUserIdx(userIdx);
        request.setAmount(amount);
        request.setOrderId("WALLET-" + UUID.randomUUID().toString().replace("-", "").toUpperCase(Locale.ROOT));
        request.setOrderName("캐시 충전");
        request.setCustomerKey(getOrCreateTossCustomerKey(session, userIdx));
        request.setSuccessUrl(appBaseUrl + "/wallet/charge/success");
        request.setFailUrl(appBaseUrl + "/wallet/charge/fail");
        request.setCreatedAt(LocalDateTime.now());

        Map<String, WalletTossChargeRequestDto> pending = getPendingTossChargeMap(session);
        pending.put(request.getOrderId(), request);
        session.setAttribute(TOSS_PENDING_SESSION_KEY, pending);
        return request;
    }

    private WalletTossChargeRequestDto takePendingTossCharge(HttpSession session, String orderId) {
        Map<String, WalletTossChargeRequestDto> pending = getPendingTossChargeMap(session);
        WalletTossChargeRequestDto request = pending.remove(orderId);
        session.setAttribute(TOSS_PENDING_SESSION_KEY, pending);
        return request;
    }

    private void removePendingTossCharge(HttpSession session, String orderId) {
        Map<String, WalletTossChargeRequestDto> pending = getPendingTossChargeMap(session);
        pending.remove(orderId);
        session.setAttribute(TOSS_PENDING_SESSION_KEY, pending);
    }

    @SuppressWarnings("unchecked")
    private Map<String, WalletTossChargeRequestDto> getPendingTossChargeMap(HttpSession session) {
        Object value = session.getAttribute(TOSS_PENDING_SESSION_KEY);
        if (value instanceof Map<?, ?> map) {
            Map<String, WalletTossChargeRequestDto> typed = new HashMap<>();
            for (Map.Entry<?, ?> entry : map.entrySet()) {
                if (entry.getKey() instanceof String key && entry.getValue() instanceof WalletTossChargeRequestDto dto) {
                    typed.put(key, dto);
                }
            }
            return typed;
        }
        return new HashMap<>();
    }
}
