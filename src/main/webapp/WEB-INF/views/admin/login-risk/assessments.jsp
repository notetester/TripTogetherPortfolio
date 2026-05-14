<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations --%>
<spring:message var="msg_security_admin_externalAssessments_title" code="security.admin.externalAssessments.title"/>
<spring:message var="msg_security_admin_placeholder_ipAccountSourceReason" code="security.admin.placeholder.ipAccountSourceReason"/>
<spring:message var="msg_security_admin_externalAssessments_desc" code="security.admin.externalAssessments.desc"/>
<spring:message var="msg_security_admin_nav_policies" code="security.admin.nav.policies"/>
<spring:message var="msg_security_admin_nav_reviews" code="security.admin.nav.reviews"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_common_sourceKind" code="security.admin.common.sourceKind"/>
<spring:message var="msg_security_admin_common_all" code="security.admin.common.all"/>
<spring:message var="msg_security_admin_common_riskLevel" code="security.admin.common.riskLevel"/>
<spring:message var="msg_security_admin_common_decisionStatus" code="security.admin.common.decisionStatus"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_common_source" code="security.admin.common.source"/>
<spring:message var="msg_security_admin_common_target" code="security.admin.common.target"/>
<spring:message var="msg_security_admin_common_recommendationAction" code="security.admin.common.recommendationAction"/>
<spring:message var="msg_security_admin_common_evidence" code="security.admin.common.evidence"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_createdAt" code="security.admin.common.createdAt"/>
<spring:message var="msg_security_admin_empty_externalAssessments" code="security.admin.empty.externalAssessments"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount" arguments="${fn:length(assessments)}"/>
<spring:message var="msg_admin_common_export" code="admin.common.export"/>
<spring:message var="msg_admin_common_exportAll" code="admin.common.exportAll"/>
<spring:message var="msg_admin_common_exportFiltered" code="admin.common.exportFiltered"/>
<spring:message var="msg_admin_common_exportSelected" code="admin.common.exportSelected"/>
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
<spring:message var="msg_lrr_noSelection" code="security.admin.loginReviews.noSelectionMsg"/>
<spring:message var="msg_lrr_pageSearchPlaceholder" code="security.admin.loginReviews.pageSearchPlaceholder"/>

<c:set var="pageTitle" value="${msg_security_admin_externalAssessments_title}"/>
<c:set var="activeMenu" value="loginRiskAssessments"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-external-assessment-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_externalAssessments_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_externalAssessments_desc}</p>
        </div>
        <div class="adm-actions adm-external-assessment-page-actions">
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/policies">${msg_security_admin_nav_policies}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/reviews">${msg_security_admin_nav_reviews}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
        </div>
    </div>

    <form id="eaSearchForm" method="get" class="adm-card adm-external-assessment-filter-card adm-overflow-visible">
        <div class="adm-card-body">
            <div class="adm-external-assessment-filterbar">
                <label>${msg_security_admin_common_sourceKind}
                    <select class="adm-select" name="sourceKind">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="AI_MODEL" ${sourceKind == 'AI_MODEL' ? 'selected' : ''}>AI_MODEL</option>
                        <option value="RULE_ALGORITHM" ${sourceKind == 'RULE_ALGORITHM' ? 'selected' : ''}>RULE_ALGORITHM</option>
                        <option value="POLICY_AUTHORITY" ${sourceKind == 'POLICY_AUTHORITY' ? 'selected' : ''}>POLICY_AUTHORITY</option>
                        <option value="ASSESSMENT_PIPELINE" ${sourceKind == 'ASSESSMENT_PIPELINE' ? 'selected' : ''}>ASSESSMENT_PIPELINE</option>
                    </select>
                </label>
                <label>${msg_security_admin_common_riskLevel}
                    <select class="adm-select" name="riskLevel">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="CRITICAL" ${riskLevel == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                        <option value="HIGH" ${riskLevel == 'HIGH' ? 'selected' : ''}>HIGH</option>
                        <option value="MEDIUM" ${riskLevel == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                        <option value="LOW" ${riskLevel == 'LOW' ? 'selected' : ''}>LOW</option>
                        <option value="PENDING" ${riskLevel == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    </select>
                </label>
                <label>${msg_security_admin_common_decisionStatus}
                    <select class="adm-select" name="decisionStatus">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="PROPOSED" ${decisionStatus == 'PROPOSED' ? 'selected' : ''}>PROPOSED</option>
                        <option value="APPLIED" ${decisionStatus == 'APPLIED' ? 'selected' : ''}>APPLIED</option>
                        <option value="IGNORED" ${decisionStatus == 'IGNORED' ? 'selected' : ''}>IGNORED</option>
                        <option value="PENDING" ${decisionStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    </select>
                </label>
                <label class="adm-external-assessment-keyword-field">${msg_security_admin_common_search}
                    <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_ipAccountSourceReason}">
                </label>
                <div class="adm-external-assessment-filter-actions">
                    <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_search}</button>
                    <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/assessments">${msg_admin_common_reset}</a>
                </div>
            </div>
        </div>
    </form>

    <div class="adm-card adm-external-assessment-list-card adm-overflow-visible">
        <div class="adm-card-head ea-card-head">
            <div class="adm-card-title">
                ${msg_security_admin_externalAssessments_title}
                <span class="ea-total-label" id="eaTotalLabel">${msg_admin_common_totalCount}</span>
            </div>
            <div class="adm-export-control ea-export-control">
                <select class="adm-select ea-export-format" id="eaExportFormat">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost js-ea-export-toggle">${msg_admin_common_export} ▾</button>
                <div id="eaExportDropdown" class="adm-export-dropdown">
                    <button type="button" class="adm-export-item" onclick="eaExport('all')">${msg_admin_common_exportAll}</button>
                    <button type="button" class="adm-export-item" onclick="eaExport('filtered')">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="adm-export-item" id="eaExportSelectedBtn" disabled onclick="eaExport('selected')">${msg_admin_common_exportSelected} (0)</button>
                </div>
            </div>
        </div>

        <div class="ea-controlbar">
            <div id="eaBulkBar" class="ea-bulkbar" aria-live="polite" aria-hidden="true">
                <span class="ea-bulk-count"><strong id="eaBulkCount">0</strong>${msg_admin_common_selectedCount}</span>
                <button type="button" class="adm-btn adm-btn-ghost ea-bulk-clear" onclick="eaClearSelection()">${msg_admin_common_clearSelection}</button>
            </div>
            <div class="ea-view-tools">
                <button type="button" class="adm-btn adm-btn-ghost ea-sort-reset adm-is-hidden" id="eaSortReset" onclick="eaResetSort()">${msg_lrr_sortReset}</button>
                <label class="ea-tool ea-page-search-tool">
                    <input class="adm-input ea-page-search" id="eaPageSearch" type="text" placeholder="${msg_lrr_pageSearchPlaceholder}" oninput="eaSetPageSearch(this.value)">
                </label>
                <label class="ea-tool">
                    <span class="ea-tool-label">${msg_admin_common_pageSizeLabel}</span>
                    <select class="adm-select ea-page-size" id="eaPageSize" onchange="eaChangeSize(this.value)">
                        <option value="10">${msg_admin_common_pageSize_10}</option>
                        <option value="20" selected>${msg_admin_common_pageSize_20}</option>
                        <option value="50">${msg_admin_common_pageSize_50}</option>
                        <option value="100">${msg_admin_common_pageSize_100}</option>
                    </select>
                </label>
            </div>
        </div>

        <div class="adm-table-wrap">
            <table id="externalAssessmentTable"
                   class="adm-table adm-section-table-fixed adm-external-assessment-table ea-table"
                   data-section="externalAssessments"
                   data-admin-list-ignore="hard">
                <colgroup>
                    <col class="ea-col-check"/>
                    <col class="ea-col-source"/>
                    <col class="ea-col-target"/>
                    <col class="ea-col-risk"/>
                    <col class="ea-col-recommend"/>
                    <col class="ea-col-evidence"/>
                    <col class="ea-col-status"/>
                    <col class="ea-col-date"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="ea-th ea-th-check"><input type="checkbox" id="eaCheckAll" onchange="eaToggleAll(this)" aria-label="select-all"></th>
                    <th class="ea-th ea-sortable" data-sort="source" onclick="eaSortBy('source')"><span class="ea-th-label">${msg_security_admin_common_source}</span><span class="ea-sort-ico" aria-hidden="true"></span></th>
                    <th class="ea-th ea-sortable" data-sort="target" onclick="eaSortBy('target')"><span class="ea-th-label">${msg_security_admin_common_target}</span><span class="ea-sort-ico" aria-hidden="true"></span></th>
                    <th class="ea-th ea-sortable" data-sort="risk" onclick="eaSortBy('risk')"><span class="ea-th-label">${msg_security_admin_common_riskLevel}</span><span class="ea-sort-ico" aria-hidden="true"></span></th>
                    <th class="ea-th ea-sortable" data-sort="recommend" onclick="eaSortBy('recommend')"><span class="ea-th-label">${msg_security_admin_common_recommendationAction}</span><span class="ea-sort-ico" aria-hidden="true"></span></th>
                    <th class="ea-th"><span class="ea-th-label">${msg_security_admin_common_evidence}</span></th>
                    <th class="ea-th ea-sortable" data-sort="status" onclick="eaSortBy('status')"><span class="ea-th-label">${msg_security_admin_common_status}</span><span class="ea-sort-ico" aria-hidden="true"></span></th>
                    <th class="ea-th ea-sortable" data-sort="date" onclick="eaSortBy('date')"><span class="ea-th-label">${msg_security_admin_common_createdAt}</span><span class="ea-sort-ico" aria-hidden="true"></span></th>
                </tr>
                </thead>
                <tbody id="eaTableBody">
                <c:forEach var="a" items="${assessments}">
                    <tr data-row-id="${a.assessmentIdx}"
                        data-sort-source="${fn:escapeXml(a.sourceKind)}|${fn:escapeXml(a.sourceName)}"
                        data-sort-target="${fn:escapeXml(a.subjectType)}:${fn:escapeXml(a.subjectKey)}"
                        data-sort-risk="${fn:escapeXml(a.riskLevel)}|${a.riskScore}"
                        data-sort-recommend="${fn:escapeXml(a.recommendationAction)}"
                        data-sort-status="${fn:escapeXml(a.decisionStatus)}"
                        data-sort-date="<fmt:formatDate value='${a.createdAtDate}' pattern='yyyyMMddHHmm'/>">
                        <td class="ea-cell-check"><input type="checkbox" class="js-ea-row-check" value="${a.assessmentIdx}" onchange="eaUpdateBulkCount()" aria-label="row-select"></td>
                        <td>
                            <div class="adm-external-assessment-primary"><c:out value="${a.sourceKind}"/></div>
                            <div class="adm-page-muted"><c:out value="${a.sourceName}"/></div>
                            <div class="adm-page-muted"><c:out value="${a.sourceCode}"/> <c:out value="${a.sourceVersion}"/></div>
                        </td>
                        <td>
                            <div><c:out value="${a.subjectType}"/>: <c:out value="${a.subjectKey}"/></div>
                            <c:if test="${not empty a.userId}"><div class="adm-page-muted"><c:out value="${a.userId}"/> / <c:out value="${a.nickname}"/></div></c:if>
                            <c:if test="${not empty a.ipAddress}"><div class="adm-page-muted">IP: <c:out value="${a.ipAddress}"/></div></c:if>
                        </td>
                        <td>
                            <div class="adm-external-assessment-primary"><c:out value="${a.riskLevel}"/></div>
                            <c:if test="${not empty a.riskScore}"><div class="adm-page-muted">score <c:out value="${a.riskScore}"/></div></c:if>
                            <c:if test="${not empty a.confidenceScore}"><div class="adm-page-muted">confidence <c:out value="${a.confidenceScore}"/></div></c:if>
                        </td>
                        <td>
                            <div class="adm-external-assessment-primary"><c:out value="${a.recommendationAction}"/></div>
                            <div class="adm-page-muted"><c:out value="${a.recommendationReason}"/></div>
                        </td>
                        <td><div class="adm-external-assessment-evidence"><c:out value="${a.evidenceSummary}"/></div></td>
                        <td><span class="adm-badge"><c:out value="${a.decisionStatus}"/></span></td>
                        <td><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="ea-empty adm-is-hidden" id="eaEmptyState">${msg_security_admin_empty_externalAssessments}</div>
        </div>

        <div class="ea-pagination" id="eaPaging">
            <div class="ea-page-info"><span id="eaPageInfo"></span></div>
            <div class="ea-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost" id="eaPrevBtn" onclick="eaGoPage(window.eaState.page - 1)">${msg_admin_common_prev}</button>
                <span class="ea-page-state" id="eaPageState"></span>
                <button type="button" class="adm-btn adm-btn-ghost" id="eaNextBtn" onclick="eaGoPage(window.eaState.page + 1)">${msg_admin_common_next}</button>
            </div>
        </div>
    </div>
</div>

<script>
(function () {
    'use strict';
    /* ─── 외부 위험 판단 — 클라이언트 사이드 페이징·정렬·검색·체크박스(선택 export 만) ───
       로딩 방식 결정: 서버 getExternalAssessments() 는 LIMIT 없이 sourceKind/riskLevel/
       decisionStatus/keyword 필터링 후 전 결과 반환. 결정 변경 API 가 없어 bulk 처리는
       구현하지 않음(체크박스는 선택 export 만 활용). 큰 필터는 상단 GET 폼, 정렬·페이징·
       페이지내 검색은 캐싱된 행으로 즉시 처리. */
    var ctx = '${pageContext.request.contextPath}';

    var EA_MSG = {
        exportSelectedLabel: '${msg_admin_common_exportSelected}',
        noSelection: '${msg_lrr_noSelection}'
    };

    var eaState = {
        page: 1, pageSize: 20,
        sortBy: '', sortDir: 'ASC',
        pageSearch: '',
        rows: [], filtered: []
    };
    window.eaState = eaState;

    function cacheRows() {
        var tbody = document.getElementById('eaTableBody');
        if (!tbody) return;
        eaState.rows = Array.prototype.slice.call(tbody.querySelectorAll('tr[data-row-id]'));
    }
    function applyFilter() {
        var q = (eaState.pageSearch || '').trim().toLowerCase();
        if (!q) { eaState.filtered = eaState.rows.slice(); return; }
        eaState.filtered = eaState.rows.filter(function (tr) {
            return ((tr.innerText || tr.textContent) || '').toLowerCase().indexOf(q) !== -1;
        });
    }
    function applySort() {
        if (!eaState.sortBy) return;
        var dir = eaState.sortDir === 'DESC' ? -1 : 1;
        var attr = 'data-sort-' + eaState.sortBy;
        eaState.filtered.sort(function (a, b) {
            var av = (a.getAttribute(attr) || '').toLowerCase();
            var bv = (b.getAttribute(attr) || '').toLowerCase();
            return av.localeCompare(bv, undefined, { numeric: true, sensitivity: 'base' }) * dir;
        });
    }
    function render() {
        var tbody = document.getElementById('eaTableBody');
        if (!tbody) return;
        var total = eaState.filtered.length;
        var pageSize = eaState.pageSize > 0 ? eaState.pageSize : 20;
        var totalPage = Math.max(1, Math.ceil(total / pageSize));
        if (eaState.page > totalPage) eaState.page = totalPage;
        if (eaState.page < 1) eaState.page = 1;
        var start = (eaState.page - 1) * pageSize;
        var slice = eaState.filtered.slice(start, start + pageSize);

        eaState.rows.forEach(function (tr) { if (tr.parentNode === tbody) tbody.removeChild(tr); });
        Array.prototype.slice.call(tbody.querySelectorAll('.ea-empty-row')).forEach(function (tr) { tr.remove(); });
        slice.forEach(function (tr) { tbody.appendChild(tr); });
        if (slice.length === 0) {
            var emptyTpl = document.getElementById('eaEmptyState');
            var emptyText = emptyTpl ? emptyTpl.textContent : '';
            var emptyTr = document.createElement('tr');
            emptyTr.className = 'ea-empty-row';
            var td = document.createElement('td');
            td.colSpan = 8; td.className = 'ea-empty-cell'; td.textContent = emptyText;
            emptyTr.appendChild(td);
            tbody.appendChild(emptyTr);
        }

        var info = document.getElementById('eaPageInfo');
        if (info) info.textContent = total + ' / ' + eaState.rows.length;
        var stateEl = document.getElementById('eaPageState');
        if (stateEl) stateEl.textContent = eaState.page + ' / ' + totalPage;
        var prev = document.getElementById('eaPrevBtn');
        var next = document.getElementById('eaNextBtn');
        if (prev) prev.disabled = eaState.page <= 1;
        if (next) next.disabled = eaState.page >= totalPage;

        Array.prototype.slice.call(document.querySelectorAll('#externalAssessmentTable thead th.ea-sortable')).forEach(function (th) {
            var ico = th.querySelector('.ea-sort-ico');
            if (!ico) return;
            ico.textContent = (th.getAttribute('data-sort') === eaState.sortBy)
                ? (eaState.sortDir === 'DESC' ? '▼' : '▲')
                : '';
        });
        var resetBtn = document.getElementById('eaSortReset');
        if (resetBtn) resetBtn.classList.toggle('adm-is-hidden', !eaState.sortBy);

        updateBulkCount();
    }
    function applyAll() { applyFilter(); applySort(); render(); }

    function updateBulkCount() {
        var checked = document.querySelectorAll('#eaTableBody .js-ea-row-check:checked');
        var n = checked.length;
        var bulkBar = document.getElementById('eaBulkBar');
        if (bulkBar) {
            bulkBar.classList.toggle('is-active', n > 0);
            bulkBar.setAttribute('aria-hidden', n > 0 ? 'false' : 'true');
            bulkBar.querySelectorAll('button').forEach(function (el) { el.disabled = n === 0; });
        }
        var countEl = document.getElementById('eaBulkCount');
        if (countEl) countEl.textContent = n;
        var selBtn = document.getElementById('eaExportSelectedBtn');
        if (selBtn) {
            selBtn.disabled = n === 0;
            selBtn.textContent = EA_MSG.exportSelectedLabel + ' (' + n + ')';
        }
        var checkAll = document.getElementById('eaCheckAll');
        if (checkAll) {
            var visible = document.querySelectorAll('#eaTableBody .js-ea-row-check');
            checkAll.checked = visible.length > 0 && n === visible.length;
            checkAll.indeterminate = n > 0 && n < visible.length;
        }
    }
    window.eaUpdateBulkCount = updateBulkCount;

    window.eaToggleAll = function (cb) {
        document.querySelectorAll('#eaTableBody .js-ea-row-check').forEach(function (c) { c.checked = cb.checked; });
        updateBulkCount();
    };
    window.eaClearSelection = function () {
        document.querySelectorAll('#eaTableBody .js-ea-row-check').forEach(function (c) { c.checked = false; });
        var checkAll = document.getElementById('eaCheckAll');
        if (checkAll) { checkAll.checked = false; checkAll.indeterminate = false; }
        updateBulkCount();
    };
    window.eaSortBy = function (field) {
        if (eaState.sortBy === field) {
            eaState.sortDir = (eaState.sortDir === 'ASC') ? 'DESC' : 'ASC';
        } else { eaState.sortBy = field; eaState.sortDir = 'ASC'; }
        eaState.page = 1;
        applyAll();
    };
    window.eaResetSort = function () {
        eaState.sortBy = ''; eaState.sortDir = 'ASC'; eaState.page = 1; applyAll();
    };
    window.eaChangeSize = function (size) {
        var n = parseInt(size, 10);
        eaState.pageSize = (n > 0 ? n : 20);
        eaState.page = 1; render();
    };
    window.eaGoPage = function (p) {
        var total = eaState.filtered.length;
        var totalPage = Math.max(1, Math.ceil(total / eaState.pageSize));
        var next = Math.min(Math.max(1, parseInt(p, 10) || 1), totalPage);
        if (next === eaState.page) return;
        eaState.page = next; render();
    };
    window.eaSetPageSearch = function (text) {
        eaState.pageSearch = text || ''; eaState.page = 1; applyAll();
    };

    window.eaExport = function (scope) {
        var format = (document.getElementById('eaExportFormat') || {}).value || 'csv';
        var params = new URLSearchParams();
        params.set('scope', scope);
        params.set('format', format);
        if (scope === 'filtered') {
            var form = document.getElementById('eaSearchForm');
            if (form) {
                var fd = new FormData(form);
                fd.forEach(function (v, k) { if (v) params.set(k, v); });
            }
        }
        if (scope === 'selected') {
            var ids = Array.prototype.slice.call(document.querySelectorAll('#eaTableBody .js-ea-row-check:checked')).map(function (c) { return c.value; });
            if (!ids.length) { alert(EA_MSG.noSelection); return; }
            params.set('selectedIds', ids.join(','));
        }
        var dropdown = document.getElementById('eaExportDropdown');
        if (dropdown) dropdown.classList.remove('open');
        window.location.href = ctx + '/admin/login-risk/assessments/export?' + params.toString();
    };

    function initExportDropdown() {
        var toggle = document.querySelector('.js-ea-export-toggle');
        var dropdown = document.getElementById('eaExportDropdown');
        if (!toggle || !dropdown) return;
        toggle.addEventListener('click', function (e) {
            e.stopPropagation();
            dropdown.classList.toggle('open');
        });
        document.addEventListener('click', function (e) {
            if (!toggle.contains(e.target) && !dropdown.contains(e.target)) dropdown.classList.remove('open');
        });
    }

    function init() {
        cacheRows();
        var sizeSel = document.getElementById('eaPageSize');
        if (sizeSel) {
            var n = parseInt(sizeSel.value, 10);
            eaState.pageSize = n > 0 ? n : 20;
        }
        initExportDropdown();
        applyAll();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else { init(); }
})();
</script>

<style>
/* ── 외부 위험 판단 페이지 전용 ── */
.adm-external-assessment-page .ea-table { width: 100%; min-width: 1220px; table-layout: fixed; }
.adm-external-assessment-page .ea-col-check     { width: 42px; }
.adm-external-assessment-page .ea-th-check, .adm-external-assessment-page .ea-cell-check { text-align: center; padding: 8px 4px; }
.adm-external-assessment-page .ea-col-source    { width: 180px; }
.adm-external-assessment-page .ea-col-target    { width: 200px; }
.adm-external-assessment-page .ea-col-risk      { width: 130px; }
.adm-external-assessment-page .ea-col-recommend { width: 180px; }
.adm-external-assessment-page .ea-col-evidence  { width: auto; }
.adm-external-assessment-page .ea-col-status    { width: 110px; }
.adm-external-assessment-page .ea-col-date      { width: 140px; }

.adm-external-assessment-page .ea-th {
    white-space: nowrap; overflow: hidden;
    user-select: none;
    padding-right: 18px; box-sizing: border-box;
}
.adm-external-assessment-page .ea-th.ea-sortable { cursor: pointer; }
.adm-external-assessment-page .ea-th .ea-th-label {
    display: inline-block; max-width: calc(100% - 14px);
    overflow: hidden; text-overflow: ellipsis; vertical-align: middle;
}
.adm-external-assessment-page .ea-th .ea-sort-ico {
    display: inline-block; margin-left: 4px; width: 10px;
    font-size: 10px; line-height: 1; vertical-align: middle; color: #93c5fd;
}
body.sa-light .adm-external-assessment-page .ea-th .ea-sort-ico { color: #2563eb; }

.adm-external-assessment-page .ea-table td {
    vertical-align: top; overflow: hidden;
    word-break: break-word;
}
.adm-external-assessment-page .ea-table .adm-external-assessment-evidence {
    white-space: pre-wrap; overflow-wrap: anywhere;
    max-height: 8em; overflow: hidden;
    text-overflow: ellipsis; font-size: 12px; line-height: 1.45;
}

/* card head + export */
.adm-external-assessment-page .ea-card-head { display: flex; align-items: center; justify-content: space-between; gap: 12px; flex-wrap: wrap; }
.adm-external-assessment-page .ea-total-label { margin-left: 8px; font-size: 12px; color: #94a3b8; font-weight: normal; }
.adm-external-assessment-page .ea-export-control { position: relative; display: inline-flex; align-items: center; gap: 6px; }
.adm-external-assessment-page .ea-export-control .ea-export-format { min-width: 84px; }
.adm-external-assessment-page .ea-export-control .adm-export-dropdown {
    display: none; position: absolute; top: 100%; right: 0; margin-top: 4px;
    background: var(--adm-card-bg, #1e293b); border: 1px solid var(--adm-border, #334155);
    border-radius: 6px; padding: 4px; z-index: 30; min-width: 200px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.25);
}
.adm-external-assessment-page .ea-export-control .adm-export-dropdown.open { display: block; }
.adm-external-assessment-page .ea-export-control .adm-export-item {
    display: block; width: 100%; text-align: left; padding: 6px 10px;
    background: transparent; color: inherit; border: 0; cursor: pointer;
    font-size: 13px; border-radius: 4px;
}
.adm-external-assessment-page .ea-export-control .adm-export-item:disabled { opacity: 0.5; cursor: not-allowed; }
.adm-external-assessment-page .ea-export-control .adm-export-item:hover:not(:disabled) { background: rgba(148,163,184,0.15); }

/* controlbar */
.adm-external-assessment-page .ea-controlbar { display: flex; align-items: center; justify-content: space-between; gap: 12px; padding: 8px 14px; flex-wrap: wrap; }
.adm-external-assessment-page .ea-bulkbar { display: flex; align-items: center; gap: 10px; opacity: 0.55; transition: opacity 0.2s; }
.adm-external-assessment-page .ea-bulkbar.is-active { opacity: 1; }
.adm-external-assessment-page .ea-bulk-count { font-size: 13px; }
.adm-external-assessment-page .ea-bulk-count strong { font-size: 15px; margin-right: 2px; color: #fbbf24; }
.adm-external-assessment-page .ea-view-tools { display: inline-flex; gap: 8px; align-items: center; flex-wrap: wrap; }
.adm-external-assessment-page .ea-tool { display: inline-flex; gap: 4px; align-items: center; }
.adm-external-assessment-page .ea-tool-label { font-size: 12px; color: #94a3b8; }
.adm-external-assessment-page .ea-page-search { min-width: 220px; }
.adm-external-assessment-page .ea-sort-reset { font-size: 12px; }

/* pagination */
.adm-external-assessment-page .ea-pagination { display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; gap: 10px; flex-wrap: wrap; }
.adm-external-assessment-page .ea-page-info { font-size: 12px; color: #94a3b8; }
.adm-external-assessment-page .ea-page-actions { display: inline-flex; gap: 8px; align-items: center; }
.adm-external-assessment-page .ea-page-state { font-size: 13px; min-width: 60px; text-align: center; }

.adm-external-assessment-page .ea-empty,
.adm-external-assessment-page .ea-empty-cell { padding: 16px; text-align: center; color: #94a3b8; }
.adm-external-assessment-page .adm-is-hidden { display: none !important; }

@media (max-width: 1180px) {
    .adm-external-assessment-page .adm-external-assessment-filterbar { flex-wrap: wrap; }
    .adm-external-assessment-page .ea-controlbar { flex-direction: column; align-items: stretch; }
    .adm-external-assessment-page .ea-bulkbar { flex-wrap: wrap; }
    .adm-external-assessment-page .ea-view-tools { justify-content: flex-end; }
}
</style>

<%@ include file="../layout-close.jsp" %>
