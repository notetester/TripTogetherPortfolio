package org.triptogether.ai.service;

import org.triptogether.ai.dto.AiPlanRequestDTO;
import org.triptogether.ai.dto.AiPlanResponseDTO;

// GPT가 일정 생성해주는 역할 담당
// 프롬프트 구성, OpenAI 호출, 응답을 AiPlanResponseDTO로 변환
public interface AiPlanGPTService {
    AiPlanResponseDTO generatePlan(AiPlanRequestDTO requestDTO);

}
