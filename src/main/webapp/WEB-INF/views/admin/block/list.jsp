<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message var="msg_admin_blocks_pageTitle" code="admin.blocks.pageTitle"/>
<c:set var="activeMenu" value="blocks"/>
<c:set var="pageTitle" value="${msg_admin_blocks_pageTitle}"/>
<%@ include file="../layout.jsp" %>
<jsp:include page="_list_messages_01.jsp"/>
<jsp:include page="_list_messages_02.jsp"/>
<jsp:include page="_list_messages_03.jsp"/>
<jsp:include page="_list_messages_04.jsp"/>
<jsp:include page="_list_01_dashboard.jsp"/>
<jsp:include page="_list_02_user_blocks.jsp"/>
<jsp:include page="_list_03_ip_rules.jsp"/>
<jsp:include page="_list_04_batches.jsp"/>
<jsp:include page="_list_05_histories.jsp"/>
<jsp:include page="_list_06_modals.jsp"/>

<style>
    .adm-inline-link {
        border: 0;
        background: transparent;
        padding: 0;
        cursor: pointer;
        font: inherit;
        text-align: left;
    }

    .adm-inline-link:hover {
        text-decoration: underline;
    }

    .adm-link-btn {
        width: 100%;
        border: 0;
        background: transparent;
        padding: 0;
        text-align: left;
        color: inherit;
        cursor: pointer;
    }

    .adm-link-btn:hover span:first-child {
        color: #93c5fd !important;
    }

    .adm-block-tab-row {
        flex-wrap: wrap;
        gap: 8px;
    }

    .adm-local-toolbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        padding: 16px;
        border-bottom: 1px solid rgba(148, 163, 184, 0.14);
        background: rgba(15, 23, 42, 0.42);
    }

    .adm-local-toolbar-group {
        display: flex;
        align-items: center;
        gap: 8px;
        flex-wrap: wrap;
    }

    .adm-local-toolbar .adm-input {
        min-width: 240px;
    }

    .adm-local-pagination {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        padding: 14px 16px 16px;
        border-top: 1px solid rgba(148, 163, 184, 0.14);
        background: rgba(15, 23, 42, 0.42);
        font-size: 13px;
        color: #cbd5e1;
    }

    .adm-local-page-actions {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .adm-local-empty td {
        text-align: center;
        padding: 28px;
        color: #64748b;
    }

    .adm-block-card-body {
        padding: 0;
    }

    .adm-block-card-spaced {
        margin-bottom: 20px;
    }

    .adm-block-kpi-grid {
        grid-template-columns: repeat(4, minmax(0, 1fr));
    }

    .adm-block-action-card-body {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        flex-wrap: wrap;
    }

    .adm-block-action-card-body.is-bottom {
        align-items: flex-end;
    }

    .adm-block-action-title {
        font-weight: 800;
        color: #e2e8f0;
    }

    .adm-block-action-desc {
        margin-top: 4px;
        color: #94a3b8;
        font-size: 12px;
    }

    .adm-block-feed-main,
    .adm-block-filter-main {
        min-width: 260px;
        flex: 1;
    }

    .adm-block-feed-form,
    .adm-block-filter-actions,
    .adm-dashboard-head-actions {
        display: flex;
        align-items: flex-end;
        gap: 8px;
        flex-wrap: wrap;
    }

    .adm-block-field {
        color: #cbd5e1;
        font-size: 12px;
        font-weight: 700;
    }

    .adm-block-source-input {
        min-width: 180px;
    }

    .adm-block-upload-result {
        width: 100%;
        color: #94a3b8;
        font-size: 12px;
    }

    .adm-block-feed-form input[type="file"].adm-input {
        min-height: 38px;
        padding: 7px 10px;
        color: #cbd5e1;
        cursor: pointer;
    }

    .adm-block-feed-form input[type="file"].adm-input::file-selector-button {
        margin-right: 10px;
        padding: 7px 11px;
        border: 1px solid rgba(96, 165, 250, .38);
        border-radius: 8px;
        background: rgba(30, 64, 175, .36);
        color: #dbeafe;
        font-weight: 800;
        cursor: pointer;
    }

    .adm-dashboard-status-filter {
        padding: 0;
        border: 0;
        background: transparent;
        box-shadow: none;
    }

    .adm-dashboard-status-filter:hover {
        background: transparent;
        transform: none;
    }

    .adm-dashboard-list-grid {
        display: grid;
        grid-template-columns: 1fr;
        row-gap: 28px;
    }

    .adm-dashboard-nested-card {
        margin: 0;
    }

    .adm-dashboard-title {
        font-size: 15px;
    }

    .adm-dashboard-sortable {
        cursor: pointer;
        user-select: none;
    }

    .adm-block-export-format {
        width: 90px;
    }

    .adm-block-export-wrap {
        position: relative;
        display: flex;
        align-items: center;
        gap: 8px;
        flex-wrap: wrap;
    }

    .adm-block-section-head {
        justify-content: space-between;
    }

    .adm-block-head-main {
        min-width: 240px;
        flex: 1 1 320px;
    }

    .adm-block-batch-actions {
        flex: 0 0 auto;
        justify-content: flex-end;
        margin-left: auto;
    }

    .adm-block-bulkbar.is-hidden,
    .adm-dash-sort-reset.is-hidden,
    .js-dashboard-panel.is-hidden,
    .js-section-card.is-hidden {
        display: none;
    }

    .adm-block-bulkbar {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 8px 16px;
        background: #1e3a5f;
        border-bottom: 1px solid #334155;
        min-height: 44px;
        flex-wrap: wrap;
    }

    .adm-block-bulkbar.is-floating {
        margin: 0 16px 12px;
        padding: 10px 14px;
        flex-wrap: wrap;
        border: 1px solid #2d6a9f;
        border-radius: 8px;
        background: #1a3354;
    }

    .adm-block-bulk-count-text {
        color: #93c5fd;
        font-size: 13px;
        font-weight: 700;
    }

    .adm-block-clear-selection {
        margin-left: auto;
    }

    body.sa-light .adm-block-action-title {
        color: #0f172a;
    }

    body.sa-light .adm-block-action-desc,
    body.sa-light .adm-block-field,
    body.sa-light .adm-block-upload-result {
        color: #64748b;
    }

    body.sa-light .adm-block-feed-form input[type="file"].adm-input {
        color: #334155;
    }

    body.sa-light .adm-block-feed-form input[type="file"].adm-input::file-selector-button {
        border-color: #bfdbfe;
        background: #eff6ff;
        color: #1d4ed8;
    }

    .adm-th-check {
        width: 36px;
        min-width: 36px;
        max-width: 36px;
        padding: 0 !important;
        text-align: center;
        vertical-align: middle;
    }
    .adm-th-check input,
    .adm-block-check-cell input {
        width: 15px;
        height: 15px;
        margin: 0;
        accent-color: #3b82f6;
        vertical-align: middle;
        cursor: pointer;
    }
    .adm-block-check-cell {
        width: 36px;
        min-width: 36px;
        max-width: 36px;
        padding: 0 !important;
        text-align: center;
        vertical-align: middle;
    }
    .adm-block-batch-table th,
    .adm-block-batch-table td {
        vertical-align: middle;
    }
    .adm-th-w9 { width: 9%; }
    .adm-th-w11 { width: 11%; }
    .adm-th-w12 { width: 12%; }
    .adm-th-w13 { width: 13%; }
    .adm-th-w14 { width: 14%; }
    .adm-th-w16 { width: 16%; }
    .adm-th-w17 { width: 17%; }
    .adm-th-w18 { width: 18%; }
    .adm-th-w20 { width: 20%; }

    .adm-quick-row {
        display: flex;
        flex-wrap: wrap;
        gap: 6px;
        margin-top: 10px;
    }

    .adm-chip-btn {
        border: 1px solid rgba(148, 163, 184, 0.28);
        background: #182030;
        color: #cbd5e1;
        border-radius: 6px;
        padding: 6px 10px;
        font-size: 12px;
        cursor: pointer;
    }

    .adm-chip-btn:hover {
        border-color: rgba(96, 165, 250, 0.5);
        color: #eff6ff;
    }
</style>

<script>
function toggleBlockExportDropdown(id) {
    const target = document.getElementById(id);
    if (!target) return;
    document.querySelectorAll('.adm-block-export-dropdown.open').forEach(function (other) {
        if (other !== target) other.classList.remove('open');
    });
    target.classList.toggle('open');
}

function closeAllBlockExportDropdowns() {
    document.querySelectorAll('.adm-block-export-dropdown.open').forEach(function (d) {
        d.classList.remove('open');
    });
}

document.addEventListener('click', function (e) {
    if (e.target.closest('.adm-block-export-wrap')) return;
    closeAllBlockExportDropdowns();
});
</script>

<jsp:include page="_list_script_01.jsp"/>
<jsp:include page="_list_script_main_01.jsp"/>
<jsp:include page="_list_script_main_02.jsp"/>
<jsp:include page="_list_script_main_03.jsp"/>
<jsp:include page="_list_script_main_04.jsp"/>
<jsp:include page="_list_script_main_05.jsp"/>
<jsp:include page="_list_script_main_06.jsp"/>

<%@ include file="../layout-close.jsp" %>

<jsp:include page="_list_script_upload.jsp"/>
