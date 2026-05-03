package org.triptogether.auth.risk;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.triptogether.auth.mapper.LoginRiskPolicyMapper;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityWafSyncQueueVO;

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
public class HttpWafSyncProvider implements WafSyncProvider {

    private final LoginRiskPolicyMapper loginRiskPolicyMapper;
    private final SecurityProviderSecretResolver secretResolver;
    private final ObjectMapper objectMapper;

    @Override
    public boolean supports(SecurityWafSyncQueueVO item) {
        return findProvider().isPresent();
    }

    @Override
    public WafSyncResult sync(SecurityWafSyncQueueVO item) {
        Optional<SecurityAssessmentProviderConfigVO> providerOpt = findProvider();
        if (providerOpt.isEmpty()) {
            return WafSyncResult.builder()
                    .handled(false)
                    .success(false)
                    .status("EXTERNAL_PROVIDER_PENDING")
                    .message("No enabled WAF provider configuration")
                    .build();
        }

        SecurityAssessmentProviderConfigVO provider = providerOpt.get();
        try {
            Map<String, Object> payload = new LinkedHashMap<>();
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
                        .message(response.body())
                        .build();
            }
            return WafSyncResult.builder()
                    .handled(true)
                    .success(false)
                    .status((provider.getFailOpen() != null && provider.getFailOpen() == 1) ? "EXTERNAL_PROVIDER_PENDING" : "FAILED")
                    .message("HTTP " + response.statusCode() + ": " + response.body())
                    .build();
        } catch (Exception e) {
            log.warn("[WAF] sync provider call failed syncIdx={}", item.getSyncIdx(), e);
            return WafSyncResult.builder()
                    .handled(true)
                    .success(false)
                    .status((provider.getFailOpen() != null && provider.getFailOpen() == 1) ? "EXTERNAL_PROVIDER_PENDING" : "FAILED")
                    .message(e.getMessage())
                    .build();
        }
    }

    private Optional<SecurityAssessmentProviderConfigVO> findProvider() {
        return loginRiskPolicyMapper.findEnabledWafProviderConfigs().stream()
                .filter(p -> p.getEndpointUrl() != null && !p.getEndpointUrl().isBlank())
                .findFirst();
    }
}
