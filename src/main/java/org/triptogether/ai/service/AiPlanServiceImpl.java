package org.triptogether.ai.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.triptogether.ai.dto.AiDayDTO;
import org.triptogether.ai.dto.AiPlanRequestDTO;
import org.triptogether.ai.dto.AiPlanResponseDTO;
import org.triptogether.ai.dto.AiSpotDTO;
import org.triptogether.courses.service.TravelPlanService;
import org.triptogether.courses.vo.TravelPlanVO;

import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AiPlanServiceImpl implements AiPlanService {

    private final TravelPlanService travelPlanService;

    @Override
    public Long generateAndSavePlan(AiPlanRequestDTO requestDTO, Long userIdx) {
        AiPlanResponseDTO responseDTO = buildAiPlan(requestDTO);

        // 아직 DB 저장 안 붙였으면 임시값
        // Long planId = 1L;

        // 나중에 여기서 TRAVEL_PLAN, PLAN_SPOT 저장
        // return planId;

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

        // 지금은 헤더만 저장
        travelPlanService.insertTravelPlan(travelPlanVO);

        return travelPlanVO.getPlan_id();
    }

    private AiPlanResponseDTO buildAiPlan(AiPlanRequestDTO requestDTO) {
        validateRequest(requestDTO);

        LocalDate start = LocalDate.parse(requestDTO.getStartDate());
        LocalDate end = LocalDate.parse(requestDTO.getEndDate());

        long totalDays = ChronoUnit.DAYS.between(start, end) + 1;

        String destination = safeValue(requestDTO.getDestination(), "여행지");
        String companion = safeValue(requestDTO.getCompanion(), "동행");
        String style = safeValue(requestDTO.getStyle(), "균형형");
        String budget = safeValue(requestDTO.getBudget(), "중간");
        String requestText = safeValue(requestDTO.getRequestText(), "");

        String title = destination + " " + totalDays + "일 AI 추천 일정";

        String summary = destination + "에서 " + companion + "와(과) 함께하는 "
                + style + " 중심의 " + totalDays + "일 여행 일정입니다. "
                + "예산은 " + budget + " 기준으로 무리 없게 구성했습니다.";

        if (!requestText.isBlank()) {
            summary += " 추가 요청사항도 반영했습니다.";
        }

        List<AiDayDTO> dayList = new ArrayList<>();

        for (int i = 0; i < totalDays; i++) {
            LocalDate currentDate = start.plusDays(i);
            int dayNo = i + 1;

            AiDayDTO day = new AiDayDTO();
            day.setDayNo(dayNo);
            day.setDate(currentDate.toString());
            day.setTheme(getThemeByDay(dayNo, style));
            day.setSpots(createSpotsByDay(dayNo, destination, style, requestText));

            dayList.add(day);
        }

        AiPlanResponseDTO responseDTO = new AiPlanResponseDTO();
        responseDTO.setTitle(title);
        responseDTO.setSummary(summary);
        responseDTO.setDays(dayList);

        return responseDTO;
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

    private List<AiSpotDTO> createSpotsByDay(int dayNo, String destination, String style, String requestText) {
        List<AiSpotDTO> spots = new ArrayList<>();

        if (dayNo == 1) {
            spots.add(new AiSpotDTO(destination + " 대표 관광지", "도착 후 가볍게 둘러보기 좋은 장소입니다.", 1));
            spots.add(new AiSpotDTO(style.contains("카페") ? "감성 카페" : "현지 인기 맛집", "첫날 부담 없이 즐기기 좋은 코스입니다.", 2));
            spots.add(new AiSpotDTO("저녁 산책 스팟", "첫날 분위기 있게 마무리할 수 있는 장소입니다.", 3));
        } else if (dayNo == 2) {
            spots.add(new AiSpotDTO(destination + " 핵심 명소", "여행지의 대표 코스를 중심으로 구성했습니다.", 1));
            spots.add(new AiSpotDTO(style.contains("액티비티") ? "체험형 액티비티 장소" : "로컬 체험 장소", "여행 스타일을 반영한 일정입니다.", 2));
            spots.add(new AiSpotDTO(style.contains("사진") ? "포토 스팟" : "야경 명소", "하루 마무리로 추천하는 장소입니다.", 3));
        } else {
            spots.add(new AiSpotDTO("로컬 시장", "마지막 날 가볍게 들르기 좋은 장소입니다.", 1));
            spots.add(new AiSpotDTO(style.contains("맛집") ? "현지 대표 음식점" : "브런치 카페", "출발 전 부담 없이 즐기기 좋은 코스입니다.", 2));
            spots.add(new AiSpotDTO(
                    requestText.isBlank() ? "마무리 산책 코스" : "추가 요청 반영 장소",
                    requestText.isBlank() ? "여행을 여유롭게 마무리할 수 있는 장소입니다." : "사용자 요청사항을 반영한 추천 장소입니다.",
                    3
            ));
        }

        return spots;
    }

    private String getThemeByDay(int dayNo, String style) {
        if (dayNo == 1) return "도착 및 가벼운 일정";
        if (dayNo == 2) return "중심 핵심 일정";
        return "여유로운 마무리 일정";
    }

    private String safeValue(String value, String defaultValue) {
        return isBlank(value) ? defaultValue : value.trim();
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}