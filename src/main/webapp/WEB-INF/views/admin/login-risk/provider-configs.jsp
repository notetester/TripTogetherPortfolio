<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="securityProviderConfigs"/>
<spring:message var="pageTitle" code="security.admin.provider.title"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="security.admin.provider.title"/></h1>
            <p class="adm-page-desc"><spring:message code="security.admin.provider.desc"/></p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments"><spring:message code="security.admin.nav.securityAssessments"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews"><spring:message code="security.admin.nav.securityReviews"/></a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success">${message}</div>
    </c:if>

    <c:forEach var="p" items="${providers}">
        <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/provider-configs/${p.providerIdx}" class="adm-card" style="margin-bottom:16px;">
            <div class="adm-card-header">
                <div>
                    <div class="adm-card-title">${p.providerName}</div>
                    <div class="adm-muted">${p.providerKind} · ${p.providerCode} · <spring:message code="security.admin.common.status"/> ${p.status}</div>
                </div>
                <label class="adm-check">
                    <input type="checkbox" name="enabled" ${p.enabled ? 'checked' : ''}>
                    <spring:message code="security.admin.common.enabled"/>
                </label>
            </div>
            <div class="adm-card-body">
                <input type="hidden" name="providerCode" value="${p.providerCode}">
                <input type="hidden" name="providerKind" value="${p.providerKind}">
                <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr));gap:12px;">
                    <label><spring:message code="security.admin.provider.displayName"/>
                        <input class="adm-input" type="text" name="providerName" value="${p.providerName}">
                    </label>
                    <label>Endpoint URL
                        <input class="adm-input" type="text" name="endpointUrl" value="${p.endpointUrl}" placeholder="https://api.example.com/risk">
                    </label>
                    <label>API Key Ref
                        <input class="adm-input" type="text" name="apiKeyRef" value="${p.apiKeyRef}" placeholder="ENV:TRIPTOGETHER_AI_KEY">
                    </label>
                    <label><spring:message code="security.admin.provider.modelName"/>
                        <input class="adm-input" type="text" name="modelName" value="${p.modelName}">
                    </label>
                    <label>Timeout(ms)
                        <input class="adm-input" type="number" name="timeoutMillis" value="${p.timeoutMillis}">
                    </label>
                    <label><spring:message code="security.admin.provider.failPolicy"/>
                        <select class="adm-input" name="failOpen">
                            <option value="1" ${p.failOpen == 1 ? 'selected' : ''}><spring:message code="security.admin.provider.failOpen"/></option>
                            <option value="0" ${p.failOpen == 0 ? 'selected' : ''}><spring:message code="security.admin.provider.failClosed"/></option>
                        </select>
                    </label>
                </div>
                <label style="display:block;margin-top:12px;"><spring:message code="security.admin.common.description"/>
                    <textarea class="adm-input" name="description" rows="2">${p.description}</textarea>
                </label>
                <div class="adm-muted" style="margin-top:8px;">
                    <spring:message code="security.admin.provider.externalCallNotice"/>
                </div>
                <div class="adm-actions" style="margin-top:12px;">
                    <button class="adm-btn primary" type="submit"><spring:message code="security.admin.common.save"/></button>
                </div>
            </div>
        </form>
    </c:forEach>
</div>
