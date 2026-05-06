<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_superAdmin_permissions_form_codePlaceholder" code="superAdmin.permissions.form.codePlaceholder"/>
<spring:message var="msg_superAdmin_permissions_form_displayNamePlaceholder" code="superAdmin.permissions.form.displayNamePlaceholder"/>
<spring:message var="msg_superAdmin_permissions_form_descriptionPlaceholder" code="superAdmin.permissions.form.descriptionPlaceholder"/>
<spring:message var="msg_superAdmin_permissions_modal_adminSearchPlaceholder" code="superAdmin.permissions.modal.adminSearchPlaceholder"/>
<spring:message var="msg_superAdmin_permissions_toast_required_js" code="superAdmin.permissions.toast.required" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_toast_createFailed_js" code="superAdmin.permissions.toast.createFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_toast_created_js" code="superAdmin.permissions.toast.created" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_confirm_activate_js" code="superAdmin.permissions.confirm.activate" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_confirm_deactivate_js" code="superAdmin.permissions.confirm.deactivate" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_toast_updated_js" code="superAdmin.permissions.toast.updated" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_toast_updateFailed_js" code="superAdmin.permissions.toast.updateFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_confirm_deleteEmpty_js" code="superAdmin.permissions.confirm.deleteEmpty" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_confirm_deleteWithUsage_js" code="superAdmin.permissions.confirm.deleteWithUsage" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_toast_deleted_js" code="superAdmin.permissions.toast.deleted" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_toast_deleteFailed_js" code="superAdmin.permissions.toast.deleteFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_modal_detailTitleSuffix_js" code="superAdmin.permissions.modal.detailTitleSuffix" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_noGroups_js" code="superAdmin.permissions.noGroups" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_noTemplates_js" code="superAdmin.permissions.noTemplates" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_noAdmins_js" code="superAdmin.permissions.noAdmins" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_action_revoke_js" code="superAdmin.permissions.action.revoke" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_toast_searchRequired_js" code="superAdmin.permissions.toast.searchRequired" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_searchEmpty_js" code="superAdmin.permissions.searchEmpty" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_action_grant_js" code="superAdmin.permissions.action.grant" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_confirm_grantAdmin_js" code="superAdmin.permissions.confirm.grantAdmin" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_toast_granted_js" code="superAdmin.permissions.toast.granted" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_toast_grantFailed_js" code="superAdmin.permissions.toast.grantFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_confirm_revokeAdmin_js" code="superAdmin.permissions.confirm.revokeAdmin" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_toast_revoked_js" code="superAdmin.permissions.toast.revoked" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_toast_revokeFailed_js" code="superAdmin.permissions.toast.revokeFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_permissions_pageTitle" code="superAdmin.permissions.pageTitle"/>
<spring:message var="msg_superAdmin_permissions_cardTitle" code="superAdmin.permissions.cardTitle"/>
<spring:message var="msg_superAdmin_permissions_cardDescription" code="superAdmin.permissions.cardDescription"/>
<spring:message var="msg_superAdmin_permissions_createButton" code="superAdmin.permissions.createButton"/>
<spring:message var="msg_superAdmin_permissions_empty" code="superAdmin.permissions.empty"/>
<spring:message var="msg_superAdmin_permissions_list_usageCount" code="superAdmin.permissions.list.usageCount"/>
<spring:message var="msg_superAdmin_permissions_status_active" code="superAdmin.permissions.status.active"/>
<spring:message var="msg_superAdmin_permissions_status_inactive" code="superAdmin.permissions.status.inactive"/>
<spring:message var="msg_superAdmin_permissions_action_detail" code="superAdmin.permissions.action.detail"/>
<spring:message var="msg_superAdmin_permissions_action_deactivate" code="superAdmin.permissions.action.deactivate"/>
<spring:message var="msg_superAdmin_permissions_action_activate" code="superAdmin.permissions.action.activate"/>
<spring:message var="msg_superAdmin_permissions_action_delete" code="superAdmin.permissions.action.delete"/>
<spring:message var="msg_superAdmin_permissions_modal_createTitle" code="superAdmin.permissions.modal.createTitle"/>
<spring:message var="msg_superAdmin_permissions_form_code" code="superAdmin.permissions.form.code"/>
<spring:message var="msg_superAdmin_permissions_form_displayName" code="superAdmin.permissions.form.displayName"/>
<spring:message var="msg_superAdmin_permissions_form_description" code="superAdmin.permissions.form.description"/>
<spring:message var="msg_admin_common_cancel" code="admin.common.cancel"/>
<spring:message var="msg_superAdmin_permissions_action_create" code="superAdmin.permissions.action.create"/>
<spring:message var="msg_superAdmin_permissions_modal_detailTitleSuffix" code="superAdmin.permissions.modal.detailTitleSuffix"/>
<spring:message var="msg_superAdmin_permissions_modal_groups" code="superAdmin.permissions.modal.groups"/>
<spring:message var="msg_superAdmin_permissions_loading" code="superAdmin.permissions.loading"/>
<spring:message var="msg_superAdmin_permissions_modal_templates" code="superAdmin.permissions.modal.templates"/>
<spring:message var="msg_superAdmin_permissions_modal_directAdmins" code="superAdmin.permissions.modal.directAdmins"/>
<spring:message var="msg_superAdmin_permissions_searchButton" code="superAdmin.permissions.searchButton"/>
<spring:message var="msg_superAdmin_permissions_modal_close" code="superAdmin.permissions.modal.close"/>
<c:set var="pageTitle" value="${msg_superAdmin_permissions_pageTitle}"/>
<c:set var="activeMenu" value="permissions"/>


<%@ include file="layout.jsp" %>

<div class="adm-content">

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div style="display:flex;align-items:center;justify-content:space-between;">
                <div>
                    <div style="font-size:15px;font-weight:700;margin-bottom:4px;">${msg_superAdmin_permissions_cardTitle}</div>
                    <div style="font-size:13px;color:#94a3b8;">${msg_superAdmin_permissions_cardDescription}</div>
                </div>
                <button class="adm-btn adm-btn-primary" onclick="openCreateModal()">${msg_superAdmin_permissions_createButton}</button>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-body" style="padding:0;">
            <c:choose>
                <c:when test="${empty permissionList}">
                    <div style="text-align:center;padding:60px;color:#94a3b8;">${msg_superAdmin_permissions_empty}</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="p" items="${permissionList}">
                    <div class="sa-group-row ${p.active ? '' : 'sa-group-inactive'}">
                        <div>
                            <span class="sa-group-code">${fn:escapeXml(p.permissionCode)}</span>
                        </div>
                        <div style="flex:1;">
                            <div class="sa-group-name">${fn:escapeXml(p.displayName)}</div>
                            <div class="sa-group-desc">${fn:escapeXml(p.description)}</div>
                        </div>
                        <div class="sa-group-cnt">${msg_superAdmin_permissions_list_usageCount}</div>
                        <div style="display:flex;gap:6px;align-items:center;">
                            <c:choose>
                                <c:when test="${p.active}"><span class="adm-badge adm-badge-green">${msg_superAdmin_permissions_status_active}</span></c:when>
                                <c:otherwise><span class="adm-badge">${msg_superAdmin_permissions_status_inactive}</span></c:otherwise>
                            </c:choose>
                        </div>
                        <div style="display:flex;gap:6px;">
                            <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                    data-code="${fn:escapeXml(p.permissionCode)}"
                                    data-name="${fn:escapeXml(p.displayName)}"
                                    onclick="openDetailModal(this.getAttribute('data-code'), this.getAttribute('data-name'))">${msg_superAdmin_permissions_action_detail}</button>
                            <c:choose>
                                <c:when test="${p.active}">
                                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                                            data-code="${fn:escapeXml(p.permissionCode)}"
                                            onclick="togglePerm(this.getAttribute('data-code'), false)">${msg_superAdmin_permissions_action_deactivate}</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="adm-btn adm-btn-sm adm-btn-primary"
                                            data-code="${fn:escapeXml(p.permissionCode)}"
                                            onclick="togglePerm(this.getAttribute('data-code'), true)">${msg_superAdmin_permissions_action_activate}</button>
                                </c:otherwise>
                            </c:choose>
                            <button class="adm-btn adm-btn-sm"
                                    style="background:#1e2330;color:#94a3b8;border:1px solid #2d3748;"
                                    data-code="${fn:escapeXml(p.permissionCode)}"
                                    data-usage="${p.usageCount}"
                                    onclick="deletePerm(this.getAttribute('data-code'), this.getAttribute('data-usage'))">${msg_superAdmin_permissions_action_delete}</button>
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
            <div class="adm-modal-title">${msg_superAdmin_permissions_modal_createTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('createModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr;">
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_permissions_form_code} <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newCode" type="text" placeholder="${msg_superAdmin_permissions_form_codePlaceholder}" style="text-transform:uppercase;">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_permissions_form_displayName} <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newName" type="text" placeholder="${msg_superAdmin_permissions_form_displayNamePlaceholder}">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_permissions_form_description}</label>
                    <input class="adm-input" id="newDesc" type="text" placeholder="${msg_superAdmin_permissions_form_descriptionPlaceholder}">
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"  onclick="closeModal('createModal')">${msg_admin_common_cancel}</button>
            <button class="adm-btn adm-btn-primary" onclick="createPerm()">${msg_superAdmin_permissions_action_create}</button>
        </div>
    </div>
</div>

<%-- 상세 모달 --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal" style="width:560px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="detailModalTitle">${msg_superAdmin_permissions_modal_detailTitleSuffix}</div>
            <button class="adm-modal-close" onclick="closeModal('detailModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-section-title">${msg_superAdmin_permissions_modal_groups}</div>
            <div id="groupList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">${msg_superAdmin_permissions_loading}</div>
            </div>
            <div class="sa-section-title">${msg_superAdmin_permissions_modal_templates}</div>
            <div id="codeList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">${msg_superAdmin_permissions_loading}</div>
            </div>
            <div class="sa-section-title">${msg_superAdmin_permissions_modal_directAdmins}</div>
            <div style="display:flex;gap:8px;margin-bottom:10px;">
                <input class="adm-input" id="adminSearchInput" type="text" placeholder="${msg_superAdmin_permissions_modal_adminSearchPlaceholder}" style="flex:1;"
                       onkeydown="if(event.key==='Enter') searchAdminsToGrant()">
                <button class="adm-btn adm-btn-primary" onclick="searchAdminsToGrant()">${msg_superAdmin_permissions_searchButton}</button>
            </div>
            <div id="adminSearchResult" style="margin-bottom:12px;"></div>
            <div id="adminList">
                <div style="text-align:center;padding:16px;color:#94a3b8;">${msg_superAdmin_permissions_loading}</div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('detailModal')">${msg_superAdmin_permissions_modal_close}</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentPermCode = null;
const PERMISSION_MESSAGES = {
    required: '${msg_superAdmin_permissions_toast_required_js}',
    createFailed: '${msg_superAdmin_permissions_toast_createFailed_js}',
    created: '${msg_superAdmin_permissions_toast_created_js}',
    confirmActivate: '${msg_superAdmin_permissions_confirm_activate_js}',
    confirmDeactivate: '${msg_superAdmin_permissions_confirm_deactivate_js}',
    updated: '${msg_superAdmin_permissions_toast_updated_js}',
    updateFailed: '${msg_superAdmin_permissions_toast_updateFailed_js}',
    confirmDeleteEmpty: '${msg_superAdmin_permissions_confirm_deleteEmpty_js}',
    confirmDeleteWithUsage: '${msg_superAdmin_permissions_confirm_deleteWithUsage_js}',
    deleted: '${msg_superAdmin_permissions_toast_deleted_js}',
    deleteFailed: '${msg_superAdmin_permissions_toast_deleteFailed_js}',
    detailSuffix: '${msg_superAdmin_permissions_modal_detailTitleSuffix_js}',
    noGroups: '${msg_superAdmin_permissions_noGroups_js}',
    noTemplates: '${msg_superAdmin_permissions_noTemplates_js}',
    noAdmins: '${msg_superAdmin_permissions_noAdmins_js}',
    revokeAction: '${msg_superAdmin_permissions_action_revoke_js}',
    searchRequired: '${msg_superAdmin_permissions_toast_searchRequired_js}',
    searchEmpty: '${msg_superAdmin_permissions_searchEmpty_js}',
    grantAction: '${msg_superAdmin_permissions_action_grant_js}',
    confirmGrantAdmin: '${msg_superAdmin_permissions_confirm_grantAdmin_js}',
    granted: '${msg_superAdmin_permissions_toast_granted_js}',
    grantFailed: '${msg_superAdmin_permissions_toast_grantFailed_js}',
    confirmRevokeAdmin: '${msg_superAdmin_permissions_confirm_revokeAdmin_js}',
    revoked: '${msg_superAdmin_permissions_toast_revoked_js}',
    revokeFailed: '${msg_superAdmin_permissions_toast_revokeFailed_js}'
};

function formatPermissionMessage(template) {
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

function createPerm() {
    const code = document.getElementById('newCode').value.trim().toUpperCase();
    const name = document.getElementById('newName').value.trim();
    const desc = document.getElementById('newDesc').value.trim();
    if (!code || !name) { adm_toast(PERMISSION_MESSAGES.required, 'error'); return; }

    const params = new URLSearchParams({ permissionCode: code, displayName: name, description: desc });
    fetch(CTX + '/superAdmin/permissions', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(PERMISSION_MESSAGES.created); closeModal('createModal'); location.reload(); }
        else adm_toast(data.message || PERMISSION_MESSAGES.createFailed, 'error');
    });
}

function togglePerm(code, active) {
    const msg = active ? PERMISSION_MESSAGES.confirmActivate : PERMISSION_MESSAGES.confirmDeactivate;
    if (!confirm(msg)) return;
    fetch(CTX + '/superAdmin/permissions/' + encodeURIComponent(code) + '/toggle', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'active=' + active
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(PERMISSION_MESSAGES.updated); location.reload(); }
        else adm_toast(data.message || PERMISSION_MESSAGES.updateFailed, 'error');
    });
}

function deletePerm(code, usageCount) {
    var cnt = parseInt(usageCount) || 0;
    var msg = cnt > 0
        ? formatPermissionMessage(PERMISSION_MESSAGES.confirmDeleteWithUsage, cnt)
        : PERMISSION_MESSAGES.confirmDeleteEmpty;
    if (!confirm(msg)) return;
    fetch(CTX + '/superAdmin/permissions/' + encodeURIComponent(code) + '/delete', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(PERMISSION_MESSAGES.deleted); location.reload(); }
        else adm_toast(data.message || PERMISSION_MESSAGES.deleteFailed, 'error');
    });
}

function openDetailModal(code, name) {
    currentPermCode = code;
    document.getElementById('detailModalTitle').textContent = name + ' (' + code + ') - ' + PERMISSION_MESSAGES.detailSuffix;
    document.getElementById('detailModal').classList.add('open');
    loadDetail();
}

function loadDetail() {
    fetch(CTX + '/superAdmin/permissions/' + encodeURIComponent(currentPermCode))
        .then(r => r.json())
        .then(data => {
            var groups = data.groups || [];
            var codes  = data.codes  || [];
            var admins = data.admins || [];

            document.getElementById('groupList').innerHTML = groups.length === 0
                ? '<div style="color:#94a3b8;padding:4px 0;">' + PERMISSION_MESSAGES.noGroups + '</div>'
                : groups.map(g => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${g.displayName}</span>
                        <span class="sa-group-item-code">\${g.groupCode}</span>
                    </div>`).join('');

            document.getElementById('codeList').innerHTML = codes.length === 0
                ? '<div style="color:#94a3b8;padding:4px 0;">' + PERMISSION_MESSAGES.noTemplates + '</div>'
                : codes.map(c => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${c.displayName}</span>
                        <span class="sa-group-item-code">\${c.adminPermissionCode}</span>
                    </div>`).join('');

            document.getElementById('adminList').innerHTML = admins.length === 0
                ? '<div style="color:#94a3b8;padding:4px 0;">' + PERMISSION_MESSAGES.noAdmins + '</div>'
                : admins.map(m => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${m.nickname}</span>
                        <span class="sa-group-item-code">\${m.userId}</span>
                        <button class="adm-btn adm-btn-sm adm-btn-danger"
                                data-uid="\${m.userIdx}"
                                onclick="revokeAdmin(this.getAttribute('data-uid'))">\${PERMISSION_MESSAGES.revokeAction}</button>
                    </div>`).join('');
        });
}

function searchAdminsToGrant() {
    const keyword = document.getElementById('adminSearchInput').value.trim();
    if (!keyword) { adm_toast(PERMISSION_MESSAGES.searchRequired, 'error'); return; }
    fetch(CTX + '/superAdmin/admins/search?keyword=' + encodeURIComponent(keyword) + '&excludePermissionCode=' + encodeURIComponent(currentPermCode))
        .then(r => r.json())
        .then(data => {
            var users = data.users || [];
            if (users.length === 0) {
                document.getElementById('adminSearchResult').innerHTML = '<div style="color:#94a3b8;font-size:13px;padding:4px 0;">' + PERMISSION_MESSAGES.searchEmpty + '</div>';
                return;
            }
            document.getElementById('adminSearchResult').innerHTML =
                '<div style="border:1px solid #2d3748;border-radius:6px;overflow:hidden;">' +
                users.map(u => `
                    <div class="sa-group-item-row" style="cursor:pointer;" data-uid="\${u.userIdx}"
                         onclick="grantToAdmin(this.getAttribute('data-uid'), '\${u.nickname}')">
                        <span class="sa-group-item-name">\${u.nickname}</span>
                        <span class="sa-group-item-code">\${u.userId}</span>
                        <span style="font-size:12px;color:#6366f1;">\${PERMISSION_MESSAGES.grantAction}</span>
                    </div>`).join('') + '</div>';
        });
}

function grantToAdmin(userIdx, nickname) {
    if (!confirm(formatPermissionMessage(PERMISSION_MESSAGES.confirmGrantAdmin, nickname))) return;
    fetch(CTX + '/superAdmin/permissions/' + encodeURIComponent(currentPermCode) + '/grant/' + userIdx, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast(PERMISSION_MESSAGES.granted);
            document.getElementById('adminSearchResult').innerHTML = '';
            document.getElementById('adminSearchInput').value = '';
            loadDetail();
        } else adm_toast(data.message || PERMISSION_MESSAGES.grantFailed, 'error');
    });
}

function revokeAdmin(userIdx) {
    if (!confirm(PERMISSION_MESSAGES.confirmRevokeAdmin)) return;
    fetch(CTX + '/superAdmin/permissions/' + encodeURIComponent(currentPermCode) + '/revoke/' + userIdx, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(PERMISSION_MESSAGES.revoked); loadDetail(); }
        else adm_toast(data.message || PERMISSION_MESSAGES.revokeFailed, 'error');
    });
}

function closeModal(id) { document.getElementById(id).classList.remove('open'); }
</script>

<%@ include file="layout-close.jsp" %>
