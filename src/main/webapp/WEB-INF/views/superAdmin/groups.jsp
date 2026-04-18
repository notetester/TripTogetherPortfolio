<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="groups"/>
<c:set var="pageTitle"  value="권한 그룹 관리"/>
<%@ include file="layout.jsp" %>

<div class="adm-content">

    <%-- 헤더 + 생성 버튼 --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div style="display:flex;align-items:center;justify-content:space-between;">
                <div>
                    <div style="font-size:15px;font-weight:700;margin-bottom:4px;">권한 그룹 목록</div>
                    <div style="font-size:13px;color:#94a3b8;">관리자에게 일괄 부여할 권한 묶음을 관리합니다.</div>
                </div>
                <button class="adm-btn adm-btn-primary" onclick="openCreateModal()">+ 그룹 생성</button>
            </div>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-body" style="padding:0;">
            <c:choose>
                <c:when test="${empty groupList}">
                    <div style="text-align:center;padding:60px;color:#94a3b8;">등록된 권한 그룹이 없습니다.</div>
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
                        <div class="sa-group-cnt">권한 ${g.itemCount}개</div>
                        <div>
                            <c:choose>
                                <c:when test="${g.active}"><span class="adm-badge adm-badge-green">활성</span></c:when>
                                <c:otherwise><span class="adm-badge">비활성</span></c:otherwise>
                            </c:choose>
                        </div>
                        <div style="display:flex;gap:6px;">
                            <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                    data-code="${g.groupCode}" data-name="${fn:escapeXml(g.displayName)}"
                                    onclick="openDetailModal(this.getAttribute('data-code'), this.getAttribute('data-name'))">상세</button>
                            <c:choose>
                                <c:when test="${g.active}">
                                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                                            data-code="${g.groupCode}"
                                            onclick="toggleGroup(this.getAttribute('data-code'), false)">비활성화</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="adm-btn adm-btn-sm adm-btn-primary"
                                            data-code="${g.groupCode}"
                                            onclick="toggleGroup(this.getAttribute('data-code'), true)">활성화</button>
                                </c:otherwise>
                            </c:choose>
                            <button class="adm-btn adm-btn-sm"
                                    style="background:#1e2330;color:#94a3b8;border:1px solid #2d3748;"
                                    data-code="${g.groupCode}" data-cnt="${g.itemCount}"
                                    onclick="deleteGroup(this.getAttribute('data-code'))">삭제</button>
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
            <div class="adm-modal-title">권한 그룹 생성</div>
            <button class="adm-modal-close" onclick="closeModal('createModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-form-grid" style="grid-template-columns:1fr;">
                <div class="sa-form-group">
                    <label class="sa-form-label">그룹 코드 <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newGroupCode" type="text" placeholder="예: COMMUNITY_OPS" style="text-transform:uppercase;">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">표시명 <span style="color:#ef4444;">*</span></label>
                    <input class="adm-input" id="newGroupName" type="text" placeholder="예: 커뮤니티 운영팀 기본 권한">
                </div>
                <div class="sa-form-group">
                    <label class="sa-form-label">설명</label>
                    <input class="adm-input" id="newGroupDesc" type="text" placeholder="그룹 설명 (선택)">
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"  onclick="closeModal('createModal')">취소</button>
            <button class="adm-btn adm-btn-primary" onclick="createGroup()">생성</button>
        </div>
    </div>
</div>

<%-- ══════════════════════════════════════════
     그룹 상세 모달
══════════════════════════════════════════ --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal" style="width:560px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="detailModalTitle">그룹 상세</div>
            <button class="adm-modal-close" onclick="closeModal('detailModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div class="sa-section-title">포함된 권한</div>
            <div id="groupItemList" style="margin-bottom:16px;">
                <div style="text-align:center;padding:20px;color:#94a3b8;">불러오는 중...</div>
            </div>
            <div class="sa-section-title">권한 추가</div>
            <div style="display:flex;gap:8px;margin-bottom:20px;">
                <select class="adm-select" id="addPermSelect" style="flex:1;">
                    <option value="">-- 권한 선택 --</option>
                    <c:forEach var="p" items="${permissionPolicies}">
                        <option value="${p.permissionCode}">${p.displayName} (${p.permissionCode})</option>
                    </c:forEach>
                </select>
                <button class="adm-btn adm-btn-primary" onclick="addItem()">추가</button>
            </div>
            <div class="sa-section-title">소속 관리자</div>
            <div style="display:flex;gap:8px;margin-bottom:10px;">
                <input class="adm-input" id="memberSearchInput" type="text" placeholder="닉네임 또는 아이디 검색" style="flex:1;"
                       onkeydown="if(event.key==='Enter') searchMembersToAdd()">
                <button class="adm-btn adm-btn-primary" onclick="searchMembersToAdd()">검색</button>
            </div>
            <div id="memberSearchResult" style="margin-bottom:12px;"></div>
            <div id="groupMemberList">
                <div style="text-align:center;padding:20px;color:#94a3b8;">불러오는 중...</div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('detailModal')">닫기</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentGroupCode = null;

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
    if (!code || !name) { adm_toast('코드와 표시명은 필수입니다.', 'error'); return; }

    const params = new URLSearchParams({ groupCode: code, displayName: name, description: desc });
    fetch(CTX + '/superAdmin/groups', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('그룹이 생성되었습니다.'); closeModal('createModal'); location.reload(); }
        else adm_toast(data.message || '생성 실패', 'error');
    });
}

function toggleGroup(groupCode, active) {
    const msg = active ? '이 그룹을 활성화하시겠습니까?' : '이 그룹을 비활성화하시겠습니까?';
    if (!confirm(msg)) return;
    fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(groupCode) + '/toggle', {
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

function openDetailModal(groupCode, groupName) {
    currentGroupCode = groupCode;
    document.getElementById('detailModalTitle').textContent = groupName + ' — 상세';
    document.getElementById('detailModal').classList.add('open');
    loadGroupItems();
    loadGroupMembers();
}

function loadGroupItems() {
    document.getElementById('groupItemList').innerHTML = '<div style="text-align:center;padding:20px;color:#94a3b8;">불러오는 중...</div>';
    fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(currentGroupCode))
        .then(r => r.json())
        .then(data => {
            var items = data.items || [];
            if (items.length === 0) {
                document.getElementById('groupItemList').innerHTML = '<div style="color:#94a3b8;padding:8px 0;">포함된 권한이 없습니다.</div>';
            } else {
                document.getElementById('groupItemList').innerHTML = items.map(i => `
                    <div class="sa-group-item-row">
                        <span class="sa-group-item-name">\${i.displayName}</span>
                        <span class="sa-group-item-code">\${i.permissionCode}</span>
                        <button class="adm-btn adm-btn-sm adm-btn-danger"
                                data-code="\${i.permissionCode}"
                                onclick="removeItem(this.getAttribute('data-code'))">삭제</button>
                    </div>`).join('');
            }
            var btn = document.querySelector('.sa-group-row button[data-code="' + currentGroupCode + '"]');
            if (btn) {
                var cnt = btn.closest('.sa-group-row').querySelector('.sa-group-cnt');
                if (cnt) cnt.textContent = '권한 ' + items.length + '개';
            }
        });
}

function loadGroupMembers() {
    document.getElementById('groupMemberList').innerHTML = '<div style="text-align:center;padding:20px;color:#94a3b8;">불러오는 중...</div>';
    fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(currentGroupCode) + '/members')
        .then(r => r.json())
        .then(data => {
            if (!data.members || data.members.length === 0) {
                document.getElementById('groupMemberList').innerHTML = '<div style="color:#94a3b8;padding:8px 0;">소속 관리자가 없습니다.</div>';
                return;
            }
            document.getElementById('groupMemberList').innerHTML = data.members.map(m => `
                <div class="sa-group-item-row">
                    <span class="sa-group-item-name">\${m.nickname}</span>
                    <span class="sa-group-item-code">\${m.userId}</span>
                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                            data-uid="\${m.userIdx}"
                            onclick="revokeMemberGroup(this.getAttribute('data-uid'))">해제</button>
                </div>`).join('');
        });
}

function searchMembersToAdd() {
    const keyword = document.getElementById('memberSearchInput').value.trim();
    if (!keyword) { adm_toast('검색어를 입력하세요.', 'error'); return; }
    fetch(CTX + '/superAdmin/admins/search?keyword=' + encodeURIComponent(keyword) + '&excludeGroupCode=' + encodeURIComponent(currentGroupCode))
        .then(r => r.json())
        .then(data => {
            var users = data.users || [];
            if (users.length === 0) {
                document.getElementById('memberSearchResult').innerHTML = '<div style="color:#94a3b8;font-size:13px;padding:4px 0;">검색 결과가 없습니다.</div>';
                return;
            }
            document.getElementById('memberSearchResult').innerHTML =
                '<div style="border:1px solid #2d3748;border-radius:6px;overflow:hidden;">' +
                users.map(u => `
                    <div class="sa-group-item-row" style="cursor:pointer;" data-uid="\${u.userIdx}"
                         onclick="addMemberToGroup(this.getAttribute('data-uid'), '\${u.nickname}')">
                        <span class="sa-group-item-name">\${u.nickname}</span>
                        <span class="sa-group-item-code">\${u.userId}</span>
                        <span style="font-size:12px;color:#6366f1;">+ 추가</span>
                    </div>`).join('') + '</div>';
        });
}

function addMemberToGroup(userIdx, nickname) {
    if (!confirm(nickname + '을(를) 그룹에 추가하시겠습니까?')) return;
    fetch(CTX + '/superAdmin/members/' + userIdx + '/groups/assign', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'groupCode=' + encodeURIComponent(currentGroupCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast('추가되었습니다.');
            document.getElementById('memberSearchResult').innerHTML = '';
            document.getElementById('memberSearchInput').value = '';
            loadGroupMembers();
        } else adm_toast(data.message || '추가 실패', 'error');
    });
}

function revokeMemberGroup(userIdx) {
    if (!confirm('이 관리자를 그룹에서 해제하시겠습니까?')) return;
    fetch(CTX + '/superAdmin/members/' + userIdx + '/groups/revoke', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'groupCode=' + encodeURIComponent(currentGroupCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('해제되었습니다.'); loadGroupMembers(); }
        else adm_toast(data.message || '해제 실패', 'error');
    });
}

function addItem() {
    const permCode = document.getElementById('addPermSelect').value;
    if (!permCode) { adm_toast('권한을 선택하세요.', 'error'); return; }
    fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(currentGroupCode) + '/items/add', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'permissionCode=' + encodeURIComponent(permCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('권한이 추가되었습니다.'); loadGroupItems(); }
        else adm_toast(data.message || '추가 실패', 'error');
    });
}

function removeItem(permCode) {
    if (!confirm('이 권한을 그룹에서 제거하시겠습니까?')) return;
    fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(currentGroupCode) + '/items/remove', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'permissionCode=' + encodeURIComponent(permCode)
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('권한이 제거되었습니다.'); loadGroupItems(); }
        else adm_toast(data.message || '제거 실패', 'error');
    });
}

function deleteGroup(groupCode) {
    fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(groupCode) + '/members')
        .then(r => r.json())
        .then(data => {
            var memberCount = (data.members || []).length;
            var msg = memberCount > 0
                ? '이 그룹을 삭제하시겠습니까?\n소속 관리자 ' + memberCount + '명의 그룹 배정이 해제되고 그룹 기반 권한이 박탈됩니다.'
                : '이 그룹을 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.';
            if (!confirm(msg)) return;
            fetch(CTX + '/superAdmin/groups/' + encodeURIComponent(groupCode) + '/delete', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' }
            })
            .then(r => r.json())
            .then(d => {
                if (d.success) { adm_toast('그룹이 삭제되었습니다.'); location.reload(); }
                else adm_toast(d.message || '삭제 실패', 'error');
            });
        });
}

function closeModal(id) { document.getElementById(id).classList.remove('open'); }
</script>

<%@ include file="layout-close.jsp" %>
