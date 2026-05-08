<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

id="ipr-exportFormat" class="adm-select js-block-export-format adm-block-export-format" data-section="ip-rules">
                        <option value="csv">CSV</option>
                        <option value="excel">Excel</option>
                    </select>
                    <button type="button" class="adm-btn adm-btn-ghost"
                            onclick="toggleBlockExportDropdown('ipr-exportDropdown')">
                        ${msg_admin_common_export} ▾
                    </button>
                    <div id="ipr-exportDropdown" class="adm-export-dropdown adm-block-export-dropdown">
                        <button type="button" class="adm-export-item" onclick="exportBlockData('ip-rules','all')">${msg_admin_common_exportAll}</button>
                        <button type="button" class="adm-export-item" onclick="exportBlockData('ip-rules','filtered')">${msg_admin_common_exportFiltered}</button>
                        <button type="button" class="adm-export-item js-block-export-selected" data-section="ip-rules" id="ipr-exportSelectedBtn" disabled onclick="exportBlockData('ip-rules','selected')">${msg_admin_common_exportSelected} (<span id="ipr-selectedCount">0</span>)</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="adm-card-body adm-block-card-body">
            <div class="adm-local-toolbar">
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-field" data-section="ip-rules">
                        <option value="all">${msg_admin_blocks_filter_allFields}</option>
                        <option value="target">${msg_admin_blocks_filter_ipOrTarget}</option>
                        <option value="batch">${msg_admin_context_batch}</option>
                        <option value="reason">${msg_admin_blocks_filter_reasonMemo}</option>
                        <option value="priority">${msg_admin_context_priority}</option>
                        <option value="policy">${msg_admin_blocks_filter_policyControlCategory}</option>
                        <option value="blockedAt">${msg_admin_blocks_filter_blockedDate}</option>
                        <option value="expiresAt">${msg_admin_blocks_filter_expireDate}</option>
                    </select>
                    <input type="text" class="adm-input js-local-keyword" data-section="ip-rules" placeholder="${msg_admin_blocks_ipRules_searchPlaceholder}">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-reset" data-section="ip-rules">${msg_admin_common_reset}</button>
                </div>
                <div class="adm-local-toolbar-group">
                    <button type="button" class="adm-dash-sort-reset js-section-sort-reset is-hidden" data-section="ip-rules" onclick="sectionSortReset('ip-rules')"></button>
                    <select class="adm-select js-section-mode" data-section="ip-rules" title="${msg_admin_blocks_mode_label}">
                        <option value="client" title="${msg_admin_blocks_mode_tipClient}">${msg_admin_blocks_mode_client}</option>
                        <option value="server" title="${msg_admin_blocks_mode_tipServer}">${msg_admin_blocks_mode_server}</option>
                    </select>
                    <select class="adm-select js-local-page-size" data-section="ip-rules">
                        <option value="10">${msg_admin_common_pageSize_10}</option>
                        <option value="20" selected>${msg_admin_common_pageSize_20}</option>
                        <option value="50">${msg_admin_common_pageSize_50}</option>
                    </select>
                </div>
            </div>
            <div id="ipr-bulkBar" class="js-block-bulkbar adm-block-bulkbar is-hidden" data-section="ip-rules">
                <span class="adm-block-bulk-count-text"><strong id="ipr-bulkCount" class="js-block-bulk-count">0</strong>${msg_admin_common_selectedCount}</span>
                <c:if test="${hasIpBlockAdmin or hasBlockPolicyAdmin}">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="bulkToggleIpRules(true)">${msg_admin_blocks_ruleOn}</button>
                    <button type="button" class="adm-btn adm-btn-danger" onclick="bulkToggleIpRules(false)">${msg_admin_blocks_ruleOff}</button>
                </c:if>
                <button type="button" class="adm-btn adm-btn-ghost adm-block-clear-selection" onclick="blockClearSelection('ip-rules')">${msg_admin_common_clearSelection}</button>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table adm-section-table-fixed">
                    <thead>
                    <tr>
                        <th class="adm-th-check"><input type="checkbox" id="ipr-checkAll" class="js-block-check-all" data-section="ip-rules" onchange="blockToggleAll('ip-rules')"></th>
                        <th class="js-local-sort adm-th-w16" data-sort-index="1" onclick="sectionSort('ip-rules',1)">${msg_admin_common_target}</th>
                        <th class="js-local-sort adm-th-w14" data-sort-index="2" onclick="sectionSort('ip-rules',2)">${msg_admin_blocks_actionControl}</th>
                        <th class="js-local-sort adm-th-w16" data-sort-index="3" onclick="sectionSort('ip-rules',3)">${msg_admin_context_batch}</th>
                        <th class="js-local-sort adm-th-w11" data-sort-index="4" onclick="sectionSort('ip-rules',4)">${msg_admin_common_status}</th>
                        <th class="js-local-sort adm-th-w9" data-sort-index="5" onclick="sectionSort('ip-rules',5)">${msg_admin_context_priority}</th>
                        <th class="js-local-sort adm-th-w20" data-sort-index="6" onclick="sectionSort('ip-rules',6)">${msg_admin_common_reason}</th>
                        <th class="adm-th-w14" onclick="openFirstBlockSectionAction('ip-rules')">${msg_admin_common_action}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%@ include file="_ipRuleRowsOnly.jspf" %>
                    </tbody>
                </table>
            </div>
            <div class="adm-local-pagination" data-section="ip-rules">
                <div class="adm-local-page-info js-local-page-info" data-section="ip-rules">0</div>
                <div class="adm-local-page-actions">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-prev" data-section="ip-rules">${msg_admin_common_prev}</button>
                    <span class="js-local-page-state" data-section="ip-rules">1 / 1</span>
                    <button type="button" class="adm-btn adm-btn-ghost js-local-next" data-section="ip-rules">${msg_admin_common_next}</button>
                </div>
            </div>
        </div>
    </div>

    <div id="iprDetailArea">
    <%@ include file="_ipRuleDetailsOnly.jspf" %>
    </div>

    <div class="adm-card js-section-card adm-block-card-spaced adm-block-batch-card" data-section="batches" data-enhanced="true">
        <div class="adm-card-head adm-block-section-head adm-block-batch-head">
            <div class="adm-block-head-main">
                <div class="adm-card-title">${msg_admin_blocks_section_batches}</div>
                <div class="adm-card-sub">${msg_admin_blocks_batches_sub}</div>
            </div>
            <div class="adm-block-export-wrap adm-block-batch-actions">
                <c:if test="${hasBlockPolicyAdmin}">
                    <button class="adm-btn adm-btn-primary" type="button" onclick="openBatchModal()">${msg_admin_blocks_createBatch}</button>
                </c:if>
                <select
