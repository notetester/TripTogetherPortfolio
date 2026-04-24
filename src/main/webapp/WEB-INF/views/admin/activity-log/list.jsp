<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="activityLogs"/>
<spring:message code="admin.activity.pageTitle" var="adminActivityPageTitle"/>
<spring:message code="admin.common.success" var="adminActivitySuccessLabel"/>
<spring:message code="admin.common.fail" var="adminActivityFailLabel"/>
<c:set var="pageTitle" value="${adminActivityPageTitle}"/>
<%@ include file="../layout.jsp" %>
<div class="adm-content">
  <div class="adm-card" style="margin-bottom:20px;">
    <div class="adm-card-body">
      <form method="get" action="${pageContext.request.contextPath}/admin/activity-logs">
        <div class="adm-filter-bar">
          <div class="adm-search-box" style="flex:1;min-width:220px;"><div class="adm-filter-label"><spring:message code="admin.common.search"/></div><span class="adm-search-ico">🔍</span><input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="<spring:message code='admin.activity.searchPlaceholder'/>"></div>
          <div><div class="adm-filter-label"><spring:message code="admin.activity.domain"/></div><select class="adm-select" name="activityDomain"><option value="ALL" ${search.activityDomain=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option><option value="GENERAL" ${search.activityDomain=='GENERAL'?'selected':''}><spring:message code="admin.activity.domain.general"/></option><option value="AUTH" ${search.activityDomain=='AUTH'?'selected':''}><spring:message code="admin.activity.domain.auth"/></option><option value="ADMIN" ${search.activityDomain=='ADMIN'?'selected':''}><spring:message code="admin.activity.domain.admin"/></option><option value="COMMUNITY" ${search.activityDomain=='COMMUNITY'?'selected':''}><spring:message code="admin.activity.domain.community"/></option><option value="MYPAGE" ${search.activityDomain=='MYPAGE'?'selected':''}><spring:message code="admin.activity.domain.mypage"/></option><option value="INQUIRY" ${search.activityDomain=='INQUIRY'?'selected':''}><spring:message code="admin.activity.domain.inquiry"/></option></select></div>
          <div><div class="adm-filter-label"><spring:message code="admin.activity.type"/></div><select class="adm-select" name="activityType"><option value="ALL" ${search.activityType=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option><option value="PAGE_VIEW" ${search.activityType=='PAGE_VIEW'?'selected':''}><spring:message code="admin.activity.type.pageView"/></option><option value="ACTION" ${search.activityType=='ACTION'?'selected':''}><spring:message code="admin.activity.type.action"/></option><option value="AJAX" ${search.activityType=='AJAX'?'selected':''}><spring:message code="admin.activity.type.ajax"/></option><option value="API" ${search.activityType=='API'?'selected':''}><spring:message code="admin.activity.type.api"/></option></select></div>
          <div><div class="adm-filter-label"><spring:message code="admin.logs.provider"/></div><select class="adm-select" name="activityProvider"><option value="ALL" ${search.activityProvider=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option><option value="LOCAL" ${search.activityProvider=='LOCAL'?'selected':''}><spring:message code="admin.logs.provider.local"/></option><option value="KAKAO" ${search.activityProvider=='KAKAO'?'selected':''}><spring:message code="admin.logs.provider.kakao"/></option><option value="NAVER" ${search.activityProvider=='NAVER'?'selected':''}><spring:message code="admin.logs.provider.naver"/></option><option value="GOOGLE" ${search.activityProvider=='GOOGLE'?'selected':''}><spring:message code="admin.logs.provider.google"/></option></select></div>
          <div><div class="adm-filter-label"><spring:message code="admin.activity.authEvent"/></div><select class="adm-select" name="authEventType"><option value="ALL" ${search.authEventType=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option><option value="LOGIN" ${search.authEventType=='LOGIN'?'selected':''}><spring:message code="admin.activity.authEvent.login"/></option><option value="LOGOUT" ${search.authEventType=='LOGOUT'?'selected':''}><spring:message code="admin.activity.authEvent.logout"/></option><option value="LINK" ${search.authEventType=='LINK'?'selected':''}><spring:message code="admin.activity.authEvent.link"/></option><option value="UNLINK" ${search.authEventType=='UNLINK'?'selected':''}><spring:message code="admin.activity.authEvent.unlink"/></option></select></div>
          <div><div class="adm-filter-label"><spring:message code="admin.activity.method"/></div><select class="adm-select" name="httpMethod"><option value="ALL" ${search.httpMethod=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option><option value="GET" ${search.httpMethod=='GET'?'selected':''}><spring:message code="admin.activity.method.get"/></option><option value="POST" ${search.httpMethod=='POST'?'selected':''}><spring:message code="admin.activity.method.post"/></option><option value="PUT" ${search.httpMethod=='PUT'?'selected':''}><spring:message code="admin.activity.method.put"/></option><option value="DELETE" ${search.httpMethod=='DELETE'?'selected':''}><spring:message code="admin.activity.method.delete"/></option></select></div>
          <div><div class="adm-filter-label"><spring:message code="admin.logs.success"/></div><select class="adm-select" name="success"><option value="ALL" ${search.success=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option><option value="SUCCESS" ${search.success=='SUCCESS'?'selected':''}><spring:message code="admin.common.success"/></option><option value="FAIL" ${search.success=='FAIL'?'selected':''}><spring:message code="admin.common.fail"/></option></select></div>
          <div style="display:flex;align-items:flex-end;gap:8px;">
            <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/activity-logs"><spring:message code="admin.common.reset"/></a>
          </div>
        </div>
      </form>
    </div>
  </div>
  <div class="adm-card">
    <div class="adm-card-head"><div class="adm-card-title"><spring:message code="admin.activity.historyTitle"/></div><div style="font-size:12px;color:#64748b;"><spring:message code="admin.common.totalCount" arguments="${total}"/></div></div>
    <div class="adm-table-wrap">
      <table class="adm-table">
        <thead><tr>
          <th data-sort="time" onclick="sortBy('time')"><spring:message code="admin.common.time"/><span class="sort-ico">▼</span></th>
          <th data-sort="member" onclick="sortBy('member')"><spring:message code="admin.common.member"/><span class="sort-ico">▼</span></th>
          <th data-sort="domain" onclick="sortBy('domain')"><spring:message code="admin.activity.domain"/><span class="sort-ico">▼</span></th>
          <th data-sort="type" onclick="sortBy('type')"><spring:message code="admin.activity.type"/><span class="sort-ico">▼</span></th>
          <th data-sort="activityCode" onclick="sortBy('activityCode')"><spring:message code="admin.activity.code"/><span class="sort-ico">▼</span></th>
          <th data-sort="uri" onclick="sortBy('uri')"><spring:message code="admin.common.uri"/><span class="sort-ico">▼</span></th>
          <th data-sort="method" onclick="sortBy('method')"><spring:message code="admin.activity.method"/><span class="sort-ico">▼</span></th>
          <th data-sort="status" onclick="sortBy('status')"><spring:message code="admin.common.status"/><span class="sort-ico">▼</span></th>
          <th data-sort="ip" onclick="sortBy('ip')"><spring:message code="admin.common.ip"/><span class="sort-ico">▼</span></th>
          <th data-sort="flow" onclick="sortBy('flow')"><spring:message code="admin.activity.flow"/><span class="sort-ico">▼</span></th>
          <th></th>
        </tr></thead>
        <tbody>
        <c:forEach items="${list}" var="item">
          <fmt:formatDate var="itemDateFilter" value="${item.createdAtDate}" pattern="yyyy-MM-dd"/>
          <fmt:formatDate var="itemTimeDisplay" value="${item.createdAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
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
                  <button type="button" class="adm-inline-link js-open-member-context" data-user-idx="${item.userIdx}" data-default-tab="activity" style="font-weight:700;color:#93c5fd;"><c:out value="${item.nickname}"/></button>
                  <div class="mem-uid"><button type="button" class="adm-inline-link js-open-member-context" data-user-idx="${item.userIdx}" data-default-tab="activity" style="color:#94a3b8;">@${item.userId}</button></div>
                </c:when>
                <c:otherwise>
                  <div class="mem-name"><spring:message code="admin.activity.guest"/></div>
                  <div class="mem-uid">-</div>
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-param-name="activityDomain" data-param-value="${item.activityDomain}" onclick="applySelectFilter(this)">
                <span><c:choose>
                  <c:when test="${item.activityDomain eq 'GENERAL'}"><spring:message code="admin.activity.domain.general"/></c:when>
                  <c:when test="${item.activityDomain eq 'AUTH'}"><spring:message code="admin.activity.domain.auth"/></c:when>
                  <c:when test="${item.activityDomain eq 'ADMIN'}"><spring:message code="admin.activity.domain.admin"/></c:when>
                  <c:when test="${item.activityDomain eq 'COMMUNITY'}"><spring:message code="admin.activity.domain.community"/></c:when>
                  <c:when test="${item.activityDomain eq 'MYPAGE'}"><spring:message code="admin.activity.domain.mypage"/></c:when>
                  <c:when test="${item.activityDomain eq 'INQUIRY'}"><spring:message code="admin.activity.domain.inquiry"/></c:when>
                  <c:otherwise><c:out value="${empty item.activityDomain ? '-' : item.activityDomain}"/></c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
              </button>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-param-name="activityType" data-param-value="${item.activityType}" onclick="applySelectFilter(this)">
                <span><c:choose>
                  <c:when test="${item.activityType eq 'PAGE_VIEW'}"><spring:message code="admin.activity.type.pageView"/></c:when>
                  <c:when test="${item.activityType eq 'ACTION'}"><spring:message code="admin.activity.type.action"/></c:when>
                  <c:when test="${item.activityType eq 'AJAX'}"><spring:message code="admin.activity.type.ajax"/></c:when>
                  <c:when test="${item.activityType eq 'API'}"><spring:message code="admin.activity.type.api"/></c:when>
                  <c:otherwise><c:out value="${item.activityType}"/></c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
              </button>
            </td>
            <td>
              <c:choose>
                <c:when test="${not empty item.activityCode}">
                  <button type="button" class="adm-cell-link" data-keyword="${item.activityCode}" onclick="applyKeywordFilter(this)">
                    <span><c:out value="${item.activityCode}"/></span>
                    <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
                  </button>
                </c:when>
                <c:otherwise><div>-</div></c:otherwise>
              </c:choose>
              <c:if test="${not empty item.activityProvider or not empty item.authEventType}">
                <div style="margin-top:4px;font-size:11px;color:#64748b;">
                  <c:choose>
                    <c:when test="${item.activityProvider eq 'LOCAL'}"><spring:message code="admin.logs.provider.local"/></c:when>
                    <c:when test="${item.activityProvider eq 'KAKAO'}"><spring:message code="admin.logs.provider.kakao"/></c:when>
                    <c:when test="${item.activityProvider eq 'NAVER'}"><spring:message code="admin.logs.provider.naver"/></c:when>
                    <c:when test="${item.activityProvider eq 'GOOGLE'}"><spring:message code="admin.logs.provider.google"/></c:when>
                    <c:otherwise><c:out value="${empty item.activityProvider ? '-' : item.activityProvider}"/></c:otherwise>
                  </c:choose>
                  <c:if test="${not empty item.authEventType}">
                    /
                    <c:choose>
                      <c:when test="${item.authEventType eq 'LOGIN'}"><spring:message code="admin.activity.authEvent.login"/></c:when>
                      <c:when test="${item.authEventType eq 'LOGOUT'}"><spring:message code="admin.activity.authEvent.logout"/></c:when>
                      <c:when test="${item.authEventType eq 'LINK'}"><spring:message code="admin.activity.authEvent.link"/></c:when>
                      <c:when test="${item.authEventType eq 'UNLINK'}"><spring:message code="admin.activity.authEvent.unlink"/></c:when>
                      <c:otherwise><c:out value="${item.authEventType}"/></c:otherwise>
                    </c:choose>
                  </c:if>
                </div>
              </c:if>
              <div class="adm-inline-actions">
                <c:if test="${(item.targetType eq 'USER' or item.targetType eq 'user') and not empty item.targetId}">
                  <button type="button" class="adm-inline-chip js-open-member-context" data-user-idx="${item.targetId}"><spring:message code="admin.common.viewTarget"/></button>
                </c:if>
                <c:if test="${(item.targetType eq 'REPORT' or item.targetType eq 'report') and not empty item.targetId}">
                  <a href="${pageContext.request.contextPath}/admin/reports/${item.targetId}" class="adm-inline-chip"><spring:message code="admin.common.viewDetail"/></a>
                </c:if>
                <c:if test="${(item.targetType eq 'INQUIRY' or item.targetType eq 'inquiry') and not empty item.targetId}">
                  <a href="${pageContext.request.contextPath}/admin/inquiries/${item.targetId}" class="adm-inline-chip"><spring:message code="admin.common.viewDetail"/></a>
                </c:if>
                <c:if test="${not empty item.targetId}">
                  <button type="button" class="adm-inline-chip" data-keyword="${item.targetId}" onclick="applyKeywordFilter(this)"><spring:message code="admin.common.sameTarget"/></button>
                </c:if>
              </div>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-keyword="${item.requestUri}" onclick="applyKeywordFilter(this)">
                <span style="word-break:break-all;"><c:out value="${item.requestUri}"/></span>
                <c:if test="${not empty item.detailSummary}">
                  <span class="adm-cell-link-note"><c:out value="${item.detailSummary}"/></span>
                </c:if>
              </button>
              <c:if test="${not empty item.detailSummary}">
                <div class="adm-tr-inline js-admin-translation-widget"
                     data-label="<spring:message code='admin.translation.label.activityLogDetailSummary'/>"
                     data-source-type="ACTIVITY_LOG"
                     data-source-idx="${item.activityIdx}"
                     data-field-name="detail_summary"
                     data-default-source-lang="ko"
                     data-source-text="${fn:escapeXml(item.detailSummary)}"></div>
              </c:if>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-param-name="httpMethod" data-param-value="${item.httpMethod}" onclick="applySelectFilter(this)">
                <span><c:choose>
                  <c:when test="${item.httpMethod eq 'GET'}"><spring:message code="admin.activity.method.get"/></c:when>
                  <c:when test="${item.httpMethod eq 'POST'}"><spring:message code="admin.activity.method.post"/></c:when>
                  <c:when test="${item.httpMethod eq 'PUT'}"><spring:message code="admin.activity.method.put"/></c:when>
                  <c:when test="${item.httpMethod eq 'DELETE'}"><spring:message code="admin.activity.method.delete"/></c:when>
                  <c:otherwise><c:out value="${item.httpMethod}"/></c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
              </button>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-param-name="success" data-param-value="${item.success ? 'SUCCESS' : 'FAIL'}" onclick="applySelectFilter(this)">
                <span><c:out value="${item.responseStatus}"/></span>
                <span class="adm-cell-link-note"><c:out value="${item.success ? adminActivitySuccessLabel : adminActivityFailLabel}"/></span>
              </button>
            </td>
            <td>
              <c:choose>
                <c:when test="${not empty item.ipAddress}">
                  <button type="button" class="adm-cell-link js-open-ip-context" data-ip-address="${item.ipAddress}" data-default-tab="activity">
                    <span style="color:#93c5fd;"><c:out value="${item.ipAddress}"/></span>
                    <span class="adm-cell-link-note"><spring:message code="admin.common.sameIp"/></span>
                  </button>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-keyword="${not empty item.requestId ? item.requestId : item.flowTraceId}" onclick="applyKeywordFilter(this)">
                <span style="font-size:12px;color:#64748b;"><c:out value="${empty item.requestId ? '-' : item.requestId}"/></span>
                <c:if test="${not empty item.flowTraceId}">
                  <span class="adm-cell-link-note"><spring:message code="admin.common.trace"/>: <c:out value="${item.flowTraceId}"/></span>
                </c:if>
              </button>
            </td>
            <td>
              <button type="button" class="adm-row-btn detail"
                      data-time="${itemTimeDisplay}"
                      data-user="${fn:escapeXml(item.nickname)} (@${fn:escapeXml(item.userId)})"
                      data-domain="${fn:escapeXml(item.activityDomain)}"
                      data-type="${fn:escapeXml(item.activityType)}"
                      data-code="${fn:escapeXml(item.activityCode)}"
                      data-provider="${fn:escapeXml(item.activityProvider)}"
                      data-auth-event="${fn:escapeXml(item.authEventType)}"
                      data-uri="${fn:escapeXml(item.requestUri)}"
                      data-method="${fn:escapeXml(item.httpMethod)}"
                      data-status="${item.responseStatus}"
                      data-response-ms="${item.responseTimeMs}"
                      data-success="${item.success ? 'SUCCESS' : 'FAIL'}"
                      data-target="${fn:escapeXml(item.targetType)} / ${fn:escapeXml(item.targetId)}"
                      data-detail-summary="${fn:escapeXml(item.detailSummary)}"
                      data-ip="${fn:escapeXml(item.ipAddress)}"
                      data-request-id="${fn:escapeXml(item.requestId)}"
                      data-flow-trace="${fn:escapeXml(item.flowTraceId)}"
                      data-handler="${fn:escapeXml(item.handlerName)}"
                      data-referer="${fn:escapeXml(item.referer)}"
                      data-user-agent="${fn:escapeXml(item.userAgent)}"
                      onclick="openActivityDetail(this)">
                <spring:message code="admin.common.viewDetail"/>
              </button>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty list}"><tr><td colspan="11" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.common.noResults"/></td></tr></c:if>
      </tbody></table>
    </div>
    <c:if test="${paging.totalPage > 1}"><div class="adm-paging"><c:if test="${paging.prev}"><button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button></c:if><c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"><button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}" onclick="goPage(${p})">${p}</button></c:forEach><c:if test="${paging.next}"><button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button></c:if><span class="adm-page-info"><spring:message code="admin.common.pageStatus" arguments="${paging.currentPage},${paging.totalPage}"/></span></div></c:if>
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
var BASE_URL = '${pageContext.request.contextPath}/admin/activity-logs';
var curSortField = '${search.sortField}';
var curSortDir = '${search.sortDir}';

document.querySelectorAll('th[data-sort]').forEach(function(th) {
  if (th.getAttribute('data-sort') === curSortField) {
    th.classList.add('sorted');
    var ico = th.querySelector('.sort-ico');
    if (ico) ico.textContent = curSortDir === 'ASC' ? '▲' : '▼';
  }
});

function sortBy(field) {
  var params = new URLSearchParams(window.location.search);
  var dir = (params.get('sortField') === field && params.get('sortDir') !== 'ASC') ? 'ASC' : 'DESC';
  params.set('sortField', field); params.set('sortDir', dir); params.set('page', '1');
  location.href = BASE_URL + '?' + params.toString();
}
function filterByDate(dateStr) {
  var params = new URLSearchParams(window.location.search);
  params.set('dateFilter', dateStr); params.set('page', '1');
  location.href = BASE_URL + '?' + params.toString();
}
function applyKeywordFilter(button) {
  var keyword = button.getAttribute('data-keyword');
  if (!keyword) return;
  var params = new URLSearchParams(window.location.search);
  params.set('keyword', keyword); params.set('page', '1');
  location.href = BASE_URL + '?' + params.toString();
}
function applySelectFilter(button) {
  var paramName = button.getAttribute('data-param-name');
  var paramValue = button.getAttribute('data-param-value');
  if (!paramName || !paramValue) return;
  var params = new URLSearchParams(window.location.search);
  params.set(paramName, paramValue); params.set('page', '1');
  location.href = BASE_URL + '?' + params.toString();
}
function goPage(page) {
  var params = new URLSearchParams(window.location.search);
  params.set('page', page);
  location.href = BASE_URL + '?' + params.toString();
}
function openActivityDetail(btn) {
  var d = btn.dataset;
  showRowDetail('<spring:message code="admin.activity.historyTitle"/>', [
    ['시각', d.time],
    ['회원', d.user],
    ['도메인', d.domain],
    ['유형', d.type],
    ['활동 코드', d.code],
    ['공급자', d.provider],
    ['인증 이벤트', d.authEvent],
    ['URI', d.uri],
    ['HTTP 메서드', d.method],
    ['응답 상태', d.status],
    ['응답 시간(ms)', d.responseMs],
    ['결과', d.success],
    ['대상', d.target],
    ['상세 요약', d.detailSummary],
    ['IP', d.ip],
    ['요청 ID', d.requestId],
    ['흐름 추적 ID', d.flowTrace],
    ['핸들러', d.handler],
    ['Referer', d.referer],
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
    if (!value || value === '' || value === '-' || value === 'null' || value === ' / ') return;
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
            '<div class="adm-local-toolbar-group adm-unified-export">'
            + '<div class="adm-export-control">'
            + '<select class="adm-select" id="adminListExportFormat"><option value="csv">CSV</option><option value="excel">Excel</option></select>'
            + '<div class="adm-export-menu">'
            + '<button type="button" class="adm-btn adm-btn-ghost js-export-toggle">⬇ 내보내기 ▾</button>'
            + '<div class="adm-export-dropdown">'
            + '<button type="button" class="js-admin-export" data-scope="all">📋 전체 내보내기</button>'
            + '<button type="button" class="js-admin-export" data-scope="search">🔍 현재 검색 내보내기</button>'
            + '<button type="button" class="js-admin-export-selected" data-scope="selected" disabled>☑ 선택 내보내기 (0)</button>'
            + '</div></div>'
            + '<button type="button" class="adm-btn adm-btn-ghost js-admin-clear-selection" style="display:none;">선택 해제</button>'
            + '</div></div>';
        wrap.parentElement.insertBefore(toolbar, wrap);
    }

    const headRow = table.querySelector('thead tr');
    if (headRow && !headRow.querySelector('.js-admin-check-all')) {
        const th = document.createElement('th');
        th.style.width = '42px';
        th.style.textAlign = 'center';
        th.innerHTML = '<input type="checkbox" class="js-admin-check-all adm-check">';
        headRow.insertBefore(th, headRow.firstElementChild);
    }

    table.querySelectorAll('tbody tr').forEach(function (row) {
        if (row.querySelector('.js-admin-row-check')) return;
        if (row.children.length === 1 && row.children[0].hasAttribute('colspan')) return;
        const td = document.createElement('td');
        td.style.textAlign = 'center';
        td.innerHTML = '<input type="checkbox" class="js-admin-row-check adm-check">';
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
