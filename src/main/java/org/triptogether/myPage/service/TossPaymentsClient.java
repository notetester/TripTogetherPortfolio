package org.triptogether.myPage.service;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;
import org.triptogether.myPage.vo.TossPaymentConfirmResponse;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;

/**
 * Toss Payments 결제 승인 / 취소 API 를 호출하는 얇은 클라이언트.
 */
@Component
@RequiredArgsConstructor
public class TossPaymentsClient {

    private static final String CONFIRM_URL = "https://api.tosspayments.com/v1/payments/confirm";
    private static final String CANCEL_URL_TEMPLATE = "https://api.tosspayments.com/v1/payments/%s/cancel";

    private final RestTemplate restTemplate;

    @Value("${toss.payments.secret-key:}")
    private String secretKey;

    public TossPaymentConfirmResponse confirmPayment(String paymentKey,
                                                     String orderId,
                                                     long amount,
                                                     Locale locale) {
        if (secretKey == null || secretKey.isBlank()) {
            throw new IllegalStateException("Toss Payments secret key is not configured.");
        }

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("paymentKey", paymentKey);
        body.put("orderId", orderId);
        body.put("amount", amount);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set(HttpHeaders.AUTHORIZATION, "Basic " + encodeSecretKey(secretKey));
        if (locale != null) {
            headers.set(HttpHeaders.ACCEPT_LANGUAGE, locale.toLanguageTag());
        }

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);
        try {
            return restTemplate.postForObject(CONFIRM_URL, entity, TossPaymentConfirmResponse.class);
        } catch (HttpStatusCodeException e) {
            throw new IllegalStateException(extractMessage(e), e);
        }
    }

    /**
     * 결제 취소 (전액 환불).
     * @param paymentKey   토스 결제 키 (USER_PAYMENT_HISTORY.toss_payment_key)
     * @param cancelReason 어드민이 입력한 환불 사유
     */
    public void cancelPayment(String paymentKey, String cancelReason) {
        if (secretKey == null || secretKey.isBlank()) {
            throw new IllegalStateException("Toss Payments secret key is not configured.");
        }
        if (paymentKey == null || paymentKey.isBlank()) {
            throw new IllegalArgumentException("paymentKey is required for cancel.");
        }

        String url = String.format(CANCEL_URL_TEMPLATE, paymentKey);

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("cancelReason", cancelReason == null || cancelReason.isBlank() ? "Admin refund" : cancelReason);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set(HttpHeaders.AUTHORIZATION, "Basic " + encodeSecretKey(secretKey));

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);
        try {
            restTemplate.postForObject(url, entity, Map.class);
        } catch (HttpStatusCodeException e) {
            throw new IllegalStateException(extractMessage(e), e);
        }
    }

    private String encodeSecretKey(String secretKey) {
        return Base64.getEncoder().encodeToString((secretKey + ":").getBytes(StandardCharsets.UTF_8));
    }

    private String extractMessage(HttpStatusCodeException e) {
        String response = e.getResponseBodyAsString();
        if (response == null || response.isBlank()) {
            return "Toss Payments confirmation failed.";
        }
        return response;
    }
}
