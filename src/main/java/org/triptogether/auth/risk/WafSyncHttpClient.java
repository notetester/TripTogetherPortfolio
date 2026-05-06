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
            String endpoint = resolveEndpoint(provider.getEndpointUrl(), item);
            WafSyncResult localMockResult = handleLocalMockProvider(provider, item, endpoint);
            if (localMockResult != null) {
                return localMockResult;
            }

            URI endpointUri = validateExternalHttpEndpoint(provider, endpoint);

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
                    .uri(endpointUri)
                    .timeout(Duration.ofMillis(provider.getTimeoutMillis() == null ? 3000 : provider.getTimeoutMillis()))
                    .header("Content-Type", "application/json");

            String body = objectMapper.writeValueAsString(payload);
            String method = resolveMethod(provider, item);
            if ("DELETE".equals(method)) {
                builder.method("DELETE", HttpRequest.BodyPublishers.ofString(body));
            } else if ("PUT".equals(method)) {
                builder.PUT(HttpRequest.BodyPublishers.ofString(body));
            } else if ("PATCH".equals(method)) {
                builder.method("PATCH", HttpRequest.BodyPublishers.ofString(body));
            } else {
                builder.POST(HttpRequest.BodyPublishers.ofString(body));
            }
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

    private String resolveEndpoint(String endpointUrl, SecurityWafSyncQueueVO item) {
        if (endpointUrl == null) {
            return "";
        }
        return endpointUrl
                .replace("{syncIdx}", safe(String.valueOf(item.getSyncIdx())))
                .replace("{sourceType}", safe(item.getSourceType()))
                .replace("{sourceId}", safe(String.valueOf(item.getSourceId())))
                .replace("{syncAction}", safe(item.getSyncAction()))
                .replace("{targetType}", safe(item.getTargetType()))
                .replace("{targetValue}", safe(item.getTargetValue()));
    }

    private WafSyncResult handleLocalMockProvider(SecurityAssessmentProviderConfigVO provider,
                                                  SecurityWafSyncQueueVO item,
                                                  String endpoint) {
        if (!MockWafSyncAdapter.isWafSyncProviderKind(provider.getProviderKind())) {
            return null;
        }
        if (!MockWafSyncAdapter.isDemoOrMockProvider(provider)
                && !MockWafSyncAdapter.hasMockEndpoint(provider)
                && !MockWafSyncAdapter.hasMockModel(provider)
                && !safe(endpoint).trim().toLowerCase().startsWith("mock://")) {
            return null;
        }

        log.info("[WAF] demo/mock provider handled locally without external request syncIdx={} provider={} endpoint={}",
                item.getSyncIdx(), provider.getProviderCode(), endpoint);
        return WafSyncResult.builder()
                .handled(true)
                .success(true)
                .status("SYNCED")
                .message(detail(provider, "MOCK_SYNCED",
                        "Demo/mock WAF endpoint was handled locally without an external HTTP request. endpoint=" + safe(endpoint)))
                .build();
    }

    private URI validateExternalHttpEndpoint(SecurityAssessmentProviderConfigVO provider, String endpoint) {
        if (endpoint == null || endpoint.isBlank()) {
            throw new IllegalArgumentException("WAF sync endpointUrl is blank");
        }

        URI uri = URI.create(endpoint);
        String scheme = uri.getScheme();
        if (!"http".equalsIgnoreCase(scheme) && !"https".equalsIgnoreCase(scheme)) {
            throw new IllegalArgumentException("Unsupported WAF sync endpoint scheme: "
                    + safe(scheme)
                    + "; providerCode=" + safe(provider.getProviderCode())
                    + "; endpoint=" + safe(endpoint));
        }
        return uri;
    }

    private String resolveMethod(SecurityAssessmentProviderConfigVO provider, SecurityWafSyncQueueVO item) {
        Map<String, String> config = parseModelConfig(provider.getModelName());
        String method = config.get("method");
        if (method != null && !method.isBlank()) {
            return method.trim().toUpperCase();
        }
        if ("UNBLOCK".equals(item.getSyncAction()) || "DELETE".equals(item.getSyncAction()) || "REMOVE".equals(item.getSyncAction())) {
            return "DELETE";
        }
        return "POST";
    }

    private Map<String, String> parseModelConfig(String value) {
        Map<String, String> result = new LinkedHashMap<>();
        if (value == null || value.isBlank()) {
            return result;
        }
        for (String token : value.split(";")) {
            int idx = token.indexOf('=');
            if (idx > 0) {
                result.put(token.substring(0, idx).trim(), token.substring(idx + 1).trim());
            }
        }
        return result;
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
