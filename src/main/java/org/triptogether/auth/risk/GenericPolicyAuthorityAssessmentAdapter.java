package org.triptogether.auth.risk;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;

import java.util.Optional;

@Component
@RequiredArgsConstructor
public class GenericPolicyAuthorityAssessmentAdapter implements SecurityAssessmentAdapter {

    private final SecurityAssessmentHttpClient httpClient;

    @Override
    public boolean supports(SecurityAssessmentProviderConfigVO provider) {
        return "POLICY_AUTHORITY".equals(provider.getProviderKind());
    }

    @Override
    public Optional<LoginRiskAssessmentResult> assess(SecurityAssessmentProviderConfigVO provider,
                                                      LoginRiskAssessmentRequest request) {
        return httpClient.call(provider, request);
    }
}
