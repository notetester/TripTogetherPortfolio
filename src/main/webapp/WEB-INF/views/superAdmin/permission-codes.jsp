<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_1ae8fe4536" code="superAdmin.permissionCodes.cardTitle"/>
<spring:message var="autoMsg_c2afb73135" code="superAdmin.permissionCodes.cardDescription"/>
<spring:message var="autoMsg_465a728122" code="superAdmin.permissionCodes.createButton"/>
<spring:message var="autoMsg_7c8fa7bc61" code="superAdmin.permissionCodes.empty"/>
<spring:message var="autoMsg_d8f75bd79c" code="superAdmin.permissionCodes.list.count"/>
<spring:message var="autoMsg_a7318696c8" code="superAdmin.permissionCodes.status.active"/>
<spring:message var="autoMsg_ef83720c18" code="superAdmin.permissionCodes.status.inactive"/>
<spring:message var="autoMsg_e829b19e0c" code="superAdmin.permissionCodes.action.detail"/>
<spring:message var="autoMsg_8351e0ad76" code="superAdmin.permissionCodes.action.deactivate"/>
<spring:message var="autoMsg_2d1c5a729c" code="superAdmin.permissionCodes.action.activate"/>
<spring:message var="autoMsg_5aa040b568" code="superAdmin.permissionCodes.action.delete"/>
<spring:message var="autoMsg_135d53b7b1" code="superAdmin.permissionCodes.modal.createTitle"/>
<spring:message var="autoMsg_5ef5a288f3" code="superAdmin.permissionCodes.form.code"/>
<spring:message var="autoMsg_2fcc2831fa" code="superAdmin.permissionCodes.form.codePlaceholder"/>
<spring:message var="autoMsg_d0c660fc81" code="superAdmin.permissionCodes.form.displayName"/>
<spring:message var="autoMsg_e37e20c6be" code="superAdmin.permissionCodes.form.displayNamePlaceholder"/>
<spring:message var="autoMsg_ad4774244e" code="superAdmin.permissionCodes.form.description"/>
<spring:message var="autoMsg_2bd8d87413" code="superAdmin.permissionCodes.form.descriptionPlaceholder"/>
<spring:message var="autoMsg_7bb4aadca6" code="admin.common.cancel"/>
<spring:message var="autoMsg_d5fffdfefc" code="superAdmin.permissionCodes.action.create"/>
<spring:message var="autoMsg_48d9653617" code="superAdmin.permissionCodes.modal.detailTitleSuffix"/>
<spring:message var="autoMsg_dbf9b3100c" code="superAdmin.permissionCodes.modal.addPermission"/>
<spring:message var="autoMsg_a85bca2e31" code="superAdmin.permissionCodes.loading"/>
<spring:message var="autoMsg_601bf9e008" code="superAdmin.permissionCodes.modal.permissionSelectPlaceholder"/>
<spring:message var="autoMsg_0d61c6c291" code="superAdmin.permissionCodes.action.add"/>
<spring:message var="autoMsg_70559cfcae" code="superAdmin.permissionCodes.modal.addGroup"/>
<spring:message var="autoMsg_9e59df18df" code="superAdmin.permissionCodes.modal.groupSelectPlaceholder"/>
<spring:message var="autoMsg_3a4aaad55a" code="superAdmin.permissionCodes.modal.assignedAdmins"/>
<spring:message var="autoMsg_da8f44fd94" code="superAdmin.permissionCodes.modal.adminSearchPlaceholder"/>
<spring:message var="autoMsg_64b993dcdf" code="superAdmin.permissionCodes.searchButton"/>
<spring:message var="autoMsg_5f7cf13a7c" code="superAdmin.permissionCodes.modal.close"/>
<spring:message var="autoMsg_05a1234193" code="superAdmin.permissionCodes.toast.required" javaScriptEscape="true"/>
<spring:message var="autoMsg_304dc2b2bb" code="superAdmin.permissionCodes.toast.createFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_b1afaf1f6b" code="superAdmin.permissionCodes.toast.created" javaScriptEscape="true"/>
<spring:message var="autoMsg_2cdc22806b" code="superAdmin.permissionCodes.confirm.activate" javaScriptEscape="true"/>
<spring:message var="autoMsg_d487944ccf" code="superAdmin.permissionCodes.confirm.deactivate" javaScriptEscape="true"/>
<spring:message var="autoMsg_d067070f0a" code="superAdmin.permissionCodes.toast.updated" javaScriptEscape="true"/>
<spring:message var="autoMsg_b2d4b29574" code="superAdmin.permissionCodes.toast.updateFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_f1655a1c32" code="superAdmin.permissionCodes.confirm.deleteEmpty" javaScriptEscape="true"/>
<spring:message var="autoMsg_73a1b1f8b3" code="superAdmin.permissionCodes.confirm.deleteWithAdmins" javaScriptEscape="true"/>
<spring:message var="autoMsg_a0a02bd418" code="superAdmin.permissionCodes.toast.deleted" javaScriptEscape="true"/>
<spring:message var="autoMsg_d1c1daa3fe" code="superAdmin.permissionCodes.toast.deleteFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_7451dbe148" code="superAdmin.permissionCodes.modal.detailTitleSuffix" javaScriptEscape="true"/>
<spring:message var="autoMsg_bcf72687cb" code="superAdmin.permissionCodes.loading" javaScriptEscape="true"/>
<spring:message var="autoMsg_7046ecc040" code="superAdmin.permissionCodes.noPermissions" javaScriptEscape="true"/>
<spring:message var="autoMsg_8460729be4" code="superAdmin.permissionCodes.noGroups" javaScriptEscape="true"/>
<spring:message var="autoMsg_033f7e4678" code="superAdmin.permissionCodes.noAdmins" javaScriptEscape="true"/>
<spring:message var="autoMsg_085a90955f" code="superAdmin.permissionCodes.action.remove" javaScriptEscape="true"/>
<spring:message var="autoMsg_59650caece" code="superAdmin.permissionCodes.action.revoke" javaScriptEscape="true"/>
<spring:message var="autoMsg_e0097a865b" code="superAdmin.permissionCodes.toast.permissionRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_a409c04055" code="superAdmin.permissionCodes.toast.permissionAdded" javaScriptEscape="true"/>
<spring:message var="autoMsg_090029a5e1" code="superAdmin.permissionCodes.toast.permissionAddFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_e61d982d0b" code="superAdmin.permissionCodes.confirm.removePermission" javaScriptEscape="true"/>
<spring:message var="autoMsg_262ca1dc2b" code="superAdmin.permissionCodes.toast.permissionRemoved" javaScriptEscape="true"/>
<spring:message var="autoMsg_014af048de" code="superAdmin.permissionCodes.toast.permissionRemoveFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_7325954f6a" code="superAdmin.permissionCodes.toast.groupRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_2e08ddedd1" code="superAdmin.permissionCodes.toast.groupAdded" javaScriptEscape="true"/>
<spring:message var="autoMsg_b1d282a816" code="superAdmin.permissionCodes.toast.groupAddFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_eca7210617" code="superAdmin.permissionCodes.confirm.removeGroup" javaScriptEscape="true"/>
<spring:message var="autoMsg_e17eaeaa42" code="superAdmin.permissionCodes.toast.groupRemoved" javaScriptEscape="true"/>
<spring:message var="autoMsg_fdbd9a4357" code="superAdmin.permissionCodes.toast.groupRemoveFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_2cdfdc29d3" code="superAdmin.permissionCodes.toast.searchRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_4fd90f3cc9" code="superAdmin.permissionCodes.searchEmpty" javaScriptEscape="true"/>
<spring:message var="autoMsg_90f4ea2e97" code="superAdmin.permissionCodes.action.assign" javaScriptEscape="true"/>
<spring:message var="autoMsg_fae9694fd2" code="superAdmin.permissionCodes.confirm.assignAdmin" javaScriptEscape="true"/>
<spring:message var="autoMsg_27481c2ecd" code="superAdmin.permissionCodes.toast.templateAssigned" javaScriptEscape="true"/>
<spring:message var="autoMsg_7af0abe550" code="superAdmin.permissionCodes.toast.templateAssignFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_5ee833c26c" code="superAdmin.permissionCodes.confirm.revokeAdmin" javaScriptEscape="true"/>
<spring:message var="autoMsg_82de44085e" code="superAdmin.permissionCodes.toast.templateRevoked" javaScriptEscape="true"/>
<spring:message var="autoMsg_608f247a54" code="superAdmin.permissionCodes.toast.templateRevokeFailed" javaScriptEscape="true"/>
<c:set var="activeMenu" value="permissionCodes"/>
<spring:message code="superAdmin.permissionCodes.pageTitle" var="pageTitle"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div style="display:flex;align-items:center;justify-content:space-between;">
                <div>
                    <div style="font-size:15px;font-weight:700;margin-bottom:4px;">${autoMsg_1ae8fe4536}</div>
                    <div style="font-size:13px;color:#94a3b8;">${autoMsg_c2afb73135}</div>
                </div>
                <button class="adm-btn adm-btn-primary" onclick="openCreateModal()">${autoMsg_465a728122}</button>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-body" style="padding:0;">
            <c:choose>
                <c:when test="${empty codeList}">
                    <div style="text-align:center;padding:60px;color:#94a3b8;">${autoMsg_7c8fa7bc61}</div>
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
                        <div class="sa-group-cnt">${autoMsg_d8f75bd79c}</div>
                        <div>
                            <c:choose>
                                <c:when test="${c.active}"><span class="adm-badge adm-badge-green">${autoMsg_a7318696c8}</span></c:when>
                                <c:otherwise><span class="adm-badge">${autoMsg_ef83720c18}</span></c:otherwise>
                            </c:choose>
                        </div>
                        <div style="display:flex;gap:6px;">
                            <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                    data-code="${fn:escapeXml(c.adminPermissionCode)}"
                                    data-name="${fn:escapeXml(c.displayName)}"
                                    onclick="openDetailModal(this.getAttribute('data-code'), this.getAttribute('data-name'))">${autoMsg_e829b19e0c}</button>
                            <c:choose>
                                <c:when test="${c.active}">
                                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                                            data-code="${fn:escapeXml(c.adminPermissionCode)}"
                                            onclick="toggleCode(this.getAttribute('data-code'), false)">${autoMsg_8351e0ad76}</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="adm-btn adm-btn-sm adm-btn-primary"
                                            data-code="${fn:escapeXml(c.adminPermissionCode)}"
                                            onclick="toggleCode(this.getAttribute('data-code'), true)">${autoMsg_2d1c5a729c}</button>
                                </c:otherwise>
                            </c:choose>
                            <button class="adm-btn adm-btn-sm"
                                    style="background:#1e2330;color:#94a3b8;border:1px solid #2d3748;"
                                    data-code="${fn:escapeXml(c.adminPermissionCode)}"
                                    onclick="deleteCode(this.getAttribute('data-code'))">${autoMsg_5aa040b568}</button>
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
            <div class="adm-modal-title">${autoMsg_135d53b7b1}</div>
            <button class="adm-modal-close" onclick="closeModal('createModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr;">
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_5ef5a288f3} <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newCode" type="text" placeholder="${autoMsg_2fcc2831fa}" style="text-transform:uppercase;">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_d0c660fc81} <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newName" type="text" placeholder="${autoMsg_e37e20c6be}">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">${autoMsg_ad4774244e}</label>
                    <input class="adm-input" id="newDesc" type="text" placeholder="${autoMsg_2bd8d87413}">
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"   onclick="closeModal('createModal')">${autoMsg_7bb4aadca6}</button>
            <button class="adm-btn adm-btn-primary"  onclick="createCode()">${autoMsg_d5fffdfefc}</button>
        </div>
    </div>
</div>

<%-- 상세 모달 --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal" style="width:600px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="detailModalTitle">${autoMsg_48d9653617}</div>
            <button class="adm-modal-close" onclick="closeModal('detailModal')">✕</button>
        </div>
        <div class="adm-modal-body">

            <div class="sa-section-title">${autoMsg_dbf9b3100c}</div>
            <div id="permItemList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">${autoMsg_a85bca2e31}</div>
            </div>
            <div style="display:flex;gap:8px;margin-bottom:20px;">
                <select class="adm-select" id="addPermSelect" style="flex:1;">
                    <option value="">${autoMsg_601bf9e008}</option>
                    <c:forEach var="p" items="${permissionPolicies}">
                        <option value="${fn:escapeXml(p.permissionCode)}">${fn:escapeXml(p.displayName)} (${fn:escapeXml(p.permissionCode)})</option>
                    </c:forEach>
                </select>
                <button class="adm-btn adm-btn-primary" onclick="addPermItem()">${autoMsg_0d61c6c291}</button>
            </div>

            <div class="sa-section-title">${autoMsg_70559cfcae}</div>
            <div id="groupItemList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">${autoMsg_a85bca2e31}</div>
            </div>
            <div style="display:flex;gap:8px;margin-bottom:20px;">
                <select class="adm-select" id="addGroupSelect" style="flex:1;">
                    <option value="">${autoMsg_9e59df18df}</option>
                    <c:forEach var="g" items="${groupList}">
                        <c:if test="${g.active}">
                        <option value="${fn:escapeXml(g.groupCode)}">${fn:escapeXml(g.displayName)} (${fn:escapeXml(g.groupCode)})</option>
                        </c:if>
                    </c:forEach>
                </select>
                <button class="adm-btn adm-btn-primary" onclick="addGroupItem()">${autoMsg_0d61c6c291}</button>
            </div>

            <div class="sa-section-title">${autoMsg_3a4aaad55a}</div>
            <div style="display:flex;gap:8px;margin-bottom:10px;">
                <input class="adm-input" id="adminSearchInput" type="text" placeholder="${autoMsg_da8f44fd94}" style="flex:1;"
                       onkeydown="if(event.key==='Enter') searchAdminsToAssign()">
                <button class="adm-btn adm-btn-primary" onclick="searchAdminsToAssign()">${autoMsg_64b993dcdf}</button>
            </div>
            <div id="adminSearchResult" style="margin-bottom:12px;"></div>
            <div id="adminList" style="margin-bottom:8px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">${autoMsg_a85bca2e31}</div>
            </div>

        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('detailModal')">${autoMsg_5f7cf13a7c}</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentCode = null;
const PERMISSION_CODE_MESSAGES = {
    required: '${autoMsg_05a1234193}',
    createFailed: '${autoMsg_304dc2b2bb}',
    created: '${autoMsg_b1afaf1f6b}',
    confirmActivate: '${autoMsg_2cdc22806b}',
    confirmDeactivate: '${autoMsg_d487944ccf}',
    updated: '${autoMsg_d067070f0a}',
    updateFailed: '${autoMsg_b2d4b29574}',
    confirmDeleteEmpty: '${autoMsg_f1655a1c32}',
    confirmDeleteWithAdmins: '${autoMsg_73a1b1f8b3}',
    deleted: '${autoMsg_a0a02bd418}',
    deleteFailed: '${autoMsg_d1c1daa3fe}',
    detailSuffix: '${autoMsg_7451dbe148}',
    loading: '${autoMsg_bcf72687cb}',
    noPermissions: '${autoMsg_7046ecc040}',
    noGroups: '${autoMsg_8460729be4}',
    noAdmins: '${autoMsg_033f7e4678}',
    removeAction: '${autoMsg_085a90955f}',
    revokeAction: '${autoMsg_59650caece}',
    permissionRequired: '${autoMsg_e0097a865b}',
    permissionAdded: '${autoMsg_a409c04055}',
    permissionAddFailed: '${autoMsg_090029a5e1}',
    confirmRemovePermission: '${autoMsg_e61d982d0b}',
    permissionRemoved: '${autoMsg_262ca1dc2b}',
    permissionRemoveFailed: '${autoMsg_014af048de}',
    groupRequired: '${autoMsg_7325954f6a}',
    groupAdded: '${autoMsg_2e08ddedd1}',
    groupAddFailed: '${autoMsg_b1d282a816}',
    confirmRemoveGroup: '${autoMsg_eca7210617}',
    groupRemoved: '${autoMsg_e17eaeaa42}',
    groupRemoveFailed: '${autoMsg_fdbd9a4357}',
    searchRequired: '${autoMsg_2cdfdc29d3}',
    searchEmpty: '${autoMsg_4fd90f3cc9}',
    assignAction: '${autoMsg_90f4ea2e97}',
    confirmAssignAdmin: '${autoMsg_fae9694fd2}',
    templateAssigned: '${autoMsg_27481c2ecd}',
    templateAssignFailed: '${autoMsg_7af0abe550}',
    confirmRevokeAdmin: '${autoMsg_5ee833c26c}',
    templateRevoked: '${autoMsg_82de44085e}',
    templateRevokeFailed: '${autoMsg_608f247a54}'
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
