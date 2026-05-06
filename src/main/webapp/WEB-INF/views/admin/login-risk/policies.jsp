<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<spring:message var="autoMsg_2b430fd0cf" code="security.admin.policies.title"/>
<spring:message var="autoMsg_6e345a2bb0" code="security.admin.policies.desc"/>
<spring:message var="autoMsg_0a6ecbee7c" code="security.admin.nav.appealPolicy"/>
<spring:message var="autoMsg_c8134acce5" code="security.admin.nav.reviews"/>
<spring:message var="autoMsg_498002b544" code="security.admin.nav.externalAssessments"/>
<spring:message var="autoMsg_8e9bf71668" code="security.admin.nav.notifications"/>
<spring:message var="autoMsg_89ac7ba12c" code="security.admin.nav.securityAssessments"/>
<spring:message var="autoMsg_20d5b95e72" code="security.admin.policies.appealGuide.title"/>
<spring:message var="autoMsg_00426c9599" code="security.admin.policies.appealGuide.desc"/>
<spring:message var="autoMsg_be421e7676" code="security.admin.policies.appealGuide.observation"/>
<spring:message var="autoMsg_25d8accb1f" code="security.admin.policies.appealGuide.threshold"/>
<spring:message var="autoMsg_1a05a51bcd" code="security.admin.policies.observationMinutes"/>
<spring:message var="autoMsg_17d3c375ec" code="security.admin.policies.thresholdCount"/>
<spring:message var="autoMsg_b7fd355f8e" code="security.admin.policies.distinctAccountThreshold"/>
<spring:message var="autoMsg_d4dbefa193" code="security.admin.policies.lockDurationMinutes"/>
<spring:message var="autoMsg_56f04cedd9" code="security.admin.policies.warningBeforeCount"/>
<spring:message var="autoMsg_536f5c7cff" code="security.admin.common.severity"/>
<spring:message var="autoMsg_445124ae74" code="security.admin.policies.notificationCategory"/>
<spring:message var="autoMsg_bf06fbcc30" code="security.admin.policies.aiRiskScoreThreshold"/>
<spring:message var="autoMsg_a512af4301" code="security.admin.common.description"/>
<spring:message var="autoMsg_0976ded641" code="security.admin.common.save"/>
<c:set var="activeMenu" value="loginRiskPolicies"/>
<spring:message var="pageTitle" code="security.admin.policies.title"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${autoMsg_2b430fd0cf}</h1>
            <p class="adm-page-desc">${autoMsg_6e345a2bb0}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/appeal-policy">${autoMsg_0a6ecbee7c}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/reviews">${autoMsg_c8134acce5}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/assessments">${autoMsg_498002b544}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences">${autoMsg_8e9bf71668}</a>
                    <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${autoMsg_89ac7ba12c}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <div class="adm-card" style="margin-bottom:16px;">
        <div class="adm-card-body">
            <div style="font-weight:800;color:#0f172a;">${autoMsg_20d5b95e72}</div>
            <div style="font-size:12px;color:#64748b;margin-top:6px;line-height:1.7;">
                ${autoMsg_00426c9599}<br>
                ${autoMsg_be421e7676}<br>
                ${autoMsg_25d8accb1f}<br>
                <spring:message code="security.admin.policies.appealGuide.distinct"/>
            </div>
        </div>
    </div>

    <c:forEach var="p" items="${policies}">
        <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/policies/${p.policyIdx}" class="adm-card" style="margin-bottom:16px;">
            <div class="adm-card-header">
                <div>
                    <div class="adm-card-title"><c:out value="${p.policyName}"/></div>
                    <div class="adm-muted"><c:out value="${p.policyCode}"/> · <c:out value="${p.policyType}"/> · <c:out value="${p.actionType}"/></div>
                </div>
                <label class="adm-check">
                    <input type="checkbox" name="active" ${p.active ? 'checked' : ''}>
                    <spring:message code="security.admin.common.enabled"/>
                </label>
            </div>
            <div class="adm-card-body">
                <input type="hidden" name="policyCode" value="${fn:escapeXml(p.policyCode)}">
                <input type="hidden" name="policyType" value="${fn:escapeXml(p.policyType)}">
                <input type="hidden" name="actionType" value="${fn:escapeXml(p.actionType)}">

                <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr)); gap:12px;">
                    <label>${autoMsg_1a05a51bcd}
                        <input class="adm-input" type="number" name="observationMinutes" value="${p.observationMinutes}">
                    </label>
                    <label>${autoMsg_17d3c375ec}
                        <input class="adm-input" type="number" name="thresholdCount" value="${p.thresholdCount}">
                    </label>
                    <label>${autoMsg_b7fd355f8e}
                        <input class="adm-input" type="number" name="distinctAccountThreshold" value="${p.distinctAccountThreshold}">
                    </label>
                    <label>${autoMsg_d4dbefa193}
                        <input class="adm-input" type="number" name="lockDurationMinutes" value="${p.lockDurationMinutes}">
                    </label>
                    <label>${autoMsg_56f04cedd9}
                        <input class="adm-input" type="number" name="warningBeforeCount" value="${p.warningBeforeCount}">
                    </label>
                    <label>${autoMsg_536f5c7cff}
                        <select class="adm-input" name="reviewSeverity">
                            <option value="LOW" ${p.reviewSeverity == 'LOW' ? 'selected' : ''}>LOW</option>
                            <option value="MEDIUM" ${p.reviewSeverity == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                            <option value="HIGH" ${p.reviewSeverity == 'HIGH' ? 'selected' : ''}>HIGH</option>
                            <option value="CRITICAL" ${p.reviewSeverity == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                        </select>
                    </label>
                    <label>${autoMsg_445124ae74}
                        <input class="adm-input" type="text" name="notificationCategory" value="${fn:escapeXml(p.notificationCategory)}">
                    </label>
                    <label>${autoMsg_bf06fbcc30}
                        <input class="adm-input" type="number" name="aiRiskScoreThreshold" value="${p.aiRiskScoreThreshold}">
                    </label>
                    <label class="adm-check" style="align-self:end;">
                        <input type="checkbox" name="resetOnSuccess" ${p.resetOnSuccess ? 'checked' : ''}>
                        <spring:message code="security.admin.policies.resetOnSuccess"/>
                    </label>
                    <label class="adm-check" style="align-self:end;">
                        <input type="checkbox" name="requireAdminReview" ${p.requireAdminReview ? 'checked' : ''}>
                        <spring:message code="security.admin.policies.requireAdminReview"/>
                    </label>
                    <label class="adm-check" style="align-self:end;">
                        <input type="checkbox" name="aiAssistEnabled" ${p.aiAssistEnabled ? 'checked' : ''}>
                        <spring:message code="security.admin.policies.aiAssistEnabled"/>
                    </label>
                    <label class="adm-check" style="align-self:end;">
                        <input type="checkbox" name="wafSyncEnabled" ${p.wafSyncEnabled ? 'checked' : ''}>
                        <spring:message code="security.admin.policies.wafSyncEnabled"/>
                    </label>
                </div>

                <label style="display:block;margin-top:12px;">${autoMsg_a512af4301}
                    <textarea class="adm-input" name="description" rows="2"><c:out value="${p.description}"/></textarea>
                </label>

                <div class="adm-actions" style="margin-top:12px;">
                    <button type="submit" class="adm-btn primary">${autoMsg_0976ded641}</button>
                </div>
            </div>
        </form>
    </c:forEach>
</div>
