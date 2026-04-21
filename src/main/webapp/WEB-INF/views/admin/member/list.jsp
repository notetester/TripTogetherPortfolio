<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="members"/>
<c:set var="pageTitle"  value="회원 관리"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ══════════════════════════════════════════
         검색 / 필터 바
    ══════════════════════════════════════════ --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form id="searchForm" method="get" action="${pageContext.request.contextPath}/admin/members">
                <div class="adm-filter-bar">

                    <%-- 키워드 검색 --%>
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

                    <%-- 상태 필터 --%>
                    <div>
                        <div class="adm-filter-label">계정 상태</div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ? 'selected' : ''}>전체</option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ? 'selected' : ''}>활성</option>
                            <option value="DORMANT" ${search.status=='DORMANT' ? 'selected' : ''}>휴면</option>
                            <option value="DELETED" ${search.status=='DELETED' ? 'selected' : ''}>탈퇴</option>
                            <option value="BLOCKED" ${search.status=='BLOCKED' ? 'selected' : ''}>차단</option>
                        </select>
                    </div>

                    <%-- 권한 필터 --%>
                    <div>
                        <div class="adm-filter-label">권한</div>
                        <select class="adm-select" name="role">
                            <option value="ALL"   ${search.role=='ALL'   ? 'selected' : ''}>전체</option>
                            <option value="USER"  ${search.role=='USER'  ? 'selected' : ''}>일반</option>
                            <option value="BUSINESS" ${search.role=='BUSINESS' ? 'selected' : ''}>비즈니스</option>
                            <option value="PARTNER"  ${search.role=='PARTNER'  ? 'selected' : ''}>파트너</option>
                            <option value="BOT"      ${search.role=='BOT'      ? 'selected' : ''}>봇</option>
                            <option value="ADMIN" ${search.role=='ADMIN' ? 'selected' : ''}>관리자</option>
                        </select>
                    </div>

                    <%-- 소셜 필터 --%>
                    <div>
                        <div class="adm-filter-label">소셜 연동</div>
                        <select class="adm-select" name="provider">
                            <option value="ALL"    ${search.provider=='ALL'    ? 'selected' : ''}>전체</option>
                            <option value="KAKAO"  ${search.provider=='KAKAO'  ? 'selected' : ''}>카카오</option>
                            <option value="NAVER"  ${search.provider=='NAVER'  ? 'selected' : ''}>네이버</option>
                            <option value="GOOGLE" ${search.provider=='GOOGLE' ? 'selected' : ''}>Google</option>
                            <option value="NONE"   ${search.provider=='NONE'   ? 'selected' : ''}>연동 없음</option>
                        </select>
                    </div>

                    <%-- 가입일 범위 --%>
                    <div>
                        <div class="adm-filter-label">가입일</div>
                        <div style="display:flex;gap:4px;align-items:center;">
                            <input class="adm-input" type="date" name="dateFrom"
                                   value="${search.dateFrom}" style="width:130px;">
                            <span style="color:#475569;font-size:12px;">~</span>
                            <input class="adm-input" type="date" name="dateTo"
                                   value="${search.dateTo}" style="width:130px;">
                        </div>
                    </div>

                    <%-- 정렬 --%>
                    <div>
                        <div class="adm-filter-label">정렬</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="sortBy">
                                <option value="createdAt"   ${search.sortBy=='createdAt'   ? 'selected' : ''}>가입일</option>
                                <option value="lastLoginAt" ${search.sortBy=='lastLoginAt' ? 'selected' : ''}>최근 로그인</option>
                                <option value="nickname"    ${search.sortBy=='nickname'    ? 'selected' : ''}>닉네임</option>
                            </select>
                            <select class="adm-select" name="sortDir">
                                <option value="DESC" ${search.sortDir=='DESC' ? 'selected' : ''}>내림차순</option>
                                <option value="ASC"  ${search.sortDir=='ASC'  ? 'selected' : ''}>오름차순</option>
                            </select>
                        </div>
                    </div>

                    <%-- 버튼 --%>
                    <div style="display:flex;gap:6px;align-items:flex-end;">
                        <button type="submit" class="adm-btn adm-btn-primary">🔍 검색</button>
                        <a href="${pageContext.request.contextPath}/admin/members"
                           class="adm-btn adm-btn-ghost">초기화</a>
                    </div>

                    <input type="hidden" name="page" value="1">
                    <input type="hidden" name="size" value="${search.size}">
                </div>
            </form>
        </div>
    </div>

    <%-- ══════════════════════════════════════════
         회원 목록 테이블
    ══════════════════════════════════════════ --%>
    <div class="adm-card" style="overflow:visible;">
        <div class="adm-card-head">
            <div class="adm-card-title">
                👥 회원 목록
                <span style="font-size:12px;font-weight:400;color:#475569;">
                    총 <strong style="color:#93c5fd;">${total}</strong>명
                </span>
            </div>
            <select class="adm-select" style="width:80px;" id="sizeSelect"
                    onchange="changeSize(this.value)">
                <option value="10"  ${search.size==10  ? 'selected' : ''}>10</option>
                <option value="20"  ${search.size==20  ? 'selected' : ''}>20</option>
                <option value="50"  ${search.size==50  ? 'selected' : ''}>50</option>
                <option value="100" ${search.size==100 ? 'selected' : ''}>100</option>
            </select>
        </div>

        <div class="adm-table-wrap" style="overflow:visible;">
            <table class="adm-table">
                <thead>
                <tr>
                    <th>회원</th>
                    <th>이메일</th>
                    <th>상태</th>
                    <th>권한</th>
                    <th>소셜</th>
                    <th>로그인</th>
                    <th>가입일</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="m">
                    <tr>
                        <%-- 회원 정보 --%>
                        <td>
                            <div class="mem-id-cell">
                                <div class="mem-av ${m.accountStatus == 'DORMANT' ? 'dormant' : m.accountStatus == 'DELETED' ? 'deleted' : ''}">
                                    ${m.nickname.substring(0,1)}
                                </div>
                                <div>
                                    <div class="mem-name">${m.nickname}</div>
                                    <div style="font-size:10px;color:#94a3b8;margin-top:2px;">${m.memberGrade} · Lv.${m.levelNo}</div>
                                    <div class="mem-uid">
                                        <c:choose>
                                            <c:when test="${not empty m.userId}">@${m.userId}</c:when>
                                            <c:otherwise><span style="color:#475569;">소셜 전용</span></c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </td>

                        <%-- 이메일 --%>
                        <td>
                            <c:choose>
                                <c:when test="${not empty m.userEmail}">
                                    <span style="font-size:12px;">${m.userEmail}</span>
                                    <c:if test="${m.emailVerified}">
                                        <span style="color:#4ade80;font-size:10px;"> ✓</span>
                                    </c:if>
                                </c:when>
                                <c:otherwise><span style="color:#475569;font-size:12px;">—</span></c:otherwise>
                            </c:choose>
                            <div style="font-size:10px;color:${m.verifiedMember ? '#4ade80' : '#64748b'};margin-top:2px;">
                                ${m.verifiedMember ? '인증 회원' : '비인증 회원'}
                            </div>
                        </td>

                        <%-- 상태 --%>
                        <td>
                            <span class="status-badge ${m.accountStatus}">${m.accountStatus}</span>
                        </td>

                        <%-- 권한 --%>
                        <td>
                            <span class="role-badge ${m.userRole}">
                                <c:choose>
                                    <c:when test="${m.userRole eq 'USER'}">일반</c:when>
                                    <c:when test="${m.userRole eq 'BUSINESS'}">비즈니스</c:when>
                                    <c:when test="${m.userRole eq 'PARTNER'}">파트너</c:when>
                                    <c:when test="${m.userRole eq 'BOT'}">봇</c:when>
                                    <c:when test="${m.userRole eq 'ADMIN'}">관리자</c:when>
                                    <c:when test="${m.userRole eq 'SUPERADMIN'}">최고관리자</c:when>
                                    <c:when test="${m.userRole eq 'SYSTEM'}">시스템</c:when>
                                    <c:otherwise>${m.userRole}</c:otherwise>
                                </c:choose>
                            </span>
                            <c:if test="${not empty m.adminPositionCode}">
                                <div style="font-size:10px;color:#94a3b8;margin-top:2px;">${m.adminPositionCode}</div>
                            </c:if>
                        </td>

                        <%-- 소셜 연동 --%>
                        <td>
                            <div class="social-icons">
                                <c:if test="${m.linkedProviders != null && m.linkedProviders.contains('KAKAO')}">
                                    <div class="social-icon-sm K" title="카카오">k</div>
                                </c:if>
                                <c:if test="${m.linkedProviders != null && m.linkedProviders.contains('NAVER')}">
                                    <div class="social-icon-sm N" title="네이버">N</div>
                                </c:if>
                                <c:if test="${m.linkedProviders != null && m.linkedProviders.contains('GOOGLE')}">
                                    <div class="social-icon-sm G" title="Google">G</div>
                                </c:if>
                                <c:if test="${empty m.linkedProviders}">
                                    <span style="color:#475569;font-size:12px;">—</span>
                                </c:if>
                            </div>
                        </td>

                        <%-- 로그인 이력 --%>
                        <td>
                            <div style="font-size:12px;">
                                <c:choose>
                                    <c:when test="${m.lastLoginAt != null}">
                                        <fmt:formatDate value="${m.lastLoginAt}" pattern="MM.dd HH:mm"/>
                                    </c:when>
                                    <c:otherwise><span style="color:#475569;">없음</span></c:otherwise>
                                </c:choose>
                            </div>
                            <div style="font-size:10px;color:#475569;margin-top:1px;">
                                ✅${m.loginSuccessCount} / ❌${m.loginFailCount}
                            </div>
                        </td>

                        <%-- 가입일 --%>
                        <td style="font-size:12px;color:#64748b;">
                            <fmt:formatDate value="${m.createdAt}" pattern="yyyy.MM.dd"/>
                        </td>

                        <%-- 액션 --%>
                        <td>
                            <div style="display:flex;gap:4px;align-items:center;">
                                <button class="adm-row-btn detail"
                                        onclick="openDetail(${m.userIdx})">상세</button>
                                <c:if test="${m.userRole != 'SYSTEM' and m.userRole != 'SUPERADMIN'}">
                                <div class="action-menu-wrap">
                                    <button class="adm-row-btn detail"
                                            onclick="toggleMenu(this)">⋯</button>
                                    <div class="action-menu">
                                        <div style="font-size:10px;color:#475569;padding:4px 10px 6px;
                                                    font-weight:700;text-transform:uppercase;letter-spacing:.06em;">
                                            상태 변경
                                        </div>
                                        <c:if test="${m.accountStatus != 'ACTIVE'}">
                                            <button class="action-menu-item"
                                                    onclick="changeStatus(${m.userIdx}, 'ACTIVE', this)">
                                                ✅ 활성화
                                            </button>
                                        </c:if>
                                        <c:if test="${m.accountStatus != 'DORMANT'}">
                                            <button class="action-menu-item"
                                                    onclick="changeStatus(${m.userIdx}, 'DORMANT', this)">
                                                😴 휴면 처리
                                            </button>
                                        </c:if>
                                        <c:if test="${m.accountStatus != 'BLOCKED'}">
                                            <button class="action-menu-item"
                                                    data-user-idx="${m.userIdx}"
                                                    data-nickname="${fn:escapeXml(m.nickname)}"
                                                    onclick="openBlockModal(this)">
                                                ⛔ 차단 처리
                                            </button>
                                        </c:if>
                                        <c:if test="${m.accountStatus != 'DELETED'}">
                                            <button class="action-menu-item danger"
                                                    onclick="changeStatus(${m.userIdx}, 'DELETED', this)">
                                                🗑️ 탈퇴 처리
                                            </button>
                                        </c:if>
                                        <div class="action-menu-sep"></div>
                                        <div style="font-size:10px;color:#475569;padding:4px 10px 6px;
                                                    font-weight:700;text-transform:uppercase;letter-spacing:.06em;">
                                            권한 변경
                                        </div>
                                        <div class="role-change-box">
                                            <select class="adm-select role-change-select" data-current-role="${m.userRole}">
                                                <option value="USER" ${m.userRole == 'USER' ? 'selected' : ''}>일반</option>
                                                <option value="BUSINESS" ${m.userRole == 'BUSINESS' ? 'selected' : ''}>비즈니스</option>
                                                <option value="PARTNER" ${m.userRole == 'PARTNER' ? 'selected' : ''}>파트너</option>
                                                <option value="BOT" ${m.userRole == 'BOT' ? 'selected' : ''}>봇</option>
                                                <option value="ADMIN" ${m.userRole == 'ADMIN' ? 'selected' : ''}>관리자</option>
                                            </select>
                                            <input class="adm-input role-change-reason"
                                                   type="text"
                                                   maxlength="500"
                                                   placeholder="변경 사유">
                                            <button class="action-menu-item role-change-submit"
                                                    data-user-idx="${m.userIdx}"
                                                    onclick="changeRoleFromMenu(this)">
                                                권한 변경 적용
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty list}">
                    <tr>
                        <td colspan="8" style="text-align:center;padding:40px;color:#475569;">
                            검색 결과가 없습니다.
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <%-- 페이징 --%>
        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}">
                    <button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button>
                </c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
                    <button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}"
                            onclick="goPage(${p})">${p}</button>
                </c:forEach>
                <c:if test="${paging.next}">
                    <button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button>
                </c:if>
                <span class="adm-page-info">${paging.currentPage} / ${paging.totalPage} 페이지</span>
            </div>
        </c:if>
    </div>
</div>

<%-- ══════════════════════════════════════════
     회원 상세 모달
══════════════════════════════════════════ --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="modalTitle">회원 상세</div>
            <button class="adm-modal-close" onclick="closeDetail()">✕</button>
        </div>
        <div class="adm-modal-body" id="modalBody">
            <div style="text-align:center;padding:40px;color:#475569;">불러오는 중...</div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeDetail()">닫기</button>
        </div>
    </div>
</div>


<div class="adm-modal-overlay" id="blockModal">
    <div class="adm-modal" style="max-width:520px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="blockModalTitle">회원 차단</div>
            <button class="adm-modal-close" onclick="closeBlockModal()">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="blockUserIdx">
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label">차단 유형</label>
                <select id="blockType" class="adm-select" style="width:100%;" onchange="handleBlockTypeChange()">
                    <option value="USER_ONLY">아이디 차단</option>
                    <option value="IP_ONLY">IP 차단</option>
                    <option value="USER_IP">아이디 + IP 차단</option>
                </select>
            </div>
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label">차단 IP (IP 차단 유형일 때 입력)</label>
                <input id="blockedIp" class="adm-input" type="text" placeholder="예: 203.0.113.10">
            </div>
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label">차단 만료 시각 (선택)</label>
                <input id="blockedUntil" class="adm-input" type="datetime-local">
            </div>
            <div class="form-group">
                <label class="form-label">차단 사유</label>
                <textarea id="blockedReason" class="adm-input" style="min-height:90px;resize:vertical;" placeholder="차단 사유를 입력하세요."></textarea>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeBlockModal()">닫기</button>
            <button id="blockSubmitBtn" class="adm-btn adm-btn-primary" type="button" onclick="submitBlock()">차단 적용</button>
        </div>
    </div>
</div>

<script>
const ctx = '${pageContext.request.contextPath}';

function escapeHtml(value) {
    if (value == null) return '';
    return String(value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
}

function formatNullable(value) {
    return value ? escapeHtml(value) : '<span style="color:#475569">—</span>';
}

function formatDateTime(value) {
    if (!value) return '—';

    const date = new Date(value);
    if (Number.isNaN(date.getTime())) return escapeHtml(value);

    return date.toLocaleString('ko-KR', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    });
}

function formatHistoryDateTime(value) {
    if (!value) return '—';

    const date = new Date(value);
    if (Number.isNaN(date.getTime())) return escapeHtml(value);

    return date.toLocaleString('ko-KR', {
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    });
}

function formatBooleanBadge(value) {
    return value
        ? '<span style="color:#4ade80">✓ 예</span>'
        : '<span style="color:#475569">✗ 아니오</span>';
}

function buildStatusBadge(status) {
    const safe = escapeHtml(status || '');
    return '<span class="status-badge ' + safe + '">' + (safe || '—') + '</span>';
}

function buildRoleBadge(role) {
    const safe = escapeHtml(role || '');
    return '<span class="role-badge ' + safe + '">' + roleLabel(safe) + '</span>';
}

function roleLabel(role) {
    const labels = {
        USER: '일반',
        BUSINESS: '비즈니스',
        PARTNER: '파트너',
        BOT: '봇',
        ADMIN: '관리자',
        SUPERADMIN: '최고관리자',
        SYSTEM: '시스템'
    };
    return labels[role] || role || '—';
}

function buildSocialHtml(linkedProviders) {
    if (!linkedProviders) {
        return '<span style="color:#475569;font-size:12px;">연동 없음</span>';
    }

    const providerMap = {
        KAKAO: 'k 카카오',
        NAVER: 'N 네이버',
        GOOGLE: 'G Google'
    };

    return linkedProviders
        .split(',')
        .map(provider => provider.trim())
        .filter(provider => provider.length > 0)
        .map(provider => '<span style="margin-right:8px;font-size:12px;color:#94a3b8;">' + escapeHtml(providerMap[provider] || provider) + '</span>')
        .join('') || '<span style="color:#475569;font-size:12px;">연동 없음</span>';
}

/* ── 페이지 이동 ── */
function goPage(p) {
    const form = document.getElementById('searchForm');
    form.querySelector('[name=page]').value = p;
    form.submit();
}

function changeSize(size) {
    const form = document.getElementById('searchForm');
    form.querySelector('[name=size]').value = size;
    form.querySelector('[name=page]').value = 1;
    form.submit();
}

/* ── 액션 메뉴 토글 ── */
function toggleMenu(btn) {
    const menu = btn.nextElementSibling;
    document.querySelectorAll('.action-menu.open').forEach(m => {
        if (m !== menu) m.classList.remove('open');
    });
    menu.classList.toggle('open');
}

function openBlockModal(triggerOrUserIdx, nickname) {
    const trigger = typeof triggerOrUserIdx === 'object' ? triggerOrUserIdx : null;
    const userIdx = trigger ? trigger.dataset.userIdx : triggerOrUserIdx;
    const resolvedNickname = trigger ? (trigger.dataset.nickname || '') : (nickname || '');

    document.getElementById('blockUserIdx').value = userIdx;
    document.getElementById('blockModalTitle').textContent = (resolvedNickname || '') + ' 회원 차단';
    document.getElementById('blockType').value = 'USER_ONLY';
    document.getElementById('blockedIp').value = '';
    document.getElementById('blockedIp').disabled = true;
    document.getElementById('blockedUntil').value = '';
    document.getElementById('blockedReason').value = '';
    document.getElementById('blockSubmitBtn').disabled = false;

    const menu = trigger ? trigger.closest('.action-menu') : null;
    if (menu) menu.classList.remove('open');

    document.getElementById('blockModal').classList.add('open');
}

function closeBlockModal() {
    document.getElementById('blockModal').classList.remove('open');
}

function handleBlockTypeChange() {
    const blockType = document.getElementById('blockType').value;
    const ipInput = document.getElementById('blockedIp');
    const requiresIp = blockType === 'IP_ONLY' || blockType === 'USER_IP';

    ipInput.disabled = !requiresIp;
    if (!requiresIp) ipInput.value = '';
}

async function submitBlock() {
    const submitBtn = document.getElementById('blockSubmitBtn');
    const userIdx = document.getElementById('blockUserIdx').value;
    const blockType = document.getElementById('blockType').value;
    const blockedIp = document.getElementById('blockedIp').value.trim();
    const blockedUntil = document.getElementById('blockedUntil').value;
    const reason = document.getElementById('blockedReason').value.trim();

    if (!userIdx) {
        adm_toast('차단 대상 회원을 찾지 못했습니다.', 'error');
        return;
    }
    if ((blockType === 'IP_ONLY' || blockType === 'USER_IP') && !blockedIp) {
        adm_toast('IP 차단 유형은 차단 IP를 입력해야 합니다.', 'error');
        document.getElementById('blockedIp').focus();
        return;
    }

    submitBtn.disabled = true;
    const originalText = submitBtn.textContent;
    submitBtn.textContent = '적용 중...';

    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/block', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ blockType, blockedIp, expiresAt: blockedUntil, reason })
        });

        let data = null;
        const contentType = res.headers.get('content-type') || '';
        if (contentType.includes('application/json')) {
            data = await res.json();
        } else {
            const text = await res.text();
            throw new Error(text || '차단 요청 응답을 해석하지 못했습니다.');
        }

        if (res.ok && data && data.success) {
            closeBlockModal();
            adm_toast(data.message || '차단이 적용되었습니다.');
            setTimeout(() => location.reload(), 800);
        } else {
            adm_toast((data && data.message) || '차단 적용 중 오류가 발생했습니다.', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast(e.message || '차단 적용 중 오류가 발생했습니다.', 'error');
    } finally {
        submitBtn.disabled = false;
        submitBtn.textContent = originalText;
    }
}

/* ── 상태 변경 ── */
async function changeStatus(userIdx, status, el) {
    const labels = {
        ACTIVE: '활성화',
        DORMANT: '휴면 처리',
        BLOCKED: '차단 처리',
        DELETED: '탈퇴 처리'
    };
    if (!confirm('이 회원을 "' + (labels[status] || status) + '" 하시겠습니까?')) return;

    const menu = el.closest('.action-menu');
    if (menu) menu.classList.remove('open');

    const res = await fetch(ctx + '/admin/members/' + userIdx + '/status', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ status })
    });

    let data;
    try {
        data = await res.json();
    } catch (e) {
        adm_toast('회원 상태 변경 응답을 해석하지 못했습니다.', 'error');
        return;
    }

    if (res.ok && data.success) {
        adm_toast(data.message || '상태가 변경되었습니다.');
        setTimeout(() => location.reload(), 800);
    } else {
        adm_toast(data.message || '회원 상태 변경 중 오류가 발생했습니다.', 'error');
    }
}

/* ── 권한 변경 ── */
function changeRoleFromMenu(button) {
    const box = button.closest('.role-change-box');
    if (!box) return;

    const select = box.querySelector('.role-change-select');
    const reasonInput = box.querySelector('.role-change-reason');
    const userIdx = button.dataset.userIdx;
    const role = select ? select.value : '';
    const currentRole = select ? select.dataset.currentRole : '';
    const reason = reasonInput ? reasonInput.value.trim() : '';

    if (!role || !userIdx) {
        adm_toast('권한 변경 정보를 찾지 못했습니다.', 'error');
        return;
    }
    if (role === currentRole) {
        adm_toast('이미 선택된 권한입니다.', 'error');
        return;
    }
    if (!reason) {
        adm_toast('권한 변경 사유를 입력해주세요.', 'error');
        if (reasonInput) reasonInput.focus();
        return;
    }

    changeRole(userIdx, role, reason, button);
}

async function changeRole(userIdx, role, reason, el) {
    if (!confirm('"' + roleLabel(role) + '" 권한으로 변경하시겠습니까?')) return;

    const menu = el.closest('.action-menu');
    if (menu) menu.classList.remove('open');

    const res = await fetch(ctx + '/admin/members/' + userIdx + '/role', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ role, reason })
    });

    let data;
    try {
        data = await res.json();
    } catch (e) {
        adm_toast('회원 권한 변경 응답을 해석하지 못했습니다.', 'error');
        return;
    }

    if (res.ok && data.success) {
        adm_toast(data.message || '권한이 변경되었습니다.');
        setTimeout(() => location.reload(), 800);
    } else {
        adm_toast(data.message || '회원 권한 변경 중 오류가 발생했습니다.', 'error');
    }
}

/* ── 회원 상세 모달 ── */
async function openDetail(userIdx) {
    document.getElementById('detailModal').classList.add('open');
    document.getElementById('modalBody').innerHTML =
        '<div style="text-align:center;padding:40px;color:#475569;">불러오는 중... ⏳</div>';

    const res = await fetch(ctx + '/admin/members/' + userIdx);
    const data = await res.json();

    if (!data.success) {
        document.getElementById('modalBody').innerHTML =
            '<div style="text-align:center;padding:40px;color:#f87171;">' + escapeHtml(data.message || '오류가 발생했습니다.') + '</div>';
        return;
    }

    const m = data.member || {};
    const h = Array.isArray(data.history) ? data.history : [];

    document.getElementById('modalTitle').textContent = (m.nickname || '회원') + ' 님 상세 정보';

    document.getElementById('modalBody').innerHTML = ''
        + '<div class="adm-tabs">'
        + '<button class="adm-tab active" onclick="switchTab(\'info\', this)">기본 정보</button>'
        + '<button class="adm-tab" onclick="switchTab(\'hist\', this)">로그인 이력 (' + h.length + ')</button>'
        + '</div>'
        + '<div id="tab-info"></div>'
        + '<div id="tab-hist" style="display:none;"></div>';

    document.getElementById('tab-info').innerHTML = buildInfoTab(m);
    document.getElementById('tab-hist').innerHTML = buildHistTab(h);
}

function buildInfoTab(m) {
    const statusBadge = buildStatusBadge(m.accountStatus);
    const roleBadge = buildRoleBadge(m.userRole);
    const socialHtml = buildSocialHtml(m.linkedProviders);
    const lastLoginText = formatDateTime(m.lastLoginAt);

    return ''
        + '<div class="detail-grid">'
        + '<div class="detail-item"><div class="detail-label">회원 번호</div><div class="detail-value">#' + escapeHtml(m.userIdx) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">아이디</div><div class="detail-value">' + formatNullable(m.userId) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">닉네임</div><div class="detail-value">' + formatNullable(m.nickname) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">이메일</div><div class="detail-value" style="font-size:12px;">' + formatNullable(m.userEmail) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">계정 상태</div><div class="detail-value">' + statusBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">권한</div><div class="detail-value">' + roleBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">국적</div><div class="detail-value">' + formatNullable(m.nationality) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">선호 언어</div><div class="detail-value">' + formatNullable(m.preferredLang) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">이메일 인증</div><div class="detail-value">' + formatBooleanBadge(m.emailVerified) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">이메일 로그인</div><div class="detail-value">' + formatBooleanBadge(m.emailLoginEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">비밀번호 로그인</div><div class="detail-value">' + formatBooleanBadge(m.passwordEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">가입일</div><div class="detail-value" style="font-size:12px;">' + formatDateTime(m.createdAt) + '</div></div>'
        + '</div>'
        + '<div class="detail-item" style="margin-top:12px;">'
        + '<div class="detail-label">소셜 연동</div>'
        + '<div class="detail-value" style="margin-top:4px;">' + socialHtml + '</div>'
        + '</div>'
        + '<div style="margin-top:12px;display:flex;gap:8px;flex-wrap:wrap;">'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">로그인 성공</div>'
        + '<div style="font-size:20px;font-weight:700;color:#4ade80;margin-top:4px;">' + escapeHtml(m.loginSuccessCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">로그인 실패</div>'
        + '<div style="font-size:20px;font-weight:700;color:#f87171;margin-top:4px;">' + escapeHtml(m.loginFailCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:120px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">최근 로그인</div>'
        + '<div style="font-size:12px;font-weight:600;color:#94a3b8;margin-top:4px;">' + escapeHtml(lastLoginText) + '</div>'
        + '</div>'
        + '</div>';
}

function buildHistTab(history) {
    if (!history.length) {
        return '<div style="text-align:center;padding:32px;color:#475569;">로그인 이력이 없습니다.</div>';
    }

    const methodMap = {
        ID: '아이디',
        EMAIL: '이메일',
        KAKAO: '카카오',
        NAVER: '네이버',
        GOOGLE: 'Google'
    };

    let rows = '';
    history.forEach(function(item) {
        const ok = !!item.success;
        rows += ''
            + '<tr>'
            + '<td>' + escapeHtml(formatHistoryDateTime(item.loginAt)) + '</td>'
            + '<td>' + escapeHtml(methodMap[item.loginMethod] || item.loginMethod || '—') + '</td>'
            + '<td class="' + (ok ? 'h-success' : 'h-fail') + '">' + (ok ? '✅ 성공' : '❌ 실패') + '</td>'
            + '<td>' + escapeHtml(item.failReason || '—') + '</td>'
            + '<td style="font-size:11px;color:#475569;">' + escapeHtml(item.ipAddress || '—') + '</td>'
            + '</tr>';
    });

    return ''
        + '<div style="overflow-x:auto;max-height:340px;overflow-y:auto;">'
        + '<table class="history-table">'
        + '<thead><tr><th>시각</th><th>방법</th><th>결과</th><th>실패 사유</th><th>IP</th></tr></thead>'
        + '<tbody>' + rows + '</tbody>'
        + '</table>'
        + '</div>';
}

function switchTab(tab, btn) {
    document.querySelectorAll('#detailModal .adm-tab').forEach(t => t.classList.remove('active'));
    btn.classList.add('active');
    document.getElementById('tab-info').style.display = tab === 'info' ? '' : 'none';
    document.getElementById('tab-hist').style.display = tab === 'hist' ? '' : 'none';
}

function closeDetail() {
    document.getElementById('detailModal').classList.remove('open');
}

document.getElementById('detailModal').addEventListener('click', function (e) {
    if (e.target === this) closeDetail();
});

document.getElementById('blockModal').addEventListener('click', function (e) {
    if (e.target === this) closeBlockModal();
});

document.addEventListener('DOMContentLoaded', function () {
    const detailUserIdx = '${fn:escapeXml(param.detailUserIdx)}';
    if (detailUserIdx) {
        openDetail(detailUserIdx);
    }
});
</script>

<%@ include file="../layout-close.jsp" %>
