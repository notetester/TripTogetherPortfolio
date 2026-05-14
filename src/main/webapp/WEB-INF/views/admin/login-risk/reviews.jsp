<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%-- i18n message declarations: 페이지 표면 문자열 + JS bulk/empty 메시지 --%>
<spring:message var="msg_security_admin_loginReviews_title" code="security.admin.loginReviews.title"/>
<spring:message var="msg_security_admin_placeholder_accountIpSummary" code="security.admin.placeholder.accountIpSummary"/>
<spring:message var="msg_security_admin_comment_approved" code="security.admin.comment.approved"/>
<spring:message var="msg_security_admin_comment_needMoreCheck" code="security.admin.comment.needMoreCheck"/>
<spring:message var="msg_security_admin_comment_notBlocked" code="security.admin.comment.notBlocked"/>
<spring:message var="msg_security_admin_loginReviews_desc" code="security.admin.loginReviews.desc"/>
<spring:message var="msg_security_admin_nav_policies" code="security.admin.nav.policies"/>
<spring:message var="msg_security_admin_nav_externalAssessments" code="security.admin.nav.externalAssessments"/>
<spring:message var="msg_security_admin_nav_notifications" code="security.admin.nav.notifications"/>
<spring:message var="msg_security_admin_nav_securityAssessments" code="security.admin.nav.securityAssessments"/>
<spring:message var="msg_security_admin_common_status" code="security.admin.common.status"/>
<spring:message var="msg_security_admin_common_all" code="security.admin.common.all"/>
<spring:message var="msg_security_admin_common_severity" code="security.admin.common.severity"/>
<spring:message var="msg_security_admin_common_type" code="security.admin.common.type"/>
<spring:message var="msg_security_admin_common_search" code="security.admin.common.search"/>
<spring:message var="msg_security_admin_common_reviewType" code="security.admin.common.reviewType"/>
<spring:message var="msg_security_admin_common_target" code="security.admin.common.target"/>
<spring:message var="msg_security_admin_common_summary" code="security.admin.common.summary"/>
<spring:message var="msg_security_admin_common_createdAt" code="security.admin.common.createdAt"/>
<spring:message var="msg_security_admin_common_action" code="security.admin.common.action"/>
<spring:message var="msg_security_admin_common_reviewComment" code="security.admin.common.reviewComment"/>
<spring:message var="msg_security_admin_common_approve" code="security.admin.common.approve"/>
<spring:message var="msg_security_admin_common_hold" code="security.admin.common.hold"/>
<spring:message var="msg_security_admin_common_reject" code="security.admin.common.reject"/>
<spring:message var="msg_security_admin_empty_reviews" code="security.admin.empty.reviews"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount" arguments="${fn:length(reviews)}"/>
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
<spring:message var="msg_lrr_bulkComment" code="security.admin.loginReviews.bulkComment"/>
<spring:message var="msg_lrr_bulkActionPlaceholder" code="security.admin.loginReviews.bulkActionPlaceholder"/>

<c:set var="pageTitle" value="${msg_security_admin_loginReviews_title}"/>
<c:set var="activeMenu" value="loginRiskReviews"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-governance-page adm-login-review-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_security_admin_loginReviews_title}</h1>
            <p class="adm-page-desc">${msg_security_admin_loginReviews_desc}</p>
        </div>
        <div class="adm-actions adm-login-review-page-actions">
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/policies">${msg_security_admin_nav_policies}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/assessments">${msg_security_admin_nav_externalAssessments}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/notification-preferences">${msg_security_admin_nav_notifications}</a>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${msg_security_admin_nav_securityAssessments}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form id="lrrSearchForm" method="get" class="adm-card adm-login-review-filter-card adm-overflow-visible">
        <div class="adm-card-body">
            <div class="adm-login-review-filterbar">
                <label>${msg_security_admin_common_status}
                    <select class="adm-select" name="status">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                        <option value="HOLD" ${status == 'HOLD' ? 'selected' : ''}>HOLD</option>
                        <option value="APPROVED" ${status == 'APPROVED' ? 'selected' : ''}>APPROVED</option>
                        <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                    </select>
                </label>
                <label>${msg_security_admin_common_severity}
                    <select class="adm-select" name="severity">
                        <option value="">${msg_security_admin_common_all}</option>
                        <option value="CRITICAL" ${severity == 'CRITICAL' ? 'selected' : ''}>CRITICAL</option>
                        <option value="HIGH" ${severity == 'HIGH' ? 'selected' : ''}>HIGH</option>
                        <option value="MEDIUM" ${severity == 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                        <option value="LOW" ${severity == 'LOW' ? 'selected' : ''}>LOW</option>
                    </select>
                </label>
                <label>${msg_security_admin_common_type}
                    <input class="adm-input" type="text" name="reviewType" value="${fn:escapeXml(reviewType)}" placeholder="IP_LOGIN_RISK">
                </label>
                <label class="adm-login-review-keyword-field">${msg_security_admin_common_search}
                    <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${msg_security_admin_placeholder_accountIpSummary}">
                </label>
                <div class="adm-login-review-filter-actions">
                    <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_search}</button>
                    <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/login-risk/reviews">${msg_admin_common_reset}</a>
                </div>
            </div>
        </div>
    </form>

    <div class="adm-card adm-login-review-list-card adm-overflow-visible">
        <div class="adm-card-head lrr-card-head">
            <div class="adm-card-title">
                ${msg_security_admin_loginReviews_title}
                <span class="lrr-total-label" id="lrrTotalLabel">${msg_admin_common_totalCount}</span>
            </div>
            <div class="adm-export-control lrr-export-control">
                <select class="adm-select lrr-export-format" id="lrrExportFormat">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost js-lrr-export-toggle">${msg_admin_common_export} ▾</button>
                <div id="lrrExportDropdown" class="adm-export-dropdown">
                    <button type="button" class="adm-export-item" onclick="lrrExport('all')">${msg_admin_common_exportAll}</button>
                    <button type="button" class="adm-export-item" onclick="lrrExport('filtered')">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="adm-export-item" id="lrrExportSelectedBtn" disabled onclick="lrrExport('selected')">${msg_admin_common_exportSelected} (0)</button>
                </div>
            </div>
        </div>

        <div class="lrr-controlbar">
            <div id="lrrBulkBar" class="lrr-bulkbar" aria-live="polite" aria-hidden="true">
                <span class="lrr-bulk-count"><strong id="lrrBulkCount">0</strong>${msg_admin_common_selectedCount}</span>
                <div class="lrr-bulk-actions">
                    <select class="adm-select" id="lrrBulkActionSelect">
                        <option value="">${msg_lrr_bulkActionPlaceholder}</option>
                        <option value="approve">${msg_security_admin_common_approve}</option>
                        <option value="hold">${msg_security_admin_common_hold}</option>
                        <option value="reject">${msg_security_admin_common_reject}</option>
                    </select>
                    <button type="button" class="adm-btn adm-btn-primary" onclick="lrrApplyBulk()">${msg_admin_common_apply}</button>
                </div>
                <button type="button" class="adm-btn adm-btn-ghost lrr-bulk-clear" onclick="lrrClearSelection()">${msg_admin_common_clearSelection}</button>
            </div>
            <div class="lrr-view-tools">
                <button type="button" class="adm-btn adm-btn-ghost lrr-sort-reset adm-is-hidden" id="lrrSortReset" onclick="lrrResetSort()">${msg_lrr_sortReset}</button>
                <label class="lrr-tool lrr-page-search-tool">
                    <input class="adm-input lrr-page-search" id="lrrPageSearch" type="text" placeholder="${msg_lrr_pageSearchPlaceholder}" oninput="lrrSetPageSearch(this.value)">
                </label>
                <label class="lrr-tool">
                    <span class="lrr-tool-label">${msg_admin_common_pageSizeLabel}</span>
                    <select class="adm-select lrr-page-size" id="lrrPageSize" onchange="lrrChangeSize(this.value)">
                        <option value="10">${msg_admin_common_pageSize_10}</option>
                        <option value="20" selected>${msg_admin_common_pageSize_20}</option>
                        <option value="50">${msg_admin_common_pageSize_50}</option>
                        <option value="100">${msg_admin_common_pageSize_100}</option>
                    </select>
                </label>
            </div>
        </div>

        <div class="adm-table-wrap">
            <table id="loginRiskReviewTable"
                   class="adm-table adm-section-table-fixed adm-login-review-table lrr-table"
                   data-section="loginRiskReviews"
                   data-admin-list-ignore="hard">
                <colgroup>
                    <col class="lrr-col-check"/>
                    <col class="lrr-col-status"/>
                    <col class="lrr-col-severity"/>
                    <col class="lrr-col-type"/>
                    <col class="lrr-col-target"/>
                    <col class="lrr-col-summary"/>
                    <col class="lrr-col-date"/>
                    <col class="lrr-col-action"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="lrr-th lrr-th-check"><input type="checkbox" id="lrrCheckAll" onchange="lrrToggleAll(this)" aria-label="select-all"></th>
                    <th class="lrr-th lrr-sortable" data-sort="status" onclick="lrrSortBy('status')"><span class="lrr-th-label">${msg_security_admin_common_status}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th lrr-sortable" data-sort="severity" onclick="lrrSortBy('severity')"><span class="lrr-th-label">${msg_security_admin_common_severity}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th lrr-sortable" data-sort="type" onclick="lrrSortBy('type')"><span class="lrr-th-label">${msg_security_admin_common_reviewType}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th lrr-sortable" data-sort="target" onclick="lrrSortBy('target')"><span class="lrr-th-label">${msg_security_admin_common_target}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th lrr-sortable" data-sort="summary" onclick="lrrSortBy('summary')"><span class="lrr-th-label">${msg_security_admin_common_summary}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th lrr-sortable" data-sort="date" onclick="lrrSortBy('date')"><span class="lrr-th-label">${msg_security_admin_common_createdAt}</span><span class="lrr-sort-ico" aria-hidden="true"></span></th>
                    <th class="lrr-th"><span class="lrr-th-label">${msg_security_admin_common_action}</span></th>
                </tr>
                </thead>
                <tbody id="lrrTableBody">
                <c:forEach var="r" items="${reviews}">
                    <tr data-row-id="${r.reviewIdx}"
                        data-sort-status="${fn:escapeXml(r.reviewStatus)}"
                        data-sort-severity="${fn:escapeXml(r.severity)}"
                        data-sort-type="${fn:escapeXml(r.reviewType)}"
                        data-sort-target="${fn:escapeXml(r.subjectType)}:${fn:escapeXml(r.subjectKey)}"
                        data-sort-summary="${fn:escapeXml(r.summary)}"
                        data-sort-date="<fmt:formatDate value='${r.createdAtDate}' pattern='yyyyMMddHHmm'/>">
                        <td class="lrr-cell-check"><input type="checkbox" class="js-lrr-row-check" value="${r.reviewIdx}" onchange="lrrUpdateBulkCount()" aria-label="row-select"></td>
                        <td><span class="adm-badge"><c:out value="${r.reviewStatus}"/></span></td>
                        <td><c:out value="${r.severity}"/></td>
                        <td>
                            <div class="adm-login-review-type"><c:out value="${r.reviewType}"/></div>
                            <div class="adm-page-muted"><c:out value="${r.policyCode}"/></div>
                        </td>
                        <td>
                            <div><c:out value="${r.subjectType}"/>: <c:out value="${r.subjectKey}"/></div>
                            <c:if test="${not empty r.userId}"><div class="adm-page-muted"><c:out value="${r.userId}"/> / <c:out value="${r.nickname}"/></div></c:if>
                        </td>
                        <td>
                            <div class="adm-login-review-summary">
                                <strong><c:out value="${r.summary}"/></strong>
                                <span><c:out value="${r.detailMessage}"/></span>
                                <c:if test="${not empty r.reviewComment}">
                                    <span>${msg_security_admin_common_reviewComment}: <c:out value="${r.reviewComment}"/></span>
                                </c:if>
                            </div>
                        </td>
                        <td><fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>
                            <c:if test="${r.reviewStatus == 'PENDING' || r.reviewStatus == 'HOLD'}">
                                <div class="adm-login-review-row-actions">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/approve">
                                        <input type="hidden" name="comment" value="${msg_security_admin_comment_approved}">
                                        <button class="adm-btn adm-btn-primary" type="submit">${msg_security_admin_common_approve}</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/hold">
                                        <input type="hidden" name="comment" value="${msg_security_admin_comment_needMoreCheck}">
                                        <button class="adm-btn adm-btn-ghost" type="submit">${msg_security_admin_common_hold}</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/reviews/${r.reviewIdx}/reject">
                                        <input type="hidden" name="comment" value="${msg_security_admin_comment_notBlocked}">
                                        <button class="adm-btn adm-btn-danger" type="submit">${msg_security_admin_common_reject}</button>
                                    </form>
                                </div>
                            </c:if>
                            <c:if test="${r.reviewStatus != 'PENDING' && r.reviewStatus != 'HOLD'}">
                                <div class="adm-page-muted"><c:out value="${r.reviewedByUserId}"/> / <fmt:formatDate value="${r.reviewedAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="lrr-empty adm-is-hidden" id="lrrEmptyState">${msg_security_admin_empty_reviews}</div>
        </div>

        <div class="lrr-pagination" id="lrrPaging">
            <div class="lrr-page-info"><span id="lrrPageInfo"></span></div>
            <div class="lrr-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost" id="lrrPrevBtn" onclick="lrrGoPage(window.lrrState.page - 1)">${msg_admin_common_prev}</button>
                <span class="lrr-page-state" id="lrrPageState"></span>
                <button type="button" class="adm-btn adm-btn-ghost" id="lrrNextBtn" onclick="lrrGoPage(window.lrrState.page + 1)">${msg_admin_common_next}</button>
            </div>
        </div>
    </div>
</div>

<script>
(function () {
    'use strict';
    /* ─── 로그인 위험 검토 — 클라이언트 사이드 페이징·정렬·검색·체크박스·다운로드 ───
       로딩 방식 결정: 서버 getReviewQueue() 는 LIMIT 없이 status/severity/reviewType/keyword
       서버 필터링 후 전 결과를 반환. 검토 큐는 운영 기준 수백건 수준이므로 한 번 렌더된 행을
       클라이언트에서 캐싱하여 페이징·정렬·페이지내 검색을 즉시 처리한다. 큰 필터 변경은
       상단 서버 GET 폼(필터바)으로 받고, 그 결과를 다시 클라이언트가 핸들링. */
    var ctx = '${pageContext.request.contextPath}';

    var LRR_MSG = {
        exportSelectedLabel: '${msg_admin_common_exportSelected}',
        pickAction: '${msg_lrr_pickAction}',
        noSelection: '${msg_lrr_noSelection}',
        bulkConfirmTpl: '<spring:message code="security.admin.loginReviews.bulkConfirm" arguments="{0}" javaScriptEscape="true"/>',
        bulkComment: '${msg_lrr_bulkComment}'
    };
    window.LRR_MSG = LRR_MSG;

    var lrrState = {
        page: 1,
        pageSize: 20,
        sortBy: '',
        sortDir: 'ASC',
        pageSearch: '',
        rows: [],
        filtered: []
    };
    window.lrrState = lrrState;

    function cacheRows() {
        var tbody = document.getElementById('lrrTableBody');
        if (!tbody) return;
        lrrState.rows = Array.prototype.slice.call(tbody.querySelectorAll('tr[data-row-id]'));
    }

    function applyFilter() {
        var q = (lrrState.pageSearch || '').trim().toLowerCase();
        if (!q) { lrrState.filtered = lrrState.rows.slice(); return; }
        lrrState.filtered = lrrState.rows.filter(function (tr) {
            return ((tr.innerText || tr.textContent) || '').toLowerCase().indexOf(q) !== -1;
        });
    }

    function applySort() {
        if (!lrrState.sortBy) return;
        var dir = lrrState.sortDir === 'DESC' ? -1 : 1;
        var attr = 'data-sort-' + lrrState.sortBy;
        lrrState.filtered.sort(function (a, b) {
            var av = (a.getAttribute(attr) || '').toLowerCase();
            var bv = (b.getAttribute(attr) || '').toLowerCase();
            return av.localeCompare(bv, undefined, { numeric: true, sensitivity: 'base' }) * dir;
        });
    }

    function render() {
        var tbody = document.getElementById('lrrTableBody');
        if (!tbody) return;
        var total = lrrState.filtered.length;
        var pageSize = lrrState.pageSize > 0 ? lrrState.pageSize : 20;
        var totalPage = Math.max(1, Math.ceil(total / pageSize));
        if (lrrState.page > totalPage) lrrState.page = totalPage;
        if (lrrState.page < 1) lrrState.page = 1;
        var start = (lrrState.page - 1) * pageSize;
        var slice = lrrState.filtered.slice(start, start + pageSize);

        /* 기존 행 detach + 빈 placeholder 제거 후 슬라이스만 재부착 */
        lrrState.rows.forEach(function (tr) { if (tr.parentNode === tbody) tbody.removeChild(tr); });
        Array.prototype.slice.call(tbody.querySelectorAll('.lrr-empty-row')).forEach(function (tr) { tr.remove(); });
        slice.forEach(function (tr) { tbody.appendChild(tr); });
        if (slice.length === 0) {
            var emptyTpl = document.getElementById('lrrEmptyState');
            var emptyText = emptyTpl ? emptyTpl.textContent : '';
            var emptyTr = document.createElement('tr');
            emptyTr.className = 'lrr-empty-row';
            var td = document.createElement('td');
            td.colSpan = 8;
            td.className = 'lrr-empty-cell';
            td.textContent = emptyText;
            emptyTr.appendChild(td);
            tbody.appendChild(emptyTr);
        }

        var info = document.getElementById('lrrPageInfo');
        if (info) info.textContent = total + ' / ' + lrrState.rows.length;
        var stateEl = document.getElementById('lrrPageState');
        if (stateEl) stateEl.textContent = lrrState.page + ' / ' + totalPage;
        var prev = document.getElementById('lrrPrevBtn');
        var next = document.getElementById('lrrNextBtn');
        if (prev) prev.disabled = lrrState.page <= 1;
        if (next) next.disabled = lrrState.page >= totalPage;

        Array.prototype.slice.call(document.querySelectorAll('#loginRiskReviewTable thead th.lrr-sortable')).forEach(function (th) {
            var ico = th.querySelector('.lrr-sort-ico');
            if (!ico) return;
            ico.textContent = (th.getAttribute('data-sort') === lrrState.sortBy)
                ? (lrrState.sortDir === 'DESC' ? '▼' : '▲')
                : '';
        });
        var resetBtn = document.getElementById('lrrSortReset');
        if (resetBtn) resetBtn.classList.toggle('adm-is-hidden', !lrrState.sortBy);

        updateBulkCount();
    }

    function applyAll() { applyFilter(); applySort(); render(); }

    function updateBulkCount() {
        var checked = document.querySelectorAll('#lrrTableBody .js-lrr-row-check:checked');
        var n = checked.length;
        var bulkBar = document.getElementById('lrrBulkBar');
        if (bulkBar) {
            bulkBar.classList.toggle('is-active', n > 0);
            bulkBar.setAttribute('aria-hidden', n > 0 ? 'false' : 'true');
            bulkBar.querySelectorAll('select, button').forEach(function (el) { el.disabled = n === 0; });
        }
        var countEl = document.getElementById('lrrBulkCount');
        if (countEl) countEl.textContent = n;
        var selBtn = document.getElementById('lrrExportSelectedBtn');
        if (selBtn) {
            selBtn.disabled = n === 0;
            selBtn.textContent = LRR_MSG.exportSelectedLabel + ' (' + n + ')';
        }
        var checkAll = document.getElementById('lrrCheckAll');
        if (checkAll) {
            var visible = document.querySelectorAll('#lrrTableBody .js-lrr-row-check');
            checkAll.checked = visible.length > 0 && n === visible.length;
            checkAll.indeterminate = n > 0 && n < visible.length;
        }
    }
    window.lrrUpdateBulkCount = updateBulkCount;

    window.lrrToggleAll = function (cb) {
        document.querySelectorAll('#lrrTableBody .js-lrr-row-check').forEach(function (c) { c.checked = cb.checked; });
        updateBulkCount();
    };
    window.lrrClearSelection = function () {
        document.querySelectorAll('#lrrTableBody .js-lrr-row-check').forEach(function (c) { c.checked = false; });
        var checkAll = document.getElementById('lrrCheckAll');
        if (checkAll) { checkAll.checked = false; checkAll.indeterminate = false; }
        updateBulkCount();
    };

    window.lrrSortBy = function (field) {
        if (lrrState.sortBy === field) {
            lrrState.sortDir = (lrrState.sortDir === 'ASC') ? 'DESC' : 'ASC';
        } else {
            lrrState.sortBy = field;
            lrrState.sortDir = 'ASC';
        }
        lrrState.page = 1;
        applyAll();
    };
    window.lrrResetSort = function () {
        lrrState.sortBy = '';
        lrrState.sortDir = 'ASC';
        lrrState.page = 1;
        applyAll();
    };
    window.lrrChangeSize = function (size) {
        var n = parseInt(size, 10);
        lrrState.pageSize = (n > 0 ? n : 20);
        lrrState.page = 1;
        render();
    };
    window.lrrGoPage = function (p) {
        var total = lrrState.filtered.length;
        var totalPage = Math.max(1, Math.ceil(total / lrrState.pageSize));
        var next = Math.min(Math.max(1, parseInt(p, 10) || 1), totalPage);
        if (next === lrrState.page) return;
        lrrState.page = next;
        render();
    };
    window.lrrSetPageSearch = function (text) {
        lrrState.pageSearch = text || '';
        lrrState.page = 1;
        applyAll();
    };

    window.lrrApplyBulk = function () {
        var action = (document.getElementById('lrrBulkActionSelect') || {}).value || '';
        if (!action) { alert(LRR_MSG.pickAction); return; }
        var checked = Array.prototype.slice.call(document.querySelectorAll('#lrrTableBody .js-lrr-row-check:checked'));
        if (!checked.length) { alert(LRR_MSG.noSelection); return; }
        var confirmMsg = (LRR_MSG.bulkConfirmTpl || '').replace('{0}', String(checked.length));
        if (!window.confirm(confirmMsg)) return;

        var ids = checked.map(function (c) { return c.value; }).join(',');
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = ctx + '/admin/login-risk/reviews/bulk';
        function addInput(name, value) {
            var inp = document.createElement('input');
            inp.type = 'hidden'; inp.name = name; inp.value = value;
            form.appendChild(inp);
        }
        addInput('action', action);
        addInput('ids', ids);
        addInput('comment', LRR_MSG.bulkComment);
        document.body.appendChild(form);
        form.submit();
    };

    window.lrrExport = function (scope) {
        var format = (document.getElementById('lrrExportFormat') || {}).value || 'csv';
        var params = new URLSearchParams();
        params.set('scope', scope);
        params.set('format', format);
        if (scope === 'filtered') {
            var form = document.getElementById('lrrSearchForm');
            if (form) {
                var fd = new FormData(form);
                fd.forEach(function (v, k) { if (v) params.set(k, v); });
            }
        }
        if (scope === 'selected') {
            var ids = Array.prototype.slice.call(document.querySelectorAll('#lrrTableBody .js-lrr-row-check:checked')).map(function (c) { return c.value; });
            if (!ids.length) { alert(LRR_MSG.noSelection); return; }
            params.set('selectedIds', ids.join(','));
        }
        var dropdown = document.getElementById('lrrExportDropdown');
        if (dropdown) dropdown.classList.remove('open');
        window.location.href = ctx + '/admin/login-risk/reviews/export?' + params.toString();
    };

    function initExportDropdown() {
        var toggle = document.querySelector('.js-lrr-export-toggle');
        var dropdown = document.getElementById('lrrExportDropdown');
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
        var sizeSel = document.getElementById('lrrPageSize');
        if (sizeSel) {
            var n = parseInt(sizeSel.value, 10);
            lrrState.pageSize = n > 0 ? n : 20;
        }
        initExportDropdown();
        applyAll();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
</script>

<style>
/* ── 로그인 위험 검토 페이지 전용 ── */
.adm-login-review-page .lrr-table { width: 100%; min-width: 1120px; table-layout: fixed; }
.adm-login-review-page .lrr-col-check    { width: 42px; }
.adm-login-review-page .lrr-th-check, .adm-login-review-page .lrr-cell-check { text-align: center; padding: 8px 4px; }
.adm-login-review-page .lrr-col-status   { width: 100px; }
.adm-login-review-page .lrr-col-severity { width: 90px; }
.adm-login-review-page .lrr-col-type     { width: 170px; }
.adm-login-review-page .lrr-col-target   { width: 200px; }
.adm-login-review-page .lrr-col-summary  { width: auto; }
.adm-login-review-page .lrr-col-date     { width: 140px; }
.adm-login-review-page .lrr-col-action   { width: 230px; }

.adm-login-review-page .lrr-th {
    white-space: nowrap; overflow: hidden;
    user-select: none;
    padding-right: 18px;
    position: relative;
    box-sizing: border-box;
}
.adm-login-review-page .lrr-th.lrr-sortable { cursor: pointer; }
.adm-login-review-page .lrr-th .lrr-th-label {
    display: inline-block; max-width: calc(100% - 14px);
    overflow: hidden; text-overflow: ellipsis; vertical-align: middle;
}
.adm-login-review-page .lrr-th .lrr-sort-ico {
    display: inline-block; margin-left: 4px; width: 10px;
    font-size: 10px; line-height: 1; vertical-align: middle; color: #93c5fd;
}
body.sa-light .adm-login-review-page .lrr-th .lrr-sort-ico { color: #2563eb; }

.adm-login-review-page .lrr-table td {
    vertical-align: top;
    overflow: hidden; text-overflow: ellipsis;
    word-break: break-word;
}
.adm-login-review-page .lrr-table td .adm-login-review-summary { white-space: normal; line-height: 1.45; }
.adm-login-review-page .lrr-table td .adm-login-review-row-actions {
    display: flex; flex-wrap: wrap; gap: 4px;
}
.adm-login-review-page .lrr-table td .adm-login-review-row-actions form { display: inline-flex; }

/* card head + export 드롭다운 */
.adm-login-review-page .lrr-card-head { display: flex; align-items: center; justify-content: space-between; gap: 12px; flex-wrap: wrap; }
.adm-login-review-page .lrr-total-label { margin-left: 8px; font-size: 12px; color: #94a3b8; font-weight: normal; }
.adm-login-review-page .lrr-export-control { position: relative; display: inline-flex; align-items: center; gap: 6px; }
.adm-login-review-page .lrr-export-control .lrr-export-format { min-width: 84px; }
.adm-login-review-page .lrr-export-control .adm-export-dropdown {
    display: none; position: absolute; top: 100%; right: 0; margin-top: 4px;
    background: var(--adm-card-bg, #1e293b); border: 1px solid var(--adm-border, #334155);
    border-radius: 6px; padding: 4px; z-index: 30; min-width: 200px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.25);
}
.adm-login-review-page .lrr-export-control .adm-export-dropdown.open { display: block; }
.adm-login-review-page .lrr-export-control .adm-export-item {
    display: block; width: 100%; text-align: left; padding: 6px 10px;
    background: transparent; color: inherit; border: 0; cursor: pointer;
    font-size: 13px; border-radius: 4px;
}
.adm-login-review-page .lrr-export-control .adm-export-item:disabled { opacity: 0.5; cursor: not-allowed; }
.adm-login-review-page .lrr-export-control .adm-export-item:hover:not(:disabled) { background: rgba(148,163,184,0.15); }

/* controlbar (bulk + view-tools) */
.adm-login-review-page .lrr-controlbar { display: flex; align-items: center; justify-content: space-between; gap: 12px; padding: 8px 14px; flex-wrap: wrap; }
.adm-login-review-page .lrr-bulkbar { display: flex; align-items: center; gap: 10px; opacity: 0.55; transition: opacity 0.2s; }
.adm-login-review-page .lrr-bulkbar.is-active { opacity: 1; }
.adm-login-review-page .lrr-bulk-count { font-size: 13px; }
.adm-login-review-page .lrr-bulk-count strong { font-size: 15px; margin-right: 2px; color: #fbbf24; }
.adm-login-review-page .lrr-bulk-actions { display: inline-flex; gap: 6px; align-items: center; }
.adm-login-review-page .lrr-view-tools { display: inline-flex; gap: 8px; align-items: center; flex-wrap: wrap; }
.adm-login-review-page .lrr-tool { display: inline-flex; gap: 4px; align-items: center; }
.adm-login-review-page .lrr-tool-label { font-size: 12px; color: #94a3b8; }
.adm-login-review-page .lrr-page-search { min-width: 220px; }
.adm-login-review-page .lrr-sort-reset { font-size: 12px; }

/* pagination */
.adm-login-review-page .lrr-pagination { display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; gap: 10px; flex-wrap: wrap; }
.adm-login-review-page .lrr-page-info { font-size: 12px; color: #94a3b8; }
.adm-login-review-page .lrr-page-actions { display: inline-flex; gap: 8px; align-items: center; }
.adm-login-review-page .lrr-page-state { font-size: 13px; min-width: 60px; text-align: center; }

/* empty placeholder */
.adm-login-review-page .lrr-empty,
.adm-login-review-page .lrr-empty-cell { padding: 16px; text-align: center; color: #94a3b8; }
.adm-login-review-page .adm-is-hidden { display: none !important; }

@media (max-width: 1080px) {
    .adm-login-review-page .adm-login-review-filterbar { flex-wrap: wrap; }
    .adm-login-review-page .lrr-controlbar { flex-direction: column; align-items: stretch; }
    .adm-login-review-page .lrr-bulkbar { flex-wrap: wrap; }
    .adm-login-review-page .lrr-view-tools { justify-content: flex-end; }
}
</style>

<%@ include file="../layout-close.jsp" %>
