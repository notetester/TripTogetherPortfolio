package org.triptogether.courses.service;

import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.ai.dto.AiDayDTO;
import org.triptogether.ai.dto.AiPlanRequestDTO;
import org.triptogether.ai.dto.AiPlanResponseDTO;
import org.triptogether.ai.dto.AiSpotDTO;
import org.triptogether.ai.service.AiPlanGPTService;
import org.triptogether.courses.vo.PlanSpotVO;
import org.triptogether.courses.vo.TravelPlanVO;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

// 요청값 검증, GPT 서비스 호출, DB 저장을 담당한다.
@Service
@RequiredArgsConstructor
public class AiPlanServiceImpl implements AiPlanService {

    private final TravelPlanService travelPlanService;
    private final AiPlanGPTService aiPlanGPTService;
    private final MessageSource messageSource;

    // AI 일정 생성 후 DB에 저장하는 메인 메서드.
    @Override
    @Transactional
    public Long generateAndSavePlan(AiPlanRequestDTO requestDTO, Long userIdx) {
        validateRequest(requestDTO);

        AiPlanResponseDTO responseDTO = aiPlanGPTService.generatePlan(requestDTO);

        LocalDate start = LocalDate.parse(requestDTO.getStartDate());
        LocalDate end = LocalDate.parse(requestDTO.getEndDate());

        TravelPlanVO travelPlanVO = new TravelPlanVO();
        travelPlanVO.setUser_idx(userIdx);
        travelPlanVO.setTitle(responseDTO.getTitle());
        travelPlanVO.setDestination(requestDTO.getDestination());
        travelPlanVO.setStart_date(Date.valueOf(start));
        travelPlanVO.setEnd_date(Date.valueOf(end));
        travelPlanVO.setIs_public(0);
        travelPlanVO.setShare_token(null);
        travelPlanVO.setPlan_source("AI");

        travelPlanService.insertTravelPlan(travelPlanVO);

        Long planId = travelPlanVO.getPlan_id();
        savePlanSpots(planId, responseDTO);

        return planId;
    }

    // AI가 만든 날짜별 장소 목록을 PLAN_SPOT 테이블에 저장한다.
    private void savePlanSpots(Long planId, AiPlanResponseDTO responseDTO) {
        if (responseDTO == null || responseDTO.getDays() == null) {
            return;
        }

        for (AiDayDTO day : responseDTO.getDays()) {
            Date visitDate = Date.valueOf(day.getDate());
            List<AiSpotDTO> spots = day.getSpots();

            if (spots == null || spots.isEmpty()) {
                continue;
            }

            for (AiSpotDTO spot : spots) {
                PlanSpotVO planSpotVO = new PlanSpotVO();
                planSpotVO.setPlan_id(planId);
                // AI 자유 장소명은 실제 SPOT_TRAVEL과 매칭하지 않으므로 spot_id는 비워둔다.
                planSpotVO.setSpot_id(null);
                planSpotVO.setPlace_name(spot.getName());
                planSpotVO.setVisit_date(visitDate);
                planSpotVO.setVisit_order(spot.getVisitOrder());

                travelPlanService.insertPlanSpot(planSpotVO);
            }
        }
    }

    private void validateRequest(AiPlanRequestDTO requestDTO) {
        if (requestDTO == null) {
            throw new IllegalArgumentException(msg("course.error.requestEmpty"));
        }

        if (isBlank(requestDTO.getDestination())) {
            throw new IllegalArgumentException(msg("course.error.destinationRequired"));
        }

        if (isBlank(requestDTO.getStartDate()) || isBlank(requestDTO.getEndDate())) {
            throw new IllegalArgumentException(msg("course.error.dateRequired"));
        }

        LocalDate start = LocalDate.parse(requestDTO.getStartDate());
        LocalDate end = LocalDate.parse(requestDTO.getEndDate());

        if (end.isBefore(start)) {
            throw new IllegalArgumentException(msg("course.error.endBeforeStart"));
        }
    }

    private String msg(String code) {
        return messageSource.getMessage(code, null, LocaleContextHolder.getLocale());
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
