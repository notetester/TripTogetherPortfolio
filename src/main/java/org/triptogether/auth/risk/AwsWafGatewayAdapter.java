package org.triptogether.auth.risk;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.core.annotation.Order;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityWafSyncQueueVO;

@Component
@Order(20)
@RequiredArgsConstructor
public class AwsWafGatewayAdapter implements WafSyncAdapter {

    private final WafSyncHttpClient httpClient;

    @Override
    public boolean supports(SecurityAssessmentProviderConfigVO provider, SecurityWafSyncQueueVO item) {
        String code = provider.getProviderCode();
        return hasEndpoint(provider) && code != null && (code.startsWith("AWS_WAF") || code.startsWith("AWS"));
    }

    @Override
    public WafSyncResult sync(SecurityAssessmentProviderConfigVO provider, SecurityWafSyncQueueVO item) {
        return httpClient.call(provider, item);
    }
    private boolean hasEndpoint(SecurityAssessmentProviderConfigVO provider) {
        return provider.getEndpointUrl() != null && !provider.getEndpointUrl().isBlank();
    }
}
