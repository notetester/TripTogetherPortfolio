<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  =============================================
  신고 내역 목록 페이지
  URL: GET /report/list
  =============================================
  [model 필요]
  - reportList  : List<ReportDto> - 신고 목록
  - totalCount  : int             - 전체 신고 수
  - totalPage   : int             - 전체 페이지 수
  - search      : ReportSearchDto - 검색 조건 (targetType, page)

  [페이지 구성]
  1. 페이지 헤더 + 대상 유형 탭
  2. 툴바 (총 건수)
  3. 신고 목록 테이블
  4. 페이지네이션
  5. 스크립트 (행 클릭 이동)
  =============================================
--%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="report/report.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<%-- =============================================
     1. 페이지 헤더 + 탭
     ============================================= --%>
<div class="rpt-ph">
    <div class="si">
        <c:choose>
          <c:when test="${isAdmin}"><h1>전체 신고 내역</h1></c:when>
          <c:otherwise><h1>내 신고 내역</h1></c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${isAdmin}"><p class="rpt-ph-sub">접수된 모든 신고 내역을 확인할 수 있습니다</p></c:when>
          <c:otherwise><p class="rpt-ph-sub">접수한 신고 내역을 확인할 수 있습니다</p></c:otherwise>
        </c:choose>

        <div class="rpt-tabs">
            <a href="${pageContext.request.contextPath}/report/list"
               class="rpt-tab ${empty search.targetType ? 'active' : ''}">전체</a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=post"
               class="rpt-tab ${search.targetType eq 'post' ? 'active' : ''}">게시글</a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=comment"
               class="rpt-tab ${search.targetType eq 'comment' ? 'active' : ''}">댓글</a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=review"
               class="rpt-tab ${search.targetType eq 'review' ? 'active' : ''}">여행지 리뷰</a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=user"
               class="rpt-tab ${search.targetType eq 'user' ? 'active' : ''}">유저</a>
        </div>
    </div>
</div>

<%-- =============================================
     본문 영역
     ============================================= --%>
<div class="rpt-body-wrap">
    <div class="si">

        <%-- =============================================
             2. 툴바
             ============================================= --%>
        <div class="rpt-toolbar">
            <span class="rpt-total">총 <strong>${totalCount}</strong>건</span>
        </div>

        <%-- =============================================
             3. 신고 목록 테이블
             ============================================= --%>
        <div class="rpt-table-wrap">
            <table class="rpt-table">
                <colgroup>
                    <col style="width:60px">
                    <col style="width:90px">
                    <col>
                    <col style="width:110px">
                    <col style="width:100px">
                </colgroup>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>대상 유형</th>
                        <th>사유</th>
                        <th>처리 상태</th>
                        <th>신고일</th>
                    </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty reportList}">
                        <tr>
                            <td colspan="5" class="rpt-empty">
                                <div class="rpt-empty-inner">
                                    <div class="rpt-empty-icon">📭</div>
                                    <div class="rpt-empty-msg">신고 내역이 없습니다</div>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="r" items="${reportList}" varStatus="vs">
                            <tr class="rpt-row" data-id="${r.reportId}">
                                <%-- No: 최신글이 1번이 되도록 역순 계산 --%>
                                <td class="rpt-no">
                                    ${totalCount - ((search.page - 1) * search.pageSize) - vs.index}
                                </td>

                                <%-- 대상 유형 --%>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.targetType eq 'post'}">
                                            <span class="rpt-type-tag type-post">커뮤니티 게시글</span>
                                        </c:when>
                                        <c:when test="${r.targetType eq 'comment'}">
                                            <span class="rpt-type-tag type-comment">커뮤니티 댓글</span>
                                        </c:when>
                                        <c:when test="${r.targetType eq 'review'}">
                                            <span class="rpt-type-tag type-review">여행지 리뷰</span>
                                        </c:when>
                                        <c:when test="${r.targetType eq 'user'}">
                                            <span class="rpt-type-tag type-user">유저</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="rpt-type-tag">${r.targetType}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <%-- 사유 --%>
                                <td class="rpt-reason-cell">
                                    <c:choose>
                                        <%-- 유저 신고: description에 자유입력 --%>
                                        <c:when test="${r.targetType eq 'user'}">
                                            <span class="rpt-reason-text">
                                                <c:choose>
                                                    <c:when test="${not empty r.description}">${r.description}</c:when>
                                                    <c:otherwise>—</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:when>
                                        <%-- 게시글/댓글/리뷰 신고: reason 코드값을 한글로 --%>
                                        <c:otherwise>
                                            <span class="rpt-reason-text">
                                                <c:choose>
                                                    <c:when test="${r.reason eq 'spam'}">스팸/광고</c:when>
                                                    <c:when test="${r.reason eq 'abuse'}">욕설/비방</c:when>
                                                    <c:when test="${r.reason eq 'privacy'}">개인정보 노출</c:when>
                                                    <c:when test="${r.reason eq 'adult'}">음란물</c:when>
                                                    <c:when test="${r.reason eq 'illegal'}">불법 정보</c:when>
                                                    <c:when test="${r.reason eq 'other'}">기타</c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${not empty r.reason}">${r.reason}</c:when>
                                                            <c:otherwise>—</c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <%-- 처리 상태 --%>
                                <td>
                                    <span class="rpt-status-badge ${r.status}">
                                        <c:choose>
                                            <c:when test="${r.status eq 'IN_REVIEW'}">검토중</c:when>
                                            <c:when test="${r.status eq 'RESOLVED'}">처리완료</c:when>
                                            <c:when test="${r.status eq 'DISMISSED'}">반려</c:when>
                                            <c:when test="${r.status eq 'CANCELLED'}">취소됨</c:when>
                                            <c:otherwise>${r.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>

                                <%-- 신고일 --%>
                                <td class="rpt-date">
                                    <fmt:formatDate value="${r.createdAt}" pattern="yyyy-MM-dd"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>

        <%-- =============================================
             4. 페이지네이션
             ============================================= --%>
        <c:if test="${totalPage > 1}">
            <div class="rpt-pagination">
                <c:if test="${search.page > 1}">
                    <a href="${pageContext.request.contextPath}/report/list?targetType=${search.targetType}&page=${search.page - 1}"
                       class="rpt-page-btn">&#8249;</a>
                </c:if>
                <c:forEach begin="1" end="${totalPage}" var="p">
                    <a href="${pageContext.request.contextPath}/report/list?targetType=${search.targetType}&page=${p}"
                       class="rpt-page-btn ${p == search.page ? 'active' : ''}">${p}</a>
                </c:forEach>
                <c:if test="${search.page < totalPage}">
                    <a href="${pageContext.request.contextPath}/report/list?targetType=${search.targetType}&page=${search.page + 1}"
                       class="rpt-page-btn">&#8250;</a>
                </c:if>
            </div>
        </c:if>

    </div>
</div>

<%@ include file="../common/footer.jsp" %>

<%-- =============================================
     5. 스크립트
     ============================================= --%>
<script>
(function () {
    var ctx = '${pageContext.request.contextPath}';

    // 행 클릭 시 상세 페이지 이동 (page/targetType 파라미터 전달)
    var listParams = 'page=${search.page}&targetType=${search.targetType}';
    document.querySelectorAll('.rpt-row[data-id]').forEach(function (tr) {
        tr.addEventListener('click', function () {
            location.href = ctx + '/report/' + this.getAttribute('data-id') + '?' + listParams;
        });
    });
})();
</script>

</body>
</html>
