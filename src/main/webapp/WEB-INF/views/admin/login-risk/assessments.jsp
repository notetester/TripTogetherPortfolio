<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_externalAssessments_title" code="security.admin.externalAssessments.title"/>
<spring:message var="msg_security_admin_placeholder_ipAccountSourceReason" code="security.admin.placeholder.ipAccountSourceReason"/>
<spring:message var="msg_security_admin_externalAssessments_desc" code="security.admin.externalAssessments.desc"/>
<spring:message var="msg_security_admin_nav_policies" code="security.admin.nav.policies"/>
<spring:message var="msg_security_admin_nav_reviews" code="security.admin.nav.reviews"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_common_sourceKind" code="security.admin.common.sourceKind"/>
<spring:message var="msg_security_admin_common_all" code="security.admin.common.all"/>
<spring:message var="msg_security_admin_common_riskLevel" code="security.admin.common.riskLevel"/>
<spring:message var="msg_security_admin_common_decisionStatus" code="security.admin.common.decisionStatus"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_common_source" code="security.admin.common.source"/>
<spring:message var="msg_security_admin_common_target" code="security.admin.common.target"/>
<spring:message var="msg_security_admin_common_recommendationAction" code="security.admin.common.recommendationAction"/>
<spring:message var="msg_security_admin_common_evidence" code="security.admin.common.evidence"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_createdAt" code="security.admin.common.createdAt"/>
<spring:message var="msg_security_admin_empty_externalAssessments" code="security.admin.empty.externalAssessments"/>
<c:set var="pageTitle" value="${msg_security_admin_externalAssessments_title}"/>
<c:set var="activeMenu" value="loginRiskAssessments"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_externalAssessments_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_externalAssessments_desc}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies">${msg_security_admin_nav_policies}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/reviews">${msg_security_admin_nav_reviews}</a>
                    <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
        </div>
    </div>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(5,minmax(0,1fr));gap:10px;">
            <label>${msg_security_admin_common_sourceKind}
                <select class="adm-input" name="sourceKind">
                    <option value="">${msg_security_admin_common_all}</option>
                    <option value="AI_MODEL" ${sourceKind == 'AI_MODEL' ? 'selected' : ''}>AI_MODEL</option>
                    <option value="RULE_ALGORITHM" ${sourceKind == 'RULE_ALGORITHM' ? 'selected' : ''}>RULE_ALGORITHM</option>
                    <option value="POLICY_AUTHORITY" ${sourceKind == 'POLICY_AUTHORITY' ? 'selected' : ''}>POLICY_AUTHORITY</option>
                    <option value="ASSESSMENT_PIPELINE" ${sourceKind == 'ASSESSMENT_PIPELINE' ? 'selected' : ''}>ASSESSMENT_PIPELINE</option>
                </select>
            </label>
            <label>${msg_security_admin_common_riskLevel}
                <select class="adm-input" name="riskLevel">
                    <option value="">${msg_security_admin_common_all}</option>
                    <option value="CRITICAL" ${riskLevel == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                    <option value="HIGH" ${riskLevel == 'HIGH' ? 'selected' : ''}>HIGH</option>
                    <option value="MEDIUM" ${riskLevel == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                    <option value="LOW" ${riskLevel == 'LOW' ? 'selected' : ''}>LOW</option>
                    <option value="PENDING" ${riskLevel == 'PENDING' ? 'selected' : ''}>PENDING</option>
                </select>
            </label>
            <label>${msg_security_admin_common_decisionStatus}
                <select class="adm-input" name="decisionStatus">
                    <option value="">${msg_security_admin_common_all}</option>
                    <option value="PROPOSED" ${decisionStatus == 'PROPOSED' ? 'selected' : ''}>PROPOSED</option>
                    <option value="APPLIED" ${decisionStatus == 'APPLIED' ? 'selected' : ''}>APPLIED</option>
                    <option value="IGNORED" ${decisionStatus == 'IGNORED' ? 'selected' : ''}>IGNORED</option>
                    <option value="PENDING" ${decisionStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                </select>
            </label>
            <label>${msg_security_admin_common_search}
                <input class="adm-input" type="text" name="keyword" value="${keyword}" placeholder="${msg_security_admin_placeholder_ipAccountSourceReason}">
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
                <th>${msg_security_admin_common_source}</th>
                <th>${msg_security_admin_common_target}</th>
                <th>${msg_security_admin_common_riskLevel}</th>
                <th>${msg_security_admin_common_recommendationAction}</th>
                <th>${msg_security_admin_common_evidence}</th>
                <th>${msg_security_admin_common_status}</th>
                <th>${msg_security_admin_common_createdAt}</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="a" items="${assessments}">
                <tr>
                    <td>
                        <strong>${a.sourceKind}</strong><br>
                        <small>${a.sourceName}</small><br>
                        <small>${a.sourceCode} ${a.sourceVersion}</small>
                    </td>
                    <td>
                        ${a.subjectType}: ${a.subjectKey}<br>
                        <c:if test="${not empty a.userId}"><small>${a.userId} / ${a.nickname}</small><br></c:if>
                        <c:if test="${not empty a.ipAddress}"><small>IP: ${a.ipAddress}</small></c:if>
                    </td>
                    <td>
                        <strong>${a.riskLevel}</strong>
                        <c:if test="${not empty a.riskScore}"><br><small>score ${a.riskScore}</small></c:if>
                        <c:if test="${not empty a.confidenceScore}"><br><small>confidence ${a.confidenceScore}</small></c:if>
                    </td>
                    <td>
                        <strong>${a.recommendationAction}</strong><br>
                        <small>${a.recommendationReason}</small>
                    </td>
                    <td>${a.evidenceSummary}</td>
                    <td>${a.decisionStatus}</td>
                    <td><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                </tr>
            </c:forEach>
            <c:if test="${empty assessments}">
                <tr><td colspan="7" class="adm-empty">${msg_security_admin_empty_externalAssessments}</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
