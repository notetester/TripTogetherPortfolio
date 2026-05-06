<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_06a5a99425" code="security.admin.loginReviews.title"/>
<spring:message var="autoMsg_1e5d023b92" code="security.admin.loginReviews.desc"/>
<spring:message var="autoMsg_2e62ede267" code="security.admin.nav.policies"/>
<spring:message var="autoMsg_b3507801e6" code="security.admin.nav.externalAssessments"/>
<spring:message var="autoMsg_aecfbe7601" code="security.admin.nav.notifications"/>
<spring:message var="autoMsg_abfde9033d" code="security.admin.nav.securityAssessments"/>
<spring:message var="autoMsg_79e8a04f86" code="security.admin.common.status"/>
<spring:message var="autoMsg_37867a1641" code="security.admin.common.all"/>
<spring:message var="autoMsg_10b55e207f" code="security.admin.common.severity"/>
<spring:message var="autoMsg_48ad995a78" code="security.admin.common.type"/>
<spring:message var="autoMsg_f4d3ecc316" code="security.admin.common.search"/>
<spring:message var="autoMsg_3d638ff4c6" code="security.admin.common.reviewType"/>
<spring:message var="autoMsg_8dc90ee3c8" code="security.admin.common.target"/>
<spring:message var="autoMsg_49220f890f" code="security.admin.common.summary"/>
<spring:message var="autoMsg_565303e110" code="security.admin.common.createdAt"/>
<spring:message var="autoMsg_e2f9d90384" code="security.admin.common.action"/>
<spring:message var="autoMsg_fb9b8ec268" code="security.admin.common.reviewComment"/>
<spring:message var="autoMsg_f8ef69a475" code="security.admin.common.approve"/>
<spring:message var="autoMsg_854021b78b" code="security.admin.common.hold"/>
<spring:message var="autoMsg_2a54b237bb" code="security.admin.common.reject"/>
<spring:message var="autoMsg_dd33914e92" code="security.admin.empty.reviews"/>
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
            <h1>${autoMsg_06a5a99425}</h1>
            <p class="adm-page-desc">${autoMsg_1e5d023b92}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies">${autoMsg_2e62ede267}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/assessments">${autoMsg_b3507801e6}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences">${autoMsg_aecfbe7601}</a>
                    <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${autoMsg_abfde9033d}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success">${message}</div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(5,minmax(0,1fr));gap:10px;">
            <label>${autoMsg_79e8a04f86}
                <select class="adm-input" name="status">
                    <option value="">${autoMsg_37867a1641}</option>
                    <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                    <option value="APPROVED" ${status == 'APPROVED' ? 'selected' : ''}>APPROVED</option>
                    <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                </select>
            </label>
            <label>${autoMsg_10b55e207f}
                <select class="adm-input" name="severity">
                    <option value="">${autoMsg_37867a1641}</option>
                    <option value="CRITICAL" ${severity == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                    <option value="HIGH" ${severity == 'HIGH' ? 'selected' : ''}>HIGH</option>
                    <option value="MEDIUM" ${severity == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                    <option value="LOW" ${severity == 'LOW' ? 'selected' : ''}>LOW</option>
                </select>
            </label>
            <label>${autoMsg_48ad995a78}
                <input class="adm-input" type="text" name="reviewType" value="${reviewType}" placeholder="IP_LOGIN_RISK">
            </label>
            <label>${autoMsg_f4d3ecc316}
                <input class="adm-input" type="text" name="keyword" value="${keyword}" placeholder="${keywordPlaceholder}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit">${autoMsg_f4d3ecc316}</button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th>${autoMsg_79e8a04f86}</th>
                <th>${autoMsg_10b55e207f}</th>
                <th>${autoMsg_3d638ff4c6}</th>
                <th>${autoMsg_8dc90ee3c8}</th>
                <th>${autoMsg_49220f890f}</th>
                <th>${autoMsg_565303e110}</th>
                <th>${autoMsg_e2f9d90384}</th>
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
                            <br><small>${autoMsg_fb9b8ec268}: ${r.reviewComment}</small>
                        </c:if>
                    </td>
                    <td><fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:if test="${r.reviewStatus == 'PENDING' || r.reviewStatus == 'HOLD'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/approve" style="display:inline;">
                                <input type="hidden" name="comment" value="${reviewApproveComment}">
                                <button class="adm-btn primary" type="submit">${autoMsg_f8ef69a475}</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/hold" style="display:inline;">
                                <input type="hidden" name="comment" value="${reviewHoldComment}">
                                <button class="adm-btn" type="submit">${autoMsg_854021b78b}</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/reject" style="display:inline;">
                                <input type="hidden" name="comment" value="${reviewRejectComment}">
                                <button class="adm-btn danger" type="submit">${autoMsg_2a54b237bb}</button>
                            </form>
                        </c:if>
                        <c:if test="${r.reviewStatus != 'PENDING' && r.reviewStatus != 'HOLD'}">
                            <small>${r.reviewedByUserId} / <fmt:formatDate value="${r.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></small>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty reviews}">
                <tr><td colspan="7" class="adm-empty">${autoMsg_dd33914e92}</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
