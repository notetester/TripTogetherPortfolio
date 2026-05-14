<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations --%>
<spring:message var="msg_security_admin_securityAssessments_title" code="security.admin.securityAssessments.title"/>
<spring:message var="msg_security_admin_placeholder_accountIpEvidenceSource" code="security.admin.placeholder.accountIpEvidenceSource"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_securityAssessments_desc" code="security.admin.securityAssessments.desc"/>
<spring:message var="msg_security_admin_nav_externalAssessmentsLong" code="security.admin.nav.externalAssessmentsLong"/>
<spring:message var="msg_security_admin_nav_securityReviews" code="security.admin.nav.securityReviews"/>
<spring:message var="msg_security_admin_nav_providerConfigs" code="security.admin.nav.providerConfigs"/>
<spring:message var="msg_security_admin_nav_blocks" code="security.admin.nav.blocks"/>
<spring:message var="msg_security_admin_common_scope" code="security.admin.common.scope"/>
<spring:message var="msg_security_admin_common_all" code="security.admin.common.all"/>
<spring:message var="msg_security_admin_common_sourceKind" code="security.admin.common.sourceKind"/>
<spring:message var="msg_security_admin_common_riskLevel" code="security.admin.common.riskLevel"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_common_scopeSource" code="security.admin.common.scopeSource"/>
<spring:message var="msg_security_admin_common_target" code="security.admin.common.target"/>
<spring:message var="msg_security_admin_common_recommendationAction" code="security.admin.common.recommendationAction"/>
<spring:message var="msg_security_admin_common_evidence" code="security.admin.common.evidence"/>
<spring:message var="msg_security_admin_common_createdAt" code="security.admin.common.createdAt"/>
<spring:message var="msg_security_admin_common_apply" code="security.admin.common.apply"/>
<spring:message var="msg_security_admin_common_ip" code="security.admin.common.ip"/>
<spring:message var="msg_security_admin_common_enqueueReview" code="security.admin.common.enqueueReview"/>
<spring:message var="msg_security_admin_common_applyUserBlock" code="security.admin.common.applyUserBlock"/>
<spring:message var="msg_security_admin_empty_securityAssessments" code="security.admin.empty.securityAssessments"/>
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
<spring:message var="msg_lrr_pickAction" code="security.admin.loginReviews.pickActionMsg"/>
<spring:message var="msg_lrr_noSelection" code="security.admin.loginReviews.noSelectionMsg"/>
<spring:message var="msg_lrr_pageSearchPlaceholder" code="security.admin.loginReviews.pageSearchPlaceholder"/>
<spring:message var="msg_lrr_bulkActionPlaceholder" code="security.admin.loginReviews.bulkActionPlaceholder"/>

<c:set var="pageTitle" value="${msg_security_admin_securityAssessments_title}"/>
<c:set var="activeMenu" value="securityRiskAssessments"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-security-assessment-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_nav_securityAssessments}</h1>
            <p class="adm-page-desc">${msg_security_admin_securityAssessments_desc}</p>
        </div>
        <div class="adm-actions adm-security-assessment-page-actions">
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/assessments">${msg_security_admin_nav_externalAssessmentsLong}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews">${msg_security_admin_nav_securityReviews}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">${msg_security_admin_nav_providerConfigs}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/blocks">${msg_security_admin_nav_blocks}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form id="sraSearchForm" method="get" class="adm-card adm-security-assessment-filter-card adm-overflow-visible">
        <div class="adm-card-body">
            <div class="adm-security-assessment-filterbar">
                <label>${msg_security_admin_common_scope}
                    <select class="adm-select" name="assessmentScope">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="LOGIN_RISK" ${assessmentScope == 'LOGIN_RISK' ? 'selected' : ''}>LOGIN_RISK</option>
                        <option value="USER_SECURITY" ${assessmentScope == 'USER_SECURITY' ? 'selected' : ''}>USER_SECURITY</option>
                        <option value="CONTENT_MODERATION" ${assessmentScope == 'CONTENT_MODERATION' ? 'selected' : ''}>CONTENT_MODERATION</option>
                        <option value="IP_REPUTATION" ${assessmentScope == 'IP_REPUTATION' ? 'selected' : ''}>IP_REPUTATION</option>
                    </select>
                </label>
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
                <label>${msg_security_admin_common_status}
                    <select class="adm-select" name="decisionStatus">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="PROPOSED" ${decisionStatus == 'PROPOSED' ? 'selected' : ''}>PROPOSED</option>
                        <option value="APPLIED" ${decisionStatus == 'APPLIED' ? 'selected' : ''}>APPLIED</option>
                        <option value="IGNORED" ${decisionStatus == 'IGNORED' ? 'selected' : ''}>IGNORED</option>
                        <option value="PENDING" ${decisionStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    </select>
                </label>
                <label class="adm-security-assessment-keyword-field">${msg_security_admin_common_search}
                    <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_accountIpEvidenceSource}">
                </label>
                <div class="adm-security-assessment-filter-actions">
                    <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_search}</button>
                    <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_admin_common_reset}</a>
                </div>
            </div>
        </div>
    </form>

    <div class="adm-card adm-security-assessment-list-card adm-overflow-visible">
        <div class="adm-card-head sra-card-head">
            <div class="adm-card-title">
                ${msg_security_admin_securityAssessments_title}
                <span class="sra-total-label" id="sraTotalLabel">${msg_admin_common_totalCount}</span>
            </div>
            <div class="adm-export-control sra-export-control">
                <select class="adm-select sra-export-format" id="sraExportFormat">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost js-sra-export-toggle">${msg_admin_common_export} ▾</button>
                <div id="sraExportDropdown" class="adm-export-dropdown">
                    <button type="button" class="adm-export-item" onclick="sraExport('all')">${msg_admin_common_exportAll}</button>
                    <button type="button" class="adm-export-item" onclick="sraExport('filtered')">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="adm-export-item" id="sraExportSelectedBtn" disabled onclick="sraExport('selected')">${msg_admin_common_exportSelected} (0)</button>
                </div>
            </div>
        </div>

        <div class="sra-controlbar">
            <div id="sraBulkBar" class="sra-bulkbar" aria-live="polite" aria-hidden="true">
                <span class="sra-bulk-count"><strong id="sraBulkCount">0</strong>${msg_admin_common_selectedCount}</span>
                <div class="sra-bulk-actions">
                    <select class="adm-select" id="sraBulkActionSelect">
                        <option value="">${msg_lrr_bulkActionPlaceholder}</option>
                        <option value="create-review">${msg_security_admin_common_enqueueReview}</option>
                        <option value="apply-user-block">${msg_security_admin_common_applyUserBlock}</option>
                    </select>
                    <button type="button" class="adm-btn adm-btn-primary" onclick="sraApplyBulk()">${msg_admin_common_apply}</button>
                </div>
                <button type="button" class="adm-btn adm-btn-ghost sra-bulk-clear" onclick="sraClearSelection()">${msg_admin_common_clearSelection}</button>
            </div>
            <div class="sra-view-tools">
                <button type="button" class="adm-btn adm-btn-ghost sra-sort-reset adm-is-hidden" id="sraSortReset" onclick="sraResetSort()">${msg_lrr_sortReset}</button>
                <label class="sra-tool sra-page-search-tool">
                    <input class="adm-input sra-page-search" id="sraPageSearch" type="text" placeholder="${msg_lrr_pageSearchPlaceholder}" oninput="sraSetPageSearch(this.value)">
                </label>
                <label class="sra-tool">
                    <span class="sra-tool-label">${msg_admin_common_pageSizeLabel}</span>
                    <select class="adm-select sra-page-size" id="sraPageSize" onchange="sraChangeSize(this.value)">
                        <option value="10">${msg_admin_common_pageSize_10}</option>
                        <option value="20" selected>${msg_admin_common_pageSize_20}</option>
                        <option value="50">${msg_admin_common_pageSize_50}</option>
                        <option value="100">${msg_admin_common_pageSize_100}</option>
                    </select>
                </label>
            </div>
        </div>

        <div class="adm-table-wrap">
            <table id="securityAssessmentTable"
                   class="adm-table adm-section-table-fixed adm-security-assessment-table sra-table"
                   data-section="securityAssessments"
                   data-admin-list-ignore="hard">
                <colgroup>
                    <col class="sra-col-check"/>
                    <col class="sra-col-source"/>
                    <col class="sra-col-target"/>
                    <col class="sra-col-risk"/>
                    <col class="sra-col-recommend"/>
                    <col class="sra-col-evidence"/>
                    <col class="sra-col-status"/>
                    <col class="sra-col-date"/>
                    <col class="sra-col-action"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="sra-th sra-th-check"><input type="checkbox" id="sraCheckAll" onchange="sraToggleAll(this)" aria-label="select-all"></th>
                    <th class="sra-th sra-sortable" data-sort="source" onclick="sraSortBy('source')"><span class="sra-th-label">${msg_security_admin_common_scopeSource}</span><span class="sra-sort-ico" aria-hidden="true"></span></th>
                    <th class="sra-th sra-sortable" data-sort="target" onclick="sraSortBy('target')"><span class="sra-th-label">${msg_security_admin_common_target}</span><span class="sra-sort-ico" aria-hidden="true"></span></th>
                    <th class="sra-th sra-sortable" data-sort="risk" onclick="sraSortBy('risk')"><span class="sra-th-label">${msg_security_admin_common_riskLevel}</span><span class="sra-sort-ico" aria-hidden="true"></span></th>
                    <th class="sra-th sra-sortable" data-sort="recommend" onclick="sraSortBy('recommend')"><span class="sra-th-label">${msg_security_admin_common_recommendationAction}</span><span class="sra-sort-ico" aria-hidden="true"></span></th>
                    <th class="sra-th"><span class="sra-th-label">${msg_security_admin_common_evidence}</span></th>
                    <th class="sra-th sra-sortable" data-sort="status" onclick="sraSortBy('status')"><span class="sra-th-label">${msg_security_admin_common_status}</span><span class="sra-sort-ico" aria-hidden="true"></span></th>
                    <th class="sra-th sra-sortable" data-sort="date" onclick="sraSortBy('date')"><span class="sra-th-label">${msg_security_admin_common_createdAt}</span><span class="sra-sort-ico" aria-hidden="true"></span></th>
                    <th class="sra-th"><span class="sra-th-label">${msg_security_admin_common_apply}</span></th>
                </tr>
                </thead>
                <tbody id="sraTableBody">
                <c:forEach var="a" items="${assessments}">
                    <tr data-row-id="${a.assessmentIdx}"
                        data-subject-type="${fn:escapeXml(a.subjectType)}"
                        data-decision-status="${fn:escapeXml(a.decisionStatus)}"
                        data-sort-source="${fn:escapeXml(a.assessmentScope)}|${fn:escapeXml(a.sourceKind)}|${fn:escapeXml(a.sourceName)}"
                        data-sort-target="${fn:escapeXml(a.subjectType)}:${fn:escapeXml(a.subjectKey)}"
                        data-sort-risk="${fn:escapeXml(a.riskLevel)}|${a.riskScore}"
                        data-sort-recommend="${fn:escapeXml(a.recommendationAction)}"
                        data-sort-status="${fn:escapeXml(a.decisionStatus)}"
                        data-sort-date="<fmt:formatDate value='${a.createdAtDate}' pattern='yyyyMMddHHmm'/>">
                        <td class="sra-cell-check"><input type="checkbox" class="js-sra-row-check" value="${a.assessmentIdx}" onchange="sraUpdateBulkCount()" aria-label="row-select"></td>
                        <td>
                            <div class="adm-security-assessment-primary"><c:out value="${a.assessmentScope}"/></div>
                            <div class="adm-page-muted"><c:out value="${a.sourceKind}"/></div>
                            <div class="adm-page-muted"><c:out value="${a.sourceName}"/></div>
                        </td>
                        <td>
                            <div><c:out value="${a.subjectType}"/>: <c:out value="${a.subjectKey}"/></div>
                            <c:if test="${not empty a.userId}"><div class="adm-page-muted"><c:out value="${a.userId}"/> / <c:out value="${a.nickname}"/></div></c:if>
                            <c:if test="${not empty a.ipAddress}"><div class="adm-page-muted">${msg_security_admin_common_ip}: <c:out value="${a.ipAddress}"/></div></c:if>
                        </td>
                        <td>
                            <div class="adm-security-assessment-primary"><c:out value="${a.riskLevel}"/></div>
                            <c:if test="${not empty a.riskScore}"><div class="adm-page-muted">score <c:out value="${a.riskScore}"/></div></c:if>
                            <c:if test="${not empty a.confidenceScore}"><div class="adm-page-muted">confidence <c:out value="${a.confidenceScore}"/></div></c:if>
                        </td>
                        <td>
                            <div class="adm-security-assessment-primary"><c:out value="${a.recommendationAction}"/></div>
                            <div class="adm-page-muted"><c:out value="${a.recommendationReason}"/></div>
                        </td>
                        <td><div class="adm-security-assessment-evidence"><c:out value="${a.evidenceSummary}"/></div></td>
                        <td><span class="adm-badge"><c:out value="${a.decisionStatus}"/></span></td>
                        <td><fmt:formatDate value="${a.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <c:if test="${a.decisionStatus != 'APPLIED'}">
                                <div class="adm-security-assessment-row-actions">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-assessments/${a.assessmentIdx}/create-review">
                                        <input type="hidden" name="severity" value="${fn:escapeXml(a.riskLevel)}">
                                        <input type="hidden" name="summary" value="${fn:escapeXml(a.recommendationAction)}">
                                        <input type="hidden" name="detailMessage" value="${fn:escapeXml(a.evidenceSummary)}">
                                        <button class="adm-btn adm-btn-ghost" type="submit">${msg_security_admin_common_enqueueReview}</button>
                                    </form>
                                    <c:if test="${a.subjectType == 'USER'}">
                                        <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/security-assessments/${a.assessmentIdx}/apply-user-block">
                                            <button class="adm-btn adm-btn-danger" type="submit">${msg_security_admin_common_applyUserBlock}</button>
                                        </form>
                                    </c:if>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="sra-empty adm-is-hidden" id="sraEmptyState">${msg_security_admin_empty_securityAssessments}</div>
        </div>

        <div class="sra-pagination" id="sraPaging">
            <div class="sra-page-info"><span id="sraPageInfo"></span></div>
            <div class="sra-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost" id="sraPrevBtn" onclick="sraGoPage(window.sraState.page - 1)">${msg_admin_common_prev}</button>
                <span class="sra-page-state" id="sraPageState"></span>
                <button type="button" class="adm-btn adm-btn-ghost" id="sraNextBtn" onclick="sraGoPage(window.sraState.page + 1)">${msg_admin_common_next}</button>
            </div>
        </div>
    </div>
</div>

<script>
(function () {
    'use strict';
    /* ─── 보안 위험 판단 — 클라이언트 사이드 페이징·정렬·검색·체크박스 일괄처리 ───
       로딩 방식 결정: 서버 getSecurityRiskAssessments() 는 LIMIT 없이 5개 필터(assessmentScope/
       sourceKind/riskLevel/decisionStatus/keyword)로 서버 필터링 후 전 결과 반환. 단건
       create-review / apply-user-block 액션을 ids 기반 bulk POST 로 확장. 행 별 단건 폼은 유지.
       프리픽스 sra- (security risk assessment) — sa- 는 superAdmin 예약. */
    var ctx = '${pageContext.request.contextPath}';

    var SRA_MSG = {
        exportSelectedLabel: '${msg_admin_common_exportSelected}',
        pickAction: '${msg_lrr_pickAction}',
        noSelection: '${msg_lrr_noSelection}',
        bulkConfirmTpl: '<spring:message code="security.admin.loginReviews.bulkConfirm" arguments="{0}" javaScriptEscape="true"/>'
    };

    var sraState = {
        page: 1, pageSize: 20,
        sortBy: '', sortDir: 'ASC',
        pageSearch: '',
        rows: [], filtered: []
    };
    window.sraState = sraState;

    function cacheRows() {
        var tbody = document.getElementById('sraTableBody');
        if (!tbody) return;
        sraState.rows = Array.prototype.slice.call(tbody.querySelectorAll('tr[data-row-id]'));
    }
    function applyFilter() {
        var q = (sraState.pageSearch || '').trim().toLowerCase();
        if (!q) { sraState.filtered = sraState.rows.slice(); return; }
        sraState.filtered = sraState.rows.filter(function (tr) {
            return ((tr.innerText || tr.textContent) || '').toLowerCase().indexOf(q) !== -1;
        });
    }
    function applySort() {
        if (!sraState.sortBy) return;
        var dir = sraState.sortDir === 'DESC' ? -1 : 1;
        var attr = 'data-sort-' + sraState.sortBy;
        sraState.filtered.sort(function (a, b) {
            var av = (a.getAttribute(attr) || '').toLowerCase();
            var bv = (b.getAttribute(attr) || '').toLowerCase();
            return av.localeCompare(bv, undefined, { numeric: true, sensitivity: 'base' }) * dir;
        });
    }
    function render() {
        var tbody = document.getElementById('sraTableBody');
        if (!tbody) return;
        var total = sraState.filtered.length;
        var pageSize = sraState.pageSize > 0 ? sraState.pageSize : 20;
        var totalPage = Math.max(1, Math.ceil(total / pageSize));
        if (sraState.page > totalPage) sraState.page = totalPage;
        if (sraState.page < 1) sraState.page = 1;
        var start = (sraState.page - 1) * pageSize;
        var slice = sraState.filtered.slice(start, start + pageSize);

        sraState.rows.forEach(function (tr) { if (tr.parentNode === tbody) tbody.removeChild(tr); });
        Array.prototype.slice.call(tbody.querySelectorAll('.sra-empty-row')).forEach(function (tr) { tr.remove(); });
        slice.forEach(function (tr) { tbody.appendChild(tr); });
        if (slice.length === 0) {
            var emptyTpl = document.getElementById('sraEmptyState');
            var emptyText = emptyTpl ? emptyTpl.textContent : '';
            var emptyTr = document.createElement('tr');
            emptyTr.className = 'sra-empty-row';
            var td = document.createElement('td');
            td.colSpan = 9; td.className = 'sra-empty-cell'; td.textContent = emptyText;
            emptyTr.appendChild(td);
            tbody.appendChild(emptyTr);
        }

        var info = document.getElementById('sraPageInfo');
        if (info) info.textContent = total + ' / ' + sraState.rows.length;
        var stateEl = document.getElementById('sraPageState');
        if (stateEl) stateEl.textContent = sraState.page + ' / ' + totalPage;
        var prev = document.getElementById('sraPrevBtn');
        var next = document.getElementById('sraNextBtn');
        if (prev) prev.disabled = sraState.page <= 1;
        if (next) next.disabled = sraState.page >= totalPage;

        Array.prototype.slice.call(document.querySelectorAll('#securityAssessmentTable thead th.sra-sortable')).forEach(function (th) {
            var ico = th.querySelector('.sra-sort-ico');
            if (!ico) return;
            ico.textContent = (th.getAttribute('data-sort') === sraState.sortBy)
                ? (sraState.sortDir === 'DESC' ? '▼' : '▲')
                : '';
        });
        var resetBtn = document.getElementById('sraSortReset');
        if (resetBtn) resetBtn.classList.toggle('adm-is-hidden', !sraState.sortBy);

        updateBulkCount();
    }
    function applyAll() { applyFilter(); applySort(); render(); }

    function updateBulkCount() {
        var checked = document.querySelectorAll('#sraTableBody .js-sra-row-check:checked');
        var n = checked.length;
        var bulkBar = document.getElementById('sraBulkBar');
        if (bulkBar) {
            bulkBar.classList.toggle('is-active', n > 0);
            bulkBar.setAttribute('aria-hidden', n > 0 ? 'false' : 'true');
            bulkBar.querySelectorAll('select, button').forEach(function (el) { el.disabled = n === 0; });
        }
        var countEl = document.getElementById('sraBulkCount');
        if (countEl) countEl.textContent = n;
        var selBtn = document.getElementById('sraExportSelectedBtn');
        if (selBtn) {
            selBtn.disabled = n === 0;
            selBtn.textContent = SRA_MSG.exportSelectedLabel + ' (' + n + ')';
        }
        var checkAll = document.getElementById('sraCheckAll');
        if (checkAll) {
            var visible = document.querySelectorAll('#sraTableBody .js-sra-row-check');
            checkAll.checked = visible.length > 0 && n === visible.length;
            checkAll.indeterminate = n > 0 && n < visible.length;
        }
    }
    window.sraUpdateBulkCount = updateBulkCount;

    window.sraToggleAll = function (cb) {
        document.querySelectorAll('#sraTableBody .js-sra-row-check').forEach(function (c) { c.checked = cb.checked; });
        updateBulkCount();
    };
    window.sraClearSelection = function () {
        document.querySelectorAll('#sraTableBody .js-sra-row-check').forEach(function (c) { c.checked = false; });
        var checkAll = document.getElementById('sraCheckAll');
        if (checkAll) { checkAll.checked = false; checkAll.indeterminate = false; }
        updateBulkCount();
    };

    window.sraSortBy = function (field) {
        if (sraState.sortBy === field) {
            sraState.sortDir = (sraState.sortDir === 'ASC') ? 'DESC' : 'ASC';
        } else { sraState.sortBy = field; sraState.sortDir = 'ASC'; }
        sraState.page = 1;
        applyAll();
    };
    window.sraResetSort = function () {
        sraState.sortBy = ''; sraState.sortDir = 'ASC'; sraState.page = 1; applyAll();
    };
    window.sraChangeSize = function (size) {
        var n = parseInt(size, 10);
        sraState.pageSize = (n > 0 ? n : 20);
        sraState.page = 1; render();
    };
    window.sraGoPage = function (p) {
        var total = sraState.filtered.length;
        var totalPage = Math.max(1, Math.ceil(total / sraState.pageSize));
        var next = Math.min(Math.max(1, parseInt(p, 10) || 1), totalPage);
        if (next === sraState.page) return;
        sraState.page = next; render();
    };
    window.sraSetPageSearch = function (text) {
        sraState.pageSearch = text || ''; sraState.page = 1; applyAll();
    };

    window.sraApplyBulk = function () {
        var action = (document.getElementById('sraBulkActionSelect') || {}).value || '';
        if (!action) { alert(SRA_MSG.pickAction); return; }
        var checked = Array.prototype.slice.call(document.querySelectorAll('#sraTableBody .js-sra-row-check:checked'));
        if (!checked.length) { alert(SRA_MSG.noSelection); return; }

        /* apply-user-block 은 USER 대상만 처리 가능 — 서버에서 한 번 더 거르지만, 사용자에게 미리 안내. */
        var filteredCount = checked.length;
        if (action === 'apply-user-block') {
            filteredCount = checked.filter(function (c) {
                var tr = c.closest('tr');
                return tr && tr.getAttribute('data-subject-type') === 'USER';
            }).length;
            if (!filteredCount) { alert(SRA_MSG.noSelection); return; }
        }
        var confirmMsg = (SRA_MSG.bulkConfirmTpl || '').replace('{0}', String(filteredCount));
        if (!window.confirm(confirmMsg)) return;

        var ids = checked.map(function (c) { return c.value; }).join(',');
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = ctx + '/admin/login-risk/security-assessments/bulk';
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

    window.sraExport = function (scope) {
        var format = (document.getElementById('sraExportFormat') || {}).value || 'csv';
        var params = new URLSearchParams();
        params.set('scope', scope);
        params.set('format', format);
        if (scope === 'filtered') {
            var form = document.getElementById('sraSearchForm');
            if (form) {
                var fd = new FormData(form);
                fd.forEach(function (v, k) { if (v) params.set(k, v); });
            }
        }
        if (scope === 'selected') {
            var ids = Array.prototype.slice.call(document.querySelectorAll('#sraTableBody .js-sra-row-check:checked')).map(function (c) { return c.value; });
            if (!ids.length) { alert(SRA_MSG.noSelection); return; }
            params.set('selectedIds', ids.join(','));
        }
        var dropdown = document.getElementById('sraExportDropdown');
        if (dropdown) dropdown.classList.remove('open');
        window.location.href = ctx + '/admin/login-risk/security-assessments/export?' + params.toString();
    };

    function initExportDropdown() {
        var toggle = document.querySelector('.js-sra-export-toggle');
        var dropdown = document.getElementById('sraExportDropdown');
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
        var sizeSel = document.getElementById('sraPageSize');
        if (sizeSel) {
            var n = parseInt(sizeSel.value, 10);
            sraState.pageSize = n > 0 ? n : 20;
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
/* ── 보안 위험 판단 페이지 전용 (sra-) ── */
.adm-security-assessment-page .sra-table { width: 100%; min-width: 1320px; table-layout: fixed; }
.adm-security-assessment-page .sra-col-check     { width: 42px; }
.adm-security-assessment-page .sra-th-check, .adm-security-assessment-page .sra-cell-check { text-align: center; padding: 8px 4px; }
.adm-security-assessment-page .sra-col-source    { width: 170px; }
.adm-security-assessment-page .sra-col-target    { width: 190px; }
.adm-security-assessment-page .sra-col-risk      { width: 130px; }
.adm-security-assessment-page .sra-col-recommend { width: 180px; }
.adm-security-assessment-page .sra-col-evidence  { width: auto; }
.adm-security-assessment-page .sra-col-status    { width: 100px; }
.adm-security-assessment-page .sra-col-date      { width: 140px; }
.adm-security-assessment-page .sra-col-action    { width: 200px; }

.adm-security-assessment-page .sra-th {
    white-space: nowrap; overflow: hidden;
    user-select: none;
    padding-right: 18px; box-sizing: border-box;
}
.adm-security-assessment-page .sra-th.sra-sortable { cursor: pointer; }
.adm-security-assessment-page .sra-th .sra-th-label {
    display: inline-block; max-width: calc(100% - 14px);
    overflow: hidden; text-overflow: ellipsis; vertical-align: middle;
}
.adm-security-assessment-page .sra-th .sra-sort-ico {
    display: inline-block; margin-left: 4px; width: 10px;
    font-size: 10px; line-height: 1; vertical-align: middle; color: #93c5fd;
}
body.sa-light .adm-security-assessment-page .sra-th .sra-sort-ico { color: #2563eb; }

.adm-security-assessment-page .sra-table td {
    vertical-align: top; overflow: hidden;
    word-break: break-word;
}
.adm-security-assessment-page .sra-table .adm-security-assessment-evidence {
    white-space: pre-wrap; overflow-wrap: anywhere;
    max-height: 8em; overflow: hidden;
    text-overflow: ellipsis; font-size: 12px; line-height: 1.45;
}
.adm-security-assessment-page .sra-table .adm-security-assessment-row-actions {
    display: flex; flex-wrap: wrap; gap: 4px;
}

/* card head + export */
.adm-security-assessment-page .sra-card-head { display: flex; align-items: center; justify-content: space-between; gap: 12px; flex-wrap: wrap; }
.adm-security-assessment-page .sra-total-label { margin-left: 8px; font-size: 12px; color: #94a3b8; font-weight: normal; }
.adm-security-assessment-page .sra-export-control { position: relative; display: inline-flex; align-items: center; gap: 6px; }
.adm-security-assessment-page .sra-export-control .sra-export-format { min-width: 84px; }
.adm-security-assessment-page .sra-export-control .adm-export-dropdown {
    display: none; position: absolute; top: 100%; right: 0; margin-top: 4px;
    background: var(--adm-card-bg, #1e293b); border: 1px solid var(--adm-border, #334155);
    border-radius: 6px; padding: 4px; z-index: 30; min-width: 200px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.25);
}
.adm-security-assessment-page .sra-export-control .adm-export-dropdown.open { display: block; }
.adm-security-assessment-page .sra-export-control .adm-export-item {
    display: block; width: 100%; text-align: left; padding: 6px 10px;
    background: transparent; color: inherit; border: 0; cursor: pointer;
    font-size: 13px; border-radius: 4px;
}
.adm-security-assessment-page .sra-export-control .adm-export-item:disabled { opacity: 0.5; cursor: not-allowed; }
.adm-security-assessment-page .sra-export-control .adm-export-item:hover:not(:disabled) { background: rgba(148,163,184,0.15); }

/* controlbar */
.adm-security-assessment-page .sra-controlbar { display: flex; align-items: center; justify-content: space-between; gap: 12px; padding: 8px 14px; flex-wrap: wrap; }
.adm-security-assessment-page .sra-bulkbar { display: flex; align-items: center; gap: 10px; opacity: 0.55; transition: opacity 0.2s; }
.adm-security-assessment-page .sra-bulkbar.is-active { opacity: 1; }
.adm-security-assessment-page .sra-bulk-count { font-size: 13px; }
.adm-security-assessment-page .sra-bulk-count strong { font-size: 15px; margin-right: 2px; color: #fbbf24; }
.adm-security-assessment-page .sra-bulk-actions { display: inline-flex; gap: 6px; align-items: center; }
.adm-security-assessment-page .sra-view-tools { display: inline-flex; gap: 8px; align-items: center; flex-wrap: wrap; }
.adm-security-assessment-page .sra-tool { display: inline-flex; gap: 4px; align-items: center; }
.adm-security-assessment-page .sra-tool-label { font-size: 12px; color: #94a3b8; }
.adm-security-assessment-page .sra-page-search { min-width: 220px; }
.adm-security-assessment-page .sra-sort-reset { font-size: 12px; }

/* pagination */
.adm-security-assessment-page .sra-pagination { display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; gap: 10px; flex-wrap: wrap; }
.adm-security-assessment-page .sra-page-info { font-size: 12px; color: #94a3b8; }
.adm-security-assessment-page .sra-page-actions { display: inline-flex; gap: 8px; align-items: center; }
.adm-security-assessment-page .sra-page-state { font-size: 13px; min-width: 60px; text-align: center; }

.adm-security-assessment-page .sra-empty,
.adm-security-assessment-page .sra-empty-cell { padding: 16px; text-align: center; color: #94a3b8; }
.adm-security-assessment-page .adm-is-hidden { display: none !important; }

@media (max-width: 1280px) {
    .adm-security-assessment-page .adm-security-assessment-filterbar { flex-wrap: wrap; }
    .adm-security-assessment-page .sra-controlbar { flex-direction: column; align-items: stretch; }
    .adm-security-assessment-page .sra-bulkbar { flex-wrap: wrap; }
    .adm-security-assessment-page .sra-view-tools { justify-content: flex-end; }
}
</style>

<%@ include file="../layout-close.jsp" %>
