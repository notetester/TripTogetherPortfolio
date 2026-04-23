<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
          <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
        </div>
      </form>
    </div>
  </div>
  <div class="adm-card"><div class="adm-card-head"><div class="adm-card-title"><spring:message code="admin.activity.historyTitle"/></div><div style="font-size:12px;color:#64748b;"><spring:message code="admin.common.totalCount" arguments="${total}"/></div></div>
    <div class="adm-table-wrap"><table class="adm-table"><thead><tr><th><spring:message code="admin.common.time"/></th><th><spring:message code="admin.common.member"/></th><th><spring:message code="admin.activity.domain"/></th><th><spring:message code="admin.activity.type"/></th><th><spring:message code="admin.activity.code"/></th><th><spring:message code="admin.common.uri"/></th><th><spring:message code="admin.activity.method"/></th><th><spring:message code="admin.common.status"/></th><th><spring:message code="admin.common.ip"/></th><th><spring:message code="admin.activity.flow"/></th></tr></thead><tbody>
      <c:forEach items="${list}" var="item"><tr>
        <td><fmt:formatDate value="${item.createdAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
        <td>
          <c:choose>
            <c:when test="${not empty item.userIdx}">
              <button type="button"
                      class="adm-inline-link js-open-member-context"
                      data-user-idx="${item.userIdx}"
                      data-default-tab="activity"
                      style="font-weight:700;color:#93c5fd;"><c:out value="${item.nickname}"/></button>
              <div class="mem-uid">
                <button type="button"
                        class="adm-inline-link js-open-member-context"
                        data-user-idx="${item.userIdx}"
                        data-default-tab="activity"
                        style="color:#94a3b8;">@${item.userId}</button>
              </div>
            </c:when>
            <c:otherwise>
              <div class="mem-name"><spring:message code="admin.activity.guest"/></div>
              <div class="mem-uid">-</div>
            </c:otherwise>
          </c:choose>
        </td>
        <td>
          <c:choose>
            <c:when test="${item.activityDomain eq 'GENERAL'}"><spring:message code="admin.activity.domain.general"/></c:when>
            <c:when test="${item.activityDomain eq 'AUTH'}"><spring:message code="admin.activity.domain.auth"/></c:when>
            <c:when test="${item.activityDomain eq 'ADMIN'}"><spring:message code="admin.activity.domain.admin"/></c:when>
            <c:when test="${item.activityDomain eq 'COMMUNITY'}"><spring:message code="admin.activity.domain.community"/></c:when>
            <c:when test="${item.activityDomain eq 'MYPAGE'}"><spring:message code="admin.activity.domain.mypage"/></c:when>
            <c:when test="${item.activityDomain eq 'INQUIRY'}"><spring:message code="admin.activity.domain.inquiry"/></c:when>
            <c:otherwise><c:out value="${empty item.activityDomain ? '-' : item.activityDomain}"/></c:otherwise>
          </c:choose>
        </td>
        <td>
          <c:choose>
            <c:when test="${item.activityType eq 'PAGE_VIEW'}"><spring:message code="admin.activity.type.pageView"/></c:when>
            <c:when test="${item.activityType eq 'ACTION'}"><spring:message code="admin.activity.type.action"/></c:when>
            <c:when test="${item.activityType eq 'AJAX'}"><spring:message code="admin.activity.type.ajax"/></c:when>
            <c:when test="${item.activityType eq 'API'}"><spring:message code="admin.activity.type.api"/></c:when>
            <c:otherwise><c:out value="${item.activityType}"/></c:otherwise>
          </c:choose>
        </td>
        <td>
          <div><c:out value="${empty item.activityCode ? '-' : item.activityCode}"/></div>
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
              <button type="button"
                      class="adm-inline-chip js-open-member-context"
                      data-user-idx="${item.targetId}">
                <spring:message code="admin.common.viewTarget"/>
              </button>
            </c:if>
            <c:if test="${(item.targetType eq 'REPORT' or item.targetType eq 'report') and not empty item.targetId}">
              <a href="${pageContext.request.contextPath}/admin/reports/${item.targetId}"
                 class="adm-inline-chip">
                <spring:message code="admin.common.viewDetail"/>
              </a>
            </c:if>
            <c:if test="${(item.targetType eq 'INQUIRY' or item.targetType eq 'inquiry') and not empty item.targetId}">
              <a href="${pageContext.request.contextPath}/admin/inquiries/${item.targetId}"
                 class="adm-inline-chip">
                <spring:message code="admin.common.viewDetail"/>
              </a>
            </c:if>
            <c:if test="${not empty item.targetId}">
              <button type="button"
                      class="adm-inline-chip"
                      data-keyword="${item.targetId}"
                      onclick="applyKeywordFilter(this)">
                <spring:message code="admin.common.sameTarget"/>
              </button>
            </c:if>
          </div>
        </td>
        <td style="max-width:300px;word-break:break-all;"><c:out value="${item.requestUri}"/></td>
        <td>
          <c:choose>
            <c:when test="${item.httpMethod eq 'GET'}"><spring:message code="admin.activity.method.get"/></c:when>
            <c:when test="${item.httpMethod eq 'POST'}"><spring:message code="admin.activity.method.post"/></c:when>
            <c:when test="${item.httpMethod eq 'PUT'}"><spring:message code="admin.activity.method.put"/></c:when>
            <c:when test="${item.httpMethod eq 'DELETE'}"><spring:message code="admin.activity.method.delete"/></c:when>
            <c:otherwise><c:out value="${item.httpMethod}"/></c:otherwise>
          </c:choose>
        </td>
        <td><c:out value="${item.responseStatus}"/> / <c:out value="${item.success ? adminActivitySuccessLabel : adminActivityFailLabel}"/></td>
        <td>
          <c:choose>
            <c:when test="${not empty item.ipAddress}">
              <div>
                <button type="button"
                        class="adm-inline-link js-open-ip-context"
                        data-ip-address="${item.ipAddress}"
                        data-default-tab="activity"
                        style="color:#93c5fd;"><c:out value="${item.ipAddress}"/></button>
              </div>
              <div class="adm-inline-actions">
                <button type="button"
                        class="adm-inline-chip"
                        data-keyword="${item.ipAddress}"
                        onclick="applyKeywordFilter(this)">
                  <spring:message code="admin.common.sameIp"/>
                </button>
              </div>
            </c:when>
            <c:otherwise>-</c:otherwise>
          </c:choose>
        </td>
        <td style="font-size:12px;color:#64748b;">
          <div><c:out value="${item.requestId}"/></div>
          <c:if test="${not empty item.flowTraceId}">
            <div style="margin-top:4px;"><c:out value="${item.flowTraceId}"/></div>
          </c:if>
          <div class="adm-inline-actions">
            <c:if test="${not empty item.requestId}">
              <button type="button"
                      class="adm-inline-chip"
                      data-keyword="${item.requestId}"
                      onclick="applyKeywordFilter(this)">
                <spring:message code="admin.common.sameRequest"/>
              </button>
            </c:if>
            <c:if test="${not empty item.flowTraceId}">
              <button type="button"
                      class="adm-inline-chip"
                      data-keyword="${item.flowTraceId}"
                      onclick="applyKeywordFilter(this)">
                <spring:message code="admin.common.sameFlow"/>
              </button>
            </c:if>
          </div>
        </td>
      </tr></c:forEach>
      <c:if test="${empty list}"><tr><td colspan="10" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.common.noResults"/></td></tr></c:if>
    </tbody></table></div>
    <c:if test="${paging.totalPage > 1}"><div class="adm-paging"><c:if test="${paging.prev}"><button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button></c:if><c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"><button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}" onclick="goPage(${p})">${p}</button></c:forEach><c:if test="${paging.next}"><button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button></c:if><span class="adm-page-info"><spring:message code="admin.common.pageStatus" arguments="${paging.currentPage},${paging.totalPage}"/></span></div></c:if>
  </div>
</div>
<%@ include file="../common/context-modal.jspf" %>
<script>
function applyKeywordFilter(button){
  var keyword = button.getAttribute('data-keyword');
  if(!keyword) return;
  const params=new URLSearchParams(window.location.search);
  params.set('keyword',keyword);
  params.set('page','1');
  location.href='${pageContext.request.contextPath}/admin/activity-logs?'+params.toString();
}
function goPage(page){const params=new URLSearchParams(window.location.search);params.set('page',page);location.href='${pageContext.request.contextPath}/admin/activity-logs?'+params.toString();}
</script>
<%@ include file="../layout-close.jsp" %>
