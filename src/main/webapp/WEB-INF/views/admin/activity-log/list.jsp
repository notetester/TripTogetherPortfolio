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
<spring:message var="msg_admin_common_prev" code="admin.common.prev"/>
<spring:message var="msg_admin_common_next" code="admin.common.next"/>
<spring:message var="msg_admin_common_pageSize_30" code="admin.common.pageSize" arguments="30"/>
<spring:message var="msg_admin_common_pageSize_50" code="admin.common.pageSize" arguments="50"/>
<spring:message var="msg_admin_common_pageSize_100" code="admin.common.pageSize" arguments="100"/>
<spring:message var="msg_admin_blocks_js_dashSortReset_js" code="admin.blocks.js.dashSortReset" javaScriptEscape="true"/>
<spring:message var="msg_admin_activity_totalCountDisplay" code="admin.common.totalCountFormat" arguments="${total}"/>
<spring:message var="msg_admin_activity_currentCountDisplay" code="admin.common.currentCountFormat" arguments="${fn:length(list)}"/>
<c:set var="activeMenu" value="activityLogs"/>


<c:set var="pageTitle" value="${msg_admin_activity_pageTitle}"/>
<%@ include file="../layout.jsp" %>
<div class="adm-content">
  <div class="adm-card adm-audit-filter-card adm-activity-audit-filter-card adm-overflow-visible">
    <div class="adm-card-body">
      <form method="get" action="${pageContext.request.contextPath}/admin/activity-logs">
        <div class="adm-filter-bar adm-audit-filterbar adm-activity-audit-filterbar">
          <div class="adm-search-box adm-audit-search-box"><div class="adm-filter-label">${msg_admin_common_search}</div><span class="adm-search-ico">🔍</span><input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(search.keyword)}" placeholder="${msg_admin_activity_searchPlaceholder}"></div>
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
          <input type="hidden" name="size" value="${search.size}">
          <input type="hidden" name="sortField" value="${fn:escapeXml(search.sortField)}">
          <input type="hidden" name="sortDir" value="${fn:escapeXml(search.sortDir)}">
        </div>
      </form>
    </div>
  </div>
  <div class="adm-card adm-managed-section-card adm-activity-log-card js-activity-section-card adm-overflow-visible">
    <div class="adm-card-head"><div class="adm-card-title">${msg_admin_activity_historyTitle}<span class="adm-section-total-inline">${msg_admin_activity_totalCountDisplay}</span></div></div>
    <div class="adm-local-toolbar adm-managed-local-toolbar">
      <div class="adm-managed-selection-bar" id="activitySelectionBar" aria-live="polite">
        <span class="adm-managed-selected-count" id="activitySelectedCount">0건 선택</span>
        <button type="button" class="adm-btn adm-btn-ghost" onclick="clearActivitySelection()">선택 해제</button>
      </div>
      <div class="adm-local-toolbar-group adm-managed-toolbar-actions">
        <button type="button" class="adm-dash-sort-reset js-activity-sort-reset adm-is-hidden" onclick="resetActivitySort()"></button>
        <select class="adm-select adm-audit-size-select" id="activitySizeSelect" onchange="changeActivitySize(this.value)">
          <option value="30" ${search.size==30 ? 'selected' : ''}>${msg_admin_common_pageSize_30}</option>
          <option value="50" ${search.size==50 ? 'selected' : ''}>${msg_admin_common_pageSize_50}</option>
          <option value="100" ${search.size==100 ? 'selected' : ''}>${msg_admin_common_pageSize_100}</option>
        </select>
        <select class="adm-select adm-managed-export-format" id="activityExportFormat" aria-label="내보내기 형식">
          <option value="csv">CSV</option>
          <option value="excel">Excel</option>
        </select>
        <button type="button" class="adm-btn adm-btn-primary js-activity-selected-export" onclick="exportSelectedActivityLogs()" disabled>선택 내보내기</button>
      </div>
    </div>
    <div class="adm-table-wrap">
      <table class="adm-table adm-section-table-fixed adm-activity-section-table" data-admin-list-ignore="hard">
        <thead><tr>
          <th class="adm-managed-check-cell">
            <input type="checkbox" class="adm-check" id="activityCheckAll" aria-label="현재 화면 전체 선택">
          </th>
          <th class="js-activity-sort" data-sort="time" onclick="sortBy('time')">${msg_admin_common_time}</th>
          <th class="js-activity-sort" data-sort="member" onclick="sortBy('member')">${msg_admin_common_member}</th>
          <th class="js-activity-sort" data-sort="domain" onclick="sortBy('domain')">${msg_admin_activity_domain}</th>
          <th class="js-activity-sort" data-sort="type" onclick="sortBy('type')">${msg_admin_activity_type}</th>
          <th class="js-activity-sort" data-sort="activityCode" onclick="sortBy('activityCode')">${msg_admin_activity_code}</th>
          <th class="js-activity-sort" data-sort="uri" onclick="sortBy('uri')">${msg_admin_common_uri}</th>
          <th class="js-activity-sort" data-sort="method" onclick="sortBy('method')">${msg_admin_activity_method}</th>
          <th class="js-activity-sort" data-sort="status" onclick="sortBy('status')">${msg_admin_common_status}</th>
          <th class="js-activity-sort" data-sort="ip" onclick="sortBy('ip')">${msg_admin_common_ip}</th>
          <th class="js-activity-sort" data-sort="flow" onclick="sortBy('flow')">${msg_admin_activity_flow}</th>
          <th onclick="openFirstActivityDetail()">${msg_admin_common_viewDetail}</th>
        </tr></thead>
        <tbody>
        <c:forEach items="${list}" var="item">
          <fmt:formatDate var="itemDateFilter" value="${item.createdAtDate}" pattern="yyyy-MM-dd"/>
          <fmt:formatDate var="itemTimeDisplay" value="${item.createdAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
          <tr class="js-activity-row">
            <td class="adm-managed-check-cell">
              <input type="checkbox" class="adm-check js-activity-row-check" value="${item.activityIdx}" aria-label="행 선택">
            </td>
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
        <c:if test="${empty list}"><tr class="adm-local-empty"><td colspan="12" class="adm-local-empty-cell">${msg_admin_common_noResults}</td></tr></c:if>
      </tbody></table>
    </div>
    <div class="adm-local-pagination" id="activityPaging">
      <div class="adm-local-page-info">${msg_admin_activity_totalCountDisplay} / ${msg_admin_activity_currentCountDisplay}</div>
      <div class="adm-local-page-actions">
        <button type="button" class="adm-btn adm-btn-ghost" ${paging.currentPage <= 1 ? 'disabled' : ''} onclick="goPage(${paging.currentPage - 1})">${msg_admin_common_prev}</button>
        <span class="js-activity-page-state">${paging.currentPage} / ${paging.totalPage}</span>
        <button type="button" class="adm-btn adm-btn-ghost" ${paging.currentPage >= paging.totalPage ? 'disabled' : ''} onclick="goPage(${paging.currentPage + 1})">${msg_admin_common_next}</button>
      </div>
    </div>
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
var activitySortResetText = '${msg_admin_blocks_js_dashSortReset_js}';

function activityRows() {
  return Array.from(document.querySelectorAll('.adm-activity-section-table .js-activity-row'));
}
function selectedActivityRows() {
  return activityRows().filter(function(row) {
    var check = row.querySelector('.js-activity-row-check');
    return check && check.checked;
  });
}
function updateActivitySelection() {
  var rows = activityRows();
  var selected = selectedActivityRows();
  var checks = rows.map(function(row) { return row.querySelector('.js-activity-row-check'); }).filter(Boolean);
  var all = document.getElementById('activityCheckAll');
  if (all) {
    all.checked = checks.length > 0 && checks.every(function(check) { return check.checked; });
    all.indeterminate = checks.some(function(check) { return check.checked; }) && !all.checked;
  }
  var count = document.getElementById('activitySelectedCount');
  if (count) count.textContent = selected.length + '건 선택';
  var bar = document.getElementById('activitySelectionBar');
  if (bar) bar.classList.toggle('is-active', selected.length > 0);
  var exportButton = document.querySelector('.js-activity-selected-export');
  if (exportButton) {
    exportButton.disabled = selected.length === 0;
    exportButton.textContent = selected.length > 0 ? '선택 내보내기 (' + selected.length + ')' : '선택 내보내기';
  }
}
function clearActivitySelection() {
  activityRows().forEach(function(row) {
    var check = row.querySelector('.js-activity-row-check');
    if (check) check.checked = false;
  });
  updateActivitySelection();
}
function toggleActivitySelection(checked) {
  activityRows().forEach(function(row) {
    var check = row.querySelector('.js-activity-row-check');
    if (check) check.checked = checked;
  });
  updateActivitySelection();
}
function activityExportText(cell) {
  var clone = cell.cloneNode(true);
  clone.querySelectorAll('.adm-cell-link-note, input, .adm-row-btn, .adm-inline-actions, .js-admin-translation-widget').forEach(function(node) { node.remove(); });
  return (clone.textContent || '').replace(/\s+/g, ' ').trim();
}
function activityCsvEscape(value) {
  return '"' + String(value == null ? '' : value).replace(/"/g, '""') + '"';
}
function activityXmlEscape(value) {
  return String(value == null ? '' : value).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}
function downloadActivityExport(content, filename, type) {
  var blob = new Blob([content], { type: type });
  var url = URL.createObjectURL(blob);
  var link = document.createElement('a');
  link.href = url;
  link.download = filename;
  document.body.appendChild(link);
  link.click();
  link.remove();
  setTimeout(function() { URL.revokeObjectURL(url); }, 1000);
}
function exportSelectedActivityLogs() {
  var selected = selectedActivityRows();
  if (!selected.length) {
    if (window.adm_toast) adm_toast('선택된 항목이 없습니다.', 'error');
    else alert('선택된 항목이 없습니다.');
    return;
  }
  var table = document.querySelector('.adm-activity-section-table');
  var headers = Array.from(table.querySelectorAll('thead th')).slice(1, -1)
    .map(function(th) { return (th.textContent || '').replace(/[▲▼]/g, '').replace(/\s+/g, ' ').trim(); });
  var rows = selected.map(function(row) {
    return Array.from(row.children).slice(1, -1).map(activityExportText);
  });
  var format = (document.getElementById('activityExportFormat') || {}).value || 'csv';
  if (format === 'excel') {
    var xmlRows = [headers].concat(rows).map(function(row, index) {
      return '<Row>' + row.map(function(value) {
        var style = index === 0 ? ' ss:StyleID="header"' : '';
        return '<Cell' + style + '><Data ss:Type="String">' + activityXmlEscape(value) + '</Data></Cell>';
      }).join('') + '</Row>';
    }).join('');
    var xls = '<?xml version="1.0" encoding="UTF-8"?><?mso-application progid="Excel.Sheet"?>'
      + '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet" xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">'
      + '<Styles><Style ss:ID="header"><Font ss:Bold="1"/><Interior ss:Color="#D9EAF7" ss:Pattern="Solid"/></Style></Styles>'
      + '<Worksheet ss:Name="selected_activity"><Table>' + xmlRows + '</Table></Worksheet></Workbook>';
    downloadActivityExport('\ufeff' + xls, 'activity-logs-selected.xls', 'application/vnd.ms-excel;charset=utf-8');
  } else {
    var csv = [headers].concat(rows).map(function(row) { return row.map(activityCsvEscape).join(','); }).join('\n');
    downloadActivityExport('\ufeff' + csv, 'activity-logs-selected.csv', 'text/csv;charset=utf-8');
  }
}

function updateActivitySortIndicators() {
  document.querySelectorAll('.adm-activity-section-table th[data-sort]').forEach(function(th) {
    var active = th.getAttribute('data-sort') === curSortField && !!curSortField;
    th.classList.toggle('sorted', active);
    var ico = th.querySelector('.sort-ico');
    if (active) {
      if (!ico) {
        ico = document.createElement('span');
        ico.className = 'sort-ico';
        ico.setAttribute('aria-hidden', 'true');
        th.appendChild(ico);
      }
      var asc = curSortDir === 'ASC';
      ico.textContent = asc ? '▲' : '▼';
      ico.classList.toggle('asc', asc);
      ico.classList.toggle('desc', !asc);
    } else if (ico) {
      ico.remove();
    }
  });
  var resetBtn = document.querySelector('.js-activity-sort-reset');
  if (resetBtn) {
    resetBtn.textContent = activitySortResetText;
    resetBtn.classList.toggle('adm-is-hidden', !curSortField);
  }
}
updateActivitySortIndicators();
document.addEventListener('DOMContentLoaded', function() {
  var all = document.getElementById('activityCheckAll');
  if (all) all.addEventListener('change', function() { toggleActivitySelection(all.checked); });
  activityRows().forEach(function(row) {
    var check = row.querySelector('.js-activity-row-check');
    if (check) check.addEventListener('change', updateActivitySelection);
  });
  updateActivitySelection();
});

function sortBy(field) {
  var params = new URLSearchParams(window.location.search);
  var dir = (params.get('sortField') === field && params.get('sortDir') !== 'ASC') ? 'ASC' : 'DESC';
  params.set('sortField', field); params.set('sortDir', dir); params.set('page', '1');
  location.href = BASE_URL + '?' + params.toString();
}
function resetActivitySort() {
  var params = new URLSearchParams(window.location.search);
  params.delete('sortField');
  params.delete('sortDir');
  params.set('page', '1');
  location.href = BASE_URL + '?' + params.toString();
}
function changeActivitySize(size) {
  var params = new URLSearchParams(window.location.search);
  params.set('size', size);
  params.set('page', '1');
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
function openFirstActivityDetail() {
  var btn = document.querySelector('.adm-activity-section-table .adm-row-btn.detail');
  if (btn) openActivityDetail(btn);
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
