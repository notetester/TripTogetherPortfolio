<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_superAdmin_permissionCodes_form_codePlaceholder" code="superAdmin.permissionCodes.form.codePlaceholder"/>
<spring:message var="msg_superAdmin_permissionCodes_form_displayNamePlaceholder" code="superAdmin.permissionCodes.form.displayNamePlaceholder"/>
<spring:message var="msg_superAdmin_permissionCodes_form_descriptionPlaceholder" code="superAdmin.permissionCodes.form.descriptionPlaceholder"/>
<spring:message var="msg_superAdmin_permissionCodes_modal_adminSearchPlaceholder" code="superAdmin.permissionCodes.modal.adminSearchPlaceholder"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_required_js" code="superAdmin.permissionCodes.toast.required" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_createFailed_js" code="superAdmin.permissionCodes.toast.createFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_created_js" code="superAdmin.permissionCodes.toast.created" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_confirm_activate_js" code="superAdmin.permissionCodes.confirm.activate" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_confirm_deactivate_js" code="superAdmin.permissionCodes.confirm.deactivate" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_updated_js" code="superAdmin.permissionCodes.toast.updated" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_updateFailed_js" code="superAdmin.permissionCodes.toast.updateFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_confirm_deleteEmpty_js" code="superAdmin.permissionCodes.confirm.deleteEmpty" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_confirm_deleteWithAdmins_js" code="superAdmin.permissionCodes.confirm.deleteWithAdmins" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_deleted_js" code="superAdmin.permissionCodes.toast.deleted" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_deleteFailed_js" code="superAdmin.permissionCodes.toast.deleteFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_modal_detailTitleSuffix_js" code="superAdmin.permissionCodes.modal.detailTitleSuffix" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_loading_js" code="superAdmin.permissionCodes.loading" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_noPermissions_js" code="superAdmin.permissionCodes.noPermissions" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_noGroups_js" code="superAdmin.permissionCodes.noGroups" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_noAdmins_js" code="superAdmin.permissionCodes.noAdmins" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_action_remove_js" code="superAdmin.permissionCodes.action.remove" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_action_revoke_js" code="superAdmin.permissionCodes.action.revoke" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_permissionRequired_js" code="superAdmin.permissionCodes.toast.permissionRequired" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_permissionAdded_js" code="superAdmin.permissionCodes.toast.permissionAdded" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_permissionAddFailed_js" code="superAdmin.permissionCodes.toast.permissionAddFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_confirm_removePermission_js" code="superAdmin.permissionCodes.confirm.removePermission" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_permissionRemoved_js" code="superAdmin.permissionCodes.toast.permissionRemoved" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_permissionRemoveFailed_js" code="superAdmin.permissionCodes.toast.permissionRemoveFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_groupRequired_js" code="superAdmin.permissionCodes.toast.groupRequired" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_groupAdded_js" code="superAdmin.permissionCodes.toast.groupAdded" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_groupAddFailed_js" code="superAdmin.permissionCodes.toast.groupAddFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_confirm_removeGroup_js" code="superAdmin.permissionCodes.confirm.removeGroup" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_groupRemoved_js" code="superAdmin.permissionCodes.toast.groupRemoved" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_groupRemoveFailed_js" code="superAdmin.permissionCodes.toast.groupRemoveFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_searchRequired_js" code="superAdmin.permissionCodes.toast.searchRequired" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_searchEmpty_js" code="superAdmin.permissionCodes.searchEmpty" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_action_assign_js" code="superAdmin.permissionCodes.action.assign" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_confirm_assignAdmin_js" code="superAdmin.permissionCodes.confirm.assignAdmin" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_templateAssigned_js" code="superAdmin.permissionCodes.toast.templateAssigned" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_templateAssignFailed_js" code="superAdmin.permissionCodes.toast.templateAssignFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_confirm_revokeAdmin_js" code="superAdmin.permissionCodes.confirm.revokeAdmin" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_templateRevoked_js" code="superAdmin.permissionCodes.toast.templateRevoked" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_toast_templateRevokeFailed_js" code="superAdmin.permissionCodes.toast.templateRevokeFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissionCodes_pageTitle" code="superAdmin.permissionCodes.pageTitle"/>
<spring:message var="msg_superAdmin_permissionCodes_cardTitle" code="superAdmin.permissionCodes.cardTitle"/>
<spring:message var="msg_superAdmin_permissionCodes_cardDescription" code="superAdmin.permissionCodes.cardDescription"/>
<spring:message var="msg_superAdmin_permissionCodes_createButton" code="superAdmin.permissionCodes.createButton"/>
<spring:message var="msg_superAdmin_permissionCodes_empty" code="superAdmin.permissionCodes.empty"/>
<spring:message var="msg_superAdmin_permissionCodes_list_count" code="superAdmin.permissionCodes.list.count"/>
<spring:message var="msg_superAdmin_permissionCodes_status_active" code="superAdmin.permissionCodes.status.active"/>
<spring:message var="msg_superAdmin_permissionCodes_status_inactive" code="superAdmin.permissionCodes.status.inactive"/>
<spring:message var="msg_superAdmin_permissionCodes_action_detail" code="superAdmin.permissionCodes.action.detail"/>
<spring:message var="msg_superAdmin_permissionCodes_action_deactivate" code="superAdmin.permissionCodes.action.deactivate"/>
<spring:message var="msg_superAdmin_permissionCodes_action_activate" code="superAdmin.permissionCodes.action.activate"/>
<spring:message var="msg_superAdmin_permissionCodes_action_delete" code="superAdmin.permissionCodes.action.delete"/>
<spring:message var="msg_superAdmin_permissionCodes_modal_createTitle" code="superAdmin.permissionCodes.modal.createTitle"/>
<spring:message var="msg_superAdmin_permissionCodes_form_code" code="superAdmin.permissionCodes.form.code"/>
<spring:message var="msg_superAdmin_permissionCodes_form_displayName" code="superAdmin.permissionCodes.form.displayName"/>
<spring:message var="msg_superAdmin_permissionCodes_form_description" code="superAdmin.permissionCodes.form.description"/>
<spring:message var="msg_admin_common_cancel" code="admin.common.cancel"/>
<spring:message var="msg_superAdmin_permissionCodes_action_create" code="superAdmin.permissionCodes.action.create"/>
<spring:message var="msg_superAdmin_permissionCodes_modal_detailTitleSuffix" code="superAdmin.permissionCodes.modal.detailTitleSuffix"/>
<spring:message var="msg_superAdmin_permissionCodes_modal_addPermission" code="superAdmin.permissionCodes.modal.addPermission"/>
<spring:message var="msg_superAdmin_permissionCodes_loading" code="superAdmin.permissionCodes.loading"/>
<spring:message var="msg_superAdmin_permissionCodes_modal_permissionSelectPlaceholder" code="superAdmin.permissionCodes.modal.permissionSelectPlaceholder"/>
<spring:message var="msg_superAdmin_permissionCodes_action_add" code="superAdmin.permissionCodes.action.add"/>
<spring:message var="msg_superAdmin_permissionCodes_modal_addGroup" code="superAdmin.permissionCodes.modal.addGroup"/>
<spring:message var="msg_superAdmin_permissionCodes_modal_groupSelectPlaceholder" code="superAdmin.permissionCodes.modal.groupSelectPlaceholder"/>
<spring:message var="msg_superAdmin_permissionCodes_modal_assignedAdmins" code="superAdmin.permissionCodes.modal.assignedAdmins"/>
<spring:message var="msg_superAdmin_permissionCodes_searchButton" code="superAdmin.permissionCodes.searchButton"/>
<spring:message var="msg_superAdmin_permissionCodes_modal_close" code="superAdmin.permissionCodes.modal.close"/>
<c:set var="pageTitle" value="${msg_superAdmin_permissionCodes_pageTitle}"/>
<c:set var="activeMenu" value="permissionCodes"/>


<%@ include file="layout.jsp" %>

<div class="adm-content">

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div style="display:flex;align-items:center;justify-content:space-between;">
                <div>
                    <div style="font-size:15px;font-weight:700;margin-bottom:4px;">${msg_superAdmin_permissionCodes_cardTitle}</div>
                    <div style="font-size:13px;color:#94a3b8;">${msg_superAdmin_permissionCodes_cardDescription}</div>
                </div>
                <button class="adm-btn adm-btn-primary" onclick="openCreateModal()">${msg_superAdmin_permissionCodes_createButton}</button>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-body" style="padding:0;">
            <c:choose>
                <c:when test="${empty codeList}">
                    <div style="text-align:center;padding:60px;color:#94a3b8;">${msg_superAdmin_permissionCodes_empty}</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="c" items="${codeList}">
                    <div class="sa-group-row ${c.active ? '' : 'sa-group-inactive'}">
                        <div>
                            <span class="sa-group-code">${fn:escapeXml(c.adminPermissionCode)}</span>
                        </div>
                        <div style="flex:1;">
                            <div class="sa-group-name">${fn:escapeXml(c.displayName)}</div>
                            <div class="sa-group-desc">${fn:escapeXml(c.description)}</div>
                        </div>
                        <div class="sa-group-cnt">${msg_superAdmin_permissionCodes_list_count}</div>
                        <div>
                            <c:choose>
                                <c:when test="${c.active}"><span class="adm-badge adm-badge-green">${msg_superAdmin_permissionCodes_status_active}</span></c:when>
                                <c:otherwise><span class="adm-badge">${msg_superAdmin_permissionCodes_status_inactive}</span></c:otherwise>
                            </c:choose>
                        </div>
                        <div style="display:flex;gap:6px;">
                            <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                    data-code="${fn:escapeXml(c.adminPermissionCode)}"
                                    data-name="${fn:escapeXml(c.displayName)}"
                                    onclick="openDetailModal(this.getAttribute('data-code'), this.getAttribute('data-name'))">${msg_superAdmin_permissionCodes_action_detail}</button>
                            <c:choose>
                                <c:when test="${c.active}">
                                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                                            data-code="${fn:escapeXml(c.adminPermissionCode)}"
                                            onclick="toggleCode(this.getAttribute('data-code'), false)">${msg_superAdmin_permissionCodes_action_deactivate}</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="adm-btn adm-btn-sm adm-btn-primary"
                                            data-code="${fn:escapeXml(c.adminPermissionCode)}"
                                            onclick="toggleCode(this.getAttribute('data-code'), true)">${msg_superAdmin_permissionCodes_action_activate}</button>
                                </c:otherwise>
                            </c:choose>
                            <button class="adm-btn adm-btn-sm"
                                    style="background:#1e2330;color:#94a3b8;border:1px solid #2d3748;"
                                    data-code="${fn:escapeXml(c.adminPermissionCode)}"
                                    onclick="deleteCode(this.getAttribute('data-code'))">${msg_superAdmin_permissionCodes_action_delete}</button>
                        </div>
                    </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%-- 생성 모달 --%>
<div class="adm-modal-overlay" id="createModal">
    <div class="adm-modal" style="width:460px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title">${msg_superAdmin_permissionCodes_modal_createTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('createModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr;">
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_permissionCodes_form_code} <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newCode" type="text" placeholder="${msg_superAdmin_permissionCodes_form_codePlaceholder}" style="text-transform:uppercase;">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_permissionCodes_form_displayName} <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newName" type="text" placeholder="${msg_superAdmin_permissionCodes_form_displayNamePlaceholder}">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_permissionCodes_form_description}</label>
                    <input class="adm-input" id="newDesc" type="text" placeholder="${msg_superAdmin_permissionCodes_form_descriptionPlaceholder}">
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"   onclick="closeModal('createModal')">${msg_admin_common_cancel}</button>
            <button class="adm-btn adm-btn-primary"  onclick="createCode()">${msg_superAdmin_permissionCodes_action_create}</button>
        </div>
    </div>
</div>

<%-- 상세 모달 --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal" style="width:600px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="detailModalTitle">${msg_superAdmin_permissionCodes_modal_detailTitleSuffix}</div>
            <button class="adm-modal-close" onclick="closeModal('detailModal')">✕</button>
        </div>
        <div class="adm-modal-body">

            <div class="sa-section-title">${msg_superAdmin_permissionCodes_modal_addPermission}</div>
            <div id="permItemList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">${msg_superAdmin_permissionCodes_loading}</div>
            </div>
            <div style="display:flex;gap:8px;margin-bottom:20px;">
                <select class="adm-select" id="addPermSelect" style="flex:1;">
                    <option value="">${msg_superAdmin_permissionCodes_modal_permissionSelectPlaceholder}</option>
                    <c:forEach var="p" items="${permissionPolicies}">
                        <option value="${fn:escapeXml(p.permissionCode)}">${fn:escapeXml(p.displayName)} (${fn:escapeXml(p.permissionCode)})</option>
                    </c:forEach>
                </select>
                <button class="adm-btn adm-btn-primary" onclick="addPermItem()">${msg_superAdmin_permissionCodes_action_add}</button>
            </div>

            <div class="sa-section-title">${msg_superAdmin_permissionCodes_modal_addGroup}</div>
            <div id="groupItemList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">${msg_superAdmin_permissionCodes_loading}</div>
            </div>
            <div style="display:flex;gap:8px;margin-bottom:20px;">
                <select class="adm-select" id="addGroupSelect" style="flex:1;">
                    <option value="">${msg_superAdmin_permissionCodes_modal_groupSelectPlaceholder}</option>
                    <c:forEach var="g" items="${groupList}">
                        <c:if test="${g.active}">
                        <option value="${fn:escapeXml(g.groupCode)}">${fn:escapeXml(g.displayName)} (${fn:escapeXml(g.groupCode)})</option>
                        </c:if>
                    </c:forEach>
                </select>
                <button class="adm-btn adm-btn-primary" onclick="addGroupItem()">${msg_superAdmin_permissionCodes_action_add}</button>
            </div>

            <div class="sa-section-title">${msg_superAdmin_permissionCodes_modal_assignedAdmins}</div>
            <div style="display:flex;gap:8px;margin-bottom:10px;">
                <input class="adm-input" id="adminSearchInput" type="text" placeholder="${msg_superAdmin_permissionCodes_modal_adminSearchPlaceholder}" style="flex:1;"
                       onkeydown="if(event.key==='Enter') searchAdminsToAssign()">
                <button class="adm-btn adm-btn-primary" onclick="searchAdminsToAssign()">${msg_superAdmin_permissionCodes_searchButton}</button>
            </div>
            <div id="adminSearchResult" style="margin-bottom:12px;"></div>
            <div id="adminList" style="margin-bottom:8px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">${msg_superAdmin_permissionCodes_loading}</div>
            </div>

        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('detailModal')">${msg_superAdmin_permissionCodes_modal_close}</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentCode = null;
const PERMISSION_CODE_MESSAGES = {
    required: '${msg_superAdmin_permissionCodes_toast_required_js}',
    createFailed: '${msg_superAdmin_permissionCodes_toast_createFailed_js}',
    created: '${msg_superAdmin_permissionCodes_toast_created_js}',
    confirmActivate: '${msg_superAdmin_permissionCodes_confirm_activate_js}',
    confirmDeactivate: '${msg_superAdmin_permissionCodes_confirm_deactivate_js}',
    updated: '${msg_superAdmin_permissionCodes_toast_updated_js}',
    updateFailed: '${msg_superAdmin_permissionCodes_toast_updateFailed_js}',
    confirmDeleteEmpty: '${msg_superAdmin_permissionCodes_confirm_deleteEmpty_js}',
    confirmDeleteWithAdmins: '${msg_superAdmin_permissionCodes_confirm_deleteWithAdmins_js}',
    deleted: '${msg_superAdmin_permissionCodes_toast_deleted_js}',
    deleteFailed: '${msg_superAdmin_permissionCodes_toast_deleteFailed_js}',
    detailSuffix: '${msg_superAdmin_permissionCodes_modal_detailTitleSuffix_js}',
    loading: '${msg_superAdmin_permissionCodes_loading_js}',
    noPermissions: '${msg_superAdmin_permissionCodes_noPermissions_js}',
    noGroups: '${msg_superAdmin_permissionCodes_noGroups_js}',
    noAdmins: '${msg_superAdmin_permissionCodes_noAdmins_js}',
    removeAction: '${msg_superAdmin_permissionCodes_action_remove_js}',
    revokeAction: '${msg_superAdmin_permissionCodes_action_revoke_js}',
    permissionRequired: '${msg_superAdmin_permissionCodes_toast_permissionRequired_js}',
    permissionAdded: '${msg_superAdmin_permissionCodes_toast_permissionAdded_js}',
    permissionAddFailed: '${msg_superAdmin_permissionCodes_toast_permissionAddFailed_js}',
    confirmRemovePermission: '${msg_superAdmin_permissionCodes_confirm_removePermission_js}',
    permissionRemoved: '${msg_superAdmin_permissionCodes_toast_permissionRemoved_js}',
    permissionRemoveFailed: '${msg_superAdmin_permissionCodes_toast_permissionRemoveFailed_js}',
    groupRequired: '${msg_superAdmin_permissionCodes_toast_groupRequired_js}',
    groupAdded: '${msg_superAdmin_permissionCodes_toast_groupAdded_js}',
    groupAddFailed: '${msg_superAdmin_permissionCodes_toast_groupAddFailed_js}',
    confirmRemoveGroup: '${msg_superAdmin_permissionCodes_confirm_removeGroup_js}',
    groupRemoved: '${msg_superAdmin_permissionCodes_toast_groupRemoved_js}',
    groupRemoveFailed: '${msg_superAdmin_permissionCodes_toast_groupRemoveFailed_js}',
    searchRequired: '${msg_superAdmin_permissionCodes_toast_searchRequired_js}',
    searchEmpty: '${msg_superAdmin_permissionCodes_searchEmpty_js}',
    assignAction: '${msg_superAdmin_permissionCodes_action_assign_js}',
    confirmAssignAdmin: '${msg_superAdmin_permissionCodes_confirm_assignAdmin_js}',
    templateAssigned: '${msg_superAdmin_permissionCodes_toast_templateAssigned_js}',
    templateAssignFailed: '${msg_superAdmin_permissionCodes_toast_templateAssignFailed_js}',
    confirmRevokeAdmin: '${msg_superAdmin_permissionCodes_confirm_revokeAdmin_js}',
    templateRevoked: '${msg_superAdmin_permissionCodes_toast_templateRevoked_js}',
    templateRevokeFailed: '${msg_superAdmin_permissionCodes_toast_templateRevokeFailed_js}'
};

function formatPermissionCodeMessage(template) {
    var args = Array.prototype.slice.call(arguments, 1);
    return template.replace(/\u007B(\d+)\u007D/g, function(_, idx) {
        return args[idx] !== undefined ? args[idx] : '';
    });
}

function openCreateModal() {
    document.getElementById('newCode').value = '';
    document.getElementById('newName').value = '';
    document.getElementById('newDesc').value = '';
    document.getElementById('createModal').classList.add('open');
}

function createCode() {
    const code = document.getElementById('newCode').value.trim().toUpperCase();
    const name = document.getElementById('newName').value.trim();
    const desc = document.getElementById('newDesc').value.trim();
    if (!code || !name) { adm_toast(PERMISSION_CODE_MESSAGES.required, 'error'); return; }

    const params = new URLSearchParams({ adminPermissionCode: code, displayName: name, description: desc });
    fetch(CTX + '/superAdmin/permission-codes', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(PERMISSION_CODE_MESSAGES.created); closeModal('createModal'); location.reload(); }
        else adm_toast(data.message || PERMISSION_CODE_MESSAGES.createFailed, 'error');
    });
}

function toggleCode(code, active) {
    const msg = active ? PERMISSION_CODE_MESSAGES.confirmActivate : PERMISSION_CODE_MESSAGES.confirmDeactivate;
    if (!confirm(msg)) return;
    fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(code) + '/toggle', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'active=' + active
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(PERMISSION_CODE_MESSAGES.updated); location.reload(); }
        else adm_toast(data.message || PERMISSION_CODE_MESSAGES.updateFailed, 'error');
    });
}

function deleteCode(code) {
    fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(code))
        .then(r => r.json())
        .then(data => {
            const cnt = (data.admins || []).length;
            const msg = cnt > 0
                ? formatPermissionCodeMessage(PERMISSION_CODE_MESSAGES.confirmDeleteWithAdmins, cnt)
                : PERMISSION_CODE_MESSAGES.confirmDeleteEmpty;
            if (!confirm(msg)) return;
            fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(code) + '/delete', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
            })
            .then(r => r.json())
            .then(d => {
                if (d.success) { adm_toast(PERMISSION_CODE_MESSAGES.deleted); location.reload(); }
                else adm_toast(d.message || PERMISSION_CODE_MESSAGES.deleteFailed, 'error');
            });
        });
}

function openDetailModal(code, name) {
    currentCode = code;
    document.getElementById('detailModalTitle').textContent = name + ' - ' + PERMISSION_CODE_MESSAGES.detailSuffix;
    document.getElementById('detailModal').classList.add('open');
    loadDetail();
}

function loadDetail() {
    fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(currentCode))
        .then(r => r.json())
        .then(data => {
            var permItems  = data.permissionItems || [];
            var groupItems = data.groupItems      || [];
            var adminCount = data.adminCount      || 0;

            document.getElementById('permItemList').innerHTML = permItems.length === 0
                ? '<div style="color:#94a3b8;padding:4px 0;">' + PERMISSION_CODE_MESSAGES.noPermissions + '</div>'
                : permItems.map(i => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${i.displayName}</span>
                        <span class="sa-group-item-code">\${i.permissionCode}</span>
                        <button class="adm-btn adm-btn-sm adm-btn-danger"
                                data-code="\${i.permissionCode}"
                                onclick="removePermItem(this.getAttribute('data-code'))">\${PERMISSION_CODE_MESSAGES.removeAction}</button>
                    </div>`).join('');

            document.getElementById('groupItemList').innerHTML = groupItems.length === 0
                ? '<div style="color:#94a3b8;padding:4px 0;">' + PERMISSION_CODE_MESSAGES.noGroups + '</div>'
                : groupItems.map(g => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${g.displayName}</span>
                        <span class="sa-group-item-code">\${g.groupCode}</span>
                        <button class="adm-btn adm-btn-sm adm-btn-danger"
                                data-code="\${g.groupCode}"
                                onclick="removeGroupItem(this.getAttribute('data-code'))">\${PERMISSION_CODE_MESSAGES.removeAction}</button>
                    </div>`).join('');

            var admins = data.admins || [];
            document.getElementById('adminList').innerHTML = admins.length === 0
                ? '<div style="color:#94a3b8;padding:4px 0;">' + PERMISSION_CODE_MESSAGES.noAdmins + '</div>'
                : admins.map(m => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${m.nickname}</span>
                        <span class="sa-group-item-code">\${m.userId}</span>
                        <button class="adm-btn adm-btn-sm adm-btn-danger"
                                data-uid="\${m.userIdx}"
                                onclick="revokeAdminCode(this.getAttribute('data-uid'))">\${PERMISSION_CODE_MESSAGES.revokeAction}</button>
                    </div>`).join('');
        });
}

function addPermItem() {
    const permCode = document.getElementById('addPermSelect').value;
    if (!permCode) { adm_toast(PERMISSION_CODE_MESSAGES.permissionRequired, 'error'); return; }
    fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(currentCode) + '/permissions/add', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'permissionCode=' + encodeURIComponent(permCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(PERMISSION_CODE_MESSAGES.permissionAdded); loadDetail(); }
        else adm_toast(data.message || PERMISSION_CODE_MESSAGES.permissionAddFailed, 'error');
    });
}

function removePermItem(permCode) {
    if (!confirm(PERMISSION_CODE_MESSAGES.confirmRemovePermission)) return;
    fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(currentCode) + '/permissions/remove', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'permissionCode=' + encodeURIComponent(permCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(PERMISSION_CODE_MESSAGES.permissionRemoved); loadDetail(); }
        else adm_toast(data.message || PERMISSION_CODE_MESSAGES.permissionRemoveFailed, 'error');
    });
}

function addGroupItem() {
    const groupCode = document.getElementById('addGroupSelect').value;
    if (!groupCode) { adm_toast(PERMISSION_CODE_MESSAGES.groupRequired, 'error'); return; }
    fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(currentCode) + '/groups/add', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'groupCode=' + encodeURIComponent(groupCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(PERMISSION_CODE_MESSAGES.groupAdded); loadDetail(); }
        else adm_toast(data.message || PERMISSION_CODE_MESSAGES.groupAddFailed, 'error');
    });
}

function removeGroupItem(groupCode) {
    if (!confirm(PERMISSION_CODE_MESSAGES.confirmRemoveGroup)) return;
    fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(currentCode) + '/groups/remove', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'groupCode=' + encodeURIComponent(groupCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(PERMISSION_CODE_MESSAGES.groupRemoved); loadDetail(); }
        else adm_toast(data.message || PERMISSION_CODE_MESSAGES.groupRemoveFailed, 'error');
    });
}

function searchAdminsToAssign() {
    const keyword = document.getElementById('adminSearchInput').value.trim();
    if (!keyword) { adm_toast(PERMISSION_CODE_MESSAGES.searchRequired, 'error'); return; }
    fetch(CTX + '/superAdmin/admins/search?keyword=' + encodeURIComponent(keyword) + '&excludeTemplateCode=' + encodeURIComponent(currentCode))
        .then(r => r.json())
        .then(data => {
            var users = data.users || [];
            if (users.length === 0) {
                document.getElementById('adminSearchResult').innerHTML = '<div style="color:#94a3b8;font-size:13px;padding:4px 0;">' + PERMISSION_CODE_MESSAGES.searchEmpty + '</div>';
                return;
            }
            document.getElementById('adminSearchResult').innerHTML =
                '<div style="border:1px solid #2d3748;border-radius:6px;overflow:hidden;">' +
                users.map(u => `
                    <div class="sa-group-item-row" style="cursor:pointer;" data-uid="\${u.userIdx}"
                         onclick="assignCodeToAdmin(this.getAttribute('data-uid'), '\${u.nickname}')">
                        <span class="sa-group-item-name">\${u.nickname}</span>
                        <span class="sa-group-item-code">\${u.userId}</span>
                        <span style="font-size:12px;color:#6366f1;">\${PERMISSION_CODE_MESSAGES.assignAction}</span>
                    </div>`).join('') + '</div>';
        });
}

function assignCodeToAdmin(userIdx, nickname) {
    if (!confirm(formatPermissionCodeMessage(PERMISSION_CODE_MESSAGES.confirmAssignAdmin, nickname))) return;
    fetch(CTX + '/superAdmin/members/' + userIdx + '/permission-code', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'permissionCode=' + encodeURIComponent(currentCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast(PERMISSION_CODE_MESSAGES.templateAssigned);
            document.getElementById('adminSearchResult').innerHTML = '';
            document.getElementById('adminSearchInput').value = '';
            loadDetail();
        } else adm_toast(data.message || PERMISSION_CODE_MESSAGES.templateAssignFailed, 'error');
    });
}

function revokeAdminCode(userIdx) {
    if (!confirm(PERMISSION_CODE_MESSAGES.confirmRevokeAdmin)) return;
    const params = new URLSearchParams();
    fetch(CTX + '/superAdmin/members/' + userIdx + '/permission-code', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(PERMISSION_CODE_MESSAGES.templateRevoked); loadDetail(); }
        else adm_toast(data.message || PERMISSION_CODE_MESSAGES.templateRevokeFailed, 'error');
    });
}

function closeModal(id) { document.getElementById(id).classList.remove('open'); }
</script>

<%@ include file="layout-close.jsp" %>
