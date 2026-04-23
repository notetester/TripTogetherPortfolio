<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="dashboard"/>
<spring:message code="admin.dashboard.pageTitle" var="adminDashboardPageTitle"/>
<spring:message code="admin.dashboard.chart.newMembers" var="adminDashboardChartNewMembers"/>
<spring:message code="admin.dashboard.chart.logins" var="adminDashboardChartLogins"/>
<spring:message code="admin.dashboard.chart.dataset.newMembers" var="adminDashboardChartDatasetNewMembers"/>
<spring:message code="admin.dashboard.chart.dataset.success" var="adminDashboardChartDatasetSuccess"/>
<spring:message code="admin.dashboard.chart.dataset.fail" var="adminDashboardChartDatasetFail"/>
<c:set var="pageTitle" value="${adminDashboardPageTitle}"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">
    <div class="stat-grid">
        <div class="stat-card blue">
            <div class="stat-label"><spring:message code="admin.dashboard.totalMembers"/></div>
            <div class="stat-value"><fmt:formatNumber value="${stats.totalMembers}" pattern="#,###"/></div>
            <div class="stat-sub"><spring:message code="admin.dashboard.todayNewMembers" arguments="${stats.todayNewMembers}"/></div>
            <div class="adm-inline-actions" style="margin-top:12px;">
                <a href="${pageContext.request.contextPath}/admin/members" class="adm-inline-chip"><spring:message code="admin.layout.menu.members"/></a>
            </div>
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
            <div class="adm-inline-actions" style="margin-top:12px;">
                <a href="${pageContext.request.contextPath}/admin/logins?eventType=LOGIN&amp;success=FAIL" class="adm-inline-chip"><spring:message code="admin.dashboard.viewFailedLogins"/></a>
            </div>
            <div class="stat-icon">🚨</div>
        </div>
        <div class="stat-card purple">
            <div class="stat-label"><spring:message code="admin.dashboard.socialLinked"/></div>
            <div class="stat-value"><fmt:formatNumber value="${stats.kakaoLinked + stats.naverLinked + stats.googleLinked}" pattern="#,###"/></div>
            <div class="stat-sub"><spring:message code="admin.dashboard.socialLinkedSub"/></div>
            <div class="adm-inline-actions" style="margin-top:12px;">
                <a href="${pageContext.request.contextPath}/admin/members" class="adm-inline-chip"><spring:message code="admin.layout.menu.members"/></a>
            </div>
            <div class="stat-icon">🔗</div>
        </div>
        <div class="stat-card blue">
            <div class="stat-label"><spring:message code="admin.dashboard.pendingInquiries"/></div>
            <div class="stat-value"><fmt:formatNumber value="${stats.pendingInquiries}" pattern="#,###"/></div>
            <div class="stat-sub"><spring:message code="admin.dashboard.totalInquiries" arguments="${stats.totalInquiries}"/></div>
            <div class="adm-inline-actions" style="margin-top:12px;">
                <a href="${pageContext.request.contextPath}/admin/inquiries?status=PENDING" class="adm-inline-chip"><spring:message code="admin.dashboard.viewPendingInquiries"/></a>
            </div>
            <div class="stat-icon">📩</div>
        </div>
    </div>

    <div class="adm-chart-grid">
        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${adminDashboardChartNewMembers}</div>
            </div>
            <div class="adm-card-body">
                <div class="adm-chart-box"><canvas id="chartNewMembers"></canvas></div>
            </div>
        </div>
        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${adminDashboardChartLogins}</div>
            </div>
            <div class="adm-card-body">
                <div class="adm-chart-box"><canvas id="chartLogin"></canvas></div>
            </div>
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
                    <div class="adm-inline-actions" style="margin-top:12px;">
                        <a href="${pageContext.request.contextPath}/admin/community" class="adm-inline-chip"><spring:message code="admin.layout.menu.community"/></a>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-label"><spring:message code="admin.dashboard.activeReports"/></div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.activeReports}" pattern="#,###"/></div>
                    <div class="stat-sub"><spring:message code="admin.dashboard.activeReportsSub"/></div>
                    <div class="adm-inline-actions" style="margin-top:12px;">
                        <a href="${pageContext.request.contextPath}/admin/reports?status=IN_REVIEW" class="adm-inline-chip"><spring:message code="admin.layout.menu.reports"/></a>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-label"><spring:message code="admin.dashboard.completedInquiries"/></div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.completedInquiries}" pattern="#,###"/></div>
                    <div class="stat-sub"><spring:message code="admin.dashboard.completedInquiriesSub"/></div>
                    <div class="adm-inline-actions" style="margin-top:12px;">
                        <a href="${pageContext.request.contextPath}/admin/inquiries?status=COMPLETED" class="adm-inline-chip"><spring:message code="admin.layout.menu.inquiries"/></a>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-label"><spring:message code="admin.dashboard.todayLogouts"/></div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.todayLogouts}" pattern="#,###"/></div>
                    <div class="stat-sub"><spring:message code="admin.dashboard.logoutProviderSummary" arguments="${stats.todayLocalLogouts},${stats.todayKakaoLogouts},${stats.todayNaverLogouts},${stats.todayGoogleLogouts}"/></div>
                    <div class="adm-inline-actions" style="margin-top:12px;">
                        <a href="${pageContext.request.contextPath}/admin/logins?eventType=LOGOUT" class="adm-inline-chip"><spring:message code="admin.dashboard.viewLogoutHistory"/></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.dashboard.socialOverview"/></div>
        </div>
        <div class="adm-card-body">
            <div class="adm-social-summary-grid">
                <div class="social-card adm-social-summary-card">
                    <div class="adm-social-summary-head">
                        <span class="adm-social-icon adm-social-summary-icon kakao-mark">k</span>
                        <span class="adm-social-summary-label"><spring:message code="admin.logs.provider.kakao"/></span>
                    </div>
                    <div class="social-card-value adm-social-summary-value"><fmt:formatNumber value="${stats.kakaoLinked}" pattern="#,###"/></div>
                    <div class="adm-inline-actions" style="margin-top:12px;">
                        <a href="${pageContext.request.contextPath}/admin/members?provider=KAKAO" class="adm-inline-chip"><spring:message code="admin.layout.menu.members"/></a>
                    </div>
                </div>
                <div class="social-card adm-social-summary-card">
                    <div class="adm-social-summary-head">
                        <span class="adm-social-icon adm-social-summary-icon naver-mark">N</span>
                        <span class="adm-social-summary-label"><spring:message code="admin.logs.provider.naver"/></span>
                    </div>
                    <div class="social-card-value adm-social-summary-value"><fmt:formatNumber value="${stats.naverLinked}" pattern="#,###"/></div>
                    <div class="adm-inline-actions" style="margin-top:12px;">
                        <a href="${pageContext.request.contextPath}/admin/members?provider=NAVER" class="adm-inline-chip"><spring:message code="admin.layout.menu.members"/></a>
                    </div>
                </div>
                <div class="social-card adm-social-summary-card">
                    <div class="adm-social-summary-head">
                        <span class="adm-social-icon adm-social-summary-icon google-mark">
                            <svg viewBox="0 0 48 48" aria-hidden="true" focusable="false">
                                <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
                                <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
                                <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/>
                                <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.36-8.16 2.36-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
                            </svg>
                        </span>
                        <span class="adm-social-summary-label"><spring:message code="admin.logs.provider.google"/></span>
                    </div>
                    <div class="social-card-value adm-social-summary-value"><fmt:formatNumber value="${stats.googleLinked}" pattern="#,###"/></div>
                    <div class="adm-inline-actions" style="margin-top:12px;">
                        <a href="${pageContext.request.contextPath}/admin/members?provider=GOOGLE" class="adm-inline-chip"><spring:message code="admin.layout.menu.members"/></a>
                    </div>
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

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
(function(){
    var DASH_CHART = {
        labels:       [<c:forEach var="l" items="${chart.labels}"       varStatus="s">"${l}"${s.last?'':','}</c:forEach>],
        newMembers:   [<c:forEach var="n" items="${chart.newMembers}"   varStatus="s">${n}${s.last?'':','}</c:forEach>],
        loginSuccess: [<c:forEach var="n" items="${chart.loginSuccess}" varStatus="s">${n}${s.last?'':','}</c:forEach>],
        loginFail:    [<c:forEach var="n" items="${chart.loginFail}"    varStatus="s">${n}${s.last?'':','}</c:forEach>]
    };

    function isLight() { return document.body.classList.contains('sa-light'); }
    function colors() {
        var light = isLight();
        return {
            grid:  light ? 'rgba(148,163,184,.25)' : 'rgba(100,116,139,.2)',
            tick:  light ? '#475569' : '#94a3b8',
            bar1:  'rgba(59,130,246,.85)',
            bar1b: '#3b82f6',
            bar2:  'rgba(34,197,94,.85)',
            bar2b: '#22c55e',
            bar3:  'rgba(239,68,68,.85)',
            bar3b: '#ef4444'
        };
    }

    var chartNew = null, chartLog = null;

    function build() {
        var c = colors();
        var common = {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { labels: { color: c.tick } },
                tooltip: { intersect: false, mode: 'index' }
            },
            scales: {
                x: { ticks: { color: c.tick }, grid: { color: c.grid } },
                y: { beginAtZero: true, ticks: { color: c.tick, precision: 0 }, grid: { color: c.grid } }
            }
        };

        if (chartNew) chartNew.destroy();
        if (chartLog) chartLog.destroy();

        chartNew = new Chart(document.getElementById('chartNewMembers'), {
            type: 'bar',
            data: {
                labels: DASH_CHART.labels,
                datasets: [{
                    label: '${adminDashboardChartDatasetNewMembers}',
                    data: DASH_CHART.newMembers,
                    backgroundColor: c.bar1,
                    borderColor: c.bar1b,
                    borderWidth: 1,
                    borderRadius: 6
                }]
            },
            options: Object.assign({}, common, {
                plugins: Object.assign({}, common.plugins, { legend: { display: false } })
            })
        });

        chartLog = new Chart(document.getElementById('chartLogin'), {
            type: 'bar',
            data: {
                labels: DASH_CHART.labels,
                datasets: [
                    { label: '${adminDashboardChartDatasetSuccess}', data: DASH_CHART.loginSuccess, backgroundColor: c.bar2, borderColor: c.bar2b, borderWidth: 1, borderRadius: 4 },
                    { label: '${adminDashboardChartDatasetFail}', data: DASH_CHART.loginFail,    backgroundColor: c.bar3, borderColor: c.bar3b, borderWidth: 1, borderRadius: 4 }
                ]
            },
            options: Object.assign({}, common, {
                scales: {
                    x: Object.assign({ stacked: true }, common.scales.x),
                    y: Object.assign({ stacked: true }, common.scales.y)
                }
            })
        });
    }

    build();

    var themeBtn = document.getElementById('saThemeBtn');
    if (themeBtn) themeBtn.addEventListener('click', function(){ setTimeout(build, 0); });
})();
</script>

<%@ include file="layout-close.jsp" %>
