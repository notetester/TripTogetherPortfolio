<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="activeMenu" value="loginRiskAssessments"/>
<spring:message var="pageTitle" code="security.admin.externalAssessments.title"/>
<spring:message var="keywordPlaceholder" code="security.admin.placeholder.ipAccountSourceReason"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="security.admin.externalAssessments.title"/></h1>
            <p class="adm-page-desc"><spring:message code="security.admin.externalAssessments.desc"/></p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies"><spring:message code="security.admin.nav.policies"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/reviews"><spring:message code="security.admin.nav.reviews"/></a>
                    <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments"><spring:message code="security.admin.nav.securityAssessments"/></a>
        </div>
    </div>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(5,minmax(0,1fr));gap:10px;">
            <label><spring:message code="security.admin.common.sourceKind"/>
                <select class="adm-input" name="sourceKind">
                    <option value=""><spring:message code="security.admin.common.all"/></option>
                    <option value="AI_MODEL" ${sourceKind == 'AI_MODEL' ? 'selected' : ''}>AI_MODEL</option>
                    <option value="RULE_ALGORITHM" ${sourceKind == 'RULE_ALGORITHM' ? 'selected' : ''}>RULE_ALGORITHM</option>
                    <option value="POLICY_AUTHORITY" ${sourceKind == 'POLICY_AUTHORITY' ? 'selected' : ''}>POLICY_AUTHORITY</option>
                    <option value="ASSESSMENT_PIPELINE" ${sourceKind == 'ASSESSMENT_PIPELINE' ? 'selected' : ''}>ASSESSMENT_PIPELINE</option>
                </select>
            </label>
            <label><spring:message code="security.admin.common.riskLevel"/>
                <select class="adm-input" name="riskLevel">
                    <option value=""><spring:message code="security.admin.common.all"/></option>
                    <option value="CRITICAL" ${riskLevel == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                    <option value="HIGH" ${riskLevel == 'HIGH' ? 'selected' : ''}>HIGH</option>
                    <option value="MEDIUM" ${riskLevel == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                    <option value="LOW" ${riskLevel == 'LOW' ? 'selected' : ''}>LOW</option>
                    <option value="PENDING" ${riskLevel == 'PENDING' ? 'selected' : ''}>PENDING</option>
                </select>
            </label>
            <label><spring:message code="security.admin.common.decisionStatus"/>
                <select class="adm-input" name="decisionStatus">
                    <option value=""><spring:message code="security.admin.common.all"/></option>
                    <option value="PROPOSED" ${decisionStatus == 'PROPOSED' ? 'selected' : ''}>PROPOSED</option>
                    <option value="APPLIED" ${decisionStatus == 'APPLIED' ? 'selected' : ''}>APPLIED</option>
                    <option value="IGNORED" ${decisionStatus == 'IGNORED' ? 'selected' : ''}>IGNORED</option>
                    <option value="PENDING" ${decisionStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                </select>
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
                <th><spring:message code="security.admin.common.source"/></th>
                <th><spring:message code="security.admin.common.target"/></th>
                <th><spring:message code="security.admin.common.riskLevel"/></th>
                <th><spring:message code="security.admin.common.recommendationAction"/></th>
                <th><spring:message code="security.admin.common.evidence"/></th>
                <th><spring:message code="security.admin.common.status"/></th>
                <th><spring:message code="security.admin.common.createdAt"/></th>
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
                <tr><td colspan="7" class="adm-empty"><spring:message code="security.admin.empty.externalAssessments"/></td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
