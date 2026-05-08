<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_finance_dashboard_title" code="admin.finance.dashboard.title"/>
<spring:message var="msg_admin_finance_users_searchPlaceholder" code="admin.finance.users.searchPlaceholder"/>
<spring:message var="msg_admin_finance_stats_totalCash" code="admin.finance.stats.totalCash"/>
<spring:message var="msg_admin_finance_unit_krw" code="admin.finance.unit.krw"/>
<spring:message var="msg_admin_finance_stats_totalMileage" code="admin.finance.stats.totalMileage"/>
<spring:message var="msg_admin_finance_unit_mileage" code="admin.finance.unit.mileage"/>
<spring:message var="msg_admin_finance_stats_totalPoint" code="admin.finance.stats.totalPoint"/>
<spring:message var="msg_admin_finance_unit_point" code="admin.finance.unit.point"/>
<spring:message var="msg_admin_finance_stats_totalUsers" code="admin.finance.stats.totalUsers"/>
<spring:message var="msg_admin_finance_stats_activeUsers" code="admin.finance.stats.activeUsers"/>
<spring:message var="msg_admin_finance_stats_blockedUsers" code="admin.finance.stats.blockedUsers"/>
<spring:message var="msg_admin_finance_stats_todayCharge" code="admin.finance.stats.todayCharge"/>
<spring:message var="msg_admin_finance_stats_lastMonthCharge" code="admin.finance.stats.lastMonthCharge"/>
<spring:message var="msg_admin_finance_widget_recentRefund_title" code="admin.finance.widget.recentRefund.title"/>
<spring:message var="msg_admin_finance_widget_viewAll" code="admin.finance.widget.viewAll"/>
<spring:message var="msg_admin_finance_widget_recentRefund_empty" code="admin.finance.widget.recentRefund.empty"/>
<spring:message var="msg_admin_finance_widget_col_time" code="admin.finance.widget.col.time"/>
<spring:message var="msg_admin_finance_widget_col_user" code="admin.finance.widget.col.user"/>
<spring:message var="msg_admin_finance_widget_col_amount" code="admin.finance.widget.col.amount"/>
<spring:message var="msg_admin_finance_widget_policy_title" code="admin.finance.widget.policy.title"/>
<spring:message var="msg_admin_finance_widget_manage" code="admin.finance.widget.manage"/>
<spring:message var="msg_admin_finance_widget_policy_limit" code="admin.finance.widget.policy.limit"/>
<spring:message var="msg_admin_finance_widget_policy_activeCount" code="admin.finance.widget.policy.activeCount"/>
<spring:message var="msg_admin_finance_widget_policy_reward" code="admin.finance.widget.policy.reward"/>
<spring:message var="msg_admin_finance_users_sectionTitle" code="admin.finance.users.sectionTitle"/>
<spring:message var="msg_admin_finance_users_allGrades" code="admin.finance.users.allGrades"/>
<spring:message var="msg_admin_finance_users_sort_latest" code="admin.finance.users.sort.latest"/>
<spring:message var="msg_admin_finance_users_sort_cash" code="admin.finance.users.sort.cash"/>
<spring:message var="msg_admin_finance_users_sort_mileage" code="admin.finance.users.sort.mileage"/>
<spring:message var="msg_admin_finance_users_sort_grade" code="admin.finance.users.sort.grade"/>
<spring:message var="msg_admin_finance_users_applyFilter" code="admin.finance.users.applyFilter"/>
<spring:message var="msg_admin_finance_users_col_nickname" code="admin.finance.users.col.nickname"/>
<spring:message var="msg_admin_finance_users_col_email" code="admin.finance.users.col.email"/>
<spring:message var="msg_admin_finance_users_col_grade" code="admin.finance.users.col.grade"/>
<spring:message var="msg_admin_finance_users_col_cash" code="admin.finance.users.col.cash"/>
<spring:message var="msg_admin_finance_users_col_mileage" code="admin.finance.users.col.mileage"/>
<spring:message var="msg_admin_finance_users_col_point" code="admin.finance.users.col.point"/>
<spring:message var="msg_admin_finance_users_col_status" code="admin.finance.users.col.status"/>
<spring:message var="msg_admin_finance_users_col_action" code="admin.finance.users.col.action"/>
<spring:message var="msg_admin_finance_users_empty" code="admin.finance.users.empty"/>
<spring:message var="msg_admin_finance_users_status_active" code="admin.finance.users.status.active"/>
<spring:message var="msg_admin_finance_users_status_blocked" code="admin.finance.users.status.blocked"/>
<spring:message var="msg_admin_finance_users_detailButton" code="admin.finance.users.detailButton"/>
<spring:message var="msg_admin_common_prev" code="admin.common.prev"/>
<spring:message var="msg_admin_common_next" code="admin.common.next"/>
<spring:message var="msg_admin_common_pageSize_20" code="admin.common.pageSize" arguments="20"/>
<spring:message var="msg_admin_common_pageSize_50" code="admin.common.pageSize" arguments="50"/>
<spring:message var="msg_admin_common_pageSize_100" code="admin.common.pageSize" arguments="100"/>
<spring:message var="msg_admin_finance_users_currentCountDisplay" code="admin.common.currentCountFormat" arguments="${fn:length(userList)}"/>
<c:set var="activeMenu" value="finance"/>
<c:set var="pageTitle">${msg_admin_finance_dashboard_title}</c:set>
<%@ include file="../layout.jsp" %>


<div class="adm-content adm-finance-page">

    <%-- 공통 탭바 --%>
    <%@ include file="_tabs.jsp" %>

    <%-- 자산 집계 카드 --%>
    <div class="adm-finance-balance-grid">
        <div class="adm-card adm-finance-stat-card adm-finance-stat-card-main">
            <div class="adm-finance-stat-label">
                💰 ${msg_admin_finance_stats_totalCash}
            </div>
            <div class="adm-fin-num adm-finance-stat-value">
                <fmt:formatNumber value="${stats.totalCashBalance}" pattern="#,###"/> ${msg_admin_finance_unit_krw}
            </div>
        </div>
        <div class="adm-card adm-finance-stat-card adm-finance-stat-card-main">
            <div class="adm-finance-stat-label">
                ✈️ ${msg_admin_finance_stats_totalMileage}
            </div>
            <div class="adm-fin-num adm-finance-stat-value">
                <fmt:formatNumber value="${stats.totalMileageBalance}" pattern="#,###"/> ${msg_admin_finance_unit_mileage}
            </div>
        </div>
        <div class="adm-card adm-finance-stat-card adm-finance-stat-card-main">
            <div class="adm-finance-stat-label">
                ⭐ ${msg_admin_finance_stats_totalPoint}
            </div>
            <div class="adm-fin-num adm-finance-stat-value">
                <fmt:formatNumber value="${stats.totalPointBalance}" pattern="#,###"/> ${msg_admin_finance_unit_point}
            </div>
        </div>
    </div>

    <%-- 회원 수 / 충전 통계 --%>
    <div class="adm-finance-summary-grid">
        <div class="adm-card adm-finance-stat-card">
            <div class="adm-finance-stat-label">${msg_admin_finance_stats_totalUsers}</div>
            <div class="adm-finance-summary-value"><fmt:formatNumber value="${stats.totalUsers}" pattern="#,###"/></div>
        </div>
        <div class="adm-card adm-finance-stat-card">
            <div class="adm-finance-stat-label">${msg_admin_finance_stats_activeUsers}</div>
            <div class="adm-finance-summary-value is-positive"><fmt:formatNumber value="${stats.activeUsers}" pattern="#,###"/></div>
        </div>
        <div class="adm-card adm-finance-stat-card">
            <div class="adm-finance-stat-label">${msg_admin_finance_stats_blockedUsers}</div>
            <div class="adm-finance-summary-value is-danger"><fmt:formatNumber value="${stats.blockedUsers}" pattern="#,###"/></div>
        </div>
        <div class="adm-card adm-finance-stat-card">
            <div class="adm-finance-stat-label">${msg_admin_finance_stats_todayCharge}</div>
            <div class="adm-finance-summary-value"><fmt:formatNumber value="${stats.todayChargeTotal}" pattern="#,###"/></div>
        </div>
        <div class="adm-card adm-finance-stat-card">
            <div class="adm-finance-stat-label">${msg_admin_finance_stats_lastMonthCharge}</div>
            <div class="adm-finance-summary-value"><fmt:formatNumber value="${stats.lastMonthChargeTotal}" pattern="#,###"/></div>
        </div>
    </div>

    <%-- 권한별 위젯 (환불 / 정책) --%>
    <c:if test="${hasFinanceOperator or hasFinancePolicyAdmin}">
        <div class="adm-finance-widget-grid ${(hasFinanceOperator and hasFinancePolicyAdmin) ? 'is-split' : 'is-single'}">

            <%-- 최근 환불 위젯 --%>
            <c:if test="${hasFinanceOperator}">
                <div class="adm-card adm-finance-widget-card">
                    <div class="adm-finance-widget-head">
                        <strong class="adm-finance-widget-title">↩️ ${msg_admin_finance_widget_recentRefund_title}</strong>
                        <a href="${pageContext.request.contextPath}/admin/finance/refund" class="adm-finance-widget-link">
                            ${msg_admin_finance_widget_viewAll} →
                        </a>
                    </div>
                    <c:choose>
                        <c:when test="${empty recentRefunds}">
                            <div class="adm-finance-widget-empty">
                                ${msg_admin_finance_widget_recentRefund_empty}
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table class="adm-finance-mini-table">
                                <thead>
                                <tr>
                                    <th onclick="financeThClick(this)">${msg_admin_finance_widget_col_time}</th>
                                    <th onclick="financeThClick(this)">${msg_admin_finance_widget_col_user}</th>
                                    <th class="adm-align-right" onclick="financeThClick(this)">${msg_admin_finance_widget_col_amount}</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="r" items="${recentRefunds}">
                                    <tr>
                                        <td class="adm-finance-mini-time"><fmt:formatDate value="${r.refundedAtDate}" pattern="MM/dd HH:mm"/></td>
                                        <td><c:out value="${r.userNickname}"/></td>
                                        <td class="adm-align-right adm-finance-mini-amount"><fmt:formatNumber value="${r.refundAmount}" pattern="#,###"/></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <%-- 정책 요약 위젯 --%>
            <c:if test="${hasFinancePolicyAdmin}">
                <div class="adm-card adm-finance-widget-card">
                    <div class="adm-finance-widget-head">
                        <strong class="adm-finance-widget-title">⚙️ ${msg_admin_finance_widget_policy_title}</strong>
                        <a href="${pageContext.request.contextPath}/admin/finance/policy" class="adm-finance-widget-link">
                            ${msg_admin_finance_widget_manage} →
                        </a>
                    </div>
                    <div class="adm-finance-policy-mini-grid">
                        <div>
                            <div class="adm-finance-policy-mini-label">🔒 ${msg_admin_finance_widget_policy_limit}</div>
                            <div class="adm-finance-policy-mini-value">
                                <c:set var="limitActive" value="0"/>
                                <c:forEach var="p" items="${limitPolicies}"><c:if test="${p.isActive}"><c:set var="limitActive" value="${limitActive + 1}"/></c:if></c:forEach>
                                ${limitActive}<span class="adm-finance-policy-mini-total"> / ${limitPolicies != null ? limitPolicies.size() : 0}</span>
                            </div>
                            <div class="adm-finance-policy-mini-note">${msg_admin_finance_widget_policy_activeCount}</div>
                        </div>
                        <div>
                            <div class="adm-finance-policy-mini-label">✨ ${msg_admin_finance_widget_policy_reward}</div>
                            <div class="adm-finance-policy-mini-value">
                                <c:set var="rewardActive" value="0"/>
                                <c:forEach var="p" items="${rewardPolicies}"><c:if test="${p.isActive}"><c:set var="rewardActive" value="${rewardActive + 1}"/></c:if></c:forEach>
                                ${rewardActive}<span class="adm-finance-policy-mini-total"> / ${rewardPolicies != null ? rewardPolicies.size() : 0}</span>
                            </div>
                            <div class="adm-finance-policy-mini-note">${msg_admin_finance_widget_policy_activeCount}</div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </c:if>

    <%-- 사용자 목록 (검색 + 페이지네이션 통합) --%>
    <h3 class="adm-finance-section-title">
        👥 ${msg_admin_finance_users_sectionTitle}
    </h3>

    <%-- 검색 폼 --%>
    <div class="adm-card adm-finance-filter-card">
        <form method="get" action="${pageContext.request.contextPath}/admin/finance"
              class="adm-finance-user-filterbar">
            <input type="text" name="keyword" value="${fn:escapeXml(search.keyword)}"
                   class="adm-input" placeholder="${msg_admin_finance_users_searchPlaceholder}"
                   >
            <select name="memberGrade" class="adm-select">
                <option value="">${msg_admin_finance_users_allGrades}</option>
                <c:forEach var="g" items="${['BRONZE','SILVER','GOLD','DIAMOND','PLATINUM']}">
                    <option value="${g}" ${search.memberGrade eq g ? 'selected' : ''}><spring:message var="msg_admin_finance_grade_g" code="admin.finance.grade.${g}"/>${msg_admin_finance_grade_g}</option>
                </c:forEach>
            </select>
            <select name="sort" class="adm-select">
                <option value="latest" ${search.sort eq 'latest' ? 'selected' : ''}>${msg_admin_finance_users_sort_latest}</option>
                <option value="cash"   ${search.sort eq 'cash'   ? 'selected' : ''}>${msg_admin_finance_users_sort_cash}</option>
                <option value="mileage" ${search.sort eq 'mileage' ? 'selected' : ''}>${msg_admin_finance_users_sort_mileage}</option>
                <option value="grade"  ${search.sort eq 'grade'  ? 'selected' : ''}>${msg_admin_finance_users_sort_grade}</option>
            </select>
            <select name="pageSize" class="adm-select adm-finance-page-size-select" onchange="admFinanceChangePageSize(this.value)">
                <option value="20" ${search.pageSize == 20 ? 'selected' : ''}>${msg_admin_common_pageSize_20}</option>
                <option value="50" ${search.pageSize == 50 ? 'selected' : ''}>${msg_admin_common_pageSize_50}</option>
                <option value="100" ${search.pageSize == 100 ? 'selected' : ''}>${msg_admin_common_pageSize_100}</option>
            </select>
            <button type="submit" class="adm-btn adm-btn-primary">${msg_admin_finance_users_applyFilter}</button>
            <span class="adm-finance-filter-total">
                <spring:message var="msg_admin_finance_users_totalCount_args_totalCount" code="admin.finance.users.totalCount" arguments="${totalCount}"/>${msg_admin_finance_users_totalCount_args_totalCount}
            </span>
        </form>
    </div>

    <%-- 사용자 테이블 --%>
    <div class="adm-card adm-finance-table-card adm-finance-managed-card adm-overflow-visible">
        <div class="adm-card-head">
            <div class="adm-card-title">
                ${msg_admin_finance_users_sectionTitle}
                <span class="adm-section-total-inline">
                    <spring:message var="msg_admin_finance_users_totalCount_args_totalCount_card" code="admin.finance.users.totalCount" arguments="${totalCount}"/>${msg_admin_finance_users_totalCount_args_totalCount_card}
                </span>
            </div>
        </div>
        <div class="adm-table-wrap">
        <table class="adm-table adm-finance-user-table" data-admin-list-ignore="true">
            <colgroup>
                <col class="adm-finance-col-id">
                <col>
                <col>
                <col class="adm-finance-col-grade">
                <col class="adm-finance-col-amount">
                <col class="adm-finance-col-amount">
                <col class="adm-finance-col-amount">
                <col class="adm-finance-col-status">
                <col class="adm-finance-col-action">
            </colgroup>
            <thead>
                <tr>
                    <th onclick="financeThClick(this)">ID</th>
                    <th onclick="financeThClick(this)">${msg_admin_finance_users_col_nickname}</th>
                    <th onclick="financeThClick(this)">${msg_admin_finance_users_col_email}</th>
                    <th onclick="financeThClick(this)">${msg_admin_finance_users_col_grade}</th>
                    <th class="adm-align-right" onclick="financeThClick(this)">${msg_admin_finance_users_col_cash}</th>
                    <th class="adm-align-right" onclick="financeThClick(this)">${msg_admin_finance_users_col_mileage}</th>
                    <th class="adm-align-right" onclick="financeThClick(this)">${msg_admin_finance_users_col_point}</th>
                    <th onclick="financeThClick(this)">${msg_admin_finance_users_col_status}</th>
                    <th onclick="financeThClick(this)">${msg_admin_finance_users_col_action}</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty userList}">
                        <tr class="adm-local-empty"><td colspan="9" class="adm-local-empty-cell">
                            ${msg_admin_finance_users_empty}
                        </td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="u" items="${userList}">
                            <tr>
                                <td>${u.userIdx}</td>
                                <td><c:out value="${u.nickname}"/></td>
                                <td class="adm-finance-email-cell"><c:out value="${u.userEmail}"/></td>
                                <td>
                                    <span class="adm-finance-grade-pill">
                                        <spring:message var="msg_admin_finance_grade_u_memberGrade_text_u_memberGrade" code="admin.finance.grade.${u.memberGrade}" text="${u.memberGrade}"/>${msg_admin_finance_grade_u_memberGrade_text_u_memberGrade}
                                    </span>
                                </td>
                                <td class="adm-align-right"><fmt:formatNumber value="${u.cashBalance}" pattern="#,###"/></td>
                                <td class="adm-align-right"><fmt:formatNumber value="${u.mileageBalance}" pattern="#,###"/></td>
                                <td class="adm-align-right"><fmt:formatNumber value="${u.pointBalance}" pattern="#,###"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.accountStatus eq 'ACTIVE'}">
                                            <span class="adm-badge adm-badge-green">${msg_admin_finance_users_status_active}</span>
                                        </c:when>
                                        <c:when test="${u.accountStatus eq 'BLOCKED'}">
                                            <span class="adm-badge adm-finance-status-blocked">${msg_admin_finance_users_status_blocked}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="adm-badge">${u.accountStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/finance/users/${u.userIdx}"
                                       class="adm-btn adm-btn-ghost adm-finance-detail-btn">
                                        ${msg_admin_finance_users_detailButton}
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
        </div>
        <c:set var="financeTotalPage" value="${totalPage < 1 ? 1 : totalPage}"/>
        <div class="adm-local-pagination adm-finance-local-pagination">
            <div class="adm-local-page-info">
                <spring:message var="msg_admin_finance_users_totalCount_args_totalCount_page" code="admin.finance.users.totalCount" arguments="${totalCount}"/>${msg_admin_finance_users_totalCount_args_totalCount_page}
                / ${msg_admin_finance_users_currentCountDisplay}
            </div>
            <div class="adm-local-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost" ${search.page <= 1 ? 'disabled' : ''} onclick="admFinanceGoPage(${search.page - 1})">${msg_admin_common_prev}</button>
                <span class="js-finance-page-state">${search.page} / ${financeTotalPage}</span>
                <button type="button" class="adm-btn adm-btn-ghost" ${search.page >= financeTotalPage ? 'disabled' : ''} onclick="admFinanceGoPage(${search.page + 1})">${msg_admin_common_next}</button>
            </div>
        </div>
    </div>

</div>

<script>
function admFinanceGoPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = '${pageContext.request.contextPath}/admin/finance?' + params.toString();
}
function admFinanceChangePageSize(pageSize) {
    var params = new URLSearchParams(window.location.search);
    params.set('pageSize', pageSize);
    params.set('page', '1');
    location.href = '${pageContext.request.contextPath}/admin/finance?' + params.toString();
}

/* ── 헤더 클릭: 첫 행의 같은 컬럼 셀 액션을 트리거 ── */
function financeThClick(th) {
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
