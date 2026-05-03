package org.triptogether.auth.risk;

import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;

import java.util.Optional;

public interface SecurityAssessmentAdapter {
    boolean supports(SecurityAssessmentProviderConfigVO provider);
    Optional<LoginRiskAssessmentResult> assess(SecurityAssessmentProviderConfigVO provider,
                                               LoginRiskAssessmentRequest request);
}
