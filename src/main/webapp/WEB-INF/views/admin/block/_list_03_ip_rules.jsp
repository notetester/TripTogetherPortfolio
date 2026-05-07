<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

id="ipr-exportFormat" class="adm-select js-block-export-format" data-section="ip-rules" style="width:90px;">
                        <option value="csv">CSV</option>
                        <option value="excel">Excel</option>
                    </select>
                    <button type="button" class="adm-btn adm-btn-ghost"
                            onclick="document.getElementById('ipr-exportDropdown').style.display=(document.getElementById('ipr-exportDropdown').style.display==='none'?'block':'none')">
                        ${msg_admin_common_export} ▾
                    </button>
                    <div id="ipr-exportDropdown" class="adm-export-dropdown" style="display:none;">
                        <button type="button" class="adm-export-item" onclick="exportBlockData('ip-rules','all')">${msg_admin_common_exportAll}</button>
                        <button type="button" class="adm-export-item" onclick="exportBlockData('ip-rules','filtered')">${msg_admin_common_exportFiltered}</button>
                        <button type="button" class="adm-export-item js-block-export-selected" data-section="ip-rules" id="ipr-exportSelectedBtn" disabled onclick="exportBlockData('ip-rules','selected')">${msg_admin_common_exportSelected} (<span id="ipr-selectedCount">0</span>)</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="adm-card-body" style="padding:0;">
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
                    <button type="button" class="adm-dash-sort-reset js-section-sort-reset" data-section="ip-rules" style="display:none;" onclick="sectionSortReset('ip-rules')"></button>
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
            <div id="ipr-bulkBar" class="js-block-bulkbar" data-section="ip-rules" style="display:none;align-items:center;gap:10px;padding:8px 16px;background:#1e3a5f;border-bottom:1px solid #334155;">
                <span style="color:#93c5fd;font-size:13px;"><strong id="ipr-bulkCount" class="js-block-bulk-count">0</strong>${msg_admin_common_selectedCount}</span>
                <c:if test="${hasIpBlockAdmin or hasBlockPolicyAdmin}">
                    <button type="button" class="adm-btn adm-btn-primary" onclick="bulkToggleIpRules(true)">${msg_admin_blocks_ruleOn}</button>
                    <button type="button" class="adm-btn adm-btn-danger" onclick="bulkToggleIpRules(false)">${msg_admin_blocks_ruleOff}</button>
                </c:if>
                <button type="button" class="adm-btn adm-btn-ghost" onclick="blockClearSelection('ip-rules')" style="margin-left:auto;">${msg_admin_common_clearSelection}</button>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table adm-section-table-fixed">
                    <thead>
                    <tr>
                        <th style="width:36px;"><input type="checkbox" id="ipr-checkAll" class="js-block-check-all" data-section="ip-rules" onchange="blockToggleAll('ip-rules')"></th>
                        <th class="js-local-sort" data-sort-index="1" onclick="sectionSort('ip-rules',1)" style="cursor:pointer;user-select:none;width:16%;">${msg_admin_common_target}</th>
                        <th class="js-local-sort" data-sort-index="2" onclick="sectionSort('ip-rules',2)" style="cursor:pointer;user-select:none;width:14%;">${msg_admin_blocks_actionControl}</th>
                        <th class="js-local-sort" data-sort-index="3" onclick="sectionSort('ip-rules',3)" style="cursor:pointer;user-select:none;width:16%;">${msg_admin_context_batch}</th>
                        <th class="js-local-sort" data-sort-index="4" onclick="sectionSort('ip-rules',4)" style="cursor:pointer;user-select:none;width:11%;">${msg_admin_common_status}</th>
                        <th class="js-local-sort" data-sort-index="5" onclick="sectionSort('ip-rules',5)" style="cursor:pointer;user-select:none;width:9%;">${msg_admin_context_priority}</th>
                        <th class="js-local-sort" data-sort-index="6" onclick="sectionSort('ip-rules',6)" style="cursor:pointer;user-select:none;width:20%;">${msg_admin_common_reason}</th>
                        <th style="width:14%;">${msg_admin_common_action}</th>
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

    <div class="adm-card js-section-card" data-section="batches" data-enhanced="true" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div>
                <div class="adm-card-title">${msg_admin_blocks_section_batches}</div>
                <div class="adm-card-sub">${msg_admin_blocks_batches_sub}</div>
            </div>
            <div style="position:relative;display:flex;align-items:center;gap:8px;">
                <select 