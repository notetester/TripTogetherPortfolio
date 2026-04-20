package org.triptogether.courses.service;

import org.triptogether.ai.dto.AiPlanRequestDTO;

public interface AiPlanService {
    Long generateAndSavePlan(AiPlanRequestDTO requestDTO, Long userIdx);
}