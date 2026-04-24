<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="logins"/>
<spring:message code="admin.logs.pageTitle" var="adminLogsPageTitle"/>
<c:set var="pageTitle" value="${adminLogsPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/logins">
                <div class="adm-filter-bar">
                    <div class="adm-search-box" style="flex:1;min-width:220px;">
                        <div class="adm-filter-label"><spring:message code="admin.common.search"/></div>
                        <span class="adm-search-ico">🔍</span>
                        <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="<spring:message code='admin.logs.searchPlaceholder'/>">
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.logs.event"/></div>
                        <select class="adm-select" name="eventType">
                            <option value="ALL" ${search.eventType=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="LOGIN" ${search.eventType=='LOGIN'?'selected':''}><spring:message code="admin.logs.event.login"/></option>
                            <option value="LOGOUT" ${search.eventType=='LOGOUT'?'selected':''}><spring:message code="admin.logs.event.logout"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.logs.success"/></div>
                        <select class="adm-select" name="success">
                            <option value="ALL" ${search.success=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="SUCCESS" ${search.success=='SUCCESS'?'selected':''}><spring:message code="admin.common.success"/></option>
                            <option value="FAIL" ${search.success=='FAIL'?'selected':''}><spring:message code="admin.common.fail"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.logs.authType"/></div>
                        <select class="adm-select" name="authType">
                            <option value="ALL" ${search.authType=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="PASSWORD" ${search.authType=='PASSWORD'?'selected':''}><spring:message code="admin.logs.authType.password"/></option>
                            <option value="SOCIAL" ${search.authType=='SOCIAL'?'selected':''}><spring:message code="admin.logs.authType.social"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.logs.provider"/></div>
                        <select class="adm-select" name="authProvider">
                            <option value="ALL" ${search.authProvider=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="LOCAL" ${search.authProvider=='LOCAL'?'selected':''}><spring:message code="admin.logs.provider.local"/></option>
                            <option value="KAKAO" ${search.authProvider=='KAKAO'?'selected':''}><spring:message code="admin.logs.provider.kakao"/></option>
                            <option value="NAVER" ${search.authProvider=='NAVER'?'selected':''}><spring:message code="admin.logs.provider.naver"/></option>
                            <option value="GOOGLE" ${search.authProvider=='GOOGLE'?'selected':''}><spring:message code="admin.logs.provider.google"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.logs.authFlow"/></div>
                        <select class="adm-select" name="loginMethod">
                            <option value="ALL" ${search.loginMethod=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="LOCAL" ${search.loginMethod=='LOCAL'?'selected':''}><spring:message code="admin.logs.authFlow.local"/></option>
                            <option value="ID" ${search.loginMethod=='ID'?'selected':''}><spring:message code="admin.logs.authFlow.id"/></option>
                            <option value="EMAIL" ${search.loginMethod=='EMAIL'?'selected':''}><spring:message code="admin.logs.authFlow.email"/></option>
                            <option value="KAKAO" ${search.loginMethod=='KAKAO'?'selected':''}><spring:message code="admin.logs.provider.kakao"/></option>
                            <option value="NAVER" ${search.loginMethod=='NAVER'?'selected':''}><spring:message code="admin.logs.provider.naver"/></option>
                            <option value="GOOGLE" ${search.loginMethod=='GOOGLE'?'selected':''}><spring:message code="admin.logs.provider.google"/></option>
                        </select>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:8px;">
                        <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/logins"><spring:message code="admin.common.reset"/></a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.logs.historyTitle"/></div>
            <div style="font-size:12px;color:#64748b;"><spring:message code="admin.common.totalCount" arguments="${total}"/></div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th data-sort="time" onclick="sortBy('time')"><spring:message code="admin.common.time"/><span class="sort-ico">▼</span></th>
                    <th><spring:message code="admin.common.member"/></th>
                    <th data-sort="eventType" onclick="sortBy('eventType')"><spring:message code="admin.logs.event"/><span class="sort-ico">▼</span></th>
                    <th data-sort="authType" onclick="sortBy('authType')"><spring:message code="admin.logs.authType"/><span class="sort-ico">▼</span></th>
                    <th data-sort="provider" onclick="sortBy('provider')"><spring:message code="admin.logs.provider"/><span class="sort-ico">▼</span></th>
                    <th data-sort="loginMethod" onclick="sortBy('loginMethod')"><spring:message code="admin.logs.authFlow"/><span class="sort-ico">▼</span></th>
                    <th><spring:message code="admin.context.inputValue"/></th>
                    <th data-sort="success" onclick="sortBy('success')"><spring:message code="admin.common.result"/><span class="sort-ico">▼</span></th>
                    <th><spring:message code="admin.common.reason"/></th>
                    <th data-sort="ip" onclick="sortBy('ip')"><spring:message code="admin.common.ip"/><span class="sort-ico">▼</span></th>
                    <th><spring:message code="admin.context.requestId"/></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <fmt:formatDate var="itemDateFilter" value="${item.loginAt}" pattern="yyyy-MM-dd"/>
                    <fmt:formatDate var="itemTimeDisplay" value="${item.loginAt}" pattern="yyyy.MM.dd HH:mm:ss"/>
                    <tr>
                        <td>
                            <button type="button" class="adm-cell-link"
                                    data-date="${itemDateFilter}"
                                    onclick="filterByDate(this.dataset.date)">
                                <span>${itemTimeDisplay}</span>
                                <span class="adm-cell-link-note"><spring:message code="admin.common.sameDate"/></span>
                            </button>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.userIdx}">
                                    <button type="button"
                                            class="adm-inline-link js-open-member-context"
                                            data-user-idx="${item.userIdx}"
                                            data-default-tab="logins"
                                            style="font-weight:700;color:#93c5fd;">${item.nickname}</button>
                                    <div class="mem-uid">
                                        <button type="button"
                                                class="adm-inline-link js-open-member-context"
                                                data-user-idx="${item.userIdx}"
                                                data-default-tab="logins"
                                                style="color:#94a3b8;">@${item.userId}</button>
                                    </div>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;"><spring:message code="admin.common.unidentified"/></span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="eventType" data-param-value="${item.eventType}" onclick="applySelectFilter(this)">
                                <span class="status-badge ${item.eventType == 'LOGOUT' ? 'PENDING' : 'ACTIVE'}">
                                    <c:choose>
                                        <c:when test="${item.eventType eq 'LOGIN'}"><spring:message code="admin.logs.event.login"/></c:when>
                                        <c:when test="${item.eventType eq 'LOGOUT'}"><spring:message code="admin.logs.event.logout"/></c:when>
                                        <c:otherwise><c:out value="${item.eventType}"/></c:otherwise>
                                    </c:choose>
                                </span>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="authType" data-param-value="${item.authType}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${item.authType eq 'PASSWORD'}"><spring:message code="admin.logs.authType.password"/></c:when>
                                    <c:when test="${item.authType eq 'SOCIAL'}"><spring:message code="admin.logs.authType.social"/></c:when>
                                    <c:otherwise><c:out value="${item.authType}"/></c:otherwise>
                                </c:choose></span>
                                <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="authProvider" data-param-value="${item.authProvider}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${item.authProvider eq 'LOCAL'}"><spring:message code="admin.logs.provider.local"/></c:when>
                                    <c:when test="${item.authProvider eq 'KAKAO'}"><spring:message code="admin.logs.provider.kakao"/></c:when>
                                    <c:when test="${item.authProvider eq 'NAVER'}"><spring:message code="admin.logs.provider.naver"/></c:when>
                                    <c:when test="${item.authProvider eq 'GOOGLE'}"><spring:message code="admin.logs.provider.google"/></c:when>
                                    <c:otherwise><c:out value="${item.authProvider}"/></c:otherwise>
                                </c:choose></span>
                                <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="loginMethod" data-param-value="${item.loginMethod}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'LOCAL'}"><spring:message code="admin.logs.authFlow.local"/></c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'ID'}"><spring:message code="admin.logs.authFlow.id"/></c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'EMAIL'}"><spring:message code="admin.logs.authFlow.email"/></c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'KAKAO'}"><spring:message code="admin.logs.provider.kakao"/></c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'NAVER'}"><spring:message code="admin.logs.provider.naver"/></c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'GOOGLE'}"><spring:message code="admin.logs.provider.google"/></c:when>
                                    <c:when test="${item.authFlow eq 'PASSWORD_ID'}"><spring:message code="admin.logs.authFlow.passwordId"/></c:when>
                                    <c:when test="${item.authFlow eq 'PASSWORD_EMAIL'}"><spring:message code="admin.logs.authFlow.passwordEmail"/></c:when>
                                    <c:when test="${item.authFlow eq 'SOCIAL_LOGIN'}"><spring:message code="admin.logs.authFlow.socialLogin"/></c:when>
                                    <c:when test="${item.authFlow eq 'SOCIAL_REGISTER'}"><spring:message code="admin.logs.authFlow.socialRegister"/></c:when>
                                    <c:when test="${item.authFlow eq 'LOGOUT_LOCAL'}"><spring:message code="admin.logs.authFlow.logoutLocal"/></c:when>
                                    <c:when test="${item.authFlow eq 'LOGOUT_SOCIAL'}"><spring:message code="admin.logs.authFlow.logoutSocial"/></c:when>
                                    <c:otherwise><c:out value="${empty item.authFlow ? item.loginMethod : item.authFlow}"/></c:otherwise>
                                </c:choose></span>
                                <c:if test="${not empty item.requestUri}">
                                    <span class="adm-cell-link-note"><c:out value="${item.requestUri}"/></span>
                                </c:if>
                            </button>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.loginIdentifier}">
                                    <button type="button"
                                            class="adm-cell-link"
                                            data-keyword="${item.loginIdentifier}"
                                            onclick="applyKeywordFilter(this)">
                                        <span><c:out value="${item.loginIdentifier}"/></span>
                                        <c:if test="${not empty item.requestUri}">
                                            <span class="adm-cell-link-note"><c:out value="${item.requestUri}"/></span>
                                        </c:if>
                                    </button>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">-</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="success" data-param-value="${item.success ? 'SUCCESS' : 'FAIL'}" onclick="applySelectFilter(this)">
                                <c:choose>
                                    <c:when test="${item.success}"><span class="status-badge ACTIVE"><spring:message code="admin.common.success"/></span></c:when>
                                    <c:otherwise><span class="status-badge DELETED"><spring:message code="admin.common.fail"/></span></c:otherwise>
                                </c:choose>
                            </button>
                        </td>
                        <td style="max-width:280px;white-space:normal;">
                            <c:choose>
                                <c:when test="${not empty item.failReason}">
                                    <button type="button" class="adm-cell-link" data-keyword="${item.failReason}" onclick="applyKeywordFilter(this)">
                                        <span><c:out value="${item.failReason}"/></span>
                                        <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
                                    </button>
                                    <div class="adm-tr-inline js-admin-translation-widget"
                                         data-label="<spring:message code='admin.translation.label.loginFailReason'/>"
                                         data-source-type="LOGIN_AUDIT"
                                         data-source-idx="${item.loginIdx}"
                                         data-field-name="fail_reason"
                                         data-default-source-lang="ko"
                                         data-source-text="${fn:escapeXml(item.failReason)}"></div>
                                </c:when>
                                <c:when test="${item.success and not empty item.authFlow}">
                                    <button type="button" class="adm-cell-link" data-param-name="loginMethod" data-param-value="${item.loginMethod}" onclick="applySelectFilter(this)">
                                        <span style="color:#64748b;font-size:12px;"><c:out value="${item.authFlow}"/></span>
                                        <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
                                    </button>
                                </c:when>
                                <c:otherwise><div style="color:#475569;">-</div></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.ipAddress}">
                                    <button type="button"
                                            class="adm-cell-link js-open-ip-context"
                                            data-ip-address="${item.ipAddress}"
                                            data-default-tab="logins">
                                        <span style="color:#93c5fd;">${item.ipAddress}</span>
                                        <span class="adm-cell-link-note"><spring:message code="admin.common.sameIp"/></span>
                                    </button>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.requestId or not empty item.flowTraceId}">
                                    <button type="button"
                                            class="adm-cell-link"
                                            data-keyword="${not empty item.requestId ? item.requestId : item.flowTraceId}"
                                            onclick="applyKeywordFilter(this)">
                                        <span><c:out value="${empty item.requestId ? '-' : item.requestId}"/></span>
                                        <c:if test="${not empty item.flowTraceId}">
                                            <span class="adm-cell-link-note"><spring:message code="admin.common.trace"/>: <c:out value="${item.flowTraceId}"/></span>
                                        </c:if>
                                    </button>
                                </c:when>
                                <c:otherwise><div style="font-size:12px;color:#64748b;">-</div></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button" class="adm-row-btn detail"
                                    data-time="${itemTimeDisplay}"
                                    data-user="${fn:escapeXml(item.nickname)} (@${fn:escapeXml(item.userId)})"
                                    data-event="${fn:escapeXml(item.eventType)}"
                                    data-auth-type="${fn:escapeXml(item.authType)}"
                                    data-provider="${fn:escapeXml(item.authProvider)}"
                                    data-auth-flow="${fn:escapeXml(item.authFlow)}"
                                    data-login-method="${fn:escapeXml(item.loginMethod)}"
                                    data-identifier="${fn:escapeXml(item.loginIdentifier)}"
                                    data-success="${item.success ? 'SUCCESS' : 'FAIL'}"
                                    data-fail-reason="${fn:escapeXml(item.failReason)}"
                                    data-ip="${fn:escapeXml(item.ipAddress)}"
                                    data-request-id="${fn:escapeXml(item.requestId)}"
                                    data-flow-trace="${fn:escapeXml(item.flowTraceId)}"
                                    data-user-agent="${fn:escapeXml(item.userAgent)}"
                                    data-request-uri="${fn:escapeXml(item.requestUri)}"
                                    data-session-id="${fn:escapeXml(item.sessionId)}"
                                    onclick="openLoginDetail(this)">
                                <spring:message code="admin.common.viewDetail"/>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="12" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.common.noResults"/></td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}"><button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button></c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
                    <button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}" onclick="goPage(${p})">${p}</button>
                </c:forEach>
                <c:if test="${paging.next}"><button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button></c:if>
                <span class="adm-page-info"><spring:message code="admin.common.pageStatus" arguments="${paging.currentPage},${paging.totalPage}"/></span>
            </div>
        </c:if>
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
var BASE_URL = '${pageContext.request.contextPath}/admin/logins';
var curSortField = '${search.sortField}';
var curSortDir = '${search.sortDir}';

document.querySelectorAll('th[data-sort]').forEach(function(th) {
    var f = th.getAttribute('data-sort');
    if (f === curSortField) {
        th.classList.add('sorted');
        var ico = th.querySelector('.sort-ico');
        if (ico) ico.textContent = curSortDir === 'ASC' ? '▲' : '▼';
    }
});

function sortBy(field) {
    var params = new URLSearchParams(window.location.search);
    var dir = (params.get('sortField') === field && params.get('sortDir') !== 'ASC') ? 'ASC' : 'DESC';
    params.set('sortField', field);
    params.set('sortDir', dir);
    params.set('page', '1');
    location.href = BASE_URL + '?' + params.toString();
}

function filterByDate(dateStr) {
    var params = new URLSearchParams(window.location.search);
    params.set('dateFilter', dateStr);
    params.set('page', '1');
    location.href = BASE_URL + '?' + params.toString();
}

function applyKeywordFilter(button) {
    var keyword = button.getAttribute('data-keyword');
    if (!keyword) return;
    var params = new URLSearchParams(window.location.search);
    params.set('keyword', keyword);
    params.set('page', '1');
    location.href = BASE_URL + '?' + params.toString();
}

function applySelectFilter(button) {
    var paramName = button.getAttribute('data-param-name');
    var paramValue = button.getAttribute('data-param-value');
    if (!paramName || !paramValue) return;
    var params = new URLSearchParams(window.location.search);
    params.set(paramName, paramValue);
    params.set('page', '1');
    location.href = BASE_URL + '?' + params.toString();
}

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = BASE_URL + '?' + params.toString();
}

function openLoginDetail(btn) {
    var d = btn.dataset;
    showRowDetail('<spring:message code="admin.logs.historyTitle"/>', [
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

/* ── 공통 운영 목록: 체크박스 + CSV/Excel 내보내기 ── */
(function enhanceAdminListExport() {
    const table = document.querySelector('.adm-table');
    if (!table || table.dataset.exportEnhanced === 'true') return;
    table.dataset.exportEnhanced = 'true';

    const wrap = table.closest('.adm-table-wrap') || table.parentElement;
    if (wrap) {
        const toolbar = document.createElement('div');
        toolbar.className = 'adm-local-toolbar';
        toolbar.style.margin = '0 0 12px';
        toolbar.innerHTML =
            '<div class="adm-local-toolbar-group">'
            + '<select class="adm-select" id="adminListExportFormat" style="width:86px;"><option value="csv">CSV</option><option value="excel">Excel</option></select>'
            + '<button type="button" class="adm-btn adm-btn-ghost js-admin-export" data-scope="all">전체 내보내기</button>'
            + '<button type="button" class="adm-btn adm-btn-ghost js-admin-export" data-scope="search">현재 검색 내보내기</button>'
            + '<button type="button" class="adm-btn adm-btn-ghost js-admin-export-selected" data-scope="selected" disabled>선택 내보내기 (0)</button>'
            + '<button type="button" class="adm-btn adm-btn-ghost js-admin-clear-selection" style="display:none;">선택 해제</button>'
            + '</div>';
        wrap.parentElement.insertBefore(toolbar, wrap);
    }

    const headRow = table.querySelector('thead tr');
    if (headRow && !headRow.querySelector('.js-admin-check-all')) {
        const th = document.createElement('th');
        th.style.width = '42px';
        th.style.textAlign = 'center';
        th.innerHTML = '<input type="checkbox" class="js-admin-check-all" style="cursor:pointer;">';
        headRow.insertBefore(th, headRow.firstElementChild);
    }

    table.querySelectorAll('tbody tr').forEach(function (row) {
        if (row.querySelector('.js-admin-row-check')) return;
        if (row.children.length === 1 && row.children[0].hasAttribute('colspan')) return;
        const td = document.createElement('td');
        td.style.textAlign = 'center';
        td.innerHTML = '<input type="checkbox" class="js-admin-row-check" style="cursor:pointer;">';
        row.insertBefore(td, row.firstElementChild);
    });

    function rows() {
        return Array.from(table.querySelectorAll('tbody tr')).filter(function (row) {
            return row.querySelector('.js-admin-row-check');
        });
    }
    function selectedRows() {
        return rows().filter(function (row) {
            const cb = row.querySelector('.js-admin-row-check');
            return cb && cb.checked;
        });
    }
    function updateSelectionUi() {
        const count = selectedRows().length;
        const selectedBtn = document.querySelector('.js-admin-export-selected');
        const clearBtn = document.querySelector('.js-admin-clear-selection');
        const all = document.querySelector('.js-admin-check-all');
        if (selectedBtn) {
            selectedBtn.disabled = count === 0;
            selectedBtn.textContent = '선택 내보내기 (' + count + ')';
        }
        if (clearBtn) clearBtn.style.display = count > 0 ? '' : 'none';
        if (all) {
            const allRows = rows();
            all.checked = allRows.length > 0 && count === allRows.length;
            all.indeterminate = count > 0 && count < allRows.length;
        }
    }
    function text(cell) {
        return (cell.innerText || '').replace(/\s+/g, ' ').trim();
    }
    function csvEscape(value) {
        const s = String(value == null ? '' : value);
        return '"' + s.replace(/"/g, '""') + '"';
    }
    function download(content, filename, type) {
        const blob = new Blob([content], {type: type});
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = filename;
        document.body.appendChild(a);
        a.click();
        a.remove();
        setTimeout(function () { URL.revokeObjectURL(url); }, 1000);
    }
    function exportRows(scope) {
        let targetRows = scope === 'selected' ? selectedRows() : rows();
        if (scope === 'selected' && targetRows.length === 0) {
            if (typeof adm_toast === 'function') adm_toast('선택된 항목이 없습니다.', 'error');
            else alert('선택된 항목이 없습니다.');
            return;
        }
        const format = (document.getElementById('adminListExportFormat') || {}).value || 'csv';
        const headers = Array.from(table.querySelectorAll('thead th'))
            .filter(function (_, idx, arr) { return idx !== 0; })
            .map(function (th) { return text(th).replace(/[↕▲▼]/g, '').trim(); });
        const body = targetRows.map(function (row) {
            return Array.from(row.children)
                .filter(function (_, idx) { return idx !== 0; })
                .map(text);
        });
        const name = (document.title || 'admin_list').replace(/[\\/:*?"<>|]+/g, '_') + '_' + scope + '_' + new Date().toISOString().slice(0, 10);
        if (format === 'excel') {
            const html = '<table><thead><tr>' + headers.map(h => '<th>' + h + '</th>').join('') + '</tr></thead><tbody>'
                + body.map(row => '<tr>' + row.map(v => '<td>' + v + '</td>').join('') + '</tr>').join('')
                + '</tbody></table>';
            download('\ufeff' + html, name + '.xls', 'application/vnd.ms-excel;charset=utf-8');
        } else {
            const csv = [headers].concat(body).map(function (row) { return row.map(csvEscape).join(','); }).join('\n');
            download('\ufeff' + csv, name + '.csv', 'text/csv;charset=utf-8');
        }
    }

    document.addEventListener('change', function (e) {
        if (e.target.matches('.js-admin-check-all')) {
            rows().forEach(function (row) {
                row.querySelector('.js-admin-row-check').checked = e.target.checked;
            });
            updateSelectionUi();
        }
        if (e.target.matches('.js-admin-row-check')) updateSelectionUi();
    });
    document.addEventListener('click', function (e) {
        const exportBtn = e.target.closest('.js-admin-export, .js-admin-export-selected');
        if (exportBtn) {
            exportRows(exportBtn.dataset.scope || 'all');
            return;
        }
        const clearBtn = e.target.closest('.js-admin-clear-selection');
        if (clearBtn) {
            rows().forEach(row => row.querySelector('.js-admin-row-check').checked = false);
            updateSelectionUi();
        }
    });
})();

</script>

<%@ include file="../layout-close.jsp" %>
