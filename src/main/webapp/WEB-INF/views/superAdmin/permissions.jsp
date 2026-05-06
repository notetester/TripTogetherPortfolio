<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_3008868af1" code="superAdmin.permissions.cardTitle"/>
<spring:message var="autoMsg_14375c9bac" code="superAdmin.permissions.cardDescription"/>
<spring:message var="autoMsg_1f4fc54972" code="superAdmin.permissions.createButton"/>
<spring:message var="autoMsg_a0b7bfa9bd" code="superAdmin.permissions.empty"/>
<spring:message var="autoMsg_24da758668" code="superAdmin.permissions.list.usageCount"/>
<spring:message var="autoMsg_69ddac438c" code="superAdmin.permissions.status.active"/>
<spring:message var="autoMsg_dfa09c7c0b" code="superAdmin.permissions.status.inactive"/>
<spring:message var="autoMsg_427270ca06" code="superAdmin.permissions.action.detail"/>
<spring:message var="autoMsg_4a59a6fd05" code="superAdmin.permissions.action.deactivate"/>
<spring:message var="autoMsg_42d0660053" code="superAdmin.permissions.action.activate"/>
<spring:message var="autoMsg_847956cf4a" code="superAdmin.permissions.action.delete"/>
<spring:message var="autoMsg_65cef0af19" code="superAdmin.permissions.modal.createTitle"/>
<spring:message var="autoMsg_5621c7edb6" code="superAdmin.permissions.form.code"/>
<spring:message var="autoMsg_9f037c466f" code="superAdmin.permissions.form.codePlaceholder"/>
<spring:message var="autoMsg_2dc1a8b034" code="superAdmin.permissions.form.displayName"/>
<spring:message var="autoMsg_97a745197a" code="superAdmin.permissions.form.displayNamePlaceholder"/>
<spring:message var="autoMsg_68084e1ba5" code="superAdmin.permissions.form.description"/>
<spring:message var="autoMsg_4a5f0e5652" code="superAdmin.permissions.form.descriptionPlaceholder"/>
<spring:message var="autoMsg_b01713ad3a" code="admin.common.cancel"/>
<spring:message var="autoMsg_08ca360679" code="superAdmin.permissions.action.create"/>
<spring:message var="autoMsg_305e13adc8" code="superAdmin.permissions.modal.detailTitleSuffix"/>
<spring:message var="autoMsg_b801574b80" code="superAdmin.permissions.modal.groups"/>
<spring:message var="autoMsg_3e8b7732ab" code="superAdmin.permissions.loading"/>
<spring:message var="autoMsg_f2fd1c9d1a" code="superAdmin.permissions.modal.templates"/>
<spring:message var="autoMsg_5fe1db3d3e" code="superAdmin.permissions.modal.directAdmins"/>
<spring:message var="autoMsg_2d2f65a644" code="superAdmin.permissions.modal.adminSearchPlaceholder"/>
<spring:message var="autoMsg_c7d8c1bf92" code="superAdmin.permissions.searchButton"/>
<spring:message var="autoMsg_a885ebe037" code="superAdmin.permissions.modal.close"/>
<spring:message var="autoMsg_005cd68a34" code="superAdmin.permissions.toast.required" javaScriptEscape="true"/>
<spring:message var="autoMsg_d88399fc11" code="superAdmin.permissions.toast.createFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_b5d5641bb4" code="superAdmin.permissions.toast.created" javaScriptEscape="true"/>
<spring:message var="autoMsg_5bda2ad06a" code="superAdmin.permissions.confirm.activate" javaScriptEscape="true"/>
<spring:message var="autoMsg_a37eb99834" code="superAdmin.permissions.confirm.deactivate" javaScriptEscape="true"/>
<spring:message var="autoMsg_4b2f5b8dff" code="superAdmin.permissions.toast.updated" javaScriptEscape="true"/>
<spring:message var="autoMsg_dceb259e16" code="superAdmin.permissions.toast.updateFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_59ca7e1742" code="superAdmin.permissions.confirm.deleteEmpty" javaScriptEscape="true"/>
<spring:message var="autoMsg_a2fe599cb9" code="superAdmin.permissions.confirm.deleteWithUsage" javaScriptEscape="true"/>
<spring:message var="autoMsg_40130f255d" code="superAdmin.permissions.toast.deleted" javaScriptEscape="true"/>
<spring:message var="autoMsg_0e8781427e" code="superAdmin.permissions.toast.deleteFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_772ebfcaf7" code="superAdmin.permissions.modal.detailTitleSuffix" javaScriptEscape="true"/>
<spring:message var="autoMsg_83842bec57" code="superAdmin.permissions.noGroups" javaScriptEscape="true"/>
<spring:message var="autoMsg_7d3262a193" code="superAdmin.permissions.noTemplates" javaScriptEscape="true"/>
<spring:message var="autoMsg_7eba6ee832" code="superAdmin.permissions.noAdmins" javaScriptEscape="true"/>
<spring:message var="autoMsg_85a050ce11" code="superAdmin.permissions.action.revoke" javaScriptEscape="true"/>
<spring:message var="autoMsg_1310d62e58" code="superAdmin.permissions.toast.searchRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_f79a66849c" code="superAdmin.permissions.searchEmpty" javaScriptEscape="true"/>
<spring:message var="autoMsg_4fbe971bc5" code="superAdmin.permissions.action.grant" javaScriptEscape="true"/>
<spring:message var="autoMsg_4767c52849" code="superAdmin.permissions.confirm.grantAdmin" javaScriptEscape="true"/>
<spring:message var="autoMsg_64b41083a8" code="superAdmin.permissions.toast.granted" javaScriptEscape="true"/>
<spring:message var="autoMsg_a0886c8fd3" code="superAdmin.permissions.toast.grantFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_0daa3801a3" code="superAdmin.permissions.confirm.revokeAdmin" javaScriptEscape="true"/>
<spring:message var="autoMsg_5e721d04d0" code="superAdmin.permissions.toast.revoked" javaScriptEscape="true"/>
<spring:message var="autoMsg_39c7ff56cd" code="superAdmin.permissions.toast.revokeFailed" javaScriptEscape="true"/>
<c:set var="activeMenu" value="permissions"/>
<spring:message code="superAdmin.permissions.pageTitle" var="pageTitle"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div style="display:flex;align-items:center;justify-content:space-between;">
                <div>
                    <div style="font-size:15px;font-weight:700;margin-bottom:4px;">${autoMsg_3008868af1}</div>
                    <div style="font-size:13px;color:#94a3b8;">${autoMsg_14375c9bac}</div>
                </div>
                <button class="adm-btn adm-btn-primary" onclick="openCreateModal()">${autoMsg_1f4fc54972}</button>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-body" style="padding:0;">
            <c:choose>
                <c:when test="${empty permissionList}">
                    <div style="text-align:center;padding:60px;color:#94a3b8;">${autoMsg_a0b7bfa9bd}</div>
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
                        <div class="sa-group-cnt">${autoMsg_24da758668}</div>
                        <div style="display:flex;gap:6px;align-items:center;">
                            <c:choose>
                                <c:when test="${p.active}"><span class="adm-badge adm-badge-green">${autoMsg_69ddac438c}</span></c:when>
                                <c:otherwise><span class="adm-badge">${autoMsg_dfa09c7c0b}</span></c:otherwise>
                            </c:choose>
                        </div>
                        <div style="display:flex;gap:6px;">
                            <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                    data-code="${fn:escapeXml(p.permissionCode)}"
                                    data-name="${fn:escapeXml(p.displayName)}"
                                    onclick="openDetailModal(this.getAttribute('data-code'), this.getAttribute('data-name'))">${autoMsg_427270ca06}</button>
                            <c:choose>
                                <c:when test="${p.active}">
                                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                                            data-code="${fn:escapeXml(p.permissionCode)}"
                                            onclick="togglePerm(this.getAttribute('data-code'), false)">${autoMsg_4a59a6fd05}</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="adm-btn adm-btn-sm adm-btn-primary"
                                            data-code="${fn:escapeXml(p.permissionCode)}"
                                            onclick="togglePerm(this.getAttribute('data-code'), true)">${autoMsg_42d0660053}</button>
                                </c:otherwise>
                            </c:choose>
                            <button class="adm-btn adm-btn-sm"
                                    style="background:#1e2330;color:#94a3b8;border:1px solid #2d3748;"
                                    data-code="${fn:escapeXml(p.permissionCode)}"
                                    data-usage="${p.usageCount}"
                                    onclick="deletePerm(this.getAttribute('data-code'), this.getAttribute('data-usage'))">${autoMsg_847956cf4a}</button>
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
            <div class="adm-modal-title">${autoMsg_65cef0af19}</div>
            <button class="adm-modal-close" onclick="closeModal('createModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr;">
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_5621c7edb6} <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newCode" type="text" placeholder="${autoMsg_9f037c466f}" style="text-transform:uppercase;">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_2dc1a8b034} <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newName" type="text" placeholder="${autoMsg_97a745197a}">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_68084e1ba5}</label>
                    <input class="adm-input" id="newDesc" type="text" placeholder="${autoMsg_4a5f0e5652}">
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"  onclick="closeModal('createModal')">${autoMsg_b01713ad3a}</button>
            <button class="adm-btn adm-btn-primary" onclick="createPerm()">${autoMsg_08ca360679}</button>
        </div>
    </div>
</div>

<%-- 상세 모달 --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal" style="width:560px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="detailModalTitle">${autoMsg_305e13adc8}</div>
            <button class="adm-modal-close" onclick="closeModal('detailModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-section-title">${autoMsg_b801574b80}</div>
            <div id="groupList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">${autoMsg_3e8b7732ab}</div>
            </div>
            <div class="sa-section-title">${autoMsg_f2fd1c9d1a}</div>
            <div id="codeList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">${autoMsg_3e8b7732ab}</div>
            </div>
            <div class="sa-section-title">${autoMsg_5fe1db3d3e}</div>
            <div style="display:flex;gap:8px;margin-bottom:10px;">
                <input class="adm-input" id="adminSearchInput" type="text" placeholder="${autoMsg_2d2f65a644}" style="flex:1;"
                       onkeydown="if(event.key==='Enter') searchAdminsToGrant()">
                <button class="adm-btn adm-btn-primary" onclick="searchAdminsToGrant()">${autoMsg_c7d8c1bf92}</button>
            </div>
            <div id="adminSearchResult" style="margin-bottom:12px;"></div>
            <div id="adminList">
                <div style="text-align:center;padding:16px;color:#94a3b8;">${autoMsg_3e8b7732ab}</div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('detailModal')">${autoMsg_a885ebe037}</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentPermCode = null;
const PERMISSION_MESSAGES = {
    required: '${autoMsg_005cd68a34}',
    createFailed: '${autoMsg_d88399fc11}',
    created: '${autoMsg_b5d5641bb4}',
    confirmActivate: '${autoMsg_5bda2ad06a}',
    confirmDeactivate: '${autoMsg_a37eb99834}',
    updated: '${autoMsg_4b2f5b8dff}',
    updateFailed: '${autoMsg_dceb259e16}',
    confirmDeleteEmpty: '${autoMsg_59ca7e1742}',
    confirmDeleteWithUsage: '${autoMsg_a2fe599cb9}',
    deleted: '${autoMsg_40130f255d}',
    deleteFailed: '${autoMsg_0e8781427e}',
    detailSuffix: '${autoMsg_772ebfcaf7}',
    noGroups: '${autoMsg_83842bec57}',
    noTemplates: '${autoMsg_7d3262a193}',
    noAdmins: '${autoMsg_7eba6ee832}',
    revokeAction: '${autoMsg_85a050ce11}',
    searchRequired: '${autoMsg_1310d62e58}',
    searchEmpty: '${autoMsg_f79a66849c}',
    grantAction: '${autoMsg_4fbe971bc5}',
    confirmGrantAdmin: '${autoMsg_4767c52849}',
    granted: '${autoMsg_64b41083a8}',
    grantFailed: '${autoMsg_a0886c8fd3}',
    confirmRevokeAdmin: '${autoMsg_0daa3801a3}',
    revoked: '${autoMsg_5e721d04d0}',
    revokeFailed: '${autoMsg_39c7ff56cd}'
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
