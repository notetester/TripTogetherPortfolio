<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="members"/>
<c:set var="pageTitle"  value="관리자 목록"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ══════════════════════════════════════════
         검색 바
    ══════════════════════════════════════════ --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form id="searchForm" method="get" action="${pageContext.request.contextPath}/superAdmin/members">
                <div class="adm-filter-bar">
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">검색</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:100px;">
                                <option value="all"      ${search.searchType=='all'      ? 'selected' : ''}>전체</option>
                                <option value="userId"   ${search.searchType=='userId'   ? 'selected' : ''}>아이디</option>
                                <option value="nickname" ${search.searchType=='nickname' ? 'selected' : ''}>닉네임</option>
                                <option value="email"    ${search.searchType=='email'    ? 'selected' : ''}>이메일</option>
                            </select>
                            <div class="adm-search-box" style="flex:1;">
                                <span class="adm-search-ico">🔍</span>
                                <input class="adm-input" type="text" name="keyword"
                                       value="${search.keyword}" placeholder="검색어 입력...">
                            </div>
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:8px;">
                        <button type="submit" class="adm-btn adm-btn-primary">검색</button>
                        <button type="button" class="adm-btn adm-btn-ghost" onclick="openGrantModal()">+ 관리자 등록</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ══════════════════════════════════════════
         관리자 테이블
    ══════════════════════════════════════════ --%>
    <div class="adm-card">
        <div class="adm-card-body" style="padding:0;">
            <table class="adm-table">
                <thead>
                    <tr>
                        <th>닉네임 / 아이디</th>
                        <th>이메일</th>
                        <th>직함</th>
                        <th>소속</th>
                        <th>권한코드</th>
                        <th>계정상태</th>
                        <th>등록일</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty adminList}">
                        <tr><td colspan="8" style="text-align:center;padding:40px;color:#94a3b8;">등록된 관리자가 없습니다.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="m" items="${adminList}">
                        <tr>
                            <td>
                                <div style="font-weight:600;">${m.nickname}</div>
                                <div style="font-size:12px;color:#94a3b8;">${m.userId}</div>
                            </td>
                            <td>${m.userEmail}</td>
                            <td>${not empty m.adminTitle ? m.adminTitle : '-'}</td>
                            <td>
                                <c:if test="${not empty m.adminOrganization}">${m.adminOrganization}</c:if>
                                <c:if test="${not empty m.adminDepartment}"> / ${m.adminDepartment}</c:if>
                                <c:if test="${empty m.adminOrganization and empty m.adminDepartment}">-</c:if>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty m.adminPermissionCode}">
                                        <span class="adm-badge adm-badge-blue">${m.adminPermissionCode}</span>
                                    </c:when>
                                    <c:otherwise><span style="color:#94a3b8;">미설정</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${m.accountStatus == 'ACTIVE'}"><span class="adm-badge adm-badge-green">활성</span></c:when>
                                    <c:when test="${m.accountStatus == 'BLOCKED'}"><span class="adm-badge adm-badge-red">차단</span></c:when>
                                    <c:otherwise><span class="adm-badge">${m.accountStatus}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td><fmt:formatDate value="${m.createdAtDate}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <div style="display:flex;gap:6px;">
                                    <button class="adm-btn adm-btn-sm adm-btn-ghost"
                                            data-id="${m.userIdx}"
                                            onclick="openDetailModal(this.getAttribute('data-id'))">권한</button>
                                    <a class="adm-btn adm-btn-sm adm-btn-ghost"
                                       href="${pageContext.request.contextPath}/superAdmin/members/${m.userIdx}/edit">편집</a>
                                    <button class="adm-btn adm-btn-sm adm-btn-danger"
                                            data-id="${m.userIdx}"
                                            data-nickname="${m.nickname}"
                                            onclick="revokeAdmin(this.getAttribute('data-id'), this.getAttribute('data-nickname'))">해제</button>
                                </div>
                            </td>
                        </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <%-- 페이징 --%>
    <c:if test="${totalPage > 1}">
        <div class="adm-pagination">
            <c:forEach begin="1" end="${totalPage}" var="p">
                <a class="adm-page-btn ${p == search.page ? 'active' : ''}"
                   href="?page=${p}&keyword=${search.keyword}&searchType=${search.searchType}">${p}</a>
            </c:forEach>
        </div>
    </c:if>
</div>

<%-- ══════════════════════════════════════════
     상세 / 권한 모달
══════════════════════════════════════════ --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal" style="width:680px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="detailModalTitle">관리자 상세</div>
            <button class="adm-modal-close" onclick="closeModal('detailModal')">✕</button>
        </div>
        <div class="adm-modal-body" id="detailModalBody" style="max-height:70vh;overflow-y:auto;">
            <div style="text-align:center;padding:40px;color:#94a3b8;">불러오는 중...</div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('detailModal')">닫기</button>
            <button class="adm-btn adm-btn-primary" id="savePermBtn" onclick="savePermissions()">권한 저장</button>
        </div>
    </div>
</div>

<%-- ══════════════════════════════════════════
     관리자 등록 모달
══════════════════════════════════════════ --%>
<div class="adm-modal-overlay" id="grantModal">
    <div class="adm-modal" style="width:520px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title">관리자 등록</div>
            <button class="adm-modal-close" onclick="closeModal('grantModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div style="display:flex;gap:8px;margin-bottom:16px;">
                <input class="adm-input" id="grantSearchInput" type="text" placeholder="아이디 또는 닉네임 검색...">
                <button class="adm-btn adm-btn-primary" onclick="searchUsers()">검색</button>
            </div>
            <div id="grantSearchResult"></div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeModal('grantModal')">닫기</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentUserIdx = null;
let allPolicies = [];

function openDetailModal(userIdx) {
    currentUserIdx = userIdx;
    document.getElementById('detailModal').classList.add('open');
    document.getElementById('detailModalBody').innerHTML = '<div style="text-align:center;padding:40px;color:#94a3b8;">불러오는 중...</div>';

    fetch(CTX + '/superAdmin/members/' + userIdx)
        .then(r => r.json())
        .then(data => {
            allPolicies = data.permissionPolicies;
            renderDetailModal(data.member, data.permissionPolicies);
        });
}

function renderDetailModal(m, policies) {
    const activeCodes = (m.permissions || []).map(p => p.permissionCode);
    document.getElementById('detailModalTitle').textContent = m.nickname + ' 상세';

    let permHtml = policies.map(p => `
        <label class="sa-perm-item">
            <input type="checkbox" name="permissionCodes" value="${p.permissionCode}"
                   ${activeCodes.includes(p.permissionCode) ? 'checked' : ''}>
            <span class="sa-perm-name">${p.displayName}</span>
            <span class="sa-perm-code">${p.permissionCode}</span>
        </label>
    `).join('');

    document.getElementById('detailModalBody').innerHTML = `
        <div class="sa-detail-grid">
            <div class="sa-detail-row"><span class="sa-detail-label">닉네임</span><span>${m.nickname}</span></div>
            <div class="sa-detail-row"><span class="sa-detail-label">아이디</span><span>${m.userId || '-'}</span></div>
            <div class="sa-detail-row"><span class="sa-detail-label">이메일</span><span>${m.userEmail || '-'}</span></div>
            <div class="sa-detail-row"><span class="sa-detail-label">직함</span><span>${m.adminTitle || '-'}</span></div>
            <div class="sa-detail-row"><span class="sa-detail-label">소속 조직</span><span>${m.adminOrganization || '-'}</span></div>
            <div class="sa-detail-row"><span class="sa-detail-label">부서</span><span>${m.adminDepartment || '-'}</span></div>
            <div class="sa-detail-row"><span class="sa-detail-label">팀</span><span>${m.adminTeam || '-'}</span></div>
        </div>
        <div class="sa-section-title">보유 권한</div>
        <div class="sa-perm-list">${permHtml}</div>
    `;
}

function savePermissions() {
    const checked = [...document.querySelectorAll('input[name="permissionCodes"]:checked')]
                        .map(el => el.value);
    const params = new URLSearchParams();
    checked.forEach(c => params.append('permissionCodes', c));

    fetch(CTX + '/superAdmin/members/' + currentUserIdx + '/permissions', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            adm_toast('권한이 저장되었습니다.');
            closeModal('detailModal');
            location.reload();
        } else {
            adm_toast(data.message || '저장 실패', 'error');
        }
    });
}

function revokeAdmin(userIdx, nickname) {
    if (!confirm(nickname + ' 관리자를 해제하시겠습니까?\n보유 권한이 모두 회수됩니다.')) return;
    fetch(CTX + '/superAdmin/members/revoke', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'userIdx=' + userIdx
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('관리자가 해제되었습니다.'); location.reload(); }
        else adm_toast(data.message || '해제 실패', 'error');
    });
}

function openGrantModal() {
    document.getElementById('grantSearchResult').innerHTML = '';
    document.getElementById('grantSearchInput').value = '';
    document.getElementById('grantModal').classList.add('open');
}

function searchUsers() {
    const keyword = document.getElementById('grantSearchInput').value.trim();
    if (!keyword) return;
    fetch(CTX + '/superAdmin/users/search?keyword=' + encodeURIComponent(keyword) + '&pageSize=10')
        .then(r => r.json())
        .then(data => {
            if (!data.users || data.users.length === 0) {
                document.getElementById('grantSearchResult').innerHTML = '<div style="color:#94a3b8;text-align:center;padding:20px;">검색 결과가 없습니다.</div>';
                return;
            }
            document.getElementById('grantSearchResult').innerHTML = data.users.map(u => `
                <div class="sa-user-row">
                    <div>
                        <div style="font-weight:600;">${u.nickname}</div>
                        <div style="font-size:12px;color:#94a3b8;">${u.userId || ''}</div>
                    </div>
                    <button class="adm-btn adm-btn-sm adm-btn-primary"
                            data-id="${u.userIdx}" data-nickname="${u.nickname}"
                            onclick="grantAdmin(this.getAttribute('data-id'), this.getAttribute('data-nickname'))">등록</button>
                </div>
            `).join('');
        });
}

function grantAdmin(userIdx, nickname) {
    if (!confirm(nickname + ' 을(를) 관리자로 등록하시겠습니까?')) return;
    fetch(CTX + '/superAdmin/members/grant', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'userIdx=' + userIdx
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast('관리자로 등록되었습니다.'); closeModal('grantModal'); location.reload(); }
        else adm_toast(data.message || '등록 실패', 'error');
    });
}

function closeModal(id) {
    document.getElementById(id).classList.remove('open');
}
</script>

<%@ include file="../layout-close.jsp" %>
