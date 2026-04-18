<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="permissionCodes"/>
<c:set var="pageTitle"  value="권한 템플릿 관리"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div style="display:flex;align-items:center;justify-content:space-between;">
                <div>
                    <div style="font-size:15px;font-weight:700;margin-bottom:4px;">실효 권한 코드 목록</div>
                    <div style="font-size:13px;color:#94a3b8;">관리자 계정에 일괄 적용할 권한 번들을 관리합니다. 개별 권한과 권한 그룹을 조합할 수 있습니다.</div>
                </div>
                <button class="adm-btn adm-btn-primary" onclick="openCreateModal()">+ 코드 생성</button>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-body" style="padding:0;">
            <c:choose>
                <c:when test="${empty codeList}">
                    <div style="text-align:center;padding:60px;color:#94a3b8;">등록된 권한 코드가 없습니다.</div>
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
                        <div class="sa-group-cnt">권한 ${c.permissionItemCount}개 · 그룹 ${c.groupItemCount}개</div>
                        <div>
                            <c:choose>
                                <c:when test="${c.active}"><span class="adm-badge adm-badge-green">활성</span></c:when>
                                <c:otherwise><span class="adm-badge">비활성</span></c:otherwise>
                            </c:choose>
                        </div>
                        <div style="display:flex;gap:6px;">
                            <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                    data-code="${fn:escapeXml(c.adminPermissionCode)}"
                                    data-name="${fn:escapeXml(c.displayName)}"
                                    onclick="openDetailModal(this.getAttribute('data-code'), this.getAttribute('data-name'))">상세</button>
                            <c:choose>
                                <c:when test="${c.active}">
                                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                                            data-code="${fn:escapeXml(c.adminPermissionCode)}"
                                            onclick="toggleCode(this.getAttribute('data-code'), false)">비활성화</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="adm-btn adm-btn-sm adm-btn-primary"
                                            data-code="${fn:escapeXml(c.adminPermissionCode)}"
                                            onclick="toggleCode(this.getAttribute('data-code'), true)">활성화</button>
                                </c:otherwise>
                            </c:choose>
                            <button class="adm-btn adm-btn-sm"
                                    style="background:#1e2330;color:#94a3b8;border:1px solid #2d3748;"
                                    data-code="${fn:escapeXml(c.adminPermissionCode)}"
                                    onclick="deleteCode(this.getAttribute('data-code'))">삭제</button>
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
            <div class="adm-modal-title">권한 코드 생성</div>
            <button class="adm-modal-close" onclick="closeModal('createModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr;">
                <div class="sa-form-group">
                    <label class="sa-form-label">권한 코드 <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newCode" type="text" placeholder="예: CS_MANAGER_L1" style="text-transform:uppercase;">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">표시명 <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newName" type="text" placeholder="예: 고객지원 매니저 L1">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">설명</label>
                    <input class="adm-input" id="newDesc" type="text" placeholder="설명 (선택)">
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"   onclick="closeModal('createModal')">취소</button>
            <button class="adm-btn adm-btn-primary"  onclick="createCode()">생성</button>
        </div>
    </div>
</div>

<%-- 상세 모달 --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal" style="width:600px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="detailModalTitle">코드 상세</div>
            <button class="adm-modal-close" onclick="closeModal('detailModal')">✕</button>
        </div>
        <div class="adm-modal-body">

            <div class="sa-section-title">포함된 개별 권한</div>
            <div id="permItemList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">불러오는 중...</div>
            </div>
            <div style="display:flex;gap:8px;margin-bottom:20px;">
                <select class="adm-select" id="addPermSelect" style="flex:1;">
                    <option value="">-- 권한 선택 --</option>
                    <c:forEach var="p" items="${permissionPolicies}">
                        <option value="${fn:escapeXml(p.permissionCode)}">${fn:escapeXml(p.displayName)} (${fn:escapeXml(p.permissionCode)})</option>
                    </c:forEach>
                </select>
                <button class="adm-btn adm-btn-primary" onclick="addPermItem()">추가</button>
            </div>

            <div class="sa-section-title">포함된 권한 그룹</div>
            <div id="groupItemList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:16px;color:#94a3b8;">불러오는 중...</div>
            </div>
            <div style="display:flex;gap:8px;margin-bottom:20px;">
                <select class="adm-select" id="addGroupSelect" style="flex:1;">
                    <option value="">-- 그룹 선택 --</option>
                    <c:forEach var="g" items="${groupList}">
                        <c:if test="${g.active}">
                        <option value="${fn:escapeXml(g.groupCode)}">${fn:escapeXml(g.displayName)} (${fn:escapeXml(g.groupCode)})</option>
                        </c:if>
                    </c:forEach>
                </select>
                <button class="adm-btn adm-btn-primary" onclick="addGroupItem()">추가</button>
            </div>

            <div class="sa-section-title">이 템플릿이 배정된 관리자</div>
            <div style="display:flex;gap:8px;margin-bottom:10px;">
                <input class="adm-input" id="adminSearchInput" type="text" placeholder="닉네임 또는 아이디 검색" style="flex:1;"
                       onkeydown="if(event.key==='Enter') searchAdminsToAssign()">
                <button class="adm-btn adm-btn-primary" onclick="searchAdminsToAssign()">검색</button>
            </div>
            <div id="adminSearchResult" style="margin-bottom:12px;"></div>
            <div id="adminList" style="margin-bottom:8px;">
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
let currentCode = null;

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
    if (!code || !name) { adm_toast('코드와 표시명은 필수입니다.', 'error'); return; }

    const params = new URLSearchParams({ adminPermissionCode: code, displayName: name, description: desc });
    fetch(CTX + '/superAdmin/permission-codes', {
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

function toggleCode(code, active) {
    const msg = active ? '이 코드를 활성화하시겠습니까?' : '이 코드를 비활성화하시겠습니까?';
    if (!confirm(msg)) return;
    fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(code) + '/toggle', {
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

function deleteCode(code) {
    fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(code))
        .then(r => r.json())
        .then(data => {
            const cnt = (data.admins || []).length;
            const msg = cnt > 0
                ? '이 코드를 삭제하시겠습니까?\n현재 ' + cnt + '명의 관리자에게 배정되어 있습니다.\n삭제 시 해당 관리자들의 코드가 NULL로 초기화됩니다.'
                : '이 코드를 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.';
            if (!confirm(msg)) return;
            fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(code) + '/delete', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
            })
            .then(r => r.json())
            .then(d => {
                if (d.success) { adm_toast('삭제되었습니다.'); location.reload(); }
                else adm_toast(d.message || '삭제 실패', 'error');
            });
        });
}

function openDetailModal(code, name) {
    currentCode = code;
    document.getElementById('detailModalTitle').textContent = name + ' — 상세';
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
                ? '<div style="color:#94a3b8;padding:4px 0;">포함된 개별 권한이 없습니다.</div>'
                : permItems.map(i => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${i.displayName}</span>
                        <span class="sa-group-item-code">\${i.permissionCode}</span>
                        <button class="adm-btn adm-btn-sm adm-btn-danger"
                                data-code="\${i.permissionCode}"
                                onclick="removePermItem(this.getAttribute('data-code'))">제거</button>
                    </div>`).join('');

            document.getElementById('groupItemList').innerHTML = groupItems.length === 0
                ? '<div style="color:#94a3b8;padding:4px 0;">포함된 그룹이 없습니다.</div>'
                : groupItems.map(g => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${g.displayName}</span>
                        <span class="sa-group-item-code">\${g.groupCode}</span>
                        <button class="adm-btn adm-btn-sm adm-btn-danger"
                                data-code="\${g.groupCode}"
                                onclick="removeGroupItem(this.getAttribute('data-code'))">제거</button>
                    </div>`).join('');

            var admins = data.admins || [];
            document.getElementById('adminList').innerHTML = admins.length === 0
                ? '<div style="color:#94a3b8;padding:4px 0;">배정된 관리자가 없습니다.</div>'
                : admins.map(m => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${m.nickname}</span>
                        <span class="sa-group-item-code">\${m.userId}</span>
                        <button class="adm-btn adm-btn-sm adm-btn-danger"
                                data-uid="\${m.userIdx}"
                                onclick="revokeAdminCode(this.getAttribute('data-uid'))">해제</button>
                    </div>`).join('');
        });
}

function addPermItem() {
    const permCode = document.getElementById('addPermSelect').value;
    if (!permCode) { adm_toast('권한을 선택하세요.', 'error'); return; }
    fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(currentCode) + '/permissions/add', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'permissionCode=' + encodeURIComponent(permCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('권한이 추가되었습니다.'); loadDetail(); }
        else adm_toast(data.message || '추가 실패', 'error');
    });
}

function removePermItem(permCode) {
    if (!confirm('이 권한을 코드에서 제거하시겠습니까?')) return;
    fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(currentCode) + '/permissions/remove', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'permissionCode=' + encodeURIComponent(permCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('제거되었습니다.'); loadDetail(); }
        else adm_toast(data.message || '제거 실패', 'error');
    });
}

function addGroupItem() {
    const groupCode = document.getElementById('addGroupSelect').value;
    if (!groupCode) { adm_toast('그룹을 선택하세요.', 'error'); return; }
    fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(currentCode) + '/groups/add', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'groupCode=' + encodeURIComponent(groupCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('그룹이 추가되었습니다.'); loadDetail(); }
        else adm_toast(data.message || '추가 실패', 'error');
    });
}

function removeGroupItem(groupCode) {
    if (!confirm('이 그룹을 코드에서 제거하시겠습니까?')) return;
    fetch(CTX + '/superAdmin/permission-codes/' + encodeURIComponent(currentCode) + '/groups/remove', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'groupCode=' + encodeURIComponent(groupCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('제거되었습니다.'); loadDetail(); }
        else adm_toast(data.message || '제거 실패', 'error');
    });
}

function searchAdminsToAssign() {
    const keyword = document.getElementById('adminSearchInput').value.trim();
    if (!keyword) { adm_toast('검색어를 입력하세요.', 'error'); return; }
    fetch(CTX + '/superAdmin/admins/search?keyword=' + encodeURIComponent(keyword) + '&excludeTemplateCode=' + encodeURIComponent(currentCode))
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
                         onclick="assignCodeToAdmin(this.getAttribute('data-uid'), '\${u.nickname}')">
                        <span class="sa-group-item-name">\${u.nickname}</span>
                        <span class="sa-group-item-code">\${u.userId}</span>
                        <span style="font-size:12px;color:#6366f1;">+ 배정</span>
                    </div>`).join('') + '</div>';
        });
}

function assignCodeToAdmin(userIdx, nickname) {
    if (!confirm(nickname + '에게 이 템플릿을 배정하시겠습니까?')) return;
    fetch(CTX + '/superAdmin/members/' + userIdx + '/permission-code', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'permissionCode=' + encodeURIComponent(currentCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast('배정되었습니다.');
            document.getElementById('adminSearchResult').innerHTML = '';
            document.getElementById('adminSearchInput').value = '';
            loadDetail();
        } else adm_toast(data.message || '배정 실패', 'error');
    });
}

function revokeAdminCode(userIdx) {
    if (!confirm('이 관리자의 권한 코드를 해제하시겠습니까?')) return;
    const params = new URLSearchParams();
    fetch(CTX + '/superAdmin/members/' + userIdx + '/permission-code', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
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
