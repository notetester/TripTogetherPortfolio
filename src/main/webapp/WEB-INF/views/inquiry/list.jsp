<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
        <h1><spring:message code="inquiry.list.title"/></h1>
        <p class="inq-ph-sub"><spring:message code="inquiry.list.subtitle"/></p>

        <%-- 카테고리 탭 - 현재 선택된 탭에 active 클래스 --%>
        <div class="inq-tabs">
            <a href="${pageContext.request.contextPath}/inquiry/list"
               class="inq-tab ${empty search.category ? 'active' : ''}"><spring:message code="inquiry.all"/></a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=service"
               class="inq-tab ${search.category eq 'service' ? 'active' : ''}"><spring:message code="inquiry.category.service"/></a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=payment"
               class="inq-tab ${search.category eq 'payment' ? 'active' : ''}"><spring:message code="inquiry.category.payment"/></a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=account"
               class="inq-tab ${search.category eq 'account' ? 'active' : ''}"><spring:message code="inquiry.category.account"/></a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=bug"
               class="inq-tab ${search.category eq 'bug' ? 'active' : ''}"><spring:message code="inquiry.category.bug"/></a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=etc"
               class="inq-tab ${search.category eq 'etc' ? 'active' : ''}"><spring:message code="inquiry.category.etc"/></a>
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
                       value="${search.keyword}" placeholder="<spring:message code="inquiry.search.placeholder"/>">
                <button class="inq-search-btn" type="submit"><spring:message code="inquiry.search.button"/></button>
            </div>
        </form>

        <%-- =============================================
             3. 툴바
             - 총 건수 표시
             - 어드민 전용: 상태 필터 (전체/대기중/처리중/완료)
             - 문의하기 버튼
             ============================================= --%>
        <div class="inq-toolbar">
            <span class="inq-total"><spring:message code="inquiry.total"/> <strong>${totalCount}</strong><spring:message code="inquiry.total.suffix"/></span>

            <%-- 어드민만 상태 필터 표시 --%>
            <c:if test="${isAdmin}">
                <div class="inq-status-filter">
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&keyword=${search.keyword}"
                       class="inq-sf ${empty search.status ? 'active' : ''}"><spring:message code="inquiry.all"/></a>
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&keyword=${search.keyword}&status=PENDING"
                       class="inq-sf ${search.status eq 'PENDING' ? 'active' : ''}"><spring:message code="inquiry.status.pending"/></a>
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&keyword=${search.keyword}&status=IN_PROGRESS"
                       class="inq-sf ${search.status eq 'IN_PROGRESS' ? 'active' : ''}"><spring:message code="inquiry.status.inProgress"/></a>
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&keyword=${search.keyword}&status=COMPLETED"
                       class="inq-sf ${search.status eq 'COMPLETED' ? 'active' : ''}"><spring:message code="inquiry.status.completed"/></a>
                </div>
            </c:if>

            <button class="inq-btn-write"
                    onclick="location.href='${pageContext.request.contextPath}/inquiry/write'">
                &#43;&nbsp;<spring:message code="inquiry.write.button"/>
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
                        <th><spring:message code="inquiry.table.title"/></th>
                        <th><spring:message code="inquiry.table.category"/></th>
                        <th><spring:message code="inquiry.table.author"/></th>
                        <th><spring:message code="inquiry.table.date"/></th>
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
                                    <div class="inq-empty-msg"><spring:message code="inquiry.empty"/></div>
                                    <div class="inq-empty-sub"><spring:message code="inquiry.empty.subtitle"/></div>
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
                            <%-- AI 독성 감지 BLUR 여부: ai_flagged=1 이고 관리자 아니면 제목 BLUR --%>
                            <c:set var="isBlurred" value="${inq.aiFlagged and !isAdmin}"/>

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
                                            <span class="inq-title inq-title-blocked"><spring:message code="inquiry.private.post"/></span>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="${isBlurred ? 'inq-title-blur-wrap' : ''}">
                                                <span class="inq-title ${isBlurred ? 'inq-title-blurred' : ''}">
                                                    <c:if test="${inq.isPrivate == 1}">
                                                        <span class="inq-private-tag"><spring:message code="inquiry.private.tag"/></span>
                                                    </c:if>
                                                    <c:out value="${inq.title}"/>
                                                </span>
                                                <%-- 상태 뱃지 --%>
                                                <span class="inq-status-badge ${inq.status}">
                                                    <c:choose>
                                                        <c:when test="${inq.status eq 'PENDING'}"><spring:message code="inquiry.status.pending"/></c:when>
                                                        <c:when test="${inq.status eq 'IN_PROGRESS'}"><spring:message code="inquiry.status.inProgress"/></c:when>
                                                        <c:when test="${inq.status eq 'COMPLETED'}"><spring:message code="inquiry.status.answerDone"/></c:when>
                                                        <c:when test="${inq.status eq 'USER_COMPLETED'}"><spring:message code="inquiry.status.userCompleted"/></c:when>
                                                        <c:when test="${inq.status eq 'CANCELLED'}"><spring:message code="inquiry.status.cancelled"/></c:when>
                                                        <c:when test="${inq.status eq 'DELETE_REQUESTED'}"><spring:message code="inquiry.status.deleteRequested"/></c:when>
                                                        <c:when test="${inq.status eq 'PRIVATE_REQUESTED'}"><spring:message code="inquiry.status.privateRequested"/></c:when>
                                                        <c:when test="${inq.status eq 'PUBLIC_REQUESTED'}"><spring:message code="inquiry.status.publicRequested"/></c:when>
                                                    </c:choose>
                                                </span>
                                                <%-- 관리자 전용 AI 감지 배지 + BLUR 해제 버튼 --%>
                                                <c:if test="${isAdmin and inq.aiFlagged}">
                                                    <span class="inq-ai-badge"><spring:message code="inquiry.badge.ai"/></span>
                                                    <button type="button" class="inq-admin-clear-blur-btn"
                                                            data-id="${inq.inquiryId}">
                                                        <spring:message code="inquiry.admin.clearBlur"/>
                                                    </button>
                                                </c:if>
                                                <%-- 일반 유저: 제목 위에 오버레이로 AI 감지 안내 (클릭 시 블러 해제) --%>
                                                <c:if test="${isBlurred}">
                                                    <div class="inq-title-blur-overlay"><spring:message code="inquiry.blocked.ai"/></div>
                                                </c:if>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <%-- 카테고리 --%>
                                <td>
                                    <span class="inq-category-tag">
                                        <c:choose>
                                            <c:when test="${inq.category eq 'service'}"><spring:message code="inquiry.category.service"/></c:when>
                                            <c:when test="${inq.category eq 'payment'}"><spring:message code="inquiry.category.payment"/></c:when>
                                            <c:when test="${inq.category eq 'account'}"><spring:message code="inquiry.category.account"/></c:when>
                                            <c:when test="${inq.category eq 'bug'}"><spring:message code="inquiry.category.bug"/></c:when>
                                            <c:otherwise><spring:message code="inquiry.category.etc"/></c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>

                                <%-- 작성자: 비밀글이면 익명 표시 --%>
                                <td class="inq-nick">
                                    <c:choose>
                                        <c:when test="${inq.isPrivate == 1 and !isMyPost and !isAdmin}"><spring:message code="inquiry.anonymous"/></c:when>
                                        <c:otherwise><c:out value="${inq.nickname}"/></c:otherwise>
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

    // 블러 오버레이 클릭 시 제목 블러 해제 (행 클릭 막고 점진적 공개)
    document.querySelectorAll('.inq-title-blur-overlay').forEach(function (ov) {
        ov.addEventListener('click', function (e) {
            e.stopPropagation();
            var wrap = this.closest('.inq-title-blur-wrap');
            if (wrap) {
                wrap.querySelectorAll('.inq-title-blurred').forEach(function (el) {
                    el.classList.remove('inq-title-blurred');
                });
                this.remove();
            }
        });
    });

    // 관리자 BLUR 해제 버튼 (행 클릭 이벤트 전파 막고 API 호출)
    document.querySelectorAll('.inq-admin-clear-blur-btn').forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            e.stopPropagation();
            var inquiryId = this.getAttribute('data-id');
            if (!confirm('<spring:message code="inquiry.admin.clearBlur.confirm" javaScriptEscape="true"/>')) return;
            fetch(ctx + '/inquiry/' + inquiryId + '/clear-blur', { method: 'POST' })
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (d.success) location.reload();
                    else alert('<spring:message code="inquiry.admin.clearBlur.fail" javaScriptEscape="true"/>');
                });
        });
    });
})();
</script>

</body>
</html>
