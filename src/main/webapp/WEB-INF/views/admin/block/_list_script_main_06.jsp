<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
document.addEventListener('click', function (e) {
    const syncCacheBtn = e.target.closest('.js-sync-block-cache');
    if (syncCacheBtn) {
        syncBlockCache();
        return;
    }

    const tabButton = e.target.closest('.js-block-tab');
    if (tabButton) {
        activateBlockTab(tabButton.dataset.tab);
        return;
    }

    const memberDetailBtn = e.target.closest('.js-open-member-detail');
    if (memberDetailBtn) {
        openMemberDetailModal(memberDetailBtn.dataset.userIdx);
        return;
    }

    const applyBlockFilterBtn = e.target.closest('.js-apply-block-filter');
    if (applyBlockFilterBtn) {
        applyBlockLocalFilter(
            applyBlockFilterBtn.dataset.section || 'all',
            applyBlockFilterBtn.dataset.field || 'all',
            applyBlockFilterBtn.dataset.keyword || ''
        );
        return;
    }

    const expiryPresetBtn = e.target.closest('.js-expiry-preset');
    if (expiryPresetBtn) {
        applyExpiryPreset(expiryPresetBtn.dataset.target, expiryPresetBtn.dataset.days);
        return;
    }

    const expiryClearBtn = e.target.closest('.js-expiry-clear');
    if (expiryClearBtn) {
        clearExpiryPreset(expiryClearBtn.dataset.target);
        return;
    }

    const detailBtn = e.target.closest('.js-open-block-detail, .js-detail-open');
    if (detailBtn) {
        openBlockDetailFromButton(detailBtn);
        return;
    }

    const userBlockEditorBtn = e.target.closest('.js-open-user-block-editor');
    if (userBlockEditorBtn) {
        openUserBlockEditor(userBlockEditorBtn);
        return;
    }

    const ipRuleEditorBtn = e.target.closest('.js-open-ip-rule-editor');
    if (ipRuleEditorBtn) {
        openIpRuleEditor(ipRuleEditorBtn);
        return;
    }

    const releaseBtn = e.target.closest('.js-release-user-block');
    if (releaseBtn) {
        releaseUserBlock(releaseBtn.dataset.targetKey);
        return;
    }

    const ipToggleBtn = e.target.closest('.js-toggle-ip-rule');
    if (ipToggleBtn) {
        toggleIpRule(ipToggleBtn.dataset.id, ipToggleBtn.dataset.active === 'true');
        return;
    }

    const returnBtn = e.target.closest('.js-return-to-batch');
    if (returnBtn) {
        returnToBatch(returnBtn.dataset.id);
        return;
    }

    const batchToggleBtn = e.target.closest('.js-open-batch-toggle');
    if (batchToggleBtn) {
        openBatchToggleModal(batchToggleBtn);
        return;
    }

    const batchEditorBtn = e.target.closest('.js-open-batch-editor');
    if (batchEditorBtn) {
        openBatchEditor(batchEditorBtn);
        return;
    }

    const historyCurrentBtn = e.target.closest('.js-open-history-current');
    if (historyCurrentBtn) {
        openHistoryCurrent(historyCurrentBtn);
        return;
    }

    /* js-local-sort click is handled by each th's inline onclick → sectionSort() */

    const checkAll = e.target.closest('.js-block-check-all');
    if (checkAll) {
        const section = checkAll.dataset.section;
        getLocalRows(section).forEach(function (row) {
            if (row.style.display === 'none') return;
            const cb = row.querySelector('.js-block-row-check');
            if (cb) cb.checked = checkAll.checked;
        });
        updateBlockBulkBar(section);
        return;
    }

    const rowCheck = e.target.closest('.js-block-row-check');
    if (rowCheck) {
        updateBlockBulkBar(rowCheck.dataset.section);
        return;
    }

    const clearSelectionBtn = e.target.closest('.js-block-clear-selection');
    if (clearSelectionBtn) {
        clearBlockSelection(clearSelectionBtn.dataset.section);
        return;
    }

    const blockExportBtn = e.target.closest('.js-block-export');
    if (blockExportBtn) {
        exportBlockSection(blockExportBtn.dataset.section, blockExportBtn.dataset.scope);
        return;
    }

    const bulkReleaseBtn = e.target.closest('.js-bulk-release-user-blocks');
    if (bulkReleaseBtn) {
        bulkReleaseSelectedUserBlocks();
        return;
    }

    const bulkToggleIpBtn = e.target.closest('.js-bulk-toggle-ip-rules');
    if (bulkToggleIpBtn) {
        bulkToggleSelectedIpRules(bulkToggleIpBtn.dataset.active === 'true');
        return;
    }

    const prevBtn = e.target.closest('.js-local-prev');
    if (prevBtn) {
        const section = prevBtn.dataset.section;
        const state = getLocalState(section);
        state.page = Math.max(1, (state.page || 1) - 1);
        renderSectionByMode(section);
        return;
    }

    const nextBtn = e.target.closest('.js-local-next');
    if (nextBtn) {
        const section = nextBtn.dataset.section;
        const state = getLocalState(section);
        state.page = (state.page || 1) + 1;
        renderSectionByMode(section);
    }
});

document.querySelectorAll('.adm-modal-overlay').forEach(function (overlay) {
    overlay.addEventListener('click', function (e) {
        if (e.target === overlay) {
            overlay.classList.remove('open');
        }
    });
});

enhanceBlockLocalTables();
enhanceBlockDashboardTables();
ensureOriginalIndices();
initSectionModes();
initializeLocalSections();
activateBlockTab(new URLSearchParams(window.location.search).get('tab') || 'dashboard');

</script>
