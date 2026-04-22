package org.triptogether.travelPackage.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.travelPackage.service.TravelPackageService;
import org.triptogether.travelPackage.vo.PackageBookingRequestVO;
import org.triptogether.travelPackage.vo.PackageBookingResultVO;
import org.triptogether.travelPackage.vo.TravelPackageForm;
import org.triptogether.travelPackage.vo.TravelPackageVO;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/packages")
public class TravelPackageController {

    private final TravelPackageService travelPackageService;
    private final MessageSource messageSource;

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
            model.addAttribute("formMode", "APPROVED".equals(travelPackage.getPackageStatus()) ? "REVISION" : "EDIT");
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
            TravelPackageVO currentPackage = travelPackageService.getSellerPackage(packageIdx, loginUser.getUserIdx());
            boolean revisionRequest = "APPROVED".equals(currentPackage.getPackageStatus());
            packageForm.setPackageIdx(packageIdx);
            travelPackageService.updatePackage(loginUser.getUserIdx(), packageForm);
            redirectAttributes.addFlashAttribute("packageMessage",
                    revisionRequest ? "패키지 수정 요청이 관리자 검토 대기 상태로 등록되었습니다." : createSavedMessage(packageForm.getAction()));
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

    @PostMapping("/{packageIdx}/book")
    @ResponseBody
    public Map<String, Object> bookPackage(@PathVariable Long packageIdx,
                                           @RequestBody PackageBookingRequestVO request,
                                           HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO loginUser = getLoginUser(session);
        if (loginUser == null) {
            result.put("success", false);
            result.put("loginRequired", true);
            result.put("message", message("package.booking.loginRequired"));
            return result;
        }

        try {
            request.setPackageIdx(packageIdx);
            PackageBookingResultVO bookingResult = travelPackageService.bookPackage(loginUser.getUserIdx(), request);
            session.setAttribute("loginUser", bookingResult.getUser());
            result.put("success", true);
            result.put("message", message("package.booking.success"));
            result.put("bookingNo", bookingResult.getBookingNo());
            result.put("totalPrice", bookingResult.getTotalPrice());
            result.put("usedCash", bookingResult.getUsedCash());
            result.put("usedMileage", bookingResult.getUsedMileage());
            result.put("cashBalance", bookingResult.getUser().getCashBalance());
            result.put("mileageBalance", bookingResult.getUser().getMileageBalance());
        } catch (IllegalArgumentException | IllegalStateException e) {
            result.put("success", false);
            result.put("message", message(e.getMessage()));
        }
        return result;
    }

    @PostMapping("/bookings/{packageBookingIdx}/cancel")
    public String cancelPackageBooking(@PathVariable Long packageBookingIdx,
                                       @RequestParam(required = false) String cancelReason,
                                       HttpSession session,
                                       RedirectAttributes redirectAttributes) {
        UsersVO loginUser = getLoginUser(session);
        if (loginUser == null) {
            return "redirect:/auth/login";
        }

        try {
            UsersVO updatedUser = travelPackageService.cancelPackageBooking(loginUser.getUserIdx(), packageBookingIdx, cancelReason);
            session.setAttribute("loginUser", updatedUser);
            redirectAttributes.addFlashAttribute("packageBookingMessage", "패키지 예약이 취소되고 사용한 캐시/마일리지가 환불되었습니다.");
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("packageBookingError", e.getMessage());
        }
        return "redirect:/mypage/bookings/packages";
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

    private String message(String codeOrMessage) {
        return messageSource.getMessage(codeOrMessage, null, codeOrMessage, LocaleContextHolder.getLocale());
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
