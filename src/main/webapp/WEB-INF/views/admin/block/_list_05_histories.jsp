<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

id="hist-exportFormat" class="adm-select js-block-export-format" data-section="histories" style="width:90px;">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost"
                        onclick="document.getElementById('hist-exportDropdown').style.display=(document.getElementById('hist-exportDropdown').style.display==='none'?'block':'none')">
                    ${msg_admin_common_export} ▾
                </button>
                <div id="hist-exportDropdown" class="adm-export-dropdown" style="display:none;">
                    <button type="button" class="adm-export-item" onclick="exportBlockData('histories','all')">${msg_admin_common_exportAll}</button>
                    <button type="button" class="adm-export-item" onclick="exportBlockData('histories','filtered')">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="adm-export-item js-block-export-selected" data-section="histories" id="hist-exportSelectedBtn" disabled onclick="exportBlockData('histories','selected')">${msg_admin_common_exportSelected} (<span id="hist-selectedCount">0</span>)</button>
                </div>
            </div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <div id="hist-bulkBar" class="js-block-bulkbar" data-section="histories" style="display:none;align-items:center;gap:10px;padding:8px 16px;background:#1e3a5f;border-bottom:1px solid #334155;">
                <span style="color:#93c5fd;font-size:13px;"><strong id="hist-bulkCount" class="js-block-bulk-count">0</strong>${msg_admin_common_selectedCount}</span>
                <button type="button" class="adm-btn adm-btn-ghost" onclick="blockClearSelection('histories')" style="margin-left:auto;">${msg_admin_common_clearSelection}</button>
            </div>
            <div class="adm-local-toolbar">
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-field" data-section="histories">
                        <option value="all">${msg_admin_blocks_filter_allFields}</option>
                        <option value="target">${msg_admin_common_target}</option>
                        <option value="member">${msg_admin_common_member}</option>
                        <option value="change">${msg_admin_blocks_changeKind}</option>
                        <option value="reason">${msg_admin_blocks_filter_reasonDescription}</option>
                        <option value="batch">${msg_admin_context_batch}</option>
                        <option value="blockedAt">${msg_admin_blocks_filter_blockedDate}</option>
                        <option value="expiresAt">${msg_admin_blocks_filter_expireDate}</option>
                    </select>
                    <input type="text" class="adm-input js-local-keyword" data-section="histories" placeholder="${msg_admin_blocks_histories_searchPlaceholder}">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-reset" data-section="histories">${msg_admin_common_reset}</button>
                </div>
                <div class="adm-local-toolbar-group">
                    <button type="button" class="adm-dash-sort-reset js-section-sort-reset" data-section="histories" style="display:none;" onclick="sectionSortReset('histories')"></button>
                    <select class="adm-select js-section-mode" data-section="histories" title="${msg_admin_blocks_mode_label}">
                        <option value="client" title="${msg_admin_blocks_mode_tipClient}">${msg_admin_blocks_mode_client}</option>
                        <option value="server" title="${msg_admin_blocks_mode_tipServer}">${msg_admin_blocks_mode_server}</option>
                    </select>
                    <select class="adm-select js-local-page-size" data-section="histories">
                        <option value="10">${msg_admin_common_pageSize}</option>
                        <option value="20" selected>${msg_admin_common_pageSize}</option>
                        <option value="50">${msg_admin_common_pageSize}</option>
                    </select>
                </div>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table adm-section-table-fixed">
                    <thead><tr>
                        <th style="width:36px;"><input type="checkbox" id="hist-checkAll" class="js-block-check-all" data-section="histories" onchange="blockToggleAll('histories')"></th>
                        <th class="js-local-sort" data-sort-index="1" onclick="sectionSort('histories',1)" style="cursor:pointer;user-select:none;width:12%;">${msg_admin_common_time}</th>
                        <th class="js-local-sort" data-sort-index="2" onclick="sectionSort('histories',2)" style="cursor:pointer;user-select:none;width:18%;">${msg_admin_common_target}</th>
                        <th class="js-local-sort" data-sort-index="3" onclick="sectionSort('histories',3)" style="cursor:pointer;user-select:none;width:12%;">${msg_admin_common_actionLabel}</th>
                        <th class="js-local-sort" data-sort-index="4" onclick="sectionSort('histories',4)" style="cursor:pointer;user-select:none;width:14%;">${msg_admin_blocks_changeKind}</th>
                        <th class="js-local-sort" data-sort-index="5" onclick="sectionSort('histories',5)" style="cursor:pointer;user-select:none;width:13%;">${msg_admin_blocks_result}</th>
                        <th class="js-local-sort" data-sort-index="6" onclick="sectionSort('histories',6)" style="cursor:pointer;user-select:none;width:17%;">${msg_admin_common_reason}</th>
                        <th style="width:14%;">${msg_admin_common_action}</th>
                    </tr></thead>
                    <tbody>
                    <%@ include file="_historyRowsOnly.jspf" %>
                    </tbody>
                </table>
            </div>
            <div class="adm-local-pagination" data-section="histories">
                <div class="adm-local-page-info js-local-page-info" data-section="histories">0</div>
                <div class="adm-local-page-actions">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-prev" data-section="histories">${msg_admin_common_prev}</button>
                    <span class="js-local-page-state" data-section="histories">1 / 1</span>
                    <button type="button" class="adm-btn adm-btn-ghost js-local-next" data-section="histories">${msg_admin_common_next}</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="histDetailArea">
<%@ include file="_historyDetailsOnly.jspf" %>
</div>

<div class="adm-modal-overlay" 