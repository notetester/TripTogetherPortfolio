<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_superAdmin_groups_form_groupCodePlaceholder" code="superAdmin.groups.form.groupCodePlaceholder"/>
<spring:message var="msg_superAdmin_groups_form_displayNamePlaceholder" code="superAdmin.groups.form.displayNamePlaceholder"/>
<spring:message var="msg_superAdmin_groups_form_descriptionPlaceholder" code="superAdmin.groups.form.descriptionPlaceholder"/>
<spring:message var="msg_superAdmin_groups_modal_memberSearchPlaceholder" code="superAdmin.groups.modal.memberSearchPlaceholder"/>
<spring:message var="msg_superAdmin_groups_toast_required_js" code="superAdmin.groups.toast.required" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_createFailed_js" code="superAdmin.groups.toast.createFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_created_js" code="superAdmin.groups.toast.created" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_confirm_activate_js" code="superAdmin.groups.confirm.activate" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_confirm_deactivate_js" code="superAdmin.groups.confirm.deactivate" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_updated_js" code="superAdmin.groups.toast.updated" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_updateFailed_js" code="superAdmin.groups.toast.updateFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_modal_detailTitleSuffix_js" code="superAdmin.groups.modal.detailTitleSuffix" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_loading_js" code="superAdmin.groups.loading" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_noPermissions_js" code="superAdmin.groups.noPermissions" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_noMembers_js" code="superAdmin.groups.noMembers" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_searchRequired_js" code="superAdmin.groups.toast.searchRequired" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_searchEmpty_js" code="superAdmin.groups.searchEmpty" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_action_add_js" code="superAdmin.groups.action.add" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_action_remove_js" code="superAdmin.groups.action.remove" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_confirm_addMember_js" code="superAdmin.groups.confirm.addMember" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_memberAdded_js" code="superAdmin.groups.toast.memberAdded" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_memberAddFailed_js" code="superAdmin.groups.toast.memberAddFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_confirm_removeMember_js" code="superAdmin.groups.confirm.removeMember" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_memberRemoved_js" code="superAdmin.groups.toast.memberRemoved" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_memberRemoveFailed_js" code="superAdmin.groups.toast.memberRemoveFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_permissionRequired_js" code="superAdmin.groups.toast.permissionRequired" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_permissionAdded_js" code="superAdmin.groups.toast.permissionAdded" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_permissionAddFailed_js" code="superAdmin.groups.toast.permissionAddFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_confirm_removePermission_js" code="superAdmin.groups.confirm.removePermission" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_permissionRemoved_js" code="superAdmin.groups.toast.permissionRemoved" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_permissionRemoveFailed_js" code="superAdmin.groups.toast.permissionRemoveFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_confirm_deleteEmpty_js" code="superAdmin.groups.confirm.deleteEmpty" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_confirm_deleteWithMembers_js" code="superAdmin.groups.confirm.deleteWithMembers" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_deleted_js" code="superAdmin.groups.toast.deleted" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_toast_deleteFailed_js" code="superAdmin.groups.toast.deleteFailed" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_list_itemCount_js" code="superAdmin.groups.list.itemCount" javaScriptEscape="true"/>
<spring:message var="msg_superAdmin_groups_pageTitle" code="superAdmin.groups.pageTitle"/>
<spring:message var="msg_superAdmin_groups_cardTitle" code="superAdmin.groups.cardTitle"/>
<spring:message var="msg_superAdmin_groups_cardDescription" code="superAdmin.groups.cardDescription"/>
<spring:message var="msg_superAdmin_groups_createButton" code="superAdmin.groups.createButton"/>
<spring:message var="msg_superAdmin_groups_empty" code="superAdmin.groups.empty"/>
<spring:message var="msg_superAdmin_groups_list_itemCount" code="superAdmin.groups.list.itemCount"/>
<spring:message var="msg_superAdmin_groups_status_active" code="superAdmin.groups.status.active"/>
<spring:message var="msg_superAdmin_groups_status_inactive" code="superAdmin.groups.status.inactive"/>
<spring:message var="msg_superAdmin_groups_action_detail" code="superAdmin.groups.action.detail"/>
<spring:message var="msg_superAdmin_groups_action_deactivate" code="superAdmin.groups.action.deactivate"/>
<spring:message var="msg_superAdmin_groups_action_activate" code="superAdmin.groups.action.activate"/>
<spring:message var="msg_superAdmin_groups_action_delete" code="superAdmin.groups.action.delete"/>
<spring:message var="msg_superAdmin_groups_modal_createTitle" code="superAdmin.groups.modal.createTitle"/>
<spring:message var="msg_superAdmin_groups_form_groupCode" code="superAdmin.groups.form.groupCode"/>
<spring:message var="msg_superAdmin_groups_form_displayName" code="superAdmin.groups.form.displayName"/>
<spring:message var="msg_superAdmin_groups_form_description" code="superAdmin.groups.form.description"/>
<spring:message var="msg_admin_common_cancel" code="admin.common.cancel"/>
<spring:message var="msg_superAdmin_groups_action_create" code="superAdmin.groups.action.create"/>
<spring:message var="msg_superAdmin_groups_modal_detailTitleSuffix" code="superAdmin.groups.modal.detailTitleSuffix"/>
<spring:message var="msg_superAdmin_groups_modal_includedPermissions" code="superAdmin.groups.modal.includedPermissions"/>
<spring:message var="msg_superAdmin_groups_loading" code="superAdmin.groups.loading"/>
<spring:message var="msg_superAdmin_groups_modal_addPermission" code="superAdmin.groups.modal.addPermission"/>
<spring:message var="msg_superAdmin_groups_modal_permissionSelectPlaceholder" code="superAdmin.groups.modal.permissionSelectPlaceholder"/>
<spring:message var="msg_superAdmin_groups_action_add" code="superAdmin.groups.action.add"/>
<spring:message var="msg_superAdmin_groups_modal_members" code="superAdmin.groups.modal.members"/>
<spring:message var="msg_superAdmin_groups_searchButton" code="superAdmin.groups.searchButton"/>
<spring:message var="msg_superAdmin_groups_modal_close" code="superAdmin.groups.modal.close"/>
<c:set var="pageTitle" value="${msg_superAdmin_groups_pageTitle}"/>
<c:set var="activeMenu" value="groups"/>


<%@ include file="layout.jsp" %>

<div class="adm-content sa-policy-admin-page">

    <%-- 헤더 + 생성 버튼 --%>
    <div class="adm-card sa-policy-head-card">
        <div class="adm-card-body">
            <div class="sa-policy-head-row">
                <div>
                    <div class="sa-policy-head-title">${msg_superAdmin_groups_cardTitle}</div>
                    <div class="sa-card-subtitle">${msg_superAdmin_groups_cardDescription}</div>
                </div>
                <button class="adm-btn adm-btn-primary" onclick="openCreateModal()">${msg_superAdmin_groups_createButton}</button>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-body sa-table-card-body">
            <c:choose>
                <c:when test="${empty groupList}">
                    <div class="sa-empty-cell sa-empty-cell-large">${msg_superAdmin_groups_empty}</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="g" items="${groupList}">
                    <div class="sa-group-row ${g.active ? '' : 'sa-group-inactive'}">
                        <div>
                            <span class="sa-group-code">${fn:escapeXml(g.groupCode)}</span>
                        </div>
                        <div class="sa-group-main">
                            <div class="sa-group-name">${fn:escapeXml(g.displayName)}</div>
                            <div class="sa-group-desc">${fn:escapeXml(g.description)}</div>
                        </div>
                        <div class="sa-group-cnt">${msg_superAdmin_groups_list_itemCount}</div>
                        <div>
                            <c:choose>
                                <c:when test="${g.active}"><span class="adm-badge adm-badge-green">${msg_superAdmin_groups_status_active}</span></c:when>
                                <c:otherwise><span class="adm-badge">${msg_superAdmin_groups_status_inactive}</span></c:otherwise>
                            </c:choose>
                        </div>
                        <div class="sa-row-actions">
                            <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                    data-code="${g.groupCode}" data-name="${fn:escapeXml(g.displayName)}"
                                    onclick="openDetailModal(this.getAttribute('data-code'), this.getAttribute('data-name'))">${msg_superAdmin_groups_action_detail}</button>
                            <c:choose>
                                <c:when test="${g.active}">
                                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                                            data-code="${g.groupCode}"
                                            onclick="toggleGroup(this.getAttribute('data-code'), false)">${msg_superAdmin_groups_action_deactivate}</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="adm-btn adm-btn-sm adm-btn-primary"
                                            data-code="${g.groupCode}"
                                            onclick="toggleGroup(this.getAttribute('data-code'), true)">${msg_superAdmin_groups_action_activate}</button>
                                </c:otherwise>
                            </c:choose>
                            <button class="adm-btn adm-btn-sm sa-muted-button"
                                    data-code="${g.groupCode}" data-cnt="${g.itemCount}"
                                    onclick="deleteGroup(this.getAttribute('data-code'))">${msg_superAdmin_groups_action_delete}</button>
                        </div>
                    </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%-- ══════════════════════════════════════════
     그룹 생성 모달
══════════════════════════════════════════ --%>
<div class="adm-modal-overlay" id="createModal">
    <div class="adm-modal sa-modal-xs">
        <div class="adm-modal-head">
            <div class="adm-modal-title">${msg_superAdmin_groups_modal_createTitle}</div>
            <button class="adm-modal-close" onclick="closeModal('createModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid sa-form-grid-single">
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_groups_form_groupCode} <span class="sa-required">*</span></label>
                    <input class="adm-input sa-uppercase-input" id="newGroupCode" type="text" placeholder="${msg_superAdmin_groups_form_groupCodePlaceholder}">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_groups_form_displayName} <span class="sa-required">*</span></label>
                    <input class="adm-input" id="newGroupName" type="text" placeholder="${msg_superAdmin_groups_form_displayNamePlaceholder}">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${msg_superAdmin_groups_form_description}</label>
                    <input class="adm-input" id="newGroupDesc" type="text" placeholder="${msg_superAdmin_groups_form_descriptionPlaceholder}">
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"  onclick="closeModal('createModal')">${msg_admin_common_cancel}</button>
            <button class="adm-btn adm-btn-primary" onclick="createGroup()">${msg_superAdmin_groups_action_create}</button>
        </div>
    </div>
</div>

<%-- ══════════════════════════════════════════
     그룹 상세 모달
══════════════════════════════════════════ --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal sa-modal-md">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="detailModalTitle">${msg_superAdmin_groups_modal_detailTitleSuffix}</div>
            <button class="adm-modal-close" onclick="closeModal('detailModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-section-title">${msg_superAdmin_groups_modal_includedPermissions}</div>
            <div id="groupItemList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:20px;color:#94a3b8;">${msg_superAdmin_groups_loading}</div>
            </div>
            <div class="sa-section-title">${msg_superAdmin_groups_modal_addPermission}</div>
            <div style="display:flex;gap:8px;margin-bottom:20px;">
                <select class="adm-select" id="addPermSelect" style="flex:1;">
                    <option value="">${msg_superAdmin_groups_modal_permissionSelectPlaceholder}</option>
                    <c:forEach var="p" items="${permissionPolicies}">
                        <option value="${p.permissionCode}">${p.displayName} (${p.permissionCode})</option>
                    </c:forEach>
                </select>
                <button class="adm-btn adm-btn-primary" onclick="addItem()">${msg_superAdmin_groups_action_add}</button>
            </div>
            <div class="sa-section-title">${msg_superAdmin_groups_modal_members}</div>
            <div style="display:flex;gap:8px;margin-bottom:10px;">
                <input class="adm-input" id="memberSearchInput" type="text" placeholder="${msg_superAdmin_groups_modal_memberSearchPlaceholder}" style="flex:1;"
                       onkeydown="if(event.key==='Enter') searchMembersToAdd()">
                <button class="adm-btn adm-btn-primary" onclick="searchMembersToAdd()">${msg_superAdmin_groups_searchButton}</button>
            </div>
            <div id="memberSearchResult" style="margin-bottom:12px;"></div>
            <div id="groupMemberList">
                <div style="text-align:center;padding:20px;color:#94a3b8;">${msg_superAdmin_groups_loading}</div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('detailModal')">${msg_superAdmin_groups_modal_close}</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentGroupCode = null;
const GROUP_MESSAGES = {
    required: '${msg_superAdmin_groups_toast_required_js}',
    createFailed: '${msg_superAdmin_groups_toast_createFailed_js}',
    created: '${msg_superAdmin_groups_toast_created_js}',
    confirmActivate: '${msg_superAdmin_groups_confirm_activate_js}',
    confirmDeactivate: '${msg_superAdmin_groups_confirm_deactivate_js}',
    updated: '${msg_superAdmin_groups_toast_updated_js}',
    updateFailed: '${msg_superAdmin_groups_toast_updateFailed_js}',
    detailSuffix: '${msg_superAdmin_groups_modal_detailTitleSuffix_js}',
    loading: '${msg_superAdmin_groups_loading_js}',
    noPermissions: '${msg_superAdmin_groups_noPermissions_js}',
    noMembers: '${msg_superAdmin_groups_noMembers_js}',
    searchRequired: '${msg_superAdmin_groups_toast_searchRequired_js}',
    searchEmpty: '${msg_superAdmin_groups_searchEmpty_js}',
    addAction: '${msg_superAdmin_groups_action_add_js}',
    removeAction: '${msg_superAdmin_groups_action_remove_js}',
    confirmAddMember: '${msg_superAdmin_groups_confirm_addMember_js}',
    memberAdded: '${msg_superAdmin_groups_toast_memberAdded_js}',
    memberAddFailed: '${msg_superAdmin_groups_toast_memberAddFailed_js}',
    confirmRemoveMember: '${msg_superAdmin_groups_confirm_removeMember_js}',
    memberRemoved: '${msg_superAdmin_groups_toast_memberRemoved_js}',
    memberRemoveFailed: '${msg_superAdmin_groups_toast_memberRemoveFailed_js}',
    permissionRequired: '${msg_superAdmin_groups_toast_permissionRequired_js}',
    permissionAdded: '${msg_superAdmin_groups_toast_permissionAdded_js}',
    permissionAddFailed: '${msg_superAdmin_groups_toast_permissionAddFailed_js}',
    confirmRemovePermission: '${msg_superAdmin_groups_confirm_removePermission_js}',
    permissionRemoved: '${msg_superAdmin_groups_toast_permissionRemoved_js}',
    permissionRemoveFailed: '${msg_superAdmin_groups_toast_permissionRemoveFailed_js}',
    confirmDeleteEmpty: '${msg_superAdmin_groups_confirm_deleteEmpty_js}',
    confirmDeleteWithMembers: '${msg_superAdmin_groups_confirm_deleteWithMembers_js}',
    deleted: '${msg_superAdmin_groups_toast_deleted_js}',
    deleteFailed: '${msg_superAdmin_groups_toast_deleteFailed_js}',
    itemCount: '${msg_superAdmin_groups_list_itemCount_js}'
};

function formatGroupMessage(template) {
    var args = Array.prototype.slice.call(arguments, 1);
    return template.replace(/\u007B(\d+)\u007D/g, function(_, idx) {
        return args[idx] !== undefined ? args[idx] : '';
    });
}

function openCreateModal() {
    document.getElementById('newGroupCode').value = '';
    document.getElementById('newGroupName').value = '';
    document.getElementById('newGroupDesc').value = '';
    document.getElementById('createModal').classList.add('open');
}

function createGroup() {
    const code = document.getElementById('newGroupCode').value.trim().toUpperCase();
    const name = document.getElementById('newGroupName').value.trim();
    const desc = document.getElementById('newGroupDesc').value.trim();
    if (!code || !name) { adm_toast(GROUP_MESSAGES.required, 'error'); return; }

    const params = new URLSearchParams({ groupCode: code, displayName: name, description: desc });
    fetch(CTX + '/superAdmin/groups', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(GROUP_MESSAGES.created); closeModal('createModal'); location.reload(); }
        else adm_toast(data.message || GROUP_MESSAGES.createFailed, 'error');
    });
}

function toggleGroup(groupCode, active) {
    const msg = active ? GROUP_MESSAGES.confirmActivate : GROUP_MESSAGES.confirmDeactivate;
    if (!confirm(msg)) return;
    fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(groupCode) + '/toggle', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'active=' + active
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(GROUP_MESSAGES.updated); location.reload(); }
        else adm_toast(data.message || GROUP_MESSAGES.updateFailed, 'error');
    });
}

function openDetailModal(groupCode, groupName) {
    currentGroupCode = groupCode;
    document.getElementById('detailModalTitle').textContent = groupName + ' - ' + GROUP_MESSAGES.detailSuffix;
    document.getElementById('detailModal').classList.add('open');
    loadGroupItems();
    loadGroupMembers();
}

function loadGroupItems() {
    document.getElementById('groupItemList').innerHTML = '<div style="text-align:center;padding:20px;color:#94a3b8;">' + GROUP_MESSAGES.loading + '</div>';
    fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(currentGroupCode))
        .then(r => r.json())
        .then(data => {
            var items = data.items || [];
            if (items.length === 0) {
                document.getElementById('groupItemList').innerHTML = '<div style="color:#94a3b8;padding:8px 0;">' + GROUP_MESSAGES.noPermissions + '</div>';
            } else {
                document.getElementById('groupItemList').innerHTML = items.map(i => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${i.displayName}</span>
                        <span class="sa-group-item-code">\${i.permissionCode}</span>
                        <button class="adm-btn adm-btn-sm adm-btn-danger"
                                data-code="\${i.permissionCode}"
                                onclick="removeItem(this.getAttribute('data-code'))">\${GROUP_MESSAGES.removeAction}</button>
                    </div>`).join('');
            }
            var btn = document.querySelector('.sa-group-row button[data-code="' + currentGroupCode + '"]');
            if (btn) {
                var cnt = btn.closest('.sa-group-row').querySelector('.sa-group-cnt');
                if (cnt) cnt.textContent = formatGroupMessage(GROUP_MESSAGES.itemCount, items.length);
            }
        });
}

function loadGroupMembers() {
    document.getElementById('groupMemberList').innerHTML = '<div style="text-align:center;padding:20px;color:#94a3b8;">' + GROUP_MESSAGES.loading + '</div>';
    fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(currentGroupCode) + '/members')
        .then(r => r.json())
        .then(data => {
            if (!data.members || data.members.length === 0) {
                document.getElementById('groupMemberList').innerHTML = '<div style="color:#94a3b8;padding:8px 0;">' + GROUP_MESSAGES.noMembers + '</div>';
                return;
            }
            document.getElementById('groupMemberList').innerHTML = data.members.map(m => `
                <div class="sa-group-item-row">
                    <span class="sa-group-item-name">\${m.nickname}</span>
                        <span class="sa-group-item-code">\${m.userId}</span>
                        <button class="adm-btn adm-btn-sm adm-btn-danger"
                                data-uid="\${m.userIdx}"
                                onclick="revokeMemberGroup(this.getAttribute('data-uid'))">\${GROUP_MESSAGES.removeAction}</button>
                </div>`).join('');
        });
}

function searchMembersToAdd() {
    const keyword = document.getElementById('memberSearchInput').value.trim();
    if (!keyword) { adm_toast(GROUP_MESSAGES.searchRequired, 'error'); return; }
    fetch(CTX + '/superAdmin/admins/search?keyword=' + encodeURIComponent(keyword) + '&excludeGroupCode=' + encodeURIComponent(currentGroupCode))
        .then(r => r.json())
        .then(data => {
            var users = data.users || [];
            if (users.length === 0) {
                document.getElementById('memberSearchResult').innerHTML = '<div style="color:#94a3b8;font-size:13px;padding:4px 0;">' + GROUP_MESSAGES.searchEmpty + '</div>';
                return;
            }
            document.getElementById('memberSearchResult').innerHTML =
                '<div style="border:1px solid #2d3748;border-radius:6px;overflow:hidden;">' +
                users.map(u => `
                    <div class="sa-group-item-row" style="cursor:pointer;" data-uid="\${u.userIdx}"
                         onclick="addMemberToGroup(this.getAttribute('data-uid'), '\${u.nickname}')">
                        <span class="sa-group-item-name">\${u.nickname}</span>
                        <span class="sa-group-item-code">\${u.userId}</span>
                        <span style="font-size:12px;color:#6366f1;">\${GROUP_MESSAGES.addAction}</span>
                    </div>`).join('') + '</div>';
        });
}

function addMemberToGroup(userIdx, nickname) {
    if (!confirm(formatGroupMessage(GROUP_MESSAGES.confirmAddMember, nickname))) return;
    fetch(CTX + '/superAdmin/members/' + userIdx + '/groups/assign', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'groupCode=' + encodeURIComponent(currentGroupCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast(GROUP_MESSAGES.memberAdded);
            document.getElementById('memberSearchResult').innerHTML = '';
            document.getElementById('memberSearchInput').value = '';
            loadGroupMembers();
        } else adm_toast(data.message || GROUP_MESSAGES.memberAddFailed, 'error');
    });
}

function revokeMemberGroup(userIdx) {
    if (!confirm(GROUP_MESSAGES.confirmRemoveMember)) return;
    fetch(CTX + '/superAdmin/members/' + userIdx + '/groups/revoke', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'groupCode=' + encodeURIComponent(currentGroupCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(GROUP_MESSAGES.memberRemoved); loadGroupMembers(); }
        else adm_toast(data.message || GROUP_MESSAGES.memberRemoveFailed, 'error');
    });
}

function addItem() {
    const permCode = document.getElementById('addPermSelect').value;
    if (!permCode) { adm_toast(GROUP_MESSAGES.permissionRequired, 'error'); return; }
    fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(currentGroupCode) + '/items/add', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'permissionCode=' + encodeURIComponent(permCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(GROUP_MESSAGES.permissionAdded); loadGroupItems(); }
        else adm_toast(data.message || GROUP_MESSAGES.permissionAddFailed, 'error');
    });
}

function removeItem(permCode) {
    if (!confirm(GROUP_MESSAGES.confirmRemovePermission)) return;
    fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(currentGroupCode) + '/items/remove', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'permissionCode=' + encodeURIComponent(permCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(GROUP_MESSAGES.permissionRemoved); loadGroupItems(); }
        else adm_toast(data.message || GROUP_MESSAGES.permissionRemoveFailed, 'error');
    });
}

function deleteGroup(groupCode) {
    fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(groupCode) + '/members')
        .then(r => r.json())
        .then(data => {
            var memberCount = (data.members || []).length;
            var msg = memberCount > 0
                ? formatGroupMessage(GROUP_MESSAGES.confirmDeleteWithMembers, memberCount)
                : GROUP_MESSAGES.confirmDeleteEmpty;
            if (!confirm(msg)) return;
            fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(groupCode) + '/delete', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
            })
            .then(r => r.json())
            .then(d => {
                if (d.success) { adm_toast(GROUP_MESSAGES.deleted); location.reload(); }
                else adm_toast(d.message || GROUP_MESSAGES.deleteFailed, 'error');
            });
        });
}

function closeModal(id) { document.getElementById(id).classList.remove('open'); }
</script>

<%@ include file="layout-close.jsp" %>
