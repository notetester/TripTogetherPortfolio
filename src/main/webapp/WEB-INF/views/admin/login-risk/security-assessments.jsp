<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="activeMenu" value="securityRiskAssessments"/>
<spring:message var="pageTitle" code="security.admin.securityAssessments.title"/>
<spring:message var="keywordPlaceholder" code="security.admin.placeholder.accountIpEvidenceSource"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="security.admin.nav.securityAssessments"/></h1>
            <p class="adm-page-desc"><spring:message code="security.admin.securityAssessments.desc"/></p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/assessments"><spring:message code="security.admin.nav.externalAssessmentsLong"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews"><spring:message code="security.admin.nav.securityReviews"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs"><spring:message code="security.admin.nav.providerConfigs"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/blocks"><spring:message code="security.admin.nav.blocks"/></a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(6,minmax(0,1fr));gap:10px;">
            <label><spring:message code="security.admin.common.scope"/>
                <select class="adm-input" name="assessmentScope">
                    <option value=""><spring:message code="security.admin.common.all"/></option>
                    <option value="LOGIN_RISK" ${assessmentScope == 'LOGIN_RISK' ? 'selected' : ''}>LOGIN_RISK</option>
                    <option value="USER_SECURITY" ${assessmentScope == 'USER_SECURITY' ? 'selected' : ''}>USER_SECURITY</option>
                    <option value="CONTENT_MODERATION" ${assessmentScope == 'CONTENT_MODERATION' ? 'selected' : ''}>CONTENT_MODERATION</option>
                    <option value="IP_REPUTATION" ${assessmentScope == 'IP_REPUTATION' ? 'selected' : ''}>IP_REPUTATION</option>
                </select>
            </label>
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
            <label><spring:message code="security.admin.common.status"/>
                <select class="adm-input" name="decisionStatus">
                    <option value=""><spring:message code="security.admin.common.all"/></option>
                    <option value="PROPOSED" ${decisionStatus == 'PROPOSED' ? 'selected' : ''}>PROPOSED</option>
                    <option value="APPLIED" ${decisionStatus == 'APPLIED' ? 'selected' : ''}>APPLIED</option>
                    <option value="IGNORED" ${decisionStatus == 'IGNORED' ? 'selected' : ''}>IGNORED</option>
                    <option value="PENDING" ${decisionStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                </select>
            </label>
            <label><spring:message code="security.admin.common.search"/>
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${keywordPlaceholder}">
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
                <th><spring:message code="security.admin.common.scopeSource"/></th>
                <th><spring:message code="security.admin.common.target"/></th>
                <th><spring:message code="security.admin.common.riskLevel"/></th>
                <th><spring:message code="security.admin.common.recommendationAction"/></th>
                <th><spring:message code="security.admin.common.evidence"/></th>
                <th><spring:message code="security.admin.common.status"/></th>
                <th><spring:message code="security.admin.common.createdAt"/></th>
                <th><spring:message code="security.admin.common.apply"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="a" items="${assessments}">
                <tr>
                    <td>
                        <strong><c:out value="${a.assessmentScope}"/></strong><br>
                        <small><c:out value="${a.sourceKind}"/></small><br>
                        <small><c:out value="${a.sourceName}"/></small>
                    </td>
                    <td>
                        <c:out value="${a.subjectType}"/>: <c:out value="${a.subjectKey}"/><br>
                        <c:if test="${not empty a.userId}"><small><c:out value="${a.userId}"/> / <c:out value="${a.nickname}"/></small><br></c:if>
                        <c:if test="${not empty a.ipAddress}"><small><spring:message code="security.admin.common.ip"/>: <c:out value="${a.ipAddress}"/></small></c:if>
                    </td>
                    <td>
                        <strong><c:out value="${fn:escapeXml(a.riskLevel)}"/></strong>
                        <c:if test="${not empty a.riskScore}"><br><small>score <c:out value="${a.riskScore}"/></small></c:if>
                        <c:if test="${not empty a.confidenceScore}"><br><small>confidence <c:out value="${a.confidenceScore}"/></small></c:if>
                    </td>
                    <td>
                        <strong><c:out value="${fn:escapeXml(a.recommendationAction)}"/></strong><br>
                        <small><c:out value="${a.recommendationReason}"/></small>
                    </td>
                    <td><c:out value="${fn:escapeXml(a.evidenceSummary)}"/></td>
                    <td><c:out value="${a.decisionStatus}"/></td>
                    <td><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <c:if test="${a.decisionStatus != 'APPLIED'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-assessments/${a.assessmentIdx}/create-review" style="display:inline;">
                                <input type="hidden" name="severity" value="${fn:escapeXml(a.riskLevel)}">
                                <input type="hidden" name="summary" value="${fn:escapeXml(a.recommendationAction)}">
                                <input type="hidden" name="detailMessage" value="${fn:escapeXml(a.evidenceSummary)}">
                                <button class="adm-btn" type="submit"><spring:message code="security.admin.common.enqueueReview"/></button>
                            </form>
                        </c:if>
                        <c:if test="${a.subjectType == 'USER' && a.decisionStatus != 'APPLIED'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-assessments/${a.assessmentIdx}/apply-user-block" style="display:inline;">
                                <button class="adm-btn danger" type="submit"><spring:message code="security.admin.common.applyUserBlock"/></button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty assessments}">
                <tr><td colspan="8" class="adm-empty"><spring:message code="security.admin.empty.securityAssessments"/></td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
