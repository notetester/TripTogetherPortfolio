<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="stats"/>
<c:set var="pageTitle"  value="통계 대시보드"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">

    <%-- 요약 카드 --%>
    <div class="sa-stats-summary">
        <div class="sa-stats-kpi">
            <div class="sa-stats-kpi-value">${totalAdmins}</div>
            <div class="sa-stats-kpi-label">총 관리자</div>
        </div>
        <div class="sa-stats-kpi">
            <div class="sa-stats-kpi-value">${fn:length(byDepartment)}</div>
            <div class="sa-stats-kpi-label">부서 수</div>
        </div>
        <div class="sa-stats-kpi">
            <div class="sa-stats-kpi-value">${fn:length(byPermissionCode)}</div>
            <div class="sa-stats-kpi-label">권한 종류</div>
        </div>
        <div class="sa-stats-kpi">
            <div class="sa-stats-kpi-value">${fn:length(byPosition)}</div>
            <div class="sa-stats-kpi-label">직책 종류</div>
        </div>
    </div>

    <%-- 차트 그리드 --%>
    <div class="sa-stats-grid">

        <div class="adm-card sa-stats-card">
            <div class="adm-card-head">
                <div class="adm-card-title">직책 분포</div>
            </div>
            <div class="adm-card-body sa-chart-body">
                <canvas id="chartPosition"></canvas>
            </div>
        </div>

        <div class="adm-card sa-stats-card">
            <div class="adm-card-head">
                <div class="adm-card-title">실효 권한 분포</div>
            </div>
            <div class="adm-card-body sa-chart-body">
                <canvas id="chartPermCode"></canvas>
            </div>
        </div>

        <div class="adm-card sa-stats-card">
            <div class="adm-card-head">
                <div class="adm-card-title">티어 분포</div>
            </div>
            <div class="adm-card-body sa-chart-body">
                <canvas id="chartTier"></canvas>
            </div>
        </div>

        <div class="adm-card sa-stats-card">
            <div class="adm-card-head">
                <div class="adm-card-title">부서 분포</div>
            </div>
            <div class="adm-card-body sa-chart-body">
                <canvas id="chartDept"></canvas>
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
