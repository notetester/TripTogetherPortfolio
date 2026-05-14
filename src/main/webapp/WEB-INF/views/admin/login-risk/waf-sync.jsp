<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations --%>
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
<spring:message var="msg_admin_common_export" code="admin.common.export"/>
<spring:message var="msg_admin_common_exportAll" code="admin.common.exportAll"/>
<spring:message var="msg_admin_common_exportFiltered" code="admin.common.exportFiltered"/>
<spring:message var="msg_admin_common_exportSelected" code="admin.common.exportSelected"/>
<spring:message var="msg_admin_common_apply" code="admin.common.apply"/>
<spring:message var="msg_admin_common_clearSelection" code="admin.common.clearSelection"/>
<spring:message var="msg_admin_common_selectedCount" code="admin.common.selectedCount"/>
<spring:message var="msg_admin_common_prev" code="admin.common.prev"/>
<spring:message var="msg_admin_common_next" code="admin.common.next"/>
<spring:message var="msg_admin_common_pageSizeLabel" code="admin.common.pageSizeLabel"/>
<spring:message var="msg_admin_common_pageSize_10" code="admin.common.pageSize" arguments="10"/>
<spring:message var="msg_admin_common_pageSize_20" code="admin.common.pageSize" arguments="20"/>
<spring:message var="msg_admin_common_pageSize_50" code="admin.common.pageSize" arguments="50"/>
<spring:message var="msg_admin_common_pageSize_100" code="admin.common.pageSize" arguments="100"/>
<spring:message var="msg_lrr_sortReset" code="security.admin.loginReviews.sortReset"/>
<spring:message var="msg_lrr_pickAction" code="security.admin.loginReviews.pickActionMsg"/>
<spring:message var="msg_lrr_noSelection" code="security.admin.loginReviews.noSelectionMsg"/>
<spring:message var="msg_lrr_pageSearchPlaceholder" code="security.admin.loginReviews.pageSearchPlaceholder"/>
<spring:message var="msg_lrr_bulkActionPlaceholder" code="security.admin.loginReviews.bulkActionPlaceholder"/>

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

    <form id="wfSearchForm" method="get" class="adm-card adm-waf-filter-card adm-overflow-visible">
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
        <div class="adm-card-head wf-card-head">
            <div class="adm-card-title">
                ${msg_security_admin_wafSync_title}
                <span class="wf-total-label" id="wfTotalLabel">${msg_admin_common_totalCount}</span>
            </div>
            <div class="adm-export-control wf-export-control">
                <select class="adm-select wf-export-format" id="wfExportFormat">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost js-wf-export-toggle">${msg_admin_common_export} ▾</button>
                <div id="wfExportDropdown" class="adm-export-dropdown">
                    <button type="button" class="adm-export-item" onclick="wfExport('all')">${msg_admin_common_exportAll}</button>
                    <button type="button" class="adm-export-item" onclick="wfExport('filtered')">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="adm-export-item" id="wfExportSelectedBtn" disabled onclick="wfExport('selected')">${msg_admin_common_exportSelected} (0)</button>
                </div>
            </div>
        </div>

        <div class="wf-controlbar">
            <div id="wfBulkBar" class="wf-bulkbar" aria-live="polite" aria-hidden="true">
                <span class="wf-bulk-count"><strong id="wfBulkCount">0</strong>${msg_admin_common_selectedCount}</span>
                <div class="wf-bulk-actions">
                    <select class="adm-select" id="wfBulkActionSelect">
                        <option value="">${msg_lrr_bulkActionPlaceholder}</option>
                        <option value="retry">${msg_security_admin_wafSync_retry}</option>
                    </select>
                    <button type="button" class="adm-btn adm-btn-primary" onclick="wfApplyBulk()">${msg_admin_common_apply}</button>
                </div>
                <button type="button" class="adm-btn adm-btn-ghost wf-bulk-clear" onclick="wfClearSelection()">${msg_admin_common_clearSelection}</button>
            </div>
            <div class="wf-view-tools">
                <button type="button" class="adm-btn adm-btn-ghost wf-sort-reset adm-is-hidden" id="wfSortReset" onclick="wfResetSort()">${msg_lrr_sortReset}</button>
                <label class="wf-tool wf-page-search-tool">
                    <input class="adm-input wf-page-search" id="wfPageSearch" type="text" placeholder="${msg_lrr_pageSearchPlaceholder}" oninput="wfSetPageSearch(this.value)">
                </label>
                <label class="wf-tool">
                    <span class="wf-tool-label">${msg_admin_common_pageSizeLabel}</span>
                    <select class="adm-select wf-page-size" id="wfPageSize" onchange="wfChangeSize(this.value)">
                        <option value="10">${msg_admin_common_pageSize_10}</option>
                        <option value="20" selected>${msg_admin_common_pageSize_20}</option>
                        <option value="50">${msg_admin_common_pageSize_50}</option>
                        <option value="100">${msg_admin_common_pageSize_100}</option>
                    </select>
                </label>
            </div>
        </div>

        <div class="adm-table-wrap">
            <table id="securityWafSyncTable"
                   class="adm-table adm-section-table-fixed adm-waf-table wf-table"
                   data-section="securityWafSync"
                   data-admin-list-ignore="hard">
                <colgroup>
                    <col class="wf-col-check"/>
                    <col class="wf-col-status"/>
                    <col class="wf-col-source"/>
                    <col class="wf-col-action"/>
                    <col class="wf-col-target"/>
                    <col class="wf-col-desc"/>
                    <col class="wf-col-created"/>
                    <col class="wf-col-result"/>
                    <col class="wf-col-rowaction"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="wf-th wf-th-check"><input type="checkbox" id="wfCheckAll" onchange="wfToggleAll(this)" aria-label="select-all"></th>
                    <th class="wf-th wf-sortable" data-sort="status" onclick="wfSortBy('status')"><span class="wf-th-label">${msg_security_admin_common_status}</span><span class="wf-sort-ico" aria-hidden="true"></span></th>
                    <th class="wf-th wf-sortable" data-sort="source" onclick="wfSortBy('source')"><span class="wf-th-label">${msg_security_admin_wafSync_source}</span><span class="wf-sort-ico" aria-hidden="true"></span></th>
                    <th class="wf-th wf-sortable" data-sort="syncaction" onclick="wfSortBy('syncaction')"><span class="wf-th-label">${msg_security_admin_wafSync_action}</span><span class="wf-sort-ico" aria-hidden="true"></span></th>
                    <th class="wf-th wf-sortable" data-sort="target" onclick="wfSortBy('target')"><span class="wf-th-label">${msg_security_admin_common_target}</span><span class="wf-sort-ico" aria-hidden="true"></span></th>
                    <th class="wf-th"><span class="wf-th-label">${msg_security_admin_common_description}</span></th>
                    <th class="wf-th wf-sortable" data-sort="created" onclick="wfSortBy('created')"><span class="wf-th-label">${msg_security_admin_common_createdAt}</span><span class="wf-sort-ico" aria-hidden="true"></span></th>
                    <th class="wf-th wf-sortable" data-sort="updated" onclick="wfSortBy('updated')"><span class="wf-th-label">${msg_security_admin_wafSync_lastResultAt}</span><span class="wf-sort-ico" aria-hidden="true"></span></th>
                    <th class="wf-th"><span class="wf-th-label">${msg_security_admin_common_action}</span></th>
                </tr>
                </thead>
                <tbody id="wfTableBody">
                <c:forEach var="i" items="${items}">
                    <tr data-row-id="${i.syncIdx}"
                        data-sort-status="${fn:escapeXml(i.status)}"
                        data-sort-source="${fn:escapeXml(i.sourceType)}|${i.sourceId}"
                        data-sort-syncaction="${fn:escapeXml(i.syncAction)}"
                        data-sort-target="${fn:escapeXml(i.targetType)}:${fn:escapeXml(i.targetValue)}"
                        data-sort-created="<fmt:formatDate value='${i.createdAtDate}' pattern='yyyyMMddHHmm'/>"
                        data-sort-updated="<fmt:formatDate value='${i.updatedAtDate}' pattern='yyyyMMddHHmm'/>">
                        <td class="wf-cell-check"><input type="checkbox" class="js-wf-row-check" value="${i.syncIdx}" onchange="wfUpdateBulkCount()" aria-label="row-select"></td>
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
                </tbody>
            </table>
            <div class="wf-empty adm-is-hidden" id="wfEmptyState">${msg_security_admin_empty_wafSync}</div>
        </div>

        <div class="wf-pagination" id="wfPaging">
            <div class="wf-page-info"><span id="wfPageInfo"></span></div>
            <div class="wf-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost" id="wfPrevBtn" onclick="wfGoPage(window.wfState.page - 1)">${msg_admin_common_prev}</button>
                <span class="wf-page-state" id="wfPageState"></span>
                <button type="button" class="adm-btn adm-btn-ghost" id="wfNextBtn" onclick="wfGoPage(window.wfState.page + 1)">${msg_admin_common_next}</button>
            </div>
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
(function () {
    'use strict';
    /* ─── WAF 동기화 큐 — 클라이언트 사이드 페이징·정렬·검색·체크박스 일괄 retry ───
       로딩 방식 결정: 서버 getWafSyncQueue() 는 LIMIT 없이 status/targetType/keyword 서버
       필터 후 전 결과 반환. 단건 retry POST 를 ids 기반 bulk 로 일원화. detail 모달 유지. */
    var ctx = '${pageContext.request.contextPath}';

    var WF_MSG = {
        exportSelectedLabel: '${msg_admin_common_exportSelected}',
        pickAction: '${msg_lrr_pickAction}',
        noSelection: '${msg_lrr_noSelection}',
        bulkConfirmTpl: '<spring:message code="security.admin.loginReviews.bulkConfirm" arguments="{0}" javaScriptEscape="true"/>'
    };

    var wfState = {
        page: 1, pageSize: 20,
        sortBy: '', sortDir: 'ASC',
        pageSearch: '',
        rows: [], filtered: []
    };
    window.wfState = wfState;

    function cacheRows() {
        var tbody = document.getElementById('wfTableBody');
        if (!tbody) return;
        wfState.rows = Array.prototype.slice.call(tbody.querySelectorAll('tr[data-row-id]'));
    }
    function applyFilter() {
        var q = (wfState.pageSearch || '').trim().toLowerCase();
        if (!q) { wfState.filtered = wfState.rows.slice(); return; }
        wfState.filtered = wfState.rows.filter(function (tr) {
            return ((tr.innerText || tr.textContent) || '').toLowerCase().indexOf(q) !== -1;
        });
    }
    function applySort() {
        if (!wfState.sortBy) return;
        var dir = wfState.sortDir === 'DESC' ? -1 : 1;
        var attr = 'data-sort-' + wfState.sortBy;
        wfState.filtered.sort(function (a, b) {
            var av = (a.getAttribute(attr) || '').toLowerCase();
            var bv = (b.getAttribute(attr) || '').toLowerCase();
            return av.localeCompare(bv, undefined, { numeric: true, sensitivity: 'base' }) * dir;
        });
    }
    function render() {
        var tbody = document.getElementById('wfTableBody');
        if (!tbody) return;
        var total = wfState.filtered.length;
        var pageSize = wfState.pageSize > 0 ? wfState.pageSize : 20;
        var totalPage = Math.max(1, Math.ceil(total / pageSize));
        if (wfState.page > totalPage) wfState.page = totalPage;
        if (wfState.page < 1) wfState.page = 1;
        var start = (wfState.page - 1) * pageSize;
        var slice = wfState.filtered.slice(start, start + pageSize);

        wfState.rows.forEach(function (tr) { if (tr.parentNode === tbody) tbody.removeChild(tr); });
        Array.prototype.slice.call(tbody.querySelectorAll('.wf-empty-row')).forEach(function (tr) { tr.remove(); });
        slice.forEach(function (tr) { tbody.appendChild(tr); });
        if (slice.length === 0) {
            var emptyTpl = document.getElementById('wfEmptyState');
            var emptyText = emptyTpl ? emptyTpl.textContent : '';
            var emptyTr = document.createElement('tr');
            emptyTr.className = 'wf-empty-row';
            var td = document.createElement('td');
            td.colSpan = 9; td.className = 'wf-empty-cell'; td.textContent = emptyText;
            emptyTr.appendChild(td);
            tbody.appendChild(emptyTr);
        }

        var info = document.getElementById('wfPageInfo');
        if (info) info.textContent = total + ' / ' + wfState.rows.length;
        var stateEl = document.getElementById('wfPageState');
        if (stateEl) stateEl.textContent = wfState.page + ' / ' + totalPage;
        var prev = document.getElementById('wfPrevBtn');
        var next = document.getElementById('wfNextBtn');
        if (prev) prev.disabled = wfState.page <= 1;
        if (next) next.disabled = wfState.page >= totalPage;

        Array.prototype.slice.call(document.querySelectorAll('#securityWafSyncTable thead th.wf-sortable')).forEach(function (th) {
            var ico = th.querySelector('.wf-sort-ico');
            if (!ico) return;
            ico.textContent = (th.getAttribute('data-sort') === wfState.sortBy)
                ? (wfState.sortDir === 'DESC' ? '▼' : '▲')
                : '';
        });
        var resetBtn = document.getElementById('wfSortReset');
        if (resetBtn) resetBtn.classList.toggle('adm-is-hidden', !wfState.sortBy);

        updateBulkCount();
    }
    function applyAll() { applyFilter(); applySort(); render(); }

    function updateBulkCount() {
        var checked = document.querySelectorAll('#wfTableBody .js-wf-row-check:checked');
        var n = checked.length;
        var bulkBar = document.getElementById('wfBulkBar');
        if (bulkBar) {
            bulkBar.classList.toggle('is-active', n > 0);
            bulkBar.setAttribute('aria-hidden', n > 0 ? 'false' : 'true');
            bulkBar.querySelectorAll('select, button').forEach(function (el) { el.disabled = n === 0; });
        }
        var countEl = document.getElementById('wfBulkCount');
        if (countEl) countEl.textContent = n;
        var selBtn = document.getElementById('wfExportSelectedBtn');
        if (selBtn) {
            selBtn.disabled = n === 0;
            selBtn.textContent = WF_MSG.exportSelectedLabel + ' (' + n + ')';
        }
        var checkAll = document.getElementById('wfCheckAll');
        if (checkAll) {
            var visible = document.querySelectorAll('#wfTableBody .js-wf-row-check');
            checkAll.checked = visible.length > 0 && n === visible.length;
            checkAll.indeterminate = n > 0 && n < visible.length;
        }
    }
    window.wfUpdateBulkCount = updateBulkCount;

    window.wfToggleAll = function (cb) {
        document.querySelectorAll('#wfTableBody .js-wf-row-check').forEach(function (c) { c.checked = cb.checked; });
        updateBulkCount();
    };
    window.wfClearSelection = function () {
        document.querySelectorAll('#wfTableBody .js-wf-row-check').forEach(function (c) { c.checked = false; });
        var checkAll = document.getElementById('wfCheckAll');
        if (checkAll) { checkAll.checked = false; checkAll.indeterminate = false; }
        updateBulkCount();
    };

    window.wfSortBy = function (field) {
        if (wfState.sortBy === field) {
            wfState.sortDir = (wfState.sortDir === 'ASC') ? 'DESC' : 'ASC';
        } else { wfState.sortBy = field; wfState.sortDir = 'ASC'; }
        wfState.page = 1; applyAll();
    };
    window.wfResetSort = function () {
        wfState.sortBy = ''; wfState.sortDir = 'ASC'; wfState.page = 1; applyAll();
    };
    window.wfChangeSize = function (size) {
        var n = parseInt(size, 10);
        wfState.pageSize = (n > 0 ? n : 20);
        wfState.page = 1; render();
    };
    window.wfGoPage = function (p) {
        var total = wfState.filtered.length;
        var totalPage = Math.max(1, Math.ceil(total / wfState.pageSize));
        var next = Math.min(Math.max(1, parseInt(p, 10) || 1), totalPage);
        if (next === wfState.page) return;
        wfState.page = next; render();
    };
    window.wfSetPageSearch = function (text) {
        wfState.pageSearch = text || ''; wfState.page = 1; applyAll();
    };

    window.wfApplyBulk = function () {
        var action = (document.getElementById('wfBulkActionSelect') || {}).value || '';
        if (!action) { alert(WF_MSG.pickAction); return; }
        var checked = Array.prototype.slice.call(document.querySelectorAll('#wfTableBody .js-wf-row-check:checked'));
        if (!checked.length) { alert(WF_MSG.noSelection); return; }
        var confirmMsg = (WF_MSG.bulkConfirmTpl || '').replace('{0}', String(checked.length));
        if (!window.confirm(confirmMsg)) return;

        var ids = checked.map(function (c) { return c.value; }).join(',');
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = ctx + '/admin/login-risk/waf-sync/bulk';
        function addInput(name, value) {
            var inp = document.createElement('input');
            inp.type = 'hidden'; inp.name = name; inp.value = value;
            form.appendChild(inp);
        }
        addInput('action', action);
        addInput('ids', ids);
        document.body.appendChild(form);
        form.submit();
    };

    window.wfExport = function (scope) {
        var format = (document.getElementById('wfExportFormat') || {}).value || 'csv';
        var params = new URLSearchParams();
        params.set('scope', scope);
        params.set('format', format);
        if (scope === 'filtered') {
            var form = document.getElementById('wfSearchForm');
            if (form) {
                var fd = new FormData(form);
                fd.forEach(function (v, k) { if (v) params.set(k, v); });
            }
        }
        if (scope === 'selected') {
            var ids = Array.prototype.slice.call(document.querySelectorAll('#wfTableBody .js-wf-row-check:checked')).map(function (c) { return c.value; });
            if (!ids.length) { alert(WF_MSG.noSelection); return; }
            params.set('selectedIds', ids.join(','));
        }
        var dropdown = document.getElementById('wfExportDropdown');
        if (dropdown) dropdown.classList.remove('open');
        window.location.href = ctx + '/admin/login-risk/waf-sync/export?' + params.toString();
    };

    function initExportDropdown() {
        var toggle = document.querySelector('.js-wf-export-toggle');
        var dropdown = document.getElementById('wfExportDropdown');
        if (!toggle || !dropdown) return;
        toggle.addEventListener('click', function (e) {
            e.stopPropagation();
            dropdown.classList.toggle('open');
        });
        document.addEventListener('click', function (e) {
            if (!toggle.contains(e.target) && !dropdown.contains(e.target)) dropdown.classList.remove('open');
        });
    }

    function initModals() {
        document.querySelectorAll('.js-waf-modal-open').forEach(function (button) {
            button.addEventListener('click', function () {
                var modal = document.getElementById(button.dataset.modalId);
                if (modal) modal.hidden = false;
            });
        });
        document.querySelectorAll('.js-waf-modal-close').forEach(function (button) {
            button.addEventListener('click', function () {
                var modal = button.closest('.waf-detail-modal');
                if (modal) modal.hidden = true;
            });
        });
        document.querySelectorAll('.waf-detail-modal').forEach(function (modal) {
            modal.addEventListener('click', function (event) {
                if (event.target === modal) modal.hidden = true;
            });
        });
        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                document.querySelectorAll('.waf-detail-modal:not([hidden])').forEach(function (m) { m.hidden = true; });
            }
        });
    }

    function init() {
        cacheRows();
        var sizeSel = document.getElementById('wfPageSize');
        if (sizeSel) {
            var n = parseInt(sizeSel.value, 10);
            wfState.pageSize = n > 0 ? n : 20;
        }
        initExportDropdown();
        initModals();
        applyAll();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else { init(); }
})();
</script>

<style>
/* ── WAF 동기화 페이지 전용 (wf-) ── */
.adm-waf-page .wf-table { width: 100%; min-width: 1320px; table-layout: fixed; }
.adm-waf-page .wf-col-check     { width: 42px; }
.adm-waf-page .wf-th-check, .adm-waf-page .wf-cell-check { text-align: center; padding: 8px 4px; }
.adm-waf-page .wf-col-status    { width: 100px; }
.adm-waf-page .wf-col-source    { width: 170px; }
.adm-waf-page .wf-col-action    { width: 100px; }
.adm-waf-page .wf-col-target    { width: 200px; }
.adm-waf-page .wf-col-desc      { width: auto; }
.adm-waf-page .wf-col-created   { width: 140px; }
.adm-waf-page .wf-col-result    { width: 140px; }
.adm-waf-page .wf-col-rowaction { width: 130px; }

.adm-waf-page .wf-th {
    white-space: nowrap; overflow: hidden;
    user-select: none;
    padding-right: 18px; box-sizing: border-box;
}
.adm-waf-page .wf-th.wf-sortable { cursor: pointer; }
.adm-waf-page .wf-th .wf-th-label {
    display: inline-block; max-width: calc(100% - 14px);
    overflow: hidden; text-overflow: ellipsis; vertical-align: middle;
}
.adm-waf-page .wf-th .wf-sort-ico {
    display: inline-block; margin-left: 4px; width: 10px;
    font-size: 10px; line-height: 1; vertical-align: middle; color: #93c5fd;
}
body.sa-light .adm-waf-page .wf-th .wf-sort-ico { color: #2563eb; }

.adm-waf-page .wf-table td {
    vertical-align: top; overflow: hidden;
    word-break: break-word;
}
.adm-waf-page .wf-table .adm-waf-description {
    white-space: normal; line-height: 1.45;
    max-height: 6em; overflow: hidden; text-overflow: ellipsis;
    font-size: 12px;
}

/* card head + export */
.adm-waf-page .wf-card-head { display: flex; align-items: center; justify-content: space-between; gap: 12px; flex-wrap: wrap; }
.adm-waf-page .wf-total-label { margin-left: 8px; font-size: 12px; color: #94a3b8; font-weight: normal; }
.adm-waf-page .wf-export-control { position: relative; display: inline-flex; align-items: center; gap: 6px; }
.adm-waf-page .wf-export-control .wf-export-format { min-width: 84px; }
.adm-waf-page .wf-export-control .adm-export-dropdown {
    display: none; position: absolute; top: 100%; right: 0; margin-top: 4px;
    background: var(--adm-card-bg, #1e293b); border: 1px solid var(--adm-border, #334155);
    border-radius: 6px; padding: 4px; z-index: 30; min-width: 200px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.25);
}
.adm-waf-page .wf-export-control .adm-export-dropdown.open { display: block; }
.adm-waf-page .wf-export-control .adm-export-item {
    display: block; width: 100%; text-align: left; padding: 6px 10px;
    background: transparent; color: inherit; border: 0; cursor: pointer;
    font-size: 13px; border-radius: 4px;
}
.adm-waf-page .wf-export-control .adm-export-item:disabled { opacity: 0.5; cursor: not-allowed; }
.adm-waf-page .wf-export-control .adm-export-item:hover:not(:disabled) { background: rgba(148,163,184,0.15); }

/* controlbar */
.adm-waf-page .wf-controlbar { display: flex; align-items: center; justify-content: space-between; gap: 12px; padding: 8px 14px; flex-wrap: wrap; }
.adm-waf-page .wf-bulkbar { display: flex; align-items: center; gap: 10px; opacity: 0.55; transition: opacity 0.2s; }
.adm-waf-page .wf-bulkbar.is-active { opacity: 1; }
.adm-waf-page .wf-bulk-count { font-size: 13px; }
.adm-waf-page .wf-bulk-count strong { font-size: 15px; margin-right: 2px; color: #fbbf24; }
.adm-waf-page .wf-bulk-actions { display: inline-flex; gap: 6px; align-items: center; }
.adm-waf-page .wf-view-tools { display: inline-flex; gap: 8px; align-items: center; flex-wrap: wrap; }
.adm-waf-page .wf-tool { display: inline-flex; gap: 4px; align-items: center; }
.adm-waf-page .wf-tool-label { font-size: 12px; color: #94a3b8; }
.adm-waf-page .wf-page-search { min-width: 220px; }
.adm-waf-page .wf-sort-reset { font-size: 12px; }

/* pagination */
.adm-waf-page .wf-pagination { display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; gap: 10px; flex-wrap: wrap; }
.adm-waf-page .wf-page-info { font-size: 12px; color: #94a3b8; }
.adm-waf-page .wf-page-actions { display: inline-flex; gap: 8px; align-items: center; }
.adm-waf-page .wf-page-state { font-size: 13px; min-width: 60px; text-align: center; }

.adm-waf-page .wf-empty,
.adm-waf-page .wf-empty-cell { padding: 16px; text-align: center; color: #94a3b8; }
.adm-waf-page .adm-is-hidden { display: none !important; }

@media (max-width: 1280px) {
    .adm-waf-page .adm-waf-filterbar { flex-wrap: wrap; }
    .adm-waf-page .wf-controlbar { flex-direction: column; align-items: stretch; }
    .adm-waf-page .wf-bulkbar { flex-wrap: wrap; }
    .adm-waf-page .wf-view-tools { justify-content: flex-end; }
}
</style>

<%@ include file="../layout-close.jsp" %>
