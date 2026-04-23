package org.triptogether.myPage.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.triptogether.auth.service.AuthServiceImpl;
import org.triptogether.auth.vo.LoginRequestContext;
import org.triptogether.auth.vo.UsersVO;
import org.triptogether.admin.vo.BusinessAccountApplicationVO;
import org.triptogether.explore.service.SpotTextTranslationService;
import org.triptogether.myPage.service.MyPageService;
import org.triptogether.myPage.service.ViewHistoryService;
import org.triptogether.myPage.vo.FeedNotificationDto;
import org.triptogether.myPage.vo.ViewHistoryItemDto;
import org.triptogether.myPage.vo.MyPageCommunityDto;
import org.triptogether.myPage.vo.MyPageFlightBookingDto;
import org.triptogether.myPage.vo.MyPageInquiryDto;
import org.triptogether.myPage.vo.MyPagePackageBookingDto;
import org.triptogether.myPage.vo.MyPagePlanDto;
import org.triptogether.myPage.vo.MyPageReviewDto;
import org.triptogether.shop.service.ShopService;
import org.triptogether.shop.vo.ShopInventoryItemDto;
import org.triptogether.reward.service.RewardService;
import org.triptogether.myPage.service.WalletService;
import org.triptogether.myPage.vo.WalletMemberGradePolicyDto;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Locale;
import java.util.UUID;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
public class ProfileController {

    private final AuthServiceImpl authService;
    private final MyPageService myPageService;
    private final ShopService shopService;
    private final RewardService rewardService;
    private final WalletService walletService;
    private final SpotTextTranslationService translationService;
    private final ViewHistoryService viewHistoryService;

    // ── 수정 전 비밀번호 확인 페이지 ──────────────
    @GetMapping("/edit-confirm")
    public String editConfirmPage(HttpSession session) {
        UsersVO user = loginUser(session);
        if (user == null) return "redirect:/auth/login";
        // 비밀번호 없는 계정(소셜 전용)은 바로 수정 페이지로
        if (!user.isPasswordEnabled()) return "redirect:/mypage/edit";
        return "mypage/edit-confirm";
    }

    @PostMapping("/edit-confirm")
    @ResponseBody
    public Map<String, Object> checkPassword(@RequestParam String password,
                                             HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) { result.put("success", false); result.put("message", "로그인이 필요합니다."); return result; }

        if (authService.checkPassword(user.getUserIdx(), password)) {
            session.setAttribute("editVerified", true);
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("message", "비밀번호가 올바르지 않습니다.");
        }
        return result;
    }

    // ── 회원정보 수정 페이지 ──────────────────────
    @GetMapping("/edit")
    public String editPage(HttpSession session, Model model) {
        UsersVO user = loginUser(session);
        if (user == null) return "redirect:/auth/login";

        // 항상 최신 사용자 정보를 DB에서 다시 조회
        UsersVO freshUser = authService.getUserByIdx(user.getUserIdx());
        if (freshUser == null) {
            session.invalidate();
            return "redirect:/auth/login";
        }

        // 비밀번호 있는 계정은 확인 절차 거쳤는지 체크
        if (freshUser.isPasswordEnabled() && !Boolean.TRUE.equals(session.getAttribute("editVerified"))) {
            return "redirect:/mypage/edit-confirm";
        }

        // 세션도 최신값으로 갱신
        session.setAttribute("loginUser", freshUser);

        String profileEmailRequestId = (String) session.getAttribute("profileEmailRequestId");
        if (profileEmailRequestId == null || profileEmailRequestId.isBlank()) {
            profileEmailRequestId = UUID.randomUUID().toString();
            session.setAttribute("profileEmailRequestId", profileEmailRequestId);
        }

        Map<String, Boolean> socialLinkMap = authService.getSocialLinkMap(freshUser.getUserIdx());
        long socialCount = socialLinkMap.values().stream().filter(Boolean::booleanValue).count();

        model.addAttribute("profileEmailRequestId", profileEmailRequestId);
        model.addAttribute("user", freshUser);
        model.addAttribute("socialLinkMap", socialLinkMap);
        model.addAttribute("socialCount", socialCount);
        model.addAttribute("hasUsableIdLogin", freshUser.getUserId() != null && !freshUser.getUserId().isBlank() && freshUser.isPasswordEnabled());
        model.addAttribute("hasUsableEmailLogin", freshUser.getUserEmail() != null && !freshUser.getUserEmail().isBlank()
                && freshUser.isEmailVerified() && freshUser.isEmailLoginEnabled() && freshUser.isPasswordEnabled());
        return "mypage/edit";
    }


    // ── 기본 프로필 수정 ──────────────────────────
    @PostMapping("/edit/profile")
    @ResponseBody
    public Map<String, Object> updateProfile(
            @RequestParam String nickname,
            @RequestParam String nationality,
            @RequestParam String preferredLang,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) { result.put("success", false); return result; }

        if (!nickname.equals(user.getNickname()) && authService.isNicknameDuplicate(nickname)) {
            result.put("success", false); result.put("field", "nickname");
            result.put("message", "이미 사용 중인 닉네임입니다."); return result;
        }

        UsersVO update = UsersVO.builder()
                .userIdx(user.getUserIdx())
                .nickname(nickname).nationality(nationality).preferredLang(preferredLang)
                .build();
        authService.updateProfile(update);

        // 세션 갱신
        user.setNickname(nickname); user.setNationality(nationality); user.setPreferredLang(preferredLang);
        result.put("success", true); result.put("message", "프로필이 수정되었습니다.");
        return result;
    }

    // ── 비밀번호 변경 ─────────────────────────────
    @PostMapping("/edit/password")
    @ResponseBody
    public Map<String, Object> updatePassword(
            @RequestParam(required = false) String currentPassword,
            @RequestParam String newPassword,
            HttpServletRequest request,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) { result.put("success", false); return result; }

        if (!user.isPasswordEnabled()) {
            result.put("success", false);
            result.put("message", "비밀번호는 로그인 수단을 추가하는 과정에서 함께 설정해 주세요.");
            return result;
        }

        if (!authService.checkPassword(user.getUserIdx(), currentPassword)) {
            authService.recordPasswordChangeFailure(user.getUserIdx(), buildRequestContext(request), "WRONG_CURRENT_PASSWORD");
            result.put("success", false); result.put("field", "currentPassword");
            result.put("message", "현재 비밀번호가 올바르지 않습니다."); return result;
        }
        if (newPassword.length() < 8) {
            authService.recordPasswordChangeFailure(user.getUserIdx(), buildRequestContext(request), "NEW_PASSWORD_TOO_SHORT");
            result.put("success", false); result.put("message", "새 비밀번호는 8자 이상이어야 합니다."); return result;
        }
        authService.updatePassword(user.getUserIdx(), newPassword, buildRequestContext(request));
        user.setPasswordEnabled(true);
        result.put("success", true); result.put("message", "비밀번호가 변경되었습니다.");
        return result;
    }

    // ── 이메일 인증 메일 발송 ─────────────────────
    @PostMapping("/edit/email/send")
    @ResponseBody
    public Map<String, Object> sendEmailVerification(
            @RequestParam String email,
            HttpServletRequest request,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) { result.put("success", false); return result; }

        if (authService.isEmailDuplicate(email) &&
                (user.getUserEmail() == null || !user.getUserEmail().equals(email))) {
            result.put("success", false); result.put("message", "이미 사용 중인 이메일입니다."); return result;
        }
        String profileEmailRequestId = (String) session.getAttribute("profileEmailRequestId");
        if (profileEmailRequestId == null || profileEmailRequestId.isBlank()) {
            profileEmailRequestId = UUID.randomUUID().toString();
            session.setAttribute("profileEmailRequestId", profileEmailRequestId);
        }

        boolean sent = authService.sendEmailVerification(user.getUserIdx(), profileEmailRequestId, email, buildRequestContext(request));
        if (!sent) {
            result.put("success", false);
            result.put("message", "인증 이메일 발송에 실패했습니다. 잠시 후 다시 시도해주세요.");
            return result;
        }

        result.put("success", true); result.put("message", "인증 이메일을 발송했습니다. 메일을 확인해주세요.");
        return result;
    }

    // ── 이메일 로그인 체크 시점 검증 (실시간 확인용) ─────
    @PostMapping("/edit/email/login-toggle")
    @ResponseBody
    public Map<String, Object> checkEmailLoginToggle(@RequestParam String email, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        String profileEmailRequestId = (String) session.getAttribute("profileEmailRequestId");
        return authService.checkEmailLoginAvailability(user.getUserIdx(), profileEmailRequestId, email);
    }

    @PostMapping("/edit/email/status")
    @ResponseBody
    public Map<String, Object> checkEmailStatus(@RequestParam String email, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }
        String profileEmailRequestId = (String) session.getAttribute("profileEmailRequestId");
        return authService.checkEmailLoginAvailability(user.getUserIdx(), profileEmailRequestId, email);
    }

    // ── 로컬 로그인 수단 저장 ─────────────────────
    @PostMapping("/edit/login-settings")
    @ResponseBody
    public Map<String, Object> saveLoginSettings(@RequestParam(required = false) String userId,
                                                 @RequestParam(required = false) String email,
                                                 @RequestParam(defaultValue = "false") boolean emailLoginEnabled,
                                                 @RequestParam(required = false) String newPassword,
                                                 HttpServletRequest request,
                                                 HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        UsersVO loginUser = loginUser(session);
        if (loginUser == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        UsersVO before = authService.getUserByIdx(loginUser.getUserIdx());
        try {
            String profileEmailRequestId = (String) session.getAttribute("profileEmailRequestId");
            UsersVO after = authService.saveLoginSettings(loginUser.getUserIdx(), profileEmailRequestId, userId, email, emailLoginEnabled, newPassword, buildRequestContext(request));
            session.setAttribute("loginUser", after);
            session.setAttribute("profileEmailRequestId", UUID.randomUUID().toString());

            boolean passwordCleared = before != null && before.isPasswordEnabled() && !after.isPasswordEnabled();
            result.put("success", true);
            result.put("userId", after.getUserId());
            result.put("emailLoginEnabled", after.isEmailLoginEnabled());
            result.put("passwordEnabled", after.isPasswordEnabled());
            result.put("passwordCleared", passwordCleared);
            result.put("message", passwordCleared
                    ? "로그인 수단이 변경되었습니다. 현재 사용할 수 있는 로컬 로그인 수단이 없어 비밀번호가 함께 해제되었습니다. 다시 사용하려면 비밀번호를 새로 설정해 주세요."
                    : "로그인 수단 설정이 저장되었습니다.");
        } catch (IllegalStateException e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    // ── 수정 완료 후 확인 세션 제거 ─────────────────
    @PostMapping("/edit/done")
    public String editDone(HttpSession session) {
        session.removeAttribute("editVerified");
        session.removeAttribute("profileEmailRequestId");
        return "redirect:/mypage";
    }

    // ── 마이페이지 메인 ──────────────────────────

    /**
     * 마이페이지 메인 페이지.
     * 커뮤니티/문의/신고 최근 목록·개수, 알림 목록·개수를 모델에 담아 반환한다.
     */
    @GetMapping("")
    public String myPage(HttpSession session, Model model) {
        UsersVO user = loginUser(session);
        if (user == null) return "redirect:/auth/login";
        UsersVO freshUser = authService.getUserByIdx(user.getUserIdx());
        if (freshUser == null) {
            session.invalidate();
            return "redirect:/auth/login";
        }
        session.setAttribute("loginUser", freshUser);

        List<MyPageCommunityDto> communityList = myPageService.getMyCommunityList(freshUser.getUserIdx());
        List<MyPageInquiryDto> inquiryList = myPageService.getMyInquiryList(freshUser.getUserIdx());
        List<MyPageReviewDto> reviewList = myPageService.getMyReviewList(freshUser.getUserIdx());
        List<MyPagePlanDto> planList = myPageService.getMyPlanList(freshUser.getUserIdx());
        List<FeedNotificationDto> notifications = myPageService.getNotifications(freshUser.getUserIdx());
        List<ShopInventoryItemDto> inventoryItems = shopService.getInventoryItems(freshUser.getUserIdx());
        List<MyPageFlightBookingDto> flightBookingList = myPageService.getMyFlightBookingList(freshUser.getUserIdx());
        List<MyPagePackageBookingDto> packageBookingList = myPageService.getMyPackageBookingList(freshUser.getUserIdx());

        translateMyPageDynamicTexts(
                communityList, inquiryList, reviewList, planList,
                notifications, inventoryItems, flightBookingList, packageBookingList
        );

        model.addAttribute("user",           freshUser);
        model.addAttribute("communityList",  communityList);
        model.addAttribute("communityCount", myPageService.getMyCommunityCount(freshUser.getUserIdx()));
        model.addAttribute("inquiryList",    inquiryList);
        model.addAttribute("inquiryCount",   myPageService.getMyInquiryCount(freshUser.getUserIdx()));
        model.addAttribute("reportList",     myPageService.getMyReportList(freshUser.getUserIdx()));
        model.addAttribute("reportCount",    myPageService.getMyReportCount(freshUser.getUserIdx()));
        model.addAttribute("reviewList",     reviewList);
        model.addAttribute("reviewCount",    myPageService.getMyReviewCount(freshUser.getUserIdx()));
        model.addAttribute("planList",       planList);
        model.addAttribute("planCount",      myPageService.getMyPlanCount(freshUser.getUserIdx()));
        model.addAttribute("flightBookingList", flightBookingList);
        model.addAttribute("flightBookingCount", myPageService.getMyFlightBookingCount(freshUser.getUserIdx()));
        model.addAttribute("packageBookingList", packageBookingList);
        model.addAttribute("packageBookingCount", myPageService.getMyPackageBookingCount(freshUser.getUserIdx()));
        model.addAttribute("viewHistoryList", viewHistoryService.getRecent(freshUser.getUserIdx(), 8));
        model.addAttribute("viewHistoryCount", viewHistoryService.countRecent(freshUser.getUserIdx()));
        model.addAttribute("notifications", notifications);
        model.addAttribute("totalNotificationCount", myPageService.getNotificationCount(freshUser.getUserIdx()));
        model.addAttribute("inventoryItems", inventoryItems);
        model.addAttribute("businessApplication", myPageService.getLatestBusinessApplication(freshUser.getUserIdx()));

        // ── 경험치 바 렌더링용 데이터 ──
        // 현재 레벨에 필요한 누적 경험치 (이 레벨의 시작점)
        long currentLevelExp = rewardService.getRequiredExpForLevel(freshUser.getLevelNo());
        // 다음 레벨에 필요한 누적 경험치 (이 레벨의 끝점 = 다음 레벨 진입 조건)
        long nextLevelExp = rewardService.getRequiredExpForLevel(freshUser.getLevelNo() + 1);
        model.addAttribute("currentLevelExp", currentLevelExp);
        model.addAttribute("nextLevelExp", nextLevelExp);

        // ── 등급 바 렌더링용 데이터 ──
        // 당월 결제 총액 (이번 달에 쌓은 금액 → 다음 달 등급 산정 기준)
        model.addAttribute("currentMonthPayment", walletService.getCurrentMonthPaymentTotal(freshUser.getUserIdx()));
        // 활성 등급 정책 목록 (등급 바의 "다음 등급 기준값" 산출에 사용)
        model.addAttribute("gradePolicies", walletService.getActiveMemberGradePolicies());

        // ── 레벨업 알림 팝업용: 읽지 않은 levelup 알림이 있으면 전달 후 읽음 처리 ──
        List<FeedNotificationDto> allNotifications = myPageService.getNotifications(freshUser.getUserIdx());
        FeedNotificationDto levelUpNoti = null;
        for (FeedNotificationDto noti : allNotifications) {
            if ("levelup".equals(noti.getSourceType()) && !Boolean.TRUE.equals(noti.getIsRead())) {
                levelUpNoti = noti;
                break;
            }
        }
        if (levelUpNoti != null) {
            // 팝업에 표시할 새 레벨 번호를 model에 전달
            model.addAttribute("levelUpLevel", levelUpNoti.getSourceId());
            // 표시했으니 읽음 처리 (한 번만 팝업, 이력은 보존)
            myPageService.markAsRead(levelUpNoti.getNotificationId());
        }

        return "mypage/index";
    }

    /**
     * DB에서 조회된 사용자 생성/운영 데이터는 기존 번역 캐시 테이블을 사용한다.
     * 반면 상태 코드, 버튼, 라벨처럼 고정된 UI 문구는 JSP의 spring:message로 처리한다.
     */
    private void translateMyPageDynamicTexts(List<MyPageCommunityDto> communityList,
                                             List<MyPageInquiryDto> inquiryList,
                                             List<MyPageReviewDto> reviewList,
                                             List<MyPagePlanDto> planList,
                                             List<FeedNotificationDto> notifications,
                                             List<ShopInventoryItemDto> inventoryItems,
                                             List<MyPageFlightBookingDto> flightBookingList,
                                             List<MyPagePackageBookingDto> packageBookingList) {
        String targetLang = resolveTargetLanguage();
        if (targetLang == null) {
            return;
        }

        if (communityList != null) {
            for (MyPageCommunityDto post : communityList) {
                if (post == null) continue;
                Long sourcePk = post.getPostId();
                post.setTitle(translate("MYPAGE_COMMUNITY_POST", sourcePk, "title", post.getTitle(), targetLang));
                post.setRegion(translate("MYPAGE_COMMUNITY_POST", sourcePk, "region", post.getRegion(), targetLang));
            }
        }

        if (inquiryList != null) {
            for (MyPageInquiryDto inquiry : inquiryList) {
                if (inquiry == null) continue;
                inquiry.setTitle(translate("MYPAGE_INQUIRY", inquiry.getInquiryId(), "title", inquiry.getTitle(), targetLang));
            }
        }

        if (reviewList != null) {
            for (MyPageReviewDto review : reviewList) {
                if (review == null) continue;
                review.setSpotName(translate("MYPAGE_REVIEW", review.getReviewIdx(), "spot_name", review.getSpotName(), targetLang));
                review.setContent(translate("MYPAGE_REVIEW", review.getReviewIdx(), "content", review.getContent(), targetLang));
            }
        }

        if (planList != null) {
            for (MyPagePlanDto plan : planList) {
                if (plan == null) continue;
                plan.setTitle(translate("MYPAGE_PLAN", plan.getPlanId(), "title", plan.getTitle(), targetLang));
                plan.setDestination(translate("MYPAGE_PLAN", plan.getPlanId(), "destination", plan.getDestination(), targetLang));
            }
        }

        if (notifications != null) {
            for (FeedNotificationDto notification : notifications) {
                if (notification == null) continue;
                notification.setMessage(translate(
                        "MYPAGE_NOTIFICATION",
                        notification.getNotificationId(),
                        "message",
                        notification.getMessage(),
                        targetLang
                ));
            }
        }

        if (inventoryItems != null) {
            for (ShopInventoryItemDto item : inventoryItems) {
                if (item == null) continue;
                item.setItemName(translate("POINT_SHOP_ITEM", 0L, "item_name", item.getItemName(), targetLang));
                item.setDescription(translate("POINT_SHOP_ITEM", 0L, "description", item.getDescription(), targetLang));
            }
        }

        translateFlightBookings(flightBookingList, targetLang);
        translatePackageBookings(packageBookingList, targetLang);
    }

    private void translateFlightBookings(List<MyPageFlightBookingDto> flightBookingList, String targetLang) {
        if (flightBookingList == null) {
            return;
        }
        for (MyPageFlightBookingDto booking : flightBookingList) {
            if (booking == null) continue;
            booking.setSpotName(translate("MYPAGE_FLIGHT_BOOKING", booking.getFlightPurchaseIdx(), "spot_name", booking.getSpotName(), targetLang));
            booking.setAirlineName(translate("MYPAGE_FLIGHT_BOOKING", booking.getFlightPurchaseIdx(), "airline_name", booking.getAirlineName(), targetLang));
            booking.setReturnAirlineName(translate("MYPAGE_FLIGHT_BOOKING", booking.getFlightPurchaseIdx(), "return_airline_name", booking.getReturnAirlineName(), targetLang));
            booking.setCancelReason(translate("MYPAGE_FLIGHT_BOOKING", booking.getFlightPurchaseIdx(), "cancel_reason", booking.getCancelReason(), targetLang));
        }
    }

    private void translatePackageBookings(List<MyPagePackageBookingDto> packageBookingList, String targetLang) {
        if (packageBookingList == null) {
            return;
        }
        for (MyPagePackageBookingDto booking : packageBookingList) {
            if (booking == null) continue;
            Long sourcePk = booking.getPackageBookingIdx();
            booking.setSpotName(translate("MYPAGE_PACKAGE_BOOKING", sourcePk, "spot_name", booking.getSpotName(), targetLang));
            booking.setPackageTitle(translate("MYPAGE_PACKAGE_BOOKING", sourcePk, "package_title", booking.getPackageTitle(), targetLang));
            booking.setPackageSummary(translate("MYPAGE_PACKAGE_BOOKING", sourcePk, "package_summary", booking.getPackageSummary(), targetLang));
            booking.setSellerNickname(translate("MYPAGE_PACKAGE_BOOKING", sourcePk, "seller_nickname", booking.getSellerNickname(), targetLang));
            booking.setCancelReason(translate("MYPAGE_PACKAGE_BOOKING", sourcePk, "cancel_reason", booking.getCancelReason(), targetLang));
        }
    }

    private String resolveTargetLanguage() {
        Locale locale = LocaleContextHolder.getLocale();
        if (locale == null) {
            return null;
        }
        String language = locale.getLanguage();
        if (language == null || language.isBlank() || "ko".equals(language)) {
            return null;
        }
        return language;
    }

    private String translate(String sourceType, Long sourcePk, String fieldName, String sourceText, String targetLang) {
        return translationService.translateText(sourceType, sourcePk == null ? 0L : sourcePk, fieldName, sourceText, targetLang);
    }

    @PostMapping("/business-application")
    public String submitBusinessApplication(@RequestParam String requestedRole,
                                            @RequestParam String companyName,
                                            @RequestParam(required = false) String businessNumber,
                                            @RequestParam String managerName,
                                            @RequestParam String managerPhone,
                                            @RequestParam(required = false) String description,
                                            HttpSession session,
                                            RedirectAttributes redirectAttributes) {
        UsersVO user = loginUser(session);
        if (user == null) return "redirect:/auth/login";

        BusinessAccountApplicationVO application = new BusinessAccountApplicationVO();
        application.setUserIdx(user.getUserIdx());
        application.setRequestedRole(requestedRole);
        application.setCompanyName(companyName);
        application.setBusinessNumber(businessNumber);
        application.setManagerName(managerName);
        application.setManagerPhone(managerPhone);
        application.setDescription(description);

        try {
            myPageService.submitBusinessApplication(application, user.getUserRole());
            redirectAttributes.addFlashAttribute("businessApplicationMessage", "기업 회원 신청이 접수되었습니다.");
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("businessApplicationError", e.getMessage());
        }

        return "redirect:/mypage";
    }

    @GetMapping("/bookings/flights")
    public String flightBookingHistory(HttpSession session, Model model) {
        UsersVO user = loginUser(session);
        if (user == null) return "redirect:/auth/login";

        UsersVO freshUser = authService.getUserByIdx(user.getUserIdx());
        if (freshUser == null) {
            session.invalidate();
            return "redirect:/auth/login";
        }

        session.setAttribute("loginUser", freshUser);
        model.addAttribute("user", freshUser);
        List<MyPageFlightBookingDto> flightBookingList = myPageService.getMyFlightBookingAllList(freshUser.getUserIdx());
        String targetLang = resolveTargetLanguage();
        if (targetLang != null) {
            translateFlightBookings(flightBookingList, targetLang);
        }
        model.addAttribute("flightBookingList", flightBookingList);
        model.addAttribute("flightBookingCount", myPageService.getMyFlightBookingCount(freshUser.getUserIdx()));
        return "mypage/flight-bookings";
    }

    @GetMapping("/bookings/packages")
    public String packageBookingHistory(HttpSession session, Model model) {
        UsersVO user = loginUser(session);
        if (user == null) return "redirect:/auth/login";

        UsersVO freshUser = authService.getUserByIdx(user.getUserIdx());
        if (freshUser == null) {
            session.invalidate();
            return "redirect:/auth/login";
        }

        session.setAttribute("loginUser", freshUser);
        model.addAttribute("user", freshUser);
        List<MyPagePackageBookingDto> packageBookingList = myPageService.getMyPackageBookingAllList(freshUser.getUserIdx());
        String targetLang = resolveTargetLanguage();
        if (targetLang != null) {
            translatePackageBookings(packageBookingList, targetLang);
        }
        model.addAttribute("packageBookingList", packageBookingList);
        model.addAttribute("packageBookingCount", myPageService.getMyPackageBookingCount(freshUser.getUserIdx()));
        return "mypage/package-bookings";
    }

    @PostMapping("/items/equip")
    public String equipPointItem(@RequestParam String itemCode,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        UsersVO user = loginUser(session);
        if (user == null) return "redirect:/auth/login";

        try {
            shopService.equipItem(user.getUserIdx(), itemCode);
            redirectAttributes.addFlashAttribute("itemMessage", "아이템을 장착했습니다.");
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("itemError", e.getMessage());
        }

        return "redirect:/mypage";
    }

    @PostMapping("/items/unequip")
    public String unequipPointItem(@RequestParam String equipSlot,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        UsersVO user = loginUser(session);
        if (user == null) return "redirect:/auth/login";

        try {
            shopService.unequipItem(user.getUserIdx(), equipSlot);
            redirectAttributes.addFlashAttribute("itemMessage", "아이템 장착을 해제했습니다.");
        } catch (IllegalArgumentException | IllegalStateException e) {
            redirectAttributes.addFlashAttribute("itemError", e.getMessage());
        }

        return "redirect:/mypage";
    }

    // ── 유틸 ──────────────────────────────────────
    private LoginRequestContext buildRequestContext(HttpServletRequest request) {
        return LoginRequestContext.builder()
                .ipAddress(getClientIp(request))
                .userAgent(request.getHeader("User-Agent"))
                .build();
    }

    private String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }
        return ip;
    }

    private UsersVO loginUser(HttpSession session) {
        return (UsersVO) session.getAttribute("loginUser");
    }

    // ── 최근 조회 내역 ─────────────────────────────

    @GetMapping("/history")
    public String viewHistoryPage(HttpSession session, Model model) {
        UsersVO user = loginUser(session);
        if (user == null) return "redirect:/auth/login";

        List<ViewHistoryItemDto> list = viewHistoryService.getRecent(user.getUserIdx(), 50);
        model.addAttribute("user", user);
        model.addAttribute("historyList", list);
        model.addAttribute("historyCount", list.size());
        return "myPage/history";
    }

    @PostMapping("/history/{historyIdx}/delete")
    @ResponseBody
    public Map<String, Object> deleteHistoryOne(@PathVariable Long historyIdx, HttpSession session) {
        Map<String, Object> res = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) {
            res.put("success", false);
            res.put("message", "login required");
            return res;
        }
        int affected = viewHistoryService.deleteOne(user.getUserIdx(), historyIdx);
        res.put("success", affected > 0);
        return res;
    }

    @PostMapping("/history/clear")
    @ResponseBody
    public Map<String, Object> clearHistory(HttpSession session) {
        Map<String, Object> res = new HashMap<>();
        UsersVO user = loginUser(session);
        if (user == null) {
            res.put("success", false);
            res.put("message", "login required");
            return res;
        }
        int affected = viewHistoryService.deleteAll(user.getUserIdx());
        res.put("success", true);
        res.put("deleted", affected);
        return res;
    }
}
