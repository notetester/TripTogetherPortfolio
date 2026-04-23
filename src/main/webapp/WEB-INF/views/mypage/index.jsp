<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  마이페이지 메인
  Controller : GET /mypage
  Model 필요 :
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

<%-- ── 레벨 바 · 등급 바 공통 추가 스타일 ── --%>
<style>
    /* ── 공통: 뱃지 + 바 가로 한 줄 레이아웃 ── */
    .mp-grade-row {
        display: flex;
        align-items: center;
        gap: 24px;
    }
    /* 뱃지 크기 통일: LEVEL과 BRONZE 등 모든 뱃지가 동일한 너비를 차지하도록 고정 */
    .mp-grade-row .mp-grade-badge {
        flex-shrink: 0;
        min-width: 120px;        /* 가장 긴 뱃지(PLATINUM)에 맞춘 고정 너비 */
        text-align: center;      /* 텍스트 가운데 정렬 */
        box-sizing: border-box;
    }
    /* 바 영역이 남은 공간을 모두 차지 → 뱃지 너비가 같으면 바 길이도 자동으로 같아짐 */
    .mp-grade-row .mp-level-wrap {
        flex: 1;
        min-width: 180px;
    }

    /* ── LEVEL 뱃지 (BRONZE 뱃지와 동일한 알약 스타일, 보라색 테마) ── */
    .mp-badge-level {
        background: #ede9fe;
        color: #5b21b6;
        border: 1.5px solid #c4b5fd;
    }

    /* ── 등급 바 섹션 ── */
    .mp-grade-bar-section {
        padding: 16px 24px 20px;
    }

    /* ── 등급 바 채움 색상 (금색 그라데이션) ── */
    .mp-grade-fill {
        height: 100%;
        background: linear-gradient(90deg, #f59e0b 0%, #d97706 100%);
        border-radius: 4px;
        transition: width .4s ease;
    }

    /* ── 승급 예정 안내 (할당량 100% 달성 시) ── */
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

    /* ── 다음 등급 힌트 (바 미달성 시) ── */
    .mp-grade-next-hint {
        margin-top: 6px;
        font-size: 11px;
        color: var(--gray-400, #94a3b8);
    }
</style>

<div class="mp-wrap">

    <%-- ══════════════════════════════════════════
         프로필 배너
    ══════════════════════════════════════════ --%>
    <div class="mp-banner">
        <div class="mp-banner-inner">
            <div class="mp-avatar">👤</div>
            <div class="mp-banner-info">
                <div class="mp-banner-nick">${user.nickname}</div>
                <div class="mp-banner-meta">
                    <span>
                        <c:choose>
                            <c:when test="${user.nationality eq 'KR'}">🇰🇷 <spring:message code="mypage.country.kr"/></c:when>
                            <c:when test="${user.nationality eq 'US'}">🇺🇸 <spring:message code="mypage.country.us"/></c:when>
                            <c:when test="${user.nationality eq 'JP'}">🇯🇵 <spring:message code="mypage.country.jp"/></c:when>
                            <c:when test="${user.nationality eq 'CN'}">🇨🇳 <spring:message code="mypage.country.cn"/></c:when>
                            <c:when test="${user.nationality eq 'GB'}">🇬🇧 <spring:message code="mypage.country.gb"/></c:when>
                            <c:when test="${user.nationality eq 'FR'}">🇫🇷 <spring:message code="mypage.country.fr"/></c:when>
                            <c:when test="${user.nationality eq 'DE'}">🇩🇪 <spring:message code="mypage.country.de"/></c:when>
                            <c:when test="${user.nationality eq 'AU'}">🇦🇺 <spring:message code="mypage.country.au"/></c:when>
                            <c:when test="${user.nationality eq 'CA'}">🇨🇦 <spring:message code="mypage.country.ca"/></c:when>
                            <c:otherwise>🌍 ${user.nationality}</c:otherwise>
                        </c:choose>
                    </span>
                    <span>
                        <c:choose>
                            <c:when test="${user.preferredLang eq 'ko'}">🇰🇷 <spring:message code="mypage.lang.ko"/></c:when>
                            <c:when test="${user.preferredLang eq 'en'}">🇺🇸 ${mypageLangEnLabel}</c:when>
                            <c:when test="${user.preferredLang eq 'ja'}">🇯🇵 ${mypageLangJaLabel}</c:when>
                            <c:when test="${user.preferredLang eq 'zh'}">🇨🇳 ${mypageLangZhLabel}</c:when>
                            <c:otherwise>${user.preferredLang}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
            <button class="mp-banner-edit"
                    onclick="location.href='${pageContext.request.contextPath}/mypage/edit-confirm'">
                ✏️ <spring:message code="mypage.profile.edit"/>
            </button>
        </div>
    </div>

    <div class="mp-inner" style="padding-top: 48px;">


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title"><span class="mp-card-icon">🏷️</span> <spring:message code="mypage.summary.title"/></div>
            </div>
            <div class="mp-info-grid">
                <div class="mp-info-item"><div class="mp-info-label"><spring:message code="mypage.summary.memberGrade"/></div><div class="mp-info-value"><c:choose><c:when test="${user.memberGrade eq 'BRONZE'}">${gradeBronzeLabel}</c:when><c:when test="${user.memberGrade eq 'SILVER'}">${gradeSilverLabel}</c:when><c:when test="${user.memberGrade eq 'GOLD'}">${gradeGoldLabel}</c:when><c:when test="${user.memberGrade eq 'DIAMOND'}">${gradeDiamondLabel}</c:when><c:when test="${user.memberGrade eq 'PLATINUM'}">${gradePlatinumLabel}</c:when><c:otherwise>${user.memberGrade}</c:otherwise></c:choose></div></div>
                <div class="mp-info-item"><div class="mp-info-label"><spring:message code="mypage.summary.verifiedMember"/></div><div class="mp-info-value"><c:choose><c:when test="${user.verifiedMember}"><span style="color:#15803d;">● <spring:message code="mypage.summary.verified"/></span></c:when><c:otherwise><span style="color:#64748b;">○ <spring:message code="mypage.summary.unverified"/></span></c:otherwise></c:choose></div></div>
                <div class="mp-info-item"><div class="mp-info-label"><spring:message code="mypage.asset.cash"/></div><div class="mp-info-value"><fmt:formatNumber value="${user.cashBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label"><spring:message code="mypage.asset.mileage"/></div><div class="mp-info-value"><fmt:formatNumber value="${user.mileageBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label"><spring:message code="mypage.asset.points"/></div><div class="mp-info-value"><fmt:formatNumber value="${user.pointBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label"><spring:message code="mypage.summary.levelExp"/></div><div class="mp-info-value">${mypageLevelPrefix} ${user.levelNo} / <fmt:formatNumber value="${user.expPoints}" pattern="#,##0"/> ${mypageLevelExpUnitLabel}</div></div>
                <div class="mp-info-item"><div class="mp-info-label"><spring:message code="mypage.summary.postCount"/></div><div class="mp-info-value">${user.totalPostCount}</div></div>
                <div class="mp-info-item"><div class="mp-info-label"><spring:message code="mypage.summary.commentCount"/></div><div class="mp-info-value">${user.totalCommentCount}</div></div>
            </div>
        </div>

        <%-- ══════════════════════════════════════════
             내 등급 & 재화
             TODO: UsersVO 필드 추가 후 EL 교체
               - 등급: ${user.memberGrade}       (BRONZE/SILVER/GOLD/DIAMOND/PLATINUM)
               - 인증: ${user.isVerifiedMember}  (boolean)
               - 레벨: ${user.levelNo}
               - 경험치: ${user.expPoints}
               - 포인트: ${user.pointBalance}
               - 마일리지: ${user.mileageBalance}
               - 캐시: ${user.cashBalance}
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🏅</span> <spring:message code="mypage.gradeAsset.title"/>
                </div>
            </div>
            <%-- 레벨/경험치 바 (LEVEL 뱃지 + 바 가로 배치) --%>
            <div class="mp-grade-bar-section">
                <%-- LEVEL 뱃지 + 바를 가로 한 줄로 (등급 바와 동일한 구조) --%>
                <div class="mp-grade-row">
                    <%-- 왼쪽: LEVEL 뱃지 (BRONZE 뱃지와 동일한 알약 스타일) --%>
                    <span class="mp-grade-badge mp-badge-level">⚡ ${mypageLevelBadgeLabel}</span>
                    <%-- 오른쪽: 레벨 경험치 바 --%>
                    <div class="mp-level-wrap">
                    <%--
                        경험치 바 계산 로직:
                        - currentLevelExp : 현재 레벨에 진입하기 위해 필요했던 누적 EXP (시작점)
                        - nextLevelExp    : 다음 레벨에 진입하기 위해 필요한 누적 EXP (끝점)
                        - user.expPoints  : 유저의 현재 누적 EXP
                        - 바 퍼센트 = (현재EXP - 현재레벨시작EXP) / (다음레벨EXP - 현재레벨시작EXP) × 100
                    --%>
                    <c:set var="expInLevel" value="${user.expPoints - currentLevelExp}" />
                    <c:set var="expNeeded" value="${nextLevelExp - currentLevelExp}" />
                    <c:set var="expPercent" value="${expNeeded > 0 ? (expInLevel * 100 / expNeeded) : 100}" />
                    <%-- 퍼센트가 100을 넘지 않도록 보정 --%>
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

            <%-- ── 등급 진행 바 ── --%>
            <%--
                등급 바 계산 로직:
                - gradePolicies       : 활성 등급 정책 목록 (sort_order ASC: BRONZE→PLATINUM)
                - currentMonthPayment : 당월 결제 총액 (이번 달 결제 → 다음 달 등급 산정 기준)
                - 다음 등급의 min_monthly_payment → 바의 끝점
                - 최고 등급이면 바 100%로 채움
            --%>
            <c:set var="currentGradeMin" value="0" />
            <c:set var="nextGradeMin" value="0" />
            <c:set var="nextGradeName" value="" />
            <c:set var="nextGradeFound" value="false" />
            <c:set var="isMaxGrade" value="true" />
            <%-- 당월 결제액 기준으로 예상되는 등급 계산 --%>
            <c:set var="expectedGrade" value="BRONZE" />

            <%-- 등급 정책 순회: 현재 등급의 기준값 + 다음 등급 정보 + 예상 등급 --%>
            <c:forEach var="gp" items="${gradePolicies}">
                <c:if test="${gp.memberGrade eq user.memberGrade}">
                    <c:set var="currentGradeMin" value="${gp.minMonthlyPayment}" />
                </c:if>
                <%-- 당월 결제액이 충족하는 가장 높은 등급 = 예상 등급 --%>
                <c:if test="${currentMonthPayment >= gp.minMonthlyPayment}">
                    <c:set var="expectedGrade" value="${gp.memberGrade}" />
                </c:if>
            </c:forEach>

            <%-- 다음 등급 찾기: 현재 등급보다 기준이 높은 첫 번째 등급 --%>
            <c:forEach var="gp" items="${gradePolicies}">
                <c:if test="${!nextGradeFound && gp.minMonthlyPayment > currentGradeMin}">
                    <c:set var="nextGradeMin" value="${gp.minMonthlyPayment}" />
                    <c:set var="nextGradeName" value="${gp.memberGrade}" />
                    <c:set var="nextGradeFound" value="true" />
                    <c:set var="isMaxGrade" value="false" />
                </c:if>
            </c:forEach>

            <%-- 등급 바 퍼센트 계산 --%>
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
                <%-- 등급 뱃지 + 바를 가로로 나란히 배치 (레벨 바와 동일한 구조) --%>
                <div class="mp-grade-row">
                    <%-- 왼쪽: 등급 뱃지 --%>
                    <span class="mp-grade-badge mp-grade-${user.memberGrade}">
                        <c:choose>
                            <c:when test="${user.memberGrade eq 'BRONZE'}">🥉 ${gradeBronzeLabel}</c:when>
                            <c:when test="${user.memberGrade eq 'SILVER'}">🥈 ${gradeSilverLabel}</c:when>
                            <c:when test="${user.memberGrade eq 'GOLD'}">🥇 ${gradeGoldLabel}</c:when>
                            <c:when test="${user.memberGrade eq 'DIAMOND'}">💎 ${gradeDiamondLabel}</c:when>
                            <c:when test="${user.memberGrade eq 'PLATINUM'}">👑 ${gradePlatinumLabel}</c:when>
                            <c:otherwise>${user.memberGrade}</c:otherwise>
                        </c:choose>
                    </span>
                    <%-- 오른쪽: 바 영역 (레벨 바와 동일한 mp-level-wrap 구조) --%>
                    <div class="mp-level-wrap">
                        <div class="mp-level-header">
                            <span class="mp-level-label"><spring:message code="mypage.summary.memberGrade"/></span>
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
                <%-- 바 아래 승급 예정 / 다음 등급 안내 --%>
                <c:choose>
                    <c:when test="${isMaxGrade}">
                        <%-- 최고 등급이면 별도 안내 없음 --%>
                    </c:when>
                    <c:when test="${expectedGrade ne user.memberGrade}">
                        <div class="mp-grade-promotion">
                            <spring:message code="mypage.grade.promotionExpected" arguments="${currentGradeLabel},${expectedGradeLabel}"/>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mp-grade-next-hint">
                            <spring:message code="mypage.grade.next"/>:
                            ${nextGradeLabel}
                            (<spring:message code="mypage.grade.thisMonthPaymentPrefix"/> <fmt:formatNumber value="${nextGradeMin}" pattern="#,##0" /> C <spring:message code="mypage.grade.thisMonthPaymentSuffix"/>)
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <%-- 재화 --%>
            <div class="mp-currency-grid">
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-point.svg" alt="${assetPointsLabel}" width="40" height="40"></div>
                    <div class="mp-currency-label"><spring:message code="mypage.asset.points"/></div>
                    <div class="mp-currency-value"><fmt:formatNumber value="${user.pointBalance}" pattern="#,##0" /></div>
                </div>
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-mileage.svg" alt="${assetMileageLabel}" width="40" height="40"></div>
                    <div class="mp-currency-label"><spring:message code="mypage.asset.mileage"/></div>
                    <div class="mp-currency-value"><fmt:formatNumber value="${user.mileageBalance}" pattern="#,##0" /></div>
                </div>
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-cash.svg" alt="${assetCashLabel}" width="40" height="40"></div>
                    <div class="mp-currency-label"><spring:message code="mypage.asset.cash"/></div>
                    <div class="mp-currency-value"><fmt:formatNumber value="${user.cashBalance}" pattern="#,##0" /></div>
                </div>
            </div>
            <%-- 활동 통계
                 TODO: UsersVO 필드 추가 후 EL 교체
                   - 작성글:    ${user.totalPostCount}
                   - 작성댓글:  ${user.totalCommentCount}
                   - 리뷰:      ${user.totalReviewCount}    (explore 팀 구현 후)
                   - 여행코스:  ${user.totalCourseCount}    (courses 팀 구현 후)
            --%>
            <div class="mp-stats-grid">
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-community"><spring:message code="mypage.stats.community"/></span>
                    <div class="mp-stats-value">${user.totalPostCount}</div>
                    <div class="mp-stats-label"><spring:message code="mypage.stats.posts"/></div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-community"><spring:message code="mypage.stats.community"/></span>
                    <div class="mp-stats-value">${user.totalCommentCount}</div>
                    <div class="mp-stats-label"><spring:message code="mypage.stats.comments"/></div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-explore"><spring:message code="mypage.stats.explore"/></span>
                    <div class="mp-stats-value">0</div>
                    <div class="mp-stats-label"><spring:message code="mypage.stats.reviews"/></div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-courses"><spring:message code="mypage.stats.courses"/></span>
                    <div class="mp-stats-value">0</div>
                    <div class="mp-stats-label"><spring:message code="mypage.stats.travelCourses"/></div>
                </div>
            </div>
        </div>

        <%-- ══════════════════════════════════════════
             내 정보
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🪪</span> <spring:message code="mypage.profile.title"/>
                </div>
            </div>
            <div class="mp-info-grid">
                <div class="mp-info-item">
                    <div class="mp-info-label"><spring:message code="mypage.nickname"/></div>
                    <div class="mp-info-value">${user.nickname}</div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label"><spring:message code="mypage.profile.userId"/></div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${not empty user.userId}">${user.userId}</c:when>
                            <c:otherwise><span style="color:var(--gray-400);"><spring:message code="mypage.profile.socialOnly"/></span></c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label"><spring:message code="mypage.nationality"/></div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.nationality eq 'KR'}">🇰🇷 <spring:message code="mypage.country.kr"/></c:when>
                            <c:when test="${user.nationality eq 'US'}">🇺🇸 <spring:message code="mypage.country.us"/></c:when>
                            <c:when test="${user.nationality eq 'JP'}">🇯🇵 <spring:message code="mypage.country.jp"/></c:when>
                            <c:when test="${user.nationality eq 'CN'}">🇨🇳 <spring:message code="mypage.country.cn"/></c:when>
                            <c:when test="${user.nationality eq 'GB'}">🇬🇧 <spring:message code="mypage.country.gb"/></c:when>
                            <c:when test="${user.nationality eq 'FR'}">🇫🇷 <spring:message code="mypage.country.fr"/></c:when>
                            <c:when test="${user.nationality eq 'DE'}">🇩🇪 <spring:message code="mypage.country.de"/></c:when>
                            <c:when test="${user.nationality eq 'AU'}">🇦🇺 <spring:message code="mypage.country.au"/></c:when>
                            <c:when test="${user.nationality eq 'CA'}">🇨🇦 <spring:message code="mypage.country.ca"/></c:when>
                            <c:otherwise>🌍 ${user.nationality}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label"><spring:message code="mypage.language"/></div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.preferredLang eq 'ko'}">🇰🇷 <spring:message code="mypage.lang.ko"/></c:when>
                            <c:when test="${user.preferredLang eq 'en'}">🇺🇸 ${mypageLangEnLabel}</c:when>
                            <c:when test="${user.preferredLang eq 'ja'}">🇯🇵 ${mypageLangJaLabel}</c:when>
                            <c:when test="${user.preferredLang eq 'zh'}">🇨🇳 ${mypageLangZhLabel}</c:when>
                            <c:otherwise>${user.preferredLang}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label"><spring:message code="mypage.profile.email"/></div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${not empty user.userEmail}">
                                ${user.userEmail}
                                <c:if test="${user.emailVerified}">
                                    <span style="font-size:11px;color:#15803d;margin-left:4px;">✓ <spring:message code="mypage.profile.emailVerified"/></span>
                                </c:if>
                            </c:when>
                            <c:otherwise><span style="color:var(--gray-400);"><spring:message code="mypage.profile.notRegistered"/></span></c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label"><spring:message code="mypage.profile.accountStatus"/></div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.accountStatus eq 'ACTIVE'}">
                                <span style="color:#15803d;">● <spring:message code="mypage.profile.active"/></span>
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
                    <span>📬</span>
                    <spring:message code="mypage.tabs.activity"/>
                </button>
                <button type="button" class="mp-tab-btn" data-mp-tab="booking" role="tab" aria-selected="false">
                    <span>✈️</span>
                    <spring:message code="mypage.tabs.booking"/>
                </button>
                <button type="button" class="mp-tab-btn" data-mp-tab="community" role="tab" aria-selected="false">
                    <span>✍️</span>
                    <spring:message code="mypage.tabs.community"/>
                </button>
                <button type="button" class="mp-tab-btn" data-mp-tab="support" role="tab" aria-selected="false">
                    <span>🧾</span>
                    <spring:message code="mypage.tabs.support"/>
                </button>
                <c:if test="${user.userRole eq 'USER'}">
                    <button type="button" class="mp-tab-btn" data-mp-tab="business" role="tab" aria-selected="false">
                        <span>🏢</span>
                        <spring:message code="mypage.tabs.business"/>
                    </button>
                </c:if>
                <button type="button" class="mp-tab-btn" data-mp-tab="items" role="tab" aria-selected="false">
                    <span>${mypageItemsIconLabel}</span>
                    <spring:message code="mypage.tabs.itemsOnly"/>
                </button>
            </div>

            <div class="mp-tab-panel is-active" data-mp-panel="activity" role="tabpanel">

        <%-- 알림 카드 --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">📬</span> <spring:message code="mypage.card.notifications"/>
                    <c:if test="${headerUnreadCount > 0}">
                        <span class="mp-notif-count">${headerUnreadCount}</span>
                    </c:if>
                </div>
            </div>
            <div class="mp-notif-list" id="mpNotifList">
                <c:choose>
                    <c:when test="${empty notifications}">
                        <div class="mp-notif-empty"><spring:message code="mypage.empty.notifications"/></div>
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
                <c:when test="${noti.sourceType eq 'community'}">[<spring:message code="mypage.notification.type.community"/>]</c:when>
                <c:when test="${noti.sourceType eq 'inquiry'}">[<spring:message code="mypage.notification.type.inquiry"/>]</c:when>
                <c:when test="${noti.sourceType eq 'report'}">[<spring:message code="mypage.notification.type.report"/>]</c:when>
                <c:when test="${noti.sourceType eq 'levelup'}">[<spring:message code="mypage.notification.type.levelup"/>]</c:when>
                <c:when test="${noti.sourceType eq 'grade'}">[<spring:message code="mypage.notification.type.grade"/>]</c:when>
                <c:when test="${noti.sourceType eq 'account_block'}">[<spring:message code="mypage.notification.type.accountBlock"/>]</c:when>
                <c:otherwise>[<spring:message code="mypage.notification.type.default"/>]</c:otherwise>
            </c:choose>
        </span>
        <span class="mp-notif-msg">${noti.message}</span>
        <span class="mp-notif-date">
            <fmt:formatDate value="${noti.createdAt}" pattern="yyyy-MM-dd"/>
        </span>
        <button type="button"
                class="mp-notif-delete"
                aria-label="<spring:message code='mypage.notifications.delete'/>">🗑️</button>
    </div>
</c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            <c:if test="${not empty notifications}">
                <div class="mp-notif-actions">
                    <button type="button" class="mp-notif-btn" id="mpNotifMarkAll"><spring:message code="mypage.notifications.markAllRead"/></button>
                    <button type="button" class="mp-notif-btn mp-notif-btn-danger" id="mpNotifDeleteAll"><spring:message code="mypage.notifications.deleteAll"/></button>
                </div>
            </c:if>
            <div class="mp-notif-footer">
                <spring:message code="mypage.notifications.limit"/>
            </div>
        </div>

        <%-- ══════════════════════════════════════════
             내 리뷰
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">⭐</span>
                    <spring:message code="mypage.card.reviews"/>
                    <span class="mp-card-count">${reviewCount}</span>
                </div>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty reviewList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">⭐</div>
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
                                                    <c:when test="${i <= review.rating}">★</c:when>
                                                    <c:otherwise>☆</c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </span>
                                        <c:if test="${not empty review.content}">
                                            <span class="mp-review-excerpt">${fn:substring(review.content, 0, 40)}<c:if test="${fn:length(review.content) > 40}">…</c:if></span>
                                        </c:if>
                                        <span><fmt:formatDate value="${review.createdAt}" pattern="yyyy-MM-dd"/></span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-rating"><spring:message code="mypage.review.rating" arguments="${review.rating}"/></span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>


        <%-- ══════════════════════════════════════════
             내 여행 일정
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🗺️</span>
                    <spring:message code="mypage.card.plans"/>
                    <span class="mp-card-count">${planCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/courses/list"
                   class="mp-card-more"><spring:message code="mypage.common.viewAll"/></a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty planList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">🗺️</div>
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
                                        <span><fmt:formatDate value="${plan.createdAt}" pattern="yyyy-MM-dd"/></span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <c:choose>
                                        <c:when test="${plan.isPublic}">
                                            <span class="mp-badge mp-badge-public"><spring:message code="mypage.plan.public"/></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="mp-badge mp-badge-private"><spring:message code="mypage.plan.private"/></span>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${plan.planSource eq 'AI'}">
                                        <span class="mp-badge mp-badge-ai"><spring:message code="mypage.plan.source.ai"/></span>
                                    </c:if>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

            </div>
            <div class="mp-tab-panel" data-mp-panel="booking" role="tabpanel" hidden>

        <%-- ══════════════════════════════════════════
             항공권 예매 정보
             - 항공권 구매 시뮬레이션으로 생성된 FLIGHT_PURCHASE_SIMULATION 이력
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">✈️</span>
                    <spring:message code="mypage.card.flightBookings"/>
                    <span class="mp-card-count">${flightBookingCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/mypage/bookings/flights"
                   class="mp-card-more"><spring:message code="mypage.common.viewAll"/></a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty flightBookingList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">✈️</div>
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
                                        <h4><spring:message code="mypage.booking.flightRoundTrip" arguments="${booking.spotName}"/></h4>
                                        <p><spring:message code="mypage.booking.reservationNo" arguments="${booking.purchaseNo}"/></p>
                                    </div>
                                    <div class="mp-flight-ticket-price">
                                        <span><spring:message code="mypage.booking.finalPayment"/></span>
                                        <strong><fmt:formatNumber value="${booking.finalAmount}" pattern="#,##0"/> C</strong>
                                    </div>
                                </div>

                                <div class="mp-flight-route-box">
                                    <div class="mp-flight-route-row">
                                        <span class="mp-flight-route-tag"><spring:message code="mypage.booking.outbound"/></span>
                                        <strong>${booking.originAirportCode} → ${booking.destinationAirportCode}</strong>
                                        <span><fmt:formatDate value="${booking.departureTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                    </div>
                                    <div class="mp-flight-route-row">
                                        <span class="mp-flight-route-tag return"><spring:message code="mypage.booking.return"/></span>
                                        <strong>${booking.returnOriginAirportCode} → ${booking.returnDestinationAirportCode}</strong>
                                        <span><fmt:formatDate value="${booking.returnDepartureTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                    </div>
                                </div>

                                <div class="mp-flight-ticket-foot">
                                    <span>${booking.airlineName} · ${booking.flightNo} / ${booking.returnFlightNo}</span>
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
                                            <h3><spring:message code="mypage.booking.flightDetail"/></h3>
                                            <p>${booking.purchaseNo}</p>
                                        </div>
                                        <button type="button" class="mp-flight-modal-close mp-flight-modal-x" aria-label="${mypageCloseLabel}">×</button>
                                    </div>

                                    <div class="mp-flight-itinerary">
                                        <div class="mp-flight-itinerary-item">
                                            <span class="mp-flight-route-tag"><spring:message code="mypage.booking.outbound"/></span>
                                            <strong>${booking.originAirportCode} → ${booking.destinationAirportCode}</strong>
                                            <p>${booking.airlineName} · ${booking.flightNo}</p>
                                            <dl>
                                                <dt><spring:message code="mypage.booking.departure"/></dt>
                                                <dd><fmt:formatDate value="${booking.departureTime}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                                <dt><spring:message code="mypage.booking.arrival"/></dt>
                                                <dd><fmt:formatDate value="${booking.arrivalTime}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                            </dl>
                                        </div>
                                        <div class="mp-flight-itinerary-item">
                                            <span class="mp-flight-route-tag return"><spring:message code="mypage.booking.return"/></span>
                                            <strong>${booking.returnOriginAirportCode} → ${booking.returnDestinationAirportCode}</strong>
                                            <p>${booking.returnAirlineName} · ${booking.returnFlightNo}</p>
                                            <dl>
                                                <dt><spring:message code="mypage.booking.departure"/></dt>
                                                <dd><fmt:formatDate value="${booking.returnDepartureTime}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                                <dt><spring:message code="mypage.booking.arrival"/></dt>
                                                <dd><fmt:formatDate value="${booking.returnArrivalTime}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                            </dl>
                                        </div>
                                    </div>

                                    <div class="mp-flight-payment">
                                        <div><span><spring:message code="mypage.booking.originalAmount"/></span><strong><fmt:formatNumber value="${booking.originalAmount}" pattern="#,##0"/> C</strong></div>
                                        <div><span><spring:message code="mypage.booking.gradeDiscount"/></span><strong>${booking.discountRate}% · -<fmt:formatNumber value="${booking.discountAmount}" pattern="#,##0"/> C</strong></div>
                                        <div><span><spring:message code="mypage.booking.usedCash"/></span><strong><fmt:formatNumber value="${booking.usedCash}" pattern="#,##0"/> C</strong></div>
                                        <div><span><spring:message code="mypage.booking.usedMileage"/></span><strong><fmt:formatNumber value="${booking.usedMileage}" pattern="#,##0"/> M</strong></div>
                                        <div class="total"><span><spring:message code="mypage.booking.finalAmount"/></span><strong><fmt:formatNumber value="${booking.finalAmount}" pattern="#,##0"/> C</strong></div>
                                        <div><span><spring:message code="mypage.booking.paidAt"/></span><strong><fmt:formatDate value="${booking.paidAt}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                    </div>

                                    <p class="mp-flight-mock-note"><spring:message code="mypage.booking.mockFlight"/></p>
                                    <a class="mp-flight-detail-link full" href="${pageContext.request.contextPath}/detail/${booking.spotIdx}"><spring:message code="mypage.booking.spotDetail"/></a>
                                </div>
                            </div>
                        </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- ══════════════════════════════════════════
             패키지 예약 정보
             - 패키지 예약/결제 시뮬레이션으로 생성된 TRAVEL_PACKAGE_BOOKING 이력
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🎒</span>
                    <spring:message code="mypage.card.packageBookings"/>
                    <span class="mp-card-count">${packageBookingCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/mypage/bookings/packages"
                   class="mp-card-more"><spring:message code="mypage.common.viewAll"/></a>
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
                            <div class="mp-empty-icon">🎒</div>
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
                                        <p>${packageBooking.spotName} · <spring:message code="mypage.booking.reservationNo" arguments="${packageBooking.bookingNo}"/></p>
                                    </div>
                                    <div class="mp-flight-ticket-price">
                                        <span><spring:message code="mypage.booking.totalPayment"/></span>
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
                                        <strong><spring:message code="mypage.booking.peopleReserved" arguments="${packageBooking.peopleCount}"/></strong>
                                        <span>
                                            <fmt:formatDate value="${packageBooking.startDate}" pattern="yyyy-MM-dd"/>
                                            ~
                                            <fmt:formatDate value="${packageBooking.endDate}" pattern="yyyy-MM-dd"/>
                                        </span>
                                        <p>${packageBooking.packageSummary}</p>
                                    </div>
                                </div>

                                <div class="mp-flight-ticket-foot">
                                    <span><spring:message code="mypage.booking.seller" arguments="${packageBooking.sellerNickname}"/></span>
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
                                            <h3><spring:message code="mypage.booking.packageDetail"/></h3>
                                            <p>${packageBooking.bookingNo}</p>
                                        </div>
                                        <button type="button" class="mp-flight-modal-close mp-flight-modal-x" aria-label="${mypageCloseLabel}">×</button>
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
                                            <a href="${pageContext.request.contextPath}/detail/${packageBooking.spotIdx}"><spring:message code="mypage.booking.spotNameDetail" arguments="${packageBooking.spotName}"/></a>
                                        </div>
                                    </div>

                                    <div class="mp-flight-payment">
                                        <div><span><spring:message code="mypage.booking.peopleCount"/></span><strong><spring:message code="mypage.booking.people" arguments="${packageBooking.peopleCount}"/></strong></div>
                                        <div><span><spring:message code="mypage.booking.unitPrice"/></span><strong><fmt:formatNumber value="${packageBooking.unitPrice}" pattern="#,##0"/> C</strong></div>
                                        <div><span><spring:message code="mypage.booking.usedCash"/></span><strong><fmt:formatNumber value="${packageBooking.usedCash}" pattern="#,##0"/> C</strong></div>
                                        <div><span><spring:message code="mypage.booking.usedMileage"/></span><strong><fmt:formatNumber value="${packageBooking.usedMileage}" pattern="#,##0"/> M</strong></div>
                                        <div class="total"><span><spring:message code="mypage.booking.totalAmount"/></span><strong><fmt:formatNumber value="${packageBooking.totalPrice}" pattern="#,##0"/> C</strong></div>
                                        <div><span><spring:message code="mypage.booking.bookedAt"/></span><strong><fmt:formatDate value="${packageBooking.bookedAt}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                        <c:if test="${packageBooking.bookingStatus eq 'CANCELLED'}">
                                            <div><span><spring:message code="mypage.booking.cancelledAt"/></span><strong><fmt:formatDate value="${packageBooking.cancelledAt}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                            <div>
                                                <span><spring:message code="mypage.booking.cancelReason"/></span>
                                                <strong>
                                                    <c:choose>
                                                        <c:when test="${empty packageBooking.cancelReason}"><spring:message code="mypage.none"/></c:when>
                                                        <c:otherwise>${packageBooking.cancelReason}</c:otherwise>
                                                    </c:choose>
                                                </strong>
                                            </div>
                                        </c:if>
                                    </div>

                                    <p class="mp-flight-mock-note"><spring:message code="mypage.booking.mockPackage"/></p>
                                    <c:if test="${packageBooking.bookingStatus eq 'BOOKED'}">
                                        <form class="mp-package-cancel-form"
                                              action="${pageContext.request.contextPath}/packages/bookings/${packageBooking.packageBookingIdx}/cancel"
                                              method="post">
                                            <label for="package-cancel-reason-${packageBooking.packageBookingIdx}"><spring:message code="mypage.booking.packageCancelReasonLabel"/></label>
                                            <textarea id="package-cancel-reason-${packageBooking.packageBookingIdx}"
                                                      name="cancelReason"
                                                      maxlength="500"
                                                      placeholder="${bookingCancelPlaceholder}"></textarea>
                                            <button type="submit"><spring:message code="mypage.booking.cancelAndRefund"/></button>
                                        </form>
                                    </c:if>
                                    <a class="mp-flight-detail-link full" href="${pageContext.request.contextPath}/packages"><spring:message code="mypage.booking.packageList"/></a>
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


        <%-- ══════════════════════════════════════════
             내가 작성한 커뮤니티 글
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">✍️</span>
                    <spring:message code="mypage.card.community"/>
                    <span class="mp-card-count">${communityCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/community/list?userIdx=${user.userIdx}"
                   class="mp-card-more"><spring:message code="mypage.common.viewAll"/></a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty communityList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">📝</div>
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
                                        <span><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd"/></span>
                                        <span>👁 ${post.viewCount}</span>
                                        <span>❤️ ${post.likeCount}</span>
                                        <span>💬 ${post.commentCount}</span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-type-${post.postType}">
                                        <c:choose>
                                            <c:when test="${post.postType eq 'review'}"><spring:message code="mypage.community.type.review"/></c:when>
                                            <c:when test="${post.postType eq 'photo'}"><spring:message code="mypage.community.type.photo"/></c:when>
                                            <c:when test="${post.postType eq 'tip'}"><spring:message code="mypage.community.type.tip"/></c:when>
                                            <c:when test="${post.postType eq 'question'}"><spring:message code="mypage.community.type.question"/></c:when>
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

        <%-- ══════════════════════════════════════════
             내 문의 글
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">📬</span>
                    <spring:message code="mypage.card.inquiries"/>
                    <span class="mp-card-count">${inquiryCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/inquiry/list"
                   class="mp-card-more"><spring:message code="mypage.common.viewAll"/></a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty inquiryList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">📭</div>
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
                                        <span><fmt:formatDate value="${inq.createdAt}" pattern="yyyy-MM-dd"/></span>
                                        <span>
                                            <c:choose>
                                                <c:when test="${inq.category eq 'service'}"><spring:message code="mypage.inquiry.category.service"/></c:when>
                                                <c:when test="${inq.category eq 'payment'}"><spring:message code="mypage.inquiry.category.payment"/></c:when>
                                                <c:when test="${inq.category eq 'account'}"><spring:message code="mypage.inquiry.category.account"/></c:when>
                                                <c:when test="${inq.category eq 'bug'}"><spring:message code="mypage.inquiry.category.bug"/></c:when>
                                                <c:otherwise><spring:message code="mypage.inquiry.category.other"/></c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-${inq.status}">
                                        <c:choose>
                                            <c:when test="${inq.status eq 'PENDING'}"><spring:message code="mypage.inquiry.status.pending"/></c:when>
                                            <c:when test="${inq.status eq 'IN_PROGRESS'}"><spring:message code="mypage.inquiry.status.inProgress"/></c:when>
                                            <c:when test="${inq.status eq 'COMPLETED'}">✓ <spring:message code="mypage.inquiry.status.completed"/></c:when>
                                        </c:choose>
                                    </span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>


        <%-- ══════════════════════════════════════════
             내 신고내역
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🚨</span>
                    <spring:message code="mypage.card.reports"/>
                    <span class="mp-card-count">${reportCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/report/list"
                   class="mp-card-more"><spring:message code="mypage.common.viewAll"/></a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty reportList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">📭</div>
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
                                            <c:when test="${rpt.targetType eq 'post'}"><spring:message code="mypage.report.target.post"/></c:when>
                                            <c:when test="${rpt.targetType eq 'comment'}"><spring:message code="mypage.report.target.comment"/></c:when>
                                            <c:when test="${rpt.targetType eq 'user'}"><spring:message code="mypage.report.target.user"/></c:when>
                                            <c:otherwise><spring:message code="mypage.report.target.default"/></c:otherwise>
                                        </c:choose>
                                        <span style="color:var(--gray-400);font-size:12px;margin-left:4px;">#${rpt.targetId}</span>
                                    </div>
                                    <div class="mp-list-meta">
                                        <span><fmt:formatDate value="${rpt.createdAt}" pattern="yyyy-MM-dd"/></span>
                                        <c:if test="${not empty rpt.reason}">
                                            <span>
                                                <c:choose>
                                                    <c:when test="${rpt.reason eq 'spam'}"><spring:message code="mypage.report.reason.spam"/></c:when>
                                                    <c:when test="${rpt.reason eq 'abuse'}"><spring:message code="mypage.report.reason.abuse"/></c:when>
                                                    <c:when test="${rpt.reason eq 'privacy'}"><spring:message code="mypage.report.reason.privacy"/></c:when>
                                                    <c:when test="${rpt.reason eq 'adult'}"><spring:message code="mypage.report.reason.adult"/></c:when>
                                                    <c:when test="${rpt.reason eq 'illegal'}"><spring:message code="mypage.report.reason.illegal"/></c:when>
                                                    <c:when test="${rpt.reason eq 'other'}"><spring:message code="mypage.report.reason.other"/></c:when>
                                                    <c:otherwise>${rpt.reason}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-${rpt.status}">
                                        <c:choose>
                                            <c:when test="${rpt.status eq 'IN_REVIEW'}"><spring:message code="mypage.report.status.inReview"/></c:when>
                                            <c:when test="${rpt.status eq 'RESOLVED'}"><spring:message code="mypage.report.status.resolved"/></c:when>
                                            <c:when test="${rpt.status eq 'DISMISSED'}"><spring:message code="mypage.report.status.dismissed"/></c:when>
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

            <%-- ══════════════════════════════════════════
                 기업 회원 신청
                 - 운영자/봇/시스템 계정은 공급자 신청 대상이 아니므로 USER에게만 노출한다.
            ══════════════════════════════════════════ --%>
            <div class="mp-card">
                <div class="mp-card-head">
                    <div class="mp-card-title">
                        <span class="mp-card-icon">🏢</span>
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
                            <span class="mp-business-kicker"><spring:message code="mypage.business.currentAccountType"/></span>
                            <strong><spring:message code="mypage.business.normalUser"/></strong>
                        </div>
                        <c:if test="${not empty businessApplication}">
                            <span class="mp-business-badge ${businessApplication.applicationStatus}">
                                <c:choose>
                                    <c:when test="${businessApplication.applicationStatus eq 'PENDING'}"><spring:message code="mypage.business.status.pending"/></c:when>
                                    <c:when test="${businessApplication.applicationStatus eq 'APPROVED'}"><spring:message code="mypage.business.status.approved"/></c:when>
                                    <c:when test="${businessApplication.applicationStatus eq 'REJECTED'}"><spring:message code="mypage.business.status.rejected"/></c:when>
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
                                        <spring:message code="mypage.business.reason"/>: ${fn:escapeXml(businessApplication.rejectReason)}
                                    </c:if>
                                </div>
                            </c:if>

                            <form class="mp-business-form" method="post" action="${pageContext.request.contextPath}/mypage/business-application">
                                <div>
                                    <label><spring:message code="mypage.business.requestedRole"/></label>
                                    <select name="requestedRole" required>
                                        <option value="BUSINESS"><spring:message code="mypage.business.role.business"/></option>
                                        <option value="PARTNER"><spring:message code="mypage.business.role.partner"/></option>
                                    </select>
                                </div>
                                <div>
                                    <label><spring:message code="mypage.business.companyName"/></label>
                                    <input type="text" name="companyName" maxlength="100" required placeholder="${businessCompanyNamePlaceholder}">
                                </div>
                                <div>
                                    <label><spring:message code="mypage.business.businessNumber"/></label>
                                    <input type="text" name="businessNumber" maxlength="50" placeholder="${businessOptionalPlaceholder}">
                                </div>
                                <div>
                                    <label><spring:message code="mypage.business.managerName"/></label>
                                    <input type="text" name="managerName" maxlength="50" required placeholder="${businessManagerNamePlaceholder}">
                                </div>
                                <div>
                                    <label><spring:message code="mypage.business.managerPhone"/></label>
                                    <input type="text" name="managerPhone" maxlength="30" required placeholder="${businessManagerPhonePlaceholder}">
                                </div>
                                <div class="mp-business-form-full">
                                    <label><spring:message code="mypage.business.description"/></label>
                                    <textarea name="description" maxlength="1000" rows="4" placeholder="${businessDescriptionPlaceholder}"></textarea>
                                </div>
                                <div class="mp-business-form-full">
                                    <button type="submit" class="mp-business-submit"><spring:message code="mypage.business.submit"/></button>
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
                    <span class="mp-card-icon">${mypageItemsIconLabel}</span> <spring:message code="mypage.card.items"/>
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
                        <div><spring:message code="mypage.empty.items"/></div>
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
                                    <span><spring:message code="mypage.items.section.nicknameColor.code"/></span>
                                    <div>
                                        <h3><spring:message code="mypage.items.section.nicknameColor"/></h3>
                                        <p><spring:message code="mypage.items.section.nicknameColor.desc"/></p>
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
                                    <span><spring:message code="mypage.items.section.nicknameEffect.code"/></span>
                                    <div>
                                        <h3><spring:message code="mypage.items.section.nicknameEffect"/></h3>
                                        <p><spring:message code="mypage.items.section.nicknameEffect.desc"/></p>
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
                                    <span><spring:message code="mypage.items.section.profileBadge.code"/></span>
                                    <div>
                                        <h3><spring:message code="mypage.items.section.profileBadge"/></h3>
                                        <p><spring:message code="mypage.items.section.profileBadge.desc"/></p>
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
                                    <span><spring:message code="mypage.items.section.bubbleStyle.code"/></span>
                                    <div>
                                        <h3><spring:message code="mypage.items.section.bubbleStyle"/></h3>
                                        <p><spring:message code="mypage.items.section.bubbleStyle.desc"/></p>
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
     * 단일 알림 삭제
     */
    /* ===== 뒤로가기 캐시 새로고침 ===== */
    window.addEventListener('pageshow', function(e) {
        if (e.persisted) location.reload();
    });

    (function () {
        const ctx = '${pageContext.request.contextPath}';
        const list = document.getElementById('mpNotifList');
        const markAllBtn = document.getElementById('mpNotifMarkAll');
        const deleteAllBtn = document.getElementById('mpNotifDeleteAll');
        if (!list) return;

        // 이벤트 위임: 알림 아이템 클릭 or 삭제 버튼 클릭
        list.addEventListener('click', function (e) {
            const deleteBtn = e.target.closest('.mp-notif-delete');
            const item = e.target.closest('.mp-notif-item');
            if (!item) return;
            const id = item.dataset.notificationId;

            // 삭제 버튼 클릭 → 이벤트 전파 차단 + DELETE
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

            // 아이템 클릭 → 읽음 처리 + 이동
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

        // 모두 읽음
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

        // 전체 삭제
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
     * 날짜 포맷팅 (YYYY-MM-DD)
     */
    function formatDate(dateString) {
        const date = new Date(dateString);
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

</script>

<%-- ══════════════════════════════════════════
     레벨업 축하 팝업
     Controller에서 levelUpLevel 값이 전달되면 자동으로 표시됩니다.
══════════════════════════════════════════ --%>
<c:if test="${not empty levelUpLevel}">
<div id="levelup-overlay" class="levelup-overlay">
    <div class="levelup-popup">
        <div class="levelup-icon">🎉</div>
        <div class="levelup-title">${mypageLevelupTitle}</div>
        <div class="levelup-level">${mypageLevelPrefix} ${levelUpLevel}</div>
        <div class="levelup-msg"><spring:message code="mypage.levelup.message"/></div>
        <button class="levelup-close-btn" onclick="closeLevelUpPopup()"><spring:message code="mypage.common.confirm"/></button>
    </div>
</div>
<style>
    /* ── 레벨업 팝업 오버레이 ── */
    .levelup-overlay {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0,0,0,0.5);
        display: flex; align-items: center; justify-content: center;
        z-index: 9999;
        animation: levelup-fade-in 0.3s ease;
    }
    /* ── 팝업 카드 ── */
    .levelup-popup {
        background: #fff; border-radius: 20px; padding: 40px 48px;
        text-align: center; box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        animation: levelup-scale-in 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    }
    /* ── 아이콘 ── */
    .levelup-icon {
        font-size: 56px; margin-bottom: 8px;
        animation: levelup-bounce 0.6s ease 0.3s both;
    }
    /* ── LEVEL UP! 타이틀 ── */
    .levelup-title {
        font-size: 14px; font-weight: 700; letter-spacing: 4px;
        color: #6366f1; margin-bottom: 4px;
    }
    /* ── 레벨 숫자 ── */
    .levelup-level {
        font-size: 40px; font-weight: 800;
        background: linear-gradient(135deg, #6366f1, #a855f7);
        -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        background-clip: text; margin-bottom: 8px;
    }
    /* ── 축하 메시지 ── */
    .levelup-msg {
        font-size: 15px; color: #64748b; margin-bottom: 24px;
    }
    /* ── 확인 버튼 ── */
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
    /* ── 애니메이션 ── */
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
     * 레벨업 팝업 닫기.
     * 오버레이를 fade-out 시키고 DOM에서 제거합니다.
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

<%@ include file="../common/footer.jsp" %>
</body>
</html>
