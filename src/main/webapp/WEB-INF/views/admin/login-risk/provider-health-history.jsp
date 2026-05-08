<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_security_admin_providerHealth_title" code="security.admin.providerHealth.title"/>
<spring:message var="msg_security_admin_providerHealth_providerCodePlaceholder" code="security.admin.providerHealth.providerCodePlaceholder"/>
<spring:message var="msg_security_admin_providerHealth_desc" code="security.admin.providerHealth.desc"/>
<spring:message var="msg_security_admin_nav_providerConfigs" code="security.admin.nav.providerConfigs"/>
<spring:message var="msg_admin_layout_menu_policyHistory" code="admin.layout.menu.policyHistory"/>
<spring:message var="msg_security_admin_providerHealth_providerCode" code="security.admin.providerHealth.providerCode"/>
<spring:message var="msg_security_admin_providerHealth_limit" code="security.admin.providerHealth.limit"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_security_admin_providerHealth_checkedAt" code="security.admin.providerHealth.checkedAt"/>
<spring:message var="msg_security_admin_providerHealth_provider" code="security.admin.providerHealth.provider"/>
<spring:message var="msg_security_admin_providerHealth_checkSource" code="security.admin.providerHealth.checkSource"/>
<spring:message var="msg_security_admin_providerHealth_statusBefore" code="security.admin.providerHealth.statusBefore"/>
<spring:message var="msg_security_admin_providerHealth_statusAfter" code="security.admin.providerHealth.statusAfter"/>
<spring:message var="msg_security_admin_providerHealth_actor" code="security.admin.providerHealth.actor"/>
<spring:message var="msg_security_admin_providerHealth_detail" code="security.admin.providerHealth.detail"/>
<spring:message var="msg_security_admin_providerHealth_empty" code="security.admin.providerHealth.empty"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount" arguments="${fn:length(histories)}"/>
<c:set var="pageTitle" value="${msg_security_admin_providerHealth_title}"/>
<c:set var="activeMenu" value="providerHealthHistory"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-provider-health-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_providerHealth_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_providerHealth_desc}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">${msg_security_admin_nav_providerConfigs}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history?sourceType=PROVIDER_CONFIG">${msg_admin_layout_menu_policyHistory}</a>
        </div>
    </div>

    <form method="get" class="adm-card adm-provider-health-filter-card adm-overflow-visible">
        <div class="adm-card-body">
            <div class="adm-provider-health-filterbar">
                <label class="adm-provider-health-code-field">${msg_security_admin_providerHealth_providerCode}
                    <input class="adm-input" type="text" name="providerCode" value="${fn:escapeXml(providerCode)}" placeholder="${msg_security_admin_providerHealth_providerCodePlaceholder}">
                </label>
                <label class="adm-provider-health-limit-field">${msg_security_admin_providerHealth_limit}
                    <input class="adm-input" type="number" min="1" max="200" name="limit" value="${limit}">
                </label>
                <div class="adm-provider-health-filter-actions">
                    <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_search}</button>
                    <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/provider-health-history">${msg_admin_common_reset}</a>
                </div>
            </div>
        </div>
    </form>

    <div class="adm-card adm-provider-health-list-card adm-overflow-visible">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_security_admin_providerHealth_title}</div>
            <div class="adm-page-muted">${msg_admin_common_totalCount}</div>
        </div>
        <div class="adm-table-wrap">
            <table id="providerHealthHistoryTable"
                   class="adm-table adm-section-table-fixed adm-provider-health-table"
                   data-admin-list-ignore="true"
                   data-section="providerHealthHistory">
                <thead>
                <tr>
                    <th data-sort="checkedAt" onclick="sortProviderHealthRows('checkedAt')">${msg_security_admin_providerHealth_checkedAt}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th data-sort="provider" onclick="sortProviderHealthRows('provider')">${msg_security_admin_providerHealth_provider}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th data-sort="checkSource" onclick="sortProviderHealthRows('checkSource')">${msg_security_admin_providerHealth_checkSource}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th data-sort="statusBefore" onclick="sortProviderHealthRows('statusBefore')">${msg_security_admin_providerHealth_statusBefore}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th data-sort="statusAfter" onclick="sortProviderHealthRows('statusAfter')">${msg_security_admin_providerHealth_statusAfter}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th data-sort="actor" onclick="sortProviderHealthRows('actor')">${msg_security_admin_providerHealth_actor}<span class="sort-ico" aria-hidden="true"></span></th>
                    <th data-sort="detail" onclick="sortProviderHealthRows('detail')">${msg_security_admin_providerHealth_detail}<span class="sort-ico" aria-hidden="true"></span></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="h" items="${histories}" varStatus="st">
                    <fmt:formatDate var="checkedAtDisplay" value="${h.checkedAtDate}" pattern="yyyy-MM-dd HH:mm"/>
                    <tr class="js-provider-health-row"
                        data-checked-at="${h.checkedAt}"
                        data-checked-at-display="${checkedAtDisplay}"
                        data-provider="${fn:escapeXml(h.providerKind)} ${fn:escapeXml(h.providerCode)}"
                        data-provider-kind="${fn:escapeXml(h.providerKind)}"
                        data-provider-code="${fn:escapeXml(h.providerCode)}"
                        data-check-source="${fn:escapeXml(h.checkSource)}"
                        data-status-before="${fn:escapeXml(h.statusBefore)}"
                        data-status-after="${fn:escapeXml(h.statusAfter)}"
                        data-actor="${h.actorUserIdx}"
                        data-detail="${fn:escapeXml(h.detailMessage)}"
                        data-original-index="${st.index}">
                        <td class="adm-provider-health-action-cell" onclick="openProviderHealthCellAction(event, this, 'checkedAt')">${checkedAtDisplay}</td>
                        <td class="adm-provider-health-action-cell" onclick="openProviderHealthCellAction(event, this, 'provider')">
                            <div class="adm-provider-health-provider"><c:out value="${h.providerKind}"/></div>
                            <div class="adm-page-muted"><c:out value="${h.providerCode}"/></div>
                        </td>
                        <td class="adm-provider-health-action-cell" onclick="openProviderHealthCellAction(event, this, 'checkSource')"><span class="adm-badge"><c:out value="${h.checkSource}"/></span></td>
                        <td class="adm-provider-health-action-cell" onclick="openProviderHealthCellAction(event, this, 'statusBefore')"><c:out value="${h.statusBefore}" default="-"/></td>
                        <td class="adm-provider-health-action-cell" onclick="openProviderHealthCellAction(event, this, 'statusAfter')"><c:out value="${h.statusAfter}" default="-"/></td>
                        <td class="adm-provider-health-action-cell" onclick="openProviderHealthCellAction(event, this, 'actor')"><c:out value="${h.actorUserIdx}" default="-"/></td>
                        <td class="adm-provider-health-action-cell" onclick="openProviderHealthCellAction(event, this, 'detail')"><div class="adm-provider-health-detail"><c:out value="${h.detailMessage}" default="-"/></div></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty histories}">
                    <tr class="adm-local-empty"><td colspan="7" class="adm-local-empty-cell">${msg_security_admin_providerHealth_empty}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div id="providerHealthDetailModal" class="adm-modal-overlay" onclick="closeProviderHealthDetail()">
    <div class="adm-modal adm-row-detail-modal" onclick="event.stopPropagation()">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="providerHealthDetailTitle">${msg_security_admin_providerHealth_detail}</div>
            <button class="adm-modal-close" type="button" onclick="closeProviderHealthDetail()">✕</button>
        </div>
        <div class="adm-modal-body adm-row-detail-body">
            <dl id="providerHealthDetailContent" class="adm-row-detail-list"></dl>
        </div>
    </div>
</div>

<script>
var providerHealthSortState = { field: 'checkedAt', dir: 'DESC' };
function providerHealthRows() {
    return Array.from(document.querySelectorAll('#providerHealthHistoryTable .js-provider-health-row'));
}
function providerHealthValue(row, field) {
    if (!row) return '';
    if (field === 'checkedAt') return row.dataset.checkedAt || row.dataset.checkedAtDisplay || '';
    if (field === 'provider') return row.dataset.provider || '';
    if (field === 'checkSource') return row.dataset.checkSource || '';
    if (field === 'statusBefore') return row.dataset.statusBefore || '';
    if (field === 'statusAfter') return row.dataset.statusAfter || '';
    if (field === 'actor') return row.dataset.actor || '';
    if (field === 'detail') return row.dataset.detail || '';
    return row.dataset.originalIndex || '';
}
function sortProviderHealthRows(field) {
    providerHealthSortState.dir = (providerHealthSortState.field === field && providerHealthSortState.dir === 'DESC') ? 'ASC' : 'DESC';
    providerHealthSortState.field = field;
    var tbody = document.querySelector('#providerHealthHistoryTable tbody');
    if (!tbody) return;
    providerHealthRows().sort(function(a, b) {
        var av = providerHealthValue(a, field);
        var bv = providerHealthValue(b, field);
        var cmp = String(av).localeCompare(String(bv), undefined, { numeric: true, sensitivity: 'base' });
        return cmp * (providerHealthSortState.dir === 'DESC' ? -1 : 1);
    }).forEach(function(row) { tbody.appendChild(row); });
    updateProviderHealthSortIndicators();
}
function updateProviderHealthSortIndicators() {
    document.querySelectorAll('#providerHealthHistoryTable th[data-sort]').forEach(function(th) {
        var active = th.dataset.sort === providerHealthSortState.field;
        th.classList.toggle('sorted', active);
        var ico = th.querySelector('.sort-ico');
        if (ico) {
            ico.textContent = active ? (providerHealthSortState.dir === 'DESC' ? '▼' : '▲') : '';
            ico.className = 'sort-ico ' + (active ? providerHealthSortState.dir.toLowerCase() : '');
        }
    });
}
function closeProviderHealthDetail() {
    var modal = document.getElementById('providerHealthDetailModal');
    if (modal) modal.classList.remove('open');
}
function openProviderHealthDetail(row, focusKey) {
    if (!row) return;
    var content = document.getElementById('providerHealthDetailContent');
    if (!content) return;
    var fields = [
        ['${msg_security_admin_providerHealth_checkedAt}', row.dataset.checkedAtDisplay, 'checkedAt'],
        ['${msg_security_admin_providerHealth_provider}', row.dataset.provider, 'provider'],
        ['${msg_security_admin_providerHealth_checkSource}', row.dataset.checkSource, 'checkSource'],
        ['${msg_security_admin_providerHealth_statusBefore}', row.dataset.statusBefore, 'statusBefore'],
        ['${msg_security_admin_providerHealth_statusAfter}', row.dataset.statusAfter, 'statusAfter'],
        ['${msg_security_admin_providerHealth_actor}', row.dataset.actor, 'actor'],
        ['${msg_security_admin_providerHealth_detail}', row.dataset.detail, 'detail']
    ];
    content.innerHTML = '';
    fields.forEach(function(pair) {
        if (!pair[1]) return;
        var dt = document.createElement('dt');
        dt.className = 'adm-row-detail-label';
        dt.textContent = pair[0];
        var dd = document.createElement('dd');
        dd.className = 'adm-row-detail-value' + (pair[2] === focusKey ? ' is-focus-flash' : '');
        dd.textContent = pair[1];
        content.appendChild(dt);
        content.appendChild(dd);
    });
    document.getElementById('providerHealthDetailModal').classList.add('open');
}
function openProviderHealthCellAction(event, cell, focusKey) {
    if (event && event.target && event.target.closest('button, a, input, select, textarea, label')) {
        return true;
    }
    openProviderHealthDetail(cell ? cell.closest('.js-provider-health-row') : null, focusKey);
    if (event) {
        event.preventDefault();
        event.stopPropagation();
    }
    return false;
}
document.addEventListener('DOMContentLoaded', updateProviderHealthSortIndicators);
</script>

<%@ include file="../layout-close.jsp" %>
