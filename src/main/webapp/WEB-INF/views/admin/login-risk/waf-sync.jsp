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
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount" arguments="${fn:length(items)}"/>
<c:set var="pageTitle" value="${msg_security_admin_wafSync_title}"/>
<c:set var="activeMenu" value="securityWafSync"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-waf-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_wafSync_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_wafSync_desc}</p>
        </div>
        <div class="adm-actions adm-waf-page-actions">
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">${msg_security_admin_nav_providerConfigs}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/policy-history?sourceType=PROVIDER_CONFIG">${msg_admin_layout_menu_policyHistory}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card adm-waf-filter-card adm-overflow-visible">
        <div class="adm-card-body">
            <div class="adm-waf-filterbar">
                <label>${msg_security_admin_common_status}
                    <select class="adm-select" name="status">
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
                <label class="adm-waf-keyword-field">${msg_security_admin_common_search}
                    <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_wafSync}">
                </label>
                <div class="adm-waf-filter-actions">
                    <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_search}</button>
                    <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/waf-sync">${msg_admin_common_reset}</a>
                </div>
            </div>
        </div>
    </form>

    <div class="adm-card adm-waf-list-card adm-overflow-visible">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_security_admin_wafSync_title}</div>
            <div class="adm-page-muted">${msg_admin_common_totalCount}</div>
        </div>
        <div class="adm-table-wrap">
            <table id="securityWafSyncTable"
                   class="adm-table adm-section-table-fixed adm-waf-table"
                   data-section="securityWafSync">
                <thead>
                <tr>
                    <th onclick="sortStaticAdminTable('securityWafSyncTable', 0)">${msg_security_admin_common_status}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th onclick="sortStaticAdminTable('securityWafSyncTable', 1)">${msg_security_admin_wafSync_source}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th onclick="sortStaticAdminTable('securityWafSyncTable', 2)">${msg_security_admin_wafSync_action}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th onclick="sortStaticAdminTable('securityWafSyncTable', 3)">${msg_security_admin_common_target}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th onclick="sortStaticAdminTable('securityWafSyncTable', 4)">${msg_security_admin_common_description}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th onclick="sortStaticAdminTable('securityWafSyncTable', 5)">${msg_security_admin_common_createdAt}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th onclick="sortStaticAdminTable('securityWafSyncTable', 6)">${msg_security_admin_wafSync_lastResultAt}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th onclick="openFirstWafDetail()">${msg_security_admin_common_action}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="i" items="${items}">
                    <tr>
                        <td><span class="adm-badge"><c:out value="${i.status}"/></span></td>
                        <td>
                            <div class="adm-waf-primary"><c:out value="${i.sourceType}"/></div>
                            <div class="adm-page-muted">#<c:out value="${i.sourceId}"/></div>
                        </td>
                        <td><div class="adm-waf-primary"><c:out value="${i.syncAction}"/></div></td>
                        <td>
                            <div><c:out value="${i.targetType}"/>: <c:out value="${i.targetValue}"/></div>
                        </td>
                        <td>
                            <button class="adm-waf-detail-trigger js-waf-modal-open" type="button" data-modal-id="waf-detail-${i.syncIdx}">
                                <span class="sync-detail"><c:out value="${i.detailMessage}"/></span>
                                <span class="adm-waf-more">${msg_security_admin_common_detail}</span>
                            </button>
                        </td>
                        <td><fmt:formatDate value="${i.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <span class="sync-meta">${msg_security_admin_wafSync_updatedAt}: <fmt:formatDate value="${i.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                            <span class="sync-meta">${msg_security_admin_wafSync_syncedAt}: <fmt:formatDate value="${i.syncedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                        </td>
                        <td>
                            <div class="adm-waf-row-actions">
                                <button class="adm-btn adm-btn-ghost js-waf-modal-open" type="button" data-modal-id="waf-detail-${i.syncIdx}">
                                    ${msg_security_admin_common_detail}
                                </button>
                                <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/waf-sync/${i.syncIdx}/retry">
                                    <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_wafSync_retry}</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty items}">
                    <tr class="adm-local-empty"><td colspan="8" class="adm-local-empty-cell">${msg_security_admin_empty_wafSync}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <c:forEach var="i" items="${items}">
            <div class="waf-detail-modal" id="waf-detail-${i.syncIdx}" hidden>
                <div class="waf-detail-card" role="dialog" aria-modal="true" aria-labelledby="waf-detail-title-${i.syncIdx}">
                    <div class="waf-detail-head">
                        <div>
                            <h2 id="waf-detail-title-${i.syncIdx}" class="waf-detail-title">${msg_security_admin_wafSync_detailTitle}</h2>
                            <div class="adm-page-muted">#<c:out value="${i.syncIdx}"/> · <c:out value="${i.status}"/></div>
                        </div>
                        <button class="adm-btn adm-btn-ghost js-waf-modal-close" type="button">${msg_security_admin_common_close}</button>
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
                                    <div>${msg_security_admin_wafSync_updatedAt}: <fmt:formatDate value="${i.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                    <div>${msg_security_admin_wafSync_syncedAt}: <fmt:formatDate value="${i.syncedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                </div>
                            </div>
                        </div>
                        <div class="waf-detail-stack">
                            <div class="waf-detail-item">
                                <div class="waf-detail-label">${msg_security_admin_common_description}</div>
                                <div class="waf-detail-value"><c:out value="${i.detailMessage}" default="-"/></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
function sortStaticAdminTable(tableId, columnIndex) {
    const table = document.getElementById(tableId);
    const tbody = table ? table.querySelector('tbody') : null;
    if (!tbody) return;
    const prevIndex = Number(table.dataset.sortIndex || -1);
    const prevDir = table.dataset.sortDir || 'ASC';
    const nextDir = prevIndex === columnIndex && prevDir === 'ASC' ? 'DESC' : 'ASC';
    table.dataset.sortIndex = String(columnIndex);
    table.dataset.sortDir = nextDir;
    Array.from(tbody.querySelectorAll('tr'))
        .filter(function(row) { return row.children.length > columnIndex && !row.querySelector('td[colspan]'); })
        .sort(function(a, b) {
            const av = (a.children[columnIndex].innerText || '').replace(/\s+/g, ' ').trim();
            const bv = (b.children[columnIndex].innerText || '').replace(/\s+/g, ' ').trim();
            return av.localeCompare(bv, undefined, { numeric: true, sensitivity: 'base' }) * (nextDir === 'ASC' ? 1 : -1);
        })
        .forEach(function(row) { tbody.appendChild(row); });
    table.querySelectorAll('th').forEach(function(th, idx) {
        const ico = th.querySelector('.sort-ico');
        if (ico) ico.textContent = idx === columnIndex ? (nextDir === 'ASC' ? '▲' : '▼') : '';
    });
}
function openFirstWafDetail() {
    const button = document.querySelector('#securityWafSyncTable .js-waf-modal-open');
    if (button) button.click();
}
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

<%@ include file="../layout-close.jsp" %>
