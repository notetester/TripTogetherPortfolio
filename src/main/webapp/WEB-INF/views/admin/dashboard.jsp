<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="dashboard"/>
<spring:message code="admin.dashboard.pageTitle" var="adminDashboardPageTitle"/>
<c:set var="pageTitle" value="${adminDashboardPageTitle}"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="stat-grid">
        <div class="stat-card blue">
            <div class="stat-label"><spring:message code="admin.dashboard.totalMembers"/></div>
            <div class="stat-value"><fmt:formatNumber value="${stats.totalMembers}" pattern="#,###"/></div>
            <div class="stat-sub"><spring:message code="admin.dashboard.todayNewMembers" arguments="${stats.todayNewMembers}"/></div>
            <div class="stat-icon">👥</div>
        </div>
        <div class="stat-card green">
            <div class="stat-label"><spring:message code="admin.dashboard.activeMembers"/></div>
            <div class="stat-value"><fmt:formatNumber value="${stats.activeMembers}" pattern="#,###"/></div>
            <div class="stat-sub"><spring:message code="admin.dashboard.activeMembersSub"/></div>
            <div class="stat-icon">✅</div>
        </div>
        <div class="stat-card yellow">
            <div class="stat-label"><spring:message code="admin.dashboard.dormantMembers"/></div>
            <div class="stat-value"><fmt:formatNumber value="${stats.dormantMembers}" pattern="#,###"/></div>
            <div class="stat-sub"><spring:message code="admin.dashboard.dormantMembersSub"/></div>
            <div class="stat-icon">😴</div>
        </div>
        <div class="stat-card red">
            <div class="stat-label"><spring:message code="admin.dashboard.todayFailedLogins"/></div>
            <div class="stat-value"><fmt:formatNumber value="${stats.todayFailedLogins}" pattern="#,###"/></div>
            <div class="stat-sub"><spring:message code="admin.dashboard.loginLogoutSummary" arguments="${stats.todayLogins},${stats.todayLogouts}"/></div>
            <div class="stat-icon">🚨</div>
        </div>
        <div class="stat-card purple">
            <div class="stat-label"><spring:message code="admin.dashboard.socialLinked"/></div>
            <div class="stat-value"><fmt:formatNumber value="${stats.kakaoLinked + stats.naverLinked + stats.googleLinked}" pattern="#,###"/></div>
            <div class="stat-sub"><spring:message code="admin.dashboard.socialLinkedSub"/></div>
            <div class="stat-icon">🔗</div>
        </div>
        <div class="stat-card blue">
            <div class="stat-label"><spring:message code="admin.dashboard.pendingInquiries"/></div>
            <div class="stat-value"><fmt:formatNumber value="${stats.pendingInquiries}" pattern="#,###"/></div>
            <div class="stat-sub"><spring:message code="admin.dashboard.totalInquiries" arguments="${stats.totalInquiries}"/></div>
            <div class="stat-icon">📩</div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.dashboard.serviceOverview"/></div>
        </div>
        <div class="adm-card-body">
            <div class="stat-grid" style="margin-bottom:0;">
                <div class="stat-card">
                    <div class="stat-label"><spring:message code="admin.dashboard.communityPosts"/></div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.totalCommunityPosts}" pattern="#,###"/></div>
                    <div class="stat-sub"><spring:message code="admin.dashboard.activePosts" arguments="${stats.activeCommunityPosts}"/></div>
                </div>
                <div class="stat-card">
                    <div class="stat-label"><spring:message code="admin.dashboard.activeReports"/></div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.activeReports}" pattern="#,###"/></div>
                    <div class="stat-sub"><spring:message code="admin.dashboard.activeReportsSub"/></div>
                </div>
                <div class="stat-card">
                    <div class="stat-label"><spring:message code="admin.dashboard.completedInquiries"/></div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.completedInquiries}" pattern="#,###"/></div>
                    <div class="stat-sub"><spring:message code="admin.dashboard.completedInquiriesSub"/></div>
                </div>
                <div class="stat-card">
                    <div class="stat-label"><spring:message code="admin.dashboard.todayLogouts"/></div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.todayLogouts}" pattern="#,###"/></div>
                    <div class="stat-sub"><spring:message code="admin.dashboard.logoutProviderSummary" arguments="${stats.todayLocalLogouts},${stats.todayKakaoLogouts},${stats.todayNaverLogouts},${stats.todayGoogleLogouts}"/></div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.dashboard.socialOverview"/></div>
        </div>
        <div class="adm-card-body">
            <div style="display:flex;gap:20px;flex-wrap:wrap;">
                <div class="social-card" style="flex:1;min-width:120px;text-align:center;padding:16px;border-radius:10px;">
                    <div style="font-size:24px;margin-bottom:8px;">🟡</div>
                    <div class="social-card-value" style="font-size:22px;font-weight:700;"><fmt:formatNumber value="${stats.kakaoLinked}" pattern="#,###"/></div>
                    <div style="font-size:11px;color:#64748b;margin-top:4px;"><spring:message code="admin.logs.provider.kakao"/></div>
                </div>
                <div class="social-card" style="flex:1;min-width:120px;text-align:center;padding:16px;border-radius:10px;">
                    <div style="font-size:24px;margin-bottom:8px;color:#03c75a;font-weight:900;">N</div>
                    <div class="social-card-value" style="font-size:22px;font-weight:700;"><fmt:formatNumber value="${stats.naverLinked}" pattern="#,###"/></div>
                    <div style="font-size:11px;color:#64748b;margin-top:4px;"><spring:message code="admin.logs.provider.naver"/></div>
                </div>
                <div class="social-card" style="flex:1;min-width:120px;text-align:center;padding:16px;border-radius:10px;">
                    <div style="font-size:24px;margin-bottom:8px;color:#4285f4;font-weight:900;">G</div>
                    <div class="social-card-value" style="font-size:22px;font-weight:700;"><fmt:formatNumber value="${stats.googleLinked}" pattern="#,###"/></div>
                    <div style="font-size:11px;color:#64748b;margin-top:4px;"><spring:message code="admin.logs.provider.google"/></div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.dashboard.quickLinks"/></div>
        </div>
        <div class="adm-card-body" style="display:flex;gap:12px;flex-wrap:wrap;">
            <a href="${pageContext.request.contextPath}/admin/members" class="adm-btn adm-btn-primary">👥 <spring:message code="admin.layout.menu.members"/></a>
            <a href="${pageContext.request.contextPath}/admin/policies" class="adm-btn adm-btn-ghost">⚙️ <spring:message code="admin.layout.menu.policies"/></a>
            <a href="${pageContext.request.contextPath}/admin/logins?eventType=LOGIN&amp;success=FAIL" class="adm-btn adm-btn-ghost">🔐 <spring:message code="admin.dashboard.viewFailedLogins"/></a>
            <a href="${pageContext.request.contextPath}/admin/logins?eventType=LOGOUT" class="adm-btn adm-btn-ghost">↩️ <spring:message code="admin.dashboard.viewLogoutHistory"/></a>
            <a href="${pageContext.request.contextPath}/admin/inquiries?status=PENDING" class="adm-btn adm-btn-ghost">📩 <spring:message code="admin.dashboard.viewPendingInquiries"/></a>
        </div>
    </div>
</div>

<%@ include file="layout-close.jsp" %>
