<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- i18n message declarations --%>
<spring:message var="msg_title" code="security.admin.provider.title"/>
<spring:message var="msg_desc" code="security.admin.providerAdv.desc"/>
<spring:message var="msg_addNew" code="security.admin.providerAdv.action.addNew"/>
<spring:message var="msg_export" code="security.admin.providerAdv.action.export"/>
<spring:message var="msg_exportAll" code="security.admin.providerAdv.action.exportAll"/>
<spring:message var="msg_exportFiltered" code="security.admin.providerAdv.action.exportFiltered"/>
<spring:message var="msg_exportSelected" code="security.admin.providerAdv.action.exportSelected"/>
<spring:message var="msg_exportCsv" code="security.admin.providerAdv.action.exportCsv"/>
<spring:message var="msg_exportExcel" code="security.admin.providerAdv.action.exportExcel"/>
<spring:message var="msg_sortReset" code="security.admin.providerAdv.action.sortReset"/>
<spring:message var="msg_refresh" code="security.admin.providerAdv.action.refresh"/>
<spring:message var="msg_searchPh" code="security.admin.providerAdv.toolbar.searchPlaceholder"/>
<spring:message var="msg_filterKind" code="security.admin.providerAdv.filter.kind"/>
<spring:message var="msg_filterStatus" code="security.admin.providerAdv.filter.status"/>
<spring:message var="msg_filterEnabled" code="security.admin.providerAdv.filter.enabled"/>
<spring:message var="msg_filterFailOpen" code="security.admin.providerAdv.filter.failOpen"/>
<spring:message var="msg_filterCategory" code="security.admin.providerAdv.filter.category"/>
<spring:message var="msg_filterTrigger" code="security.admin.providerAdv.filter.triggerEvent"/>
<spring:message var="msg_filterIncludeDeleted" code="security.admin.providerAdv.filter.includeDeleted"/>
<spring:message var="msg_filterOnlyDeleted" code="security.admin.providerAdv.filter.onlyDeleted"/>
<spring:message var="msg_filterAll" code="security.admin.providerAdv.filter.all"/>
<spring:message var="msg_filterEnYes" code="security.admin.providerAdv.filter.enabledYes"/>
<spring:message var="msg_filterEnNo" code="security.admin.providerAdv.filter.enabledNo"/>
<spring:message var="msg_pageSize" code="security.admin.providerAdv.pageSize"/>
<spring:message var="msg_pageSizeAll" code="security.admin.providerAdv.pageSize.all"/>
<spring:message var="msg_colPriority" code="security.admin.providerAdv.col.priority"/>
<spring:message var="msg_colKind" code="security.admin.providerAdv.col.kind"/>
<spring:message var="msg_colCode" code="security.admin.providerAdv.col.code"/>
<spring:message var="msg_colName" code="security.admin.providerAdv.col.name"/>
<spring:message var="msg_colCategory" code="security.admin.providerAdv.col.category"/>
<spring:message var="msg_colStatus" code="security.admin.providerAdv.col.status"/>
<spring:message var="msg_colEnabled" code="security.admin.providerAdv.col.enabled"/>
<spring:message var="msg_colNextCheck" code="security.admin.providerAdv.col.nextCheck"/>
<spring:message var="msg_colLastCheck" code="security.admin.providerAdv.col.lastCheck"/>
<spring:message var="msg_colActions" code="security.admin.providerAdv.col.actions"/>
<spring:message var="msg_bulkEnable" code="security.admin.providerAdv.bulk.enable"/>
<spring:message var="msg_bulkDisable" code="security.admin.providerAdv.bulk.disable"/>
<spring:message var="msg_bulkCheck" code="security.admin.providerAdv.bulk.check"/>
<spring:message var="msg_bulkDelete" code="security.admin.providerAdv.bulk.delete"/>
<spring:message var="msg_bulkRestore" code="security.admin.providerAdv.bulk.restore"/>
<spring:message var="msg_modalCreateTitle" code="security.admin.providerAdv.modal.title.create"/>
<spring:message var="msg_modalEditTitle" code="security.admin.providerAdv.modal.title.edit"/>
<spring:message var="msg_tabBasic" code="security.admin.providerAdv.modal.tab.basic"/>
<spring:message var="msg_tabRequest" code="security.admin.providerAdv.modal.tab.request"/>
<spring:message var="msg_tabLimits" code="security.admin.providerAdv.modal.tab.limits"/>
<spring:message var="msg_tabHealth" code="security.admin.providerAdv.modal.tab.health"/>
<spring:message var="msg_actSave" code="security.admin.providerAdv.modal.action.save"/>
<spring:message var="msg_actCreate" code="security.admin.providerAdv.modal.action.create"/>
<spring:message var="msg_actCancel" code="security.admin.providerAdv.modal.action.cancel"/>
<spring:message var="msg_actDelete" code="security.admin.providerAdv.modal.action.delete"/>
<spring:message var="msg_actRestore" code="security.admin.providerAdv.modal.action.restore"/>
<spring:message var="msg_failOpenOpen" code="security.admin.providerAdv.failOpen.open"/>
<spring:message var="msg_failOpenClosed" code="security.admin.providerAdv.failOpen.closed"/>

<%-- JS-injected message constants --%>
<spring:message var="js_empty" code="security.admin.providerAdv.empty" javaScriptEscape="true"/>
<spring:message var="js_totalCount" code="security.admin.providerAdv.totalCount" javaScriptEscape="true"/>
<spring:message var="js_selectedCount" code="security.admin.providerAdv.bulk.selectedCount" javaScriptEscape="true"/>
<spring:message var="js_confirmDelete" code="security.admin.providerAdv.confirmDelete" javaScriptEscape="true"/>
<spring:message var="js_confirmRestore" code="security.admin.providerAdv.confirmRestore" javaScriptEscape="true"/>
<spring:message var="js_confirmBulkAction" code="security.admin.providerAdv.confirmBulkAction" javaScriptEscape="true"/>
<spring:message var="js_invalidJson" code="security.admin.providerAdv.invalidJson" javaScriptEscape="true"/>
<spring:message var="js_toastSaved" code="security.admin.providerAdv.toast.saved" javaScriptEscape="true"/>
<spring:message var="js_toastCreated" code="security.admin.providerAdv.toast.created" javaScriptEscape="true"/>
<spring:message var="js_toastDeleted" code="security.admin.providerAdv.toast.deleted" javaScriptEscape="true"/>
<spring:message var="js_toastRestored" code="security.admin.providerAdv.toast.restored" javaScriptEscape="true"/>
<spring:message var="js_toastChecked" code="security.admin.providerAdv.toast.checked" javaScriptEscape="true"/>
<spring:message var="js_toastBulkDone" code="security.admin.providerAdv.toast.bulkDone" javaScriptEscape="true"/>
<spring:message var="js_toastFailed" code="security.admin.providerAdv.toast.failed" javaScriptEscape="true"/>
<spring:message var="js_modalCreateTitle" code="security.admin.providerAdv.modal.title.create" javaScriptEscape="true"/>
<spring:message var="js_modalEditTitle" code="security.admin.providerAdv.modal.title.edit" javaScriptEscape="true"/>
<spring:message var="js_actSave" code="security.admin.providerAdv.modal.action.save" javaScriptEscape="true"/>
<spring:message var="js_actCreate" code="security.admin.providerAdv.modal.action.create" javaScriptEscape="true"/>
<spring:message var="js_exportSelected" code="security.admin.providerAdv.action.exportSelected" javaScriptEscape="true"/>

<c:set var="pageTitle" value="${msg_title}"/>
<c:set var="activeMenu" value="securityProviderConfigs"/>

<%@ include file="../layout.jsp" %>

<style>
  .adm-providerAdv-page .pa-filter-card {
      margin-bottom: 18px;
  }
  .adm-providerAdv-page .pa-filter-bar {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      align-items: flex-end;
      margin-bottom: 0;
  }
  .adm-providerAdv-page .pa-field {
      display: flex;
      flex-direction: column;
      gap: 6px;
      min-width: 132px;
  }
  .adm-providerAdv-page .pa-field-grow {
      flex: 1 1 340px;
      min-width: 240px;
  }
  .adm-providerAdv-page .pa-field-label {
      color: #94a3b8;
      font-size: 12px;
      font-weight: 700;
      line-height: 1.2;
  }
  .adm-providerAdv-page .pa-search-box {
      position: relative;
  }
  .adm-providerAdv-page .pa-search-box .adm-input {
      padding-left: 34px;
  }
  .adm-providerAdv-page .pa-check-field {
      min-width: 150px;
  }
  .adm-providerAdv-page .pa-toggle {
      min-height: 40px;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      color: #cbd5e1;
      font-size: 13px;
      font-weight: 700;
      line-height: 1.35;
      white-space: nowrap;
  }
  .adm-providerAdv-page .pa-toggle input {
      width: 16px;
      height: 16px;
      accent-color: #60a5fa;
      flex: 0 0 auto;
  }
  .adm-providerAdv-page .pa-list-card {
      overflow: visible;
  }
  .adm-providerAdv-page .pa-list-head {
      min-height: 64px;
  }
  .adm-providerAdv-page .pa-total-label {
      color: #94a3b8;
      font-size: 12px;
      font-weight: 500;
  }
  .adm-providerAdv-page .pa-export-control {
      position: relative;
      flex: 0 0 auto;
  }
  .adm-providerAdv-page .pa-export-format {
      width: 90px;
      min-width: 90px;
  }
  .adm-providerAdv-page .pa-controlbar {
      display: grid;
      grid-template-columns: minmax(420px, 1fr) max-content;
      align-items: center;
      gap: 12px;
      padding: 12px 16px;
      border-bottom: 1px solid rgba(148, 163, 184, .14);
      background: rgba(15, 23, 42, .42);
  }
  .adm-providerAdv-page .pa-bulkbar {
      min-height: 44px;
      min-width: 0;
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 6px 10px;
      border: 1px solid transparent;
      border-radius: 8px;
      opacity: 0;
      visibility: hidden;
      pointer-events: none;
      transition: opacity .15s ease, border-color .15s ease, background-color .15s ease;
  }
  .adm-providerAdv-page .pa-bulkbar.is-active {
      opacity: 1;
      visibility: visible;
      pointer-events: auto;
      border-color: rgba(59, 130, 246, .56);
      background: rgba(29, 78, 137, .48);
  }
  .adm-providerAdv-page .pa-selected-label {
      flex: 0 0 auto;
      color: #93c5fd;
      font-size: 13px;
      font-weight: 800;
      white-space: nowrap;
  }
  .adm-providerAdv-page .pa-bulk-actions,
  .adm-providerAdv-page .pa-view-tools,
  .adm-providerAdv-page .pa-primary-tools {
      display: flex;
      align-items: center;
      gap: 8px;
      min-width: 0;
  }
  .adm-providerAdv-page .pa-bulk-actions {
      flex-wrap: wrap;
  }
  .adm-providerAdv-page .pa-view-tools,
  .adm-providerAdv-page .pa-primary-tools {
      justify-content: flex-end;
  }
  .adm-providerAdv-page .pa-tool {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      color: #94a3b8;
      font-size: 12px;
      font-weight: 700;
      white-space: nowrap;
  }
  .adm-providerAdv-page .pa-tool-label {
      color: #64748b;
      font-size: 11px;
      font-weight: 800;
  }
  .adm-providerAdv-page .pa-page-size {
      width: 96px;
      min-width: 96px;
  }
  .adm-providerAdv-page .pa-overflow-menu {
      position: relative;
      display: none;
      flex: 0 0 auto;
  }
  .adm-providerAdv-page .pa-overflow-menu.has-items {
      display: inline-flex;
  }
  .adm-providerAdv-page .pa-overflow-toggle {
      min-width: 76px;
      font-size: 12px;
  }
  .adm-providerAdv-page .pa-overflow-panel {
      display: none;
      position: absolute;
      top: calc(100% + 6px);
      right: 0;
      z-index: 80;
      min-width: 224px;
      padding: 10px;
      border: 1px solid #334155;
      border-radius: 8px;
      background: #111827;
      box-shadow: 0 18px 42px rgba(0, 0, 0, .32);
  }
  .adm-providerAdv-page .pa-overflow-menu.open .pa-overflow-panel {
      display: flex;
      flex-direction: column;
      gap: 8px;
  }
  .adm-providerAdv-page .pa-overflow-panel .pa-tool-item {
      width: 100%;
      justify-content: space-between;
  }
  .adm-providerAdv-page .pa-overflow-panel .adm-btn {
      width: 100%;
  }
  .adm-providerAdv-page .pa-table-wrap {
      border: 0;
      border-radius: 0;
  }
  .adm-providerAdv-page .pa-table {
      min-width: 1180px;
  }
  .adm-providerAdv-page .pa-check-col {
      width: 42px;
      text-align: center;
  }
  .adm-providerAdv-page .pa-check-input {
      width: 15px;
      height: 15px;
      accent-color: #3b82f6;
      cursor: pointer;
      vertical-align: middle;
  }
  .adm-providerAdv-page .pa-table th {
      cursor: default;
  }
  .adm-providerAdv-page .pa-table th[data-sort] {
      cursor: pointer;
  }
  .adm-providerAdv-page .pa-table td {
      vertical-align: middle;
  }
  .adm-providerAdv-page .pa-table tr.row-deleted {
      opacity: .58;
  }
  .adm-providerAdv-page .pa-empty-cell {
      padding: 32px 16px !important;
      text-align: center;
      color: #94a3b8;
  }
  .adm-providerAdv-page .chip {
      display: inline-flex;
      align-items: center;
      min-height: 22px;
      padding: 3px 8px;
      border-radius: 999px;
      font-size: 11px;
      font-weight: 800;
      line-height: 1.2;
      background: rgba(148, 163, 184, .14);
      color: #cbd5e1;
      margin: 2px 4px 2px 0;
      white-space: nowrap;
  }
  .adm-providerAdv-page .chip.kind-AI_MODEL { background:#dbeafe; color:#1e40af; }
  .adm-providerAdv-page .chip.kind-POLICY_AUTHORITY { background:#fef3c7; color:#854d0e; }
  .adm-providerAdv-page .chip.kind-RULE_ALGORITHM { background:#e0e7ff; color:#3730a3; }
  .adm-providerAdv-page .chip.kind-WAF_PROVIDER,
  .adm-providerAdv-page .chip.kind-WAF,
  .adm-providerAdv-page .chip.kind-WAF_CDN { background:#fee2e2; color:#991b1b; }
  .adm-providerAdv-page .chip.kind-CONTENT_MODERATION { background:#dcfce7; color:#166534; }
  .adm-providerAdv-page .chip.kind-IP_REPUTATION { background:#fce7f3; color:#9d174d; }
  .adm-providerAdv-page .chip.kind-EMAIL_REPUTATION { background:#cffafe; color:#155e75; }
  .adm-providerAdv-page .chip.kind-CUSTOM_WEBHOOK { background:#f3e8ff; color:#6b21a8; }
  .adm-providerAdv-page .chip.status-DISABLED { background:#e5e7eb; color:#374151; }
  .adm-providerAdv-page .chip.status-READY { background:#dcfce7; color:#166534; }
  .adm-providerAdv-page .chip.status-READY_NEEDS_SECRET { background:#fef3c7; color:#854d0e; }
  .adm-providerAdv-page .chip.status-ERROR { background:#fee2e2; color:#991b1b; }
  .adm-providerAdv-page .priority-bar {
      display: inline-flex;
      min-width: 40px;
      align-items: center;
      justify-content: center;
      padding: 3px 8px;
      border-radius: 8px;
      background: rgba(59, 130, 246, .15);
      color: #bfdbfe;
      font-weight: 800;
  }
  .adm-providerAdv-page .pa-row-actions {
      display: flex;
      align-items: center;
      gap: 6px;
      flex-wrap: wrap;
  }
  .adm-providerAdv-page .pa-pagination {
      display: flex;
      align-items: center;
      justify-content: flex-end;
      gap: 6px;
      flex-wrap: wrap;
      padding: 14px 16px 16px;
      border-top: 1px solid rgba(148, 163, 184, .14);
      background: rgba(15, 23, 42, .42);
  }
  .adm-providerAdv-page .pa-pagination .pg-btn {
      min-width: 36px;
      min-height: 34px;
      padding: 6px 10px;
      border: 1px solid rgba(148, 163, 184, .24);
      border-radius: 8px;
      background: rgba(15, 23, 42, .82);
      color: #cbd5e1;
      cursor: pointer;
      font-weight: 800;
  }
  .adm-providerAdv-page .pa-pagination .pg-btn.active {
      background: #2563eb;
      color: #fff;
      border-color: #60a5fa;
  }
  .adm-providerAdv-page .pa-pagination .pg-btn:disabled {
      opacity: .4;
      cursor: not-allowed;
  }
  .adm-providerAdv-page .pa-modal {
      position: fixed;
      inset: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      background: rgba(2, 6, 23, .72);
      z-index: 1050;
  }
  .adm-providerAdv-page .pa-modal[hidden] {
      display: none !important;
  }
  .adm-providerAdv-page .pa-card {
      width: min(960px, 96vw);
      max-height: 92vh;
      overflow: auto;
      border: 1px solid rgba(148, 163, 184, .22);
      border-radius: 14px;
      background: #161b27;
      box-shadow: 0 24px 60px rgba(2, 6, 23, .48);
  }
  .adm-providerAdv-page .pa-head {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 12px;
      padding: 16px 18px;
      border-bottom: 1px solid rgba(148, 163, 184, .16);
      background: #111827;
  }
  .adm-providerAdv-page .pa-head h2 {
      margin: 0;
      color: #f8fafc;
      font-size: 18px;
  }
  .adm-providerAdv-page .pa-tabs {
      display: flex;
      gap: 6px;
      padding: 12px 18px 0;
      flex-wrap: wrap;
      border-bottom: 1px solid rgba(148, 163, 184, .16);
  }
  .adm-providerAdv-page .pa-tab {
      padding: 9px 13px;
      border: 1px solid rgba(148, 163, 184, .22);
      border-bottom: 0;
      border-radius: 10px 10px 0 0;
      background: rgba(15, 23, 42, .64);
      color: #94a3b8;
      cursor: pointer;
      font-size: 13px;
      font-weight: 800;
  }
  .adm-providerAdv-page .pa-tab.active {
      background: #161b27;
      border-color: rgba(96, 165, 250, .55);
      color: #dbeafe;
  }
  .adm-providerAdv-page .pa-body {
      padding: 18px;
  }
  .adm-providerAdv-page .pa-pane[hidden] {
      display: none;
  }
  .adm-providerAdv-page .pa-grid {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 14px;
  }
  .adm-providerAdv-page .pa-grid label,
  .adm-providerAdv-page .pa-grid .pa-form-field {
      display: flex;
      flex-direction: column;
      gap: 6px;
      min-width: 0;
      color: #cbd5e1;
      font-size: 12px;
      font-weight: 700;
  }
  .adm-providerAdv-page .pa-grid label.pa-toggle {
      min-height: 36px;
      display: inline-flex;
      flex-direction: row;
      align-items: center;
      width: auto;
  }
  .adm-providerAdv-page .pa-grid label.full {
      grid-column: 1 / -1;
  }
  .adm-providerAdv-page .pa-check-list {
      display: flex;
      align-items: center;
      gap: 8px;
      flex-wrap: wrap;
  }
  .adm-providerAdv-page .pa-hint {
      color: #94a3b8;
      font-size: 11px;
      font-weight: 500;
      line-height: 1.5;
  }
  .adm-providerAdv-page .pa-foot {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 10px;
      flex-wrap: wrap;
      padding: 14px 18px;
      border-top: 1px solid rgba(148, 163, 184, .16);
      background: rgba(15, 23, 42, .42);
  }
  .adm-providerAdv-page .pa-foot-actions {
      display: flex;
      align-items: center;
      gap: 8px;
      flex-wrap: wrap;
  }
  .adm-providerAdv-page .pa-error {
      display: none;
      margin: 12px 18px 0;
      padding: 10px 12px;
      border: 1px solid rgba(239, 68, 68, .42);
      border-radius: 10px;
      background: rgba(127, 29, 29, .28);
      color: #fecaca;
      font-size: 13px;
      font-weight: 700;
  }
  .adm-providerAdv-page .pa-error.show {
      display: block;
  }
  .adm-providerAdv-page .pa-toast {
      position: fixed;
      bottom: 24px;
      left: 50%;
      z-index: 1100;
      max-width: min(520px, calc(100vw - 32px));
      transform: translateX(-50%);
      padding: 10px 16px;
      border-radius: 10px;
      background: #1f2937;
      color: #fff;
      box-shadow: 0 18px 38px rgba(2, 6, 23, .38);
      opacity: 0;
      transition: opacity .2s;
  }
  .adm-providerAdv-page .pa-toast.show {
      opacity: .96;
  }
  body.sa-light .adm-providerAdv-page .pa-field-label,
  body.sa-light .adm-providerAdv-page .pa-tool-label {
      color: #64748b;
  }
  body.sa-light .adm-providerAdv-page .pa-toggle,
  body.sa-light .adm-providerAdv-page .pa-tool,
  body.sa-light .adm-providerAdv-page .pa-grid label,
  body.sa-light .adm-providerAdv-page .pa-grid .pa-form-field {
      color: #475569;
  }
  body.sa-light .adm-providerAdv-page .pa-controlbar,
  body.sa-light .adm-providerAdv-page .pa-pagination,
  body.sa-light .adm-providerAdv-page .pa-foot {
      background: #f8fafc;
      border-color: #e2e8f0;
  }
  body.sa-light .adm-providerAdv-page .pa-bulkbar.is-active {
      border-color: rgba(37, 99, 235, .34);
      background: #eff6ff;
  }
  body.sa-light .adm-providerAdv-page .pa-total-label,
  body.sa-light .adm-providerAdv-page .pa-hint,
  body.sa-light .adm-providerAdv-page .pa-empty-cell {
      color: #64748b;
  }
  body.sa-light .adm-providerAdv-page .pa-overflow-panel,
  body.sa-light .adm-providerAdv-page .pa-card {
      background: #fff;
      border-color: #e2e8f0;
      box-shadow: 0 16px 34px rgba(15, 23, 42, .14);
  }
  body.sa-light .adm-providerAdv-page .pa-head {
      background: #f8fafc;
      border-color: #e2e8f0;
  }
  body.sa-light .adm-providerAdv-page .pa-head h2 {
      color: #1e293b;
  }
  body.sa-light .adm-providerAdv-page .pa-tabs {
      border-color: #e2e8f0;
  }
  body.sa-light .adm-providerAdv-page .pa-tab {
      background: #f8fafc;
      border-color: #e2e8f0;
      color: #64748b;
  }
  body.sa-light .adm-providerAdv-page .pa-tab.active {
      background: #fff;
      border-color: #60a5fa;
      color: #2563eb;
  }
  body.sa-light .adm-providerAdv-page .priority-bar {
      background: #eff6ff;
      color: #1d4ed8;
  }
  body.sa-light .adm-providerAdv-page .pa-pagination .pg-btn {
      background: #fff;
      border-color: #e2e8f0;
      color: #475569;
  }
  body.sa-light .adm-providerAdv-page .pa-pagination .pg-btn.active {
      background: #2563eb;
      color: #fff;
      border-color: #2563eb;
  }
  body.sa-light .adm-providerAdv-page .pa-toast {
      background: #1e293b;
  }
  @media (max-width: 1180px) {
      .adm-providerAdv-page .pa-controlbar {
          grid-template-columns: 1fr;
          align-items: stretch;
      }
      .adm-providerAdv-page .pa-view-tools,
      .adm-providerAdv-page .pa-primary-tools {
          justify-content: flex-start;
      }
      .adm-providerAdv-page .pa-overflow-panel {
          left: 0;
          right: auto;
      }
  }
  @media (max-width: 767px) {
      .adm-providerAdv-page .pa-field,
      .adm-providerAdv-page .pa-field-grow,
      .adm-providerAdv-page .pa-check-field {
          flex: 1 1 100%;
          width: 100%;
      }
      .adm-providerAdv-page .pa-filter-bar .adm-select,
      .adm-providerAdv-page .pa-filter-bar .adm-input,
      .adm-providerAdv-page .pa-filter-bar .adm-btn {
          width: 100%;
      }
      .adm-providerAdv-page .pa-bulkbar:not(.is-active) {
          display: none;
      }
      .adm-providerAdv-page .pa-bulkbar,
      .adm-providerAdv-page .pa-bulk-actions,
      .adm-providerAdv-page .pa-primary-tools,
      .adm-providerAdv-page .pa-foot-actions {
          flex-wrap: wrap;
      }
      .adm-providerAdv-page .pa-pagination {
          justify-content: center;
      }
      .adm-providerAdv-page .pa-grid {
          grid-template-columns: 1fr;
      }
  }
  @media (max-width: 560px) {
      .adm-providerAdv-page .pa-export-control,
      .adm-providerAdv-page .pa-export-control .adm-btn,
      .adm-providerAdv-page .pa-bulk-actions .adm-btn,
      .adm-providerAdv-page .pa-overflow-menu,
      .adm-providerAdv-page .pa-overflow-toggle,
      .adm-providerAdv-page .pa-overflow-panel,
      .adm-providerAdv-page .pa-foot-actions,
      .adm-providerAdv-page .pa-foot-actions .adm-btn {
          width: 100%;
      }
      .adm-providerAdv-page .pa-export-format,
      .adm-providerAdv-page .pa-page-size {
          width: 100%;
      }
      .adm-providerAdv-page .pa-bulkbar {
          display: grid;
          grid-template-columns: 1fr;
          gap: 8px;
      }
      .adm-providerAdv-page .pa-bulk-actions {
          display: grid;
          grid-template-columns: 1fr;
      }
      .adm-providerAdv-page .pa-modal {
          align-items: flex-start;
          padding: 12px;
      }
  }
</style>

<div class="adm-content adm-governance-page adm-providerAdv-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_title}</h1>
            <p class="adm-page-desc">${msg_desc}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments"><spring:message code="security.admin.nav.securityAssessments"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-reviews"><spring:message code="security.admin.nav.securityReviews"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history?sourceType=PROVIDER_CONFIG"><spring:message code="admin.layout.menu.policyHistory"/></a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="adm-alert danger"><c:out value="${errorMessage}"/></div>
    </c:if>

    <div class="adm-card pa-filter-card">
        <div class="adm-card-body">
            <div class="pa-filter-bar">
                <div class="pa-field pa-field-grow">
                    <label class="pa-field-label" for="pa-keyword">${msg_searchPh}</label>
                    <div class="adm-search-box pa-search-box">
                        <span class="adm-search-ico">🔍</span>
                        <input id="pa-keyword" class="adm-input" type="text" placeholder="${msg_searchPh}">
                    </div>
                </div>
                <div class="pa-field">
                    <label class="pa-field-label" for="pa-kind">${msg_filterKind}</label>
                    <select id="pa-kind" class="adm-select">
                        <option value="">${msg_filterAll}</option>
                        <option value="AI_MODEL"><spring:message code="security.admin.providerAdv.kind.AI_MODEL"/></option>
                        <option value="POLICY_AUTHORITY"><spring:message code="security.admin.providerAdv.kind.POLICY_AUTHORITY"/></option>
                        <option value="RULE_ALGORITHM"><spring:message code="security.admin.providerAdv.kind.RULE_ALGORITHM"/></option>
                        <option value="WAF_PROVIDER"><spring:message code="security.admin.providerAdv.kind.WAF_PROVIDER"/></option>
                        <option value="CONTENT_MODERATION"><spring:message code="security.admin.providerAdv.kind.CONTENT_MODERATION"/></option>
                        <option value="IP_REPUTATION"><spring:message code="security.admin.providerAdv.kind.IP_REPUTATION"/></option>
                        <option value="EMAIL_REPUTATION"><spring:message code="security.admin.providerAdv.kind.EMAIL_REPUTATION"/></option>
                        <option value="CUSTOM_WEBHOOK"><spring:message code="security.admin.providerAdv.kind.CUSTOM_WEBHOOK"/></option>
                        <option value="WAF_CDN"><spring:message code="security.admin.providerAdv.kind.WAF_CDN"/></option>
                        <option value="WAF"><spring:message code="security.admin.providerAdv.kind.WAF"/></option>
                        <option value="CDN"><spring:message code="security.admin.providerAdv.kind.CDN"/></option>
                        <option value="EDGE_SECURITY"><spring:message code="security.admin.providerAdv.kind.EDGE_SECURITY"/></option>
                    </select>
                </div>
                <div class="pa-field">
                    <label class="pa-field-label" for="pa-status">${msg_filterStatus}</label>
                    <select id="pa-status" class="adm-select">
                        <option value="">${msg_filterAll}</option>
                        <option value="DISABLED"><spring:message code="security.admin.providerAdv.status.DISABLED"/></option>
                        <option value="READY"><spring:message code="security.admin.providerAdv.status.READY"/></option>
                        <option value="READY_NEEDS_SECRET"><spring:message code="security.admin.providerAdv.status.READY_NEEDS_SECRET"/></option>
                        <option value="ERROR"><spring:message code="security.admin.providerAdv.status.ERROR"/></option>
                    </select>
                </div>
                <div class="pa-field">
                    <label class="pa-field-label" for="pa-enabled">${msg_filterEnabled}</label>
                    <select id="pa-enabled" class="adm-select">
                        <option value="">${msg_filterAll}</option>
                        <option value="1">${msg_filterEnYes}</option>
                        <option value="0">${msg_filterEnNo}</option>
                    </select>
                </div>
                <div class="pa-field">
                    <label class="pa-field-label" for="pa-category">${msg_filterCategory}</label>
                    <select id="pa-category" class="adm-select">
                        <option value="">${msg_filterAll}</option>
                        <option value="LOGIN_RISK"><spring:message code="security.admin.providerAdv.category.LOGIN_RISK"/></option>
                        <option value="WAF_SYNC"><spring:message code="security.admin.providerAdv.category.WAF_SYNC"/></option>
                        <option value="CONTENT_MODERATION"><spring:message code="security.admin.providerAdv.category.CONTENT_MODERATION"/></option>
                        <option value="IP_REPUTATION"><spring:message code="security.admin.providerAdv.category.IP_REPUTATION"/></option>
                        <option value="EMAIL_REPUTATION"><spring:message code="security.admin.providerAdv.category.EMAIL_REPUTATION"/></option>
                    </select>
                </div>
                <div class="pa-field">
                    <label class="pa-field-label" for="pa-trigger">${msg_filterTrigger}</label>
                    <select id="pa-trigger" class="adm-select">
                        <option value="">${msg_filterAll}</option>
                        <option value="LOGIN_ATTEMPT"><spring:message code="security.admin.providerAdv.triggerEvent.LOGIN_ATTEMPT"/></option>
                        <option value="SIGNUP"><spring:message code="security.admin.providerAdv.triggerEvent.SIGNUP"/></option>
                        <option value="REPORT_CREATED"><spring:message code="security.admin.providerAdv.triggerEvent.REPORT_CREATED"/></option>
                        <option value="COMMUNITY_POST_CREATED"><spring:message code="security.admin.providerAdv.triggerEvent.COMMUNITY_POST_CREATED"/></option>
                        <option value="PASSWORD_RESET"><spring:message code="security.admin.providerAdv.triggerEvent.PASSWORD_RESET"/></option>
                    </select>
                </div>
                <div class="pa-field pa-check-field">
                    <span class="pa-field-label">&nbsp;</span>
                    <label class="pa-toggle"><input id="pa-includeDeleted" type="checkbox"> ${msg_filterIncludeDeleted}</label>
                </div>
                <div class="pa-field pa-check-field">
                    <span class="pa-field-label">&nbsp;</span>
                    <label class="pa-toggle"><input id="pa-onlyDeleted" type="checkbox"> ${msg_filterOnlyDeleted}</label>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card pa-list-card adm-overflow-visible">
        <div class="adm-card-head pa-list-head">
            <div class="adm-card-title">
                ${msg_title}
                <span class="pa-total-label" id="pa-totalLine"></span>
            </div>
            <div class="pa-export-control adm-export-control">
                <select class="adm-select pa-export-format" id="pa-exportFormat" title="${msg_export}">
                    <option value="csv">${msg_exportCsv}</option>
                    <option value="excel">${msg_exportExcel}</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost" id="pa-exportToggle">${msg_export} ▾</button>
                <div id="pa-exportDropdown" class="adm-export-dropdown">
                    <button type="button" class="adm-export-item" data-export-scope="all">${msg_exportAll}</button>
                    <button type="button" class="adm-export-item" data-export-scope="filtered">${msg_exportFiltered}</button>
                    <button type="button" class="adm-export-item" data-export-scope="selected" id="pa-exportSelectedBtn" disabled>${msg_exportSelected} (0)</button>
                </div>
            </div>
        </div>

        <div class="pa-controlbar">
            <div class="pa-bulkbar" id="pa-bulkbar" aria-hidden="true" aria-live="polite">
                <span class="pa-selected-label" id="pa-selectedLabel"></span>
                <div class="pa-bulk-actions">
                    <button type="button" class="adm-btn" data-bulk-action="enable" disabled>${msg_bulkEnable}</button>
                    <button type="button" class="adm-btn" data-bulk-action="disable" disabled>${msg_bulkDisable}</button>
                    <button type="button" class="adm-btn" data-bulk-action="check" disabled>${msg_bulkCheck}</button>
                    <button type="button" class="adm-btn" data-bulk-action="delete" disabled>${msg_bulkDelete}</button>
                    <button type="button" class="adm-btn" data-bulk-action="restore" disabled>${msg_bulkRestore}</button>
                </div>
            </div>

            <div class="pa-view-tools">
                <div id="pa-primaryTools" class="pa-primary-tools">
                    <button type="button" class="adm-dash-sort-reset pa-tool-item pa-sort-reset adm-is-hidden" id="pa-sortReset">${msg_sortReset}</button>
                    <label class="pa-tool-item pa-tool pa-size-tool">
                        <span class="pa-tool-label">${msg_pageSize}</span>
                        <select id="pa-pageSize" class="adm-select pa-page-size">
                            <option value="20">20</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                            <option value="0">${msg_pageSizeAll}</option>
                        </select>
                    </label>
                    <button type="button" class="adm-btn adm-btn-ghost pa-tool-item pa-refresh-tool" id="pa-refresh">${msg_refresh}</button>
                    <button type="button" class="adm-btn adm-btn-primary pa-tool-item pa-create-tool" id="pa-openCreate">${msg_addNew}</button>
                </div>
                <div class="pa-overflow-menu" id="pa-overflowMenu">
                    <button type="button" class="adm-btn adm-btn-ghost pa-overflow-toggle" aria-expanded="false" aria-controls="pa-overflowPanel">옵션 ▾</button>
                    <div id="pa-overflowPanel" class="pa-overflow-panel"></div>
                </div>
            </div>
        </div>

        <div class="adm-table-wrap adm-overflow-visible pa-table-wrap">
            <table class="adm-table pa-table" data-admin-list-ignore="hard">
                <thead>
                    <tr>
                        <th class="pa-check-col"><input type="checkbox" id="pa-selAll" class="pa-check-input"></th>
                        <th data-sort="priority_desc">${msg_colPriority}<span class="sort-ico" aria-hidden="true"></span></th>
                        <th>${msg_colKind}</th>
                        <th data-sort="name_asc">${msg_colName}<span class="sort-ico" aria-hidden="true"></span></th>
                        <th>${msg_colCode}</th>
                        <th>${msg_colCategory}</th>
                        <th>${msg_colStatus}</th>
                        <th>${msg_colEnabled}</th>
                        <th data-sort="last_checked_desc">${msg_colLastCheck}<span class="sort-ico" aria-hidden="true"></span></th>
                        <th>${msg_colNextCheck}</th>
                        <th>${msg_colActions}</th>
                    </tr>
                </thead>
                <tbody id="pa-rows">
                    <tr><td colspan="11" class="pa-empty-cell">...</td></tr>
                </tbody>
            </table>
        </div>

        <div class="pa-pagination" id="pa-pagination"></div>
    </div>

<%-- Edit/Create Modal --%>
<div class="pa-modal" id="pa-modal" hidden>
    <div class="pa-card" role="dialog" aria-modal="true">
        <div class="pa-head">
            <h2 id="pa-modalTitle">${msg_modalCreateTitle}</h2>
            <button type="button" class="adm-btn" id="pa-modalClose">×</button>
        </div>
        <div class="pa-error" id="pa-modalError"></div>
        <div class="pa-tabs">
            <div class="pa-tab active" data-tab="basic">${msg_tabBasic}</div>
            <div class="pa-tab" data-tab="request">${msg_tabRequest}</div>
            <div class="pa-tab" data-tab="limits">${msg_tabLimits}</div>
            <div class="pa-tab" data-tab="health">${msg_tabHealth}</div>
        </div>
        <form id="pa-form" autocomplete="off">
            <input type="hidden" name="providerIdx" id="f-providerIdx">
            <div class="pa-body">
                <div class="pa-pane" data-pane="basic">
                    <div class="pa-grid">
                        <label>${msg_modalCreateTitle != null ? '' : ''}<span><spring:message code="security.admin.providerAdv.modal.field.providerCode"/></span>
                            <input class="adm-input" type="text" name="providerCode" id="f-providerCode" maxlength="80">
                            <span class="pa-hint"><spring:message code="security.admin.providerAdv.modal.field.providerCodeHint"/></span>
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.providerKind"/></span>
                            <select class="adm-select" name="providerKind" id="f-providerKind" required>
                                <option value="AI_MODEL"><spring:message code="security.admin.providerAdv.kind.AI_MODEL"/></option>
                                <option value="POLICY_AUTHORITY"><spring:message code="security.admin.providerAdv.kind.POLICY_AUTHORITY"/></option>
                                <option value="RULE_ALGORITHM"><spring:message code="security.admin.providerAdv.kind.RULE_ALGORITHM"/></option>
                                <option value="WAF_PROVIDER"><spring:message code="security.admin.providerAdv.kind.WAF_PROVIDER"/></option>
                                <option value="CONTENT_MODERATION"><spring:message code="security.admin.providerAdv.kind.CONTENT_MODERATION"/></option>
                                <option value="IP_REPUTATION"><spring:message code="security.admin.providerAdv.kind.IP_REPUTATION"/></option>
                                <option value="EMAIL_REPUTATION"><spring:message code="security.admin.providerAdv.kind.EMAIL_REPUTATION"/></option>
                                <option value="CUSTOM_WEBHOOK"><spring:message code="security.admin.providerAdv.kind.CUSTOM_WEBHOOK"/></option>
                                <option value="WAF_CDN"><spring:message code="security.admin.providerAdv.kind.WAF_CDN"/></option>
                                <option value="WAF"><spring:message code="security.admin.providerAdv.kind.WAF"/></option>
                                <option value="CDN"><spring:message code="security.admin.providerAdv.kind.CDN"/></option>
                                <option value="EDGE_SECURITY"><spring:message code="security.admin.providerAdv.kind.EDGE_SECURITY"/></option>
                            </select>
                        </label>
                        <label class="full"><span><spring:message code="security.admin.providerAdv.modal.field.providerName"/></span>
                            <input class="adm-input" type="text" name="providerName" id="f-providerName" maxlength="160" required>
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.priority"/></span>
                            <input class="adm-input" type="number" name="priority" id="f-priority" min="0" max="100000">
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.tags"/></span>
                            <input class="adm-input" type="text" name="tags" id="f-tags" maxlength="255">
                        </label>
                        <label class="full"><span><spring:message code="security.admin.providerAdv.modal.field.usageCategories"/></span>
                            <div id="f-usageCategories" class="pa-check-list">
                                <label class="pa-toggle"><input type="checkbox" data-cat value="LOGIN_RISK"> <spring:message code="security.admin.providerAdv.category.LOGIN_RISK"/></label>
                                <label class="pa-toggle"><input type="checkbox" data-cat value="WAF_SYNC"> <spring:message code="security.admin.providerAdv.category.WAF_SYNC"/></label>
                                <label class="pa-toggle"><input type="checkbox" data-cat value="CONTENT_MODERATION"> <spring:message code="security.admin.providerAdv.category.CONTENT_MODERATION"/></label>
                                <label class="pa-toggle"><input type="checkbox" data-cat value="IP_REPUTATION"> <spring:message code="security.admin.providerAdv.category.IP_REPUTATION"/></label>
                                <label class="pa-toggle"><input type="checkbox" data-cat value="EMAIL_REPUTATION"> <spring:message code="security.admin.providerAdv.category.EMAIL_REPUTATION"/></label>
                            </div>
                            <span class="pa-hint"><spring:message code="security.admin.providerAdv.modal.field.usageCategoriesHint"/></span>
                        </label>
                        <label class="full"><span><spring:message code="security.admin.providerAdv.modal.field.triggerEvents"/></span>
                            <div id="f-triggerEvents" class="pa-check-list">
                                <label class="pa-toggle"><input type="checkbox" data-ev value="LOGIN_ATTEMPT"> <spring:message code="security.admin.providerAdv.triggerEvent.LOGIN_ATTEMPT"/></label>
                                <label class="pa-toggle"><input type="checkbox" data-ev value="SIGNUP"> <spring:message code="security.admin.providerAdv.triggerEvent.SIGNUP"/></label>
                                <label class="pa-toggle"><input type="checkbox" data-ev value="REPORT_CREATED"> <spring:message code="security.admin.providerAdv.triggerEvent.REPORT_CREATED"/></label>
                                <label class="pa-toggle"><input type="checkbox" data-ev value="COMMUNITY_POST_CREATED"> <spring:message code="security.admin.providerAdv.triggerEvent.COMMUNITY_POST_CREATED"/></label>
                                <label class="pa-toggle"><input type="checkbox" data-ev value="PASSWORD_RESET"> <spring:message code="security.admin.providerAdv.triggerEvent.PASSWORD_RESET"/></label>
                            </div>
                            <span class="pa-hint"><spring:message code="security.admin.providerAdv.modal.field.triggerEventsHint"/></span>
                        </label>
                        <label class="full"><span><spring:message code="security.admin.providerAdv.modal.field.description"/></span>
                            <textarea class="adm-input" name="description" id="f-description" rows="3" maxlength="1000"></textarea>
                        </label>
                        <div class="pa-form-field"><span><spring:message code="security.admin.providerAdv.modal.field.enabled"/></span>
                            <label class="pa-toggle"><input type="checkbox" name="enabled" id="f-enabled"> ${msg_filterEnYes}</label>
                        </div>
                    </div>
                </div>
                <div class="pa-pane" data-pane="request" hidden>
                    <div class="pa-grid">
                        <label class="full"><span><spring:message code="security.admin.providerAdv.modal.field.endpointUrl"/></span>
                            <input class="adm-input" type="text" name="endpointUrl" id="f-endpointUrl" maxlength="500" placeholder="https://api.example.com/risk">
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.apiKeyRef"/></span>
                            <input class="adm-input" type="text" name="apiKeyRef" id="f-apiKeyRef" maxlength="160" placeholder="ENV:TRIPTOGETHER_AI_KEY">
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.modelName"/></span>
                            <input class="adm-input" type="text" name="modelName" id="f-modelName" maxlength="160">
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.requestMethod"/></span>
                            <select class="adm-select" name="requestMethod" id="f-requestMethod">
                                <option value="">(default)</option>
                                <option value="GET">GET</option>
                                <option value="POST">POST</option>
                                <option value="PUT">PUT</option>
                                <option value="PATCH">PATCH</option>
                                <option value="DELETE">DELETE</option>
                            </select>
                        </label>
                        <label class="full"><span><spring:message code="security.admin.providerAdv.modal.field.requestHeadersJson"/></span>
                            <textarea class="adm-input" name="requestHeadersJson" id="f-requestHeadersJson" rows="3" placeholder='{"X-Source":"TripTogether"}'></textarea>
                            <span class="pa-hint"><spring:message code="security.admin.providerAdv.modal.field.requestHeadersHint"/></span>
                        </label>
                        <label class="full"><span><spring:message code="security.admin.providerAdv.modal.field.requestTemplateJson"/></span>
                            <textarea class="adm-input" name="requestTemplateJson" id="f-requestTemplateJson" rows="5"></textarea>
                            <span class="pa-hint"><spring:message code="security.admin.providerAdv.modal.field.requestTemplateHint"/></span>
                        </label>
                        <label class="full"><span><spring:message code="security.admin.providerAdv.modal.field.responseMappingJson"/></span>
                            <textarea class="adm-input" name="responseMappingJson" id="f-responseMappingJson" rows="3" placeholder='{"score":"/risk/score","label":"/risk/level"}'></textarea>
                            <span class="pa-hint"><spring:message code="security.admin.providerAdv.modal.field.responseMappingHint"/></span>
                        </label>
                    </div>
                </div>
                <div class="pa-pane" data-pane="limits" hidden>
                    <div class="pa-grid">
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.timeoutMillis"/></span>
                            <input class="adm-input" type="number" name="timeoutMillis" id="f-timeoutMillis" min="100" max="120000">
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.failOpen"/></span>
                            <select class="adm-select" name="failOpen" id="f-failOpen">
                                <option value="1">${msg_failOpenOpen}</option>
                                <option value="0">${msg_failOpenClosed}</option>
                            </select>
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.maxConcurrent"/></span>
                            <input class="adm-input" type="number" name="maxConcurrent" id="f-maxConcurrent" min="1" max="10000">
                            <span class="pa-hint"><spring:message code="security.admin.providerAdv.modal.field.maxConcurrentHint"/></span>
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.ratePerMinute"/></span>
                            <input class="adm-input" type="number" name="ratePerMinute" id="f-ratePerMinute" min="1" max="1000000">
                            <span class="pa-hint"><spring:message code="security.admin.providerAdv.modal.field.ratePerMinuteHint"/></span>
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.retryCount"/></span>
                            <input class="adm-input" type="number" name="retryCount" id="f-retryCount" min="0" max="20">
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.retryBackoffMs"/></span>
                            <input class="adm-input" type="number" name="retryBackoffMs" id="f-retryBackoffMs" min="0" max="60000">
                        </label>
                    </div>
                </div>
                <div class="pa-pane" data-pane="health" hidden>
                    <div class="pa-grid">
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.healthCheckIntervalSec"/></span>
                            <input class="adm-input" type="number" name="healthCheckIntervalSec" id="f-healthCheckIntervalSec" min="30" max="86400">
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.nextHealthCheckAt"/></span>
                            <input class="adm-input" type="text" id="f-nextHealthCheckAt" disabled>
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.lastCheckedAt"/></span>
                            <input class="adm-input" type="text" id="f-lastCheckedAt" disabled>
                        </label>
                    </div>
                </div>
            </div>
            <div class="pa-foot">
                <div class="pa-foot-actions">
                    <button type="button" class="adm-btn" id="pa-deleteBtn" hidden>${msg_actDelete}</button>
                    <button type="button" class="adm-btn" id="pa-restoreBtn" hidden>${msg_actRestore}</button>
                    <button type="button" class="adm-btn" id="pa-checkBtn" hidden><spring:message code="security.admin.providerAdv.row.action.check"/></button>
                </div>
                <div class="pa-foot-actions">
                    <button type="button" class="adm-btn" id="pa-cancelBtn">${msg_actCancel}</button>
                    <button type="submit" class="adm-btn adm-btn-primary" id="pa-saveBtn">${msg_actSave}</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="pa-toast" id="pa-toast"></div>
</div>

<script>
(function () {
    const ctx = '${pageContext.request.contextPath}';
    const MSG = {
        empty: '${js_empty}',
        totalCount: '${js_totalCount}',
        selectedCount: '${js_selectedCount}',
        confirmDelete: '${js_confirmDelete}',
        confirmRestore: '${js_confirmRestore}',
        confirmBulkAction: '${js_confirmBulkAction}',
        invalidJson: '${js_invalidJson}',
        toastSaved: '${js_toastSaved}',
        toastCreated: '${js_toastCreated}',
        toastDeleted: '${js_toastDeleted}',
        toastRestored: '${js_toastRestored}',
        toastChecked: '${js_toastChecked}',
        toastBulkDone: '${js_toastBulkDone}',
        toastFailed: '${js_toastFailed}',
        modalCreateTitle: '${js_modalCreateTitle}',
        modalEditTitle: '${js_modalEditTitle}',
        actSave: '${js_actSave}',
        actCreate: '${js_actCreate}',
        exportSelected: '${js_exportSelected}'
    };

    const state = {
        sort: 'priority_desc',
        page: 1,
        pageSize: 20,
        rows: [],
        total: 0,
        totalPage: 1,
        selected: new Set()
    };

    const $ = (id) => document.getElementById(id);
    const escHtml = (s) => (s == null ? '' : String(s).replace(/[&<>"']/g, m => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[m])));
    const fmt = (msgPattern, ...args) => msgPattern.replace(/\{(\d+)\}/g, (_, i) => args[parseInt(i, 10)] ?? '');
    const showToast = (text) => {
        const t = $('pa-toast'); t.textContent = text; t.classList.add('show');
        clearTimeout(t._timer); t._timer = setTimeout(() => t.classList.remove('show'), 2200);
    };

    const buildFilterParams = () => {
        const p = new URLSearchParams();
        const v = (id) => $(id).value;
        if (v('pa-keyword')) p.set('keyword', v('pa-keyword'));
        if (v('pa-kind')) p.set('kind', v('pa-kind'));
        if (v('pa-status')) p.set('status', v('pa-status'));
        if (v('pa-enabled')) p.set('enabled', v('pa-enabled'));
        if (v('pa-category')) p.set('category', v('pa-category'));
        if (v('pa-trigger')) p.set('triggerEvent', v('pa-trigger'));
        if ($('pa-includeDeleted').checked) p.set('includeDeleted', 'true');
        if ($('pa-onlyDeleted').checked) p.set('onlyDeleted', 'true');
        p.set('sort', state.sort);
        p.set('page', state.page);
        p.set('pageSize', state.pageSize);
        return p;
    };

    const loadList = async () => {
        const params = buildFilterParams();
        try {
            const res = await fetch(ctx + '/admin/login-risk/provider-configs/api?' + params.toString());
            const data = await res.json();
            state.rows = data.rows || [];
            state.total = data.total || 0;
            state.totalPage = data.totalPage || 1;
            renderTable();
            renderPagination();
            renderTotal();
        } catch (e) {
            showToast(MSG.toastFailed);
        }
    };

    const formatDate = (s) => s ? String(s).replace('T', ' ').substring(0, 16) : '';

    const renderTable = () => {
        const tbody = $('pa-rows');
        if (!state.rows.length) {
            tbody.innerHTML = '<tr><td colspan="11" class="pa-empty-cell">' + escHtml(MSG.empty) + '</td></tr>';
            return;
        }
        const html = state.rows.map(row => {
            const isDeleted = !!row.deletedAt;
            const cats = (row.usageCategories || '').split(',').filter(s => s.trim()).map(c =>
                '<span class="chip">' + escHtml(c.trim()) + '</span>').join('');
            const checked = state.selected.has(row.providerIdx) ? 'checked' : '';
            return '' +
                '<tr class="' + (isDeleted ? 'row-deleted' : '') + '" data-idx="' + row.providerIdx + '">' +
                  '<td class="pa-check-col"><input type="checkbox" class="pa-rowsel pa-check-input" value="' + row.providerIdx + '" ' + checked + '></td>' +
                  '<td><span class="priority-bar">' + (row.priority ?? '') + '</span></td>' +
                  '<td><span class="chip kind-' + escHtml(row.providerKind) + '">' + escHtml(row.providerKind || '') + '</span></td>' +
                  '<td><a href="#" class="adm-inline-link pa-edit-link" data-idx="' + row.providerIdx + '">' + escHtml(row.providerName || '') + '</a></td>' +
                  '<td><code>' + escHtml(row.providerCode || '') + '</code></td>' +
                  '<td>' + cats + '</td>' +
                  '<td><span class="chip status-' + escHtml(row.status) + '">' + escHtml(row.status || '') + '</span></td>' +
                  '<td>' + (row.enabled ? '✔' : '—') + '</td>' +
                  '<td>' + escHtml(formatDate(row.lastCheckedAt)) + '</td>' +
                  '<td>' + escHtml(formatDate(row.nextHealthCheckAt)) + '</td>' +
                  '<td><div class="pa-row-actions">' +
                    '<button type="button" class="adm-btn pa-edit" data-idx="' + row.providerIdx + '"><spring:message code="security.admin.providerAdv.row.action.edit"/></button> ' +
                    (isDeleted
                      ? '<button type="button" class="adm-btn pa-restore" data-idx="' + row.providerIdx + '"><spring:message code="security.admin.providerAdv.row.action.restore"/></button>'
                      : '<button type="button" class="adm-btn pa-check" data-idx="' + row.providerIdx + '"><spring:message code="security.admin.providerAdv.row.action.check"/></button> ' +
                        '<button type="button" class="adm-btn pa-delete" data-idx="' + row.providerIdx + '"><spring:message code="security.admin.providerAdv.row.action.delete"/></button>'
                    ) +
                  '</div></td>' +
                '</tr>';
        }).join('');
        tbody.innerHTML = html;
    };

    const renderPagination = () => {
        const pg = $('pa-pagination');
        if (state.pageSize === 0 || state.totalPage <= 1) { pg.innerHTML = ''; return; }
        const cur = state.page;
        const last = state.totalPage;
        const html = [];
        const btn = (label, page, opts) => {
            opts = opts || {};
            const cls = 'pg-btn' + (opts.active ? ' active' : '');
            const dis = opts.disabled ? 'disabled' : '';
            return '<button class="' + cls + '" data-page="' + page + '" ' + dis + '>' + label + '</button>';
        };
        html.push(btn('«', 1, { disabled: cur === 1 }));
        html.push(btn('‹', Math.max(1, cur - 1), { disabled: cur === 1 }));
        const start = Math.max(1, cur - 3);
        const end = Math.min(last, start + 6);
        for (let i = start; i <= end; i++) html.push(btn(i, i, { active: i === cur }));
        html.push(btn('›', Math.min(last, cur + 1), { disabled: cur === last }));
        html.push(btn('»', last, { disabled: cur === last }));
        pg.innerHTML = html.join('');
    };

    const updateSortIndicators = () => {
        const currentBase = state.sort.replace(/_(asc|desc)$/i, '');
        const isDesc = state.sort.endsWith('_desc');
        document.querySelectorAll('.pa-table th[data-sort]').forEach(th => {
            const thBase = th.dataset.sort.replace(/_(asc|desc)$/i, '');
            const active = thBase === currentBase;
            th.classList.toggle('sorted', active);
            const ico = th.querySelector('.sort-ico');
            if (!ico) return;
            if (active) {
                ico.className = 'sort-ico ' + (isDesc ? 'desc' : 'asc');
                ico.textContent = isDesc ? '▼' : '▲';
            } else {
                ico.className = 'sort-ico';
                ico.textContent = '';
            }
        });
        const resetBtn = $('pa-sortReset');
        if (resetBtn) resetBtn.classList.toggle('adm-is-hidden', state.sort === 'priority_desc');
        syncProviderControlOverflow();
    };

    const renderTotal = () => {
        $('pa-totalLine').textContent = fmt(MSG.totalCount, state.total);
        const sel = state.selected.size;
        const bulkbar = $('pa-bulkbar');
        const selectedLabel = $('pa-selectedLabel');
        const selectedExport = $('pa-exportSelectedBtn');
        const selectAll = $('pa-selAll');
        if (bulkbar) {
            bulkbar.classList.toggle('is-active', sel > 0);
            bulkbar.setAttribute('aria-hidden', sel > 0 ? 'false' : 'true');
            bulkbar.querySelectorAll('button[data-bulk-action]').forEach(btn => { btn.disabled = sel === 0; });
        }
        if (selectedLabel) selectedLabel.textContent = sel > 0 ? fmt(MSG.selectedCount, sel) : fmt(MSG.selectedCount, 0);
        if (selectedExport) {
            selectedExport.disabled = sel === 0;
            selectedExport.classList.toggle('has-selection', sel > 0);
            selectedExport.textContent = MSG.exportSelected + ' (' + sel + ')';
        }
        if (selectAll) {
            const visibleChecks = Array.from(document.querySelectorAll('.pa-rowsel'));
            const checked = visibleChecks.filter(cb => cb.checked);
            selectAll.checked = visibleChecks.length > 0 && checked.length === visibleChecks.length;
            selectAll.indeterminate = checked.length > 0 && checked.length < visibleChecks.length;
        }
        updateSortIndicators();
    };

    const setSort = (key) => {
        if (state.sort === key) {
            state.sort = key.endsWith('_asc') ? key.replace('_asc', '_desc') : key.replace('_desc', '_asc');
        } else {
            state.sort = key;
        }
        state.page = 1;
        loadList();
    };

    const validateJson = (s, fieldName) => {
        if (!s || !s.trim()) return null;
        try { JSON.parse(s); return null; } catch (e) { return fmt(MSG.invalidJson, fieldName); }
    };

    const openModal = async (idx) => {
        const m = $('pa-modal');
        const err = $('pa-modalError'); err.classList.remove('show'); err.textContent = '';
        document.querySelectorAll('#pa-form input, #pa-form textarea, #pa-form select').forEach(el => {
            if (el.type === 'checkbox') el.checked = false;
            else el.value = '';
        });
        document.querySelectorAll('.pa-tab').forEach(t => t.classList.toggle('active', t.dataset.tab === 'basic'));
        document.querySelectorAll('.pa-pane').forEach(p => p.hidden = (p.dataset.pane !== 'basic'));
        if (idx) {
            try {
                const res = await fetch(ctx + '/admin/login-risk/provider-configs/' + idx + '/api');
                const row = await res.json();
                $('f-providerIdx').value = row.providerIdx;
                $('f-providerCode').value = row.providerCode || '';
                $('f-providerCode').readOnly = true;
                $('f-providerKind').value = row.providerKind || 'AI_MODEL';
                $('f-providerName').value = row.providerName || '';
                $('f-priority').value = row.priority ?? 100;
                $('f-tags').value = row.tags || '';
                $('f-description').value = row.description || '';
                $('f-enabled').checked = !!row.enabled;
                $('f-endpointUrl').value = row.endpointUrl || '';
                $('f-apiKeyRef').value = row.apiKeyRef || '';
                $('f-modelName').value = row.modelName || '';
                $('f-requestMethod').value = row.requestMethod || '';
                $('f-requestHeadersJson').value = row.requestHeadersJson || '';
                $('f-requestTemplateJson').value = row.requestTemplateJson || '';
                $('f-responseMappingJson').value = row.responseMappingJson || '';
                $('f-timeoutMillis').value = row.timeoutMillis ?? 3000;
                $('f-failOpen').value = row.failOpen ?? 1;
                $('f-maxConcurrent').value = row.maxConcurrent ?? '';
                $('f-ratePerMinute').value = row.ratePerMinute ?? '';
                $('f-retryCount').value = row.retryCount ?? 0;
                $('f-retryBackoffMs').value = row.retryBackoffMs ?? 500;
                $('f-healthCheckIntervalSec').value = row.healthCheckIntervalSec ?? 300;
                $('f-nextHealthCheckAt').value = formatDate(row.nextHealthCheckAt);
                $('f-lastCheckedAt').value = formatDate(row.lastCheckedAt);
                const cats = (row.usageCategories || '').split(',').map(s => s.trim()).filter(Boolean);
                document.querySelectorAll('#f-usageCategories input[data-cat]').forEach(cb => cb.checked = cats.includes(cb.value));
                const evs = (row.triggerEvents || '').split(',').map(s => s.trim()).filter(Boolean);
                document.querySelectorAll('#f-triggerEvents input[data-ev]').forEach(cb => cb.checked = evs.includes(cb.value));
                $('pa-modalTitle').textContent = MSG.modalEditTitle;
                $('pa-saveBtn').textContent = MSG.actSave;
                $('pa-deleteBtn').hidden = !!row.deletedAt;
                $('pa-restoreBtn').hidden = !row.deletedAt;
                $('pa-checkBtn').hidden = !!row.deletedAt;
            } catch (e) {
                showToast(MSG.toastFailed);
                return;
            }
        } else {
            $('f-providerIdx').value = '';
            $('f-providerCode').readOnly = false;
            $('f-providerKind').value = 'AI_MODEL';
            $('f-priority').value = 100;
            $('f-timeoutMillis').value = 3000;
            $('f-failOpen').value = 1;
            $('f-retryCount').value = 0;
            $('f-retryBackoffMs').value = 500;
            $('f-healthCheckIntervalSec').value = 300;
            $('pa-modalTitle').textContent = MSG.modalCreateTitle;
            $('pa-saveBtn').textContent = MSG.actCreate;
            $('pa-deleteBtn').hidden = true;
            $('pa-restoreBtn').hidden = true;
            $('pa-checkBtn').hidden = true;
        }
        m.hidden = false;
    };
    const closeModal = () => { $('pa-modal').hidden = true; };

    const submitForm = async (e) => {
        e.preventDefault();
        const err = $('pa-modalError');
        err.classList.remove('show'); err.textContent = '';

        for (const [id, label] of [['f-requestHeadersJson','headers'], ['f-requestTemplateJson','template'], ['f-responseMappingJson','mapping']]) {
            const msg = validateJson($(id).value, label);
            if (msg) { err.textContent = msg; err.classList.add('show'); return; }
        }
        const cats = Array.from(document.querySelectorAll('#f-usageCategories input[data-cat]:checked')).map(cb => cb.value).join(',');
        const evs = Array.from(document.querySelectorAll('#f-triggerEvents input[data-ev]:checked')).map(cb => cb.value).join(',');
        const fd = new FormData($('pa-form'));
        fd.set('usageCategories', cats);
        fd.set('triggerEvents', evs);
        if (!$('f-enabled').checked) fd.delete('enabled');
        const idx = $('f-providerIdx').value;
        const url = idx ? (ctx + '/admin/login-risk/provider-configs/' + idx) : (ctx + '/admin/login-risk/provider-configs');
        try {
            const res = await fetch(url, { method:'POST', body: fd, redirect:'manual' });
            if (res.type === 'opaqueredirect' || res.ok || res.status === 0) {
                showToast(idx ? MSG.toastSaved : MSG.toastCreated);
                closeModal();
                loadList();
            } else {
                showToast(MSG.toastFailed);
            }
        } catch (e) {
            showToast(idx ? MSG.toastSaved : MSG.toastCreated);
            closeModal();
            loadList();
        }
    };

    const rowAction = async (action, idx) => {
        if (action === 'delete' && !confirm(MSG.confirmDelete)) return;
        if (action === 'restore' && !confirm(MSG.confirmRestore)) return;
        const url = ctx + '/admin/login-risk/provider-configs/' + idx + '/' + action;
        try {
            await fetch(url, { method:'POST', redirect:'manual' });
            showToast(action === 'delete' ? MSG.toastDeleted : action === 'restore' ? MSG.toastRestored : MSG.toastChecked);
            loadList();
        } catch (e) { showToast(MSG.toastFailed); }
    };

    const bulkAction = async (action) => {
        if (state.selected.size === 0) return;
        if (!confirm(fmt(MSG.confirmBulkAction, state.selected.size))) return;
        const fd = new FormData();
        fd.set('action', action);
        fd.set('ids', Array.from(state.selected).join(','));
        try {
            const res = await fetch(ctx + '/admin/login-risk/provider-configs/bulk', { method:'POST', body: fd });
            const data = await res.json();
            showToast(fmt(MSG.toastBulkDone, data.requested, data.affected));
            state.selected.clear();
            loadList();
        } catch (e) { showToast(MSG.toastFailed); }
    };

    const exportData = (scope) => {
        const format = $('pa-exportFormat').value;
        const params = buildFilterParams();
        params.set('scope', scope);
        params.set('format', format);
        if (scope === 'selected') {
            if (state.selected.size === 0) return;
            params.set('selectedIds', Array.from(state.selected).join(','));
        }
        window.location.href = ctx + '/admin/login-risk/provider-configs/export?' + params.toString();
    };

    let providerControlOverflowSync = null;

    function isVisibleProviderTool(tool) {
        return !!tool && !tool.classList.contains('adm-is-hidden');
    }

    function syncProviderControlOverflow() {
        if (typeof providerControlOverflowSync === 'function') providerControlOverflowSync();
    }

    function initProviderControlOverflow() {
        const primary = $('pa-primaryTools');
        const menu = $('pa-overflowMenu');
        const panel = $('pa-overflowPanel');
        const toggle = menu ? menu.querySelector('.pa-overflow-toggle') : null;
        if (!primary || !menu || !panel || !toggle) return;

        const tools = [
            { node: $('pa-sortReset'), breakpoint: 1360 },
            { node: document.querySelector('.pa-size-tool'), breakpoint: 1220 },
            { node: $('pa-refresh'), breakpoint: 1040 },
            { node: $('pa-openCreate'), breakpoint: 760 }
        ].filter(item => !!item.node);

        providerControlOverflowSync = function () {
            const width = window.innerWidth || document.documentElement.clientWidth || 1600;
            tools.forEach(item => {
                const target = width <= item.breakpoint ? panel : primary;
                if (item.node.parentElement !== target) target.appendChild(item.node);
            });
            const hasItems = Array.from(panel.children).some(isVisibleProviderTool);
            menu.classList.toggle('has-items', hasItems);
            if (!hasItems) {
                menu.classList.remove('open');
                toggle.setAttribute('aria-expanded', 'false');
            }
        };

        toggle.addEventListener('click', () => {
            const willOpen = !menu.classList.contains('open');
            menu.classList.toggle('open', willOpen);
            toggle.setAttribute('aria-expanded', willOpen ? 'true' : 'false');
        });
        document.addEventListener('click', e => {
            if (!menu.contains(e.target)) {
                menu.classList.remove('open');
                toggle.setAttribute('aria-expanded', 'false');
            }
        });
        window.addEventListener('resize', syncProviderControlOverflow, { passive: true });
        syncProviderControlOverflow();
    }

    document.addEventListener('DOMContentLoaded', () => {
        loadList();

        ['pa-keyword','pa-kind','pa-status','pa-enabled','pa-category','pa-trigger'].forEach(id => {
            const el = $(id);
            const handler = () => { state.page = 1; loadList(); };
            el.addEventListener(id === 'pa-keyword' ? 'input' : 'change', handler);
        });
        ['pa-includeDeleted','pa-onlyDeleted'].forEach(id => {
            $(id).addEventListener('change', () => { state.page = 1; loadList(); });
        });
        $('pa-pageSize').addEventListener('change', (e) => {
            state.pageSize = parseInt(e.target.value, 10) || 0;
            state.page = 1;
            loadList();
        });
        $('pa-sortReset').addEventListener('click', () => { state.sort = 'priority_desc'; state.page = 1; loadList(); });
        $('pa-refresh').addEventListener('click', loadList);
        $('pa-openCreate').addEventListener('click', () => openModal(null));

        initProviderControlOverflow();

        document.querySelectorAll('.pa-table thead th[data-sort]').forEach(th => {
            th.addEventListener('click', () => setSort(th.dataset.sort));
        });

        $('pa-rows').addEventListener('change', (e) => {
            if (e.target.classList.contains('pa-rowsel')) {
                const id = parseInt(e.target.value, 10);
                if (e.target.checked) state.selected.add(id); else state.selected.delete(id);
                renderTotal();
            }
        });
        $('pa-rows').addEventListener('click', (e) => {
            const t = e.target.closest('button, a');
            if (!t) return;
            const idx = parseInt(t.dataset.idx, 10);
            if (t.classList.contains('pa-edit') || t.classList.contains('pa-edit-link')) { e.preventDefault(); openModal(idx); }
            else if (t.classList.contains('pa-delete')) rowAction('delete', idx);
            else if (t.classList.contains('pa-restore')) rowAction('restore', idx);
            else if (t.classList.contains('pa-check')) rowAction('check', idx);
        });
        $('pa-selAll').addEventListener('change', (e) => {
            const checked = e.target.checked;
            document.querySelectorAll('.pa-rowsel').forEach(cb => {
                cb.checked = checked;
                const id = parseInt(cb.value, 10);
                if (checked) state.selected.add(id); else state.selected.delete(id);
            });
            renderTotal();
        });
        $('pa-bulkbar').addEventListener('click', (e) => {
            const t = e.target.closest('button[data-bulk-action]');
            if (t) bulkAction(t.dataset.bulkAction);
        });
        $('pa-pagination').addEventListener('click', (e) => {
            const b = e.target.closest('button[data-page]');
            if (!b || b.disabled) return;
            state.page = parseInt(b.dataset.page, 10) || 1;
            loadList();
        });
        document.querySelectorAll('.pa-tab').forEach(tab => {
            tab.addEventListener('click', () => {
                const tabName = tab.dataset.tab;
                document.querySelectorAll('.pa-tab').forEach(t => t.classList.toggle('active', t === tab));
                document.querySelectorAll('.pa-pane').forEach(p => p.hidden = (p.dataset.pane !== tabName));
            });
        });
        $('pa-modalClose').addEventListener('click', closeModal);
        $('pa-cancelBtn').addEventListener('click', closeModal);
        $('pa-modal').addEventListener('click', (e) => { if (e.target === $('pa-modal')) closeModal(); });
        document.addEventListener('keydown', (e) => { if (e.key === 'Escape' && !$('pa-modal').hidden) closeModal(); });
        $('pa-form').addEventListener('submit', submitForm);
        $('pa-deleteBtn').addEventListener('click', () => {
            const idx = parseInt($('f-providerIdx').value, 10);
            if (idx) { closeModal(); rowAction('delete', idx); }
        });
        $('pa-restoreBtn').addEventListener('click', () => {
            const idx = parseInt($('f-providerIdx').value, 10);
            if (idx) { closeModal(); rowAction('restore', idx); }
        });
        $('pa-checkBtn').addEventListener('click', () => {
            const idx = parseInt($('f-providerIdx').value, 10);
            if (idx) rowAction('check', idx);
        });

        const dropdown = $('pa-exportDropdown');
        $('pa-exportToggle').addEventListener('click', (e) => {
            e.stopPropagation();
            dropdown.classList.toggle('open');
        });
        document.addEventListener('click', (e) => {
            if (!dropdown.contains(e.target)) dropdown.classList.remove('open');
        });
        dropdown.addEventListener('click', (e) => {
            const b = e.target.closest('button[data-export-scope]');
            if (b) {
                exportData(b.dataset.exportScope);
                dropdown.classList.remove('open');
            }
        });
    });
})();
</script>

<%@ include file="../layout-close.jsp" %>
