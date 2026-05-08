<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

id="bat-exportFormat" class="adm-select js-block-export-format adm-block-export-format" data-section="batches">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost"
                        onclick="toggleBlockExportDropdown('bat-exportDropdown')">
                    ${msg_admin_common_export} ▾
                </button>
                <div id="bat-exportDropdown" class="adm-export-dropdown adm-block-export-dropdown">
                    <button type="button" class="adm-export-item" onclick="exportBlockData('batches','all')">${msg_admin_common_exportAll}</button>
                    <button type="button" class="adm-export-item" onclick="exportBlockData('batches','filtered')">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="adm-export-item js-block-export-selected" data-section="batches" id="bat-exportSelectedBtn" disabled onclick="exportBlockData('batches','selected')">${msg_admin_common_exportSelected} (<span id="bat-selectedCount">0</span>)</button>
                </div>
            </div>
        </div>
        <div class="adm-card-body adm-block-card-body">
            <div id="bat-bulkBar" class="js-block-bulkbar adm-block-bulkbar is-hidden" data-section="batches">
                <span class="adm-block-bulk-count-text"><strong id="bat-bulkCount" class="js-block-bulk-count">0</strong>${msg_admin_common_selectedCount}</span>
                <button type="button" class="adm-btn adm-btn-ghost adm-block-clear-selection" onclick="blockClearSelection('batches')">${msg_admin_common_clearSelection}</button>
            </div>
            <div class="adm-local-toolbar">
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-field" data-section="batches">
                        <option value="all">${msg_admin_blocks_filter_allFields}</option>
                        <option value="batch">${msg_admin_blocks_filter_batchNameCode}</option>
                        <option value="source">${msg_admin_blocks_filter_source}</option>
                        <option value="description">${msg_admin_blocks_description}</option>
                        <option value="policy">${msg_admin_blocks_filter_basePolicy}</option>
                        <option value="priority">${msg_admin_context_priority}</option>
                        <option value="status">${msg_admin_common_status}</option>
                        <option value="updatedAt">${msg_admin_blocks_filter_recentUpdated}</option>
                    </select>
                    <input type="text" class="adm-input js-local-keyword" data-section="batches" placeholder="${msg_admin_blocks_batches_searchPlaceholder}">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-reset" data-section="batches">${msg_admin_common_reset}</button>
                </div>
                <div class="adm-local-toolbar-group">
                    <button type="button" class="adm-dash-sort-reset js-section-sort-reset is-hidden" data-section="batches" onclick="sectionSortReset('batches')"></button>
                    <select class="adm-select js-section-mode" data-section="batches" title="${msg_admin_blocks_mode_label}">
                        <option value="client" title="${msg_admin_blocks_mode_tipClient}">${msg_admin_blocks_mode_client}</option>
                        <option value="server" title="${msg_admin_blocks_mode_tipServer}">${msg_admin_blocks_mode_server}</option>
                    </select>
                    <select class="adm-select js-local-page-size" data-section="batches">
                        <option value="10">${msg_admin_common_pageSize_10}</option>
                        <option value="20" selected>${msg_admin_common_pageSize_20}</option>
                        <option value="50">${msg_admin_common_pageSize_50}</option>
                    </select>
                </div>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table adm-section-table-fixed">
                    <thead><tr>
                        <th class="adm-th-check"><input type="checkbox" id="bat-checkAll" class="js-block-check-all" data-section="batches" onchange="blockToggleAll('batches')"></th>
                        <th class="js-local-sort adm-th-w20" data-sort-index="1" onclick="sectionSort('batches',1)">${msg_admin_blocks_batch}</th>
                        <th class="js-local-sort adm-th-w14" data-sort-index="2" onclick="sectionSort('batches',2)">${msg_admin_blocks_basePolicy}</th>
                        <th class="js-local-sort adm-th-w9" data-sort-index="3" onclick="sectionSort('batches',3)">${msg_admin_context_priority}</th>
                        <th class="js-local-sort adm-th-w13" data-sort-index="4" onclick="sectionSort('batches',4)">${msg_admin_blocks_currentState}</th>
                        <th class="js-local-sort adm-th-w16" data-sort-index="5" onclick="sectionSort('batches',5)">${msg_admin_blocks_ruleStats}</th>
                        <th class="js-local-sort adm-th-w14" data-sort-index="6" onclick="sectionSort('batches',6)">${msg_admin_blocks_description}</th>
                        <th class="adm-th-w14" onclick="openFirstBlockSectionAction('batches')">${msg_admin_common_action}</th>
                    </tr></thead>
                    <tbody>
                    <%@ include file="_batchRowsOnly.jspf" %>
                    </tbody>
                </table>
            </div>
            <div class="adm-local-pagination" data-section="batches">
                <div class="adm-local-page-info js-local-page-info" data-section="batches">0</div>
                <div class="adm-local-page-actions">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-prev" data-section="batches">${msg_admin_common_prev}</button>
                    <span class="js-local-page-state" data-section="batches">1 / 1</span>
                    <button type="button" class="adm-btn adm-btn-ghost js-local-next" data-section="batches">${msg_admin_common_next}</button>
                </div>
            </div>
        </div>
    </div>

    <div id="batDetailArea">
<%@ include file="_batchDetailsOnly.jspf" %>
    </div>

    <div class="adm-card js-section-card" data-section="histories" data-enhanced="true">
        <div class="adm-card-head">
            <div>
                <div class="adm-card-title">${msg_admin_blocks_section_histories}</div>
                <div class="adm-card-sub">${msg_admin_blocks_histories_sub}</div>
            </div>
            <div class="adm-block-export-wrap">
                <select
