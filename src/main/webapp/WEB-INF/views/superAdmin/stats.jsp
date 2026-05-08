<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_superAdmin_stats_pageTitle" code="superAdmin.stats.pageTitle"/>
<spring:message var="msg_superAdmin_stats_recentLogin_none" code="superAdmin.stats.recentLogin.none"/>
<spring:message var="msg_superAdmin_stats_kpi_totalAdmins" code="superAdmin.stats.kpi.totalAdmins"/>
<spring:message var="msg_superAdmin_stats_kpi_departments" code="superAdmin.stats.kpi.departments"/>
<spring:message var="msg_superAdmin_stats_kpi_permissions" code="superAdmin.stats.kpi.permissions"/>
<spring:message var="msg_superAdmin_stats_kpi_positions" code="superAdmin.stats.kpi.positions"/>
<spring:message var="msg_superAdmin_stats_card_positionDistribution" code="superAdmin.stats.card.positionDistribution"/>
<spring:message var="msg_superAdmin_stats_card_permissionDistribution" code="superAdmin.stats.card.permissionDistribution"/>
<spring:message var="msg_superAdmin_stats_card_tierDistribution" code="superAdmin.stats.card.tierDistribution"/>
<spring:message var="msg_superAdmin_stats_card_departmentDistribution" code="superAdmin.stats.card.departmentDistribution"/>
<spring:message var="msg_superAdmin_stats_card_dormantAdmins" code="superAdmin.stats.card.dormantAdmins"/>
<spring:message var="msg_superAdmin_stats_suffix_days90" code="superAdmin.stats.suffix.days90"/>
<spring:message var="msg_superAdmin_stats_empty" code="superAdmin.stats.empty"/>
<spring:message var="msg_superAdmin_stats_table_nickname" code="superAdmin.stats.table.nickname"/>
<spring:message var="msg_superAdmin_stats_table_department" code="superAdmin.stats.table.department"/>
<spring:message var="msg_superAdmin_stats_table_lastLogin" code="superAdmin.stats.table.lastLogin"/>
<spring:message var="msg_superAdmin_stats_card_noPermissionAdmins" code="superAdmin.stats.card.noPermissionAdmins"/>
<spring:message var="msg_superAdmin_stats_table_title" code="superAdmin.stats.table.title"/>
<spring:message var="msg_superAdmin_stats_card_withoutManagerAdmins" code="superAdmin.stats.card.withoutManagerAdmins"/>
<c:set var="pageTitle" value="${msg_superAdmin_stats_pageTitle}"/>
<c:set var="activeMenu" value="stats"/>
<spring:message var="msg_superAdmin_stats_dormantTotalDisplay" code="admin.common.totalCountFormat" arguments="${fn:length(dormantAdmins)}"/>
<spring:message var="msg_superAdmin_stats_noPermissionTotalDisplay" code="admin.common.totalCountFormat" arguments="${fn:length(adminsWithoutPermissions)}"/>
<spring:message var="msg_superAdmin_stats_withoutManagerTotalDisplay" code="admin.common.totalCountFormat" arguments="${fn:length(adminsWithoutManager)}"/>


<%@ include file="layout.jsp" %>

<div class="adm-content">

    <%-- 요약 카드 --%>
    <div class="sa-stats-summary">
        <div class="sa-stats-kpi">
            <div class="sa-stats-kpi-value">${totalAdmins}</div>
            <div class="sa-stats-kpi-label">${msg_superAdmin_stats_kpi_totalAdmins}</div>
        </div>
        <div class="sa-stats-kpi">
            <div class="sa-stats-kpi-value">${fn:length(byDepartment)}</div>
            <div class="sa-stats-kpi-label">${msg_superAdmin_stats_kpi_departments}</div>
        </div>
        <div class="sa-stats-kpi">
            <div class="sa-stats-kpi-value">${fn:length(byPermissionCode)}</div>
            <div class="sa-stats-kpi-label">${msg_superAdmin_stats_kpi_permissions}</div>
        </div>
        <div class="sa-stats-kpi">
            <div class="sa-stats-kpi-value">${fn:length(byPosition)}</div>
            <div class="sa-stats-kpi-label">${msg_superAdmin_stats_kpi_positions}</div>
        </div>
    </div>

    <%-- 차트 그리드 --%>
    <div class="sa-stats-grid">

        <div class="adm-card sa-stats-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${msg_superAdmin_stats_card_positionDistribution}</div>
            </div>
            <div class="adm-card-body sa-chart-body">
                <canvas id="chartPosition"></canvas>
            </div>
        </div>

        <div class="adm-card sa-stats-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${msg_superAdmin_stats_card_permissionDistribution}</div>
            </div>
            <div class="adm-card-body sa-chart-body">
                <canvas id="chartPermCode"></canvas>
            </div>
        </div>

        <div class="adm-card sa-stats-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${msg_superAdmin_stats_card_tierDistribution}</div>
            </div>
            <div class="adm-card-body sa-chart-body">
                <canvas id="chartTier"></canvas>
            </div>
        </div>

        <div class="adm-card sa-stats-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${msg_superAdmin_stats_card_departmentDistribution}</div>
            </div>
            <div class="adm-card-body sa-chart-body">
                <canvas id="chartDept"></canvas>
            </div>
        </div>

    </div>

    <%-- 예외 현황 --%>
    <div class="sa-stats-exception-grid">

        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title">
                    ${msg_superAdmin_stats_card_dormantAdmins}
                    <span class="adm-section-total-inline">${msg_superAdmin_stats_dormantTotalDisplay}</span>
                    <span class="sa-exception-count">(${msg_superAdmin_stats_suffix_days90})</span>
                </div>
            </div>
            <div class="adm-card-body sa-table-card-body sa-table-scroll">
                <c:choose>
                    <c:when test="${empty dormantAdmins}">
                        <div class="sa-exception-empty">${msg_superAdmin_stats_empty}</div>
                    </c:when>
                    <c:otherwise>
                        <table class="sa-exception-table" data-admin-list-ignore="true">
                            <thead><tr><th onclick="saStatsThClick(this)">${msg_superAdmin_stats_table_nickname}</th><th onclick="saStatsThClick(this)">${msg_superAdmin_stats_table_department}</th><th onclick="saStatsThClick(this)">${msg_superAdmin_stats_table_lastLogin}</th></tr></thead>
                            <tbody>
                            <c:forEach var="m" items="${dormantAdmins}">
                                <tr>
                                    <td><a href="${pageContext.request.contextPath}/superAdmin/members/${m.userIdx}/edit">${fn:escapeXml(m.nickname)}</a></td>
                                    <td>${fn:escapeXml(m.adminDepartment)}</td>
                                    <td>${m.lastLoginAt != null ? m.lastLoginAt : msg_superAdmin_stats_recentLogin_none}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title">
                    ${msg_superAdmin_stats_card_noPermissionAdmins}
                    <span class="adm-section-total-inline">${msg_superAdmin_stats_noPermissionTotalDisplay}</span>
                </div>
            </div>
            <div class="adm-card-body sa-table-card-body sa-table-scroll">
                <c:choose>
                    <c:when test="${empty adminsWithoutPermissions}">
                        <div class="sa-exception-empty">${msg_superAdmin_stats_empty}</div>
                    </c:when>
                    <c:otherwise>
                        <table class="sa-exception-table" data-admin-list-ignore="true">
                            <thead><tr><th onclick="saStatsThClick(this)">${msg_superAdmin_stats_table_nickname}</th><th onclick="saStatsThClick(this)">${msg_superAdmin_stats_table_department}</th><th onclick="saStatsThClick(this)">${msg_superAdmin_stats_table_title}</th></tr></thead>
                            <tbody>
                            <c:forEach var="m" items="${adminsWithoutPermissions}">
                                <tr>
                                    <td><a href="${pageContext.request.contextPath}/superAdmin/members/${m.userIdx}/edit">${fn:escapeXml(m.nickname)}</a></td>
                                    <td>${fn:escapeXml(m.adminDepartment)}</td>
                                    <td>${fn:escapeXml(m.adminTitle)}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title">
                    ${msg_superAdmin_stats_card_withoutManagerAdmins}
                    <span class="adm-section-total-inline">${msg_superAdmin_stats_withoutManagerTotalDisplay}</span>
                </div>
            </div>
            <div class="adm-card-body sa-table-card-body sa-table-scroll">
                <c:choose>
                    <c:when test="${empty adminsWithoutManager}">
                        <div class="sa-exception-empty">${msg_superAdmin_stats_empty}</div>
                    </c:when>
                    <c:otherwise>
                        <table class="sa-exception-table" data-admin-list-ignore="true">
                            <thead><tr><th onclick="saStatsThClick(this)">${msg_superAdmin_stats_table_nickname}</th><th onclick="saStatsThClick(this)">${msg_superAdmin_stats_table_department}</th><th onclick="saStatsThClick(this)">${msg_superAdmin_stats_table_title}</th></tr></thead>
                            <tbody>
                            <c:forEach var="m" items="${adminsWithoutManager}">
                                <tr>
                                    <td><a href="${pageContext.request.contextPath}/superAdmin/members/${m.userIdx}/edit">${fn:escapeXml(m.nickname)}</a></td>
                                    <td>${fn:escapeXml(m.adminDepartment)}</td>
                                    <td>${fn:escapeXml(m.adminTitle)}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>

</div>

<%-- Chart.js 데이터를 JSP에서 JS 배열로 전달 --%>
<script>
const dataPosition = {
    labels: [<c:forEach var="s" items="${byPosition}" varStatus="vs">'${fn:escapeXml(s.label)}'<c:if test="${!vs.last}">,</c:if></c:forEach>],
    counts: [<c:forEach var="s" items="${byPosition}" varStatus="vs">${s.count}<c:if test="${!vs.last}">,</c:if></c:forEach>]
};
const dataPermCode = {
    labels: [<c:forEach var="s" items="${byPermissionCode}" varStatus="vs">'${fn:escapeXml(s.label)}'<c:if test="${!vs.last}">,</c:if></c:forEach>],
    counts: [<c:forEach var="s" items="${byPermissionCode}" varStatus="vs">${s.count}<c:if test="${!vs.last}">,</c:if></c:forEach>]
};
const dataTier = {
    labels: [<c:forEach var="s" items="${byTier}" varStatus="vs">'${fn:escapeXml(s.label)}'<c:if test="${!vs.last}">,</c:if></c:forEach>],
    counts: [<c:forEach var="s" items="${byTier}" varStatus="vs">${s.count}<c:if test="${!vs.last}">,</c:if></c:forEach>]
};
const dataDept = {
    labels: [<c:forEach var="s" items="${byDepartment}" varStatus="vs">'${fn:escapeXml(s.label)}'<c:if test="${!vs.last}">,</c:if></c:forEach>],
    counts: [<c:forEach var="s" items="${byDepartment}" varStatus="vs">${s.count}<c:if test="${!vs.last}">,</c:if></c:forEach>]
};
</script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>
<script>
(function () {
    const PALETTE = [
        '#6366f1','#8b5cf6','#06b6d4','#10b981',
        '#f59e0b','#ef4444','#ec4899','#84cc16',
        '#f97316','#3b82f6','#a855f7','#14b8a6'
    ];

    function donutChart(id, data) {
        if (!data.labels.length) return;
        new Chart(document.getElementById(id), {
            type: 'doughnut',
            data: {
                labels: data.labels,
                datasets: [{ data: data.counts, backgroundColor: PALETTE, borderWidth: 2, borderColor: '#1e2330' }]
            },
            options: {
                plugins: {
                    legend: { position: 'right', labels: { color: '#94a3b8', font: { size: 12 } } }
                },
                cutout: '62%'
            }
        });
    }

    function barChart(id, data) {
        if (!data.labels.length) return;
        new Chart(document.getElementById(id), {
            type: 'bar',
            data: {
                labels: data.labels,
                datasets: [{
                    data: data.counts,
                    backgroundColor: PALETTE,
                    borderRadius: 4
                }]
            },
            options: {
                plugins: { legend: { display: false } },
                scales: {
                    x: { ticks: { color: '#94a3b8' }, grid: { color: '#2d3748' } },
                    y: { ticks: { color: '#94a3b8', stepSize: 1 }, grid: { color: '#2d3748' }, beginAtZero: true }
                }
            }
        });
    }

    donutChart('chartPosition', dataPosition);
    donutChart('chartPermCode', dataPermCode);
    barChart('chartTier', dataTier);
    barChart('chartDept', dataDept);
})();

/* ── 헤더 클릭: 첫 행의 같은 컬럼 셀 액션을 트리거 ── */
function saStatsThClick(th) {
    var table = th.closest('table');
    var firstRow = table && table.querySelector('tbody tr');
    if (!firstRow) return;
    var cell = firstRow.children[th.cellIndex];
    if (!cell) return;
    var target = cell.querySelector('a[href], button');
    if (target) { target.click(); return; }
    var anyLink = firstRow.querySelector('a[href]');
    if (anyLink) location.href = anyLink.getAttribute('href');
}
</script>

<%@ include file="layout-close.jsp" %>
