<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

id="ub-exportFormat" class="adm-select js-block-export-format adm-block-export-format" data-section="user-blocks">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost"
                        onclick="toggleBlockExportDropdown('ub-exportDropdown')">
                    ${msg_admin_common_export} ▾
                </button>
                <div id="ub-exportDropdown" class="adm-export-dropdown adm-block-export-dropdown is-hidden">
                    <button type="button" class="adm-export-item" onclick="exportBlockData('user-blocks','all')">${msg_admin_common_exportAll}</button>
                    <button type="button" class="adm-export-item" onclick="exportBlockData('user-blocks','filtered')">${msg_admin_common_exportFiltered}</button>
                    <button type="button" class="adm-export-item js-block-export-selected" data-section="user-blocks" id="ub-exportSelectedBtn" disabled onclick="exportBlockData('user-blocks','selected')">${msg_admin_common_exportSelected} (<span id="ub-selectedCount">0</span>)</button>
                </div>
            </div>
        </div>
        <div class="adm-card-body adm-block-card-body">
            <div class="adm-local-toolbar">
                <div class="adm-local-toolbar-group">
                    <select class="adm-select js-local-field" data-section="user-blocks">
                        <option value="all">${msg_admin_blocks_filter_allFields}</option>
                        <option value="nickname">${msg_admin_blocks_filter_memberNickname}</option>
                        <option value="userId">${msg_admin_blocks_filter_memberUserId}</option>
                        <option value="target">${msg_admin_blocks_filter_blockTarget}</option>
                        <option value="reason">${msg_admin_common_reason}</option>
                        <option value="blockType">${msg_admin_blocks_filter_blockType}</option>
                        <option value="blockedAt">${msg_admin_blocks_filter_blockedDate}</option>
                        <option value="expiresAt">${msg_admin_blocks_filter_expireDate}</option>
                    </select>
                    <input type="text" class="adm-input js-local-keyword" data-section="user-blocks" placeholder="${msg_admin_blocks_userBlocks_searchPlaceholder}">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-reset" data-section="user-blocks">${msg_admin_common_reset}</button>
                </div>
                <div class="adm-local-toolbar-group">
                    <button type="button" class="adm-dash-sort-reset js-section-sort-reset is-hidden" data-section="user-blocks" onclick="sectionSortReset('user-blocks')"></button>
                    <select class="adm-select js-section-mode" data-section="user-blocks" title="${msg_admin_blocks_mode_label}">
                        <option value="client" title="${msg_admin_blocks_mode_tipClient}">${msg_admin_blocks_mode_client}</option>
                        <option value="server" title="${msg_admin_blocks_mode_tipServer}">${msg_admin_blocks_mode_server}</option>
                    </select>
                    <select class="adm-select js-local-page-size" data-section="user-blocks">
                        <option value="10">${msg_admin_common_pageSize_10}</option>
                        <option value="20" selected>${msg_admin_common_pageSize_20}</option>
                        <option value="50">${msg_admin_common_pageSize_50}</option>
                    </select>
                </div>
            </div>
            <div id="ub-bulkBar" class="js-block-bulkbar adm-block-bulkbar is-hidden" data-section="user-blocks">
                <span class="adm-block-bulk-count-text"><strong id="ub-bulkCount" class="js-block-bulk-count">0</strong>${msg_admin_common_selectedCount}</span>
                <c:if test="${hasUserBlockAdmin}">
                    <button type="button" class="adm-btn adm-btn-danger" onclick="bulkReleaseUserBlocks()">${msg_admin_common_bulkRelease}</button>
                </c:if>
                <button type="button" class="adm-btn adm-btn-ghost adm-block-clear-selection" onclick="blockClearSelection('user-blocks')">${msg_admin_common_clearSelection}</button>
            </div>
            <div class="adm-table-wrap">
                <table class="adm-table adm-section-table-fixed">
                    <thead>
                    <tr>
                        <th class="adm-th-check"><input type="checkbox" id="ub-checkAll" class="js-block-check-all" data-section="user-blocks" onchange="blockToggleAll('user-blocks')"></th>
                        <th class="js-local-sort adm-th-w16" data-sort-index="1" onclick="sectionSort('user-blocks',1)">${msg_admin_common_member}</th>
                        <th class="js-local-sort adm-th-w12" data-sort-index="2" onclick="sectionSort('user-blocks',2)">${msg_admin_blocks_filter_blockType}</th>
                        <th class="js-local-sort adm-th-w17" data-sort-index="3" onclick="sectionSort('user-blocks',3)">${msg_admin_common_target}</th>
                        <th class="js-local-sort adm-th-w9" data-sort-index="4" onclick="sectionSort('user-blocks',4)">${msg_admin_common_status}</th>
                        <th class="js-local-sort adm-th-w16" data-sort-index="5" onclick="sectionSort('user-blocks',5)">${msg_admin_common_reason}</th>
                        <th class="js-local-sort adm-th-w16" data-sort-index="6" onclick="sectionSort('user-blocks',6)">${msg_admin_blocks_blockAndExpire}</th>
                        <th class="adm-th-w14">${msg_admin_common_action}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%@ include file="_userBlockRowsOnly.jspf" %>
                    </tbody>
                </table>
            </div>
            <div class="adm-local-pagination" data-section="user-blocks">
                <div class="adm-local-page-info js-local-page-info" data-section="user-blocks">0</div>
                <div class="adm-local-page-actions">
                    <button type="button" class="adm-btn adm-btn-ghost js-local-prev" data-section="user-blocks">${msg_admin_common_prev}</button>
                    <span class="js-local-page-state" data-section="user-blocks">1 / 1</span>
                    <button type="button" class="adm-btn adm-btn-ghost js-local-next" data-section="user-blocks">${msg_admin_common_next}</button>
                </div>
            </div>
        </div>
    </div>

    <div id="ubDetailArea">
    <%@ include file="_userBlockDetailsOnly.jspf" %>
    </div>

    <div class="adm-card js-section-card adm-block-card-spaced" data-section="ip-rules" data-enhanced="true">
        <div class="adm-card-head">
            <div>
                <div class="adm-card-title">${msg_admin_blocks_ipRules_title}</div>
                <div class="adm-card-sub">${msg_admin_blocks_ipRules_sub}</div>
            </div>
            <div class="adm-block-export-wrap">
                <c:if test="${hasBlockPolicyAdmin}">
                    <button class="adm-btn adm-btn-ghost" type="button" onclick="openBatchModal()">${msg_admin_blocks_createBatch}</button>
                </c:if>
                <c:if test="${hasIpBlockAdmin or hasBlockPolicyAdmin}">
                    <button class="adm-btn adm-btn-primary" type="button" onclick="openIpRuleModal()">${msg_admin_blocks_addRule}</button>
                </c:if>
                <div class="adm-block-export-wrap">
                    <select
