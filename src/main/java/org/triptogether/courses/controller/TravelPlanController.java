package org.triptogether.courses.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.courses.service.TravelPlanService;
import org.triptogether.courses.vo.SpotTravelVO;
import org.triptogether.courses.vo.TravelPlanVO;

import java.util.List;

@Controller
@RequestMapping("/courses")
public class TravelPlanController {

    @Autowired
    private TravelPlanService travelPlanService;

    private Long getLoginUserIdx(HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return null;
        }
        return loginUser.getUserIdx();
    }

    // 1. 내 여행일정 목록 조회
    @GetMapping("/list")
    public String list(HttpSession session, Model model) {
        Long userIdx = getLoginUserIdx(session);

        if (userIdx == null) {
            return "redirect:/auth/login";
        }

        TravelPlanVO travelPlanVO = new TravelPlanVO();
        travelPlanVO.setUser_idx(userIdx);

        List<TravelPlanVO> travelPlanList = travelPlanService.getTravelList(travelPlanVO);
        model.addAttribute("travelPlanList", travelPlanList);

        return "courses/list";
    }

    // 일정 작성 폼
    @GetMapping("/write")
    public String writeForm(HttpSession session, Model model) {
        Long userIdx = getLoginUserIdx(session);

        if (userIdx == null) {
            return "redirect:/auth/login";
        }

        List<SpotTravelVO> spotTravelList = travelPlanService.getSpotTravelList();
        model.addAttribute("spotTravelList", spotTravelList);

        return "courses/write";
    }

    // 2. 여행일정 상세 조회
    @GetMapping("/detail")
    public String detail(@RequestParam("planId") Long planId,
                         HttpSession session,
                         Model model) {
        Long userIdx = getLoginUserIdx(session);

        if (userIdx == null) {
            return "redirect:/auth/login";
        }

        TravelPlanVO travelPlanVO = new TravelPlanVO();
        travelPlanVO.setPlan_id(planId);
        travelPlanVO.setUser_idx(userIdx);

        TravelPlanVO travelPlan = travelPlanService.getTravelPlanDetail(travelPlanVO);

        if (travelPlan == null) {
            return "redirect:/courses/list";
        }

        // 수정까지 고려해서 전체 여행지 목록도 같이 넘김
        List<SpotTravelVO> spotTravelList = travelPlanService.getSpotTravelList();

        model.addAttribute("travelPlan", travelPlan);
        model.addAttribute("spotTravelList", spotTravelList);

        return "courses/detail";
    }

    // 3. 여행일정 생성
    @PostMapping("/insert")
    public String insertTravelPlan(TravelPlanVO travelPlanVO, HttpSession session) {
        Long userIdx = getLoginUserIdx(session);

        if (userIdx == null) {
            return "redirect:/auth/login";
        }

        travelPlanVO.setUser_idx(userIdx);
        travelPlanService.insertTravelPlan(travelPlanVO);

        return "redirect:/courses/list";
    }

    // 4. 여행일정 수정
    @PostMapping("/update")
    public String updateTravelPlan(TravelPlanVO travelPlanVO, HttpSession session) {
        Long userIdx = getLoginUserIdx(session);

        if (userIdx == null) {
            return "redirect:/auth/login";
        }

        travelPlanVO.setUser_idx(userIdx);
        travelPlanService.updateTravelPlan(travelPlanVO);

        return "redirect:/courses/detail?planId=" + travelPlanVO.getPlan_id();
    }

    // 5. 여행일정 삭제
    @PostMapping("/delete")
    public String deleteTravelPlan(@RequestParam("planId") Long planId,
                                   HttpSession session) {
        Long userIdx = getLoginUserIdx(session);

        if (userIdx == null) {
            return "redirect:/auth/login";
        }

        TravelPlanVO travelPlanVO = new TravelPlanVO();
        travelPlanVO.setPlan_id(planId);
        travelPlanVO.setUser_idx(userIdx);

        travelPlanService.deleteTravelPlan(travelPlanVO);

        return "redirect:/courses/list";
    }
}