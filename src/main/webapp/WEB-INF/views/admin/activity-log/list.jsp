<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_511e1748e3" code="admin.common.search"/>
<spring:message var="autoMsg_5d6f8d636d" code="admin.activity.searchPlaceholder"/>
<spring:message var="autoMsg_1a7012409e" code="admin.activity.domain"/>
<spring:message var="autoMsg_8a0409a969" code="admin.common.all"/>
<spring:message var="autoMsg_b02d1251e7" code="admin.activity.domain.general"/>
<spring:message var="autoMsg_819e000313" code="admin.activity.domain.auth"/>
<spring:message var="autoMsg_838a254e15" code="admin.activity.domain.admin"/>
<spring:message var="autoMsg_5a6bef150d" code="admin.activity.domain.community"/>
<spring:message var="autoMsg_514415e9aa" code="admin.activity.domain.mypage"/>
<spring:message var="autoMsg_2db6aa955b" code="admin.activity.domain.inquiry"/>
<spring:message var="autoMsg_02fb01adbf" code="admin.activity.type"/>
<spring:message var="autoMsg_da9585643b" code="admin.activity.type.pageView"/>
<spring:message var="autoMsg_858a9e2d34" code="admin.activity.type.action"/>
<spring:message var="autoMsg_f8e3a748d3" code="admin.activity.type.ajax"/>
<spring:message var="autoMsg_d745565752" code="admin.activity.type.api"/>
<spring:message var="autoMsg_ef783e94b0" code="admin.logs.provider"/>
<spring:message var="autoMsg_b248505b87" code="admin.logs.provider.local"/>
<spring:message var="autoMsg_c2ba5baa18" code="admin.logs.provider.kakao"/>
<spring:message var="autoMsg_e08771308a" code="admin.logs.provider.naver"/>
<spring:message var="autoMsg_b17a92bec4" code="admin.logs.provider.google"/>
<spring:message var="autoMsg_441f1808d9" code="admin.activity.authEvent"/>
<spring:message var="autoMsg_2173b07736" code="admin.activity.authEvent.login"/>
<spring:message var="autoMsg_733e6ed44f" code="admin.activity.authEvent.logout"/>
<spring:message var="autoMsg_666d925aa4" code="admin.activity.authEvent.link"/>
<spring:message var="autoMsg_9b41a51d54" code="admin.activity.authEvent.unlink"/>
<spring:message var="autoMsg_38b49a0459" code="admin.activity.method"/>
<spring:message var="autoMsg_30ed05b82c" code="admin.activity.method.get"/>
<spring:message var="autoMsg_4afe4dbec6" code="admin.activity.method.post"/>
<spring:message var="autoMsg_04d74843bd" code="admin.activity.method.put"/>
<spring:message var="autoMsg_38350e221e" code="admin.activity.method.delete"/>
<spring:message var="autoMsg_76e38bfaa0" code="admin.logs.success"/>
<spring:message var="autoMsg_cfac0bb333" code="admin.common.success"/>
<spring:message var="autoMsg_905f4f82bc" code="admin.common.fail"/>
<spring:message var="autoMsg_b0bf2bb2df" code="admin.common.searchButton"/>
<spring:message var="autoMsg_97fe8371fe" code="admin.common.reset"/>
<spring:message var="autoMsg_02ff18aec3" code="admin.activity.historyTitle"/>
<spring:message var="autoMsg_89c3457daa" code="admin.common.totalCount"/>
<spring:message var="autoMsg_2e03de840c" code="admin.common.time"/>
<spring:message var="autoMsg_26713101ca" code="admin.common.member"/>
<spring:message var="autoMsg_57e3f49ab7" code="admin.activity.code"/>
<spring:message var="autoMsg_76d3365c53" code="admin.common.uri"/>
<spring:message var="autoMsg_d4e28c5823" code="admin.common.status"/>
<spring:message var="autoMsg_da705efb2b" code="admin.common.ip"/>
<spring:message var="autoMsg_7c25f29a44" code="admin.activity.flow"/>
<spring:message var="autoMsg_e85a49eb7d" code="admin.common.sameDate"/>
<spring:message var="autoMsg_6e04c8026d" code="admin.activity.guest"/>
<spring:message var="autoMsg_db92625ca9" code="admin.common.sameValue"/>
<spring:message var="autoMsg_2729211cb6" code="admin.common.viewTarget"/>
<spring:message var="autoMsg_a78f92e193" code="admin.common.viewDetail"/>
<spring:message var="autoMsg_83bc1ff3e0" code="admin.common.sameTarget"/>
<spring:message var="autoMsg_15fa02a9e9" code="admin.translation.label.activityLogDetailSummary"/>
<spring:message var="autoMsg_457ebe26df" code="admin.common.sameIp"/>
<spring:message var="autoMsg_0940980042" code="admin.common.trace"/>
<spring:message var="autoMsg_c64dea2728" code="admin.common.noResults"/>
<spring:message var="autoMsg_147ba64a5d" code="admin.common.pageStatus"/>
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
          <div class="adm-search-box" style="flex:1;min-width:220px;"><div class="adm-filter-label">${autoMsg_511e1748e3}</div><span class="adm-search-ico">🔍</span><input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="${autoMsg_5d6f8d636d}"></div>
          <div><div class="adm-filter-label">${autoMsg_1a7012409e}</div><select class="adm-select" name="activityDomain"><option value="ALL" ${search.activityDomain=='ALL'?'selected':''}>${autoMsg_8a0409a969}</option><option value="GENERAL" ${search.activityDomain=='GENERAL'?'selected':''}>${autoMsg_b02d1251e7}</option><option value="AUTH" ${search.activityDomain=='AUTH'?'selected':''}>${autoMsg_819e000313}</option><option value="ADMIN" ${search.activityDomain=='ADMIN'?'selected':''}>${autoMsg_838a254e15}</option><option value="COMMUNITY" ${search.activityDomain=='COMMUNITY'?'selected':''}>${autoMsg_5a6bef150d}</option><option value="MYPAGE" ${search.activityDomain=='MYPAGE'?'selected':''}>${autoMsg_514415e9aa}</option><option value="INQUIRY" ${search.activityDomain=='INQUIRY'?'selected':''}>${autoMsg_2db6aa955b}</option></select></div>
          <div><div class="adm-filter-label">${autoMsg_02fb01adbf}</div><select class="adm-select" name="activityType"><option value="ALL" ${search.activityType=='ALL'?'selected':''}>${autoMsg_8a0409a969}</option><option value="PAGE_VIEW" ${search.activityType=='PAGE_VIEW'?'selected':''}>${autoMsg_da9585643b}</option><option value="ACTION" ${search.activityType=='ACTION'?'selected':''}>${autoMsg_858a9e2d34}</option><option value="AJAX" ${search.activityType=='AJAX'?'selected':''}>${autoMsg_f8e3a748d3}</option><option value="API" ${search.activityType=='API'?'selected':''}>${autoMsg_d745565752}</option></select></div>
          <div><div class="adm-filter-label">${autoMsg_ef783e94b0}</div><select class="adm-select" name="activityProvider"><option value="ALL" ${search.activityProvider=='ALL'?'selected':''}>${autoMsg_8a0409a969}</option><option value="LOCAL" ${search.activityProvider=='LOCAL'?'selected':''}>${autoMsg_b248505b87}</option><option value="KAKAO" ${search.activityProvider=='KAKAO'?'selected':''}>${autoMsg_c2ba5baa18}</option><option value="NAVER" ${search.activityProvider=='NAVER'?'selected':''}>${autoMsg_e08771308a}</option><option value="GOOGLE" ${search.activityProvider=='GOOGLE'?'selected':''}>${autoMsg_b17a92bec4}</option></select></div>
          <div><div class="adm-filter-label">${autoMsg_441f1808d9}</div><select class="adm-select" name="authEventType"><option value="ALL" ${search.authEventType=='ALL'?'selected':''}>${autoMsg_8a0409a969}</option><option value="LOGIN" ${search.authEventType=='LOGIN'?'selected':''}>${autoMsg_2173b07736}</option><option value="LOGOUT" ${search.authEventType=='LOGOUT'?'selected':''}>${autoMsg_733e6ed44f}</option><option value="LINK" ${search.authEventType=='LINK'?'selected':''}>${autoMsg_666d925aa4}</option><option value="UNLINK" ${search.authEventType=='UNLINK'?'selected':''}>${autoMsg_9b41a51d54}</option></select></div>
          <div><div class="adm-filter-label">${autoMsg_38b49a0459}</div><select class="adm-select" name="httpMethod"><option value="ALL" ${search.httpMethod=='ALL'?'selected':''}>${autoMsg_8a0409a969}</option><option value="GET" ${search.httpMethod=='GET'?'selected':''}>${autoMsg_30ed05b82c}</option><option value="POST" ${search.httpMethod=='POST'?'selected':''}>${autoMsg_4afe4dbec6}</option><option value="PUT" ${search.httpMethod=='PUT'?'selected':''}>${autoMsg_04d74843bd}</option><option value="DELETE" ${search.httpMethod=='DELETE'?'selected':''}>${autoMsg_38350e221e}</option></select></div>
          <div><div class="adm-filter-label">${autoMsg_76e38bfaa0}</div><select class="adm-select" name="success"><option value="ALL" ${search.success=='ALL'?'selected':''}>${autoMsg_8a0409a969}</option><option value="SUCCESS" ${search.success=='SUCCESS'?'selected':''}>${autoMsg_cfac0bb333}</option><option value="FAIL" ${search.success=='FAIL'?'selected':''}>${autoMsg_905f4f82bc}</option></select></div>
          <div style="display:flex;align-items:flex-end;gap:8px;">
            <button class="adm-btn adm-btn-primary" type="submit">${autoMsg_b0bf2bb2df}</button>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/activity-logs">${autoMsg_97fe8371fe}</a>
          </div>
        </div>
      </form>
    </div>
  </div>
  <div class="adm-card">
    <div class="adm-card-head"><div class="adm-card-title">${autoMsg_02ff18aec3}</div><div style="font-size:12px;color:#64748b;">${autoMsg_89c3457daa}</div></div>
    <div class="adm-table-wrap">
      <table class="adm-table">
        <thead><tr>
          <th data-sort="time" onclick="sortBy('time')">${autoMsg_2e03de840c}<span class="sort-ico">▼</span></th>
          <th data-sort="member" onclick="sortBy('member')">${autoMsg_26713101ca}<span class="sort-ico">▼</span></th>
          <th data-sort="domain" onclick="sortBy('domain')">${autoMsg_1a7012409e}<span class="sort-ico">▼</span></th>
          <th data-sort="type" onclick="sortBy('type')">${autoMsg_02fb01adbf}<span class="sort-ico">▼</span></th>
          <th data-sort="activityCode" onclick="sortBy('activityCode')">${autoMsg_57e3f49ab7}<span class="sort-ico">▼</span></th>
          <th data-sort="uri" onclick="sortBy('uri')">${autoMsg_76d3365c53}<span class="sort-ico">▼</span></th>
          <th data-sort="method" onclick="sortBy('method')">${autoMsg_38b49a0459}<span class="sort-ico">▼</span></th>
          <th data-sort="status" onclick="sortBy('status')">${autoMsg_d4e28c5823}<span class="sort-ico">▼</span></th>
          <th data-sort="ip" onclick="sortBy('ip')">${autoMsg_da705efb2b}<span class="sort-ico">▼</span></th>
          <th data-sort="flow" onclick="sortBy('flow')">${autoMsg_7c25f29a44}<span class="sort-ico">▼</span></th>
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
                <span class="adm-cell-link-note">${autoMsg_e85a49eb7d}</span>
              </button>
            </td>
            <td>
              <c:choose>
                <c:when test="${not empty item.userIdx}">
                  <button type="button" class="adm-inline-link js-open-member-context" data-user-idx="${item.userIdx}" data-default-tab="activity" style="font-weight:700;color:#93c5fd;"><c:out value="${item.nickname}"/></button>
                  <div class="mem-uid"><button type="button" class="adm-inline-link js-open-member-context" data-user-idx="${item.userIdx}" data-default-tab="activity" style="color:#94a3b8;">@${item.userId}</button></div>
                </c:when>
                <c:otherwise>
                  <div class="mem-name">${autoMsg_6e04c8026d}</div>
                  <div class="mem-uid">-</div>
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-param-name="activityDomain" data-param-value="${item.activityDomain}" onclick="applySelectFilter(this)">
                <span><c:choose>
                  <c:when test="${item.activityDomain eq 'GENERAL'}">${autoMsg_b02d1251e7}</c:when>
                  <c:when test="${item.activityDomain eq 'AUTH'}">${autoMsg_819e000313}</c:when>
                  <c:when test="${item.activityDomain eq 'ADMIN'}">${autoMsg_838a254e15}</c:when>
                  <c:when test="${item.activityDomain eq 'COMMUNITY'}">${autoMsg_5a6bef150d}</c:when>
                  <c:when test="${item.activityDomain eq 'MYPAGE'}">${autoMsg_514415e9aa}</c:when>
                  <c:when test="${item.activityDomain eq 'INQUIRY'}">${autoMsg_2db6aa955b}</c:when>
                  <c:otherwise><c:out value="${empty item.activityDomain ? '-' : item.activityDomain}"/></c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note">${autoMsg_db92625ca9}</span>
              </button>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-param-name="activityType" data-param-value="${item.activityType}" onclick="applySelectFilter(this)">
                <span><c:choose>
                  <c:when test="${item.activityType eq 'PAGE_VIEW'}">${autoMsg_da9585643b}</c:when>
                  <c:when test="${item.activityType eq 'ACTION'}">${autoMsg_858a9e2d34}</c:when>
                  <c:when test="${item.activityType eq 'AJAX'}">${autoMsg_f8e3a748d3}</c:when>
                  <c:when test="${item.activityType eq 'API'}">${autoMsg_d745565752}</c:when>
                  <c:otherwise><c:out value="${item.activityType}"/></c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note">${autoMsg_db92625ca9}</span>
              </button>
            </td>
            <td>
              <c:choose>
                <c:when test="${not empty item.activityCode}">
                  <button type="button" class="adm-cell-link" data-keyword="${item.activityCode}" onclick="applyKeywordFilter(this)">
                    <span><c:out value="${item.activityCode}"/></span>
                    <span class="adm-cell-link-note">${autoMsg_db92625ca9}</span>
                  </button>
                </c:when>
                <c:otherwise><div>-</div></c:otherwise>
              </c:choose>
              <c:if test="${not empty item.activityProvider or not empty item.authEventType}">
                <div style="margin-top:4px;font-size:11px;color:#64748b;">
                  <c:choose>
                    <c:when test="${item.activityProvider eq 'LOCAL'}">${autoMsg_b248505b87}</c:when>
                    <c:when test="${item.activityProvider eq 'KAKAO'}">${autoMsg_c2ba5baa18}</c:when>
                    <c:when test="${item.activityProvider eq 'NAVER'}">${autoMsg_e08771308a}</c:when>
                    <c:when test="${item.activityProvider eq 'GOOGLE'}">${autoMsg_b17a92bec4}</c:when>
                    <c:otherwise><c:out value="${empty item.activityProvider ? '-' : item.activityProvider}"/></c:otherwise>
                  </c:choose>
                  <c:if test="${not empty item.authEventType}">
                    /
                    <c:choose>
                      <c:when test="${item.authEventType eq 'LOGIN'}">${autoMsg_2173b07736}</c:when>
                      <c:when test="${item.authEventType eq 'LOGOUT'}">${autoMsg_733e6ed44f}</c:when>
                      <c:when test="${item.authEventType eq 'LINK'}">${autoMsg_666d925aa4}</c:when>
                      <c:when test="${item.authEventType eq 'UNLINK'}">${autoMsg_9b41a51d54}</c:when>
                      <c:otherwise><c:out value="${item.authEventType}"/></c:otherwise>
                    </c:choose>
                  </c:if>
                </div>
              </c:if>
              <div class="adm-inline-actions">
                <c:if test="${(item.targetType eq 'USER' or item.targetType eq 'user') and not empty item.targetId}">
                  <button type="button" class="adm-inline-chip js-open-member-context" data-user-idx="${item.targetId}">${autoMsg_2729211cb6}</button>
                </c:if>
                <c:if test="${(item.targetType eq 'REPORT' or item.targetType eq 'report') and not empty item.targetId}">
                  <a href="${pageContext.request.contextPath}/admin/reports/${item.targetId}" class="adm-inline-chip">${autoMsg_a78f92e193}</a>
                </c:if>
                <c:if test="${(item.targetType eq 'INQUIRY' or item.targetType eq 'inquiry') and not empty item.targetId}">
                  <a href="${pageContext.request.contextPath}/admin/inquiries/${item.targetId}" class="adm-inline-chip">${autoMsg_a78f92e193}</a>
                </c:if>
                <c:if test="${not empty item.targetId}">
                  <button type="button" class="adm-inline-chip" data-keyword="${item.targetId}" onclick="applyKeywordFilter(this)">${autoMsg_83bc1ff3e0}</button>
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
                     data-label="${autoMsg_15fa02a9e9}"
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
                  <c:when test="${item.httpMethod eq 'GET'}">${autoMsg_30ed05b82c}</c:when>
                  <c:when test="${item.httpMethod eq 'POST'}">${autoMsg_4afe4dbec6}</c:when>
                  <c:when test="${item.httpMethod eq 'PUT'}">${autoMsg_04d74843bd}</c:when>
                  <c:when test="${item.httpMethod eq 'DELETE'}">${autoMsg_38350e221e}</c:when>
                  <c:otherwise><c:out value="${item.httpMethod}"/></c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note">${autoMsg_db92625ca9}</span>
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
                    <span class="adm-cell-link-note">${autoMsg_457ebe26df}</span>
                  </button>
                </c:when>
                <c:otherwise>-</c:otherwise>
              </c:choose>
            </td>
            <td>
              <button type="button" class="adm-cell-link" data-keyword="${not empty item.requestId ? item.requestId : item.flowTraceId}" onclick="applyKeywordFilter(this)">
                <span style="font-size:12px;color:#64748b;"><c:out value="${empty item.requestId ? '-' : item.requestId}"/></span>
                <c:if test="${not empty item.flowTraceId}">
                  <span class="adm-cell-link-note">${autoMsg_0940980042}: <c:out value="${item.flowTraceId}"/></span>
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
        <c:if test="${empty list}"><tr><td colspan="11" style="text-align:center;padding:40px;color:#475569;">${autoMsg_c64dea2728}</td></tr></c:if>
      </tbody></table>
    </div>
    <c:if test="${paging.totalPage > 1}"><div class="adm-paging"><c:if test="${paging.prev}"><button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button></c:if><c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"><button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}" onclick="goPage(${p})">${p}</button></c:forEach><c:if test="${paging.next}"><button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button></c:if><span class="adm-page-info">${autoMsg_147ba64a5d}</span></div></c:if>
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
  showRowDetail('${autoMsg_02ff18aec3}', [
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
</script>
<%@ include file="../layout-close.jsp" %>
