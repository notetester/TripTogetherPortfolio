<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_finance_userDetail_title" code="admin.finance.userDetail.title"/>
<spring:message var="msg_admin_finance_userDetail_backToList" code="admin.finance.userDetail.backToList"/>
<spring:message var="msg_admin_finance_users_status_active" code="admin.finance.users.status.active"/>
<spring:message var="msg_admin_finance_users_status_blocked" code="admin.finance.users.status.blocked"/>
<spring:message var="msg_admin_finance_userDetail_cash" code="admin.finance.userDetail.cash"/>
<spring:message var="msg_admin_finance_userDetail_mileage" code="admin.finance.userDetail.mileage"/>
<spring:message var="msg_admin_finance_userDetail_point" code="admin.finance.userDetail.point"/>
<spring:message var="msg_admin_finance_userDetail_walletHistory" code="admin.finance.userDetail.walletHistory"/>
<spring:message var="msg_admin_finance_userDetail_walletHistoryEmpty" code="admin.finance.userDetail.walletHistoryEmpty"/>
<spring:message var="msg_admin_finance_userDetail_col_changedAt" code="admin.finance.userDetail.col.changedAt"/>
<spring:message var="msg_admin_finance_userDetail_col_assetType" code="admin.finance.userDetail.col.assetType"/>
<spring:message var="msg_admin_finance_userDetail_col_changeType" code="admin.finance.userDetail.col.changeType"/>
<spring:message var="msg_admin_finance_userDetail_col_amount" code="admin.finance.userDetail.col.amount"/>
<spring:message var="msg_admin_finance_userDetail_col_balanceAfter" code="admin.finance.userDetail.col.balanceAfter"/>
<spring:message var="msg_admin_finance_userDetail_col_detail" code="admin.finance.userDetail.col.detail"/>
<spring:message var="msg_admin_finance_userDetail_paymentHistory" code="admin.finance.userDetail.paymentHistory"/>
<spring:message var="msg_admin_finance_userDetail_paymentHistoryEmpty" code="admin.finance.userDetail.paymentHistoryEmpty"/>
<spring:message var="msg_admin_finance_userDetail_col_method" code="admin.finance.userDetail.col.method"/>
<spring:message var="msg_admin_finance_userDetail_col_status" code="admin.finance.userDetail.col.status"/>
<c:set var="activeMenu" value="finance"/>
<c:set var="pageTitle">${msg_admin_finance_userDetail_title}</c:set>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- 공통 탭바 --%>
    <%@ include file="_tabs.jsp" %>

    <a href="${pageContext.request.contextPath}/admin/finance" class="adm-btn adm-btn-ghost"
       style="margin-bottom:16px;display:inline-block;">
        ← ${msg_admin_finance_userDetail_backToList}
    </a>

    <%-- 사용자 기본 정보 --%>
    <div class="adm-card" style="padding:20px;margin-bottom:16px;">
        <div style="display:flex;align-items:center;gap:16px;margin-bottom:12px;">
            <div style="font-size:18px;font-weight:700;"><c:out value="${user.nickname}"/></div>
            <span style="font-size:11px;padding:2px 8px;border-radius:999px;background:#f1f5f9;color:#475569;">
                ${user.memberGrade}
            </span>
            <c:choose>
                <c:when test="${user.accountStatus eq 'ACTIVE'}">
                    <span class="adm-badge adm-badge-green">${msg_admin_finance_users_status_active}</span>
                </c:when>
                <c:when test="${user.accountStatus eq 'BLOCKED'}">
                    <span class="adm-badge" style="background:#fee2e2;color:#b91c1c;">${msg_admin_finance_users_status_blocked}</span>
                </c:when>
                <c:otherwise>
                    <span class="adm-badge">${user.accountStatus}</span>
                </c:otherwise>
            </c:choose>
        </div>
        <div style="font-size:13px;color:#64748b;">
            ID: ${user.userIdx} · <c:out value="${user.userEmail}"/>
        </div>
    </div>

    <%-- 자산 카드 --%>
    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-bottom:20px;">
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:13px;color:#94a3b8;margin-bottom:6px;">
                💰 ${msg_admin_finance_userDetail_cash}
            </div>
            <div class="adm-fin-num" style="font-size:22px;font-weight:700;">
                <fmt:formatNumber value="${user.cashBalance}" pattern="#,###"/>
            </div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:13px;color:#94a3b8;margin-bottom:6px;">
                ✈️ ${msg_admin_finance_userDetail_mileage}
            </div>
            <div class="adm-fin-num" style="font-size:22px;font-weight:700;">
                <fmt:formatNumber value="${user.mileageBalance}" pattern="#,###"/>
            </div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:13px;color:#94a3b8;margin-bottom:6px;">
                ⭐ ${msg_admin_finance_userDetail_point}
            </div>
            <div class="adm-fin-num" style="font-size:22px;font-weight:700;">
                <fmt:formatNumber value="${user.pointBalance}" pattern="#,###"/>
            </div>
        </div>
    </div>

    <%-- 자산 변동 이력 --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div style="padding:16px;border-bottom:1px solid #e2e8f0;font-weight:600;">
            ${msg_admin_finance_userDetail_walletHistory}
        </div>
        <div style="padding:0;overflow-x:auto;">
            <c:choose>
                <c:when test="${empty walletHistory}">
                    <div style="text-align:center;padding:40px;color:#94a3b8;font-size:13px;">
                        ${msg_admin_finance_userDetail_walletHistoryEmpty}
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="adm-table" style="width:100%;">
                        <thead>
                            <tr>
                                <th style="width:160px;">${msg_admin_finance_userDetail_col_changedAt}</th>
                                <th style="width:90px;">${msg_admin_finance_userDetail_col_assetType}</th>
                                <th style="width:110px;">${msg_admin_finance_userDetail_col_changeType}</th>
                                <th style="width:130px;text-align:right;">${msg_admin_finance_userDetail_col_amount}</th>
                                <th style="width:130px;text-align:right;">${msg_admin_finance_userDetail_col_balanceAfter}</th>
                                <th>${msg_admin_finance_userDetail_col_detail}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="h" items="${walletHistory}">
                                <tr>
                                    <td style="font-size:12px;color:#475569;">${h.createdAt}</td>
                                    <td><span style="font-size:11px;padding:2px 8px;border-radius:999px;background:#f1f5f9;">${h.assetType}</span></td>
                                    <td style="font-size:12px;">${h.changeType}</td>
                                    <td style="text-align:right;${h.amount >= 0 ? 'color:#15803d;' : 'color:#b91c1c;'}">
                                        <c:if test="${h.amount > 0}">+</c:if><fmt:formatNumber value="${h.amount}" pattern="#,###"/>
                                    </td>
                                    <td style="text-align:right;font-weight:600;"><fmt:formatNumber value="${h.balanceAfter}" pattern="#,###"/></td>
                                    <td style="font-size:12px;color:#64748b;"><c:out value="${h.detailMessage}"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%-- 결제 이력 --%>
    <div class="adm-card">
        <div style="padding:16px;border-bottom:1px solid #e2e8f0;font-weight:600;">
            ${msg_admin_finance_userDetail_paymentHistory}
        </div>
        <div style="padding:0;overflow-x:auto;">
            <c:choose>
                <c:when test="${empty paymentHistory}">
                    <div style="text-align:center;padding:40px;color:#94a3b8;font-size:13px;">
                        ${msg_admin_finance_userDetail_paymentHistoryEmpty}
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="adm-table" style="width:100%;">
                        <thead>
                            <tr>
                                <th style="width:160px;">${msg_admin_finance_userDetail_col_changedAt}</th>
                                <th>${msg_admin_finance_userDetail_col_method}</th>
                                <th>${msg_admin_finance_userDetail_col_status}</th>
                                <th style="width:130px;text-align:right;">${msg_admin_finance_userDetail_col_amount}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${paymentHistory}">
                                <tr>
                                    <td style="font-size:12px;color:#475569;">${p.createdAt}</td>
                                    <td style="font-size:12px;">${p.paymentMethod}</td>
                                    <td>
                                        <span style="font-size:11px;padding:2px 8px;border-radius:999px;background:#f1f5f9;">${p.paymentStatus}</span>
                                    </td>
                                    <td style="text-align:right;font-weight:600;"><fmt:formatNumber value="${p.amount}" pattern="#,###"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>

<%@ include file="../layout-close.jsp" %>
