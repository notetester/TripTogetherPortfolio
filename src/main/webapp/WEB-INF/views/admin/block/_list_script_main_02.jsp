<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
const blockSectionState = {};
let activeBlockTab = 'dashboard';

function escapeHtml(value) {
    if (value == null) return '';
    return String(value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
}

function formatNullable(value) {
    return value ? escapeHtml(value) : '<span style="color:#475569">—</span>';
}

function normalizeSearchValue(value) {
    return String(value || '').trim().toLowerCase();
}

function getLocalRows(section) {
    return Array.from(document.querySelectorAll('.js-local-row[data-section="' + section + '"]'));
}

function getLocalState(section) {
    if (!blockSectionState[section]) {
        blockSectionState[section] = {page: 1, pageSize: 20, sortKey: '', sortDir: 'ASC'};
    }
    return blockSectionState[section];
}

function updateTabQuery(tab) {
    const hiddenInput = document.getElementById('blockActiveTabInput');
    if (hiddenInput) {
        hiddenInput.value = tab;
    }
    const url = new URL(window.location.href);
    url.searchParams.set('tab', tab);
    window.history.replaceState({}, '', url.toString());
}

function resetBlockFilters() {
    const tab = activeBlockTab || (document.getElementById('blockActiveTabInput') || {}).value || 'dashboard';
    window.location.href = CTX + '/admin/blocks?tab=' + encodeURIComponent(tab);
    return false;
}

function activateBlockTab(tab) {
    const validTabs = ['dashboard', 'all', 'user-blocks', 'ip-rules', 'batches', 'histories'];
    activeBlockTab = validTabs.includes(tab) ? tab : 'dashboard';
    updateTabQuery(activeBlockTab);

    document.querySelectorAll('.js-block-tab').forEach(function (button) {
        button.classList.toggle('active', button.dataset.tab === activeBlockTab);
    });

    const dashboardPanel = document.querySelector('.js-dashboard-panel');
    if (dashboardPanel) {
        dashboardPanel.style.display = activeBlockTab === 'dashboard' ? '' : 'none';
    }

    document.querySelectorAll('.js-section-card').forEach(function (card) {
        const section = card.dataset.section;
        const visible = activeBlockTab === 'all' || (activeBlockTab !== 'dashboard' && activeBlockTab === section);
        card.style.display = visible ? '' : 'none';
    });
}

function ensureLocalEmptyRow(section, visibleCount) {
    const rows = getLocalRows(section);
    const sampleRow = rows[0];
    if (!sampleRow) return;

    const tbody = sampleRow.parentElement;
    const colspan = sampleRow.children.length || tbody.parentElement.querySelectorAll('thead th').length || 1;
    let emptyRow = tbody.querySelector('.adm-local-empty[data-section="' + section + '"]');

    if (visibleCount > 0) {
        if (emptyRow) emptyRow.remove();
        return;
    }

    if (!emptyRow) {
        emptyRow = document.createElement('tr');
        emptyRow.className = 'adm-local-empty';
        emptyRow.dataset.section = section;
        emptyRow.innerHTML = '<td colspan="' + colspan + '">' + escapeHtml(ADMIN_BLOCK_MSG.noMatchingData) + '</td>';
        tbody.appendChild(emptyRow);
    }
}

function filterLocalRows(section) {
    const config = BLOCK_SECTION_CONFIG[section];
    if (!config) return [];

    const keywordInput = document.querySelector('.js-local-keyword[data-section="' + section + '"]');
    const fieldSelect = document.querySelector('.js-local-field[data-section="' + section + '"]');
    const keyword = normalizeSearchValue(keywordInput ? keywordInput.value : '');
    const field = fieldSelect ? fieldSelect.value : 'all';
    const keys = config.fields[field] || config.fields.all;

    return getLocalRows(section).filter(function (row) {
        if (!keyword) return true;
        return keys.some(function (key) {
            return normalizeSearchValue(row.dataset[key] || '').includes(keyword);
        });
    });
}


function getSectionCard(section) {
    return document.querySelector('.js-section-card[data-section="' + section + '"]');
}

function getCellSortKey(td) {
    if (!td) return '';
    if (td.dataset && td.dataset.sortValue != null) return td.dataset.sortValue;
    return (td.innerText || '').replace(/\s+/g, ' ').trim();
}

function sortLocalRows(section, rows) {
    const state = getLocalState(section);
    const cellIndex = (state.sectionSortCell != null) ? state.sectionSortCell : -1;
    if (cellIndex < 0) {
        return rows.slice().sort(function (a, b) {
            return Number(a.dataset.originalIndex || 0) - Number(b.dataset.originalIndex || 0);
        });
    }
    const dir = state.sortDir === 'DESC' ? -1 : 1;
    return rows.slice().sort(function (a, b) {
        const av = getCellSortKey(a.children[cellIndex]);
        const bv = getCellSortKey(b.children[cellIndex]);
        const an = Number(av.replace(/[^0-9.-]/g, ''));
        const bn = Number(bv.replace(/[^0-9.-]/g, ''));
        let cmp;
        if (!Number.isNaN(an) && !Number.isNaN(bn) && av.match(/\d/) && bv.match(/\d/)) {
            cmp = an - bn;
        } else {
            cmp = av.localeCompare(bv, ADMIN_BLOCK_LOCALE || undefined, {numeric: true, sensitivity: 'base'});
        }
        return cmp * dir;
    });
}

function updateLocalSortIndicators(section) {
    const state = getLocalState(section);
    const card = getSectionCard(section);
    if (!card) return;
    const activeCellIndex = (state.sectionSortCell != null) ? state.sectionSortCell : -1;
    card.querySelectorAll('th[data-sort-index]').forEach(function (th) {
        const thIndex = Number(th.dataset.sortIndex);
        const active = (activeCellIndex >= 0 && thIndex === activeCellIndex);
        th.classList.toggle('sorted', active);
        let ico = th.querySelector('.sort-ico');
        if (active) {
            if (!ico) {
                ico = document.createElement('span');
                ico.className = 'sort-ico';
                ico.style.cssText = 'font-size:10px;margin-left:4px;';
                th.appendChild(ico);
            }
            ico.textContent = state.sortDir === 'DESC' ? '▼' : '▲';
            ico.style.color = state.sortDir === 'DESC' ? '#3b82f6' : '#ef4444';
        } else {
            if (ico) ico.remove();
        }
    });
    const resetBtn = card.querySelector('.js-section-sort-reset');
    if (resetBtn) {
        if (activeCellIndex >= 0) {
            resetBtn.textContent = ADMIN_BLOCK_MSG.dashSortReset;
            resetBtn.style.display = '';
        } else {
            resetBtn.style.display = 'none';
        }
    }
}

function sectionSort(section, cellIndex) {
    const state = getLocalState(section);
    const prevCell = (state.sectionSortCell != null) ? state.sectionSortCell : -1;
    const nextDir = (prevCell === cellIndex && state.sortDir === 'ASC') ? 'DESC' : 'ASC';
    state.sectionSortCell = cellIndex;
    state.sortDir = nextDir;
    state.page = 1;
    renderSectionByMode(section);
}

function sectionSortReset(section) {
    const state = getLocalState(section);
    state.sectionSortCell = null;
    state.sortDir = 'ASC';
    state.page = 1;
    renderSectionByMode(section);
}

function ensureOriginalIndices() {
    ['user-blocks', 'ip-rules', 'batches', 'histories'].forEach(function (section) {
        getLocalRows(section).forEach(function (row, idx) {
            if (row.dataset.originalIndex == null) {
                row.dataset.originalIndex = String(idx);
            }
        });
    });
}

// ================ 모드 토글 (CLIENT 전체 로드 / SERVER 페이지 단위) ================
// 디폴트는 SERVER — 첫 진입 비용을 LIMIT만큼만으로 절감.
// 모드는 쿠키(서버 인식용) + localStorage(미러) 양쪽에 저장.
const SECTION_MODE_STORAGE = 'admBlockSectionMode';
const SECTION_COOKIE_NAME = {
    'histories':   'admBlockHistMode',
    'ip-rules':    'admBlockIprMode',
    'user-blocks': 'admBlockUbMode',
    'batches':     'admBlockBatMode'
};

function setSectionCookie(section, mode) {
    const name = SECTION_COOKIE_NAME[section];
    if (!name) return;
    document.cookie = name + '=' + (mode === 'SERVER' ? 'server' : 'client') + ';path=' + (CTX || '/') + ';max-age=31536000;samesite=lax';
}

function loadStoredSectionModes() {
    try {
        const raw = localStorage.getItem(SECTION_MODE_STORAGE);
        if (!raw) return {};
        return JSON.parse(raw) || {};
    } catch (e) { return {}; }
}

function saveSectionMode(section, mode) {
    try {
        const stored = loadStoredSectionModes();
        stored[section] = mode;
        localStorage.setItem(SECTION_MODE_STORAGE, JSON.stringify(stored));
    } catch (e) {}
    setSectionCookie(section, mode);
}

function getSectionMode(section) {
    const state = getLocalState(section);
    return state.mode === 'SERVER' ? 'SERVER' : 'CLIENT';
}

window.getSectionMode = getSectionMode;

function initSectionModes() {
    const stored = loadStoredSectionModes();
    ['user-blocks', 'ip-rules', 'batches', 'histories'].forEach(function (section) {
        const state = getLocalState(section);
        // 명시적으로 CLIENT가 저장된 경우만 CLIENT, 그 외(미설정 포함) SERVER가 디폴트
        state.mode = stored[section] === 'CLIENT' ? 'CLIENT' : 'SERVER';
        // 쿠키도 동기화 (서버가 인식할 수 있도록)
        setSectionCookie(section, state.mode);
    });
    document.querySelectorAll('.js-section-mode').forEach(function (sel) {
        const section = sel.dataset.section;
        const state = getLocalState(section);
        sel.value = state.mode === 'SERVER' ? 'server' : 'client';
        sel.addEventListener('change', function () {
            const mode = sel.value === 'server' ? 'SERVER' : 'CLIENT';
            state.mode = mode;
            saveSectionMode(section, mode);
            // 모드 전환은 페이지 새로고침으로 단순화 (서버는 쿠키 보고 데이터 분기)
            location.reload();
        });
    });
}

function sortKeyForCellIndex(section, cellIndex) {
    if (cellIndex == null || cellIndex < 0) return '';
    if (section === 'histories') {
        // 인덱스: 0=checkbox, 1=time, 2=target, 3=actionLabel, 4=changeKind, 5=result, 6=reason, 7=action
        const map = {1:'time', 2:'target', 3:'actionLabel', 4:'changeKind', 5:'result', 6:'reason'};
        return map[cellIndex] || '';
    }
    if (section === 'ip-rules') {
        // 인덱스: 0=checkbox, 1=target, 2=actionControl, 3=batch, 4=status, 5=priority, 6=reason, 7=action
        const map = {1:'target', 2:'actionControl', 3:'batch', 4:'status', 5:'priority', 6:'reason'};
        return map[cellIndex] || '';
    }
    if (section === 'batches') {
        // 인덱스: 0=checkbox, 1=batch, 2=basePolicy, 3=priority, 4=currentState, 5=ruleStats, 6=description, 7=action
        const map = {1:'batch', 2:'basePolicy', 3:'priority', 4:'currentState', 5:'ruleStats', 6:'description'};
        return map[cellIndex] || '';
    }
    if (section === 'user-blocks') {
        // 인덱스: 0=checkbox, 1=member, 2=blockType, 3=target, 4=status, 5=reason, 6=blockedAt, 7=action
        const map = {1:'member', 2:'blockType', 3:'target', 4:'status', 5:'reason', 6:'blockedAt'};
        return map[cellIndex] || '';
    }
    return '';
}

const SECTION_FETCH_CONFIG = {
    'histories': {
        fragmentUrl: '/admin/blocks/api/histories/fragment',
        splitMarker: '<!--HISTORY-FRAGMENT-SPLIT-->',
        detailAreaId: 'histDetailArea',
        detailUrlPrefix: '/admin/blocks/api/histories/'
    },
    'ip-rules': {
        fragmentUrl: '/admin/blocks/api/ip-rules/fragment',
        splitMarker: '<!--IPRULE-FRAGMENT-SPLIT-->',
        detailAreaId: 'iprDetailArea',
        detailUrlPrefix: '/admin/blocks/api/ip-rules/'
    },
    'batches': {
        fragmentUrl: '/admin/blocks/api/batches/fragment',
        splitMarker: '<!--BATCH-FRAGMENT-SPLIT-->',
        detailAreaId: 'batDetailArea',
        detailUrlPrefix: '/admin/blocks/api/batches/'
    },
    'user-blocks': {
        fragmentUrl: '/admin/blocks/api/user-blocks/fragment',
        splitMarker: '<!--USERBLOCK-FRAGMENT-SPLIT-->',
        detailAreaId: 'ubDetailArea',
        detailUrlPrefix: '/admin/blocks/api/user-blocks/'
    }
};

async function renderServerSection(section) {
    const cfg = SECTION_FETCH_CONFIG[section];
    if (!cfg) return; // 아직 SERVER 모드 미지원 섹션
    const state = getLocalState(section);
    const card = getSectionCard(section);
    if (!card) return;

    const fieldEl = card.querySelector('.js-local-field');
    const keywordEl = card.querySelector('.js-local-keyword');
    const sortBy = sortKeyForCellIndex(section, state.sectionSortCell);
    const params = new URLSearchParams();
    params.set('page', String(state.page || 1));
    params.set('size', String(state.pageSize || 20));
    if (sortBy) {
        params.set('sortBy', sortBy);
        params.set('sortDir', state.sortDir === 'ASC' ? 'ASC' : 'DESC');
    }
    if (fieldEl && fieldEl.value) params.set('field', fieldEl.value);
    if (keywordEl && keywordEl.value) params.set('keyword', keywordEl.value);

    try {
        const res = await fetch(CTX + cfg.fragmentUrl + '?' + params.toString(), {
            credentials: 'same-origin',
            headers: {'Accept': 'text/html'}
        });
        if (!res.ok) throw new Error('HTTP ' + res.status);
        const html = await res.text();
        const split = html.split(cfg.splitMarker);
        const rowsHtml = (split[0] || '').trim();
        const detailsHtml = (split[1] || '').trim();

        const tbody = card.querySelector('tbody');
        if (tbody) tbody.innerHTML = rowsHtml;
        const detailArea = document.getElementById(cfg.detailAreaId);
        if (detailArea) detailArea.innerHTML = detailsHtml;

        const total = Number(res.headers.get('X-Section-Total') || 0);
        const currentPage = Number(res.headers.get('X-Section-Page') || state.page || 1);
        const totalPages = Math.max(1, Number(res.headers.get('X-Section-Pages') || 1));
        state.page = currentPage;
        updateServerPageMeta(section, currentPage, totalPages, total);
        updateLocalSortIndicators(section);
    } catch (e) {
        if (typeof notice === 'function') notice(ADMIN_BLOCK_MSG.serverFetchError);
    }
}


</script>
