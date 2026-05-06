<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_7ae2d2fa3c" code="security.admin.externalAssessments.title"/>
<spring:message var="autoMsg_3fe2ed745b" code="security.admin.externalAssessments.desc"/>
<spring:message var="autoMsg_80ce403310" code="security.admin.nav.policies"/>
<spring:message var="autoMsg_f64989b9e6" code="security.admin.nav.reviews"/>
<spring:message var="autoMsg_f90c8185ea" code="security.admin.nav.securityAssessments"/>
<spring:message var="autoMsg_74ccee8dca" code="security.admin.common.sourceKind"/>
<spring:message var="autoMsg_f5e6dbad1a" code="security.admin.common.all"/>
<spring:message var="autoMsg_08053e751f" code="security.admin.common.riskLevel"/>
<spring:message var="autoMsg_032b2fe114" code="security.admin.common.decisionStatus"/>
<spring:message var="autoMsg_bba5f0b9e2" code="security.admin.common.search"/>
<spring:message var="autoMsg_cbe6739d87" code="security.admin.common.source"/>
<spring:message var="autoMsg_a4576aff8d" code="security.admin.common.target"/>
<spring:message var="autoMsg_395056446a" code="security.admin.common.recommendationAction"/>
<spring:message var="autoMsg_64a1eb914c" code="security.admin.common.evidence"/>
<spring:message var="autoMsg_987a9651f9" code="security.admin.common.status"/>
<spring:message var="autoMsg_480e717d85" code="security.admin.common.createdAt"/>
<spring:message var="autoMsg_b20d1f1194" code="security.admin.empty.externalAssessments"/>
<c:set var="activeMenu" value="loginRiskAssessments"/>
<spring:message var="pageTitle" code="security.admin.externalAssessments.title"/>
<spring:message var="keywordPlaceholder" code="security.admin.placeholder.ipAccountSourceReason"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${autoMsg_7ae2d2fa3c}</h1>
            <p class="adm-page-desc">${autoMsg_3fe2ed745b}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies">${autoMsg_80ce403310}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/reviews">${autoMsg_f64989b9e6}</a>
                    <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${autoMsg_f90c8185ea}</a>
        </div>
    </div>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(5,minmax(0,1fr));gap:10px;">
            <label>${autoMsg_74ccee8dca}
                <select class="adm-input" name="sourceKind">
                    <option value="">${autoMsg_f5e6dbad1a}</option>
                    <option value="AI_MODEL" ${sourceKind == 'AI_MODEL' ? 'selected' : ''}>AI_MODEL</option>
                    <option value="RULE_ALGORITHM" ${sourceKind == 'RULE_ALGORITHM' ? 'selected' : ''}>RULE_ALGORITHM</option>
                    <option value="POLICY_AUTHORITY" ${sourceKind == 'POLICY_AUTHORITY' ? 'selected' : ''}>POLICY_AUTHORITY</option>
                    <option value="ASSESSMENT_PIPELINE" ${sourceKind == 'ASSESSMENT_PIPELINE' ? 'selected' : ''}>ASSESSMENT_PIPELINE</option>
                </select>
            </label>
            <label>${autoMsg_08053e751f}
                <select class="adm-input" name="riskLevel">
                    <option value="">${autoMsg_f5e6dbad1a}</option>
                    <option value="CRITICAL" ${riskLevel == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                    <option value="HIGH" ${riskLevel == 'HIGH' ? 'selected' : ''}>HIGH</option>
                    <option value="MEDIUM" ${riskLevel == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                    <option value="LOW" ${riskLevel == 'LOW' ? 'selected' : ''}>LOW</option>
                    <option value="PENDING" ${riskLevel == 'PENDING' ? 'selected' : ''}>PENDING</option>
                </select>
            </label>
            <label>${autoMsg_032b2fe114}
                <select class="adm-input" name="decisionStatus">
                    <option value="">${autoMsg_f5e6dbad1a}</option>
                    <option value="PROPOSED" ${decisionStatus == 'PROPOSED' ? 'selected' : ''}>PROPOSED</option>
                    <option value="APPLIED" ${decisionStatus == 'APPLIED' ? 'selected' : ''}>APPLIED</option>
                    <option value="IGNORED" ${decisionStatus == 'IGNORED' ? 'selected' : ''}>IGNORED</option>
                    <option value="PENDING" ${decisionStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                </select>
            </label>
            <label>${autoMsg_bba5f0b9e2}
                <input class="adm-input" type="text" name="keyword" value="${keyword}" placeholder="${keywordPlaceholder}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit">${autoMsg_bba5f0b9e2}</button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th>${autoMsg_cbe6739d87}</th>
                <th>${autoMsg_a4576aff8d}</th>
                <th>${autoMsg_08053e751f}</th>
                <th>${autoMsg_395056446a}</th>
                <th>${autoMsg_64a1eb914c}</th>
                <th>${autoMsg_987a9651f9}</th>
                <th>${autoMsg_480e717d85}</th>
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
                <tr><td colspan="7" class="adm-empty">${autoMsg_b20d1f1194}</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
