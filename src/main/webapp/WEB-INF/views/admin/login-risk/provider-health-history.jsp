<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations --%>
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
<spring:message var="msg_pa_sortReset" code="security.admin.providerAdv.action.sortReset"/>
<spring:message var="msg_pa_refresh" code="security.admin.providerAdv.action.refresh"/>
<spring:message var="msg_pa_exportCsv" code="security.admin.providerAdv.action.exportCsv"/>
<spring:message var="msg_pa_exportExcel" code="security.admin.providerAdv.action.exportExcel"/>
<spring:message var="msg_admin_common_selectedCount" code="admin.common.selectedCount"/>
<spring:message var="msg_admin_common_clearSelection" code="admin.common.clearSelection"/>
<spring:message var="msg_admin_common_export" code="admin.common.export"/>
<spring:message var="msg_admin_common_exportAll" code="admin.common.exportAll"/>
<spring:message var="msg_admin_common_exportFiltered" code="admin.common.exportFiltered"/>
<spring:message var="msg_admin_common_exportSelected" code="admin.common.exportSelected"/>
<spring:message var="msg_admin_common_pageSizeLabel" code="admin.common.pageSizeLabel"/>
<spring:message var="msg_admin_common_prev" code="admin.common.prev"/>
<spring:message var="msg_admin_common_next" code="admin.common.next"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_common_selectPageRows" code="admin.common.selectPageRows"/>
<spring:message var="msg_admin_common_selectRow" code="admin.common.selectRow"/>
<spring:message var="js_admin_common_exportSelected" code="admin.common.exportSelected" javaScriptEscape="true"/>
<spring:message var="js_admin_common_selectedCount" code="admin.common.selectedCount" javaScriptEscape="true"/>
<c:set var="pageTitle" value="${msg_security_admin_providerHealth_title}"/>
<c:set var="activeMenu" value="providerHealthHistory"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page phh-page">
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

    <div class="adm-card phh-list-card">
        <div class="adm-card-head phh-card-head">
            <div class="adm-card-title">
                ${msg_security_admin_providerHealth_title}
                <span class="adm-page-muted phh-total">${msg_admin_common_totalCount}</span>
            </div>
            <div class="phh-export-control" id="phhExportControl">
                <select class="adm-select phh-export-format" id="phhExportFormat" title="${msg_admin_common_export}">
                    <option value="csv">${msg_pa_exportCsv}</option>
                    <option value="excel">${msg_pa_exportExcel}</option>
                </select>
                <button class="adm-btn adm-btn-ghost" type="button" id="phhExportToggle">${msg_admin_common_export} ▾</button>
                <div class="phh-export-dropdown" id="phhExportDropdown">
                    <button type="button" class="phh-export-item" data-scope="all">${msg_admin_common_exportAll}</button>
                    <button type="button" class="phh-export-item" data-scope="filtered">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="phh-export-item" data-scope="selected" id="phhExportSelectedBtn" disabled>${msg_admin_common_exportSelected} (0)</button>
                </div>
            </div>
        </div>

        <div id="phhBulkbar" class="phh-bulkbar" aria-hidden="true" aria-live="polite">
            <span class="phh-selected-label"><strong id="phhSelectedCount">0</strong>${msg_admin_common_selectedCount}</span>
            <button type="button" class="adm-btn adm-btn-ghost phh-clear-selection" onclick="clearPhhSelection()">${msg_admin_common_clearSelection}</button>
        </div>

        <form method="get" id="phhSearchForm" class="phh-toolbar">
            <div class="phh-toolbar-group phh-toolbar-search">
                <label class="phh-field phh-field-keyword">
                    <span class="phh-label">${msg_security_admin_providerHealth_providerCode}</span>
                    <input class="adm-input phh-input-keyword" type="text" name="providerCode"
                           value="${fn:escapeXml(providerCode)}"
                           placeholder="${msg_security_admin_providerHealth_providerCodePlaceholder}">
                </label>
                <label class="phh-field phh-field-limit">
                    <span class="phh-label">${msg_security_admin_providerHealth_limit}</span>
                    <select class="adm-select phh-select-limit" name="limit">
                        <option value="20"  ${limit == 20  ? 'selected' : ''}>20</option>
                        <option value="50"  ${limit == 50  ? 'selected' : ''}>50</option>
                        <option value="100" ${limit == 100 ? 'selected' : ''}>100</option>
                        <option value="200" ${limit == 200 ? 'selected' : ''}>200</option>
                    </select>
                </label>
                <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_search}</button>
                <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/provider-health-history">${msg_admin_common_reset}</a>
            </div>
            <div class="phh-toolbar-group phh-toolbar-tools">
                <button class="adm-btn adm-btn-ghost" type="button" id="phhSortReset" hidden>${msg_pa_sortReset}</button>
                <button class="adm-btn adm-btn-ghost" type="button" onclick="location.reload()">${msg_pa_refresh}</button>
                <label class="phh-page-size-tool">
                    <span>${msg_admin_common_pageSizeLabel}</span>
                    <select class="adm-select phh-page-size" id="phhPageSize">
                        <option value="20">20</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                        <option value="0">${msg_admin_common_all}</option>
                    </select>
                </label>
            </div>
        </form>

        <div class="adm-table-wrap phh-table-wrap">
            <table id="providerHealthHistoryTable" class="adm-table phh-table" data-admin-list-ignore="hard">
                <colgroup>
                    <col class="phh-col-check"/>
                    <col class="phh-col-checked-at"/>
                    <col class="phh-col-provider"/>
                    <col class="phh-col-source"/>
                    <col class="phh-col-status"/>
                    <col class="phh-col-status"/>
                    <col class="phh-col-actor"/>
                    <col class="phh-col-detail"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="phh-check-head">
                        <span class="phh-check-slot">
                            <input type="checkbox" class="phh-check" id="phhPageCheck" onclick="togglePhhPageSelection(event)" aria-label="${msg_admin_common_selectPageRows}">
                        </span>
                    </th>
                    <th class="phh-th" data-sort="checkedAt" onclick="sortProviderHealthRows('checkedAt')"><span class="phh-th-label">${msg_security_admin_providerHealth_checkedAt}</span><span class="phh-sort-ico" aria-hidden="true"></span></th>
                    <th class="phh-th" data-sort="provider" onclick="sortProviderHealthRows('provider')"><span class="phh-th-label">${msg_security_admin_providerHealth_provider}</span><span class="phh-sort-ico" aria-hidden="true"></span></th>
                    <th class="phh-th" data-sort="checkSource" onclick="sortProviderHealthRows('checkSource')"><span class="phh-th-label">${msg_security_admin_providerHealth_checkSource}</span><span class="phh-sort-ico" aria-hidden="true"></span></th>
                    <th class="phh-th" data-sort="statusBefore" onclick="sortProviderHealthRows('statusBefore')"><span class="phh-th-label">${msg_security_admin_providerHealth_statusBefore}</span><span class="phh-sort-ico" aria-hidden="true"></span></th>
                    <th class="phh-th" data-sort="statusAfter" onclick="sortProviderHealthRows('statusAfter')"><span class="phh-th-label">${msg_security_admin_providerHealth_statusAfter}</span><span class="phh-sort-ico" aria-hidden="true"></span></th>
                    <th class="phh-th" data-sort="actor" onclick="sortProviderHealthRows('actor')"><span class="phh-th-label">${msg_security_admin_providerHealth_actor}</span><span class="phh-sort-ico" aria-hidden="true"></span></th>
                    <th class="phh-th" data-sort="detail" onclick="sortProviderHealthRows('detail')"><span class="phh-th-label">${msg_security_admin_providerHealth_detail}</span><span class="phh-sort-ico" aria-hidden="true"></span></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="h" items="${histories}" varStatus="st">
                    <fmt:formatDate var="checkedAtDisplay" value="${h.checkedAtDate}" pattern="yyyy-MM-dd HH:mm"/>
                    <tr class="phh-row js-provider-health-row"
                        data-health-history-idx="${h.healthHistoryIdx}"
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
                        <td class="phh-check-cell">
                            <span class="phh-check-slot">
                                <input type="checkbox" class="phh-check phh-row-check" value="${h.healthHistoryIdx}" onclick="togglePhhRowSelection(event, this)" aria-label="${msg_admin_common_selectRow}">
                            </span>
                        </td>
                        <td class="phh-cell phh-cell-checked-at" onclick="openPhhCellAction(event, this, 'checkedAt')">${checkedAtDisplay}</td>
                        <td class="phh-cell phh-cell-provider" onclick="openPhhCellAction(event, this, 'provider')">
                            <div class="phh-provider-kind"><c:out value="${h.providerKind}"/></div>
                            <div class="phh-provider-code"><c:out value="${h.providerCode}"/></div>
                        </td>
                        <td class="phh-cell" onclick="openPhhCellAction(event, this, 'checkSource')"><span class="phh-badge"><c:out value="${h.checkSource}"/></span></td>
                        <td class="phh-cell" onclick="openPhhCellAction(event, this, 'statusBefore')"><c:out value="${h.statusBefore}" default="-"/></td>
                        <td class="phh-cell" onclick="openPhhCellAction(event, this, 'statusAfter')"><c:out value="${h.statusAfter}" default="-"/></td>
                        <td class="phh-cell" onclick="openPhhCellAction(event, this, 'actor')"><c:out value="${h.actorUserIdx}" default="-"/></td>
                        <td class="phh-cell phh-cell-detail" onclick="openPhhCellAction(event, this, 'detail')"><div class="phh-detail-text"><c:out value="${h.detailMessage}" default="-"/></div></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty histories}">
                    <tr class="adm-local-empty"><td colspan="8" class="adm-local-empty-cell">${msg_security_admin_providerHealth_empty}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <div class="phh-pagination">
            <div class="phh-page-info" id="phhPageInfo">0</div>
            <div class="phh-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost phh-page-btn" id="phhPrevPage">${msg_admin_common_prev}</button>
                <button type="button" class="adm-btn adm-btn-ghost phh-page-btn" id="phhNextPage">${msg_admin_common_next}</button>
            </div>
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
(function () {
    var ctx = '${pageContext.request.contextPath}';
    var selectedHistoryIds = new Set();
    var currentPage = 1;
    var pageSize = 20;

    /* ── 정렬 ── */
    var providerHealthSortState = { field: '', dir: 'DESC' };
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
    window.sortProviderHealthRows = function (field) {
        providerHealthSortState.dir = (providerHealthSortState.field === field && providerHealthSortState.dir === 'DESC') ? 'ASC' : 'DESC';
        providerHealthSortState.field = field;
        var tbody = document.querySelector('#providerHealthHistoryTable tbody');
        if (!tbody) return;
        providerHealthRows().sort(function (a, b) {
            var av = providerHealthValue(a, field);
            var bv = providerHealthValue(b, field);
            var cmp = String(av).localeCompare(String(bv), undefined, { numeric: true, sensitivity: 'base' });
            return cmp * (providerHealthSortState.dir === 'DESC' ? -1 : 1);
        }).forEach(function (row) { tbody.appendChild(row); });
        updateProviderHealthSortIndicators();
        currentPage = 1;
        renderProviderHealthPage();
    };
    function updateProviderHealthSortIndicators() {
        document.querySelectorAll('#providerHealthHistoryTable th[data-sort]').forEach(function (th) {
            var active = th.dataset.sort === providerHealthSortState.field;
            th.classList.toggle('sorted', active);
            var ico = th.querySelector('.phh-sort-ico');
            if (ico) {
                ico.textContent = active ? (providerHealthSortState.dir === 'DESC' ? '▼' : '▲') : '';
                ico.className = 'phh-sort-ico ' + (active ? providerHealthSortState.dir.toLowerCase() : '');
            }
        });
        var resetBtn = document.getElementById('phhSortReset');
        if (resetBtn) resetBtn.hidden = !providerHealthSortState.field;
    }
    function resetProviderHealthSort() {
        providerHealthSortState = { field: '', dir: 'DESC' };
        var tbody = document.querySelector('#providerHealthHistoryTable tbody');
        if (!tbody) return;
        providerHealthRows().sort(function (a, b) {
            return Number(a.dataset.originalIndex) - Number(b.dataset.originalIndex);
        }).forEach(function (row) { tbody.appendChild(row); });
        updateProviderHealthSortIndicators();
        currentPage = 1;
        renderProviderHealthPage();
    }

    /* ── 선택 + 페이지네이션 ── */
    function rowKey(row) {
        return row ? (row.dataset.healthHistoryIdx || row.dataset.originalIndex || '') : '';
    }
    function pageBounds(rows) {
        var total = rows.length;
        if (!pageSize || pageSize <= 0) return { start: 0, end: total, totalPages: 1 };
        var totalPages = Math.max(1, Math.ceil(total / pageSize));
        currentPage = Math.min(Math.max(1, currentPage), totalPages);
        var start = (currentPage - 1) * pageSize;
        return { start: start, end: Math.min(start + pageSize, total), totalPages: totalPages };
    }
    function currentPageRows() {
        var rows = providerHealthRows();
        var bounds = pageBounds(rows);
        return rows.slice(bounds.start, bounds.end);
    }
    function syncSelectionUi() {
        providerHealthRows().forEach(function (row) {
            var box = row.querySelector('.phh-row-check');
            if (box) box.checked = selectedHistoryIds.has(rowKey(row));
        });
        var visibleRows = currentPageRows();
        var checkedVisible = visibleRows.filter(function (row) { return selectedHistoryIds.has(rowKey(row)); }).length;
        var pageCheck = document.getElementById('phhPageCheck');
        if (pageCheck) {
            pageCheck.checked = visibleRows.length > 0 && checkedVisible === visibleRows.length;
            pageCheck.indeterminate = checkedVisible > 0 && checkedVisible < visibleRows.length;
            pageCheck.disabled = visibleRows.length === 0;
        }
        var count = selectedHistoryIds.size;
        var bulkbar = document.getElementById('phhBulkbar');
        var countEl = document.getElementById('phhSelectedCount');
        var exportSelected = document.getElementById('phhExportSelectedBtn');
        if (countEl) countEl.textContent = count;
        if (bulkbar) {
            bulkbar.classList.toggle('is-active', count > 0);
            bulkbar.setAttribute('aria-hidden', count > 0 ? 'false' : 'true');
        }
        if (exportSelected) {
            exportSelected.disabled = count === 0;
            exportSelected.textContent = '${js_admin_common_exportSelected} (' + count + ')';
        }
    }
    function renderProviderHealthPage() {
        var rows = providerHealthRows();
        var bounds = pageBounds(rows);
        rows.forEach(function (row, idx) {
            row.hidden = idx < bounds.start || idx >= bounds.end;
        });
        var info = document.getElementById('phhPageInfo');
        if (info) {
            var startNo = rows.length === 0 ? 0 : bounds.start + 1;
            info.textContent = startNo + '-' + bounds.end + ' / ' + rows.length + ' · ' + currentPage + '/' + bounds.totalPages;
        }
        var prev = document.getElementById('phhPrevPage');
        var next = document.getElementById('phhNextPage');
        if (prev) prev.disabled = currentPage <= 1 || rows.length === 0;
        if (next) next.disabled = currentPage >= bounds.totalPages || rows.length === 0;
        syncSelectionUi();
    }
    window.togglePhhRowSelection = function (event, checkbox) {
        if (event) event.stopPropagation();
        var row = checkbox ? checkbox.closest('.js-provider-health-row') : null;
        var key = rowKey(row);
        if (!key) return;
        if (checkbox.checked) selectedHistoryIds.add(key);
        else selectedHistoryIds.delete(key);
        syncSelectionUi();
    };
    window.togglePhhPageSelection = function (event) {
        if (event) event.stopPropagation();
        var checked = event && event.target ? event.target.checked : false;
        currentPageRows().forEach(function (row) {
            var key = rowKey(row);
            if (checked) selectedHistoryIds.add(key);
            else selectedHistoryIds.delete(key);
        });
        syncSelectionUi();
    };
    window.clearPhhSelection = function () {
        selectedHistoryIds.clear();
        syncSelectionUi();
    };

    /* ── 상세 모달 ── */
    window.closeProviderHealthDetail = function () {
        var modal = document.getElementById('providerHealthDetailModal');
        if (modal) modal.classList.remove('open');
    };
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
        fields.forEach(function (pair) {
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
    window.openPhhCellAction = function (event, cell, focusKey) {
        if (event && event.target && event.target.closest('button, a, input, select, textarea, label')) return true;
        openProviderHealthDetail(cell ? cell.closest('.js-provider-health-row') : null, focusKey);
        if (event) { event.preventDefault(); event.stopPropagation(); }
        return false;
    };

    /* ── 내보내기 드롭다운 ── */
    function exportData(scope) {
        var params = new URLSearchParams();
        var providerCode = document.querySelector('input[name="providerCode"]').value || '';
        var limit = document.querySelector('select[name="limit"]').value || '200';
        var format = document.getElementById('phhExportFormat').value || 'csv';
        params.set('scope', scope || 'filtered');
        if (scope === 'selected') {
            if (selectedHistoryIds.size === 0) return;
            params.set('selectedIds', Array.from(selectedHistoryIds).join(','));
        }
        if (scope !== 'all' && scope !== 'selected' && providerCode) params.set('providerCode', providerCode);
        params.set('limit', scope === 'all' ? '1000' : limit);
        params.set('format', format);
        window.location.href = ctx + '/admin/login-risk/provider-health-history/export?' + params.toString();
    }

    document.addEventListener('DOMContentLoaded', function () {
        updateProviderHealthSortIndicators();

        var sortReset = document.getElementById('phhSortReset');
        if (sortReset) sortReset.addEventListener('click', resetProviderHealthSort);

        var pageSizeSelect = document.getElementById('phhPageSize');
        if (pageSizeSelect) {
            pageSize = Number(pageSizeSelect.value || 20);
            pageSizeSelect.addEventListener('change', function () {
                pageSize = Number(this.value || 20);
                currentPage = 1;
                renderProviderHealthPage();
            });
        }
        var prev = document.getElementById('phhPrevPage');
        var next = document.getElementById('phhNextPage');
        if (prev) prev.addEventListener('click', function () { currentPage -= 1; renderProviderHealthPage(); });
        if (next) next.addEventListener('click', function () { currentPage += 1; renderProviderHealthPage(); });

        var control = document.getElementById('phhExportControl');
        var dropdown = document.getElementById('phhExportDropdown');
        var toggle = document.getElementById('phhExportToggle');
        if (toggle && dropdown && control) {
            toggle.addEventListener('click', function (e) { e.stopPropagation(); control.classList.toggle('open'); });
            document.addEventListener('click', function (e) {
                if (!control.contains(e.target)) control.classList.remove('open');
            });
            dropdown.addEventListener('click', function (e) {
                var b = e.target.closest('button.phh-export-item');
                if (b) { exportData(b.dataset.scope); control.classList.remove('open'); }
            });
        }
        renderProviderHealthPage();
    });
})();
</script>

<style>
/* ── Provider 헬스체크 이력 페이지 전용 스타일 ── */
.phh-page .phh-list-card { padding: 0; overflow: visible; }
.phh-page .phh-card-head {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    flex-wrap: wrap;
    padding: 12px 16px;
    border-bottom: 1px solid rgba(30,41,59,.6);
}
.phh-page .phh-total { margin-left: 8px; font-size: 12px; opacity: .8; }

/* Toolbar - IP 정책 배치처럼 검색 도구와 보기 도구를 같은 줄에 배치 */
.phh-page .phh-toolbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    padding: 12px 16px;
    border-bottom: 1px solid rgba(30,41,59,.5);
    background: rgba(15, 23, 42, .42);
    position: relative;
    z-index: 30;
    flex-wrap: wrap;
}
.phh-page .phh-toolbar-group {
    display: inline-flex;
    align-items: flex-end;
    gap: 8px;
    flex-wrap: wrap;
    min-width: 0;
}
.phh-page .phh-toolbar-search {
    flex: 1 1 520px;
}
.phh-page .phh-toolbar-tools {
    flex: 0 0 auto;
    justify-content: flex-end;
    margin-left: auto;
}
.phh-page #phhSortReset[hidden] {
    display: none !important;
}
.phh-page .phh-field { display: flex; flex-direction: column; gap: 4px; min-width: 0; }
.phh-page .phh-field-keyword { flex: 1 1 300px; min-width: 240px; max-width: 460px; }
.phh-page .phh-field-limit { flex: 0 0 auto; }
.phh-page .phh-label { font-size: 11px; opacity: .75; white-space: nowrap; }
.phh-page .phh-input-keyword { width: 100%; }
.phh-page .phh-select-limit { width: 90px; }

/* Bulkbar - IP 정책 배치처럼 선택 시에만 테이블 위에 노출 */
.phh-page .phh-bulkbar {
    display: none;
    align-items: center;
    gap: 10px;
    min-height: 44px;
    padding: 8px 16px;
    background: #1e3a5f;
    border-bottom: 1px solid #334155;
    flex-wrap: wrap;
}
.phh-page .phh-bulkbar.is-active {
    display: flex;
}
.phh-page .phh-selected-label {
    color: #93c5fd;
    font-size: 13px;
    font-weight: 800;
    white-space: nowrap;
}
.phh-page .phh-clear-selection { margin-left: auto; padding: 7px 10px; }
.phh-page .phh-pagination {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    padding: 14px 16px 16px;
    border-top: 1px solid rgba(148, 163, 184, .14);
    background: rgba(15, 23, 42, .42);
}
.phh-page .phh-page-size-tool {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    color: #94a3b8;
    font-size: 12px;
    font-weight: 700;
    white-space: nowrap;
}
.phh-page .phh-page-size { width: 86px; min-width: 86px; }
.phh-page .phh-page-info {
    color: #94a3b8;
    font-size: 13px;
    font-weight: 700;
    white-space: nowrap;
}
.phh-page .phh-page-actions {
    display: flex;
    align-items: center;
    gap: 8px;
}
.phh-page .phh-page-btn { padding: 7px 12px; }

/* Export dropdown - 회원 관리와 같은 형식 선택 + 범위 드롭다운 */
.phh-page .phh-export-control {
    position: relative;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    flex-shrink: 0;
}
.phh-page .phh-export-format {
    width: 90px;
    min-width: 90px;
}
.phh-page .phh-export-dropdown {
    position: absolute; top: calc(100% + 4px); right: 0;
    min-width: 184px;
    background: #111827; border: 1px solid #334155; border-radius: 6px;
    box-shadow: 0 8px 20px rgba(0,0,0,.32);
    z-index: 50;
    overflow: hidden;
    display: none;
}
.phh-page .phh-export-control.open .phh-export-dropdown { display: block; }
.phh-page .phh-export-item {
    display: block; width: 100%; padding: 9px 14px;
    background: transparent; border: 0; color: #e2e8f0; text-align: left;
    border-bottom: 1px solid #334155;
    font-size: 13px; cursor: pointer;
}
.phh-page .phh-export-item:last-child { border-bottom: 0; }
.phh-page .phh-export-item:hover { background: #1f2937; }
body.sa-light .phh-page .phh-export-dropdown { background: #fff; border-color: #e2e8f0; box-shadow: 0 8px 20px rgba(15,23,42,.16); }
body.sa-light .phh-page .phh-export-item { color: #334155; }
body.sa-light .phh-page .phh-export-item:hover { background: #f1f5f9; }
body.sa-light .phh-page .phh-export-item:disabled { color: #94a3b8; }

/* Table — 컬럼 폭 명시, 가로 overflow는 wrap에서 처리 */
.phh-page .phh-table-wrap { overflow-x: auto; position: relative; z-index: 1; }
.phh-page .phh-table {
    width: 100%; min-width: 1160px;
    table-layout: fixed; border-collapse: collapse;
}
.phh-page .phh-col-check      { width: 38px; }
.phh-page .phh-col-checked-at { width: 132px; }
.phh-page .phh-col-provider   { width: 320px; }
.phh-page .phh-col-source     { width: 112px; }
.phh-page .phh-col-status     { width: 116px; }
.phh-page .phh-col-actor      { width: 82px; }
.phh-page .phh-col-detail     { width: auto; }

/* Header — 정렬 ▼/▲가 다음 컬럼으로 떨어지지 않도록 inline-flex로 고정 */
.phh-page .phh-th {
    padding: 10px 12px;
    background: rgba(15,23,42,.6);
    border-bottom: 1px solid rgba(30,41,59,.6);
    font-size: 12px; font-weight: 700;
    text-align: left;
    white-space: nowrap;
    cursor: pointer;
    user-select: none;
    box-sizing: border-box;
    overflow: hidden;
}
.phh-page .phh-th .phh-th-label {
    display: inline-block;
    max-width: calc(100% - 14px);
    overflow: hidden;
    text-overflow: ellipsis;
    vertical-align: middle;
}
.phh-page .phh-th .phh-sort-ico {
    display: inline-block;
    margin-left: 4px;
    width: 10px;
    font-size: 10px;
    line-height: 1;
    color: #93c5fd;
    vertical-align: middle;
}
.phh-page .phh-th.sorted { color: #93c5fd; }
.phh-page .phh-th .phh-sort-ico.asc { color: #ef4444; }
.phh-page .phh-th .phh-sort-ico.desc { color: #3b82f6; }
body.sa-light .phh-page .phh-th { background: #f8fafc; color: #334155; border-bottom-color: #e2e8f0; }
body.sa-light .phh-page .phh-th.sorted { color: #2563eb; }
body.sa-light .phh-page .phh-th .phh-sort-ico.asc { color: #dc2626; }
body.sa-light .phh-page .phh-th .phh-sort-ico.desc { color: #2563eb; }
body.sa-light .phh-page .phh-card-head,
body.sa-light .phh-page .phh-toolbar,
body.sa-light .phh-page .phh-pagination { border-color: #e2e8f0; }
body.sa-light .phh-page .phh-toolbar,
body.sa-light .phh-page .phh-pagination { background: #f8fafc; }
body.sa-light .phh-page .phh-bulkbar {
    background: #dbeafe;
    border-bottom-color: #bfdbfe;
}
body.sa-light .phh-page .phh-page-size-tool,
body.sa-light .phh-page .phh-page-info { color: #64748b; }

.phh-page .phh-check-head,
.phh-page .phh-check-cell {
    width: 38px;
    min-width: 38px;
    max-width: 38px;
    padding: 0 !important;
    text-align: center;
    vertical-align: middle;
    line-height: 0;
}
.phh-page .phh-check-head {
    background: rgba(15,23,42,.6);
    border-bottom: 1px solid rgba(30,41,59,.6);
}
.phh-page .phh-check-slot {
    min-height: 42px;
    display: flex;
    align-items: center;
    justify-content: center;
}
.phh-page .phh-check-head .phh-check-slot {
    min-height: 38px;
}
.phh-page .phh-check {
    display: block;
    width: 15px;
    height: 15px;
    margin: 0;
    accent-color: #3b82f6;
    cursor: pointer;
}
body.sa-light .phh-page .phh-check-head {
    background: #f8fafc;
    border-bottom-color: #e2e8f0;
}

/* Cell */
.phh-page .phh-cell {
    padding: 8px 12px;
    border-bottom: 1px solid rgba(30,41,59,.4);
    vertical-align: top;
    overflow: hidden;
    text-overflow: ellipsis;
    cursor: pointer;
    box-sizing: border-box;
}
.phh-page .phh-cell:hover { background: rgba(59,130,246,.06); }
body.sa-light .phh-page .phh-cell { border-bottom-color: #e2e8f0; }
body.sa-light .phh-page .phh-cell:hover { background: rgba(37,99,235,.06); }

.phh-page .phh-cell-checked-at { white-space: nowrap; font-variant-numeric: tabular-nums; }
.phh-page .phh-cell-provider   { line-height: 1.3; }
.phh-page .phh-provider-kind,
.phh-page .phh-provider-code {
    display: block;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.phh-page .phh-provider-kind   { font-weight: 700; color: #dbeafe; }
.phh-page .phh-provider-code   { font-size: 11px; opacity: .75; }
body.sa-light .phh-page .phh-provider-kind { color: #1d4ed8; }

.phh-page .phh-badge {
    display: inline-block; padding: 2px 8px; border-radius: 999px;
    font-size: 11px; font-weight: 600;
    background: rgba(59,130,246,.16); color: #93c5fd;
}
body.sa-light .phh-page .phh-badge { background: #dbeafe; color: #1e40af; }

.phh-page .phh-cell-detail { white-space: normal; overflow: visible; }
.phh-page .phh-detail-text {
    white-space: pre-wrap;
    overflow-wrap: anywhere;
    line-height: 1.45;
    font-size: 12px;
    max-height: 6em;
    overflow: hidden;
    text-overflow: ellipsis;
}

/* 빈 행 */
.phh-page .adm-local-empty-cell { padding: 32px 12px; text-align: center; opacity: .6; }

/* 미디어 쿼리 */
@media (max-width: 1080px) {
    .phh-page .phh-toolbar-tools { margin-left: 0; }
}
@media (max-width: 720px) {
    .phh-page .phh-field-keyword { flex: 1 1 100%; max-width: none; }
    .phh-page .phh-toolbar-group,
    .phh-page .phh-toolbar-group .adm-btn,
    .phh-page .phh-field,
    .phh-page .phh-pagination {
        width: 100%;
    }
    .phh-page .phh-toolbar-tools,
    .phh-page .phh-page-actions { justify-content: flex-end; }
}
</style>

<%@ include file="../layout-close.jsp" %>
