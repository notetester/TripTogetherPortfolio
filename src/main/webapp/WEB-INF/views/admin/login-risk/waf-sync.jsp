<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_wafSync_title" code="security.admin.wafSync.title"/>
<spring:message var="msg_security_admin_placeholder_wafSync" code="security.admin.placeholder.wafSync"/>
<spring:message var="msg_security_admin_placeholder_wafTargetType" code="security.admin.placeholder.wafTargetType"/>
<spring:message var="msg_security_admin_wafSync_desc" code="security.admin.wafSync.desc"/>
<spring:message var="msg_security_admin_nav_providerConfigs" code="security.admin.nav.providerConfigs"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_admin_layout_menu_policyHistory" code="admin.layout.menu.policyHistory"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_all" code="security.admin.common.all"/>
<spring:message var="msg_security_admin_common_targetType" code="security.admin.common.targetType"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_wafSync_source" code="security.admin.wafSync.source"/>
<spring:message var="msg_security_admin_wafSync_action" code="security.admin.wafSync.action"/>
<spring:message var="msg_security_admin_common_target" code="security.admin.common.target"/>
<spring:message var="msg_security_admin_common_description" code="security.admin.common.description"/>
<spring:message var="msg_security_admin_common_createdAt" code="security.admin.common.createdAt"/>
<spring:message var="msg_security_admin_wafSync_lastResultAt" code="security.admin.wafSync.lastResultAt"/>
<spring:message var="msg_security_admin_common_action" code="security.admin.common.action"/>
<spring:message var="msg_security_admin_wafSync_updatedAt" code="security.admin.wafSync.updatedAt"/>
<spring:message var="msg_security_admin_wafSync_syncedAt" code="security.admin.wafSync.syncedAt"/>
<spring:message var="msg_security_admin_common_detail" code="security.admin.common.detail"/>
<spring:message var="msg_security_admin_wafSync_retry" code="security.admin.wafSync.retry"/>
<spring:message var="msg_security_admin_wafSync_detailTitle" code="security.admin.wafSync.detailTitle"/>
<spring:message var="msg_security_admin_common_close" code="security.admin.common.close"/>
<spring:message var="msg_security_admin_empty_wafSync" code="security.admin.empty.wafSync"/>
<c:set var="pageTitle" value="${msg_security_admin_wafSync_title}"/>
<c:set var="activeMenu" value="securityWafSync"/>


<%@ include file="../layout.jsp" %>
<style>
    .sync-detail { white-space: pre-wrap; max-width: 520px; line-height: 1.55; }
    .sync-meta { display:block; color:#64748b; font-size:12px; margin-top:6px; }
    .waf-detail-modal[hidden] { display:none; }
    .waf-detail-modal { position:fixed; inset:0; z-index:2000; background:rgba(15,23,42,.55); display:flex; align-items:center; justify-content:center; padding:24px; }
    .waf-detail-card { width:min(920px,96vw); max-height:88vh; overflow:auto; background:#fff; border-radius:20px; box-shadow:0 24px 70px rgba(15,23,42,.28); border:1px solid #e2e8f0; }
    .waf-detail-head { display:flex; justify-content:space-between; gap:12px; align-items:flex-start; padding:20px 22px; border-bottom:1px solid #e2e8f0; }
    .waf-detail-body { padding:20px 22px; }
    .waf-detail-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:12px; }
    .waf-detail-item { border:1px solid #e2e8f0; border-radius:14px; padding:12px; background:#f8fafc; }
    .waf-detail-label { font-size:12px; color:#64748b; font-weight:700; margin-bottom:6px; }
    .waf-detail-value { white-space:pre-wrap; word-break:break-word; color:#0f172a; }
    .waf-detail-close { border:0; background:#e2e8f0; border-radius:10px; padding:8px 12px; cursor:pointer; font-weight:800; }
    @media (max-width:720px) { .waf-detail-grid { grid-template-columns:1fr; } }
</style>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_wafSync_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_wafSync_desc}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">${msg_security_admin_nav_providerConfigs}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history?sourceType=PROVIDER_CONFIG">${msg_admin_layout_menu_policyHistory}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
            <label>${msg_security_admin_common_status}
                <select class="adm-input" name="status">
                    <option value="">${msg_security_admin_common_all}</option>
                    <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    <option value="EXTERNAL_PROVIDER_PENDING" ${status == 'EXTERNAL_PROVIDER_PENDING' ? 'selected' : ''}>EXTERNAL_PROVIDER_PENDING</option>
                    <option value="SYNCED" ${status == 'SYNCED' ? 'selected' : ''}>SYNCED</option>
                    <option value="FAILED" ${status == 'FAILED' ? 'selected' : ''}>FAILED</option>
                </select>
            </label>
            <label>${msg_security_admin_common_targetType}
                <input class="adm-input" type="text" name="targetType" value="${fn:escapeXml(targetType)}" placeholder="${msg_security_admin_placeholder_wafTargetType}">
            </label>
            <label>${msg_security_admin_common_search}
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_wafSync}">
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
                <th>${msg_security_admin_common_status}</th>
                <th>${msg_security_admin_wafSync_source}</th>
                <th>${msg_security_admin_wafSync_action}</th>
                <th>${msg_security_admin_common_target}</th>
                <th>${msg_security_admin_common_description}</th>
                <th>${msg_security_admin_common_createdAt}</th>
                <th>${msg_security_admin_wafSync_lastResultAt}</th>
                <th>${msg_security_admin_common_action}</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="i" items="${items}">
                <tr>
                    <td><span class="adm-badge"><c:out value="${i.status}"/></span></td>
                    <td><c:out value="${i.sourceType}"/> #<c:out value="${i.sourceId}"/></td>
                    <td><c:out value="${i.syncAction}"/></td>
                    <td><c:out value="${i.targetType}"/>: <c:out value="${i.targetValue}"/></td>
                    <td><div class="sync-detail"><c:out value="${i.detailMessage}"/></div></td>
                    <td><fmt:formatDate value="${i.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <span class="sync-meta">${msg_security_admin_wafSync_updatedAt}: <fmt:formatDate value="${i.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                        <span class="sync-meta">${msg_security_admin_wafSync_syncedAt}: <fmt:formatDate value="${i.syncedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </td>
                    <td>
                        <button class="adm-btn js-waf-modal-open" type="button" data-modal-id="waf-detail-${i.syncIdx}">
                            ${msg_security_admin_common_detail}
                        </button>
                        <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/waf-sync/${i.syncIdx}/retry" style="display:inline;">
                            <button class="adm-btn" type="submit">${msg_security_admin_wafSync_retry}</button>
                        </form>
                    </td>
                </tr>
                <tr style="display:none;"><td colspan="8">
                    <div class="waf-detail-modal" id="waf-detail-${i.syncIdx}" hidden>
                        <div class="waf-detail-card" role="dialog" aria-modal="true" aria-labelledby="waf-detail-title-${i.syncIdx}">
                            <div class="waf-detail-head">
                                <div>
                                    <h2 id="waf-detail-title-${i.syncIdx}" style="margin:0;">${msg_security_admin_wafSync_detailTitle}</h2>
                                    <div class="adm-muted">#<c:out value="${i.syncIdx}"/> · <c:out value="${i.status}"/></div>
                                </div>
                                <button class="waf-detail-close js-waf-modal-close" type="button">${msg_security_admin_common_close}</button>
                            </div>
                            <div class="waf-detail-body">
                                <div class="waf-detail-grid">
                                    <div class="waf-detail-item">
                                        <div class="waf-detail-label">${msg_security_admin_common_status}</div>
                                        <div class="waf-detail-value"><c:out value="${i.status}" default="-"/></div>
                                    </div>
                                    <div class="waf-detail-item">
                                        <div class="waf-detail-label">${msg_security_admin_wafSync_source}</div>
                                        <div class="waf-detail-value"><c:out value="${i.sourceType}" default="-"/> #<c:out value="${i.sourceId}" default="-"/></div>
                                    </div>
                                    <div class="waf-detail-item">
                                        <div class="waf-detail-label">${msg_security_admin_wafSync_action}</div>
                                        <div class="waf-detail-value"><c:out value="${i.syncAction}" default="-"/></div>
                                    </div>
                                    <div class="waf-detail-item">
                                        <div class="waf-detail-label">${msg_security_admin_common_target}</div>
                                        <div class="waf-detail-value"><c:out value="${i.targetType}" default="-"/>: <c:out value="${i.targetValue}" default="-"/></div>
                                    </div>
                                    <div class="waf-detail-item">
                                        <div class="waf-detail-label">${msg_security_admin_common_createdAt}</div>
                                        <div class="waf-detail-value"><fmt:formatDate value="${i.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                    </div>
                                    <div class="waf-detail-item">
                                        <div class="waf-detail-label">${msg_security_admin_wafSync_lastResultAt}</div>
                                        <div class="waf-detail-value">
                                            ${msg_security_admin_wafSync_updatedAt}: <fmt:formatDate value="${i.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/><br>
                                            ${msg_security_admin_wafSync_syncedAt}: <fmt:formatDate value="${i.syncedAtDate}" pattern="yyyy-MM-dd HH:mm"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="waf-detail-item" style="margin-top:12px;">
                                    <div class="waf-detail-label">${msg_security_admin_common_description}</div>
                                    <div class="waf-detail-value"><c:out value="${i.detailMessage}" default="-"/></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </td></tr>
            </c:forEach>
            <c:if test="${empty items}">
                <tr><td colspan="8" class="adm-empty">${msg_security_admin_empty_wafSync}</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<script>
(function () {
    const closeModal = function (modal) { if (modal) modal.hidden = true; };
    const openModal = function (modal) { if (modal) modal.hidden = false; };
    document.querySelectorAll('.js-waf-modal-open').forEach(function (button) {
        button.addEventListener('click', function () {
            openModal(document.getElementById(button.dataset.modalId));
        });
    });
    document.querySelectorAll('.js-waf-modal-close').forEach(function (button) {
        button.addEventListener('click', function () {
            closeModal(button.closest('.waf-detail-modal'));
        });
    });
    document.querySelectorAll('.waf-detail-modal').forEach(function (modal) {
        modal.addEventListener('click', function (event) {
            if (event.target === modal) closeModal(modal);
        });
    });
    document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') {
            document.querySelectorAll('.waf-detail-modal:not([hidden])').forEach(closeModal);
        }
    });
})();
</script>
