package org.triptogether.auth.risk;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;

import java.util.Optional;

@Component
@RequiredArgsConstructor
public class GenericAiRiskAssessmentAdapter implements SecurityAssessmentAdapter {

    private final SecurityAssessmentHttpClient httpClient;

    @Override
    public boolean supports(SecurityAssessmentProviderConfigVO provider) {
        return "AI_MODEL".equals(provider.getProviderKind())
                && (provider.getProviderCode() == null || !provider.getProviderCode().startsWith("POLICY_"));
    }

    @Override
    public Optional<LoginRiskAssessmentResult> assess(SecurityAssessmentProviderConfigVO provider,
                                                      LoginRiskAssessmentRequest request) {
        return httpClient.call(provider, request);
    }
}
