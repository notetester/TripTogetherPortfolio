<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="activeMenu" value="requests"/>
<spring:message var="superadminPermissionsRequestsConfirmApproveMsg" code="superAdmin.permissions.requests.confirmApprove" javaScriptEscape="true"/>
<spring:message var="superadminPermissionsRequestsConfirmRejectMsg" code="superAdmin.permissions.requests.confirmReject" javaScriptEscape="true"/>
<spring:message var="superadminPermissionsRequestsToastApprovedMsg" code="superAdmin.permissions.requests.toastApproved" javaScriptEscape="true"/>
<spring:message var="superadminPermissionsRequestsToastApproveFailMsg" code="superAdmin.permissions.requests.toastApproveFail" javaScriptEscape="true"/>
<spring:message var="superadminPermissionsRequestsToastRejectedMsg" code="superAdmin.permissions.requests.toastRejected" javaScriptEscape="true"/>
<spring:message var="superadminPermissionsRequestsToastRejectFailMsg" code="superAdmin.permissions.requests.toastRejectFail" javaScriptEscape="true"/>
<spring:message code="superAdmin.permissions.requests.pageTitle" var="pageTitle"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="superAdmin.permissions.requests.cardTitle"/></div>
            <div style="font-size:13px;color:#94a3b8;">
                <spring:message code="superAdmin.permissions.requests.cardDescription"/>
            </div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <c:choose>
                <c:when test="${empty requestList}">
                    <div style="text-align:center;padding:60px;color:#94a3b8;">
                        <spring:message code="superAdmin.permissions.requests.empty"/>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="req" items="${requestList}">
                    <div class="sa-req-row">
                        <div class="sa-req-user">${fn:escapeXml(req.userNickname)}</div>
                        <div class="sa-req-perm">
                            <div class="sa-req-perm-name">${fn:escapeXml(req.permissionDisplayName)}</div>
                            <div class="sa-req-perm-code">${fn:escapeXml(req.permissionCode)}</div>
                        </div>
                        <div class="sa-req-meta">
                            <div><spring:message code="superAdmin.permissions.requests.requester"/>: ${not empty req.requestedByNickname ? fn:escapeXml(req.requestedByNickname) : '-'}</div>
                            <div><fmt:formatDate value="${req.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                            <c:if test="${not empty req.description}">
                                <div style="color:#64748b;margin-top:2px;">${fn:escapeXml(req.description)}</div>
                            </c:if>
                        </div>
                        <div style="display:flex;gap:8px;">
                            <button class="adm-btn adm-btn-sm adm-btn-primary"
                                    data-id="${req.adminPermissionIdx}"
                                    onclick="approveRequest(this.getAttribute('data-id'), this)"><spring:message code="superAdmin.permissions.requests.action.approve"/></button>
                            <button class="adm-btn adm-btn-sm adm-btn-danger"
                                    data-id="${req.adminPermissionIdx}"
                                    onclick="rejectRequest(this.getAttribute('data-id'), this)"><spring:message code="superAdmin.permissions.requests.action.reject"/></button>
                        </div>
                    </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div style="margin-top:12px;font-size:13px;color:#94a3b8;padding:0 4px;">
        <spring:message code="superAdmin.permissions.requests.createHint"/>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
const REQUEST_MESSAGES = {
    confirmApprove: '${superadminPermissionsRequestsConfirmApproveMsg}',
    confirmReject: '${superadminPermissionsRequestsConfirmRejectMsg}',
    approved: '${superadminPermissionsRequestsToastApprovedMsg}',
    approveFail: '${superadminPermissionsRequestsToastApproveFailMsg}',
    rejected: '${superadminPermissionsRequestsToastRejectedMsg}',
    rejectFail: '${superadminPermissionsRequestsToastRejectFailMsg}'
};

function approveRequest(adminPermissionIdx, btn) {
    if (!confirm(REQUEST_MESSAGES.confirmApprove)) return;
    fetch(CTX + '/superAdmin/permissions/requests/' + adminPermissionIdx + '/approve', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast(REQUEST_MESSAGES.approved);
            btn.closest('.sa-req-row').remove();
        } else {
            adm_toast(data.message || REQUEST_MESSAGES.approveFail, 'error');
        }
    });
}

function rejectRequest(adminPermissionIdx, btn) {
    if (!confirm(REQUEST_MESSAGES.confirmReject)) return;
    fetch(CTX + '/superAdmin/permissions/requests/' + adminPermissionIdx + '/reject', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast(REQUEST_MESSAGES.rejected);
            btn.closest('.sa-req-row').remove();
        } else {
            adm_toast(data.message || REQUEST_MESSAGES.rejectFail, 'error');
        }
    });
}
</script>

<%@ include file="../layout-close.jsp" %>
