<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_8ff804b522" code="superAdmin.groups.cardTitle"/>
<spring:message var="autoMsg_53732b65a8" code="superAdmin.groups.cardDescription"/>
<spring:message var="autoMsg_7eb41d615e" code="superAdmin.groups.createButton"/>
<spring:message var="autoMsg_0beaaf35dd" code="superAdmin.groups.empty"/>
<spring:message var="autoMsg_a90ca85a34" code="superAdmin.groups.list.itemCount"/>
<spring:message var="autoMsg_5b68ee3381" code="superAdmin.groups.status.active"/>
<spring:message var="autoMsg_95dfe5af46" code="superAdmin.groups.status.inactive"/>
<spring:message var="autoMsg_7dc1efc152" code="superAdmin.groups.action.detail"/>
<spring:message var="autoMsg_b5846476d2" code="superAdmin.groups.action.deactivate"/>
<spring:message var="autoMsg_117df9afef" code="superAdmin.groups.action.activate"/>
<spring:message var="autoMsg_9198c9584c" code="superAdmin.groups.action.delete"/>
<spring:message var="autoMsg_97928e330b" code="superAdmin.groups.modal.createTitle"/>
<spring:message var="autoMsg_f5cab7e008" code="superAdmin.groups.form.groupCode"/>
<spring:message var="autoMsg_e37c6fdbe8" code="superAdmin.groups.form.groupCodePlaceholder"/>
<spring:message var="autoMsg_78e28f7978" code="superAdmin.groups.form.displayName"/>
<spring:message var="autoMsg_8e7c7e5ead" code="superAdmin.groups.form.displayNamePlaceholder"/>
<spring:message var="autoMsg_641f42ec91" code="superAdmin.groups.form.description"/>
<spring:message var="autoMsg_6fb3defd81" code="superAdmin.groups.form.descriptionPlaceholder"/>
<spring:message var="autoMsg_c930b651a5" code="admin.common.cancel"/>
<spring:message var="autoMsg_ae634821b1" code="superAdmin.groups.action.create"/>
<spring:message var="autoMsg_4bf7716484" code="superAdmin.groups.modal.detailTitleSuffix"/>
<spring:message var="autoMsg_01695a82f4" code="superAdmin.groups.modal.includedPermissions"/>
<spring:message var="autoMsg_4f571bfd53" code="superAdmin.groups.loading"/>
<spring:message var="autoMsg_67e36ff738" code="superAdmin.groups.modal.addPermission"/>
<spring:message var="autoMsg_ca0eb28bd3" code="superAdmin.groups.modal.permissionSelectPlaceholder"/>
<spring:message var="autoMsg_cb119059f0" code="superAdmin.groups.action.add"/>
<spring:message var="autoMsg_d1381439f4" code="superAdmin.groups.modal.members"/>
<spring:message var="autoMsg_c6823a1a67" code="superAdmin.groups.modal.memberSearchPlaceholder"/>
<spring:message var="autoMsg_beec4f39e9" code="superAdmin.groups.searchButton"/>
<spring:message var="autoMsg_499d545e6c" code="superAdmin.groups.modal.close"/>
<spring:message var="autoMsg_b403cfeb3f" code="superAdmin.groups.toast.required" javaScriptEscape="true"/>
<spring:message var="autoMsg_5bed619bf9" code="superAdmin.groups.toast.createFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_3b6de39b6a" code="superAdmin.groups.toast.created" javaScriptEscape="true"/>
<spring:message var="autoMsg_c977f36aed" code="superAdmin.groups.confirm.activate" javaScriptEscape="true"/>
<spring:message var="autoMsg_3f13b52653" code="superAdmin.groups.confirm.deactivate" javaScriptEscape="true"/>
<spring:message var="autoMsg_17d4f09e97" code="superAdmin.groups.toast.updated" javaScriptEscape="true"/>
<spring:message var="autoMsg_6d03f98c32" code="superAdmin.groups.toast.updateFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_f6b06052b7" code="superAdmin.groups.modal.detailTitleSuffix" javaScriptEscape="true"/>
<spring:message var="autoMsg_d3a1785b18" code="superAdmin.groups.loading" javaScriptEscape="true"/>
<spring:message var="autoMsg_0b5831f5e0" code="superAdmin.groups.noPermissions" javaScriptEscape="true"/>
<spring:message var="autoMsg_8b5e307ab1" code="superAdmin.groups.noMembers" javaScriptEscape="true"/>
<spring:message var="autoMsg_ae85f12bf0" code="superAdmin.groups.toast.searchRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_b5bbc40a9a" code="superAdmin.groups.searchEmpty" javaScriptEscape="true"/>
<spring:message var="autoMsg_7a7b33400b" code="superAdmin.groups.action.add" javaScriptEscape="true"/>
<spring:message var="autoMsg_32c5d2d547" code="superAdmin.groups.action.remove" javaScriptEscape="true"/>
<spring:message var="autoMsg_726167f345" code="superAdmin.groups.confirm.addMember" javaScriptEscape="true"/>
<spring:message var="autoMsg_23a182e07f" code="superAdmin.groups.toast.memberAdded" javaScriptEscape="true"/>
<spring:message var="autoMsg_5676e6aca4" code="superAdmin.groups.toast.memberAddFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_737dce300d" code="superAdmin.groups.confirm.removeMember" javaScriptEscape="true"/>
<spring:message var="autoMsg_4e669d26fb" code="superAdmin.groups.toast.memberRemoved" javaScriptEscape="true"/>
<spring:message var="autoMsg_672309c90c" code="superAdmin.groups.toast.memberRemoveFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_f55a5acfbe" code="superAdmin.groups.toast.permissionRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_d21cc70e91" code="superAdmin.groups.toast.permissionAdded" javaScriptEscape="true"/>
<spring:message var="autoMsg_134b3bf460" code="superAdmin.groups.toast.permissionAddFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_dc8a47bdd2" code="superAdmin.groups.confirm.removePermission" javaScriptEscape="true"/>
<spring:message var="autoMsg_47ffa76cab" code="superAdmin.groups.toast.permissionRemoved" javaScriptEscape="true"/>
<spring:message var="autoMsg_0aee8eaeff" code="superAdmin.groups.toast.permissionRemoveFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_d3e5a99fbb" code="superAdmin.groups.confirm.deleteEmpty" javaScriptEscape="true"/>
<spring:message var="autoMsg_e2ac994be5" code="superAdmin.groups.confirm.deleteWithMembers" javaScriptEscape="true"/>
<spring:message var="autoMsg_7c1c72882c" code="superAdmin.groups.toast.deleted" javaScriptEscape="true"/>
<spring:message var="autoMsg_bb8597fd45" code="superAdmin.groups.toast.deleteFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_ac86f0eb4c" code="superAdmin.groups.list.itemCount" javaScriptEscape="true"/>
<c:set var="activeMenu" value="groups"/>
<spring:message code="superAdmin.groups.pageTitle" var="pageTitle"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">

    <%-- 헤더 + 생성 버튼 --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div style="display:flex;align-items:center;justify-content:space-between;">
                <div>
                    <div style="font-size:15px;font-weight:700;margin-bottom:4px;">${autoMsg_8ff804b522}</div>
                    <div style="font-size:13px;color:#94a3b8;">${autoMsg_53732b65a8}</div>
                </div>
                <button class="adm-btn adm-btn-primary" onclick="openCreateModal()">${autoMsg_7eb41d615e}</button>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-body" style="padding:0;">
            <c:choose>
                <c:when test="${empty groupList}">
                    <div style="text-align:center;padding:60px;color:#94a3b8;">${autoMsg_0beaaf35dd}</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="g" items="${groupList}">
                    <div class="sa-group-row ${g.active ? '' : 'sa-group-inactive'}">
                        <div>
                            <span class="sa-group-code">${fn:escapeXml(g.groupCode)}</span>
                        </div>
                        <div style="flex:1;">
                            <div class="sa-group-name">${fn:escapeXml(g.displayName)}</div>
                            <div class="sa-group-desc">${fn:escapeXml(g.description)}</div>
                        </div>
                        <div class="sa-group-cnt">${autoMsg_a90ca85a34}</div>
                        <div>
                            <c:choose>
                                <c:when test="${g.active}"><span class="adm-badge adm-badge-green">${autoMsg_5b68ee3381}</span></c:when>
                                <c:otherwise><span class="adm-badge">${autoMsg_95dfe5af46}</span></c:otherwise>
                            </c:choose>
                        </div>
                        <div style="display:flex;gap:6px;">
                            <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                    data-code="${g.groupCode}" data-name="${fn:escapeXml(g.displayName)}"
                                    onclick="openDetailModal(this.getAttribute('data-code'), this.getAttribute('data-name'))">${autoMsg_7dc1efc152}</button>
                            <c:choose>
                                <c:when test="${g.active}">
                                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                                            data-code="${g.groupCode}"
                                            onclick="toggleGroup(this.getAttribute('data-code'), false)">${autoMsg_b5846476d2}</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="adm-btn adm-btn-sm adm-btn-primary"
                                            data-code="${g.groupCode}"
                                            onclick="toggleGroup(this.getAttribute('data-code'), true)">${autoMsg_117df9afef}</button>
                                </c:otherwise>
                            </c:choose>
                            <button class="adm-btn adm-btn-sm"
                                    style="background:#1e2330;color:#94a3b8;border:1px solid #2d3748;"
                                    data-code="${g.groupCode}" data-cnt="${g.itemCount}"
                                    onclick="deleteGroup(this.getAttribute('data-code'))">${autoMsg_9198c9584c}</button>
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
    <div class="adm-modal" style="width:460px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title">${autoMsg_97928e330b}</div>
            <button class="adm-modal-close" onclick="closeModal('createModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr;">
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_f5cab7e008} <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newGroupCode" type="text" placeholder="${autoMsg_e37c6fdbe8}" style="text-transform:uppercase;">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_78e28f7978} <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newGroupName" type="text" placeholder="${autoMsg_8e7c7e5ead}">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_641f42ec91}</label>
                    <input class="adm-input" id="newGroupDesc" type="text" placeholder="${autoMsg_6fb3defd81}">
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"  onclick="closeModal('createModal')">${autoMsg_c930b651a5}</button>
            <button class="adm-btn adm-btn-primary" onclick="createGroup()">${autoMsg_ae634821b1}</button>
        </div>
    </div>
</div>

<%-- ══════════════════════════════════════════
     그룹 상세 모달
══════════════════════════════════════════ --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal" style="width:560px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="detailModalTitle">${autoMsg_4bf7716484}</div>
            <button class="adm-modal-close" onclick="closeModal('detailModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-section-title">${autoMsg_01695a82f4}</div>
            <div id="groupItemList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:20px;color:#94a3b8;">${autoMsg_4f571bfd53}</div>
            </div>
            <div class="sa-section-title">${autoMsg_67e36ff738}</div>
            <div style="display:flex;gap:8px;margin-bottom:20px;">
                <select class="adm-select" id="addPermSelect" style="flex:1;">
                    <option value="">${autoMsg_ca0eb28bd3}</option>
                    <c:forEach var="p" items="${permissionPolicies}">
                        <option value="${p.permissionCode}">${p.displayName} (${p.permissionCode})</option>
                    </c:forEach>
                </select>
                <button class="adm-btn adm-btn-primary" onclick="addItem()">${autoMsg_cb119059f0}</button>
            </div>
            <div class="sa-section-title">${autoMsg_d1381439f4}</div>
            <div style="display:flex;gap:8px;margin-bottom:10px;">
                <input class="adm-input" id="memberSearchInput" type="text" placeholder="${autoMsg_c6823a1a67}" style="flex:1;"
                       onkeydown="if(event.key==='Enter') searchMembersToAdd()">
                <button class="adm-btn adm-btn-primary" onclick="searchMembersToAdd()">${autoMsg_beec4f39e9}</button>
            </div>
            <div id="memberSearchResult" style="margin-bottom:12px;"></div>
            <div id="groupMemberList">
                <div style="text-align:center;padding:20px;color:#94a3b8;">${autoMsg_4f571bfd53}</div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('detailModal')">${autoMsg_499d545e6c}</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentGroupCode = null;
const GROUP_MESSAGES = {
    required: '${autoMsg_b403cfeb3f}',
    createFailed: '${autoMsg_5bed619bf9}',
    created: '${autoMsg_3b6de39b6a}',
    confirmActivate: '${autoMsg_c977f36aed}',
    confirmDeactivate: '${autoMsg_3f13b52653}',
    updated: '${autoMsg_17d4f09e97}',
    updateFailed: '${autoMsg_6d03f98c32}',
    detailSuffix: '${autoMsg_f6b06052b7}',
    loading: '${autoMsg_d3a1785b18}',
    noPermissions: '${autoMsg_0b5831f5e0}',
    noMembers: '${autoMsg_8b5e307ab1}',
    searchRequired: '${autoMsg_ae85f12bf0}',
    searchEmpty: '${autoMsg_b5bbc40a9a}',
    addAction: '${autoMsg_7a7b33400b}',
    removeAction: '${autoMsg_32c5d2d547}',
    confirmAddMember: '${autoMsg_726167f345}',
    memberAdded: '${autoMsg_23a182e07f}',
    memberAddFailed: '${autoMsg_5676e6aca4}',
    confirmRemoveMember: '${autoMsg_737dce300d}',
    memberRemoved: '${autoMsg_4e669d26fb}',
    memberRemoveFailed: '${autoMsg_672309c90c}',
    permissionRequired: '${autoMsg_f55a5acfbe}',
    permissionAdded: '${autoMsg_d21cc70e91}',
    permissionAddFailed: '${autoMsg_134b3bf460}',
    confirmRemovePermission: '${autoMsg_dc8a47bdd2}',
    permissionRemoved: '${autoMsg_47ffa76cab}',
    permissionRemoveFailed: '${autoMsg_0aee8eaeff}',
    confirmDeleteEmpty: '${autoMsg_d3e5a99fbb}',
    confirmDeleteWithMembers: '${autoMsg_e2ac994be5}',
    deleted: '${autoMsg_7c1c72882c}',
    deleteFailed: '${autoMsg_bb8597fd45}',
    itemCount: '${autoMsg_ac86f0eb4c}'
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
