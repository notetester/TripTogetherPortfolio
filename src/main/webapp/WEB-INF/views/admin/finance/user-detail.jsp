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
<spring:message var="msg_admin_finance_userDetail_walletCurrentCount" code="admin.common.currentCountFormat" arguments="${fn:length(walletHistory)}"/>
<spring:message var="msg_admin_finance_userDetail_paymentCurrentCount" code="admin.common.currentCountFormat" arguments="${fn:length(paymentHistory)}"/>
<c:set var="activeMenu" value="finance"/>
<c:set var="pageTitle">${msg_admin_finance_userDetail_title}</c:set>
<%@ include file="../layout.jsp" %>

<div class="adm-content adm-finance-page">

    <%-- 공통 탭바 --%>
    <%@ include file="_tabs.jsp" %>

    <a href="${pageContext.request.contextPath}/admin/finance" class="adm-btn adm-btn-ghost adm-finance-back-link">
        ← ${msg_admin_finance_userDetail_backToList}
    </a>

    <%-- 사용자 기본 정보 --%>
    <div class="adm-card adm-finance-user-hero-card">
        <div class="adm-finance-user-hero-main">
            <div class="adm-finance-user-name"><c:out value="${user.nickname}"/></div>
            <span class="adm-finance-grade-pill">
                ${user.memberGrade}
            </span>
            <c:choose>
                <c:when test="${user.accountStatus eq 'ACTIVE'}">
                    <span class="adm-badge adm-badge-green">${msg_admin_finance_users_status_active}</span>
                </c:when>
                <c:when test="${user.accountStatus eq 'BLOCKED'}">
                    <span class="adm-badge adm-finance-status-blocked">${msg_admin_finance_users_status_blocked}</span>
                </c:when>
                <c:otherwise>
                    <span class="adm-badge">${user.accountStatus}</span>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="adm-finance-user-meta">
            ID: ${user.userIdx} · <c:out value="${user.userEmail}"/>
        </div>
    </div>

    <%-- 자산 카드 --%>
    <div class="adm-finance-balance-grid">
        <div class="adm-card adm-finance-stat-card adm-finance-stat-card-main">
            <div class="adm-finance-stat-label">
                💰 ${msg_admin_finance_userDetail_cash}
            </div>
            <div class="adm-fin-num adm-finance-stat-value">
                <fmt:formatNumber value="${user.cashBalance}" pattern="#,###"/>
            </div>
        </div>
        <div class="adm-card adm-finance-stat-card adm-finance-stat-card-main">
            <div class="adm-finance-stat-label">
                ✈️ ${msg_admin_finance_userDetail_mileage}
            </div>
            <div class="adm-fin-num adm-finance-stat-value">
                <fmt:formatNumber value="${user.mileageBalance}" pattern="#,###"/>
            </div>
        </div>
        <div class="adm-card adm-finance-stat-card adm-finance-stat-card-main">
            <div class="adm-finance-stat-label">
                ⭐ ${msg_admin_finance_userDetail_point}
            </div>
            <div class="adm-fin-num adm-finance-stat-value">
                <fmt:formatNumber value="${user.pointBalance}" pattern="#,###"/>
            </div>
        </div>
    </div>

    <%-- 자산 변동 이력 --%>
    <div class="adm-card adm-finance-history-card adm-finance-managed-card adm-overflow-visible">
        <div class="adm-card-head">
            <div class="adm-card-title">
                ${msg_admin_finance_userDetail_walletHistory}
                <span class="adm-section-total-inline">${msg_admin_finance_userDetail_walletCurrentCount}</span>
            </div>
        </div>
        <div class="adm-table-wrap">
            <c:choose>
                <c:when test="${empty walletHistory}">
                    <div class="adm-local-empty-cell">
                        ${msg_admin_finance_userDetail_walletHistoryEmpty}
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="adm-table adm-finance-wallet-history-table" data-admin-list-ignore="true">
                        <colgroup>
                            <col class="adm-finance-col-time">
                            <col class="adm-finance-col-method">
                            <col class="adm-finance-col-status-wide">
                            <col class="adm-finance-col-amount">
                            <col class="adm-finance-col-amount">
                            <col>
                        </colgroup>
                        <thead>
                            <tr>
                                <th onclick="financeUserDetailThClick(this)">${msg_admin_finance_userDetail_col_changedAt}</th>
                                <th onclick="financeUserDetailThClick(this)">${msg_admin_finance_userDetail_col_assetType}</th>
                                <th onclick="financeUserDetailThClick(this)">${msg_admin_finance_userDetail_col_changeType}</th>
                                <th class="adm-align-right" onclick="financeUserDetailThClick(this)">${msg_admin_finance_userDetail_col_amount}</th>
                                <th class="adm-align-right" onclick="financeUserDetailThClick(this)">${msg_admin_finance_userDetail_col_balanceAfter}</th>
                                <th onclick="financeUserDetailThClick(this)">${msg_admin_finance_userDetail_col_detail}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="h" items="${walletHistory}">
                                <tr>
                                    <td class="adm-finance-time-cell">${h.createdAt}</td>
                                    <td><span class="adm-finance-grade-pill">${h.assetType}</span></td>
                                    <td class="adm-finance-reason-cell">${h.changeType}</td>
                                    <td class="adm-align-right adm-finance-signed-amount ${h.amount >= 0 ? 'is-positive' : 'is-negative'}">
                                        <c:if test="${h.amount > 0}">+</c:if><fmt:formatNumber value="${h.amount}" pattern="#,###"/>
                                    </td>
                                    <td class="adm-align-right adm-finance-amount-strong"><fmt:formatNumber value="${h.balanceAfter}" pattern="#,###"/></td>
                                    <td class="adm-finance-desc-cell"><c:out value="${h.detailMessage}"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%-- 결제 이력 --%>
    <div class="adm-card adm-finance-history-card adm-finance-managed-card adm-overflow-visible">
        <div class="adm-card-head">
            <div class="adm-card-title">
                ${msg_admin_finance_userDetail_paymentHistory}
                <span class="adm-section-total-inline">${msg_admin_finance_userDetail_paymentCurrentCount}</span>
            </div>
        </div>
        <div class="adm-table-wrap">
            <c:choose>
                <c:when test="${empty paymentHistory}">
                    <div class="adm-local-empty-cell">
                        ${msg_admin_finance_userDetail_paymentHistoryEmpty}
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="adm-table adm-finance-payment-history-table" data-admin-list-ignore="true">
                        <colgroup>
                            <col class="adm-finance-col-time">
                            <col>
                            <col>
                            <col class="adm-finance-col-amount">
                        </colgroup>
                        <thead>
                            <tr>
                                <th onclick="financeUserDetailThClick(this)">${msg_admin_finance_userDetail_col_changedAt}</th>
                                <th onclick="financeUserDetailThClick(this)">${msg_admin_finance_userDetail_col_method}</th>
                                <th onclick="financeUserDetailThClick(this)">${msg_admin_finance_userDetail_col_status}</th>
                                <th class="adm-align-right" onclick="financeUserDetailThClick(this)">${msg_admin_finance_userDetail_col_amount}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${paymentHistory}">
                                <tr>
                                    <td class="adm-finance-time-cell">${p.createdAt}</td>
                                    <td class="adm-finance-reason-cell">${p.paymentMethod}</td>
                                    <td>
                                        <span class="adm-finance-grade-pill">${p.paymentStatus}</span>
                                    </td>
                                    <td class="adm-align-right adm-finance-amount-strong"><fmt:formatNumber value="${p.amount}" pattern="#,###"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>

<script>
/* ── 헤더 클릭: 첫 행의 같은 컬럼 셀 액션을 트리거 (이력성 표는 행 자체로) ── */
function financeUserDetailThClick(th) {
    var table = th.closest('table');
    var firstRow = table && table.querySelector('tbody tr');
    if (!firstRow) return;
    var cell = firstRow.children[th.cellIndex];
    if (!cell) return;
    var target = cell.querySelector('button, a[href]');
    if (target) { target.click(); return; }
    var anyBtn = firstRow.querySelector('button, a[href]');
    if (anyBtn) anyBtn.click();
}
</script>

<%@ include file="../layout-close.jsp" %>
