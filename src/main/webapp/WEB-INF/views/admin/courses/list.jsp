<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="courses"/>
<spring:message code="admin.courses.list.pageTitle" var="pageTitle"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.courses.list.summary.active"/></div>
            <div class="adm-summary-value is-primary">${stats.activePlans}</div>
            <div class="adm-summary-sub"><spring:message code="admin.courses.list.summary.total"/> ${stats.totalPlans}<spring:message code="admin.common.countSuffix"/></div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.courses.list.summary.deleted"/></div>
            <div class="adm-summary-value is-danger">${stats.deletedPlans}</div>
            <div class="adm-summary-sub"><spring:message code="admin.courses.list.summary.today"/> ${stats.todayPlans}<spring:message code="admin.common.countSuffix"/></div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.courses.list.summary.ai"/></div>
            <div class="adm-summary-value is-success">${stats.aiPlans}</div>
            <div class="adm-summary-sub"><spring:message code="admin.courses.list.summary.manual"/> ${stats.manualPlans}<spring:message code="admin.common.countSuffix"/></div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.courses.list.summary.public"/></div>
            <div class="adm-summary-value is-warning">${stats.publicPlans}</div>
            <div class="adm-summary-sub"><spring:message code="admin.courses.list.summary.private"/> ${stats.privatePlans}<spring:message code="admin.common.countSuffix"/></div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/courses" id="searchForm">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.list.filter.status"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ?'selected':''}><spring:message code="admin.common.active"/></option>
                            <option value="DELETED" ${search.status=='DELETED' ?'selected':''}><spring:message code="admin.courses.status.deleted"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.list.filter.source"/></div>
                        <select class="adm-select" name="planSource">
                            <option value="ALL"    ${search.planSource=='ALL'    ?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="MANUAL" ${search.planSource=='MANUAL' ?'selected':''}><spring:message code="admin.courses.source.manual"/></option>
                            <option value="AI"     ${search.planSource=='AI'     ?'selected':''}><spring:message code="admin.courses.source.ai"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.list.filter.visibility"/></div>
                        <select class="adm-select" name="isPublic">
                            <option value="ALL"     ${search.isPublic=='ALL'     ?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="PUBLIC"  ${search.isPublic=='PUBLIC'  ?'selected':''}><spring:message code="admin.courses.visibility.public"/></option>
                            <option value="PRIVATE" ${search.isPublic=='PRIVATE' ?'selected':''}><spring:message code="admin.courses.visibility.private"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.list.filter.sort"/></div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt" ${search.sortBy=='createdAt' ?'selected':''}><spring:message code="admin.courses.list.sort.createdAt"/></option>
                            <option value="updatedAt" ${search.sortBy=='updatedAt' ?'selected':''}><spring:message code="admin.courses.list.sort.updatedAt"/></option>
                            <option value="startDate" ${search.sortBy=='startDate' ?'selected':''}><spring:message code="admin.courses.list.sort.startDate"/></option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label"><spring:message code="admin.common.search"/></div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:120px;">
                                <option value="all"         ${search.searchType=='all'         ?'selected':''}><spring:message code="admin.common.all"/></option>
                                <option value="title"       ${search.searchType=='title'       ?'selected':''}><spring:message code="admin.courses.list.search.title"/></option>
                                <option value="destination" ${search.searchType=='destination' ?'selected':''}><spring:message code="admin.courses.list.search.destination"/></option>
                                <option value="nickname"    ${search.searchType=='nickname'    ?'selected':''}><spring:message code="admin.common.nickname"/></option>
                                <option value="userId"      ${search.searchType=='userId'      ?'selected':''}><spring:message code="admin.common.userId"/></option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(search.keyword)}"
                                   placeholder="<spring:message code='admin.courses.list.filter.keywordPlaceholder'/>" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.search"/></button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/courses"><spring:message code="admin.common.reset"/></a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title"><spring:message code="admin.courses.list.title"/></div>
                <div class="adm-muted-note"><spring:message code="admin.courses.list.total"/> ${total}<spring:message code="admin.common.countSuffix"/></div>
            </div>
            <%-- 일괄 처리 버튼 --%>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" style="font-size:12px;color:#94a3b8;"></span>
                <button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;"
                        onclick="bulkAction('delete')"><spring:message code="admin.courses.list.action.bulkDelete"/></button>
                <button class="adm-btn adm-btn-ghost" style="color:#34d399;border-color:#34d399;"
                        onclick="bulkAction('restore')"><spring:message code="admin.courses.list.action.bulkRestore"/></button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:60px;">ID</th>
                    <th><spring:message code="admin.courses.list.table.author"/></th>
                    <th><spring:message code="admin.courses.list.table.title"/></th>
                    <th><spring:message code="admin.courses.list.table.destination"/></th>
                    <th style="width:120px;"><spring:message code="admin.courses.list.table.period"/></th>
                    <th style="width:50px;"><spring:message code="admin.courses.list.table.spots"/></th>
                    <th style="width:60px;"><spring:message code="admin.courses.list.table.source"/></th>
                    <th style="width:60px;"><spring:message code="admin.courses.list.table.visibility"/></th>
                    <th style="width:70px;"><spring:message code="admin.common.accountStatus"/></th>
                    <th style="width:90px;"><spring:message code="admin.courses.list.table.createdAt"/></th>
                    <th style="width:120px;"><spring:message code="admin.common.action"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="p">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${p.planId}"></td>
                        <td style="color:#64748b;font-size:12px;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">#${p.planId}</a>
                        </td>

                        <%-- 작성자 --%>
                        <td>
                            <button type="button"
                                    class="adm-inline-link js-open-member-context"
                                    data-user-idx="${p.userIdx}"
                                    style="font-weight:600;font-size:13px;color:#7dd3fc;">${p.nickname}</button>
                            <div>
                                <button type="button"
                                        class="adm-inline-link js-open-member-context"
                                        data-user-idx="${p.userIdx}"
                                        style="font-size:11px;color:#64748b;">${p.userId}</button>
                            </div>
                            <c:if test="${p.accountStatus == 'BLOCKED'}">
                                <span class="adm-inline-danger"><spring:message code="admin.courses.list.accountBlocked"/></span>
                            </c:if>
                        </td>

                        <%-- 제목 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/courses/${p.planId}"
                               class="adm-link-title" title="${p.title}">
                                <c:choose>
                                    <c:when test="${fn:length(p.title) > 24}">${fn:substring(p.title, 0, 24)}…</c:when>
                                    <c:otherwise>${p.title}</c:otherwise>
                                </c:choose>
                            </a>
                        </td>

                        <%-- 여행지 --%>
                        <td style="font-size:12px;color:#cbd5e1;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">
                            <c:choose>
                                <c:when test="${not empty p.destination}">${p.destination}</c:when>
                                <c:otherwise><span style="color:#475569;"><spring:message code="admin.common.dash"/></span></c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 일정 --%>
                        <td style="font-size:11px;color:#94a3b8;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">
                            <c:choose>
                                <c:when test="${not empty p.startDate}">
                                    <fmt:formatDate value="${p.startDate}" pattern="yyyy.MM.dd"/>
                                    <div>~ <fmt:formatDate value="${p.endDate}" pattern="MM.dd"/></div>
                                </c:when>
                                <c:otherwise><span style="color:#475569;"><spring:message code="admin.common.dash"/></span></c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 스팟 수 --%>
                        <td style="text-align:center;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">
                            <c:choose>
                                <c:when test="${p.spotCount > 0}">
                                    <span style="color:#7dd3fc;font-weight:600;">${p.spotCount}</span>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">0</span></c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 유형 --%>
                        <td style="font-size:12px;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">
                            <c:choose>
                                <c:when test="${p.planSource == 'AI'}">
                                    <span style="color:#a78bfa;font-weight:600;"><spring:message code="admin.courses.source.ai"/></span>
                                </c:when>
                                <c:when test="${p.planSource == 'MANUAL'}">
                                    <span style="color:#94a3b8;"><spring:message code="admin.courses.source.manual"/></span>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">${p.planSource}</span></c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 공개 --%>
                        <td style="font-size:12px;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">
                            <c:choose>
                                <c:when test="${p.isPublic == 1}">
                                    <span style="color:#34d399;"><spring:message code="admin.courses.visibility.public"/></span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#64748b;"><spring:message code="admin.courses.visibility.private"/></span>
                                </c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 상태 --%>
                        <td>
                            <c:choose>
                                <c:when test="${p.isDeleted == 0}">
                                    <a href="${pageContext.request.contextPath}/admin/courses/${p.planId}"
                                       class="adm-cell-link adm-cell-link--inline status-badge ACTIVE"><spring:message code="admin.common.active"/></a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/courses/${p.planId}"
                                       class="adm-cell-link adm-cell-link--inline status-badge DELETED"><spring:message code="admin.courses.status.deleted"/></a>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 등록일 --%>
                        <td style="font-size:11px;color:#64748b;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">
                            <fmt:formatDate value="${p.createdAt}" pattern="yyyy.MM.dd"/>
                            <div><fmt:formatDate value="${p.createdAt}" pattern="HH:mm"/></div>
                            </a>
                        </td>

                        <%-- 액션 --%>
                        <td>
                            <div class="adm-row-actions is-single">
                                <c:choose>
                                    <c:when test="${p.isDeleted == 0}">
                                        <button class="adm-row-btn danger"
                                                type="button"
                                                data-id="${p.planId}"
                                                onclick="actionPlan(this.getAttribute('data-id'), 'delete')"><spring:message code="admin.common.delete"/></button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="adm-row-btn success"
                                                type="button"
                                                data-id="${p.planId}"
                                                onclick="actionPlan(this.getAttribute('data-id'), 'restore')"><spring:message code="admin.common.restore"/></button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="12" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.courses.list.empty"/></td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <%-- 페이지네이션 --%>
        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}">
                    <button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button>
                </c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pg">
                    <button class="adm-page-btn ${pg == paging.currentPage ? 'active' : ''}" onclick="goPage(${pg})">${pg}</button>
                </c:forEach>
                <c:if test="${paging.next}">
                    <button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button>
                </c:if>
                <span class="adm-page-info">${paging.currentPage} / ${paging.totalPage}</span>
            </div>
        </c:if>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var COURSE_LIST_MESSAGES = {
    bulkSelected: '<spring:message code="admin.courses.list.js.bulkSelected" javaScriptEscape="true"/>',
    actionDelete: '<spring:message code="admin.common.delete" javaScriptEscape="true"/>',
    actionRestore: '<spring:message code="admin.common.restore" javaScriptEscape="true"/>',
    confirmSingle: '<spring:message code="admin.courses.list.js.confirmSingle" javaScriptEscape="true"/>',
    confirmBulk: '<spring:message code="admin.courses.list.js.confirmBulk" javaScriptEscape="true"/>',
    noSelection: '<spring:message code="admin.courses.list.js.noSelection" javaScriptEscape="true"/>',
    error: '<spring:message code="admin.common.processError" javaScriptEscape="true"/>'
};

function formatCourseListMessage(template) {
    var args = Array.prototype.slice.call(arguments, 1);
    return template.replace(/\{(\d+)\}/g, function (_, idx) {
        return typeof args[idx] !== 'undefined' ? args[idx] : '';
    });
}

// ── 전체 선택 ──
document.getElementById('checkAll').addEventListener('change', function () {
    document.querySelectorAll('.row-check').forEach(function (cb) { cb.checked = this.checked; }, this);
    updateBulkBar();
});
document.querySelectorAll('.row-check').forEach(function (cb) {
    cb.addEventListener('change', updateBulkBar);
});

function updateBulkBar() {
    var checked = document.querySelectorAll('.row-check:checked');
    var bar = document.getElementById('bulkBar');
    if (checked.length > 0) {
        bar.style.display = 'flex';
        document.getElementById('bulkCount').textContent = formatCourseListMessage(COURSE_LIST_MESSAGES.bulkSelected, checked.length);
    } else {
        bar.style.display = 'none';
    }
}

// ── 단건 액션 ──
function actionPlan(planId, action) {
    var label = action === 'delete' ? COURSE_LIST_MESSAGES.actionDelete : COURSE_LIST_MESSAGES.actionRestore;
    if (!confirm(formatCourseListMessage(COURSE_LIST_MESSAGES.confirmSingle, planId, label))) return;
    fetch(ctx + '/admin/courses/' + planId + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COURSE_LIST_MESSAGES.error); }
    });
}

// ── 일괄 처리 ──
function bulkAction(action) {
    var ids = Array.from(document.querySelectorAll('.row-check:checked'))
                   .map(function (cb) { return cb.getAttribute('data-id'); });
    if (ids.length === 0) { alert(COURSE_LIST_MESSAGES.noSelection); return; }
    var label = action === 'delete' ? COURSE_LIST_MESSAGES.actionDelete : COURSE_LIST_MESSAGES.actionRestore;
    if (!confirm(formatCourseListMessage(COURSE_LIST_MESSAGES.confirmBulk, ids.length, label))) return;

    var body = 'action=' + action + '&' + ids.map(function (id) { return 'ids=' + id; }).join('&');
    fetch(ctx + '/admin/courses/bulk-action', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: body
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COURSE_LIST_MESSAGES.error); }
    });
}

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = ctx + '/admin/courses?' + params.toString();
}
</script>

<%@ include file="../layout-close.jsp" %>


<script>
/* ── 공통 운영 탭: 헤더 클릭 정렬 + 체크박스 + CSV/Excel 내보내기 ── */
(function enhanceGenericAdminOperationTables() {
    const tables = Array.from(document.querySelectorAll('.adm-table'));
    if (!tables.length) return;

    function cleanText(el) {
        return (el && el.innerText ? el.innerText : '').replace(/[↕▲▼]/g, '').replace(/\s+/g, ' ').trim();
    }
    function rowsOf(table) {
        return Array.from(table.querySelectorAll('tbody tr')).filter(function (row) {
            return row.querySelector('.js-op-row-check');
        });
    }
    function selectedRowsOf(table) {
        return rowsOf(table).filter(function (row) {
            const cb = row.querySelector('.js-op-row-check');
            return cb && cb.checked;
        });
    }
    function csvEscape(value) {
        const s = String(value == null ? '' : value);
        return '"' + s.replace(/"/g, '""') + '"';
    }
    function download(content, filename, type) {
        const blob = new Blob([content], {type: type});
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = filename;
        document.body.appendChild(a);
        a.click();
        a.remove();
        setTimeout(function () { URL.revokeObjectURL(url); }, 1000);
    }
    function updateSelectionUi(table) {
        const wrap = table.closest('.adm-table-wrap') || table.parentElement;
        const selected = selectedRowsOf(table).length;
        const selectedBtn = wrap.parentElement.querySelector('.js-op-export-selected');
        const clearBtn = wrap.parentElement.querySelector('.js-op-clear-selection');
        const all = table.querySelector('.js-op-check-all');
        if (selectedBtn) {
            selectedBtn.disabled = selected === 0;
            selectedBtn.textContent = '선택 내보내기 (' + selected + ')';
        }
        if (clearBtn) clearBtn.style.display = selected > 0 ? '' : 'none';
        if (all) {
            const rows = rowsOf(table);
            all.checked = rows.length > 0 && selected === rows.length;
            all.indeterminate = selected > 0 && selected < rows.length;
        }
    }
    function exportTable(table, scope) {
        let exportRows = scope === 'selected' ? selectedRowsOf(table) : rowsOf(table);
        if (scope === 'selected' && exportRows.length === 0) {
            if (typeof adm_toast === 'function') adm_toast('선택된 항목이 없습니다.', 'error');
            else alert('선택된 항목이 없습니다.');
            return;
        }
        const wrap = table.closest('.adm-table-wrap') || table.parentElement;
        const formatSelect = wrap.parentElement.querySelector('.js-op-export-format');
        const format = formatSelect ? formatSelect.value : 'csv';
        const headers = Array.from(table.querySelectorAll('thead th'))
            .filter(function (_, idx, arr) { return idx !== 0 && idx !== arr.length - 1; })
            .map(cleanText);
        const body = exportRows.map(function (row) {
            return Array.from(row.children)
                .filter(function (_, idx, arr) { return idx !== 0 && idx !== arr.length - 1; })
                .map(cleanText);
        });
        const base = (document.title || 'admin_operation').replace(/[\\/:*?"<>|]+/g, '_') + '_' + scope + '_' + new Date().toISOString().slice(0, 10);
        if (format === 'excel') {
            const html = '<table><thead><tr>' + headers.map(h => '<th>' + h + '</th>').join('') + '</tr></thead><tbody>'
                + body.map(row => '<tr>' + row.map(v => '<td>' + v + '</td>').join('') + '</tr>').join('')
                + '</tbody></table>';
            download('\ufeff' + html, base + '.xls', 'application/vnd.ms-excel;charset=utf-8');
        } else {
            const csv = [headers].concat(body).map(row => row.map(csvEscape).join(',')).join('\n');
            download('\ufeff' + csv, base + '.csv', 'text/csv;charset=utf-8');
        }
    }
    function sortTable(table, colIndex, th) {
        const tbody = table.querySelector('tbody');
        const rows = rowsOf(table);
        const dir = th.dataset.sortDir === 'ASC' ? 'DESC' : 'ASC';
        th.closest('tr').querySelectorAll('th').forEach(function (h) {
            h.dataset.sortDir = '';
            const ico = h.querySelector('.sort-ico-generic');
            if (ico) ico.textContent = '↕';
        });
        th.dataset.sortDir = dir;
        const ico = th.querySelector('.sort-ico-generic');
        if (ico) ico.textContent = dir === 'ASC' ? '▲' : '▼';
        rows.sort(function (a, b) {
            const av = cleanText(a.children[colIndex]);
            const bv = cleanText(b.children[colIndex]);
            const an = Number(av.replace(/[^0-9.-]/g, ''));
            const bn = Number(bv.replace(/[^0-9.-]/g, ''));
            const bothNumeric = !Number.isNaN(an) && !Number.isNaN(bn) && /[0-9]/.test(av + bv);
            const result = bothNumeric ? (an - bn) : av.localeCompare(bv, undefined, {numeric: true, sensitivity: 'base'});
            return dir === 'ASC' ? result : -result;
        });
        rows.forEach(row => tbody.appendChild(row));
    }

    tables.forEach(function (table, tableIndex) {
        if (table.dataset.genericOperationEnhanced === 'true') return;
        table.dataset.genericOperationEnhanced = 'true';
        const wrap = table.closest('.adm-table-wrap') || table.parentElement;

        const toolbar = document.createElement('div');
        toolbar.className = 'adm-local-toolbar';
        toolbar.style.margin = '0 0 12px';
        toolbar.innerHTML =
            '<div class="adm-local-toolbar-group">'
            + '<select class="adm-select js-op-export-format" style="width:86px;"><option value="csv">CSV</option><option value="excel">Excel</option></select>'
            + '<button type="button" class="adm-btn adm-btn-ghost js-op-export" data-scope="all">전체 내보내기</button>'
            + '<button type="button" class="adm-btn adm-btn-ghost js-op-export" data-scope="search">현재 검색 내보내기</button>'
            + '<button type="button" class="adm-btn adm-btn-ghost js-op-export-selected" data-scope="selected" disabled>선택 내보내기 (0)</button>'
            + '<button type="button" class="adm-btn adm-btn-ghost js-op-clear-selection" style="display:none;">선택 해제</button>'
            + '</div>';
        wrap.parentElement.insertBefore(toolbar, wrap);

        const headRow = table.querySelector('thead tr');
        if (headRow && !headRow.querySelector('.js-op-check-all')) {
            const th = document.createElement('th');
            th.style.width = '42px';
            th.style.textAlign = 'center';
            th.innerHTML = '<input type="checkbox" class="js-op-check-all" style="cursor:pointer;">';
            headRow.insertBefore(th, headRow.firstElementChild);
        }

        table.querySelectorAll('tbody tr').forEach(function (row) {
            if (row.children.length === 1 && row.children[0].hasAttribute('colspan')) return;
            if (row.querySelector('.js-op-row-check')) return;
            const td = document.createElement('td');
            td.style.textAlign = 'center';
            td.innerHTML = '<input type="checkbox" class="js-op-row-check" style="cursor:pointer;">';
            row.insertBefore(td, row.firstElementChild);
        });

        Array.from(table.querySelectorAll('thead th')).forEach(function (th, idx, arr) {
            if (idx === 0 || idx === arr.length - 1 || th.querySelector('input')) return;
            if (!th.querySelector('.sort-ico-generic')) {
                th.style.cursor = 'pointer';
                th.style.userSelect = 'none';
                th.insertAdjacentHTML('beforeend', ' <span class="sort-ico-generic" style="font-size:10px;color:#94a3b8;">↕</span>');
                th.addEventListener('click', function () { sortTable(table, idx, th); });
            }
        });

        table.addEventListener('change', function (e) {
            if (e.target.matches('.js-op-check-all')) {
                rowsOf(table).forEach(row => row.querySelector('.js-op-row-check').checked = e.target.checked);
                updateSelectionUi(table);
            }
            if (e.target.matches('.js-op-row-check')) updateSelectionUi(table);
        });
        toolbar.addEventListener('click', function (e) {
            const exportBtn = e.target.closest('.js-op-export, .js-op-export-selected');
            if (exportBtn) {
                exportTable(table, exportBtn.dataset.scope || 'all');
                return;
            }
            const clearBtn = e.target.closest('.js-op-clear-selection');
            if (clearBtn) {
                rowsOf(table).forEach(row => row.querySelector('.js-op-row-check').checked = false);
                updateSelectionUi(table);
            }
        });
    });
})();
</script>

