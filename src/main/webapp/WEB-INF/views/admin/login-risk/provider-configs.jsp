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

<c:set var="pageTitle" value="${msg_title}"/>
<c:set var="activeMenu" value="securityProviderConfigs"/>

<%@ include file="../layout.jsp" %>

<style>
  .adm-providerAdv-page .adm-toolbar { display:flex; flex-wrap:wrap; gap:.5rem; align-items:flex-end; padding:.75rem; border:1px solid var(--adm-border, #ddd); border-radius:.5rem; background:var(--adm-card-bg, #fff); margin-bottom:.75rem; }
  .adm-providerAdv-page .adm-toolbar > .field { display:flex; flex-direction:column; gap:.15rem; min-width:120px; }
  .adm-providerAdv-page .adm-toolbar label.field-label { font-size:.78rem; opacity:.75; }
  .adm-providerAdv-page .adm-toolbar .grow { flex:1; min-width:240px; }
  .adm-providerAdv-page .adm-toolbar .toggle { display:inline-flex; gap:.3rem; align-items:center; }
  .adm-providerAdv-page .adm-bulkbar { display:flex; gap:.4rem; align-items:center; padding:.5rem .75rem; background:var(--adm-warning-bg, #fff7e6); border:1px solid var(--adm-warning-border, #f0c378); border-radius:.4rem; margin-bottom:.5rem; }
  .adm-providerAdv-page .adm-bulkbar.hidden { display:none; }
  .adm-providerAdv-page .adm-table { width:100%; border-collapse:collapse; }
  .adm-providerAdv-page .adm-table th, .adm-providerAdv-page .adm-table td { padding:.4rem .55rem; border-bottom:1px solid var(--adm-border, #e2e2e2); vertical-align:middle; font-size:.85rem; }
  .adm-providerAdv-page .adm-table th { text-align:left; background:var(--adm-card-head-bg, #f6f6f6); font-weight:600; cursor:pointer; user-select:none; }
  .adm-providerAdv-page .adm-table th.sort-asc::after { content:" ▲"; opacity:.6; }
  .adm-providerAdv-page .adm-table th.sort-desc::after { content:" ▼"; opacity:.6; }
  .adm-providerAdv-page .adm-table tr.row-deleted { opacity:.55; }
  .adm-providerAdv-page .chip { display:inline-block; padding:.1rem .45rem; border-radius:.6rem; font-size:.72rem; background:#eee; color:#333; margin-right:.15rem; }
  .adm-providerAdv-page .chip.kind-AI_MODEL { background:#dbeafe; color:#1e40af; }
  .adm-providerAdv-page .chip.kind-POLICY_AUTHORITY { background:#fef3c7; color:#854d0e; }
  .adm-providerAdv-page .chip.kind-RULE_ALGORITHM { background:#e0e7ff; color:#3730a3; }
  .adm-providerAdv-page .chip.kind-WAF_PROVIDER, .adm-providerAdv-page .chip.kind-WAF, .adm-providerAdv-page .chip.kind-WAF_CDN { background:#fee2e2; color:#991b1b; }
  .adm-providerAdv-page .chip.kind-CONTENT_MODERATION { background:#dcfce7; color:#166534; }
  .adm-providerAdv-page .chip.kind-IP_REPUTATION { background:#fce7f3; color:#9d174d; }
  .adm-providerAdv-page .chip.kind-EMAIL_REPUTATION { background:#cffafe; color:#155e75; }
  .adm-providerAdv-page .chip.kind-CUSTOM_WEBHOOK { background:#f3e8ff; color:#6b21a8; }
  .adm-providerAdv-page .chip.status-DISABLED { background:#e5e7eb; color:#374151; }
  .adm-providerAdv-page .chip.status-READY { background:#dcfce7; color:#166534; }
  .adm-providerAdv-page .chip.status-READY_NEEDS_SECRET { background:#fef3c7; color:#854d0e; }
  .adm-providerAdv-page .chip.status-ERROR { background:#fee2e2; color:#991b1b; }
  .adm-providerAdv-page .priority-bar { display:inline-block; min-width:2.4rem; text-align:center; padding:.05rem .35rem; border-radius:.25rem; background:#e5e7eb; font-weight:600; }
  .adm-providerAdv-page .pagination { display:flex; gap:.25rem; align-items:center; justify-content:center; padding:.6rem 0; flex-wrap:wrap; }
  .adm-providerAdv-page .pagination .pg-btn { min-width:2rem; padding:.2rem .55rem; border:1px solid var(--adm-border, #ccc); background:#fff; cursor:pointer; border-radius:.25rem; }
  .adm-providerAdv-page .pagination .pg-btn.active { background:#2563eb; color:#fff; border-color:#2563eb; }
  .adm-providerAdv-page .pagination .pg-btn:disabled { opacity:.4; cursor:not-allowed; }
  .adm-providerAdv-page .total-line { font-size:.85rem; opacity:.8; padding:.4rem 0; }
  .adm-providerAdv-page .pa-modal { position:fixed; inset:0; background:rgba(0,0,0,.45); display:flex; align-items:center; justify-content:center; z-index:1050; }
  .adm-providerAdv-page .pa-modal[hidden] { display:none !important; }
  .adm-providerAdv-page .pa-card { background:#fff; max-width:920px; width:96%; max-height:92vh; overflow:auto; border-radius:.5rem; box-shadow:0 8px 30px rgba(0,0,0,.25); }
  .adm-providerAdv-page .pa-head { display:flex; justify-content:space-between; align-items:center; padding:.75rem 1rem; border-bottom:1px solid #eee; }
  .adm-providerAdv-page .pa-tabs { display:flex; gap:.25rem; padding:.5rem 1rem 0; flex-wrap:wrap; border-bottom:1px solid #eee; }
  .adm-providerAdv-page .pa-tab { padding:.5rem .9rem; border:1px solid #ddd; border-bottom:none; background:#f6f6f6; cursor:pointer; border-radius:.4rem .4rem 0 0; }
  .adm-providerAdv-page .pa-tab.active { background:#fff; font-weight:600; border-color:#2563eb; color:#2563eb; }
  .adm-providerAdv-page .pa-body { padding:1rem; }
  .adm-providerAdv-page .pa-pane[hidden] { display:none; }
  .adm-providerAdv-page .pa-grid { display:grid; grid-template-columns:repeat(2, minmax(0, 1fr)); gap:.7rem 1rem; }
  .adm-providerAdv-page .pa-grid label { display:flex; flex-direction:column; gap:.2rem; font-size:.82rem; }
  .adm-providerAdv-page .pa-grid label.full { grid-column:1 / -1; }
  .adm-providerAdv-page .pa-hint { font-size:.72rem; opacity:.7; }
  .adm-providerAdv-page .pa-foot { padding:.75rem 1rem; border-top:1px solid #eee; display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:.4rem; }
  .adm-providerAdv-page .pa-error { background:#fee2e2; color:#991b1b; padding:.4rem .7rem; border-radius:.3rem; margin:.4rem 1rem 0; display:none; }
  .adm-providerAdv-page .pa-error.show { display:block; }
  .adm-providerAdv-page .adm-export-dropdown { position:relative; display:inline-block; }
  .adm-providerAdv-page .adm-export-dropdown > .menu { position:absolute; top:100%; right:0; min-width:240px; padding:.4rem; background:#fff; border:1px solid #ddd; border-radius:.4rem; box-shadow:0 4px 12px rgba(0,0,0,.12); z-index:10; }
  .adm-providerAdv-page .adm-export-dropdown:not(.open) > .menu { display:none; }
  .adm-providerAdv-page .adm-export-dropdown .menu .row { display:flex; align-items:center; gap:.4rem; padding:.25rem .35rem; }
  .adm-providerAdv-page .adm-export-dropdown .menu .row .lbl { flex:1; font-size:.82rem; }
  .adm-providerAdv-page .adm-toast { position:fixed; bottom:1.5rem; left:50%; transform:translateX(-50%); background:#1f2937; color:#fff; padding:.55rem 1rem; border-radius:.4rem; z-index:1100; opacity:0; transition:opacity .2s; }
  .adm-providerAdv-page .adm-toast.show { opacity:.95; }
  @media (max-width: 720px) { .adm-providerAdv-page .pa-grid { grid-template-columns:1fr; } }
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

    <%-- Toolbar --%>
    <div class="adm-toolbar">
        <div class="field grow">
            <label class="field-label" for="pa-keyword">${msg_searchPh}</label>
            <input id="pa-keyword" class="adm-input" type="text" placeholder="${msg_searchPh}">
        </div>
        <div class="field">
            <label class="field-label" for="pa-kind">${msg_filterKind}</label>
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
        <div class="field">
            <label class="field-label" for="pa-status">${msg_filterStatus}</label>
            <select id="pa-status" class="adm-select">
                <option value="">${msg_filterAll}</option>
                <option value="DISABLED"><spring:message code="security.admin.providerAdv.status.DISABLED"/></option>
                <option value="READY"><spring:message code="security.admin.providerAdv.status.READY"/></option>
                <option value="READY_NEEDS_SECRET"><spring:message code="security.admin.providerAdv.status.READY_NEEDS_SECRET"/></option>
                <option value="ERROR"><spring:message code="security.admin.providerAdv.status.ERROR"/></option>
            </select>
        </div>
        <div class="field">
            <label class="field-label" for="pa-enabled">${msg_filterEnabled}</label>
            <select id="pa-enabled" class="adm-select">
                <option value="">${msg_filterAll}</option>
                <option value="1">${msg_filterEnYes}</option>
                <option value="0">${msg_filterEnNo}</option>
            </select>
        </div>
        <div class="field">
            <label class="field-label" for="pa-category">${msg_filterCategory}</label>
            <select id="pa-category" class="adm-select">
                <option value="">${msg_filterAll}</option>
                <option value="LOGIN_RISK"><spring:message code="security.admin.providerAdv.category.LOGIN_RISK"/></option>
                <option value="WAF_SYNC"><spring:message code="security.admin.providerAdv.category.WAF_SYNC"/></option>
                <option value="CONTENT_MODERATION"><spring:message code="security.admin.providerAdv.category.CONTENT_MODERATION"/></option>
                <option value="IP_REPUTATION"><spring:message code="security.admin.providerAdv.category.IP_REPUTATION"/></option>
                <option value="EMAIL_REPUTATION"><spring:message code="security.admin.providerAdv.category.EMAIL_REPUTATION"/></option>
            </select>
        </div>
        <div class="field">
            <label class="field-label" for="pa-trigger">${msg_filterTrigger}</label>
            <select id="pa-trigger" class="adm-select">
                <option value="">${msg_filterAll}</option>
                <option value="LOGIN_ATTEMPT"><spring:message code="security.admin.providerAdv.triggerEvent.LOGIN_ATTEMPT"/></option>
                <option value="SIGNUP"><spring:message code="security.admin.providerAdv.triggerEvent.SIGNUP"/></option>
                <option value="REPORT_CREATED"><spring:message code="security.admin.providerAdv.triggerEvent.REPORT_CREATED"/></option>
                <option value="COMMUNITY_POST_CREATED"><spring:message code="security.admin.providerAdv.triggerEvent.COMMUNITY_POST_CREATED"/></option>
                <option value="PASSWORD_RESET"><spring:message code="security.admin.providerAdv.triggerEvent.PASSWORD_RESET"/></option>
            </select>
        </div>
        <div class="field">
            <label class="field-label">&nbsp;</label>
            <label class="toggle"><input id="pa-includeDeleted" type="checkbox"> ${msg_filterIncludeDeleted}</label>
        </div>
        <div class="field">
            <label class="field-label">&nbsp;</label>
            <label class="toggle"><input id="pa-onlyDeleted" type="checkbox"> ${msg_filterOnlyDeleted}</label>
        </div>
        <div class="field">
            <label class="field-label" for="pa-pageSize">${msg_pageSize}</label>
            <select id="pa-pageSize" class="adm-select">
                <option value="20">20</option>
                <option value="50">50</option>
                <option value="100">100</option>
                <option value="0">${msg_pageSizeAll}</option>
            </select>
        </div>
        <div class="field">
            <label class="field-label">&nbsp;</label>
            <button type="button" class="adm-btn" id="pa-sortReset">${msg_sortReset}</button>
        </div>
        <div class="field" style="margin-left:auto;">
            <label class="field-label">&nbsp;</label>
            <div style="display:flex; gap:.4rem;">
                <button type="button" class="adm-btn" id="pa-refresh">${msg_refresh}</button>
                <button type="button" class="adm-btn primary" id="pa-openCreate">${msg_addNew}</button>
                <div class="adm-export-dropdown" id="pa-exportDropdown">
                    <button type="button" class="adm-btn" id="pa-exportToggle">${msg_export} ▾</button>
                    <div class="menu">
                        <div class="row"><span class="lbl">${msg_exportAll}</span>
                            <button type="button" class="adm-btn" data-export-scope="all" data-export-format="csv">${msg_exportCsv}</button>
                            <button type="button" class="adm-btn" data-export-scope="all" data-export-format="excel">${msg_exportExcel}</button>
                        </div>
                        <div class="row"><span class="lbl">${msg_exportFiltered}</span>
                            <button type="button" class="adm-btn" data-export-scope="filtered" data-export-format="csv">${msg_exportCsv}</button>
                            <button type="button" class="adm-btn" data-export-scope="filtered" data-export-format="excel">${msg_exportExcel}</button>
                        </div>
                        <div class="row"><span class="lbl">${msg_exportSelected}</span>
                            <button type="button" class="adm-btn" data-export-scope="selected" data-export-format="csv">${msg_exportCsv}</button>
                            <button type="button" class="adm-btn" data-export-scope="selected" data-export-format="excel">${msg_exportExcel}</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Bulk action bar (hidden until selection) --%>
    <div class="adm-bulkbar hidden" id="pa-bulkbar">
        <span id="pa-selectedLabel"></span>
        <button type="button" class="adm-btn" data-bulk-action="enable">${msg_bulkEnable}</button>
        <button type="button" class="adm-btn" data-bulk-action="disable">${msg_bulkDisable}</button>
        <button type="button" class="adm-btn" data-bulk-action="check">${msg_bulkCheck}</button>
        <button type="button" class="adm-btn" data-bulk-action="delete">${msg_bulkDelete}</button>
        <button type="button" class="adm-btn" data-bulk-action="restore">${msg_bulkRestore}</button>
    </div>

    <div class="total-line" id="pa-totalLine"></div>

    <div class="adm-card" style="padding:0;">
        <table class="adm-table">
            <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="pa-selAll"></th>
                    <th data-sort="priority_desc">${msg_colPriority}</th>
                    <th>${msg_colKind}</th>
                    <th data-sort="name_asc">${msg_colName}</th>
                    <th>${msg_colCode}</th>
                    <th>${msg_colCategory}</th>
                    <th>${msg_colStatus}</th>
                    <th>${msg_colEnabled}</th>
                    <th data-sort="last_checked_desc">${msg_colLastCheck}</th>
                    <th>${msg_colNextCheck}</th>
                    <th>${msg_colActions}</th>
                </tr>
            </thead>
            <tbody id="pa-rows">
                <tr><td colspan="11" style="text-align:center; padding:2rem;">…</td></tr>
            </tbody>
        </table>
    </div>

    <div class="pagination" id="pa-pagination"></div>
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
                            <div id="f-usageCategories">
                                <label class="toggle"><input type="checkbox" data-cat value="LOGIN_RISK"> <spring:message code="security.admin.providerAdv.category.LOGIN_RISK"/></label>
                                <label class="toggle"><input type="checkbox" data-cat value="WAF_SYNC"> <spring:message code="security.admin.providerAdv.category.WAF_SYNC"/></label>
                                <label class="toggle"><input type="checkbox" data-cat value="CONTENT_MODERATION"> <spring:message code="security.admin.providerAdv.category.CONTENT_MODERATION"/></label>
                                <label class="toggle"><input type="checkbox" data-cat value="IP_REPUTATION"> <spring:message code="security.admin.providerAdv.category.IP_REPUTATION"/></label>
                                <label class="toggle"><input type="checkbox" data-cat value="EMAIL_REPUTATION"> <spring:message code="security.admin.providerAdv.category.EMAIL_REPUTATION"/></label>
                            </div>
                            <span class="pa-hint"><spring:message code="security.admin.providerAdv.modal.field.usageCategoriesHint"/></span>
                        </label>
                        <label class="full"><span><spring:message code="security.admin.providerAdv.modal.field.triggerEvents"/></span>
                            <div id="f-triggerEvents">
                                <label class="toggle"><input type="checkbox" data-ev value="LOGIN_ATTEMPT"> <spring:message code="security.admin.providerAdv.triggerEvent.LOGIN_ATTEMPT"/></label>
                                <label class="toggle"><input type="checkbox" data-ev value="SIGNUP"> <spring:message code="security.admin.providerAdv.triggerEvent.SIGNUP"/></label>
                                <label class="toggle"><input type="checkbox" data-ev value="REPORT_CREATED"> <spring:message code="security.admin.providerAdv.triggerEvent.REPORT_CREATED"/></label>
                                <label class="toggle"><input type="checkbox" data-ev value="COMMUNITY_POST_CREATED"> <spring:message code="security.admin.providerAdv.triggerEvent.COMMUNITY_POST_CREATED"/></label>
                                <label class="toggle"><input type="checkbox" data-ev value="PASSWORD_RESET"> <spring:message code="security.admin.providerAdv.triggerEvent.PASSWORD_RESET"/></label>
                            </div>
                            <span class="pa-hint"><spring:message code="security.admin.providerAdv.modal.field.triggerEventsHint"/></span>
                        </label>
                        <label class="full"><span><spring:message code="security.admin.providerAdv.modal.field.description"/></span>
                            <textarea class="adm-input" name="description" id="f-description" rows="3" maxlength="1000"></textarea>
                        </label>
                        <label><span><spring:message code="security.admin.providerAdv.modal.field.enabled"/></span>
                            <label class="toggle"><input type="checkbox" name="enabled" id="f-enabled"> ${msg_filterEnYes}</label>
                        </label>
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
                <div>
                    <button type="button" class="adm-btn" id="pa-deleteBtn" hidden>${msg_actDelete}</button>
                    <button type="button" class="adm-btn" id="pa-restoreBtn" hidden>${msg_actRestore}</button>
                    <button type="button" class="adm-btn" id="pa-checkBtn" hidden><spring:message code="security.admin.providerAdv.row.action.check"/></button>
                </div>
                <div>
                    <button type="button" class="adm-btn" id="pa-cancelBtn">${msg_actCancel}</button>
                    <button type="submit" class="adm-btn primary" id="pa-saveBtn">${msg_actSave}</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="adm-toast" id="pa-toast"></div>

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
        actCreate: '${js_actCreate}'
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
            tbody.innerHTML = '<tr><td colspan="11" style="text-align:center; padding:2rem; opacity:.7;">' + escHtml(MSG.empty) + '</td></tr>';
            return;
        }
        const html = state.rows.map(row => {
            const isDeleted = !!row.deletedAt;
            const cats = (row.usageCategories || '').split(',').filter(s => s.trim()).map(c =>
                '<span class="chip">' + escHtml(c.trim()) + '</span>').join('');
            const checked = state.selected.has(row.providerIdx) ? 'checked' : '';
            return '' +
                '<tr class="' + (isDeleted ? 'row-deleted' : '') + '" data-idx="' + row.providerIdx + '">' +
                  '<td><input type="checkbox" class="pa-rowsel" value="' + row.providerIdx + '" ' + checked + '></td>' +
                  '<td><span class="priority-bar">' + (row.priority ?? '') + '</span></td>' +
                  '<td><span class="chip kind-' + escHtml(row.providerKind) + '">' + escHtml(row.providerKind || '') + '</span></td>' +
                  '<td><a href="#" class="pa-edit-link" data-idx="' + row.providerIdx + '">' + escHtml(row.providerName || '') + '</a></td>' +
                  '<td><code>' + escHtml(row.providerCode || '') + '</code></td>' +
                  '<td>' + cats + '</td>' +
                  '<td><span class="chip status-' + escHtml(row.status) + '">' + escHtml(row.status || '') + '</span></td>' +
                  '<td>' + (row.enabled ? '✔' : '—') + '</td>' +
                  '<td>' + escHtml(formatDate(row.lastCheckedAt)) + '</td>' +
                  '<td>' + escHtml(formatDate(row.nextHealthCheckAt)) + '</td>' +
                  '<td>' +
                    '<button type="button" class="adm-btn pa-edit" data-idx="' + row.providerIdx + '"><spring:message code="security.admin.providerAdv.row.action.edit"/></button> ' +
                    (isDeleted
                      ? '<button type="button" class="adm-btn pa-restore" data-idx="' + row.providerIdx + '"><spring:message code="security.admin.providerAdv.row.action.restore"/></button>'
                      : '<button type="button" class="adm-btn pa-check" data-idx="' + row.providerIdx + '"><spring:message code="security.admin.providerAdv.row.action.check"/></button> ' +
                        '<button type="button" class="adm-btn pa-delete" data-idx="' + row.providerIdx + '"><spring:message code="security.admin.providerAdv.row.action.delete"/></button>'
                    ) +
                  '</td>' +
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

    const renderTotal = () => {
        $('pa-totalLine').textContent = fmt(MSG.totalCount, state.total);
        const sel = state.selected.size;
        if (sel > 0) {
            $('pa-bulkbar').classList.remove('hidden');
            $('pa-selectedLabel').textContent = fmt(MSG.selectedCount, sel);
        } else {
            $('pa-bulkbar').classList.add('hidden');
        }
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

    const exportData = (scope, format) => {
        const params = buildFilterParams();
        params.set('scope', scope);
        params.set('format', format);
        if (scope === 'selected') {
            if (state.selected.size === 0) return;
            params.set('selectedIds', Array.from(state.selected).join(','));
        }
        window.location.href = ctx + '/admin/login-risk/provider-configs/export?' + params.toString();
    };

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

        document.querySelectorAll('.adm-table thead th[data-sort]').forEach(th => {
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
                exportData(b.dataset.exportScope, b.dataset.exportFormat);
                dropdown.classList.remove('open');
            }
        });
    });
})();
</script>

<%@ include file="../layout-close.jsp" %>
