<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="activeMenu" value="security"/>
<c:set var="pageTitle" value="보안 이력"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/security">
                <div class="adm-filter-bar">
                    <div class="adm-search-box" style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">검색</div>
                        <span class="adm-search-ico">🔍</span>
                        <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="아이디, 닉네임, 이메일, 입력값, IP 검색">
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
                        <div class="adm-filter-label">이벤트 유형</div>
                        <select class="adm-select" name="eventType">
                            <option value="ALL" ${search.eventType=='ALL'?'selected':''}>전체</option>
                            <option value="FIND_ID" ${search.eventType=='FIND_ID'?'selected':''}>FIND_ID</option>
                            <option value="FIND_PASSWORD" ${search.eventType=='FIND_PASSWORD'?'selected':''}>FIND_PASSWORD</option>
                            <option value="RESET_PASSWORD" ${search.eventType=='RESET_PASSWORD'?'selected':''}>RESET_PASSWORD</option>
                            <option value="PASSWORD_CHANGE" ${search.eventType=='PASSWORD_CHANGE'?'selected':''}>PASSWORD_CHANGE</option>
                            <option value="EMAIL_VERIFY" ${search.eventType=='EMAIL_VERIFY'?'selected':''}>EMAIL_VERIFY</option>
                            <option value="EMAIL_LOGIN_TOGGLE" ${search.eventType=='EMAIL_LOGIN_TOGGLE'?'selected':''}>EMAIL_LOGIN_TOGGLE</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">단계</div>
                        <select class="adm-select" name="eventStage">
                            <option value="ALL" ${search.eventStage=='ALL'?'selected':''}>전체</option>
                            <option value="REQUEST" ${search.eventStage=='REQUEST'?'selected':''}>REQUEST</option>
                            <option value="ISSUE" ${search.eventStage=='ISSUE'?'selected':''}>ISSUE</option>
                            <option value="VERIFY" ${search.eventStage=='VERIFY'?'selected':''}>VERIFY</option>
                            <option value="COMPLETE" ${search.eventStage=='COMPLETE'?'selected':''}>COMPLETE</option>
                        </select>
                    </div>
                    <button class="adm-btn adm-btn-primary" type="submit">조회</button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">계정 복구 / 인증 / 변경 이력</div>
            <div style="font-size:12px;color:#64748b;">총 ${total}건</div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th>시각</th>
                    <th>대상 회원</th>
                    <th>실행 주체</th>
                    <th>이벤트</th>
                    <th>단계</th>
                    <th>입력값</th>
                    <th>대상 이메일</th>
                    <th>결과</th>
                    <th>사유</th>
                    <th>IP</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr>
                        <td><fmt:formatDate value="${item.occurredAt}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.userIdx}">
                                    <button type="button"
                                            class="adm-inline-link js-open-member-context"
                                            data-user-idx="${item.userIdx}"
                                            data-default-tab="security"
                                            style="font-weight:700;color:#93c5fd;">${item.nickname}</button>
                                    <div class="mem-uid">
                                        <button type="button"
                                                class="adm-inline-link js-open-member-context"
                                                data-user-idx="${item.userIdx}"
                                                data-default-tab="security"
                                                style="color:#94a3b8;">@${item.userId}</button>
                                    </div>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">미식별</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.actorUserIdx}">
                                    <button type="button"
                                            class="adm-inline-link js-open-member-context"
                                            data-user-idx="${item.actorUserIdx}"
                                            data-default-tab="security"
                                            style="font-weight:700;color:#93c5fd;">${item.actorNickname}</button>
                                    <div class="mem-uid">
                                        <button type="button"
                                                class="adm-inline-link js-open-member-context"
                                                data-user-idx="${item.actorUserIdx}"
                                                data-default-tab="security"
                                                style="color:#94a3b8;">@${item.actorUserId}</button>
                                    </div>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">비로그인/시스템</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>${item.eventType}</td>
                        <td>${item.eventStage}</td>
                        <td><c:out value="${empty item.inputIdentifier ? '-' : item.inputIdentifier}"/></td>
                        <td><c:out value="${empty item.targetEmail ? '-' : item.targetEmail}"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${item.success}"><span class="status-badge ACTIVE">SUCCESS</span></c:when>
                                <c:otherwise><span class="status-badge DELETED">FAIL</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td><c:out value="${empty item.failReason ? '-' : item.failReason}"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.ipAddress}">
                                    <button type="button"
                                            class="adm-inline-link js-open-ip-context"
                                            data-ip-address="${item.ipAddress}"
                                            data-default-tab="security"
                                            style="color:#93c5fd;">${item.ipAddress}</button>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="10" style="text-align:center;padding:40px;color:#475569;">조회 결과가 없습니다.</td></tr>
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

<%@ include file="../common/context-modal.jspf" %>

<script>
function goPage(page) {
    const params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = '${pageContext.request.contextPath}/admin/security?' + params.toString();
}
</script>

<%@ include file="../layout-close.jsp" %>
