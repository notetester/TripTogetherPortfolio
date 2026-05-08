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
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Component
@RequiredArgsConstructor
public class SecurityAssessmentHttpClient {

    private final SecurityProviderSecretResolver secretResolver;
    private final ObjectMapper objectMapper;
    private final ProviderCallThrottler throttler;

    public Optional<LoginRiskAssessmentResult> call(SecurityAssessmentProviderConfigVO provider,
                                                    LoginRiskAssessmentRequest request) {
        ProviderCallThrottler.Lease lease = null;
        try {
            lease = throttler.acquire(provider);
            if (!lease.isGranted()) {
                log.warn("[SecurityProvider] throttled provider={} reason={}", provider.getProviderCode(), lease.denyReason());
                return failClosedResult(provider, "throttled: " + lease.denyReason());
            }
            return invokeWithRetry(provider, request);
        } catch (InterruptedException ie) {
            Thread.currentThread().interrupt();
            return failClosedResult(provider, "interrupted: " + ie.getMessage());
        } finally {
            if (lease != null) lease.close();
        }
    }

    private Optional<LoginRiskAssessmentResult> invokeWithRetry(SecurityAssessmentProviderConfigVO provider,
                                                                LoginRiskAssessmentRequest request) {
        int attempts = (provider.getRetryCount() == null ? 0 : Math.max(0, provider.getRetryCount())) + 1;
        int backoff = provider.getRetryBackoffMs() == null ? 500 : Math.max(0, provider.getRetryBackoffMs());
        Exception lastError = null;
        for (int i = 0; i < attempts; i++) {
            try {
                return Optional.of(doCall(provider, request));
            } catch (Exception e) {
                log.warn("[SecurityProvider] call attempt {} failed provider={}", i + 1, provider.getProviderCode(), e);
                lastError = e;
            }
            if (i < attempts - 1 && backoff > 0) {
                try { Thread.sleep((long) backoff * (i + 1)); } catch (InterruptedException ie) { Thread.currentThread().interrupt(); break; }
            }
        }
        String reason = lastError == null ? "unknown" : lastError.getClass().getSimpleName() + ": " + lastError.getMessage();
        return failClosedResult(provider, reason);
    }

    private LoginRiskAssessmentResult doCall(SecurityAssessmentProviderConfigVO provider,
                                             LoginRiskAssessmentRequest request) throws Exception {
        String body = renderBody(provider, request);
        String method = (provider.getRequestMethod() == null || provider.getRequestMethod().isBlank())
                ? "POST" : provider.getRequestMethod().toUpperCase();

        String apiKey = secretResolver.resolve(provider.getApiKeyRef());
        HttpRequest.Builder builder = HttpRequest.newBuilder()
                .uri(URI.create(provider.getEndpointUrl()))
                .timeout(Duration.ofMillis(provider.getTimeoutMillis() == null ? 3000 : provider.getTimeoutMillis()))
                .header("Content-Type", "application/json");

        applyExtraHeaders(builder, provider);

        switch (method) {
            case "GET" -> builder.GET();
            case "PUT" -> builder.PUT(HttpRequest.BodyPublishers.ofString(body));
            case "PATCH" -> builder.method("PATCH", HttpRequest.BodyPublishers.ofString(body));
            case "DELETE" -> builder.method("DELETE", HttpRequest.BodyPublishers.ofString(body));
            default -> builder.POST(HttpRequest.BodyPublishers.ofString(body));
        }

        if (apiKey != null && !apiKey.isBlank()) {
            builder.header("Authorization", "Bearer " + apiKey);
        }

        HttpResponse<String> response = HttpClient.newHttpClient().send(builder.build(), HttpResponse.BodyHandlers.ofString());
        if (response.statusCode() < 200 || response.statusCode() >= 300) {
            throw new RuntimeException("HTTP " + response.statusCode() + ": " + abbreviate(response.body()));
        }

        JsonNode json = objectMapper.readTree(response.body());
        return extractResult(provider, response.body(), json);
    }

    private String renderBody(SecurityAssessmentProviderConfigVO provider, LoginRiskAssessmentRequest request) throws Exception {
        String tpl = provider.getRequestTemplateJson();
        if (tpl != null && !tpl.isBlank()) {
            return substitutePlaceholders(tpl, request);
        }
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
        return objectMapper.writeValueAsString(payload);
    }

    private String substitutePlaceholders(String template, LoginRiskAssessmentRequest request) {
        String ip = nullToEmpty(request.getIpAddress());
        String userId = request.getUserIdx() == null ? "" : String.valueOf(request.getUserIdx());
        String loginId = nullToEmpty(request.getSubjectKey());
        String requestId = nullToEmpty(request.getDetailMessage());
        return template
                .replace("{{ip}}", escapeForJson(ip))
                .replace("{{userId}}", escapeForJson(userId))
                .replace("{{loginIdentifier}}", escapeForJson(loginId))
                .replace("{{userAgent}}", "")
                .replace("{{requestId}}", escapeForJson(requestId));
    }

    private void applyExtraHeaders(HttpRequest.Builder builder, SecurityAssessmentProviderConfigVO provider) {
        String headers = provider.getRequestHeadersJson();
        if (headers == null || headers.isBlank()) return;
        try {
            JsonNode node = objectMapper.readTree(headers);
            if (node.isObject()) {
                Iterator<Map.Entry<String, JsonNode>> it = node.fields();
                while (it.hasNext()) {
                    Map.Entry<String, JsonNode> e = it.next();
                    String k = e.getKey();
                    String v = e.getValue().isTextual() ? e.getValue().asText() : e.getValue().toString();
                    if (k != null && !k.isBlank() && !"Content-Type".equalsIgnoreCase(k)) {
                        builder.header(k, v == null ? "" : v);
                    }
                }
            }
        } catch (Exception e) {
            log.warn("[SecurityProvider] invalid requestHeadersJson provider={}", provider.getProviderCode(), e);
        }
    }

    private LoginRiskAssessmentResult extractResult(SecurityAssessmentProviderConfigVO provider,
                                                    String rawBody,
                                                    JsonNode json) {
        Integer riskScore = null;
        String riskLevel = null;
        Integer confidenceScore = null;
        String recommendationAction = null;

        String mappingJson = provider.getResponseMappingJson();
        if (mappingJson != null && !mappingJson.isBlank()) {
            try {
                JsonNode mapping = objectMapper.readTree(mappingJson);
                riskScore = readPointerInt(json, mapping.get("score"));
                riskLevel = readPointerText(json, mapping.get("label"));
                if (riskLevel == null) riskLevel = readPointerText(json, mapping.get("level"));
                confidenceScore = readPointerInt(json, mapping.get("confidence"));
                recommendationAction = readPointerText(json, mapping.get("decision"));
                if (recommendationAction == null) recommendationAction = readPointerText(json, mapping.get("recommendation"));
            } catch (Exception e) {
                log.warn("[SecurityProvider] invalid responseMappingJson provider={}", provider.getProviderCode(), e);
            }
        }
        if (riskScore == null) riskScore = intOrNull(json, "riskScore");
        if (riskLevel == null) riskLevel = textOrDefault(json, "riskLevel", "PENDING");
        if (confidenceScore == null) confidenceScore = intOrNull(json, "confidenceScore");
        if (recommendationAction == null) recommendationAction = textOrDefault(json, "recommendationAction", "REVIEW");

        return LoginRiskAssessmentResult.builder()
                .sourceKind(provider.getProviderKind())
                .sourceCode(provider.getProviderCode())
                .sourceName(provider.getProviderName())
                .sourceVersion(provider.getModelName())
                .riskScore(riskScore)
                .riskLevel(riskLevel)
                .confidenceScore(confidenceScore)
                .recommendationAction(recommendationAction)
                .recommendationReason(textOrDefault(json, "recommendationReason", "External provider assessment"))
                .evidenceSummary(textOrDefault(json, "evidenceSummary", rawBody))
                .rawPayload(rawBody)
                .build();
    }

    private Integer readPointerInt(JsonNode root, JsonNode pointerNode) {
        JsonNode at = readPointer(root, pointerNode);
        if (at == null || at.isMissingNode() || at.isNull()) return null;
        return at.canConvertToInt() ? at.asInt() : null;
    }

    private String readPointerText(JsonNode root, JsonNode pointerNode) {
        JsonNode at = readPointer(root, pointerNode);
        if (at == null || at.isMissingNode() || at.isNull()) return null;
        return at.isTextual() ? at.asText() : at.toString();
    }

    private JsonNode readPointer(JsonNode root, JsonNode pointerNode) {
        if (pointerNode == null || !pointerNode.isTextual()) return null;
        String pointer = pointerNode.asText();
        if (pointer == null || pointer.isBlank()) return null;
        try {
            return root.at(pointer.startsWith("/") ? pointer : "/" + pointer);
        } catch (Exception e) {
            return null;
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
        if (value == null) return "";
        return value.length() <= 500 ? value : value.substring(0, 500) + "...";
    }

    private String nullToEmpty(String s) { return s == null ? "" : s; }

    private String escapeForJson(String s) {
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}
