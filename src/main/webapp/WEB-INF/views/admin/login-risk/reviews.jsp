<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_loginReviews_title" code="security.admin.loginReviews.title"/>
<spring:message var="msg_security_admin_placeholder_accountIpSummary" code="security.admin.placeholder.accountIpSummary"/>
<spring:message var="msg_security_admin_comment_approved" code="security.admin.comment.approved"/>
<spring:message var="msg_security_admin_comment_needMoreCheck" code="security.admin.comment.needMoreCheck"/>
<spring:message var="msg_security_admin_comment_notBlocked" code="security.admin.comment.notBlocked"/>
<spring:message var="msg_security_admin_loginReviews_desc" code="security.admin.loginReviews.desc"/>
<spring:message var="msg_security_admin_nav_policies" code="security.admin.nav.policies"/>
<spring:message var="msg_security_admin_nav_externalAssessments" code="security.admin.nav.externalAssessments"/>
<spring:message var="msg_security_admin_nav_notifications" code="security.admin.nav.notifications"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_all" code="security.admin.common.all"/>
<spring:message var="msg_security_admin_common_severity" code="security.admin.common.severity"/>
<spring:message var="msg_security_admin_common_type" code="security.admin.common.type"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_common_reviewType" code="security.admin.common.reviewType"/>
<spring:message var="msg_security_admin_common_target" code="security.admin.common.target"/>
<spring:message var="msg_security_admin_common_summary" code="security.admin.common.summary"/>
<spring:message var="msg_security_admin_common_createdAt" code="security.admin.common.createdAt"/>
<spring:message var="msg_security_admin_common_action" code="security.admin.common.action"/>
<spring:message var="msg_security_admin_common_reviewComment" code="security.admin.common.reviewComment"/>
<spring:message var="msg_security_admin_common_approve" code="security.admin.common.approve"/>
<spring:message var="msg_security_admin_common_hold" code="security.admin.common.hold"/>
<spring:message var="msg_security_admin_common_reject" code="security.admin.common.reject"/>
<spring:message var="msg_security_admin_empty_reviews" code="security.admin.empty.reviews"/>
<c:set var="pageTitle" value="${msg_security_admin_loginReviews_title}"/>
<c:set var="activeMenu" value="loginRiskReviews"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_loginReviews_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_loginReviews_desc}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies">${msg_security_admin_nav_policies}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/assessments">${msg_security_admin_nav_externalAssessments}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences">${msg_security_admin_nav_notifications}</a>
                    <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success">${message}</div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(5,minmax(0,1fr));gap:10px;">
            <label>${msg_security_admin_common_status}
                <select class="adm-input" name="status">
                    <option value="">${msg_security_admin_common_all}</option>
                    <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                    <option value="APPROVED" ${status == 'APPROVED' ? 'selected' : ''}>APPROVED</option>
                    <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                </select>
            </label>
            <label>${msg_security_admin_common_severity}
                <select class="adm-input" name="severity">
                    <option value="">${msg_security_admin_common_all}</option>
                    <option value="CRITICAL" ${severity == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                    <option value="HIGH" ${severity == 'HIGH' ? 'selected' : ''}>HIGH</option>
                    <option value="MEDIUM" ${severity == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                    <option value="LOW" ${severity == 'LOW' ? 'selected' : ''}>LOW</option>
                </select>
            </label>
            <label>${msg_security_admin_common_type}
                <input class="adm-input" type="text" name="reviewType" value="${reviewType}" placeholder="IP_LOGIN_RISK">
            </label>
            <label>${msg_security_admin_common_search}
                <input class="adm-input" type="text" name="keyword" value="${keyword}" placeholder="${msg_security_admin_placeholder_accountIpSummary}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit">${msg_security_admin_common_search}</button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th>${msg_security_admin_common_status}</th>
                <th>${msg_security_admin_common_severity}</th>
                <th>${msg_security_admin_common_reviewType}</th>
                <th>${msg_security_admin_common_target}</th>
                <th>${msg_security_admin_common_summary}</th>
                <th>${msg_security_admin_common_createdAt}</th>
                <th>${msg_security_admin_common_action}</th>
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
                            <br><small>${msg_security_admin_common_reviewComment}: ${r.reviewComment}</small>
                        </c:if>
                    </td>
                    <td><fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:if test="${r.reviewStatus == 'PENDING' || r.reviewStatus == 'HOLD'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/approve" style="display:inline;">
                                <input type="hidden" name="comment" value="${msg_security_admin_comment_approved}">
                                <button class="adm-btn primary" type="submit">${msg_security_admin_common_approve}</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/hold" style="display:inline;">
                                <input type="hidden" name="comment" value="${msg_security_admin_comment_needMoreCheck}">
                                <button class="adm-btn" type="submit">${msg_security_admin_common_hold}</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/reject" style="display:inline;">
                                <input type="hidden" name="comment" value="${msg_security_admin_comment_notBlocked}">
                                <button class="adm-btn danger" type="submit">${msg_security_admin_common_reject}</button>
                            </form>
                        </c:if>
                        <c:if test="${r.reviewStatus != 'PENDING' && r.reviewStatus != 'HOLD'}">
                            <small>${r.reviewedByUserId} / <fmt:formatDate value="${r.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></small>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty reviews}">
                <tr><td colspan="7" class="adm-empty">${msg_security_admin_empty_reviews}</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
