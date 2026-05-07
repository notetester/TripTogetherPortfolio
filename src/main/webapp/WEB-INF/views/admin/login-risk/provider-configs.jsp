<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_provider_title" code="security.admin.provider.title"/>
<spring:message var="msg_security_admin_provider_endpointPlaceholder" code="security.admin.provider.endpointPlaceholder"/>
<spring:message var="msg_security_admin_provider_apiKeyRefPlaceholder" code="security.admin.provider.apiKeyRefPlaceholder"/>
<spring:message var="msg_security_admin_provider_desc" code="security.admin.provider.desc"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_nav_securityReviews" code="security.admin.nav.securityReviews"/>
<spring:message var="msg_admin_layout_menu_policyHistory" code="admin.layout.menu.policyHistory"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_enabled" code="security.admin.common.enabled"/>
<spring:message var="msg_security_admin_provider_displayName" code="security.admin.provider.displayName"/>
<spring:message var="msg_security_admin_provider_endpointUrl" code="security.admin.provider.endpointUrl"/>
<spring:message var="msg_security_admin_provider_apiKeyRef" code="security.admin.provider.apiKeyRef"/>
<spring:message var="msg_security_admin_provider_modelName" code="security.admin.provider.modelName"/>
<spring:message var="msg_security_admin_provider_timeoutMillis" code="security.admin.provider.timeoutMillis"/>
<spring:message var="msg_security_admin_provider_failPolicy" code="security.admin.provider.failPolicy"/>
<spring:message var="msg_security_admin_provider_failOpen" code="security.admin.provider.failOpen"/>
<spring:message var="msg_security_admin_provider_failClosed" code="security.admin.provider.failClosed"/>
<spring:message var="msg_security_admin_common_description" code="security.admin.common.description"/>
<spring:message var="msg_security_admin_provider_externalCallNotice" code="security.admin.provider.externalCallNotice"/>
<spring:message var="msg_security_admin_provider_lastCheckedAt" code="security.admin.provider.lastCheckedAt"/>
<spring:message var="msg_security_admin_common_save" code="security.admin.common.save"/>
<spring:message var="msg_security_admin_provider_checkNow" code="security.admin.provider.checkNow"/>
<spring:message var="msg_security_admin_common_detail" code="security.admin.common.detail"/>
<spring:message var="msg_security_admin_provider_history" code="security.admin.provider.history"/>
<spring:message var="msg_security_admin_provider_detailTitle" code="security.admin.provider.detailTitle"/>
<spring:message var="msg_security_admin_common_close" code="security.admin.common.close"/>
<c:set var="pageTitle" value="${msg_security_admin_provider_title}"/>
<c:set var="activeMenu" value="securityProviderConfigs"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-provider-config-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_provider_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_provider_desc}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews">${msg_security_admin_nav_securityReviews}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history?sourceType=PROVIDER_CONFIG">${msg_admin_layout_menu_policyHistory}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <c:forEach var="p" items="${providers}">
        <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/provider-configs/${p.providerIdx}" class="adm-card adm-provider-config-card">
            <div class="adm-card-header adm-provider-card-head">
                <div class="adm-provider-card-titleblock">
                    <div class="adm-card-title"><c:out value="${p.providerName}"/></div>
                    <div class="adm-muted"><c:out value="${p.providerKind}"/> · <c:out value="${p.providerCode}"/> · ${msg_security_admin_common_status} <c:out value="${p.status}"/></div>
                </div>
                <div class="adm-provider-card-controls">
                    <label class="adm-check adm-provider-enabled">
                        <input type="checkbox" name="enabled" ${p.enabled ? 'checked' : ''}>
                        ${msg_security_admin_common_enabled}
                    </label>
                    <div class="adm-provider-card-actions">
                        <button class="adm-btn primary" type="submit">${msg_security_admin_common_save}</button>
                        <button class="adm-btn" type="submit"
                                formmethod="post"
                                formaction="${pageContext.request.contextPath}/admin/login-risk/provider-configs/${p.providerIdx}/check">
                            ${msg_security_admin_provider_checkNow}
                        </button>
                        <button class="adm-btn js-provider-modal-open" type="button" data-modal-id="provider-detail-${p.providerIdx}">
                            ${msg_security_admin_common_detail}
                        </button>
                        <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history?sourceType=PROVIDER_CONFIG&keyword=${fn:escapeXml(p.providerCode)}">
                            ${msg_security_admin_provider_history}
                        </a>
                    </div>
                </div>
            </div>
            <div class="adm-card-body">
                <input type="hidden" name="providerCode" value="${fn:escapeXml(p.providerCode)}">
                <input type="hidden" name="providerKind" value="${fn:escapeXml(p.providerKind)}">
                <div class="adm-form-grid adm-provider-form-grid">
                    <label>${msg_security_admin_provider_displayName}
                        <input class="adm-input" type="text" name="providerName" value="${fn:escapeXml(p.providerName)}">
                    </label>
                    <label>${msg_security_admin_provider_endpointUrl}
                        <input class="adm-input" type="text" name="endpointUrl" value="${fn:escapeXml(p.endpointUrl)}" placeholder="${msg_security_admin_provider_endpointPlaceholder}">
                    </label>
                    <label>${msg_security_admin_provider_apiKeyRef}
                        <input class="adm-input" type="text" name="apiKeyRef" value="${fn:escapeXml(p.apiKeyRef)}" placeholder="${msg_security_admin_provider_apiKeyRefPlaceholder}">
                    </label>
                    <label>${msg_security_admin_provider_modelName}
                        <input class="adm-input" type="text" name="modelName" value="${fn:escapeXml(p.modelName)}">
                    </label>
                    <label>${msg_security_admin_provider_timeoutMillis}
                        <input class="adm-input" type="number" name="timeoutMillis" value="${fn:escapeXml(p.timeoutMillis)}">
                    </label>
                    <label>${msg_security_admin_provider_failPolicy}
                        <select class="adm-select" name="failOpen">
                            <option value="1" ${p.failOpen == 1 ? 'selected' : ''}>${msg_security_admin_provider_failOpen}</option>
                            <option value="0" ${p.failOpen == 0 ? 'selected' : ''}>${msg_security_admin_provider_failClosed}</option>
                        </select>
                    </label>
                </div>
                <label class="adm-provider-description-field">${msg_security_admin_common_description}
                    <textarea class="adm-input" name="description" rows="2"><c:out value="${p.description}"/></textarea>
                </label>
                <div class="adm-provider-card-foot adm-muted">
                    <span>${msg_security_admin_provider_externalCallNotice}</span>
                    <span>${msg_security_admin_provider_lastCheckedAt}: <fmt:formatDate value="${p.lastCheckedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                </div>
            </div>
        </form>

        <div class="provider-detail-modal" id="provider-detail-${p.providerIdx}" hidden>
            <div class="provider-detail-card" role="dialog" aria-modal="true" aria-labelledby="provider-detail-title-${p.providerIdx}">
                <div class="provider-detail-head">
                    <div>
                        <h2 id="provider-detail-title-${p.providerIdx}" class="provider-detail-title">${msg_security_admin_provider_detailTitle}</h2>
                        <div class="adm-muted"><c:out value="${p.providerKind}"/> · <c:out value="${p.providerCode}"/></div>
                    </div>
                    <button class="provider-detail-close js-provider-modal-close" type="button">${msg_security_admin_common_close}</button>
                </div>
                <div class="provider-detail-body">
                    <div class="provider-detail-grid">
                        <div class="provider-detail-item">
                            <div class="provider-detail-label">${msg_security_admin_provider_displayName}</div>
                            <div class="provider-detail-value"><c:out value="${p.providerName}" default="-"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label">${msg_security_admin_common_status}</div>
                            <div class="provider-detail-value"><c:out value="${p.status}" default="-"/> / ${msg_security_admin_common_enabled}: <c:out value="${p.enabled}"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label">${msg_security_admin_provider_endpointUrl}</div>
                            <div class="provider-detail-value"><c:out value="${p.endpointUrl}" default="-"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label">${msg_security_admin_provider_apiKeyRef}</div>
                            <div class="provider-detail-value"><c:out value="${p.apiKeyRef}" default="-"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label">${msg_security_admin_provider_modelName}</div>
                            <div class="provider-detail-value"><c:out value="${p.modelName}" default="-"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label">${msg_security_admin_provider_timeoutMillis}</div>
                            <div class="provider-detail-value"><c:out value="${p.timeoutMillis}" default="-"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label">${msg_security_admin_provider_failPolicy}</div>
                            <div class="provider-detail-value"><c:out value="${p.failOpen}" default="-"/></div>
                        </div>
                        <div class="provider-detail-item">
                            <div class="provider-detail-label">${msg_security_admin_provider_lastCheckedAt}</div>
                            <div class="provider-detail-value"><fmt:formatDate value="${p.lastCheckedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                        </div>
                    </div>
                    <div class="provider-detail-item provider-detail-description">
                        <div class="provider-detail-label">${msg_security_admin_common_description}</div>
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
