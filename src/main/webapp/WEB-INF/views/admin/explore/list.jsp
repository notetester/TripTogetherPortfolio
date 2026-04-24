<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="explore"/>
<spring:message code="admin.explore.list.pageTitle" var="adminExploreListPageTitle"/>
<c:set var="pageTitle" value="${adminExploreListPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-admin-tabs">
        <a class="adm-tab active" href="${pageContext.request.contextPath}/admin/explore">
            <spring:message code="admin.explore.tabs.spots"/>
        </a>
        <a class="adm-tab" href="${pageContext.request.contextPath}/admin/explore/reviews">
            <spring:message code="admin.explore.tabs.reviews"/>
        </a>
    </div>

    <div class="adm-summary-grid">
        <div class="adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.explore.kpi.totalSpots"/></div>
            <div class="adm-summary-value">${stats.totalSpots}</div>
            <div class="adm-summary-sub">
                <spring:message code="admin.explore.kpi.activeSpots" arguments="${stats.activeSpots}"/>
            </div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.explore.kpi.deletedSpots"/></div>
            <div class="adm-summary-value">${stats.deletedSpots}</div>
            <div class="adm-summary-sub"><spring:message code="admin.explore.kpi.deletedSpotsSub"/></div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.explore.kpi.totalReviews"/></div>
            <div class="adm-summary-value">${stats.totalReviews}</div>
            <div class="adm-summary-sub">
                <spring:message code="admin.explore.kpi.activeReviews" arguments="${stats.activeReviews}"/>
            </div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.explore.kpi.blockedReviews"/></div>
            <div class="adm-summary-value">${stats.blockedReviews}</div>
            <div class="adm-summary-sub"><spring:message code="admin.explore.kpi.blockedReviewsSub"/></div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/explore">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.explore.filter.status"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="ACTIVE" ${search.status=='ACTIVE'?'selected':''}><spring:message code="admin.explore.status.active"/></option>
                            <option value="DELETED" ${search.status=='DELETED'?'selected':''}><spring:message code="admin.explore.status.deleted"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.explore.filter.sort"/></div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt" ${search.sortBy=='createdAt'?'selected':''}><spring:message code="admin.explore.sort.createdAt"/></option>
                            <option value="reviewCount" ${search.sortBy=='reviewCount'?'selected':''}><spring:message code="admin.explore.sort.reviewCount"/></option>
                            <option value="likeCount" ${search.sortBy=='likeCount'?'selected':''}><spring:message code="admin.explore.sort.likeCount"/></option>
                            <option value="ratingAvg" ${search.sortBy=='ratingAvg'?'selected':''}><spring:message code="admin.explore.sort.ratingAvg"/></option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label"><spring:message code="admin.explore.filter.search"/></div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:120px;">
                                <option value="all" ${search.searchType=='all'?'selected':''}><spring:message code="admin.common.all"/></option>
                                <option value="name" ${search.searchType=='name'?'selected':''}><spring:message code="admin.explore.searchType.name"/></option>
                                <option value="region" ${search.searchType=='region'?'selected':''}><spring:message code="admin.explore.searchType.region"/></option>
                                <option value="address" ${search.searchType=='address'?'selected':''}><spring:message code="admin.explore.searchType.address"/></option>
                                <option value="description" ${search.searchType=='description'?'selected':''}><spring:message code="admin.explore.searchType.description"/></option>
                                <option value="nickname" ${search.searchType=='nickname'?'selected':''}><spring:message code="admin.explore.searchType.nickname"/></option>
                                <option value="userId" ${search.searchType=='userId'?'selected':''}><spring:message code="admin.explore.searchType.userId"/></option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="<spring:message code='admin.explore.filter.searchPlaceholder'/>" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore"><spring:message code="admin.common.reset"/></a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title"><spring:message code="admin.explore.list.title"/></div>
                <div class="adm-muted-inline"><spring:message code="admin.common.totalCount" arguments="${total}"/></div>
            </div>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" class="adm-muted-inline"></span>
                <button class="adm-btn adm-btn-ghost" type="button" onclick="bulkAction('delete')"><spring:message code="admin.explore.action.bulkDelete"/></button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:70px;"><spring:message code="admin.common.id"/></th>
                    <th style="width:84px;"><spring:message code="admin.explore.table.image"/></th>
                    <th><spring:message code="admin.explore.table.spot"/></th>
                    <th style="width:120px;"><spring:message code="admin.explore.table.author"/></th>
                    <th style="width:130px;"><spring:message code="admin.explore.table.region"/></th>
                    <th style="width:80px;"><spring:message code="admin.explore.table.rating"/></th>
                    <th style="width:70px;"><spring:message code="admin.explore.table.reviews"/></th>
                    <th style="width:70px;"><spring:message code="admin.explore.table.likes"/></th>
                    <th style="width:80px;"><spring:message code="admin.common.status"/></th>
                    <th style="width:140px;"><spring:message code="admin.common.action"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="spot">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${spot.spotIdx}"></td>
                        <td class="adm-muted-inline">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}">#${spot.spotIdx}</a>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty spot.thumbUrl}">
                                    <img src="${spot.thumbUrl}" alt="${fn:escapeXml(spot.name)}" style="width:56px;height:56px;object-fit:cover;border-radius:8px;border:1px solid #cbd5e1;">
                                </c:when>
                                <c:otherwise>
                                    <div class="adm-image-placeholder" style="width:56px;height:56px;border-radius:8px;display:flex;align-items:center;justify-content:center;">
                                        <spring:message code="admin.explore.noImage"/>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:url var="spotReviewsManageUrl" value="/admin/explore/reviews">
                                <c:param name="searchType" value="name"/>
                                <c:param name="keyword" value="${spot.name}"/>
                            </c:url>
                            <a href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}" class="adm-link-title" style="font-weight:600;">${fn:escapeXml(spot.name)}</a>
                            <a class="adm-cell-link adm-cell-link--inline adm-cell-ellipsis"
                               href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}"
                               style="font-size:11px;color:#64748b;margin-top:4px;max-width:260px;">${fn:escapeXml(spot.address)}</a>
                            <div class="adm-inline-actions">
                                <a href="${pageContext.request.contextPath}/detail/${spot.spotIdx}" target="_blank" class="adm-inline-chip"><spring:message code="admin.explore.detail.userView"/></a>
                                <a href="${pageContext.request.contextPath}${spotReviewsManageUrl}" class="adm-inline-chip"><spring:message code="admin.explore.detail.reviewsManageAll"/></a>
                            </div>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-inline-link js-open-member-context"
                                    data-user-idx="${spot.userIdx}"
                                    style="font-size:13px;font-weight:700;color:#93c5fd;">
                                ${fn:escapeXml(spot.nickname)}
                            </button>
                            <div class="adm-muted-inline">
                                <button type="button"
                                        class="adm-inline-link js-open-member-context"
                                        data-user-idx="${spot.userIdx}"
                                        style="font-size:12px;color:#94a3b8;">
                                    ${fn:escapeXml(spot.userId)}
                                </button>
                            </div>
                        </td>
                        <td class="adm-muted-inline">
                            <c:url var="spotRegionSearchUrl" value="/admin/explore">
                                <c:param name="searchType" value="region"/>
                                <c:param name="keyword" value="${spot.region}"/>
                            </c:url>
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}${spotRegionSearchUrl}">${fn:escapeXml(spot.region)}</a>
                        </td>
                        <td style="font-size:12px;color:#d97706;font-weight:700;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}${spotReviewsManageUrl}"><fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/></a>
                        </td>
                        <td class="adm-muted-inline">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}${spotReviewsManageUrl}">${spot.reviewCount}</a>
                        </td>
                        <td class="adm-muted-inline">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}">${spot.likeCount}</a>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}?edit=true"
                               class="adm-cell-link adm-cell-link--inline status-badge ${spot.displayStatus}">
                                <c:choose>
                                    <c:when test="${spot.displayStatus == 'ACTIVE'}"><spring:message code="admin.explore.status.active"/></c:when>
                                    <c:otherwise><spring:message code="admin.explore.status.deleted"/></c:otherwise>
                                </c:choose>
                            </a>
                        </td>
                        <td>
                            <div class="adm-row-actions">
                                <a class="adm-row-btn detail" href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}?edit=true"><spring:message code="admin.common.edit"/></a>
                                <c:if test="${spot.displayStatus != 'DELETED'}">
                                    <div class="action-menu-wrap">
                                        <button class="adm-row-btn detail adm-row-btn-more"
                                                type="button"
                                                onclick="admToggleActionMenu(this)">⋯</button>
                                        <div class="action-menu">
                                            <button class="action-menu-item danger"
                                                    type="button"
                                                    data-id="${spot.spotIdx}"
                                                    onclick="actionSpot(this, 'delete')"><spring:message code="admin.common.delete"/></button>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="11" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.explore.list.empty"/></td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}">
                    <button class="adm-page-btn" type="button" onclick="goPage(${paging.startPage - 1})"><spring:message code="admin.common.previous"/></button>
                </c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pg">
                    <button class="adm-page-btn ${pg == paging.currentPage ? 'active' : ''}" type="button" onclick="goPage(${pg})">${pg}</button>
                </c:forEach>
                <c:if test="${paging.next}">
                    <button class="adm-page-btn" type="button" onclick="goPage(${paging.endPage + 1})"><spring:message code="admin.common.next"/></button>
                </c:if>
                <span class="adm-page-info"><spring:message code="admin.common.pageStatus" arguments="${paging.currentPage},${paging.totalPage}"/></span>
            </div>
        </c:if>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var EXPLORE_LIST_MSG = {
    bulkSelectedTemplate: '<spring:message code="admin.explore.bulk.selected" arguments="__COUNT__" javaScriptEscape="true"/>',
    confirmDeleteOne: '<spring:message code="admin.explore.confirm.deleteOne" arguments="__ID__" javaScriptEscape="true"/>',
    confirmDeleteBulk: '<spring:message code="admin.explore.confirm.deleteBulk" arguments="__COUNT__" javaScriptEscape="true"/>',
    requestFailed: '<spring:message code="admin.explore.error.requestFailed" javaScriptEscape="true"/>',
    noSelection: '<spring:message code="admin.explore.error.noSelection" javaScriptEscape="true"/>'
};

document.getElementById('checkAll').addEventListener('change', function() {
    document.querySelectorAll('.row-check').forEach(function(cb) {
        cb.checked = document.getElementById('checkAll').checked;
    });
    updateBulkBar();
});

document.querySelectorAll('.row-check').forEach(function(cb) {
    cb.addEventListener('change', updateBulkBar);
});

function updateBulkBar() {
    var checked = document.querySelectorAll('.row-check:checked');
    var bar = document.getElementById('bulkBar');
    if (checked.length > 0) {
        bar.style.display = 'flex';
        document.getElementById('bulkCount').textContent = EXPLORE_LIST_MSG.bulkSelectedTemplate.replace('__COUNT__', checked.length);
    } else {
        bar.style.display = 'none';
    }
}

function actionSpot(button, action) {
    var spotIdx = button.getAttribute('data-id');
    if (!confirm(EXPLORE_LIST_MSG.confirmDeleteOne.replace('__ID__', spotIdx))) return;
    fetch(ctx + '/admin/explore/spots/' + spotIdx + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function(r) {
        return r.json();
    }).then(function(d) {
        if (d.success) {
            location.reload();
        } else {
            alert(d.message || EXPLORE_LIST_MSG.requestFailed);
        }
    });
}

function bulkAction(action) {
    var ids = Array.from(document.querySelectorAll('.row-check:checked')).map(function(cb) {
        return cb.getAttribute('data-id');
    });
    if (ids.length === 0) {
        alert(EXPLORE_LIST_MSG.noSelection);
        return;
    }
    if (!confirm(EXPLORE_LIST_MSG.confirmDeleteBulk.replace('__COUNT__', ids.length))) return;

    var body = 'action=' + action + '&' + ids.map(function(id) {
        return 'ids=' + id;
    }).join('&');

    fetch(ctx + '/admin/explore/spots/bulk-action', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: body
    }).then(function(r) {
        return r.json();
    }).then(function(d) {
        if (d.success) {
            location.reload();
        } else {
            alert(d.message || EXPLORE_LIST_MSG.requestFailed);
        }
    });
}

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = ctx + '/admin/explore?' + params.toString();
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
            '<div class="adm-local-toolbar-group adm-unified-export">'
            + '<div class="adm-export-control">'
            + '<select class="adm-select js-op-export-format"><option value="csv">CSV</option><option value="excel">Excel</option></select>'
            + '<div class="adm-export-menu">'
            + '<button type="button" class="adm-btn adm-btn-ghost js-export-toggle">⬇ 내보내기 ▾</button>'
            + '<div class="adm-export-dropdown">'
            + '<button type="button" class="js-op-export" data-scope="all">📋 전체 내보내기</button>'
            + '<button type="button" class="js-op-export" data-scope="search">🔍 현재 검색 내보내기</button>'
            + '<button type="button" class="js-op-export-selected" data-scope="selected" disabled>☑ 선택 내보내기 (0)</button>'
            + '</div></div></div>'
            + '<button type="button" class="adm-btn adm-btn-ghost js-op-clear-selection" style="display:none;">선택 해제</button>'
            + '</div>';
        wrap.parentElement.insertBefore(toolbar, wrap);

        const headRow = table.querySelector('thead tr');
        if (headRow && !headRow.querySelector('.js-op-check-all')) {
            const th = document.createElement('th');
            th.style.width = '42px';
            th.style.textAlign = 'center';
            th.innerHTML = '<input type="checkbox" class="js-op-check-all adm-check">';
            headRow.insertBefore(th, headRow.firstElementChild);
        }

        table.querySelectorAll('tbody tr').forEach(function (row) {
            if (row.children.length === 1 && row.children[0].hasAttribute('colspan')) return;
            if (row.querySelector('.js-op-row-check')) return;
            const td = document.createElement('td');
            td.style.textAlign = 'center';
            td.innerHTML = '<input type="checkbox" class="js-op-row-check adm-check">';
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

