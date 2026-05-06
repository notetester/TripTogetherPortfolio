<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_16af579649" code="admin.business.pageTitle"/>
<spring:message var="autoMsg_2eb70374a7" code="admin.business.pageSubtitle"/>
<spring:message var="autoMsg_70104e0814" code="admin.common.search"/>
<spring:message var="autoMsg_8f3c8aa535" code="admin.common.all"/>
<spring:message var="autoMsg_70aa03bd7f" code="admin.business.column.applicant"/>
<spring:message var="autoMsg_71a3285057" code="admin.business.column.companyInfo"/>
<spring:message var="autoMsg_73a5bc5b24" code="admin.business.managerSearch"/>
<spring:message var="autoMsg_4e2610b507" code="admin.business.businessNumberSearch"/>
<spring:message var="autoMsg_baf8a9caf8" code="admin.business.filter.status"/>
<spring:message var="autoMsg_cab2d9fe33" code="admin.business.status.pending"/>
<spring:message var="autoMsg_185bd76167" code="admin.business.status.approved"/>
<spring:message var="autoMsg_ce9bcdb179" code="admin.business.status.rejected"/>
<spring:message var="autoMsg_724e783009" code="admin.business.column.requestedRole"/>
<spring:message var="autoMsg_40237d6631" code="admin.business.role.business"/>
<spring:message var="autoMsg_f0e6fc650e" code="admin.business.role.partner"/>
<spring:message var="autoMsg_7b44677f84" code="admin.business.column.appliedAt"/>
<spring:message var="autoMsg_ab90a6e07c" code="admin.common.searchButton"/>
<spring:message var="autoMsg_871a5d2852" code="admin.common.reset"/>
<spring:message var="autoMsg_e35f294052" code="admin.common.export"/>
<spring:message var="autoMsg_8b2a9e9a9f" code="admin.common.exportAll"/>
<spring:message var="autoMsg_f75de738d9" code="admin.common.exportFiltered"/>
<spring:message var="autoMsg_efe2dcc95c" code="admin.common.exportSelected"/>
<spring:message var="autoMsg_e48adf43d8" code="admin.blocks.mode.label"/>
<spring:message var="autoMsg_afe095e6ce" code="admin.blocks.mode.tipClient"/>
<spring:message var="autoMsg_f935be5eea" code="admin.blocks.mode.client"/>
<spring:message var="autoMsg_0d5b6d1d55" code="admin.blocks.mode.tipServer"/>
<spring:message var="autoMsg_c4faf36202" code="admin.blocks.mode.server"/>
<spring:message var="autoMsg_c77a4d64e5" code="admin.common.pageSize"/>
<spring:message var="autoMsg_d62fefdd10" code="admin.common.selectedCount"/>
<spring:message var="autoMsg_ccde0de3bf" code="admin.business.rejectReasonPlaceholder"/>
<spring:message var="autoMsg_e9b1a92c17" code="admin.common.clearSelection"/>
<spring:message var="autoMsg_f7ed844e00" code="admin.common.status"/>
<spring:message var="autoMsg_19a797248a" code="admin.business.column.review"/>
<spring:message var="autoMsg_005f1c3518" code="admin.common.prev"/>
<spring:message var="autoMsg_3bd4078056" code="admin.common.next"/>
<spring:message var="autoMsg_c5b5e0fdf8" code="admin.common.close"/>
<spring:message var="autoMsg_a3756e975b" code="admin.blocks.js.dashSortReset" javaScriptEscape="true"/>
<spring:message var="autoMsg_a968042925" code="admin.common.exportSelected" javaScriptEscape="true"/>
<spring:message var="autoMsg_a778883f6f" code="admin.business.rejectReasonPlaceholder" javaScriptEscape="true"/>
<spring:message var="autoMsg_2c274d3fb4" code="admin.business.noResults" javaScriptEscape="true"/>
<c:set var="activeMenu" value="businessApplications"/>
<spring:message code="admin.business.pageTitle" var="adminBusinessPageTitle"/>
<c:set var="pageTitle"  value="${adminBusinessPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${autoMsg_16af579649}</h1>
            <p>${autoMsg_2eb70374a7}</p>
        </div>
    </div>

    <c:if test="${not empty businessApplicationMessage}">
        <div class="adm-alert adm-alert-success">${fn:escapeXml(businessApplicationMessage)}</div>
    </c:if>
    <c:if test="${not empty businessApplicationError}">
        <div class="adm-alert adm-alert-danger">${fn:escapeXml(businessApplicationError)}</div>
    </c:if>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form id="businessSearchForm" method="get" action="${pageContext.request.contextPath}/admin/business-applications">
                <div class="adm-filter-bar">
                    <div style="flex:1;min-width:240px;">
                        <div class="adm-filter-label">${autoMsg_70104e0814}</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:132px;">
                                <option value="all" ${search.searchType eq 'all' ? 'selected' : ''}>${autoMsg_8f3c8aa535}</option>
                                <option value="applicant" ${search.searchType eq 'applicant' ? 'selected' : ''}>${autoMsg_70aa03bd7f}</option>
                                <option value="company" ${search.searchType eq 'company' ? 'selected' : ''}>${autoMsg_71a3285057}</option>
                                <option value="manager" ${search.searchType eq 'manager' ? 'selected' : ''}>${autoMsg_73a5bc5b24}</option>
                                <option value="businessNumber" ${search.searchType eq 'businessNumber' ? 'selected' : ''}>${autoMsg_4e2610b507}</option>
                            </select>
                            <div class="adm-search-box" style="flex:1;">
                                <span class="adm-search-ico">🔍</span>
                                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(search.keyword)}" placeholder="${autoMsg_70104e0814}">
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="adm-filter-label">${autoMsg_baf8a9caf8}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status eq 'ALL' ? 'selected' : ''}>${autoMsg_8f3c8aa535}</option>
                            <option value="PENDING" ${search.status eq 'PENDING' ? 'selected' : ''}>${autoMsg_cab2d9fe33}</option>
                            <option value="APPROVED" ${search.status eq 'APPROVED' ? 'selected' : ''}>${autoMsg_185bd76167}</option>
                            <option value="REJECTED" ${search.status eq 'REJECTED' ? 'selected' : ''}>${autoMsg_ce9bcdb179}</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">${autoMsg_724e783009}</div>
                        <select class="adm-select" name="requestedRole">
                            <option value="ALL" ${search.requestedRole eq 'ALL' ? 'selected' : ''}>${autoMsg_8f3c8aa535}</option>
                            <option value="BUSINESS" ${search.requestedRole eq 'BUSINESS' ? 'selected' : ''}>${autoMsg_40237d6631}</option>
                            <option value="PARTNER" ${search.requestedRole eq 'PARTNER' ? 'selected' : ''}>${autoMsg_f0e6fc650e}</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">${autoMsg_7b44677f84}</div>
                        <div style="display:flex;gap:4px;align-items:center;">
                            <input class="adm-input" type="date" name="dateFrom" value="${search.dateFrom}" style="width:130px;">
                            <span style="color:#475569;font-size:12px;">~</span>
                            <input class="adm-input" type="date" name="dateTo" value="${search.dateTo}" style="width:130px;">
                        </div>
                    </div>

                    <div style="display:flex;gap:6px;align-items:flex-end;">
                        <button type="submit" class="adm-btn adm-btn-primary">🔍 ${autoMsg_ab90a6e07c}</button>
                        <button type="button" class="adm-btn adm-btn-ghost" onclick="resetBusinessFilters()">${autoMsg_871a5d2852}</button>
                    </div>

                    <input type="hidden" name="page" value="${paging.currentPage}">
                    <input type="hidden" name="size" value="${search.size}">
                    <input type="hidden" id="businessSortByInput" name="sortBy" value="${search.sortBy}">
                    <input type="hidden" id="businessSortDirInput" name="sortDir" value="${search.sortDir}">
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card js-business-section-card adm-managed-section-card" data-section="businessApplications" data-enhanced="true" style="overflow:visible;">
        <div class="adm-card-head">
            <div class="adm-card-title">
                🏢 ${autoMsg_16af579649}
                <span id="businessTotalLabel" style="font-size:12px;font-weight:400;color:#475569;">총 ${total}건</span>
            </div>
            <div style="position:relative;display:flex;align-items:center;gap:8px;">
                <select class="adm-select" id="businessExportFormat" style="width:90px;">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost js-business-export-toggle">${autoMsg_e35f294052} ▾</button>
                <div id="businessExportDropdown" class="adm-export-dropdown">
                    <button type="button" class="adm-export-item" onclick="exportBusinessData('all')">${autoMsg_8b2a9e9a9f}</button>
                    <button type="button" class="adm-export-item" onclick="exportBusinessData('search')">${autoMsg_f75de738d9}</button>
                    <button type="button" class="adm-export-item" id="businessExportSelectedBtn" disabled onclick="exportBusinessData('selected')">${autoMsg_efe2dcc95c} (0)</button>
                </div>
            </div>
        </div>

        <div class="adm-local-toolbar adm-managed-local-toolbar">
            <div class="adm-local-toolbar-group adm-managed-toolbar-actions">
                <button type="button" class="adm-dash-sort-reset js-business-sort-reset" style="display:none;" onclick="resetBusinessSort()"></button>
                <select class="adm-select" id="businessModeSelect" title="${autoMsg_e48adf43d8}">
                    <option value="client" title="${autoMsg_afe095e6ce}">${autoMsg_f935be5eea}</option>
                    <option value="server" title="${autoMsg_0d5b6d1d55}">${autoMsg_c4faf36202}</option>
                </select>
                <select class="adm-select" id="businessSizeSelect" style="width:90px;" onchange="changeBusinessSize(this.value)">
                    <option value="10"  ${search.size==10  ? 'selected' : ''}>${autoMsg_c77a4d64e5}</option>
                    <option value="20"  ${search.size==20  ? 'selected' : ''}>${autoMsg_c77a4d64e5}</option>
                    <option value="50"  ${search.size==50  ? 'selected' : ''}>${autoMsg_c77a4d64e5}</option>
                    <option value="100" ${search.size==100 ? 'selected' : ''}>${autoMsg_c77a4d64e5}</option>
                </select>
            </div>
        </div>

        <div id="businessBulkBar" style="display:none;background:#1a3354;border:1px solid #2d6a9f;border-radius:8px;padding:10px 16px;margin:0 0 12px;align-items:center;gap:12px;flex-wrap:wrap;">
            <span style="color:#93c5fd;font-size:13px;font-weight:600;"><strong id="businessBulkCount">0</strong>${autoMsg_d62fefdd10}</span>
            <button type="button" class="adm-btn adm-btn-primary" style="font-size:12px;" onclick="bulkApproveBusiness()">${autoMsg_185bd76167}</button>
            <input class="adm-input" id="businessBulkRejectReason" maxlength="500" style="max-width:260px;" placeholder="${autoMsg_ccde0de3bf}">
            <button type="button" class="adm-btn adm-btn-danger" style="font-size:12px;" onclick="bulkRejectBusiness()">${autoMsg_ce9bcdb179}</button>
            <button type="button" class="adm-btn adm-btn-ghost" style="font-size:12px;margin-left:auto;" onclick="clearBusinessSelection()">${autoMsg_e9b1a92c17}</button>
        </div>

        <div class="adm-table-wrap" style="overflow:visible;">
            <table class="adm-table adm-section-table-fixed adm-business-section-table" data-admin-list-ignore="true" data-section="businessApplications">
                <thead>
                <tr>
                    <th style="width:40px;text-align:center;"><input type="checkbox" id="businessCheckAll" class="adm-check" onchange="toggleAllBusiness(this)"></th>
                    <th class="js-business-sort" data-sort="applicant" onclick="businessSortBy('applicant')" style="cursor:pointer;user-select:none;">${autoMsg_70aa03bd7f}</th>
                    <th class="js-business-sort" data-sort="requestedRole" onclick="businessSortBy('requestedRole')" style="cursor:pointer;user-select:none;">${autoMsg_724e783009}</th>
                    <th class="js-business-sort" data-sort="company" onclick="businessSortBy('company')" style="cursor:pointer;user-select:none;">${autoMsg_71a3285057}</th>
                    <th class="js-business-sort" data-sort="status" onclick="businessSortBy('status')" style="cursor:pointer;user-select:none;">${autoMsg_f7ed844e00}</th>
                    <th class="js-business-sort" data-sort="createdAt" onclick="businessSortBy('createdAt')" style="cursor:pointer;user-select:none;">${autoMsg_7b44677f84}</th>
                    <th>${autoMsg_19a797248a}</th>
                </tr>
                </thead>
                <tbody id="businessRowsBody">
                <%@ include file="_businessApplicationRowsFragment.jsp" %>
                </tbody>
            </table>
        </div>

        <div class="adm-local-pagination" data-section="businessApplications" id="businessPaging">
            <div class="adm-local-page-info js-business-page-info" data-section="businessApplications">총 ${total}건 / 현재 ${fn:length(applicationList)}건</div>
            <div class="adm-local-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost js-business-prev" onclick="goBusinessPage(businessSectionState.page - 1)">${autoMsg_005f1c3518}</button>
                <span class="js-business-page-state" data-section="businessApplications">${paging.currentPage} / ${paging.totalPage}</span>
                <button type="button" class="adm-btn adm-btn-ghost js-business-next" onclick="goBusinessPage(businessSectionState.page + 1)">${autoMsg_3bd4078056}</button>
            </div>
        </div>
    </div>
</div>


<div id="businessApplicationDetailModal" class="adm-modal-overlay" onclick="closeBusinessApplicationDetailModal()">
    <div class="adm-modal adm-context-modal adm-context-modal-wide" onclick="event.stopPropagation()">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="businessApplicationDetailTitle">기업 신청 상세</div>
            <button class="adm-modal-close" type="button" onclick="closeBusinessApplicationDetailModal()">✕</button>
        </div>
        <div class="adm-modal-body" id="businessApplicationDetailBody" style="padding:20px 24px;max-height:72vh;overflow-y:auto;"></div>
        <div class="adm-modal-foot" style="gap:8px;justify-content:flex-end;">
            <button class="adm-btn adm-btn-ghost" type="button" id="businessApplicationDetailMemberBtn">회원 설정</button>
            <button class="adm-btn adm-btn-primary" type="button" id="businessApplicationDetailReviewBtn">검토 위치로 이동</button>
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeBusinessApplicationDetailModal()">${autoMsg_c5b5e0fdf8}</button>
        </div>
    </div>
</div>

<script>
const BUSINESS_CTX = '${pageContext.request.contextPath}';
const BUSINESS_LOCALE = '${fn:escapeXml(pageContext.response.locale.toLanguageTag())}';
const BUSINESS_MSG = {
    sortReset: '${autoMsg_a3756e975b}',
    exportSelected: '${autoMsg_a968042925}',
    selectedMissing: '선택된 항목이 없습니다.',
    rejectReasonMissing: '${autoMsg_a778883f6f}',
    noResults: '${autoMsg_2c274d3fb4}'
};
const businessSectionState = {
    mode: 'SERVER',
    page: Number('${paging.currentPage}' || 1) || 1,
    pageSize: Number('${search.size}' || 20) || 20,
    sortBy: '${fn:escapeXml(search.sortBy)}',
    sortDir: '${fn:escapeXml(search.sortDir)}' || 'DESC',
    clientRows: null,
    clientFilterKey: null
};

function getBusinessForm() { return document.getElementById('businessSearchForm'); }
function getBusinessTbody() { return document.getElementById('businessRowsBody'); }
function loadBusinessMode() { return (localStorage.getItem('admin.businessApplications.mode') || 'SERVER').toUpperCase() === 'CLIENT' ? 'CLIENT' : 'SERVER'; }
function saveBusinessMode(mode) {
    businessSectionState.mode = mode === 'CLIENT' ? 'CLIENT' : 'SERVER';
    localStorage.setItem('admin.businessApplications.mode', businessSectionState.mode);
    const select = document.getElementById('businessModeSelect');
    if (select) select.value = businessSectionState.mode === 'CLIENT' ? 'client' : 'server';
}
function buildBusinessParams(pageOverride, options) {
    const opts = options || {};
    const form = getBusinessForm();
    const params = new URLSearchParams(form ? new FormData(form) : undefined);
    params.set('page', String(pageOverride || businessSectionState.page || 1));
    params.set('size', String(businessSectionState.pageSize || 20));
    params.set('mode', opts.clientFetch ? 'CLIENT' : businessSectionState.mode);
    if (opts.includeSort !== false && businessSectionState.sortBy) {
        params.set('sortBy', businessSectionState.sortBy);
        params.set('sortDir', businessSectionState.sortDir || 'DESC');
    } else {
        params.delete('sortBy');
        params.delete('sortDir');
    }
    return params;
}
function getBusinessFilterKey() {
    const params = buildBusinessParams(1, {includeSort: false, clientFetch: true});
    params.delete('page'); params.delete('size'); params.delete('mode');
    return params.toString();
}
function syncBusinessHiddenInputs() {
    const form = getBusinessForm();
    if (!form) return;
    const page = form.querySelector('[name=page]');
    const size = form.querySelector('[name=size]');
    const sortBy = document.getElementById('businessSortByInput');
    const sortDir = document.getElementById('businessSortDirInput');
    if (page) page.value = businessSectionState.page;
    if (size) size.value = businessSectionState.pageSize;
    if (sortBy) sortBy.value = businessSectionState.sortBy || '';
    if (sortDir) sortDir.value = businessSectionState.sortDir || 'DESC';
}
function updateBusinessSortIndicators() {
    document.querySelectorAll('.js-business-sort').forEach(function(th) {
        th.classList.remove('sorted');
        const old = th.querySelector('.sort-ico');
        if (old) old.remove();
        if (businessSectionState.sortBy && th.dataset.sort === businessSectionState.sortBy) {
            th.classList.add('sorted');
            const ico = document.createElement('span');
            ico.className = 'sort-ico';
            ico.textContent = businessSectionState.sortDir === 'ASC' ? '▲' : '▼';
            ico.style.color = businessSectionState.sortDir === 'ASC' ? '#ef4444' : '#3b82f6';
            th.appendChild(ico);
        }
    });
    const reset = document.querySelector('.js-business-sort-reset');
    if (reset) {
        reset.textContent = BUSINESS_MSG.sortReset || '↺ 초기화';
        reset.style.display = businessSectionState.sortBy ? '' : 'none';
    }
    syncBusinessHiddenInputs();
}
function updateBusinessPaginationMeta(page, pages, total, current) {
    const safePage = Math.max(1, Number(page || 1));
    const safePages = Math.max(1, Number(pages || 1));
    businessSectionState.page = safePage;
    const info = document.querySelector('.js-business-page-info');
    if (info) info.textContent = '총 ' + Number(total || 0) + '건 / 현재 ' + Number(current || 0) + '건';
    const label = document.getElementById('businessTotalLabel');
    if (label) label.textContent = '총 ' + Number(total || 0) + '건';
    const state = document.querySelector('.js-business-page-state');
    if (state) state.textContent = safePage + ' / ' + safePages;
    const prev = document.querySelector('.js-business-prev');
    const next = document.querySelector('.js-business-next');
    if (prev) prev.disabled = safePage <= 1;
    if (next) next.disabled = safePage >= safePages;
    syncBusinessHiddenInputs();
}
function markBusinessOriginal(rows) {
    rows.forEach(function(row, idx) { if (row.dataset.originalIndex == null) row.dataset.originalIndex = String(idx); });
}
function businessSortValue(row, field) {
    if (!row || !field) return '';
    if (field === 'requestedRole') return row.dataset.requestedRole || '';
    if (field === 'company') return row.dataset.company || '';
    if (field === 'status') return row.dataset.status || '';
    if (field === 'createdAt') return row.dataset.createdAt || '';
    if (field === 'reviewedAt') return row.dataset.reviewedAt || '';
    if (field === 'reviewer') return row.dataset.reviewer || '';
    if (field === 'applicationIdx') return row.dataset.applicationIdx || '0';
    return row.dataset.applicant || '';
}
function compareBusinessRows(a, b) {
    const field = businessSectionState.sortBy;
    if (!field) return Number(a.dataset.originalIndex || 0) - Number(b.dataset.originalIndex || 0);
    const av = businessSortValue(a, field);
    const bv = businessSortValue(b, field);
    const an = Number(av), bn = Number(bv);
    let cmp = (!Number.isNaN(an) && !Number.isNaN(bn) && /^-?\d+(\.\d+)?$/.test(String(av)) && /^-?\d+(\.\d+)?$/.test(String(bv)))
        ? an - bn
        : String(av).localeCompare(String(bv), BUSINESS_LOCALE || undefined, {numeric:true, sensitivity:'base'});
    return cmp * (businessSectionState.sortDir === 'DESC' ? -1 : 1);
}
function businessEmptyRow() { return '<tr class="adm-local-empty"><td colspan="7" style="text-align:center;color:#64748b;padding:32px;">' + BUSINESS_MSG.noResults + '</td></tr>'; }
async function renderServerBusiness(pageOverride) {
    businessSectionState.mode = 'SERVER';
    const params = buildBusinessParams(pageOverride, {includeSort:true});
    const tbody = getBusinessTbody(); if (!tbody) return;
    tbody.classList.add('is-loading');
    try {
        const res = await fetch(BUSINESS_CTX + '/admin/business-applications/fragment?' + params.toString(), {credentials:'same-origin', headers:{'Accept':'text/html','X-Requested-With':'XMLHttpRequest'}});
        const html = await res.text();
        if (!res.ok) throw new Error(html || '목록을 불러오지 못했습니다.');
        tbody.innerHTML = html.trim() || businessEmptyRow();
        const rows = Array.from(tbody.querySelectorAll('.js-business-row'));
        markBusinessOriginal(rows);
        updateBusinessPaginationMeta(Number(res.headers.get('X-Section-Page') || params.get('page') || 1), Number(res.headers.get('X-Section-Pages') || 1), Number(res.headers.get('X-Section-Total') || rows.length || 0), rows.length);
        updateBusinessSortIndicators();
        clearBusinessSelection();
    } catch (e) { adm_toast(e.message || '목록을 불러오지 못했습니다.', 'error'); }
    finally { tbody.classList.remove('is-loading'); }
}
async function ensureClientBusinessRows() {
    const key = getBusinessFilterKey();
    if (businessSectionState.clientRows && businessSectionState.clientFilterKey === key) return;
    const params = buildBusinessParams(1, {clientFetch:true, includeSort:false});
    const res = await fetch(BUSINESS_CTX + '/admin/business-applications/fragment?' + params.toString(), {credentials:'same-origin', headers:{'Accept':'text/html','X-Requested-With':'XMLHttpRequest'}});
    const html = await res.text();
    if (!res.ok) throw new Error(html || '전체 목록을 불러오지 못했습니다.');
    const temp = document.createElement('tbody');
    temp.innerHTML = html;
    const rows = Array.from(temp.querySelectorAll('.js-business-row'));
    markBusinessOriginal(rows);
    businessSectionState.clientRows = rows;
    businessSectionState.clientFilterKey = key;
}
async function renderClientBusiness(pageOverride) {
    businessSectionState.mode = 'CLIENT';
    const tbody = getBusinessTbody(); if (!tbody) return;
    tbody.classList.add('is-loading');
    try {
        await ensureClientBusinessRows();
        let rows = (businessSectionState.clientRows || []).slice();
        rows.sort(compareBusinessRows);
        const total = rows.length;
        const totalPages = Math.max(1, Math.ceil(total / businessSectionState.pageSize));
        const page = Math.min(Math.max(1, Number(pageOverride || businessSectionState.page || 1)), totalPages);
        const visible = rows.slice((page - 1) * businessSectionState.pageSize, page * businessSectionState.pageSize);
        tbody.innerHTML = '';
        if (!visible.length) tbody.innerHTML = businessEmptyRow();
        else visible.forEach(function(row) { tbody.appendChild(row.cloneNode(true)); });
        updateBusinessPaginationMeta(page, totalPages, total, visible.length);
        updateBusinessSortIndicators();
        clearBusinessSelection();
    } catch (e) { adm_toast(e.message || '전체 목록을 불러오지 못했습니다.', 'error'); }
    finally { tbody.classList.remove('is-loading'); }
}
function renderBusinessByMode(pageOverride) { return businessSectionState.mode === 'CLIENT' ? renderClientBusiness(pageOverride) : renderServerBusiness(pageOverride); }
function refreshBusinessSection() { if (businessSectionState.mode === 'CLIENT') businessSectionState.clientRows = null; return renderBusinessByMode(businessSectionState.page || 1); }
function businessSortBy(field) {
    const same = businessSectionState.sortBy === field;
    businessSectionState.sortBy = field;
    businessSectionState.sortDir = same && businessSectionState.sortDir === 'ASC' ? 'DESC' : 'ASC';
    renderBusinessByMode(1);
}
function resetBusinessSort() { businessSectionState.sortBy = ''; businessSectionState.sortDir = 'ASC'; renderBusinessByMode(1); }
function resetBusinessFilters() {
    const form = getBusinessForm();
    if (form) {
        form.querySelector('[name=searchType]').value = 'all';
        form.querySelector('[name=keyword]').value = '';
        form.querySelector('[name=status]').value = 'PENDING';
        form.querySelector('[name=requestedRole]').value = 'ALL';
        form.querySelector('[name=dateFrom]').value = '';
        form.querySelector('[name=dateTo]').value = '';
    }
    businessSectionState.sortBy = ''; businessSectionState.sortDir = 'ASC'; businessSectionState.page = 1; businessSectionState.clientRows = null;
    renderBusinessByMode(1);
}
function goBusinessPage(p) { renderBusinessByMode(Math.max(1, Number(p || 1))); }
function changeBusinessSize(size) { businessSectionState.pageSize = [10,20,50,100].includes(Number(size)) ? Number(size) : 20; renderBusinessByMode(1); }
function toggleAllBusiness(cb) { document.querySelectorAll('.js-business-row-check').forEach(function(c) { c.checked = cb.checked; }); updateBusinessBulkBar(); }
function selectedBusinessIds() { return Array.from(document.querySelectorAll('.js-business-row-check:checked')).map(function(c) { return c.value; }); }
function updateBusinessBulkBar() {
    const ids = selectedBusinessIds();
    const bar = document.getElementById('businessBulkBar');
    if (bar) bar.style.display = ids.length ? 'flex' : 'none';
    const count = document.getElementById('businessBulkCount');
    if (count) count.textContent = ids.length;
    const exportBtn = document.getElementById('businessExportSelectedBtn');
    if (exportBtn) { exportBtn.disabled = ids.length === 0; exportBtn.textContent = BUSINESS_MSG.exportSelected + ' (' + ids.length + ')'; }
    const all = document.getElementById('businessCheckAll');
    if (all) {
        const rows = document.querySelectorAll('.js-business-row-check');
        all.checked = rows.length > 0 && ids.length === rows.length;
        all.indeterminate = ids.length > 0 && ids.length < rows.length;
    }
}
function clearBusinessSelection() { document.querySelectorAll('.js-business-row-check, #businessCheckAll').forEach(function(c) { c.checked = false; c.indeterminate = false; }); updateBusinessBulkBar(); }

function businessDash(value) {
    return value == null || String(value).trim() === '' ? '-' : String(value);
}
function businessEscapeHtml(value) {
    return businessDash(value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
}
function businessRoleLabel(value) {
    if (value === 'BUSINESS') return '기업회원';
    if (value === 'PARTNER') return '파트너';
    if (value === 'ADMIN') return '관리자';
    if (value === 'USER') return '일반회원';
    return businessDash(value);
}
function businessStatusLabel(value) {
    if (value === 'PENDING') return '대기';
    if (value === 'APPROVED') return '승인';
    if (value === 'REJECTED') return '반려';
    return businessDash(value);
}
function businessBadge(value, type) {
    const raw = businessDash(value);
    if (raw === '-') return '<span class="adm-business-detail-muted">-</span>';
    return '<span class="adm-business-detail-badge ' + businessEscapeHtml(type || '') + ' ' + businessEscapeHtml(raw) + '">' + businessEscapeHtml(type === 'status' ? businessStatusLabel(raw) : businessRoleLabel(raw)) + '</span>';
}
function businessDetailField(label, value, options) {
    const opts = options || {};
    const focusAttr = opts.focus ? ' data-focus-key="' + businessEscapeHtml(opts.focus) + '"' : '';
    const focusClass = opts.focus ? ' is-focus-target' : '';
    const valueClass = opts.pre ? ' adm-business-prevalue' : '';
    const rendered = opts.html ? (value || '<span class="adm-business-detail-muted">-</span>') : businessEscapeHtml(value);
    return '<div class="adm-business-detail-field' + focusClass + '"' + focusAttr + '>'
        + '<div class="adm-business-detail-label">' + businessEscapeHtml(label) + '</div>'
        + '<div class="adm-business-detail-value' + valueClass + '">' + rendered + '</div>'
        + '</div>';
}
function businessDetailSection(title, fields, options) {
    const opts = options || {};
    return '<section class="adm-business-detail-section ' + businessEscapeHtml(opts.className || '') + '">'
        + '<div class="adm-business-detail-section-title">' + businessEscapeHtml(title) + '</div>'
        + '<div class="adm-business-detail-grid">' + fields.join('') + '</div>'
        + '</section>';
}
function closeBusinessApplicationDetailModal() {
    const modal = document.getElementById('businessApplicationDetailModal');
    if (modal) modal.classList.remove('open');
}
function openBusinessApplicationDetail(trigger) {
    const row = trigger ? trigger.closest('.js-business-row') : null;
    if (!row) return;
    const d = row.dataset;
    const modal = document.getElementById('businessApplicationDetailModal');
    const title = document.getElementById('businessApplicationDetailTitle');
    const body = document.getElementById('businessApplicationDetailBody');
    if (!modal || !title || !body) return;

    title.textContent = '#' + businessDash(d.applicationIdx) + ' · ' + businessDash(d.companyName);
    const applicant = businessDash(d.nickname) + (d.userId ? ' (@' + d.userId + ')' : '');
    const statusHtml = businessBadge(d.status, 'status');
    const requestedRoleHtml = businessBadge(d.requestedRole, 'role');
    const currentRoleHtml = businessBadge(d.currentRole, 'role');
    body.innerHTML =
        '<div class="adm-business-detail-shell">'
        + '<div class="adm-business-detail-hero">'
        + '  <div>'
        + '    <div class="adm-business-detail-kicker">기업 회원 신청</div>'
        + '    <div class="adm-business-detail-company">' + businessEscapeHtml(d.companyName) + '</div>'
        + '    <div class="adm-business-detail-sub">신청번호 #' + businessEscapeHtml(d.applicationIdx) + ' · ' + businessEscapeHtml(d.createdAtDisplay || d.createdAt) + '</div>'
        + '  </div>'
        + '  <div class="adm-business-detail-hero-badges">' + statusHtml + requestedRoleHtml + '</div>'
        + '</div>'
        + businessDetailSection('신청자 / 회원 정보', [
            businessDetailField('신청자', applicant),
            businessDetailField('회원 이메일', d.userEmail),
            businessDetailField('현재 권한', currentRoleHtml, {html:true}),
            businessDetailField('요청 권한', requestedRoleHtml, {html:true, focus:'role'})
        ])
        + businessDetailSection('회사 정보', [
            businessDetailField('회사명', d.companyName, {focus:'company'}),
            businessDetailField('사업자번호', d.businessNumber, {focus:'company'}),
            businessDetailField('담당자', d.managerName, {focus:'company'}),
            businessDetailField('담당자 연락처', d.managerPhone, {focus:'company'})
        ])
        + businessDetailSection('검토 정보', [
            businessDetailField('상태', statusHtml, {html:true, focus:'status'}),
            businessDetailField('신청일시', d.createdAtDisplay || d.createdAt, {focus:'date'}),
            businessDetailField('검토자', d.reviewer),
            businessDetailField('검토일시', d.reviewedAtDisplay || d.reviewedAt)
        ])
        + businessDetailSection('신청/반려 메모', [
            businessDetailField('신청 설명', d.description, {pre:true, focus:'company'}),
            businessDetailField('반려 사유', d.rejectReason, {pre:true, focus:'status'})
        ], {className:'is-wide'})
        + '</div>';

    const memberBtn = document.getElementById('businessApplicationDetailMemberBtn');
    if (memberBtn) {
        memberBtn.disabled = !d.userIdx;
        memberBtn.onclick = function() {
            closeBusinessApplicationDetailModal();
            if (d.userIdx) openAdminMemberContext(d.userIdx, 'actions');
        };
    }
    const reviewBtn = document.getElementById('businessApplicationDetailReviewBtn');
    if (reviewBtn) {
        reviewBtn.disabled = d.status !== 'PENDING';
        reviewBtn.onclick = function() {
            closeBusinessApplicationDetailModal();
            focusBusinessReviewActions(d.applicationIdx);
        };
    }
    modal.classList.add('open');

    const focusKey = trigger.getAttribute('data-default-focus');
    if (focusKey) {
        const focusEl = body.querySelector('[data-focus-key="' + focusKey + '"]');
        if (focusEl) {
            focusEl.classList.remove('is-focus-flash');
            void focusEl.offsetWidth;
            focusEl.classList.add('is-focus-flash');
        }
    }
}
function focusBusinessReviewActions(applicationIdx) {
    const target = document.getElementById('business-review-actions-' + applicationIdx);
    if (!target) {
        adm_toast('현재 페이지에 검토 영역이 없습니다.', 'error');
        return;
    }
    target.scrollIntoView({behavior:'smooth', block:'center'});
    target.classList.remove('is-focus-flash'); void target.offsetWidth; target.classList.add('is-focus-flash');
    const focusable = target.querySelector('input, button, textarea, select');
    if (focusable) { try { focusable.focus({preventScroll:true}); } catch(e) { focusable.focus(); } }
}

async function postBusinessBulk(url, extra) {
    const ids = selectedBusinessIds();
    if (!ids.length) { adm_toast(BUSINESS_MSG.selectedMissing, 'error'); return; }
    const params = new URLSearchParams();
    ids.forEach(function(id) { params.append('applicationIdxList', id); });
    if (extra) Object.keys(extra).forEach(function(k) { params.append(k, extra[k]); });
    const res = await fetch(BUSINESS_CTX + url, {method:'POST', credentials:'same-origin', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body:params});
    const data = await res.json();
    if (res.ok && data.success) { adm_toast(data.message); await refreshBusinessSection(); }
    else adm_toast(data.message || '처리 중 오류가 발생했습니다.', 'error');
}
function bulkApproveBusiness() { if (confirm('선택한 신청을 승인할까요?')) postBusinessBulk('/admin/business-applications/bulk/approve'); }
function bulkRejectBusiness() {
    const input = document.getElementById('businessBulkRejectReason');
    const reason = input ? input.value.trim() : '';
    if (!reason) { adm_toast(BUSINESS_MSG.rejectReasonMissing, 'error'); return; }
    if (confirm('선택한 신청을 반려할까요?')) postBusinessBulk('/admin/business-applications/bulk/reject', {rejectReason: reason});
}
function exportBusinessData(scope) {
    const format = document.getElementById('businessExportFormat').value;
    const params = buildBusinessParams(null, {includeSort:true});
    params.delete('page'); params.set('scope', scope); params.set('format', format);
    if (scope === 'selected') {
        const ids = selectedBusinessIds();
        if (!ids.length) { adm_toast(BUSINESS_MSG.selectedMissing, 'error'); return; }
        params.set('selectedIds', ids.join(','));
    }
    const dd = document.getElementById('businessExportDropdown'); if (dd) dd.classList.remove('open');
    window.location.href = BUSINESS_CTX + '/admin/business-applications/export?' + params.toString();
}
function initBusinessSection() {
    saveBusinessMode(loadBusinessMode());
    const form = getBusinessForm();
    if (form) form.addEventListener('submit', function(e) { e.preventDefault(); businessSectionState.page = 1; businessSectionState.clientRows = null; renderBusinessByMode(1); });
    const mode = document.getElementById('businessModeSelect');
    if (mode) mode.addEventListener('change', function() { saveBusinessMode(mode.value === 'client' ? 'CLIENT' : 'SERVER'); businessSectionState.clientRows = null; renderBusinessByMode(1); });
    const exportToggle = document.querySelector('.js-business-export-toggle');
    const exportDropdown = document.getElementById('businessExportDropdown');
    if (exportToggle && exportDropdown) {
        exportToggle.addEventListener('click', function() { exportDropdown.classList.toggle('open'); });
        document.addEventListener('click', function(e) { if (!exportToggle.contains(e.target) && !exportDropdown.contains(e.target)) exportDropdown.classList.remove('open'); });
    }
    document.addEventListener('click', function(event) {
        const detailTrigger = event.target.closest('.js-open-business-detail');
        if (detailTrigger) {
            openBusinessApplicationDetail(detailTrigger);
            return;
        }
        const trigger = event.target.closest('.js-focus-review-actions');
        if (!trigger) return;
        focusBusinessReviewActions(trigger.getAttribute('data-application-idx'));
    });
    document.addEventListener('submit', async function(event) {
        const formEl = event.target.closest('.js-business-review-form');
        if (!formEl) return;
        event.preventDefault();
        const res = await fetch(formEl.action, {method:'POST', credentials:'same-origin', body:new URLSearchParams(new FormData(formEl))});
        if (res.ok) { adm_toast('처리되었습니다.'); await refreshBusinessSection(); }
        else adm_toast('처리 중 오류가 발생했습니다.', 'error');
    });
    markBusinessOriginal(Array.from(document.querySelectorAll('#businessRowsBody .js-business-row')));
    updateBusinessPaginationMeta(businessSectionState.page, Number('${paging.totalPage}' || 1), Number('${total}' || 0), document.querySelectorAll('#businessRowsBody .js-business-row').length);
    updateBusinessSortIndicators();
    if (businessSectionState.mode === 'CLIENT') renderBusinessByMode(1);
}
document.addEventListener('DOMContentLoaded', initBusinessSection);
</script>

<%@ include file="../layout-close.jsp" %>
