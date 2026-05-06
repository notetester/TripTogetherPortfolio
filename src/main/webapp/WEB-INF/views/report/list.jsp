<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_report_list_pageTitle_all" code="report.list.pageTitle.all"/>
<spring:message var="msg_report_list_pageTitle_mine" code="report.list.pageTitle.mine"/>
<spring:message var="msg_report_list_pageSubtitle_all" code="report.list.pageSubtitle.all"/>
<spring:message var="msg_report_list_pageSubtitle_mine" code="report.list.pageSubtitle.mine"/>
<spring:message var="msg_report_list_tab_all" code="report.list.tab.all"/>
<spring:message var="msg_report_list_tab_post" code="report.list.tab.post"/>
<spring:message var="msg_report_list_tab_comment" code="report.list.tab.comment"/>
<spring:message var="msg_report_list_tab_review" code="report.list.tab.review"/>
<spring:message var="msg_report_list_tab_user" code="report.list.tab.user"/>
<spring:message var="msg_report_list_totalCount" code="report.list.totalCount"/>
<spring:message var="msg_report_list_column_no" code="report.list.column.no"/>
<spring:message var="msg_report_list_column_targetType" code="report.list.column.targetType"/>
<spring:message var="msg_report_list_column_reason" code="report.list.column.reason"/>
<spring:message var="msg_report_list_column_status" code="report.list.column.status"/>
<spring:message var="msg_report_list_column_reportedAt" code="report.list.column.reportedAt"/>
<spring:message var="msg_report_list_empty" code="report.list.empty"/>
<spring:message var="msg_report_common_target_post" code="report.common.target.post"/>
<spring:message var="msg_report_common_target_comment" code="report.common.target.comment"/>
<spring:message var="msg_report_common_target_review" code="report.common.target.review"/>
<spring:message var="msg_report_common_target_user" code="report.common.target.user"/>
<spring:message var="msg_report_common_none" code="report.common.none"/>
<spring:message var="msg_report_common_reason_spam" code="report.common.reason.spam"/>
<spring:message var="msg_report_common_reason_abuse" code="report.common.reason.abuse"/>
<spring:message var="msg_report_common_reason_privacy" code="report.common.reason.privacy"/>
<spring:message var="msg_report_common_reason_adult" code="report.common.reason.adult"/>
<spring:message var="msg_report_common_reason_illegal" code="report.common.reason.illegal"/>
<spring:message var="msg_report_common_reason_other" code="report.common.reason.other"/>
<spring:message var="msg_report_common_status_inReview" code="report.common.status.inReview"/>
<spring:message var="msg_report_common_status_resolved" code="report.common.status.resolved"/>
<spring:message var="msg_report_common_status_dismissed" code="report.common.status.dismissed"/>
<spring:message var="msg_report_common_status_cancelled" code="report.common.status.cancelled"/>
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
          <c:when test="${isAdmin}"><h1>${msg_report_list_pageTitle_all}</h1></c:when>
          <c:otherwise><h1>${msg_report_list_pageTitle_mine}</h1></c:otherwise>
        </c:choose>
        <c:choose>
          <c:when test="${isAdmin}"><p class="rpt-ph-sub">${msg_report_list_pageSubtitle_all}</p></c:when>
          <c:otherwise><p class="rpt-ph-sub">${msg_report_list_pageSubtitle_mine}</p></c:otherwise>
        </c:choose>

        <div class="rpt-tabs">
            <a href="${pageContext.request.contextPath}/report/list"
               class="rpt-tab ${empty search.targetType ? 'active' : ''}">${msg_report_list_tab_all}</a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=post"
               class="rpt-tab ${search.targetType eq 'post' ? 'active' : ''}">${msg_report_list_tab_post}</a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=comment"
               class="rpt-tab ${search.targetType eq 'comment' ? 'active' : ''}">${msg_report_list_tab_comment}</a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=review"
               class="rpt-tab ${search.targetType eq 'review' ? 'active' : ''}">${msg_report_list_tab_review}</a>
            <a href="${pageContext.request.contextPath}/report/list?targetType=user"
               class="rpt-tab ${search.targetType eq 'user' ? 'active' : ''}">${msg_report_list_tab_user}</a>
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
            <span class="rpt-total">${msg_report_list_totalCount}</span>
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
                        <th>${msg_report_list_column_no}</th>
                        <th>${msg_report_list_column_targetType}</th>
                        <th>${msg_report_list_column_reason}</th>
                        <th>${msg_report_list_column_status}</th>
                        <th>${msg_report_list_column_reportedAt}</th>
                    </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty reportList}">
                        <tr>
                            <td colspan="5" class="rpt-empty">
                                <div class="rpt-empty-inner">
                                    <div class="rpt-empty-icon">📭</div>
                                    <div class="rpt-empty-msg">${msg_report_list_empty}</div>
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
                                            <span class="rpt-type-tag type-post">${msg_report_common_target_post}</span>
                                        </c:when>
                                        <c:when test="${r.targetType eq 'comment'}">
                                            <span class="rpt-type-tag type-comment">${msg_report_common_target_comment}</span>
                                        </c:when>
                                        <c:when test="${r.targetType eq 'review'}">
                                            <span class="rpt-type-tag type-review">${msg_report_common_target_review}</span>
                                        </c:when>
                                        <c:when test="${r.targetType eq 'user'}">
                                            <span class="rpt-type-tag type-user">${msg_report_common_target_user}</span>
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
                                                    <c:otherwise>${msg_report_common_none}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="rpt-reason-text">
                                                <c:choose>
                                                    <c:when test="${r.reason eq 'spam'}">${msg_report_common_reason_spam}</c:when>
                                                    <c:when test="${r.reason eq 'abuse'}">${msg_report_common_reason_abuse}</c:when>
                                                    <c:when test="${r.reason eq 'privacy'}">${msg_report_common_reason_privacy}</c:when>
                                                    <c:when test="${r.reason eq 'adult'}">${msg_report_common_reason_adult}</c:when>
                                                    <c:when test="${r.reason eq 'illegal'}">${msg_report_common_reason_illegal}</c:when>
                                                    <c:when test="${r.reason eq 'other'}">${msg_report_common_reason_other}</c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${not empty r.reason}">${r.reason}</c:when>
                                                            <c:otherwise>${msg_report_common_none}</c:otherwise>
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
                                            <c:when test="${r.status eq 'IN_REVIEW'}">${msg_report_common_status_inReview}</c:when>
                                            <c:when test="${r.status eq 'RESOLVED'}">${msg_report_common_status_resolved}</c:when>
                                            <c:when test="${r.status eq 'DISMISSED'}">${msg_report_common_status_dismissed}</c:when>
                                            <c:when test="${r.status eq 'CANCELLED'}">${msg_report_common_status_cancelled}</c:when>
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
