/*
 * TripTogether Admin column actions
 * - Every non-selection admin table column should lead to a useful action.
 * - Existing member/block style cell buttons remain the source of truth.
 * - Empty cell space falls back to the nearest domain action or a row summary modal.
 */
(function () {
    'use strict';

    if (window.__TT_ADMIN_COLUMN_ACTIONS_LOADED__) return;
    window.__TT_ADMIN_COLUMN_ACTIONS_LOADED__ = true;

    const TABLE_SELECTOR = '.adm-content table.adm-table, .adm-content table.sa-salary-table#salaryTable';
    const INTERACTIVE_SELECTOR = [
        'a',
        'button',
        'input',
        'select',
        'textarea',
        'label',
        'summary',
        '[role="button"]',
        '[contenteditable="true"]',
        '.js-admin-translation-widget'
    ].join(',');
    const PRIMARY_ACTION_SELECTOR = [
        '.adm-cell-link',
        '.adm-inline-link',
        '.adm-link-btn',
        '.adm-row-btn.detail:not(.adm-row-btn-more)',
        '.js-open-member-context',
        '.js-open-ip-context',
        '.js-open-member-detail',
        '.js-member-open-detail',
        '.js-open-user-block-editor',
        '.js-open-ip-rule-editor',
        '.js-open-batch-editor',
        '.js-open-block-detail',
        '.js-open-history-current',
        '.js-open-history-detail',
        '.js-open-business-detail',
        '.js-open-detail',
        'a[href]',
        'button:not([disabled])'
    ].join(',');
    const SKIP_TABLE_SELECTOR = [
        '.history-table',
        '.sa-audit-table',
        '#salaryPreviewTable'
    ].join(',');

    let enhanceTimer = null;

    function ready(fn) {
        if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', fn);
        else fn();
    }

    function cleanText(el) {
        return (el && (el.innerText || el.textContent) ? (el.innerText || el.textContent) : '')
            .replace(/[↕▲▼]/g, '')
            .replace(/\s+/g, ' ')
            .trim();
    }

    function escapeHtml(value) {
        return String(value == null ? '' : value)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

    function isModalTable(table) {
        return !!table.closest('.adm-modal, .adm-modal-overlay, .modal, [role="dialog"]');
    }

    function isEnhanceableTable(table) {
        if (!table || table.dataset.adminColumnActions === 'off') return false;
        if (table.matches(SKIP_TABLE_SELECTOR)) return false;
        if (isModalTable(table)) return false;
        if (!table.querySelector('thead tr') || !table.querySelector('tbody')) return false;
        return true;
    }

    function tableHeaders(table) {
        return Array.from(table.querySelectorAll('thead tr:last-child th'));
    }

    function isSelectionHeader(th) {
        return !!(th && th.querySelector('input[type="checkbox"]'));
    }

    function isSelectionCell(td) {
        if (!td) return false;
        const row = td.parentElement;
        const idx = Array.prototype.indexOf.call(row.children, td);
        const table = td.closest('table');
        const header = tableHeaders(table)[idx];
        return isSelectionHeader(header) || !!td.querySelector('input[type="checkbox"], input[type="radio"]');
    }

    function isSortableHeader(th) {
        if (!th) return false;
        if (th.hasAttribute('data-sort')) return true;
        if (th.dataset.adminListSortable === 'true') return true;
        return /\bsort\b/.test(th.className || '') || /SortBy|sortBy|goSort|changeSort/i.test(th.getAttribute('onclick') || '');
    }

    function columnIndexOfCell(td) {
        return Array.prototype.indexOf.call(td.parentElement.children, td);
    }

    function columnIndexOfHeader(th) {
        return Array.prototype.indexOf.call(th.parentElement.children, th);
    }

    function headerForCell(td) {
        const table = td.closest('table');
        return tableHeaders(table)[columnIndexOfCell(td)] || null;
    }

    function normalizeColumnKey(value) {
        return String(value || '')
            .replace(/_(asc|desc)$/i, '')
            .replace(/[^\w가-힣]+/g, '_')
            .replace(/^_+|_+$/g, '')
            .toLowerCase();
    }

    function columnKeyForCell(td) {
        const header = headerForCell(td);
        return td.dataset.columnKey
            || (header && (header.dataset.columnKey || normalizeColumnKey(header.dataset.sort || cleanText(header))))
            || '';
    }

    function isVisible(el) {
        if (!el) return false;
        if (el.hidden) return false;
        if (el.disabled) return false;
        if (el.getAttribute('aria-hidden') === 'true') return false;
        return !!(el.offsetWidth || el.offsetHeight || el.getClientRects().length);
    }

    function findPrimaryAction(root) {
        if (!root) return null;
        const candidates = Array.from(root.querySelectorAll(PRIMARY_ACTION_SELECTOR));
        return candidates.find(function (el) {
            if (!isVisible(el)) return false;
            if (el.matches('input, select, textarea, label')) return false;
            if (el.closest('.action-menu:not(.open), .adm-export-dropdown, .pa-menu')) return false;
            if (el.matches('.adm-row-btn-more, .js-export-toggle, .pa-overflow-toggle, .adm-admin-list-overflow-toggle')) return false;
            if (el.querySelector && el.querySelector('input[type="checkbox"], input[type="radio"]')) return false;
            return true;
        }) || null;
    }

    function customHandler(table, payload) {
        const handlerName = table.dataset.adminColumnActionHandler;
        if (!handlerName || typeof window[handlerName] !== 'function') return false;
        const result = window[handlerName](payload);
        return result !== false;
    }

    function ensureDetailModal() {
        let modal = document.getElementById('admColumnDetailModal');
        if (modal) return modal;
        modal = document.createElement('div');
        modal.id = 'admColumnDetailModal';
        modal.className = 'adm-modal-overlay adm-column-detail-modal';
        modal.innerHTML = ''
            + '<div class="adm-modal adm-context-modal adm-context-modal-wide" role="dialog" aria-modal="true">'
            + '<div class="adm-modal-head">'
            + '<div class="adm-modal-title" id="admColumnDetailTitle">행 상세</div>'
            + '<button class="adm-modal-close" type="button" data-adm-column-close>✕</button>'
            + '</div>'
            + '<div class="adm-modal-body" id="admColumnDetailBody"></div>'
            + '<div class="adm-modal-foot">'
            + '<button class="adm-btn adm-btn-ghost" type="button" data-adm-column-close>닫기</button>'
            + '</div>'
            + '</div>';
        document.body.appendChild(modal);
        modal.addEventListener('click', function (event) {
            if (event.target === modal || event.target.closest('[data-adm-column-close]')) {
                modal.classList.remove('open');
            }
        });
        return modal;
    }

    function openFallbackDetail(table, row, headerText) {
        const modal = ensureDetailModal();
        const title = document.querySelector('.adm-page-title, .adm-content h1, .adm-content h2');
        const headers = tableHeaders(table);
        const rows = Array.from(row.children).map(function (td, idx) {
            const header = headers[idx];
            if (isSelectionHeader(header)) return '';
            const label = cleanText(header) || ('Column ' + (idx + 1));
            const value = cleanText(td) || '-';
            return '<div class="adm-column-detail-row">'
                + '<div class="adm-column-detail-label">' + escapeHtml(label) + '</div>'
                + '<div class="adm-column-detail-value">' + escapeHtml(value) + '</div>'
                + '</div>';
        }).filter(Boolean).join('');
        document.getElementById('admColumnDetailTitle').textContent =
            (title ? cleanText(title) : '행 상세') + (headerText ? ' · ' + headerText : '');
        document.getElementById('admColumnDetailBody').innerHTML =
            '<div class="adm-column-detail-grid">' + rows + '</div>';
        modal.classList.add('open');
    }

    function activateCell(td, event, options) {
        if (!td || isSelectionCell(td)) return true;
        if (event && event.target && event.target.closest(INTERACTIVE_SELECTOR)) return true;

        const table = td.closest('table');
        const row = td.closest('tr');
        if (!table || !row) return true;

        const header = headerForCell(td);
        const payload = {
            table: table,
            row: row,
            cell: td,
            header: header,
            columnIndex: columnIndexOfCell(td),
            columnKey: columnKeyForCell(td),
            headerText: cleanText(header),
            fromHeader: !!(options && options.fromHeader)
        };

        if (customHandler(table, payload)) {
            if (event) {
                event.preventDefault();
                event.stopPropagation();
            }
            return false;
        }

        const direct = findPrimaryAction(td) || findPrimaryAction(row);
        if (direct) {
            if (event) {
                event.preventDefault();
                event.stopPropagation();
            }
            direct.click();
            return false;
        }

        if (event) {
            event.preventDefault();
            event.stopPropagation();
        }
        openFallbackDetail(table, row, payload.headerText);
        return false;
    }

    window.admColumnHeaderFallback = function (event, th) {
        if (!th || isSelectionHeader(th)) return true;
        if (event && event.target && event.target.closest(INTERACTIVE_SELECTOR)) return true;
        if (isSortableHeader(th)) return true;

        const table = th.closest('table');
        if (!table) return true;
        const idx = columnIndexOfHeader(th);
        const firstRow = Array.from(table.querySelectorAll('tbody tr')).find(function (row) {
            return isVisible(row) && row.children.length > 1 && !row.querySelector('td[colspan]');
        });
        if (!firstRow || !firstRow.children[idx]) return true;
        return activateCell(firstRow.children[idx], event, { fromHeader: true });
    };

    function enhanceHeaders(table) {
        tableHeaders(table).forEach(function (th) {
            if (isSelectionHeader(th)) return;
            th.classList.add('adm-column-action-head');
            if (!th.getAttribute('onclick')) {
                th.setAttribute('onclick', 'return window.admColumnHeaderFallback(event, this);');
            }
            if (!isSortableHeader(th) && !th.hasAttribute('tabindex')) {
                th.tabIndex = 0;
            }
        });
    }

    function enhanceCells(table) {
        Array.from(table.querySelectorAll('tbody tr')).forEach(function (row) {
            if (row.children.length <= 1 && row.querySelector('td[colspan]')) return;
            Array.from(row.children).forEach(function (td) {
                if (isSelectionCell(td)) return;
                td.classList.add('adm-column-clickable-cell');
                if (!td.hasAttribute('tabindex') && !td.querySelector(INTERACTIVE_SELECTOR)) {
                    td.tabIndex = 0;
                }
            });
        });
    }

    function bindTable(table) {
        if (table.dataset.adminColumnActionsBound === 'true') return;
        table.dataset.adminColumnActionsBound = 'true';
        table.addEventListener('click', function (event) {
            const td = event.target.closest('td');
            if (!td || !table.contains(td)) return;
            activateCell(td, event);
        });
        table.addEventListener('keydown', function (event) {
            if (event.key !== 'Enter' && event.key !== ' ') return;
            const target = event.target.closest('td, th');
            if (!target || !table.contains(target)) return;
            if (target.tagName === 'TD') {
                activateCell(target, event);
            } else if (target.tagName === 'TH' && !isSortableHeader(target)) {
                window.admColumnHeaderFallback(event, target);
            }
        });
    }

    function enhanceTable(table) {
        if (!isEnhanceableTable(table)) return;
        enhanceHeaders(table);
        enhanceCells(table);
        bindTable(table);
    }

    function enhanceAll() {
        Array.from(document.querySelectorAll(TABLE_SELECTOR)).forEach(enhanceTable);
    }

    function scheduleEnhance() {
        window.clearTimeout(enhanceTimer);
        enhanceTimer = window.setTimeout(enhanceAll, 80);
    }

    ready(function () {
        enhanceAll();
        if (!window.MutationObserver || !document.body) return;
        const observer = new MutationObserver(function (mutations) {
            const hasTableMutation = mutations.some(function (mutation) {
                return Array.from(mutation.addedNodes || []).some(function (node) {
                    if (!node || node.nodeType !== 1) return false;
                    return (node.matches && node.matches('table, tr, td, th, .adm-table-wrap'))
                        || (node.querySelector && node.querySelector(TABLE_SELECTOR));
                });
            });
            if (hasTableMutation) scheduleEnhance();
        });
        observer.observe(document.body, { childList: true, subtree: true });
    });
})();
