<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="inquiries"/>
<spring:message code="admin.inquiry.pageTitle" var="adminInquiryPageTitle"/>
<spring:message code="admin.common.id" var="adminCommonId"/>
<c:set var="pageTitle" value="${adminInquiryPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.inquiry.kpi.total"/></div>
            <div class="adm-summary-value is-primary">${stats.totalInquiries}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.inquiry.status.pending"/></div>
            <div class="adm-summary-value is-warning">${stats.pendingInquiries}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.inquiry.status.inProgress"/></div>
            <div class="adm-summary-value is-accent">${stats.inProgressInquiries}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.inquiry.status.completed"/></div>
            <div class="adm-summary-value is-success">${stats.completedInquiries}</div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/inquiries">
                <div class="adm-filter-bar">
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.common.status"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL"              ${search.status=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="PENDING"          ${search.status=='PENDING'?'selected':''}><spring:message code="admin.inquiry.status.pending"/></option>
                            <option value="IN_PROGRESS"      ${search.status=='IN_PROGRESS'?'selected':''}><spring:message code="admin.inquiry.status.inProgress"/></option>
                            <option value="COMPLETED"        ${search.status=='COMPLETED'?'selected':''}><spring:message code="admin.inquiry.status.completed"/></option>
                            <option value="USER_COMPLETED"   ${search.status=='USER_COMPLETED'?'selected':''}><spring:message code="admin.inquiry.status.userCompleted"/></option>
                            <option value="CANCELLED"        ${search.status=='CANCELLED'?'selected':''}><spring:message code="admin.inquiry.status.cancelled"/></option>
                            <option value="DELETE_REQUESTED" ${search.status=='DELETE_REQUESTED'?'selected':''}><spring:message code="admin.inquiry.status.deleteRequested"/></option>
                            <option value="PRIVATE_REQUESTED"${search.status=='PRIVATE_REQUESTED'?'selected':''}><spring:message code="admin.inquiry.status.privateRequested"/></option>
                            <option value="PUBLIC_REQUESTED" ${search.status=='PUBLIC_REQUESTED'?'selected':''}><spring:message code="admin.inquiry.status.publicRequested"/></option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.inquiry.category"/></div>
                        <select class="adm-select" name="category">
                            <option value="ALL" ${search.category=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="service" ${search.category=='service'?'selected':''}><spring:message code="admin.inquiry.category.service"/></option>
                            <option value="payment" ${search.category=='payment'?'selected':''}><spring:message code="admin.inquiry.category.payment"/></option>
                            <option value="account" ${search.category=='account'?'selected':''}><spring:message code="admin.inquiry.category.account"/></option>
                            <option value="bug" ${search.category=='bug'?'selected':''}><spring:message code="admin.inquiry.category.bug"/></option>
                            <option value="etc" ${search.category=='etc'?'selected':''}><spring:message code="admin.inquiry.category.etc"/></option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.inquiry.answerState"/></div>
                        <select class="adm-select" name="answered">
                            <option value="ALL" ${search.answered=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="ANSWERED" ${search.answered=='ANSWERED'?'selected':''}><spring:message code="admin.inquiry.answered"/></option>
                            <option value="UNANSWERED" ${search.answered=='UNANSWERED'?'selected':''}><spring:message code="admin.inquiry.unanswered"/></option>
                        </select>
                    </div>

                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label"><spring:message code="admin.common.search"/></div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:110px;">
                                <option value="all" ${search.searchType=='all'?'selected':''}><spring:message code="admin.common.all"/></option>
                                <option value="inquiryId" ${search.searchType=='inquiryId'?'selected':''}><spring:message code="admin.inquiry.searchType.inquiryId"/></option>
                                <option value="title" ${search.searchType=='title'?'selected':''}><spring:message code="admin.inquiry.searchType.title"/></option>
                                <option value="content" ${search.searchType=='content'?'selected':''}><spring:message code="admin.inquiry.searchType.content"/></option>
                                <option value="nickname" ${search.searchType=='nickname'?'selected':''}><spring:message code="admin.inquiry.searchType.nickname"/></option>
                                <option value="userId" ${search.searchType=='userId'?'selected':''}><spring:message code="admin.inquiry.searchType.userId"/></option>
                            </select>
                            <div class="adm-search-box" style="flex:1;">
                                <span class="adm-search-ico">🔍</span>
                                <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="<spring:message code='admin.inquiry.searchPlaceholder'/>">
                            </div>
                        </div>
                    </div>

                    <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.inquiry.listTitle"/></div>
            <div style="font-size:12px;color:#64748b;"><spring:message code="admin.common.totalCount" arguments="${total}"/></div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th>${adminCommonId}</th>
                    <th><spring:message code="admin.inquiry.author"/></th>
                    <th><spring:message code="admin.inquiry.title"/></th>
                    <th><spring:message code="admin.inquiry.category"/></th>
                    <th><spring:message code="admin.common.status"/></th>
                    <th><spring:message code="admin.inquiry.answer"/></th>
                    <th><spring:message code="admin.inquiry.createdAt"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr class="adm-inq-row" data-id="${item.inquiryId}" style="cursor:pointer;">
                        <td>#${item.inquiryId}</td>
                        <%-- 작성자 --%>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-open-member-context"
                                    data-user-idx="${item.userIdx}"
                                    onclick="event.stopPropagation();">
                                <span style="font-weight:700;color:#93c5fd;">${item.nickname}</span>
                                <span class="adm-cell-link-note">@${item.userId}</span>
                                <c:if test="${item.accountStatus == 'BLOCKED'}">
                                    <span class="adm-cell-link-note" style="color:#fca5a5;"><spring:message code="admin.reports.accountBlocked"/></span>
                                </c:if>
                            </button>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/inquiries/${item.inquiryId}?${fn:escapeXml(listParams)}"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <span class="mem-name">${item.title}</span>
                                <span class="adm-cell-link-note">
                                    <c:if test="${item.privateFlag}">🔒 <spring:message code="admin.inquiry.privateFlag"/> · </c:if>
                                    <spring:message code="admin.inquiry.viewCount" arguments="${item.viewCount}"/>
                                </span>
                            </a>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link"
                                    data-category="${item.category}"
                                    onclick="event.stopPropagation(); applyInquiryFilter(this);">
                                <span>
                                    <c:choose>
                                        <c:when test="${item.category eq 'service'}"><spring:message code="admin.inquiry.category.service"/></c:when>
                                        <c:when test="${item.category eq 'payment'}"><spring:message code="admin.inquiry.category.payment"/></c:when>
                                        <c:when test="${item.category eq 'account'}"><spring:message code="admin.inquiry.category.account"/></c:when>
                                        <c:when test="${item.category eq 'bug'}"><spring:message code="admin.inquiry.category.bug"/></c:when>
                                        <c:otherwise><spring:message code="admin.inquiry.category.etc"/></c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-cell-link-note"><spring:message code="admin.common.sameCategory"/></span>
                            </button>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/inquiries/${item.inquiryId}?${fn:escapeXml(listParams)}&jump=inquiry-status-actions"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <span class="status-badge ${item.status}">
                                    <c:choose>
                                        <c:when test="${item.status eq 'PENDING'}"><spring:message code="admin.inquiry.status.pending"/></c:when>
                                        <c:when test="${item.status eq 'IN_PROGRESS'}"><spring:message code="admin.inquiry.status.inProgress"/></c:when>
                                        <c:when test="${item.status eq 'COMPLETED'}"><spring:message code="admin.inquiry.status.completed"/></c:when>
                                        <c:when test="${item.status eq 'USER_COMPLETED'}"><spring:message code="admin.inquiry.status.userCompleted"/></c:when>
                                        <c:when test="${item.status eq 'CANCELLED'}"><spring:message code="admin.inquiry.status.cancelled"/></c:when>
                                        <c:when test="${item.status eq 'DELETE_REQUESTED'}"><spring:message code="admin.inquiry.status.deleteRequested"/></c:when>
                                        <c:when test="${item.status eq 'PRIVATE_REQUESTED'}"><spring:message code="admin.inquiry.status.privateRequested"/></c:when>
                                        <c:when test="${item.status eq 'PUBLIC_REQUESTED'}"><spring:message code="admin.inquiry.status.publicRequested"/></c:when>
                                        <c:otherwise>${item.status}</c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-cell-link-note"><spring:message code="admin.inquiry.detail.statusChange"/></span>
                            </a>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/inquiries/${item.inquiryId}?${fn:escapeXml(listParams)}&jump=inquiry-answer-card"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <c:choose>
                                    <c:when test="${not empty item.answerId}">
                                        <span class="mem-name"><spring:message code="admin.inquiry.answered"/></span>
                                        <span class="adm-cell-link-note">${item.answerAdminNickname}</span>
                                    </c:when>
                                    <c:otherwise><span style="color:#64748b;"><spring:message code="admin.inquiry.unanswered"/></span></c:otherwise>
                                </c:choose>
                            </a>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/inquiries/${item.inquiryId}?${fn:escapeXml(listParams)}"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <span><fmt:formatDate value="${item.createdAt}" type="both" dateStyle="short" timeStyle="short"/></span>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="7" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.common.noResults"/></td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}"><button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button></c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
                    <button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}" onclick="goPage(${p})">${p}</button>
                </c:forEach>
                <c:if test="${paging.next}"><button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button></c:if>
                <span class="adm-page-info"><spring:message code="admin.common.pageStatus" arguments="${paging.currentPage},${paging.totalPage}"/></span>
            </div>
        </c:if>
    </div>

    <%-- ── 유저 화면 바로가기 ── --%>
    <div style="margin-top:16px;padding:0 10px;">
        <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/inquiry/list" target="_blank">
            <span class="adm-nav-icon">↗️</span> <spring:message code="admin.inquiry.viewSite"/>
        </a>
    </div>
</div>

<script>
function goPage(page) {
    const params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = '${pageContext.request.contextPath}/admin/inquiries?' + params.toString();
}

function applyInquiryFilter(button) {
    const params = new URLSearchParams(window.location.search);
    params.set('page', '1');

    if (button.dataset.category !== undefined) {
        if (button.dataset.category) params.set('category', button.dataset.category);
        else params.delete('category');
        params.delete('searchType');
        params.delete('keyword');
    }

    if (button.dataset.searchType !== undefined) {
        if (button.dataset.searchType) params.set('searchType', button.dataset.searchType);
        else params.delete('searchType');
    }

    if (button.dataset.keyword !== undefined) {
        if (button.dataset.keyword) params.set('keyword', button.dataset.keyword);
        else params.delete('keyword');
    }

    location.href = '${pageContext.request.contextPath}/admin/inquiries?' + params.toString();
}

var ctx = '${pageContext.request.contextPath}';

// 행 클릭 시 어드민 문의 상세 페이지 이동
var listParams = 'page=${search.page}&status=${search.status}&category=${search.category}&answered=${search.answered}&searchType=${search.searchType}&keyword=' + encodeURIComponent('${search.keyword}');
document.querySelectorAll('.adm-inq-row[data-id]').forEach(function (tr) {
    tr.addEventListener('click', function (e) {
        if (e.target.closest('button, a')) return;
        location.href = '${pageContext.request.contextPath}/admin/inquiries/' + this.getAttribute('data-id') + '?' + listParams;
    });
});
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

