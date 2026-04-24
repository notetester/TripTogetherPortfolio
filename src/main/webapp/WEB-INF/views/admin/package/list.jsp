<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="packages"/>
<spring:message code="package.admin.title" var="adminPackagesPageTitle"/>
<c:set var="pageTitle"  value="${adminPackagesPageTitle}"/>
<spring:message code="package.revision.rejectReason" var="revisionRejectReasonPlaceholder"/>
<spring:message code="package.admin.approveConfirm" var="packageApproveConfirm"/>
<spring:message code="package.admin.rejectPlaceholder" var="packageRejectPlaceholder"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="package.admin.title"/></h1>
            <p><spring:message code="package.admin.desc"/></p>
        </div>
    </div>

    <c:if test="${not empty packageReviewMessage}">
        <div class="adm-alert adm-alert-success">${fn:escapeXml(packageReviewMessage)}</div>
    </c:if>
    <c:if test="${not empty packageReviewError}">
        <div class="adm-alert adm-alert-danger">${fn:escapeXml(packageReviewError)}</div>
    </c:if>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/packages">
                <div class="adm-filter-bar">
                    <div>
                        <div class="adm-filter-label"><spring:message code="package.admin.filterStatus"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${status eq 'ALL' ? 'selected' : ''}><spring:message code="package.admin.filterAll"/></option>
                            <option value="PENDING" ${status eq 'PENDING' ? 'selected' : ''}><spring:message code="package.status.pending"/></option>
                            <option value="APPROVED" ${status eq 'APPROVED' ? 'selected' : ''}><spring:message code="package.status.approved"/></option>
                            <option value="REJECTED" ${status eq 'REJECTED' ? 'selected' : ''}><spring:message code="package.status.rejected"/></option>
                            <option value="DRAFT" ${status eq 'DRAFT' ? 'selected' : ''}><spring:message code="package.status.draft"/></option>
                            <option value="BLOCKED" ${status eq 'BLOCKED' ? 'selected' : ''}><spring:message code="package.status.blocked"/></option>
                        </select>
                    </div>
                    <div style="display:flex;gap:6px;align-items:flex-end;">
                        <button type="submit" class="adm-btn adm-btn-primary"><spring:message code="package.admin.search"/></button>
                        <a href="${pageContext.request.contextPath}/admin/packages"
                           class="adm-btn adm-btn-ghost"><spring:message code="package.admin.reset"/></a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div style="display:flex;justify-content:space-between;gap:14px;align-items:flex-start;margin-bottom:14px;">
                <div>
                    <h2 style="margin:0;color:#e2e8f0;font-size:18px;"><spring:message code="package.revision.adminTitle"/></h2>
                    <p style="margin:6px 0 0;color:#94a3b8;font-size:13px;"><spring:message code="package.revision.adminDesc"/></p>
                </div>
                <span class="status-badge PENDING"><spring:message code="package.status.pending"/></span>
            </div>

            <c:choose>
                <c:when test="${empty revisionList}">
                    <div style="padding:24px;border:1px dashed rgba(148,163,184,.32);border-radius:14px;color:#64748b;text-align:center;">
                        <spring:message code="package.revision.empty"/>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="adm-table-wrap">
                        <table class="adm-table">
                            <thead>
                            <tr>
                                <th><spring:message code="package.revision.beforeAfter"/></th>
                                <th><spring:message code="package.revision.sellerSpot"/></th>
                                <th><spring:message code="package.revision.pricePeriod"/></th>
                                <th><spring:message code="package.revision.requestedAt"/></th>
                                <th><spring:message code="package.revision.review"/></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="revision" items="${revisionList}">
                                <tr>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link"
                                                onclick="focusPackageReviewAction('revision-${revision.packageRevisionIdx}')">
                                            <span style="font-size:12px;color:#94a3b8;"><spring:message code="package.revision.current"/></span>
                                            <span style="font-weight:800;color:#e2e8f0;">${fn:escapeXml(revision.currentPackageTitle)}</span>
                                            <span style="font-size:12px;color:#38bdf8;margin-top:6px;"><spring:message code="package.revision.requested"/></span>
                                            <span style="font-weight:800;color:#e2e8f0;">${fn:escapeXml(revision.packageTitle)}</span>
                                            <c:if test="${not empty revision.packageSummary}">
                                                <span style="font-size:12px;color:#94a3b8;margin-top:4px;max-width:420px;">
                                                    ${fn:escapeXml(revision.packageSummary)}
                                                </span>
                                            </c:if>
                                        </button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link js-open-member-context"
                                                data-user-idx="${revision.sellerUserIdx}"
                                                data-default-tab="profile">
                                            <span class="mem-name">${fn:escapeXml(revision.sellerNickname)}</span>
                                            <span class="mem-uid">user_idx ${revision.sellerUserIdx}</span>
                                            <span style="font-size:12px;color:#94a3b8;margin-top:8px;">
                                                ${fn:escapeXml(revision.spotRegion)} · ${fn:escapeXml(revision.spotName)}
                                            </span>
                                        </button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link"
                                                onclick="focusPackageReviewAction('revision-${revision.packageRevisionIdx}')">
                                            <span style="font-weight:800;color:#e2e8f0;">
                                                <fmt:formatNumber value="${revision.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(revision.currencyCode)}
                                            </span>
                                            <span style="font-size:12px;color:#94a3b8;margin-top:4px;">
                                                <c:choose>
                                                    <c:when test="${not empty revision.startDate or not empty revision.endDate}">
                                                        ${revision.startDate} ~ ${revision.endDate}
                                                    </c:when>
                                                    <c:otherwise><spring:message code="package.common.always"/></c:otherwise>
                                                </c:choose>
                                            </span>
                                            <span style="font-size:12px;color:#94a3b8;">
                                                <spring:message code="package.common.minPeople" arguments="${revision.minPeople}"/>
                                                <c:if test="${not empty revision.maxPeople}">
                                                    / <spring:message code="package.common.maxPeople" arguments="${revision.maxPeople}"/>
                                                </c:if>
                                            </span>
                                        </button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                onclick="focusPackageReviewAction('revision-${revision.packageRevisionIdx}')">
                                            ${revision.requestedAt}
                                        </button>
                                    </td>
                                    <td>
                                        <div class="adm-row-actions" id="package-action-revision-${revision.packageRevisionIdx}">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/packages/revisions/${revision.packageRevisionIdx}/approve">
                                                <button type="submit" class="adm-row-btn detail">
                                                    <spring:message code="package.revision.approve"/>
                                                </button>
                                            </form>
                                            <div class="action-menu-wrap">
                                                <button type="button"
                                                        class="adm-row-btn detail adm-row-btn-more"
                                                        onclick="admToggleActionMenu(this)">⋯</button>
                                                <div class="action-menu action-menu-wide">
                                                    <form class="action-menu-form"
                                                          method="post"
                                                          action="${pageContext.request.contextPath}/admin/packages/revisions/${revision.packageRevisionIdx}/reject">
                                                        <label class="action-menu-head" for="revision-reject-${revision.packageRevisionIdx}">
                                                            <spring:message code="package.revision.reject"/>
                                                        </label>
                                                        <input id="revision-reject-${revision.packageRevisionIdx}"
                                                               class="adm-input"
                                                               name="rejectReason"
                                                               maxlength="500"
                                                               placeholder="${revisionRejectReasonPlaceholder}"
                                                               required>
                                                        <button type="submit" class="action-menu-item danger">
                                                            <spring:message code="package.revision.reject"/>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th><spring:message code="package.admin.thPackage"/></th>
                    <th><spring:message code="package.admin.thSeller"/></th>
                    <th><spring:message code="package.admin.thSpot"/></th>
                    <th><spring:message code="package.admin.thPriceSchedule"/></th>
                    <th><spring:message code="package.admin.thStatus"/></th>
                    <th><spring:message code="package.admin.thReview"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="pkg" items="${packageList}">
                    <tr>
                        <td>
                            <div style="display:flex;gap:12px;align-items:flex-start;min-width:280px;">
                                <div style="width:82px;height:58px;border-radius:10px;overflow:hidden;background:#1e293b;flex:0 0 auto;">
                                    <c:choose>
                                        <c:when test="${not empty pkg.mainImagePath}">
                                            <img src="${fn:escapeXml(pkg.mainImagePath)}"
                                                 alt="${fn:escapeXml(pkg.packageTitle)}"
                                                 style="width:100%;height:100%;object-fit:cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="height:100%;display:grid;place-items:center;color:#94a3b8;font-size:11px;font-weight:800;"><spring:message code="package.admin.noImage"/></div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <button type="button"
                                            class="adm-cell-link adm-cell-link--inline"
                                            onclick="focusPackageReviewAction('package-${pkg.packageIdx}')">
                                        <span style="font-weight:800;">${fn:escapeXml(pkg.packageTitle)}</span>
                                    </button>
                                    <c:if test="${not empty pkg.packageSummary}">
                                        <div style="font-size:12px;color:#94a3b8;margin-top:4px;max-width:420px;">
                                            ${fn:escapeXml(pkg.packageSummary)}
                                        </div>
                                    </c:if>
                                    <div style="font-size:11px;color:#64748b;margin-top:4px;"><spring:message code="package.admin.registeredAt" arguments="${pkg.createdAt}"/></div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-open-member-context"
                                    data-user-idx="${pkg.sellerUserIdx}"
                                    data-default-tab="profile">
                                <span class="mem-name">${fn:escapeXml(pkg.sellerNickname)}</span>
                                <span class="mem-uid">user_idx ${pkg.sellerUserIdx}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link"
                                    onclick="focusPackageReviewAction('package-${pkg.packageIdx}')">
                                <span style="font-weight:700;color:#e2e8f0;">${fn:escapeXml(pkg.spotName)}</span>
                                <span style="font-size:12px;color:#94a3b8;">${fn:escapeXml(pkg.spotRegion)}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link"
                                    onclick="focusPackageReviewAction('package-${pkg.packageIdx}')">
                                <span style="font-weight:800;color:#e2e8f0;">
                                    <fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(pkg.currencyCode)}
                                </span>
                                <span style="font-size:12px;color:#94a3b8;margin-top:4px;">
                                    <c:choose>
                                        <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">
                                            ${pkg.startDate} ~ ${pkg.endDate}
                                        </c:when>
                                        <c:otherwise><spring:message code="package.common.always"/></c:otherwise>
                                    </c:choose>
                                </span>
                                <span style="font-size:12px;color:#94a3b8;">
                                    <spring:message code="package.common.minPeople" arguments="${pkg.minPeople}"/>
                                    <c:if test="${not empty pkg.maxPeople}"> / <spring:message code="package.common.maxPeople" arguments="${pkg.maxPeople}"/></c:if>
                                </span>
                            </button>
                        </td>
                        <td>
                            <c:set var="displayStatusClass" value="${pkg.packageStatus}"/>
                            <c:if test="${pkg.packageStatus eq 'APPROVED' and pkg.expired}">
                                <c:set var="displayStatusClass" value="EXPIRED"/>
                            </c:if>
                            <button type="button"
                                    class="adm-cell-link adm-cell-link--inline"
                                    onclick="focusPackageReviewAction('package-${pkg.packageIdx}')">
                                <span class="status-badge ${displayStatusClass}">
                                    <c:choose>
                                        <c:when test="${displayStatusClass eq 'EXPIRED'}"><spring:message code="package.status.expired"/></c:when>
                                        <c:when test="${displayStatusClass eq 'PENDING'}"><spring:message code="package.status.pending"/></c:when>
                                        <c:when test="${displayStatusClass eq 'APPROVED'}"><spring:message code="package.status.approved"/></c:when>
                                        <c:when test="${displayStatusClass eq 'REJECTED'}"><spring:message code="package.status.rejected"/></c:when>
                                        <c:when test="${displayStatusClass eq 'DRAFT'}"><spring:message code="package.status.draft"/></c:when>
                                        <c:when test="${displayStatusClass eq 'BLOCKED'}"><spring:message code="package.status.blocked"/></c:when>
                                        <c:otherwise>${fn:escapeXml(pkg.packageStatus)}</c:otherwise>
                                    </c:choose>
                                </span>
                            </button>
                            <c:if test="${pkg.packageStatus eq 'APPROVED' and pkg.expired}">
                                <div style="font-size:11px;color:#fbbf24;margin-top:6px;max-width:240px;">
                                    <spring:message code="package.manage.expiredHidden"/>
                                </div>
                            </c:if>
                            <c:if test="${not empty pkg.rejectReason}">
                                <div style="font-size:11px;color:#fca5a5;margin-top:6px;max-width:240px;">
                                    ${fn:escapeXml(pkg.rejectReason)}
                                </div>
                            </c:if>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${pkg.packageStatus eq 'PENDING'}">
                                    <div class="adm-row-actions" id="package-action-package-${pkg.packageIdx}">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/packages/${pkg.packageIdx}/approve">
                                                <button type="submit" class="adm-row-btn detail"
                                                    onclick="return confirm('<spring:message code="admin.packages.confirmApprove" javaScriptEscape="true"/>');"><spring:message code="package.admin.approve"/></button>
                                            </form>
                                        <div class="action-menu-wrap">
                                            <button type="button"
                                                    class="adm-row-btn detail adm-row-btn-more"
                                                    onclick="admToggleActionMenu(this)">⋯</button>
                                            <div class="action-menu action-menu-wide">
                                                <form class="action-menu-form"
                                                      method="post"
                                                      action="${pageContext.request.contextPath}/admin/packages/${pkg.packageIdx}/reject">
                                                    <label class="action-menu-head" for="package-reject-${pkg.packageIdx}">
                                                        <spring:message code="package.admin.reject"/>
                                                    </label>
                                                    <input id="package-reject-${pkg.packageIdx}"
                                                           class="adm-input"
                                                           name="rejectReason"
                                                           maxlength="500"
                                                           placeholder="<spring:message code='admin.packages.rejectReasonPlaceholder'/>"
                                                           required>
                                                    <button type="submit" class="action-menu-item danger">
                                                        <spring:message code="package.admin.reject"/>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#64748b;font-size:12px;"><spring:message code="package.admin.notPending"/></span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty packageList}">
                    <tr>
                        <td colspan="6" style="text-align:center;padding:40px;color:#64748b;">
                            <spring:message code="package.admin.noResults"/>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
function focusPackageReviewAction(key) {
    var target = document.getElementById('package-action-' + key);
    if (!target) return;
    target.scrollIntoView({ behavior: 'smooth', block: 'center' });
    target.classList.remove('is-focus-flash');
    void target.offsetWidth;
    target.classList.add('is-focus-flash');
    setTimeout(function () {
        target.classList.remove('is-focus-flash');
    }, 1300);
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

