<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="groups"/>
<spring:message code="superAdmin.groups.pageTitle" var="pageTitle"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">

    <%-- 헤더 + 생성 버튼 --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div style="display:flex;align-items:center;justify-content:space-between;">
                <div>
                    <div style="font-size:15px;font-weight:700;margin-bottom:4px;"><spring:message code="superAdmin.groups.cardTitle"/></div>
                    <div style="font-size:13px;color:#94a3b8;"><spring:message code="superAdmin.groups.cardDescription"/></div>
                </div>
                <button class="adm-btn adm-btn-primary" onclick="openCreateModal()"><spring:message code="superAdmin.groups.createButton"/></button>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-body" style="padding:0;">
            <c:choose>
                <c:when test="${empty groupList}">
                    <div style="text-align:center;padding:60px;color:#94a3b8;"><spring:message code="superAdmin.groups.empty"/></div>
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
                        <div class="sa-group-cnt"><spring:message code="superAdmin.groups.list.itemCount" arguments="${g.itemCount}"/></div>
                        <div>
                            <c:choose>
                                <c:when test="${g.active}"><span class="adm-badge adm-badge-green"><spring:message code="superAdmin.groups.status.active"/></span></c:when>
                                <c:otherwise><span class="adm-badge"><spring:message code="superAdmin.groups.status.inactive"/></span></c:otherwise>
                            </c:choose>
                        </div>
                        <div style="display:flex;gap:6px;">
                            <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                    data-code="${g.groupCode}" data-name="${fn:escapeXml(g.displayName)}"
                                    onclick="openDetailModal(this.getAttribute('data-code'), this.getAttribute('data-name'))"><spring:message code="superAdmin.groups.action.detail"/></button>
                            <c:choose>
                                <c:when test="${g.active}">
                                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                                            data-code="${g.groupCode}"
                                            onclick="toggleGroup(this.getAttribute('data-code'), false)"><spring:message code="superAdmin.groups.action.deactivate"/></button>
                                </c:when>
                                <c:otherwise>
                                    <button class="adm-btn adm-btn-sm adm-btn-primary"
                                            data-code="${g.groupCode}"
                                            onclick="toggleGroup(this.getAttribute('data-code'), true)"><spring:message code="superAdmin.groups.action.activate"/></button>
                                </c:otherwise>
                            </c:choose>
                            <button class="adm-btn adm-btn-sm"
                                    style="background:#1e2330;color:#94a3b8;border:1px solid #2d3748;"
                                    data-code="${g.groupCode}" data-cnt="${g.itemCount}"
                                    onclick="deleteGroup(this.getAttribute('data-code'))"><spring:message code="superAdmin.groups.action.delete"/></button>
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
            <div class="adm-modal-title"><spring:message code="superAdmin.groups.modal.createTitle"/></div>
            <button class="adm-modal-close" onclick="closeModal('createModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr;">
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="superAdmin.groups.form.groupCode"/> <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newGroupCode" type="text" placeholder="<spring:message code='superAdmin.groups.form.groupCodePlaceholder'/>" style="text-transform:uppercase;">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="superAdmin.groups.form.displayName"/> <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newGroupName" type="text" placeholder="<spring:message code='superAdmin.groups.form.displayNamePlaceholder'/>">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="superAdmin.groups.form.description"/></label>
                    <input class="adm-input" id="newGroupDesc" type="text" placeholder="<spring:message code='superAdmin.groups.form.descriptionPlaceholder'/>">
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"  onclick="closeModal('createModal')"><spring:message code="admin.common.cancel"/></button>
            <button class="adm-btn adm-btn-primary" onclick="createGroup()"><spring:message code="superAdmin.groups.action.create"/></button>
        </div>
    </div>
</div>

<%-- ══════════════════════════════════════════
     그룹 상세 모달
══════════════════════════════════════════ --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal" style="width:560px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="detailModalTitle"><spring:message code="superAdmin.groups.modal.detailTitleSuffix"/></div>
            <button class="adm-modal-close" onclick="closeModal('detailModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-section-title"><spring:message code="superAdmin.groups.modal.includedPermissions"/></div>
            <div id="groupItemList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:20px;color:#94a3b8;"><spring:message code="superAdmin.groups.loading"/></div>
            </div>
            <div class="sa-section-title"><spring:message code="superAdmin.groups.modal.addPermission"/></div>
            <div style="display:flex;gap:8px;margin-bottom:20px;">
                <select class="adm-select" id="addPermSelect" style="flex:1;">
                    <option value=""><spring:message code="superAdmin.groups.modal.permissionSelectPlaceholder"/></option>
                    <c:forEach var="p" items="${permissionPolicies}">
                        <option value="${p.permissionCode}">${p.displayName} (${p.permissionCode})</option>
                    </c:forEach>
                </select>
                <button class="adm-btn adm-btn-primary" onclick="addItem()"><spring:message code="superAdmin.groups.action.add"/></button>
            </div>
            <div class="sa-section-title"><spring:message code="superAdmin.groups.modal.members"/></div>
            <div style="display:flex;gap:8px;margin-bottom:10px;">
                <input class="adm-input" id="memberSearchInput" type="text" placeholder="<spring:message code='superAdmin.groups.modal.memberSearchPlaceholder'/>" style="flex:1;"
                       onkeydown="if(event.key==='Enter') searchMembersToAdd()">
                <button class="adm-btn adm-btn-primary" onclick="searchMembersToAdd()"><spring:message code="superAdmin.groups.searchButton"/></button>
            </div>
            <div id="memberSearchResult" style="margin-bottom:12px;"></div>
            <div id="groupMemberList">
                <div style="text-align:center;padding:20px;color:#94a3b8;"><spring:message code="superAdmin.groups.loading"/></div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('detailModal')"><spring:message code="superAdmin.groups.modal.close"/></button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentGroupCode = null;
const GROUP_MESSAGES = {
    required: '<spring:message code="superAdmin.groups.toast.required" javaScriptEscape="true"/>',
    createFailed: '<spring:message code="superAdmin.groups.toast.createFailed" javaScriptEscape="true"/>',
    created: '<spring:message code="superAdmin.groups.toast.created" javaScriptEscape="true"/>',
    confirmActivate: '<spring:message code="superAdmin.groups.confirm.activate" javaScriptEscape="true"/>',
    confirmDeactivate: '<spring:message code="superAdmin.groups.confirm.deactivate" javaScriptEscape="true"/>',
    updated: '<spring:message code="superAdmin.groups.toast.updated" javaScriptEscape="true"/>',
    updateFailed: '<spring:message code="superAdmin.groups.toast.updateFailed" javaScriptEscape="true"/>',
    detailSuffix: '<spring:message code="superAdmin.groups.modal.detailTitleSuffix" javaScriptEscape="true"/>',
    loading: '<spring:message code="superAdmin.groups.loading" javaScriptEscape="true"/>',
    noPermissions: '<spring:message code="superAdmin.groups.noPermissions" javaScriptEscape="true"/>',
    noMembers: '<spring:message code="superAdmin.groups.noMembers" javaScriptEscape="true"/>',
    searchRequired: '<spring:message code="superAdmin.groups.toast.searchRequired" javaScriptEscape="true"/>',
    searchEmpty: '<spring:message code="superAdmin.groups.searchEmpty" javaScriptEscape="true"/>',
    addAction: '<spring:message code="superAdmin.groups.action.add" javaScriptEscape="true"/>',
    removeAction: '<spring:message code="superAdmin.groups.action.remove" javaScriptEscape="true"/>',
    confirmAddMember: '<spring:message code="superAdmin.groups.confirm.addMember" javaScriptEscape="true"/>',
    memberAdded: '<spring:message code="superAdmin.groups.toast.memberAdded" javaScriptEscape="true"/>',
    memberAddFailed: '<spring:message code="superAdmin.groups.toast.memberAddFailed" javaScriptEscape="true"/>',
    confirmRemoveMember: '<spring:message code="superAdmin.groups.confirm.removeMember" javaScriptEscape="true"/>',
    memberRemoved: '<spring:message code="superAdmin.groups.toast.memberRemoved" javaScriptEscape="true"/>',
    memberRemoveFailed: '<spring:message code="superAdmin.groups.toast.memberRemoveFailed" javaScriptEscape="true"/>',
    permissionRequired: '<spring:message code="superAdmin.groups.toast.permissionRequired" javaScriptEscape="true"/>',
    permissionAdded: '<spring:message code="superAdmin.groups.toast.permissionAdded" javaScriptEscape="true"/>',
    permissionAddFailed: '<spring:message code="superAdmin.groups.toast.permissionAddFailed" javaScriptEscape="true"/>',
    confirmRemovePermission: '<spring:message code="superAdmin.groups.confirm.removePermission" javaScriptEscape="true"/>',
    permissionRemoved: '<spring:message code="superAdmin.groups.toast.permissionRemoved" javaScriptEscape="true"/>',
    permissionRemoveFailed: '<spring:message code="superAdmin.groups.toast.permissionRemoveFailed" javaScriptEscape="true"/>',
    confirmDeleteEmpty: '<spring:message code="superAdmin.groups.confirm.deleteEmpty" javaScriptEscape="true"/>',
    confirmDeleteWithMembers: '<spring:message code="superAdmin.groups.confirm.deleteWithMembers" javaScriptEscape="true"/>',
    deleted: '<spring:message code="superAdmin.groups.toast.deleted" javaScriptEscape="true"/>',
    deleteFailed: '<spring:message code="superAdmin.groups.toast.deleteFailed" javaScriptEscape="true"/>',
    itemCount: '<spring:message code="superAdmin.groups.list.itemCount" javaScriptEscape="true"/>'
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
