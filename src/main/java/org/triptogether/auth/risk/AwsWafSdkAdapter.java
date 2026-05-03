package org.triptogether.auth.risk;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.core.annotation.Order;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityWafSyncQueueVO;
import software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.http.urlconnection.UrlConnectionHttpClient;
import software.amazon.awssdk.services.wafv2.Wafv2Client;
import software.amazon.awssdk.services.wafv2.model.GetIpSetRequest;
import software.amazon.awssdk.services.wafv2.model.GetIpSetResponse;
import software.amazon.awssdk.services.wafv2.model.IPSet;
import software.amazon.awssdk.services.wafv2.model.Scope;
import software.amazon.awssdk.services.wafv2.model.UpdateIpSetRequest;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Component
@Order(10)
@RequiredArgsConstructor
public class AwsWafSdkAdapter implements WafSyncAdapter {

    @Override
    public boolean supports(SecurityAssessmentProviderConfigVO provider, SecurityWafSyncQueueVO item) {
        String code = provider.getProviderCode();
        return code != null && (code.startsWith("AWS_WAF_SDK") || code.startsWith("AWS_WAF_DIRECT"));
    }

    @Override
    public WafSyncResult sync(SecurityAssessmentProviderConfigVO provider, SecurityWafSyncQueueVO item) {
        if (!isIpTarget(item)) {
            return WafSyncResult.builder()
                    .handled(true)
                    .success(false)
                    .status("FAILED")
                    .message(detail(provider, "UNSUPPORTED_TARGET", "AWS WAF SDK adapter supports IP/CIDR target values for IPSet synchronization."))
                    .build();
        }

        Map<String, String> config = parseModelConfig(provider.getModelName());
        String region = value(config, "region", "ap-northeast-2");
        Scope scope = Scope.fromValue(value(config, "scope", "REGIONAL"));
        String ipSetId = value(config, "ipSetId", null);
        String ipSetName = value(config, "ipSetName", null);

        if (ipSetId == null || ipSetName == null) {
            return WafSyncResult.builder()
                    .handled(true)
                    .success(false)
                    .status("FAILED")
                    .message(detail(provider, "MISSING_CONFIG", "modelName must contain region, scope, ipSetId, ipSetName. Example: region=ap-northeast-2;scope=REGIONAL;ipSetId=...;ipSetName=..."))
                    .build();
        }

        try (Wafv2Client client = Wafv2Client.builder()
                .region(Region.of(region))
                .credentialsProvider(DefaultCredentialsProvider.create())
                .httpClientBuilder(UrlConnectionHttpClient.builder())
                .build()) {

            GetIpSetResponse current = client.getIPSet(GetIpSetRequest.builder()
                    .scope(scope)
                    .id(ipSetId)
                    .name(ipSetName)
                    .build());

            IPSet ipSet = current.ipSet();
            List<String> addresses = new ArrayList<>(ipSet.addresses());
            String target = normalizeIpTarget(item.getTargetValue());

            if (isRemoveAction(item.getSyncAction())) {
                addresses.remove(target);
            } else if (!addresses.contains(target)) {
                addresses.add(target);
            }

            client.updateIPSet(UpdateIpSetRequest.builder()
                    .scope(scope)
                    .id(ipSetId)
                    .name(ipSetName)
                    .addresses(addresses)
                    .lockToken(current.lockToken())
                    .description(ipSet.description())
                    .build());

            return WafSyncResult.builder()
                    .handled(true)
                    .success(true)
                    .status("SYNCED")
                    .message(detail(provider, "AWS_WAF_SDK_SYNCED", "target=" + target + "; action=" + item.getSyncAction()))
                    .build();
        } catch (Exception e) {
            String status = provider.getFailOpen() != null && provider.getFailOpen() == 1
                    ? "EXTERNAL_PROVIDER_PENDING"
                    : "FAILED";
            return WafSyncResult.builder()
                    .handled(true)
                    .success(false)
                    .status(status)
                    .message(detail(provider, e.getClass().getSimpleName(), e.getMessage()))
                    .build();
        }
    }

    private boolean isIpTarget(SecurityWafSyncQueueVO item) {
        return "IP".equals(item.getTargetType()) || "CIDR".equals(item.getTargetType());
    }

    private boolean isRemoveAction(String action) {
        return "UNBLOCK".equals(action) || "ALLOW".equals(action) || "DELETE".equals(action) || "REMOVE".equals(action);
    }

    private String normalizeIpTarget(String targetValue) {
        if (targetValue == null || targetValue.isBlank()) {
            return targetValue;
        }
        if (targetValue.contains("/")) {
            return targetValue;
        }
        if (targetValue.contains(":")) {
            return targetValue + "/128";
        }
        return targetValue + "/32";
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

    private String value(Map<String, String> config, String key, String fallback) {
        String value = config.get(key);
        return value == null || value.isBlank() ? fallback : value;
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
}
