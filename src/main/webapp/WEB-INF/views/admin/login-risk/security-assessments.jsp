<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<spring:message var="autoMsg_822043e5e2" code="security.admin.nav.securityAssessments"/>
<spring:message var="autoMsg_fd9ce2c461" code="security.admin.securityAssessments.desc"/>
<spring:message var="autoMsg_8f1772a609" code="security.admin.nav.externalAssessmentsLong"/>
<spring:message var="autoMsg_3536c24f20" code="security.admin.nav.securityReviews"/>
<spring:message var="autoMsg_4d4bbbc48f" code="security.admin.nav.providerConfigs"/>
<spring:message var="autoMsg_d7f4de913d" code="security.admin.nav.blocks"/>
<spring:message var="autoMsg_aeeecf7269" code="security.admin.common.scope"/>
<spring:message var="autoMsg_374a299e77" code="security.admin.common.all"/>
<spring:message var="autoMsg_c5fdc44c6f" code="security.admin.common.sourceKind"/>
<spring:message var="autoMsg_6f5236b343" code="security.admin.common.riskLevel"/>
<spring:message var="autoMsg_b7ec5db69f" code="security.admin.common.status"/>
<spring:message var="autoMsg_385d205cd8" code="security.admin.common.search"/>
<spring:message var="autoMsg_687461049f" code="security.admin.common.scopeSource"/>
<spring:message var="autoMsg_959698d730" code="security.admin.common.target"/>
<spring:message var="autoMsg_d89852520c" code="security.admin.common.recommendationAction"/>
<spring:message var="autoMsg_52943e8209" code="security.admin.common.evidence"/>
<spring:message var="autoMsg_6100f3d38a" code="security.admin.common.createdAt"/>
<spring:message var="autoMsg_09d1c77bd5" code="security.admin.common.apply"/>
<spring:message var="autoMsg_bed8a531cb" code="security.admin.common.ip"/>
<spring:message var="autoMsg_d3eff41c91" code="security.admin.common.enqueueReview"/>
<spring:message var="autoMsg_3a02d7bdaf" code="security.admin.common.applyUserBlock"/>
<spring:message var="autoMsg_25fa9d8e2f" code="security.admin.empty.securityAssessments"/>
<c:set var="activeMenu" value="securityRiskAssessments"/>
<spring:message var="pageTitle" code="security.admin.securityAssessments.title"/>
<spring:message var="keywordPlaceholder" code="security.admin.placeholder.accountIpEvidenceSource"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${autoMsg_822043e5e2}</h1>
            <p class="adm-page-desc">${autoMsg_fd9ce2c461}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/assessments">${autoMsg_8f1772a609}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews">${autoMsg_3536c24f20}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">${autoMsg_4d4bbbc48f}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/blocks">${autoMsg_d7f4de913d}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(6,minmax(0,1fr));gap:10px;">
            <label>${autoMsg_aeeecf7269}
                <select class="adm-input" name="assessmentScope">
                    <option value="">${autoMsg_374a299e77}</option>
                    <option value="LOGIN_RISK" ${assessmentScope == 'LOGIN_RISK' ? 'selected' : ''}>LOGIN_RISK</option>
                    <option value="USER_SECURITY" ${assessmentScope == 'USER_SECURITY' ? 'selected' : ''}>USER_SECURITY</option>
                    <option value="CONTENT_MODERATION" ${assessmentScope == 'CONTENT_MODERATION' ? 'selected' : ''}>CONTENT_MODERATION</option>
                    <option value="IP_REPUTATION" ${assessmentScope == 'IP_REPUTATION' ? 'selected' : ''}>IP_REPUTATION</option>
                </select>
            </label>
            <label>${autoMsg_c5fdc44c6f}
                <select class="adm-input" name="sourceKind">
                    <option value="">${autoMsg_374a299e77}</option>
                    <option value="AI_MODEL" ${sourceKind == 'AI_MODEL' ? 'selected' : ''}>AI_MODEL</option>
                    <option value="RULE_ALGORITHM" ${sourceKind == 'RULE_ALGORITHM' ? 'selected' : ''}>RULE_ALGORITHM</option>
                    <option value="POLICY_AUTHORITY" ${sourceKind == 'POLICY_AUTHORITY' ? 'selected' : ''}>POLICY_AUTHORITY</option>
                    <option value="ASSESSMENT_PIPELINE" ${sourceKind == 'ASSESSMENT_PIPELINE' ? 'selected' : ''}>ASSESSMENT_PIPELINE</option>
                </select>
            </label>
            <label>${autoMsg_6f5236b343}
                <select class="adm-input" name="riskLevel">
                    <option value="">${autoMsg_374a299e77}</option>
                    <option value="CRITICAL" ${riskLevel == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                    <option value="HIGH" ${riskLevel == 'HIGH' ? 'selected' : ''}>HIGH</option>
                    <option value="MEDIUM" ${riskLevel == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                    <option value="LOW" ${riskLevel == 'LOW' ? 'selected' : ''}>LOW</option>
                    <option value="PENDING" ${riskLevel == 'PENDING' ? 'selected' : ''}>PENDING</option>
                </select>
            </label>
            <label>${autoMsg_b7ec5db69f}
                <select class="adm-input" name="decisionStatus">
                    <option value="">${autoMsg_374a299e77}</option>
                    <option value="PROPOSED" ${decisionStatus == 'PROPOSED' ? 'selected' : ''}>PROPOSED</option>
                    <option value="APPLIED" ${decisionStatus == 'APPLIED' ? 'selected' : ''}>APPLIED</option>
                    <option value="IGNORED" ${decisionStatus == 'IGNORED' ? 'selected' : ''}>IGNORED</option>
                    <option value="PENDING" ${decisionStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                </select>
            </label>
            <label>${autoMsg_385d205cd8}
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${keywordPlaceholder}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit">${autoMsg_385d205cd8}</button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th>${autoMsg_687461049f}</th>
                <th>${autoMsg_959698d730}</th>
                <th>${autoMsg_6f5236b343}</th>
                <th>${autoMsg_d89852520c}</th>
                <th>${autoMsg_52943e8209}</th>
                <th>${autoMsg_b7ec5db69f}</th>
                <th>${autoMsg_6100f3d38a}</th>
                <th>${autoMsg_09d1c77bd5}</th>
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
                        <c:if test="${not empty a.ipAddress}"><small>${autoMsg_bed8a531cb}: <c:out value="${a.ipAddress}"/></small></c:if>
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
                                <button class="adm-btn" type="submit">${autoMsg_d3eff41c91}</button>
                            </form>
                        </c:if>
                        <c:if test="${a.subjectType == 'USER' && a.decisionStatus != 'APPLIED'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-assessments/${a.assessmentIdx}/apply-user-block" style="display:inline;">
                                <button class="adm-btn danger" type="submit">${autoMsg_3a02d7bdaf}</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty assessments}">
                <tr><td colspan="8" class="adm-empty">${autoMsg_25fa9d8e2f}</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
