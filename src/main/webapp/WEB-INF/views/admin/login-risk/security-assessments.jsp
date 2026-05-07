<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_securityAssessments_title" code="security.admin.securityAssessments.title"/>
<spring:message var="msg_security_admin_placeholder_accountIpEvidenceSource" code="security.admin.placeholder.accountIpEvidenceSource"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_securityAssessments_desc" code="security.admin.securityAssessments.desc"/>
<spring:message var="msg_security_admin_nav_externalAssessmentsLong" code="security.admin.nav.externalAssessmentsLong"/>
<spring:message var="msg_security_admin_nav_securityReviews" code="security.admin.nav.securityReviews"/>
<spring:message var="msg_security_admin_nav_providerConfigs" code="security.admin.nav.providerConfigs"/>
<spring:message var="msg_security_admin_nav_blocks" code="security.admin.nav.blocks"/>
<spring:message var="msg_security_admin_common_scope" code="security.admin.common.scope"/>
<spring:message var="msg_security_admin_common_all" code="security.admin.common.all"/>
<spring:message var="msg_security_admin_common_sourceKind" code="security.admin.common.sourceKind"/>
<spring:message var="msg_security_admin_common_riskLevel" code="security.admin.common.riskLevel"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_common_scopeSource" code="security.admin.common.scopeSource"/>
<spring:message var="msg_security_admin_common_target" code="security.admin.common.target"/>
<spring:message var="msg_security_admin_common_recommendationAction" code="security.admin.common.recommendationAction"/>
<spring:message var="msg_security_admin_common_evidence" code="security.admin.common.evidence"/>
<spring:message var="msg_security_admin_common_createdAt" code="security.admin.common.createdAt"/>
<spring:message var="msg_security_admin_common_apply" code="security.admin.common.apply"/>
<spring:message var="msg_security_admin_common_ip" code="security.admin.common.ip"/>
<spring:message var="msg_security_admin_common_enqueueReview" code="security.admin.common.enqueueReview"/>
<spring:message var="msg_security_admin_common_applyUserBlock" code="security.admin.common.applyUserBlock"/>
<spring:message var="msg_security_admin_empty_securityAssessments" code="security.admin.empty.securityAssessments"/>
<c:set var="pageTitle" value="${msg_security_admin_securityAssessments_title}"/>
<c:set var="activeMenu" value="securityRiskAssessments"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_nav_securityAssessments}</h1>
            <p class="adm-page-desc">${msg_security_admin_securityAssessments_desc}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/assessments">${msg_security_admin_nav_externalAssessmentsLong}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews">${msg_security_admin_nav_securityReviews}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">${msg_security_admin_nav_providerConfigs}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/blocks">${msg_security_admin_nav_blocks}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(6,minmax(0,1fr));gap:10px;">
            <label>${msg_security_admin_common_scope}
                <select class="adm-input" name="assessmentScope">
                    <option value="">${msg_security_admin_common_all}</option>
                    <option value="LOGIN_RISK" ${assessmentScope == 'LOGIN_RISK' ? 'selected' : ''}>LOGIN_RISK</option>
                    <option value="USER_SECURITY" ${assessmentScope == 'USER_SECURITY' ? 'selected' : ''}>USER_SECURITY</option>
                    <option value="CONTENT_MODERATION" ${assessmentScope == 'CONTENT_MODERATION' ? 'selected' : ''}>CONTENT_MODERATION</option>
                    <option value="IP_REPUTATION" ${assessmentScope == 'IP_REPUTATION' ? 'selected' : ''}>IP_REPUTATION</option>
                </select>
            </label>
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
            <label>${msg_security_admin_common_status}
                <select class="adm-input" name="decisionStatus">
                    <option value="">${msg_security_admin_common_all}</option>
                    <option value="PROPOSED" ${decisionStatus == 'PROPOSED' ? 'selected' : ''}>PROPOSED</option>
                    <option value="APPLIED" ${decisionStatus == 'APPLIED' ? 'selected' : ''}>APPLIED</option>
                    <option value="IGNORED" ${decisionStatus == 'IGNORED' ? 'selected' : ''}>IGNORED</option>
                    <option value="PENDING" ${decisionStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                </select>
            </label>
            <label>${msg_security_admin_common_search}
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_accountIpEvidenceSource}">
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
                <th>${msg_security_admin_common_scopeSource}</th>
                <th>${msg_security_admin_common_target}</th>
                <th>${msg_security_admin_common_riskLevel}</th>
                <th>${msg_security_admin_common_recommendationAction}</th>
                <th>${msg_security_admin_common_evidence}</th>
                <th>${msg_security_admin_common_status}</th>
                <th>${msg_security_admin_common_createdAt}</th>
                <th>${msg_security_admin_common_apply}</th>
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
                        <c:if test="${not empty a.ipAddress}"><small>${msg_security_admin_common_ip}: <c:out value="${a.ipAddress}"/></small></c:if>
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
                                <button class="adm-btn" type="submit">${msg_security_admin_common_enqueueReview}</button>
                            </form>
                        </c:if>
                        <c:if test="${a.subjectType == 'USER' && a.decisionStatus != 'APPLIED'}">
                            <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-assessments/${a.assessmentIdx}/apply-user-block" style="display:inline;">
                                <button class="adm-btn danger" type="submit">${msg_security_admin_common_applyUserBlock}</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty assessments}">
                <tr><td colspan="8" class="adm-empty">${msg_security_admin_empty_securityAssessments}</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
