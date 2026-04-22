<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="businessApplications"/>
<spring:message code="admin.business.pageTitle" var="adminBusinessPageTitle"/>
<c:set var="pageTitle"  value="${adminBusinessPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="admin.business.pageTitle"/></h1>
            <p><spring:message code="admin.business.pageSubtitle"/></p>
        </div>
    </div>

    <c:if test="${not empty businessApplicationMessage}">
        <div class="adm-alert adm-alert-success">${fn:escapeXml(businessApplicationMessage)}</div>
    </c:if>
    <c:if test="${not empty businessApplicationError}">
        <div class="adm-alert adm-alert-danger">${fn:escapeXml(businessApplicationError)}</div>
    </c:if>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/business-applications">
                <div class="adm-filter-bar">
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.business.filter.status"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${status eq 'ALL' ? 'selected' : ''}><spring:message code="admin.common.all"/></option>
                            <option value="PENDING" ${status eq 'PENDING' ? 'selected' : ''}><spring:message code="admin.business.status.pending"/></option>
                            <option value="APPROVED" ${status eq 'APPROVED' ? 'selected' : ''}><spring:message code="admin.business.status.approved"/></option>
                            <option value="REJECTED" ${status eq 'REJECTED' ? 'selected' : ''}><spring:message code="admin.business.status.rejected"/></option>
                        </select>
                    </div>
                    <div style="display:flex;gap:6px;align-items:flex-end;">
                        <button type="submit" class="adm-btn adm-btn-primary"><spring:message code="admin.common.searchButton"/></button>
                        <a href="${pageContext.request.contextPath}/admin/business-applications"
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
                    <th><spring:message code="admin.business.column.applicant"/></th>
                    <th><spring:message code="admin.business.column.requestedRole"/></th>
                    <th><spring:message code="admin.business.column.companyInfo"/></th>
                    <th><spring:message code="admin.common.status"/></th>
                    <th><spring:message code="admin.business.column.appliedAt"/></th>
                    <th><spring:message code="admin.business.column.review"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="app" items="${applicationList}">
                    <tr>
                        <td>
                            <div class="mem-name">${fn:escapeXml(app.nickname)}</div>
                            <div class="mem-uid">
                                <c:choose>
                                    <c:when test="${not empty app.userId}">@${fn:escapeXml(app.userId)}</c:when>
                                    <c:otherwise><spring:message code="admin.business.socialOnly"/></c:otherwise>
                                </c:choose>
                            </div>
                            <div style="font-size:11px;color:#64748b;margin-top:2px;"><spring:message code="admin.business.currentRole" arguments="${fn:escapeXml(app.currentUserRole)}"/></div>
                        </td>
                        <td>
                            <span class="role-badge ${app.requestedRole}">
                                <c:choose>
                                    <c:when test="${app.requestedRole eq 'BUSINESS'}"><spring:message code="admin.business.role.business"/></c:when>
                                    <c:when test="${app.requestedRole eq 'PARTNER'}"><spring:message code="admin.business.role.partner"/></c:when>
                                    <c:otherwise>${fn:escapeXml(app.requestedRole)}</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <div style="font-weight:700;color:#e2e8f0;">${fn:escapeXml(app.companyName)}</div>
                            <div style="font-size:12px;color:#94a3b8;margin-top:3px;">
                                <spring:message code="admin.business.businessNumber"/>
                                <c:choose>
                                    <c:when test="${not empty app.businessNumber}">${fn:escapeXml(app.businessNumber)}</c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </div>
                            <div style="font-size:12px;color:#94a3b8;">
                                <spring:message code="admin.business.managerInfo" arguments="${fn:escapeXml(app.managerName)},${fn:escapeXml(app.managerPhone)}"/>
                            </div>
                            <c:if test="${not empty app.description}">
                                <div style="font-size:12px;color:#cbd5e1;margin-top:6px;max-width:420px;white-space:pre-wrap;">${fn:escapeXml(app.description)}</div>
                            </c:if>
                        </td>
                        <td>
                            <span class="status-badge ${app.applicationStatus}">
                                <c:choose>
                                    <c:when test="${app.applicationStatus eq 'PENDING'}"><spring:message code="admin.business.status.pending"/></c:when>
                                    <c:when test="${app.applicationStatus eq 'APPROVED'}"><spring:message code="admin.business.status.approved"/></c:when>
                                    <c:when test="${app.applicationStatus eq 'REJECTED'}"><spring:message code="admin.business.status.rejected"/></c:when>
                                    <c:otherwise>${fn:escapeXml(app.applicationStatus)}</c:otherwise>
                                </c:choose>
                            </span>
                            <c:if test="${not empty app.rejectReason}">
                                <div style="font-size:11px;color:#fca5a5;margin-top:6px;">${fn:escapeXml(app.rejectReason)}</div>
                            </c:if>
                            <c:if test="${not empty app.reviewerNickname}">
                                <div style="font-size:11px;color:#94a3b8;margin-top:4px;"><spring:message code="admin.business.reviewer" arguments="${fn:escapeXml(app.reviewerNickname)}"/></div>
                            </c:if>
                        </td>
                        <td>
                            <fmt:formatDate value="${app.createdAtDate}" type="both" dateStyle="short" timeStyle="short"/>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${app.applicationStatus eq 'PENDING'}">
                                    <div class="business-review-actions">
                                        <form method="post" action="${pageContext.request.contextPath}/admin/business-applications/${app.applicationIdx}/approve">
                                            <button type="submit" class="adm-row-btn detail"
                                                    onclick="return confirm('<spring:message code="admin.business.confirmApprove" javaScriptEscape="true"/>')"><spring:message code="admin.business.status.approved"/></button>
                                        </form>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/business-applications/${app.applicationIdx}/reject">
                                            <input class="adm-input" name="rejectReason" maxlength="500" placeholder="<spring:message code='admin.business.rejectReasonPlaceholder'/>" required>
                                            <button type="submit" class="adm-row-btn danger"><spring:message code="admin.business.status.rejected"/></button>
                                        </form>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#64748b;font-size:12px;"><spring:message code="admin.business.reviewDone"/></span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty applicationList}">
                    <tr>
                        <td colspan="6" style="text-align:center;padding:40px;color:#64748b;">
                            <spring:message code="admin.business.noResults"/>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../layout-close.jsp" %>
