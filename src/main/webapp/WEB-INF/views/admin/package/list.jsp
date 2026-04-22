<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="packages"/>
<spring:message code="admin.packages.pageTitle" var="adminPackagesPageTitle"/>
<c:set var="pageTitle"  value="${adminPackagesPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="admin.packages.pageTitle"/></h1>
            <p><spring:message code="admin.packages.pageSubtitle"/></p>
        </div>
    </div>

    <c:if test="${not empty packageReviewMessage}">
        <div class="adm-alert adm-alert-success">${fn:escapeXml(packageReviewMessage)}</div>
    </c:if>
    <c:if test="${not empty packageReviewError}">
        <div class="adm-alert adm-alert-danger">${fn:escapeXml(packageReviewError)}</div>
    </c:if>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/packages">
                <div class="adm-filter-bar">
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.packages.filter.status"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${status eq 'ALL' ? 'selected' : ''}><spring:message code="admin.common.all"/></option>
                            <option value="PENDING" ${status eq 'PENDING' ? 'selected' : ''}><spring:message code="admin.packages.status.pending"/></option>
                            <option value="APPROVED" ${status eq 'APPROVED' ? 'selected' : ''}><spring:message code="admin.packages.status.approved"/></option>
                            <option value="REJECTED" ${status eq 'REJECTED' ? 'selected' : ''}><spring:message code="admin.packages.status.rejected"/></option>
                            <option value="DRAFT" ${status eq 'DRAFT' ? 'selected' : ''}><spring:message code="admin.packages.status.draft"/></option>
                            <option value="BLOCKED" ${status eq 'BLOCKED' ? 'selected' : ''}><spring:message code="admin.packages.status.blocked"/></option>
                        </select>
                    </div>
                    <div style="display:flex;gap:6px;align-items:flex-end;">
                        <button type="submit" class="adm-btn adm-btn-primary"><spring:message code="admin.common.searchButton"/></button>
                        <a href="${pageContext.request.contextPath}/admin/packages"
                           class="adm-btn adm-btn-ghost"><spring:message code="admin.common.reset"/></a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th><spring:message code="admin.packages.column.package"/></th>
                    <th><spring:message code="admin.packages.column.seller"/></th>
                    <th><spring:message code="admin.packages.column.spot"/></th>
                    <th><spring:message code="admin.packages.column.priceSchedule"/></th>
                    <th><spring:message code="admin.common.status"/></th>
                    <th><spring:message code="admin.packages.column.review"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="pkg" items="${packageList}">
                    <tr>
                        <td>
                            <div style="display:flex;gap:12px;align-items:flex-start;min-width:280px;">
                                <div style="width:82px;height:58px;border-radius:10px;overflow:hidden;background:#1e293b;flex:0 0 auto;">
                                    <c:choose>
                                        <c:when test="${not empty pkg.mainImagePath}">
                                            <img src="${fn:escapeXml(pkg.mainImagePath)}"
                                                 alt="${fn:escapeXml(pkg.packageTitle)}"
                                                 style="width:100%;height:100%;object-fit:cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="height:100%;display:grid;place-items:center;color:#94a3b8;font-size:11px;font-weight:800;"><spring:message code="admin.packages.noImage"/></div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <div style="font-weight:800;color:#e2e8f0;">${fn:escapeXml(pkg.packageTitle)}</div>
                                    <c:if test="${not empty pkg.packageSummary}">
                                        <div style="font-size:12px;color:#94a3b8;margin-top:4px;max-width:420px;">
                                            ${fn:escapeXml(pkg.packageSummary)}
                                        </div>
                                    </c:if>
                                    <div style="font-size:11px;color:#64748b;margin-top:4px;"><spring:message code="admin.packages.createdAt" arguments="${pkg.createdAt}"/></div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="mem-name">${fn:escapeXml(pkg.sellerNickname)}</div>
                            <div class="mem-uid">user_idx ${pkg.sellerUserIdx}</div>
                        </td>
                        <td>
                            <div style="font-weight:700;color:#e2e8f0;">${fn:escapeXml(pkg.spotName)}</div>
                            <div style="font-size:12px;color:#94a3b8;">${fn:escapeXml(pkg.spotRegion)}</div>
                        </td>
                        <td>
                            <div style="font-weight:800;color:#e2e8f0;">
                                <fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(pkg.currencyCode)}
                            </div>
                            <div style="font-size:12px;color:#94a3b8;margin-top:4px;">
                                <c:choose>
                                    <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">
                                        ${pkg.startDate} ~ ${pkg.endDate}
                                    </c:when>
                                    <c:otherwise><spring:message code="admin.packages.always"/></c:otherwise>
                                </c:choose>
                            </div>
                            <div style="font-size:12px;color:#94a3b8;">
                                <spring:message code="admin.packages.minPeople" arguments="${pkg.minPeople}"/>
                                <c:if test="${not empty pkg.maxPeople}"> / <spring:message code="admin.packages.maxPeople" arguments="${pkg.maxPeople}"/></c:if>
                            </div>
                        </td>
                        <td>
                            <span class="status-badge ${pkg.packageStatus}">
                                <c:choose>
                                    <c:when test="${pkg.packageStatus eq 'PENDING'}"><spring:message code="admin.packages.status.pending"/></c:when>
                                    <c:when test="${pkg.packageStatus eq 'APPROVED'}"><spring:message code="admin.packages.status.approved"/></c:when>
                                    <c:when test="${pkg.packageStatus eq 'REJECTED'}"><spring:message code="admin.packages.status.rejected"/></c:when>
                                    <c:when test="${pkg.packageStatus eq 'DRAFT'}"><spring:message code="admin.packages.status.draft"/></c:when>
                                    <c:when test="${pkg.packageStatus eq 'BLOCKED'}"><spring:message code="admin.packages.status.blocked"/></c:when>
                                    <c:otherwise>${fn:escapeXml(pkg.packageStatus)}</c:otherwise>
                                </c:choose>
                            </span>
                            <c:if test="${not empty pkg.rejectReason}">
                                <div style="font-size:11px;color:#fca5a5;margin-top:6px;max-width:240px;">
                                    ${fn:escapeXml(pkg.rejectReason)}
                                </div>
                            </c:if>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${pkg.packageStatus eq 'PENDING'}">
                                    <div class="business-review-actions">
                                        <form method="post" action="${pageContext.request.contextPath}/admin/packages/${pkg.packageIdx}/approve">
                                            <button type="submit" class="adm-row-btn detail"
                                                    onclick="return confirm('<spring:message code="admin.packages.confirmApprove" javaScriptEscape="true"/>');"><spring:message code="admin.packages.status.approved"/></button>
                                        </form>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/packages/${pkg.packageIdx}/reject">
                                            <input class="adm-input" name="rejectReason" maxlength="500" placeholder="<spring:message code='admin.packages.rejectReasonPlaceholder'/>" required>
                                            <button type="submit" class="adm-row-btn danger"><spring:message code="admin.packages.status.rejected"/></button>
                                        </form>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#64748b;font-size:12px;"><spring:message code="admin.packages.reviewDone"/></span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty packageList}">
                    <tr>
                        <td colspan="6" style="text-align:center;padding:40px;color:#64748b;">
                            <spring:message code="admin.packages.noResults"/>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../layout-close.jsp" %>
