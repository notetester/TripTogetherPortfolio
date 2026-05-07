<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_activity_searchPlaceholder" code="admin.activity.searchPlaceholder"/>
<spring:message var="msg_admin_activity_historyTitle" code="admin.activity.historyTitle"/>
<spring:message var="msg_admin_translation_label_activityLogDetailSummary" code="admin.translation.label.activityLogDetailSummary"/>
<spring:message var="msg_admin_activity_pageTitle" code="admin.activity.pageTitle"/>
<spring:message var="msg_admin_common_success" code="admin.common.success"/>
<spring:message var="msg_admin_common_fail" code="admin.common.fail"/>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_activity_domain" code="admin.activity.domain"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_activity_domain_general" code="admin.activity.domain.general"/>
<spring:message var="msg_admin_activity_domain_auth" code="admin.activity.domain.auth"/>
<spring:message var="msg_admin_activity_domain_admin" code="admin.activity.domain.admin"/>
<spring:message var="msg_admin_activity_domain_community" code="admin.activity.domain.community"/>
<spring:message var="msg_admin_activity_domain_mypage" code="admin.activity.domain.mypage"/>
<spring:message var="msg_admin_activity_domain_inquiry" code="admin.activity.domain.inquiry"/>
<spring:message var="msg_admin_activity_type" code="admin.activity.type"/>
<spring:message var="msg_admin_activity_type_pageView" code="admin.activity.type.pageView"/>
<spring:message var="msg_admin_activity_type_action" code="admin.activity.type.action"/>
<spring:message var="msg_admin_activity_type_ajax" code="admin.activity.type.ajax"/>
<spring:message var="msg_admin_activity_type_api" code="admin.activity.type.api"/>
<spring:message var="msg_admin_logs_provider" code="admin.logs.provider"/>
<spring:message var="msg_admin_logs_provider_local" code="admin.logs.provider.local"/>
<spring:message var="msg_admin_logs_provider_kakao" code="admin.logs.provider.kakao"/>
<spring:message var="msg_admin_logs_provider_naver" code="admin.logs.provider.naver"/>
<spring:message var="msg_admin_logs_provider_google" code="admin.logs.provider.google"/>
<spring:message var="msg_admin_activity_authEvent" code="admin.activity.authEvent"/>
<spring:message var="msg_admin_activity_authEvent_login" code="admin.activity.authEvent.login"/>
<spring:message var="msg_admin_activity_authEvent_logout" code="admin.activity.authEvent.logout"/>
<spring:message var="msg_admin_activity_authEvent_link" code="admin.activity.authEvent.link"/>
<spring:message var="msg_admin_activity_authEvent_unlink" code="admin.activity.authEvent.unlink"/>
<spring:message var="msg_admin_activity_method" code="admin.activity.method"/>
<spring:message var="msg_admin_activity_method_get" code="admin.activity.method.get"/>
<spring:message var="msg_admin_activity_method_post" code="admin.activity.method.post"/>
<spring:message var="msg_admin_activity_method_put" code="admin.activity.method.put"/>
<spring:message var="msg_admin_activity_method_delete" code="admin.activity.method.delete"/>
<spring:message var="msg_admin_logs_success" code="admin.logs.success"/>
<spring:message var="msg_admin_common_searchButton" code="admin.common.searchButton"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount"/>
<spring:message var="msg_admin_common_time" code="admin.common.time"/>
<spring:message var="msg_admin_common_member" code="admin.common.member"/>
<spring:message var="msg_admin_activity_code" code="admin.activity.code"/>
<spring:message var="msg_admin_common_uri" code="admin.common.uri"/>
<spring:message var="msg_admin_common_status" code="admin.common.status"/>
<spring:message var="msg_admin_common_ip" code="admin.common.ip"/>
<spring:message var="msg_admin_activity_flow" code="admin.activity.flow"/>
<spring:message var="msg_admin_common_sameDate" code="admin.common.sameDate"/>
<spring:message var="msg_admin_activity_guest" code="admin.activity.guest"/>
<spring:message var="msg_admin_common_sameValue" code="admin.common.sameValue"/>
<spring:message var="msg_admin_common_viewTarget" code="admin.common.viewTarget"/>
<spring:message var="msg_admin_common_viewDetail" code="admin.common.viewDetail"/>
<spring:message var="msg_admin_common_sameTarget" code="admin.common.sameTarget"/>
<spring:message var="msg_admin_common_sameIp" code="admin.common.sameIp"/>
<spring:message var="msg_admin_common_trace" code="admin.common.trace"/>
<spring:message var="msg_admin_common_noResults" code="admin.common.noResults"/>
<spring:message var="msg_admin_common_pageStatus" code="admin.common.pageStatus"/>
<c:set var="activeMenu" value="activityLogs"/>


<c:set var="pageTitle" value="${msg_admin_activity_pageTitle}"/>
<%@ include file="../layout.jsp" %>
<div class="adm-content">
  <div class="adm-card adm-audit-filter-card adm-activity-audit-filter-card">
    <div class="adm-card-body">
      <form method="get" action="${pageContext.request.contextPath}/admin/activity-logs">
        <div class="adm-filter-bar adm-audit-filterbar adm-activity-audit-filterbar">
          <div class="adm-search-box adm-audit-search-box"><div class="adm-filter-label">${msg_admin_common_search}</div><span class="adm-search-ico">🔍</span><input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="${msg_admin_activity_searchPlaceholder}"></div>
          <div><div class="adm-filter-label">${msg_admin_activity_domain}</div><select class="adm-select" name="activityDomain"><option value="ALL" ${search.activityDomain=='ALL'?'selected':''}>${msg_admin_common_all}</option><option value="GENERAL" ${search.activityDomain=='GENERAL'?'selected':''}>${msg_admin_activity_domain_general}</option><option value="AUTH" ${search.activityDomain=='AUTH'?'selected':''}>${msg_admin_activity_domain_auth}</option><option value="ADMIN" ${search.activityDomain=='ADMIN'?'selected':''}>${msg_admin_activity_domain_admin}</option><option value="COMMUNITY" ${search.activityDomain=='COMMUNITY'?'selected':''}>${msg_admin_activity_domain_community}</option><option value="MYPAGE" ${search.activityDomain=='MYPAGE'?'selected':''}>${msg_admin_activity_domain_mypage}</option><option value="INQUIRY" ${search.activityDomain=='INQUIRY'?'selected':''}>${msg_admin_activity_domain_inquiry}</option></select></div>
          <div><div class="adm-filter-label">${msg_admin_activity_type}</div><select class="adm-select" name="activityType"><option value="ALL" ${search.activityType=='ALL'?'selected':''}>${msg_admin_common_all}</option><option value="PAGE_VIEW" ${search.activityType=='PAGE_VIEW'?'selected':''}>${msg_admin_activity_type_pageView}</option><option value="ACTION" ${search.activityType=='ACTION'?'selected':''}>${msg_admin_activity_type_action}</option><option value="AJAX" ${search.activityType=='AJAX'?'selected':''}>${msg_admin_activity_type_ajax}</option><option value="API" ${search.activityType=='API'?'selected':''}>${msg_admin_activity_type_api}</option></select></div>
          <div><div class="adm-filter-label">${msg_admin_logs_provider}</div><select class="adm-select" name="activityProvider"><option value="ALL" ${search.activityProvider=='ALL'?'selected':''}>${msg_admin_common_all}</option><option value="LOCAL" ${search.activityProvider=='LOCAL'?'selected':''}>${msg_admin_logs_provider_local}</option><option value="KAKAO" ${search.activityProvider=='KAKAO'?'selected':''}>${msg_admin_logs_provider_kakao}</option><option value="NAVER" ${search.activityProvider=='NAVER'?'selected':''}>${msg_admin_logs_provider_naver}</option><option value="GOOGLE" ${search.activityProvider=='GOOGLE'?'selected':''}>${msg_admin_logs_provider_google}</option></select></div>
          <div><div class="adm-filter-label">${msg_admin_activity_authEvent}</div><select class="adm-select" name="authEventType"><option value="ALL" ${search.authEventType=='ALL'?'selected':''}>${msg_admin_common_all}</option><option value="LOGIN" ${search.authEventType=='LOGIN'?'selected':''}>${msg_admin_activity_authEvent_login}</option><option value="LOGOUT" ${search.authEventType=='LOGOUT'?'selected':''}>${msg_admin_activity_authEvent_logout}</option><option value="LINK" ${search.authEventType=='LINK'?'selected':''}>${msg_admin_activity_authEvent_link}</option><option value="UNLINK" ${search.authEventType=='UNLINK'?'selected':''}>${msg_admin_activity_authEvent_unlink}</option></select></div>
          <div><div class="adm-filter-label">${msg_admin_activity_method}</div><select class="adm-select" name="httpMethod"><option value="ALL" ${search.httpMethod=='ALL'?'selected':''}>${msg_admin_common_all}</option><option value="GET" ${search.httpMethod=='GET'?'selected':''}>${msg_admin_activity_method_get}</option><option value="POST" ${search.httpMethod=='POST'?'selected':''}>${msg_admin_activity_method_post}</option><option value="PUT" ${search.httpMethod=='PUT'?'selected':''}>${msg_admin_activity_method_put}</option><option value="DELETE" ${search.httpMethod=='DELETE'?'selected':''}>${msg_admin_activity_method_delete}</option></select></div>
          <div><div class="adm-filter-label">${msg_admin_logs_success}</div><select class="adm-select" name="success"><option value="ALL" ${search.success=='ALL'?'selected':''}>${msg_admin_common_all}</option><option value="SUCCESS" ${search.success=='SUCCESS'?'selected':''}>${msg_admin_common_success}</option><option value="FAIL" ${search.success=='FAIL'?'selected':''}>${msg_admin_common_fail}</option></select></div>
          <div class="adm-audit-filter-actions">
            <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_searchButton}</button>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/activity-logs">${msg_admin_common_reset}</a>
          </div>
        </div>
      </form>
    </div>
  </div>
  <div class="adm-card adm-activity-log-card">
    <div class="adm-card-head"><div class="adm-card-title">${msg_admin_activity_historyTitle}<span class="adm-section-total-inline">${msg_admin_common_totalCount}</span></div></div>
    <div class="adm-table-wrap">
      <table class="adm-table">
        <thead><tr>
          <th data-sort="time" onclick="sortBy('time')">${msg_admin_common_time}<span class="sort-ico" aria-hidden="true"></span></th>
          <th data-sort="member" onclick="sortBy('member')">${msg_admin_common_member}<span class="sort-ico" aria-hidden="true"></span></th>
          <th data-sort="domain" onclick="sortBy('domain')">${msg_admin_activity_domain}<span class="sort-ico" aria-hidden="true"></span></th>
          <th data-sort="type" onclick="sortBy('type')">${msg_admin_activity_type}<span class="sort-ico" aria-hidden="true"></span></th>
          <th data-sort="activityCode" onclick="sortBy('activityCode')">${msg_admin_activity_code}<span class="sort-ico" aria-hidden="true"></span></th>
          <th data-sort="uri" onclick="sortBy('uri')">${msg_admin_common_uri}<span class="sort-ico" aria-hidden="true"></span></th>
          <th data-sort="method" onclick="sortBy('method')">${msg_admin_activity_method}<span class="sort-ico" aria-hidden="true"></span></th>
          <th data-sort="status" onclick="sortBy('status')">${msg_admin_common_status}<span class="sort-ico" aria-hidden="true"></span></th>
          <th data-sort="ip" onclick="sortBy('ip')">${msg_admin_common_ip}<span class="sort-ico" aria-hidden="true"></span></th>
          <th data-sort="flow" onclick="sortBy('flow')">${msg_admin_activity_flow}<span class="sort-ico" aria-hidden="true"></span></th>
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
                <span class="adm-cell-link-note">${msg_admin_common_sameDate}</span>
              </button>
            </td>
            <td>
              <c:choose>
                <c:when test="${not empty item.userIdx}">
                  <button type="button" class="adm-inline-link adm-activity-member-name js-open-member-context" data-user-idx="${item.userIdx}" data-default-tab="activity"><c:out value="${item.nickname}"/></button>
                  <div class="mem-uid"><button type="button" class="adm-inline-link adm-activity-member-id js-open-member-context" data-user-idx="${item.userIdx}" data-default-tab="activity">@${item.userId}</button></div>
                </c:when>
                <c:otherwise>
                  <div class="mem-name">${msg_admin_activity_guest}</div>
                  <div class="mem-uid">-</div>
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-param-name="activityDomain" data-param-value="${item.activityDomain}" onclick="applySelectFilter(this)">
                <span><c:choose>
                  <c:when test="${item.activityDomain eq 'GENERAL'}">${msg_admin_activity_domain_general}</c:when>
                  <c:when test="${item.activityDomain eq 'AUTH'}">${msg_admin_activity_domain_auth}</c:when>
                  <c:when test="${item.activityDomain eq 'ADMIN'}">${msg_admin_activity_domain_admin}</c:when>
                  <c:when test="${item.activityDomain eq 'COMMUNITY'}">${msg_admin_activity_domain_community}</c:when>
                  <c:when test="${item.activityDomain eq 'MYPAGE'}">${msg_admin_activity_domain_mypage}</c:when>
                  <c:when test="${item.activityDomain eq 'INQUIRY'}">${msg_admin_activity_domain_inquiry}</c:when>
                  <c:otherwise><c:out value="${empty item.activityDomain ? '-' : item.activityDomain}"/></c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note">${msg_admin_common_sameValue}</span>
              </button>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-param-name="activityType" data-param-value="${item.activityType}" onclick="applySelectFilter(this)">
                <span><c:choose>
                  <c:when test="${item.activityType eq 'PAGE_VIEW'}">${msg_admin_activity_type_pageView}</c:when>
                  <c:when test="${item.activityType eq 'ACTION'}">${msg_admin_activity_type_action}</c:when>
                  <c:when test="${item.activityType eq 'AJAX'}">${msg_admin_activity_type_ajax}</c:when>
                  <c:when test="${item.activityType eq 'API'}">${msg_admin_activity_type_api}</c:when>
                  <c:otherwise><c:out value="${item.activityType}"/></c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note">${msg_admin_common_sameValue}</span>
              </button>
            </td>
            <td>
              <c:choose>
                <c:when test="${not empty item.activityCode}">
                  <button type="button" class="adm-cell-link" data-keyword="${item.activityCode}" onclick="applyKeywordFilter(this)">
                    <span><c:out value="${item.activityCode}"/></span>
                    <span class="adm-cell-link-note">${msg_admin_common_sameValue}</span>
                  </button>
                </c:when>
                <c:otherwise><div>-</div></c:otherwise>
              </c:choose>
              <c:if test="${not empty item.activityProvider or not empty item.authEventType}">
                <div class="adm-activity-code-meta">
                  <c:choose>
                    <c:when test="${item.activityProvider eq 'LOCAL'}">${msg_admin_logs_provider_local}</c:when>
                    <c:when test="${item.activityProvider eq 'KAKAO'}">${msg_admin_logs_provider_kakao}</c:when>
                    <c:when test="${item.activityProvider eq 'NAVER'}">${msg_admin_logs_provider_naver}</c:when>
                    <c:when test="${item.activityProvider eq 'GOOGLE'}">${msg_admin_logs_provider_google}</c:when>
                    <c:otherwise><c:out value="${empty item.activityProvider ? '-' : item.activityProvider}"/></c:otherwise>
                  </c:choose>
                  <c:if test="${not empty item.authEventType}">
                    /
                    <c:choose>
                      <c:when test="${item.authEventType eq 'LOGIN'}">${msg_admin_activity_authEvent_login}</c:when>
                      <c:when test="${item.authEventType eq 'LOGOUT'}">${msg_admin_activity_authEvent_logout}</c:when>
                      <c:when test="${item.authEventType eq 'LINK'}">${msg_admin_activity_authEvent_link}</c:when>
                      <c:when test="${item.authEventType eq 'UNLINK'}">${msg_admin_activity_authEvent_unlink}</c:when>
                      <c:otherwise><c:out value="${item.authEventType}"/></c:otherwise>
                    </c:choose>
                  </c:if>
                </div>
              </c:if>
              <div class="adm-inline-actions">
                <c:if test="${(item.targetType eq 'USER' or item.targetType eq 'user') and not empty item.targetId}">
                  <button type="button" class="adm-inline-chip js-open-member-context" data-user-idx="${item.targetId}">${msg_admin_common_viewTarget}</button>
                </c:if>
                <c:if test="${(item.targetType eq 'REPORT' or item.targetType eq 'report') and not empty item.targetId}">
                  <a href="${pageContext.request.contextPath}/admin/reports/${item.targetId}" class="adm-inline-chip">${msg_admin_common_viewDetail}</a>
                </c:if>
                <c:if test="${(item.targetType eq 'INQUIRY' or item.targetType eq 'inquiry') and not empty item.targetId}">
                  <a href="${pageContext.request.contextPath}/admin/inquiries/${item.targetId}" class="adm-inline-chip">${msg_admin_common_viewDetail}</a>
                </c:if>
                <c:if test="${not empty item.targetId}">
                  <button type="button" class="adm-inline-chip" data-keyword="${item.targetId}" onclick="applyKeywordFilter(this)">${msg_admin_common_sameTarget}</button>
                </c:if>
              </div>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-keyword="${item.requestUri}" onclick="applyKeywordFilter(this)">
                <span class="adm-cell-break"><c:out value="${item.requestUri}"/></span>
                <c:if test="${not empty item.detailSummary}">
                  <span class="adm-cell-link-note"><c:out value="${item.detailSummary}"/></span>
                </c:if>
              </button>
              <c:if test="${not empty item.detailSummary}">
                <div class="adm-tr-inline js-admin-translation-widget"
                     data-label="${msg_admin_translation_label_activityLogDetailSummary}"
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
                  <c:when test="${item.httpMethod eq 'GET'}">${msg_admin_activity_method_get}</c:when>
                  <c:when test="${item.httpMethod eq 'POST'}">${msg_admin_activity_method_post}</c:when>
                  <c:when test="${item.httpMethod eq 'PUT'}">${msg_admin_activity_method_put}</c:when>
                  <c:when test="${item.httpMethod eq 'DELETE'}">${msg_admin_activity_method_delete}</c:when>
                  <c:otherwise><c:out value="${item.httpMethod}"/></c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note">${msg_admin_common_sameValue}</span>
              </button>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-param-name="success" data-param-value="${item.success ? 'SUCCESS' : 'FAIL'}" onclick="applySelectFilter(this)">
                <span><c:out value="${item.responseStatus}"/></span>
                <span class="adm-cell-link-note"><c:out value="${item.success ? msg_admin_common_success : msg_admin_common_fail}"/></span>
              </button>
            </td>
            <td>
              <c:choose>
                <c:when test="${not empty item.ipAddress}">
                  <button type="button" class="adm-cell-link js-open-ip-context" data-ip-address="${item.ipAddress}" data-default-tab="activity">
                    <span class="adm-activity-ip"><c:out value="${item.ipAddress}"/></span>
                    <span class="adm-cell-link-note">${msg_admin_common_sameIp}</span>
                  </button>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-keyword="${not empty item.requestId ? item.requestId : item.flowTraceId}" onclick="applyKeywordFilter(this)">
                <span class="adm-flow-id"><c:out value="${empty item.requestId ? '-' : item.requestId}"/></span>
                <c:if test="${not empty item.flowTraceId}">
                  <span class="adm-cell-link-note">${msg_admin_common_trace}: <c:out value="${item.flowTraceId}"/></span>
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
                ${msg_admin_common_viewDetail}
              </button>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty list}"><tr class="adm-local-empty"><td colspan="11" class="adm-local-empty-cell">${msg_admin_common_noResults}</td></tr></c:if>
      </tbody></table>
    </div>
    <c:if test="${paging.totalPage > 1}"><div class="adm-paging"><c:if test="${paging.prev}"><button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button></c:if><c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"><button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}" onclick="goPage(${p})">${p}</button></c:forEach><c:if test="${paging.next}"><button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button></c:if><span class="adm-page-info">${msg_admin_common_pageStatus}</span></div></c:if>
  </div>
</div>

<div id="rowDetailModal" class="adm-modal-overlay" onclick="this.classList.remove('open')">
  <div class="adm-modal adm-audit-row-detail-modal" onclick="event.stopPropagation()">
    <div class="adm-modal-head">
      <div class="adm-modal-title" id="rowDetailModalTitle"></div>
      <button class="adm-modal-close" onclick="document.getElementById('rowDetailModal').classList.remove('open')">✕</button>
    </div>
    <div class="adm-modal-body adm-audit-row-detail-body">
      <dl id="rowDetailModalContent" class="adm-audit-row-detail-list"></dl>
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
    if (ico) {
      ico.textContent = curSortDir === 'ASC' ? '▲' : '▼';
      ico.style.color = curSortDir === 'ASC' ? '#ef4444' : '#3b82f6';
    }
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
  showRowDetail('${msg_admin_activity_historyTitle}', [
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
    dt.className = 'adm-audit-row-detail-key';
    dt.textContent = label;
    var dd = document.createElement('dd');
    dd.className = 'adm-audit-row-detail-value';
    dd.textContent = value;
    content.appendChild(dt);
    content.appendChild(dd);
  });
  modal.classList.add('open');
}
</script>
<%@ include file="../layout-close.jsp" %>
