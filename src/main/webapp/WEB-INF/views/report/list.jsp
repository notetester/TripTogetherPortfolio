<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_1f00683640" code="report.list.pageTitle.all"/>
<spring:message var="autoMsg_701304a57c" code="report.list.pageTitle.mine"/>
<spring:message var="autoMsg_751d7981a2" code="report.list.pageSubtitle.all"/>
<spring:message var="autoMsg_31f33503a9" code="report.list.pageSubtitle.mine"/>
<spring:message var="autoMsg_f97bf54645" code="report.list.tab.all"/>
<spring:message var="autoMsg_828bf752f6" code="report.list.tab.post"/>
<spring:message var="autoMsg_482706918f" code="report.list.tab.comment"/>
<spring:message var="autoMsg_e87af823b8" code="report.list.tab.review"/>
<spring:message var="autoMsg_5b454f9807" code="report.list.tab.user"/>
<spring:message var="autoMsg_4edc6703be" code="report.list.totalCount"/>
<spring:message var="autoMsg_7f1563d033" code="report.list.column.no"/>
<spring:message var="autoMsg_41d070034a" code="report.list.column.targetType"/>
<spring:message var="autoMsg_7c37c7e9c7" code="report.list.column.reason"/>
<spring:message var="autoMsg_711f2243db" code="report.list.column.status"/>
<spring:message var="autoMsg_eaa7870b5d" code="report.list.column.reportedAt"/>
<spring:message var="autoMsg_f868099c48" code="report.list.empty"/>
<spring:message var="autoMsg_69daf71796" code="report.common.target.post"/>
<spring:message var="autoMsg_a3c96f99cc" code="report.common.target.comment"/>
<spring:message var="autoMsg_4acfc12f9c" code="report.common.target.review"/>
<spring:message var="autoMsg_126317c298" code="report.common.target.user"/>
<spring:message var="autoMsg_6c909f18e9" code="report.common.none"/>
<spring:message var="autoMsg_d3f70cea7f" code="report.common.reason.spam"/>
<spring:message var="autoMsg_2236d0601b" code="report.common.reason.abuse"/>
<spring:message var="autoMsg_0c73c3e7ed" code="report.common.reason.privacy"/>
<spring:message var="autoMsg_7dc04d4213" code="report.common.reason.adult"/>
<spring:message var="autoMsg_7da128d193" code="report.common.reason.illegal"/>
<spring:message var="autoMsg_ca0406b6f4" code="report.common.reason.other"/>
<spring:message var="autoMsg_e545909f3a" code="report.common.status.inReview"/>
<spring:message var="autoMsg_1af8849e59" code="report.common.status.resolved"/>
<spring:message var="autoMsg_737a121376" code="report.common.status.dismissed"/>
<spring:message var="autoMsg_e8c2445e84" code="report.common.status.cancelled"/>
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
          <c:when test="${isAdmin}"><h1>${autoMsg_1f00683640}</h1></c:when>
          <c:otherwise><h1>${autoMsg_701304a57c}</h1></c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${isAdmin}"><p class="rpt-ph-sub">${autoMsg_751d7981a2}</p></c:when>
          <c:otherwise><p class="rpt-ph-sub">${autoMsg_31f33503a9}</p></c:otherwise>
        </c:choose>

        <div class="rpt-tabs">
            <a href="${pageContext.request.contextPath}/report/list"
               class="rpt-tab ${empty search.targetType ? 'active' : ''}">${autoMsg_f97bf54645}</a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=post"
               class="rpt-tab ${search.targetType eq 'post' ? 'active' : ''}">${autoMsg_828bf752f6}</a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=comment"
               class="rpt-tab ${search.targetType eq 'comment' ? 'active' : ''}">${autoMsg_482706918f}</a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=review"
               class="rpt-tab ${search.targetType eq 'review' ? 'active' : ''}">${autoMsg_e87af823b8}</a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=user"
               class="rpt-tab ${search.targetType eq 'user' ? 'active' : ''}">${autoMsg_5b454f9807}</a>
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
            <span class="rpt-total">${autoMsg_4edc6703be}</span>
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
                        <th>${autoMsg_7f1563d033}</th>
                        <th>${autoMsg_41d070034a}</th>
                        <th>${autoMsg_7c37c7e9c7}</th>
                        <th>${autoMsg_711f2243db}</th>
                        <th>${autoMsg_eaa7870b5d}</th>
                    </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty reportList}">
                        <tr>
                            <td colspan="5" class="rpt-empty">
                                <div class="rpt-empty-inner">
                                    <div class="rpt-empty-icon">📭</div>
                                    <div class="rpt-empty-msg">${autoMsg_f868099c48}</div>
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
                                            <span class="rpt-type-tag type-post">${autoMsg_69daf71796}</span>
                                        </c:when>
                                        <c:when test="${r.targetType eq 'comment'}">
                                            <span class="rpt-type-tag type-comment">${autoMsg_a3c96f99cc}</span>
                                        </c:when>
                                        <c:when test="${r.targetType eq 'review'}">
                                            <span class="rpt-type-tag type-review">${autoMsg_4acfc12f9c}</span>
                                        </c:when>
                                        <c:when test="${r.targetType eq 'user'}">
                                            <span class="rpt-type-tag type-user">${autoMsg_126317c298}</span>
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
                                                    <c:otherwise>${autoMsg_6c909f18e9}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="rpt-reason-text">
                                                <c:choose>
                                                    <c:when test="${r.reason eq 'spam'}">${autoMsg_d3f70cea7f}</c:when>
                                                    <c:when test="${r.reason eq 'abuse'}">${autoMsg_2236d0601b}</c:when>
                                                    <c:when test="${r.reason eq 'privacy'}">${autoMsg_0c73c3e7ed}</c:when>
                                                    <c:when test="${r.reason eq 'adult'}">${autoMsg_7dc04d4213}</c:when>
                                                    <c:when test="${r.reason eq 'illegal'}">${autoMsg_7da128d193}</c:when>
                                                    <c:when test="${r.reason eq 'other'}">${autoMsg_ca0406b6f4}</c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${not empty r.reason}">${r.reason}</c:when>
                                                            <c:otherwise>${autoMsg_6c909f18e9}</c:otherwise>
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
                                            <c:when test="${r.status eq 'IN_REVIEW'}">${autoMsg_e545909f3a}</c:when>
                                            <c:when test="${r.status eq 'RESOLVED'}">${autoMsg_1af8849e59}</c:when>
                                            <c:when test="${r.status eq 'DISMISSED'}">${autoMsg_737a121376}</c:when>
                                            <c:when test="${r.status eq 'CANCELLED'}">${autoMsg_e8c2445e84}</c:when>
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
