package org.triptogether.auth.risk;

import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityWafSyncQueueVO;

@Component
@Order(0)
public class MockWafSyncAdapter implements WafSyncAdapter {

    @Override
    public boolean supports(SecurityAssessmentProviderConfigVO provider, SecurityWafSyncQueueVO item) {
        if (provider == null || !isWafSyncProviderKind(provider.getProviderKind())) {
            return false;
        }
        return isDemoOrMockProvider(provider) || hasMockEndpoint(provider) || hasMockModel(provider);
    }

    @Override
    public WafSyncResult sync(SecurityAssessmentProviderConfigVO provider, SecurityWafSyncQueueVO item) {
        return WafSyncResult.builder()
                .handled(true)
                .success(true)
                .status("SYNCED")
                .message("providerCode=" + safe(provider.getProviderCode())
                        + "; providerKind=" + safe(provider.getProviderKind())
                        + "; result=MOCK_SYNCED"
                        + "; failOpen=" + safe(String.valueOf(provider.getFailOpen()))
                        + "; reason=Demo/mock WAF sync was handled locally without an external HTTP request."
                        + "; endpoint=" + safe(provider.getEndpointUrl())
                        + "; targetType=" + safe(item.getTargetType())
                        + "; targetValue=" + safe(item.getTargetValue())
                        + "; action=" + safe(item.getSyncAction()))
                .build();
    }

    static boolean isDemoOrMockProvider(SecurityAssessmentProviderConfigVO provider) {
        String providerCode = normalize(provider == null ? null : provider.getProviderCode());
        return "MOCK_WAF_SERVICE".equals(providerCode)
                || providerCode.startsWith("DEMO_")
                || providerCode.contains("_MOCK_")
                || providerCode.endsWith("_MOCK")
                || providerCode.contains("MOCK_WAF");
    }

    static boolean hasMockEndpoint(SecurityAssessmentProviderConfigVO provider) {
        String endpointUrl = trim(provider == null ? null : provider.getEndpointUrl());
        return endpointUrl.toLowerCase().startsWith("mock://");
    }

    static boolean hasMockModel(SecurityAssessmentProviderConfigVO provider) {
        String modelName = trim(provider == null ? null : provider.getModelName()).toLowerCase();
        return modelName.startsWith("mock-")
                || modelName.contains(";mode=mock")
                || modelName.contains("mode=mock;")
                || "mode=mock".equals(modelName);
    }

    static boolean isWafSyncProviderKind(String providerKind) {
        String normalized = normalize(providerKind);
        return "WAF_CDN".equals(normalized)
                || "WAF".equals(normalized)
                || "CDN".equals(normalized)
                || "EDGE_SECURITY".equals(normalized);
    }

    private static String normalize(String value) {
        return trim(value).toUpperCase();
    }

    private static String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private String safe(String value) {
        return value == null ? "" : value;
    }
}
