<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  =============================================
  문의 게시판 목록 페이지
  URL: GET /inquiry/list
  =============================================
  [model 필요]
  - inquiryList   : List<InquiryPostDto> - 문의 목록
  - totalCount    : int                  - 전체 문의 수
  - totalPage     : int                  - 전체 페이지 수
  - search        : InquirySearchDto     - 검색 조건 (category, status, keyword, page)
  - isAdmin       : boolean              - 운영진 여부
  - loginUserIdx  : Long                 - 로그인 유저 idx

  [페이지 구성]
  1. 페이지 헤더 + 카테고리 탭
  2. 검색창
  3. 툴바 (총 건수 + 어드민 상태 필터 + 문의하기 버튼)
  4. 문의 목록 테이블
  5. 페이지네이션
  6. 스크립트 (행 클릭 이동 + 키워드 하이라이트)
  =============================================
--%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="inquiry/inquiry.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<%-- =============================================
     1. 페이지 헤더 + 카테고리 탭
     ============================================= --%>
<div class="inq-ph">
    <div class="si">
        <h1>고객지원</h1>
        <p class="inq-ph-sub">문의사항을 남겨주시면 빠르게 답변 드리겠습니다</p>

        <%-- 카테고리 탭 - 현재 선택된 탭에 active 클래스 --%>
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

<%-- =============================================
     본문 영역
     ============================================= --%>
<div class="inq-body-wrap">
    <div class="si">

        <%-- =============================================
             2. 검색창
             - 현재 category, status 는 hidden으로 유지
             - keyword 로 제목/내용/답변 내용까지 검색
             ============================================= --%>
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

        <%-- =============================================
             3. 툴바
             - 총 건수 표시
             - 어드민 전용: 상태 필터 (전체/대기중/처리중/완료)
             - 문의하기 버튼
             ============================================= --%>
        <div class="inq-toolbar">
            <span class="inq-total">총 <strong>${totalCount}</strong>건</span>

            <%-- 어드민만 상태 필터 표시 --%>
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

        <%-- =============================================
             4. 문의 목록 테이블
             ============================================= --%>
        <div class="inq-table-wrap">
            <table class="inq-table">
                <colgroup>
                    <col style="width:70px">  <%-- No --%>
                    <col>                     <%-- 제목 --%>
                    <col style="width:100px"> <%-- 카테고리 --%>
                    <col style="width:110px"> <%-- 작성자 --%>
                    <col style="width:100px"> <%-- 작성일 --%>
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
                    <%-- 문의 없을 때 빈 상태 표시 --%>
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
                            <%-- 비밀글 접근 제한 여부 판단
                                 - 비밀글이고 본인 글이 아니고 어드민이 아니면 isBlocked = true --%>
                            <c:set var="isMyPost"  value="${inq.userIdx == loginUserIdx}"/>
                            <c:set var="isBlocked" value="${inq.isPrivate == 1 and !isMyPost and !isAdmin}"/>

                            <%-- isBlocked면 클릭 불가 행, 아니면 클릭 가능 행 --%>
                            <c:choose>
                                <c:when test="${isBlocked}">
                                    <tr class="inq-row-blocked">
                                </c:when>
                                <c:otherwise>
                                    <tr class="inq-row" data-id="${inq.inquiryId}">
                                </c:otherwise>
                            </c:choose>

                                <%-- No: 최신글이 1번이 되도록 역순 계산 --%>
                                <td class="inq-no">
                                    ${totalCount - ((search.page - 1) * search.pageSize) - vs.index}
                                </td>

                                <%-- 제목: 비밀글이면 잠금 표시, 아니면 제목 + 상태 뱃지 --%>
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
                                            <%-- 상태 뱃지 --%>
                                            <span class="inq-status-badge ${inq.status}">
                                                <c:choose>
                                                    <c:when test="${inq.status eq 'PENDING'}">대기중</c:when>
                                                    <c:when test="${inq.status eq 'IN_PROGRESS'}">처리중</c:when>
                                                    <c:when test="${inq.status eq 'COMPLETED'}">✓ 답변완료</c:when>
                                                    <c:when test="${inq.status eq 'USER_COMPLETED'}">✓ 해결됨</c:when>
                                                    <c:when test="${inq.status eq 'CANCELLED'}">취소됨</c:when>
                                                    <c:when test="${inq.status eq 'DELETE_REQUESTED'}">삭제요청</c:when>
                                                    <c:when test="${inq.status eq 'PRIVATE_REQUESTED'}">비공개요청</c:when>
                                                    <c:when test="${inq.status eq 'PUBLIC_REQUESTED'}">공개요청</c:when>
                                                </c:choose>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <%-- 카테고리 --%>
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

                                <%-- 작성자: 비밀글이면 익명 표시 --%>
                                <td class="inq-nick">
                                    <c:choose>
                                        <c:when test="${inq.isPrivate == 1 and !isMyPost and !isAdmin}">익명</c:when>
                                        <c:otherwise>${inq.nickname}</c:otherwise>
                                    </c:choose>
                                </td>

                                <%-- 작성일 --%>
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

        <%-- =============================================
             5. 페이지네이션
             - 총 페이지가 1개면 표시 안 함
             - 현재 페이지에 active 클래스
             ============================================= --%>
        <c:if test="${totalPage > 1}">
            <div class="inq-pagination">
                <%-- 이전 페이지 버튼 --%>
                <c:if test="${search.page > 1}">
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&status=${search.status}&keyword=${search.keyword}&page=${search.page - 1}"
                       class="inq-page-btn">&#8249;</a>
                </c:if>

                <%-- 페이지 번호 버튼 --%>
                <c:forEach begin="1" end="${totalPage}" var="p">
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&status=${search.status}&keyword=${search.keyword}&page=${p}"
                       class="inq-page-btn ${p == search.page ? 'active' : ''}">${p}</a>
                </c:forEach>

                <%-- 다음 페이지 버튼 --%>
                <c:if test="${search.page < totalPage}">
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&status=${search.status}&keyword=${search.keyword}&page=${search.page + 1}"
                       class="inq-page-btn">&#8250;</a>
                </c:if>
            </div>
        </c:if>

    </div>
</div>

<%@ include file="../common/footer.jsp" %>

<%-- =============================================
     6. 스크립트
     ============================================= --%>
<script>
(function () {
    var ctx = '${pageContext.request.contextPath}';

    // 행 클릭 시 상세 페이지 이동
    // - onclick 속성 대신 JS로 처리 (EL 충돌 방지)
    // - data-id 속성에서 inquiryId 읽어서 이동
    var listParams = 'page=${search.page}&category=${search.category}&status=${search.status}&keyword=' + encodeURIComponent('${search.keyword}');
    document.querySelectorAll('.inq-row[data-id]').forEach(function (tr) {
        tr.style.cursor = 'pointer';
        tr.addEventListener('click', function () {
            location.href = ctx + '/inquiry/' + this.getAttribute('data-id') + '?' + listParams;
        });
    });

    // 검색 키워드 하이라이트
    // - 검색어가 있을 때만 실행
    // - 제목에서 검색어를 찾아 <mark> 태그로 감쌈
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
