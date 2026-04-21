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
          <div><div class="adm-filter-label"><spring:message code="admin.activity.domain"/></div><select class="adm-select" name="activityDomain"><option value="ALL" ${search.activityDomain=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option><option value="GENERAL" ${search.activityDomain=='GENERAL'?'selected':''}>GENERAL</option><option value="AUTH" ${search.activityDomain=='AUTH'?'selected':''}>AUTH</option><option value="ADMIN" ${search.activityDomain=='ADMIN'?'selected':''}>ADMIN</option><option value="COMMUNITY" ${search.activityDomain=='COMMUNITY'?'selected':''}>COMMUNITY</option><option value="MYPAGE" ${search.activityDomain=='MYPAGE'?'selected':''}>MYPAGE</option><option value="INQUIRY" ${search.activityDomain=='INQUIRY'?'selected':''}>INQUIRY</option></select></div>
          <div><div class="adm-filter-label"><spring:message code="admin.activity.type"/></div><select class="adm-select" name="activityType"><option value="ALL" ${search.activityType=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option><option value="PAGE_VIEW" ${search.activityType=='PAGE_VIEW'?'selected':''}>PAGE_VIEW</option><option value="ACTION" ${search.activityType=='ACTION'?'selected':''}>ACTION</option><option value="AJAX" ${search.activityType=='AJAX'?'selected':''}>AJAX</option><option value="API" ${search.activityType=='API'?'selected':''}>API</option></select></div>
          <div><div class="adm-filter-label"><spring:message code="admin.logs.provider"/></div><select class="adm-select" name="activityProvider"><option value="ALL" ${search.activityProvider=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option><option value="LOCAL" ${search.activityProvider=='LOCAL'?'selected':''}>LOCAL</option><option value="KAKAO" ${search.activityProvider=='KAKAO'?'selected':''}>KAKAO</option><option value="NAVER" ${search.activityProvider=='NAVER'?'selected':''}>NAVER</option><option value="GOOGLE" ${search.activityProvider=='GOOGLE'?'selected':''}>GOOGLE</option></select></div>
          <div><div class="adm-filter-label"><spring:message code="admin.activity.authEvent"/></div><select class="adm-select" name="authEventType"><option value="ALL" ${search.authEventType=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option><option value="LOGIN" ${search.authEventType=='LOGIN'?'selected':''}>LOGIN</option><option value="LOGOUT" ${search.authEventType=='LOGOUT'?'selected':''}>LOGOUT</option><option value="LINK" ${search.authEventType=='LINK'?'selected':''}>LINK</option><option value="UNLINK" ${search.authEventType=='UNLINK'?'selected':''}>UNLINK</option></select></div>
          <div><div class="adm-filter-label"><spring:message code="admin.activity.method"/></div><select class="adm-select" name="httpMethod"><option value="ALL" ${search.httpMethod=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option><option value="GET" ${search.httpMethod=='GET'?'selected':''}>GET</option><option value="POST" ${search.httpMethod=='POST'?'selected':''}>POST</option><option value="PUT" ${search.httpMethod=='PUT'?'selected':''}>PUT</option><option value="DELETE" ${search.httpMethod=='DELETE'?'selected':''}>DELETE</option></select></div>
          <div><div class="adm-filter-label"><spring:message code="admin.logs.success"/></div><select class="adm-select" name="success"><option value="ALL" ${search.success=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option><option value="SUCCESS" ${search.success=='SUCCESS'?'selected':''}><spring:message code="admin.common.success"/></option><option value="FAIL" ${search.success=='FAIL'?'selected':''}><spring:message code="admin.common.fail"/></option></select></div>
          <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
        </div>
      </form>
    </div>
  </div>
  <div class="adm-card"><div class="adm-card-head"><div class="adm-card-title"><spring:message code="admin.activity.historyTitle"/></div><div style="font-size:12px;color:#64748b;"><spring:message code="admin.common.totalCount" arguments="${total}"/></div></div>
    <div class="adm-table-wrap"><table class="adm-table"><thead><tr><th><spring:message code="admin.common.time"/></th><th><spring:message code="admin.common.member"/></th><th><spring:message code="admin.activity.domain"/></th><th><spring:message code="admin.activity.type"/></th><th><spring:message code="admin.activity.code"/></th><th>URI</th><th><spring:message code="admin.activity.method"/></th><th><spring:message code="admin.common.status"/></th><th>IP</th><th><spring:message code="admin.activity.flow"/></th></tr></thead><tbody>
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
        <td><c:out value="${empty item.activityDomain ? '-' : item.activityDomain}"/></td>
        <td>${item.activityType}</td>
        <td>
          <div><c:out value="${empty item.activityCode ? '-' : item.activityCode}"/></div>
          <c:if test="${not empty item.activityProvider or not empty item.authEventType}">
            <div style="margin-top:4px;font-size:11px;color:#64748b;">
              <c:out value="${empty item.activityProvider ? '-' : item.activityProvider}"/>
              <c:if test="${not empty item.authEventType}">
                / <c:out value="${item.authEventType}"/>
              </c:if>
            </div>
          </c:if>
        </td>
        <td style="max-width:300px;word-break:break-all;"><c:out value="${item.requestUri}"/></td>
        <td>${item.httpMethod}</td>
        <td><c:out value="${item.responseStatus}"/> / <c:out value="${item.success ? adminActivitySuccessLabel : adminActivityFailLabel}"/></td>
        <td>
          <c:choose>
            <c:when test="${not empty item.ipAddress}">
              <button type="button"
                      class="adm-inline-link js-open-ip-context"
                      data-ip-address="${item.ipAddress}"
                      data-default-tab="activity"
                      style="color:#93c5fd;"><c:out value="${item.ipAddress}"/></button>
            </c:when>
            <c:otherwise>-</c:otherwise>
          </c:choose>
        </td>
        <td style="font-size:12px;color:#64748b;">
          <div><c:out value="${item.requestId}"/></div>
          <c:if test="${not empty item.flowTraceId}">
            <div style="margin-top:4px;"><c:out value="${item.flowTraceId}"/></div>
          </c:if>
        </td>
      </tr></c:forEach>
      <c:if test="${empty list}"><tr><td colspan="10" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.common.noResults"/></td></tr></c:if>
    </tbody></table></div>
    <c:if test="${paging.totalPage > 1}"><div class="adm-paging"><c:if test="${paging.prev}"><button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button></c:if><c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"><button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}" onclick="goPage(${p})">${p}</button></c:forEach><c:if test="${paging.next}"><button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button></c:if><span class="adm-page-info"><spring:message code="admin.common.pageStatus" arguments="${paging.currentPage},${paging.totalPage}"/></span></div></c:if>
  </div>
</div>
<%@ include file="../common/context-modal.jspf" %>
<script>function goPage(page){const params=new URLSearchParams(window.location.search);params.set('page',page);location.href='${pageContext.request.contextPath}/admin/activity-logs?'+params.toString();}</script>
<%@ include file="../layout-close.jsp" %>
