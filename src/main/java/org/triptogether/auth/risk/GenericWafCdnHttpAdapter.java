package org.triptogether.auth.risk;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;
import org.triptogether.auth.vo.SecurityWafSyncQueueVO;

@Component
@RequiredArgsConstructor
public class GenericWafCdnHttpAdapter implements WafSyncAdapter {

    private final WafSyncHttpClient httpClient;

    @Override
    public boolean supports(SecurityAssessmentProviderConfigVO provider, SecurityWafSyncQueueVO item) {
        return "WAF_CDN".equals(provider.getProviderKind())
                || "WAF".equals(provider.getProviderKind())
                || "CDN".equals(provider.getProviderKind())
                || "EDGE_SECURITY".equals(provider.getProviderKind());
    }

    @Override
    public WafSyncResult sync(SecurityAssessmentProviderConfigVO provider, SecurityWafSyncQueueVO item) {
        return httpClient.call(provider, item);
    }
}
