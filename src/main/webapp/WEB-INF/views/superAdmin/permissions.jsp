<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="permissions"/>
<c:set var="pageTitle"  value="권한 항목 관리"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div style="display:flex;align-items:center;justify-content:space-between;">
                <div>
                    <div style="font-size:15px;font-weight:700;margin-bottom:4px;">개별 권한 코드 목록</div>
                    <div style="font-size:13px;color:#94a3b8;">권한 그룹·번들의 기본 단위입니다. 신중하게 추가/삭제하세요.</div>
                </div>
                <button class="adm-btn adm-btn-primary" onclick="openCreateModal()">+ 권한 생성</button>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-body" style="padding:0;">
            <c:choose>
                <c:when test="${empty permissionList}">
                    <div style="text-align:center;padding:60px;color:#94a3b8;">등록된 권한이 없습니다.</div>
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
                        <div class="sa-group-cnt">직접 부여 ${p.usageCount}명</div>
                        <div>
                            <c:choose>
                                <c:when test="${p.active}"><span class="adm-badge adm-badge-green">활성</span></c:when>
                                <c:otherwise><span class="adm-badge">비활성</span></c:otherwise>
                            </c:choose>
                        </div>
                        <div style="display:flex;gap:6px;">
                            <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                    data-code="${fn:escapeXml(p.permissionCode)}"
                                    data-name="${fn:escapeXml(p.displayName)}"
                                    onclick="openDetailModal(this.getAttribute('data-code'), this.getAttribute('data-name'))">상세</button>
                            <c:choose>
                                <c:when test="${p.active}">
                                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                                            data-code="${fn:escapeXml(p.permissionCode)}"
                                            onclick="togglePerm(this.getAttribute('data-code'), false)">비활성화</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="adm-btn adm-btn-sm adm-btn-primary"
                                            data-code="${fn:escapeXml(p.permissionCode)}"
                                            onclick="togglePerm(this.getAttribute('data-code'), true)">활성화</button>
                                </c:otherwise>
                            </c:choose>
                            <button class="adm-btn adm-btn-sm"
                                    style="background:#1e2330;color:#94a3b8;border:1px solid #2d3748;"
                                    data-code="${fn:escapeXml(p.permissionCode)}"
                                    data-usage="${p.usageCount}"
                                    onclick="deletePerm(this.getAttribute('data-code'), this.getAttribute('data-usage'))">삭제</button>
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
            <div class="adm-modal-title">개별 권한 생성</div>
            <button class="adm-modal-close" onclick="closeModal('createModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr;">
                <div class="sa-form-group">
                    <label class="sa-form-label">권한 코드 <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newCode" type="text" placeholder="예: EXPLORE_ADMIN" style="text-transform:uppercase;">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">표시명 <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newName" type="text" placeholder="예: 여행지 관리자">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">설명</label>
                    <input class="adm-input" id="newDesc" type="text" placeholder="설명 (선택)">
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"  onclick="closeModal('createModal')">취소</button>
            <button class="adm-btn adm-btn-primary" onclick="createPerm()">생성</button>
        </div>
    </div>
</div>

<%-- 상세 모달 --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal" style="width:560px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="detailModalTitle">권한 상세</div>
            <button class="adm-modal-close" onclick="closeModal('detailModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-section-title">포함된 권한 그룹</div>
            <div id="groupList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">불러오는 중...</div>
            </div>
            <div class="sa-section-title">포함된 권한 템플릿</div>
            <div id="codeList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">불러오는 중...</div>
            </div>
            <div class="sa-section-title">직접 부여된 관리자</div>
            <div style="display:flex;gap:8px;margin-bottom:10px;">
                <input class="adm-input" id="adminSearchInput" type="text" placeholder="닉네임 또는 아이디 검색" style="flex:1;"
                       onkeydown="if(event.key==='Enter') searchAdminsToGrant()">
                <button class="adm-btn adm-btn-primary" onclick="searchAdminsToGrant()">검색</button>
            </div>
            <div id="adminSearchResult" style="margin-bottom:12px;"></div>
            <div id="adminList">
                <div style="text-align:center;padding:16px;color:#94a3b8;">불러오는 중...</div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('detailModal')">닫기</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentPermCode = null;

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
    if (!code || !name) { adm_toast('코드와 표시명은 필수입니다.', 'error'); return; }

    const params = new URLSearchParams({ permissionCode: code, displayName: name, description: desc });
    fetch(CTX + '/superAdmin/permissions', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('생성되었습니다.'); closeModal('createModal'); location.reload(); }
        else adm_toast(data.message || '생성 실패', 'error');
    });
}

function togglePerm(code, active) {
    const msg = active ? '이 권한을 활성화하시겠습니까?' : '이 권한을 비활성화하시겠습니까?';
    if (!confirm(msg)) return;
    fetch(CTX + '/superAdmin/permissions/' + encodeURIComponent(code) + '/toggle', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'active=' + active
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('변경되었습니다.'); location.reload(); }
        else adm_toast(data.message || '변경 실패', 'error');
    });
}

function deletePerm(code, usageCount) {
    var cnt = parseInt(usageCount) || 0;
    var msg = cnt > 0
        ? '이 권한을 삭제하시겠습니까?\n현재 ' + cnt + '명에게 직접 부여되어 있습니다.\n그룹·번들에 포함된 경우도 함께 삭제됩니다.'
        : '이 권한을 삭제하시겠습니까?\n그룹·번들에 포함된 경우도 함께 삭제됩니다.\n이 작업은 되돌릴 수 없습니다.';
    if (!confirm(msg)) return;
    fetch(CTX + '/superAdmin/permissions/' + encodeURIComponent(code) + '/delete', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('삭제되었습니다.'); location.reload(); }
        else adm_toast(data.message || '삭제 실패', 'error');
    });
}

function openDetailModal(code, name) {
    currentPermCode = code;
    document.getElementById('detailModalTitle').textContent = name + ' (' + code + ') — 상세';
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
                ? '<div style="color:#94a3b8;padding:4px 0;">포함된 그룹이 없습니다.</div>'
                : groups.map(g => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${g.displayName}</span>
                        <span class="sa-group-item-code">\${g.groupCode}</span>
                    </div>`).join('');

            document.getElementById('codeList').innerHTML = codes.length === 0
                ? '<div style="color:#94a3b8;padding:4px 0;">포함된 템플릿이 없습니다.</div>'
                : codes.map(c => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${c.displayName}</span>
                        <span class="sa-group-item-code">\${c.adminPermissionCode}</span>
                    </div>`).join('');

            document.getElementById('adminList').innerHTML = admins.length === 0
                ? '<div style="color:#94a3b8;padding:4px 0;">직접 부여된 관리자가 없습니다.</div>'
                : admins.map(m => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${m.nickname}</span>
                        <span class="sa-group-item-code">\${m.userId}</span>
                        <button class="adm-btn adm-btn-sm adm-btn-danger"
                                data-uid="\${m.userIdx}"
                                onclick="revokeAdmin(this.getAttribute('data-uid'))">해제</button>
                    </div>`).join('');
        });
}

function searchAdminsToGrant() {
    const keyword = document.getElementById('adminSearchInput').value.trim();
    if (!keyword) { adm_toast('검색어를 입력하세요.', 'error'); return; }
    fetch(CTX + '/superAdmin/admins/search?keyword=' + encodeURIComponent(keyword) + '&excludePermissionCode=' + encodeURIComponent(currentPermCode))
        .then(r => r.json())
        .then(data => {
            var users = data.users || [];
            if (users.length === 0) {
                document.getElementById('adminSearchResult').innerHTML = '<div style="color:#94a3b8;font-size:13px;padding:4px 0;">검색 결과가 없습니다.</div>';
                return;
            }
            document.getElementById('adminSearchResult').innerHTML =
                '<div style="border:1px solid #2d3748;border-radius:6px;overflow:hidden;">' +
                users.map(u => `
                    <div class="sa-group-item-row" style="cursor:pointer;" data-uid="\${u.userIdx}"
                         onclick="grantToAdmin(this.getAttribute('data-uid'), '\${u.nickname}')">
                        <span class="sa-group-item-name">\${u.nickname}</span>
                        <span class="sa-group-item-code">\${u.userId}</span>
                        <span style="font-size:12px;color:#6366f1;">+ 부여</span>
                    </div>`).join('') + '</div>';
        });
}

function grantToAdmin(userIdx, nickname) {
    if (!confirm(nickname + '에게 이 권한을 부여하시겠습니까?')) return;
    fetch(CTX + '/superAdmin/permissions/' + encodeURIComponent(currentPermCode) + '/grant/' + userIdx, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast('부여되었습니다.');
            document.getElementById('adminSearchResult').innerHTML = '';
            document.getElementById('adminSearchInput').value = '';
            loadDetail();
        } else adm_toast(data.message || '부여 실패', 'error');
    });
}

function revokeAdmin(userIdx) {
    if (!confirm('이 관리자의 권한을 해제하시겠습니까?')) return;
    fetch(CTX + '/superAdmin/permissions/' + encodeURIComponent(currentPermCode) + '/revoke/' + userIdx, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('해제되었습니다.'); loadDetail(); }
        else adm_toast(data.message || '해제 실패', 'error');
    });
}

function closeModal(id) { document.getElementById(id).classList.remove('open'); }
</script>

<%@ include file="layout-close.jsp" %>
