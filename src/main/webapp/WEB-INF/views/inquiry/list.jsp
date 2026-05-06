<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_912bcae37f" code="inquiry.list.title"/>
<spring:message var="autoMsg_3e07d6a304" code="inquiry.list.subtitle"/>
<spring:message var="autoMsg_2a028f6db0" code="inquiry.all"/>
<spring:message var="autoMsg_006ce58f3b" code="inquiry.category.service"/>
<spring:message var="autoMsg_b4db95ba6b" code="inquiry.category.payment"/>
<spring:message var="autoMsg_e5842af72f" code="inquiry.category.account"/>
<spring:message var="autoMsg_617de2f8c7" code="inquiry.category.bug"/>
<spring:message var="autoMsg_7b787af45a" code="inquiry.category.etc"/>
<spring:message var="autoMsg_ae381b9741" code="inquiry.search.placeholder"/>
<spring:message var="autoMsg_29ce1549b9" code="inquiry.search.button"/>
<spring:message var="autoMsg_5ae3295eed" code="inquiry.total"/>
<spring:message var="autoMsg_e6fdd3b71a" code="inquiry.total.suffix"/>
<spring:message var="autoMsg_7525331304" code="inquiry.status.pending"/>
<spring:message var="autoMsg_f6aed6b412" code="inquiry.status.inProgress"/>
<spring:message var="autoMsg_38c8228cdc" code="inquiry.status.completed"/>
<spring:message var="autoMsg_68458c3c7e" code="inquiry.write.button"/>
<spring:message var="autoMsg_e3faeecd78" code="inquiry.table.title"/>
<spring:message var="autoMsg_b701db9417" code="inquiry.table.category"/>
<spring:message var="autoMsg_c808019c76" code="inquiry.table.author"/>
<spring:message var="autoMsg_e366b00d7d" code="inquiry.table.date"/>
<spring:message var="autoMsg_36f23c8af7" code="inquiry.empty"/>
<spring:message var="autoMsg_3565eb1a2e" code="inquiry.empty.subtitle"/>
<spring:message var="autoMsg_0623b022ca" code="inquiry.private.post"/>
<spring:message var="autoMsg_3985df1bd7" code="inquiry.private.tag"/>
<spring:message var="autoMsg_a1d69646a7" code="inquiry.status.answerDone"/>
<spring:message var="autoMsg_2a520f4f32" code="inquiry.status.userCompleted"/>
<spring:message var="autoMsg_36bab78855" code="inquiry.status.cancelled"/>
<spring:message var="autoMsg_59a8e4d46c" code="inquiry.status.deleteRequested"/>
<spring:message var="autoMsg_6f8d141f76" code="inquiry.status.privateRequested"/>
<spring:message var="autoMsg_b3a78ebbf3" code="inquiry.status.publicRequested"/>
<spring:message var="autoMsg_c6bd998679" code="inquiry.badge.ai"/>
<spring:message var="autoMsg_ca3b64eac7" code="inquiry.blocked.ai"/>
<spring:message var="autoMsg_cce006a50b" code="inquiry.anonymous"/>
<spring:message var="autoMsg_153028eb77" code="inquiry.admin.clearBlur.confirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_59dea71733" code="inquiry.admin.clearBlur.fail" javaScriptEscape="true"/>
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
        <h1>${autoMsg_912bcae37f}</h1>
        <p class="inq-ph-sub">${autoMsg_3e07d6a304}</p>

        <%-- 카테고리 탭 - 현재 선택된 탭에 active 클래스 --%>
        <div class="inq-tabs">
            <a href="${pageContext.request.contextPath}/inquiry/list"
               class="inq-tab ${empty search.category ? 'active' : ''}">${autoMsg_2a028f6db0}</a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=service"
               class="inq-tab ${search.category eq 'service' ? 'active' : ''}">${autoMsg_006ce58f3b}</a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=payment"
               class="inq-tab ${search.category eq 'payment' ? 'active' : ''}">${autoMsg_b4db95ba6b}</a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=account"
               class="inq-tab ${search.category eq 'account' ? 'active' : ''}">${autoMsg_e5842af72f}</a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=bug"
               class="inq-tab ${search.category eq 'bug' ? 'active' : ''}">${autoMsg_617de2f8c7}</a>
            <a href="${pageContext.request.contextPath}/inquiry/list?category=etc"
               class="inq-tab ${search.category eq 'etc' ? 'active' : ''}">${autoMsg_7b787af45a}</a>
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
                       value="${search.keyword}" placeholder="${autoMsg_ae381b9741}">
                <button class="inq-search-btn" type="submit">${autoMsg_29ce1549b9}</button>
            </div>
        </form>

        <%-- =============================================
             3. 툴바
             - 총 건수 표시
             - 어드민 전용: 상태 필터 (전체/대기중/처리중/완료)
             - 문의하기 버튼
             ============================================= --%>
        <div class="inq-toolbar">
            <span class="inq-total">${autoMsg_5ae3295eed} <strong>${totalCount}</strong>${autoMsg_e6fdd3b71a}</span>

            <%-- 어드민만 상태 필터 표시 --%>
            <c:if test="${isAdmin}">
                <div class="inq-status-filter">
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&keyword=${search.keyword}"
                       class="inq-sf ${empty search.status ? 'active' : ''}">${autoMsg_2a028f6db0}</a>
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&keyword=${search.keyword}&status=PENDING"
                       class="inq-sf ${search.status eq 'PENDING' ? 'active' : ''}">${autoMsg_7525331304}</a>
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&keyword=${search.keyword}&status=IN_PROGRESS"
                       class="inq-sf ${search.status eq 'IN_PROGRESS' ? 'active' : ''}">${autoMsg_f6aed6b412}</a>
                    <a href="${pageContext.request.contextPath}/inquiry/list?category=${search.category}&keyword=${search.keyword}&status=COMPLETED"
                       class="inq-sf ${search.status eq 'COMPLETED' ? 'active' : ''}">${autoMsg_38c8228cdc}</a>
                </div>
            </c:if>

            <button class="inq-btn-write"
                    onclick="location.href='${pageContext.request.contextPath}/inquiry/write'">
                &#43;&nbsp;${autoMsg_68458c3c7e}
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
                        <th>${autoMsg_e3faeecd78}</th>
                        <th>${autoMsg_b701db9417}</th>
                        <th>${autoMsg_c808019c76}</th>
                        <th>${autoMsg_e366b00d7d}</th>
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
                                    <div class="inq-empty-msg">${autoMsg_36f23c8af7}</div>
                                    <div class="inq-empty-sub">${autoMsg_3565eb1a2e}</div>
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
                                            <span class="inq-title inq-title-blocked">${autoMsg_0623b022ca}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="${isBlurred ? 'inq-title-blur-wrap' : ''}">
                                                <span class="inq-title ${isBlurred ? 'inq-title-blurred' : ''}">
                                                    <c:if test="${inq.isPrivate == 1}">
                                                        <span class="inq-private-tag">${autoMsg_3985df1bd7}</span>
                                                    </c:if>
                                                    <c:out value="${inq.title}"/>
                                                </span>
                                                <%-- 상태 뱃지 --%>
                                                <span class="inq-status-badge ${inq.status}">
                                                    <c:choose>
                                                        <c:when test="${inq.status eq 'PENDING'}">${autoMsg_7525331304}</c:when>
                                                        <c:when test="${inq.status eq 'IN_PROGRESS'}">${autoMsg_f6aed6b412}</c:when>
                                                        <c:when test="${inq.status eq 'COMPLETED'}">${autoMsg_a1d69646a7}</c:when>
                                                        <c:when test="${inq.status eq 'USER_COMPLETED'}">${autoMsg_2a520f4f32}</c:when>
                                                        <c:when test="${inq.status eq 'CANCELLED'}">${autoMsg_36bab78855}</c:when>
                                                        <c:when test="${inq.status eq 'DELETE_REQUESTED'}">${autoMsg_59a8e4d46c}</c:when>
                                                        <c:when test="${inq.status eq 'PRIVATE_REQUESTED'}">${autoMsg_6f8d141f76}</c:when>
                                                        <c:when test="${inq.status eq 'PUBLIC_REQUESTED'}">${autoMsg_b3a78ebbf3}</c:when>
                                                    </c:choose>
                                                </span>
                                                <%-- 관리자 전용 AI 감지 배지 + BLUR 해제 버튼 --%>
                                                <c:if test="${isAdmin and inq.aiFlagged}">
                                                    <span class="inq-ai-badge">${autoMsg_c6bd998679}</span>
                                                    <button type="button" class="inq-admin-clear-blur-btn"
                                                            data-id="${inq.inquiryId}">
                                                        <spring:message code="inquiry.admin.clearBlur"/>
                                                    </button>
                                                </c:if>
                                                <%-- 일반 유저: 제목 위에 오버레이로 AI 감지 안내 (클릭 시 블러 해제) --%>
                                                <c:if test="${isBlurred}">
                                                    <div class="inq-title-blur-overlay">${autoMsg_ca3b64eac7}</div>
                                                </c:if>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <%-- 카테고리 --%>
                                <td>
                                    <span class="inq-category-tag">
                                        <c:choose>
                                            <c:when test="${inq.category eq 'service'}">${autoMsg_006ce58f3b}</c:when>
                                            <c:when test="${inq.category eq 'payment'}">${autoMsg_b4db95ba6b}</c:when>
                                            <c:when test="${inq.category eq 'account'}">${autoMsg_e5842af72f}</c:when>
                                            <c:when test="${inq.category eq 'bug'}">${autoMsg_617de2f8c7}</c:when>
                                            <c:otherwise>${autoMsg_7b787af45a}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>

                                <%-- 작성자: 비밀글이면 익명 표시 --%>
                                <td class="inq-nick">
                                    <c:choose>
                                        <c:when test="${inq.isPrivate == 1 and !isMyPost and !isAdmin}">${autoMsg_cce006a50b}</c:when>
                                        <c:otherwise><c:out value="${inq.nickname}"/></c:otherwise>
                                    </c:choose>
                                </td>

                                <%-- 작성일 --%>
                                <td class="inq-date">
                                    <fmt:formatDate value="${inq.createdAtDate}" pattern="yyyy-MM-dd"/>
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
            if (!confirm('${autoMsg_153028eb77}')) return;
            fetch(ctx + '/inquiry/' + inquiryId + '/clear-blur', { method: 'POST' })
                .then(function (r) { return r.json(); })
                .then(function (d) {
                    if (d.success) location.reload();
                    else alert('${autoMsg_59dea71733}');
                });
        });
    });
})();
</script>

</body>
</html>
