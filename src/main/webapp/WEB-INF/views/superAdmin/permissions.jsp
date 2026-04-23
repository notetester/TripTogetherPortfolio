<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="permissions"/>
<spring:message code="superAdmin.permissions.pageTitle" var="pageTitle"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div style="display:flex;align-items:center;justify-content:space-between;">
                <div>
                    <div style="font-size:15px;font-weight:700;margin-bottom:4px;"><spring:message code="superAdmin.permissions.cardTitle"/></div>
                    <div style="font-size:13px;color:#94a3b8;"><spring:message code="superAdmin.permissions.cardDescription"/></div>
                </div>
                <button class="adm-btn adm-btn-primary" onclick="openCreateModal()"><spring:message code="superAdmin.permissions.createButton"/></button>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-body" style="padding:0;">
            <c:choose>
                <c:when test="${empty permissionList}">
                    <div style="text-align:center;padding:60px;color:#94a3b8;"><spring:message code="superAdmin.permissions.empty"/></div>
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
                        <div class="sa-group-cnt"><spring:message code="superAdmin.permissions.list.usageCount" arguments="${p.usageCount}"/></div>
                        <div style="display:flex;gap:6px;align-items:center;">
                            <c:if test="${p.permissionCode == 'FINANCE_ADMIN'}">
                                <span class="adm-badge"
                                      style="background:#f59e0b20;color:#fbbf24;border:1px solid #f59e0b;"
                                      title="<spring:message code='superAdmin.permissions.badge.unimplementedTitle'/>"><spring:message code="superAdmin.permissions.badge.unimplemented"/></span>
                            </c:if>
                            <c:choose>
                                <c:when test="${p.active}"><span class="adm-badge adm-badge-green"><spring:message code="superAdmin.permissions.status.active"/></span></c:when>
                                <c:otherwise><span class="adm-badge"><spring:message code="superAdmin.permissions.status.inactive"/></span></c:otherwise>
                            </c:choose>
                        </div>
                        <div style="display:flex;gap:6px;">
                            <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                    data-code="${fn:escapeXml(p.permissionCode)}"
                                    data-name="${fn:escapeXml(p.displayName)}"
                                    onclick="openDetailModal(this.getAttribute('data-code'), this.getAttribute('data-name'))"><spring:message code="superAdmin.permissions.action.detail"/></button>
                            <c:choose>
                                <c:when test="${p.active}">
                                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                                            data-code="${fn:escapeXml(p.permissionCode)}"
                                            onclick="togglePerm(this.getAttribute('data-code'), false)"><spring:message code="superAdmin.permissions.action.deactivate"/></button>
                                </c:when>
                                <c:otherwise>
                                    <button class="adm-btn adm-btn-sm adm-btn-primary"
                                            data-code="${fn:escapeXml(p.permissionCode)}"
                                            onclick="togglePerm(this.getAttribute('data-code'), true)"><spring:message code="superAdmin.permissions.action.activate"/></button>
                                </c:otherwise>
                            </c:choose>
                            <button class="adm-btn adm-btn-sm"
                                    style="background:#1e2330;color:#94a3b8;border:1px solid #2d3748;"
                                    data-code="${fn:escapeXml(p.permissionCode)}"
                                    data-usage="${p.usageCount}"
                                    onclick="deletePerm(this.getAttribute('data-code'), this.getAttribute('data-usage'))"><spring:message code="superAdmin.permissions.action.delete"/></button>
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
            <div class="adm-modal-title"><spring:message code="superAdmin.permissions.modal.createTitle"/></div>
            <button class="adm-modal-close" onclick="closeModal('createModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr;">
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="superAdmin.permissions.form.code"/> <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newCode" type="text" placeholder="<spring:message code='superAdmin.permissions.form.codePlaceholder'/>" style="text-transform:uppercase;">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="superAdmin.permissions.form.displayName"/> <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newName" type="text" placeholder="<spring:message code='superAdmin.permissions.form.displayNamePlaceholder'/>">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label"><spring:message code="superAdmin.permissions.form.description"/></label>
                    <input class="adm-input" id="newDesc" type="text" placeholder="<spring:message code='superAdmin.permissions.form.descriptionPlaceholder'/>">
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"  onclick="closeModal('createModal')"><spring:message code="admin.common.cancel"/></button>
            <button class="adm-btn adm-btn-primary" onclick="createPerm()"><spring:message code="superAdmin.permissions.action.create"/></button>
        </div>
    </div>
</div>

<%-- 상세 모달 --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal" style="width:560px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="detailModalTitle"><spring:message code="superAdmin.permissions.modal.detailTitleSuffix"/></div>
            <button class="adm-modal-close" onclick="closeModal('detailModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-section-title"><spring:message code="superAdmin.permissions.modal.groups"/></div>
            <div id="groupList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;"><spring:message code="superAdmin.permissions.loading"/></div>
            </div>
            <div class="sa-section-title"><spring:message code="superAdmin.permissions.modal.templates"/></div>
            <div id="codeList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;"><spring:message code="superAdmin.permissions.loading"/></div>
            </div>
            <div class="sa-section-title"><spring:message code="superAdmin.permissions.modal.directAdmins"/></div>
            <div style="display:flex;gap:8px;margin-bottom:10px;">
                <input class="adm-input" id="adminSearchInput" type="text" placeholder="<spring:message code='superAdmin.permissions.modal.adminSearchPlaceholder'/>" style="flex:1;"
                       onkeydown="if(event.key==='Enter') searchAdminsToGrant()">
                <button class="adm-btn adm-btn-primary" onclick="searchAdminsToGrant()"><spring:message code="superAdmin.permissions.searchButton"/></button>
            </div>
            <div id="adminSearchResult" style="margin-bottom:12px;"></div>
            <div id="adminList">
                <div style="text-align:center;padding:16px;color:#94a3b8;"><spring:message code="superAdmin.permissions.loading"/></div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('detailModal')"><spring:message code="superAdmin.permissions.modal.close"/></button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentPermCode = null;
const PERMISSION_MESSAGES = {
    required: '<spring:message code="superAdmin.permissions.toast.required" javaScriptEscape="true"/>',
    createFailed: '<spring:message code="superAdmin.permissions.toast.createFailed" javaScriptEscape="true"/>',
    created: '<spring:message code="superAdmin.permissions.toast.created" javaScriptEscape="true"/>',
    confirmActivate: '<spring:message code="superAdmin.permissions.confirm.activate" javaScriptEscape="true"/>',
    confirmDeactivate: '<spring:message code="superAdmin.permissions.confirm.deactivate" javaScriptEscape="true"/>',
    updated: '<spring:message code="superAdmin.permissions.toast.updated" javaScriptEscape="true"/>',
    updateFailed: '<spring:message code="superAdmin.permissions.toast.updateFailed" javaScriptEscape="true"/>',
    confirmDeleteEmpty: '<spring:message code="superAdmin.permissions.confirm.deleteEmpty" javaScriptEscape="true"/>',
    confirmDeleteWithUsage: '<spring:message code="superAdmin.permissions.confirm.deleteWithUsage" javaScriptEscape="true"/>',
    deleted: '<spring:message code="superAdmin.permissions.toast.deleted" javaScriptEscape="true"/>',
    deleteFailed: '<spring:message code="superAdmin.permissions.toast.deleteFailed" javaScriptEscape="true"/>',
    detailSuffix: '<spring:message code="superAdmin.permissions.modal.detailTitleSuffix" javaScriptEscape="true"/>',
    noGroups: '<spring:message code="superAdmin.permissions.noGroups" javaScriptEscape="true"/>',
    noTemplates: '<spring:message code="superAdmin.permissions.noTemplates" javaScriptEscape="true"/>',
    noAdmins: '<spring:message code="superAdmin.permissions.noAdmins" javaScriptEscape="true"/>',
    revokeAction: '<spring:message code="superAdmin.permissions.action.revoke" javaScriptEscape="true"/>',
    searchRequired: '<spring:message code="superAdmin.permissions.toast.searchRequired" javaScriptEscape="true"/>',
    searchEmpty: '<spring:message code="superAdmin.permissions.searchEmpty" javaScriptEscape="true"/>',
    grantAction: '<spring:message code="superAdmin.permissions.action.grant" javaScriptEscape="true"/>',
    confirmGrantAdmin: '<spring:message code="superAdmin.permissions.confirm.grantAdmin" javaScriptEscape="true"/>',
    granted: '<spring:message code="superAdmin.permissions.toast.granted" javaScriptEscape="true"/>',
    grantFailed: '<spring:message code="superAdmin.permissions.toast.grantFailed" javaScriptEscape="true"/>',
    confirmRevokeAdmin: '<spring:message code="superAdmin.permissions.confirm.revokeAdmin" javaScriptEscape="true"/>',
    revoked: '<spring:message code="superAdmin.permissions.toast.revoked" javaScriptEscape="true"/>',
    revokeFailed: '<spring:message code="superAdmin.permissions.toast.revokeFailed" javaScriptEscape="true"/>'
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
