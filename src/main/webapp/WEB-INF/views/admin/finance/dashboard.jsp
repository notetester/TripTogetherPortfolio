<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="finance"/>
<c:set var="pageTitle"><spring:message code="admin.finance.dashboard.title"/></c:set>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- 자산 집계 카드 --%>
    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-bottom:20px;">
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:13px;color:#94a3b8;margin-bottom:6px;">
                💰 <spring:message code="admin.finance.stats.totalCash"/>
            </div>
            <div class="adm-fin-num" style="font-size:22px;font-weight:700;">
                <fmt:formatNumber value="${stats.totalCashBalance}" pattern="#,###"/> <spring:message code="admin.finance.unit.krw"/>
            </div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:13px;color:#94a3b8;margin-bottom:6px;">
                ✈️ <spring:message code="admin.finance.stats.totalMileage"/>
            </div>
            <div class="adm-fin-num" style="font-size:22px;font-weight:700;">
                <fmt:formatNumber value="${stats.totalMileageBalance}" pattern="#,###"/> <spring:message code="admin.finance.unit.mileage"/>
            </div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:13px;color:#94a3b8;margin-bottom:6px;">
                ⭐ <spring:message code="admin.finance.stats.totalPoint"/>
            </div>
            <div class="adm-fin-num" style="font-size:22px;font-weight:700;">
                <fmt:formatNumber value="${stats.totalPointBalance}" pattern="#,###"/> <spring:message code="admin.finance.unit.point"/>
            </div>
        </div>
    </div>

    <%-- 회원 수 / 충전 통계 --%>
    <div style="display:grid;grid-template-columns:repeat(5,1fr);gap:12px;margin-bottom:20px;">
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;"><spring:message code="admin.finance.stats.totalUsers"/></div>
            <div style="font-size:18px;font-weight:700;"><fmt:formatNumber value="${stats.totalUsers}" pattern="#,###"/></div>
        </div>
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;"><spring:message code="admin.finance.stats.activeUsers"/></div>
            <div style="font-size:18px;font-weight:700;color:#15803d;"><fmt:formatNumber value="${stats.activeUsers}" pattern="#,###"/></div>
        </div>
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;"><spring:message code="admin.finance.stats.blockedUsers"/></div>
            <div style="font-size:18px;font-weight:700;color:#b91c1c;"><fmt:formatNumber value="${stats.blockedUsers}" pattern="#,###"/></div>
        </div>
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;"><spring:message code="admin.finance.stats.todayCharge"/></div>
            <div style="font-size:18px;font-weight:700;"><fmt:formatNumber value="${stats.todayChargeTotal}" pattern="#,###"/></div>
        </div>
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;"><spring:message code="admin.finance.stats.lastMonthCharge"/></div>
            <div style="font-size:18px;font-weight:700;"><fmt:formatNumber value="${stats.lastMonthChargeTotal}" pattern="#,###"/></div>
        </div>
    </div>

    <div class="adm-card" style="padding:20px;">
        <div class="adm-fin-guide" style="font-size:14px;margin-bottom:12px;">
            <spring:message code="admin.finance.dashboard.guide"/>
        </div>
        <a href="${pageContext.request.contextPath}/admin/finance/users" class="adm-btn adm-btn-primary">
            <spring:message code="admin.finance.dashboard.goUsers"/>
        </a>
    </div>

</div>

<%@ include file="../layout-close.jsp" %>
