<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="inquiry/inquiry.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<div class="inq-ph">
    <div class="si">
        <h1>고객지원</h1>
        <p class="inq-ph-sub">문의사항을 남겨주시면 빠르게 답변 드리겠습니다</p>
        <div class="inq-tabs">
            <a href="${pageContext.request.contextPath}/inquiry/list"
               class="inq-tab ${empty search.category ? 'active' : ''}">전체</a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=service"
               class="inq-tab ${search.category eq 'service' ? 'active' : ''}">서비스</a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=payment"
               class="inq-tab ${search.category eq 'payment' ? 'active' : ''}">결제</a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=account"
               class="inq-tab ${search.category eq 'account' ? 'active' : ''}">계정</a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=bug"
               class="inq-tab ${search.category eq 'bug' ? 'active' : ''}">오류신고</a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=etc"
               class="inq-tab ${search.category eq 'etc' ? 'active' : ''}">기타</a>
        </div>
    </div>
</div>

<div class="inq-body-wrap">
    <div class="si">

        <form class="inq-search-form"
              action="${pageContext.request.contextPath}/inquiry/list" method="get">
            <input type="hidden" name="category" value="${search.category}">
            <input type="hidden" name="status"   value="${search.status}">
            <div class="inq-search-wrap">
                <span class="inq-search-icon">🔍</span>
                <input class="inq-search-input" type="text" name="keyword"
                       value="${search.keyword}" placeholder="제목 / 내용 검색">
                <button class="inq-search-btn" type="submit">검색</button>
            </div>
        </form>

        <div class="inq-toolbar">
            <span class="inq-total">총 <strong>${totalCount}</strong>건</span>
            <c:if test="${isAdmin}">
                <div class="inq-status-filter">
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&keyword=${search.keyword}"
                       class="inq-sf ${empty search.status ? 'active' : ''}">전체</a>
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&keyword=${search.keyword}&status=PENDING"
                       class="inq-sf ${search.status eq 'PENDING' ? 'active' : ''}">대기중</a>
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&keyword=${search.keyword}&status=IN_PROGRESS"
                       class="inq-sf ${search.status eq 'IN_PROGRESS' ? 'active' : ''}">처리중</a>
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&keyword=${search.keyword}&status=COMPLETED"
                       class="inq-sf ${search.status eq 'COMPLETED' ? 'active' : ''}">완료</a>
                </div>
            </c:if>
            <button class="inq-btn-write"
                    onclick="location.href='${pageContext.request.contextPath}/inquiry/write'">
                &#43;&nbsp;문의하기
            </button>
        </div>

        <div class="inq-table-wrap">
            <table class="inq-table">
                <colgroup>
                    <col style="width:70px">
                    <col>
                    <col style="width:100px">
                    <col style="width:110px">
                    <col style="width:100px">
                </colgroup>
                <thead>
                <tr>
                    <th>No</th>
                    <th>제목</th>
                    <th>카테고리</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty inquiryList}">
                        <tr>
                            <td colspan="5" class="inq-empty">
                                <div class="inq-empty-inner">
                                    <div class="inq-empty-icon">📭</div>
                                    <div class="inq-empty-msg">문의 내역이 없습니다</div>
                                    <div class="inq-empty-sub">궁금한 점이 있으시면 문의하기를 눌러주세요</div>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="inq" items="${inquiryList}" varStatus="vs">
                            <c:set var="isMyPost"  value="${inq.userIdx == loginUserIdx}"/>
                            <c:set var="isBlocked" value="${inq.isPrivate == 1 and !isMyPost and !isAdmin}"/>
                            <c:choose>
                                <c:when test="${isBlocked}">
                                    <tr class="inq-row-blocked">
                                </c:when>
                                <c:otherwise>
                                    <tr class="inq-row" data-id="${inq.inquiryId}">
                                </c:otherwise>
                            </c:choose>
                                <td class="inq-no">
                                    ${totalCount - ((search.page - 1) * search.pageSize) - vs.index}
                                </td>
                                <td class="inq-title-cell">
                                    <c:choose>
                                        <c:when test="${isBlocked}">
                                            <span class="inq-title inq-title-blocked">🔒 비밀글입니다.</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inq-title">
                                                <c:if test="${inq.isPrivate == 1}">
                                                    <span class="inq-private-tag">🔒 비밀글</span>
                                                </c:if>
                                                ${inq.title}
                                            </span>
                                            <span class="inq-status-badge ${inq.status}">
                                                <c:choose>
                                                    <c:when test="${inq.status eq 'PENDING'}">대기중</c:when>
                                                    <c:when test="${inq.status eq 'IN_PROGRESS'}">처리중</c:when>
                                                    <c:when test="${inq.status eq 'COMPLETED'}">✓ 답변완료</c:when>
                                                </c:choose>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="inq-category-tag">
                                        <c:choose>
                                            <c:when test="${inq.category eq 'service'}">서비스</c:when>
                                            <c:when test="${inq.category eq 'payment'}">결제</c:when>
                                            <c:when test="${inq.category eq 'account'}">계정</c:when>
                                            <c:when test="${inq.category eq 'bug'}">오류신고</c:when>
                                            <c:otherwise>기타</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td class="inq-nick">
                                    <c:choose>
                                        <c:when test="${inq.isPrivate == 1 and !isMyPost and !isAdmin}">익명</c:when>
                                        <c:otherwise>${inq.nickname}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="inq-date">
                                    <fmt:formatDate value="${inq.createdAt}" pattern="yyyy-MM-dd"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>

        <c:if test="${totalPage > 1}">
            <div class="inq-pagination">
                <c:if test="${search.page > 1}">
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&status=${search.status}&keyword=${search.keyword}&page=${search.page - 1}"
                       class="inq-page-btn">&#8249;</a>
                </c:if>
                <c:forEach begin="1" end="${totalPage}" var="p">
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&status=${search.status}&keyword=${search.keyword}&page=${p}"
                       class="inq-page-btn ${p == search.page ? 'active' : ''}">${p}</a>
                </c:forEach>
                <c:if test="${search.page < totalPage}">
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&status=${search.status}&keyword=${search.keyword}&page=${search.page + 1}"
                       class="inq-page-btn">&#8250;</a>
                </c:if>
            </div>
        </c:if>

    </div>
</div>

<%@ include file="../common/footer.jsp" %>

<script>
(function () {
    var ctx = '${pageContext.request.contextPath}';

    // 행 클릭 이동 - onclick 속성 완전 제거, data-id 로 JS 처리
    document.querySelectorAll('.inq-row[data-id]').forEach(function (tr) {
        tr.style.cursor = 'pointer';
        tr.addEventListener('click', function () {
            location.href = ctx + '/inquiry/' + this.getAttribute('data-id');
        });
    });

    // 키워드 하이라이트
    var keyword = '${search.keyword}';
    if (keyword) {
 var escaped = keyword.replace(/[.*+?^$\u007B\u007D()|[\]\\]/g, '\\$&');
        var regex = new RegExp(escaped, 'gi');
        document.querySelectorAll('.inq-title').forEach(function (el) {
            el.innerHTML = el.innerHTML.replace(regex, function (m) {
                return '<mark class="inq-highlight">' + m + '</mark>';
            });
        });
    }
})();
</script>

</body>
</html>
