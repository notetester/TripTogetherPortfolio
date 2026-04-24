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
/* ??? ??, ??, ???? ?? ?? ???? ?? ??? ?? ???? ??? */
import org.triptogether.explore.service.SpotTextTranslationService;
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
    private static final int PACKAGE_LIST_PAGE_SIZE = 9;
    private static final int PACKAGE_LIST_PAGE_BLOCK_SIZE = 5;

    private final TravelPackageService travelPackageService;
    /* ??? ?? ???? ??? ????, ????? ?? ?? ???? ?? */
    private final SpotTextTranslationService translationService;
    private final MessageSource messageSource;

    @GetMapping("")
    public String packageList(@RequestParam(defaultValue = "1") int page,
                              @RequestParam(required = false) String keyword,
                              Model model) {
        String normalizedKeyword = keyword != null ? keyword.trim() : "";
        int totalCount = travelPackageService.countApprovedPackages(normalizedKeyword);
        int totalPages = totalCount == 0 ? 1 : (int) Math.ceil((double) totalCount / PACKAGE_LIST_PAGE_SIZE);
        int currentPage = Math.max(1, page);
        if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        java.util.List<TravelPackageVO> packages =
                travelPackageService.getApprovedPackages(normalizedKeyword, currentPage, PACKAGE_LIST_PAGE_SIZE);
        // ???? ?????? ??? ??? ????? ???? ????.
        translationService.translatePackages(packages);

        int startPage = Math.max(1, currentPage - (PACKAGE_LIST_PAGE_BLOCK_SIZE / 2));
        int endPage = Math.min(totalPages, startPage + PACKAGE_LIST_PAGE_BLOCK_SIZE - 1);
        startPage = Math.max(1, endPage - PACKAGE_LIST_PAGE_BLOCK_SIZE + 1);

        model.addAttribute("packageList", packages);
        model.addAttribute("keyword", normalizedKeyword);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        return "packages/list";
    }

    @GetMapping("/manage")
    public String managePage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        UsersVO loginUser = getLoginUser(session);
        if (!canManagePackage(loginUser, redirectAttributes)) {
            return redirectByAuthState(loginUser);
        }

        // ??? ?? ????? ????? ????? ?? ??? ?? ????.
        java.util.List<TravelPackageVO> packages = travelPackageService.getSellerPackages(loginUser.getUserIdx());
        translationService.translatePackages(packages);
        model.addAttribute("packageList", packages);
        return "packages/manage";
    }

    @GetMapping("/manage/write")
    public String writeForm(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        UsersVO loginUser = getLoginUser(session);
        if (!canManagePackage(loginUser, redirectAttributes)) {
            return redirectByAuthState(loginUser);
        }

        // ??? ?? ???? ??? ?? ?? ???? ????.
        java.util.List<org.triptogether.travelPackage.vo.PackageSpotOptionVO> spotOptions = travelPackageService.getSpotOptions();
        translationService.translateSpotOptions(spotOptions);

        model.addAttribute("formMode", "CREATE");
        model.addAttribute("packageForm", new TravelPackageForm());
        model.addAttribute("spotOptions", spotOptions);
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

            // ── 여행지 드롭다운의 이름/지역을 현재 로케일에 맞게 번역 ──
            java.util.List<org.triptogether.travelPackage.vo.PackageSpotOptionVO> spotOptions = travelPackageService.getSpotOptions();
            translationService.translateSpotOptions(spotOptions);
            model.addAttribute("spotOptions", spotOptions);

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
                    revisionRequest ? message("package.message.revisionSubmitted") : createSavedMessage(packageForm.getAction()));
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
            redirectAttributes.addFlashAttribute("packageMessage", message("package.message.submitCompleted"));
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
            redirectAttributes.addFlashAttribute("packageBookingMessage", message("package.message.bookingCancelled"));
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
            redirectAttributes.addFlashAttribute("loginMessage", message("package.message.loginRequired"));
            return false;
        }
        if (!loginUser.canManagePackage()) {
            redirectAttributes.addFlashAttribute("packageError", message("package.message.noPermission"));
            return false;
        }
        return true;
    }

    private String redirectByAuthState(UsersVO loginUser) {
        return loginUser == null ? "redirect:/auth/login" : "redirect:/mypage";
    }

    private String createSavedMessage(String action) {
        if ("PENDING".equalsIgnoreCase(action)) {
            return message("package.message.savedAndSubmitted");
        }
        return message("package.message.savedDraft");
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
