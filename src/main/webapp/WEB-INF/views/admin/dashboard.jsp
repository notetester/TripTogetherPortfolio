<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_dashboard_sales_sub" code="admin.dashboard.sales.sub"/>
<spring:message var="msg_admin_dashboard_sales_loading" code="admin.dashboard.sales.loading"/>
<spring:message var="msg_admin_dashboard_sales_noData" code="admin.dashboard.sales.noData"/>
<spring:message var="msg_admin_dashboard_sales_chart_gross" code="admin.dashboard.sales.chart.gross"/>
<spring:message var="msg_admin_dashboard_sales_chart_cash" code="admin.dashboard.sales.chart.cash"/>
<spring:message var="msg_admin_dashboard_sales_chart_mileage" code="admin.dashboard.sales.chart.mileage"/>
<spring:message var="msg_admin_dashboard_sales_chart_cancel" code="admin.dashboard.sales.chart.cancel"/>
<spring:message var="msg_admin_dashboard_sales_chart_net" code="admin.dashboard.sales.chart.net"/>
<spring:message var="msg_admin_dashboard_sales_chart_flightCount" code="admin.dashboard.sales.chart.flightCount"/>
<spring:message var="msg_admin_dashboard_sales_chart_packageCount" code="admin.dashboard.sales.chart.packageCount"/>
<spring:message var="msg_admin_dashboard_sales_chart_cancelCount" code="admin.dashboard.sales.chart.cancelCount"/>
<spring:message var="msg_admin_dashboard_sales_table_grossSales" code="admin.dashboard.sales.table.grossSales"/>
<spring:message var="msg_admin_dashboard_sales_table_totalSummary" code="admin.dashboard.sales.table.totalSummary"/>
<spring:message var="msg_admin_dashboard_sales_table_cashSales" code="admin.dashboard.sales.table.cashSales"/>
<spring:message var="msg_admin_dashboard_sales_table_mileageUsed" code="admin.dashboard.sales.table.mileageUsed"/>
<spring:message var="msg_admin_dashboard_sales_table_netSales" code="admin.dashboard.sales.table.netSales"/>
<spring:message var="msg_admin_dashboard_pageTitle" code="admin.dashboard.pageTitle"/>
<spring:message var="msg_admin_dashboard_chart_newMembersDataset" code="admin.dashboard.chart.newMembersDataset"/>
<spring:message var="msg_admin_dashboard_chart_loginSuccessDataset" code="admin.dashboard.chart.loginSuccessDataset"/>
<spring:message var="msg_admin_dashboard_chart_loginFailDataset" code="admin.dashboard.chart.loginFailDataset"/>
<spring:message var="msg_admin_dashboard_totalMembers" code="admin.dashboard.totalMembers"/>
<spring:message var="msg_admin_dashboard_todayNewMembers" code="admin.dashboard.todayNewMembers"/>
<spring:message var="msg_admin_layout_menu_members" code="admin.layout.menu.members"/>
<spring:message var="msg_admin_dashboard_activeMembers" code="admin.dashboard.activeMembers"/>
<spring:message var="msg_admin_dashboard_activeMembersSub" code="admin.dashboard.activeMembersSub"/>
<spring:message var="msg_admin_dashboard_dormantMembers" code="admin.dashboard.dormantMembers"/>
<spring:message var="msg_admin_dashboard_dormantMembersSub" code="admin.dashboard.dormantMembersSub"/>
<spring:message var="msg_admin_dashboard_todayFailedLogins" code="admin.dashboard.todayFailedLogins"/>
<spring:message var="msg_admin_dashboard_loginLogoutSummary" code="admin.dashboard.loginLogoutSummary"/>
<spring:message var="msg_admin_dashboard_viewFailedLogins" code="admin.dashboard.viewFailedLogins"/>
<spring:message var="msg_admin_dashboard_socialLinked" code="admin.dashboard.socialLinked"/>
<spring:message var="msg_admin_dashboard_socialLinkedSub" code="admin.dashboard.socialLinkedSub"/>
<spring:message var="msg_admin_dashboard_pendingInquiries" code="admin.dashboard.pendingInquiries"/>
<spring:message var="msg_admin_dashboard_totalInquiries" code="admin.dashboard.totalInquiries"/>
<spring:message var="msg_admin_dashboard_viewPendingInquiries" code="admin.dashboard.viewPendingInquiries"/>
<spring:message var="msg_admin_dashboard_chart_newMembersTitle" code="admin.dashboard.chart.newMembersTitle"/>
<spring:message var="msg_admin_dashboard_chart_loginTitle" code="admin.dashboard.chart.loginTitle"/>
<spring:message var="msg_admin_dashboard_sales_title" code="admin.dashboard.sales.title"/>
<spring:message var="msg_admin_dashboard_sales_sub_args_30" code="admin.dashboard.sales.sub" arguments="30"/>
<spring:message var="msg_admin_dashboard_sales_detail" code="admin.dashboard.sales.detail"/>
<spring:message var="msg_admin_dashboard_serviceOverview" code="admin.dashboard.serviceOverview"/>
<spring:message var="msg_admin_dashboard_communityPosts" code="admin.dashboard.communityPosts"/>
<spring:message var="msg_admin_dashboard_activePosts" code="admin.dashboard.activePosts"/>
<spring:message var="msg_admin_layout_menu_community" code="admin.layout.menu.community"/>
<spring:message var="msg_admin_dashboard_activeReports" code="admin.dashboard.activeReports"/>
<spring:message var="msg_admin_dashboard_activeReportsSub" code="admin.dashboard.activeReportsSub"/>
<spring:message var="msg_admin_layout_menu_reports" code="admin.layout.menu.reports"/>
<spring:message var="msg_admin_dashboard_completedInquiries" code="admin.dashboard.completedInquiries"/>
<spring:message var="msg_admin_dashboard_completedInquiriesSub" code="admin.dashboard.completedInquiriesSub"/>
<spring:message var="msg_admin_layout_menu_inquiries" code="admin.layout.menu.inquiries"/>
<spring:message var="msg_admin_dashboard_todayLogouts" code="admin.dashboard.todayLogouts"/>
<spring:message var="msg_admin_dashboard_logoutProviderSummary" code="admin.dashboard.logoutProviderSummary"/>
<spring:message var="msg_admin_dashboard_viewLogoutHistory" code="admin.dashboard.viewLogoutHistory"/>
<spring:message var="msg_admin_dashboard_socialOverview" code="admin.dashboard.socialOverview"/>
<spring:message var="msg_admin_logs_provider_kakao" code="admin.logs.provider.kakao"/>
<spring:message var="msg_admin_logs_provider_naver" code="admin.logs.provider.naver"/>
<spring:message var="msg_admin_logs_provider_google" code="admin.logs.provider.google"/>
<spring:message var="msg_admin_dashboard_quickLinks" code="admin.dashboard.quickLinks"/>
<spring:message var="msg_admin_layout_menu_policies" code="admin.layout.menu.policies"/>
<spring:message var="msg_admin_dashboard_sales_pageTitle" code="admin.dashboard.sales.pageTitle"/>
<spring:message var="msg_admin_dashboard_sales_daysLabel" code="admin.dashboard.sales.daysLabel"/>
<spring:message var="msg_admin_common_searchButton" code="admin.common.searchButton"/>
<spring:message var="msg_admin_dashboard_sales_close" code="admin.dashboard.sales.close"/>
<c:set var="activeMenu" value="dashboard"/>


<c:set var="pageTitle" value="${msg_admin_dashboard_pageTitle}"/>


<%@ include file="layout.jsp" %>

<div class="adm-content adm-dashboard-page">
    <div class="stat-grid">
        <div class="stat-card blue">
            <div class="stat-label">${msg_admin_dashboard_totalMembers}</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.totalMembers}" pattern="#,###"/></div>
            <div class="stat-sub">${msg_admin_dashboard_todayNewMembers}</div>
            <div class="adm-inline-actions">
                <a href="${pageContext.request.contextPath}/admin/members" class="adm-inline-chip">${msg_admin_layout_menu_members}</a>
            </div>
            <div class="stat-icon">👥</div>
        </div>
        <div class="stat-card green">
            <div class="stat-label">${msg_admin_dashboard_activeMembers}</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.activeMembers}" pattern="#,###"/></div>
            <div class="stat-sub">${msg_admin_dashboard_activeMembersSub}</div>
            <div class="stat-icon">✅</div>
        </div>
        <div class="stat-card yellow">
            <div class="stat-label">${msg_admin_dashboard_dormantMembers}</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.dormantMembers}" pattern="#,###"/></div>
            <div class="stat-sub">${msg_admin_dashboard_dormantMembersSub}</div>
            <div class="stat-icon">😴</div>
        </div>
        <div class="stat-card red">
            <div class="stat-label">${msg_admin_dashboard_todayFailedLogins}</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.todayFailedLogins}" pattern="#,###"/></div>
            <div class="stat-sub">${msg_admin_dashboard_loginLogoutSummary}</div>
            <div class="adm-inline-actions">
                <a href="${pageContext.request.contextPath}/admin/logins?eventType=LOGIN&amp;success=FAIL" class="adm-inline-chip">${msg_admin_dashboard_viewFailedLogins}</a>
            </div>
            <div class="stat-icon">🚨</div>
        </div>
        <div class="stat-card purple">
            <div class="stat-label">${msg_admin_dashboard_socialLinked}</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.kakaoLinked + stats.naverLinked + stats.googleLinked}" pattern="#,###"/></div>
            <div class="stat-sub">${msg_admin_dashboard_socialLinkedSub}</div>
            <div class="adm-inline-actions">
                <a href="${pageContext.request.contextPath}/admin/members" class="adm-inline-chip">${msg_admin_layout_menu_members}</a>
            </div>
            <div class="stat-icon">🔗</div>
        </div>
        <div class="stat-card blue">
            <div class="stat-label">${msg_admin_dashboard_pendingInquiries}</div>
            <div class="stat-value"><fmt:formatNumber value="${stats.pendingInquiries}" pattern="#,###"/></div>
            <div class="stat-sub">${msg_admin_dashboard_totalInquiries}</div>
            <div class="adm-inline-actions">
                <a href="${pageContext.request.contextPath}/admin/inquiries?status=PENDING" class="adm-inline-chip">${msg_admin_dashboard_viewPendingInquiries}</a>
            </div>
            <div class="stat-icon">📩</div>
        </div>
    </div>

    <div class="adm-chart-grid">
        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${msg_admin_dashboard_chart_newMembersTitle}</div>
            </div>
            <div class="adm-card-body">
                <div class="adm-chart-box"><canvas id="chartNewMembers"></canvas></div>
            </div>
        </div>
        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${msg_admin_dashboard_chart_loginTitle}</div>
            </div>
            <div class="adm-card-body">
                <div class="adm-chart-box"><canvas id="chartLogin"></canvas></div>
            </div>
        </div>
    </div>

    <div class="adm-card adm-dashboard-card adm-dashboard-sales-card">
        <div class="adm-card-head adm-dashboard-card-head">
            <div>
                <div class="adm-card-title">${msg_admin_dashboard_sales_title}</div>
                <div class="adm-dashboard-card-subtitle">
                    ${msg_admin_dashboard_sales_sub_args_30}
                </div>
            </div>
            <div class="adm-inline-actions">
                <button type="button" class="adm-btn adm-btn-primary" onclick="openSalesDetailModal()">
                    ${msg_admin_dashboard_sales_detail}
                </button>
            </div>
        </div>
        <div class="adm-card-body">
            <div class="adm-dashboard-sales-stack">
                <div class="adm-chart-box adm-dashboard-sales-amount">
                    <canvas id="salesAmountChart"></canvas>
                </div>
                <div class="adm-chart-box adm-dashboard-sales-count">
                    <canvas id="salesCountChart"></canvas>
                </div>
            </div>
            <div class="adm-summary-grid adm-dashboard-sales-summary" id="salesSummaryGrid"></div>
        </div>
    </div>

    <div class="adm-card adm-dashboard-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_dashboard_serviceOverview}</div>
        </div>
        <div class="adm-card-body">
            <div class="stat-grid adm-dashboard-service-grid">
                <div class="stat-card">
                    <div class="stat-label">${msg_admin_dashboard_communityPosts}</div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.totalCommunityPosts}" pattern="#,###"/></div>
                    <div class="stat-sub">${msg_admin_dashboard_activePosts}</div>
                    <div class="adm-inline-actions">
                        <a href="${pageContext.request.contextPath}/admin/community" class="adm-inline-chip">${msg_admin_layout_menu_community}</a>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">${msg_admin_dashboard_activeReports}</div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.activeReports}" pattern="#,###"/></div>
                    <div class="stat-sub">${msg_admin_dashboard_activeReportsSub}</div>
                    <div class="adm-inline-actions">
                        <a href="${pageContext.request.contextPath}/admin/reports?status=IN_REVIEW" class="adm-inline-chip">${msg_admin_layout_menu_reports}</a>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">${msg_admin_dashboard_completedInquiries}</div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.completedInquiries}" pattern="#,###"/></div>
                    <div class="stat-sub">${msg_admin_dashboard_completedInquiriesSub}</div>
                    <div class="adm-inline-actions">
                        <a href="${pageContext.request.contextPath}/admin/inquiries?status=COMPLETED" class="adm-inline-chip">${msg_admin_layout_menu_inquiries}</a>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">${msg_admin_dashboard_todayLogouts}</div>
                    <div class="stat-value"><fmt:formatNumber value="${stats.todayLogouts}" pattern="#,###"/></div>
                    <div class="stat-sub">${msg_admin_dashboard_logoutProviderSummary}</div>
                    <div class="adm-inline-actions">
                        <a href="${pageContext.request.contextPath}/admin/logins?eventType=LOGOUT" class="adm-inline-chip">${msg_admin_dashboard_viewLogoutHistory}</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card adm-dashboard-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_dashboard_socialOverview}</div>
        </div>
        <div class="adm-card-body">
            <div class="adm-social-summary-grid">
                <div class="social-card adm-social-summary-card">
                    <div class="adm-social-summary-head">
                        <span class="adm-social-icon adm-social-summary-icon kakao-mark">k</span>
                        <span class="adm-social-summary-label">${msg_admin_logs_provider_kakao}</span>
                    </div>
                    <div class="social-card-value adm-social-summary-value"><fmt:formatNumber value="${stats.kakaoLinked}" pattern="#,###"/></div>
                    <div class="adm-inline-actions">
                        <a href="${pageContext.request.contextPath}/admin/members?provider=KAKAO" class="adm-inline-chip">${msg_admin_layout_menu_members}</a>
                    </div>
                </div>
                <div class="social-card adm-social-summary-card">
                    <div class="adm-social-summary-head">
                        <span class="adm-social-icon adm-social-summary-icon naver-mark">N</span>
                        <span class="adm-social-summary-label">${msg_admin_logs_provider_naver}</span>
                    </div>
                    <div class="social-card-value adm-social-summary-value"><fmt:formatNumber value="${stats.naverLinked}" pattern="#,###"/></div>
                    <div class="adm-inline-actions">
                        <a href="${pageContext.request.contextPath}/admin/members?provider=NAVER" class="adm-inline-chip">${msg_admin_layout_menu_members}</a>
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
                        <span class="adm-social-summary-label">${msg_admin_logs_provider_google}</span>
                    </div>
                    <div class="social-card-value adm-social-summary-value"><fmt:formatNumber value="${stats.googleLinked}" pattern="#,###"/></div>
                    <div class="adm-inline-actions">
                        <a href="${pageContext.request.contextPath}/admin/members?provider=GOOGLE" class="adm-inline-chip">${msg_admin_layout_menu_members}</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_dashboard_quickLinks}</div>
        </div>
        <div class="adm-card-body adm-dashboard-quicklinks">
            <a href="${pageContext.request.contextPath}/admin/members" class="adm-btn adm-btn-primary">👥 ${msg_admin_layout_menu_members}</a>
            <a href="${pageContext.request.contextPath}/admin/policies" class="adm-btn adm-btn-ghost">⚙️ ${msg_admin_layout_menu_policies}</a>
            <a href="${pageContext.request.contextPath}/admin/logins?eventType=LOGIN&amp;success=FAIL" class="adm-btn adm-btn-ghost">🔐 ${msg_admin_dashboard_viewFailedLogins}</a>
            <a href="${pageContext.request.contextPath}/admin/logins?eventType=LOGOUT" class="adm-btn adm-btn-ghost">↩️ ${msg_admin_dashboard_viewLogoutHistory}</a>
            <a href="${pageContext.request.contextPath}/admin/inquiries?status=PENDING" class="adm-btn adm-btn-ghost">📩 ${msg_admin_dashboard_viewPendingInquiries}</a>
        </div>
    </div>
</div>

<div class="adm-modal-overlay" id="salesDetailModal">
    <div class="adm-modal adm-sales-modal">
        <div class="adm-modal-head">
            <div class="adm-modal-title">${msg_admin_dashboard_sales_pageTitle}</div>
            <button class="adm-modal-close" type="button" onclick="closeSalesDetailModal()">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="adm-sales-modal-filter">
                <div class="adm-sales-modal-field">
                    <label for="salesDaysInput" class="adm-sales-modal-label">
                        ${msg_admin_dashboard_sales_daysLabel}
                    </label>
                    <input type="number" id="salesDaysInput" class="adm-input" min="1" max="365" value="30">
                </div>
                <button type="button" class="adm-btn adm-btn-primary" onclick="loadSalesStats()">
                    ${msg_admin_common_searchButton}
                </button>
            </div>
            <div id="salesDetailStatus" class="adm-sales-modal-status">
                ${msg_admin_dashboard_sales_sub_args_30}
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeSalesDetailModal()">
                ${msg_admin_dashboard_sales_close}
            </button>
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

    var SALES_STATS = [
        <c:forEach var="sale" items="${salesStats}" varStatus="s">
        {
            salesDate: "${sale.salesDate}",
            grossSales: ${sale.grossSales},
            cashSales: ${sale.cashSales},
            mileageUsed: ${sale.mileageUsed},
            cancelAmount: ${sale.cancelAmount},
            netSales: ${sale.netSales},
            flightBookingCount: ${sale.flightBookingCount},
            packageBookingCount: ${sale.packageBookingCount},
            cancelCount: ${sale.cancelCount}
        }${s.last ? '' : ','}
        </c:forEach>
    ];
    var SALES_DAYS = 30;
    var SALES_SUB_TEMPLATE = '${msg_admin_dashboard_sales_sub}';
    var SALES_LOADING_TEXT = '${msg_admin_dashboard_sales_loading}';
    var SALES_NO_DATA_TEXT = '${msg_admin_dashboard_sales_noData}';
    var SALES_CHART_LABELS = {
        gross: '${msg_admin_dashboard_sales_chart_gross}',
        cash: '${msg_admin_dashboard_sales_chart_cash}',
        mileage: '${msg_admin_dashboard_sales_chart_mileage}',
        cancel: '${msg_admin_dashboard_sales_chart_cancel}',
        net: '${msg_admin_dashboard_sales_chart_net}',
        flightCount: '${msg_admin_dashboard_sales_chart_flightCount}',
        packageCount: '${msg_admin_dashboard_sales_chart_packageCount}',
        cancelCount: '${msg_admin_dashboard_sales_chart_cancelCount}'
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

    function locale() {
        return document.documentElement.lang || 'ko-KR';
    }

    function formatNumber(value) {
        return new Intl.NumberFormat(locale()).format(Number(value || 0));
    }

    function formatDateText(value) {
        if (!value) return '-';
        return String(value);
    }

    function shortDateText(value) {
        if (!value) return '-';
        var text = String(value);
        if (text.length >= 10 && text.indexOf('-') >= 0) {
            return text.substring(5, 10).replace('-', '/');
        }
        return text;
    }

    function sumField(rows, field) {
        return rows.reduce(function(total, row) {
            return total + Number(row[field] || 0);
        }, 0);
    }

    function renderSalesSummary(rows) {
        var summary = document.getElementById('salesSummaryGrid');
        if (!summary) return;

        if (!rows || !rows.length) {
            summary.innerHTML = '';
            return;
        }

        summary.innerHTML =
            '<div class="adm-card adm-summary-card">' +
                '<div class="adm-summary-label">${msg_admin_dashboard_sales_table_grossSales}</div>' +
                '<div class="adm-summary-value is-primary">' + formatNumber(sumField(rows, 'grossSales')) + '</div>' +
                '<div class="adm-summary-sub">${msg_admin_dashboard_sales_table_totalSummary}</div>' +
            '</div>' +
            '<div class="adm-card adm-summary-card">' +
                '<div class="adm-summary-label">${msg_admin_dashboard_sales_table_cashSales}</div>' +
                '<div class="adm-summary-value is-success">' + formatNumber(sumField(rows, 'cashSales')) + '</div>' +
                '<div class="adm-summary-sub">${msg_admin_dashboard_sales_table_totalSummary}</div>' +
            '</div>' +
            '<div class="adm-card adm-summary-card">' +
                '<div class="adm-summary-label">${msg_admin_dashboard_sales_table_mileageUsed}</div>' +
                '<div class="adm-summary-value is-warning">' + formatNumber(sumField(rows, 'mileageUsed')) + '</div>' +
                '<div class="adm-summary-sub">${msg_admin_dashboard_sales_table_totalSummary}</div>' +
            '</div>' +
            '<div class="adm-card adm-summary-card">' +
                '<div class="adm-summary-label">${msg_admin_dashboard_sales_table_netSales}</div>' +
                '<div class="adm-summary-value is-danger">' + formatNumber(sumField(rows, 'netSales')) + '</div>' +
                '<div class="adm-summary-sub">${msg_admin_dashboard_sales_table_totalSummary}</div>' +
            '</div>';
    }

    var salesAmountChart = null;
    var salesCountChart = null;

    function chartLabels(rows) {
        return rows.map(function(row) {
            return shortDateText(row.salesDate);
        });
    }

    function chartTooltipLabel(context) {
        return context.dataset.label + ': ' + formatNumber(context.parsed.y);
    }

    function renderSalesAmountChart(rows) {
        var canvas = document.getElementById('salesAmountChart');
        if (!canvas) return;

        if (salesAmountChart) {
            salesAmountChart.destroy();
            salesAmountChart = null;
        }

        if (!rows || !rows.length) {
            renderSalesSummary([]);
            return;
        }

        var c = colors();
        salesAmountChart = new Chart(canvas, {
            type: 'line',
            data: {
                labels: chartLabels(rows),
                datasets: [
                    {
                        label: SALES_CHART_LABELS.gross,
                        data: rows.map(function(row) { return row.grossSales; }),
                        borderColor: '#3b82f6',
                        backgroundColor: 'rgba(59,130,246,.14)',
                        pointRadius: 2,
                        tension: 0.25,
                        borderWidth: 2
                    },
                    {
                        label: SALES_CHART_LABELS.cash,
                        data: rows.map(function(row) { return row.cashSales; }),
                        borderColor: '#22c55e',
                        backgroundColor: 'rgba(34,197,94,.14)',
                        pointRadius: 2,
                        tension: 0.25,
                        borderWidth: 2
                    },
                    {
                        label: SALES_CHART_LABELS.mileage,
                        data: rows.map(function(row) { return row.mileageUsed; }),
                        borderColor: '#f59e0b',
                        backgroundColor: 'rgba(245,158,11,.14)',
                        pointRadius: 2,
                        tension: 0.25,
                        borderWidth: 2
                    },
                    {
                        label: SALES_CHART_LABELS.cancel,
                        data: rows.map(function(row) { return row.cancelAmount; }),
                        borderColor: '#8b5cf6',
                        backgroundColor: 'rgba(139,92,246,.14)',
                        pointRadius: 2,
                        tension: 0.25,
                        borderWidth: 2
                    },
                    {
                        label: SALES_CHART_LABELS.net,
                        data: rows.map(function(row) { return row.netSales; }),
                        borderColor: '#ef4444',
                        backgroundColor: 'rgba(239,68,68,.12)',
                        pointRadius: 3,
                        tension: 0.25,
                        borderWidth: 2
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                interaction: {
                    mode: 'index',
                    intersect: false
                },
                plugins: {
                    legend: { labels: { color: c.tick } },
                    tooltip: {
                        callbacks: {
                            label: chartTooltipLabel
                        }
                    }
                },
                scales: {
                    x: {
                        ticks: {
                            color: c.tick,
                            autoSkip: false,
                            maxRotation: 0,
                            callback: function(value, index) {
                                return index % 3 === 0 ? this.getLabelForValue(value) : '';
                            }
                        },
                        grid: { color: c.grid }
                    },
                    y: {
                        beginAtZero: true,
                        ticks: {
                            color: c.tick,
                            callback: function(value) {
                                return formatNumber(value);
                            }
                        },
                        grid: { color: c.grid }
                    }
                }
            }
        });

        renderSalesSummary(rows);
    }

    function renderSalesCountChart(rows) {
        var canvas = document.getElementById('salesCountChart');
        if (!canvas) return;

        if (salesCountChart) {
            salesCountChart.destroy();
            salesCountChart = null;
        }

        if (!rows || !rows.length) {
            return;
        }

        var c = colors();
        salesCountChart = new Chart(canvas, {
            type: 'bar',
            data: {
                labels: chartLabels(rows),
                datasets: [
                    {
                        label: SALES_CHART_LABELS.flightCount,
                        data: rows.map(function(row) { return row.flightBookingCount; }),
                        backgroundColor: 'rgba(59,130,246,.18)',
                        borderColor: '#3b82f6',
                        borderWidth: 1,
                        borderRadius: 4
                    },
                    {
                        label: SALES_CHART_LABELS.packageCount,
                        data: rows.map(function(row) { return row.packageBookingCount; }),
                        backgroundColor: 'rgba(34,197,94,.18)',
                        borderColor: '#22c55e',
                        borderWidth: 1,
                        borderRadius: 4
                    },
                    {
                        label: SALES_CHART_LABELS.cancelCount,
                        data: rows.map(function(row) { return row.cancelCount; }),
                        backgroundColor: 'rgba(239,68,68,.18)',
                        borderColor: '#ef4444',
                        borderWidth: 1,
                        borderRadius: 4
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                interaction: {
                    mode: 'index',
                    intersect: false
                },
                plugins: {
                    legend: { labels: { color: c.tick } },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.dataset.label + ': ' + formatNumber(context.parsed.y);
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        stacked: true,
                        ticks: {
                            color: c.tick,
                            autoSkip: false,
                            maxRotation: 0,
                            callback: function(value, index) {
                                return index % 3 === 0 ? this.getLabelForValue(value) : '';
                            }
                        },
                        grid: { color: c.grid }
                    },
                    y: {
                        stacked: true,
                        beginAtZero: true,
                        ticks: {
                            color: c.tick,
                            precision: 0,
                            callback: function(value) {
                                return formatNumber(value);
                            }
                        },
                        grid: { color: c.grid }
                    }
                }
            }
        });
    }

    function setSalesStatus(message) {
        var status = document.getElementById('salesDetailStatus');
        if (status) status.textContent = message;
    }

    function openSalesDetailModal() {
        var modal = document.getElementById('salesDetailModal');
        var input = document.getElementById('salesDaysInput');
        if (input) input.value = SALES_DAYS;
        if (modal) modal.classList.add('open');
        setSalesStatus(SALES_SUB_TEMPLATE.replace('__DAYS__', SALES_DAYS));
    }

    function closeSalesDetailModal() {
        var modal = document.getElementById('salesDetailModal');
        if (modal) modal.classList.remove('open');
    }

    function loadSalesStats() {
        var input = document.getElementById('salesDaysInput');
        var days = input ? parseInt(input.value, 10) : SALES_DAYS;
        if (!days || days < 1) days = SALES_DAYS;
        if (days > 365) days = 365;
        SALES_DAYS = days;
        if (input) input.value = days;

        setSalesStatus(SALES_LOADING_TEXT);

        fetch('${pageContext.request.contextPath}/admin/sales/stats?days=' + encodeURIComponent(days), {
            headers: {
                'Accept': 'application/json'
            }
        })
        .then(function(response) {
            if (!response.ok) {
                throw new Error('HTTP ' + response.status);
            }
            return response.json();
        })
        .then(function(rows) {
            SALES_STATS = Array.isArray(rows) ? rows : [];
            renderSalesAmountChart(SALES_STATS);
            renderSalesCountChart(SALES_STATS);
            setSalesStatus(SALES_SUB_TEMPLATE.replace('__DAYS__', days));
        })
        .catch(function(error) {
            console.error('Failed to load sales stats', error);
            setSalesStatus(SALES_NO_DATA_TEXT);
        });
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
                    label: '${msg_admin_dashboard_chart_newMembersDataset}',
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
                    { label: '${msg_admin_dashboard_chart_loginSuccessDataset}', data: DASH_CHART.loginSuccess, backgroundColor: c.bar2, borderColor: c.bar2b, borderWidth: 1, borderRadius: 4 },
                    { label: '${msg_admin_dashboard_chart_loginFailDataset}', data: DASH_CHART.loginFail,    backgroundColor: c.bar3, borderColor: c.bar3b, borderWidth: 1, borderRadius: 4 }
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
    renderSalesAmountChart(SALES_STATS);
    renderSalesCountChart(SALES_STATS);

    var themeBtn = document.getElementById('saThemeBtn');
    if (themeBtn) themeBtn.addEventListener('click', function(){ setTimeout(build, 0); });

    var salesModal = document.getElementById('salesDetailModal');
    if (salesModal) {
        salesModal.addEventListener('click', function(event) {
            if (event.target === salesModal) {
                closeSalesDetailModal();
            }
        });
    }

    window.openSalesDetailModal = openSalesDetailModal;
    window.closeSalesDetailModal = closeSalesDetailModal;
    window.loadSalesStats = loadSalesStats;
})();
</script>

<%@ include file="layout-close.jsp" %>
