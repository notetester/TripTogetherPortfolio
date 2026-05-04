<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="loginRiskPolicies"/>
<spring:message var="pageTitle" code="security.admin.policies.title"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="security.admin.policies.title"/></h1>
            <p class="adm-page-desc"><spring:message code="security.admin.policies.desc"/></p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/reviews"><spring:message code="security.admin.nav.reviews"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/assessments"><spring:message code="security.admin.nav.externalAssessments"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences"><spring:message code="security.admin.nav.notifications"/></a>
                    <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments"><spring:message code="security.admin.nav.securityAssessments"/></a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <div class="adm-card" style="margin-bottom:16px;">
        <div class="adm-card-body">
            <div style="font-weight:800;color:#0f172a;"><spring:message code="security.admin.policies.appealGuide.title"/></div>
            <div style="font-size:12px;color:#64748b;margin-top:6px;line-height:1.7;">
                <spring:message code="security.admin.policies.appealGuide.desc"/><br>
                <spring:message code="security.admin.policies.appealGuide.observation"/><br>
                <spring:message code="security.admin.policies.appealGuide.threshold"/><br>
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
                    <label><spring:message code="security.admin.policies.observationMinutes"/>
                        <input class="adm-input" type="number" name="observationMinutes" value="${p.observationMinutes}">
                    </label>
                    <label><spring:message code="security.admin.policies.thresholdCount"/>
                        <input class="adm-input" type="number" name="thresholdCount" value="${p.thresholdCount}">
                    </label>
                    <label><spring:message code="security.admin.policies.distinctAccountThreshold"/>
                        <input class="adm-input" type="number" name="distinctAccountThreshold" value="${p.distinctAccountThreshold}">
                    </label>
                    <label><spring:message code="security.admin.policies.lockDurationMinutes"/>
                        <input class="adm-input" type="number" name="lockDurationMinutes" value="${p.lockDurationMinutes}">
                    </label>
                    <label><spring:message code="security.admin.policies.warningBeforeCount"/>
                        <input class="adm-input" type="number" name="warningBeforeCount" value="${p.warningBeforeCount}">
                    </label>
                    <label><spring:message code="security.admin.common.severity"/>
                        <select class="adm-input" name="reviewSeverity">
                            <option value="LOW" ${p.reviewSeverity == 'LOW' ? 'selected' : ''}>LOW</option>
                            <option value="MEDIUM" ${p.reviewSeverity == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                            <option value="HIGH" ${p.reviewSeverity == 'HIGH' ? 'selected' : ''}>HIGH</option>
                            <option value="CRITICAL" ${p.reviewSeverity == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                        </select>
                    </label>
                    <label><spring:message code="security.admin.policies.notificationCategory"/>
                        <input class="adm-input" type="text" name="notificationCategory" value="${fn:escapeXml(p.notificationCategory)}">
                    </label>
                    <label><spring:message code="security.admin.policies.aiRiskScoreThreshold"/>
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

                <label style="display:block;margin-top:12px;"><spring:message code="security.admin.common.description"/>
                    <textarea class="adm-input" name="description" rows="2"><c:out value="${p.description}"/></textarea>
                </label>

                <div class="adm-actions" style="margin-top:12px;">
                    <button type="submit" class="adm-btn primary"><spring:message code="security.admin.common.save"/></button>
                </div>
            </div>
        </form>
    </c:forEach>
</div>
