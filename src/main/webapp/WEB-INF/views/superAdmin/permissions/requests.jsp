<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="requests"/>
<c:set var="pageTitle"  value="권한 요청 목록"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">대기 중인 권한 요청</div>
            <div style="font-size:13px;color:#94a3b8;">
                관리자 상세 화면의 '변경 요청'으로 생성된 권한 부여 요청을 승인하거나 거절합니다.
            </div>
        </div>
        <div class="adm-card-body" style="padding:0;">
            <c:choose>
                <c:when test="${empty requestList}">
                    <div style="text-align:center;padding:60px;color:#94a3b8;">
                        대기 중인 권한 요청이 없습니다.
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
                            <div>요청자: ${not empty req.requestedByNickname ? fn:escapeXml(req.requestedByNickname) : '-'}</div>
                            <div><fmt:formatDate value="${req.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                            <c:if test="${not empty req.description}">
                                <div style="color:#64748b;margin-top:2px;">${fn:escapeXml(req.description)}</div>
                            </c:if>
                        </div>
                        <div style="display:flex;gap:8px;">
                            <button class="adm-btn adm-btn-sm adm-btn-primary"
                                    data-id="${req.adminPermissionIdx}"
                                    onclick="approveRequest(this.getAttribute('data-id'), this)">승인</button>
                            <button class="adm-btn adm-btn-sm adm-btn-danger"
                                    data-id="${req.adminPermissionIdx}"
                                    onclick="rejectRequest(this.getAttribute('data-id'), this)">거절</button>
                        </div>
                    </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div style="margin-top:12px;font-size:13px;color:#94a3b8;padding:0 4px;">
        권한 요청은 관리자 목록 → 권한 모달 → "변경 요청" 버튼으로 생성할 수 있습니다.
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';

function approveRequest(adminPermissionIdx, btn) {
    if (!confirm('이 권한 요청을 승인하시겠습니까?')) return;
    fetch(CTX + '/superAdmin/permissions/requests/' + adminPermissionIdx + '/approve', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast('승인되었습니다.');
            btn.closest('.sa-req-row').remove();
        } else {
            adm_toast(data.message || '승인 실패', 'error');
        }
    });
}

function rejectRequest(adminPermissionIdx, btn) {
    if (!confirm('이 권한 요청을 거절하시겠습니까?')) return;
    fetch(CTX + '/superAdmin/permissions/requests/' + adminPermissionIdx + '/reject', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast('거절되었습니다.');
            btn.closest('.sa-req-row').remove();
        } else {
            adm_toast(data.message || '거절 실패', 'error');
        }
    });
}
</script>

<%@ include file="../layout-close.jsp" %>
