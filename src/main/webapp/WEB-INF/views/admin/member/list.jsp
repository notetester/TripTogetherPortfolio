<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="members"/>
<spring:message code="admin.members.pageTitle" var="adminMembersPageTitle"/>
<spring:message code="admin.status.ACTIVE" var="memberStatusActive"/>
<spring:message code="admin.status.DORMANT" var="memberStatusDormant"/>
<spring:message code="admin.status.BLOCKED" var="memberStatusBlocked"/>
<spring:message code="admin.status.DELETED" var="memberStatusDeleted"/>
<c:set var="pageTitle"  value="${adminMembersPageTitle}"/>
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
                        <div class="adm-filter-label"><spring:message code="admin.common.search"/></div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:100px;">
                                <option value="all"      ${search.searchType=='all'      ? 'selected' : ''}><spring:message code="admin.common.all"/></option>
                                <option value="userId"   ${search.searchType=='userId'   ? 'selected' : ''}><spring:message code="admin.context.userId"/></option>
                                <option value="nickname" ${search.searchType=='nickname' ? 'selected' : ''}><spring:message code="admin.context.nickname"/></option>
                                <option value="email"    ${search.searchType=='email'    ? 'selected' : ''}><spring:message code="admin.context.email"/></option>
                            </select>
                            <div class="adm-search-box" style="flex:1;">
                                <span class="adm-search-ico">🔍</span>
                                <input class="adm-input" type="text" name="keyword"
                                       value="${search.keyword}" placeholder="<spring:message code='admin.members.searchPlaceholder'/>">
                            </div>
                        </div>
                    </div>

                    <%-- 상태 필터 --%>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.members.accountStatus"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ? 'selected' : ''}><spring:message code="admin.common.all"/></option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ? 'selected' : ''}><spring:message code="admin.status.ACTIVE"/></option>
                            <option value="DORMANT" ${search.status=='DORMANT' ? 'selected' : ''}><spring:message code="admin.status.DORMANT"/></option>
                            <option value="DELETED" ${search.status=='DELETED' ? 'selected' : ''}><spring:message code="admin.status.DELETED"/></option>
                            <option value="BLOCKED" ${search.status=='BLOCKED' ? 'selected' : ''}><spring:message code="admin.status.BLOCKED"/></option>
                        </select>
                    </div>

                    <%-- 권한 필터 --%>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.common.role"/></div>
                        <select class="adm-select" name="role">
                            <option value="ALL"   ${search.role=='ALL'   ? 'selected' : ''}><spring:message code="admin.common.all"/></option>
                            <option value="USER"  ${search.role=='USER'  ? 'selected' : ''}><spring:message code="admin.role.USER"/></option>
                            <option value="BUSINESS" ${search.role=='BUSINESS' ? 'selected' : ''}><spring:message code="admin.role.BUSINESS"/></option>
                            <option value="PARTNER"  ${search.role=='PARTNER'  ? 'selected' : ''}><spring:message code="admin.role.PARTNER"/></option>
                            <option value="BOT"      ${search.role=='BOT'      ? 'selected' : ''}><spring:message code="admin.role.BOT"/></option>
                            <option value="ADMIN" ${search.role=='ADMIN' ? 'selected' : ''}><spring:message code="admin.role.ADMIN"/></option>
                        </select>
                    </div>

                    <%-- 소셜 필터 --%>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.members.socialLinked"/></div>
                        <select class="adm-select" name="provider">
                            <option value="ALL"    ${search.provider=='ALL'    ? 'selected' : ''}><spring:message code="admin.common.all"/></option>
                            <option value="KAKAO"  ${search.provider=='KAKAO'  ? 'selected' : ''}><spring:message code="admin.social.kakao"/></option>
                            <option value="NAVER"  ${search.provider=='NAVER'  ? 'selected' : ''}><spring:message code="admin.social.naver"/></option>
                            <option value="GOOGLE" ${search.provider=='GOOGLE' ? 'selected' : ''}><spring:message code="admin.social.google"/></option>
                            <option value="NONE"   ${search.provider=='NONE'   ? 'selected' : ''}><spring:message code="admin.members.noLinkedProvider"/></option>
                        </select>
                    </div>

                    <%-- 가입일 범위 --%>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.context.createdAt"/></div>
                        <div style="display:flex;gap:4px;align-items:center;">
                            <input class="adm-input" type="date" name="dateFrom"
                                   value="${search.dateFrom}" style="width:130px;">
                            <span style="color:#475569;font-size:12px;">~</span>
                            <input class="adm-input" type="date" name="dateTo"
                                   value="${search.dateTo}" style="width:130px;">
                        </div>
                    </div>

                    <%-- 버튼 --%>
                    <div style="display:flex;gap:6px;align-items:flex-end;">
                        <button type="submit" class="adm-btn adm-btn-primary">🔍 <spring:message code="admin.common.searchButton"/></button>
                        <button type="button" class="adm-btn adm-btn-ghost" onclick="resetMemberFilters()"><spring:message code="admin.members.reset"/></button>
                    </div>

                    <input type="hidden" name="page" value="1">
                    <input type="hidden" name="size" value="${search.size}">
                    <input type="hidden" id="sortByInput" name="sortBy" value="${search.sortBy}">
                    <input type="hidden" id="sortDirInput" name="sortDir" value="${search.sortDir}">
                </div>
            </form>
        </div>
    </div>

    <%-- ══════════════════════════════════════════
         회원 목록 테이블
    ══════════════════════════════════════════ --%>
    <div class="adm-card js-member-section-card" data-section="members" data-enhanced="true" style="overflow:visible;">
        <div class="adm-card-head">
            <div class="adm-card-title">
                👥 <spring:message code="admin.members.listTitle"/>
                <span id="memberTotalLabel" style="font-size:12px;font-weight:400;color:#475569;">
                    <spring:message code="admin.members.totalMembers" arguments="${total}"/>
                </span>
            </div>
            <div style="position:relative;display:flex;align-items:center;gap:8px;">
                <select class="adm-select" id="exportFormat" style="width:90px;">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <button type="button" class="adm-btn adm-btn-ghost js-export-toggle"><spring:message code="admin.common.export"/> ▾</button>
                <div id="exportDropdown" class="adm-export-dropdown">
                    <button type="button" class="adm-export-item" onclick="exportData('all')"><spring:message code="admin.common.exportAll"/></button>
                    <button type="button" class="adm-export-item" onclick="exportData('search')"><spring:message code="admin.common.exportFiltered"/></button>
                    <button type="button" class="adm-export-item" id="exportSelectedBtn" disabled onclick="exportData('selected')"><spring:message code="admin.common.exportSelected"/> (0)</button>
                </div>
            </div>
        </div>

        <div class="adm-local-toolbar adm-member-local-toolbar">
            <div class="adm-local-toolbar-group adm-member-toolbar-actions">
                <button type="button" class="adm-dash-sort-reset js-member-sort-reset" style="display:none;" onclick="resetMemberSort()"></button>
                <select class="adm-select js-member-section-mode" id="memberModeSelect" title="<spring:message code='admin.blocks.mode.label'/>">
                    <option value="client" title="<spring:message code='admin.blocks.mode.tipClient'/>"><spring:message code="admin.blocks.mode.client"/></option>
                    <option value="server" title="<spring:message code='admin.blocks.mode.tipServer'/>"><spring:message code="admin.blocks.mode.server"/></option>
                </select>
                <select class="adm-select js-member-page-size" style="width:90px;" id="sizeSelect" onchange="changeSize(this.value)">
                    <option value="10"  ${search.size==10  ? 'selected' : ''}><spring:message code="admin.common.pageSize" arguments="10"/></option>
                    <option value="20"  ${search.size==20  ? 'selected' : ''}><spring:message code="admin.common.pageSize" arguments="20"/></option>
                    <option value="50"  ${search.size==50  ? 'selected' : ''}><spring:message code="admin.common.pageSize" arguments="50"/></option>
                    <option value="100" ${search.size==100 ? 'selected' : ''}><spring:message code="admin.common.pageSize" arguments="100"/></option>
                </select>
            </div>
        </div>

        <%-- 일괄 처리 바 --%>
        <div id="bulkBar" style="display:none;background:#1a3354;border:1px solid #2d6a9f;border-radius:8px;padding:10px 16px;margin:0 0 12px;align-items:center;gap:12px;flex-wrap:wrap;">
            <span style="color:#93c5fd;font-size:13px;font-weight:600;"><strong id="bulkCount">0</strong><spring:message code="admin.common.selectedCount"/></span>
            <div style="display:flex;align-items:center;gap:6px;">
                <select class="adm-select" id="bulkStatusSelect" style="width:130px;">
                    <option value="">상태 선택</option>
                    <option value="ACTIVE"><spring:message code="admin.status.ACTIVE"/></option>
                    <option value="DORMANT"><spring:message code="admin.status.DORMANT"/></option>
                    <option value="BLOCKED"><spring:message code="admin.status.BLOCKED"/></option>
                    <option value="DELETED"><spring:message code="admin.status.DELETED"/></option>
                </select>
                <button type="button" class="adm-btn adm-btn-primary" style="font-size:12px;" onclick="applyBulkStatus()">적용</button>
            </div>
            <button type="button" class="adm-btn adm-btn-ghost" style="font-size:12px;margin-left:auto;" onclick="clearSelection()"><spring:message code="admin.common.clearSelection"/></button>
        </div>

        <div class="adm-table-wrap" style="overflow:visible;">
            <table class="adm-table adm-section-table-fixed adm-member-section-table" data-admin-list-ignore="true" data-section="members">
                <thead>
                <tr>
                    <th style="width:40px;text-align:center;">
                        <input type="checkbox" id="checkAll" class="adm-check" onchange="toggleAll(this)">
                    </th>
                    <th class="js-member-sort" data-sort="nickname" onclick="memberSortBy('nickname')" style="cursor:pointer;user-select:none;">
                        <spring:message code="admin.common.member"/>
                    </th>
                    <th class="js-member-sort" data-sort="email" onclick="memberSortBy('email')" style="cursor:pointer;user-select:none;">
                        <spring:message code="admin.context.email"/>
                    </th>
                    <th class="js-member-sort" data-sort="status" onclick="memberSortBy('status')" style="cursor:pointer;user-select:none;">
                        <spring:message code="admin.common.status"/>
                    </th>
                    <th class="js-member-sort" data-sort="role" onclick="memberSortBy('role')" style="cursor:pointer;user-select:none;">
                        <spring:message code="admin.common.role"/>
                    </th>
                    <th class="js-member-sort" data-sort="social" onclick="memberSortBy('social')" style="cursor:pointer;user-select:none;">
                        <spring:message code="admin.members.social"/>
                    </th>
                    <th class="js-member-sort" data-sort="lastLoginAt" onclick="memberSortBy('lastLoginAt')" style="cursor:pointer;user-select:none;">
                        <spring:message code="admin.members.login"/>
                    </th>
                    <th class="js-member-sort" data-sort="createdAt" onclick="memberSortBy('createdAt')" style="cursor:pointer;user-select:none;">
                        <spring:message code="admin.context.createdAt"/>
                    </th>
                    <th></th>
                </tr>
                </thead>
                <tbody id="memberRowsBody">
                <%@ include file="_memberRowsFragment.jsp" %>
                </tbody>
            </table>
        </div>

        <%-- 페이징 --%>
        <div class="adm-local-pagination" data-section="members" id="memberPaging">
            <div class="adm-local-page-info js-member-page-info" data-section="members">총 ${total}건 / 현재 ${fn:length(list)}건</div>
            <div class="adm-local-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost js-member-prev" onclick="goPage(memberSectionState.page - 1)"><spring:message code="admin.common.prev"/></button>
                <span class="js-member-page-state" data-section="members">${paging.currentPage} / ${paging.totalPage}</span>
                <button type="button" class="adm-btn adm-btn-ghost js-member-next" onclick="goPage(memberSectionState.page + 1)"><spring:message code="admin.common.next"/></button>
            </div>
        </div>
    </div>
</div>

<%-- ══════════════════════════════════════════
     회원 상세 모달
══════════════════════════════════════════ --%>
<div class="adm-modal-overlay" id="detailModal">
    <div class="adm-modal">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="modalTitle"><spring:message code="admin.context.memberTitle"/></div>
            <button class="adm-modal-close" onclick="closeDetail()">✕</button>
        </div>
        <div class="adm-modal-body" id="modalBody">
            <div style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.common.loading"/></div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeDetail()"><spring:message code="admin.common.close"/></button>
        </div>
    </div>
</div>


<div class="adm-modal-overlay" id="blockModal">
    <div class="adm-modal" style="max-width:520px;">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="blockModalTitle"><spring:message code="admin.members.blockModalTitle"/></div>
            <button class="adm-modal-close" onclick="closeBlockModal()">✕</button>
        </div>
        <div class="adm-modal-body">
            <input type="hidden" id="blockUserIdx">
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label"><spring:message code="admin.context.action.blockType"/></label>
                <select id="blockType" class="adm-select" style="width:100%;" onchange="handleBlockTypeChange()">
                    <option value="USER_ONLY"><spring:message code="admin.context.blockType.userOnly"/></option>
                    <option value="IP_ONLY"><spring:message code="admin.context.blockType.ipOnly"/></option>
                    <option value="USER_IP"><spring:message code="admin.context.blockType.userIp"/></option>
                </select>
            </div>
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label"><spring:message code="admin.members.blockedIpLabel"/></label>
                <input id="blockedIp" class="adm-input" type="text" placeholder="<spring:message code='admin.context.action.blockIpPlaceholder'/>">
            </div>
            <div class="form-group" style="margin-bottom:12px;">
                <label class="form-label"><spring:message code="admin.members.blockExpiresLabel"/></label>
                <input id="blockedUntil" class="adm-input" type="datetime-local">
            </div>
            <div class="form-group">
                <label class="form-label"><spring:message code="admin.members.blockReasonLabel"/></label>
                <textarea id="blockedReason" class="adm-input" style="min-height:90px;resize:vertical;" placeholder="<spring:message code='admin.context.action.reasonPlaceholder'/>"></textarea>
            </div>
        </div>
        <div class="adm-modal-foot">
            <button class="adm-btn adm-btn-ghost" onclick="closeBlockModal()"><spring:message code="admin.common.close"/></button>
            <button id="blockSubmitBtn" class="adm-btn adm-btn-primary" type="button" onclick="submitBlock()"><spring:message code="admin.context.action.applyBlock"/></button>
        </div>
    </div>
</div>

<script>
const ctx = '${pageContext.request.contextPath}';

/* ── 회원 목록: 차단 관리형 서버/클라이언트 섹션 로직 ── */
const MEMBER_DEFAULT_SORT_BY = 'createdAt';
const MEMBER_DEFAULT_SORT_DIR = 'DESC';
const MEMBER_MODE_STORAGE = 'admMemberSectionMode';
const MEMBER_MODE_COOKIE = 'admMemberMode';
const MEMBER_CLIENT_MAX_SIZE = 10000;

var memberSectionState = {
    page: 1,
    pageSize: 20,
    sortBy: '',
    sortDir: 'ASC',
    mode: 'SERVER',
    clientRows: null,
    clientFilterKey: '',
    clientTotal: 0
};

function getSearchForm() {
    return document.getElementById('searchForm');
}

function getMemberTbody() {
    return document.getElementById('memberRowsBody');
}

function getMemberSearchFilterKey() {
    const form = getSearchForm();
    if (!form) return '';
    const params = new URLSearchParams();
    new FormData(form).forEach(function (val, key) {
        if (['page', 'size', 'sortBy', 'sortDir', 'mode'].includes(key)) return;
        if (val != null && String(val).trim().length > 0) params.append(key, String(val).trim());
    });
    return params.toString();
}

function buildMemberParams(pageOverride, options) {
    options = options || {};
    const form = getSearchForm();
    const params = new URLSearchParams();
    if (form) {
        new FormData(form).forEach(function (val, key) {
            if (['page', 'size', 'sortBy', 'sortDir', 'mode'].includes(key)) return;
            if (val != null && String(val).trim().length > 0) params.append(key, String(val).trim());
        });
    }
    const targetPage = pageOverride != null ? Number(pageOverride) : Number(memberSectionState.page || 1);
    params.set('page', String(Math.max(1, targetPage || 1)));
    params.set('size', String(options.clientFetch ? MEMBER_CLIENT_MAX_SIZE : (memberSectionState.pageSize || 20)));
    params.set('mode', options.clientFetch ? 'CLIENT' : memberSectionState.mode);
    if (options.includeSort !== false && memberSectionState.sortBy) {
        params.set('sortBy', memberSectionState.sortBy);
        params.set('sortDir', memberSectionState.sortDir === 'DESC' ? 'DESC' : 'ASC');
    }
    return params;
}

function syncMemberHiddenInputs() {
    const form = getSearchForm();
    if (!form) return;
    const pageInput = form.querySelector('[name=page]');
    const sizeInput = form.querySelector('[name=size]');
    const sortByInput = document.getElementById('sortByInput');
    const sortDirInput = document.getElementById('sortDirInput');
    if (pageInput) pageInput.value = String(memberSectionState.page || 1);
    if (sizeInput) sizeInput.value = String(memberSectionState.pageSize || 20);
    if (sortByInput) sortByInput.value = memberSectionState.sortBy || '';
    if (sortDirInput) sortDirInput.value = memberSectionState.sortBy ? memberSectionState.sortDir : '';
}

function setMemberModeCookie(mode) {
    document.cookie = MEMBER_MODE_COOKIE + '=' + (mode === 'CLIENT' ? 'client' : 'server') + ';path=' + (ctx || '/') + ';max-age=31536000;samesite=lax';
}

function loadStoredMemberMode() {
    try {
        const stored = localStorage.getItem(MEMBER_MODE_STORAGE);
        return stored === 'CLIENT' ? 'CLIENT' : 'SERVER';
    } catch (e) {
        return 'SERVER';
    }
}

function saveMemberMode(mode) {
    memberSectionState.mode = mode === 'CLIENT' ? 'CLIENT' : 'SERVER';
    try { localStorage.setItem(MEMBER_MODE_STORAGE, memberSectionState.mode); } catch (e) {}
    setMemberModeCookie(memberSectionState.mode);
    const select = document.getElementById('memberModeSelect');
    if (select) select.value = memberSectionState.mode === 'CLIENT' ? 'client' : 'server';
}

function updateMemberSortIndicators() {
    document.querySelectorAll('th[data-sort]').forEach(function (th) {
        const active = !!memberSectionState.sortBy && th.dataset.sort === memberSectionState.sortBy;
        th.classList.toggle('sorted', active);
        let ico = th.querySelector('.sort-ico');
        if (active) {
            if (!ico) {
                ico = document.createElement('span');
                ico.className = 'sort-ico';
                ico.style.cssText = 'font-size:10px;margin-left:4px;font-weight:900;';
                th.appendChild(ico);
            }
            ico.textContent = memberSectionState.sortDir === 'DESC' ? '▼' : '▲';
            ico.style.color = memberSectionState.sortDir === 'DESC' ? '#3b82f6' : '#ef4444';
        } else if (ico) {
            ico.remove();
        }
    });
    const resetBtn = document.querySelector('.js-member-sort-reset');
    if (resetBtn) {
        resetBtn.textContent = ADMIN_MEMBER_MSG.dashSortReset;
        resetBtn.style.display = memberSectionState.sortBy ? '' : 'none';
    }
}

function updateMemberTotal(total) {
    const totalLabel = document.getElementById('memberTotalLabel');
    if (totalLabel) totalLabel.textContent = '총 ' + Number(total || 0).toLocaleString() + '명';
}

function updateMemberPaginationMeta(page, totalPages, total, renderedCount) {
    const safePages = Math.max(1, Number(totalPages || 1));
    const safePage = Math.min(Math.max(1, Number(page || 1)), safePages);
    memberSectionState.page = safePage;
    const pageInfo = document.querySelector('.js-member-page-info');
    if (pageInfo) {
        const totalText = ADMIN_MEMBER_MSG.totalCountFormat.replace('{0}', Number(total || 0).toLocaleString());
        const currentText = ADMIN_MEMBER_MSG.currentCountFormat.replace('{0}', Number(renderedCount || 0).toLocaleString());
        pageInfo.textContent = totalText + ' / ' + currentText;
    }
    const pageState = document.querySelector('.js-member-page-state');
    if (pageState) pageState.textContent = safePage + ' / ' + safePages;
    const prevBtn = document.querySelector('.js-member-prev');
    const nextBtn = document.querySelector('.js-member-next');
    if (prevBtn) prevBtn.disabled = safePage <= 1;
    if (nextBtn) nextBtn.disabled = safePage >= safePages;
    updateMemberTotal(total);
    syncMemberHiddenInputs();
}

function memberSortValue(row, field) {
    if (!row || !field) return '';
    if (field === 'email') return row.dataset.email || '';
    if (field === 'status') return row.dataset.status || '';
    if (field === 'role') return row.dataset.role || '';
    if (field === 'lastLoginAt') return row.dataset.lastLoginAt || '0';
    if (field === 'createdAt') return row.dataset.createdAt || '0';
    if (field === 'social' || field === 'socialCount') {
        const count = Number(row.dataset.socialCount || '0');
        const rank = Number(row.dataset.socialRank || '0');
        return String((Number.isFinite(count) ? count : 0) * 100 + (Number.isFinite(rank) ? rank : 0));
    }
    return row.dataset.nickname || '';
}

function compareMemberRows(a, b) {
    const field = memberSectionState.sortBy;
    if (!field) {
        return Number(a.dataset.originalIndex || 0) - Number(b.dataset.originalIndex || 0);
    }
    const av = memberSortValue(a, field);
    const bv = memberSortValue(b, field);
    const an = Number(av);
    const bn = Number(bv);
    let cmp;
    if (!Number.isNaN(an) && !Number.isNaN(bn) && /^-?\d+(\.\d+)?$/.test(String(av)) && /^-?\d+(\.\d+)?$/.test(String(bv))) {
        cmp = an - bn;
    } else {
        cmp = String(av).localeCompare(String(bv), ADMIN_MEMBER_LOCALE || undefined, {numeric: true, sensitivity: 'base'});
    }
    return cmp * (memberSectionState.sortDir === 'DESC' ? -1 : 1);
}

function markOriginalIndices(rows) {
    rows.forEach(function (row, idx) {
        if (row.dataset.originalIndex == null) row.dataset.originalIndex = String(idx);
    });
}

function renderMemberEmptyRow() {
    return '<tr class="adm-local-empty"><td colspan="9" style="text-align:center;color:#64748b;padding:32px;">' + escapeHtml(ADMIN_MEMBER_MSG.noResults) + '</td></tr>';
}

async function renderServerMembers(pageOverride) {
    memberSectionState.mode = 'SERVER';
    const params = buildMemberParams(pageOverride, {includeSort: true});
    const tbody = getMemberTbody();
    if (!tbody) return;
    tbody.classList.add('is-loading');
    try {
        const res = await fetch(ctx + '/admin/members/fragment?' + params.toString(), {
            credentials: 'same-origin',
            headers: {'Accept': 'text/html', 'X-Requested-With': 'XMLHttpRequest'}
        });
        const html = await res.text();
        if (!res.ok) throw new Error(html || '목록을 불러오지 못했습니다.');
        tbody.innerHTML = html.trim() || renderMemberEmptyRow();
        const rows = Array.from(tbody.querySelectorAll('.js-member-row'));
        markOriginalIndices(rows);
        const total = Number(res.headers.get('X-Section-Total') || rows.length || 0);
        const page = Number(res.headers.get('X-Section-Page') || params.get('page') || 1);
        const size = Number(res.headers.get('X-Section-Size') || memberSectionState.pageSize || 20);
        const pages = Number(res.headers.get('X-Section-Pages') || 1);
        memberSectionState.pageSize = [10,20,50,100].includes(size) ? size : memberSectionState.pageSize;
        const sizeSelect = document.getElementById('sizeSelect');
        if (sizeSelect) sizeSelect.value = String(memberSectionState.pageSize);
        updateMemberPaginationMeta(page, pages, total, rows.length);
        updateMemberSortIndicators();
        clearSelection();
    } catch (e) {
        adm_toast(e.message || '목록을 불러오지 못했습니다.', 'error');
    } finally {
        tbody.classList.remove('is-loading');
    }
}

async function ensureClientMemberRows() {
    const filterKey = getMemberSearchFilterKey();
    if (memberSectionState.clientRows && memberSectionState.clientFilterKey === filterKey) return;
    const params = buildMemberParams(1, {clientFetch: true, includeSort: false});
    const res = await fetch(ctx + '/admin/members/fragment?' + params.toString(), {
        credentials: 'same-origin',
        headers: {'Accept': 'text/html', 'X-Requested-With': 'XMLHttpRequest'}
    });
    const html = await res.text();
    if (!res.ok) throw new Error(html || '전체 목록을 불러오지 못했습니다.');
    const temp = document.createElement('tbody');
    temp.innerHTML = html;
    const rows = Array.from(temp.querySelectorAll('.js-member-row'));
    markOriginalIndices(rows);
    memberSectionState.clientRows = rows;
    memberSectionState.clientFilterKey = filterKey;
    memberSectionState.clientTotal = Number(res.headers.get('X-Section-Total') || rows.length || 0);
}

async function renderClientMembers(pageOverride) {
    memberSectionState.mode = 'CLIENT';
    const tbody = getMemberTbody();
    if (!tbody) return;
    tbody.classList.add('is-loading');
    try {
        await ensureClientMemberRows();
        let rows = (memberSectionState.clientRows || []).slice();
        rows.sort(compareMemberRows);
        const total = rows.length;
        const pageSize = memberSectionState.pageSize || 20;
        const totalPages = Math.max(1, Math.ceil(total / pageSize));
        const page = Math.min(Math.max(1, Number(pageOverride || memberSectionState.page || 1)), totalPages);
        const start = (page - 1) * pageSize;
        const visible = rows.slice(start, start + pageSize);
        tbody.innerHTML = '';
        if (visible.length === 0) {
            tbody.innerHTML = renderMemberEmptyRow();
        } else {
            visible.forEach(function (row) { tbody.appendChild(row.cloneNode(true)); });
        }
        updateMemberPaginationMeta(page, totalPages, total, visible.length);
        updateMemberSortIndicators();
        clearSelection();
    } catch (e) {
        adm_toast(e.message || '전체 목록을 불러오지 못했습니다.', 'error');
    } finally {
        tbody.classList.remove('is-loading');
    }
}

async function renderMemberByMode(pageOverride) {
    if (memberSectionState.mode === 'CLIENT') {
        return renderClientMembers(pageOverride);
    }
    return renderServerMembers(pageOverride);
}

async function reloadMemberRows(pageOverride) {
    if (memberSectionState.mode === 'CLIENT') memberSectionState.clientRows = null;
    return renderMemberByMode(pageOverride || memberSectionState.page || 1);
}

async function refreshMemberSection() {
    if (memberSectionState.mode === 'CLIENT') memberSectionState.clientRows = null;
    return renderMemberByMode(memberSectionState.page || 1);
}

function memberSortBy(field) {
    const prevField = memberSectionState.sortBy || '';
    const prevDir = memberSectionState.sortDir || 'ASC';
    memberSectionState.sortBy = field;
    memberSectionState.sortDir = (prevField === field && prevDir === 'ASC') ? 'DESC' : 'ASC';
    memberSectionState.page = 1;
    renderMemberByMode(1);
}

function resetMemberSort() {
    memberSectionState.sortBy = '';
    memberSectionState.sortDir = 'ASC';
    memberSectionState.page = 1;
    renderMemberByMode(1);
}

function resetMemberFilters() {
    const form = getSearchForm();
    if (form) {
        const setValue = function (name, value) {
            const el = form.querySelector('[name=' + name + ']');
            if (el) el.value = value;
        };
        setValue('searchType', 'all');
        setValue('keyword', '');
        setValue('status', 'ALL');
        setValue('role', 'ALL');
        setValue('provider', 'ALL');
        setValue('dateFrom', '');
        setValue('dateTo', '');
    }
    memberSectionState.page = 1;
    memberSectionState.sortBy = '';
    memberSectionState.sortDir = 'ASC';
    memberSectionState.clientRows = null;
    renderMemberByMode(1);
}

function goPage(p) {
    const page = Math.max(1, Number(p || 1));
    renderMemberByMode(page);
}

function changeSize(size) {
    const parsed = Number(size);
    memberSectionState.pageSize = [10, 20, 50, 100].includes(parsed) ? parsed : 20;
    memberSectionState.page = 1;
    syncMemberHiddenInputs();
    renderMemberByMode(1);
}

/* ── 체크박스 ── */
function toggleAll(cb) {
    document.querySelectorAll('.js-row-check').forEach(function (c) { c.checked = cb.checked; });
    updateBulkBar();
}
function updateBulkBar() {
    const checked = document.querySelectorAll('.js-row-check:checked');
    const n = checked.length;
    const bulkBar = document.getElementById('bulkBar');
    if (bulkBar) bulkBar.style.display = n > 0 ? 'flex' : 'none';
    const bulkCount = document.getElementById('bulkCount');
    if (bulkCount) bulkCount.textContent = n;
    const selBtn = document.getElementById('exportSelectedBtn');
    if (selBtn) {
        selBtn.disabled = n === 0;
        selBtn.style.color = n > 0 ? '#e2e8f0' : '#94a3b8';
        selBtn.textContent = ADMIN_MEMBER_MSG.exportSelected + ' (' + n + ')';
    }
    const all = document.getElementById('checkAll');
    if (all) {
        const rows = document.querySelectorAll('.js-row-check');
        all.checked = rows.length > 0 && n === rows.length;
        all.indeterminate = n > 0 && n < rows.length;
    }
}
function clearSelection() {
    document.querySelectorAll('.js-row-check, #checkAll').forEach(function (c) {
        c.checked = false;
        c.indeterminate = false;
    });
    updateBulkBar();
}

/* ── 일괄 상태 변경 ── */
async function applyBulkStatus() {
    const status = document.getElementById('bulkStatusSelect').value;
    if (!status) { adm_toast('상태를 선택해주세요.', 'error'); return; }
    const ids = Array.from(document.querySelectorAll('.js-row-check:checked')).map(function (c) { return c.value; });
    if (!ids.length) { adm_toast('선택된 항목이 없습니다.', 'error'); return; }
    if (!confirm(ids.length + '명의 상태를 "' + status + '"(으)로 변경하시겠습니까?')) return;
    const params = new URLSearchParams();
    ids.forEach(function (id) { params.append('userIdxList', id); });
    params.append('status', status);
    const res = await fetch(ctx + '/admin/members/bulk/status', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: params
    });
    const data = await res.json();
    if (res.ok && data.success) {
        adm_toast(data.message);
        document.getElementById('bulkStatusSelect').value = '';
        await refreshMemberSection();
    } else {
        adm_toast(data.message || '처리 중 오류가 발생했습니다.', 'error');
    }
}

/* ── 내보내기 ── */
function exportData(scope) {
    const format = document.getElementById('exportFormat').value;
    const params = buildMemberParams(null, {includeSort: true});
    params.delete('page');
    params.set('scope', scope);
    params.set('format', format);
    if (scope === 'selected') {
        const ids = Array.from(document.querySelectorAll('.js-row-check:checked')).map(function (c) { return c.value; });
        if (!ids.length) { adm_toast('선택된 항목이 없습니다.', 'error'); return; }
        params.set('selectedIds', ids.join(','));
    }
    const exportDropdown = document.getElementById('exportDropdown');
    if (exportDropdown) exportDropdown.classList.remove('open');
    window.location.href = ctx + '/admin/members/export?' + params.toString();
}

function initMemberSection() {
    const sizeSelect = document.getElementById('sizeSelect');
    memberSectionState.pageSize = Number(sizeSelect ? sizeSelect.value : 20) || 20;
    memberSectionState.page = Number((getSearchForm() && getSearchForm().querySelector('[name=page]') || {}).value || 1) || 1;
    saveMemberMode(loadStoredMemberMode());

    const modeSelect = document.getElementById('memberModeSelect');
    if (modeSelect) {
        modeSelect.addEventListener('change', function () {
            saveMemberMode(modeSelect.value === 'client' ? 'CLIENT' : 'SERVER');
            memberSectionState.page = 1;
            memberSectionState.clientRows = null;
            renderMemberByMode(1);
        });
    }
    const form = getSearchForm();
    if (form) {
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            memberSectionState.page = 1;
            memberSectionState.clientRows = null;
            renderMemberByMode(1);
        });
    }
    const exportToggle = document.querySelector('.js-export-toggle');
    const exportDropdown = document.getElementById('exportDropdown');
    if (exportToggle && exportDropdown) {
        exportToggle.addEventListener('click', function () { exportDropdown.classList.toggle('open'); });
        document.addEventListener('click', function (e) {
            if (!exportToggle.contains(e.target) && !exportDropdown.contains(e.target)) exportDropdown.classList.remove('open');
        });
    }

    const existingRows = Array.from(document.querySelectorAll('#memberRowsBody .js-member-row'));
    markOriginalIndices(existingRows);
    updateMemberPaginationMeta(memberSectionState.page, Number((document.querySelector('.js-member-page-state') || {}).textContent?.split('/')[1] || 1), Number('${total}' || existingRows.length), existingRows.length);
    updateMemberSortIndicators();
    if (memberSectionState.mode === 'CLIENT') renderMemberByMode(1);
}

document.addEventListener('DOMContentLoaded', initMemberSection);

const ADMIN_MEMBER_LOCALE = '${fn:escapeXml(pageContext.response.locale.toLanguageTag())}';
const ADMIN_MEMBER_MSG = {
    loading: '<spring:message code="admin.common.loading" javaScriptEscape="true"/>',
    dashSortReset: '<spring:message code="admin.blocks.js.dashSortReset" javaScriptEscape="true"/>',
    totalCountFormat: '<spring:message code="admin.common.totalCountFormat" javaScriptEscape="true"/>',
    currentCountFormat: '<spring:message code="admin.common.currentCountFormat" javaScriptEscape="true"/>',
    exportSelected: '<spring:message code="admin.common.exportSelected" javaScriptEscape="true"/>',
    noResults: '<spring:message code="admin.common.noResults" javaScriptEscape="true"/>',
    close: '<spring:message code="admin.common.close" javaScriptEscape="true"/>',
    error: '<spring:message code="admin.common.error" javaScriptEscape="true"/>',
    yes: '<spring:message code="admin.common.yes" javaScriptEscape="true"/>',
    no: '<spring:message code="admin.common.no" javaScriptEscape="true"/>',
    none: '<spring:message code="admin.members.none" javaScriptEscape="true"/>',
    noLinkedProvider: '<spring:message code="admin.members.noLinkedProvider" javaScriptEscape="true"/>',
    verifiedMember: '<spring:message code="admin.members.verifiedMember" javaScriptEscape="true"/>',
    unverifiedMember: '<spring:message code="admin.members.unverifiedMember" javaScriptEscape="true"/>',
    statusActive: '<spring:message code="admin.status.ACTIVE" javaScriptEscape="true"/>',
    statusDormant: '<spring:message code="admin.status.DORMANT" javaScriptEscape="true"/>',
    statusBlocked: '<spring:message code="admin.status.BLOCKED" javaScriptEscape="true"/>',
    statusDeleted: '<spring:message code="admin.status.DELETED" javaScriptEscape="true"/>',
    blockModalTitleSuffix: '<spring:message code="admin.members.blockModalTitleSuffix" javaScriptEscape="true"/>',
    parsingBlockResponse: '<spring:message code="admin.members.blockResponseParseError" javaScriptEscape="true"/>',
    parsingStatusResponse: '<spring:message code="admin.members.statusResponseParseError" javaScriptEscape="true"/>',
    parsingRoleResponse: '<spring:message code="admin.members.roleResponseParseError" javaScriptEscape="true"/>',
    missingBlockTarget: '<spring:message code="admin.members.blockTargetMissing" javaScriptEscape="true"/>',
    applying: '<spring:message code="admin.common.applying" javaScriptEscape="true"/>',
    blockApplied: '<spring:message code="admin.context.toast.saveBlockSuccess" javaScriptEscape="true"/>',
    memberDetailsTitle: '<spring:message code="admin.context.memberTitle" javaScriptEscape="true"/>',
    memberDetailsSuffix: '<spring:message code="admin.members.detailTitleSuffix" javaScriptEscape="true"/>',
    emailSectionTitle: '<spring:message code="admin.members.action.emailTitle" javaScriptEscape="true"/>',
    emailPlaceholder: '<spring:message code="admin.members.emailPlaceholder" javaScriptEscape="true"/>',
    saveEmail: '<spring:message code="admin.members.action.saveEmail" javaScriptEscape="true"/>',
    emailResetNotice: '<spring:message code="admin.members.emailResetNotice" javaScriptEscape="true"/>',
    emailCellHint: '<spring:message code="admin.members.emailCellHint" javaScriptEscape="true"/>',
    emailUpdated: '<spring:message code="admin.members.emailUpdated" javaScriptEscape="true"/>',
    infoTab: '<spring:message code="admin.context.tab.info" javaScriptEscape="true"/>',
    loginTab: '<spring:message code="admin.context.tab.logins" javaScriptEscape="true"/>',
    securityTab: '<spring:message code="admin.context.tab.security" javaScriptEscape="true"/>',
    emailHistoryTab: '<spring:message code="admin.members.emailHistoryTab" javaScriptEscape="true"/>',
    activityTab: '<spring:message code="admin.context.tab.activity" javaScriptEscape="true"/>',
    blockTab: '<spring:message code="admin.context.tab.blocks" javaScriptEscape="true"/>',
    actionsTab: '<spring:message code="admin.context.tab.actions" javaScriptEscape="true"/>',
    chatbotTab: '<spring:message code="admin.context.tab.chatbot" javaScriptEscape="true"/>',
    chatbotFilterSelectIp: '<spring:message code="admin.context.chatbotFilter.selectIp" javaScriptEscape="true"/>',
    chatbotFilterF1: '<spring:message code="admin.context.chatbotFilter.f1" javaScriptEscape="true"/>',
    chatbotFilterF1Tip: '<spring:message code="admin.context.chatbotFilter.f1.tip" javaScriptEscape="true"/>',
    chatbotFilterF2: '<spring:message code="admin.context.chatbotFilter.f2" javaScriptEscape="true"/>',
    chatbotFilterF2Tip: '<spring:message code="admin.context.chatbotFilter.f2.tip" javaScriptEscape="true"/>',
    chatbotFilterF3: '<spring:message code="admin.context.chatbotFilter.f3" javaScriptEscape="true"/>',
    chatbotFilterF3Tip: '<spring:message code="admin.context.chatbotFilter.f3.tip" javaScriptEscape="true"/>',
    chatbotFilterF4: '<spring:message code="admin.context.chatbotFilter.f4" javaScriptEscape="true"/>',
    chatbotFilterF4Tip: '<spring:message code="admin.context.chatbotFilter.f4.tip" javaScriptEscape="true"/>',
    chatbotFilterF5: '<spring:message code="admin.context.chatbotFilter.f5" javaScriptEscape="true"/>',
    chatbotFilterF5Tip: '<spring:message code="admin.context.chatbotFilter.f5.tip" javaScriptEscape="true"/>',
    chatbotFilterLoadFailed: '<spring:message code="admin.context.chatbotFilter.loadFailed" javaScriptEscape="true"/>',
    chatbotEmptyClicks: '<spring:message code="admin.context.empty.chatbotClicks" javaScriptEscape="true"/>',
    anonymous: '<spring:message code="admin.common.anonymous" javaScriptEscape="true"/>',
    tabMore: '<spring:message code="admin.context.tab.more" javaScriptEscape="true"/>'
};

let _chatbotDetailUserIdx = null;
let _detailTabsRo = null;

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

    return date.toLocaleString(ADMIN_MEMBER_LOCALE || undefined, {
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

    return date.toLocaleString(ADMIN_MEMBER_LOCALE || undefined, {
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    });
}

function formatBooleanBadge(value) {
    return value
        ? '<span style="color:#4ade80">✓ ' + escapeHtml(ADMIN_MEMBER_MSG.yes) + '</span>'
        : '<span style="color:#475569">✗ ' + escapeHtml(ADMIN_MEMBER_MSG.no) + '</span>';
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
        USER: '<spring:message code="admin.role.USER" javaScriptEscape="true"/>',
        BUSINESS: '<spring:message code="admin.role.BUSINESS" javaScriptEscape="true"/>',
        PARTNER: '<spring:message code="admin.role.PARTNER" javaScriptEscape="true"/>',
        BOT: '<spring:message code="admin.role.BOT" javaScriptEscape="true"/>',
        ADMIN: '<spring:message code="admin.role.ADMIN" javaScriptEscape="true"/>',
        SUPERADMIN: '<spring:message code="admin.role.SUPERADMIN" javaScriptEscape="true"/>',
        SYSTEM: '<spring:message code="admin.role.SYSTEM" javaScriptEscape="true"/>'
    };
    return labels[role] || role || '—';
}

function buildSocialHtml(linkedProviders) {
    if (!linkedProviders) {
        return '<span class="adm-social-empty">' + escapeHtml(ADMIN_MEMBER_MSG.noLinkedProvider) + '</span>';
    }

    const providerMap = {
        KAKAO: {
            label: '<spring:message code="admin.social.kakao" javaScriptEscape="true"/>',
            className: 'kakao',
            icon: '<span class="adm-social-icon kakao-mark">k</span>'
        },
        NAVER: {
            label: '<spring:message code="admin.social.naver" javaScriptEscape="true"/>',
            className: 'naver',
            icon: '<span class="adm-social-icon naver-mark">N</span>'
        },
        GOOGLE: {
            label: '<spring:message code="admin.social.google" javaScriptEscape="true"/>',
            className: 'google',
            icon: '<span class="adm-social-icon google-mark"><svg viewBox="0 0 48 48" aria-hidden="true" focusable="false"><path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/><path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/><path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/><path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.18 1.48-4.97 2.36-8.16 2.36-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/></svg></span>'
        }
    };

    const items = linkedProviders
        .split(',')
        .map(provider => provider.trim())
        .filter(provider => provider.length > 0)
        .map(function(provider) {
            const info = providerMap[provider];
            if (!info) {
                return '<span class="adm-social-pill"><span class="adm-social-label">' + escapeHtml(provider) + '</span></span>';
            }
            return '<span class="adm-social-pill ' + info.className + '">' + info.icon + '<span class="adm-social-label">' + escapeHtml(info.label) + '</span></span>';
        });

    if (!items.length) {
        return '<span class="adm-social-empty">' + escapeHtml(ADMIN_MEMBER_MSG.noLinkedProvider) + '</span>';
    }

    return '<div class="adm-social-list">' + items.join('') + '</div>';
}

/* ── 액션 메뉴 토글 ── */
function openBlockModal(triggerOrUserIdx, nickname) {
    const trigger = typeof triggerOrUserIdx === 'object' ? triggerOrUserIdx : null;
    const userIdx = trigger ? trigger.dataset.userIdx : triggerOrUserIdx;
    const resolvedNickname = trigger ? (trigger.dataset.nickname || '') : (nickname || '');

    document.getElementById('blockUserIdx').value = userIdx;
    document.getElementById('blockModalTitle').textContent = (resolvedNickname || '') + ' ' + ADMIN_MEMBER_MSG.blockModalTitleSuffix;
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
        adm_toast(ADMIN_MEMBER_MSG.missingBlockTarget, 'error');
        return;
    }
    if ((blockType === 'IP_ONLY' || blockType === 'USER_IP') && !blockedIp) {
        adm_toast('<spring:message code="admin.context.requireBlockedIp" javaScriptEscape="true"/>', 'error');
        document.getElementById('blockedIp').focus();
        return;
    }

    submitBtn.disabled = true;
    const originalText = submitBtn.textContent;
    submitBtn.textContent = ADMIN_MEMBER_MSG.applying;

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
            throw new Error(text || ADMIN_MEMBER_MSG.parsingBlockResponse);
        }

        if (res.ok && data && data.success) {
            closeBlockModal();
            adm_toast(ADMIN_MEMBER_MSG.blockApplied || '<spring:message code="admin.context.toast.saveBlockSuccess" javaScriptEscape="true"/>');
            setTimeout(() => refreshMemberSection(), 800);
        } else {
            adm_toast((data && data.message) || '<spring:message code="admin.context.toast.saveBlockFail" javaScriptEscape="true"/>', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast(e.message || '<spring:message code="admin.context.toast.saveBlockError" javaScriptEscape="true"/>', 'error');
    } finally {
        submitBtn.disabled = false;
        submitBtn.textContent = originalText;
    }
}

/* ── 상태 변경 ── */
async function changeStatus(userIdx, status, el) {
    const labels = {
        ACTIVE: ADMIN_MEMBER_MSG.statusActive,
        DORMANT: ADMIN_MEMBER_MSG.statusDormant,
        BLOCKED: ADMIN_MEMBER_MSG.statusBlocked,
        DELETED: ADMIN_MEMBER_MSG.statusDeleted
    };
    if (!confirm('<spring:message code="admin.members.confirmStatusChangePrefix" javaScriptEscape="true"/>' + ' "' + (labels[status] || status) + '" ' + '<spring:message code="admin.members.confirmStatusChangeSuffix" javaScriptEscape="true"/>')) return;

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
        adm_toast(ADMIN_MEMBER_MSG.parsingStatusResponse, 'error');
        return;
    }

    if (res.ok && data.success) {
        adm_toast(data.message || '<spring:message code="admin.context.toast.saveStatusSuccess" javaScriptEscape="true"/>');
        setTimeout(() => refreshMemberSection(), 800);
    } else {
        adm_toast(data.message || '<spring:message code="admin.context.toast.saveStatusFail" javaScriptEscape="true"/>', 'error');
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
        adm_toast('<spring:message code="admin.members.roleContextMissing" javaScriptEscape="true"/>', 'error');
        return;
    }
    if (role === currentRole) {
        adm_toast('<spring:message code="admin.members.roleAlreadySelected" javaScriptEscape="true"/>', 'error');
        return;
    }
    if (!reason) {
        adm_toast('<spring:message code="admin.context.requireRoleReason" javaScriptEscape="true"/>', 'error');
        if (reasonInput) reasonInput.focus();
        return;
    }

    changeRole(userIdx, role, reason, button);
}

async function changeRole(userIdx, role, reason, el) {
    if (!confirm('"' + roleLabel(role) + '" ' + '<spring:message code="admin.members.confirmRoleChangeSuffix" javaScriptEscape="true"/>')) return;

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
        adm_toast(ADMIN_MEMBER_MSG.parsingRoleResponse, 'error');
        return;
    }

    if (res.ok && data.success) {
        adm_toast(data.message || '<spring:message code="admin.context.toast.saveRoleSuccess" javaScriptEscape="true"/>');
        setTimeout(() => refreshMemberSection(), 800);
    } else {
        adm_toast(data.message || '<spring:message code="admin.context.toast.saveRoleFail" javaScriptEscape="true"/>', 'error');
    }
}

function buildContextRows(items, renderer, emptyMessage) {
    if (!Array.isArray(items) || !items.length) {
        return '<div style="text-align:center;padding:32px;color:#475569;">' + emptyMessage + '</div>';
    }
    return '<div style="display:flex;flex-direction:column;gap:10px;">' + items.map(renderer).join('') + '</div>';
}

function buildSecurityRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.eventType || '-') + '</strong> / ' + escapeHtml(item.eventStage || '-') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.occurredAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;"><spring:message code="admin.context.inputValue" javaScriptEscape="true"/>: ' + escapeHtml(item.inputIdentifier || '-') + '</div>'
            + '<div style="margin-top:4px;font-size:12px;color:#94a3b8;"><spring:message code="admin.context.targetEmail" javaScriptEscape="true"/>: ' + escapeHtml(item.targetEmail || '-') + '</div>'
            + '</div>';
    }, '<spring:message code="admin.context.empty.security" javaScriptEscape="true"/>');
}

function buildEmailRequestRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.purpose || '-') + '</strong> / ' + escapeHtml(item.status || '-') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.requestedAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;"><spring:message code="admin.context.requestEmail" javaScriptEscape="true"/>: ' + escapeHtml(item.pendingEmail || '-') + '</div>'
            + '</div>';
    }, '<spring:message code="admin.context.empty.emailRequests" javaScriptEscape="true"/>');
}

function buildEmailTokenRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.purpose || '-') + '</strong> / ' + escapeHtml(item.used ? '<spring:message code="admin.context.used" javaScriptEscape="true"/>' : '<spring:message code="admin.context.unused" javaScriptEscape="true"/>') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.createdAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;"><spring:message code="admin.context.targetEmail" javaScriptEscape="true"/>: ' + escapeHtml(item.email || '-') + '</div>'
            + '</div>';
    }, '<spring:message code="admin.context.empty.emailTokens" javaScriptEscape="true"/>');
}

function buildActivityRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.activityCode || '-') + '</strong> / ' + escapeHtml(item.activityDomain || item.activityType || '-') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.createdAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;"><spring:message code="admin.context.uri" javaScriptEscape="true"/>: ' + escapeHtml(item.requestUri || '-') + '</div>'
            + '</div>';
    }, '<spring:message code="admin.context.empty.activity" javaScriptEscape="true"/>');
}

function buildBlockRows(items) {
    return buildContextRows(items, function(item) {
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div><strong>' + escapeHtml(item.blockType || '-') + '</strong> / ' + escapeHtml(item.active ? 'ACTIVE' : 'INACTIVE') + '</div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.blockedAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;color:#cbd5e1;"><spring:message code="admin.common.reason" javaScriptEscape="true"/>: ' + escapeHtml(item.reason || '-') + '</div>'
            + '<div style="margin-top:4px;font-size:12px;color:#94a3b8;">IP: ' + escapeHtml(item.blockedIp || '-') + '</div>'
            + '</div>';
    }, '<spring:message code="admin.context.empty.blocks" javaScriptEscape="true"/>');
}

function buildChatbotLinkClickRows(items) {
    return buildContextRows(items, function(item) {
        const url = item.url || '';
        return ''
            + '<div class="adm-context-record">'
            + '<div style="display:flex;justify-content:space-between;gap:8px;align-items:center;">'
            + '<div style="font-size:13px;"><strong>' + escapeHtml(item.label || '-') + '</strong></div>'
            + '<div style="font-size:12px;color:#94a3b8;">' + escapeHtml(formatHistoryDateTime(item.clickedAt)) + '</div>'
            + '</div>'
            + '<div style="margin-top:6px;font-size:12px;"><a href="' + ctx + escapeHtml(url) + '" target="_blank" style="color:#60a5fa;font-family:monospace;text-decoration:none;">' + escapeHtml(url) + '</a></div>'
            + '<div style="margin-top:4px;font-size:11px;color:#94a3b8;">'
            + 'conv #' + escapeHtml(item.conversationId || '-')
            + ' · msg #' + escapeHtml(item.messageId || '-')
            + ' · IP: ' + escapeHtml(item.ipAddress || '-')
            + (item.userIdx ? '' : ' · <span style="color:#fbbf24;">' + escapeHtml(ADMIN_MEMBER_MSG.anonymous) + '</span>')
            + '</div>'
            + '</div>';
    }, ADMIN_MEMBER_MSG.chatbotEmptyClicks);
}

function buildChatbotTab(initialClicks, loginAudits, userIdx) {
    _chatbotDetailUserIdx = userIdx;
    const ips = [];
    const seen = {};
    (loginAudits || []).forEach(function(a) {
        if (a.ipAddress && !seen[a.ipAddress]) {
            seen[a.ipAddress] = true;
            ips.push(a.ipAddress);
        }
    });

    let ipOptions = '<option value="">' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterSelectIp) + '</option>';
    ips.forEach(function(ip) {
        ipOptions += '<option value="' + escapeHtml(ip) + '">' + escapeHtml(ip) + '</option>';
    });

    return ''
        + '<div class="adm-chatbot-filter">'
        + '<span class="adm-chatbot-filter-label">IP</span>'
        + '<select id="chatbotIpSelect" class="adm-select" style="min-width:140px;font-size:11px;" onchange="chatbotOnIpChange()">'
        + ipOptions
        + '</select>'
        + '<div class="adm-chatbot-mode-group" id="chatbotModeGroup">'
        + '<button type="button" class="adm-chatbot-mode-btn active" data-mode="1" title="' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF1Tip) + '" onclick="chatbotOnModeClick(this)">' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF1) + '</button>'
        + '<button type="button" class="adm-chatbot-mode-btn" data-mode="2" title="' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF2Tip) + '" onclick="chatbotOnModeClick(this)" disabled>' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF2) + '</button>'
        + '<button type="button" class="adm-chatbot-mode-btn" data-mode="3" title="' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF3Tip) + '" onclick="chatbotOnModeClick(this)" disabled>' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF3) + '</button>'
        + '<button type="button" class="adm-chatbot-mode-btn" data-mode="4" title="' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF4Tip) + '" onclick="chatbotOnModeClick(this)" disabled>' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF4) + '</button>'
        + '<button type="button" class="adm-chatbot-mode-btn" data-mode="5" title="' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF5Tip) + '" onclick="chatbotOnModeClick(this)" disabled>' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterF5) + '</button>'
        + '</div>'
        + '</div>'
        + '<div id="chatbotClickRows">' + buildChatbotLinkClickRows(initialClicks) + '</div>';
}

function chatbotOnIpChange() {
    const ip = document.getElementById('chatbotIpSelect').value;
    document.querySelectorAll('#chatbotModeGroup .adm-chatbot-mode-btn').forEach(function(btn) {
        const mode = parseInt(btn.dataset.mode);
        if (mode === 1) return;
        if (ip) {
            btn.disabled = false;
        } else {
            btn.disabled = true;
            btn.classList.remove('active');
        }
    });
    if (!ip) {
        const f1 = document.querySelector('#chatbotModeGroup .adm-chatbot-mode-btn[data-mode="1"]');
        if (f1) f1.classList.add('active');
    }
    const activeBtn = document.querySelector('#chatbotModeGroup .adm-chatbot-mode-btn.active');
    const mode = activeBtn ? parseInt(activeBtn.dataset.mode) : 1;
    chatbotLoadFilter(_chatbotDetailUserIdx, ip || null, !ip ? 1 : mode);
}

function chatbotOnModeClick(btn) {
    if (btn.disabled) return;
    document.querySelectorAll('#chatbotModeGroup .adm-chatbot-mode-btn').forEach(function(b) { b.classList.remove('active'); });
    btn.classList.add('active');
    const ip = document.getElementById('chatbotIpSelect').value || null;
    chatbotLoadFilter(_chatbotDetailUserIdx, ip, parseInt(btn.dataset.mode));
}

async function chatbotLoadFilter(userIdx, ip, mode) {
    const rows = document.getElementById('chatbotClickRows');
    if (!rows) return;
    rows.innerHTML = '<div style="text-align:center;padding:20px;color:#475569;">' + escapeHtml(ADMIN_MEMBER_MSG.loading) + '</div>';
    let url = ctx + '/admin/members/' + userIdx + '/chatbot-clicks?mode=' + (mode || 1);
    if (ip) url += '&ip=' + encodeURIComponent(ip);
    try {
        const res = await fetch(url);
        const data = await res.json();
        rows.innerHTML = buildChatbotLinkClickRows(Array.isArray(data.clicks) ? data.clicks : []);
    } catch (e) {
        rows.innerHTML = '<div style="text-align:center;padding:20px;color:#f87171;">' + escapeHtml(ADMIN_MEMBER_MSG.chatbotFilterLoadFailed) + '</div>';
    }
}

function buildActionTab(m) {
    return ''
        + '<div class="adm-context-actions-grid">'
        + '<div class="adm-context-panel" id="memberProfilePanel">'
        + '<div class="adm-context-panel-title">' + '<spring:message code="admin.context.action.profileTitle" javaScriptEscape="true"/>' + '</div>'
        + '<div class="detail-label">' + '<spring:message code="admin.context.nickname" javaScriptEscape="true"/>' + '</div><input id="memberProfileNickname" class="adm-input" type="text" value="' + escapeHtml(m.nickname || '') + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.nationality" javaScriptEscape="true"/>' + '</div><input id="memberProfileNationality" class="adm-input" type="text" value="' + escapeHtml(m.nationality || '') + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.preferredLanguage" javaScriptEscape="true"/>' + '</div><input id="memberProfileLang" class="adm-input" type="text" value="' + escapeHtml(m.preferredLang || '') + '">'
        + '<button type="button" class="adm-btn adm-btn-primary" style="margin-top:12px;" onclick="saveMemberProfile(' + escapeHtml(m.userIdx) + ', this)">' + '<spring:message code="admin.context.action.saveProfile" javaScriptEscape="true"/>' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel" id="memberEmailPanel">'
        + '<div class="adm-context-panel-title">' + ADMIN_MEMBER_MSG.emailSectionTitle + '</div>'
        + '<div class="detail-label">' + '<spring:message code="admin.context.email" javaScriptEscape="true"/>' + '</div><input id="memberEmailInput" class="adm-input" type="email" placeholder="' + ADMIN_MEMBER_MSG.emailPlaceholder + '" value="' + escapeHtml(m.userEmail || '') + '">'
        + '<div class="adm-cell-link-note" style="margin-top:10px;">' + escapeHtml(ADMIN_MEMBER_MSG.emailResetNotice) + '</div>'
        + '<div style="display:flex;gap:8px;flex-wrap:wrap;margin-top:10px;">'
        + '<span class="status-badge ' + (m.emailVerified ? 'ACTIVE' : 'DORMANT') + '">' + '<spring:message code="admin.members.emailVerified" javaScriptEscape="true"/>' + ': ' + (m.emailVerified ? escapeHtml(ADMIN_MEMBER_MSG.yes) : escapeHtml(ADMIN_MEMBER_MSG.no)) + '</span>'
        + '<span class="status-badge ' + (m.emailLoginEnabled ? 'ACTIVE' : 'DORMANT') + '">' + '<spring:message code="admin.members.emailLoginEnabled" javaScriptEscape="true"/>' + ': ' + (m.emailLoginEnabled ? escapeHtml(ADMIN_MEMBER_MSG.yes) : escapeHtml(ADMIN_MEMBER_MSG.no)) + '</span>'
        + '</div>'
        + '<button type="button" class="adm-btn adm-btn-primary" style="margin-top:12px;" onclick="saveMemberEmail(' + escapeHtml(m.userIdx) + ', this)">' + ADMIN_MEMBER_MSG.saveEmail + '</button>'
        + '</div>'
        + '<div class="adm-context-panel" id="memberStatusRolePanel">'
        + '<div class="adm-context-panel-title">' + '<spring:message code="admin.context.action.statusRoleTitle" javaScriptEscape="true"/>' + '</div>'
        + '<div class="detail-label">' + '<spring:message code="admin.members.accountStatus" javaScriptEscape="true"/>' + '</div>'
        + '<div style="display:flex;gap:8px;"><select id="memberStatusSelect" class="adm-select" style="width:100%;"><option value="ACTIVE"><spring:message code="admin.status.ACTIVE" javaScriptEscape="true"/></option><option value="DORMANT"><spring:message code="admin.status.DORMANT" javaScriptEscape="true"/></option><option value="BLOCKED"><spring:message code="admin.status.BLOCKED" javaScriptEscape="true"/></option><option value="DELETED"><spring:message code="admin.status.DELETED" javaScriptEscape="true"/></option></select><button type="button" class="adm-btn adm-btn-ghost" onclick="applyStatusFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '<spring:message code="admin.common.apply" javaScriptEscape="true"/>' + '</button></div>'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.common.role" javaScriptEscape="true"/>' + '</div>'
        + '<select id="memberRoleSelect" class="adm-select" style="width:100%;"><option value="USER"><spring:message code="admin.role.USER" javaScriptEscape="true"/></option><option value="BUSINESS"><spring:message code="admin.role.BUSINESS" javaScriptEscape="true"/></option><option value="PARTNER"><spring:message code="admin.role.PARTNER" javaScriptEscape="true"/></option><option value="BOT"><spring:message code="admin.role.BOT" javaScriptEscape="true"/></option><option value="ADMIN"><spring:message code="admin.role.ADMIN" javaScriptEscape="true"/></option></select>'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.action.roleReason" javaScriptEscape="true"/>' + '</div>'
        + '<input id="memberRoleReason" class="adm-input" type="text" maxlength="500" placeholder="' + '<spring:message code="admin.context.action.roleReasonPlaceholder" javaScriptEscape="true"/>' + '">'
        + '<button type="button" class="adm-btn adm-btn-ghost" style="margin-top:12px;" onclick="applyRoleFromDetail(' + escapeHtml(m.userIdx) + ', this)">' + '<spring:message code="admin.context.action.changeRole" javaScriptEscape="true"/>' + '</button>'
        + '</div>'
        + '<div class="adm-context-panel" id="memberQuickBlockPanel">'
        + '<div class="adm-context-panel-title">' + '<spring:message code="admin.context.action.quickBlockTitle" javaScriptEscape="true"/>' + '</div>'
        + '<div class="detail-label">' + '<spring:message code="admin.context.action.blockType" javaScriptEscape="true"/>' + '</div><select id="detailBlockType" class="adm-select" style="width:100%;"><option value="USER_ONLY">' + '<spring:message code="admin.context.blockType.userOnly" javaScriptEscape="true"/>' + '</option><option value="IP_ONLY">' + '<spring:message code="admin.context.blockType.ipOnly" javaScriptEscape="true"/>' + '</option><option value="USER_IP">' + '<spring:message code="admin.context.blockType.userIp" javaScriptEscape="true"/>' + '</option></select>'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.blockedIp" javaScriptEscape="true"/>' + '</div><input id="detailBlockedIp" class="adm-input" type="text" placeholder="' + '<spring:message code="admin.context.action.blockIpPlaceholder" javaScriptEscape="true"/>' + '">'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.context.action.blockExpires" javaScriptEscape="true"/>' + '</div><input id="detailBlockedUntil" class="adm-input" type="datetime-local">'
        + '<div class="detail-label" style="margin-top:10px;">' + '<spring:message code="admin.common.reason" javaScriptEscape="true"/>' + '</div><textarea id="detailBlockedReason" class="adm-input" style="min-height:88px;resize:vertical;"></textarea>'
        + '<button type="button" class="adm-btn adm-btn-primary" style="margin-top:12px;" onclick="submitDetailBlock(' + escapeHtml(m.userIdx) + ', this)">' + '<spring:message code="admin.context.action.applyBlock" javaScriptEscape="true"/>' + '</button>'
        + '</div>'
        + '</div>';
}

/* ── 회원 상세 모달 ── */
async function openDetail(userIdx, defaultTab, focusSection) {
    document.getElementById('detailModal').classList.add('open');
    document.getElementById('modalBody').innerHTML =
        '<div style="text-align:center;padding:40px;color:#475569;">' + escapeHtml(ADMIN_MEMBER_MSG.loading) + ' ⏳</div>';

    let data;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx);
        data = await res.json();
    } catch (error) {
        document.getElementById('modalBody').innerHTML =
            '<div style="text-align:center;padding:40px;color:#f87171;">' + escapeHtml(ADMIN_MEMBER_MSG.fetchError) + '</div>';
        return;
    }

    if (!data.success) {
        document.getElementById('modalBody').innerHTML =
            '<div style="text-align:center;padding:40px;color:#f87171;">' + escapeHtml(data.message || ADMIN_MEMBER_MSG.error) + '</div>';
        return;
    }

    const m = data.member || {};
    const h = Array.isArray(data.history) ? data.history : [];
    const securityAudits = Array.isArray(data.securityAudits) ? data.securityAudits : [];
    const emailRequests = Array.isArray(data.emailRequests) ? data.emailRequests : [];
    const emailTokens = Array.isArray(data.emailTokens) ? data.emailTokens : [];
    const activityLogs = Array.isArray(data.activityLogs) ? data.activityLogs : [];
    const recentBlocks = Array.isArray(data.recentBlocks) ? data.recentBlocks : [];
    const chatbotLinkClicks = Array.isArray(data.chatbotLinkClicks) ? data.chatbotLinkClicks : [];
    const loginAudits = Array.isArray(data.loginAudits) ? data.loginAudits : [];
    const activeTab = ['info', 'hist', 'security', 'emails', 'activity', 'blocks', 'chatbot', 'actions'].includes(defaultTab) ? defaultTab : 'info';

    document.getElementById('modalTitle').textContent = (m.nickname || ADMIN_MEMBER_MSG.memberDetailsTitle) + ' ' + ADMIN_MEMBER_MSG.memberDetailsSuffix;

    document.getElementById('modalBody').innerHTML = ''
        + '<div class="adm-tabs-nav" id="detailTabsNav">'
        + '<div class="adm-tabs">'
        + '<button class="adm-tab ' + (activeTab === 'info' ? 'active' : '') + '" data-tab="info">' + escapeHtml(ADMIN_MEMBER_MSG.infoTab) + '</button>'
        + '<button class="adm-tab ' + (activeTab === 'hist' ? 'active' : '') + '" data-tab="hist">' + escapeHtml(ADMIN_MEMBER_MSG.loginTab) + ' (' + h.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'security' ? 'active' : '') + '" data-tab="security">' + escapeHtml(ADMIN_MEMBER_MSG.securityTab) + ' (' + securityAudits.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'emails' ? 'active' : '') + '" data-tab="emails">' + escapeHtml(ADMIN_MEMBER_MSG.emailHistoryTab) + '</button>'
        + '<button class="adm-tab ' + (activeTab === 'activity' ? 'active' : '') + '" data-tab="activity">' + escapeHtml(ADMIN_MEMBER_MSG.activityTab) + ' (' + activityLogs.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'blocks' ? 'active' : '') + '" data-tab="blocks">' + escapeHtml(ADMIN_MEMBER_MSG.blockTab) + ' (' + recentBlocks.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'chatbot' ? 'active' : '') + '" data-tab="chatbot">' + escapeHtml(ADMIN_MEMBER_MSG.chatbotTab) + ' (' + chatbotLinkClicks.length + ')</button>'
        + '<button class="adm-tab ' + (activeTab === 'actions' ? 'active' : '') + '" data-tab="actions">' + escapeHtml(ADMIN_MEMBER_MSG.actionsTab) + '</button>'
        + '</div>'
        + '<div class="adm-tabs-more" id="detailTabsMore" style="display:none;">'
        + '<button type="button" class="adm-tabs-more-btn" id="detailTabsMoreBtn">' + escapeHtml(ADMIN_MEMBER_MSG.tabMore) + '</button>'
        + '<div class="adm-tabs-dropdown" id="detailTabsDropdown" style="display:none;"></div>'
        + '</div>'
        + '</div>'
        + '<div id="tab-info" style="display:' + (activeTab === 'info' ? '' : 'none') + ';"></div>'
        + '<div id="tab-hist" style="display:' + (activeTab === 'hist' ? '' : 'none') + ';"></div>'
        + '<div id="tab-security" style="display:' + (activeTab === 'security' ? '' : 'none') + ';"></div>'
        + '<div id="tab-emails" style="display:' + (activeTab === 'emails' ? '' : 'none') + ';"></div>'
        + '<div id="tab-activity" style="display:' + (activeTab === 'activity' ? '' : 'none') + ';"></div>'
        + '<div id="tab-blocks" style="display:' + (activeTab === 'blocks' ? '' : 'none') + ';"></div>'
        + '<div id="tab-chatbot" style="display:' + (activeTab === 'chatbot' ? '' : 'none') + ';"></div>'
        + '<div id="tab-actions" style="display:' + (activeTab === 'actions' ? '' : 'none') + ';"></div>';

    document.getElementById('tab-info').innerHTML = buildInfoTab(m);
    document.getElementById('tab-hist').innerHTML = buildHistTab(h);
    document.getElementById('tab-security').innerHTML = buildSecurityRows(securityAudits);
    document.getElementById('tab-emails').innerHTML = ''
        + '<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:16px;">'
        + '<div><div style="font-weight:700;margin-bottom:10px;">' + '<spring:message code="admin.context.tab.emailRequests" javaScriptEscape="true"/>' + '</div>' + buildEmailRequestRows(emailRequests) + '</div>'
        + '<div><div style="font-weight:700;margin-bottom:10px;">' + '<spring:message code="admin.context.tab.emailTokens" javaScriptEscape="true"/>' + '</div>' + buildEmailTokenRows(emailTokens) + '</div>'
        + '</div>';
    document.getElementById('tab-activity').innerHTML = buildActivityRows(activityLogs);
    document.getElementById('tab-blocks').innerHTML = buildBlockRows(recentBlocks);
    document.getElementById('tab-chatbot').innerHTML = buildChatbotTab(chatbotLinkClicks, loginAudits, userIdx);
    document.getElementById('tab-actions').innerHTML = buildActionTab(m);
    initDetailTabsNav(activeTab);
    const statusSelect = document.getElementById('memberStatusSelect');
    const roleSelect = document.getElementById('memberRoleSelect');
    if (statusSelect) statusSelect.value = m.accountStatus || 'ACTIVE';
    if (roleSelect) roleSelect.value = m.userRole || 'USER';
    if (focusSection) {
        focusMemberSection(activeTab, focusSection);
    }
}

function focusMemberSection(activeTab, focusSection) {
    if (activeTab === 'actions') {
        const panelMap = {
            email: 'memberEmailPanel',
            statusRole: 'memberStatusRolePanel',
            quickBlock: 'memberQuickBlockPanel',
            profile: 'memberProfilePanel'
        };
        const targetId = panelMap[focusSection];
        const panel = targetId ? document.getElementById(targetId) : null;
        if (panel) {
            panel.classList.add('is-focus-flash');
            panel.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
            const focusable = panel.querySelector('input, textarea, select, button');
            if (focusable) {
                focusable.focus({ preventScroll: true });
                if (typeof focusable.select === 'function' && focusSection === 'email') {
                    focusable.select();
                }
            }
            setTimeout(() => panel.classList.remove('is-focus-flash'), 1800);
        }
        return;
    }

    if (activeTab === 'hist') {
        const table = document.querySelector('#tab-hist table');
        if (table) table.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    }
}

function buildInfoTab(m) {
    const statusBadge = buildStatusBadge(m.accountStatus);
    const roleBadge = buildRoleBadge(m.userRole);
    const socialHtml = buildSocialHtml(m.linkedProviders);
    const lastLoginText = formatDateTime(m.lastLoginAt);

    return ''
        + '<div class="detail-grid">'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.memberNo" javaScriptEscape="true"/>' + '</div><div class="detail-value">#' + escapeHtml(m.userIdx) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.userId" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatNullable(m.userId) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.nickname" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatNullable(m.nickname) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.email" javaScriptEscape="true"/>' + '</div><div class="detail-value" style="font-size:12px;">' + formatNullable(m.userEmail) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.members.accountStatus" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + statusBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.common.role" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + roleBadge + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.nationality" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatNullable(m.nationality) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.preferredLanguage" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatNullable(m.preferredLang) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.members.emailVerified" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatBooleanBadge(m.emailVerified) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.members.emailLoginEnabled" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatBooleanBadge(m.emailLoginEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.members.passwordLoginEnabled" javaScriptEscape="true"/>' + '</div><div class="detail-value">' + formatBooleanBadge(m.passwordEnabled) + '</div></div>'
        + '<div class="detail-item"><div class="detail-label">' + '<spring:message code="admin.context.createdAt" javaScriptEscape="true"/>' + '</div><div class="detail-value" style="font-size:12px;">' + formatDateTime(m.createdAt) + '</div></div>'
        + '</div>'
        + '<div class="detail-item" style="margin-top:12px;">'
        + '<div class="detail-label">' + '<spring:message code="admin.members.socialLinked" javaScriptEscape="true"/>' + '</div>'
        + '<div class="detail-value" style="margin-top:4px;">' + socialHtml + '</div>'
        + '</div>'
        + '<div style="margin-top:12px;display:flex;gap:8px;flex-wrap:wrap;">'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">' + '<spring:message code="admin.members.loginSuccess" javaScriptEscape="true"/>' + '</div>'
        + '<div style="font-size:20px;font-weight:700;color:#4ade80;margin-top:4px;">' + escapeHtml(m.loginSuccessCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:100px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">' + '<spring:message code="admin.members.loginFailure" javaScriptEscape="true"/>' + '</div>'
        + '<div style="font-size:20px;font-weight:700;color:#f87171;margin-top:4px;">' + escapeHtml(m.loginFailCount ?? 0) + '</div>'
        + '</div>'
        + '<div style="background:#1a2030;border-radius:8px;padding:10px 16px;flex:1;min-width:120px;text-align:center;">'
        + '<div style="font-size:10px;color:#64748b;font-weight:700;text-transform:uppercase;">' + '<spring:message code="admin.context.lastLogin" javaScriptEscape="true"/>' + '</div>'
        + '<div style="font-size:12px;font-weight:600;color:#94a3b8;margin-top:4px;">' + escapeHtml(lastLoginText) + '</div>'
        + '</div>'
        + '</div>';
}

function buildHistTab(history) {
    if (!history.length) {
        return '<div style="text-align:center;padding:32px;color:#475569;">' + '<spring:message code="admin.context.empty.logins" javaScriptEscape="true"/>' + '</div>';
    }

    const methodMap = {
        ID: '<spring:message code="admin.context.userId" javaScriptEscape="true"/>',
        EMAIL: '<spring:message code="admin.context.email" javaScriptEscape="true"/>',
        KAKAO: '<spring:message code="admin.social.kakao" javaScriptEscape="true"/>',
        NAVER: '<spring:message code="admin.social.naver" javaScriptEscape="true"/>',
        GOOGLE: '<spring:message code="admin.social.google" javaScriptEscape="true"/>'
    };

    let rows = '';
    history.forEach(function(item) {
        const ok = !!item.success;
        rows += ''
            + '<tr>'
            + '<td>' + escapeHtml(formatHistoryDateTime(item.loginAt)) + '</td>'
            + '<td>' + escapeHtml(methodMap[item.loginMethod] || item.loginMethod || '—') + '</td>'
            + '<td class="' + (ok ? 'h-success' : 'h-fail') + '">' + (ok ? '✅ ' + '<spring:message code="admin.logs.success" javaScriptEscape="true"/>' : '❌ ' + '<spring:message code="admin.logs.failure" javaScriptEscape="true"/>') + '</td>'
            + '<td>' + escapeHtml(item.failReason || '—') + '</td>'
            + '<td style="font-size:11px;color:#475569;">' + escapeHtml(item.ipAddress || '—') + '</td>'
            + '</tr>';
    });

    return ''
        + '<div style="overflow-x:auto;max-height:340px;overflow-y:auto;">'
        + '<table class="history-table">'
        + '<thead><tr><th>' + '<spring:message code="admin.common.time" javaScriptEscape="true"/>' + '</th><th>' + '<spring:message code="admin.logs.provider" javaScriptEscape="true"/>' + '</th><th>' + '<spring:message code="admin.logs.success" javaScriptEscape="true"/>' + '</th><th>' + '<spring:message code="admin.logs.failReason" javaScriptEscape="true"/>' + '</th><th><spring:message code="admin.common.ip" javaScriptEscape="true"/></th></tr></thead>'
        + '<tbody>' + rows + '</tbody>'
        + '</table>'
        + '</div>';
}

const DETAIL_TAB_KEYS = ['info', 'hist', 'security', 'emails', 'activity', 'blocks', 'chatbot', 'actions'];

function switchTab(tabKey) {
    DETAIL_TAB_KEYS.forEach(function(name) {
        const el = document.getElementById('tab-' + name);
        if (el) el.style.display = tabKey === name ? '' : 'none';
    });
    const nav = document.getElementById('detailTabsNav');
    if (!nav) return;
    nav.querySelectorAll('.adm-tab').forEach(function(b) { b.classList.remove('active'); });
    nav.querySelectorAll('.adm-tab[data-tab="' + tabKey + '"]').forEach(function(b) { b.classList.add('active'); });
    const moreBtn = document.getElementById('detailTabsMoreBtn');
    if (moreBtn) {
        const inDropdown = !!document.querySelector('#detailTabsDropdown .adm-tab[data-tab="' + tabKey + '"]');
        moreBtn.classList.toggle('has-active', inDropdown);
    }
}

function initDetailTabsNav(activeTab) {
    const nav = document.getElementById('detailTabsNav');
    if (!nav) return;

    const row = nav.querySelector('.adm-tabs');
    const moreWrap = document.getElementById('detailTabsMore');
    const moreBtn = document.getElementById('detailTabsMoreBtn');
    const dropdown = document.getElementById('detailTabsDropdown');

    // 이벤트 위임 — row와 dropdown 모두 커버
    nav.addEventListener('click', function(e) {
        const btn = e.target.closest('.adm-tab[data-tab]');
        if (!btn) return;
        dropdown.style.display = 'none';
        switchTab(btn.dataset.tab);
    });

    moreBtn.addEventListener('click', function(e) {
        e.stopPropagation();
        dropdown.style.display = dropdown.style.display === 'none' ? '' : 'none';
    });

    document.addEventListener('click', function _closeDropdown() {
        if (!dropdown) { document.removeEventListener('click', _closeDropdown); return; }
        dropdown.style.display = 'none';
    });

    function reflow() {
        const allTabs = Array.from(row.querySelectorAll(':scope > .adm-tab'));
        // 전체 복원 후 측정
        allTabs.forEach(function(t) { t.style.display = ''; });
        moreWrap.style.display = 'none';
        dropdown.innerHTML = '';

        const navWidth = nav.offsetWidth;
        const totalTabsWidth = allTabs.reduce(function(acc, t) { return acc + t.offsetWidth + 2; }, 0);

        if (totalTabsWidth <= navWidth) {
            if (moreBtn) moreBtn.classList.remove('has-active');
            return;
        }

        // 더보기 버튼이 필요함 — 버튼 너비 확보
        moreWrap.style.display = '';
        const availWidth = navWidth - moreWrap.offsetWidth - 2;

        // 앞에서부터 누적해서 자를 위치 결정
        let acc = 0;
        let cutAt = allTabs.length;
        for (let i = 0; i < allTabs.length; i++) {
            acc += allTabs[i].offsetWidth + 2;
            if (acc > availWidth) { cutAt = i; break; }
        }

        // cutAt 이후 탭 → 숨기고 드롭다운에 복제
        let hasActiveInDropdown = false;
        for (let i = cutAt; i < allTabs.length; i++) {
            const original = allTabs[i];
            if (original.classList.contains('active')) hasActiveInDropdown = true;
            original.style.display = 'none';
            const clone = original.cloneNode(true);
            clone.style.display = '';
            dropdown.appendChild(clone);
        }
        moreBtn.classList.toggle('has-active', hasActiveInDropdown);
    }

    reflow();

    if (_detailTabsRo) _detailTabsRo.disconnect();
    _detailTabsRo = new ResizeObserver(reflow);
    _detailTabsRo.observe(nav);
}

async function saveMemberProfile(userIdx, button) {
    const nickname = document.getElementById('memberProfileNickname').value.trim();
    const nationality = document.getElementById('memberProfileNationality').value.trim();
    const preferredLang = document.getElementById('memberProfileLang').value.trim();

    button.disabled = true;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/profile', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ nickname, nationality, preferredLang })
        });
        const data = await res.json();
        if (res.ok && data.success) {
            adm_toast(data.message || '<spring:message code="admin.context.toast.saveProfileSuccess" javaScriptEscape="true"/>');
            setTimeout(() => refreshMemberSection(), 700);
        } else {
            adm_toast(data.message || '<spring:message code="admin.context.toast.saveProfileFail" javaScriptEscape="true"/>', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast('<spring:message code="admin.context.toast.saveProfileError" javaScriptEscape="true"/>', 'error');
    } finally {
        button.disabled = false;
    }
}

async function saveMemberEmail(userIdx, button) {
    const email = document.getElementById('memberEmailInput').value.trim();

    button.disabled = true;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/email', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ email })
        });
        const data = await res.json();
        if (res.ok && data.success) {
            adm_toast(data.message || ADMIN_MEMBER_MSG.emailUpdated);
            await openDetail(userIdx, 'actions', 'email');
        } else {
            adm_toast(data.message || '<spring:message code="admin.common.saveFailed" javaScriptEscape="true"/>', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast('<spring:message code="admin.common.saveFailed" javaScriptEscape="true"/>', 'error');
    } finally {
        button.disabled = false;
    }
}

function applyStatusFromDetail(userIdx, button) {
    const status = document.getElementById('memberStatusSelect').value;
    changeStatus(userIdx, status, button);
}

function applyRoleFromDetail(userIdx, button) {
    const role = document.getElementById('memberRoleSelect').value;
    const reason = document.getElementById('memberRoleReason').value.trim();
    if (!reason) {
        adm_toast('<spring:message code="admin.context.requireRoleReason" javaScriptEscape="true"/>', 'error');
        return;
    }
    changeRole(userIdx, role, reason, button);
}

async function submitDetailBlock(userIdx, button) {
    const blockType = document.getElementById('detailBlockType').value;
    const blockedIp = document.getElementById('detailBlockedIp').value.trim();
    const expiresAt = document.getElementById('detailBlockedUntil').value;
    const reason = document.getElementById('detailBlockedReason').value.trim();

    if ((blockType === 'IP_ONLY' || blockType === 'USER_IP') && !blockedIp) {
        adm_toast('<spring:message code="admin.context.requireBlockedIp" javaScriptEscape="true"/>', 'error');
        return;
    }

    button.disabled = true;
    try {
        const res = await fetch(ctx + '/admin/members/' + userIdx + '/block', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: new URLSearchParams({ blockType, blockedIp, expiresAt, reason })
        });
        const data = await res.json();
        if (res.ok && data.success) {
            adm_toast(data.message || '<spring:message code="admin.context.toast.saveBlockSuccess" javaScriptEscape="true"/>');
            setTimeout(() => refreshMemberSection(), 700);
        } else {
            adm_toast(data.message || '<spring:message code="admin.context.toast.saveBlockFail" javaScriptEscape="true"/>', 'error');
        }
    } catch (e) {
        console.error(e);
        adm_toast('<spring:message code="admin.context.toast.saveBlockError" javaScriptEscape="true"/>', 'error');
    } finally {
        button.disabled = false;
    }
}

function closeDetail() {
    if (_detailTabsRo) { _detailTabsRo.disconnect(); _detailTabsRo = null; }
    document.getElementById('detailModal').classList.remove('open');
    // 외부에서 ?detailUserIdx=N 으로 들어와 자동 오픈된 경우, 닫힘 후 파라미터 제거 (리프레시 재오픈 방지)
    try {
        const url = new URL(window.location.href);
        if (url.searchParams.has('detailUserIdx')) {
            url.searchParams.delete('detailUserIdx');
            window.history.replaceState(null, '', url.toString());
        }
    } catch (e) {}
}

document.getElementById('detailModal').addEventListener('click', function (e) {
    if (e.target === this) closeDetail();
});

document.getElementById('blockModal').addEventListener('click', function (e) {
    if (e.target === this) closeBlockModal();
});

document.addEventListener('click', function (e) {
    const detailTrigger = e.target.closest('.js-member-open-detail');
    if (!detailTrigger) return;
    openDetail(detailTrigger.dataset.userIdx, detailTrigger.dataset.defaultTab, detailTrigger.dataset.focusSection);
});

document.addEventListener('DOMContentLoaded', function () {
    updateBulkBar();

    // URL 파라미터로 상세 자동 오픈
    const detailUserIdx = '${fn:escapeXml(param.detailUserIdx)}';
    if (detailUserIdx) {
        openDetail(detailUserIdx);
    }
});
</script>

<%@ include file="../layout-close.jsp" %>
