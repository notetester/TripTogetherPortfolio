package org.triptogether.auth.risk;

import java.util.Optional;

/**
 * 로그인 위험 보조 판단 모듈 확장 지점.
 *
 * <p>실제 AI 모델, 룰 기반 알고리즘, 상위 정책기관/관제센터 연동 모듈은
 * 이 인터페이스를 구현해 Spring Bean으로 등록하면 LoginRiskPolicyService에서
 * 자동으로 평가 결과를 수집할 수 있다.</p>
 */
public interface LoginRiskAssessmentProvider {
    Optional<LoginRiskAssessmentResult> assess(LoginRiskAssessmentRequest request);
}
