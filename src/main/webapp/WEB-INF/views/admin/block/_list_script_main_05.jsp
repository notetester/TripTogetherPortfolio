<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
function openIpRuleModal() {
    document.getElementById('ipRuleModal').classList.add('open');
    handleIpRuleTypeChange();
    handleIpBatchChange();
}

function openBatchModal() {
    document.getElementById('batchModal').classList.add('open');
}

function openBatchEditor(button) {
    const resolvedButton = button.dataset.sourceType
        ? button
        : findFirstButton('.js-open-batch-editor', function (candidate) {
            return candidate.dataset.batchId === button.dataset.batchId && candidate.dataset.sourceType;
        });

    if (!resolvedButton) {
        adm_toast(ADMIN_BLOCK_MSG.batchSettingsNotFound, 'error');
        return;
    }

    document.getElementById('batchEditId').value = resolvedButton.dataset.batchId || '';
    document.getElementById('batchEditTitle').textContent = resolvedButton.dataset.batchName || '${msg_admin_blocks_batches_editTitle_js}';
    document.getElementById('batchEditStatus').textContent = resolvedButton.dataset.statusLabel || '-';
    document.getElementById('batchEditUpdatedAt').textContent = resolvedButton.dataset.updatedAt || '-';
    document.getElementById('batchEditCreatedAt').textContent = resolvedButton.dataset.createdAt || '-';
    document.getElementById('batchEditStats').textContent = ADMIN_BLOCK_MSG.totalCountFormat.replace('{0}', resolvedButton.dataset.totalRules || '0')
        + ' / ' + ADMIN_BLOCK_MSG.ruleOn + ' ' + (resolvedButton.dataset.activeRules || '0')
        + ' / ' + ADMIN_BLOCK_MSG.effectiveOn + ' ' + (resolvedButton.dataset.effectiveRules || '0')
        + ' / ' + ADMIN_BLOCK_MSG.expired + ' ' + (resolvedButton.dataset.expiredRules || '0');
    document.getElementById('batchEditCode').value = resolvedButton.dataset.batchCode || '';
    document.getElementById('batchEditName').value = resolvedButton.dataset.batchName || '';
    document.getElementById('batchEditSourceType').value = resolvedButton.dataset.sourceType || 'MANUAL';
    document.getElementById('batchEditSourceName').value = resolvedButton.dataset.sourceName || '';
    document.getElementById('batchEditRuleAction').value = resolvedButton.dataset.batchRuleAction || 'BLOCK';
    document.getElementById('batchEditPriority').value = resolvedButton.dataset.defaultPriority || '1';
    document.getElementById('batchEditDisableStrategy').value = resolvedButton.dataset.defaultDisableStrategy || 'BATCH_ONLY';
    document.getElementById('batchEditEnableStrategy').value = resolvedButton.dataset.defaultEnableStrategy || 'BATCH_ONLY';
    document.getElementById('batchEditDescription').value = resolvedButton.dataset.description || '';
    document.getElementById('batchEditModal').classList.add('open');
}

function closeModal(id) {
    document.getElementById(id).classList.remove('open');
}

function handleIpRuleTypeChange() {
    const type = document.getElementById('ipMatchType').value;
    document.getElementById('fieldSingleIp').style.display = type === 'SINGLE_IP' ? '' : 'none';
    document.getElementById('fieldCidr').style.display = type === 'CIDR' ? '' : 'none';
    document.getElementById('fieldRangeStart').style.display = type === 'RANGE' ? '' : 'none';
    document.getElementById('fieldRangeEnd').style.display = type === 'RANGE' ? '' : 'none';
    document.getElementById('fieldCountry').style.display = type === 'COUNTRY' ? '' : 'none';
    document.getElementById('fieldAsn').style.display = type === 'ASN' ? '' : 'none';
}

function handleIpBatchChange() {
    const batchId = document.getElementById('ipBatchIdx').value;
    const controlMode = document.getElementById('ipControlMode');
    if (!batchId) {
        controlMode.value = 'MANUAL';
    } else if (controlMode.value === 'MANUAL') {
        controlMode.value = 'BATCH';
    }
}


function sectionFromDetailTemplateId(templateId) {
    if (!templateId) return '';
    if (templateId.indexOf('detail-user-') === 0) return 'user-blocks';
    if (templateId.indexOf('detail-ip-') === 0) return 'ip-rules';
    if (templateId.indexOf('detail-batch-') === 0) return 'batches';
    if (templateId.indexOf('detail-history-') === 0) return 'histories';
    return '';
}

function idFromDetailTemplateId(templateId) {
    return String(templateId || '').replace(/^detail-(user|ip|batch|history)-/, '');
}

async function fetchBlockDetailTemplate(templateId, force) {
    const existing = templateId ? document.getElementById(templateId) : null;
    if (!templateId) return false;
    if (existing && !force) return true;
    if (existing && force) existing.remove();
    const section = sectionFromDetailTemplateId(templateId);
    const cfg = SECTION_FETCH_CONFIG[section];
    if (!cfg || !cfg.detailUrlPrefix) return false;
    const id = idFromDetailTemplateId(templateId);
    if (!id) return false;
    try {
        const res = await fetch(CTX + cfg.detailUrlPrefix + encodeURIComponent(id) + '/detail', {
            credentials: 'same-origin',
            headers: {'Accept': 'text/html'}
        });
        if (!res.ok) throw new Error('HTTP ' + res.status);
        const html = (await res.text()).trim();
        if (!html) return false;
        const detailArea = document.getElementById(cfg.detailAreaId);
        if (!detailArea) return false;
        detailArea.insertAdjacentHTML('beforeend', html);
        return !!document.getElementById(templateId);
    } catch (e) {
        console.error('block detail fetch failed', e);
        return false;
    }
}
window.sectionFromDetailTemplateId = sectionFromDetailTemplateId;
window.fetchBlockDetailTemplate = fetchBlockDetailTemplate;

function openBlockDetail(templateId, title) {
    if (window.TripAdminBlockDetailFallback && typeof window.TripAdminBlockDetailFallback.open === 'function') {
        return window.TripAdminBlockDetailFallback.open(templateId, title);
    }
    const template = document.getElementById(templateId);
    if (!template) {
        adm_toast(ADMIN_BLOCK_MSG.fetchError, 'error');
        return;
    }

    const modal = document.getElementById('blockDetailModal');
    const body = document.getElementById('blockDetailBody');
    document.getElementById('blockDetailTitle').textContent = title || ADMIN_BLOCK_MSG.blockDetailTitle;

    body.innerHTML = '';
    if (template.content) {
        body.appendChild(document.importNode(template.content, true));
    } else {
        body.innerHTML = template.innerHTML;
    }
    modal.classList.add('open');

    if (window.TripAdminTranslation && typeof window.TripAdminTranslation.scan === 'function') {
        try {
            window.TripAdminTranslation.scan(body);
        } catch (error) {
            console.error('block detail translation scan failed', error);
        }
    }
}

async function openBlockDetailFromButton(button) {
    if (!button) {
        adm_toast(ADMIN_BLOCK_MSG.fetchError, 'error');
        return false;
    }
    const templateId = button.dataset.templateId;
    const section = sectionFromDetailTemplateId(templateId);
    const forceDetailFetch = section && getSectionMode(section) === 'SERVER';
    if (templateId && (forceDetailFetch || !document.getElementById(templateId))) {
        const loaded = await fetchBlockDetailTemplate(templateId, forceDetailFetch);
        if (!loaded) {
            adm_toast(ADMIN_BLOCK_MSG.fetchError, 'error');
            return false;
        }
    }
    openBlockDetail(templateId, button.dataset.detailTitle || ADMIN_BLOCK_MSG.blockDetailTitle);
    return false;
}

function applyExpiryPreset(targetId, days) {
    const input = document.getElementById(targetId);
    if (!input) return;
    const base = new Date();
    base.setMinutes(base.getMinutes() - base.getTimezoneOffset());
    const result = new Date(base.getTime() + (Number(days) * 24 * 60 * 60 * 1000));
    input.value = result.toISOString().slice(0, 16);
}

function clearExpiryPreset(targetId) {
    const input = document.getElementById(targetId);
    if (input) {
        input.value = '';
    }
}

function fillIpRuleEditControlModes(hasBatch, currentMode) {
    const select = document.getElementById('ipRuleEditControlMode');
    if (!select) return;

    if (hasBatch) {
        select.innerHTML = ''
            + '<option value="BATCH">${msg_admin_blocks_control_batch_js}</option>'
            + '<option value="MANUAL_OVERRIDE">${msg_admin_blocks_control_override_js}</option>';
        select.value = currentMode === 'MANUAL_OVERRIDE' ? 'MANUAL_OVERRIDE' : 'BATCH';
    } else {
        select.innerHTML = '<option value="MANUAL">${msg_admin_blocks_control_manual_js}</option>';
        select.value = 'MANUAL';
    }
}

function openUserBlockEditor(button) {
    const resolvedButton = resolveUserBlockEditorButton(button);
    if (!resolvedButton || !resolvedButton.dataset.blockIdx) {
        adm_toast(ADMIN_BLOCK_MSG.fetchError, 'error');
        return;
    }

    const userIdx = resolvedButton.dataset.userIdx || '';
    const displayName = resolvedButton.dataset.displayName || '-';
    const userId = resolvedButton.dataset.userId || '';
    const userEmail = resolvedButton.dataset.userEmail || '';

    document.getElementById('userBlockEditId').value = resolvedButton.dataset.blockIdx;
    document.getElementById('userBlockEditTemplateId').value = resolvedButton.dataset.templateId || '';
    document.getElementById('userBlockEditTitle').textContent = '${msg_admin_blocks_userBlocks_editTitle_js}';

    let memberHtml = escapeHtml(displayName);
    if (userIdx) {
        memberHtml = '<button type="button" class="adm-inline-link js-open-member-detail" data-user-idx="' + escapeHtml(userIdx) + '" style="color:#93c5fd;">' + escapeHtml(displayName) + '</button>';
    }
    if (userId) {
        memberHtml += '<div style="font-size:12px;color:#94a3b8;margin-top:4px;">' + escapeHtml(userId) + '</div>';
    }
    if (userEmail) {
        memberHtml += '<div style="font-size:12px;color:#64748b;margin-top:4px;">' + escapeHtml(userEmail) + '</div>';
    }

    document.getElementById('userBlockEditMember').innerHTML = memberHtml;
    document.getElementById('userBlockEditTarget').textContent = resolvedButton.dataset.targetKey || '-';
    document.getElementById('userBlockEditType').textContent = resolvedButton.dataset.blockType || '-';
    document.getElementById('userBlockEditStatus').textContent = (resolvedButton.dataset.active === 'true' ? ADMIN_BLOCK_MSG.keepBlocked : ADMIN_BLOCK_MSG.releaseBlock) + ' / ' + (resolvedButton.dataset.snapshotStatus || '-');
    document.getElementById('userBlockEditBlockedAt').textContent = resolvedButton.dataset.blockedAt || '-';
    document.getElementById('userBlockEditSyncAt').textContent = resolvedButton.dataset.syncAt || '-';
    document.getElementById('userBlockEditActive').value = resolvedButton.dataset.active === 'true' ? 'true' : 'false';
    document.getElementById('userBlockEditExpiresAt').value = resolvedButton.dataset.expiresAt || '';
    document.getElementById('userBlockEditReason').value = resolvedButton.dataset.reason || '';
    document.getElementById('userBlockEditHistoryBtn').onclick = function () {
        closeModal('userBlockEditModal');
        openBlockDetail(resolvedButton.dataset.templateId, ADMIN_BLOCK_MSG.userBlockHistory);
    };
    document.getElementById('userBlockEditModal').classList.add('open');
}

function openIpRuleEditor(button) {
    const resolvedButton = resolveIpRuleEditorButton(button);
    if (!resolvedButton || !resolvedButton.dataset.id) {
        adm_toast(ADMIN_BLOCK_MSG.fetchError, 'error');
        return;
    }

    const batchId = resolvedButton.dataset.batchId || '';
    const hasBatch = batchId !== '';
    const batchLabel = hasBatch
        ? (resolvedButton.dataset.batchName || '-') + (resolvedButton.dataset.batchCode ? ' (' + resolvedButton.dataset.batchCode + ')' : '')
        : ADMIN_BLOCK_MSG.individualRule;

    document.getElementById('ipRuleEditId').value = resolvedButton.dataset.id;
    document.getElementById('ipRuleEditTemplateId').value = resolvedButton.dataset.templateId || '';
    document.getElementById('ipRuleEditHasBatch').value = hasBatch ? 'true' : 'false';
    document.getElementById('ipRuleEditTitle').textContent = '${msg_admin_blocks_ipRules_editTitle_js}';
    document.getElementById('ipRuleEditTarget').textContent = (resolvedButton.dataset.targetDisplay || '-') + ' / ' + (resolvedButton.dataset.targetKey || '-');
    document.getElementById('ipRuleEditBatch').textContent = batchLabel + ' / ' + (resolvedButton.dataset.batchStatusLabel || ADMIN_BLOCK_MSG.individualRule);
    document.getElementById('ipRuleEditRuleState').textContent = resolvedButton.dataset.ruleStateLabel || '-';
    document.getElementById('ipRuleEditFinalState').textContent = (resolvedButton.dataset.finalStateLabel || '-') + ' / ' + (resolvedButton.dataset.effectiveStatusLabel || '-');
    document.getElementById('ipRuleEditBlockedAt').textContent = resolvedButton.dataset.blockedAt || '-';
    document.getElementById('ipRuleEditExpiresDisplay').textContent = resolvedButton.dataset.expiresDisplay || '${fn:escapeXml(msg_admin_members_none)}';
    document.getElementById('ipRuleEditAction').value = resolvedButton.dataset.ruleAction || 'BLOCK';
    document.getElementById('ipRuleEditCategory').value = resolvedButton.dataset.blockCategory || 'MANUAL';
    document.getElementById('ipRuleEditPriority').value = resolvedButton.dataset.priority || '1';
    document.getElementById('ipRuleEditExpiresAt').value = resolvedButton.dataset.expiresAt || '';
    document.getElementById('ipRuleEditReason').value = resolvedButton.dataset.reason || '';
    document.getElementById('ipRuleEditDetailMessage').value = resolvedButton.dataset.detailMessage || '';
    fillIpRuleEditControlModes(hasBatch, resolvedButton.dataset.controlMode || 'MANUAL');
    document.getElementById('ipRuleEditHistoryBtn').onclick = function () {
        closeModal('ipRuleEditModal');
        openBlockDetail(resolvedButton.dataset.templateId, ADMIN_BLOCK_MSG.ipRuleHistory);
    };
    document.getElementById('ipRuleEditModal').classList.add('open');
}

async function submitIpRule() {
    const params = new URLSearchParams({
        matchType: document.getElementById('ipMatchType').value,
        ipAddress: document.getElementById('ipAddressInput').value.trim(),
        cidrNotation: document.getElementById('cidrNotationInput').value.trim(),
        rangeStartIp: document.getElementById('rangeStartInput').value.trim(),
        rangeEndIp: document.getElementById('rangeEndInput').value.trim(),
        countryCode: document.getElementById('countryCodeInput').value.trim(),
        asn: document.getElementById('asnInput').value.trim(),
        ruleAction: document.getElementById('ipRuleAction').value,
        controlMode: document.getElementById('ipControlMode').value,
        blockCategory: document.getElementById('ipBlockCategory').value,
        priority: document.getElementById('ipPriority').value,
        ipBlockBatchIdx: document.getElementById('ipBatchIdx').value,
        reason: document.getElementById('ipReason').value.trim(),
        detailMessage: document.getElementById('ipDetailMessage').value.trim(),
        expiresAt: document.getElementById('ipExpiresAt').value
    });
    const res = await fetch(CTX + '/admin/blocks/ip-rules', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saved);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saveFailed, 'error');
    }
}

async function submitIpRuleEdit() {
    const id = document.getElementById('ipRuleEditId').value;
    const params = new URLSearchParams({
        ruleAction: document.getElementById('ipRuleEditAction').value,
        controlMode: document.getElementById('ipRuleEditControlMode').value,
        blockCategory: document.getElementById('ipRuleEditCategory').value,
        priority: document.getElementById('ipRuleEditPriority').value,
        reason: document.getElementById('ipRuleEditReason').value.trim(),
        detailMessage: document.getElementById('ipRuleEditDetailMessage').value.trim(),
        expiresAt: document.getElementById('ipRuleEditExpiresAt').value
    });
    const res = await fetch(CTX + '/admin/blocks/ip-rules/' + id + '/update', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saved);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saveFailed, 'error');
    }
}

async function toggleIpRule(id, active) {
    const message = active ? ADMIN_BLOCK_MSG.confirmRuleOn : ADMIN_BLOCK_MSG.confirmRuleOff;
    if (!confirm(message)) return;
    const res = await fetch(CTX + '/admin/blocks/ip-rules/' + id + '/toggle', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: 'active=' + active
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.updated);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.updateFailed, 'error');
    }
}

async function returnToBatch(id) {
    if (!confirm(ADMIN_BLOCK_MSG.confirmReturnToBatch)) return;
    const res = await fetch(CTX + '/admin/blocks/ip-rules/' + id + '/return-to-batch', {
        method: 'POST',
        headers: {'X-Requested-With': 'XMLHttpRequest'}
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.updated);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.updateFailed, 'error');
    }
}

async function releaseUserBlock(targetKey) {
    if (!confirm(ADMIN_BLOCK_MSG.confirmReleaseUserBlock)) return;
    const params = new URLSearchParams({blockTargetKey: targetKey});
    const res = await fetch(CTX + '/admin/blocks/user-blocks/release', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.released);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.releaseFailed, 'error');
    }
}

async function submitUserBlockEdit() {
    const id = document.getElementById('userBlockEditId').value;
    const active = document.getElementById('userBlockEditActive').value;
    const params = new URLSearchParams({
        active: active,
        reason: document.getElementById('userBlockEditReason').value.trim(),
        expiresAt: document.getElementById('userBlockEditExpiresAt').value
    });
    const res = await fetch(CTX + '/admin/blocks/user-blocks/' + id + '/update', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saved);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saveFailed, 'error');
    }
}

async function submitBatch() {
    const params = new URLSearchParams({
        batchCode: document.getElementById('batchCode').value.trim(),
        batchName: document.getElementById('batchName').value.trim(),
        sourceType: document.getElementById('batchSourceType').value,
        sourceName: document.getElementById('batchSourceName').value.trim(),
        batchRuleAction: document.getElementById('batchRuleAction').value,
        defaultRulePriority: document.getElementById('batchDefaultPriority').value,
        defaultDisableStrategy: document.getElementById('batchDisableStrategy').value,
        defaultEnableStrategy: document.getElementById('batchEnableStrategy').value,
        description: document.getElementById('batchDescription').value.trim()
    });
    const res = await fetch(CTX + '/admin/blocks/batches', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.created);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.createFailed, 'error');
    }
}

async function submitBatchEdit() {
    const id = document.getElementById('batchEditId').value;
    const params = new URLSearchParams({
        batchCode: document.getElementById('batchEditCode').value.trim(),
        batchName: document.getElementById('batchEditName').value.trim(),
        sourceType: document.getElementById('batchEditSourceType').value,
        sourceName: document.getElementById('batchEditSourceName').value.trim(),
        batchRuleAction: document.getElementById('batchEditRuleAction').value,
        defaultRulePriority: document.getElementById('batchEditPriority').value,
        defaultDisableStrategy: document.getElementById('batchEditDisableStrategy').value,
        defaultEnableStrategy: document.getElementById('batchEditEnableStrategy').value,
        description: document.getElementById('batchEditDescription').value.trim()
    });
    const res = await fetch(CTX + '/admin/blocks/batches/' + id + '/update', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saved);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.saveFailed, 'error');
    }
}

function openBatchToggleModal(button) {
    const nextActive = button.dataset.active === 'true';
    const batchName = button.dataset.batchName;
    const effectiveRules = button.dataset.effectiveRules;
    const activeRules = button.dataset.activeRules;
    const optionSelect = document.getElementById('batchToggleOption');
    optionSelect.innerHTML = '';

    document.getElementById('batchToggleId').value = button.dataset.id;
    document.getElementById('batchToggleActive').value = nextActive ? 'true' : 'false';
    document.getElementById('batchToggleTitle').textContent = nextActive ? '${msg_admin_blocks_batchReactivate_js}' : '${msg_admin_blocks_batchDeactivate_js}';

    if (nextActive) {
        document.getElementById('batchToggleSummary').textContent = ADMIN_BLOCK_MSG.batchToggleEnableSummary.replace('{0}', batchName);
        optionSelect.innerHTML =
            '<option value="BATCH_ONLY">BATCH_ONLY</option>' +
            '<option value="RESTORE_BATCH_CONTROL">RESTORE_BATCH_CONTROL</option>' +
            '<option value="FORCE_ENABLE_ALL">FORCE_ENABLE_ALL</option>';
        optionSelect.value = button.dataset.defaultEnableStrategy || 'BATCH_ONLY';
    } else {
        document.getElementById('batchToggleSummary').textContent = ADMIN_BLOCK_MSG.batchToggleDisableSummary
            .replace('{0}', batchName)
            .replace('{1}', effectiveRules)
            .replace('{2}', activeRules);
        optionSelect.innerHTML =
            '<option value="BATCH_ONLY">BATCH_ONLY</option>' +
            '<option value="CASCADE_ACTIVE_RULES">CASCADE_ACTIVE_RULES</option>';
        optionSelect.value = button.dataset.defaultDisableStrategy || 'BATCH_ONLY';
    }

    document.getElementById('batchToggleDescription').value = '';
    document.getElementById('batchToggleModal').classList.add('open');
}

async function fetchHistoryCurrentSetting(button) {
    const historyId = button.dataset.historyId;
    if (!historyId) return null;

    const url = CTX + '/admin/blocks/histories/' + encodeURIComponent(historyId) + '/current-setting';
    const res = await fetch(url, {
        headers: {'X-Requested-With': 'XMLHttpRequest'}
    });
    const data = await res.json();
    if (!res.ok || !data.success) {
        throw new Error(data.message || ADMIN_BLOCK_MSG.fetchError);
    }
    return data;
}

function buildHistoryCurrentButton(sourceButton, data) {
    return {
        dataset: Object.assign({}, data || {}, {
            templateId: sourceButton.dataset.templateId || ''
        })
    };
}

async function openHistoryCurrent(button) {
    const resolvedButton = resolveHistoryCurrentButton(button);
    if (!resolvedButton || !resolvedButton.dataset.historyId) {
        adm_toast(ADMIN_BLOCK_MSG.fetchError, 'error');
        return;
    }

    try {
        const response = await fetchHistoryCurrentSetting(resolvedButton);
        if (response && response.found && response.data) {
            const currentButton = buildHistoryCurrentButton(resolvedButton, response.data);
            if (response.currentType === 'BATCH') {
                openBatchEditor(currentButton);
                return;
            }
            if (response.currentType === 'USER_BLOCK') {
                openUserBlockEditor(currentButton);
                return;
            }
            openIpRuleEditor(currentButton);
            return;
        }
    } catch (error) {
        adm_toast(error.message || ADMIN_BLOCK_MSG.fetchError, 'error');
        return;
    }

    if (resolvedButton.dataset.templateId) {
        openBlockDetail(resolvedButton.dataset.templateId, ADMIN_BLOCK_MSG.blockDetailTitle);
    }
    adm_toast(ADMIN_BLOCK_MSG.historyCurrentMissing, 'error');
}

async function submitBatchToggle() {
    const id = document.getElementById('batchToggleId').value;
    const active = document.getElementById('batchToggleActive').value;
    const operationOption = document.getElementById('batchToggleOption').value;
    const description = document.getElementById('batchToggleDescription').value.trim();
    const params = new URLSearchParams({
        active: active,
        operationOption: operationOption,
        description: description
    });
    const res = await fetch(CTX + '/admin/blocks/batches/' + id + '/toggle', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
        body: params.toString()
    });
    const data = await res.json();
    if (data.success) {
        adm_toast(data.message || ADMIN_BLOCK_MSG.updated);
        location.reload();
    } else {
        adm_toast(data.message || ADMIN_BLOCK_MSG.updateFailed, 'error');
    }
}

async function syncBlockCache() {
    const res = await fetch(CTX + '/admin/blocks/api/cache/sync', {
        method: 'POST',
        headers: {'X-Requested-With': 'XMLHttpRequest'}
    });
    const data = await res.json();
    if (data.success) {
        adm_toast((data.message || '차단 규칙 캐시가 동기화되었습니다.') + ' IP=' + (data.ipRuleCount || 0) + ', USER=' + (data.userRuleCount || 0));
    } else {
        adm_toast(data.message || '차단 규칙 캐시 동기화 실패', 'error');
    }
}


</script>
