<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
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
                                       value="${fn:escapeXml(search.keyword)}" placeholder="검색어 입력...">
                            </div>
                        </div>
                    </div>
                    <div style="flex:0 0 auto;">
                        <div class="adm-filter-label">부서</div>
                        <select class="adm-select" name="filterDepartment" style="width:140px;">
                            <option value="">전체</option>
                            <c:forEach var="dept" items="${['커뮤니티운영팀','여행서비스팀','고객지원팀','플랫폼개발팀','인프라팀','AI팀','마케팅팀','재무팀','인사팀','법무팀','사업개발팀','보안팀','개인정보보호팀']}">
                                <option value="${dept}" <c:if test="${search.filterDepartment == dept}">selected</c:if>>${dept}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div style="flex:0 0 auto;">
                        <div class="adm-filter-label">실효권한</div>
                        <select class="adm-select" name="filterPermissionCode" style="width:140px;">
                            <option value="">전체</option>
                            <c:forEach var="pc" items="${permissionCodePolicies}">
                                <option value="${fn:escapeXml(pc.adminPermissionCode)}" <c:if test="${search.filterPermissionCode == pc.adminPermissionCode}">selected</c:if>>${fn:escapeXml(pc.displayName)}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div style="flex:0 0 auto;">
                        <div class="adm-filter-label">계정상태</div>
                        <select class="adm-select" name="filterAccountStatus" style="width:110px;">
                            <option value="">전체</option>
                            <option value="ACTIVE"  <c:if test="${search.filterAccountStatus == 'ACTIVE'}">selected</c:if>>ACTIVE</option>
                            <option value="BLOCKED" <c:if test="${search.filterAccountStatus == 'BLOCKED'}">selected</c:if>>BLOCKED</option>
                            <option value="DORMANT" <c:if test="${search.filterAccountStatus == 'DORMANT'}">selected</c:if>>DORMANT</option>
                            <option value="DELETED" <c:if test="${search.filterAccountStatus == 'DELETED'}">selected</c:if>>DELETED</option>
                        </select>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:8px;">
                        <button type="submit" class="adm-btn adm-btn-primary">검색</button>
                        <a href="${pageContext.request.contextPath}/superAdmin/members" class="adm-btn adm-btn-ghost">초기화</a>
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
                        <th style="width:40px;text-align:center;">
                            <input type="checkbox" class="sa-cb" id="cbAll" onclick="toggleAll(this)">
                        </th>
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
                        <tr><td colspan="9" style="text-align:center;padding:40px;color:#94a3b8;">등록된 관리자가 없습니다.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="m" items="${adminList}">
                        <tr>
                            <td style="text-align:center;">
                                <input type="checkbox" class="sa-cb row-cb"
                                       data-idx="${m.userIdx}" data-nickname="${m.nickname}"
                                       onchange="onRowCbChange()">
                            </td>
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
        <div class="adm-paging">
            <c:forEach begin="1" end="${totalPage}" var="p">
                <a class="adm-page-btn ${p == search.page ? 'active' : ''}"
                   href="?page=${p}&keyword=${fn:escapeXml(search.keyword)}&searchType=${search.searchType}&filterDepartment=${fn:escapeXml(search.filterDepartment)}&filterPermissionCode=${fn:escapeXml(search.filterPermissionCode)}&filterAccountStatus=${fn:escapeXml(search.filterAccountStatus)}">${p}</a>
            </c:forEach>
        </div>
    </c:if>
</div>


<%-- ══════════════════════════════════════════
     일괄 처리 액션바
══════════════════════════════════════════ --%>
<div class="sa-bulk-bar sa-bulk-hidden" id="bulkBar">
    <span class="sa-bulk-count" id="bulkCount">0명</span> 선택됨
    <button class="adm-btn adm-btn-sm adm-btn-primary" onclick="openBulkPermModal()">권한 일괄 설정</button>
    <button class="adm-btn adm-btn-sm adm-btn-danger"  onclick="bulkRevoke()">관리자 해제</button>
    <button class="adm-btn adm-btn-sm adm-btn-ghost"   onclick="clearSelection()" style="color:#94a3b8;">취소</button>
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
        <div class="adm-modal-body" style="max-height:70vh;overflow-y:auto;">
            <div class="sa-tabs">
                <button class="sa-tab-btn active" onclick="switchTab('info',this)">정보 / 권한</button>
                <button class="sa-tab-btn"        onclick="switchTab('audit',this)">변경 이력</button>
            </div>
            <div class="sa-tab-panel active" id="tabInfo">
                <div id="detailModalBody">
                    <div style="text-align:center;padding:40px;color:#94a3b8;">불러오는 중...</div>
                </div>
            </div>
            <div class="sa-tab-panel" id="tabAudit">
                <div id="auditBody">
                    <div style="text-align:center;padding:40px;color:#94a3b8;">불러오는 중...</div>
                </div>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"   onclick="closeModal('detailModal')">닫기</button>
            <button class="adm-btn adm-btn-primary"  id="savePermBtn" onclick="savePermissions()">권한 저장</button>
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

<%-- ══════════════════════════════════════════
     일괄 권한 설정 모달
══════════════════════════════════════════ --%>
<div class="adm-modal-overlay" id="bulkPermModal">
    <div class="adm-modal" style="width:520px;max-width:95vw;">
        <div class="adm-modal-head">
            <div class="adm-modal-title">권한 일괄 설정</div>
            <button class="adm-modal-close" onclick="closeModal('bulkPermModal')">✕</button>
        </div>
        <div class="adm-modal-body">
            <div style="font-size:13px;color:#64748b;margin-bottom:12px;">
                선택된 관리자 전체에 동일한 권한 세트를 적용합니다.<br>
                기존 권한은 모두 초기화됩니다.
            </div>
            <div id="bulkPermList"></div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost"   onclick="closeModal('bulkPermModal')">취소</button>
            <button class="adm-btn adm-btn-primary"  onclick="saveBulkPermissions()">일괄 저장</button>
        </div>
    </div>
</div>

<script>
const CTX = '${pageContext.request.contextPath}';
let currentUserIdx  = null;
let allPolicies     = [];
let activeCodes     = [];

const GROUP_LIST = [
<c:forEach var="g" items="${groupList}"><c:if test="${g.active}">{code:'${fn:escapeXml(g.groupCode)}',name:'${fn:escapeXml(g.displayName)}'},
</c:if></c:forEach>
];

function buildGroupAssignSection(adminGroups) {
    if (GROUP_LIST.length === 0) return '';
    var currentCodes = (adminGroups || []).map(function(g){ return g.groupCode; });
    var currentHtml = (adminGroups && adminGroups.length > 0)
        ? adminGroups.map(function(g){
            return '<div style="display:flex;align-items:center;gap:8px;margin-bottom:6px;">' +
                '<span class="adm-badge adm-badge-green" style="font-size:12px;">' + g.displayName + '</span>' +
                '<button class="adm-btn adm-btn-sm adm-btn-danger" ' +
                    'data-gcode="' + g.groupCode + '" ' +
                    'onclick="revokeGroup(this.getAttribute(\'data-gcode\'))">해제</button>' +
                '</div>';
          }).join('')
        : '<div style="color:#94a3b8;font-size:13px;margin-bottom:8px;">소속 그룹 없음</div>';

    var assignableGroups = GROUP_LIST.filter(function(g){ return !currentCodes.includes(g.code); });
    var assignHtml = assignableGroups.length > 0
        ? '<div style="display:flex;gap:8px;margin-top:8px;">' +
          '<select class="adm-select" id="grpAssignSel" style="flex:1;">' +
          '<option value="">-- 그룹 배정 --</option>' +
          assignableGroups.map(function(g){ return '<option value="' + g.code + '">' + g.name + '</option>'; }).join('') +
          '</select>' +
          '<button class="adm-btn adm-btn-primary" onclick="assignGroup()">배정</button>' +
          '</div>'
        : '';

    return '<div class="sa-section-title">소속 그룹</div>' +
           '<div id="adminGroupList">' + currentHtml + '</div>' + assignHtml;
}

function assignGroup() {
    var sel = document.getElementById('grpAssignSel');
    if (!sel || !sel.value) { adm_toast('그룹을 선택하세요.', 'error'); return; }
    fetch(CTX + '/superAdmin/members/' + currentUserIdx + '/groups/assign', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'groupCode=' + encodeURIComponent(sel.value)
    })
    .then(function(r){ return r.json(); })
    .then(function(data){
        if (data.success) { adm_toast('그룹이 배정되었습니다.'); reloadDetailModal(); }
        else adm_toast(data.message || '배정 실패', 'error');
    });
}

function revokeGroup(groupCode) {
    if (!confirm('이 그룹에서 해제하시겠습니까?')) return;
    fetch(CTX + '/superAdmin/members/' + currentUserIdx + '/groups/revoke', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: 'groupCode=' + encodeURIComponent(groupCode)
    })
    .then(function(r){ return r.json(); })
    .then(function(data){
        if (data.success) { adm_toast('그룹에서 해제되었습니다.'); reloadDetailModal(); }
        else adm_toast(data.message || '해제 실패', 'error');
    });
}

function reloadDetailModal() {
    fetch(CTX + '/superAdmin/members/' + currentUserIdx)
        .then(function(r){ return r.json(); })
        .then(function(data){
            allPolicies = data.permissionPolicies;
            activeCodes = (data.member.permissions || []).map(function(p){ return p.permissionCode; });
            renderDetailModal(data.member, data.permissionPolicies, data.adminGroups);
        });
}

/* ── 탭 전환 ── */
function switchTab(tab, btn) {
    document.querySelectorAll('.sa-tab-btn').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.sa-tab-panel').forEach(p => p.classList.remove('active'));
    btn.classList.add('active');
    document.getElementById('tab' + tab.charAt(0).toUpperCase() + tab.slice(1)).classList.add('active');

    if (tab === 'info') {
        document.getElementById('savePermBtn').style.display = '';
    } else {
        document.getElementById('savePermBtn').style.display = 'none';
        loadAuditLog();
    }
}

/* ── 상세 모달 열기 ── */
function openDetailModal(userIdx) {
    currentUserIdx = userIdx;
    activeCodes    = [];
    document.getElementById('detailModal').classList.add('open');
    document.getElementById('detailModalBody').innerHTML = '<div style="text-align:center;padding:40px;color:#94a3b8;">불러오는 중...</div>';
    document.getElementById('auditBody').innerHTML       = '<div style="text-align:center;padding:40px;color:#94a3b8;">불러오는 중...</div>';
    document.getElementById('savePermBtn').style.display = '';
    document.querySelectorAll('.sa-tab-btn').forEach((b,i) => b.classList.toggle('active', i===0));
    document.querySelectorAll('.sa-tab-panel').forEach((p,i) => p.classList.toggle('active', i===0));

    fetch(CTX + '/superAdmin/members/' + userIdx)
        .then(r => r.json())
        .then(data => {
            allPolicies = data.permissionPolicies;
            activeCodes = (data.member.permissions || []).map(p => p.permissionCode);
            renderDetailModal(data.member, data.permissionPolicies, data.adminGroups);
        });
}

function renderDetailModal(m, policies, adminGroups) {
    document.getElementById('detailModalTitle').textContent = (m.nickname || '') + ' 상세';

    // 권한별 소스 맵 구성
    var sourceMap = {};
    (m.permissions || []).forEach(function(p) {
        if (!sourceMap[p.permissionCode]) sourceMap[p.permissionCode] = { isDirect: false, groupSources: [] };
        if (p.permissionSource === 'DIRECT') {
            sourceMap[p.permissionCode].isDirect = true;
        } else {
            var label = p.sourceGroupCode || p.permissionSource;
            if (label && !sourceMap[p.permissionCode].groupSources.includes(label))
                sourceMap[p.permissionCode].groupSources.push(label);
        }
    });

    activeCodes = Object.keys(sourceMap).filter(function(code) { return sourceMap[code].isDirect; });

    var permHtml = policies.map(function(p) {
        var info = sourceMap[p.permissionCode];
        var hasGroup = info && info.groupSources.length > 0;
        var isDirect = info && info.isDirect;
        var sourceLabel = hasGroup ? ('그룹: ' + info.groupSources.join(', ')) : '';

        if (hasGroup && !isDirect) {
            // 그룹에서만 부여 → disabled
            return '<label class="sa-perm-item sa-perm-from-group">' +
                '<input type="checkbox" disabled checked>' +
                '<span class="sa-perm-name">' + (p.displayName || '') + '</span>' +
                '<span class="sa-perm-code">' + (p.permissionCode || '') + '</span>' +
                '<span class="sa-perm-source">' + sourceLabel + '</span>' +
                '</label>';
        } else {
            return '<label class="sa-perm-item">' +
                '<input type="checkbox" name="permissionCodes" value="' + p.permissionCode + '"' +
                (isDirect ? ' checked' : '') + '>' +
                '<span class="sa-perm-name">' + (p.displayName || '') + '</span>' +
                '<span class="sa-perm-code">' + (p.permissionCode || '') + '</span>' +
                (hasGroup ? '<span class="sa-perm-source">' + sourceLabel + ' + 직접</span>' : '') +
                '</label>';
        }
    }).join('');

    document.getElementById('detailModalBody').innerHTML =
        '<div class="sa-detail-grid">' +
            '<div class="sa-detail-row"><span class="sa-detail-label">닉네임</span><span>' + (m.nickname || '') + '</span></div>' +
            '<div class="sa-detail-row"><span class="sa-detail-label">아이디</span><span>' + (m.userId || '-') + '</span></div>' +
            '<div class="sa-detail-row"><span class="sa-detail-label">이메일</span><span>' + (m.userEmail || '-') + '</span></div>' +
            '<div class="sa-detail-row"><span class="sa-detail-label">직함</span><span>' + (m.adminTitle || '-') + '</span></div>' +
            '<div class="sa-detail-row"><span class="sa-detail-label">소속 조직</span><span>' + (m.adminOrganization || '-') + '</span></div>' +
            '<div class="sa-detail-row"><span class="sa-detail-label">부서</span><span>' + (m.adminDepartment || '-') + '</span></div>' +
            '<div class="sa-detail-row"><span class="sa-detail-label">팀</span><span>' + (m.adminTeam || '-') + '</span></div>' +
        '</div>' +
        buildGroupAssignSection(adminGroups) +
        '<div class="sa-section-title" style="margin-top:16px;">보유 권한</div>' +
        '<div style="font-size:12px;color:#94a3b8;margin-bottom:8px;">그룹 소속 권한(보라색)은 그룹 해제로만 제거할 수 있습니다.</div>' +
        '<div class="sa-perm-list">' + permHtml + '</div>';
}

/* ── 이력 로드 ── */
function loadAuditLog() {
    if (!currentUserIdx) return;
    fetch(CTX + '/superAdmin/members/' + currentUserIdx + '/audit')
        .then(r => r.json())
        .then(data => {
            var html = '';

            // 그룹 배정 이력
            var gLogs = data.groupLogs || [];
            if (gLogs.length > 0) {
                var gRows = gLogs.map(function(l) {
                    var status = l.active
                        ? '<span class="sa-status-active">활성</span>'
                        : '<span class="sa-status-inactive">해제</span>';
                    var at = l.grantedAt ? new Date(l.grantedAt).toLocaleString('ko-KR') : '-';
                    return '<tr>' +
                        '<td><span class="sa-perm-code" style="background:#d1fae5;color:#065f46;border-radius:4px;padding:1px 6px;">' + (l.groupCode || '') + '</span></td>' +
                        '<td>' + (l.displayName || '-') + '</td>' +
                        '<td>' + status + '</td>' +
                        '<td>' + (l.grantedByNickname || '-') + '</td>' +
                        '<td style="font-size:12px;color:#94a3b8;">' + at + '</td>' +
                        '</tr>';
                }).join('');
                html += '<div class="sa-section-title" style="margin-bottom:8px;">그룹 배정 이력</div>' +
                    '<table class="sa-audit-table" style="margin-bottom:20px;">' +
                    '<thead><tr><th>그룹코드</th><th>그룹명</th><th>상태</th><th>처리자</th><th>일시</th></tr></thead>' +
                    '<tbody>' + gRows + '</tbody></table>';
            }

            // 직접 권한 이력
            var pLogs = (data.logs || []).filter(function(l) { return l.grantedByNickname || l.active; });
            if (pLogs.length > 0) {
                var pRows = pLogs.map(function(l) {
                    var status = l.active
                        ? '<span class="sa-status-active">활성</span>'
                        : '<span class="sa-status-inactive">비활성</span>';
                    var grantedBy = l.grantedByNickname || '-';
                    var updatedAt = l.updatedAt ? new Date(l.updatedAt).toLocaleString('ko-KR') : '-';
                    return '<tr>' +
                        '<td><span class="sa-perm-code" style="background:#e0e7ff;color:#4338ca;border-radius:4px;padding:1px 6px;">' + (l.permissionCode || '') + '</span></td>' +
                        '<td>' + (l.displayName || '-') + '</td>' +
                        '<td>' + status + '</td>' +
                        '<td>' + grantedBy + '</td>' +
                        '<td style="font-size:12px;color:#94a3b8;">' + updatedAt + '</td>' +
                        '</tr>';
                }).join('');
                html += '<div class="sa-section-title" style="margin-bottom:8px;">직접 권한 이력</div>' +
                    '<table class="sa-audit-table">' +
                    '<thead><tr><th>코드</th><th>권한명</th><th>상태</th><th>처리자</th><th>일시</th></tr></thead>' +
                    '<tbody>' + pRows + '</tbody></table>';
            }

            document.getElementById('auditBody').innerHTML = html ||
                '<div style="text-align:center;padding:40px;color:#94a3b8;">변경 이력이 없습니다.</div>';
        });
}

/* ── 권한 저장 (직접) ── */
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
        if (data.success) { adm_toast('권한이 저장되었습니다.'); closeModal('detailModal'); location.reload(); }
        else adm_toast(data.message || '저장 실패', 'error');
    });
}

/* ── 관리자 해제 ── */
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

/* ── 관리자 등록 모달 ── */
function openGrantModal() {
    document.getElementById('grantSearchResult').innerHTML = '';
    document.getElementById('grantSearchInput').value = '';
    document.getElementById('grantModal').classList.add('open');
    setTimeout(() => document.getElementById('grantSearchInput').focus(), 100);
}
document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('grantSearchInput').addEventListener('keydown', function (e) {
        if (e.key === 'Enter') searchUsers();
    });
});

function searchUsers() {
    const keyword = document.getElementById('grantSearchInput').value.trim();
    const resultEl = document.getElementById('grantSearchResult');
    if (!keyword) {
        resultEl.innerHTML = '<div style="color:#94a3b8;text-align:center;padding:20px;">검색어를 입력하세요.</div>';
        return;
    }
    resultEl.innerHTML = '<div style="text-align:center;padding:20px;color:#94a3b8;">검색 중...</div>';
    fetch(CTX + '/superAdmin/users/search?keyword=' + encodeURIComponent(keyword) + '&pageSize=20')
        .then(r => {
            if (!r.ok) throw new Error('HTTP ' + r.status);
            return r.json();
        })
        .then(data => {
            if (!data.users || data.users.length === 0) {
                resultEl.innerHTML = '<div style="color:#94a3b8;text-align:center;padding:20px;">검색 결과가 없습니다.</div>';
                return;
            }
            resultEl.innerHTML = data.users.map(function(u) {
                return '<div class="sa-user-row">' +
                    '<div>' +
                        '<div style="font-weight:600;">' + (u.nickname || '') + '</div>' +
                        '<div style="font-size:12px;color:#94a3b8;">' + (u.userId || '') + ' · ' + (u.userEmail || '') + '</div>' +
                    '</div>' +
                    '<button class="adm-btn adm-btn-sm adm-btn-primary"' +
                        ' data-id="' + u.userIdx + '"' +
                        ' data-nickname="' + (u.nickname || '') + '"' +
                        ' onclick="grantAdmin(this.getAttribute(\'data-id\'), this.getAttribute(\'data-nickname\'))">등록</button>' +
                '</div>';
            }).join('');
        })
        .catch(err => {
            resultEl.innerHTML = '<div style="color:#ef4444;text-align:center;padding:20px;">오류가 발생했습니다: ' + err.message + '</div>';
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

/* ── 일괄 처리 ── */
function toggleAll(cb) {
    document.querySelectorAll('.row-cb').forEach(el => el.checked = cb.checked);
    onRowCbChange();
}

function onRowCbChange() {
    const checked = document.querySelectorAll('.row-cb:checked');
    const bar     = document.getElementById('bulkBar');
    document.getElementById('cbAll').checked = (checked.length > 0 && checked.length === document.querySelectorAll('.row-cb').length);
    if (checked.length > 0) {
        document.getElementById('bulkCount').textContent = checked.length + '명';
        bar.classList.remove('sa-bulk-hidden');
    } else {
        bar.classList.add('sa-bulk-hidden');
    }
}

function clearSelection() {
    document.querySelectorAll('.row-cb').forEach(el => el.checked = false);
    document.getElementById('cbAll').checked = false;
    document.getElementById('bulkBar').classList.add('sa-bulk-hidden');
}

function getSelectedIdxList() {
    return [...document.querySelectorAll('.row-cb:checked')].map(el => el.getAttribute('data-idx'));
}

function bulkRevoke() {
    const list = getSelectedIdxList();
    if (list.length === 0) return;
    if (!confirm(list.length + '명의 관리자를 해제하시겠습니까?\n모든 권한이 회수됩니다.')) return;

    const params = new URLSearchParams();
    list.forEach(idx => params.append('userIdxList', idx));

    fetch(CTX + '/superAdmin/members/bulk-revoke', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(list.length + '명이 해제되었습니다.'); location.reload(); }
        else adm_toast(data.message || '해제 실패', 'error');
    });
}

function openBulkPermModal() {
    const list = getSelectedIdxList();
    if (list.length === 0) return;
    var permHtml = allPolicies.length > 0
        ? allPolicies.map(function(p) {
            return '<label class="sa-perm-item">' +
                '<input type="checkbox" name="bulkPermCodes" value="' + p.permissionCode + '">' +
                '<span class="sa-perm-name">' + (p.displayName || '') + '</span>' +
                '<span class="sa-perm-code">' + (p.permissionCode || '') + '</span>' +
                '</label>';
          }).join('')
        : '<div style="color:#94a3b8;text-align:center;padding:20px;">권한 정책이 없습니다.</div>';

    // allPolicies가 비어있으면 서버에서 불러오기
    if (allPolicies.length === 0) {
        fetch(CTX + '/superAdmin/members/1') // 임시 any user call to get policies
            .then(r => r.json())
            .then(data => {
                allPolicies = data.permissionPolicies || [];
                openBulkPermModal();
            });
        return;
    }
    document.getElementById('bulkPermList').innerHTML = buildGroupSelect('bulkPermCodes') + '<div class="sa-perm-list">' + permHtml + '</div>';
    document.getElementById('bulkPermModal').classList.add('open');
}

function saveBulkPermissions() {
    const userIdxList = getSelectedIdxList();
    const codes = [...document.querySelectorAll('input[name="bulkPermCodes"]:checked')].map(el => el.value);
    const params = new URLSearchParams();
    userIdxList.forEach(idx => params.append('userIdxList', idx));
    codes.forEach(c => params.append('permissionCodes', c));

    fetch(CTX + '/superAdmin/members/bulk-permissions', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) { adm_toast(userIdxList.length + '명의 권한이 업데이트되었습니다.'); closeModal('bulkPermModal'); clearSelection(); location.reload(); }
        else adm_toast(data.message || '저장 실패', 'error');
    });
}

function closeModal(id) {
    document.getElementById(id).classList.remove('open');
}
</script>


<%@ include file="../layout-close.jsp" %>
