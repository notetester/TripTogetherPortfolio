<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="policies"/>
<spring:message code="admin.policy.pageTitle" var="adminPolicyPageTitle"/>
<c:set var="pageTitle" value="${adminPolicyPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.policy.centerTitle"/></div>
        </div>
        <div class="adm-card-body">
            <div class="policy-overview-grid">
                <c:forEach items="${policies}" var="policy">
                    <div class="policy-overview-card">
                        <div class="policy-overview-eyebrow">${policy.policyGroup}</div>
                        <div class="policy-overview-title">${policy.policyName}</div>
                        <div class="policy-overview-meta">
                            <spring:message code="admin.common.status"/>:
                            <span class="status-badge ${policy.active ? 'ACTIVE' : 'DORMANT'}">
                                <c:choose>
                                    <c:when test="${policy.active}"><spring:message code="admin.common.active"/></c:when>
                                    <c:otherwise><spring:message code="admin.common.inactive"/></c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div class="policy-overview-meta">
                            <spring:message code="admin.policy.nextExecute"/>:
                            <c:choose>
                                <c:when test="${not empty policy.nextExecuteAtDate}">
                                    <fmt:formatDate value="${policy.nextExecuteAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                                </c:when>
                                <c:otherwise><spring:message code="admin.policy.unscheduled"/></c:otherwise>
                            </c:choose>
                        </div>
                        <div class="policy-overview-meta">
                            <spring:message code="admin.policy.lastExecute"/>:
                            <c:choose>
                                <c:when test="${not empty policy.lastExecutedAtDate}">
                                    <fmt:formatDate value="${policy.lastExecutedAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                                    <c:if test="${not empty policy.lastExecutionStatus}">
                                        / ${policy.lastExecutionStatus}
                                    </c:if>
                                </c:when>
                                <c:otherwise><spring:message code="admin.policy.noExecution"/></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="policy-layout">
        <div class="policy-main-column">
            <c:forEach items="${policies}" var="policy">
                <div class="adm-card policy-card"
                     data-policy-code="${policy.policyCode}"
                     data-config-json="${fn:escapeXml(policy.configJson)}"
                     data-schedule-type="${policy.scheduleType}"
                     data-schedule-interval="${policy.scheduleIntervalHours}"
                    data-schedule-day="${policy.scheduleDayOfMonth}"
                     data-schedule-time="${policy.scheduleTime}">
                    <div class="adm-card-head">
                        <div>
                            <div class="adm-card-title">${policy.policyName}</div>
                            <div class="adm-card-subtitle">${policy.policyCode}</div>
                        </div>
                        <div class="policy-card-head-actions">
                            <span class="status-badge ${policy.active ? 'ACTIVE' : 'DORMANT'}">
                                <c:choose>
                                    <c:when test="${policy.active}"><spring:message code="admin.common.active"/></c:when>
                                    <c:otherwise><spring:message code="admin.common.inactive"/></c:otherwise>
                                </c:choose>
                            </span>
                            <button type="button" class="adm-btn adm-btn-ghost" onclick="runPolicyNow('${policy.policyCode}', this)"><spring:message code="admin.policy.runNow"/></button>
                        </div>
                    </div>
                    <div class="adm-card-body">
                        <div class="policy-form-grid">
                            <div class="policy-config-dormant" style="display:none;">
                                <div class="adm-filter-label"><spring:message code="admin.policy.inactiveDays"/></div>
                                <input class="adm-input js-policy-inactive-days" type="number" min="30" step="1">
                            </div>
                            <div class="policy-config-level" style="display:none;">
                                <div class="adm-filter-label"><spring:message code="admin.policy.levelScope"/></div>
                                <label class="policy-inline-check">
                                    <input class="js-policy-only-active" type="checkbox">
                                    <spring:message code="admin.policy.onlyActiveMembers"/>
                                </label>
                            </div>
                            <div>
                                <div class="adm-filter-label"><spring:message code="admin.policy.scheduleType"/></div>
                                <select class="adm-select js-policy-schedule-type" style="width:100%;">
                                    <option value="DAILY_TIME"><spring:message code="admin.policy.schedule.daily"/></option>
                                    <option value="INTERVAL_HOURS"><spring:message code="admin.policy.schedule.interval"/></option>
                                    <option value="MONTHLY_DAY_TIME"><spring:message code="admin.policy.schedule.monthly"/></option>
                                    <option value="MANUAL"><spring:message code="admin.policy.schedule.manual"/></option>
                                </select>
                            </div>
                            <div class="js-policy-interval-wrap">
                                <div class="adm-filter-label"><spring:message code="admin.policy.intervalHours"/></div>
                                <input class="adm-input js-policy-interval" type="number" min="1" step="1">
                            </div>
                            <div class="js-policy-day-wrap">
                                <div class="adm-filter-label"><spring:message code="admin.policy.dayOfMonth"/></div>
                                <input class="adm-input js-policy-day" type="number" min="1" max="28" step="1">
                            </div>
                            <div class="js-policy-time-wrap">
                                <div class="adm-filter-label"><spring:message code="admin.policy.scheduleTime"/></div>
                                <input class="adm-input js-policy-time" type="time">
                            </div>
                            <div>
                                <div class="adm-filter-label"><spring:message code="admin.policy.policyEnabled"/></div>
                                <label class="policy-inline-check">
                                    <input class="js-policy-active" type="checkbox" ${policy.active ? 'checked' : ''}>
                                    <spring:message code="admin.policy.autoExecution"/>
                                </label>
                            </div>
                        </div>
                        <div class="policy-card-foot">
                            <div class="policy-card-foot-note">
                                <spring:message code="admin.policy.lastMessage"/>:
                                <span class="policy-card-foot-value">
                                    <c:choose>
                                        <c:when test="${empty policy.lastExecutionMessage}">
                                            <spring:message code="admin.policy.noExecution"/>
                                        </c:when>
                                        <c:otherwise>${policy.lastExecutionMessage}</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div style="display:flex;gap:8px;">
                                <button type="button" class="adm-btn adm-btn-primary" onclick="savePolicy('${policy.policyCode}', this)"><spring:message code="admin.policy.save"/></button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title"><spring:message code="admin.policy.historyTitle"/></div>
            </div>
            <div class="adm-card-body policy-history-column">
                <c:forEach items="${policies}" var="policy">
                    <div class="policy-history-card">
                        <div class="policy-history-card-title">${policy.policyName}</div>
                        <div class="adm-card-subtitle">${policy.policyCode}</div>
                        <div class="policy-history-stack">
                            <c:forEach items="${policyHistories[policy.policyCode]}" var="history">
                                <div class="policy-history-item">
                                    <div class="policy-history-item-head">
                                        <div class="policy-history-item-title">${history.changeType}</div>
                                        <div class="policy-history-item-time">
                                            <fmt:formatDate value="${history.changedAtDate}" pattern="MM.dd HH:mm"/>
                                        </div>
                                    </div>
                                    <div class="policy-history-item-meta">
                                        <spring:message code="admin.policy.operator"/>:
                                        <span class="policy-history-item-value">
                                            <c:choose>
                                                <c:when test="${empty history.changedByNickname}"><spring:message code="admin.common.system"/></c:when>
                                                <c:otherwise>${history.changedByNickname}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <c:if test="${not empty history.executionStatus or not empty history.executionMessage}">
                                        <div class="policy-history-item-meta">
                                            <spring:message code="admin.common.result"/>:
                                            <span class="policy-history-item-value">${empty history.executionStatus ? '-' : history.executionStatus}</span>
                                            <c:if test="${not empty history.executionMessage}">
                                                / ${history.executionMessage}
                                            </c:if>
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                            <c:if test="${empty policyHistories[policy.policyCode]}">
                                <div class="policy-history-empty"><spring:message code="admin.policy.noHistory"/></div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<spring:message code="admin.policy.noExecution" var="policyNoExecutionText"/>
<spring:message code="admin.policy.saving" var="policySavingText"/>
<spring:message code="admin.policy.saveSuccess" var="policySaveSuccessText"/>
<spring:message code="admin.policy.saveFailure" var="policySaveFailureText"/>
<spring:message code="admin.policy.saveError" var="policySaveErrorText"/>
<spring:message code="admin.policy.runConfirm" var="policyRunConfirmText"/>
<spring:message code="admin.policy.running" var="policyRunningText"/>
<spring:message code="admin.policy.runSuccess" var="policyRunSuccessText"/>
<spring:message code="admin.policy.runFailure" var="policyRunFailureText"/>
<spring:message code="admin.policy.runError" var="policyRunErrorText"/>
<spring:message code="admin.policy.jsonParseError" var="policyJsonParseErrorText"/>

<script>
const POLICY_CTX = '${pageContext.request.contextPath}';
const POLICY_TEXT = {
    noExecution: '${fn:escapeXml(policyNoExecutionText)}',
    saving: '${fn:escapeXml(policySavingText)}',
    saveSuccess: '${fn:escapeXml(policySaveSuccessText)}',
    saveFailure: '${fn:escapeXml(policySaveFailureText)}',
    saveError: '${fn:escapeXml(policySaveErrorText)}',
    runConfirm: '${fn:escapeXml(policyRunConfirmText)}',
    running: '${fn:escapeXml(policyRunningText)}',
    runSuccess: '${fn:escapeXml(policyRunSuccessText)}',
    runFailure: '${fn:escapeXml(policyRunFailureText)}',
    runError: '${fn:escapeXml(policyRunErrorText)}',
    jsonParseError: '${fn:escapeXml(policyJsonParseErrorText)}'
};

function parsePolicyConfig(text) {
    if (!text) return {};
    try {
        return JSON.parse(text);
    } catch (e) {
        console.warn(POLICY_TEXT.jsonParseError, e);
        return {};
    }
}

function togglePolicyScheduleFields(card) {
    const scheduleType = card.querySelector('.js-policy-schedule-type').value;
    card.querySelector('.js-policy-interval-wrap').style.display = scheduleType === 'INTERVAL_HOURS' ? '' : 'none';
    card.querySelector('.js-policy-day-wrap').style.display = scheduleType === 'MONTHLY_DAY_TIME' ? '' : 'none';
    card.querySelector('.js-policy-time-wrap').style.display = scheduleType === 'MANUAL' ? 'none' : '';
}

function hydratePolicyCard(card) {
    const policyCode = card.dataset.policyCode;
    const config = parsePolicyConfig(card.dataset.configJson);
    const scheduleTypeInput = card.querySelector('.js-policy-schedule-type');
    const intervalInput = card.querySelector('.js-policy-interval');
    const dayInput = card.querySelector('.js-policy-day');
    const timeInput = card.querySelector('.js-policy-time');

    scheduleTypeInput.value = card.dataset.scheduleType || 'DAILY_TIME';
    intervalInput.value = card.dataset.scheduleInterval || '';
    dayInput.value = card.dataset.scheduleDay || '';
    timeInput.value = card.dataset.scheduleTime || '03:00';

    if (policyCode === 'DORMANT_ACCOUNT_POLICY') {
        card.querySelector('.policy-config-dormant').style.display = '';
        card.querySelector('.js-policy-inactive-days').value = config.inactiveDays || 365;
    }
    if (policyCode === 'MEMBER_LEVEL_SETTLEMENT_POLICY') {
        card.querySelector('.policy-config-level').style.display = '';
        card.querySelector('.js-policy-only-active').checked = config.onlyActiveMembers !== false;
    }

    scheduleTypeInput.addEventListener('change', function() {
        togglePolicyScheduleFields(card);
    });
    togglePolicyScheduleFields(card);
}

document.querySelectorAll('.policy-card').forEach(hydratePolicyCard);

async function savePolicy(policyCode, button) {
    const card = button.closest('.policy-card');
    const scheduleType = card.querySelector('.js-policy-schedule-type').value;
    const scheduleIntervalHours = card.querySelector('.js-policy-interval').value;
    const scheduleDayOfMonth = card.querySelector('.js-policy-day').value;
    const scheduleTime = card.querySelector('.js-policy-time').value;
    const active = card.querySelector('.js-policy-active').checked;
    let config = {};

    if (policyCode === 'DORMANT_ACCOUNT_POLICY') {
        config.inactiveDays = Number(card.querySelector('.js-policy-inactive-days').value || 365);
    } else if (policyCode === 'MEMBER_LEVEL_SETTLEMENT_POLICY') {
        config.onlyActiveMembers = card.querySelector('.js-policy-only-active').checked;
    }

    const payload = new URLSearchParams({
        configJson: JSON.stringify(config),
        scheduleType: scheduleType,
        scheduleIntervalHours: scheduleIntervalHours || '',
        scheduleDayOfMonth: scheduleDayOfMonth || '',
        scheduleTime: scheduleTime || '',
        active: active
    });

    button.disabled = true;
    const originalText = button.textContent;
    button.textContent = POLICY_TEXT.saving;
    try {
        const response = await fetch(POLICY_CTX + '/admin/policies/' + encodeURIComponent(policyCode), {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: payload
        });
        const data = await response.json();
        if (response.ok && data.success) {
            adm_toast(POLICY_TEXT.saveSuccess);
            setTimeout(function() { location.reload(); }, 600);
        } else {
            adm_toast(POLICY_TEXT.saveFailure, 'error');
        }
    } catch (error) {
        console.error(error);
        adm_toast(POLICY_TEXT.saveError, 'error');
    } finally {
        button.disabled = false;
        button.textContent = originalText;
    }
}

async function runPolicyNow(policyCode, button) {
    if (!confirm(POLICY_TEXT.runConfirm)) {
        return;
    }
    button.disabled = true;
    const originalText = button.textContent;
    button.textContent = POLICY_TEXT.running;
    try {
        const response = await fetch(POLICY_CTX + '/admin/policies/' + encodeURIComponent(policyCode) + '/run', {
            method: 'POST'
        });
        const data = await response.json();
        if (response.ok && data.success) {
            adm_toast(POLICY_TEXT.runSuccess);
            setTimeout(function() { location.reload(); }, 600);
        } else {
            adm_toast(POLICY_TEXT.runFailure, 'error');
        }
    } catch (error) {
        console.error(error);
        adm_toast(POLICY_TEXT.runError, 'error');
    } finally {
        button.disabled = false;
        button.textContent = originalText;
    }
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

