<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
                        <div class="adm-filter-label"><spring:message code="admin.common.search"/></div>
                        <span class="adm-search-ico">🔍</span>
                        <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(search.keyword)}" placeholder="<spring:message code='admin.security.searchPlaceholder'/>">
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.logs.success"/></div>
                        <select class="adm-select" name="success">
                            <option value="ALL" ${search.success=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="SUCCESS" ${search.success=='SUCCESS'?'selected':''}><spring:message code="admin.common.success"/></option>
                            <option value="FAIL" ${search.success=='FAIL'?'selected':''}><spring:message code="admin.common.fail"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.security.eventType"/></div>
                        <select class="adm-select" name="eventType">
                            <option value="ALL" ${search.eventType=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="FIND_ID" ${search.eventType=='FIND_ID'?'selected':''}><spring:message code="admin.security.eventType.findId"/></option>
                            <option value="FIND_PASSWORD" ${search.eventType=='FIND_PASSWORD'?'selected':''}><spring:message code="admin.security.eventType.findPassword"/></option>
                            <option value="RESET_PASSWORD" ${search.eventType=='RESET_PASSWORD'?'selected':''}><spring:message code="admin.security.eventType.resetPassword"/></option>
                            <option value="PASSWORD_CHANGE" ${search.eventType=='PASSWORD_CHANGE'?'selected':''}><spring:message code="admin.security.eventType.passwordChange"/></option>
                            <option value="EMAIL_VERIFY" ${search.eventType=='EMAIL_VERIFY'?'selected':''}><spring:message code="admin.security.eventType.emailVerify"/></option>
                            <option value="EMAIL_LOGIN_TOGGLE" ${search.eventType=='EMAIL_LOGIN_TOGGLE'?'selected':''}><spring:message code="admin.security.eventType.emailLoginToggle"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.security.stage"/></div>
                        <select class="adm-select" name="eventStage">
                            <option value="ALL" ${search.eventStage=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="REQUEST" ${search.eventStage=='REQUEST'?'selected':''}><spring:message code="admin.security.stage.request"/></option>
                            <option value="ISSUE" ${search.eventStage=='ISSUE'?'selected':''}><spring:message code="admin.security.stage.issue"/></option>
                            <option value="VERIFY" ${search.eventStage=='VERIFY'?'selected':''}><spring:message code="admin.security.stage.verify"/></option>
                            <option value="COMPLETE" ${search.eventStage=='COMPLETE'?'selected':''}><spring:message code="admin.security.stage.complete"/></option>
                        </select>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:8px;">
                        <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
                        <button class="adm-btn adm-btn-ghost" type="button" onclick="resetSecurityFilters()"><spring:message code="admin.common.reset"/></button>
                    </div>

                    <input type="hidden" name="page" value="${search.page}">
                    <input type="hidden" name="size" value="${search.size}">
                    <input type="hidden" id="securitySortFieldInput" name="sortField" value="${fn:escapeXml(search.sortField)}">
                    <input type="hidden" id="securitySortDirInput" name="sortDir" value="${fn:escapeXml(search.sortDir)}">
                    <input type="hidden" id="securityDateFilterInput" name="dateFilter" value="${fn:escapeXml(search.dateFilter)}">
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card adm-managed-section-card js-security-section-card" data-section="securityAudits" data-enhanced="true">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.security.historyTitle"/></div>
            <div style="font-size:12px;color:#64748b;"><spring:message code="admin.common.totalCount" arguments="${total}"/></div>
        </div>

        <div class="adm-local-toolbar adm-managed-local-toolbar">
            <div class="adm-local-toolbar-group adm-managed-toolbar-actions">
                <button type="button" class="adm-dash-sort-reset js-security-sort-reset" id="securitySortResetBtn" style="display:none;" onclick="resetSecuritySort()"></button>
                <select class="adm-select js-security-section-mode" id="securityModeSelect" title="<spring:message code='admin.blocks.mode.label'/>">
                    <option value="client" title="<spring:message code='admin.blocks.mode.tipClient'/>"><spring:message code="admin.blocks.mode.client"/></option>
                    <option value="server" title="<spring:message code='admin.blocks.mode.tipServer'/>"><spring:message code="admin.blocks.mode.server"/></option>
                </select>
                <select class="adm-select js-security-page-size" id="securitySizeSelect" style="width:90px;" onchange="changeSecuritySize(this.value)">
                    <option value="30" ${search.size==30 ? 'selected' : ''}><spring:message code="admin.common.pageSize" arguments="30"/></option>
                    <option value="50" ${search.size==50 ? 'selected' : ''}><spring:message code="admin.common.pageSize" arguments="50"/></option>
                    <option value="100" ${search.size==100 ? 'selected' : ''}><spring:message code="admin.common.pageSize" arguments="100"/></option>
                </select>
            </div>
        </div>

        <div class="adm-table-wrap">
            <table class="adm-table adm-section-table-fixed adm-security-section-table" data-admin-list-ignore="true" data-section="securityAudits">
                <colgroup>
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
                    <th class="js-security-sort" data-sort="time" onclick="securitySortBy('time')"><spring:message code="admin.common.time"/><span class="sort-ico">▼</span></th>
                    <th class="js-security-sort" data-sort="targetMember" onclick="securitySortBy('targetMember')"><spring:message code="admin.security.targetMember"/><span class="sort-ico">▼</span></th>
                    <th class="js-security-sort" data-sort="actor" onclick="securitySortBy('actor')"><spring:message code="admin.security.actor"/><span class="sort-ico">▼</span></th>
                    <th class="js-security-sort" data-sort="eventType" onclick="securitySortBy('eventType')"><spring:message code="admin.security.eventType"/><span class="sort-ico">▼</span></th>
                    <th class="js-security-sort" data-sort="eventStage" onclick="securitySortBy('eventStage')"><spring:message code="admin.security.stage"/><span class="sort-ico">▼</span></th>
                    <th class="js-security-sort" data-sort="input" onclick="securitySortBy('input')"><spring:message code="admin.context.inputValue"/><span class="sort-ico">▼</span></th>
                    <th class="js-security-sort" data-sort="targetEmail" onclick="securitySortBy('targetEmail')"><spring:message code="admin.context.targetEmail"/><span class="sort-ico">▼</span></th>
                    <th class="js-security-sort" data-sort="success" onclick="securitySortBy('success')"><spring:message code="admin.common.result"/><span class="sort-ico">▼</span></th>
                    <th class="js-security-sort" data-sort="reason" onclick="securitySortBy('reason')"><spring:message code="admin.common.reason"/><span class="sort-ico">▼</span></th>
                    <th class="js-security-sort" data-sort="ip" onclick="securitySortBy('ip')"><spring:message code="admin.common.ip"/><span class="sort-ico">▼</span></th>
                    <th class="js-security-sort" data-sort="requestId" onclick="securitySortBy('requestId')"><spring:message code="admin.context.requestId"/><span class="sort-ico">▼</span></th>
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
                <button type="button" class="adm-btn adm-btn-ghost js-security-prev" onclick="goSecurityPage(securitySectionState.page - 1)"><spring:message code="admin.common.prev"/></button>
                <span class="js-security-page-state" data-section="securityAudits">${paging.currentPage} / ${paging.totalPage}</span>
                <button type="button" class="adm-btn adm-btn-ghost js-security-next" onclick="goSecurityPage(securitySectionState.page + 1)"><spring:message code="admin.common.next"/></button>
            </div>
        </div>
    </div>
</div>

<div id="securityDetailModal" class="adm-modal-overlay" onclick="closeSecurityDetailModal()">
    <div class="adm-modal adm-context-modal adm-context-modal-wide" onclick="event.stopPropagation()">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="securityDetailModalTitle"><spring:message code="admin.security.historyTitle"/></div>
            <button class="adm-modal-close" type="button" onclick="closeSecurityDetailModal()">✕</button>
        </div>
        <div class="adm-modal-body" id="securityDetailModalContent" style="padding:20px 24px;max-height:72vh;overflow-y:auto;"></div>
        <div class="adm-modal-foot" style="justify-content:flex-end;">
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeSecurityDetailModal()"><spring:message code="admin.common.close"/></button>
        </div>
    </div>
</div>

<script>
const SECURITY_CTX = '${pageContext.request.contextPath}';
const SECURITY_MODE_STORAGE = 'admSecurityAuditSectionMode';
const SECURITY_CLIENT_MAX_SIZE = 10000;
const SECURITY_LOCALE = '${fn:escapeXml(pageContext.response.locale.toLanguageTag())}';
const SECURITY_MSG = {
    loadFailed: '<spring:message code="admin.common.loadFailed" text="목록을 불러오지 못했습니다." javaScriptEscape="true"/>',
    loadAllFailed: '<spring:message code="admin.common.loadAllFailed" text="전체 목록을 불러오지 못했습니다." javaScriptEscape="true"/>',
    dashSortReset: '<spring:message code="admin.blocks.js.dashSortReset" text="↺ 정렬 초기화" javaScriptEscape="true"/>',
    totalCountFormat: '<spring:message code="admin.common.totalCountFormat" text="총 {0}건" javaScriptEscape="true"/>',
    currentCountFormat: '<spring:message code="admin.common.currentCountFormat" text="현재 {0}건" javaScriptEscape="true"/>',
    noResults: '<spring:message code="admin.common.noResults" text="조회 결과가 없습니다." javaScriptEscape="true"/>',
    historyTitle: '<spring:message code="admin.security.historyTitle" text="보안 이력" javaScriptEscape="true"/>'
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
        th.classList.remove('sorted');
        const ico = th.querySelector('.sort-ico');
        if (ico) ico.textContent = '▼';
        if (securitySectionState.sortBy && th.dataset.sort === securitySectionState.sortBy) {
            th.classList.add('sorted');
            const icon = th.querySelector('.sort-ico');
            if (icon) icon.textContent = securitySectionState.sortDir === 'ASC' ? '▲' : '▼';
        }
    });
    const resetBtn = document.getElementById('securitySortResetBtn');
    if (resetBtn) {
        resetBtn.textContent = SECURITY_MSG.dashSortReset;
        resetBtn.style.display = securitySectionState.sortBy ? '' : 'none';
    }
}
function updateSecurityTotal(total) {
    const cardTitleCounter = document.querySelector('.js-security-section-card .adm-card-head > div:last-child');
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
    return '<tr class="adm-local-empty"><td colspan="12" style="text-align:center;color:#64748b;padding:32px;">' + escapeSecurityHtml(SECURITY_MSG.noResults) + '</td></tr>';
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
    securitySectionState.page = 1;
    securitySectionState.clientRows = null;
    renderSecurityByMode(1);
}
function openSecurityRelatedActivity(button) {
    const keyword = button.getAttribute('data-keyword');
    if (!keyword) return;
    const params = new URLSearchParams();
    params.set('keyword', keyword);
    params.set('page', '1');
    location.href = SECURITY_CTX + '/admin/activity-logs?' + params.toString();
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
            securityDetailField('요청 ID', d.requestId),
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
            securitySectionState.page = 1;
            securitySectionState.clientRows = null;
            renderSecurityByMode(1);
        });
    }

    const existingRows = Array.from(document.querySelectorAll('#securityRowsBody .js-security-row'));
    markSecurityOriginalIndices(existingRows);
    const pageState = document.querySelector('.js-security-page-state');
    const totalPages = pageState && pageState.textContent.indexOf('/') >= 0 ? Number(pageState.textContent.split('/')[1].trim()) : 1;
    updateSecurityPaginationMeta(securitySectionState.page, totalPages, Number('${total}' || existingRows.length), existingRows.length);
    updateSecuritySortIndicators();
    if (securitySectionState.mode === 'CLIENT') renderSecurityByMode(1);
}
document.addEventListener('DOMContentLoaded', initSecuritySection);
</script>

<%@ include file="../layout-close.jsp" %>
