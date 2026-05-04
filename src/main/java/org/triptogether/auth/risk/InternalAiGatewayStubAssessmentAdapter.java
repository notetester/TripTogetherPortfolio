package org.triptogether.auth.risk;

import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.triptogether.auth.vo.SecurityAssessmentProviderConfigVO;

import java.util.Optional;

@Component
@Order(0)
public class InternalAiGatewayStubAssessmentAdapter implements SecurityAssessmentAdapter {

    @Override
    public boolean supports(SecurityAssessmentProviderConfigVO provider) {
        return "INTERNAL_AI_GATEWAY".equals(provider.getProviderCode());
    }

    @Override
    public Optional<LoginRiskAssessmentResult> assess(SecurityAssessmentProviderConfigVO provider,
                                                      LoginRiskAssessmentRequest request) {
        return Optional.of(LoginRiskAssessmentResult.builder()
                .sourceKind("AI_MODEL")
                .sourceCode("INTERNAL_AI_GATEWAY")
                .sourceName(provider.getProviderName())
                .sourceVersion(provider.getModelName())
                .riskScore(0)
                .riskLevel("LOW")
                .confidenceScore(100)
                .recommendationAction("PASS")
                .recommendationReason("Stub response before production AI Gateway integration")
                .evidenceSummary("Mock AI Gateway allowed the request. policyCode="
                        + safe(request.getPolicyCode()) + ", subjectKey=" + safe(request.getSubjectKey()))
                .rawPayload("{\"stub\":true,\"recommendationAction\":\"PASS\"}")
                .build());
    }

    private String safe(String value) {
        return value == null ? "" : value;
    }
}
