package org.triptogether.moderation.advice;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.triptogether.moderation.service.ModerationPolicyService;

/**
 * 모든 컨트롤러 응답 모델에 모더레이션 정책값을 자동 주입한다.
 * JSP는 ${reportThreshold} 같이 EL로 바로 사용한다.
 */
@ControllerAdvice
@RequiredArgsConstructor
public class ModerationPolicyAdvice {

    private final ModerationPolicyService policyService;

    @ModelAttribute("reportThreshold")
    public int reportThreshold() {
        return policyService.getPolicy().getReportThreshold();
    }
}
