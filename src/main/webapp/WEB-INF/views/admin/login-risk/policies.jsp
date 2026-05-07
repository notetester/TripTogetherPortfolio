<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_policies_title" code="security.admin.policies.title"/>
<spring:message var="msg_security_admin_policies_desc" code="security.admin.policies.desc"/>
<spring:message var="msg_security_admin_nav_appealPolicy" code="security.admin.nav.appealPolicy"/>
<spring:message var="msg_security_admin_nav_reviews" code="security.admin.nav.reviews"/>
<spring:message var="msg_security_admin_nav_externalAssessments" code="security.admin.nav.externalAssessments"/>
<spring:message var="msg_security_admin_nav_notifications" code="security.admin.nav.notifications"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_policies_appealGuide_title" code="security.admin.policies.appealGuide.title"/>
<spring:message var="msg_security_admin_policies_appealGuide_desc" code="security.admin.policies.appealGuide.desc"/>
<spring:message var="msg_security_admin_policies_appealGuide_observation" code="security.admin.policies.appealGuide.observation"/>
<spring:message var="msg_security_admin_policies_appealGuide_threshold" code="security.admin.policies.appealGuide.threshold"/>
<spring:message var="msg_security_admin_policies_appealGuide_distinct" code="security.admin.policies.appealGuide.distinct"/>
<spring:message var="msg_security_admin_common_enabled" code="security.admin.common.enabled"/>
<spring:message var="msg_security_admin_policies_observationMinutes" code="security.admin.policies.observationMinutes"/>
<spring:message var="msg_security_admin_policies_thresholdCount" code="security.admin.policies.thresholdCount"/>
<spring:message var="msg_security_admin_policies_distinctAccountThreshold" code="security.admin.policies.distinctAccountThreshold"/>
<spring:message var="msg_security_admin_policies_lockDurationMinutes" code="security.admin.policies.lockDurationMinutes"/>
<spring:message var="msg_security_admin_policies_warningBeforeCount" code="security.admin.policies.warningBeforeCount"/>
<spring:message var="msg_security_admin_common_severity" code="security.admin.common.severity"/>
<spring:message var="msg_security_admin_policies_notificationCategory" code="security.admin.policies.notificationCategory"/>
<spring:message var="msg_security_admin_policies_aiRiskScoreThreshold" code="security.admin.policies.aiRiskScoreThreshold"/>
<spring:message var="msg_security_admin_policies_resetOnSuccess" code="security.admin.policies.resetOnSuccess"/>
<spring:message var="msg_security_admin_policies_requireAdminReview" code="security.admin.policies.requireAdminReview"/>
<spring:message var="msg_security_admin_policies_aiAssistEnabled" code="security.admin.policies.aiAssistEnabled"/>
<spring:message var="msg_security_admin_policies_wafSyncEnabled" code="security.admin.policies.wafSyncEnabled"/>
<spring:message var="msg_security_admin_common_description" code="security.admin.common.description"/>
<spring:message var="msg_security_admin_common_save" code="security.admin.common.save"/>
<c:set var="pageTitle" value="${msg_security_admin_policies_title}"/>
<c:set var="activeMenu" value="loginRiskPolicies"/>

<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_policies_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_policies_desc}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/appeal-policy">${msg_security_admin_nav_appealPolicy}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/reviews">${msg_security_admin_nav_reviews}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/assessments">${msg_security_admin_nav_externalAssessments}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences">${msg_security_admin_nav_notifications}</a>
                    <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <div class="adm-card" style="margin-bottom:16px;">
        <div class="adm-card-body">
            <div style="font-weight:800;color:#0f172a;">${msg_security_admin_policies_appealGuide_title}</div>
            <div style="font-size:12px;color:#64748b;margin-top:6px;line-height:1.7;">
                ${msg_security_admin_policies_appealGuide_desc}<br>
                ${msg_security_admin_policies_appealGuide_observation}<br>
                ${msg_security_admin_policies_appealGuide_threshold}<br>
                ${msg_security_admin_policies_appealGuide_distinct}
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
                    ${msg_security_admin_common_enabled}
                </label>
            </div>
            <div class="adm-card-body">
                <input type="hidden" name="policyCode" value="${fn:escapeXml(p.policyCode)}">
                <input type="hidden" name="policyType" value="${fn:escapeXml(p.policyType)}">
                <input type="hidden" name="actionType" value="${fn:escapeXml(p.actionType)}">

                <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr)); gap:12px;">
                    <label>${msg_security_admin_policies_observationMinutes}
                        <input class="adm-input" type="number" name="observationMinutes" value="${p.observationMinutes}">
                    </label>
                    <label>${msg_security_admin_policies_thresholdCount}
                        <input class="adm-input" type="number" name="thresholdCount" value="${p.thresholdCount}">
                    </label>
                    <label>${msg_security_admin_policies_distinctAccountThreshold}
                        <input class="adm-input" type="number" name="distinctAccountThreshold" value="${p.distinctAccountThreshold}">
                    </label>
                    <label>${msg_security_admin_policies_lockDurationMinutes}
                        <input class="adm-input" type="number" name="lockDurationMinutes" value="${p.lockDurationMinutes}">
                    </label>
                    <label>${msg_security_admin_policies_warningBeforeCount}
                        <input class="adm-input" type="number" name="warningBeforeCount" value="${p.warningBeforeCount}">
                    </label>
                    <label>${msg_security_admin_common_severity}
                        <select class="adm-input" name="reviewSeverity">
                            <option value="LOW" ${p.reviewSeverity == 'LOW' ? 'selected' : ''}>LOW</option>
                            <option value="MEDIUM" ${p.reviewSeverity == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                            <option value="HIGH" ${p.reviewSeverity == 'HIGH' ? 'selected' : ''}>HIGH</option>
                            <option value="CRITICAL" ${p.reviewSeverity == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                        </select>
                    </label>
                    <label>${msg_security_admin_policies_notificationCategory}
                        <input class="adm-input" type="text" name="notificationCategory" value="${fn:escapeXml(p.notificationCategory)}">
                    </label>
                    <label>${msg_security_admin_policies_aiRiskScoreThreshold}
                        <input class="adm-input" type="number" name="aiRiskScoreThreshold" value="${p.aiRiskScoreThreshold}">
                    </label>
                    <label class="adm-check" style="align-self:end;">
                        <input type="checkbox" name="resetOnSuccess" ${p.resetOnSuccess ? 'checked' : ''}>
                        ${msg_security_admin_policies_resetOnSuccess}
                    </label>
                    <label class="adm-check" style="align-self:end;">
                        <input type="checkbox" name="requireAdminReview" ${p.requireAdminReview ? 'checked' : ''}>
                        ${msg_security_admin_policies_requireAdminReview}
                    </label>
                    <label class="adm-check" style="align-self:end;">
                        <input type="checkbox" name="aiAssistEnabled" ${p.aiAssistEnabled ? 'checked' : ''}>
                        ${msg_security_admin_policies_aiAssistEnabled}
                    </label>
                    <label class="adm-check" style="align-self:end;">
                        <input type="checkbox" name="wafSyncEnabled" ${p.wafSyncEnabled ? 'checked' : ''}>
                        ${msg_security_admin_policies_wafSyncEnabled}
                    </label>
                </div>

                <label style="display:block;margin-top:12px;">${msg_security_admin_common_description}
                    <textarea class="adm-input" name="description" rows="2"><c:out value="${p.description}"/></textarea>
                </label>

                <div class="adm-actions" style="margin-top:12px;">
                    <button type="submit" class="adm-btn primary">${msg_security_admin_common_save}</button>
                </div>
            </div>
        </form>
    </c:forEach>
</div>
