package org.triptogether.auth.risk;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.triptogether.auth.mapper.LoginRiskPolicyMapper;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityWafSyncQueueVO;

import java.util.List;

@Component
@RequiredArgsConstructor
public class HttpWafSyncProvider implements WafSyncProvider {

    private final LoginRiskPolicyMapper loginRiskPolicyMapper;
    private final List<WafSyncAdapter> wafSyncAdapters;

    @Override
    public boolean supports(SecurityWafSyncQueueVO item) {
        return loginRiskPolicyMapper.findEnabledWafProviderConfigs().stream()
                .filter(this::hasEndpoint)
                .anyMatch(provider -> wafSyncAdapters.stream().anyMatch(adapter -> adapter.supports(provider, item)));
    }

    @Override
    public WafSyncResult sync(SecurityWafSyncQueueVO item) {
        for (SecurityAssessmentProviderConfigVO provider : loginRiskPolicyMapper.findEnabledWafProviderConfigs()) {
            if (!hasEndpoint(provider)) {
                continue;
            }
            for (WafSyncAdapter adapter : wafSyncAdapters) {
                if (adapter.supports(provider, item)) {
                    return adapter.sync(provider, item);
                }
            }
        }
        return WafSyncResult.builder()
                .handled(false)
                .success(false)
                .status("EXTERNAL_PROVIDER_PENDING")
                .message("No enabled WAF provider configuration")
                .build();
    }

    private boolean hasEndpoint(SecurityAssessmentProviderConfigVO provider) {
        return provider.getEndpointUrl() != null && !provider.getEndpointUrl().isBlank();
    }
}
