<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
          <c:when test="${isAdmin}"><h1><spring:message code="report.list.pageTitle.all"/></h1></c:when>
          <c:otherwise><h1><spring:message code="report.list.pageTitle.mine"/></h1></c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${isAdmin}"><p class="rpt-ph-sub"><spring:message code="report.list.pageSubtitle.all"/></p></c:when>
          <c:otherwise><p class="rpt-ph-sub"><spring:message code="report.list.pageSubtitle.mine"/></p></c:otherwise>
        </c:choose>

        <div class="rpt-tabs">
            <a href="${pageContext.request.contextPath}/report/list"
               class="rpt-tab ${empty search.targetType ? 'active' : ''}"><spring:message code="report.list.tab.all"/></a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=post"
               class="rpt-tab ${search.targetType eq 'post' ? 'active' : ''}"><spring:message code="report.list.tab.post"/></a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=comment"
               class="rpt-tab ${search.targetType eq 'comment' ? 'active' : ''}"><spring:message code="report.list.tab.comment"/></a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=review"
               class="rpt-tab ${search.targetType eq 'review' ? 'active' : ''}"><spring:message code="report.list.tab.review"/></a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=user"
               class="rpt-tab ${search.targetType eq 'user' ? 'active' : ''}"><spring:message code="report.list.tab.user"/></a>
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
            <span class="rpt-total"><spring:message code="report.list.totalCount" arguments="${totalCount}"/></span>
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
                        <th><spring:message code="report.list.column.no"/></th>
                        <th><spring:message code="report.list.column.targetType"/></th>
                        <th><spring:message code="report.list.column.reason"/></th>
                        <th><spring:message code="report.list.column.status"/></th>
                        <th><spring:message code="report.list.column.reportedAt"/></th>
                    </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty reportList}">
                        <tr>
                            <td colspan="5" class="rpt-empty">
                                <div class="rpt-empty-inner">
                                    <div class="rpt-empty-icon">📭</div>
                                    <div class="rpt-empty-msg"><spring:message code="report.list.empty"/></div>
                                </div>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="r" items="${reportList}" varStatus="vs">
                            <tr class="rpt-row" data-id="${r.reportId}">
                                <td class="rpt-no">
                                    ${totalCount - ((search.page - 1) * search.pageSize) - vs.index}
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${r.targetType eq 'post'}">
                                            <span class="rpt-type-tag type-post"><spring:message code="report.common.target.post"/></span>
                                        </c:when>
                                        <c:when test="${r.targetType eq 'comment'}">
                                            <span class="rpt-type-tag type-comment"><spring:message code="report.common.target.comment"/></span>
                                        </c:when>
                                        <c:when test="${r.targetType eq 'review'}">
                                            <span class="rpt-type-tag type-review"><spring:message code="report.common.target.review"/></span>
                                        </c:when>
                                        <c:when test="${r.targetType eq 'user'}">
                                            <span class="rpt-type-tag type-user"><spring:message code="report.common.target.user"/></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="rpt-type-tag">${r.targetType}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="rpt-reason-cell">
                                    <c:choose>
                                        <c:when test="${r.targetType eq 'user'}">
                                            <span class="rpt-reason-text">
                                                <c:choose>
                                                    <c:when test="${not empty r.description}">${r.description}</c:when>
                                                    <c:otherwise><spring:message code="report.common.none"/></c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="rpt-reason-text">
                                                <c:choose>
                                                    <c:when test="${r.reason eq 'spam'}"><spring:message code="report.common.reason.spam"/></c:when>
                                                    <c:when test="${r.reason eq 'abuse'}"><spring:message code="report.common.reason.abuse"/></c:when>
                                                    <c:when test="${r.reason eq 'privacy'}"><spring:message code="report.common.reason.privacy"/></c:when>
                                                    <c:when test="${r.reason eq 'adult'}"><spring:message code="report.common.reason.adult"/></c:when>
                                                    <c:when test="${r.reason eq 'illegal'}"><spring:message code="report.common.reason.illegal"/></c:when>
                                                    <c:when test="${r.reason eq 'other'}"><spring:message code="report.common.reason.other"/></c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${not empty r.reason}">${r.reason}</c:when>
                                                            <c:otherwise><spring:message code="report.common.none"/></c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <span class="rpt-status-badge ${r.status}">
                                        <c:choose>
                                            <c:when test="${r.status eq 'IN_REVIEW'}"><spring:message code="report.common.status.inReview"/></c:when>
                                            <c:when test="${r.status eq 'RESOLVED'}"><spring:message code="report.common.status.resolved"/></c:when>
                                            <c:when test="${r.status eq 'DISMISSED'}"><spring:message code="report.common.status.dismissed"/></c:when>
                                            <c:when test="${r.status eq 'CANCELLED'}"><spring:message code="report.common.status.cancelled"/></c:when>
                                            <c:otherwise>${r.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>

                                <td class="rpt-date">
                                    <fmt:formatDate value="${r.createdAtDate}" pattern="yyyy-MM-dd"/>
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

<script>
(function () {
    var ctx = '${pageContext.request.contextPath}';
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
