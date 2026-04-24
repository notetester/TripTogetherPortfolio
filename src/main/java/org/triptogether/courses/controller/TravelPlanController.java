package org.triptogether.courses.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.courses.service.TravelPlanService;
import org.triptogether.courses.vo.TravelPlanVO;
import org.triptogether.explore.service.SpotTextTranslationService;
import org.triptogether.myPage.service.ViewHistoryService;

import java.util.List;

@Controller
@RequestMapping("/courses")
public class TravelPlanController {

    @Autowired
    private TravelPlanService travelPlanService;

    @Autowired
    private SpotTextTranslationService translationService;

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private ViewHistoryService viewHistoryService;

    private Long getLoginUserIdx(HttpSession session) {
        UsersVO loginUser = (UsersVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return null;
        }
        return loginUser.getUserIdx();
    }

    private String msg(String code) {
        return messageSource.getMessage(code, null, LocaleContextHolder.getLocale());
    }

    // 0. 여행 코스 메인 선택 화면
    @GetMapping({"", "/"})
    public String coursesMain() {
        return "courses/main";
    }

    // 기존 /courses/list 접근 시 메인으로 이동
    @GetMapping("/list")
    public String listRedirect() {
        return "redirect:/courses";
    }

    // 1. 내 여행일정 목록
    @GetMapping("/my")
    public String myList(HttpSession session,
                         Model model,
                         RedirectAttributes redirectAttributes) {
        try {
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.loginRequired"));
                return "redirect:/auth/login";
            }

            TravelPlanVO travelPlanVO = new TravelPlanVO();
            travelPlanVO.setUser_idx(userIdx);

            List<TravelPlanVO> travelPlanList = travelPlanService.getTravelList(travelPlanVO);
            translationService.translateTravelPlans(travelPlanList);

            model.addAttribute("travelPlanList", travelPlanList);
            model.addAttribute("loginUserIdx", userIdx);

            return "courses/my";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.myListLoadFailed"));
            return "redirect:/courses";
        }
    }

    // 2. 공개 일정 목록
    @GetMapping("/public")
    public String publicList(HttpSession session,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        try {
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.loginRequired"));
                return "redirect:/auth/login";
            }

            List<TravelPlanVO> travelPlanList = travelPlanService.getPublicTravelList();
            translationService.translateTravelPlans(travelPlanList);

            model.addAttribute("travelPlanList", travelPlanList);
            model.addAttribute("loginUserIdx", userIdx);

            return "courses/public";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.publicListLoadFailed"));
            return "redirect:/courses";
        }
    }

    // 3. 일정 작성 폼
    @GetMapping("/write")
    public String writeForm(HttpSession session,
                            RedirectAttributes redirectAttributes) {
        try {
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.loginRequired"));
                return "redirect:/auth/login";
            }

            return "courses/write";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.writeLoadFailed"));
            return "redirect:/courses";
        }
    }

    // 4. 여행일정 상세 조회
    @GetMapping("/detail")
    public String detail(@RequestParam("planId") Long planId,
                         HttpSession session,
                         Model model,
                         RedirectAttributes redirectAttributes) {
        try {
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.loginRequired"));
                return "redirect:/auth/login";
            }

            TravelPlanVO travelPlan = travelPlanService.getTravelPlanDetailByPlanId(planId);

            if (travelPlan == null) {
                redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.notFound"));
                return "redirect:/courses";
            }

            boolean isOwner = travelPlan.getUser_idx().equals(userIdx);
            boolean isPublic = travelPlan.getIs_public() != null && travelPlan.getIs_public() == 1;

            if (!isOwner && !isPublic) {
                redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.privateOwnerOnly"));
                return "redirect:/courses";
            }

            translationService.translateTravelPlan(travelPlan);

            viewHistoryService.record(userIdx, ViewHistoryService.TYPE_PLAN, planId);

            model.addAttribute("travelPlan", travelPlan);
            model.addAttribute("isOwner", isOwner);

            return "courses/detail";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.detailLoadFailed"));
            return "redirect:/courses";
        }
    }

    // 5. 여행일정 생성
    @PostMapping("/insert")
    public String insertTravelPlan(TravelPlanVO travelPlanVO,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        try {
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.loginRequired"));
                return "redirect:/auth/login";
            }

            travelPlanVO.setUser_idx(userIdx);
            travelPlanVO.setPlan_source("MANUAL");
            travelPlanService.insertTravelPlan(travelPlanVO);

            redirectAttributes.addFlashAttribute("successMessage", msg("course.message.createSuccess"));
            return "redirect:/courses/my";

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/courses/write";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.createFailed"));
            return "redirect:/courses/write";
        }
    }

    // 6. 여행일정 수정 폼
    @GetMapping("/edit")
    public String editForm(@RequestParam("planId") Long planId,
                           HttpSession session,
                           Model model,
                           RedirectAttributes redirectAttributes) {
        try {
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.loginRequired"));
                return "redirect:/auth/login";
            }

            TravelPlanVO paramVO = new TravelPlanVO();
            paramVO.setPlan_id(planId);
            paramVO.setUser_idx(userIdx);

            TravelPlanVO travelPlan = travelPlanService.getTravelPlanDetail(paramVO);

            if (travelPlan == null) {
                redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.editNotFound"));
                return "redirect:/courses/my";
            }

            if (!travelPlan.getUser_idx().equals(userIdx)) {
                redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.ownerEditOnly"));
                return "redirect:/courses/my";
            }

            translationService.translateTravelPlan(travelPlan);

            model.addAttribute("travelPlan", travelPlan);
            return "courses/edit";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.editLoadFailed"));
            return "redirect:/courses/my";
        }
    }

    // 7. 여행일정 수정 저장
    @PostMapping("/edit")
    public String editSubmit(TravelPlanVO travelPlanVO,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        try {
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.loginRequired"));
                return "redirect:/auth/login";
            }

            travelPlanVO.setUser_idx(userIdx);

            if (travelPlanVO.getPlan_source() == null || travelPlanVO.getPlan_source().trim().isEmpty()) {
                travelPlanVO.setPlan_source("MANUAL");
            }

            travelPlanService.editTravelPlan(travelPlanVO);

            redirectAttributes.addFlashAttribute("successMessage", msg("course.message.editSuccess"));
            return "redirect:/courses/detail?planId=" + travelPlanVO.getPlan_id();

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/courses/edit?planId=" + travelPlanVO.getPlan_id();
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.editFailed"));
            return "redirect:/courses/edit?planId=" + travelPlanVO.getPlan_id();
        }
    }

    // 8. 여행일정 삭제
    @PostMapping("/delete")
    public String deleteTravelPlan(@RequestParam("planId") Long planId,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        try {
            Long userIdx = getLoginUserIdx(session);

            if (userIdx == null) {
                redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.loginRequired"));
                return "redirect:/auth/login";
            }

            TravelPlanVO travelPlanVO = new TravelPlanVO();
            travelPlanVO.setPlan_id(planId);
            travelPlanVO.setUser_idx(userIdx);

            travelPlanService.deleteTravelPlan(travelPlanVO);

            redirectAttributes.addFlashAttribute("successMessage", msg("course.message.deleteSuccess"));
            return "redirect:/courses/my";

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/courses/detail?planId=" + planId;
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", msg("course.error.deleteFailed"));
            return "redirect:/courses/detail?planId=" + planId;
        }
    }
}
