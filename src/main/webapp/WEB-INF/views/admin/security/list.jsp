<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_43fbbe4765" code="admin.common.search"/>
<spring:message var="autoMsg_80d53474e6" code="admin.security.searchPlaceholder"/>
<spring:message var="autoMsg_8e0ae10185" code="admin.logs.success"/>
<spring:message var="autoMsg_7076bbc65a" code="admin.common.all"/>
<spring:message var="autoMsg_4396547332" code="admin.common.success"/>
<spring:message var="autoMsg_b56b40e80e" code="admin.common.fail"/>
<spring:message var="autoMsg_fb96228926" code="admin.security.eventType"/>
<spring:message var="autoMsg_949e3ef70b" code="admin.security.eventType.findId"/>
<spring:message var="autoMsg_f1d9e88727" code="admin.security.eventType.findPassword"/>
<spring:message var="autoMsg_da904dc9fe" code="admin.security.eventType.resetPassword"/>
<spring:message var="autoMsg_78784cd58b" code="admin.security.eventType.passwordChange"/>
<spring:message var="autoMsg_4589794850" code="admin.security.eventType.emailVerify"/>
<spring:message var="autoMsg_4f2984c127" code="admin.security.eventType.emailLoginToggle"/>
<spring:message var="autoMsg_52ffa5a6ca" code="admin.security.stage"/>
<spring:message var="autoMsg_4837b93310" code="admin.security.stage.request"/>
<spring:message var="autoMsg_51ee8e918c" code="admin.security.stage.issue"/>
<spring:message var="autoMsg_4736e42989" code="admin.security.stage.verify"/>
<spring:message var="autoMsg_3abb2e4afe" code="admin.security.stage.complete"/>
<spring:message var="autoMsg_7b08a203f8" code="admin.common.searchButton"/>
<spring:message var="autoMsg_74f0d21a9c" code="admin.common.reset"/>
<spring:message var="autoMsg_549ebe4630" code="admin.common.totalCount"/>
<spring:message var="autoMsg_f499ec71fa" code="admin.common.export"/>
<spring:message var="autoMsg_9e26c9110b" code="admin.common.exportAll"/>
<spring:message var="autoMsg_7ba7fab06f" code="admin.common.exportFiltered"/>
<spring:message var="autoMsg_e849f53569" code="admin.common.exportSelected"/>
<spring:message var="autoMsg_bcf57a4b2e" code="admin.blocks.mode.label"/>
<spring:message var="autoMsg_5ca7a74e5e" code="admin.blocks.mode.tipClient"/>
<spring:message var="autoMsg_deafe21b83" code="admin.blocks.mode.client"/>
<spring:message var="autoMsg_c0c5affdfd" code="admin.blocks.mode.tipServer"/>
<spring:message var="autoMsg_bee2025dd2" code="admin.blocks.mode.server"/>
<spring:message var="autoMsg_7412fe3c9d" code="admin.common.pageSize"/>
<spring:message var="autoMsg_be10370ce4" code="admin.common.selectedCount"/>
<spring:message var="autoMsg_598849a7a1" code="admin.common.clearSelection"/>
<spring:message var="autoMsg_00e1e31931" code="admin.common.time"/>
<spring:message var="autoMsg_8b69017288" code="admin.security.targetMember"/>
<spring:message var="autoMsg_0f52313ee1" code="admin.security.actor"/>
<spring:message var="autoMsg_519c6918d9" code="admin.context.inputValue"/>
<spring:message var="autoMsg_258c2c3652" code="admin.context.targetEmail"/>
<spring:message var="autoMsg_005e5e108d" code="admin.common.result"/>
<spring:message var="autoMsg_79eefd9703" code="admin.common.reason"/>
<spring:message var="autoMsg_fc792c14ad" code="admin.common.ip"/>
<spring:message var="autoMsg_0f4728b0c0" code="admin.security.correlationId"/>
<spring:message var="autoMsg_7eab91f841" code="admin.common.prev"/>
<spring:message var="autoMsg_71a0fb020e" code="admin.common.next"/>
<spring:message var="autoMsg_c6bc5566a9" code="admin.security.historyTitle"/>
<spring:message var="autoMsg_af16c287ca" code="admin.common.close"/>
<spring:message var="autoMsg_e6202f6055" code="admin.common.loadFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_11a423d313" code="admin.common.loadAllFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_58eab77510" code="admin.blocks.js.dashSortReset" javaScriptEscape="true"/>
<spring:message var="autoMsg_3b06864ede" code="admin.common.totalCountFormat" javaScriptEscape="true"/>
<spring:message var="autoMsg_0e68d86725" code="admin.common.currentCountFormat" javaScriptEscape="true"/>
<spring:message var="autoMsg_5a558b55eb" code="admin.common.noResults" javaScriptEscape="true"/>
<spring:message var="autoMsg_ed2b82c41f" code="admin.security.historyTitle" javaScriptEscape="true"/>
<c:set var="activeMenu" value="security"/>
<spring:message code="admin.security.pageTitle" var="adminSecurityPageTitle"/>
<c:set var="pageTitle" value="${adminSecurityPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form id="securitySearchForm" method="get" action="${pageContext.request.contextPath}/admin/security">
                <div class="adm-filter-bar">
                    <div class="adm-search-box" style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">${autoMsg_43fbbe4765}</div>
                        <span class="adm-search-ico">🔍</span>
                        <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(search.keyword)}" placeholder="${autoMsg_80d53474e6}">
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_8e0ae10185}</div>
                        <select class="adm-select" name="success">
                            <option value="ALL" ${search.success=='ALL'?'selected':''}>${autoMsg_7076bbc65a}</option>
                            <option value="SUCCESS" ${search.success=='SUCCESS'?'selected':''}>${autoMsg_4396547332}</option>
                            <option value="FAIL" ${search.success=='FAIL'?'selected':''}>${autoMsg_b56b40e80e}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_fb96228926}</div>
                        <select class="adm-select" name="eventType">
                            <option value="ALL" ${search.eventType=='ALL'?'selected':''}>${autoMsg_7076bbc65a}</option>
                            <option value="FIND_ID" ${search.eventType=='FIND_ID'?'selected':''}>${autoMsg_949e3ef70b}</option>
                            <option value="FIND_PASSWORD" ${search.eventType=='FIND_PASSWORD'?'selected':''}>${autoMsg_f1d9e88727}</option>
                            <option value="RESET_PASSWORD" ${search.eventType=='RESET_PASSWORD'?'selected':''}>${autoMsg_da904dc9fe}</option>
                            <option value="PASSWORD_CHANGE" ${search.eventType=='PASSWORD_CHANGE'?'selected':''}>${autoMsg_78784cd58b}</option>
                            <option value="EMAIL_VERIFY" ${search.eventType=='EMAIL_VERIFY'?'selected':''}>${autoMsg_4589794850}</option>
                            <option value="EMAIL_LOGIN_TOGGLE" ${search.eventType=='EMAIL_LOGIN_TOGGLE'?'selected':''}>${autoMsg_4f2984c127}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_52ffa5a6ca}</div>
                        <select class="adm-select" name="eventStage">
                            <option value="ALL" ${search.eventStage=='ALL'?'selected':''}>${autoMsg_7076bbc65a}</option>
                            <option value="REQUEST" ${search.eventStage=='REQUEST'?'selected':''}>${autoMsg_4837b93310}</option>
                            <option value="ISSUE" ${search.eventStage=='ISSUE'?'selected':''}>${autoMsg_51ee8e918c}</option>
                            <option value="VERIFY" ${search.eventStage=='VERIFY'?'selected':''}>${autoMsg_4736e42989}</option>
                            <option value="COMPLETE" ${search.eventStage=='COMPLETE'?'selected':''}>${autoMsg_3abb2e4afe}</option>
                        </select>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:8px;">
                        <button class="adm-btn adm-btn-primary" type="submit">${autoMsg_7b08a203f8}</button>
                        <button class="adm-btn adm-btn-ghost" type="button" onclick="resetSecurityFilters()">${autoMsg_74f0d21a9c}</button>
                    </div>

                    <input type="hidden" name="page" value="${search.page}">
                    <input type="hidden" name="size" value="${search.size}">
                    <input type="hidden" id="securitySortFieldInput" name="sortField" value="${fn:escapeXml(search.sortField)}">
                    <input type="hidden" id="securitySortDirInput" name="sortDir" value="${fn:escapeXml(search.sortDir)}">
                    <input type="hidden" id="securityDateFilterInput" name="dateFilter" value="${fn:escapeXml(search.dateFilter)}">
                    <input type="hidden" id="securityRequestKeyFilterInput" name="requestKey" value="${fn:escapeXml(search.requestKey)}">
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card adm-managed-section-card js-security-section-card" data-section="securityAudits" data-enhanced="true">
        <div class="adm-card-head">
            <div class="adm-card-title">
                <spring:message code="admin.security.historyTitle"/>
                <span id="securityTotalLabel" class="adm-section-total-inline">${autoMsg_549ebe4630}</span>
            </div>
            <div class="adm-section-head-actions">
                <select class="adm-select" id="securityExportFormat" style="width:90px;">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <div class="adm-export-menu">
                    <button type="button" class="adm-btn adm-btn-ghost js-security-export-toggle">${autoMsg_f499ec71fa} ▾</button>
                    <div id="securityExportDropdown" class="adm-export-dropdown">
                        <button type="button" onclick="exportSecurityAudits('all')">${autoMsg_9e26c9110b}</button>
                        <button type="button" onclick="exportSecurityAudits('search')">${autoMsg_7ba7fab06f}</button>
                        <button type="button" id="securityExportSelectedBtn" disabled onclick="exportSecurityAudits('selected')">${autoMsg_e849f53569} (0)</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="adm-local-toolbar adm-managed-local-toolbar">
            <div class="adm-local-toolbar-group adm-managed-toolbar-actions">
                <button type="button" class="adm-dash-sort-reset js-security-sort-reset" id="securitySortResetBtn" style="display:none;" onclick="resetSecuritySort()"></button>
                <select class="adm-select js-security-section-mode" id="securityModeSelect" title="${autoMsg_bcf57a4b2e}">
                    <option value="client" title="${autoMsg_5ca7a74e5e}">${autoMsg_deafe21b83}</option>
                    <option value="server" title="${autoMsg_c0c5affdfd}">${autoMsg_bee2025dd2}</option>
                </select>
                <select class="adm-select js-security-page-size" id="securitySizeSelect" style="width:90px;" onchange="changeSecuritySize(this.value)">
                    <option value="30" ${search.size==30 ? 'selected' : ''}>${autoMsg_7412fe3c9d}</option>
                    <option value="50" ${search.size==50 ? 'selected' : ''}>${autoMsg_7412fe3c9d}</option>
                    <option value="100" ${search.size==100 ? 'selected' : ''}>${autoMsg_7412fe3c9d}</option>
                </select>
            </div>
        </div>

        <div id="securityBulkBar" class="adm-audit-bulk-bar" style="display:none;">
            <span><strong id="securityBulkCount">0</strong>${autoMsg_be10370ce4}</span>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="clearSecuritySelection()">${autoMsg_598849a7a1}</button>
        </div>

        <div class="adm-table-wrap">
            <table class="adm-table adm-section-table-fixed adm-security-section-table" data-admin-list-ignore="true" data-section="securityAudits">
                <colgroup>
                    <col style="width:44px;">
                    <col style="width:150px;">
                    <col style="width:150px;">
                    <col style="width:150px;">
                    <col style="width:138px;">
                    <col style="width:96px;">
                    <col style="width:180px;">
                    <col style="width:190px;">
                    <col style="width:88px;">
                    <col style="width:210px;">
                    <col style="width:128px;">
                    <col style="width:220px;">
                    <col style="width:96px;">
                </colgroup>
                <thead>
                <tr>
                    <th class="adm-check-cell"><input type="checkbox" id="securityCheckAll" class="adm-check" onchange="toggleAllSecurity(this)"></th>
                    <th class="js-security-sort" data-sort="time" onclick="securitySortBy('time')">${autoMsg_00e1e31931}</th>
                    <th class="js-security-sort" data-sort="targetMember" onclick="securitySortBy('targetMember')">${autoMsg_8b69017288}</th>
                    <th class="js-security-sort" data-sort="actor" onclick="securitySortBy('actor')">${autoMsg_0f52313ee1}</th>
                    <th class="js-security-sort" data-sort="eventType" onclick="securitySortBy('eventType')">${autoMsg_fb96228926}</th>
                    <th class="js-security-sort" data-sort="eventStage" onclick="securitySortBy('eventStage')">${autoMsg_52ffa5a6ca}</th>
                    <th class="js-security-sort" data-sort="input" onclick="securitySortBy('input')">${autoMsg_519c6918d9}</th>
                    <th class="js-security-sort" data-sort="targetEmail" onclick="securitySortBy('targetEmail')">${autoMsg_258c2c3652}</th>
                    <th class="js-security-sort" data-sort="success" onclick="securitySortBy('success')">${autoMsg_005e5e108d}</th>
                    <th class="js-security-sort" data-sort="reason" onclick="securitySortBy('reason')">${autoMsg_79eefd9703}</th>
                    <th class="js-security-sort" data-sort="ip" onclick="securitySortBy('ip')">${autoMsg_fc792c14ad}</th>
                    <th class="js-security-sort" data-sort="requestId" onclick="securitySortBy('requestId')">${autoMsg_0f4728b0c0}</th>
                    <th></th>
                </tr>
                </thead>
                <tbody id="securityRowsBody">
                <%@ include file="_securityAuditRowsFragment.jsp" %>
                </tbody>
            </table>
        </div>

        <div class="adm-local-pagination" data-section="securityAudits" id="securityPaging">
            <div class="adm-local-page-info js-security-page-info" data-section="securityAudits">총 ${total}건 / 현재 ${fn:length(list)}건</div>
            <div class="adm-local-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost js-security-prev" onclick="goSecurityPage(securitySectionState.page - 1)">${autoMsg_7eab91f841}</button>
                <span class="js-security-page-state" data-section="securityAudits">${paging.currentPage} / ${paging.totalPage}</span>
                <button type="button" class="adm-btn adm-btn-ghost js-security-next" onclick="goSecurityPage(securitySectionState.page + 1)">${autoMsg_71a0fb020e}</button>
            </div>
        </div>
    </div>
</div>

<div id="securityDetailModal" class="adm-modal-overlay" onclick="closeSecurityDetailModal()">
    <div class="adm-modal adm-context-modal adm-context-modal-wide" onclick="event.stopPropagation()">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="securityDetailModalTitle">${autoMsg_c6bc5566a9}</div>
            <button class="adm-modal-close" type="button" onclick="closeSecurityDetailModal()">✕</button>
        </div>
        <div class="adm-modal-body" id="securityDetailModalContent" style="padding:20px 24px;max-height:72vh;overflow-y:auto;"></div>
        <div class="adm-modal-foot" style="justify-content:flex-end;">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeSecurityDetailModal()">${autoMsg_af16c287ca}</button>
        </div>
    </div>
</div>

<script>
const SECURITY_CTX = '${pageContext.request.contextPath}';
const SECURITY_MODE_STORAGE = 'admSecurityAuditSectionMode';
const SECURITY_CLIENT_MAX_SIZE = 10000;
const SECURITY_LOCALE = '${fn:escapeXml(pageContext.response.locale.toLanguageTag())}';
const SECURITY_MSG = {
    loadFailed: '${autoMsg_e6202f6055}',
    loadAllFailed: '${autoMsg_11a423d313}',
    dashSortReset: '${autoMsg_58eab77510}',
    totalCountFormat: '${autoMsg_3b06864ede}',
    currentCountFormat: '${autoMsg_0e68d86725}',
    noResults: '${autoMsg_5a558b55eb}',
    historyTitle: '${autoMsg_ed2b82c41f}'
};

var securitySectionState = {
    page: Number('${paging.currentPage}' || 1) || 1,
    pageSize: Number('${search.size}' || 30) || 30,
    sortBy: '',
    sortDir: 'DESC',
    mode: 'SERVER',
    clientRows: null,
    clientFilterKey: '',
    clientTotal: 0
};

function showSecurityToast(message, type) {
    if (typeof adm_toast === 'function') adm_toast(message, type);
    else console[type === 'error' ? 'error' : 'log'](message);
}
function escapeSecurityHtml(value) {
    return String(value == null ? '' : value)
        .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;').replace(/'/g, '&#39;');
}
function securityDash(value) {
    return value == null || String(value).trim() === '' ? '-' : String(value);
}
function getSecuritySearchForm() { return document.getElementById('securitySearchForm'); }
function getSecurityTbody() { return document.getElementById('securityRowsBody'); }
function getSecuritySearchFilterKey() {
    const form = getSecuritySearchForm();
    if (!form) return '';
    const params = new URLSearchParams();
    new FormData(form).forEach(function (val, key) {
        if (['page', 'size', 'sortField', 'sortDir', 'mode'].includes(key)) return;
        if (val != null && String(val).trim().length > 0) params.append(key, String(val).trim());
    });
    return params.toString();
}
function buildSecurityParams(pageOverride, options) {
    options = options || {};
    const form = getSecuritySearchForm();
    const params = new URLSearchParams();
    if (form) {
        new FormData(form).forEach(function (val, key) {
            if (!['page', 'size', 'sortField', 'sortDir'].includes(key)) params.append(key, val);
        });
    }
    params.set('page', String(pageOverride || securitySectionState.page || 1));
    params.set('size', String(options.clientFetch ? SECURITY_CLIENT_MAX_SIZE : (securitySectionState.pageSize || 30)));
    if (options.includeSort !== false && securitySectionState.sortBy) {
        params.set('sortField', securitySectionState.sortBy);
        params.set('sortDir', securitySectionState.sortDir || 'DESC');
    } else {
        params.delete('sortField');
        params.delete('sortDir');
    }
    return params;
}
function loadStoredSecurityMode() {
    return (localStorage.getItem(SECURITY_MODE_STORAGE) || 'SERVER').toUpperCase() === 'CLIENT' ? 'CLIENT' : 'SERVER';
}
function saveSecurityMode(mode) {
    securitySectionState.mode = mode === 'CLIENT' ? 'CLIENT' : 'SERVER';
    localStorage.setItem(SECURITY_MODE_STORAGE, securitySectionState.mode);
    const select = document.getElementById('securityModeSelect');
    if (select) select.value = securitySectionState.mode === 'CLIENT' ? 'client' : 'server';
}
function syncSecurityHiddenInputs() {
    const form = getSecuritySearchForm();
    if (!form) return;
    const page = form.querySelector('[name=page]');
    const size = form.querySelector('[name=size]');
    const sortField = document.getElementById('securitySortFieldInput');
    const sortDir = document.getElementById('securitySortDirInput');
    if (page) page.value = securitySectionState.page;
    if (size) size.value = securitySectionState.pageSize;
    if (sortField) sortField.value = securitySectionState.sortBy || '';
    if (sortDir) sortDir.value = securitySectionState.sortDir || 'DESC';
}
function updateSecuritySortIndicators() {
    document.querySelectorAll('.js-security-sort').forEach(function (th) {
        const active = !!securitySectionState.sortBy && th.dataset.sort === securitySectionState.sortBy;
        th.classList.toggle('sorted', active);
        let ico = th.querySelector('.sort-ico');
        if (active) {
            if (!ico) {
                ico = document.createElement('span');
                ico.className = 'sort-ico';
                ico.style.cssText = 'font-size:10px;margin-left:4px;font-weight:900;';
                th.appendChild(ico);
            }
            ico.textContent = securitySectionState.sortDir === 'ASC' ? '▲' : '▼';
            ico.style.color = securitySectionState.sortDir === 'ASC' ? '#ef4444' : '#3b82f6';
        } else if (ico) {
            ico.remove();
        }
    });
    const resetBtn = document.getElementById('securitySortResetBtn');
    if (resetBtn) {
        resetBtn.textContent = SECURITY_MSG.dashSortReset;
        resetBtn.style.display = securitySectionState.sortBy ? '' : 'none';
    }
}
function updateSecurityTotal(total) {
    const cardTitleCounter = document.getElementById('securityTotalLabel');
    if (cardTitleCounter) cardTitleCounter.textContent = '총 ' + Number(total || 0).toLocaleString() + '건';
}
function updateSecurityPaginationMeta(page, totalPages, total, renderedCount) {
    const safePages = Math.max(1, Number(totalPages || 1));
    const safePage = Math.min(Math.max(1, Number(page || 1)), safePages);
    securitySectionState.page = safePage;
    const pageInfo = document.querySelector('.js-security-page-info');
    if (pageInfo) {
        const totalText = SECURITY_MSG.totalCountFormat.replace('{0}', Number(total || 0).toLocaleString());
        const currentText = SECURITY_MSG.currentCountFormat.replace('{0}', Number(renderedCount || 0).toLocaleString());
        pageInfo.textContent = totalText + ' / ' + currentText;
    }
    const pageState = document.querySelector('.js-security-page-state');
    if (pageState) pageState.textContent = safePage + ' / ' + safePages;
    const prevBtn = document.querySelector('.js-security-prev');
    const nextBtn = document.querySelector('.js-security-next');
    if (prevBtn) prevBtn.disabled = safePage <= 1;
    if (nextBtn) nextBtn.disabled = safePage >= safePages;
    updateSecurityTotal(total);
    syncSecurityHiddenInputs();
}
function securitySortValue(row, field) {
    if (!row || !field) return '';
    if (field === 'time') return row.dataset.time || '0';
    if (field === 'targetMember') return row.dataset.targetMember || '';
    if (field === 'actor') return row.dataset.actor || '';
    if (field === 'eventType') return row.dataset.eventType || '';
    if (field === 'eventStage') return row.dataset.eventStage || '';
    if (field === 'input') return row.dataset.input || '';
    if (field === 'targetEmail') return row.dataset.targetEmail || '';
    if (field === 'success') return row.dataset.success || '0';
    if (field === 'reason') return row.dataset.reason || '';
    if (field === 'ip') return row.dataset.ip || '';
    if (field === 'requestId') return row.dataset.requestId || '';
    return row.dataset.time || '0';
}
function compareSecurityRows(a, b) {
    const field = securitySectionState.sortBy;
    if (!field) return Number(a.dataset.originalIndex || 0) - Number(b.dataset.originalIndex || 0);
    const av = securitySortValue(a, field);
    const bv = securitySortValue(b, field);
    const numericFields = ['time', 'success'];
    let cmp = numericFields.includes(field)
        ? ((Number(av) || 0) - (Number(bv) || 0))
        : String(av).localeCompare(String(bv), SECURITY_LOCALE || undefined, {numeric: true, sensitivity: 'base'});
    if (cmp === 0) cmp = (Number(a.dataset.time || 0) - Number(b.dataset.time || 0));
    return cmp * (securitySectionState.sortDir === 'DESC' ? -1 : 1);
}
function markSecurityOriginalIndices(rows) {
    rows.forEach(function (row, idx) {
        if (row.dataset.originalIndex == null) row.dataset.originalIndex = String(idx);
    });
}
function renderSecurityEmptyRow() {
    return '<tr class="adm-local-empty"><td colspan="13" style="text-align:center;color:#64748b;padding:32px;">' + escapeSecurityHtml(SECURITY_MSG.noResults) + '</td></tr>';
}
async function renderServerSecurity(pageOverride) {
    securitySectionState.mode = 'SERVER';
    const params = buildSecurityParams(pageOverride, {includeSort: true});
    const tbody = getSecurityTbody();
    if (!tbody) return;
    tbody.classList.add('is-loading');
    try {
        const res = await fetch(SECURITY_CTX + '/admin/security/fragment?' + params.toString(), {
            credentials: 'same-origin',
            headers: {'Accept': 'text/html', 'X-Requested-With': 'XMLHttpRequest'}
        });
        const html = await res.text();
        if (!res.ok) throw new Error(html || SECURITY_MSG.loadFailed);
        tbody.innerHTML = html.trim() || renderSecurityEmptyRow();
        const rows = Array.from(tbody.querySelectorAll('.js-security-row'));
        markSecurityOriginalIndices(rows);
        const total = Number(res.headers.get('X-Section-Total') || rows.length || 0);
        const page = Number(res.headers.get('X-Section-Page') || params.get('page') || 1);
        const size = Number(res.headers.get('X-Section-Size') || securitySectionState.pageSize || 30);
        const pages = Number(res.headers.get('X-Section-Pages') || 1);
        securitySectionState.pageSize = [30,50,100].includes(size) ? size : securitySectionState.pageSize;
        const sizeSelect = document.getElementById('securitySizeSelect');
        if (sizeSelect) sizeSelect.value = String(securitySectionState.pageSize);
        updateSecurityPaginationMeta(page, pages, total, rows.length);
        updateSecuritySortIndicators();
        clearSecuritySelection();
    } catch (e) {
        showSecurityToast(e.message || SECURITY_MSG.loadFailed, 'error');
    } finally {
        tbody.classList.remove('is-loading');
    }
}
async function ensureClientSecurityRows() {
    const filterKey = getSecuritySearchFilterKey();
    if (securitySectionState.clientRows && securitySectionState.clientFilterKey === filterKey) return;
    const params = buildSecurityParams(1, {clientFetch: true, includeSort: false});
    const res = await fetch(SECURITY_CTX + '/admin/security/fragment?' + params.toString(), {
        credentials: 'same-origin',
        headers: {'Accept': 'text/html', 'X-Requested-With': 'XMLHttpRequest'}
    });
    const html = await res.text();
    if (!res.ok) throw new Error(html || SECURITY_MSG.loadAllFailed);
    const temp = document.createElement('tbody');
    temp.innerHTML = html;
    const rows = Array.from(temp.querySelectorAll('.js-security-row'));
    markSecurityOriginalIndices(rows);
    securitySectionState.clientRows = rows;
    securitySectionState.clientFilterKey = filterKey;
    securitySectionState.clientTotal = Number(res.headers.get('X-Section-Total') || rows.length || 0);
}
async function renderClientSecurity(pageOverride) {
    securitySectionState.mode = 'CLIENT';
    const tbody = getSecurityTbody();
    if (!tbody) return;
    tbody.classList.add('is-loading');
    try {
        await ensureClientSecurityRows();
        let rows = (securitySectionState.clientRows || []).slice();
        rows.sort(compareSecurityRows);
        const total = rows.length;
        const pageSize = securitySectionState.pageSize || 30;
        const totalPages = Math.max(1, Math.ceil(total / pageSize));
        const page = Math.min(Math.max(1, Number(pageOverride || securitySectionState.page || 1)), totalPages);
        const start = (page - 1) * pageSize;
        const visible = rows.slice(start, start + pageSize);
        tbody.innerHTML = '';
        if (visible.length === 0) tbody.innerHTML = renderSecurityEmptyRow();
        else visible.forEach(function (row) { tbody.appendChild(row.cloneNode(true)); });
        updateSecurityPaginationMeta(page, totalPages, total, visible.length);
        updateSecuritySortIndicators();
        clearSecuritySelection();
    } catch (e) {
        showSecurityToast(e.message || SECURITY_MSG.loadAllFailed, 'error');
    } finally {
        tbody.classList.remove('is-loading');
    }
}
async function renderSecurityByMode(pageOverride) {
    return securitySectionState.mode === 'CLIENT' ? renderClientSecurity(pageOverride) : renderServerSecurity(pageOverride);
}
function securitySortBy(field) {
    const same = securitySectionState.sortBy === field;
    securitySectionState.sortBy = field;
    securitySectionState.sortDir = same && securitySectionState.sortDir === 'ASC' ? 'DESC' : 'ASC';
    securitySectionState.page = 1;
    renderSecurityByMode(1);
}
function resetSecuritySort() {
    securitySectionState.sortBy = '';
    securitySectionState.sortDir = 'DESC';
    securitySectionState.page = 1;
    renderSecurityByMode(1);
}
function clearSecurityRequestKeyFilter() {
    const requestKeyInput = document.getElementById('securityRequestKeyFilterInput');
    if (requestKeyInput) requestKeyInput.value = '';
}
function resetSecurityFilters() {
    const form = getSecuritySearchForm();
    if (form) {
        const setValue = function (name, value) {
            const el = form.querySelector('[name=' + name + ']');
            if (el) el.value = value;
        };
        setValue('keyword', '');
        setValue('success', 'ALL');
        setValue('eventType', 'ALL');
        setValue('eventStage', 'ALL');
        setValue('dateFilter', '');
        setValue('requestKey', '');
    }
    securitySectionState.page = 1;
    securitySectionState.sortBy = '';
    securitySectionState.sortDir = 'DESC';
    securitySectionState.clientRows = null;
    renderSecurityByMode(1);
}
function goSecurityPage(page) {
    renderSecurityByMode(Math.max(1, Number(page || 1)));
}
function changeSecuritySize(size) {
    const parsed = Number(size);
    securitySectionState.pageSize = [30,50,100].includes(parsed) ? parsed : 30;
    securitySectionState.page = 1;
    syncSecurityHiddenInputs();
    renderSecurityByMode(1);
}
function filterSecurityByDate(dateStr) {
    const dateInput = document.getElementById('securityDateFilterInput');
    if (dateInput) dateInput.value = dateStr || '';
    clearSecurityRequestKeyFilter();
    securitySectionState.page = 1;
    securitySectionState.clientRows = null;
    renderSecurityByMode(1);
}
function applySecurityKeywordFilter(button) {
    const keyword = button.getAttribute('data-keyword');
    if (!keyword) return;
    const form = getSecuritySearchForm();
    const input = form ? form.querySelector('[name=keyword]') : null;
    if (input) input.value = keyword;
    clearSecurityRequestKeyFilter();
    securitySectionState.page = 1;
    securitySectionState.clientRows = null;
    renderSecurityByMode(1);
}
function applySecuritySelectFilter(button) {
    const paramName = button.getAttribute('data-param-name');
    const paramValue = button.getAttribute('data-param-value');
    if (!paramName || !paramValue) return;
    const form = getSecuritySearchForm();
    const input = form ? form.querySelector('[name=' + paramName + ']') : null;
    if (input) input.value = paramValue;
    clearSecurityRequestKeyFilter();
    securitySectionState.page = 1;
    securitySectionState.clientRows = null;
    renderSecurityByMode(1);
}
function applySecurityRequestFlowFilter(button) {
    const requestKey = button.getAttribute('data-request-key') || button.getAttribute('data-keyword');
    if (!requestKey) return;
    const form = getSecuritySearchForm();
    if (form) {
        const setValue = function (name, value) {
            const el = form.querySelector('[name=' + name + ']');
            if (el) el.value = value;
        };
        // 요청/흐름 ID 클릭은 다른 검색 조건을 유지하지 않고 해당 흐름 전체를 보이게 한다.
        setValue('keyword', '');
        setValue('success', 'ALL');
        setValue('eventType', 'ALL');
        setValue('eventStage', 'ALL');
        setValue('dateFilter', '');
        setValue('requestKey', requestKey);
    }
    securitySectionState.page = 1;
    securitySectionState.clientRows = null;
    renderSecurityByMode(1);
}
function closeSecurityDetailModal() {
    const modal = document.getElementById('securityDetailModal');
    if (modal) modal.classList.remove('open');
}
function securityDetailField(label, value, options) {
    const opts = options || {};
    const text = securityDash(value);
    const className = opts.pre ? ' adm-audit-detail-prevalue' : '';
    return '<div class="adm-audit-detail-field">'
        + '<div class="adm-audit-detail-label">' + escapeSecurityHtml(label) + '</div>'
        + '<div class="adm-audit-detail-value' + className + '">' + escapeSecurityHtml(text) + '</div>'
        + '</div>';
}
function securityDetailSection(title, fields) {
    return '<section class="adm-audit-detail-section">'
        + '<div class="adm-audit-detail-section-title">' + escapeSecurityHtml(title) + '</div>'
        + '<div class="adm-audit-detail-grid">' + fields.join('') + '</div>'
        + '</section>';
}

function getSecurityCheckedBoxes() {
    return Array.from(document.querySelectorAll('.js-security-row-check:checked'));
}
function toggleAllSecurity(cb) {
    document.querySelectorAll('.js-security-row-check').forEach(function (c) { c.checked = cb.checked; });
    updateSecuritySelectionState();
}
function clearSecuritySelection() {
    document.querySelectorAll('.js-security-row-check').forEach(function (c) { c.checked = false; });
    const all = document.getElementById('securityCheckAll');
    if (all) all.checked = false;
    updateSecuritySelectionState();
}
function updateSecuritySelectionState() {
    const checked = getSecurityCheckedBoxes();
    const n = checked.length;
    const bar = document.getElementById('securityBulkBar');
    if (bar) bar.style.display = n > 0 ? 'flex' : 'none';
    const count = document.getElementById('securityBulkCount');
    if (count) count.textContent = n;
    const selectedBtn = document.getElementById('securityExportSelectedBtn');
    if (selectedBtn) {
        selectedBtn.disabled = n === 0;
        selectedBtn.textContent = '선택 내보내기 (' + n + ')';
    }
    const all = document.getElementById('securityCheckAll');
    if (all) {
        const rows = Array.from(document.querySelectorAll('.js-security-row-check'));
        all.checked = rows.length > 0 && n === rows.length;
        all.indeterminate = n > 0 && n < rows.length;
    }
}
function securityHeaderLabels() {
    return Array.from(document.querySelectorAll('.adm-security-section-table thead th'))
        .slice(1, -1)
        .map(function (th) { return th.textContent.trim(); });
}
function securityRowToExportValues(row) {
    return Array.from(row.children).slice(1, -1).map(function (td) {
        return td.textContent.replace(/\s+/g, ' ').trim();
    });
}
function securityRowsToCsv(rows) {
    const csvEscape = function (v) { return '"' + String(v == null ? '' : v).replace(/"/g, '""') + '"'; };
    const lines = [securityHeaderLabels().map(csvEscape).join(',')];
    rows.forEach(function (row) { lines.push(securityRowToExportValues(row).map(csvEscape).join(',')); });
    return '\ufeff' + lines.join('\r\n');
}
function securityRowsToExcelHtml(rows) {
    const esc = function (v) { return escapeSecurityHtml(v); };
    let html = '<table><thead><tr>' + securityHeaderLabels().map(function (h) { return '<th>' + esc(h) + '</th>'; }).join('') + '</tr></thead><tbody>';
    rows.forEach(function (row) {
        html += '<tr>' + securityRowToExportValues(row).map(function (v) { return '<td>' + esc(v) + '</td>'; }).join('') + '</tr>';
    });
    html += '</tbody></table>';
    return '\ufeff<html><head><meta charset="UTF-8"></head><body>' + html + '</body></html>';
}
function downloadSecurityBlob(content, filename, mime) {
    const blob = new Blob([content], {type: mime});
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = filename;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
}
async function fetchSecurityRowsForExport(scope) {
    if (scope === 'selected') {
        return getSecurityCheckedBoxes().map(function (cb) { return cb.closest('tr'); }).filter(Boolean);
    }
    const params = scope === 'all' ? new URLSearchParams() : buildSecurityParams(1, {includeSort: true});
    params.set('page', '1');
    params.set('size', String(SECURITY_CLIENT_MAX_SIZE));
    if (scope === 'all') {
        params.set('sortField', securitySectionState.sortBy || '');
        params.set('sortDir', securitySectionState.sortBy ? securitySectionState.sortDir : '');
    }
    const res = await fetch(SECURITY_CTX + '/admin/security/fragment?' + params.toString(), {
        credentials: 'same-origin',
        headers: {'Accept': 'text/html', 'X-Requested-With': 'XMLHttpRequest'}
    });
    const html = await res.text();
    if (!res.ok) throw new Error(html || SECURITY_MSG.loadAllFailed);
    const temp = document.createElement('tbody');
    temp.innerHTML = html;
    return Array.from(temp.querySelectorAll('.js-security-row'));
}
async function exportSecurityAudits(scope) {
    try {
        const rows = await fetchSecurityRowsForExport(scope);
        if (!rows.length) { showSecurityToast('내보낼 항목이 없습니다.', 'error'); return; }
        const format = (document.getElementById('securityExportFormat') || {}).value === 'excel' ? 'excel' : 'csv';
        const stamp = new Date().toISOString().slice(0, 10).replace(/-/g, '');
        if (format === 'excel') {
            downloadSecurityBlob(securityRowsToExcelHtml(rows), 'security-audits-' + scope + '-' + stamp + '.xls', 'application/vnd.ms-excel;charset=utf-8');
        } else {
            downloadSecurityBlob(securityRowsToCsv(rows), 'security-audits-' + scope + '-' + stamp + '.csv', 'text/csv;charset=utf-8');
        }
        const dropdown = document.getElementById('securityExportDropdown');
        if (dropdown) dropdown.classList.remove('open');
    } catch (e) {
        showSecurityToast(e.message || SECURITY_MSG.loadAllFailed, 'error');
    }
}

function openSecurityDetail(btn) {
    const d = btn.dataset;
    const modal = document.getElementById('securityDetailModal');
    const title = document.getElementById('securityDetailModalTitle');
    const content = document.getElementById('securityDetailModalContent');
    if (!modal || !title || !content) return;
    title.textContent = SECURITY_MSG.historyTitle + ' · ' + securityDash(d.eventType);
    content.innerHTML =
        '<div class="adm-audit-detail-shell">'
        + '<div class="adm-audit-detail-hero">'
        + '  <div>'
        + '    <div class="adm-audit-detail-kicker">Security Audit</div>'
        + '    <div class="adm-audit-detail-title">' + escapeSecurityHtml(securityDash(d.eventType)) + ' / ' + escapeSecurityHtml(securityDash(d.eventStage)) + '</div>'
        + '    <div class="adm-audit-detail-sub">' + escapeSecurityHtml(securityDash(d.time)) + '</div>'
        + '  </div>'
        + '  <span class="status-badge ' + (d.success === 'SUCCESS' ? 'ACTIVE' : 'DELETED') + '">' + escapeSecurityHtml(securityDash(d.success)) + '</span>'
        + '</div>'
        + securityDetailSection('대상 / 실행 주체', [
            securityDetailField('대상 회원', d.targetUser),
            securityDetailField('실행 주체', d.actor),
            securityDetailField('입력 식별자', d.identifier),
            securityDetailField('대상 이메일', d.targetEmail)
        ])
        + securityDetailSection('이벤트', [
            securityDetailField('이벤트 유형', d.eventType),
            securityDetailField('단계', d.eventStage),
            securityDetailField('결과', d.success),
            securityDetailField('실패 사유', d.failReason, {pre:true})
        ])
        + securityDetailSection('요청 컨텍스트', [
            securityDetailField('IP', d.ip),
            securityDetailField('요청/흐름 ID', d.requestKey || d.requestId || d.flowTrace),
            securityDetailField('흐름 추적 ID', d.flowTrace),
            securityDetailField('User-Agent', d.userAgent, {pre:true})
        ])
        + securityDetailSection('상세 메시지', [
            securityDetailField('상세 메시지', d.detailMsg, {pre:true})
        ])
        + '</div>';
    modal.classList.add('open');
}
function initSecuritySection() {
    const sizeSelect = document.getElementById('securitySizeSelect');
    securitySectionState.pageSize = Number(sizeSelect ? sizeSelect.value : securitySectionState.pageSize) || 30;
    const sortFieldInput = document.getElementById('securitySortFieldInput');
    const sortDirInput = document.getElementById('securitySortDirInput');
    securitySectionState.sortBy = sortFieldInput ? sortFieldInput.value : '';
    securitySectionState.sortDir = sortDirInput && sortDirInput.value === 'ASC' ? 'ASC' : 'DESC';
    saveSecurityMode(loadStoredSecurityMode());

    const modeSelect = document.getElementById('securityModeSelect');
    if (modeSelect) {
        modeSelect.addEventListener('change', function () {
            saveSecurityMode(modeSelect.value === 'client' ? 'CLIENT' : 'SERVER');
            securitySectionState.page = 1;
            securitySectionState.clientRows = null;
            renderSecurityByMode(1);
        });
    }

    const form = getSecuritySearchForm();
    if (form) {
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            clearSecurityRequestKeyFilter();
            securitySectionState.page = 1;
            securitySectionState.clientRows = null;
            renderSecurityByMode(1);
        });
    }

    const exportToggle = document.querySelector('.js-security-export-toggle');
    const exportDropdown = document.getElementById('securityExportDropdown');
    if (exportToggle && exportDropdown) {
        exportToggle.addEventListener('click', function (e) { e.stopPropagation(); exportDropdown.classList.toggle('open'); });
        document.addEventListener('click', function (e) {
            if (!exportToggle.contains(e.target) && !exportDropdown.contains(e.target)) exportDropdown.classList.remove('open');
        });
    }

    const existingRows = Array.from(document.querySelectorAll('#securityRowsBody .js-security-row'));
    markSecurityOriginalIndices(existingRows);
    const pageState = document.querySelector('.js-security-page-state');
    const totalPages = pageState && pageState.textContent.indexOf('/') >= 0 ? Number(pageState.textContent.split('/')[1].trim()) : 1;
    updateSecurityPaginationMeta(securitySectionState.page, totalPages, Number('${total}' || existingRows.length), existingRows.length);
    updateSecuritySortIndicators();
    updateSecuritySelectionState();
    if (securitySectionState.mode === 'CLIENT') renderSecurityByMode(1);
}
document.addEventListener('DOMContentLoaded', initSecuritySection);
</script>

<%@ include file="../layout-close.jsp" %>
