<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_deb7421309" code="admin.common.search"/>
<spring:message var="autoMsg_451b466735" code="admin.logs.searchPlaceholder"/>
<spring:message var="autoMsg_609d3980d4" code="admin.logs.event"/>
<spring:message var="autoMsg_b4cf135b1f" code="admin.common.all"/>
<spring:message var="autoMsg_105a65889a" code="admin.logs.event.login"/>
<spring:message var="autoMsg_1276967587" code="admin.logs.event.logout"/>
<spring:message var="autoMsg_d6d6b6df6d" code="admin.logs.success"/>
<spring:message var="autoMsg_0d6d3c82fe" code="admin.common.success"/>
<spring:message var="autoMsg_4021c04f25" code="admin.common.fail"/>
<spring:message var="autoMsg_12cde594a6" code="admin.logs.authType"/>
<spring:message var="autoMsg_7b3817e680" code="admin.logs.authType.password"/>
<spring:message var="autoMsg_af0834ff44" code="admin.logs.authType.social"/>
<spring:message var="autoMsg_bba7344d3d" code="admin.logs.provider"/>
<spring:message var="autoMsg_77c6672043" code="admin.logs.provider.local"/>
<spring:message var="autoMsg_e29dd87334" code="admin.logs.provider.kakao"/>
<spring:message var="autoMsg_683441ea2d" code="admin.logs.provider.naver"/>
<spring:message var="autoMsg_0f38cff5f5" code="admin.logs.provider.google"/>
<spring:message var="autoMsg_e4d874dc6c" code="admin.logs.authFlow"/>
<spring:message var="autoMsg_db24757bc9" code="admin.logs.authFlow.local"/>
<spring:message var="autoMsg_e7109820db" code="admin.logs.authFlow.id"/>
<spring:message var="autoMsg_a8029c10ad" code="admin.logs.authFlow.email"/>
<spring:message var="autoMsg_a187f1e4af" code="admin.common.searchButton"/>
<spring:message var="autoMsg_3436036fa7" code="admin.common.reset"/>
<spring:message var="autoMsg_10e24a6962" code="admin.common.totalCount"/>
<spring:message var="autoMsg_99d1cdb68a" code="admin.common.export"/>
<spring:message var="autoMsg_16addb1293" code="admin.common.exportAll"/>
<spring:message var="autoMsg_e805869cc3" code="admin.common.exportFiltered"/>
<spring:message var="autoMsg_8062b91cde" code="admin.common.exportSelected"/>
<spring:message var="autoMsg_b7204954ec" code="admin.blocks.mode.label"/>
<spring:message var="autoMsg_4304e3222d" code="admin.blocks.mode.tipClient"/>
<spring:message var="autoMsg_8ccfc3dc76" code="admin.blocks.mode.client"/>
<spring:message var="autoMsg_d6f1eb63b0" code="admin.blocks.mode.tipServer"/>
<spring:message var="autoMsg_0d8e57c1b0" code="admin.blocks.mode.server"/>
<spring:message var="autoMsg_0a7ae34f66" code="admin.common.pageSize"/>
<spring:message var="autoMsg_ba29f08541" code="admin.common.selectedCount"/>
<spring:message var="autoMsg_7f30b7b84e" code="admin.common.clearSelection"/>
<spring:message var="autoMsg_18752b5d43" code="admin.common.time"/>
<spring:message var="autoMsg_2137653abe" code="admin.common.member"/>
<spring:message var="autoMsg_c98077883f" code="admin.context.inputValue"/>
<spring:message var="autoMsg_7fde55a32f" code="admin.common.result"/>
<spring:message var="autoMsg_428678b46b" code="admin.common.reason"/>
<spring:message var="autoMsg_ac2a6870ab" code="admin.common.ip"/>
<spring:message var="autoMsg_bb07223336" code="admin.context.requestId"/>
<spring:message var="autoMsg_1caee27be0" code="admin.common.prev"/>
<spring:message var="autoMsg_9bf192b9b0" code="admin.common.next"/>
<spring:message var="autoMsg_45bc80cb9e" code="admin.common.loadFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_09e942f241" code="admin.common.loadAllFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_2ea95b219e" code="admin.blocks.js.dashSortReset" javaScriptEscape="true"/>
<spring:message var="autoMsg_a86864f87e" code="admin.common.totalCountFormat" javaScriptEscape="true"/>
<spring:message var="autoMsg_b9504dc085" code="admin.common.currentCountFormat" javaScriptEscape="true"/>
<spring:message var="autoMsg_11719678aa" code="admin.common.noResults" javaScriptEscape="true"/>
<spring:message var="autoMsg_dd49fa20c7" code="admin.logs.historyTitle" javaScriptEscape="true"/>
<c:set var="activeMenu" value="logins"/>
<spring:message code="admin.logs.pageTitle" var="adminLogsPageTitle"/>
<c:set var="pageTitle" value="${adminLogsPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form id="loginSearchForm" method="get" action="${pageContext.request.contextPath}/admin/logins">
                <div class="adm-filter-bar">
                    <div class="adm-search-box" style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">${autoMsg_deb7421309}</div>
                        <span class="adm-search-ico">🔍</span>
                        <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(search.keyword)}" placeholder="${autoMsg_451b466735}">
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_609d3980d4}</div>
                        <select class="adm-select" name="eventType">
                            <option value="ALL" ${search.eventType=='ALL'?'selected':''}>${autoMsg_b4cf135b1f}</option>
                            <option value="LOGIN" ${search.eventType=='LOGIN'?'selected':''}>${autoMsg_105a65889a}</option>
                            <option value="LOGOUT" ${search.eventType=='LOGOUT'?'selected':''}>${autoMsg_1276967587}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_d6d6b6df6d}</div>
                        <select class="adm-select" name="success">
                            <option value="ALL" ${search.success=='ALL'?'selected':''}>${autoMsg_b4cf135b1f}</option>
                            <option value="SUCCESS" ${search.success=='SUCCESS'?'selected':''}>${autoMsg_0d6d3c82fe}</option>
                            <option value="FAIL" ${search.success=='FAIL'?'selected':''}>${autoMsg_4021c04f25}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_12cde594a6}</div>
                        <select class="adm-select" name="authType">
                            <option value="ALL" ${search.authType=='ALL'?'selected':''}>${autoMsg_b4cf135b1f}</option>
                            <option value="PASSWORD" ${search.authType=='PASSWORD'?'selected':''}>${autoMsg_7b3817e680}</option>
                            <option value="SOCIAL" ${search.authType=='SOCIAL'?'selected':''}>${autoMsg_af0834ff44}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_bba7344d3d}</div>
                        <select class="adm-select" name="authProvider">
                            <option value="ALL" ${search.authProvider=='ALL'?'selected':''}>${autoMsg_b4cf135b1f}</option>
                            <option value="LOCAL" ${search.authProvider=='LOCAL'?'selected':''}>${autoMsg_77c6672043}</option>
                            <option value="KAKAO" ${search.authProvider=='KAKAO'?'selected':''}>${autoMsg_e29dd87334}</option>
                            <option value="NAVER" ${search.authProvider=='NAVER'?'selected':''}>${autoMsg_683441ea2d}</option>
                            <option value="GOOGLE" ${search.authProvider=='GOOGLE'?'selected':''}>${autoMsg_0f38cff5f5}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_e4d874dc6c}</div>
                        <select class="adm-select" name="loginMethod">
                            <option value="ALL" ${search.loginMethod=='ALL'?'selected':''}>${autoMsg_b4cf135b1f}</option>
                            <option value="LOCAL" ${search.loginMethod=='LOCAL'?'selected':''}>${autoMsg_db24757bc9}</option>
                            <option value="ID" ${search.loginMethod=='ID'?'selected':''}>${autoMsg_e7109820db}</option>
                            <option value="EMAIL" ${search.loginMethod=='EMAIL'?'selected':''}>${autoMsg_a8029c10ad}</option>
                            <option value="KAKAO" ${search.loginMethod=='KAKAO'?'selected':''}>${autoMsg_e29dd87334}</option>
                            <option value="NAVER" ${search.loginMethod=='NAVER'?'selected':''}>${autoMsg_683441ea2d}</option>
                            <option value="GOOGLE" ${search.loginMethod=='GOOGLE'?'selected':''}>${autoMsg_0f38cff5f5}</option>
                        </select>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:8px;">
                        <button class="adm-btn adm-btn-primary" type="submit">${autoMsg_a187f1e4af}</button>
                        <button type="button" class="adm-btn adm-btn-ghost" onclick="resetLoginFilters()">${autoMsg_3436036fa7}</button>
                    </div>

                    <input type="hidden" name="page" value="${search.page}">
                    <input type="hidden" name="size" value="${search.size}">
                    <input type="hidden" id="loginSortFieldInput" name="sortField" value="${fn:escapeXml(search.sortField)}">
                    <input type="hidden" id="loginSortDirInput" name="sortDir" value="${fn:escapeXml(search.sortDir)}">
                    <input type="hidden" id="loginDateFilterInput" name="dateFilter" value="${fn:escapeXml(search.dateFilter)}">
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card adm-managed-section-card js-login-section-card" data-section="loginAudits" data-enhanced="true">
        <div class="adm-card-head">
            <div class="adm-card-title">
                <spring:message code="admin.logs.historyTitle"/>
                <span id="loginTotalLabel" class="adm-section-total-inline">${autoMsg_10e24a6962}</span>
            </div>
            <div class="adm-section-head-actions">
                <select class="adm-select" id="loginExportFormat" style="width:90px;">
                    <option value="csv">CSV</option>
                    <option value="excel">Excel</option>
                </select>
                <div class="adm-export-menu">
                    <button type="button" class="adm-btn adm-btn-ghost js-login-export-toggle">${autoMsg_99d1cdb68a} ▾</button>
                    <div id="loginExportDropdown" class="adm-export-dropdown">
                        <button type="button" onclick="exportLoginAudits('all')">${autoMsg_16addb1293}</button>
                        <button type="button" onclick="exportLoginAudits('search')">${autoMsg_e805869cc3}</button>
                        <button type="button" id="loginExportSelectedBtn" disabled onclick="exportLoginAudits('selected')">${autoMsg_8062b91cde} (0)</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="adm-local-toolbar adm-managed-local-toolbar">
            <div class="adm-local-toolbar-group adm-managed-toolbar-actions">
                <button type="button" class="adm-dash-sort-reset js-login-sort-reset" id="loginSortResetBtn" style="display:none;" onclick="resetLoginSort()"></button>
                <select class="adm-select js-login-section-mode" id="loginModeSelect" title="${autoMsg_b7204954ec}">
                    <option value="client" title="${autoMsg_4304e3222d}">${autoMsg_8ccfc3dc76}</option>
                    <option value="server" title="${autoMsg_d6f1eb63b0}">${autoMsg_0d8e57c1b0}</option>
                </select>
                <select class="adm-select js-login-page-size" id="loginSizeSelect" style="width:90px;" onchange="changeLoginSize(this.value)">
                    <option value="30" ${search.size==30 ? 'selected' : ''}>${autoMsg_0a7ae34f66}</option>
                    <option value="50" ${search.size==50 ? 'selected' : ''}>${autoMsg_0a7ae34f66}</option>
                    <option value="100" ${search.size==100 ? 'selected' : ''}>${autoMsg_0a7ae34f66}</option>
                </select>
            </div>
        </div>
        <div id="loginBulkBar" class="adm-audit-bulk-bar" style="display:none;">
            <span><strong id="loginBulkCount">0</strong>${autoMsg_ba29f08541}</span>
            <button type="button" class="adm-btn adm-btn-ghost" onclick="clearLoginSelection()">${autoMsg_7f30b7b84e}</button>
        </div>

        <div class="adm-table-wrap">
            <table class="adm-table adm-section-table-fixed adm-login-section-table" data-admin-list-ignore="true" data-section="loginAudits">
                <colgroup>
                    <col style="width:44px;">
                    <col style="width:150px;">
                    <col style="width:150px;">
                    <col style="width:92px;">
                    <col style="width:96px;">
                    <col style="width:96px;">
                    <col style="width:150px;">
                    <col style="width:190px;">
                    <col style="width:88px;">
                    <col style="width:180px;">
                    <col style="width:128px;">
                    <col style="width:210px;">
                    <col style="width:96px;">
                </colgroup>
                <thead>
                <tr>
                    <th class="adm-check-cell"><input type="checkbox" id="loginCheckAll" class="adm-check" onchange="toggleAllLogin(this)"></th>
                    <th class="js-login-sort" data-sort="time" onclick="loginSortBy('time')">${autoMsg_18752b5d43}</th>
                    <th class="js-login-sort" data-sort="member" onclick="loginSortBy('member')">${autoMsg_2137653abe}</th>
                    <th class="js-login-sort" data-sort="eventType" onclick="loginSortBy('eventType')">${autoMsg_609d3980d4}</th>
                    <th class="js-login-sort" data-sort="authType" onclick="loginSortBy('authType')">${autoMsg_12cde594a6}</th>
                    <th class="js-login-sort" data-sort="provider" onclick="loginSortBy('provider')">${autoMsg_bba7344d3d}</th>
                    <th class="js-login-sort" data-sort="loginMethod" onclick="loginSortBy('loginMethod')">${autoMsg_e4d874dc6c}</th>
                    <th class="js-login-sort" data-sort="input" onclick="loginSortBy('input')">${autoMsg_c98077883f}</th>
                    <th class="js-login-sort" data-sort="success" onclick="loginSortBy('success')">${autoMsg_7fde55a32f}</th>
                    <th class="js-login-sort" data-sort="reason" onclick="loginSortBy('reason')">${autoMsg_428678b46b}</th>
                    <th class="js-login-sort" data-sort="ip" onclick="loginSortBy('ip')">${autoMsg_ac2a6870ab}</th>
                    <th class="js-login-sort" data-sort="requestId" onclick="loginSortBy('requestId')">${autoMsg_bb07223336}</th>
                    <th></th>
                </tr>
                </thead>
                <tbody id="loginRowsBody">
                <%@ include file="_loginAuditRowsFragment.jsp" %>
                </tbody>
            </table>
        </div>

        <div class="adm-local-pagination" data-section="loginAudits" id="loginPaging">
            <div class="adm-local-page-info js-login-page-info" data-section="loginAudits">총 ${total}건 / 현재 ${fn:length(list)}건</div>
            <div class="adm-local-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost js-login-prev" onclick="goLoginPage(loginSectionState.page - 1)">${autoMsg_1caee27be0}</button>
                <span class="js-login-page-state" data-section="loginAudits">${paging.currentPage} / ${paging.totalPage}</span>
                <button type="button" class="adm-btn adm-btn-ghost js-login-next" onclick="goLoginPage(loginSectionState.page + 1)">${autoMsg_9bf192b9b0}</button>
            </div>
        </div>
    </div>
</div>

<div id="rowDetailModal" class="adm-modal-overlay" onclick="this.classList.remove('open')">
    <div class="adm-modal" style="max-width:560px;width:100%;" onclick="event.stopPropagation()">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="rowDetailModalTitle"></div>
            <button class="adm-modal-close" onclick="document.getElementById('rowDetailModal').classList.remove('open')">✕</button>
        </div>
        <div class="adm-modal-body" style="padding:20px 24px;max-height:72vh;overflow-y:auto;">
            <dl id="rowDetailModalContent" style="margin:0;"></dl>
        </div>
    </div>
</div>

<script>
const ctx = '${pageContext.request.contextPath}';
const LOGIN_MODE_STORAGE = 'admLoginAuditSectionMode';
const LOGIN_MODE_COOKIE = 'admLoginAuditMode';
const LOGIN_CLIENT_MAX_SIZE = 10000;
const ADMIN_LOGIN_LOCALE = '${fn:escapeXml(pageContext.response.locale.toLanguageTag())}';
const ADMIN_LOGIN_MSG = {
    loadFailed: '${autoMsg_45bc80cb9e}',
    loadAllFailed: '${autoMsg_09e942f241}',
    dashSortReset: '${autoMsg_2ea95b219e}',
    totalCountFormat: '${autoMsg_a86864f87e}',
    currentCountFormat: '${autoMsg_b9504dc085}',
    noResults: '${autoMsg_11719678aa}',
    historyTitle: '${autoMsg_dd49fa20c7}'
};

var loginSectionState = {
    page: Number('${paging.currentPage}' || 1) || 1,
    pageSize: Number('${search.size}' || 30) || 30,
    sortBy: '',
    sortDir: 'DESC',
    mode: 'SERVER',
    clientRows: null,
    clientFilterKey: '',
    clientTotal: 0
};

function showLoginToast(message, type) {
    if (typeof adm_toast === 'function') {
        adm_toast(message, type);
    } else {
        console[type === 'error' ? 'error' : 'log'](message);
    }
}

function escapeHtml(value) {
    return String(value == null ? '' : value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
}

function getLoginSearchForm() {
    return document.getElementById('loginSearchForm');
}

function getLoginTbody() {
    return document.getElementById('loginRowsBody');
}

function getLoginSearchFilterKey() {
    const form = getLoginSearchForm();
    if (!form) return '';
    const params = new URLSearchParams();
    new FormData(form).forEach(function (val, key) {
        if (['page', 'size', 'sortField', 'sortDir', 'mode'].includes(key)) return;
        if (val != null && String(val).trim().length > 0) params.append(key, String(val).trim());
    });
    return params.toString();
}

function buildLoginParams(pageOverride, options) {
    options = options || {};
    const form = getLoginSearchForm();
    const params = new URLSearchParams();
    if (form) {
        new FormData(form).forEach(function (val, key) {
            if (['page', 'size', 'sortField', 'sortDir', 'mode'].includes(key)) return;
            if (val != null && String(val).trim().length > 0) params.append(key, String(val).trim());
        });
    }
    const targetPage = pageOverride != null ? Number(pageOverride) : Number(loginSectionState.page || 1);
    params.set('page', String(Math.max(1, targetPage || 1)));
    params.set('size', String(options.clientFetch ? LOGIN_CLIENT_MAX_SIZE : (loginSectionState.pageSize || 30)));
    params.set('mode', options.clientFetch ? 'CLIENT' : loginSectionState.mode);
    if (options.includeSort !== false && loginSectionState.sortBy) {
        params.set('sortField', loginSectionState.sortBy);
        params.set('sortDir', loginSectionState.sortDir === 'ASC' ? 'ASC' : 'DESC');
    }
    return params;
}

function syncLoginHiddenInputs() {
    const form = getLoginSearchForm();
    if (!form) return;
    const pageInput = form.querySelector('[name=page]');
    const sizeInput = form.querySelector('[name=size]');
    const sortFieldInput = document.getElementById('loginSortFieldInput');
    const sortDirInput = document.getElementById('loginSortDirInput');
    if (pageInput) pageInput.value = String(loginSectionState.page || 1);
    if (sizeInput) sizeInput.value = String(loginSectionState.pageSize || 30);
    if (sortFieldInput) sortFieldInput.value = loginSectionState.sortBy || '';
    if (sortDirInput) sortDirInput.value = loginSectionState.sortBy ? loginSectionState.sortDir : '';
}

function setLoginModeCookie(mode) {
    document.cookie = LOGIN_MODE_COOKIE + '=' + (mode === 'CLIENT' ? 'client' : 'server') + ';path=' + (ctx || '/') + ';max-age=31536000;samesite=lax';
}

function loadStoredLoginMode() {
    try {
        const stored = localStorage.getItem(LOGIN_MODE_STORAGE);
        return stored === 'CLIENT' ? 'CLIENT' : 'SERVER';
    } catch (e) {
        return 'SERVER';
    }
}

function saveLoginMode(mode) {
    loginSectionState.mode = mode === 'CLIENT' ? 'CLIENT' : 'SERVER';
    try { localStorage.setItem(LOGIN_MODE_STORAGE, loginSectionState.mode); } catch (e) {}
    setLoginModeCookie(loginSectionState.mode);
    const select = document.getElementById('loginModeSelect');
    if (select) select.value = loginSectionState.mode === 'CLIENT' ? 'client' : 'server';
}

function updateLoginSortIndicators() {
    document.querySelectorAll('th[data-sort]').forEach(function (th) {
        const active = !!loginSectionState.sortBy && th.dataset.sort === loginSectionState.sortBy;
        th.classList.toggle('sorted', active);
        let ico = th.querySelector('.sort-ico');
        if (active) {
            if (!ico) {
                ico = document.createElement('span');
                ico.className = 'sort-ico';
                ico.style.cssText = 'font-size:10px;margin-left:4px;font-weight:900;';
                th.appendChild(ico);
            }
            ico.textContent = loginSectionState.sortDir === 'DESC' ? '▼' : '▲';
            ico.style.color = loginSectionState.sortDir === 'DESC' ? '#3b82f6' : '#ef4444';
        } else if (ico) {
            ico.remove();
        }
    });
    const resetBtn = document.querySelector('.js-login-sort-reset');
    if (resetBtn) {
        resetBtn.textContent = ADMIN_LOGIN_MSG.dashSortReset;
        resetBtn.style.display = loginSectionState.sortBy ? '' : 'none';
    }
}

function updateLoginTotal(total) {
    const cardTitleCounter = document.getElementById('loginTotalLabel');
    if (cardTitleCounter) {
        cardTitleCounter.textContent = '총 ' + Number(total || 0).toLocaleString() + '건';
    }
}

function updateLoginPaginationMeta(page, totalPages, total, renderedCount) {
    const safePages = Math.max(1, Number(totalPages || 1));
    const safePage = Math.min(Math.max(1, Number(page || 1)), safePages);
    loginSectionState.page = safePage;
    const pageInfo = document.querySelector('.js-login-page-info');
    if (pageInfo) {
        const totalText = ADMIN_LOGIN_MSG.totalCountFormat.replace('{0}', Number(total || 0).toLocaleString());
        const currentText = ADMIN_LOGIN_MSG.currentCountFormat.replace('{0}', Number(renderedCount || 0).toLocaleString());
        pageInfo.textContent = totalText + ' / ' + currentText;
    }
    const pageState = document.querySelector('.js-login-page-state');
    if (pageState) pageState.textContent = safePage + ' / ' + safePages;
    const prevBtn = document.querySelector('.js-login-prev');
    const nextBtn = document.querySelector('.js-login-next');
    if (prevBtn) prevBtn.disabled = safePage <= 1;
    if (nextBtn) nextBtn.disabled = safePage >= safePages;
    updateLoginTotal(total);
    syncLoginHiddenInputs();
}

function loginSortValue(row, field) {
    if (!row || !field) return '';
    if (field === 'time') return row.dataset.time || '0';
    if (field === 'member') return row.dataset.member || '';
    if (field === 'eventType') return row.dataset.eventType || '';
    if (field === 'authType') return row.dataset.authType || '';
    if (field === 'provider') return row.dataset.provider || '';
    if (field === 'loginMethod') return row.dataset.loginMethod || '';
    if (field === 'input') return row.dataset.input || '';
    if (field === 'success') return row.dataset.success || '0';
    if (field === 'reason') return row.dataset.reason || '';
    if (field === 'ip') return row.dataset.ip || '';
    if (field === 'requestId') return row.dataset.requestId || '';
    return row.dataset.time || '0';
}

function compareLoginRows(a, b) {
    const field = loginSectionState.sortBy;
    if (!field) {
        return Number(a.dataset.originalIndex || 0) - Number(b.dataset.originalIndex || 0);
    }
    const av = loginSortValue(a, field);
    const bv = loginSortValue(b, field);
    const numericFields = ['time', 'success'];
    let cmp;
    if (numericFields.includes(field)) {
        cmp = (Number(av) || 0) - (Number(bv) || 0);
    } else {
        cmp = String(av).localeCompare(String(bv), ADMIN_LOGIN_LOCALE || undefined, {numeric: true, sensitivity: 'base'});
    }
    if (cmp === 0) {
        cmp = (Number(a.dataset.time || 0) - Number(b.dataset.time || 0));
    }
    return cmp * (loginSectionState.sortDir === 'DESC' ? -1 : 1);
}

function markLoginOriginalIndices(rows) {
    rows.forEach(function (row, idx) {
        if (row.dataset.originalIndex == null) row.dataset.originalIndex = String(idx);
    });
}

function renderLoginEmptyRow() {
    return '<tr class="adm-local-empty"><td colspan="13" style="text-align:center;color:#64748b;padding:32px;">' + escapeHtml(ADMIN_LOGIN_MSG.noResults) + '</td></tr>';
}

async function renderServerLogins(pageOverride) {
    loginSectionState.mode = 'SERVER';
    const params = buildLoginParams(pageOverride, {includeSort: true});
    const tbody = getLoginTbody();
    if (!tbody) return;
    tbody.classList.add('is-loading');
    try {
        const res = await fetch(ctx + '/admin/logins/fragment?' + params.toString(), {
            credentials: 'same-origin',
            headers: {'Accept': 'text/html', 'X-Requested-With': 'XMLHttpRequest'}
        });
        const html = await res.text();
        if (!res.ok) throw new Error(html || ADMIN_LOGIN_MSG.loadFailed);
        tbody.innerHTML = html.trim() || renderLoginEmptyRow();
        const rows = Array.from(tbody.querySelectorAll('.js-login-row'));
        markLoginOriginalIndices(rows);
        const total = Number(res.headers.get('X-Section-Total') || rows.length || 0);
        const page = Number(res.headers.get('X-Section-Page') || params.get('page') || 1);
        const size = Number(res.headers.get('X-Section-Size') || loginSectionState.pageSize || 30);
        const pages = Number(res.headers.get('X-Section-Pages') || 1);
        loginSectionState.pageSize = [30,50,100].includes(size) ? size : loginSectionState.pageSize;
        const sizeSelect = document.getElementById('loginSizeSelect');
        if (sizeSelect) sizeSelect.value = String(loginSectionState.pageSize);
        updateLoginPaginationMeta(page, pages, total, rows.length);
        updateLoginSortIndicators();
        clearLoginSelection();
    } catch (e) {
        showLoginToast(e.message || ADMIN_LOGIN_MSG.loadFailed, 'error');
    } finally {
        tbody.classList.remove('is-loading');
    }
}

async function ensureClientLoginRows() {
    const filterKey = getLoginSearchFilterKey();
    if (loginSectionState.clientRows && loginSectionState.clientFilterKey === filterKey) return;
    const params = buildLoginParams(1, {clientFetch: true, includeSort: false});
    const res = await fetch(ctx + '/admin/logins/fragment?' + params.toString(), {
        credentials: 'same-origin',
        headers: {'Accept': 'text/html', 'X-Requested-With': 'XMLHttpRequest'}
    });
    const html = await res.text();
    if (!res.ok) throw new Error(html || ADMIN_LOGIN_MSG.loadAllFailed);
    const temp = document.createElement('tbody');
    temp.innerHTML = html;
    const rows = Array.from(temp.querySelectorAll('.js-login-row'));
    markLoginOriginalIndices(rows);
    loginSectionState.clientRows = rows;
    loginSectionState.clientFilterKey = filterKey;
    loginSectionState.clientTotal = Number(res.headers.get('X-Section-Total') || rows.length || 0);
}

async function renderClientLogins(pageOverride) {
    loginSectionState.mode = 'CLIENT';
    const tbody = getLoginTbody();
    if (!tbody) return;
    tbody.classList.add('is-loading');
    try {
        await ensureClientLoginRows();
        let rows = (loginSectionState.clientRows || []).slice();
        rows.sort(compareLoginRows);
        const total = rows.length;
        const pageSize = loginSectionState.pageSize || 30;
        const totalPages = Math.max(1, Math.ceil(total / pageSize));
        const page = Math.min(Math.max(1, Number(pageOverride || loginSectionState.page || 1)), totalPages);
        const start = (page - 1) * pageSize;
        const visible = rows.slice(start, start + pageSize);
        tbody.innerHTML = '';
        if (visible.length === 0) {
            tbody.innerHTML = renderLoginEmptyRow();
        } else {
            visible.forEach(function (row) { tbody.appendChild(row.cloneNode(true)); });
        }
        updateLoginPaginationMeta(page, totalPages, total, visible.length);
        updateLoginSortIndicators();
        clearLoginSelection();
    } catch (e) {
        showLoginToast(e.message || ADMIN_LOGIN_MSG.loadAllFailed, 'error');
    } finally {
        tbody.classList.remove('is-loading');
    }
}

async function renderLoginByMode(pageOverride) {
    if (loginSectionState.mode === 'CLIENT') {
        return renderClientLogins(pageOverride);
    }
    return renderServerLogins(pageOverride);
}

async function refreshLoginSection() {
    if (loginSectionState.mode === 'CLIENT') loginSectionState.clientRows = null;
    return renderLoginByMode(loginSectionState.page || 1);
}

function loginSortBy(field) {
    const prevField = loginSectionState.sortBy || '';
    const prevDir = loginSectionState.sortDir || 'DESC';
    loginSectionState.sortBy = field;
    loginSectionState.sortDir = (prevField === field && prevDir === 'ASC') ? 'DESC' : 'ASC';
    loginSectionState.page = 1;
    renderLoginByMode(1);
}

function resetLoginSort() {
    loginSectionState.sortBy = '';
    loginSectionState.sortDir = 'DESC';
    loginSectionState.page = 1;
    renderLoginByMode(1);
}

function resetLoginFilters() {
    const form = getLoginSearchForm();
    if (form) {
        const setValue = function (name, value) {
            const el = form.querySelector('[name=' + name + ']');
            if (el) el.value = value;
        };
        setValue('keyword', '');
        setValue('success', 'ALL');
        setValue('eventType', 'ALL');
        setValue('authType', 'ALL');
        setValue('authProvider', 'ALL');
        setValue('loginMethod', 'ALL');
        setValue('dateFilter', '');
    }
    loginSectionState.page = 1;
    loginSectionState.sortBy = '';
    loginSectionState.sortDir = 'DESC';
    loginSectionState.clientRows = null;
    renderLoginByMode(1);
}

function goLoginPage(page) {
    renderLoginByMode(Math.max(1, Number(page || 1)));
}

function changeLoginSize(size) {
    const parsed = Number(size);
    loginSectionState.pageSize = [30,50,100].includes(parsed) ? parsed : 30;
    loginSectionState.page = 1;
    syncLoginHiddenInputs();
    renderLoginByMode(1);
}

function filterByDate(dateStr) {
    const dateInput = document.getElementById('loginDateFilterInput');
    if (dateInput) dateInput.value = dateStr || '';
    loginSectionState.page = 1;
    loginSectionState.clientRows = null;
    renderLoginByMode(1);
}

function applyKeywordFilter(button) {
    const keyword = button.getAttribute('data-keyword');
    if (!keyword) return;
    const form = getLoginSearchForm();
    const input = form ? form.querySelector('[name=keyword]') : null;
    if (input) input.value = keyword;
    loginSectionState.page = 1;
    loginSectionState.clientRows = null;
    renderLoginByMode(1);
}

function applySelectFilter(button) {
    const paramName = button.getAttribute('data-param-name');
    const paramValue = button.getAttribute('data-param-value');
    if (!paramName || !paramValue) return;
    const form = getLoginSearchForm();
    const input = form ? form.querySelector('[name=' + paramName + ']') : null;
    if (input) input.value = paramValue;
    loginSectionState.page = 1;
    loginSectionState.clientRows = null;
    renderLoginByMode(1);
}


function getLoginCheckedBoxes() {
    return Array.from(document.querySelectorAll('.js-login-row-check:checked'));
}

function toggleAllLogin(cb) {
    document.querySelectorAll('.js-login-row-check').forEach(function (c) { c.checked = cb.checked; });
    updateLoginSelectionState();
}

function clearLoginSelection() {
    document.querySelectorAll('.js-login-row-check').forEach(function (c) { c.checked = false; });
    const all = document.getElementById('loginCheckAll');
    if (all) all.checked = false;
    updateLoginSelectionState();
}

function updateLoginSelectionState() {
    const checked = getLoginCheckedBoxes();
    const n = checked.length;
    const bar = document.getElementById('loginBulkBar');
    if (bar) bar.style.display = n > 0 ? 'flex' : 'none';
    const count = document.getElementById('loginBulkCount');
    if (count) count.textContent = n;
    const selectedBtn = document.getElementById('loginExportSelectedBtn');
    if (selectedBtn) {
        selectedBtn.disabled = n === 0;
        selectedBtn.textContent = '선택 내보내기 (' + n + ')';
    }
    const all = document.getElementById('loginCheckAll');
    if (all) {
        const rows = Array.from(document.querySelectorAll('.js-login-row-check'));
        all.checked = rows.length > 0 && n === rows.length;
        all.indeterminate = n > 0 && n < rows.length;
    }
}

function loginHeaderLabels() {
    return Array.from(document.querySelectorAll('.adm-login-section-table thead th'))
        .slice(1, -1)
        .map(function (th) { return th.textContent.trim(); });
}

function loginRowToExportValues(row) {
    return Array.from(row.children).slice(1, -1).map(function (td) {
        return td.textContent.replace(/\s+/g, ' ').trim();
    });
}

function loginRowsToCsv(rows) {
    const csvEscape = function (v) { return '"' + String(v == null ? '' : v).replace(/"/g, '""') + '"'; };
    const lines = [loginHeaderLabels().map(csvEscape).join(',')];
    rows.forEach(function (row) { lines.push(loginRowToExportValues(row).map(csvEscape).join(',')); });
    return '\ufeff' + lines.join('\r\n');
}

function loginRowsToExcelHtml(rows) {
    const esc = function (v) { return escapeHtml(v); };
    let html = '<table><thead><tr>' + loginHeaderLabels().map(function (h) { return '<th>' + esc(h) + '</th>'; }).join('') + '</tr></thead><tbody>';
    rows.forEach(function (row) {
        html += '<tr>' + loginRowToExportValues(row).map(function (v) { return '<td>' + esc(v) + '</td>'; }).join('') + '</tr>';
    });
    html += '</tbody></table>';
    return '\ufeff<html><head><meta charset="UTF-8"></head><body>' + html + '</body></html>';
}

function downloadLoginBlob(content, filename, mime) {
    const blob = new Blob([content], {type: mime});
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = filename;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
}

async function fetchLoginRowsForExport(scope) {
    if (scope === 'selected') {
        return getLoginCheckedBoxes().map(function (cb) { return cb.closest('tr'); }).filter(Boolean);
    }
    const params = scope === 'all' ? new URLSearchParams() : buildLoginParams(1, {includeSort: true});
    params.set('page', '1');
    params.set('size', String(LOGIN_CLIENT_MAX_SIZE));
    if (scope === 'all') {
        params.set('sortField', loginSectionState.sortBy || '');
        params.set('sortDir', loginSectionState.sortBy ? loginSectionState.sortDir : '');
    }
    const res = await fetch(ctx + '/admin/logins/fragment?' + params.toString(), {
        credentials: 'same-origin',
        headers: {'Accept': 'text/html', 'X-Requested-With': 'XMLHttpRequest'}
    });
    const html = await res.text();
    if (!res.ok) throw new Error(html || ADMIN_LOGIN_MSG.loadAllFailed);
    const temp = document.createElement('tbody');
    temp.innerHTML = html;
    return Array.from(temp.querySelectorAll('.js-login-row'));
}

async function exportLoginAudits(scope) {
    try {
        const rows = await fetchLoginRowsForExport(scope);
        if (!rows.length) { showLoginToast('내보낼 항목이 없습니다.', 'error'); return; }
        const format = (document.getElementById('loginExportFormat') || {}).value === 'excel' ? 'excel' : 'csv';
        const stamp = new Date().toISOString().slice(0, 10).replace(/-/g, '');
        if (format === 'excel') {
            downloadLoginBlob(loginRowsToExcelHtml(rows), 'login-audits-' + scope + '-' + stamp + '.xls', 'application/vnd.ms-excel;charset=utf-8');
        } else {
            downloadLoginBlob(loginRowsToCsv(rows), 'login-audits-' + scope + '-' + stamp + '.csv', 'text/csv;charset=utf-8');
        }
        const dropdown = document.getElementById('loginExportDropdown');
        if (dropdown) dropdown.classList.remove('open');
    } catch (e) {
        showLoginToast(e.message || ADMIN_LOGIN_MSG.loadAllFailed, 'error');
    }
}

function openLoginDetail(btn) {
    var d = btn.dataset;
    showRowDetail(ADMIN_LOGIN_MSG.historyTitle, [
        ['시각', d.time],
        ['회원', d.user],
        ['이벤트', d.event],
        ['인증 유형', d.authType],
        ['공급자', d.provider],
        ['인증 흐름', d.authFlow],
        ['로그인 방법', d.loginMethod],
        ['입력 식별자', d.identifier],
        ['결과', d.success],
        ['사유', d.failReason],
        ['IP', d.ip],
        ['요청 ID', d.requestId],
        ['흐름 추적 ID', d.flowTrace],
        ['세션 ID', d.sessionId],
        ['요청 URI', d.requestUri],
        ['User-Agent', d.userAgent]
    ]);
}

function showRowDetail(title, fields) {
    var modal = document.getElementById('rowDetailModal');
    document.getElementById('rowDetailModalTitle').textContent = title;
    var content = document.getElementById('rowDetailModalContent');
    content.innerHTML = '';
    fields.forEach(function(pair) {
        var label = pair[0], value = pair[1];
        if (!value || value === '' || value === '-') return;
        var dt = document.createElement('dt');
        dt.style.cssText = 'font-size:11px;color:#64748b;margin-top:12px;margin-bottom:2px;font-weight:600;text-transform:uppercase;letter-spacing:.5px;';
        dt.textContent = label;
        var dd = document.createElement('dd');
        dd.style.cssText = 'font-size:13px;color:#e2e8f0;word-break:break-all;margin:0;padding:6px 10px;background:#0f1520;border-radius:4px;';
        dd.textContent = value;
        content.appendChild(dt);
        content.appendChild(dd);
    });
    modal.classList.add('open');
}

function initLoginSection() {
    const sizeSelect = document.getElementById('loginSizeSelect');
    loginSectionState.pageSize = Number(sizeSelect ? sizeSelect.value : loginSectionState.pageSize) || 30;
    const sortFieldInput = document.getElementById('loginSortFieldInput');
    const sortDirInput = document.getElementById('loginSortDirInput');
    loginSectionState.sortBy = sortFieldInput ? sortFieldInput.value : '';
    loginSectionState.sortDir = sortDirInput && sortDirInput.value === 'ASC' ? 'ASC' : 'DESC';
    saveLoginMode(loadStoredLoginMode());

    const modeSelect = document.getElementById('loginModeSelect');
    if (modeSelect) {
        modeSelect.addEventListener('change', function () {
            saveLoginMode(modeSelect.value === 'client' ? 'CLIENT' : 'SERVER');
            loginSectionState.page = 1;
            loginSectionState.clientRows = null;
            renderLoginByMode(1);
        });
    }

    const form = getLoginSearchForm();
    if (form) {
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            loginSectionState.page = 1;
            loginSectionState.clientRows = null;
            renderLoginByMode(1);
        });
    }

    const exportToggle = document.querySelector('.js-login-export-toggle');
    const exportDropdown = document.getElementById('loginExportDropdown');
    if (exportToggle && exportDropdown) {
        exportToggle.addEventListener('click', function (e) { e.stopPropagation(); exportDropdown.classList.toggle('open'); });
        document.addEventListener('click', function (e) {
            if (!exportToggle.contains(e.target) && !exportDropdown.contains(e.target)) exportDropdown.classList.remove('open');
        });
    }

    const existingRows = Array.from(document.querySelectorAll('#loginRowsBody .js-login-row'));
    markLoginOriginalIndices(existingRows);
    updateLoginPaginationMeta(loginSectionState.page, Number((document.querySelector('.js-login-page-state') || {}).textContent?.split('/')[1] || 1), Number('${total}' || existingRows.length), existingRows.length);
    updateLoginSortIndicators();
    updateLoginSelectionState();
    if (loginSectionState.mode === 'CLIENT') renderLoginByMode(1);
}

document.addEventListener('DOMContentLoaded', initLoginSection);
</script>

<%@ include file="../layout-close.jsp" %>
