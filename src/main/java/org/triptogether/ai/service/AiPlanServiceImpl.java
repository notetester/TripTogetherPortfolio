package org.triptogether.ai.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.triptogether.ai.dto.AiDayDTO;
import org.triptogether.ai.dto.AiPlanRequestDTO;
import org.triptogether.ai.dto.AiPlanResponseDTO;
import org.triptogether.ai.dto.AiSpotDTO;
import org.triptogether.courses.service.TravelPlanService;
import org.triptogether.courses.vo.PlanSpotVO;
import org.triptogether.courses.vo.TravelPlanVO;

import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

// 요청값 검증, GPT 서비스 호출, DB 저장
@Service
@RequiredArgsConstructor
public class AiPlanServiceImpl implements AiPlanService {

    private final TravelPlanService travelPlanService;
    private final AiPlanGPTService aiPlanGPTService;

    // AI 일정 생성 후 DB에 저장하는 메인 메서드
    // 폼에서 받은 여행 조건을 검사 -> GPT한테 일정 제목 같은 걸 받아오고
    //      -> TRAVEL_PLAN 테이블에 저장 후 -> 생성된 plan_id를 반환
    @Override
    @Transactional
    public Long generateAndSavePlan(AiPlanRequestDTO requestDTO, Long userIdx) {
        validateRequest(requestDTO);    // 입력값 검사

        // 진짜 AI 생성 역할을 GPT 서비스에 맡김
        AiPlanResponseDTO responseDTO = aiPlanGPTService.generatePlan(requestDTO);

        // 사용자가 입력한 문자열 날짜를 자바 날짜 객체(LocalDate)로 바꾸는 부분
        LocalDate start = LocalDate.parse(requestDTO.getStartDate());
        LocalDate end = LocalDate.parse(requestDTO.getEndDate());

        // 1. TRAVEL_PLAN 저장
        // DB에 넣을 여행일정 객체 생성
        TravelPlanVO travelPlanVO = new TravelPlanVO();
        // 이 일정이 누구 것인지 저장
        travelPlanVO.setUser_idx(userIdx);
        // 일정 제목은 GPT가 만들어준 걸 사용
        travelPlanVO.setTitle(responseDTO.getTitle());
        // 여행지는 사용자가 입력한 값 저장
        travelPlanVO.setDestination(requestDTO.getDestination());
        // LocalDate를 DB용 Date로 바꿔서 저장
        travelPlanVO.setStart_date(Date.valueOf(start));
        travelPlanVO.setEnd_date(Date.valueOf(end));
        // 공개여부: 비공개, 공유토큰: 아직 없음, 생성방식: AI
        travelPlanVO.setIs_public(0);
        travelPlanVO.setShare_token(null);
        travelPlanVO.setPlan_source("AI");

        // 실제로 TRAVEL_PLAN 테이블에 insert 하는 부분
        travelPlanService.insertTravelPlan(travelPlanVO);

        Long planId = travelPlanVO.getPlan_id();

        // 2. PLAN_SPOT 저장
        savePlanSpots(planId, responseDTO);

        return planId;
    }


    // AI가 만들어준 날짜별 장소 목록을 PLAN_SPOT 테이블에 저장하는 역할
    // responseDTO 안에 들어있는 day들 -> 각 day 안의 spot들 -> 하나씩 꺼내서 DB에 insert
    private void savePlanSpots(Long planId, AiPlanResponseDTO responseDTO){
        if (responseDTO == null || responseDTO.getDays() == null) return;

        // day 하나씩 반복
        for (AiDayDTO day : responseDTO.getDays()) {
            Date visitDate = Date.valueOf(day.getDate());

            // 그 날짜의 장소 목록 꺼내기
            List<AiSpotDTO> spots = day.getSpots();

            // 장소가 없으면 다음 날짜로 넘어감
            if (spots == null || spots.isEmpty()) {
                continue;
            }

            // 장소(spot) 하나씩 반복
            for (AiSpotDTO spot : spots) {
                // DB 저장용 객체 생성
                PlanSpotVO planSpotVO = new PlanSpotVO();
                planSpotVO.setPlan_id(planId);

                // 실제 SPOT_TRAVEL의 spot_id와 매칭 전까지는 null 또는 임시값 사용
                // planSpotVO.setSpot_id(null);
                planSpotVO.setSpot_id("AI_" + planId + "_" + day.getDayNo() + "_" + spot.getVisitOrder());

                // getPlaceName() 이 없으면 getName() 등으로 바꾸면 됨
                planSpotVO.setPlace_name(spot.getName());

                // day 날짜를 visit_date 로 저장
                planSpotVO.setVisit_date(visitDate);

                // 방문 순서 저장
                // AiSpotDTO.visitOrder -> PLAN_SPOT.visit_order
                planSpotVO.setVisit_order(spot.getVisitOrder());

                // 실제 DB insert
                travelPlanService.insertPlanSpot(planSpotVO);
            }
        }
    }

    private void validateRequest(AiPlanRequestDTO requestDTO) {
        if (requestDTO == null) {
            throw new IllegalArgumentException("요청 정보가 없습니다.");
        }

        if (isBlank(requestDTO.getDestination())) {
            throw new IllegalArgumentException("여행지를 입력해주세요.");
        }

        if (isBlank(requestDTO.getStartDate()) || isBlank(requestDTO.getEndDate())) {
            throw new IllegalArgumentException("여행 날짜를 입력해주세요.");
        }

        LocalDate start = LocalDate.parse(requestDTO.getStartDate());
        LocalDate end = LocalDate.parse(requestDTO.getEndDate());

        if (end.isBefore(start)) {
            throw new IllegalArgumentException("종료일은 시작일보다 빠를 수 없습니다.");
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}