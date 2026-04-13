<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="activityLogs"/>
<c:set var="pageTitle" value="일반 활동 로그"/>
<%@ include file="../layout.jsp" %>
<div class="adm-content">
  <div class="adm-card" style="margin-bottom:20px;">
    <div class="adm-card-body">
      <form method="get" action="${pageContext.request.contextPath}/admin/activity-logs">
        <div class="adm-filter-bar">
          <div class="adm-search-box" style="flex:1;min-width:220px;"><div class="adm-filter-label">검색</div><span class="adm-search-ico">🔍</span><input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="아이디, 닉네임, URI, 활동코드, 대상, IP 검색"></div>
          <div><div class="adm-filter-label">분류</div><select class="adm-select" name="activityType"><option value="ALL" ${search.activityType=='ALL'?'selected':''}>전체</option><option value="PAGE_VIEW" ${search.activityType=='PAGE_VIEW'?'selected':''}>PAGE_VIEW</option><option value="ACTION" ${search.activityType=='ACTION'?'selected':''}>ACTION</option><option value="AJAX" ${search.activityType=='AJAX'?'selected':''}>AJAX</option><option value="API" ${search.activityType=='API'?'selected':''}>API</option></select></div>
          <div><div class="adm-filter-label">메서드</div><select class="adm-select" name="httpMethod"><option value="ALL" ${search.httpMethod=='ALL'?'selected':''}>전체</option><option value="GET" ${search.httpMethod=='GET'?'selected':''}>GET</option><option value="POST" ${search.httpMethod=='POST'?'selected':''}>POST</option><option value="PUT" ${search.httpMethod=='PUT'?'selected':''}>PUT</option><option value="DELETE" ${search.httpMethod=='DELETE'?'selected':''}>DELETE</option></select></div>
          <div><div class="adm-filter-label">성공여부</div><select class="adm-select" name="success"><option value="ALL" ${search.success=='ALL'?'selected':''}>전체</option><option value="SUCCESS" ${search.success=='SUCCESS'?'selected':''}>SUCCESS</option><option value="FAIL" ${search.success=='FAIL'?'selected':''}>FAIL</option></select></div>
          <button class="adm-btn adm-btn-primary" type="submit">조회</button>
        </div>
      </form>
    </div>
  </div>
  <div class="adm-card"><div class="adm-card-head"><div class="adm-card-title">일반 활동 로그</div><div style="font-size:12px;color:#64748b;">총 ${total}건</div></div>
    <div class="adm-table-wrap"><table class="adm-table"><thead><tr><th>시각</th><th>회원</th><th>분류</th><th>활동코드</th><th>URI</th><th>메서드</th><th>상태</th><th>IP</th><th>요청ID</th></tr></thead><tbody>
      <c:forEach items="${list}" var="item"><tr>
        <td><fmt:formatDate value="${item.createdAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
        <td><div class="mem-name"><c:out value="${empty item.nickname ? '비회원' : item.nickname}"/></div><div class="mem-uid"><c:out value="${empty item.userId ? '-' : '@'.concat(item.userId)}"/></div></td>
        <td>${item.activityType}</td><td><c:out value="${empty item.activityCode ? '-' : item.activityCode}"/></td><td style="max-width:300px;word-break:break-all;"><c:out value="${item.requestUri}"/></td><td>${item.httpMethod}</td><td><c:out value="${item.responseStatus}"/> / <c:out value="${item.success ? 'SUCCESS' : 'FAIL'}"/></td><td><c:out value="${empty item.ipAddress ? '-' : item.ipAddress}"/></td><td style="font-size:12px;color:#64748b;"><c:out value="${item.requestId}"/></td>
      </tr></c:forEach>
      <c:if test="${empty list}"><tr><td colspan="9" style="text-align:center;padding:40px;color:#475569;">조회 결과가 없습니다.</td></tr></c:if>
    </tbody></table></div>
    <c:if test="${paging.totalPage > 1}"><div class="adm-paging"><c:if test="${paging.prev}"><button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button></c:if><c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"><button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}" onclick="goPage(${p})">${p}</button></c:forEach><c:if test="${paging.next}"><button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button></c:if><span class="adm-page-info">${paging.currentPage} / ${paging.totalPage} 페이지</span></div></c:if>
  </div>
</div>
<script>function goPage(page){const params=new URLSearchParams(window.location.search);params.set('page',page);location.href='${pageContext.request.contextPath}/admin/activity-logs?'+params.toString();}</script>
<%@ include file="../layout-close.jsp" %>
