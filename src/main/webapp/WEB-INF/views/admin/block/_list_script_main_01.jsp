<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>

const CTX = '${pageContext.request.contextPath}';
const ADMIN_BLOCK_LOCALE = '${fn:escapeXml(pageContext.response.locale.toLanguageTag())}';
const ADMIN_BLOCK_MSG = {
    noData: '${msg_admin_common_noData_js}',
    noMatchingData: '${msg_admin_common_noMatchingData_js}',
    totalCountFormat: '${msg_admin_common_totalCountFormat_js}',
    currentCountFormat: '${msg_admin_common_currentCountFormat_js}',
    loading: '${msg_admin_common_loading_js}',
    close: '${msg_admin_common_close_js}',
    fetchError: '${msg_admin_context_fetchError_js}',
    settings: '${msg_admin_common_settings_js}',
    detail: '${msg_admin_common_detail_js}',
    history: '${msg_admin_common_history_js}',
    memberTitle: '${msg_admin_context_memberTitle_js}',
    tabInfo: '${msg_admin_context_tab_info_js}',
    tabLogins: '${msg_admin_context_tab_logins_js}',
    saved: '${msg_admin_common_saved_js}',
    saveFailed: '${msg_admin_common_saveFailed_js}',
    created: '${msg_admin_common_created_js}',
    createFailed: '${msg_admin_common_createFailed_js}',
    updated: '${msg_admin_common_updated_js}',
    updateFailed: '${msg_admin_common_updateFailed_js}',
    released: '${msg_admin_common_released_js}',
    releaseFailed: '${msg_admin_common_releaseFailed_js}',
    batchSettingsNotFound: '${msg_admin_blocks_batchSettingsNotFound_js}',
    blockDetailTitle: '${msg_admin_blocks_detailTitle_js}',
    userBlockHistory: '${msg_admin_blocks_userBlockHistory_js}',
    ipRuleHistory: '${msg_admin_blocks_ipRuleHistory_js}',
    confirmRuleOn: '${msg_admin_blocks_confirmRuleOn_js}',
    confirmRuleOff: '${msg_admin_blocks_confirmRuleOff_js}',
    confirmReturnToBatch: '${msg_admin_blocks_confirmReturnToBatch_js}',
    confirmReleaseUserBlock: '${msg_admin_blocks_confirmReleaseUserBlock_js}',
    historyCurrentMissing: '${msg_admin_blocks_historyCurrentMissing_js}',
    batchToggleEnableSummary: '${msg_admin_blocks_batchToggleEnableSummary_js}',
    batchToggleDisableSummary: '${msg_admin_blocks_batchToggleDisableSummary_js}',
    keepBlocked: '${msg_admin_blocks_keepBlocked_js}',
    releaseBlock: '${msg_admin_blocks_releaseBlock_js}',
    effectiveOn: '${msg_admin_blocks_effective_effective_js}',
    ruleOff: '${msg_admin_blocks_effective_ruleInactive_js}',
    batchOff: '${msg_admin_blocks_effective_batchInactive_js}',
    expired: '${msg_admin_blocks_effective_expired_js}',
    individualRule: '${msg_admin_blocks_individualRule_js}',
    ruleOn: '${msg_admin_blocks_ruleOn_js}',
    pagePrefix: '${msg_admin_common_pagePrefix_js}',
    export: '${msg_admin_common_export_js}',
    exportAll: '${msg_admin_common_exportAll_js}',
    exportFiltered: '${msg_admin_common_exportFiltered_js}',
    exportSelected: '${msg_admin_common_exportSelected_js}',
    selectedCount: '${msg_admin_common_selectedCount_js}',
    bulkRelease: '${msg_admin_common_bulkRelease_js}',
    clearSelection: '${msg_admin_common_clearSelection_js}',
    processError: '${msg_admin_common_processError_js}',
    dashViewUserBlocks: '${msg_admin_blocks_js_dashViewUserBlocks_js}',
    dashViewIpRules: '${msg_admin_blocks_js_dashViewIpRules_js}',
    dashViewBatches: '${msg_admin_blocks_js_dashViewBatches_js}',
    dashViewHistories: '${msg_admin_blocks_js_dashViewHistories_js}',
    dashViewAll: '${msg_admin_blocks_js_dashViewAll_js}',
    dashSortTip: '${msg_admin_blocks_js_dashSortTip_js}',
    dashSortReset: '${msg_admin_blocks_js_dashSortReset_js}',
    serverFetchError: '${msg_admin_blocks_js_serverFetchError_js}',
    bulkActivate: '${msg_admin_blocks_js_bulkActivate_js}',
    bulkDeactivate: '${msg_admin_blocks_js_bulkDeactivate_js}',
    noSelection: '${msg_admin_blocks_js_noSelection_js}',
    confirmBulkRelease: '${msg_admin_blocks_js_confirmBulkRelease_js}',
    confirmBulkActivate: '${msg_admin_blocks_js_confirmBulkActivate_js}',
    confirmBulkDeactivate: '${msg_admin_blocks_js_confirmBulkDeactivate_js}',
    done: '${msg_admin_blocks_js_done_js}'
};
const BLOCK_SECTION_CONFIG = {
    'user-blocks': {
        fields: {
            all: ['search'],
            nickname: ['nickname'],
            userId: ['userId'],
            target: ['target'],
            reason: ['reason'],
            blockType: ['blockType'],
            blockedAt: ['blockedAt'],
            expiresAt: ['expiresAt']
        }
    },
    'ip-rules': {
        fields: {
            all: ['search'],
            target: ['target'],
            batch: ['batch'],
            reason: ['reason'],
            priority: ['priority'],
            policy: ['policy'],
            blockedAt: ['blockedAt'],
            expiresAt: ['expiresAt']
        }
    },
    'batches': {
        fields: {
            all: ['search'],
            batch: ['batch'],
            source: ['source'],
            description: ['description'],
            policy: ['policy'],
            priority: ['priority'],
            status: ['status'],
            updatedAt: ['updatedAt']
        }
    },
    'histories': {
        fields: {
            all: ['search'],
            target: ['target'],
            member: ['member'],
            change: ['change'],
            reason: ['reason'],
            batch: ['batch'],
            blockedAt: ['blockedAt'],
            expiresAt: ['expiresAt']
        }
    }
};

</script>
