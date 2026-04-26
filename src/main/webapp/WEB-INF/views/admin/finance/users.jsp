<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="finance"/>
<c:set var="pageTitle"><spring:message code="admin.finance.users.title"/></c:set>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- 검색 폼 --%>
    <div class="adm-card" style="padding:16px;margin-bottom:16px;">
        <form method="get" action="${pageContext.request.contextPath}/admin/finance/users"
              style="display:flex;gap:8px;align-items:center;flex-wrap:wrap;">
            <input type="text" name="keyword" value="<c:out value='${search.keyword}'/>"
                   class="adm-input" placeholder="<spring:message code='admin.finance.users.searchPlaceholder'/>"
                   style="padding:8px 12px;font-size:13px;width:240px;">
            <select name="memberGrade" class="adm-input" style="padding:8px 12px;font-size:13px;">
                <option value=""><spring:message code="admin.finance.users.allGrades"/></option>
                <c:forEach var="g" items="${['BRONZE','SILVER','GOLD','DIAMOND','PLATINUM']}">
                    <option value="${g}" ${search.memberGrade eq g ? 'selected' : ''}>${g}</option>
                </c:forEach>
            </select>
            <select name="sort" class="adm-input" style="padding:8px 12px;font-size:13px;">
                <option value="latest" ${search.sort eq 'latest' ? 'selected' : ''}><spring:message code="admin.finance.users.sort.latest"/></option>
                <option value="cash"   ${search.sort eq 'cash'   ? 'selected' : ''}><spring:message code="admin.finance.users.sort.cash"/></option>
                <option value="mileage" ${search.sort eq 'mileage' ? 'selected' : ''}><spring:message code="admin.finance.users.sort.mileage"/></option>
                <option value="grade"  ${search.sort eq 'grade'  ? 'selected' : ''}><spring:message code="admin.finance.users.sort.grade"/></option>
            </select>
            <button type="submit" class="adm-btn adm-btn-ghost"><spring:message code="admin.finance.users.applyFilter"/></button>
            <span style="margin-left:auto;font-size:13px;color:#64748b;">
                <spring:message code="admin.finance.users.totalCount" arguments="${totalCount}"/>
            </span>
        </form>
    </div>

    <%-- 목록 테이블 --%>
    <div class="adm-card" style="padding:0;overflow-x:auto;">
        <table class="adm-table" style="width:100%;">
            <thead>
                <tr>
                    <th style="width:80px;">ID</th>
                    <th><spring:message code="admin.finance.users.col.nickname"/></th>
                    <th><spring:message code="admin.finance.users.col.email"/></th>
                    <th style="width:100px;"><spring:message code="admin.finance.users.col.grade"/></th>
                    <th style="width:130px;text-align:right;"><spring:message code="admin.finance.users.col.cash"/></th>
                    <th style="width:130px;text-align:right;"><spring:message code="admin.finance.users.col.mileage"/></th>
                    <th style="width:130px;text-align:right;"><spring:message code="admin.finance.users.col.point"/></th>
                    <th style="width:90px;"><spring:message code="admin.finance.users.col.status"/></th>
                    <th style="width:100px;"><spring:message code="admin.finance.users.col.action"/></th>
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
                                        ${u.memberGrade}
                                    </span>
                                </td>
                                <td style="text-align:right;"><fmt:formatNumber value="${u.cashBalance}" pattern="#,###"/></td>
                                <td style="text-align:right;"><fmt:formatNumber value="${u.mileageBalance}" pattern="#,###"/></td>
                                <td style="text-align:right;"><fmt:formatNumber value="${u.pointBalance}" pattern="#,###"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.accountStatus eq 'ACTIVE'}">
                                            <span class="adm-badge adm-badge-green"><spring:message code="admin.finance.users.status.active"/></span>
                                        </c:when>
                                        <c:when test="${u.accountStatus eq 'BLOCKED'}">
                                            <span class="adm-badge" style="background:#fee2e2;color:#b91c1c;"><spring:message code="admin.finance.users.status.blocked"/></span>
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
