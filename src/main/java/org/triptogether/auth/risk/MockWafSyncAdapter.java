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
        return "MOCK_WAF_SERVICE".equals(provider.getProviderCode());
    }

    @Override
    public WafSyncResult sync(SecurityAssessmentProviderConfigVO provider, SecurityWafSyncQueueVO item) {
        return WafSyncResult.builder()
                .handled(true)
                .success(true)
                .status("SYNCED")
                .message("providerCode=MOCK_WAF_SERVICE; providerKind=WAF_CDN; result=MOCK_SYNCED; failOpen="
                        + provider.getFailOpen()
                        + "; reason=Stub WAF sync completed for E2E demo. targetType="
                        + safe(item.getTargetType())
                        + "; targetValue=" + safe(item.getTargetValue())
                        + "; action=" + safe(item.getSyncAction()))
                .build();
    }

    private String safe(String value) {
        return value == null ? "" : value;
    }
}
