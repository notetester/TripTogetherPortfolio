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
<c:set var="activeMenu" value="finance"/>
<c:set var="pageTitle">${msg_admin_finance_dashboard_title}</c:set>
<%@ include file="../layout.jsp" %>


<div class="adm-content">

    <%-- 공통 탭바 --%>
    <%@ include file="_tabs.jsp" %>

    <%-- 자산 집계 카드 --%>
    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-bottom:20px;">
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:13px;color:#94a3b8;margin-bottom:6px;">
                💰 ${msg_admin_finance_stats_totalCash}
            </div>
            <div class="adm-fin-num" style="font-size:22px;font-weight:700;">
                <fmt:formatNumber value="${stats.totalCashBalance}" pattern="#,###"/> ${msg_admin_finance_unit_krw}
            </div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:13px;color:#94a3b8;margin-bottom:6px;">
                ✈️ ${msg_admin_finance_stats_totalMileage}
            </div>
            <div class="adm-fin-num" style="font-size:22px;font-weight:700;">
                <fmt:formatNumber value="${stats.totalMileageBalance}" pattern="#,###"/> ${msg_admin_finance_unit_mileage}
            </div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:13px;color:#94a3b8;margin-bottom:6px;">
                ⭐ ${msg_admin_finance_stats_totalPoint}
            </div>
            <div class="adm-fin-num" style="font-size:22px;font-weight:700;">
                <fmt:formatNumber value="${stats.totalPointBalance}" pattern="#,###"/> ${msg_admin_finance_unit_point}
            </div>
        </div>
    </div>

    <%-- 회원 수 / 충전 통계 --%>
    <div style="display:grid;grid-template-columns:repeat(5,1fr);gap:12px;margin-bottom:20px;">
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;">${msg_admin_finance_stats_totalUsers}</div>
            <div style="font-size:18px;font-weight:700;"><fmt:formatNumber value="${stats.totalUsers}" pattern="#,###"/></div>
        </div>
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;">${msg_admin_finance_stats_activeUsers}</div>
            <div style="font-size:18px;font-weight:700;color:#15803d;"><fmt:formatNumber value="${stats.activeUsers}" pattern="#,###"/></div>
        </div>
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;">${msg_admin_finance_stats_blockedUsers}</div>
            <div style="font-size:18px;font-weight:700;color:#b91c1c;"><fmt:formatNumber value="${stats.blockedUsers}" pattern="#,###"/></div>
        </div>
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;">${msg_admin_finance_stats_todayCharge}</div>
            <div style="font-size:18px;font-weight:700;"><fmt:formatNumber value="${stats.todayChargeTotal}" pattern="#,###"/></div>
        </div>
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;">${msg_admin_finance_stats_lastMonthCharge}</div>
            <div style="font-size:18px;font-weight:700;"><fmt:formatNumber value="${stats.lastMonthChargeTotal}" pattern="#,###"/></div>
        </div>
    </div>

    <%-- 권한별 위젯 (환불 / 정책) --%>
    <c:if test="${hasFinanceOperator or hasFinancePolicyAdmin}">
        <div style="display:grid;grid-template-columns:repeat(${(hasFinanceOperator and hasFinancePolicyAdmin) ? 2 : 1},1fr);gap:16px;margin-bottom:20px;">

            <%-- 최근 환불 위젯 --%>
            <c:if test="${hasFinanceOperator}">
                <div class="adm-card" style="padding:18px;">
                    <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:12px;">
                        <strong style="font-size:14px;">↩️ ${msg_admin_finance_widget_recentRefund_title}</strong>
                        <a href="${pageContext.request.contextPath}/admin/finance/refund" style="font-size:12px;color:#60a5fa;text-decoration:none;">
                            ${msg_admin_finance_widget_viewAll} →
                        </a>
                    </div>
                    <c:choose>
                        <c:when test="${empty recentRefunds}">
                            <div style="font-size:12px;color:#94a3b8;text-align:center;padding:18px 0;">
                                ${msg_admin_finance_widget_recentRefund_empty}
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table style="width:100%;font-size:12px;border-collapse:collapse;">
                                <thead>
                                <tr style="color:#94a3b8;">
                                    <th style="text-align:left;padding:6px 4px;border-bottom:1px solid rgba(148,163,184,.2);">${msg_admin_finance_widget_col_time}</th>
                                    <th style="text-align:left;padding:6px 4px;border-bottom:1px solid rgba(148,163,184,.2);">${msg_admin_finance_widget_col_user}</th>
                                    <th style="text-align:right;padding:6px 4px;border-bottom:1px solid rgba(148,163,184,.2);">${msg_admin_finance_widget_col_amount}</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="r" items="${recentRefunds}">
                                    <tr>
                                        <td style="padding:6px 4px;color:#cbd5e1;"><fmt:formatDate value="${r.refundedAtDate}" pattern="MM/dd HH:mm"/></td>
                                        <td style="padding:6px 4px;"><c:out value="${r.userNickname}"/></td>
                                        <td style="padding:6px 4px;text-align:right;font-weight:600;"><fmt:formatNumber value="${r.refundAmount}" pattern="#,###"/></td>
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
                <div class="adm-card" style="padding:18px;">
                    <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:12px;">
                        <strong style="font-size:14px;">⚙️ ${msg_admin_finance_widget_policy_title}</strong>
                        <a href="${pageContext.request.contextPath}/admin/finance/policy" style="font-size:12px;color:#60a5fa;text-decoration:none;">
                            ${msg_admin_finance_widget_manage} →
                        </a>
                    </div>
                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:14px;font-size:12px;">
                        <div>
                            <div style="color:#94a3b8;margin-bottom:4px;">🔒 ${msg_admin_finance_widget_policy_limit}</div>
                            <div style="font-size:18px;font-weight:700;">
                                <c:set var="limitActive" value="0"/>
                                <c:forEach var="p" items="${limitPolicies}"><c:if test="${p.isActive}"><c:set var="limitActive" value="${limitActive + 1}"/></c:if></c:forEach>
                                ${limitActive}<span style="font-size:11px;font-weight:400;color:#94a3b8;"> / ${limitPolicies != null ? limitPolicies.size() : 0}</span>
                            </div>
                            <div style="font-size:11px;color:#94a3b8;">${msg_admin_finance_widget_policy_activeCount}</div>
                        </div>
                        <div>
                            <div style="color:#94a3b8;margin-bottom:4px;">✨ ${msg_admin_finance_widget_policy_reward}</div>
                            <div style="font-size:18px;font-weight:700;">
                                <c:set var="rewardActive" value="0"/>
                                <c:forEach var="p" items="${rewardPolicies}"><c:if test="${p.isActive}"><c:set var="rewardActive" value="${rewardActive + 1}"/></c:if></c:forEach>
                                ${rewardActive}<span style="font-size:11px;font-weight:400;color:#94a3b8;"> / ${rewardPolicies != null ? rewardPolicies.size() : 0}</span>
                            </div>
                            <div style="font-size:11px;color:#94a3b8;">${msg_admin_finance_widget_policy_activeCount}</div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </c:if>

    <%-- 사용자 목록 (검색 + 페이지네이션 통합) --%>
    <h3 style="font-size:15px;margin:24px 0 10px 0;">
        👥 ${msg_admin_finance_users_sectionTitle}
    </h3>

    <%-- 검색 폼 --%>
    <div class="adm-card" style="padding:16px;margin-bottom:16px;">
        <form method="get" action="${pageContext.request.contextPath}/admin/finance"
              style="display:flex;gap:8px;align-items:center;flex-wrap:wrap;">
            <input type="text" name="keyword" value="${fn:escapeXml(search.keyword)}"
                   class="adm-input" placeholder="${msg_admin_finance_users_searchPlaceholder}"
                   style="padding:8px 12px;font-size:13px;width:240px;">
            <select name="memberGrade" class="adm-input" style="padding:8px 12px;font-size:13px;">
                <option value="">${msg_admin_finance_users_allGrades}</option>
                <c:forEach var="g" items="${['BRONZE','SILVER','GOLD','DIAMOND','PLATINUM']}">
                    <option value="${g}" ${search.memberGrade eq g ? 'selected' : ''}><spring:message var="msg_admin_finance_grade_g" code="admin.finance.grade.${g}"/>${msg_admin_finance_grade_g}</option>
                </c:forEach>
            </select>
            <select name="sort" class="adm-input" style="padding:8px 12px;font-size:13px;">
                <option value="latest" ${search.sort eq 'latest' ? 'selected' : ''}>${msg_admin_finance_users_sort_latest}</option>
                <option value="cash"   ${search.sort eq 'cash'   ? 'selected' : ''}>${msg_admin_finance_users_sort_cash}</option>
                <option value="mileage" ${search.sort eq 'mileage' ? 'selected' : ''}>${msg_admin_finance_users_sort_mileage}</option>
                <option value="grade"  ${search.sort eq 'grade'  ? 'selected' : ''}>${msg_admin_finance_users_sort_grade}</option>
            </select>
            <button type="submit" class="adm-btn adm-btn-ghost">${msg_admin_finance_users_applyFilter}</button>
            <span style="margin-left:auto;font-size:13px;color:#64748b;">
                <spring:message var="msg_admin_finance_users_totalCount_args_totalCount" code="admin.finance.users.totalCount" arguments="${totalCount}"/>${msg_admin_finance_users_totalCount_args_totalCount}
            </span>
        </form>
    </div>

    <%-- 사용자 테이블 --%>
    <div class="adm-card" style="padding:0;overflow-x:auto;">
        <table class="adm-table" style="width:100%;">
            <thead>
                <tr>
                    <th style="width:80px;">ID</th>
                    <th>${msg_admin_finance_users_col_nickname}</th>
                    <th>${msg_admin_finance_users_col_email}</th>
                    <th style="width:100px;">${msg_admin_finance_users_col_grade}</th>
                    <th style="width:130px;text-align:right;">${msg_admin_finance_users_col_cash}</th>
                    <th style="width:130px;text-align:right;">${msg_admin_finance_users_col_mileage}</th>
                    <th style="width:130px;text-align:right;">${msg_admin_finance_users_col_point}</th>
                    <th style="width:90px;">${msg_admin_finance_users_col_status}</th>
                    <th style="width:100px;">${msg_admin_finance_users_col_action}</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty userList}">
                        <tr><td colspan="9" style="text-align:center;padding:48px;color:#94a3b8;">
                            ${msg_admin_finance_users_empty}
                        </td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="u" items="${userList}">
                            <tr>
                                <td>${u.userIdx}</td>
                                <td><c:out value="${u.nickname}"/></td>
                                <td style="font-size:12px;color:#475569;"><c:out value="${u.userEmail}"/></td>
                                <td>
                                    <span style="font-size:11px;padding:2px 8px;border-radius:999px;background:#f1f5f9;color:#475569;">
                                        <spring:message var="msg_admin_finance_grade_u_memberGrade_text_u_memberGrade" code="admin.finance.grade.${u.memberGrade}" text="${u.memberGrade}"/>${msg_admin_finance_grade_u_memberGrade_text_u_memberGrade}
                                    </span>
                                </td>
                                <td style="text-align:right;"><fmt:formatNumber value="${u.cashBalance}" pattern="#,###"/></td>
                                <td style="text-align:right;"><fmt:formatNumber value="${u.mileageBalance}" pattern="#,###"/></td>
                                <td style="text-align:right;"><fmt:formatNumber value="${u.pointBalance}" pattern="#,###"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.accountStatus eq 'ACTIVE'}">
                                            <span class="adm-badge adm-badge-green">${msg_admin_finance_users_status_active}</span>
                                        </c:when>
                                        <c:when test="${u.accountStatus eq 'BLOCKED'}">
                                            <span class="adm-badge" style="background:#fee2e2;color:#b91c1c;">${msg_admin_finance_users_status_blocked}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="adm-badge">${u.accountStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/finance/users/${u.userIdx}"
                                       class="adm-btn adm-btn-ghost" style="padding:4px 10px;font-size:12px;">
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

    <%-- 페이지네이션 --%>
    <c:if test="${totalPage > 1}">
        <div style="display:flex;justify-content:center;gap:6px;margin-top:16px;">
            <c:forEach var="p" begin="1" end="${totalPage}">
                <a href="?keyword=${search.keyword}&memberGrade=${search.memberGrade}&sort=${search.sort}&page=${p}"
                   class="adm-btn ${search.page == p ? 'adm-btn-primary' : 'adm-btn-ghost'}"
                   style="padding:6px 12px;font-size:13px;">${p}</a>
            </c:forEach>
        </div>
    </c:if>

</div>

<%@ include file="../layout-close.jsp" %>
