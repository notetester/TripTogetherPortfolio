<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
function renderLocalSection(section) {
    const state = getLocalState(section);
    const filteredRows = sortLocalRows(section, filterLocalRows(section));
    const total = filteredRows.length;
    const pageSize = Math.max(1, Number(state.pageSize || 20));
    const totalPages = Math.max(1, Math.ceil(total / pageSize));

    if (state.page > totalPages) {
        state.page = totalPages;
    }
    if (state.page < 1) {
        state.page = 1;
    }

    const start = (state.page - 1) * pageSize;
    const end = start + pageSize;

    getLocalRows(section).forEach(function (row) {
        row.style.display = 'none';
    });
    const visibleRows = filteredRows.slice(start, end);
    if (visibleRows.length) {
        const tbody = visibleRows[0].parentElement;
        visibleRows.forEach(function (row) {
            tbody.appendChild(row);
            row.style.display = '';
        });
    }

    ensureLocalEmptyRow(section, visibleRows.length);
    updateLocalSortIndicators(section);
    updateBlockBulkBar(section);

    const info = document.querySelector('.js-local-page-info[data-section="' + section + '"]');
    const pageState = document.querySelector('.js-local-page-state[data-section="' + section + '"]');
    const prevBtn = document.querySelector('.js-local-prev[data-section="' + section + '"]');
    const nextBtn = document.querySelector('.js-local-next[data-section="' + section + '"]');

    if (info) {
        const shown = total === 0 ? 0 : Math.min(total, end) - start;
        info.textContent = ADMIN_BLOCK_MSG.totalCountFormat.replace('{0}', total) + ' / ' + ADMIN_BLOCK_MSG.currentCountFormat.replace('{0}', shown);
    }
    if (pageState) {
        pageState.textContent = state.page + ' / ' + totalPages;
    }
    if (prevBtn) prevBtn.disabled = state.page <= 1;
    if (nextBtn) nextBtn.disabled = state.page >= totalPages;
}

function initializeLocalSections() {
    Object.keys(BLOCK_SECTION_CONFIG).forEach(function (section) {
        const pageSizeSelect = document.querySelector('.js-local-page-size[data-section="' + section + '"]');
        const fieldSelect = document.querySelector('.js-local-field[data-section="' + section + '"]');
        const keywordInput = document.querySelector('.js-local-keyword[data-section="' + section + '"]');
        const resetButton = document.querySelector('.js-local-reset[data-section="' + section + '"]');

        const state = getLocalState(section);
        if (pageSizeSelect) {
            state.pageSize = Number(pageSizeSelect.value || 20);
            pageSizeSelect.addEventListener('change', function () {
                state.pageSize = Number(pageSizeSelect.value || 20);
                state.page = 1;
                renderSectionByMode(section);
            });
        }
        if (fieldSelect) {
            fieldSelect.addEventListener('change', function () {
                state.page = 1;
                renderSectionByMode(section);
            });
        }
        if (keywordInput) {
            keywordInput.addEventListener('input', function () {
                state.page = 1;
                renderSectionByMode(section);
            });
        }
        if (resetButton) {
            resetButton.addEventListener('click', function () {
                if (fieldSelect) fieldSelect.value = 'all';
                if (keywordInput) keywordInput.value = '';
                state.page = 1;
                renderSectionByMode(section);
            });
        }
        renderSectionByMode(section);
    });
}

function applyBlockLocalFilter(section, field, keyword) {
    const fieldSelect = document.querySelector('.js-local-field[data-section="' + section + '"]');
    const keywordInput = document.querySelector('.js-local-keyword[data-section="' + section + '"]');
    if (fieldSelect) fieldSelect.value = field || 'all';
    if (keywordInput) keywordInput.value = keyword || '';
    const state = getLocalState(section);
    state.page = 1;
    activateBlockTab(section);
    renderSectionByMode(section);
}

function blockSortBy(section, field) { /* deprecated — use sectionSort */ }
function blockToggleAll(section) {
    const checkAll = document.querySelector('.js-block-check-all[data-section="' + section + '"]');
    const checked = checkAll ? checkAll.checked : false;
    getLocalRows(section).forEach(function(row) {
        if (row.style.display === 'none') return;
        const cb = row.querySelector('.js-block-row-check');
        if (cb) cb.checked = checked;
    });
    updateBlockBulkBar(section);
}
function exportBlockData(section, scope) { exportBlockSection(section, scope); }
function bulkReleaseUserBlocks() { bulkReleaseSelectedUserBlocks(); }
function bulkToggleIpRules(active) { bulkToggleSelectedIpRules(active); }
function blockClearSelection(section) { clearBlockSelection(section); }

function findFirstButton(selector, predicate) {
    const buttons = Array.from(document.querySelectorAll(selector));
    return buttons.find(predicate) || null;
}

function hasUsefulDatasetValue(value) {
    return value !== undefined && value !== null && String(value).trim() !== '';
}

function resolveButtonByKey(button, selector, key, requiredKeys) {
    if (!button || !key || !hasUsefulDatasetValue(button.dataset[key])) {
        return button || null;
    }

    const currentValue = String(button.dataset[key]);
    const resolvedButton = findFirstButton(selector, function (candidate) {
        if (String(candidate.dataset[key] || '') !== currentValue) {
            return false;
        }
        if (!Array.isArray(requiredKeys) || !requiredKeys.length) {
            return true;
        }
        return requiredKeys.every(function (requiredKey) {
            return hasUsefulDatasetValue(candidate.dataset[requiredKey]);
        });
    });

    return resolvedButton || button;
}

function resolveUserBlockEditorButton(button) {
    return resolveButtonByKey(button, '.js-open-user-block-editor', 'blockIdx', [
        'blockIdx',
        'targetKey',
        'blockType',
        'snapshotStatus',
        'templateId'
    ]);
}

function resolveIpRuleEditorButton(button) {
    return resolveButtonByKey(button, '.js-open-ip-rule-editor', 'id', [
        'id',
        'targetKey',
        'ruleAction',
        'controlMode',
        'templateId'
    ]);
}

function resolveHistoryCurrentButton(button) {
    return resolveButtonByKey(button, '.js-open-history-current', 'historyId', [
        'historyId',
        'templateId'
    ]);
}

function formatDateTime(value) {
    if (!value) return '—';

    const date = new Date(value);
    if (Number.isNaN(date.getTime())) return escapeHtml(value);

    return date.toLocaleString(ADMIN_BLOCK_LOCALE || undefined, {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    });
}

function formatHistoryDateTime(value) {
    if (!value) return '—';

    const date = new Date(value);
    if (Number.isNaN(date.getTime())) return escapeHtml(value);

    return date.toLocaleString(ADMIN_BLOCK_LOCALE || undefined, {
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    });
}

function formatBooleanBadge(value) {
    return value
        ? '<span style="color:#4ade80">✓ ${msg_admin_common_yes_js}</span>'
        : '<span style="color:#475569">✗ ${msg_admin_common_no_js}</span>';
}

function buildStatusBadge(status) {
    const safe = escapeHtml(status || '');
    return '<span class="status-badge ' + safe + '">' + (safe || '—') + '</span>';
}

function buildRoleBadge(role) {
    const safe = escapeHtml(role || '');
    return '<span class="role-badge ' + safe + '">' + (safe || '—') + '</span>';
}

function buildSocialHtml(linkedProviders) {
    if (!linkedProviders) {
        return '<span class="adm-social-empty">${msg_admin_members_noLinkedProvider_js}</span>';
    }

    const providerMap = {
        KAKAO: {
            label: '${msg_admin_social_kakao_js}',
            className: 'kakao',
            icon: '<span class="adm-social-icon kakao-mark">k</span>'
        },
        NAVER: {
            label: '${msg_admin_social_naver_js}',
            className: 'naver',
            icon: '<span class="adm-social-icon naver-mark">N</span>'
        },
        GOOGLE: {
            label: '${msg_admin_social_google_js}',
            className: 'google',
            icon: '<span class="adm-social-icon google-mark"><svg viewBox="0 0 48 48" aria-hidden="true" focusable="false"><path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/><path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/><path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/><path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.36-8.16 2.36-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/></svg></span>'
        }
    };

    const items = linkedProviders
        .split(',')
        .map(provider => provider.trim())
        .filter(provider => provider.length > 0)
        .map(function(provider) {
            const info = providerMap[provider];
            if (!info) {
                return '<span class="adm-social-pill"><span class="adm-social-label">' + escapeHtml(provider) + '</span></span>';
            }
            return '<span class="adm-social-pill ' + info.className + '">' + info.icon + '<span class="adm-social-label">' + escapeHtml(info.label) + '</span></span>';
        });

    if (!items.length) {
        return '<span class="adm-social-empty">${msg_admin_members_noLinkedProvider_js}</span>';
    }

    return '<div class="adm-social-list">' + items.join('') + '</div>';
}

function buildMemberInfoTab(member) {
    const statusBadge = buildStatusBadge(member.accountStatus);
    const roleBadge = buildRoleBadge(member.userRole);
    const socialHtml = buildSocialHtml(member.linkedProviders);
    const lastLoginText = formatDateTime(member.lastLoginAt);

    return ''
        + '<div class="detail-grid">'
        + '<div class="detail-item"><div class="detail-label">${msg_admin_context_memberNo_js}</div><div class="detail-value">#' + escapeHtml(member.userIdx) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">${msg_admin_context_userId_js}</div><div class="detail-value">' + formatNullable(member.userId) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">${msg_admin_context_nickname_js}</div><div class="detail-value">' + formatNullable(member.nickname) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">${msg_admin_context_email_js}</div><div class="detail-value" style="font-size:12px;">' + formatNullable(member.userEmail) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">${msg_admin_members_accountStatus_js}</div><div class="detail-value">' + statusBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">${msg_admin_common_role_js}</div><div class="detail-value">' + roleBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">${msg_admin_context_nationality_js}</div><div class="detail-value">' + formatNullable(member.nationality) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">${msg_admin_context_preferredLanguage_js}</div><div class="detail-value">' + formatNullable(member.preferredLang) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">${msg_admin_members_emailVerified_js}</div><div class="detail-value">' + formatBooleanBadge(member.emailVerified) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">${msg_admin_members_emailLoginEnabled_js}</div><div class="detail-value">' + formatBooleanBadge(member.emailLoginEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">${msg_admin_members_passwordLoginEnabled_js}</div><div class="detail-value">' + formatBooleanBadge(member.passwordEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">${msg_admin_context_createdAt_js}</div><div class="detail-value" style="font-size:12px;">' + formatDateTime(member.createdAt) + '</div></div>'
        + '</div>'
        + '<div class="detail-item" style="margin-top:12px;">'
        + '<div class="detail-label">${msg_admin_members_socialLinked_js}</div>'
        + '<div class="detail-value" style="margin-top:4px;">' + socialHtml + '</div>'
        + '</div>'
        + '<div style="margin-top:12px;display:flex;gap:8px;flex-wrap:wrap;">'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">${msg_admin_members_loginSuccess_js}</div>'
        + '<div style="font-size:20px;font-weight:700;color:#4ade80;margin-top:4px;">' + escapeHtml(member.loginSuccessCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">${msg_admin_members_loginFailure_js}</div>'
        + '<div style="font-size:20px;font-weight:700;color:#f87171;margin-top:4px;">' + escapeHtml(member.loginFailCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:120px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">${msg_admin_context_lastLogin_js}</div>'
        + '<div style="font-size:12px;font-weight:600;color:#94a3b8;margin-top:4px;">' + escapeHtml(lastLoginText) + '</div>'
        + '</div>'
        + '</div>';
}

function buildMemberHistTab(history) {
    if (!history.length) {
        return '<div style="text-align:center;padding:32px;color:#475569;">${msg_admin_context_empty_logins_js}</div>';
    }

    const methodMap = {
        ID: '${msg_admin_context_userId_js}',
        EMAIL: '${msg_admin_context_email_js}',
        KAKAO: '${msg_admin_social_kakao_js}',
        NAVER: '${msg_admin_social_naver_js}',
        GOOGLE: '${msg_admin_social_google_js}'
    };

    let rows = '';
    history.forEach(function(item) {
        const ok = !!item.success;
        rows += ''
            + '<tr>'
            + '<td>' + escapeHtml(formatHistoryDateTime(item.loginAt)) + '</td>'
            + '<td>' + escapeHtml(methodMap[item.loginMethod] || item.loginMethod || '—') + '</td>'
            + '<td class="' + (ok ? 'h-success' : 'h-fail') + '">' + (ok ? '✅ ${msg_admin_logs_success_js}' : '❌ ${msg_admin_logs_failure_js}') + '</td>'
            + '<td>' + escapeHtml(item.failReason || '—') + '</td>'
            + '<td style="font-size:11px;color:#475569;">' + escapeHtml(item.ipAddress || '—') + '</td>'
            + '</tr>';
    });

    return ''
        + '<div style="overflow-x:auto;max-height:340px;overflow-y:auto;">'
        + '<table class="history-table">'
        + '<thead><tr>'
        +   '<th onclick="blockHistoryThClick(this)">${msg_admin_common_time_js}</th>'
        +   '<th onclick="blockHistoryThClick(this)">${msg_admin_logs_provider_js}</th>'
        +   '<th onclick="blockHistoryThClick(this)">${msg_admin_blocks_result_js}</th>'
        +   '<th onclick="blockHistoryThClick(this)">${msg_admin_logs_failReason_js}</th>'
        +   '<th onclick="blockHistoryThClick(this)">${msg_admin_common_ip_js}</th>'
        + '</tr></thead>'
        + '<tbody>' + rows + '</tbody>'
        + '</table>'
        + '</div>';
}

function switchMemberTab(tab, btn) {
    document.querySelectorAll('#memberDetailModal .adm-tab').forEach(function(tabButton) {
        tabButton.classList.remove('active');
    });
    btn.classList.add('active');
    document.getElementById('member-detail-tab-info').style.display = tab === 'info' ? '' : 'none';
    document.getElementById('member-detail-tab-hist').style.display = tab === 'hist' ? '' : 'none';
}

async function openMemberDetailModal(userIdx) {
    if (!userIdx) return;

    document.getElementById('memberDetailModal').classList.add('open');
    document.getElementById('memberDetailBody').innerHTML =
        '<div style="text-align:center;padding:40px;color:#475569;">' + escapeHtml(ADMIN_BLOCK_MSG.loading) + ' ⏳</div>';

    const res = await fetch(CTX + '/admin/members/' + userIdx, {
        headers: {'X-Requested-With': 'XMLHttpRequest'}
    });
    const data = await res.json();

    if (!data.success) {
        document.getElementById('memberDetailBody').innerHTML =
            '<div style="text-align:center;padding:40px;color:#f87171;">' + escapeHtml(data.message || ADMIN_BLOCK_MSG.fetchError) + '</div>';
        return;
    }

    const member = data.member || {};
    const history = Array.isArray(data.history) ? data.history : [];
    document.getElementById('memberDetailTitle').textContent = ADMIN_BLOCK_MSG.memberTitle;
    document.getElementById('memberDetailBody').innerHTML = ''
        + '<div class="adm-tabs">'
        + '<button class="adm-tab active" onclick="switchMemberTab(\'info\', this)">' + escapeHtml(ADMIN_BLOCK_MSG.tabInfo) + '</button>'
        + '<button class="adm-tab" onclick="switchMemberTab(\'hist\', this)">' + escapeHtml(ADMIN_BLOCK_MSG.tabLogins) + ' (' + history.length + ')</button>'
        + '</div>'
        + '<div id="member-detail-tab-info">' + buildMemberInfoTab(member) + '</div>'
        + '<div id="member-detail-tab-hist" style="display:none;">' + buildMemberHistTab(history) + '</div>';
}

/* ── 헤더 클릭: 차단 모달 내 history-table 첫 행의 같은 컬럼 셀 액션을 트리거 ── */
function blockHistoryThClick(th) {
    var table = th.closest('table');
    var firstRow = table && table.querySelector('tbody tr');
    if (!firstRow) return;
    var cell = firstRow.children[th.cellIndex];
    if (!cell) return;
    var target = cell.querySelector('button, a[href]');
    if (target) target.click();
}

</script>
