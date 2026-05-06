<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_4aac89bce7" code="admin.finance.dashboard.title"/>
<spring:message var="autoMsg_296fc079b4" code="admin.finance.stats.totalCash"/>
<spring:message var="autoMsg_070f0e2d5e" code="admin.finance.unit.krw"/>
<spring:message var="autoMsg_f822b1f9ef" code="admin.finance.stats.totalMileage"/>
<spring:message var="autoMsg_2c9f53e6f2" code="admin.finance.unit.mileage"/>
<spring:message var="autoMsg_f7cdb1ef62" code="admin.finance.stats.totalPoint"/>
<spring:message var="autoMsg_b337e2a9e9" code="admin.finance.unit.point"/>
<spring:message var="autoMsg_71b1cec270" code="admin.finance.stats.totalUsers"/>
<spring:message var="autoMsg_d9256be8b3" code="admin.finance.stats.activeUsers"/>
<spring:message var="autoMsg_a10dac46cf" code="admin.finance.stats.blockedUsers"/>
<spring:message var="autoMsg_06a13eb9b7" code="admin.finance.stats.todayCharge"/>
<spring:message var="autoMsg_f79c809b4d" code="admin.finance.stats.lastMonthCharge"/>
<spring:message var="autoMsg_fc2de31a62" code="admin.finance.widget.recentRefund.title"/>
<spring:message var="autoMsg_81e040051c" code="admin.finance.widget.viewAll"/>
<spring:message var="autoMsg_037b739937" code="admin.finance.widget.col.time"/>
<spring:message var="autoMsg_9607fc1847" code="admin.finance.widget.col.user"/>
<spring:message var="autoMsg_4a09e717dd" code="admin.finance.widget.col.amount"/>
<spring:message var="autoMsg_8d32eb8532" code="admin.finance.widget.policy.title"/>
<spring:message var="autoMsg_54c3166c32" code="admin.finance.widget.manage"/>
<spring:message var="autoMsg_76ffbff157" code="admin.finance.widget.policy.limit"/>
<spring:message var="autoMsg_f1e333cf53" code="admin.finance.widget.policy.activeCount"/>
<spring:message var="autoMsg_806ab4c254" code="admin.finance.widget.policy.reward"/>
<spring:message var="autoMsg_aea611da23" code="admin.finance.users.sectionTitle"/>
<spring:message var="autoMsg_c8e70420e9" code="admin.finance.users.searchPlaceholder"/>
<spring:message var="autoMsg_adb802c602" code="admin.finance.users.allGrades"/>
<spring:message var="autoMsg_9c6df3c0fe" code="admin.finance.grade.${g}"/>
<spring:message var="autoMsg_ccd31366f5" code="admin.finance.users.sort.latest"/>
<spring:message var="autoMsg_7f2068b3f4" code="admin.finance.users.sort.cash"/>
<spring:message var="autoMsg_aeced72b22" code="admin.finance.users.sort.mileage"/>
<spring:message var="autoMsg_544c84880b" code="admin.finance.users.sort.grade"/>
<spring:message var="autoMsg_090781dc81" code="admin.finance.users.applyFilter"/>
<spring:message var="autoMsg_cd2b08c2e8" code="admin.finance.users.col.nickname"/>
<spring:message var="autoMsg_f1f0168e43" code="admin.finance.users.col.email"/>
<spring:message var="autoMsg_d6a7baaff1" code="admin.finance.users.col.grade"/>
<spring:message var="autoMsg_36d42e3a3c" code="admin.finance.users.col.cash"/>
<spring:message var="autoMsg_6e905cd764" code="admin.finance.users.col.mileage"/>
<spring:message var="autoMsg_d26b2006cc" code="admin.finance.users.col.point"/>
<spring:message var="autoMsg_f5d63bca0a" code="admin.finance.users.col.status"/>
<spring:message var="autoMsg_b846ca4753" code="admin.finance.users.col.action"/>
<spring:message var="autoMsg_8a017b192a" code="admin.finance.users.status.active"/>
<spring:message var="autoMsg_5e33245357" code="admin.finance.users.status.blocked"/>
<c:set var="activeMenu" value="finance"/>
<c:set var="pageTitle">${autoMsg_4aac89bce7}</c:set>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- 공통 탭바 --%>
    <%@ include file="_tabs.jsp" %>

    <%-- 자산 집계 카드 --%>
    <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:16px;margin-bottom:20px;">
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:13px;color:#94a3b8;margin-bottom:6px;">
                💰 ${autoMsg_296fc079b4}
            </div>
            <div class="adm-fin-num" style="font-size:22px;font-weight:700;">
                <fmt:formatNumber value="${stats.totalCashBalance}" pattern="#,###"/> ${autoMsg_070f0e2d5e}
            </div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:13px;color:#94a3b8;margin-bottom:6px;">
                ✈️ ${autoMsg_f822b1f9ef}
            </div>
            <div class="adm-fin-num" style="font-size:22px;font-weight:700;">
                <fmt:formatNumber value="${stats.totalMileageBalance}" pattern="#,###"/> ${autoMsg_2c9f53e6f2}
            </div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:13px;color:#94a3b8;margin-bottom:6px;">
                ⭐ ${autoMsg_f7cdb1ef62}
            </div>
            <div class="adm-fin-num" style="font-size:22px;font-weight:700;">
                <fmt:formatNumber value="${stats.totalPointBalance}" pattern="#,###"/> ${autoMsg_b337e2a9e9}
            </div>
        </div>
    </div>

    <%-- 회원 수 / 충전 통계 --%>
    <div style="display:grid;grid-template-columns:repeat(5,1fr);gap:12px;margin-bottom:20px;">
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;">${autoMsg_71b1cec270}</div>
            <div style="font-size:18px;font-weight:700;"><fmt:formatNumber value="${stats.totalUsers}" pattern="#,###"/></div>
        </div>
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;">${autoMsg_d9256be8b3}</div>
            <div style="font-size:18px;font-weight:700;color:#15803d;"><fmt:formatNumber value="${stats.activeUsers}" pattern="#,###"/></div>
        </div>
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;">${autoMsg_a10dac46cf}</div>
            <div style="font-size:18px;font-weight:700;color:#b91c1c;"><fmt:formatNumber value="${stats.blockedUsers}" pattern="#,###"/></div>
        </div>
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;">${autoMsg_06a13eb9b7}</div>
            <div style="font-size:18px;font-weight:700;"><fmt:formatNumber value="${stats.todayChargeTotal}" pattern="#,###"/></div>
        </div>
        <div class="adm-card" style="padding:16px;">
            <div style="font-size:12px;color:#94a3b8;">${autoMsg_f79c809b4d}</div>
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
                        <strong style="font-size:14px;">↩️ ${autoMsg_fc2de31a62}</strong>
                        <a href="${pageContext.request.contextPath}/admin/finance/refund" style="font-size:12px;color:#60a5fa;text-decoration:none;">
                            ${autoMsg_81e040051c} →
                        </a>
                    </div>
                    <c:choose>
                        <c:when test="${empty recentRefunds}">
                            <div style="font-size:12px;color:#94a3b8;text-align:center;padding:18px 0;">
                                <spring:message code="admin.finance.widget.recentRefund.empty"/>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table style="width:100%;font-size:12px;border-collapse:collapse;">
                                <thead>
                                <tr style="color:#94a3b8;">
                                    <th style="text-align:left;padding:6px 4px;border-bottom:1px solid rgba(148,163,184,.2);">${autoMsg_037b739937}</th>
                                    <th style="text-align:left;padding:6px 4px;border-bottom:1px solid rgba(148,163,184,.2);">${autoMsg_9607fc1847}</th>
                                    <th style="text-align:right;padding:6px 4px;border-bottom:1px solid rgba(148,163,184,.2);">${autoMsg_4a09e717dd}</th>
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
                        <strong style="font-size:14px;">⚙️ ${autoMsg_8d32eb8532}</strong>
                        <a href="${pageContext.request.contextPath}/admin/finance/policy" style="font-size:12px;color:#60a5fa;text-decoration:none;">
                            ${autoMsg_54c3166c32} →
                        </a>
                    </div>
                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:14px;font-size:12px;">
                        <div>
                            <div style="color:#94a3b8;margin-bottom:4px;">🔒 ${autoMsg_76ffbff157}</div>
                            <div style="font-size:18px;font-weight:700;">
                                <c:set var="limitActive" value="0"/>
                                <c:forEach var="p" items="${limitPolicies}"><c:if test="${p.isActive}"><c:set var="limitActive" value="${limitActive + 1}"/></c:if></c:forEach>
                                ${limitActive}<span style="font-size:11px;font-weight:400;color:#94a3b8;"> / ${limitPolicies != null ? limitPolicies.size() : 0}</span>
                            </div>
                            <div style="font-size:11px;color:#94a3b8;">${autoMsg_f1e333cf53}</div>
                        </div>
                        <div>
                            <div style="color:#94a3b8;margin-bottom:4px;">✨ ${autoMsg_806ab4c254}</div>
                            <div style="font-size:18px;font-weight:700;">
                                <c:set var="rewardActive" value="0"/>
                                <c:forEach var="p" items="${rewardPolicies}"><c:if test="${p.isActive}"><c:set var="rewardActive" value="${rewardActive + 1}"/></c:if></c:forEach>
                                ${rewardActive}<span style="font-size:11px;font-weight:400;color:#94a3b8;"> / ${rewardPolicies != null ? rewardPolicies.size() : 0}</span>
                            </div>
                            <div style="font-size:11px;color:#94a3b8;">${autoMsg_f1e333cf53}</div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </c:if>

    <%-- 사용자 목록 (검색 + 페이지네이션 통합) --%>
    <h3 style="font-size:15px;margin:24px 0 10px 0;">
        👥 ${autoMsg_aea611da23}
    </h3>

    <%-- 검색 폼 --%>
    <div class="adm-card" style="padding:16px;margin-bottom:16px;">
        <form method="get" action="${pageContext.request.contextPath}/admin/finance"
              style="display:flex;gap:8px;align-items:center;flex-wrap:wrap;">
            <input type="text" name="keyword" value="${fn:escapeXml(search.keyword)}"
                   class="adm-input" placeholder="${autoMsg_c8e70420e9}"
                   style="padding:8px 12px;font-size:13px;width:240px;">
            <select name="memberGrade" class="adm-input" style="padding:8px 12px;font-size:13px;">
                <option value="">${autoMsg_adb802c602}</option>
                <c:forEach var="g" items="${['BRONZE','SILVER','GOLD','DIAMOND','PLATINUM']}">
                    <option value="${g}" ${search.memberGrade eq g ? 'selected' : ''}>${autoMsg_9c6df3c0fe}</option>
                </c:forEach>
            </select>
            <select name="sort" class="adm-input" style="padding:8px 12px;font-size:13px;">
                <option value="latest" ${search.sort eq 'latest' ? 'selected' : ''}>${autoMsg_ccd31366f5}</option>
                <option value="cash"   ${search.sort eq 'cash'   ? 'selected' : ''}>${autoMsg_7f2068b3f4}</option>
                <option value="mileage" ${search.sort eq 'mileage' ? 'selected' : ''}>${autoMsg_aeced72b22}</option>
                <option value="grade"  ${search.sort eq 'grade'  ? 'selected' : ''}>${autoMsg_544c84880b}</option>
            </select>
            <button type="submit" class="adm-btn adm-btn-ghost">${autoMsg_090781dc81}</button>
            <span style="margin-left:auto;font-size:13px;color:#64748b;">
                <spring:message code="admin.finance.users.totalCount" arguments="${totalCount}"/>
            </span>
        </form>
    </div>

    <%-- 사용자 테이블 --%>
    <div class="adm-card" style="padding:0;overflow-x:auto;">
        <table class="adm-table" style="width:100%;">
            <thead>
                <tr>
                    <th style="width:80px;">ID</th>
                    <th>${autoMsg_cd2b08c2e8}</th>
                    <th>${autoMsg_f1f0168e43}</th>
                    <th style="width:100px;">${autoMsg_d6a7baaff1}</th>
                    <th style="width:130px;text-align:right;">${autoMsg_36d42e3a3c}</th>
                    <th style="width:130px;text-align:right;">${autoMsg_6e905cd764}</th>
                    <th style="width:130px;text-align:right;">${autoMsg_d26b2006cc}</th>
                    <th style="width:90px;">${autoMsg_f5d63bca0a}</th>
                    <th style="width:100px;">${autoMsg_b846ca4753}</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty userList}">
                        <tr><td colspan="9" style="text-align:center;padding:48px;color:#94a3b8;">
                            <spring:message code="admin.finance.users.empty"/>
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
                                        <spring:message code="admin.finance.grade.${u.memberGrade}" text="${u.memberGrade}"/>
                                    </span>
                                </td>
                                <td style="text-align:right;"><fmt:formatNumber value="${u.cashBalance}" pattern="#,###"/></td>
                                <td style="text-align:right;"><fmt:formatNumber value="${u.mileageBalance}" pattern="#,###"/></td>
                                <td style="text-align:right;"><fmt:formatNumber value="${u.pointBalance}" pattern="#,###"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.accountStatus eq 'ACTIVE'}">
                                            <span class="adm-badge adm-badge-green">${autoMsg_8a017b192a}</span>
                                        </c:when>
                                        <c:when test="${u.accountStatus eq 'BLOCKED'}">
                                            <span class="adm-badge" style="background:#fee2e2;color:#b91c1c;">${autoMsg_5e33245357}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="adm-badge">${u.accountStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/finance/users/${u.userIdx}"
                                       class="adm-btn adm-btn-ghost" style="padding:4px 10px;font-size:12px;">
                                        <spring:message code="admin.finance.users.detailButton"/>
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
