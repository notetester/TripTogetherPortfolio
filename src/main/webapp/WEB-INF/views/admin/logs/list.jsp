<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="logins"/>
<c:set var="pageTitle" value="로그인 감사"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/logins">
                <div class="adm-filter-bar">
                    <div class="adm-search-box" style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">검색</div>
                        <span class="adm-search-ico">🔍</span>
                        <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="아이디, 닉네임, 입력값, IP 검색">
                    </div>
                    <div>
                        <div class="adm-filter-label">성공 여부</div>
                        <select class="adm-select" name="success">
                            <option value="ALL" ${search.success=='ALL'?'selected':''}>전체</option>
                            <option value="SUCCESS" ${search.success=='SUCCESS'?'selected':''}>성공</option>
                            <option value="FAIL" ${search.success=='FAIL'?'selected':''}>실패</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">인증 방식</div>
                        <select class="adm-select" name="authType">
                            <option value="ALL" ${search.authType=='ALL'?'selected':''}>전체</option>
                            <option value="PASSWORD" ${search.authType=='PASSWORD'?'selected':''}>PASSWORD</option>
                            <option value="SOCIAL" ${search.authType=='SOCIAL'?'selected':''}>SOCIAL</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">로그인 경로</div>
                        <select class="adm-select" name="loginMethod">
                            <option value="ALL" ${search.loginMethod=='ALL'?'selected':''}>전체</option>
                            <option value="ID" ${search.loginMethod=='ID'?'selected':''}>ID</option>
                            <option value="EMAIL" ${search.loginMethod=='EMAIL'?'selected':''}>EMAIL</option>
                            <option value="KAKAO" ${search.loginMethod=='KAKAO'?'selected':''}>KAKAO</option>
                            <option value="NAVER" ${search.loginMethod=='NAVER'?'selected':''}>NAVER</option>
                            <option value="GOOGLE" ${search.loginMethod=='GOOGLE'?'selected':''}>GOOGLE</option>
                        </select>
                    </div>
                    <button class="adm-btn adm-btn-primary" type="submit">조회</button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">로그인 시도 이력</div>
            <div style="font-size:12px;color:#64748b;">총 ${total}건</div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th>시각</th>
                    <th>회원</th>
                    <th>인증</th>
                    <th>경로</th>
                    <th>입력값</th>
                    <th>결과</th>
                    <th>사유</th>
                    <th>IP</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr>
                        <td><fmt:formatDate value="${item.loginAt}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.userIdx}">
                                    <div class="mem-name">${item.nickname}</div>
                                    <div class="mem-uid">@${item.userId}</div>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">미식별</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>${item.authType}</td>
                        <td>${item.loginMethod}</td>
                        <td>${item.loginIdentifier}</td>
                        <td>
                            <c:choose>
                                <c:when test="${item.success}"><span class="status-badge ACTIVE">SUCCESS</span></c:when>
                                <c:otherwise><span class="status-badge DELETED">FAIL</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td><c:out value="${empty item.failReason ? '-' : item.failReason}"/></td>
                        <td>${item.ipAddress}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="8" style="text-align:center;padding:40px;color:#475569;">조회 결과가 없습니다.</td></tr>
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
                <span class="adm-page-info">${paging.currentPage} / ${paging.totalPage} 페이지</span>
            </div>
        </c:if>
    </div>
</div>

<script>
function goPage(page) {
    const params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = '${pageContext.request.contextPath}/admin/logins?' + params.toString();
}
</script>

<%@ include file="../layout-close.jsp" %>
