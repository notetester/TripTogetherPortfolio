package org.triptogether.auth.risk;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityWafSyncQueueVO;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.LinkedHashMap;
import java.util.Map;

@Slf4j
@Component
@RequiredArgsConstructor
public class WafSyncHttpClient {

    private final SecurityProviderSecretResolver secretResolver;
    private final ObjectMapper objectMapper;

    public WafSyncResult call(SecurityAssessmentProviderConfigVO provider, SecurityWafSyncQueueVO item) {
        try {
            Map<String, Object> payload = new LinkedHashMap<>();
            payload.put("providerCode", provider.getProviderCode());
            payload.put("providerKind", provider.getProviderKind());
            payload.put("syncIdx", item.getSyncIdx());
            payload.put("sourceType", item.getSourceType());
            payload.put("sourceId", item.getSourceId());
            payload.put("syncAction", item.getSyncAction());
            payload.put("targetType", item.getTargetType());
            payload.put("targetValue", item.getTargetValue());

            String apiKey = secretResolver.resolve(provider.getApiKeyRef());
            HttpRequest.Builder builder = HttpRequest.newBuilder()
                    .uri(URI.create(provider.getEndpointUrl()))
                    .timeout(Duration.ofMillis(provider.getTimeoutMillis() == null ? 3000 : provider.getTimeoutMillis()))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(objectMapper.writeValueAsString(payload)));
            if (apiKey != null && !apiKey.isBlank()) {
                builder.header("Authorization", "Bearer " + apiKey);
            }

            HttpResponse<String> response = HttpClient.newHttpClient().send(builder.build(), HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() >= 200 && response.statusCode() < 300) {
                return WafSyncResult.builder()
                        .handled(true)
                        .success(true)
                        .status("SYNCED")
                        .message(detail(provider, "HTTP " + response.statusCode(), abbreviate(response.body())))
                        .build();
            }

            String status = provider.getFailOpen() != null && provider.getFailOpen() == 1
                    ? "EXTERNAL_PROVIDER_PENDING"
                    : "FAILED";
            return WafSyncResult.builder()
                    .handled(true)
                    .success(false)
                    .status(status)
                    .message(detail(provider, "HTTP " + response.statusCode(), abbreviate(response.body())))
                    .build();
        } catch (Exception e) {
            log.warn("[WAF] sync provider call failed syncIdx={} provider={}", item.getSyncIdx(), provider.getProviderCode(), e);
            return WafSyncResult.builder()
                    .handled(true)
                    .success(false)
                    .status(provider.getFailOpen() != null && provider.getFailOpen() == 1 ? "EXTERNAL_PROVIDER_PENDING" : "FAILED")
                    .message(detail(provider, e.getClass().getSimpleName(), e.getMessage()))
                    .build();
        }
    }

    private String detail(SecurityAssessmentProviderConfigVO provider, String result, String reason) {
        return "providerCode=" + safe(provider.getProviderCode())
                + "; providerKind=" + safe(provider.getProviderKind())
                + "; result=" + safe(result)
                + "; failOpen=" + safe(String.valueOf(provider.getFailOpen()))
                + "; reason=" + safe(reason);
    }

    private String safe(String value) {
        return value == null ? "" : value;
    }

    private String abbreviate(String value) {
        if (value == null) {
            return "";
        }
        return value.length() <= 500 ? value : value.substring(0, 500) + "...";
    }
}
