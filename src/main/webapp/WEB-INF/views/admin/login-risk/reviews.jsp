<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


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
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount" arguments="${fn:length(reviews)}"/>
<c:set var="pageTitle" value="${msg_security_admin_loginReviews_title}"/>
<c:set var="activeMenu" value="loginRiskReviews"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page">
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
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card adm-login-review-filter-card">
        <div class="adm-card-body">
            <div class="adm-login-review-filterbar">
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
                    <input class="adm-input" type="text" name="reviewType" value="${fn:escapeXml(reviewType)}" placeholder="IP_LOGIN_RISK">
                </label>
                <label class="adm-login-review-keyword-field">${msg_security_admin_common_search}
                    <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_accountIpSummary}">
                </label>
                <div class="adm-login-review-filter-actions">
                    <button class="adm-btn primary" type="submit">${msg_security_admin_common_search}</button>
                    <a class="adm-btn ghost" href="${pageContext.request.contextPath}/admin/login-risk/reviews">${msg_admin_common_reset}</a>
                </div>
            </div>
        </div>
    </form>

    <div class="adm-card adm-login-review-list-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_security_admin_loginReviews_title}</div>
            <div class="adm-page-muted">${msg_admin_common_totalCount}</div>
        </div>
        <div class="adm-table-wrap">
            <table id="loginRiskReviewTable"
                   class="adm-table adm-section-table-fixed adm-login-review-table"
                   data-section="loginRiskReviews">
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
                        <td><span class="adm-badge"><c:out value="${r.reviewStatus}"/></span></td>
                        <td><c:out value="${r.severity}"/></td>
                        <td>
                            <div class="adm-login-review-type"><c:out value="${r.reviewType}"/></div>
                            <div class="adm-page-muted"><c:out value="${r.policyCode}"/></div>
                        </td>
                        <td>
                            <div><c:out value="${r.subjectType}"/>: <c:out value="${r.subjectKey}"/></div>
                            <c:if test="${not empty r.userId}"><div class="adm-page-muted"><c:out value="${r.userId}"/> / <c:out value="${r.nickname}"/></div></c:if>
                        </td>
                        <td>
                            <div class="adm-login-review-summary">
                                <strong><c:out value="${r.summary}"/></strong>
                                <span><c:out value="${r.detailMessage}"/></span>
                                <c:if test="${not empty r.reviewComment}">
                                    <span>${msg_security_admin_common_reviewComment}: <c:out value="${r.reviewComment}"/></span>
                                </c:if>
                            </div>
                        </td>
                        <td><fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <c:if test="${r.reviewStatus == 'PENDING' || r.reviewStatus == 'HOLD'}">
                                <div class="adm-login-review-row-actions">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/approve">
                                        <input type="hidden" name="comment" value="${msg_security_admin_comment_approved}">
                                        <button class="adm-btn primary" type="submit">${msg_security_admin_common_approve}</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/hold">
                                        <input type="hidden" name="comment" value="${msg_security_admin_comment_needMoreCheck}">
                                        <button class="adm-btn" type="submit">${msg_security_admin_common_hold}</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/reject">
                                        <input type="hidden" name="comment" value="${msg_security_admin_comment_notBlocked}">
                                        <button class="adm-btn danger" type="submit">${msg_security_admin_common_reject}</button>
                                    </form>
                                </div>
                            </c:if>
                            <c:if test="${r.reviewStatus != 'PENDING' && r.reviewStatus != 'HOLD'}">
                                <div class="adm-page-muted"><c:out value="${r.reviewedByUserId}"/> / <fmt:formatDate value="${r.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
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
</div>
