<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
function updateServerPageMeta(section, page, totalPages, total) {
    const card = getSectionCard(section);
    if (!card) return;
    const renderedCount = card.querySelectorAll('tbody .js-local-row').length;
    const pageInfo = card.querySelector('.js-local-page-info[data-section="' + section + '"]');
    if (pageInfo) pageInfo.textContent = '총 ' + total + '건 / 현재 ' + renderedCount + '건';
    const pageState = card.querySelector('.js-local-page-state[data-section="' + section + '"]');
    if (pageState) pageState.textContent = page + ' / ' + totalPages;
    const prevBtn = card.querySelector('.js-local-prev[data-section="' + section + '"]');
    const nextBtn = card.querySelector('.js-local-next[data-section="' + section + '"]');
    if (prevBtn) prevBtn.disabled = page <= 1;
    if (nextBtn) nextBtn.disabled = page >= totalPages;
}

function renderSectionByMode(section) {
    if (getSectionMode(section) === 'SERVER') {
        renderServerSection(section);
    } else {
        renderLocalSection(section);
    }
}

function blockRowKey(row, section) {
    if (section === 'user-blocks') {
        const btn = row.querySelector('.js-open-user-block-editor[data-target-key]');
        return btn ? btn.dataset.targetKey : '';
    }
    if (section === 'ip-rules') {
        const btn = row.querySelector('.js-open-ip-rule-editor[data-id]');
        return btn ? btn.dataset.id : '';
    }
    if (section === 'batches') {
        const btn = row.querySelector('.js-open-batch-editor[data-batch-id]');
        return btn ? btn.dataset.batchId : '';
    }
    if (section === 'histories') {
        const btn = row.querySelector('.js-open-history-current[data-history-id]');
        return btn ? btn.dataset.historyId : '';
    }
    return '';
}


function enhanceBlockDashboardTables() {
    const sections = ['user-blocks', 'ip-rules', 'batches', 'histories'];
    const titles = [ADMIN_BLOCK_MSG.dashViewUserBlocks, ADMIN_BLOCK_MSG.dashViewIpRules, ADMIN_BLOCK_MSG.dashViewBatches, ADMIN_BLOCK_MSG.dashViewHistories];

    document.querySelectorAll('.js-dashboard-panel table.adm-table').forEach(function (table, tableIndex) {
        const targetSection = sections[tableIndex] || 'all';
        const card = table.closest('.adm-card');
        const head = card ? card.querySelector('.adm-card-head') : null;
        if (head && !head.querySelector('.js-dashboard-open-section')) {
            const btn = document.createElement('button');
            btn.type = 'button';
            btn.className = 'adm-btn adm-btn-ghost js-dashboard-open-section';
            btn.style.fontSize = '12px';
            btn.textContent = titles[tableIndex] || ADMIN_BLOCK_MSG.dashViewAll;
            btn.addEventListener('click', function () {
                activateBlockTab(targetSection);
                renderSectionByMode(targetSection);
            });
            head.appendChild(btn);
        }

        const resetBtn = head ? head.querySelector('.js-dash-sort-reset') : null;
        if (resetBtn) {
            resetBtn.textContent = ADMIN_BLOCK_MSG.dashSortReset;
            resetBtn.addEventListener('click', function () {
                resetDashboardSort(table);
            });
        }

        const tbody = table.querySelector('tbody');
        if (tbody) {
            Array.from(tbody.querySelectorAll('tr')).forEach(function (row, i) {
                row.dataset.origOrder = String(i);
            });
        }

        table.querySelectorAll('thead th').forEach(function (th, idx, arr) {
            if (idx === arr.length - 1 || th.dataset.dashboardEnhanced === 'true') return;
            th.dataset.dashboardEnhanced = 'true';
            th.dataset.sortIndex = String(idx);
            th.style.cursor = 'pointer';
            th.style.userSelect = 'none';
            th.title = ADMIN_BLOCK_MSG.dashSortTip;
            th.addEventListener('click', function () {
                sortDashboardTable(table, idx);
            });
        });
    });
}

function sortDashboardTable(table, cellIndex) {
    const tbody = table.querySelector('tbody');
    if (!tbody) return;

    const prevIndex = Number(table.dataset.dashboardSortIndex || -1);
    const prevDir = table.dataset.dashboardSortDir || 'ASC';
    const nextDir = prevIndex === cellIndex && prevDir === 'ASC' ? 'DESC' : 'ASC';
    table.dataset.dashboardSortIndex = String(cellIndex);
    table.dataset.dashboardSortDir = nextDir;

    const rows = Array.from(tbody.querySelectorAll('tr')).filter(function (row) {
        return row.children.length > 1 && !row.querySelector('td[colspan]');
    });

    rows.sort(function (a, b) {
        const av = (a.children[cellIndex] ? a.children[cellIndex].innerText : '').replace(/\s+/g, ' ').trim();
        const bv = (b.children[cellIndex] ? b.children[cellIndex].innerText : '').replace(/\s+/g, ' ').trim();
        const an = Number(av.replace(/[^0-9.-]/g, ''));
        const bn = Number(bv.replace(/[^0-9.-]/g, ''));
        let cmp;
        if (!Number.isNaN(an) && !Number.isNaN(bn) && av.match(/\d/) && bv.match(/\d/)) {
            cmp = an - bn;
        } else {
            cmp = av.localeCompare(bv, ADMIN_BLOCK_LOCALE || undefined, {numeric: true, sensitivity: 'base'});
        }
        return nextDir === 'ASC' ? cmp : -cmp;
    });

    rows.forEach(function (row) { tbody.appendChild(row); });

    table.querySelectorAll('thead th').forEach(function (th) {
        const active = Number(th.dataset.sortIndex || -1) === cellIndex;
        let ico = th.querySelector('.sort-ico');
        if (active) {
            if (!ico) {
                ico = document.createElement('span');
                ico.className = 'sort-ico';
                th.appendChild(ico);
            }
            const asc = nextDir === 'ASC';
            ico.className = 'sort-ico ' + (asc ? 'asc' : 'desc');
            ico.textContent = asc ? '▲' : '▼';
        } else {
            if (ico) ico.remove();
        }
    });

    const card = table.closest('.adm-card');
    if (card) {
        const resetBtn = card.querySelector('.js-dash-sort-reset');
        if (resetBtn) resetBtn.classList.remove('is-hidden');
    }
}

function resetDashboardSort(table) {
    delete table.dataset.dashboardSortIndex;
    delete table.dataset.dashboardSortDir;

    const tbody = table.querySelector('tbody');
    if (tbody) {
        const rows = Array.from(tbody.querySelectorAll('tr'));
        rows.sort(function (a, b) {
            return Number(a.dataset.origOrder || 0) - Number(b.dataset.origOrder || 0);
        });
        rows.forEach(function (row) { tbody.appendChild(row); });
    }

    table.querySelectorAll('thead th .sort-ico').forEach(function (ico) { ico.remove(); });

    const card = table.closest('.adm-card');
    if (card) {
        const resetBtn = card.querySelector('.js-dash-sort-reset');
        if (resetBtn) resetBtn.classList.add('is-hidden');
    }
}

function enhanceBlockLocalTables() {
    Object.keys(BLOCK_SECTION_CONFIG).forEach(function (section) {
        const card = getSectionCard(section);
        if (!card || card.dataset.enhanced === 'true') return;
        card.dataset.enhanced = 'true';

        const toolbar = card.querySelector('.adm-local-toolbar');
        if (toolbar) {
            const group = document.createElement('div');
            group.className = 'adm-local-toolbar-group js-local-export-group';
            group.innerHTML =
                '<div class="adm-export-control">'
                + '<select class="adm-select js-block-export-format" data-section="' + section + '"><option value="csv">CSV</option><option value="excel">Excel</option></select>'
                + '<div class="adm-export-menu">'
                + '<button type="button" class="adm-btn adm-btn-ghost js-export-toggle">⬇ ' + ADMIN_BLOCK_MSG.export + ' ▾</button>'
                + '<div class="adm-export-dropdown">'
                + '<button type="button" class="js-block-export" data-section="' + section + '" data-scope="all">📋 ' + ADMIN_BLOCK_MSG.exportAll + '</button>'
                + '<button type="button" class="js-block-export" data-section="' + section + '" data-scope="search">🔍 ' + ADMIN_BLOCK_MSG.exportFiltered + '</button>'
                + '<button type="button" class="js-block-export js-block-export-selected" data-section="' + section + '" data-scope="selected" disabled>☑ ' + ADMIN_BLOCK_MSG.exportSelected + ' (0)</button>'
                + '</div></div></div>';
            toolbar.appendChild(group);
        }

        const table = card.querySelector('table.adm-table');
        if (!table) return;
        const headRow = table.querySelector('thead tr');
        if (headRow && !headRow.querySelector('.js-block-check-all')) {
            const checkTh = document.createElement('th');
            checkTh.className = 'js-block-check-cell';
            checkTh.style.width = '42px';
            checkTh.style.textAlign = 'center';
            checkTh.innerHTML = '<input type="checkbox" class="js-block-check-all adm-check" data-section="' + section + '">';
            headRow.insertBefore(checkTh, headRow.firstElementChild);
        }

        /* sort enhancement is handled by data-sort-index + sectionSort inline onclick */

        getLocalRows(section).forEach(function (row) {
            if (row.querySelector('.js-block-row-check')) return;
            const checkTd = document.createElement('td');
            checkTd.className = 'js-block-check-cell';
            checkTd.style.textAlign = 'center';
            checkTd.innerHTML = '<input type="checkbox" class="js-block-row-check adm-check" data-section="' + section + '" value="' + escapeHtml(blockRowKey(row, section)) + '">';
            row.insertBefore(checkTd, row.firstElementChild);
        });

        if (section === 'user-blocks' || section === 'ip-rules') {
            const wrap = card.querySelector('.adm-table-wrap');
            if (wrap && !card.querySelector('.js-block-bulkbar[data-section="' + section + '"]')) {
                const bar = document.createElement('div');
                bar.className = 'js-block-bulkbar adm-block-bulkbar is-floating is-hidden';
                bar.dataset.section = section;
                if (section === 'user-blocks') {
                    bar.innerHTML = '<span class="adm-block-bulk-count-text"><span class="js-block-bulk-count">0</span>' + ADMIN_BLOCK_MSG.selectedCount + '</span>'
                        + '<button type="button" class="adm-btn adm-btn-primary js-bulk-release-user-blocks">' + ADMIN_BLOCK_MSG.bulkRelease + '</button>'
                        + '<button type="button" class="adm-btn adm-btn-ghost js-block-clear-selection adm-block-clear-selection" data-section="' + section + '">' + ADMIN_BLOCK_MSG.clearSelection + '</button>';
                } else {
                    bar.innerHTML = '<span class="adm-block-bulk-count-text"><span class="js-block-bulk-count">0</span>' + ADMIN_BLOCK_MSG.selectedCount + '</span>'
                        + '<button type="button" class="adm-btn adm-btn-primary js-bulk-toggle-ip-rules" data-active="true">' + ADMIN_BLOCK_MSG.bulkActivate + '</button>'
                        + '<button type="button" class="adm-btn adm-btn-danger js-bulk-toggle-ip-rules" data-active="false">' + ADMIN_BLOCK_MSG.bulkDeactivate + '</button>'
                        + '<button type="button" class="adm-btn adm-btn-ghost js-block-clear-selection adm-block-clear-selection" data-section="' + section + '">' + ADMIN_BLOCK_MSG.clearSelection + '</button>';
                }
                wrap.parentElement.insertBefore(bar, wrap);
            }
        }
    });
}

function selectedBlockChecks(section) {
    return Array.from(document.querySelectorAll('.js-block-row-check[data-section="' + section + '"]:checked'));
}

function updateBlockBulkBar(section) {
    const checks = selectedBlockChecks(section);
    const bar = document.querySelector('.js-block-bulkbar[data-section="' + section + '"]');
    if (bar) {
        bar.classList.toggle('is-hidden', checks.length === 0);
        const count = bar.querySelector('.js-block-bulk-count');
        if (count) count.textContent = checks.length;
    }
    const selectedBtn = document.querySelector('.js-block-export-selected[data-section="' + section + '"]');
    if (selectedBtn) {
        selectedBtn.disabled = checks.length === 0;
        const countSpan = selectedBtn.querySelector('span');
        if (countSpan) {
            countSpan.textContent = checks.length;
        } else {
            selectedBtn.textContent = selectedBtn.textContent.replace(/\(\d+\)/, '(' + checks.length + ')');
        }
    }
    const all = document.querySelector('.js-block-check-all[data-section="' + section + '"]');
    if (all) {
        const visibleChecks = getLocalRows(section)
            .filter(row => row.style.display !== 'none')
            .map(row => row.querySelector('.js-block-row-check'))
            .filter(Boolean);
        all.checked = visibleChecks.length > 0 && visibleChecks.every(cb => cb.checked);
        all.indeterminate = visibleChecks.some(cb => cb.checked) && !all.checked;
    }
}

function clearBlockSelection(section) {
    document.querySelectorAll('.js-block-row-check[data-section="' + section + '"], .js-block-check-all[data-section="' + section + '"]').forEach(function (cb) {
        cb.checked = false;
        cb.indeterminate = false;
    });
    updateBlockBulkBar(section);
}

async function bulkReleaseSelectedUserBlocks() {
    const keys = selectedBlockChecks('user-blocks').map(cb => cb.value).filter(Boolean);
    if (!keys.length) { adm_toast(ADMIN_BLOCK_MSG.noSelection, 'error'); return; }
    if (!confirm(ADMIN_BLOCK_MSG.confirmBulkRelease.replace('{0}', keys.length))) return;
    const params = new URLSearchParams();
    keys.forEach(key => params.append('blockTargetKeys', key));
    const res = await fetch(CTX + '/admin/blocks/user-blocks/bulk-release', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: params
    });
    const data = await res.json();
    if (res.ok && data.success) { adm_toast(data.message || ADMIN_BLOCK_MSG.done); location.reload(); }
    else { adm_toast(data.message || ADMIN_BLOCK_MSG.processError, 'error'); }
}

async function bulkToggleSelectedIpRules(active) {
    const ids = selectedBlockChecks('ip-rules').map(cb => cb.value).filter(Boolean);
    if (!ids.length) { adm_toast(ADMIN_BLOCK_MSG.noSelection, 'error'); return; }
    if (!confirm(active ? ADMIN_BLOCK_MSG.confirmBulkActivate.replace('{0}', ids.length) : ADMIN_BLOCK_MSG.confirmBulkDeactivate.replace('{0}', ids.length))) return;
    const params = new URLSearchParams();
    ids.forEach(id => params.append('ipBlocklistIdxList', id));
    params.append('active', active ? 'true' : 'false');
    const res = await fetch(CTX + '/admin/blocks/ip-rules/bulk-toggle', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: params
    });
    const data = await res.json();
    if (res.ok && data.success) { adm_toast(data.message || ADMIN_BLOCK_MSG.done); location.reload(); }
    else { adm_toast(data.message || ADMIN_BLOCK_MSG.processError, 'error'); }
}

function exportBlockSection(section, scope) {
    const card = getSectionCard(section);
    if (!card) return;
    const table = card.querySelector('table.adm-table');
    const formatSelect = card.querySelector('.js-block-export-format[data-section="' + section + '"]');
    const format = formatSelect ? formatSelect.value : 'csv';
    let rows;
    if (scope === 'selected') {
        rows = selectedBlockChecks(section).map(cb => cb.closest('tr')).filter(Boolean);
        if (!rows.length) { adm_toast(ADMIN_BLOCK_MSG.noSelection, 'error'); return; }
    } else if (scope === 'search') {
        rows = sortLocalRows(section, filterLocalRows(section));
    } else {
        rows = sortLocalRows(section, getLocalRows(section));
    }
    const headers = Array.from(table.querySelectorAll('thead th'))
        .filter((th, idx, arr) => idx !== 0 && idx !== arr.length - 1)
        .map(th => th.innerText.replace(/[↕▲▼]/g, '').trim());
    const body = rows.map(function (row) {
        const cells = Array.from(row.children).filter((td, idx, arr) => idx !== 0 && idx !== arr.length - 1);
        return cells.map(td => td.innerText.replace(/\s+/g, ' ').trim());
    });
    const filename = 'blocks_' + section + '_' + scope + '_' + new Date().toISOString().slice(0, 10);
    if (format === 'excel') {
        const worksheetName = 'blocks_' + section.replace(/[^A-Za-z0-9가-힣_-]/g, '_').slice(0, 24);
        const xls = buildExcelXml(headers, body, worksheetName);
        downloadBlob('\ufeff' + xls, filename + '.xls', 'application/vnd.ms-excel;charset=utf-8');
    } else {
        const csv = [headers].concat(body).map(row => row.map(csvEscape).join(',')).join('\n');
        downloadBlob('\ufeff' + csv, filename + '.csv', 'text/csv;charset=utf-8');
    }
}

function csvEscape(value) {
    const s = String(value == null ? '' : value);
    return '"' + s.replace(/"/g, '""') + '"';
}

function excelXmlEscape(value) {
    return String(value == null ? '' : value)
        .replace(/[\x00-\x08\x0B\x0C\x0E-\x1F]/g, '')
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&apos;');
}

function excelXmlCell(value, styleId) {
    const styleAttr = styleId ? ' ss:StyleID="' + styleId + '"' : '';
    return '<Cell' + styleAttr + '><Data ss:Type="String">' + excelXmlEscape(value) + '</Data></Cell>';
}

function buildExcelXml(headers, rows, worksheetName) {
    const safeSheetName = excelXmlEscape(worksheetName || 'export').slice(0, 31) || 'export';
    const headerXml = '<Row>' + headers.map(function (h) { return excelXmlCell(h, 'header'); }).join('') + '</Row>';
    const bodyXml = rows.map(function (row) {
        return '<Row>' + row.map(function (v) { return excelXmlCell(v); }).join('') + '</Row>';
    }).join('');

    return '<?xml version="1.0" encoding="UTF-8"?>'
        + '<?mso-application progid="Excel.Sheet"?>'
        + '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" '
        + 'xmlns:o="urn:schemas-microsoft-com:office:office" '
        + 'xmlns:x="urn:schemas-microsoft-com:office:excel" '
        + 'xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" '
        + 'xmlns:html="http://www.w3.org/TR/REC-html40">'
        + '<Styles>'
        + '<Style ss:ID="Default" ss:Name="Normal"><Alignment ss:Vertical="Center"/><Font ss:FontName="맑은 고딕" ss:Size="10"/></Style>'
        + '<Style ss:ID="header"><Font ss:FontName="맑은 고딕" ss:Size="10" ss:Bold="1"/><Interior ss:Color="#D9EAF7" ss:Pattern="Solid"/></Style>'
        + '</Styles>'
        + '<Worksheet ss:Name="' + safeSheetName + '"><Table>'
        + headerXml + bodyXml
        + '</Table><WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel"><FreezePanes/><FrozenNoSplit/><SplitHorizontal>1</SplitHorizontal><TopRowBottomPane>1</TopRowBottomPane></WorksheetOptions></Worksheet>'
        + '</Workbook>';
}

function downloadBlob(content, filename, type) {
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


</script>
