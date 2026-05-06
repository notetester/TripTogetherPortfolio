<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_76a6ec04a9" code="superAdmin.stats.kpi.totalAdmins"/>
<spring:message var="autoMsg_99906cc99e" code="superAdmin.stats.kpi.departments"/>
<spring:message var="autoMsg_2492fdca31" code="superAdmin.stats.kpi.permissions"/>
<spring:message var="autoMsg_c5504dad2a" code="superAdmin.stats.kpi.positions"/>
<spring:message var="autoMsg_ef1ae5db2a" code="superAdmin.stats.card.positionDistribution"/>
<spring:message var="autoMsg_1e92d9efc4" code="superAdmin.stats.card.permissionDistribution"/>
<spring:message var="autoMsg_0b2add40fe" code="superAdmin.stats.card.tierDistribution"/>
<spring:message var="autoMsg_411f8fc5bb" code="superAdmin.stats.card.departmentDistribution"/>
<spring:message var="autoMsg_4874dd5e2a" code="superAdmin.stats.card.dormantAdmins"/>
<spring:message var="autoMsg_db4c0e9886" code="superAdmin.stats.suffix.days90"/>
<spring:message var="autoMsg_908fd975b1" code="superAdmin.stats.empty"/>
<spring:message var="autoMsg_33de62ed44" code="superAdmin.stats.table.nickname"/>
<spring:message var="autoMsg_632bc53444" code="superAdmin.stats.table.department"/>
<spring:message var="autoMsg_b2953c8a6f" code="superAdmin.stats.table.lastLogin"/>
<spring:message var="autoMsg_93788ad07e" code="superAdmin.stats.card.noPermissionAdmins"/>
<spring:message var="autoMsg_49e55ccef5" code="superAdmin.stats.table.title"/>
<spring:message var="autoMsg_19514e69b9" code="superAdmin.stats.card.withoutManagerAdmins"/>
<c:set var="activeMenu" value="stats"/>
<spring:message code="superAdmin.stats.pageTitle" var="pageTitle"/>
<spring:message code="superAdmin.stats.recentLogin.none" var="recentLoginNone"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">

    <%-- 요약 카드 --%>
    <div class="sa-stats-summary">
        <div class="sa-stats-kpi">
            <div class="sa-stats-kpi-value">${totalAdmins}</div>
            <div class="sa-stats-kpi-label">${autoMsg_76a6ec04a9}</div>
        </div>
        <div class="sa-stats-kpi">
            <div class="sa-stats-kpi-value">${fn:length(byDepartment)}</div>
            <div class="sa-stats-kpi-label">${autoMsg_99906cc99e}</div>
        </div>
        <div class="sa-stats-kpi">
            <div class="sa-stats-kpi-value">${fn:length(byPermissionCode)}</div>
            <div class="sa-stats-kpi-label">${autoMsg_2492fdca31}</div>
        </div>
        <div class="sa-stats-kpi">
            <div class="sa-stats-kpi-value">${fn:length(byPosition)}</div>
            <div class="sa-stats-kpi-label">${autoMsg_c5504dad2a}</div>
        </div>
    </div>

    <%-- 차트 그리드 --%>
    <div class="sa-stats-grid">

        <div class="adm-card sa-stats-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${autoMsg_ef1ae5db2a}</div>
            </div>
            <div class="adm-card-body sa-chart-body">
                <canvas id="chartPosition"></canvas>
            </div>
        </div>

        <div class="adm-card sa-stats-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${autoMsg_1e92d9efc4}</div>
            </div>
            <div class="adm-card-body sa-chart-body">
                <canvas id="chartPermCode"></canvas>
            </div>
        </div>

        <div class="adm-card sa-stats-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${autoMsg_0b2add40fe}</div>
            </div>
            <div class="adm-card-body sa-chart-body">
                <canvas id="chartTier"></canvas>
            </div>
        </div>

        <div class="adm-card sa-stats-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${autoMsg_411f8fc5bb}</div>
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
                <div class="adm-card-title">${autoMsg_4874dd5e2a} <span class="sa-exception-count">(${autoMsg_db4c0e9886})</span></div>
            </div>
            <div class="adm-card-body" style="padding:0;overflow-x:auto;">
                <c:choose>
                    <c:when test="${empty dormantAdmins}">
                        <div class="sa-exception-empty">${autoMsg_908fd975b1}</div>
                    </c:when>
                    <c:otherwise>
                        <table class="sa-exception-table">
                            <thead><tr><th>${autoMsg_33de62ed44}</th><th>${autoMsg_632bc53444}</th><th>${autoMsg_b2953c8a6f}</th></tr></thead>
                            <tbody>
                            <c:forEach var="m" items="${dormantAdmins}">
                                <tr>
                                    <td><a href="${pageContext.request.contextPath}/superAdmin/members/${m.userIdx}/edit">${fn:escapeXml(m.nickname)}</a></td>
                                    <td>${fn:escapeXml(m.adminDepartment)}</td>
                                    <td>${m.lastLoginAt != null ? m.lastLoginAt : recentLoginNone}</td>
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
                <div class="adm-card-title">${autoMsg_93788ad07e}</div>
            </div>
            <div class="adm-card-body" style="padding:0;overflow-x:auto;">
                <c:choose>
                    <c:when test="${empty adminsWithoutPermissions}">
                        <div class="sa-exception-empty">${autoMsg_908fd975b1}</div>
                    </c:when>
                    <c:otherwise>
                        <table class="sa-exception-table">
                            <thead><tr><th>${autoMsg_33de62ed44}</th><th>${autoMsg_632bc53444}</th><th>${autoMsg_49e55ccef5}</th></tr></thead>
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
                <div class="adm-card-title">${autoMsg_19514e69b9}</div>
            </div>
            <div class="adm-card-body" style="padding:0;overflow-x:auto;">
                <c:choose>
                    <c:when test="${empty adminsWithoutManager}">
                        <div class="sa-exception-empty">${autoMsg_908fd975b1}</div>
                    </c:when>
                    <c:otherwise>
                        <table class="sa-exception-table">
                            <thead><tr><th>${autoMsg_33de62ed44}</th><th>${autoMsg_632bc53444}</th><th>${autoMsg_49e55ccef5}</th></tr></thead>
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
</script>

<%@ include file="layout-close.jsp" %>
