<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="ads"/>
<c:set var="pageTitle" value="광고 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <c:if test="${not empty adMessage}">
        <div class="adm-card" style="padding:12px 16px;margin-bottom:16px;background:#dcfce7;color:#15803d;border:1px solid #86efac;">
            ${adMessage}
        </div>
    </c:if>
    <c:if test="${not empty adError}">
        <div class="adm-card" style="padding:12px 16px;margin-bottom:16px;background:#fee2e2;color:#b91c1c;border:1px solid #fca5a5;">
            ${adError}
        </div>
    </c:if>

    <%-- 상단 액션 바 --%>
    <div class="adm-card" style="padding:16px;margin-bottom:16px;display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap;">
        <form method="get" action="${pageContext.request.contextPath}/admin/ads" style="display:flex;gap:8px;align-items:center;flex-wrap:wrap;">
            <select name="slotCode" class="adm-input" style="padding:8px 12px;font-size:13px;">
                <option value="">전체 슬롯</option>
                <option value="community_list_top"      ${slotCodeFilter eq 'community_list_top'      ? 'selected' : ''}>커뮤니티 목록 상단</option>
                <option value="community_detail_bottom" ${slotCodeFilter eq 'community_detail_bottom' ? 'selected' : ''}>커뮤니티 상세 하단</option>
            </select>
            <label style="display:inline-flex;align-items:center;gap:6px;font-size:13px;color:#475569;">
                <input type="checkbox" name="activeOnly" value="true" ${activeOnly ? 'checked' : ''}/> 활성만 보기
            </label>
            <button type="submit" class="adm-btn adm-btn-ghost">적용</button>
        </form>
        <a href="${pageContext.request.contextPath}/admin/ads/new" class="adm-btn adm-btn-primary">＋ 광고 등록</a>
    </div>

    <%-- 목록 테이블 --%>
    <div class="adm-card" style="padding:0;overflow-x:auto;">
        <table class="adm-table" style="width:100%;">
            <thead>
                <tr>
                    <th style="width:88px;">이미지</th>
                    <th>제목</th>
                    <th>슬롯</th>
                    <th>링크</th>
                    <th>기간</th>
                    <th>노출 / 클릭</th>
                    <th>활성</th>
                    <th style="width:180px;">액션</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty adList}">
                        <tr><td colspan="8" style="text-align:center;padding:48px;color:#94a3b8;">등록된 광고가 없습니다.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="ad" items="${adList}">
                            <tr data-ad-id="${ad.adId}">
                                <td>
                                    <c:if test="${not empty ad.imageUrl}">
                                        <img src="${ad.imageUrl}" alt="" style="width:80px;height:40px;object-fit:cover;border-radius:4px;"/>
                                    </c:if>
                                </td>
                                <td>
                                    <div style="font-weight:600;">${ad.title}</div>
                                    <c:if test="${not empty ad.creatorNickname}">
                                        <div style="font-size:11px;color:#94a3b8;margin-top:2px;">by ${ad.creatorNickname}</div>
                                    </c:if>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${ad.slotCode eq 'community_list_top'}">
                                            <span style="font-size:11px;color:#1d4ed8;background:#dbeafe;padding:2px 8px;border-radius:999px;">커뮤니티 목록 상단</span>
                                        </c:when>
                                        <c:when test="${ad.slotCode eq 'community_detail_bottom'}">
                                            <span style="font-size:11px;color:#6d28d9;background:#ede9fe;padding:2px 8px;border-radius:999px;">커뮤니티 상세 하단</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="font-size:11px;color:#64748b;background:#f1f5f9;padding:2px 8px;border-radius:999px;">${ad.slotCode}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="max-width:220px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;font-size:12px;color:#475569;">
                                    <c:choose>
                                        <c:when test="${ad.linkType eq 'INTERNAL'}">
                                            <span style="color:#0d9488;">(내부) ${ad.linkTargetType}<c:if test="${not empty ad.linkTargetId}"> #${ad.linkTargetId}</c:if></span>
                                        </c:when>
                                        <c:when test="${ad.linkType eq 'NONE'}">
                                            <span style="color:#94a3b8;">(액션 없음)</span>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${not empty ad.linkUrl}">
                                                <a href="${ad.linkUrl}" target="_blank" rel="noopener" style="color:#2563eb;">${ad.linkUrl}</a>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="font-size:12px;color:#475569;">
                                    <c:choose>
                                        <c:when test="${empty ad.startAt and empty ad.endAt}">상시</c:when>
                                        <c:otherwise>
                                            <c:if test="${not empty ad.startAt}"><fmt:formatDate value="${ad.startAt}" pattern="yyyy-MM-dd HH:mm"/></c:if>
                                            ~
                                            <c:if test="${not empty ad.endAt}"><fmt:formatDate value="${ad.endAt}" pattern="yyyy-MM-dd HH:mm"/></c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="font-size:12px;color:#475569;">
                                    👁 ${ad.viewCount} · 👆 ${ad.clickCount}
                                </td>
                                <td style="text-align:center;">
                                    <label class="adm-switch" style="cursor:pointer;">
                                        <input type="checkbox" class="ad-active-toggle" data-ad-id="${ad.adId}" ${ad.isActive ? 'checked' : ''}/>
                                        <span>${ad.isActive ? 'ON' : 'OFF'}</span>
                                    </label>
                                </td>
                                <td>
                                    <div style="display:flex;gap:6px;">
                                        <a href="${pageContext.request.contextPath}/admin/ads/${ad.adId}/edit" class="adm-btn adm-btn-ghost" style="padding:4px 10px;font-size:12px;">수정</a>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/ads/${ad.adId}/delete"
                                              onsubmit="return confirm('이 광고를 삭제할까요?');" style="display:inline;">
                                            <button type="submit" class="adm-btn adm-btn-ghost" style="padding:4px 10px;font-size:12px;color:#dc2626;">삭제</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<script>
(function () {
    var CTX = '${pageContext.request.contextPath}';
    document.querySelectorAll('.ad-active-toggle').forEach(function (cb) {
        cb.addEventListener('change', function () {
            var adId = cb.dataset.adId;
            var isActive = cb.checked;
            fetch(CTX + '/admin/ads/' + adId + '/toggle-active', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
                body: new URLSearchParams({ isActive: isActive })
            })
            .then(function (r) { return r.json(); })
            .then(function (data) {
                if (!data.success) {
                    alert('상태 변경 실패');
                    cb.checked = !isActive;
                } else {
                    var label = cb.nextElementSibling;
                    if (label) label.textContent = isActive ? 'ON' : 'OFF';
                }
            })
            .catch(function () {
                alert('상태 변경 중 오류');
                cb.checked = !isActive;
            });
        });
    });
})();
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

