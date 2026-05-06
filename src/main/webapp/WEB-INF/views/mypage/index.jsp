<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_3362febff6" code="mypage.country.kr"/>
<spring:message var="autoMsg_52b9bda884" code="mypage.country.us"/>
<spring:message var="autoMsg_d999e40885" code="mypage.country.jp"/>
<spring:message var="autoMsg_01c615c71e" code="mypage.country.cn"/>
<spring:message var="autoMsg_3fbf4fd68b" code="mypage.country.gb"/>
<spring:message var="autoMsg_90033154dd" code="mypage.country.fr"/>
<spring:message var="autoMsg_adccf5cc06" code="mypage.country.de"/>
<spring:message var="autoMsg_e961064fbf" code="mypage.country.au"/>
<spring:message var="autoMsg_272ac87e03" code="mypage.country.ca"/>
<spring:message var="autoMsg_ae017cb7ba" code="mypage.lang.ko"/>
<spring:message var="autoMsg_d1c3401c79" code="mypage.profile.edit"/>
<spring:message var="autoMsg_7f4ba90966" code="mypage.summary.title"/>
<spring:message var="autoMsg_6e052700d0" code="mypage.summary.memberGrade"/>
<spring:message var="autoMsg_c28738fcc6" code="mypage.summary.verifiedMember"/>
<spring:message var="autoMsg_ad9f7ee7bd" code="mypage.summary.verified"/>
<spring:message var="autoMsg_c9cd016a5f" code="mypage.summary.unverified"/>
<spring:message var="autoMsg_777391ee7c" code="mypage.asset.cash"/>
<spring:message var="autoMsg_1776d33e12" code="mypage.asset.mileage"/>
<spring:message var="autoMsg_f5d120209f" code="mypage.asset.points"/>
<spring:message var="autoMsg_db82f65024" code="mypage.summary.levelExp"/>
<spring:message var="autoMsg_d9caeb6bc5" code="mypage.summary.postCount"/>
<spring:message var="autoMsg_5b65c911bf" code="mypage.summary.commentCount"/>
<spring:message var="autoMsg_383958b165" code="mypage.gradeAsset.title"/>
<spring:message var="autoMsg_55bce3e461" code="mypage.grade.name.bronze"/>
<spring:message var="autoMsg_299185c9e1" code="mypage.grade.next"/>
<spring:message var="autoMsg_a8821b41d2" code="mypage.grade.thisMonthPaymentPrefix"/>
<spring:message var="autoMsg_de8f0aec1b" code="mypage.grade.thisMonthPaymentSuffix"/>
<spring:message var="autoMsg_558421b0c7" code="mypage.stats.community"/>
<spring:message var="autoMsg_256687b65e" code="mypage.stats.posts"/>
<spring:message var="autoMsg_5b48fe2a6f" code="mypage.stats.comments"/>
<spring:message var="autoMsg_806b321a9a" code="mypage.stats.explore"/>
<spring:message var="autoMsg_ab87d87efd" code="mypage.stats.reviews"/>
<spring:message var="autoMsg_ae2a458c93" code="mypage.stats.courses"/>
<spring:message var="autoMsg_c0344af943" code="mypage.stats.travelCourses"/>
<spring:message var="autoMsg_d757e426d6" code="mypage.reward.status.claimed"/>
<spring:message var="autoMsg_1d42b19cf5" code="mypage.reward.status.pending"/>
<spring:message var="autoMsg_08f7d07c0a" code="mypage.reward.status.locked"/>
<spring:message var="autoMsg_c867da0813" code="mypage.reward.empty"/>
<spring:message var="autoMsg_914b7370cc" code="mypage.profile.title"/>
<spring:message var="autoMsg_b829561b81" code="mypage.nickname"/>
<spring:message var="autoMsg_4ef802baf3" code="mypage.profile.userId"/>
<spring:message var="autoMsg_aca855ec29" code="mypage.profile.socialOnly"/>
<spring:message var="autoMsg_6e3d78d0fc" code="mypage.nationality"/>
<spring:message var="autoMsg_442d461755" code="mypage.language"/>
<spring:message var="autoMsg_2e6ff75d48" code="mypage.profile.email"/>
<spring:message var="autoMsg_a1cafac8c5" code="mypage.profile.emailVerified"/>
<spring:message var="autoMsg_2efe1573c2" code="mypage.profile.notRegistered"/>
<spring:message var="autoMsg_2b399197ba" code="mypage.profile.accountStatus"/>
<spring:message var="autoMsg_7942b3e568" code="mypage.profile.active"/>
<spring:message var="autoMsg_d9aa3afcd8" code="mypage.card.notifications"/>
<spring:message var="autoMsg_e1f1c61d96" code="mypage.empty.notifications"/>
<spring:message var="autoMsg_c1b221e8d6" code="mypage.notification.type.community"/>
<spring:message var="autoMsg_a95bf0b57e" code="mypage.notification.type.inquiry"/>
<spring:message var="autoMsg_5df22ded5e" code="mypage.notification.type.report"/>
<spring:message var="autoMsg_03da6dd4dd" code="mypage.notification.type.levelup"/>
<spring:message var="autoMsg_38465ab5e2" code="mypage.notification.type.grade"/>
<spring:message var="autoMsg_13d3b943c0" code="mypage.notification.type.accountBlock"/>
<spring:message var="autoMsg_b781e46c3e" code="mypage.notification.type.default"/>
<spring:message var="autoMsg_45ec824ac5" code="mypage.notifications.delete"/>
<spring:message var="autoMsg_fe8e6426cb" code="mypage.notifications.markAllRead"/>
<spring:message var="autoMsg_824e2c7066" code="mypage.notifications.deleteAll"/>
<spring:message var="autoMsg_9c2f6a5371" code="mypage.review.rating"/>
<spring:message var="autoMsg_541ed72721" code="mypage.common.viewAll"/>
<spring:message var="autoMsg_c347f9dd5c" code="mypage.plan.public"/>
<spring:message var="autoMsg_6fd906648b" code="mypage.plan.private"/>
<spring:message var="autoMsg_b65623259c" code="mypage.plan.source.ai"/>
<spring:message var="autoMsg_c84dd3647e" code="mypage.history.deleted"/>
<spring:message var="autoMsg_0ea4ca3fb7" code="mypage.booking.flightRoundTrip"/>
<spring:message var="autoMsg_ddf52af61d" code="mypage.booking.reservationNo"/>
<spring:message var="autoMsg_3d435d48c1" code="mypage.booking.finalPayment"/>
<spring:message var="autoMsg_8d9b802ff6" code="mypage.booking.outbound"/>
<spring:message var="autoMsg_cadbf8ead7" code="mypage.booking.return"/>
<spring:message var="autoMsg_e4548d4d22" code="mypage.booking.flightDetail"/>
<spring:message var="autoMsg_632ebe3c9e" code="mypage.booking.departure"/>
<spring:message var="autoMsg_2d01f96be6" code="mypage.booking.arrival"/>
<spring:message var="autoMsg_f3d3ad8e5f" code="mypage.booking.originalAmount"/>
<spring:message var="autoMsg_1220509693" code="mypage.booking.gradeDiscount"/>
<spring:message var="autoMsg_ae3aee4a3a" code="mypage.booking.usedCash"/>
<spring:message var="autoMsg_41f9e848b4" code="mypage.booking.usedMileage"/>
<spring:message var="autoMsg_bcd6b94d40" code="mypage.booking.finalAmount"/>
<spring:message var="autoMsg_07639402da" code="mypage.booking.paidAt"/>
<spring:message var="autoMsg_821df8ec6c" code="mypage.booking.mockFlight"/>
<spring:message var="autoMsg_b381ac1a88" code="mypage.booking.spotDetail"/>
<spring:message var="autoMsg_d0ed5ba82f" code="mypage.booking.totalPayment"/>
<spring:message var="autoMsg_26e2b300ce" code="mypage.booking.peopleReserved"/>
<spring:message var="autoMsg_e6e594d840" code="mypage.booking.seller"/>
<spring:message var="autoMsg_1038d4683f" code="mypage.booking.packageDetail"/>
<spring:message var="autoMsg_9122276136" code="mypage.booking.spotNameDetail"/>
<spring:message var="autoMsg_735bd807f3" code="mypage.booking.peopleCount"/>
<spring:message var="autoMsg_88d438cc74" code="mypage.booking.people"/>
<spring:message var="autoMsg_2ac1d93bd0" code="mypage.booking.unitPrice"/>
<spring:message var="autoMsg_840e5c531a" code="mypage.booking.totalAmount"/>
<spring:message var="autoMsg_0a8f0a81a8" code="mypage.booking.bookedAt"/>
<spring:message var="autoMsg_d0664d9d7c" code="mypage.booking.cancelledAt"/>
<spring:message var="autoMsg_0c2e9d375b" code="mypage.booking.cancelReason"/>
<spring:message var="autoMsg_598c00d3f1" code="mypage.none"/>
<spring:message var="autoMsg_aa472626e8" code="mypage.booking.mockPackage"/>
<spring:message var="autoMsg_ff521daa8c" code="mypage.booking.packageCancelReasonLabel"/>
<spring:message var="autoMsg_f35299404c" code="mypage.booking.cancelAndRefund"/>
<spring:message var="autoMsg_6a7e1483e8" code="mypage.booking.packageList"/>
<spring:message var="autoMsg_a290bdff6f" code="mypage.community.type.review"/>
<spring:message var="autoMsg_b937f56014" code="mypage.community.type.photo"/>
<spring:message var="autoMsg_fb5f7de1eb" code="mypage.community.type.tip"/>
<spring:message var="autoMsg_1c5e1743f7" code="mypage.community.type.question"/>
<spring:message var="autoMsg_e41262b274" code="mypage.inquiry.category.service"/>
<spring:message var="autoMsg_166a5630fb" code="mypage.inquiry.category.payment"/>
<spring:message var="autoMsg_25b1c21c54" code="mypage.inquiry.category.account"/>
<spring:message var="autoMsg_f223019f42" code="mypage.inquiry.category.bug"/>
<spring:message var="autoMsg_a4142fa5f4" code="mypage.inquiry.category.other"/>
<spring:message var="autoMsg_d2578ce875" code="mypage.inquiry.status.pending"/>
<spring:message var="autoMsg_cb49cabff8" code="mypage.inquiry.status.inProgress"/>
<spring:message var="autoMsg_e7ee4b79dd" code="mypage.inquiry.status.completed"/>
<spring:message var="autoMsg_d8198986bd" code="mypage.report.target.post"/>
<spring:message var="autoMsg_ff86de67fc" code="mypage.report.target.comment"/>
<spring:message var="autoMsg_db99709620" code="mypage.report.target.user"/>
<spring:message var="autoMsg_f2694c4d06" code="mypage.report.target.default"/>
<spring:message var="autoMsg_76781c8ba5" code="mypage.report.reason.spam"/>
<spring:message var="autoMsg_dbee15473c" code="mypage.report.reason.abuse"/>
<spring:message var="autoMsg_0cb7c8fd34" code="mypage.report.reason.privacy"/>
<spring:message var="autoMsg_24a1351605" code="mypage.report.reason.adult"/>
<spring:message var="autoMsg_9e47ef632a" code="mypage.report.reason.illegal"/>
<spring:message var="autoMsg_5dae044dc0" code="mypage.report.reason.other"/>
<spring:message var="autoMsg_ba6ab204b9" code="mypage.report.status.inReview"/>
<spring:message var="autoMsg_7a4c7fe32e" code="mypage.report.status.resolved"/>
<spring:message var="autoMsg_e6d72b6f92" code="mypage.report.status.dismissed"/>
<spring:message var="autoMsg_5e2d3acbb3" code="mypage.business.currentAccountType"/>
<spring:message var="autoMsg_a3b43faf36" code="mypage.business.normalUser"/>
<spring:message var="autoMsg_bcc2de252b" code="mypage.business.status.pending"/>
<spring:message var="autoMsg_ebe890d08b" code="mypage.business.status.approved"/>
<spring:message var="autoMsg_995165a82e" code="mypage.business.status.rejected"/>
<spring:message var="autoMsg_4c6dc5a1bd" code="mypage.business.reason"/>
<spring:message var="autoMsg_53b752f019" code="mypage.business.requestedRole"/>
<spring:message var="autoMsg_94d0ae3432" code="mypage.business.role.business"/>
<spring:message var="autoMsg_de098cef21" code="mypage.business.role.partner"/>
<spring:message var="autoMsg_d33d09e3b8" code="mypage.business.companyName"/>
<spring:message var="autoMsg_35000833f7" code="mypage.business.businessNumber"/>
<spring:message var="autoMsg_9a57d22604" code="mypage.business.managerName"/>
<spring:message var="autoMsg_763ebaf844" code="mypage.business.managerPhone"/>
<spring:message var="autoMsg_1720ee4966" code="mypage.business.description"/>
<spring:message var="autoMsg_185fcb411c" code="mypage.business.submit"/>
<spring:message var="autoMsg_b3395a9398" code="mypage.card.items"/>
<spring:message var="autoMsg_b4e87aab96" code="mypage.empty.items"/>
<spring:message var="autoMsg_4f3391c0a0" code="mypage.items.section.nicknameColor.code"/>
<spring:message var="autoMsg_4a688bf12d" code="mypage.items.section.nicknameColor"/>
<spring:message var="autoMsg_1ddd712d08" code="mypage.items.section.nicknameColor.desc"/>
<spring:message var="autoMsg_5973c7e712" code="mypage.items.section.nicknameEffect.code"/>
<spring:message var="autoMsg_1294ab196b" code="mypage.items.section.nicknameEffect"/>
<spring:message var="autoMsg_84934f3fe7" code="mypage.items.section.nicknameEffect.desc"/>
<spring:message var="autoMsg_fd0c837e77" code="mypage.items.section.profileBadge.code"/>
<spring:message var="autoMsg_e29b856c1b" code="mypage.items.section.profileBadge"/>
<spring:message var="autoMsg_e2703a22bc" code="mypage.items.section.profileBadge.desc"/>
<spring:message var="autoMsg_af78ffbdb7" code="mypage.items.section.bubbleStyle.code"/>
<spring:message var="autoMsg_4b9d6e50f4" code="mypage.items.section.bubbleStyle"/>
<spring:message var="autoMsg_38da52a7a7" code="mypage.items.section.bubbleStyle.desc"/>
<spring:message var="autoMsg_95a542a6b5" code="mypage.levelup.message"/>
<spring:message var="autoMsg_95661c7f97" code="mypage.common.confirm"/>
<spring:message var="autoMsg_96f8760768" code="mypage.history.relative.justNow" javaScriptEscape="true"/>
<spring:message var="autoMsg_eb082ef359" code="mypage.history.relative.minutes" javaScriptEscape="true"/>
<spring:message var="autoMsg_0f1794ae9a" code="mypage.history.relative.hours" javaScriptEscape="true"/>
<spring:message var="autoMsg_14e51ae4cc" code="mypage.history.relative.yesterday" javaScriptEscape="true"/>
<spring:message var="autoMsg_28dc84ae6e" code="mypage.history.relative.days" javaScriptEscape="true"/>
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
<spring:message code="mypage.common.close" var="mypageCloseLabel"/>
<spring:message code="mypage.common.status.reserved" var="statusReserved"/>
<spring:message code="mypage.common.status.booked" var="statusBooked"/>
<spring:message code="mypage.common.status.cancelled" var="statusCancelled"/>
<spring:message code="mypage.common.status.completed" var="statusCompleted"/>
<spring:message code="mypage.booking.cancelPlaceholder" var="bookingCancelPlaceholder"/>
<spring:message code="mypage.asset.points" var="assetPointsLabel"/>
<spring:message code="mypage.asset.mileage" var="assetMileageLabel"/>
<spring:message code="mypage.asset.cash" var="assetCashLabel"/>
<spring:message code="mypage.business.placeholder.companyName" var="businessCompanyNamePlaceholder"/>
<spring:message code="mypage.business.placeholder.optional" var="businessOptionalPlaceholder"/>
<spring:message code="mypage.business.placeholder.managerName" var="businessManagerNamePlaceholder"/>
<spring:message code="mypage.business.placeholder.managerPhone" var="businessManagerPhonePlaceholder"/>
<spring:message code="mypage.business.placeholder.description" var="businessDescriptionPlaceholder"/>
<spring:message code="mypage.notifications.deleteAllConfirm" var="notificationsDeleteAllConfirm"/>
<spring:message code="mypage.grade.name.bronze" var="gradeBronzeLabel"/>
<spring:message code="mypage.grade.name.silver" var="gradeSilverLabel"/>
<spring:message code="mypage.grade.name.gold" var="gradeGoldLabel"/>
<spring:message code="mypage.grade.name.diamond" var="gradeDiamondLabel"/>
<spring:message code="mypage.grade.name.platinum" var="gradePlatinumLabel"/>
<spring:message code="mypage.lang.en" var="mypageLangEnLabel"/>
<spring:message code="mypage.lang.ja" var="mypageLangJaLabel"/>
<spring:message code="mypage.lang.zh" var="mypageLangZhLabel"/>
<spring:message code="mypage.level.badge" var="mypageLevelBadgeLabel"/>
<spring:message code="mypage.level.expUnit" var="mypageLevelExpUnitLabel"/>
<spring:message code="mypage.level.prefix" var="mypageLevelPrefix"/>
<spring:message code="mypage.levelup.title" var="mypageLevelupTitle"/>
<spring:message code="mypage.items.emptyIcon" var="mypageItemsEmptyIconLabel"/>
<spring:message code="mypage.items.icon" var="mypageItemsIconLabel"/>
<spring:message code="mypage.items.packageIcon" var="mypageItemsPackageIconLabel"/>

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
                            <c:when test="${user.nationality eq 'KR'}">&#127760; ${autoMsg_3362febff6}</c:when>
                            <c:when test="${user.nationality eq 'US'}">&#127760; ${autoMsg_52b9bda884}</c:when>
                            <c:when test="${user.nationality eq 'JP'}">&#127760; ${autoMsg_d999e40885}</c:when>
                            <c:when test="${user.nationality eq 'CN'}">&#127760; ${autoMsg_01c615c71e}</c:when>
                            <c:when test="${user.nationality eq 'GB'}">&#127760; ${autoMsg_3fbf4fd68b}</c:when>
                            <c:when test="${user.nationality eq 'FR'}">&#127760; ${autoMsg_90033154dd}</c:when>
                            <c:when test="${user.nationality eq 'DE'}">&#127760; ${autoMsg_adccf5cc06}</c:when>
                            <c:when test="${user.nationality eq 'AU'}">&#127760; ${autoMsg_e961064fbf}</c:when>
                            <c:when test="${user.nationality eq 'CA'}">&#127760; ${autoMsg_272ac87e03}</c:when>
                            <c:otherwise>&#127760; ${user.nationality}</c:otherwise>
                        </c:choose>
                    </span>
                    <span>
                        <c:choose>
                            <c:when test="${user.preferredLang eq 'ko'}">&#128483;&#65039; ${autoMsg_ae017cb7ba}</c:when>
                            <c:when test="${user.preferredLang eq 'en'}">&#128483;&#65039; ${mypageLangEnLabel}</c:when>
                            <c:when test="${user.preferredLang eq 'ja'}">&#128483;&#65039; ${mypageLangJaLabel}</c:when>
                            <c:when test="${user.preferredLang eq 'zh'}">&#128483;&#65039; ${mypageLangZhLabel}</c:when>
                            <c:otherwise>${user.preferredLang}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
            <button class="mp-banner-edit"
                    onclick="location.href='${pageContext.request.contextPath}/mypage/edit-confirm'">
                &#9998; ${autoMsg_d1c3401c79}
            </button>
        </div>
    </div>

    <div class="mp-inner" style="padding-top: 48px;">


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title"><span class="mp-card-icon">&#128202;</span> ${autoMsg_7f4ba90966}</div>
            </div>
            <div class="mp-info-grid">
                <div class="mp-info-item"><div class="mp-info-label">${autoMsg_6e052700d0}</div><div class="mp-info-value"><c:choose><c:when test="${user.memberGrade eq 'BRONZE'}">&#x1F949; ${gradeBronzeLabel}</c:when><c:when test="${user.memberGrade eq 'SILVER'}">&#x1F948; ${gradeSilverLabel}</c:when><c:when test="${user.memberGrade eq 'GOLD'}">&#x1F947; ${gradeGoldLabel}</c:when><c:when test="${user.memberGrade eq 'DIAMOND'}">&#x1F48E; ${gradeDiamondLabel}</c:when><c:when test="${user.memberGrade eq 'PLATINUM'}">&#x1F451; ${gradePlatinumLabel}</c:when><c:otherwise>${user.memberGrade}</c:otherwise></c:choose></div></div>
                <div class="mp-info-item"><div class="mp-info-label">${autoMsg_c28738fcc6}</div><div class="mp-info-value"><c:choose><c:when test="${user.verifiedMember}"><span style="color:#15803d;">&#10004; ${autoMsg_ad9f7ee7bd}</span></c:when><c:otherwise><span style="color:#64748b;">&#10008; ${autoMsg_c9cd016a5f}</span></c:otherwise></c:choose></div></div>
                <div class="mp-info-item"><div class="mp-info-label">${autoMsg_777391ee7c}</div><div class="mp-info-value"><fmt:formatNumber value="${user.cashBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label">${autoMsg_1776d33e12}</div><div class="mp-info-value"><fmt:formatNumber value="${user.mileageBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label">${autoMsg_f5d120209f}</div><div class="mp-info-value"><fmt:formatNumber value="${user.pointBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label">${autoMsg_db82f65024}</div><div class="mp-info-value">${mypageLevelPrefix} ${user.levelNo} / <fmt:formatNumber value="${user.expPoints}" pattern="#,##0"/> ${mypageLevelExpUnitLabel}</div></div>
                <div class="mp-info-item"><div class="mp-info-label">${autoMsg_d9caeb6bc5}</div><div class="mp-info-value">${user.totalPostCount}</div></div>
                <div class="mp-info-item"><div class="mp-info-label">${autoMsg_5b65c911bf}</div><div class="mp-info-value">${user.totalCommentCount}</div></div>
            </div>
        </div>

        <%-- Grade / asset summary section --%>










        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#128176;</span> ${autoMsg_383958b165}
                </div>
            </div>
            <%-- Level card: level badge + EXP progress --%>
            <div class="mp-grade-bar-section">
                <%-- Left badge and right progress area --%>
                <div class="mp-grade-row">
                    <%-- LEVEL badge --%>
                    <span class="mp-grade-badge mp-badge-level">&#9889; ${mypageLevelBadgeLabel}</span>
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
                        <span class="mp-level-label">${mypageLevelPrefix} ${user.levelNo}</span>
                        <span class="mp-level-xp">
                            <fmt:formatNumber value="${user.expPoints}" pattern="#,##0" />
                            /
                            <fmt:formatNumber value="${nextLevelExp}" pattern="#,##0" /> ${mypageLevelExpUnitLabel}
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
            <c:if test="${user.memberGrade eq 'BRONZE'}"><c:set var="currentGradeLabel" value="${gradeBronzeLabel}" /></c:if>
            <c:if test="${user.memberGrade eq 'SILVER'}"><c:set var="currentGradeLabel" value="${gradeSilverLabel}" /></c:if>
            <c:if test="${user.memberGrade eq 'GOLD'}"><c:set var="currentGradeLabel" value="${gradeGoldLabel}" /></c:if>
            <c:if test="${user.memberGrade eq 'DIAMOND'}"><c:set var="currentGradeLabel" value="${gradeDiamondLabel}" /></c:if>
            <c:if test="${user.memberGrade eq 'PLATINUM'}"><c:set var="currentGradeLabel" value="${gradePlatinumLabel}" /></c:if>

            <c:set var="expectedGradeLabel" value="${expectedGrade}" />
            <c:if test="${expectedGrade eq 'BRONZE'}"><c:set var="expectedGradeLabel" value="${gradeBronzeLabel}" /></c:if>
            <c:if test="${expectedGrade eq 'SILVER'}"><c:set var="expectedGradeLabel" value="${gradeSilverLabel}" /></c:if>
            <c:if test="${expectedGrade eq 'GOLD'}"><c:set var="expectedGradeLabel" value="${gradeGoldLabel}" /></c:if>
            <c:if test="${expectedGrade eq 'DIAMOND'}"><c:set var="expectedGradeLabel" value="${gradeDiamondLabel}" /></c:if>
            <c:if test="${expectedGrade eq 'PLATINUM'}"><c:set var="expectedGradeLabel" value="${gradePlatinumLabel}" /></c:if>

            <c:set var="nextGradeLabel" value="${nextGradeName}" />
            <c:if test="${nextGradeName eq 'BRONZE'}"><c:set var="nextGradeLabel" value="${gradeBronzeLabel}" /></c:if>
            <c:if test="${nextGradeName eq 'SILVER'}"><c:set var="nextGradeLabel" value="${gradeSilverLabel}" /></c:if>
            <c:if test="${nextGradeName eq 'GOLD'}"><c:set var="nextGradeLabel" value="${gradeGoldLabel}" /></c:if>
            <c:if test="${nextGradeName eq 'DIAMOND'}"><c:set var="nextGradeLabel" value="${gradeDiamondLabel}" /></c:if>
            <c:if test="${nextGradeName eq 'PLATINUM'}"><c:set var="nextGradeLabel" value="${gradePlatinumLabel}" /></c:if>

            <div class="mp-grade-bar-section">
                <%-- Grade badge + grade payment progress bar --%>
                <div class="mp-grade-row">
                    <%-- Current member grade badge --%>
                    <span class="mp-grade-badge mp-grade-${user.memberGrade}">
    <c:choose>
        <c:when test="${user.memberGrade eq 'BRONZE'}">&#x1F949; ${autoMsg_55bce3e461}</c:when>
        <c:when test="${user.memberGrade eq 'SILVER'}">&#x1F948; ${gradeSilverLabel}</c:when>
        <c:when test="${user.memberGrade eq 'GOLD'}">&#x1F947; ${gradeGoldLabel}</c:when>
        <c:when test="${user.memberGrade eq 'DIAMOND'}">&#x1F48E; ${gradeDiamondLabel}</c:when>
        <c:when test="${user.memberGrade eq 'PLATINUM'}">&#x1F451; ${gradePlatinumLabel}</c:when>
        <c:otherwise>${user.memberGrade}</c:otherwise>
    </c:choose>
</span>
                    <%-- Payment progress area for the next grade --%>
                    <div class="mp-level-wrap">
                        <div class="mp-level-header">
                            <span class="mp-level-label">${autoMsg_6e052700d0}</span>
                            <span class="mp-level-xp">
                                <c:choose>
                                    <c:when test="${isMaxGrade}">
                                        <spring:message code="mypage.grade.maxReached"/>
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
                            <spring:message code="mypage.grade.promotionExpected" arguments="${currentGradeLabel},${expectedGradeLabel}"/>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mp-grade-next-hint">
                            ${autoMsg_299185c9e1}:
                            ${nextGradeLabel}
                            (${autoMsg_a8821b41d2} <fmt:formatNumber value="${nextGradeMin}" pattern="#,##0" /> C ${autoMsg_de8f0aec1b})
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <%-- ????--%>
            <div class="mp-currency-grid">
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-point.svg" alt="${assetPointsLabel}" width="40" height="40"></div>
                    <div class="mp-currency-label">${autoMsg_f5d120209f}</div>
                    <div class="mp-currency-value"><fmt:formatNumber value="${user.pointBalance}" pattern="#,##0" /></div>
                </div>
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-mileage.svg" alt="${assetMileageLabel}" width="40" height="40"></div>
                    <div class="mp-currency-label">${autoMsg_1776d33e12}</div>
                    <div class="mp-currency-value"><fmt:formatNumber value="${user.mileageBalance}" pattern="#,##0" /></div>
                </div>
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-cash.svg" alt="${assetCashLabel}" width="40" height="40"></div>
                    <div class="mp-currency-label">${autoMsg_777391ee7c}</div>
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
                    <span class="mp-stats-source mp-stats-src-community">${autoMsg_558421b0c7}</span>
                    <div class="mp-stats-value">${user.totalPostCount}</div>
                    <div class="mp-stats-label">${autoMsg_256687b65e}</div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-community">${autoMsg_558421b0c7}</span>
                    <div class="mp-stats-value">${user.totalCommentCount}</div>
                    <div class="mp-stats-label">${autoMsg_5b48fe2a6f}</div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-explore">${autoMsg_806b321a9a}</span>
                    <div class="mp-stats-value">0</div>
                    <div class="mp-stats-label">${autoMsg_ab87d87efd}</div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-courses">${autoMsg_ae2a458c93}</span>
                    <div class="mp-stats-value">0</div>
                    <div class="mp-stats-label">${autoMsg_c0344af943}</div>
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
                                        <c:when test="${reward.rewardStatusCode eq 'claimed'}">${autoMsg_d757e426d6}</c:when>
                                        <c:when test="${reward.rewardStatusCode eq 'pending'}">${autoMsg_1d42b19cf5}</c:when>
                                        <c:otherwise>${autoMsg_08f7d07c0a}</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="mp-level-reward-empty">
                        <span class="mp-level-reward-empty-icon">&#127919;</span>
                        <p>${autoMsg_c867da0813}</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Profile information section --%>


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#128100;</span> ${autoMsg_914b7370cc}
                </div>
            </div>
            <div class="mp-info-grid">
                <div class="mp-info-item">
                    <div class="mp-info-label">${autoMsg_b829561b81}</div>
                    <div class="mp-info-value">${user.nickname}</div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">${autoMsg_4ef802baf3}</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${not empty user.userId}">${user.userId}</c:when>
                            <c:otherwise><span style="color:var(--gray-400);">${autoMsg_aca855ec29}</span></c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">${autoMsg_6e3d78d0fc}</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.nationality eq 'KR'}">&#127760; ${autoMsg_3362febff6}</c:when>
                            <c:when test="${user.nationality eq 'US'}">&#127760; ${autoMsg_52b9bda884}</c:when>
                            <c:when test="${user.nationality eq 'JP'}">&#127760; ${autoMsg_d999e40885}</c:when>
                            <c:when test="${user.nationality eq 'CN'}">&#127760; ${autoMsg_01c615c71e}</c:when>
                            <c:when test="${user.nationality eq 'GB'}">&#127760; ${autoMsg_3fbf4fd68b}</c:when>
                            <c:when test="${user.nationality eq 'FR'}">&#127760; ${autoMsg_90033154dd}</c:when>
                            <c:when test="${user.nationality eq 'DE'}">&#127760; ${autoMsg_adccf5cc06}</c:when>
                            <c:when test="${user.nationality eq 'AU'}">&#127760; ${autoMsg_e961064fbf}</c:when>
                            <c:when test="${user.nationality eq 'CA'}">&#127760; ${autoMsg_272ac87e03}</c:when>
                            <c:otherwise>&#127760; ${user.nationality}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">${autoMsg_442d461755}</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.preferredLang eq 'ko'}">&#128483;&#65039; ${autoMsg_ae017cb7ba}</c:when>
                            <c:when test="${user.preferredLang eq 'en'}">&#128483;&#65039; ${mypageLangEnLabel}</c:when>
                            <c:when test="${user.preferredLang eq 'ja'}">&#128483;&#65039; ${mypageLangJaLabel}</c:when>
                            <c:when test="${user.preferredLang eq 'zh'}">&#128483;&#65039; ${mypageLangZhLabel}</c:when>
                            <c:otherwise>${user.preferredLang}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">${autoMsg_2e6ff75d48}</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${not empty user.userEmail}">
                                ${user.userEmail}
                                <c:if test="${user.emailVerified}">
                                    <span style="font-size:11px;color:#15803d;margin-left:4px;">&#10004; ${autoMsg_a1cafac8c5}</span>
                                </c:if>
                            </c:when>
                            <c:otherwise><span style="color:var(--gray-400);">${autoMsg_2efe1573c2}</span></c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">${autoMsg_2b399197ba}</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.accountStatus eq 'ACTIVE'}">
                                <span style="color:#15803d;">&#10004; ${autoMsg_7942b3e568}</span>
                            </c:when>
                            <c:otherwise>${user.accountStatus}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <spring:message code="mypage.tabs.ariaLabel" var="mypageTabsAriaLabel"/>
        <section class="mp-dashboard-tabs" aria-label="${mypageTabsAriaLabel}">
            <div class="mp-tab-nav" role="tablist">
                <button type="button" class="mp-tab-btn is-active" data-mp-tab="activity" role="tab" aria-selected="true">
                    <span>&#128276;</span>
                    <spring:message code="mypage.tabs.activity"/>
                </button>
                <button type="button" class="mp-tab-btn" data-mp-tab="booking" role="tab" aria-selected="false">
                    <span>&#127915;</span>
                    <spring:message code="mypage.tabs.booking"/>
                </button>
                <button type="button" class="mp-tab-btn" data-mp-tab="community" role="tab" aria-selected="false">
                    <span>&#128172;</span>
                    <spring:message code="mypage.tabs.community"/>
                </button>
                <button type="button" class="mp-tab-btn" data-mp-tab="support" role="tab" aria-selected="false">
                    <span>&#128221;</span>
                    <spring:message code="mypage.tabs.support"/>
                </button>
                <c:if test="${user.userRole eq 'USER'}">
                    <button type="button" class="mp-tab-btn" data-mp-tab="business" role="tab" aria-selected="false">
                        <span>&#127970;</span>
                        <spring:message code="mypage.tabs.business"/>
                    </button>
                </c:if>
                <button type="button" class="mp-tab-btn" data-mp-tab="items" role="tab" aria-selected="false">
                    <span>${mypageItemsIconLabel}</span>
                    <spring:message code="mypage.tabs.itemsOnly"/>
                </button>
            </div>

            <div class="mp-tab-panel is-active" data-mp-panel="activity" role="tabpanel">

        <%-- Notification section --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#128276;</span> ${autoMsg_d9aa3afcd8}
                    <c:if test="${headerUnreadCount > 0}">
                        <span class="mp-notif-count">${headerUnreadCount}</span>
                    </c:if>
                </div>
            </div>
            <div class="mp-notif-list" id="mpNotifList">
                <c:choose>
                    <c:when test="${empty notifications}">
                        <div class="mp-notif-empty">${autoMsg_e1f1c61d96}</div>
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
                <c:when test="${noti.sourceType eq 'community'}">[${autoMsg_c1b221e8d6}]</c:when>
                <c:when test="${noti.sourceType eq 'inquiry'}">[${autoMsg_a95bf0b57e}]</c:when>
                <c:when test="${noti.sourceType eq 'report'}">[${autoMsg_5df22ded5e}]</c:when>
                <c:when test="${noti.sourceType eq 'levelup'}">[${autoMsg_03da6dd4dd}]</c:when>
                <c:when test="${noti.sourceType eq 'grade'}">[${autoMsg_38465ab5e2}]</c:when>
                <c:when test="${noti.sourceType eq 'account_block'}">[${autoMsg_13d3b943c0}]</c:when>
                <c:otherwise>[${autoMsg_b781e46c3e}]</c:otherwise>
            </c:choose>
        </span>
        <span class="mp-notif-msg">${noti.message}</span>
        <span class="mp-notif-date">
            <fmt:formatDate value="${noti.createdAtDate}" pattern="yyyy-MM-dd"/>
        </span>
        <button type="button"
                class="mp-notif-delete"
                aria-label="${autoMsg_45ec824ac5}">&#10005;</button>
    </div>
</c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            <c:if test="${not empty notifications}">
                <div class="mp-notif-actions">
                    <button type="button" class="mp-notif-btn" id="mpNotifMarkAll">${autoMsg_fe8e6426cb}</button>
                    <button type="button" class="mp-notif-btn mp-notif-btn-danger" id="mpNotifDeleteAll">${autoMsg_824e2c7066}</button>
                </div>
            </c:if>
            <div class="mp-notif-footer">
                <spring:message code="mypage.notifications.limit"/>
            </div>
        </div>

        <%-- Review section --%>


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">&#11088;</span>
                    <spring:message code="mypage.card.reviews"/>
                    <span class="mp-card-count">${reviewCount}</span>
                </div>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty reviewList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#11088;</div>
                            <spring:message code="mypage.empty.reviews"/>
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
                                    <span class="mp-badge mp-badge-rating">${autoMsg_9c2f6a5371}</span>
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
                    <spring:message code="mypage.card.plans"/>
                    <span class="mp-card-count">${planCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/courses/list"
                   class="mp-card-more">${autoMsg_541ed72721}</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty planList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#128467;</div>
                            <spring:message code="mypage.empty.plans"/>
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
                                            <span class="mp-badge mp-badge-public">${autoMsg_c347f9dd5c}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="mp-badge mp-badge-private">${autoMsg_6fd906648b}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${plan.planSource eq 'AI'}">
                                        <span class="mp-badge mp-badge-ai">${autoMsg_b65623259c}</span>
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
                    <spring:message code="mypage.card.history"/>
                    <span class="mp-card-count">${viewHistoryCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/mypage/history"
                   class="mp-card-more">${autoMsg_541ed72721}</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty viewHistoryList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#128340;</div>
                            <spring:message code="mypage.empty.history"/>
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
                                            <c:otherwise>${autoMsg_c84dd3647e}</c:otherwise>
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
                                        <spring:message code="mypage.history.type.${typeKey}"/>
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
                    <spring:message code="mypage.card.flightBookings"/>
                    <span class="mp-card-count">${flightBookingCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/mypage/bookings/flights"
                   class="mp-card-more">${autoMsg_541ed72721}</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty flightBookingList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#127915;</div>
                            <spring:message code="mypage.empty.flightBookings"/>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mp-flight-booking-grid">
                        <c:forEach var="booking" items="${flightBookingList}">
                            <c:set var="bookingStatusLabel" value="${statusReserved}"/>
                            <c:if test="${booking.status eq 'CANCELLED'}">
                                <c:set var="bookingStatusLabel" value="${statusCancelled}"/>
                            </c:if>

                            <article class="mp-flight-ticket">
                                <div class="mp-flight-ticket-head">
                                    <div>
                                        <span class="mp-flight-status">${bookingStatusLabel}</span>
                                        <h4>${autoMsg_0ea4ca3fb7}</h4>
                                        <p>${autoMsg_ddf52af61d}</p>
                                    </div>
                                    <div class="mp-flight-ticket-price">
                                        <span>${autoMsg_3d435d48c1}</span>
                                        <strong><fmt:formatNumber value="${booking.finalAmount}" pattern="#,##0"/> C</strong>
                                    </div>
                                </div>

                                <div class="mp-flight-route-box">
                                    <div class="mp-flight-route-row">
                                        <span class="mp-flight-route-tag">${autoMsg_8d9b802ff6}</span>
                                        <strong>${booking.originAirportCode} &#8594; ${booking.destinationAirportCode}</strong>
                                        <span><fmt:formatDate value="${booking.departureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                                    </div>
                                    <div class="mp-flight-route-row">
                                        <span class="mp-flight-route-tag return">${autoMsg_cadbf8ead7}</span>
                                        <strong>${booking.returnOriginAirportCode} &#8594; ${booking.returnDestinationAirportCode}</strong>
                                        <span><fmt:formatDate value="${booking.returnDepartureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                                    </div>
                                </div>

                                <div class="mp-flight-ticket-foot">
                                    <span>${booking.airlineName} | ${booking.flightNo} / ${booking.returnFlightNo}</span>
                                    <button type="button"
                                            class="mp-flight-detail-link mp-flight-modal-open"
                                            data-modal-id="flight-booking-${booking.flightPurchaseIdx}">
                                        <spring:message code="mypage.common.detail"/>
                                    </button>
                                </div>
                            </article>

                            <div class="mp-flight-modal" id="flight-booking-${booking.flightPurchaseIdx}">
                                <button type="button" class="mp-flight-modal-backdrop mp-flight-modal-close" aria-label="${mypageCloseLabel}"></button>
                                <div class="mp-flight-modal-card" role="dialog" aria-modal="true">
                                    <div class="mp-flight-modal-head">
                                        <div>
                                            <span class="mp-flight-status">${bookingStatusLabel}</span>
                                            <h3>${autoMsg_e4548d4d22}</h3>
                                            <p>${booking.purchaseNo}</p>
                                        </div>
                                        <button type="button" class="mp-flight-modal-close mp-flight-modal-x" aria-label="${mypageCloseLabel}">&#10005;</button>
                                    </div>

                                    <div class="mp-flight-itinerary">
                                        <div class="mp-flight-itinerary-item">
                                            <span class="mp-flight-route-tag">${autoMsg_8d9b802ff6}</span>
                                            <strong>${booking.originAirportCode} &#8594; ${booking.destinationAirportCode}</strong>
                                            <p>${booking.airlineName} | ${booking.flightNo}</p>
                                            <dl>
                                                <dt>${autoMsg_632ebe3c9e}</dt>
                                                <dd><fmt:formatDate value="${booking.departureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                                <dt>${autoMsg_2d01f96be6}</dt>
                                                <dd><fmt:formatDate value="${booking.arrivalTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                            </dl>
                                        </div>
                                        <div class="mp-flight-itinerary-item">
                                            <span class="mp-flight-route-tag return">${autoMsg_cadbf8ead7}</span>
                                            <strong>${booking.returnOriginAirportCode} &#8594; ${booking.returnDestinationAirportCode}</strong>
                                            <p>${booking.returnAirlineName} | ${booking.returnFlightNo}</p>
                                            <dl>
                                                <dt>${autoMsg_632ebe3c9e}</dt>
                                                <dd><fmt:formatDate value="${booking.returnDepartureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                                <dt>${autoMsg_2d01f96be6}</dt>
                                                <dd><fmt:formatDate value="${booking.returnArrivalTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                            </dl>
                                        </div>
                                    </div>

                                    <div class="mp-flight-payment">
                                        <div><span>${autoMsg_f3d3ad8e5f}</span><strong><fmt:formatNumber value="${booking.originalAmount}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${autoMsg_1220509693}</span><strong>${booking.discountRate}% -<fmt:formatNumber value="${booking.discountAmount}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${autoMsg_ae3aee4a3a}</span><strong><fmt:formatNumber value="${booking.usedCash}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${autoMsg_41f9e848b4}</span><strong><fmt:formatNumber value="${booking.usedMileage}" pattern="#,##0"/> M</strong></div>
                                        <div class="total"><span>${autoMsg_bcd6b94d40}</span><strong><fmt:formatNumber value="${booking.finalAmount}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${autoMsg_07639402da}</span><strong><fmt:formatDate value="${booking.paidAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                    </div>

                                    <p class="mp-flight-mock-note">${autoMsg_821df8ec6c}</p>
                                    <a class="mp-flight-detail-link full" href="${pageContext.request.contextPath}/detail/${booking.spotIdx}">${autoMsg_b381ac1a88}</a>
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
                    <spring:message code="mypage.card.packageBookings"/>
                    <span class="mp-card-count">${packageBookingCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/mypage/bookings/packages"
                   class="mp-card-more">${autoMsg_541ed72721}</a>
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
                            <spring:message code="mypage.empty.packageBookings"/>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mp-flight-booking-grid mp-package-booking-grid">
                        <c:forEach var="packageBooking" items="${packageBookingList}">
                            <c:set var="packageStatusLabel" value="${statusBooked}"/>
                            <c:if test="${packageBooking.bookingStatus eq 'CANCELLED'}">
                                <c:set var="packageStatusLabel" value="${statusCancelled}"/>
                            </c:if>
                            <c:if test="${packageBooking.bookingStatus eq 'COMPLETED'}">
                                <c:set var="packageStatusLabel" value="${statusCompleted}"/>
                            </c:if>

                            <article class="mp-flight-ticket mp-package-ticket">
                                <div class="mp-flight-ticket-head">
                                    <div>
                                        <span class="mp-flight-status mp-package-status">${packageStatusLabel}</span>
                                        <h4>${packageBooking.packageTitle}</h4>
                                        <p>${packageBooking.spotName} 鸚?${autoMsg_ddf52af61d}</p>
                                    </div>
                                    <div class="mp-flight-ticket-price">
                                        <span>${autoMsg_d0ed5ba82f}</span>
                                        <strong><fmt:formatNumber value="${packageBooking.totalPrice}" pattern="#,##0"/> C</strong>
                                    </div>
                                </div>

                                <div class="mp-package-summary-box">
                                    <c:if test="${not empty packageBooking.mainImagePath}">
                                        <img src="${fn:escapeXml(packageBooking.mainImagePath)}" alt="${fn:escapeXml(packageBooking.packageTitle)}">
                                    </c:if>
                                    <c:if test="${empty packageBooking.mainImagePath}">
                                        <div class="mp-package-no-image">${mypageItemsPackageIconLabel}</div>
                                    </c:if>
                                    <div>
                                        <strong>${autoMsg_26e2b300ce}</strong>
                                        <span>
                                            <fmt:formatDate value="${packageBooking.startDate}" pattern="yyyy-MM-dd"/>
                                            ~
                                            <fmt:formatDate value="${packageBooking.endDate}" pattern="yyyy-MM-dd"/>
                                        </span>
                                        <p>${packageBooking.packageSummary}</p>
                                    </div>
                                </div>

                                <div class="mp-flight-ticket-foot">
                                    <span>${autoMsg_e6e594d840}</span>
                                    <button type="button"
                                            class="mp-flight-detail-link mp-flight-modal-open"
                                            data-modal-id="package-booking-${packageBooking.packageBookingIdx}">
                                        <spring:message code="mypage.common.detail"/>
                                    </button>
                                </div>
                            </article>

                            <div class="mp-flight-modal" id="package-booking-${packageBooking.packageBookingIdx}">
                                <button type="button" class="mp-flight-modal-backdrop mp-flight-modal-close" aria-label="${mypageCloseLabel}"></button>
                                <div class="mp-flight-modal-card" role="dialog" aria-modal="true">
                                    <div class="mp-flight-modal-head">
                                        <div>
                                            <span class="mp-flight-status mp-package-status">${packageStatusLabel}</span>
                                            <h3>${autoMsg_1038d4683f}</h3>
                                            <p>${packageBooking.bookingNo}</p>
                                        </div>
                                        <button type="button" class="mp-flight-modal-close mp-flight-modal-x" aria-label="${mypageCloseLabel}">&#10005;</button>
                                    </div>

                                    <div class="mp-package-modal-summary">
                                        <c:if test="${not empty packageBooking.mainImagePath}">
                                            <img src="${fn:escapeXml(packageBooking.mainImagePath)}" alt="${fn:escapeXml(packageBooking.packageTitle)}">
                                        </c:if>
                                        <c:if test="${empty packageBooking.mainImagePath}">
                                            <div class="mp-package-no-image">${mypageItemsPackageIconLabel}</div>
                                        </c:if>
                                        <div>
                                            <h4>${packageBooking.packageTitle}</h4>
                                            <p>${packageBooking.packageSummary}</p>
                                            <a href="${pageContext.request.contextPath}/detail/${packageBooking.spotIdx}">${autoMsg_9122276136}</a>
                                        </div>
                                    </div>

                                    <div class="mp-flight-payment">
                                        <div><span>${autoMsg_735bd807f3}</span><strong>${autoMsg_88d438cc74}</strong></div>
                                        <div><span>${autoMsg_2ac1d93bd0}</span><strong><fmt:formatNumber value="${packageBooking.unitPrice}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${autoMsg_ae3aee4a3a}</span><strong><fmt:formatNumber value="${packageBooking.usedCash}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${autoMsg_41f9e848b4}</span><strong><fmt:formatNumber value="${packageBooking.usedMileage}" pattern="#,##0"/> M</strong></div>
                                        <div class="total"><span>${autoMsg_840e5c531a}</span><strong><fmt:formatNumber value="${packageBooking.totalPrice}" pattern="#,##0"/> C</strong></div>
                                        <div><span>${autoMsg_0a8f0a81a8}</span><strong><fmt:formatDate value="${packageBooking.bookedAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                        <c:if test="${packageBooking.bookingStatus eq 'CANCELLED'}">
                                            <div><span>${autoMsg_d0664d9d7c}</span><strong><fmt:formatDate value="${packageBooking.cancelledAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                            <div>
                                                <span>${autoMsg_0c2e9d375b}</span>
                                                <strong>
                                                    <c:choose>
                                                        <c:when test="${empty packageBooking.cancelReason}">${autoMsg_598c00d3f1}</c:when>
                                                        <c:otherwise>${packageBooking.cancelReason}</c:otherwise>
                                                    </c:choose>
                                                </strong>
                                            </div>
                                        </c:if>
                                    </div>

                                    <p class="mp-flight-mock-note">${autoMsg_aa472626e8}</p>
                                    <c:if test="${packageBooking.bookingStatus eq 'BOOKED'}">
                                        <form class="mp-package-cancel-form"
                                              action="${pageContext.request.contextPath}/packages/bookings/${packageBooking.packageBookingIdx}/cancel"
                                              method="post">
                                            <label for="package-cancel-reason-${packageBooking.packageBookingIdx}">${autoMsg_ff521daa8c}</label>
                                            <textarea id="package-cancel-reason-${packageBooking.packageBookingIdx}"
                                                      name="cancelReason"
                                                      maxlength="500"
                                                      placeholder="${bookingCancelPlaceholder}"></textarea>
                                            <button type="submit">${autoMsg_f35299404c}</button>
                                        </form>
                                    </c:if>
                                    <a class="mp-flight-detail-link full" href="${pageContext.request.contextPath}/packages">${autoMsg_6a7e1483e8}</a>
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
                    <spring:message code="mypage.card.community"/>
                    <span class="mp-card-count">${communityCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/community/list?userIdx=${user.userIdx}"
                   class="mp-card-more">${autoMsg_541ed72721}</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty communityList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#9997;</div>
                            <spring:message code="mypage.empty.community"/>
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
                                            <c:when test="${post.postType eq 'review'}">${autoMsg_a290bdff6f}</c:when>
                                            <c:when test="${post.postType eq 'photo'}">${autoMsg_b937f56014}</c:when>
                                            <c:when test="${post.postType eq 'tip'}">${autoMsg_fb5f7de1eb}</c:when>
                                            <c:when test="${post.postType eq 'question'}">${autoMsg_1c5e1743f7}</c:when>
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
                    <spring:message code="mypage.card.inquiries"/>
                    <span class="mp-card-count">${inquiryCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/inquiry/list"
                   class="mp-card-more">${autoMsg_541ed72721}</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty inquiryList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#128221;</div>
                            <spring:message code="mypage.empty.inquiries"/>
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
                                                <c:when test="${inq.category eq 'service'}">${autoMsg_e41262b274}</c:when>
                                                <c:when test="${inq.category eq 'payment'}">${autoMsg_166a5630fb}</c:when>
                                                <c:when test="${inq.category eq 'account'}">${autoMsg_25b1c21c54}</c:when>
                                                <c:when test="${inq.category eq 'bug'}">${autoMsg_f223019f42}</c:when>
                                                <c:otherwise>${autoMsg_a4142fa5f4}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-${inq.status}">
                                        <c:choose>
                                            <c:when test="${inq.status eq 'PENDING'}">${autoMsg_d2578ce875}</c:when>
                                            <c:when test="${inq.status eq 'IN_PROGRESS'}">${autoMsg_cb49cabff8}</c:when>
                                            <c:when test="${inq.status eq 'COMPLETED'}">&#10004; ${autoMsg_e7ee4b79dd}</c:when>
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
                    <spring:message code="mypage.card.reports"/>
                    <span class="mp-card-count">${reportCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/report/list"
                   class="mp-card-more">${autoMsg_541ed72721}</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty reportList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">&#9888;</div>
                            <spring:message code="mypage.empty.reports"/>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="rpt" items="${reportList}">
                            <a href="${pageContext.request.contextPath}/report/${rpt.reportId}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">
                                        <c:choose>
                                            <c:when test="${rpt.targetType eq 'post'}">${autoMsg_d8198986bd}</c:when>
                                            <c:when test="${rpt.targetType eq 'comment'}">${autoMsg_ff86de67fc}</c:when>
                                            <c:when test="${rpt.targetType eq 'user'}">${autoMsg_db99709620}</c:when>
                                            <c:otherwise>${autoMsg_f2694c4d06}</c:otherwise>
                                        </c:choose>
                                        <span style="color:var(--gray-400);font-size:12px;margin-left:4px;">#${rpt.targetId}</span>
                                    </div>
                                    <div class="mp-list-meta">
                                        <span><fmt:formatDate value="${rpt.createdAtDate}" pattern="yyyy-MM-dd"/></span>
                                        <c:if test="${not empty rpt.reason}">
                                            <span>
                                                <c:choose>
                                                    <c:when test="${rpt.reason eq 'spam'}">${autoMsg_76781c8ba5}</c:when>
                                                    <c:when test="${rpt.reason eq 'abuse'}">${autoMsg_dbee15473c}</c:when>
                                                    <c:when test="${rpt.reason eq 'privacy'}">${autoMsg_0cb7c8fd34}</c:when>
                                                    <c:when test="${rpt.reason eq 'adult'}">${autoMsg_24a1351605}</c:when>
                                                    <c:when test="${rpt.reason eq 'illegal'}">${autoMsg_9e47ef632a}</c:when>
                                                    <c:when test="${rpt.reason eq 'other'}">${autoMsg_5dae044dc0}</c:when>
                                                    <c:otherwise>${rpt.reason}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-${rpt.status}">
                                        <c:choose>
                                            <c:when test="${rpt.status eq 'IN_REVIEW'}">${autoMsg_ba6ab204b9}</c:when>
                                            <c:when test="${rpt.status eq 'RESOLVED'}">${autoMsg_7a4c7fe32e}</c:when>
                                            <c:when test="${rpt.status eq 'DISMISSED'}">${autoMsg_e6d72b6f92}</c:when>
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
                        <spring:message code="mypage.card.businessApplication"/>
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
                            <span class="mp-business-kicker">${autoMsg_5e2d3acbb3}</span>
                            <strong>${autoMsg_a3b43faf36}</strong>
                        </div>
                        <c:if test="${not empty businessApplication}">
                            <span class="mp-business-badge ${businessApplication.applicationStatus}">
                                <c:choose>
                                    <c:when test="${businessApplication.applicationStatus eq 'PENDING'}">${autoMsg_bcc2de252b}</c:when>
                                    <c:when test="${businessApplication.applicationStatus eq 'APPROVED'}">${autoMsg_ebe890d08b}</c:when>
                                    <c:when test="${businessApplication.applicationStatus eq 'REJECTED'}">${autoMsg_995165a82e}</c:when>
                                    <c:otherwise>${businessApplication.applicationStatus}</c:otherwise>
                                </c:choose>
                            </span>
                        </c:if>
                    </div>

                    <c:choose>
                        <c:when test="${not empty businessApplication and businessApplication.applicationStatus eq 'PENDING'}">
                            <p class="mp-business-note">
                                <spring:message code="mypage.business.pendingNote" arguments="${fn:escapeXml(businessApplication.companyName)}"/>
                                <spring:message code="mypage.business.appliedAt"/>: <fmt:formatDate value="${businessApplication.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/>
                            </p>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${not empty businessApplication and businessApplication.applicationStatus eq 'REJECTED'}">
                                <div class="mp-business-reject">
                                    <spring:message code="mypage.business.rejectedPrevious"/>
                                    <c:if test="${not empty businessApplication.rejectReason}">
                                        ${autoMsg_4c6dc5a1bd}: ${fn:escapeXml(businessApplication.rejectReason)}
                                    </c:if>
                                </div>
                            </c:if>

                            <form class="mp-business-form" method="post" action="${pageContext.request.contextPath}/mypage/business-application">
                                <div>
                                    <label>${autoMsg_53b752f019}</label>
                                    <select name="requestedRole" required>
                                        <option value="BUSINESS">${autoMsg_94d0ae3432}</option>
                                        <option value="PARTNER">${autoMsg_de098cef21}</option>
                                    </select>
                                </div>
                                <div>
                                    <label>${autoMsg_d33d09e3b8}</label>
                                    <input type="text" name="companyName" maxlength="100" required placeholder="${businessCompanyNamePlaceholder}">
                                </div>
                                <div>
                                    <label>${autoMsg_35000833f7}</label>
                                    <input type="text" name="businessNumber" maxlength="50" placeholder="${businessOptionalPlaceholder}">
                                </div>
                                <div>
                                    <label>${autoMsg_9a57d22604}</label>
                                    <input type="text" name="managerName" maxlength="50" required placeholder="${businessManagerNamePlaceholder}">
                                </div>
                                <div>
                                    <label>${autoMsg_763ebaf844}</label>
                                    <input type="text" name="managerPhone" maxlength="30" required placeholder="${businessManagerPhonePlaceholder}">
                                </div>
                                <div class="mp-business-form-full">
                                    <label>${autoMsg_1720ee4966}</label>
                                    <textarea name="description" maxlength="1000" rows="4" placeholder="${businessDescriptionPlaceholder}"></textarea>
                                </div>
                                <div class="mp-business-form-full">
                                    <button type="submit" class="mp-business-submit">${autoMsg_185fcb411c}</button>
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
                    <span class="mp-card-icon">${mypageItemsIconLabel}</span> ${autoMsg_b3395a9398}
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
                        <div class="mp-empty-icon">${mypageItemsEmptyIconLabel}</div>
                        <div>${autoMsg_b4e87aab96}</div>
                        <button class="mp-item-shop-btn"
                                type="button"
                                onclick="location.href='${pageContext.request.contextPath}/shop'">
                            <spring:message code="mypage.items.goShop"/>
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
                                    <span>${autoMsg_4f3391c0a0}</span>
                                    <div>
                                        <h3>${autoMsg_4a688bf12d}</h3>
                                        <p>${autoMsg_1ddd712d08}</p>
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
                                    <span>${autoMsg_5973c7e712}</span>
                                    <div>
                                        <h3>${autoMsg_1294ab196b}</h3>
                                        <p>${autoMsg_84934f3fe7}</p>
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
                                    <span>${autoMsg_fd0c837e77}</span>
                                    <div>
                                        <h3>${autoMsg_e29b856c1b}</h3>
                                        <p>${autoMsg_e2703a22bc}</p>
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
                                    <span>${autoMsg_af78ffbdb7}</span>
                                    <div>
                                        <h3>${autoMsg_4b9d6e50f4}</h3>
                                        <p>${autoMsg_38da52a7a7}</p>
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
                if (!confirm("${fn:escapeXml(notificationsDeleteAllConfirm)}")) return;
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
        <div class="levelup-title">${mypageLevelupTitle}</div>
        <div class="levelup-level">${mypageLevelPrefix} ${levelUpLevel}</div>
        <div class="levelup-msg">${autoMsg_95a542a6b5}</div>
        <button class="levelup-close-btn" onclick="closeLevelUpPopup()">${autoMsg_95661c7f97}</button>
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
        justNow:   '${autoMsg_96f8760768}',
        minutes:   '${autoMsg_eb082ef359}',
        hours:     '${autoMsg_0f1794ae9a}',
        yesterday: '${autoMsg_14e51ae4cc}',
        days:      '${autoMsg_28dc84ae6e}'
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
