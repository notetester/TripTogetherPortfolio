package org.triptogether.courses.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
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
    public String list(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try{
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "로그인 후 이용해주세요.");
                return "redirect:/auth/login";
            }

            TravelPlanVO travelPlanVO = new TravelPlanVO();
            travelPlanVO.setUser_idx(userIdx);

            List<TravelPlanVO> travelPlanList = travelPlanService.getTravelList(travelPlanVO);
            model.addAttribute("travelPlanList", travelPlanList);

            return "courses/list";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "여행 일정 목록 조회 중 오류가 발생했습니다.");
            return "redirect:/";
        }

    }

    // 일정 작성 폼
    @GetMapping("/write")
    public String writeForm(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        try{
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "로그인 후 이용해주세요.");
                return "redirect:/auth/login";
            }

            List<SpotTravelVO> spotTravelList = travelPlanService.getSpotTravelList();
            model.addAttribute("spotTravelList", spotTravelList);

            return "courses/write";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "일정 작성 페이지를 불러오는 중 오류가 발생했습니다.");
            return "redirect:/courses/list";
        }
    }

    // 2. 여행일정 상세 조회
    @GetMapping("/detail")
    public String detail(@RequestParam("planId") Long planId,
                         HttpSession session,
                         Model model,
                         RedirectAttributes redirectAttributes) {
        try{
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "로그인 후 이용해주세요.");
                return "redirect:/auth/login";
            }

            TravelPlanVO travelPlanVO = new TravelPlanVO();
            travelPlanVO.setPlan_id(planId);
            travelPlanVO.setUser_idx(userIdx);

            TravelPlanVO travelPlan = travelPlanService.getTravelPlanDetail(travelPlanVO);

            if (travelPlan == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "해당 여행 일정을 찾을 수 없습니다.");
                return "redirect:/courses/list";
            }

            // 수정까지 고려해서 전체 여행지 목록도 같이 넘김
            List<SpotTravelVO> spotTravelList = travelPlanService.getSpotTravelList();

            model.addAttribute("travelPlan", travelPlan);
            model.addAttribute("spotTravelList", spotTravelList);

            return "courses/detail";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "여행 일정 상세 조회 중 오류가 발생했습니다.");
            return "redirect:/courses/list";
        }
    }

    // 3. 여행일정 생성
    @PostMapping("/insert")
    public String insertTravelPlan(TravelPlanVO travelPlanVO,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        try{
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "로그인 후 이용해주세요.");
                return "redirect:/auth/login";
            }

            travelPlanVO.setUser_idx(userIdx);
            travelPlanService.insertTravelPlan(travelPlanVO);

            redirectAttributes.addFlashAttribute("successMessage", "여행 일정이 등록되었습니다.");
            return "redirect:/courses/list";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/courses/write";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "여행 일정 등록 중 오류가 발생했습니다.");
            return "redirect:/courses/write";
        }
    }

    // 4. 여행일정 수정
    @GetMapping("/edit")
    public String editTravelPlan(@RequestParam("planId") Long planId,
                                 HttpSession session,
                                 Model model,
                                 RedirectAttributes redirectAttributes) {
        try {
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "로그인 후 이용해주세요.");
                return "redirect:/auth/login";
            }

            TravelPlanVO paramVO = new TravelPlanVO();
            paramVO.setPlan_id(planId);
            paramVO.setUser_idx(userIdx);

            TravelPlanVO travelPlan = travelPlanService.getTravelPlanDetail(paramVO);

            if (travelPlan == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "수정할 여행 일정을 찾을 수 없습니다.");
                return "redirect:/courses/list";
            }

            if (!travelPlan.getUser_idx().equals(userIdx)) {
                redirectAttributes.addFlashAttribute("errorMessage", "본인의 여행 일정만 수정할 수 있습니다.");
                return "redirect:/courses/list";
            }

            List<SpotTravelVO> spotTravelList = travelPlanService.getSpotTravelList();
            model.addAttribute("travelPlan", travelPlan);
            model.addAttribute("spotTravelList", spotTravelList);

            return "courses/edit";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "여행 일정 수정 페이지를 불러오는 중 오류가 발생했습니다.");
            return "redirect:/courses/list";
        }
    }

    // 수정 저장
    @PostMapping("/edit")
    public String editTravelPlan(TravelPlanVO travelPlanVO,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        try{
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "로그인 후 이용해주세요.");
                return "redirect:/auth/login";
            }

            travelPlanVO.setUser_idx(userIdx);
            travelPlanService.editTravelPlan(travelPlanVO);

            redirectAttributes.addFlashAttribute("successMessage", "여행 일정이 수정되었습니다.");
            return "redirect:/courses/detail?planId=" + travelPlanVO.getPlan_id();

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/courses/edit?planId=" + travelPlanVO.getPlan_id();
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "여행 일정 수정 중 오류가 발생했습니다.");
            return "redirect:/courses/edit?planId=" + travelPlanVO.getPlan_id();
        }
    }


    // 5. 여행일정 삭제
    @PostMapping("/delete")
    public String deleteTravelPlan(@RequestParam("planId") Long planId,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        try {
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "로그인 후 이용해주세요.");
                return "redirect:/auth/login";
            }

            TravelPlanVO travelPlanVO = new TravelPlanVO();
            travelPlanVO.setPlan_id(planId);
            travelPlanVO.setUser_idx(userIdx);

            travelPlanService.deleteTravelPlan(travelPlanVO);

            redirectAttributes.addFlashAttribute("successMessage", "여행 일정이 삭제되었습니다.");
            return "redirect:/courses/list";

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/courses/detail?planId=" + planId;
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("successMessage", "여행 일정 삭제 중 오류가 발생했습니다.");
            return "redirect:/courses/detail?planId=" + planId;
        }
    }
}