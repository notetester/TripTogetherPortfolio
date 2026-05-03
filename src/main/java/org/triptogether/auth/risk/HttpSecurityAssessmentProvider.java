package org.triptogether.auth.risk;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.triptogether.auth.mapper.LoginRiskPolicyMapper;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;

import java.util.List;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class HttpSecurityAssessmentProvider implements LoginRiskAssessmentProvider {

    private final LoginRiskPolicyMapper loginRiskPolicyMapper;
    private final List<SecurityAssessmentAdapter> assessmentAdapters;

    @Override
    public Optional<LoginRiskAssessmentResult> assess(LoginRiskAssessmentRequest request) {
        return loginRiskPolicyMapper.findEnabledExternalAssessmentProviders().stream()
                .filter(provider -> provider.getEndpointUrl() != null && !provider.getEndpointUrl().isBlank())
                .flatMap(provider -> assessWithSupportedAdapters(provider, request).stream())
                .findFirst();
    }

    private Optional<LoginRiskAssessmentResult> assessWithSupportedAdapters(SecurityAssessmentProviderConfigVO provider,
                                                                           LoginRiskAssessmentRequest request) {
        return assessmentAdapters.stream()
                .filter(adapter -> adapter.supports(provider))
                .map(adapter -> adapter.assess(provider, request))
                .filter(Optional::isPresent)
                .map(Optional::get)
                .findFirst();
    }
}
