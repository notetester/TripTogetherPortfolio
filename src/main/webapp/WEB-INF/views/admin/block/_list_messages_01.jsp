<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%-- Request-scoped i18n declarations for admin/block/list dynamic JSP fragments. --%>
<spring:message var="msg_admin_blocks_kpi_tooltip_numUserBlocks_js" code="admin.blocks.kpi.tooltip.numUserBlocks" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_kpi_tooltip_denTotalUsers_js" code="admin.blocks.kpi.tooltip.denTotalUsers" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_kpi_tooltip_numActivePolicies_js" code="admin.blocks.kpi.tooltip.numActivePolicies" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_kpi_tooltip_denTotalIpRules_js" code="admin.blocks.kpi.tooltip.denTotalIpRules" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_kpi_tooltip_numTodayBlocks_js" code="admin.blocks.kpi.tooltip.numTodayBlocks" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_kpi_tooltip_denTotalHistory_js" code="admin.blocks.kpi.tooltip.denTotalHistory" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_kpi_tooltip_numActiveBatches_js" code="admin.blocks.kpi.tooltip.numActiveBatches" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_kpi_tooltip_denTotalBatches_js" code="admin.blocks.kpi.tooltip.denTotalBatches" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_searchPlaceholder" code="admin.blocks.searchPlaceholder" scope="request"/>
<spring:message var="msg_admin_blocks_userBlocks_searchPlaceholder" code="admin.blocks.userBlocks.searchPlaceholder" scope="request"/>
<spring:message var="msg_admin_blocks_mode_label" code="admin.blocks.mode.label" scope="request"/>
<spring:message var="msg_admin_blocks_mode_tipClient" code="admin.blocks.mode.tipClient" scope="request"/>
<spring:message var="msg_admin_blocks_mode_tipServer" code="admin.blocks.mode.tipServer" scope="request"/>
<spring:message var="msg_admin_blocks_ipRules_searchPlaceholder" code="admin.blocks.ipRules.searchPlaceholder" scope="request"/>
<spring:message var="msg_admin_blocks_batches_searchPlaceholder" code="admin.blocks.batches.searchPlaceholder" scope="request"/>
<spring:message var="msg_admin_blocks_histories_searchPlaceholder" code="admin.blocks.histories.searchPlaceholder" scope="request"/>
<spring:message var="msg_admin_blocks_detailTitle" code="admin.blocks.detailTitle" htmlEscape="true" scope="request"/>
<spring:message var="msg_admin_common_noData_js" code="admin.common.noData" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_noMatchingData_js" code="admin.common.noMatchingData" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_totalCountFormat_js" code="admin.common.totalCountFormat" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_currentCountFormat_js" code="admin.common.currentCountFormat" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_loading_js" code="admin.common.loading" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_close_js" code="admin.common.close" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_context_fetchError_js" code="admin.context.fetchError" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_settings_js" code="admin.common.settings" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_detail_js" code="admin.common.detail" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_history_js" code="admin.common.history" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_context_memberTitle_js" code="admin.context.memberTitle" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_context_tab_info_js" code="admin.context.tab.info" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_context_tab_logins_js" code="admin.context.tab.logins" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_saved_js" code="admin.common.saved" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_saveFailed_js" code="admin.common.saveFailed" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_created_js" code="admin.common.created" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_createFailed_js" code="admin.common.createFailed" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_updated_js" code="admin.common.updated" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_updateFailed_js" code="admin.common.updateFailed" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_released_js" code="admin.common.released" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_releaseFailed_js" code="admin.common.releaseFailed" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_batchSettingsNotFound_js" code="admin.blocks.batchSettingsNotFound" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_detailTitle_js" code="admin.blocks.detailTitle" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_userBlockHistory_js" code="admin.blocks.userBlockHistory" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_ipRuleHistory_js" code="admin.blocks.ipRuleHistory" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_confirmRuleOn_js" code="admin.blocks.confirmRuleOn" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_confirmRuleOff_js" code="admin.blocks.confirmRuleOff" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_confirmReturnToBatch_js" code="admin.blocks.confirmReturnToBatch" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_confirmReleaseUserBlock_js" code="admin.blocks.confirmReleaseUserBlock" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_historyCurrentMissing_js" code="admin.blocks.historyCurrentMissing" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_batchToggleEnableSummary_js" code="admin.blocks.batchToggleEnableSummary" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_batchToggleDisableSummary_js" code="admin.blocks.batchToggleDisableSummary" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_keepBlocked_js" code="admin.blocks.keepBlocked" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_releaseBlock_js" code="admin.blocks.releaseBlock" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_effective_effective_js" code="admin.blocks.effective.effective" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_effective_ruleInactive_js" code="admin.blocks.effective.ruleInactive" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_effective_batchInactive_js" code="admin.blocks.effective.batchInactive" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_effective_expired_js" code="admin.blocks.effective.expired" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_individualRule_js" code="admin.blocks.individualRule" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_ruleOn_js" code="admin.blocks.ruleOn" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_pagePrefix_js" code="admin.common.pagePrefix" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_export_js" code="admin.common.export" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_exportAll_js" code="admin.common.exportAll" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_exportFiltered_js" code="admin.common.exportFiltered" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_exportSelected_js" code="admin.common.exportSelected" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_selectedCount_js" code="admin.common.selectedCount" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_bulkRelease_js" code="admin.common.bulkRelease" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_clearSelection_js" code="admin.common.clearSelection" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_common_processError_js" code="admin.common.processError" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_dashViewUserBlocks_js" code="admin.blocks.js.dashViewUserBlocks" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_dashViewIpRules_js" code="admin.blocks.js.dashViewIpRules" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_dashViewBatches_js" code="admin.blocks.js.dashViewBatches" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_dashViewHistories_js" code="admin.blocks.js.dashViewHistories" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_dashViewAll_js" code="admin.blocks.js.dashViewAll" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_dashSortTip_js" code="admin.blocks.js.dashSortTip" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_dashSortReset_js" code="admin.blocks.js.dashSortReset" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_serverFetchError_js" code="admin.blocks.js.serverFetchError" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_bulkActivate_js" code="admin.blocks.js.bulkActivate" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_bulkDeactivate_js" code="admin.blocks.js.bulkDeactivate" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_noSelection_js" code="admin.blocks.js.noSelection" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_confirmBulkRelease_js" code="admin.blocks.js.confirmBulkRelease" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_confirmBulkActivate_js" code="admin.blocks.js.confirmBulkActivate" javaScriptEscape="true" scope="request"/>
<spring:message var="msg_admin_blocks_js_confirmBulkDeactivate_js" code="admin.blocks.js.confirmBulkDeactivate" javaScriptEscape="true" scope="request"/>
