<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="emailTokens"/>
<c:set var="pageTitle" value="이메일 액션 토큰"/>
<%@ include file="../layout.jsp" %>
<div class="adm-content">
  <div class="adm-card" style="margin-bottom:20px;">
    <div class="adm-card-body">
      <form method="get" action="${pageContext.request.contextPath}/admin/email-tokens">
        <div class="adm-filter-bar">
          <div class="adm-search-box" style="flex:1;min-width:220px;">
            <div class="adm-filter-label">검색</div>
            <span class="adm-search-ico">🔍</span>
            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="아이디, 닉네임, 이메일, 요청ID, IP 검색">
          </div>
          <div>
            <div class="adm-filter-label">목적</div>
            <select class="adm-select" name="purpose">
              <option value="ALL" ${search.purpose=='ALL'?'selected':''}>전체</option>
              <option value="PROFILE_EMAIL" ${search.purpose=='PROFILE_EMAIL'?'selected':''}>PROFILE_EMAIL</option>
              <option value="FIND_ID" ${search.purpose=='FIND_ID'?'selected':''}>FIND_ID</option>
              <option value="RESET_PW" ${search.purpose=='RESET_PW'?'selected':''}>RESET_PW</option>
              <option value="VERIFY" ${search.purpose=='VERIFY'?'selected':''}>VERIFY</option>
            </select>
          </div>
          <div>
            <div class="adm-filter-label">사용여부</div>
            <select class="adm-select" name="used">
              <option value="ALL" ${search.used=='ALL'?'selected':''}>전체</option>
              <option value="USED" ${search.used=='USED'?'selected':''}>USED</option>
              <option value="UNUSED" ${search.used=='UNUSED'?'selected':''}>UNUSED</option>
            </select>
          </div>
          <button class="adm-btn adm-btn-primary" type="submit">조회</button>
        </div>
      </form>
    </div>
  </div>
  <div class="adm-card">
    <div class="adm-card-head"><div class="adm-card-title">이메일 액션 토큰 이력</div><div style="font-size:12px;color:#64748b;">총 ${total}건</div></div>
    <div class="adm-table-wrap"><table class="adm-table"><thead><tr><th>발급시각</th><th>회원</th><th>목적</th><th>대상 이메일</th><th>사용</th><th>사용시각</th><th>만료시각</th><th>요청ID</th></tr></thead><tbody>
      <c:forEach items="${list}" var="item"><tr>
        <td><fmt:formatDate value="${item.createdAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
        <td><div class="mem-name"><c:out value="${empty item.nickname ? '미식별 요청' : item.nickname}"/></div><div class="mem-uid"><c:out value="${empty item.userId ? '-' : '@'.concat(item.userId)}"/></div></td>
        <td>${item.purpose}</td><td><c:out value="${item.email}"/></td><td>${item.used ? 'USED' : 'UNUSED'}</td>
        <td><c:choose><c:when test="${not empty item.usedAtDate}"><fmt:formatDate value="${item.usedAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/></c:when><c:otherwise>-</c:otherwise></c:choose></td>
        <td><c:choose><c:when test="${not empty item.expiredAtDate}"><fmt:formatDate value="${item.expiredAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/></c:when><c:otherwise>-</c:otherwise></c:choose></td>
        <td style="font-size:12px;color:#64748b;"><c:out value="${item.requestId}"/></td>
      </tr></c:forEach>
      <c:if test="${empty list}"><tr><td colspan="8" style="text-align:center;padding:40px;color:#475569;">조회 결과가 없습니다.</td></tr></c:if>
    </tbody></table></div>
    <c:if test="${paging.totalPage > 1}"><div class="adm-paging"><c:if test="${paging.prev}"><button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button></c:if><c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p"><button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}" onclick="goPage(${p})">${p}</button></c:forEach><c:if test="${paging.next}"><button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button></c:if><span class="adm-page-info">${paging.currentPage} / ${paging.totalPage} 페이지</span></div></c:if>
  </div>
</div>
<script>function goPage(page){const params=new URLSearchParams(window.location.search);params.set('page',page);location.href='${pageContext.request.contextPath}/admin/email-tokens?'+params.toString();}</script>
<%@ include file="../layout-close.jsp" %>
