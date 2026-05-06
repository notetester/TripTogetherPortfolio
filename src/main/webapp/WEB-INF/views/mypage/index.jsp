<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_mypage_notifications_delete" code="mypage.notifications.delete"/>
<spring:message var="msg_mypage_history_relative_justNow_js" code="mypage.history.relative.justNow" javaScriptEscape="true"/>
<spring:message var="msg_mypage_history_relative_minutes_js" code="mypage.history.relative.minutes" javaScriptEscape="true"/>
<spring:message var="msg_mypage_history_relative_hours_js" code="mypage.history.relative.hours" javaScriptEscape="true"/>
<spring:message var="msg_mypage_history_relative_yesterday_js" code="mypage.history.relative.yesterday" javaScriptEscape="true"/>
<spring:message var="msg_mypage_history_relative_days_js" code="mypage.history.relative.days" javaScriptEscape="true"/>
<spring:message var="msg_mypage_common_close" code="mypage.common.close"/>
<spring:message var="msg_mypage_common_status_reserved" code="mypage.common.status.reserved"/>
<spring:message var="msg_mypage_common_status_booked" code="mypage.common.status.booked"/>
<spring:message var="msg_mypage_common_status_cancelled" code="mypage.common.status.cancelled"/>
<spring:message var="msg_mypage_common_status_completed" code="mypage.common.status.completed"/>
<spring:message var="msg_mypage_booking_cancelPlaceholder" code="mypage.booking.cancelPlaceholder"/>
<spring:message var="msg_mypage_asset_points" code="mypage.asset.points"/>
<spring:message var="msg_mypage_asset_mileage" code="mypage.asset.mileage"/>
<spring:message var="msg_mypage_asset_cash" code="mypage.asset.cash"/>
<spring:message var="msg_mypage_business_placeholder_companyName" code="mypage.business.placeholder.companyName"/>
<spring:message var="msg_mypage_business_placeholder_optional" code="mypage.business.placeholder.optional"/>
<spring:message var="msg_mypage_business_placeholder_managerName" code="mypage.business.placeholder.managerName"/>
<spring:message var="msg_mypage_business_placeholder_managerPhone" code="mypage.business.placeholder.managerPhone"/>
<spring:message var="msg_mypage_business_placeholder_description" code="mypage.business.placeholder.description"/>
<spring:message var="msg_mypage_notifications_deleteAllConfirm" code="mypage.notifications.deleteAllConfirm"/>
<spring:message var="msg_mypage_grade_name_bronze" code="mypage.grade.name.bronze"/>
<spring:message var="msg_mypage_grade_name_silver" code="mypage.grade.name.silver"/>
<spring:message var="msg_mypage_grade_name_gold" code="mypage.grade.name.gold"/>
<spring:message var="msg_mypage_grade_name_diamond" code="mypage.grade.name.diamond"/>
<spring:message var="msg_mypage_grade_name_platinum" code="mypage.grade.name.platinum"/>
<spring:message var="msg_mypage_lang_en" code="mypage.lang.en"/>
<spring:message var="msg_mypage_lang_ja" code="mypage.lang.ja"/>
<spring:message var="msg_mypage_lang_zh" code="mypage.lang.zh"/>
<spring:message var="msg_mypage_level_badge" code="mypage.level.badge"/>
<spring:message var="msg_mypage_level_expUnit" code="mypage.level.expUnit"/>
<spring:message var="msg_mypage_level_prefix" code="mypage.level.prefix"/>
<spring:message var="msg_mypage_levelup_title" code="mypage.levelup.title"/>
<spring:message var="msg_mypage_items_emptyIcon" code="mypage.items.emptyIcon"/>
<spring:message var="msg_mypage_items_icon" code="mypage.items.icon"/>
<spring:message var="msg_mypage_items_packageIcon" code="mypage.items.packageIcon"/>
<spring:message var="msg_mypage_country_kr" code="mypage.country.kr"/>
<spring:message var="msg_mypage_country_us" code="mypage.country.us"/>
<spring:message var="msg_mypage_country_jp" code="mypage.country.jp"/>
<spring:message var="msg_mypage_country_cn" code="mypage.country.cn"/>
<spring:message var="msg_mypage_country_gb" code="mypage.country.gb"/>
<spring:message var="msg_mypage_country_fr" code="mypage.country.fr"/>
<spring:message var="msg_mypage_country_de" code="mypage.country.de"/>
<spring:message var="msg_mypage_country_au" code="mypage.country.au"/>
<spring:message var="msg_mypage_country_ca" code="mypage.country.ca"/>
<spring:message var="msg_mypage_lang_ko" code="mypage.lang.ko"/>
<spring:message var="msg_mypage_profile_edit" code="mypage.profile.edit"/>
<spring:message var="msg_mypage_summary_title" code="mypage.summary.title"/>
<spring:message var="msg_mypage_summary_memberGrade" code="mypage.summary.memberGrade"/>
<spring:message var="msg_mypage_summary_verifiedMember" code="mypage.summary.verifiedMember"/>
<spring:message var="msg_mypage_summary_verified" code="mypage.summary.verified"/>
<spring:message var="msg_mypage_summary_unverified" code="mypage.summary.unverified"/>
<spring:message var="msg_mypage_summary_levelExp" code="mypage.summary.levelExp"/>
<spring:message var="msg_mypage_summary_postCount" code="mypage.summary.postCount"/>
<spring:message var="msg_mypage_summary_commentCount" code="mypage.summary.commentCount"/>
<spring:message var="msg_mypage_gradeAsset_title" code="mypage.gradeAsset.title"/>
<spring:message var="msg_mypage_grade_maxReached" code="mypage.grade.maxReached"/>
<spring:message var="msg_mypage_grade_next" code="mypage.grade.next"/>
<spring:message var="msg_mypage_grade_thisMonthPaymentPrefix" code="mypage.grade.thisMonthPaymentPrefix"/>
<spring:message var="msg_mypage_grade_thisMonthPaymentSuffix" code="mypage.grade.thisMonthPaymentSuffix"/>
<spring:message var="msg_mypage_stats_community" code="mypage.stats.community"/>
<spring:message var="msg_mypage_stats_posts" code="mypage.stats.posts"/>
<spring:message var="msg_mypage_stats_comments" code="mypage.stats.comments"/>
<spring:message var="msg_mypage_stats_explore" code="mypage.stats.explore"/>
<spring:message var="msg_mypage_stats_reviews" code="mypage.stats.reviews"/>
<spring:message var="msg_mypage_stats_courses" code="mypage.stats.courses"/>
<spring:message var="msg_mypage_stats_travelCourses" code="mypage.stats.travelCourses"/>
<spring:message var="msg_mypage_reward_status_claimed" code="mypage.reward.status.claimed"/>
<spring:message var="msg_mypage_reward_status_pending" code="mypage.reward.status.pending"/>
<spring:message var="msg_mypage_reward_status_locked" code="mypage.reward.status.locked"/>
<spring:message var="msg_mypage_reward_empty" code="mypage.reward.empty"/>
<spring:message var="msg_mypage_profile_title" code="mypage.profile.title"/>
<spring:message var="msg_mypage_nickname" code="mypage.nickname"/>
<spring:message var="msg_mypage_profile_userId" code="mypage.profile.userId"/>
<spring:message var="msg_mypage_profile_socialOnly" code="mypage.profile.socialOnly"/>
<spring:message var="msg_mypage_nationality" code="mypage.nationality"/>
<spring:message var="msg_mypage_language" code="mypage.language"/>
<spring:message var="msg_mypage_profile_email" code="mypage.profile.email"/>
<spring:message var="msg_mypage_profile_emailVerified" code="mypage.profile.emailVerified"/>
<spring:message var="msg_mypage_profile_notRegistered" code="mypage.profile.notRegistered"/>
<spring:message var="msg_mypage_profile_accountStatus" code="mypage.profile.accountStatus"/>
<spring:message var="msg_mypage_profile_active" code="mypage.profile.active"/>
<spring:message var="msg_mypage_tabs_ariaLabel" code="mypage.tabs.ariaLabel"/>
<spring:message var="msg_mypage_tabs_activity" code="mypage.tabs.activity"/>
<spring:message var="msg_mypage_tabs_booking" code="mypage.tabs.booking"/>
<spring:message var="msg_mypage_tabs_community" code="mypage.tabs.community"/>
<spring:message var="msg_mypage_tabs_support" code="mypage.tabs.support"/>
<spring:message var="msg_mypage_tabs_business" code="mypage.tabs.business"/>
<spring:message var="msg_mypage_tabs_itemsOnly" code="mypage.tabs.itemsOnly"/>
<spring:message var="msg_mypage_card_notifications" code="mypage.card.notifications"/>
<spring:message var="msg_mypage_empty_notifications" code="mypage.empty.notifications"/>
<spring:message var="msg_mypage_notification_type_community" code="mypage.notification.type.community"/>
<spring:message var="msg_mypage_notification_type_inquiry" code="mypage.notification.type.inquiry"/>
<spring:message var="msg_mypage_notification_type_report" code="mypage.notification.type.report"/>
<spring:message var="msg_mypage_notification_type_levelup" code="mypage.notification.type.levelup"/>
<spring:message var="msg_mypage_notification_type_grade" code="mypage.notification.type.grade"/>
<spring:message var="msg_mypage_notification_type_accountBlock" code="mypage.notification.type.accountBlock"/>
<spring:message var="msg_mypage_notification_type_default" code="mypage.notification.type.default"/>
<spring:message var="msg_mypage_notifications_markAllRead" code="mypage.notifications.markAllRead"/>
<spring:message var="msg_mypage_notifications_deleteAll" code="mypage.notifications.deleteAll"/>
<spring:message var="msg_mypage_notifications_limit" code="mypage.notifications.limit"/>
<spring:message var="msg_mypage_card_reviews" code="mypage.card.reviews"/>
<spring:message var="msg_mypage_empty_reviews" code="mypage.empty.reviews"/>
<spring:message var="msg_mypage_review_rating" code="mypage.review.rating"/>
<spring:message var="msg_mypage_card_plans" code="mypage.card.plans"/>
<spring:message var="msg_mypage_common_viewAll" code="mypage.common.viewAll"/>
<spring:message var="msg_mypage_empty_plans" code="mypage.empty.plans"/>
<spring:message var="msg_mypage_plan_public" code="mypage.plan.public"/>
<spring:message var="msg_mypage_plan_private" code="mypage.plan.private"/>
<spring:message var="msg_mypage_plan_source_ai" code="mypage.plan.source.ai"/>
<spring:message var="msg_mypage_card_history" code="mypage.card.history"/>
<spring:message var="msg_mypage_empty_history" code="mypage.empty.history"/>
<spring:message var="msg_mypage_history_deleted" code="mypage.history.deleted"/>
<spring:message var="msg_mypage_card_flightBookings" code="mypage.card.flightBookings"/>
<spring:message var="msg_mypage_empty_flightBookings" code="mypage.empty.flightBookings"/>
<spring:message var="msg_mypage_booking_flightRoundTrip" code="mypage.booking.flightRoundTrip"/>
<spring:message var="msg_mypage_booking_reservationNo" code="mypage.booking.reservationNo"/>
<spring:message var="msg_mypage_booking_finalPayment" code="mypage.booking.finalPayment"/>
<spring:message var="msg_mypage_booking_outbound" code="mypage.booking.outbound"/>
<spring:message var="msg_mypage_booking_return" code="mypage.booking.return"/>
<spring:message var="msg_mypage_common_detail" code="mypage.common.detail"/>
<spring:message var="msg_mypage_booking_flightDetail" code="mypage.booking.flightDetail"/>
<spring:message var="msg_mypage_booking_departure" code="mypage.booking.departure"/>
<spring:message var="msg_mypage_booking_arrival" code="mypage.booking.arrival"/>
<spring:message var="msg_mypage_booking_originalAmount" code="mypage.booking.originalAmount"/>
<spring:message var="msg_mypage_booking_gradeDiscount" code="mypage.booking.gradeDiscount"/>
<spring:message var="msg_mypage_booking_usedCash" code="mypage.booking.usedCash"/>
<spring:message var="msg_mypage_booking_usedMileage" code="mypage.booking.usedMileage"/>
<spring:message var="msg_mypage_booking_finalAmount" code="mypage.booking.finalAmount"/>
<spring:message var="msg_mypage_booking_paidAt" code="mypage.booking.paidAt"/>
<spring:message var="msg_mypage_booking_mockFlight" code="mypage.booking.mockFlight"/>
<spring:message var="msg_mypage_booking_spotDetail" code="mypage.booking.spotDetail"/>
<spring:message var="msg_mypage_card_packageBookings" code="mypage.card.packageBookings"/>
<spring:message var="msg_mypage_empty_packageBookings" code="mypage.empty.packageBookings"/>
<spring:message var="msg_mypage_booking_totalPayment" code="mypage.booking.totalPayment"/>
<spring:message var="msg_mypage_booking_peopleReserved" code="mypage.booking.peopleReserved"/>
<spring:message var="msg_mypage_booking_seller" code="mypage.booking.seller"/>
<spring:message var="msg_mypage_booking_packageDetail" code="mypage.booking.packageDetail"/>
<spring:message var="msg_mypage_booking_spotNameDetail" code="mypage.booking.spotNameDetail"/>
<spring:message var="msg_mypage_booking_peopleCount" code="mypage.booking.peopleCount"/>
<spring:message var="msg_mypage_booking_people" code="mypage.booking.people"/>
<spring:message var="msg_mypage_booking_unitPrice" code="mypage.booking.unitPrice"/>
<spring:message var="msg_mypage_booking_totalAmount" code="mypage.booking.totalAmount"/>
<spring:message var="msg_mypage_booking_bookedAt" code="mypage.booking.bookedAt"/>
<spring:message var="msg_mypage_booking_cancelledAt" code="mypage.booking.cancelledAt"/>
<spring:message var="msg_mypage_booking_cancelReason" code="mypage.booking.cancelReason"/>
<spring:message var="msg_mypage_none" code="mypage.none"/>
<spring:message var="msg_mypage_booking_mockPackage" code="mypage.booking.mockPackage"/>
<spring:message var="msg_mypage_booking_packageCancelReasonLabel" code="mypage.booking.packageCancelReasonLabel"/>
<spring:message var="msg_mypage_booking_cancelAndRefund" code="mypage.booking.cancelAndRefund"/>
<spring:message var="msg_mypage_booking_packageList" code="mypage.booking.packageList"/>
<spring:message var="msg_mypage_card_community" code="mypage.card.community"/>
<spring:message var="msg_mypage_empty_community" code="mypage.empty.community"/>
<spring:message var="msg_mypage_community_type_review" code="mypage.community.type.review"/>
<spring:message var="msg_mypage_community_type_photo" code="mypage.community.type.photo"/>
<spring:message var="msg_mypage_community_type_tip" code="mypage.community.type.tip"/>
<spring:message var="msg_mypage_community_type_question" code="mypage.community.type.question"/>
<spring:message var="msg_mypage_card_inquiries" code="mypage.card.inquiries"/>
<spring:message var="msg_mypage_empty_inquiries" code="mypage.empty.inquiries"/>
<spring:message var="msg_mypage_inquiry_category_service" code="mypage.inquiry.category.service"/>
<spring:message var="msg_mypage_inquiry_category_payment" code="mypage.inquiry.category.payment"/>
<spring:message var="msg_mypage_inquiry_category_account" code="mypage.inquiry.category.account"/>
<spring:message var="msg_mypage_inquiry_category_bug" code="mypage.inquiry.category.bug"/>
<spring:message var="msg_mypage_inquiry_category_other" code="mypage.inquiry.category.other"/>
<spring:message var="msg_mypage_inquiry_status_pending" code="mypage.inquiry.status.pending"/>
<spring:message var="msg_mypage_inquiry_status_inProgress" code="mypage.inquiry.status.inProgress"/>
<spring:message var="msg_mypage_inquiry_status_completed" code="mypage.inquiry.status.completed"/>
<spring:message var="msg_mypage_card_reports" code="mypage.card.reports"/>
<spring:message var="msg_mypage_empty_reports" code="mypage.empty.reports"/>
<spring:message var="msg_mypage_report_target_post" code="mypage.report.target.post"/>
<spring:message var="msg_mypage_report_target_comment" code="mypage.report.target.comment"/>
<spring:message var="msg_mypage_report_target_user" code="mypage.report.target.user"/>
<spring:message var="msg_mypage_report_target_default" code="mypage.report.target.default"/>
<spring:message var="msg_mypage_report_reason_spam" code="mypage.report.reason.spam"/>
<spring:message var="msg_mypage_report_reason_abuse" code="mypage.report.reason.abuse"/>
<spring:message var="msg_mypage_report_reason_privacy" code="mypage.report.reason.privacy"/>
<spring:message var="msg_mypage_report_reason_adult" code="mypage.report.reason.adult"/>
<spring:message var="msg_mypage_report_reason_illegal" code="mypage.report.reason.illegal"/>
<spring:message var="msg_mypage_report_reason_other" code="mypage.report.reason.other"/>
<spring:message var="msg_mypage_report_status_inReview" code="mypage.report.status.inReview"/>
<spring:message var="msg_mypage_report_status_resolved" code="mypage.report.status.resolved"/>
<spring:message var="msg_mypage_report_status_dismissed" code="mypage.report.status.dismissed"/>
<spring:message var="msg_mypage_card_businessApplication" code="mypage.card.businessApplication"/>
<spring:message var="msg_mypage_business_currentAccountType" code="mypage.business.currentAccountType"/>
<spring:message var="msg_mypage_business_normalUser" code="mypage.business.normalUser"/>
<spring:message var="msg_mypage_business_status_pending" code="mypage.business.status.pending"/>
<spring:message var="msg_mypage_business_status_approved" code="mypage.business.status.approved"/>
<spring:message var="msg_mypage_business_status_rejected" code="mypage.business.status.rejected"/>
<spring:message var="msg_mypage_business_appliedAt" code="mypage.business.appliedAt"/>
<spring:message var="msg_mypage_business_rejectedPrevious" code="mypage.business.rejectedPrevious"/>
<spring:message var="msg_mypage_business_reason" code="mypage.business.reason"/>
<spring:message var="msg_mypage_business_requestedRole" code="mypage.business.requestedRole"/>
<spring:message var="msg_mypage_business_role_business" code="mypage.business.role.business"/>
<spring:message var="msg_mypage_business_role_partner" code="mypage.business.role.partner"/>
<spring:message var="msg_mypage_business_companyName" code="mypage.business.companyName"/>
<spring:message var="msg_mypage_business_businessNumber" code="mypage.business.businessNumber"/>
<spring:message var="msg_mypage_business_managerName" code="mypage.business.managerName"/>
<spring:message var="msg_mypage_business_managerPhone" code="mypage.business.managerPhone"/>
<spring:message var="msg_mypage_business_description" code="mypage.business.description"/>
<spring:message var="msg_mypage_business_submit" code="mypage.business.submit"/>
<spring:message var="msg_mypage_card_items" code="mypage.card.items"/>
<spring:message var="msg_mypage_empty_items" code="mypage.empty.items"/>
<spring:message var="msg_mypage_items_goShop" code="mypage.items.goShop"/>
<spring:message var="msg_mypage_items_section_nicknameColor_code" code="mypage.items.section.nicknameColor.code"/>
<spring:message var="msg_mypage_items_section_nicknameColor" code="mypage.items.section.nicknameColor"/>
<spring:message var="msg_mypage_items_section_nicknameColor_desc" code="mypage.items.section.nicknameColor.desc"/>
<spring:message var="msg_mypage_items_section_nicknameEffect_code" code="mypage.items.section.nicknameEffect.code"/>
<spring:message var="msg_mypage_items_section_nicknameEffect" code="mypage.items.section.nicknameEffect"/>
<spring:message var="msg_mypage_items_section_nicknameEffect_desc" code="mypage.items.section.nicknameEffect.desc"/>
<spring:message var="msg_mypage_items_section_profileBadge_code" code="mypage.items.section.profileBadge.code"/>
<spring:message var="msg_mypage_items_section_profileBadge" code="mypage.items.section.profileBadge"/>
<spring:message var="msg_mypage_items_section_profileBadge_desc" code="mypage.items.section.profileBadge.desc"/>
<spring:message var="msg_mypage_items_section_bubbleStyle_code" code="mypage.items.section.bubbleStyle.code"/>
<spring:message var="msg_mypage_items_section_bubbleStyle" code="mypage.items.section.bubbleStyle"/>
<spring:message var="msg_mypage_items_section_bubbleStyle_desc" code="mypage.items.section.bubbleStyle.desc"/>
<spring:message var="msg_mypage_levelup_message" code="mypage.levelup.message"/>
<spring:message var="msg_mypage_common_confirm" code="mypage.common.confirm"/>
<%--
  My Page main dashboard view.
  Controller: GET /mypage
  Main model data:
    - user           : UsersVO
    - communityList  : List<MyPageCommunityDto>
    - communityCount : int
    - inquiryList    : List<MyPageInquiryDto>
    - inquiryCount   : int
    - reviewList     : List<MyPageReviewDto>
    - reviewCount    : int
    - planList       : List<MyPagePlanDto>
    - planCount      : int
--%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="mypage/mypage.css"/>
<c:set var="currentLang" value="${pageContext.response.locale.language}"/>
<%@ include file="../common/header.jsp" %>
<body>


<%-- Grade / level common styles used in the summary card --%>
<style>
    /* Grade badge row layout */
    .mp-grade-row {
        display: flex;
        align-items: center;
        gap: 24px;
    }
    /* Keep grade badges aligned even when text length differs */
    .mp-grade-row .mp-grade-badge {
        flex-shrink: 0;
        min-width: 120px;        /* ???ル봿??????????(PLATINUM)???轅붽틓?????????숈?????????됲룈 */
        text-align: center;      /* ????筌뤾쑬已?????ル봿?????????꿔꺂???影??*/
        box-sizing: border-box;
    }
    /* Let the level area fill the remaining horizontal space */
    .mp-grade-row .mp-level-wrap {
        flex: 1;
        min-width: 180px;
    }

    /* LEVEL badge visual style */
    .mp-badge-level {
        background: #ede9fe;
        color: #5b21b6;
        border: 1.5px solid #c4b5fd;
    }

    /* Grade progress section wrapper */
    .mp-grade-bar-section {
        padding: 16px 24px 20px;
    }

    /* Grade progress fill bar */
    .mp-grade-fill {
        height: 100%;
        background: linear-gradient(90deg, #f59e0b 0%, #d97706 100%);
        border-radius: 4px;
        transition: width .4s ease;
    }

    /* Promotion notice shown when expected grade is higher */
    .mp-grade-promotion {
        margin-top: 8px;
        padding: 8px 14px;
        background: linear-gradient(135deg, #fef3c7, #fde68a);
        color: #92400e;
        font-size: 13px;
        font-weight: 700;
        border-radius: 8px;
        text-align: center;
        animation: mp-grade-pulse 2s ease-in-out infinite;
    }
    @keyframes mp-grade-pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.75; }
    }

    /* Hint for the next grade target */
    .mp-grade-next-hint {
        margin-top: 6px;
        font-size: 11px;
        color: var(--gray-400, #94a3b8);
    }
</style>

<div class="mp-wrap">

    <%-- Banner section --%>


    <div class="mp-banner">
        <div class="mp-banner-inner">
            <div class="mp-avatar">&#128100;</div>
            <div class="mp-banner-info">
                <div class="mp-banner-nick">${user.nickname}</div>
                <div class="mp-banner-meta">
                    <span>
                        <c:choose>
                            <c:when test="${user.nationality eq 'KR'}">&#127760; ${msg_mypage_country_kr}</c:when>
                            <c:when test="${user.nationality eq 'US'}">&#127760; ${msg_mypage_country_us}</c:when>
                            <c:when test="${user.nationality eq 'JP'}">&#127760; ${msg_mypage_country_jp}</c:when>
                            <c:when test="${user.nationality eq 'CN'}">&#127760; ${msg_mypage_country_cn}</c:when>
                            <c:when test="${user.nationality eq 'GB'}">&#127760; ${msg_mypage_country_gb}</c:when>
                            <c:when test="${user.nationality eq 'FR'}">&#127760; ${msg_mypage_country_fr}</c:when>
                            <c:when test="${user.nationality eq 'DE'}">&#127760; ${msg_mypage_country_de}</c:when>
                            <c:when test="${user.nationality eq 'AU'}">&#127760; ${msg_mypage_country_au}</c:when>
                            <c:when test="${user.nationality eq 'CA'}">&#127760; ${msg_mypage_country_ca}</c:when>
                            <c:otherwise>&#127760; ${user.nationality}</c:otherwise>
                        </c:choose>
                    </span>
                    <span>
                        <c:choose>
                            <c:when test="${user.preferredLang eq 'ko'}">&#128483;&#65039; ${msg_mypage_lang_ko}</c:when>
                            <c:when test="${user.preferredLang eq 'en'}">&#128483;&#65039; ${msg_mypage_lang_en}</c:when>
                            <c:when test="${user.preferredLang eq 'ja'}">&#128483;&#65039; ${msg_mypage_lang_ja}</c:when>
                            <c:when test="${user.preferredLang eq 'zh'}">&#128483;&#65039; ${msg_mypage_lang_zh}</c:when>
                            <c:otherwise>${user.preferredLang}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
            <button class="mp-banner-edit"
                    onclick="location.href='${pageContext.request.contextPath}/mypage/edit-confirm'">
                &#9998; ${msg_mypage_profile_edit}
            </button>
        </div>
    </div>

    <div class="mp-inner" style="padding-top: 48px;">


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title"><span class="mp-card-icon">&#128202;</span> ${msg_mypage_summary_title}</div>
            </div>
            <div class="mp-info-grid">
                <div class="mp-info-item"><div class="mp-info-label">${msg_mypage_summary_memberGrade}</div><div class="mp-info-value"><c:choose><c:when test="${user.memberGrade eq 'BRONZE'}">&#x1F949; ${msg_mypage_grade_name_bronze}</c:when><c:when test="${user.memberGrade eq 'SILVER'}">&#x1F948; ${msg_mypage_grade_name_silver}</c:when><c:when test="${user.memberGrade eq 'GOLD'}">&#x1F947; ${msg_mypage_grade_name_gold}</c:when><c:when test="${user.memberGrade eq 'DIAMOND'}">&#x1F48E; ${msg_mypage_grade_name_diamond}</c:when><c:when test="${user.memberGrade eq 'PLATINUM'}">&#x1F451; ${msg_mypage_grade_name_platinum}</c:when><c:otherwise>${user.memberGrade}</c:otherwise></c:choose></div></div>
                <div class="mp-info-item"><div class="mp-info-label">${msg_mypage_summary_verifiedMember}</div><div class="mp-info-value"><c:choose><c:when test="${user.verifiedMember}"><span style="color:#15803d;">&#10004; ${msg_mypage_summary_verified}</span></c:when><c:otherwise><span style="color:#64748b;">&#10008; ${msg_mypage_summary_unverified}</span></c:otherwise></c:choose></div></div>
                <div class="mp-info-item"><div class="mp-info-label">${msg_mypage_asset_cash}</div><div class="mp-info-value"><fmt:formatNumber value="${user.cashBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label">${msg_mypage_asset_mileage}</div><div class="mp-info-value"><fmt:formatNumber value="${user.mileageBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label">${msg_mypage_asset_points}</div><div class="mp-info-value"><fmt:formatNumber value="${user.pointBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label">${msg_mypage_summary_levelExp}</div><div class="mp-info-value">${msg_mypage_level_prefix} ${user.levelNo} / <fmt:formatNumber value="${user.expPoints}" pattern="#,##0"/> ${msg_mypage_level_expUnit}</div></div>
                <div class="mp-info-item"><div class="mp-info-label">${msg_mypage_summary_postCount}</div><div class="mp-info-value">${user.totalPostCount}</div></div>
                <div class="mp-info-item"><div class="mp-info-label">${msg_mypage_summary_commentCount}</div><div class="mp-info-value">${user.totalCommentCount}</div></div>
            </div>
        </div>

        <%-- Grade / asset summary section --%>

        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#128176;</span> ${msg_mypage_gradeAsset_title}
                </div>
            </div>
            <%-- Level card: level badge + EXP progress --%>
            <div class="mp-grade-bar-section">
                <%-- Left badge and right progress area --%>
                <div class="mp-grade-row">
                    <%-- LEVEL badge --%>
                    <span class="mp-grade-badge mp-badge-level">&#9889; ${msg_mypage_level_badge}</span>
                    <div class="mp-level-wrap">
                    <%--
                        EXP progress calculation:
                        - currentLevelExp : starting EXP of the current level
                        - nextLevelExp    : required EXP for the next level
                        - user.expPoints  : user current total EXP
                        - expPercent      : current progress within this level
                    --%>
                    <c:set var="expInLevel" value="${user.expPoints - currentLevelExp}" />
                    <c:set var="expNeeded" value="${nextLevelExp - currentLevelExp}" />
                    <c:set var="expPercent" value="${expNeeded > 0 ? (expInLevel * 100 / expNeeded) : 100}" />
                    <%-- Clamp EXP percent to 0~100 --%>
                    <c:if test="${expPercent > 100}"><c:set var="expPercent" value="100" /></c:if>
                    <c:if test="${expPercent < 0}"><c:set var="expPercent" value="0" /></c:if>

                    <div class="mp-level-header">
                        <span class="mp-level-label">${msg_mypage_level_prefix} ${user.levelNo}</span>
                        <span class="mp-level-xp">
                            <fmt:formatNumber value="${user.expPoints}" pattern="#,##0" />
                            /
                            <fmt:formatNumber value="${nextLevelExp}" pattern="#,##0" /> ${msg_mypage_level_expUnit}
                        </span>
                    </div>
                    <div class="mp-xp-bar">
                        <div class="mp-xp-fill" style="width: ${expPercent}%;"></div>
                    </div>
                </div>
                <%-- /mp-grade-row --%>
                </div>
            </div>

            <%-- Membership grade progress section --%>
            <%--
                Grade progress uses the current month payment amount.
                gradePolicies are sorted from BRONZE to PLATINUM.
                nextGradeMin is the target amount for the next grade.
                When already at max grade, the progress is fixed to 100%.
            --%>
            <c:set var="currentGradeMin" value="0" />
            <c:set var="nextGradeMin" value="0" />
            <c:set var="nextGradeName" value="" />
            <c:set var="nextGradeFound" value="false" />
            <c:set var="isMaxGrade" value="true" />
            <%-- Determine the expected grade from this month payment --%>
            <c:set var="expectedGrade" value="BRONZE" />

            <%-- Resolve current / expected / next grade metadata --%>
            <c:forEach var="gp" items="${gradePolicies}">
                <c:if test="${gp.memberGrade eq user.memberGrade}">
                    <c:set var="currentGradeMin" value="${gp.minMonthlyPayment}" />
                </c:if>
                <%-- Save the highest grade that current payment satisfies --%>
                <c:if test="${currentMonthPayment >= gp.minMonthlyPayment}">
                    <c:set var="expectedGrade" value="${gp.memberGrade}" />
                </c:if>
            </c:forEach>

            <%-- Find the first grade above the current grade threshold --%>
            <c:forEach var="gp" items="${gradePolicies}">
                <c:if test="${!nextGradeFound && gp.minMonthlyPayment > currentGradeMin}">
                    <c:set var="nextGradeMin" value="${gp.minMonthlyPayment}" />
                    <c:set var="nextGradeName" value="${gp.memberGrade}" />
                    <c:set var="nextGradeFound" value="true" />
                    <c:set var="isMaxGrade" value="false" />
                </c:if>
            </c:forEach>

            <%-- Calculate grade progress percent --%>
            <c:choose>
                <c:when test="${isMaxGrade}">
                    <c:set var="gradePercent" value="100" />
                </c:when>
                <c:otherwise>
                    <c:set var="gradeRange" value="${nextGradeMin - currentGradeMin}" />
                    <c:set var="gradeProgress" value="${currentMonthPayment - currentGradeMin}" />
                    <c:set var="gradePercent" value="${gradeRange > 0 ? (gradeProgress * 100 / gradeRange) : 0}" />
                    <c:if test="${gradePercent > 100}"><c:set var="gradePercent" value="100" /></c:if>
                    <c:if test="${gradePercent < 0}"><c:set var="gradePercent" value="0" /></c:if>
                </c:otherwise>
            </c:choose>

            <c:set var="currentGradeLabel" value="${user.memberGrade}" />
            <c:if test="${user.memberGrade eq 'BRONZE'}"><c:set var="currentGradeLabel" value="${msg_mypage_grade_name_bronze}" /></c:if>
            <c:if test="${user.memberGrade eq 'SILVER'}"><c:set var="currentGradeLabel" value="${msg_mypage_grade_name_silver}" /></c:if>
            <c:if test="${user.memberGrade eq 'GOLD'}"><c:set var="currentGradeLabel" value="${msg_mypage_grade_name_gold}" /></c:if>
            <c:if test="${user.memberGrade eq 'DIAMOND'}"><c:set var="currentGradeLabel" value="${msg_mypage_grade_name_diamond}" /></c:if>
            <c:if test="${user.memberGrade eq 'PLATINUM'}"><c:set var="currentGradeLabel" value="${msg_mypage_grade_name_platinum}" /></c:if>

            <c:set var="expectedGradeLabel" value="${expectedGrade}" />
            <c:if test="${expectedGrade eq 'BRONZE'}"><c:set var="expectedGradeLabel" value="${msg_mypage_grade_name_bronze}" /></c:if>
            <c:if test="${expectedGrade eq 'SILVER'}"><c:set var="expectedGradeLabel" value="${msg_mypage_grade_name_silver}" /></c:if>
            <c:if test="${expectedGrade eq 'GOLD'}"><c:set var="expectedGradeLabel" value="${msg_mypage_grade_name_gold}" /></c:if>
            <c:if test="${expectedGrade eq 'DIAMOND'}"><c:set var="expectedGradeLabel" value="${msg_mypage_grade_name_diamond}" /></c:if>
            <c:if test="${expectedGrade eq 'PLATINUM'}"><c:set var="expectedGradeLabel" value="${msg_mypage_grade_name_platinum}" /></c:if>

            <c:set var="nextGradeLabel" value="${nextGradeName}" />
            <c:if test="${nextGradeName eq 'BRONZE'}"><c:set var="nextGradeLabel" value="${msg_mypage_grade_name_bronze}" /></c:if>
            <c:if test="${nextGradeName eq 'SILVER'}"><c:set var="nextGradeLabel" value="${msg_mypage_grade_name_silver}" /></c:if>
            <c:if test="${nextGradeName eq 'GOLD'}"><c:set var="nextGradeLabel" value="${msg_mypage_grade_name_gold}" /></c:if>
            <c:if test="${nextGradeName eq 'DIAMOND'}"><c:set var="nextGradeLabel" value="${msg_mypage_grade_name_diamond}" /></c:if>
            <c:if test="${nextGradeName eq 'PLATINUM'}"><c:set var="nextGradeLabel" value="${msg_mypage_grade_name_platinum}" /></c:if>

            <div class="mp-grade-bar-section">
                <%-- Grade badge + grade payment progress bar --%>
                <div class="mp-grade-row">
                    <%-- Current member grade badge --%>
                    <span class="mp-grade-badge mp-grade-${user.memberGrade}">
    <c:choose>
        <c:when test="${user.memberGrade eq 'BRONZE'}">&#x1F949; ${msg_mypage_grade_name_bronze}</c:when>
        <c:when test="${user.memberGrade eq 'SILVER'}">&#x1F948; ${msg_mypage_grade_name_silver}</c:when>
        <c:when test="${user.memberGrade eq 'GOLD'}">&#x1F947; ${msg_mypage_grade_name_gold}</c:when>
        <c:when test="${user.memberGrade eq 'DIAMOND'}">&#x1F48E; ${msg_mypage_grade_name_diamond}</c:when>
        <c:when test="${user.memberGrade eq 'PLATINUM'}">&#x1F451; ${msg_mypage_grade_name_platinum}</c:when>
        <c:otherwise>${user.memberGrade}</c:otherwise>
    </c:choose>
</span>
                    <%-- Payment progress area for the next grade --%>
                    <div class="mp-level-wrap">
                        <div class="mp-level-header">
                            <span class="mp-level-label">${msg_mypage_summary_memberGrade}</span>
                            <span class="mp-level-xp">
                                <c:choose>
                                    <c:when test="${isMaxGrade}">
                                        ${msg_mypage_grade_maxReached}
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${currentMonthPayment}" pattern="#,##0" />
                                        /
                                        <fmt:formatNumber value="${nextGradeMin}" pattern="#,##0" /> C
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="mp-xp-bar">
                            <div class="mp-grade-fill" style="width: ${gradePercent}%;"></div>
                        </div>
                    </div>
                </div>
                <%-- Promotion hint or next-grade hint --%>
                <c:choose>
                    <c:when test="${isMaxGrade}">
                        <%-- ?轅붽틓????彛????μ떜媛?슙??????????ㅼ뒧?????????? ?????쇨덧??--%>
                    </c:when>
                    <c:when test="${expectedGrade ne user.memberGrade}">
                        <div class="mp-grade-promotion">
                            <spring:message var="msg_mypage_grade_promotionExpected_args_currentGradeLabel_expectedGradeLabel" code="mypage.grade.promotionExpected" arguments="${currentGradeLabel},${expectedGradeLabel}"/>${msg_mypage_grade_promotionExpected_args_currentGradeLabel_expectedGradeLabel}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mp-grade-next-hint">
                            ${msg_mypage_grade_next}:
                            ${nextGradeLabel}
                            (${msg_mypage_grade_thisMonthPaymentPrefix} <fmt:formatNumber value="${nextGradeMin}" pattern="#,##0" /> C ${msg_mypage_grade_thisMonthPaymentSuffix})
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <%-- ????--%>
            <div class="mp-currency-grid">
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-point.svg" alt="${msg_mypage_asset_points}" width="40" height="40"></div>
                    <div class="mp-currency-label">${msg_mypage_asset_points}</div>
                    <div class="mp-currency-value"><fmt:formatNumber value="${user.pointBalance}" pattern="#,##0" /></div>
                </div>
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-mileage.svg" alt="${msg_mypage_asset_mileage}" width="40" height="40"></div>
                    <div class="mp-currency-label">${msg_mypage_asset_mileage}</div>
                    <div class="mp-currency-value"><fmt:formatNumber value="${user.mileageBalance}" pattern="#,##0" /></div>
                </div>
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-cash.svg" alt="${msg_mypage_asset_cash}" width="40" height="40"></div>
                    <div class="mp-currency-label">${msg_mypage_asset_cash}</div>
                    <div class="mp-currency-value"><fmt:formatNumber value="${user.cashBalance}" pattern="#,##0" /></div>
                </div>
            </div>
            <%-- Activity summary stats --%>
            <%--
                 Community post/comment counts are real values.
                 Explore review count and course count are placeholders here.


            --%>
            <div class="mp-stats-grid">
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-community">${msg_mypage_stats_community}</span>
                    <div class="mp-stats-value">${user.totalPostCount}</div>
                    <div class="mp-stats-label">${msg_mypage_stats_posts}</div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-community">${msg_mypage_stats_community}</span>
                    <div class="mp-stats-value">${user.totalCommentCount}</div>
                    <div class="mp-stats-label">${msg_mypage_stats_comments}</div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-explore">${msg_mypage_stats_explore}</span>
                    <div class="mp-stats-value">0</div>
                    <div class="mp-stats-label">${msg_mypage_stats_reviews}</div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-courses">${msg_mypage_stats_courses}</span>
                    <div class="mp-stats-value">0</div>
                    <div class="mp-stats-label">${msg_mypage_stats_travelCourses}</div>
                </div>
            </div>
        </div>

        <%-- Level-up reward policy section --%>
        <div class="mp-card mp-level-reward-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#127942;</span>
                    <c:choose>
                        <c:when test="${currentLang eq 'en'}">Level-Up Rewards</c:when>
                        <c:when test="${currentLang eq 'ja'}">レベルアップ報酬</c:when>
                        <c:when test="${currentLang eq 'zh'}">升级奖励</c:when>
                        <c:otherwise>레벨업 보상</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <p class="mp-level-reward-subtitle">
                <c:choose>
                    <c:when test="${currentLang eq 'en'}">Growth rewards are granted automatically when you reach each level.</c:when>
                    <c:when test="${currentLang eq 'ja'}">各レベルを達成すると、成長報酬が自動で支給されます。</c:when>
                    <c:when test="${currentLang eq 'zh'}">达到对应等级时，将自动发放成长奖励。</c:when>
                    <c:otherwise>레벨을 달성하면 활동 기반 성장 보상이 자동으로 지급됩니다.</c:otherwise>
                </c:choose>
            </p>

            <div class="mp-level-reward-overview">
                <div class="mp-level-reward-stat">
                    <span class="mp-level-reward-stat__label">
                        <c:choose>
                            <c:when test="${currentLang eq 'en'}">Current Level</c:when>
                            <c:when test="${currentLang eq 'ja'}">現在レベル</c:when>
                            <c:when test="${currentLang eq 'zh'}">当前等级</c:when>
                            <c:otherwise>현재 레벨</c:otherwise>
                        </c:choose>
                    </span>
                    <strong>Lv.${user.levelNo}</strong>
                </div>
                <div class="mp-level-reward-stat">
                    <span class="mp-level-reward-stat__label">
                        <c:choose>
                            <c:when test="${currentLang eq 'en'}">Rewards Claimed</c:when>
                            <c:when test="${currentLang eq 'ja'}">受取完了報酬</c:when>
                            <c:when test="${currentLang eq 'zh'}">已领取奖励</c:when>
                            <c:otherwise>수령 완료 보상</c:otherwise>
                        </c:choose>
                    </span>
                    <strong>${claimedLevelRewardCount} / ${totalLevelRewardCount}</strong>
                </div>
                <c:if test="${not empty nextLevelReward}">
                    <div class="mp-level-reward-next-card">
                        <div class="mp-level-reward-next-card__head">
                            <span class="mp-level-reward-next-kicker">
                                <c:choose>
                                    <c:when test="${currentLang eq 'en'}">Next Reward</c:when>
                                    <c:when test="${currentLang eq 'ja'}">次の報酬</c:when>
                                    <c:when test="${currentLang eq 'zh'}">下一奖励</c:when>
                                    <c:otherwise>다음 보상</c:otherwise>
                                </c:choose>
                            </span>
                            <strong>Lv.${nextLevelReward.levelNo}</strong>
                        </div>
                        <div class="mp-level-reward-next-body">
                            <c:if test="${not empty nextLevelReward.rewardImagePath}">
                                <img class="mp-level-reward-next-image"
                                     src="${pageContext.request.contextPath}${nextLevelReward.rewardImagePath}"
                                     alt="${nextLevelReward.rewardDisplayText}">
                            </c:if>
                            <div>
                                <div class="mp-level-reward-next-text">${nextLevelReward.rewardDisplayText}</div>
                                <span class="mp-level-reward-status is-${nextLevelReward.rewardStatusCode}">
                                    <c:choose>
                                        <c:when test="${nextLevelReward.rewardStatusCode eq 'claimed'}">
                                            <c:choose>
                                                <c:when test="${currentLang eq 'en'}">Claimed</c:when>
                                                <c:when test="${currentLang eq 'ja'}">受取完了</c:when>
                                                <c:when test="${currentLang eq 'zh'}">已领取</c:when>
                                                <c:otherwise>수령 완료</c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${nextLevelReward.rewardStatusCode eq 'pending'}">
                                            <c:choose>
                                                <c:when test="${currentLang eq 'en'}">Reward Ready</c:when>
                                                <c:when test="${currentLang eq 'ja'}">지급 가능</c:when>
                                                <c:when test="${currentLang eq 'zh'}">可发放</c:when>
                                                <c:otherwise>지급 가능</c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${currentLang eq 'en'}">Locked</c:when>
                                                <c:when test="${currentLang eq 'ja'}">達成前</c:when>
                                                <c:when test="${currentLang eq 'zh'}">未达成</c:when>
                                                <c:otherwise>달성 전</c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>

            <c:choose>
                <c:when test="${not empty levelRewardList}">
                    <div class="mp-level-reward-grid">
                        <c:forEach var="reward" items="${levelRewardList}">
                            <div class="mp-level-reward-item is-${reward.rewardStatusCode}">
                                <span class="mp-level-reward-item__lv">Lv.${reward.levelNo}</span>
                                <div class="mp-level-reward-item__content">
                                    <span class="mp-level-reward-item__img-wrap">
                                        <c:if test="${not empty reward.rewardImagePath}">
                                            <img class="mp-level-reward-item__img"
                                                 src="${pageContext.request.contextPath}${reward.rewardImagePath}"
                                                 alt="${reward.rewardDisplayText}">
                                        </c:if>
                                    </span>
                                    <span>${reward.rewardDisplayText}</span>
                                </div>
                                <span class="mp-level-reward-status is-${reward.rewardStatusCode}">
                                    <c:choose>
                                        <c:when test="${reward.rewardStatusCode eq 'claimed'}">${msg_mypage_reward_status_claimed}</c:when>
                                        <c:when test="${reward.rewardStatusCode eq 'pending'}">${msg_mypage_reward_status_pending}</c:when>
                                        <c:otherwise>${msg_mypage_reward_status_locked}</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="mp-level-reward-empty">
                        <span class="mp-level-reward-empty-icon">&#127919;</span>
                        <p>${msg_mypage_reward_empty}</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Profile information section --%>


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#128100;</span> ${msg_mypage_profile_title}
                </div>
            </div>
            <div class="mp-info-grid">
                <div class="mp-info-item">
                    <div class="mp-info-label">${msg_mypage_nickname}</div>
                    <div class="mp-info-value">${user.nickname}</div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">${msg_mypage_profile_userId}</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${not empty user.userId}">${user.userId}</c:when>
                            <c:otherwise><span style="color:var(--gray-400);">${msg_mypage_profile_socialOnly}</span></c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">${msg_mypage_nationality}</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.nationality eq 'KR'}">&#127760; ${msg_mypage_country_kr}</c:when>
                            <c:when test="${user.nationality eq 'US'}">&#127760; ${msg_mypage_country_us}</c:when>
                            <c:when test="${user.nationality eq 'JP'}">&#127760; ${msg_mypage_country_jp}</c:when>
                            <c:when test="${user.nationality eq 'CN'}">&#127760; ${msg_mypage_country_cn}</c:when>
                            <c:when test="${user.nationality eq 'GB'}">&#127760; ${msg_mypage_country_gb}</c:when>
                            <c:when test="${user.nationality eq 'FR'}">&#127760; ${msg_mypage_country_fr}</c:when>
                            <c:when test="${user.nationality eq 'DE'}">&#127760; ${msg_mypage_country_de}</c:when>
                            <c:when test="${user.nationality eq 'AU'}">&#127760; ${msg_mypage_country_au}</c:when>
                            <c:when test="${user.nationality eq 'CA'}">&#127760; ${msg_mypage_country_ca}</c:when>
                            <c:otherwise>&#127760; ${user.nationality}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">${msg_mypage_language}</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.preferredLang eq 'ko'}">&#128483;&#65039; ${msg_mypage_lang_ko}</c:when>
                            <c:when test="${user.preferredLang eq 'en'}">&#128483;&#65039; ${msg_mypage_lang_en}</c:when>
                            <c:when test="${user.preferredLang eq 'ja'}">&#128483;&#65039; ${msg_mypage_lang_ja}</c:when>
                            <c:when test="${user.preferredLang eq 'zh'}">&#128483;&#65039; ${msg_mypage_lang_zh}</c:when>
                            <c:otherwise>${user.preferredLang}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">${msg_mypage_profile_email}</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${not empty user.userEmail}">
                                ${user.userEmail}
                                <c:if test="${user.emailVerified}">
                                    <span style="font-size:11px;color:#15803d;margin-left:4px;">&#10004; ${msg_mypage_profile_emailVerified}</span>
                                </c:if>
                            </c:when>
                            <c:otherwise><span style="color:var(--gray-400);">${msg_mypage_profile_notRegistered}</span></c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">${msg_mypage_profile_accountStatus}</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.accountStatus eq 'ACTIVE'}">
                                <span style="color:#15803d;">&#10004; ${msg_mypage_profile_active}</span>
                            </c:when>
                            <c:otherwise>${user.accountStatus}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        
        <section class="mp-dashboard-tabs" aria-label="${msg_mypage_tabs_ariaLabel}">
            <div class="mp-tab-nav" role="tablist">
                <button type="button" class="mp-tab-btn is-active" data-mp-tab="activity" role="tab" aria-selected="true">
                    <span>&#128276;</span>
                    ${msg_mypage_tabs_activity}
                </button>
                <button type="button" class="mp-tab-btn" data-mp-tab="booking" role="tab" aria-selected="false">
                    <span>&#127915;</span>
                    ${msg_mypage_tabs_booking}
                </button>
                <button type="button" class="mp-tab-btn" data-mp-tab="community" role="tab" aria-selected="false">
                    <span>&#128172;</span>
                    ${msg_mypage_tabs_community}
                </button>
                <button type="button" class="mp-tab-btn" data-mp-tab="support" role="tab" aria-selected="false">
                    <span>&#128221;</span>
                    ${msg_mypage_tabs_support}
                </button>
                <c:if test="${user.userRole eq 'USER'}">
                    <button type="button" class="mp-tab-btn" data-mp-tab="business" role="tab" aria-selected="false">
                        <span>&#127970;</span>
                        ${msg_mypage_tabs_business}
                    </button>
                </c:if>
                <button type="button" class="mp-tab-btn" data-mp-tab="items" role="tab" aria-selected="false">
                    <span>${msg_mypage_items_icon}</span>
                    ${msg_mypage_tabs_itemsOnly}
                </button>
            </div>

            <div class="mp-tab-panel is-active" data-mp-panel="activity" role="tabpanel">

        <%-- Notification section --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#128276;</span> ${msg_mypage_card_notifications}
                    <c:if test="${headerUnreadCount > 0}">
                        <span class="mp-notif-count">${headerUnreadCount}</span>
                    </c:if>
                </div>
            </div>
            <div class="mp-notif-list" id="mpNotifList">
                <c:choose>
                    <c:when test="${empty notifications}">
                        <div class="mp-notif-empty">${msg_mypage_empty_notifications}</div>
                    </c:when>
                    <c:otherwise>
<c:forEach var="noti" items="${notifications}">
    <c:set var="unreadClass" value="unread"/>
    <c:if test="${noti.isRead}">
        <c:set var="unreadClass" value=""/>
    </c:if>

    <div class="mp-notif-item ${unreadClass}"
         data-notification-id="${noti.notificationId}"
         data-target="${noti.targetUrl}">
        <span class="mp-notif-type">
            <c:choose>
                <c:when test="${noti.sourceType eq 'community'}">[${msg_mypage_notification_type_community}]</c:when>
                <c:when test="${noti.sourceType eq 'inquiry'}">[${msg_mypage_notification_type_inquiry}]</c:when>
                <c:when test="${noti.sourceType eq 'report'}">[${msg_mypage_notification_type_report}]</c:when>
                <c:when test="${noti.sourceType eq 'levelup'}">[${msg_mypage_notification_type_levelup}]</c:when>
                <c:when test="${noti.sourceType eq 'grade'}">[${msg_mypage_notification_type_grade}]</c:when>
                <c:when test="${noti.sourceType eq 'account_block'}">[${msg_mypage_notification_type_accountBlock}]</c:when>
                <c:otherwise>[${msg_mypage_notification_type_default}]</c:otherwise>
            </c:choose>
        </span>
        <span class="mp-notif-msg">${noti.message}</span>
        <span class="mp-notif-date">
            <fmt:formatDate value="${noti.createdAtDate}" pattern="yyyy-MM-dd"/>
        </span>
        <button type="button"
                class="mp-notif-delete"
                aria-label="${msg_mypage_notifications_delete}">&#10005;</button>
    </div>
</c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            <c:if test="${not empty notifications}">
                <div class="mp-notif-actions">
                    <button type="button" class="mp-notif-btn" id="mpNotifMarkAll">${msg_mypage_notifications_markAllRead}</button>
                    <button type="button" class="mp-notif-btn mp-notif-btn-danger" id="mpNotifDeleteAll">${msg_mypage_notifications_deleteAll}</button>
                </div>
            </c:if>
            <div class="mp-notif-footer">
                ${msg_mypage_notifications_limit}
            </div>
        </div>

        <%-- Review section --%>


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#11088;</span>
                    ${msg_mypage_card_reviews}
                    <span class="mp-card-count">${reviewCount}</span>
                </div>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty reviewList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#11088;</div>
                            ${msg_mypage_empty_reviews}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="review" items="${reviewList}">
                            <a href="${pageContext.request.contextPath}/detail/${review.spotIdx}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">${review.spotName}</div>
                                    <div class="mp-list-meta">
                                        <span class="mp-review-stars">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= review.rating}">&#9733;</c:when>
                                                    <c:otherwise>&#9734;</c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </span>
                                        <c:if test="${not empty review.content}">
                                            <span class="mp-review-excerpt">${fn:substring(review.content, 0, 40)}<c:if test="${fn:length(review.content) > 40}">...</c:if></span>
                                        </c:if>
                                        <span><fmt:formatDate value="${review.createdAtDate}" pattern="yyyy-MM-dd"/></span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-rating">${msg_mypage_review_rating}</span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>


        <%-- Travel plan section --%>


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#128467;</span>
                    ${msg_mypage_card_plans}
                    <span class="mp-card-count">${planCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/courses/list"
                   class="mp-card-more">${msg_mypage_common_viewAll}</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty planList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#128467;</div>
                            ${msg_mypage_empty_plans}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="plan" items="${planList}">
                            <a href="${pageContext.request.contextPath}/courses/detail?planId=${plan.planId}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">${plan.title}</div>
                                    <div class="mp-list-meta">
                                        <c:if test="${not empty plan.destination}">
                                            <span>${plan.destination}</span>
                                        </c:if>
                                        <span>
                                            <fmt:formatDate value="${plan.startDate}" pattern="yyyy-MM-dd"/>
                                            ~
                                            <fmt:formatDate value="${plan.endDate}" pattern="yyyy-MM-dd"/>
                                        </span>
                                        <span><fmt:formatDate value="${plan.createdAtDate}" pattern="yyyy-MM-dd"/></span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <c:choose>
                                        <c:when test="${plan.isPublic}">
                                            <span class="mp-badge mp-badge-public">${msg_mypage_plan_public}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="mp-badge mp-badge-private">${msg_mypage_plan_private}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${plan.planSource eq 'AI'}">
                                        <span class="mp-badge mp-badge-ai">${msg_mypage_plan_source_ai}</span>
                                    </c:if>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- Recently viewed section --%>
        <%-- Recent items are loaded from USER_VIEW_HISTORY. --%>

        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#128340;</span>
                    ${msg_mypage_card_history}
                    <span class="mp-card-count">${viewHistoryCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/mypage/history"
                   class="mp-card-more">${msg_mypage_common_viewAll}</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty viewHistoryList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#128340;</div>
                            ${msg_mypage_empty_history}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="h" items="${viewHistoryList}">
                            <c:set var="typeKey" value="${h.contentType}"/>
                            <c:set var="linkHref" value=""/>
                            <c:choose>
                                <c:when test="${typeKey eq 'community'}">
                                    <c:set var="linkHref" value="${pageContext.request.contextPath}/community/${h.contentId}"/>
                                </c:when>
                                <c:when test="${typeKey eq 'spot'}">
                                    <c:set var="linkHref" value="${pageContext.request.contextPath}/detail/${h.contentId}"/>
                                </c:when>
                                <c:when test="${typeKey eq 'plan'}">
                                    <c:set var="linkHref" value="${pageContext.request.contextPath}/courses/detail?planId=${h.contentId}"/>
                                </c:when>
                            </c:choose>
                            <a href="${linkHref}" class="mp-list-item <c:if test='${not h.available}'>is-unavailable</c:if>">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">
                                        <c:choose>
                                            <c:when test="${h.available and not empty h.title}">${h.title}</c:when>
                                            <c:otherwise>${msg_mypage_history_deleted}</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="mp-list-meta">
                                        <c:if test="${not empty h.subtitle}">
                                            <span>${h.subtitle}</span>
                                        </c:if>
                                        <span data-mp-history-ts="${h.viewedAt.time}"></span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-history-type-${typeKey}">
                                        <spring:message var="msg_mypage_history_type_typeKey" code="mypage.history.type.${typeKey}"/>${msg_mypage_history_type_typeKey}
                                    </span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

            </div>
            <div class="mp-tab-panel" data-mp-panel="booking" role="tabpanel" hidden>

        <%-- Flight booking section --%>
        <%-- Flight booking data comes from the mock booking table. --%>


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#127915;</span>
                    ${msg_mypage_card_flightBookings}
                    <span class="mp-card-count">${flightBookingCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/mypage/bookings/flights"
                   class="mp-card-more">${msg_mypage_common_viewAll}</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty flightBookingList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#127915;</div>
                            ${msg_mypage_empty_flightBookings}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mp-flight-booking-grid">
                        <c:forEach var="booking" items="${flightBookingList}">
                            <c:set var="bookingStatusLabel" value="${msg_mypage_common_status_reserved}"/>
                            <c:if test="${booking.status eq 'CANCELLED'}">
                                <c:set var="bookingStatusLabel" value="${msg_mypage_common_status_cancelled}"/>
                            </c:if>

                            <article class="mp-flight-ticket">
                                <div class="mp-flight-ticket-head">
                                    <div>
                                        <span class="mp-flight-status">${bookingStatusLabel}</span>
                                        <h4>${msg_mypage_booking_flightRoundTrip}</h4>
                                        <p>${msg_mypage_booking_reservationNo}</p>
                                    </div>
                                    <div class="mp-flight-ticket-price">
                                        <span>${msg_mypage_booking_finalPayment}</span>
                                        <strong><fmt:formatNumber value="${booking.finalAmount}" pattern="#,##0"/> C</strong>
                                    </div>
                                </div>

                                <div class="mp-flight-route-box">
                                    <div class="mp-flight-route-row">
                                        <span class="mp-flight-route-tag">${msg_mypage_booking_outbound}</span>
                                        <strong>${booking.originAirportCode} &#8594; ${booking.destinationAirportCode}</strong>
                                        <span><fmt:formatDate value="${booking.departureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                                    </div>
                                    <div class="mp-flight-route-row">
                                        <span class="mp-flight-route-tag return">${msg_mypage_booking_return}</span>
                                        <strong>${booking.returnOriginAirportCode} &#8594; ${booking.returnDestinationAirportCode}</strong>
                                        <span><fmt:formatDate value="${booking.returnDepartureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                                    </div>
                                </div>

                                <div class="mp-flight-ticket-foot">
                                    <span>${booking.airlineName} | ${booking.flightNo} / ${booking.returnFlightNo}</span>
                                    <button type="button"
                                            class="mp-flight-detail-link mp-flight-modal-open"
                                            data-modal-id="flight-booking-${booking.flightPurchaseIdx}">
                                        ${msg_mypage_common_detail}
                                    </button>
                                </div>
                            </article>

                            <div class="mp-flight-modal" id="flight-booking-${booking.flightPurchaseIdx}">
                                <button type="button" class="mp-flight-modal-backdrop mp-flight-modal-close" aria-label="${msg_mypage_common_close}"></button>
                                <div class="mp-flight-modal-card" role="dialog" aria-modal="true">
                                    <div class="mp-flight-modal-head">
                                        <div>
                                            <span class="mp-flight-status">${bookingStatusLabel}</span>
                                            <h3>${msg_mypage_booking_flightDetail}</h3>
                                            <p>${booking.purchaseNo}</p>
                                        </div>
                                        <button type="button" class="mp-flight-modal-close mp-flight-modal-x" aria-label="${msg_mypage_common_close}">&#10005;</button>
                                    </div>

                                    <div class="mp-flight-itinerary">
                                        <div class="mp-flight-itinerary-item">
                                            <span class="mp-flight-route-tag">${msg_mypage_booking_outbound}</span>
                                            <strong>${booking.originAirportCode} &#8594; ${booking.destinationAirportCode}</strong>
                                            <p>${booking.airlineName} | ${booking.flightNo}</p>
                                            <dl>
                                                <dt>${msg_mypage_booking_departure}</dt>
                                                <dd><fmt:formatDate value="${booking.departureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                                <dt>${msg_mypage_booking_arrival}</dt>
                                                <dd><fmt:formatDate value="${booking.arrivalTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                            </dl>
                                        </div>
                                        <div class="mp-flight-itinerary-item">
                                            <span class="mp-flight-route-tag return">${msg_mypage_booking_return}</span>
                                            <strong>${booking.returnOriginAirportCode} &#8594; ${booking.returnDestinationAirportCode}</strong>
                                            <p>${booking.returnAirlineName} | ${booking.returnFlightNo}</p>
                                            <dl>
                                                <dt>${msg_mypage_booking_departure}</dt>
                                                <dd><fmt:formatDate value="${booking.returnDepartureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                                <dt>${msg_mypage_booking_arrival}</dt>
                                                <dd><fmt:formatDate value="${booking.returnArrivalTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                            </dl>
                                        </div>
                                    </div>

                                    <div class="mp-flight-payment">
                                        <div><span>${msg_mypage_booking_originalAmount}</span><strong><fmt:formatNumber value="${booking.originalAmount}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${msg_mypage_booking_gradeDiscount}</span><strong>${booking.discountRate}% -<fmt:formatNumber value="${booking.discountAmount}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${msg_mypage_booking_usedCash}</span><strong><fmt:formatNumber value="${booking.usedCash}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${msg_mypage_booking_usedMileage}</span><strong><fmt:formatNumber value="${booking.usedMileage}" pattern="#,##0"/> M</strong></div>
                                        <div class="total"><span>${msg_mypage_booking_finalAmount}</span><strong><fmt:formatNumber value="${booking.finalAmount}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${msg_mypage_booking_paidAt}</span><strong><fmt:formatDate value="${booking.paidAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                    </div>

                                    <p class="mp-flight-mock-note">${msg_mypage_booking_mockFlight}</p>
                                    <a class="mp-flight-detail-link full" href="${pageContext.request.contextPath}/detail/${booking.spotIdx}">${msg_mypage_booking_spotDetail}</a>
                                </div>
                            </div>
                        </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- Package booking section --%>
        <%-- Package booking data comes from TRAVEL_PACKAGE_BOOKING. --%>


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#128717;</span>
                    ${msg_mypage_card_packageBookings}
                    <span class="mp-card-count">${packageBookingCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/mypage/bookings/packages"
                   class="mp-card-more">${msg_mypage_common_viewAll}</a>
            </div>
            <div class="mp-card-body">
                <c:if test="${not empty packageBookingMessage}">
                    <div class="mp-package-booking-alert success">${packageBookingMessage}</div>
                </c:if>
                <c:if test="${not empty packageBookingError}">
                    <div class="mp-package-booking-alert error">${packageBookingError}</div>
                </c:if>
                <c:choose>
                    <c:when test="${empty packageBookingList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#128717;</div>
                            ${msg_mypage_empty_packageBookings}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mp-flight-booking-grid mp-package-booking-grid">
                        <c:forEach var="packageBooking" items="${packageBookingList}">
                            <c:set var="packageStatusLabel" value="${msg_mypage_common_status_booked}"/>
                            <c:if test="${packageBooking.bookingStatus eq 'CANCELLED'}">
                                <c:set var="packageStatusLabel" value="${msg_mypage_common_status_cancelled}"/>
                            </c:if>
                            <c:if test="${packageBooking.bookingStatus eq 'COMPLETED'}">
                                <c:set var="packageStatusLabel" value="${msg_mypage_common_status_completed}"/>
                            </c:if>

                            <article class="mp-flight-ticket mp-package-ticket">
                                <div class="mp-flight-ticket-head">
                                    <div>
                                        <span class="mp-flight-status mp-package-status">${packageStatusLabel}</span>
                                        <h4>${packageBooking.packageTitle}</h4>
                                        <p>${packageBooking.spotName} 鸚?${msg_mypage_booking_reservationNo}</p>
                                    </div>
                                    <div class="mp-flight-ticket-price">
                                        <span>${msg_mypage_booking_totalPayment}</span>
                                        <strong><fmt:formatNumber value="${packageBooking.totalPrice}" pattern="#,##0"/> C</strong>
                                    </div>
                                </div>

                                <div class="mp-package-summary-box">
                                    <c:if test="${not empty packageBooking.mainImagePath}">
                                        <img src="${fn:escapeXml(packageBooking.mainImagePath)}" alt="${fn:escapeXml(packageBooking.packageTitle)}">
                                    </c:if>
                                    <c:if test="${empty packageBooking.mainImagePath}">
                                        <div class="mp-package-no-image">${msg_mypage_items_packageIcon}</div>
                                    </c:if>
                                    <div>
                                        <strong>${msg_mypage_booking_peopleReserved}</strong>
                                        <span>
                                            <fmt:formatDate value="${packageBooking.startDate}" pattern="yyyy-MM-dd"/>
                                            ~
                                            <fmt:formatDate value="${packageBooking.endDate}" pattern="yyyy-MM-dd"/>
                                        </span>
                                        <p>${packageBooking.packageSummary}</p>
                                    </div>
                                </div>

                                <div class="mp-flight-ticket-foot">
                                    <span>${msg_mypage_booking_seller}</span>
                                    <button type="button"
                                            class="mp-flight-detail-link mp-flight-modal-open"
                                            data-modal-id="package-booking-${packageBooking.packageBookingIdx}">
                                        ${msg_mypage_common_detail}
                                    </button>
                                </div>
                            </article>

                            <div class="mp-flight-modal" id="package-booking-${packageBooking.packageBookingIdx}">
                                <button type="button" class="mp-flight-modal-backdrop mp-flight-modal-close" aria-label="${msg_mypage_common_close}"></button>
                                <div class="mp-flight-modal-card" role="dialog" aria-modal="true">
                                    <div class="mp-flight-modal-head">
                                        <div>
                                            <span class="mp-flight-status mp-package-status">${packageStatusLabel}</span>
                                            <h3>${msg_mypage_booking_packageDetail}</h3>
                                            <p>${packageBooking.bookingNo}</p>
                                        </div>
                                        <button type="button" class="mp-flight-modal-close mp-flight-modal-x" aria-label="${msg_mypage_common_close}">&#10005;</button>
                                    </div>

                                    <div class="mp-package-modal-summary">
                                        <c:if test="${not empty packageBooking.mainImagePath}">
                                            <img src="${fn:escapeXml(packageBooking.mainImagePath)}" alt="${fn:escapeXml(packageBooking.packageTitle)}">
                                        </c:if>
                                        <c:if test="${empty packageBooking.mainImagePath}">
                                            <div class="mp-package-no-image">${msg_mypage_items_packageIcon}</div>
                                        </c:if>
                                        <div>
                                            <h4>${packageBooking.packageTitle}</h4>
                                            <p>${packageBooking.packageSummary}</p>
                                            <a href="${pageContext.request.contextPath}/detail/${packageBooking.spotIdx}">${msg_mypage_booking_spotNameDetail}</a>
                                        </div>
                                    </div>

                                    <div class="mp-flight-payment">
                                        <div><span>${msg_mypage_booking_peopleCount}</span><strong>${msg_mypage_booking_people}</strong></div>
                                        <div><span>${msg_mypage_booking_unitPrice}</span><strong><fmt:formatNumber value="${packageBooking.unitPrice}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${msg_mypage_booking_usedCash}</span><strong><fmt:formatNumber value="${packageBooking.usedCash}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${msg_mypage_booking_usedMileage}</span><strong><fmt:formatNumber value="${packageBooking.usedMileage}" pattern="#,##0"/> M</strong></div>
                                        <div class="total"><span>${msg_mypage_booking_totalAmount}</span><strong><fmt:formatNumber value="${packageBooking.totalPrice}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${msg_mypage_booking_bookedAt}</span><strong><fmt:formatDate value="${packageBooking.bookedAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                        <c:if test="${packageBooking.bookingStatus eq 'CANCELLED'}">
                                            <div><span>${msg_mypage_booking_cancelledAt}</span><strong><fmt:formatDate value="${packageBooking.cancelledAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                            <div>
                                                <span>${msg_mypage_booking_cancelReason}</span>
                                                <strong>
                                                    <c:choose>
                                                        <c:when test="${empty packageBooking.cancelReason}">${msg_mypage_none}</c:when>
                                                        <c:otherwise>${packageBooking.cancelReason}</c:otherwise>
                                                    </c:choose>
                                                </strong>
                                            </div>
                                        </c:if>
                                    </div>

                                    <p class="mp-flight-mock-note">${msg_mypage_booking_mockPackage}</p>
                                    <c:if test="${packageBooking.bookingStatus eq 'BOOKED'}">
                                        <form class="mp-package-cancel-form"
                                              action="${pageContext.request.contextPath}/packages/bookings/${packageBooking.packageBookingIdx}/cancel"
                                              method="post">
                                            <label for="package-cancel-reason-${packageBooking.packageBookingIdx}">${msg_mypage_booking_packageCancelReasonLabel}</label>
                                            <textarea id="package-cancel-reason-${packageBooking.packageBookingIdx}"
                                                      name="cancelReason"
                                                      maxlength="500"
                                                      placeholder="${msg_mypage_booking_cancelPlaceholder}"></textarea>
                                            <button type="submit">${msg_mypage_booking_cancelAndRefund}</button>
                                        </form>
                                    </c:if>
                                    <a class="mp-flight-detail-link full" href="${pageContext.request.contextPath}/packages">${msg_mypage_booking_packageList}</a>
                                </div>
                            </div>
                        </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

            </div>
            <div class="mp-tab-panel" data-mp-panel="community" role="tabpanel" hidden>


        <%-- Community activity section --%>


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#128172;</span>
                    ${msg_mypage_card_community}
                    <span class="mp-card-count">${communityCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/community/list?userIdx=${user.userIdx}"
                   class="mp-card-more">${msg_mypage_common_viewAll}</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty communityList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#9997;</div>
                            ${msg_mypage_empty_community}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="post" items="${communityList}">
                            <a href="${pageContext.request.contextPath}/community/${post.postId}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">${post.title}</div>
                                    <div class="mp-list-meta">
                                        <span><fmt:formatDate value="${post.createdAtDate}" pattern="yyyy-MM-dd"/></span>
                                        <span>&#128065; ${post.viewCount}</span>
                                        <span>&#10084; ${post.likeCount}</span>
                                        <span>&#128172; ${post.commentCount}</span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-type-${post.postType}">
                                        <c:choose>
                                            <c:when test="${post.postType eq 'review'}">${msg_mypage_community_type_review}</c:when>
                                            <c:when test="${post.postType eq 'photo'}">${msg_mypage_community_type_photo}</c:when>
                                            <c:when test="${post.postType eq 'tip'}">${msg_mypage_community_type_tip}</c:when>
                                            <c:when test="${post.postType eq 'question'}">${msg_mypage_community_type_question}</c:when>
                                            <c:otherwise>${post.postType}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

            </div>
            <div class="mp-tab-panel" data-mp-panel="support" role="tabpanel" hidden>

        <%-- Inquiry section --%>


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#128221;</span>
                    ${msg_mypage_card_inquiries}
                    <span class="mp-card-count">${inquiryCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/inquiry/list"
                   class="mp-card-more">${msg_mypage_common_viewAll}</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty inquiryList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#128221;</div>
                            ${msg_mypage_empty_inquiries}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="inq" items="${inquiryList}">
                            <a href="${pageContext.request.contextPath}/inquiry/${inq.inquiryId}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">${inq.title}</div>
                                    <div class="mp-list-meta">
                                        <span><fmt:formatDate value="${inq.createdAtDate}" pattern="yyyy-MM-dd"/></span>
                                        <span>
                                            <c:choose>
                                                <c:when test="${inq.category eq 'service'}">${msg_mypage_inquiry_category_service}</c:when>
                                                <c:when test="${inq.category eq 'payment'}">${msg_mypage_inquiry_category_payment}</c:when>
                                                <c:when test="${inq.category eq 'account'}">${msg_mypage_inquiry_category_account}</c:when>
                                                <c:when test="${inq.category eq 'bug'}">${msg_mypage_inquiry_category_bug}</c:when>
                                                <c:otherwise>${msg_mypage_inquiry_category_other}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-${inq.status}">
                                        <c:choose>
                                            <c:when test="${inq.status eq 'PENDING'}">${msg_mypage_inquiry_status_pending}</c:when>
                                            <c:when test="${inq.status eq 'IN_PROGRESS'}">${msg_mypage_inquiry_status_inProgress}</c:when>
                                            <c:when test="${inq.status eq 'COMPLETED'}">&#10004; ${msg_mypage_inquiry_status_completed}</c:when>
                                        </c:choose>
                                    </span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>


        <%-- Report section --%>


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#9888;</span>
                    ${msg_mypage_card_reports}
                    <span class="mp-card-count">${reportCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/report/list"
                   class="mp-card-more">${msg_mypage_common_viewAll}</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty reportList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#9888;</div>
                            ${msg_mypage_empty_reports}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="rpt" items="${reportList}">
                            <a href="${pageContext.request.contextPath}/report/${rpt.reportId}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">
                                        <c:choose>
                                            <c:when test="${rpt.targetType eq 'post'}">${msg_mypage_report_target_post}</c:when>
                                            <c:when test="${rpt.targetType eq 'comment'}">${msg_mypage_report_target_comment}</c:when>
                                            <c:when test="${rpt.targetType eq 'user'}">${msg_mypage_report_target_user}</c:when>
                                            <c:otherwise>${msg_mypage_report_target_default}</c:otherwise>
                                        </c:choose>
                                        <span style="color:var(--gray-400);font-size:12px;margin-left:4px;">#${rpt.targetId}</span>
                                    </div>
                                    <div class="mp-list-meta">
                                        <span><fmt:formatDate value="${rpt.createdAtDate}" pattern="yyyy-MM-dd"/></span>
                                        <c:if test="${not empty rpt.reason}">
                                            <span>
                                                <c:choose>
                                                    <c:when test="${rpt.reason eq 'spam'}">${msg_mypage_report_reason_spam}</c:when>
                                                    <c:when test="${rpt.reason eq 'abuse'}">${msg_mypage_report_reason_abuse}</c:when>
                                                    <c:when test="${rpt.reason eq 'privacy'}">${msg_mypage_report_reason_privacy}</c:when>
                                                    <c:when test="${rpt.reason eq 'adult'}">${msg_mypage_report_reason_adult}</c:when>
                                                    <c:when test="${rpt.reason eq 'illegal'}">${msg_mypage_report_reason_illegal}</c:when>
                                                    <c:when test="${rpt.reason eq 'other'}">${msg_mypage_report_reason_other}</c:when>
                                                    <c:otherwise>${rpt.reason}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-${rpt.status}">
                                        <c:choose>
                                            <c:when test="${rpt.status eq 'IN_REVIEW'}">${msg_mypage_report_status_inReview}</c:when>
                                            <c:when test="${rpt.status eq 'RESOLVED'}">${msg_mypage_report_status_resolved}</c:when>
                                            <c:when test="${rpt.status eq 'DISMISSED'}">${msg_mypage_report_status_dismissed}</c:when>
                                            <c:otherwise>${rpt.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

            </div>
            <c:if test="${user.userRole eq 'USER'}">
            <div class="mp-tab-panel" data-mp-panel="business" role="tabpanel" hidden>

            <%-- Business application section --%>
            <%-- Only normal USER accounts can see this tab. --%>


            <div class="mp-card">
                <div class="mp-card-head">
                    <div class="mp-card-title">
                        <span class="mp-card-icon">&#127970;</span>
                        ${msg_mypage_card_businessApplication}
                    </div>
                </div>

                <c:if test="${not empty businessApplicationMessage}">
                    <div class="mp-item-alert mp-item-alert--success">${businessApplicationMessage}</div>
                </c:if>
                <c:if test="${not empty businessApplicationError}">
                    <div class="mp-item-alert mp-item-alert--error">${businessApplicationError}</div>
                </c:if>

                <div class="mp-business-box">
                    <div class="mp-business-status">
                        <div>
                            <span class="mp-business-kicker">${msg_mypage_business_currentAccountType}</span>
                            <strong>${msg_mypage_business_normalUser}</strong>
                        </div>
                        <c:if test="${not empty businessApplication}">
                            <span class="mp-business-badge ${businessApplication.applicationStatus}">
                                <c:choose>
                                    <c:when test="${businessApplication.applicationStatus eq 'PENDING'}">${msg_mypage_business_status_pending}</c:when>
                                    <c:when test="${businessApplication.applicationStatus eq 'APPROVED'}">${msg_mypage_business_status_approved}</c:when>
                                    <c:when test="${businessApplication.applicationStatus eq 'REJECTED'}">${msg_mypage_business_status_rejected}</c:when>
                                    <c:otherwise>${businessApplication.applicationStatus}</c:otherwise>
                                </c:choose>
                            </span>
                        </c:if>
                    </div>

                    <c:choose>
                        <c:when test="${not empty businessApplication and businessApplication.applicationStatus eq 'PENDING'}">
                            <p class="mp-business-note">
                                <spring:message var="msg_mypage_business_pendingNote_args_fn_escapeXml_businessApplication_companyName" code="mypage.business.pendingNote" arguments="${fn:escapeXml(businessApplication.companyName)}"/>${msg_mypage_business_pendingNote_args_fn_escapeXml_businessApplication_companyName}
                                ${msg_mypage_business_appliedAt}: <fmt:formatDate value="${businessApplication.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/>
                            </p>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${not empty businessApplication and businessApplication.applicationStatus eq 'REJECTED'}">
                                <div class="mp-business-reject">
                                    ${msg_mypage_business_rejectedPrevious}
                                    <c:if test="${not empty businessApplication.rejectReason}">
                                        ${msg_mypage_business_reason}: ${fn:escapeXml(businessApplication.rejectReason)}
                                    </c:if>
                                </div>
                            </c:if>

                            <form class="mp-business-form" method="post" action="${pageContext.request.contextPath}/mypage/business-application">
                                <div>
                                    <label>${msg_mypage_business_requestedRole}</label>
                                    <select name="requestedRole" required>
                                        <option value="BUSINESS">${msg_mypage_business_role_business}</option>
                                        <option value="PARTNER">${msg_mypage_business_role_partner}</option>
                                    </select>
                                </div>
                                <div>
                                    <label>${msg_mypage_business_companyName}</label>
                                    <input type="text" name="companyName" maxlength="100" required placeholder="${msg_mypage_business_placeholder_companyName}">
                                </div>
                                <div>
                                    <label>${msg_mypage_business_businessNumber}</label>
                                    <input type="text" name="businessNumber" maxlength="50" placeholder="${msg_mypage_business_placeholder_optional}">
                                </div>
                                <div>
                                    <label>${msg_mypage_business_managerName}</label>
                                    <input type="text" name="managerName" maxlength="50" required placeholder="${msg_mypage_business_placeholder_managerName}">
                                </div>
                                <div>
                                    <label>${msg_mypage_business_managerPhone}</label>
                                    <input type="text" name="managerPhone" maxlength="30" required placeholder="${msg_mypage_business_placeholder_managerPhone}">
                                </div>
                                <div class="mp-business-form-full">
                                    <label>${msg_mypage_business_description}</label>
                                    <textarea name="description" maxlength="1000" rows="4" placeholder="${msg_mypage_business_placeholder_description}"></textarea>
                                </div>
                                <div class="mp-business-form-full">
                                    <button type="submit" class="mp-business-submit">${msg_mypage_business_submit}</button>
                                </div>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            </div>
            </c:if>

            <div class="mp-tab-panel" data-mp-panel="items" role="tabpanel" hidden>

        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">${msg_mypage_items_icon}</span> ${msg_mypage_card_items}
                </div>
            </div>

            <c:if test="${not empty itemMessage}">
                <div class="mp-item-alert mp-item-alert--success">${itemMessage}</div>
            </c:if>
            <c:if test="${not empty itemError}">
                <div class="mp-item-alert mp-item-alert--error">${itemError}</div>
            </c:if>

            <c:choose>
                <c:when test="${empty inventoryItems}">
                    <div class="mp-empty">
                        <div class="mp-empty-icon">${msg_mypage_items_emptyIcon}</div>
                        <div>${msg_mypage_empty_items}</div>
                        <button class="mp-item-shop-btn"
                                type="button"
                                onclick="location.href='${pageContext.request.contextPath}/shop'">
                            ${msg_mypage_items_goShop}
                        </button>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:set var="hasNicknameColor" value="false"/>
                    <c:set var="hasNicknameEffect" value="false"/>
                    <c:set var="hasProfileBadge" value="false"/>
                    <c:set var="hasBubbleStyle" value="false"/>

                    <c:forEach var="item" items="${inventoryItems}">
                        <c:if test="${item.itemType eq 'NICKNAME_COLOR'}"><c:set var="hasNicknameColor" value="true"/></c:if>
                        <c:if test="${item.itemType eq 'NICKNAME_EFFECT'}"><c:set var="hasNicknameEffect" value="true"/></c:if>
                        <c:if test="${item.itemType eq 'PROFILE_BADGE'}"><c:set var="hasProfileBadge" value="true"/></c:if>
                        <c:if test="${item.itemType eq 'BUBBLE_STYLE'}"><c:set var="hasBubbleStyle" value="true"/></c:if>
                    </c:forEach>

                    <div class="mp-item-section-list">
                        <c:if test="${hasNicknameColor}">
                            <section class="mp-item-section">
                                <div class="mp-item-section-head">
                                    <span>${msg_mypage_items_section_nicknameColor_code}</span>
                                    <div>
                                        <h3>${msg_mypage_items_section_nicknameColor}</h3>
                                        <p>${msg_mypage_items_section_nicknameColor_desc}</p>
                                    </div>
                                </div>
                                <div class="mp-item-grid">
                                    <c:forEach var="item" items="${inventoryItems}">
                                        <c:if test="${item.itemType eq 'NICKNAME_COLOR'}">
                                            <%@ include file="item-card-fragment.jspf" %>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </section>
                        </c:if>

                        <c:if test="${hasNicknameEffect}">
                            <section class="mp-item-section">
                                <div class="mp-item-section-head">
                                    <span>${msg_mypage_items_section_nicknameEffect_code}</span>
                                    <div>
                                        <h3>${msg_mypage_items_section_nicknameEffect}</h3>
                                        <p>${msg_mypage_items_section_nicknameEffect_desc}</p>
                                    </div>
                                </div>
                                <div class="mp-item-grid">
                                    <c:forEach var="item" items="${inventoryItems}">
                                        <c:if test="${item.itemType eq 'NICKNAME_EFFECT'}">
                                            <%@ include file="item-card-fragment.jspf" %>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </section>
                        </c:if>

                        <c:if test="${hasProfileBadge}">
                            <section class="mp-item-section">
                                <div class="mp-item-section-head">
                                    <span>${msg_mypage_items_section_profileBadge_code}</span>
                                    <div>
                                        <h3>${msg_mypage_items_section_profileBadge}</h3>
                                        <p>${msg_mypage_items_section_profileBadge_desc}</p>
                                    </div>
                                </div>
                                <div class="mp-item-grid">
                                    <c:forEach var="item" items="${inventoryItems}">
                                        <c:if test="${item.itemType eq 'PROFILE_BADGE'}">
                                            <%@ include file="item-card-fragment.jspf" %>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </section>
                        </c:if>

                        <c:if test="${hasBubbleStyle}">
                            <section class="mp-item-section">
                                <div class="mp-item-section-head">
                                    <span>${msg_mypage_items_section_bubbleStyle_code}</span>
                                    <div>
                                        <h3>${msg_mypage_items_section_bubbleStyle}</h3>
                                        <p>${msg_mypage_items_section_bubbleStyle_desc}</p>
                                    </div>
                                </div>
                                <div class="mp-item-grid">
                                    <c:forEach var="item" items="${inventoryItems}">
                                        <c:if test="${item.itemType eq 'BUBBLE_STYLE'}">
                                            <%@ include file="item-card-fragment.jspf" %>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </section>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
            </div>
        </section>
    </div>
    <%-- /mp-inner --%>
</div>
<%-- /mp-wrap --%>

<script>
    (function () {
        var tabButtons = document.querySelectorAll('.mp-tab-btn');
        var tabPanels = document.querySelectorAll('.mp-tab-panel');

        function activateTab(tabName) {
            tabButtons.forEach(function (button) {
                var isActive = button.dataset.mpTab === tabName;
                button.classList.toggle('is-active', isActive);
                button.setAttribute('aria-selected', isActive ? 'true' : 'false');
            });

            tabPanels.forEach(function (panel) {
                var isActive = panel.dataset.mpPanel === tabName;
                panel.classList.toggle('is-active', isActive);
                panel.hidden = !isActive;
            });
        }

        tabButtons.forEach(function (button) {
            button.addEventListener('click', function () {
                activateTab(button.dataset.mpTab);
            });
        });
    })();

    /**
     * Notification area script.
     */
    /* ===== Prevent stale page state when restored from browser cache ===== */
    window.addEventListener('pageshow', function(e) {
        if (e.persisted) location.reload();
    });

    (function () {
        const ctx = '${pageContext.request.contextPath}';
        const list = document.getElementById('mpNotifList');
        const markAllBtn = document.getElementById('mpNotifMarkAll');
        const deleteAllBtn = document.getElementById('mpNotifDeleteAll');
        if (!list) return;

        // Event delegation for notification item click and delete button
        list.addEventListener('click', function (e) {
            const deleteBtn = e.target.closest('.mp-notif-delete');
            const item = e.target.closest('.mp-notif-item');
            if (!item) return;
            const id = item.dataset.notificationId;

            // Delete a single notification
            if (deleteBtn) {
                e.stopPropagation();
                fetch(ctx + '/api/notifications/' + id, {
                    method: 'DELETE',
                    headers: {'X-Requested-With': 'XMLHttpRequest'}
                }).then(r => r.json())
                  .then(function (data) {
                      if (data.success) item.remove();
                  })
                  .catch(function () {});
                return;
            }

            // Mark as read and then move to the target page
            const fallbackUrl = ctx + '/mypage';
            fetch(ctx + '/api/notifications/' + id + '/read', {
                method: 'POST',
                headers: {'X-Requested-With': 'XMLHttpRequest'}
            }).then(r => r.json())
              .then(function (data) {
                  location.href = (data.success && data.targetUrl)
                      ? ctx + data.targetUrl
                      : fallbackUrl;
              })
              .catch(function () { location.href = fallbackUrl; });
        });

        // Mark all notifications as read
        if (markAllBtn) {
            markAllBtn.addEventListener('click', function () {
                fetch(ctx + '/api/notifications/read-all', {
                    method: 'POST',
                    headers: {'X-Requested-With': 'XMLHttpRequest'}
                }).then(r => r.json())
                  .then(function (data) {
                      if (!data.success) return;
                      list.querySelectorAll('.mp-notif-item').forEach(function (el) {
                          el.classList.remove('unread');
                      });
                      const badge = document.querySelector('.mp-notif-count');
                      if (badge) badge.remove();
                  })
                  .catch(function () {});
            });
        }

        // Delete all notifications
        if (deleteAllBtn) {
            deleteAllBtn.addEventListener('click', function () {
                if (!confirm("${fn:escapeXml(msg_mypage_notifications_deleteAllConfirm)}")) return;
                fetch(ctx + '/api/notifications', {
                    method: 'DELETE',
                    headers: {'X-Requested-With': 'XMLHttpRequest'}
                }).then(r => r.json())
                  .then(function (data) {
                      if (data.success) location.reload();
                  })
                  .catch(function () {});
            });
        }
    })();

    /**
     * Format date as YYYY-MM-DD.
     */
    function formatDate(dateString) {
        const date = new Date(dateString);
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

</script>

<%--
     Level-up popup section.
     It is shown when the controller provides levelUpLevel.
--%>
<c:if test="${not empty levelUpLevel}">
<div id="levelup-overlay" class="levelup-overlay">
    <div class="levelup-popup">
        <div class="levelup-icon">&#127881;</div>
        <div class="levelup-title">${msg_mypage_levelup_title}</div>
        <div class="levelup-level">${msg_mypage_level_prefix} ${levelUpLevel}</div>
        <div class="levelup-msg">${msg_mypage_levelup_message}</div>
        <button class="levelup-close-btn" onclick="closeLevelUpPopup()">${msg_mypage_common_confirm}</button>
    </div>
</div>
<style>
    /* Level-up popup overlay */
    .levelup-overlay {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0,0,0,0.5);
        display: flex; align-items: center; justify-content: center;
        z-index: 9999;
        animation: levelup-fade-in 0.3s ease;
    }
    /* Level-up popup card */
    .levelup-popup {
        background: #fff; border-radius: 20px; padding: 40px 48px;
        text-align: center; box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        animation: levelup-scale-in 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    }
    /* Celebration icon */
    .levelup-icon {
        font-size: 56px; margin-bottom: 8px;
        animation: levelup-bounce 0.6s ease 0.3s both;
    }
    /* LEVEL UP title */
    .levelup-title {
        font-size: 14px; font-weight: 700; letter-spacing: 4px;
        color: #6366f1; margin-bottom: 4px;
    }
    /* Level number text */
    .levelup-level {
        font-size: 40px; font-weight: 800;
        background: linear-gradient(135deg, #6366f1, #a855f7);
        -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        background-clip: text; margin-bottom: 8px;
    }
    /* Sub message */
    .levelup-msg {
        font-size: 15px; color: #64748b; margin-bottom: 24px;
    }
    /* Confirm button */
    .levelup-close-btn {
        background: linear-gradient(135deg, #6366f1, #a855f7);
        color: #fff; border: none; border-radius: 12px;
        padding: 12px 48px; font-size: 15px; font-weight: 600;
        cursor: pointer; transition: transform 0.15s, box-shadow 0.15s;
    }
    .levelup-close-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 16px rgba(99,102,241,0.4);
    }
    /* Popup animations */
    @keyframes levelup-fade-in { from { opacity: 0; } to { opacity: 1; } }
    @keyframes levelup-scale-in { from { transform: scale(0.6); opacity: 0; } to { transform: scale(1); opacity: 1; } }
    @keyframes levelup-bounce {
        0% { transform: scale(0); }
        60% { transform: scale(1.3); }
        100% { transform: scale(1); }
    }
</style>
<script>
    /**
     * Close the level-up popup with a short fade-out effect.
     */
    function closeLevelUpPopup() {
        var overlay = document.getElementById('levelup-overlay');
        if (overlay) {
            overlay.style.animation = 'levelup-fade-in 0.2s ease reverse';
            setTimeout(function() { overlay.remove(); }, 200);
        }
    }
</script>
</c:if>

<script>
    (function () {
        var openedFlightModal = null;

        function closeFlightBookingModal() {
            if (!openedFlightModal) return;
            openedFlightModal.classList.remove('is-open');
            openedFlightModal = null;
            document.body.classList.remove('mp-flight-modal-lock');
        }

        document.querySelectorAll('.mp-flight-modal-open').forEach(function (button) {
            button.addEventListener('click', function () {
                var modalId = button.dataset.modalId;
                var modal = document.getElementById(modalId);
                if (!modal) return;
                closeFlightBookingModal();
                openedFlightModal = modal;
                openedFlightModal.classList.add('is-open');
                document.body.classList.add('mp-flight-modal-lock');
            });
        });

        document.querySelectorAll('.mp-flight-modal-close').forEach(function (button) {
            button.addEventListener('click', closeFlightBookingModal);
        });

        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                closeFlightBookingModal();
            }
        });
    })();
</script>

<script>
/* Relative time labels for recent-view history */
(function () {
    var LABELS = {
        justNow:   '${msg_mypage_history_relative_justNow_js}',
        minutes:   '${msg_mypage_history_relative_minutes_js}',
        hours:     '${msg_mypage_history_relative_hours_js}',
        yesterday: '${msg_mypage_history_relative_yesterday_js}',
        days:      '${msg_mypage_history_relative_days_js}'
    };
    function relTime(ts) {
        var now = Date.now();
        var diffSec = Math.max(0, Math.floor((now - ts) / 1000));
        if (diffSec < 60)             return LABELS.justNow;
        if (diffSec < 60 * 60)        return LABELS.minutes.replace('{0}', Math.floor(diffSec / 60));
        if (diffSec < 60 * 60 * 24)   return LABELS.hours.replace('{0}', Math.floor(diffSec / 3600));
        if (diffSec < 60 * 60 * 48)   return LABELS.yesterday;
        return LABELS.days.replace('{0}', Math.floor(diffSec / 86400));
    }
    document.querySelectorAll('[data-mp-history-ts]').forEach(function (el) {
        var ts = parseInt(el.getAttribute('data-mp-history-ts'), 10);
        if (!isNaN(ts)) el.textContent = relTime(ts);
    });
})();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
