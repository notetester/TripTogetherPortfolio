<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_blocks_mode_label" code="admin.blocks.mode.label"/>
<spring:message var="msg_admin_blocks_mode_tipClient" code="admin.blocks.mode.tipClient"/>
<spring:message var="msg_admin_blocks_mode_tipServer" code="admin.blocks.mode.tipServer"/>
<spring:message var="msg_admin_business_rejectReasonPlaceholder" code="admin.business.rejectReasonPlaceholder"/>
<spring:message var="msg_admin_blocks_js_dashSortReset_js" code="admin.blocks.js.dashSortReset" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_exportSelected_js" code="admin.common.exportSelected" javaScriptEscape="true"/>
<spring:message var="msg_admin_business_rejectReasonPlaceholder_js" code="admin.business.rejectReasonPlaceholder" javaScriptEscape="true"/>
<spring:message var="msg_admin_business_noResults_js" code="admin.business.noResults" javaScriptEscape="true"/>
<spring:message var="msg_admin_business_pageTitle" code="admin.business.pageTitle"/>
<spring:message var="msg_admin_business_pageSubtitle" code="admin.business.pageSubtitle"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_business_column_applicant" code="admin.business.column.applicant"/>
<spring:message var="msg_admin_business_column_companyInfo" code="admin.business.column.companyInfo"/>
<spring:message var="msg_admin_business_managerSearch" code="admin.business.managerSearch"/>
<spring:message var="msg_admin_business_businessNumberSearch" code="admin.business.businessNumberSearch"/>
<spring:message var="msg_admin_business_filter_status" code="admin.business.filter.status"/>
<spring:message var="msg_admin_business_status_pending" code="admin.business.status.pending"/>
<spring:message var="msg_admin_business_status_approved" code="admin.business.status.approved"/>
<spring:message var="msg_admin_business_status_rejected" code="admin.business.status.rejected"/>
<spring:message var="msg_admin_business_column_requestedRole" code="admin.business.column.requestedRole"/>
<spring:message var="msg_admin_business_role_business" code="admin.business.role.business"/>
<spring:message var="msg_admin_business_role_partner" code="admin.business.role.partner"/>
<spring:message var="msg_admin_business_column_appliedAt" code="admin.business.column.appliedAt"/>
<spring:message var="msg_admin_common_searchButton" code="admin.common.searchButton"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_export" code="admin.common.export"/>
<spring:message var="msg_admin_common_exportAll" code="admin.common.exportAll"/>
<spring:message var="msg_admin_common_exportFiltered" code="admin.common.exportFiltered"/>
<spring:message var="msg_admin_common_exportSelected" code="admin.common.exportSelected"/>
<spring:message var="msg_admin_blocks_mode_client" code="admin.blocks.mode.client"/>
<spring:message var="msg_admin_blocks_mode_server" code="admin.blocks.mode.server"/>
<spring:message var="msg_admin_common_pageSize" code="admin.common.pageSize"/>
<spring:message var="msg_admin_common_pageSizeLabel" code="admin.common.pageSizeLabel"/>
<spring:message var="msg_admin_common_pageSize_10" code="admin.common.pageSize" arguments="10"/>
<spring:message var="msg_admin_common_pageSize_20" code="admin.common.pageSize" arguments="20"/>
<spring:message var="msg_admin_common_pageSize_50" code="admin.common.pageSize" arguments="50"/>
<spring:message var="msg_admin_common_pageSize_100" code="admin.common.pageSize" arguments="100"/>
<spring:message var="msg_admin_common_selectedCount" code="admin.common.selectedCount"/>
<spring:message var="msg_admin_common_clearSelection" code="admin.common.clearSelection"/>
<spring:message var="msg_admin_common_status" code="admin.common.status"/>
<spring:message var="msg_admin_business_column_review" code="admin.business.column.review"/>
<spring:message var="msg_admin_common_prev" code="admin.common.prev"/>
<spring:message var="msg_admin_common_next" code="admin.common.next"/>
<spring:message var="msg_admin_common_close" code="admin.common.close"/>
<c:set var="activeMenu" value="businessApplications"/>


<c:set var="pageTitle"  value="${msg_admin_business_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${msg_admin_business_pageTitle}</h1>
            <p>${msg_admin_business_pageSubtitle}</p>
        </div>
    </div>

    <c:if test="${not empty businessApplicationMessage}">
        <div class="adm-alert adm-alert-success">${fn:escapeXml(businessApplicationMessage)}</div>
    </c:if>
    <c:if test="${not empty businessApplicationError}">
        <div class="adm-alert adm-alert-danger">${fn:escapeXml(businessApplicationError)}</div>
    </c:if>

    <div class="adm-card adm-business-filter-card">
        <div class="adm-card-body">
            <form id="businessSearchForm" method="get" action="${pageContext.request.contextPath}/admin/business-applications">
                <div class="adm-filter-bar">
                    <div class="adm-business-keyword-field">
                        <div class="adm-filter-label">${msg_admin_common_search}</div>
                        <div class="adm-business-search-row">
                            <select class="adm-select adm-business-search-type" name="searchType">
                                <option value="all" ${search.searchType eq 'all' ? 'selected' : ''}>${msg_admin_common_all}</option>
                                <option value="applicant" ${search.searchType eq 'applicant' ? 'selected' : ''}>${msg_admin_business_column_applicant}</option>
                                <option value="company" ${search.searchType eq 'company' ? 'selected' : ''}>${msg_admin_business_column_companyInfo}</option>
                                <option value="manager" ${search.searchType eq 'manager' ? 'selected' : ''}>${msg_admin_business_managerSearch}</option>
                                <option value="businessNumber" ${search.searchType eq 'businessNumber' ? 'selected' : ''}>${msg_admin_business_businessNumberSearch}</option>
                            </select>
                            <div class="adm-search-box adm-business-search-box">
                                <span class="adm-search-ico">🔍</span>
                                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(search.keyword)}" placeholder="${msg_admin_common_search}">
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="adm-filter-label">${msg_admin_business_filter_status}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status eq 'ALL' ? 'selected' : ''}>${msg_admin_common_all}</option>
                            <option value="PENDING" ${search.status eq 'PENDING' ? 'selected' : ''}>${msg_admin_business_status_pending}</option>
                            <option value="APPROVED" ${search.status eq 'APPROVED' ? 'selected' : ''}>${msg_admin_business_status_approved}</option>
                            <option value="REJECTED" ${search.status eq 'REJECTED' ? 'selected' : ''}>${msg_admin_business_status_rejected}</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">${msg_admin_business_column_requestedRole}</div>
                        <select class="adm-select" name="requestedRole">
                            <option value="ALL" ${search.requestedRole eq 'ALL' ? 'selected' : ''}>${msg_admin_common_all}</option>
                            <option value="BUSINESS" ${search.requestedRole eq 'BUSINESS' ? 'selected' : ''}>${msg_admin_business_role_business}</option>
                            <option value="PARTNER" ${search.requestedRole eq 'PARTNER' ? 'selected' : ''}>${msg_admin_business_role_partner}</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">${msg_admin_business_column_appliedAt}</div>
                        <div class="adm-business-date-row">
                            <input class="adm-input adm-business-date-input" type="date" name="dateFrom" value="${search.dateFrom}">
                            <span class="adm-business-date-sep">~</span>
                            <input class="adm-input adm-business-date-input" type="date" name="dateTo" value="${search.dateTo}">
                        </div>
                    </div>

                    <div class="adm-business-filter-actions">
                        <button type="submit" class="adm-btn adm-btn-primary">🔍 ${msg_admin_common_searchButton}</button>
                        <button type="button" class="adm-btn adm-btn-ghost" onclick="resetBusinessFilters()">${msg_admin_common_reset}</button>
                    </div>

                    <input type="hidden" name="page" value="${paging.currentPage}">
                    <input type="hidden" name="size" value="${search.size}">
                    <input type="hidden" id="businessSortByInput" name="sortBy" value="${search.sortBy}">
                    <input type="hidden" id="businessSortDirInput" name="sortDir" value="${search.sortDir}">
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card js-business-section-card adm-managed-section-card adm-overflow-visible" data-section="businessApplications" data-enhanced="true">
        <div class="adm-card-head adm-business-list-head">
            <div class="adm-card-title">
                🏢 ${msg_admin_business_pageTitle}
                <span id="businessTotalLabel" class="adm-business-total-label">총 ${total}건</span>
            </div>
            <div class="adm-business-export-control adm-export-control">
                <select class="adm-select adm-business-export-format" id="businessExportFormat">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost js-business-export-toggle">${msg_admin_common_export} ▾</button>
                <div id="businessExportDropdown" class="adm-export-dropdown">
                    <button type="button" class="adm-export-item" onclick="exportBusinessData('all')">${msg_admin_common_exportAll}</button>
                    <button type="button" class="adm-export-item" onclick="exportBusinessData('search')">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="adm-export-item" id="businessExportSelectedBtn" disabled onclick="exportBusinessData('selected')">${msg_admin_common_exportSelected} (0)</button>
                </div>
            </div>
        </div>

        <div class="adm-business-controlbar">
            <div id="businessBulkBar" class="adm-business-bulkbar" aria-live="polite">
                <span class="adm-business-bulk-count"><strong id="businessBulkCount">0</strong>${msg_admin_common_selectedCount}</span>
                <div class="adm-business-bulk-actions">
                    <button type="button" class="adm-btn adm-btn-primary adm-business-bulk-approve" onclick="bulkApproveBusiness()">${msg_admin_business_status_approved}</button>
                    <input class="adm-input" id="businessBulkRejectReason" maxlength="500" placeholder="${msg_admin_business_rejectReasonPlaceholder}">
                    <button type="button" class="adm-btn adm-btn-danger adm-business-bulk-reject" onclick="bulkRejectBusiness()">${msg_admin_business_status_rejected}</button>
                </div>
                <button type="button" class="adm-btn adm-btn-ghost adm-business-bulk-clear" onclick="clearBusinessSelection()">${msg_admin_common_clearSelection}</button>
            </div>
            <div class="adm-business-view-tools">
                <div id="businessPrimaryTools" class="adm-business-primary-tools">
                    <button type="button" class="adm-dash-sort-reset js-business-sort-reset adm-business-tool-item adm-business-sort-reset adm-is-hidden" onclick="resetBusinessSort()"></button>
                    <label class="adm-business-tool-item adm-business-tool adm-business-mode-tool">
                        <span class="adm-business-tool-label">${msg_admin_blocks_mode_label}</span>
                        <select class="adm-select" id="businessModeSelect" title="${msg_admin_blocks_mode_label}">
                            <option value="client" title="${msg_admin_blocks_mode_tipClient}">${msg_admin_blocks_mode_client}</option>
                            <option value="server" title="${msg_admin_blocks_mode_tipServer}">${msg_admin_blocks_mode_server}</option>
                        </select>
                    </label>
                    <label class="adm-business-tool-item adm-business-tool adm-business-size-tool">
                        <span class="adm-business-tool-label">${msg_admin_common_pageSizeLabel}</span>
                        <select class="adm-select" id="businessSizeSelect" onchange="changeBusinessSize(this.value)">
                            <option value="10"  ${search.size==10  ? 'selected' : ''}>${msg_admin_common_pageSize_10}</option>
                            <option value="20"  ${search.size==20  ? 'selected' : ''}>${msg_admin_common_pageSize_20}</option>
                            <option value="50"  ${search.size==50  ? 'selected' : ''}>${msg_admin_common_pageSize_50}</option>
                            <option value="100" ${search.size==100 ? 'selected' : ''}>${msg_admin_common_pageSize_100}</option>
                        </select>
                    </label>
                </div>
                <div class="adm-business-overflow-menu" id="businessOverflowMenu">
                    <button type="button" class="adm-btn adm-btn-ghost adm-business-overflow-toggle" aria-expanded="false" aria-controls="businessOverflowPanel">옵션 ▾</button>
                    <div id="businessOverflowPanel" class="adm-business-overflow-panel"></div>
                </div>
            </div>
        </div>

        <div class="adm-table-wrap adm-overflow-visible">
            <table class="adm-table adm-section-table-fixed adm-business-section-table" data-admin-list-ignore="true" data-section="businessApplications">
                <thead>
                <tr>
                    <th class="adm-business-check-head"><input type="checkbox" id="businessCheckAll" class="adm-check" onchange="toggleAllBusiness(this)"></th>
                    <th class="js-business-sort" data-sort="applicant" onclick="businessSortBy('applicant')">${msg_admin_business_column_applicant}</th>
                    <th class="js-business-sort" data-sort="requestedRole" onclick="businessSortBy('requestedRole')">${msg_admin_business_column_requestedRole}</th>
                    <th class="js-business-sort" data-sort="company" onclick="businessSortBy('company')">${msg_admin_business_column_companyInfo}</th>
                    <th class="js-business-sort" data-sort="status" onclick="businessSortBy('status')">${msg_admin_common_status}</th>
                    <th class="js-business-sort" data-sort="createdAt" onclick="businessSortBy('createdAt')">${msg_admin_business_column_appliedAt}</th>
                    <th>${msg_admin_business_column_review}</th>
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
                <button type="button" class="adm-btn adm-btn-ghost js-business-prev" onclick="goBusinessPage(businessSectionState.page - 1)">${msg_admin_common_prev}</button>
                <span class="js-business-page-state" data-section="businessApplications">${paging.currentPage} / ${paging.totalPage}</span>
                <button type="button" class="adm-btn adm-btn-ghost js-business-next" onclick="goBusinessPage(businessSectionState.page + 1)">${msg_admin_common_next}</button>
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
        <div class="adm-modal-body adm-business-detail-body" id="businessApplicationDetailBody"></div>
        <div class="adm-modal-foot adm-business-detail-foot">
            <button class="adm-btn adm-btn-ghost" type="button" id="businessApplicationDetailMemberBtn">회원 설정</button>
            <button class="adm-btn adm-btn-primary" type="button" id="businessApplicationDetailReviewBtn">검토 위치로 이동</button>
            <button class="adm-btn adm-btn-ghost" type="button" onclick="closeBusinessApplicationDetailModal()">${msg_admin_common_close}</button>
        </div>
    </div>
</div>

<script>
const BUSINESS_CTX = '${pageContext.request.contextPath}';
const BUSINESS_LOCALE = '${fn:escapeXml(pageContext.response.locale.toLanguageTag())}';
const BUSINESS_MSG = {
    sortReset: '${msg_admin_blocks_js_dashSortReset_js}',
    exportSelected: '${msg_admin_common_exportSelected_js}',
    selectedMissing: '선택된 항목이 없습니다.',
    rejectReasonMissing: '${msg_admin_business_rejectReasonPlaceholder_js}',
    noResults: '${msg_admin_business_noResults_js}'
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
            const asc = businessSectionState.sortDir === 'ASC';
            ico.className = 'sort-ico ' + (asc ? 'asc' : 'desc');
            ico.textContent = asc ? '▲' : '▼';
            th.appendChild(ico);
        }
    });
    const reset = document.querySelector('.js-business-sort-reset');
    if (reset) {
        reset.textContent = BUSINESS_MSG.sortReset || '↺ 초기화';
        reset.classList.toggle('adm-is-hidden', !businessSectionState.sortBy);
    }
    syncBusinessHiddenInputs();
    syncBusinessControlOverflow();
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
function businessEmptyRow() { return '<tr class="adm-local-empty"><td colspan="7" class="adm-local-empty-cell">' + BUSINESS_MSG.noResults + '</td></tr>'; }
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
    if (bar) {
        bar.classList.toggle('is-active', ids.length > 0);
        bar.setAttribute('aria-hidden', ids.length > 0 ? 'false' : 'true');
        bar.querySelectorAll('input, button').forEach(function(control) {
            control.disabled = ids.length === 0;
        });
    }
    const count = document.getElementById('businessBulkCount');
    if (count) count.textContent = ids.length;
    const rejectReason = document.getElementById('businessBulkRejectReason');
    if (rejectReason && ids.length === 0) rejectReason.value = '';
    const exportBtn = document.getElementById('businessExportSelectedBtn');
    if (exportBtn) {
        exportBtn.disabled = ids.length === 0;
        exportBtn.classList.toggle('has-selection', ids.length > 0);
        exportBtn.textContent = BUSINESS_MSG.exportSelected + ' (' + ids.length + ')';
    }
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

let businessControlOverflowSync = null;

function isVisibleBusinessTool(tool) {
    if (!tool) return false;
    return !tool.classList.contains('js-business-sort-reset') || !tool.classList.contains('adm-is-hidden');
}

function syncBusinessControlOverflow() {
    if (typeof businessControlOverflowSync === 'function') businessControlOverflowSync();
}

function initBusinessControlOverflow() {
    const primary = document.getElementById('businessPrimaryTools');
    const menu = document.getElementById('businessOverflowMenu');
    const panel = document.getElementById('businessOverflowPanel');
    const toggle = menu ? menu.querySelector('.adm-business-overflow-toggle') : null;
    if (!primary || !menu || !panel || !toggle) return;

    const tools = [
        { node: document.querySelector('.adm-business-sort-reset'), breakpoint: 1380 },
        { node: document.querySelector('.adm-business-mode-tool'), breakpoint: 1180 },
        { node: document.querySelector('.adm-business-size-tool'), breakpoint: 980 }
    ].filter(function(item) { return !!item.node; });

    businessControlOverflowSync = function() {
        const width = window.innerWidth || document.documentElement.clientWidth || 1600;
        tools.forEach(function(item) {
            const target = width <= item.breakpoint ? panel : primary;
            if (item.node.parentElement !== target) target.appendChild(item.node);
        });
        const hasItems = Array.from(panel.children).some(isVisibleBusinessTool);
        menu.classList.toggle('has-items', hasItems);
        if (!hasItems) {
            menu.classList.remove('open');
            toggle.setAttribute('aria-expanded', 'false');
        }
    };

    toggle.addEventListener('click', function() {
        const willOpen = !menu.classList.contains('open');
        menu.classList.toggle('open', willOpen);
        toggle.setAttribute('aria-expanded', willOpen ? 'true' : 'false');
    });
    document.addEventListener('click', function(e) {
        if (!menu.contains(e.target)) {
            menu.classList.remove('open');
            toggle.setAttribute('aria-expanded', 'false');
        }
    });
    window.addEventListener('resize', syncBusinessControlOverflow, { passive: true });
    syncBusinessControlOverflow();
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
    updateBusinessBulkBar();
    initBusinessControlOverflow();
    if (businessSectionState.mode === 'CLIENT') renderBusinessByMode(1);
}
document.addEventListener('DOMContentLoaded', initBusinessSection);
</script>

<%@ include file="../layout-close.jsp" %>
