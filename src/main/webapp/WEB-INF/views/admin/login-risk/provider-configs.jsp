<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="securityProviderConfigs"/>
<spring:message var="pageTitle" code="security.admin.provider.title"/>
<spring:message var="providerEndpointPlaceholder" code="security.admin.provider.endpointPlaceholder"/>
<spring:message var="providerApiKeyRefPlaceholder" code="security.admin.provider.apiKeyRefPlaceholder"/>
<%@ include file="../layout.jsp" %>

<style>
    .provider-detail-modal[hidden] { display:none; }
    .provider-detail-modal { position:fixed; inset:0; z-index:2000; background:rgba(15,23,42,.55); display:flex; align-items:center; justify-content:center; padding:24px; }
    .provider-detail-card { width:min(900px,96vw); max-height:88vh; overflow:auto; background:#fff; border-radius:20px; box-shadow:0 24px 70px rgba(15,23,42,.28); border:1px solid #e2e8f0; }
    .provider-detail-head { display:flex; justify-content:space-between; gap:12px; align-items:flex-start; padding:20px 22px; border-bottom:1px solid #e2e8f0; }
    .provider-detail-body { padding:20px 22px; }
    .provider-detail-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:12px; }
    .provider-detail-item { border:1px solid #e2e8f0; border-radius:14px; padding:12px; background:#f8fafc; }
    .provider-detail-label { font-size:12px; color:#64748b; font-weight:700; margin-bottom:6px; }
    .provider-detail-value { white-space:pre-wrap; word-break:break-word; color:#0f172a; }
    .provider-detail-close { border:0; background:#e2e8f0; border-radius:10px; padding:8px 12px; cursor:pointer; font-weight:800; }
    @media (max-width:720px) { .provider-detail-grid { grid-template-columns:1fr; } }
</style>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="security.admin.provider.title"/></h1>
            <p class="adm-page-desc"><spring:message code="security.admin.provider.desc"/></p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments"><spring:message code="security.admin.nav.securityAssessments"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews"><spring:message code="security.admin.nav.securityReviews"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history?sourceType=PROVIDER_CONFIG"><spring:message code="admin.layout.menu.policyHistory"/></a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <c:forEach var="p" items="${providers}">
        <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/provider-configs/${p.providerIdx}" class="adm-card" style="margin-bottom:16px;">
            <div class="adm-card-header">
                <div>
                    <div class="adm-card-title"><c:out value="${p.providerName}"/></div>
                    <div class="adm-muted"><c:out value="${p.providerKind}"/> · <c:out value="${p.providerCode}"/> · <spring:message code="security.admin.common.status"/> <c:out value="${p.status}"/></div>
                </div>
                <label class="adm-check">
                    <input type="checkbox" name="enabled" ${p.enabled ? 'checked' : ''}>
                    <spring:message code="security.admin.common.enabled"/>
                </label>
            </div>
            <div class="adm-card-body">
                <input type="hidden" name="providerCode" value="${fn:escapeXml(p.providerCode)}">
                <input type="hidden" name="providerKind" value="${fn:escapeXml(p.providerKind)}">
                <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr));gap:12px;">
                    <label><spring:message code="security.admin.provider.displayName"/>
                        <input class="adm-input" type="text" name="providerName" value="${fn:escapeXml(p.providerName)}">
                    </label>
                    <label><spring:message code="security.admin.provider.endpointUrl"/>
                        <input class="adm-input" type="text" name="endpointUrl" value="${fn:escapeXml(p.endpointUrl)}" placeholder="${providerEndpointPlaceholder}">
                    </label>
                    <label><spring:message code="security.admin.provider.apiKeyRef"/>
                        <input class="adm-input" type="text" name="apiKeyRef" value="${fn:escapeXml(p.apiKeyRef)}" placeholder="${providerApiKeyRefPlaceholder}">
                    </label>
                    <label><spring:message code="security.admin.provider.modelName"/>
                        <input class="adm-input" type="text" name="modelName" value="${fn:escapeXml(p.modelName)}">
                    </label>
                    <label><spring:message code="security.admin.provider.timeoutMillis"/>
                        <input class="adm-input" type="number" name="timeoutMillis" value="${fn:escapeXml(p.timeoutMillis)}">
                    </label>
                    <label><spring:message code="security.admin.provider.failPolicy"/>
                        <select class="adm-input" name="failOpen">
                            <option value="1" ${p.failOpen == 1 ? 'selected' : ''}><spring:message code="security.admin.provider.failOpen"/></option>
                            <option value="0" ${p.failOpen == 0 ? 'selected' : ''}><spring:message code="security.admin.provider.failClosed"/></option>
                        </select>
                    </label>
                </div>
                <label style="display:block;margin-top:12px;"><spring:message code="security.admin.common.description"/>
                    <textarea class="adm-input" name="description" rows="2"><c:out value="${p.description}"/></textarea>
                </label>
                <div class="adm-muted" style="margin-top:8px;line-height:1.7;">
                    <spring:message code="security.admin.provider.externalCallNotice"/><br>
                    <spring:message code="security.admin.provider.lastCheckedAt"/>:
                    <fmt:formatDate value="${p.lastCheckedAtDate}" pattern="yyyy-MM-dd HH:mm"/>
                </div>
                <div class="adm-actions" style="margin-top:12px;">
                    <button class="adm-btn primary" type="submit"><spring:message code="security.admin.common.save"/></button>
                    <button class="adm-btn" type="submit"
                            formmethod="post"
                            formaction="${pageContext.request.contextPath}/admin/login-risk/provider-configs/${p.providerIdx}/check">
                        <spring:message code="security.admin.provider.checkNow"/>
                    </button>
                    <button class="adm-btn js-provider-modal-open" type="button" data-modal-id="provider-detail-${p.providerIdx}">
                        <spring:message code="security.admin.common.detail"/>
                    </button>
                    <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history?sourceType=PROVIDER_CONFIG&keyword=${fn:escapeXml(p.providerCode)}">
                        <spring:message code="security.admin.provider.history"/>
                    </a>
                </div>
            </div>
        </form>

        <div class="provider-detail-modal" id="provider-detail-${p.providerIdx}" hidden>
            <div class="provider-detail-card" role="dialog" aria-modal="true" aria-labelledby="provider-detail-title-${p.providerIdx}">
                <div class="provider-detail-head">
                    <div>
                        <h2 id="provider-detail-title-${p.providerIdx}" style="margin:0;"><spring:message code="security.admin.provider.detailTitle"/></h2>
                        <div class="adm-muted"><c:out value="${p.providerKind}"/> · <c:out value="${p.providerCode}"/></div>
                    </div>
                    <button class="provider-detail-close js-provider-modal-close" type="button"><spring:message code="security.admin.common.close"/></button>
                </div>
                <div class="provider-detail-body">
                    <div class="provider-detail-grid">
                        <div class="provider-detail-item">
                            <div class="provider-detail-label"><spring:message code="security.admin.provider.displayName"/></div>
                            <div class="provider-detail-value"><c:out value="${p.providerName}" default="-"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label"><spring:message code="security.admin.common.status"/></div>
                            <div class="provider-detail-value"><c:out value="${p.status}" default="-"/> / <spring:message code="security.admin.common.enabled"/>: <c:out value="${p.enabled}"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label"><spring:message code="security.admin.provider.endpointUrl"/></div>
                            <div class="provider-detail-value"><c:out value="${p.endpointUrl}" default="-"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label"><spring:message code="security.admin.provider.apiKeyRef"/></div>
                            <div class="provider-detail-value"><c:out value="${p.apiKeyRef}" default="-"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label"><spring:message code="security.admin.provider.modelName"/></div>
                            <div class="provider-detail-value"><c:out value="${p.modelName}" default="-"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label"><spring:message code="security.admin.provider.timeoutMillis"/></div>
                            <div class="provider-detail-value"><c:out value="${p.timeoutMillis}" default="-"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label"><spring:message code="security.admin.provider.failPolicy"/></div>
                            <div class="provider-detail-value"><c:out value="${p.failOpen}" default="-"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label"><spring:message code="security.admin.provider.lastCheckedAt"/></div>
                            <div class="provider-detail-value"><fmt:formatDate value="${p.lastCheckedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                        </div>
                    </div>
                    <div class="provider-detail-item" style="margin-top:12px;">
                        <div class="provider-detail-label"><spring:message code="security.admin.common.description"/></div>
                        <div class="provider-detail-value"><c:out value="${p.description}" default="-"/></div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<script>
(function () {
    const closeModal = function (modal) { if (modal) modal.hidden = true; };
    const openModal = function (modal) { if (modal) modal.hidden = false; };
    document.querySelectorAll('.js-provider-modal-open').forEach(function (button) {
        button.addEventListener('click', function () {
            openModal(document.getElementById(button.dataset.modalId));
        });
    });
    document.querySelectorAll('.js-provider-modal-close').forEach(function (button) {
        button.addEventListener('click', function () {
            closeModal(button.closest('.provider-detail-modal'));
        });
    });
    document.querySelectorAll('.provider-detail-modal').forEach(function (modal) {
        modal.addEventListener('click', function (event) {
            if (event.target === modal) closeModal(modal);
        });
    });
    document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') {
            document.querySelectorAll('.provider-detail-modal:not([hidden])').forEach(closeModal);
        }
    });
})();
</script>
