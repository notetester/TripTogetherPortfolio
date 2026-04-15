package org.triptogether.ai.service;

import org.triptogether.ai.dto.AiPlanRequestDTO;
import org.triptogether.ai.dto.AiPlanResponseDTO;

public interface AiPlanService {
    Long generateAndSavePlan(AiPlanRequestDTO requestDTO, Long userIdx);
}