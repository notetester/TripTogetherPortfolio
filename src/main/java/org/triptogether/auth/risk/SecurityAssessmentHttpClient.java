package org.triptogether.auth.risk;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Component
@RequiredArgsConstructor
public class SecurityAssessmentHttpClient {

    private final SecurityProviderSecretResolver secretResolver;
    private final ObjectMapper objectMapper;

    public Optional<LoginRiskAssessmentResult> call(SecurityAssessmentProviderConfigVO provider,
                                                    LoginRiskAssessmentRequest request) {
        try {
            Map<String, Object> payload = new LinkedHashMap<>();
            payload.put("providerCode", provider.getProviderCode());
            payload.put("providerKind", provider.getProviderKind());
            payload.put("modelName", provider.getModelName());
            payload.put("policyCode", request.getPolicyCode());
            payload.put("reviewType", request.getReviewType());
            payload.put("subjectType", request.getSubjectType());
            payload.put("subjectKey", request.getSubjectKey());
            payload.put("userIdx", request.getUserIdx());
            payload.put("ipAddress", request.getIpAddress());
            payload.put("countryCode", request.getCountryCode());
            payload.put("asn", request.getAsn());
            payload.put("observedCount", request.getObservedCount());
            payload.put("distinctIdentifierCount", request.getDistinctIdentifierCount());
            payload.put("detailMessage", request.getDetailMessage());

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
            if (response.statusCode() < 200 || response.statusCode() >= 300) {
                log.warn("[SecurityProvider] assessment provider returned non-2xx provider={} status={}",
                        provider.getProviderCode(), response.statusCode());
                return failClosedResult(provider, "HTTP " + response.statusCode() + ": " + abbreviate(response.body()));
            }

            JsonNode json = objectMapper.readTree(response.body());
            return Optional.of(LoginRiskAssessmentResult.builder()
                    .sourceKind(provider.getProviderKind())
                    .sourceCode(provider.getProviderCode())
                    .sourceName(provider.getProviderName())
                    .sourceVersion(provider.getModelName())
                    .riskScore(intOrNull(json, "riskScore"))
                    .riskLevel(textOrDefault(json, "riskLevel", "PENDING"))
                    .confidenceScore(intOrNull(json, "confidenceScore"))
                    .recommendationAction(textOrDefault(json, "recommendationAction", "REVIEW"))
                    .recommendationReason(textOrDefault(json, "recommendationReason", "External provider assessment"))
                    .evidenceSummary(textOrDefault(json, "evidenceSummary", response.body()))
                    .rawPayload(response.body())
                    .build());
        } catch (Exception e) {
            log.warn("[SecurityProvider] assessment provider call failed provider={}", provider.getProviderCode(), e);
            return failClosedResult(provider, e.getClass().getSimpleName() + ": " + e.getMessage());
        }
    }

    private Optional<LoginRiskAssessmentResult> failClosedResult(SecurityAssessmentProviderConfigVO provider,
                                                                 String reason) {
        if (provider.getFailOpen() != null && provider.getFailOpen() == 1) {
            return Optional.empty();
        }
        return Optional.of(LoginRiskAssessmentResult.builder()
                .sourceKind(provider.getProviderKind())
                .sourceCode(provider.getProviderCode())
                .sourceName(provider.getProviderName())
                .sourceVersion(provider.getModelName())
                .riskScore(null)
                .riskLevel("PENDING")
                .confidenceScore(null)
                .recommendationAction("REVIEW")
                .recommendationReason("Provider failure with fail-closed policy")
                .evidenceSummary(reason)
                .rawPayload("{\"providerFailure\":true}")
                .build());
    }

    private String textOrDefault(JsonNode json, String field, String fallback) {
        JsonNode value = json.get(field);
        return value == null || value.isNull() ? fallback : value.asText();
    }

    private Integer intOrNull(JsonNode json, String field) {
        JsonNode value = json.get(field);
        return value == null || value.isNull() ? null : value.asInt();
    }

    private String abbreviate(String value) {
        if (value == null) {
            return "";
        }
        return value.length() <= 500 ? value : value.substring(0, 500) + "...";
    }
}
