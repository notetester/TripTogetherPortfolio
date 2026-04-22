package org.triptogether.travelPackage.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.travelPackage.service.TravelPackageService;
import org.triptogether.travelPackage.vo.TravelPackageForm;
import org.triptogether.travelPackage.vo.TravelPackageVO;

@Controller
@RequiredArgsConstructor
@RequestMapping("/packages")
public class TravelPackageController {

    private final TravelPackageService travelPackageService;

    @GetMapping("")
    public String packageList(Model model) {
        model.addAttribute("packageList", travelPackageService.getApprovedPackages());
        return "packages/list";
    }

    @GetMapping("/manage")
    public String managePage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        UsersVO loginUser = getLoginUser(session);
        if (!canManagePackage(loginUser, redirectAttributes)) {
            return redirectByAuthState(loginUser);
        }

        model.addAttribute("packageList", travelPackageService.getSellerPackages(loginUser.getUserIdx()));
        return "packages/manage";
    }

    @GetMapping("/manage/write")
    public String writeForm(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        UsersVO loginUser = getLoginUser(session);
        if (!canManagePackage(loginUser, redirectAttributes)) {
            return redirectByAuthState(loginUser);
        }

        model.addAttribute("formMode", "CREATE");
        model.addAttribute("packageForm", new TravelPackageForm());
        model.addAttribute("spotOptions", travelPackageService.getSpotOptions());
        return "packages/form";
    }

    @PostMapping("/manage/write")
    public String createPackage(@ModelAttribute TravelPackageForm packageForm,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        UsersVO loginUser = getLoginUser(session);
        if (!canManagePackage(loginUser, redirectAttributes)) {
            return redirectByAuthState(loginUser);
        }

        try {
            travelPackageService.createPackage(loginUser.getUserIdx(), packageForm);
            redirectAttributes.addFlashAttribute("packageMessage", createSavedMessage(packageForm.getAction()));
            return "redirect:/packages/manage";
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("packageError", e.getMessage());
            return "redirect:/packages/manage/write";
        }
    }

    @GetMapping("/manage/{packageIdx}/edit")
    public String editForm(@PathVariable Long packageIdx,
                           HttpSession session,
                           Model model,
                           RedirectAttributes redirectAttributes) {
        UsersVO loginUser = getLoginUser(session);
        if (!canManagePackage(loginUser, redirectAttributes)) {
            return redirectByAuthState(loginUser);
        }

        try {
            TravelPackageVO travelPackage = travelPackageService.getSellerPackage(packageIdx, loginUser.getUserIdx());
            model.addAttribute("formMode", "EDIT");
            model.addAttribute("packageForm", toForm(travelPackage));
            model.addAttribute("spotOptions", travelPackageService.getSpotOptions());
            return "packages/form";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("packageError", e.getMessage());
            return "redirect:/packages/manage";
        }
    }

    @PostMapping("/manage/{packageIdx}/edit")
    public String updatePackage(@PathVariable Long packageIdx,
                                @ModelAttribute TravelPackageForm packageForm,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        UsersVO loginUser = getLoginUser(session);
        if (!canManagePackage(loginUser, redirectAttributes)) {
            return redirectByAuthState(loginUser);
        }

        try {
            packageForm.setPackageIdx(packageIdx);
            travelPackageService.updatePackage(loginUser.getUserIdx(), packageForm);
            redirectAttributes.addFlashAttribute("packageMessage", createSavedMessage(packageForm.getAction()));
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("packageError", e.getMessage());
        }
        return "redirect:/packages/manage";
    }

    @PostMapping("/manage/{packageIdx}/submit")
    public String submitPackage(@PathVariable Long packageIdx,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        UsersVO loginUser = getLoginUser(session);
        if (!canManagePackage(loginUser, redirectAttributes)) {
            return redirectByAuthState(loginUser);
        }

        try {
            travelPackageService.submitPackage(loginUser.getUserIdx(), packageIdx);
            redirectAttributes.addFlashAttribute("packageMessage", "관리자 승인 요청이 완료되었습니다.");
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("packageError", e.getMessage());
        }
        return "redirect:/packages/manage";
    }

    private UsersVO getLoginUser(HttpSession session) {
        return (UsersVO) session.getAttribute("loginUser");
    }

    private boolean canManagePackage(UsersVO loginUser, RedirectAttributes redirectAttributes) {
        if (loginUser == null) {
            redirectAttributes.addFlashAttribute("loginMessage", "로그인이 필요합니다.");
            return false;
        }
        if (!loginUser.canManagePackage()) {
            redirectAttributes.addFlashAttribute("packageError", "비즈니스 또는 파트너 회원만 패키지 상품을 관리할 수 있습니다.");
            return false;
        }
        return true;
    }

    private String redirectByAuthState(UsersVO loginUser) {
        return loginUser == null ? "redirect:/auth/login" : "redirect:/mypage";
    }

    private String createSavedMessage(String action) {
        if ("PENDING".equalsIgnoreCase(action)) {
            return "패키지 상품이 저장되고 관리자 승인 요청 상태로 변경되었습니다.";
        }
        return "패키지 상품이 임시저장되었습니다.";
    }

    private TravelPackageForm toForm(TravelPackageVO travelPackage) {
        TravelPackageForm form = new TravelPackageForm();
        form.setPackageIdx(travelPackage.getPackageIdx());
        form.setSpotIdx(travelPackage.getSpotIdx());
        form.setPackageTitle(travelPackage.getPackageTitle());
        form.setPackageSummary(travelPackage.getPackageSummary());
        form.setPackageContent(travelPackage.getPackageContent());
        form.setPackagePrice(travelPackage.getPackagePrice());
        form.setCurrencyCode(travelPackage.getCurrencyCode());
        form.setStartDate(travelPackage.getStartDate());
        form.setEndDate(travelPackage.getEndDate());
        form.setMinPeople(travelPackage.getMinPeople());
        form.setMaxPeople(travelPackage.getMaxPeople());
        form.setMainImagePath(travelPackage.getMainImagePath());
        form.setAction("DRAFT");
        return form;
    }
}
