<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="activeMenu" value="loginRiskReviews"/>
<spring:message var="pageTitle" code="security.admin.loginReviews.title"/>
<spring:message var="keywordPlaceholder" code="security.admin.placeholder.accountIpSummary"/>
<spring:message var="reviewApproveComment" code="security.admin.comment.approved"/>
<spring:message var="reviewHoldComment" code="security.admin.comment.needMoreCheck"/>
<spring:message var="reviewRejectComment" code="security.admin.comment.notBlocked"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="security.admin.loginReviews.title"/></h1>
            <p class="adm-page-desc"><spring:message code="security.admin.loginReviews.desc"/></p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies"><spring:message code="security.admin.nav.policies"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/assessments"><spring:message code="security.admin.nav.externalAssessments"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences"><spring:message code="security.admin.nav.notifications"/></a>
                    <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments"><spring:message code="security.admin.nav.securityAssessments"/></a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success">${message}</div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(5,minmax(0,1fr));gap:10px;">
            <label><spring:message code="security.admin.common.status"/>
                <select class="adm-input" name="status">
                    <option value=""><spring:message code="security.admin.common.all"/></option>
                    <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                    <option value="APPROVED" ${status == 'APPROVED' ? 'selected' : ''}>APPROVED</option>
                    <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                </select>
            </label>
            <label><spring:message code="security.admin.common.severity"/>
                <select class="adm-input" name="severity">
                    <option value=""><spring:message code="security.admin.common.all"/></option>
                    <option value="CRITICAL" ${severity == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                    <option value="HIGH" ${severity == 'HIGH' ? 'selected' : ''}>HIGH</option>
                    <option value="MEDIUM" ${severity == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                    <option value="LOW" ${severity == 'LOW' ? 'selected' : ''}>LOW</option>
                </select>
            </label>
            <label><spring:message code="security.admin.common.type"/>
                <input class="adm-input" type="text" name="reviewType" value="${reviewType}" placeholder="IP_LOGIN_RISK">
            </label>
            <label><spring:message code="security.admin.common.search"/>
                <input class="adm-input" type="text" name="keyword" value="${keyword}" placeholder="${keywordPlaceholder}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit"><spring:message code="security.admin.common.search"/></button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th><spring:message code="security.admin.common.status"/></th>
                <th><spring:message code="security.admin.common.severity"/></th>
                <th><spring:message code="security.admin.common.reviewType"/></th>
                <th><spring:message code="security.admin.common.target"/></th>
                <th><spring:message code="security.admin.common.summary"/></th>
                <th><spring:message code="security.admin.common.createdAt"/></th>
                <th><spring:message code="security.admin.common.action"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="r" items="${reviews}">
                <tr>
                    <td><span class="adm-badge">${r.reviewStatus}</span></td>
                    <td>${r.severity}</td>
                    <td>${r.reviewType}<br><small>${r.policyCode}</small></td>
                    <td>
                        ${r.subjectType}: ${r.subjectKey}<br>
                        <c:if test="${not empty r.userId}"><small>${r.userId} / ${r.nickname}</small></c:if>
                    </td>
                    <td>
                        <strong>${r.summary}</strong><br>
                        <small>${r.detailMessage}</small>
                        <c:if test="${not empty r.reviewComment}">
                            <br><small><spring:message code="security.admin.common.reviewComment"/>: ${r.reviewComment}</small>
                        </c:if>
                    </td>
                    <td><fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:if test="${r.reviewStatus == 'PENDING' || r.reviewStatus == 'HOLD'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/approve" style="display:inline;">
                                <input type="hidden" name="comment" value="${reviewApproveComment}">
                                <button class="adm-btn primary" type="submit"><spring:message code="security.admin.common.approve"/></button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/hold" style="display:inline;">
                                <input type="hidden" name="comment" value="${reviewHoldComment}">
                                <button class="adm-btn" type="submit"><spring:message code="security.admin.common.hold"/></button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/reject" style="display:inline;">
                                <input type="hidden" name="comment" value="${reviewRejectComment}">
                                <button class="adm-btn danger" type="submit"><spring:message code="security.admin.common.reject"/></button>
                            </form>
                        </c:if>
                        <c:if test="${r.reviewStatus != 'PENDING' && r.reviewStatus != 'HOLD'}">
                            <small>${r.reviewedByUserId} / <fmt:formatDate value="${r.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></small>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty reviews}">
                <tr><td colspan="7" class="adm-empty"><spring:message code="security.admin.empty.reviews"/></td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
