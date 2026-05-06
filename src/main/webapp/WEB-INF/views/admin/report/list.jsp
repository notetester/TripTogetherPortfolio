<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_reports_searchPlaceholder" code="admin.reports.searchPlaceholder"/>
<spring:message var="msg_admin_reports_pageTitle" code="admin.reports.pageTitle"/>
<spring:message var="msg_admin_common_id" code="admin.common.id"/>
<spring:message var="msg_admin_reports_kpi_total" code="admin.reports.kpi.total"/>
<spring:message var="msg_admin_reports_status_inReview" code="admin.reports.status.inReview"/>
<spring:message var="msg_admin_reports_status_resolved" code="admin.reports.status.resolved"/>
<spring:message var="msg_admin_reports_status_dismissed" code="admin.reports.status.dismissed"/>
<spring:message var="msg_admin_common_status" code="admin.common.status"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_reports_targetType" code="admin.reports.targetType"/>
<spring:message var="msg_admin_reports_target_post" code="admin.reports.target.post"/>
<spring:message var="msg_admin_reports_target_comment" code="admin.reports.target.comment"/>
<spring:message var="msg_admin_reports_target_review" code="admin.reports.target.review"/>
<spring:message var="msg_admin_reports_target_user" code="admin.reports.target.user"/>
<spring:message var="msg_admin_common_reason" code="admin.common.reason"/>
<spring:message var="msg_admin_reports_reason_spam" code="admin.reports.reason.spam"/>
<spring:message var="msg_admin_reports_reason_abuse" code="admin.reports.reason.abuse"/>
<spring:message var="msg_admin_reports_reason_privacy" code="admin.reports.reason.privacy"/>
<spring:message var="msg_admin_reports_reason_adult" code="admin.reports.reason.adult"/>
<spring:message var="msg_admin_reports_reason_illegal" code="admin.reports.reason.illegal"/>
<spring:message var="msg_admin_reports_reason_user" code="admin.reports.reason.user"/>
<spring:message var="msg_admin_reports_reason_other" code="admin.reports.reason.other"/>
<spring:message var="msg_admin_reports_searchLabel" code="admin.reports.searchLabel"/>
<spring:message var="msg_admin_common_searchButton" code="admin.common.searchButton"/>
<spring:message var="msg_admin_reports_listTitle" code="admin.reports.listTitle"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount"/>
<spring:message var="msg_admin_reports_reportCount" code="admin.reports.reportCount"/>
<spring:message var="msg_admin_common_target" code="admin.common.target"/>
<spring:message var="msg_admin_reports_reporter" code="admin.reports.reporter"/>
<spring:message var="msg_admin_reports_reportedAt" code="admin.reports.reportedAt"/>
<spring:message var="msg_admin_reports_resolvedAt" code="admin.reports.resolvedAt"/>
<spring:message var="msg_admin_common_countSuffix" code="admin.common.countSuffix"/>
<spring:message var="msg_admin_layout_menu_community" code="admin.layout.menu.community"/>
<spring:message var="msg_admin_layout_menu_explore" code="admin.layout.menu.explore"/>
<spring:message var="msg_admin_common_member" code="admin.common.member"/>
<spring:message var="msg_admin_reports_targetBlocked" code="admin.reports.targetBlocked"/>
<spring:message var="msg_admin_reports_targetDeleted" code="admin.reports.targetDeleted"/>
<spring:message var="msg_admin_common_viewDetail" code="admin.common.viewDetail"/>
<spring:message var="msg_admin_reports_accountBlocked" code="admin.reports.accountBlocked"/>
<spring:message var="msg_admin_reports_detail_processingTitle" code="admin.reports.detail.processingTitle"/>
<spring:message var="msg_admin_common_noResults" code="admin.common.noResults"/>
<spring:message var="msg_admin_common_pageStatus" code="admin.common.pageStatus"/>
<spring:message var="msg_admin_reports_viewSite" code="admin.reports.viewSite"/>
<c:set var="activeMenu" value="reports"/>


<c:set var="pageTitle" value="${msg_admin_reports_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_reports_kpi_total}</div>
            <div class="adm-summary-value is-primary">${stats.totalReports}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_reports_status_inReview}</div>
            <div class="adm-summary-value is-warning">${stats.inReviewReports}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_reports_status_resolved}</div>
            <div class="adm-summary-value is-success">${stats.resolvedReports}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_reports_status_dismissed}</div>
            <div class="adm-summary-value is-accent">${stats.dismissedReports}</div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/reports">
                <div class="adm-filter-bar">

                    <div>
                        <div class="adm-filter-label">${msg_admin_common_status}</div>
                        <select class="adm-select" name="status">
                            <option value=""           ${empty search.status         ? 'selected':''}>${msg_admin_common_all}</option>
                            <option value="IN_REVIEW"  ${search.status=='IN_REVIEW'  ? 'selected':''}>${msg_admin_reports_status_inReview}</option>
                            <option value="RESOLVED"   ${search.status=='RESOLVED'   ? 'selected':''}>${msg_admin_reports_status_resolved}</option>
                            <option value="DISMISSED"  ${search.status=='DISMISSED'  ? 'selected':''}>${msg_admin_reports_status_dismissed}</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">${msg_admin_reports_targetType}</div>
                        <select class="adm-select" name="targetType">
                            <option value=""        ${empty search.targetType      ? 'selected':''}>${msg_admin_common_all}</option>
                            <option value="post"    ${search.targetType=='post'    ? 'selected':''}>${msg_admin_reports_target_post}</option>
                            <option value="comment" ${search.targetType=='comment' ? 'selected':''}>${msg_admin_reports_target_comment}</option>
                            <option value="review"  ${search.targetType=='review'  ? 'selected':''}>${msg_admin_reports_target_review}</option>
                            <option value="user"    ${search.targetType=='user'    ? 'selected':''}>${msg_admin_reports_target_user}</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">${msg_admin_common_reason}</div>
                        <select class="adm-select" name="reason">
                            <option value=""        ${empty search.reason          ? 'selected':''}>${msg_admin_common_all}</option>
                            <option value="spam"    ${search.reason=='spam'    ? 'selected':''}>${msg_admin_reports_reason_spam}</option>
                            <option value="abuse"   ${search.reason=='abuse'   ? 'selected':''}>${msg_admin_reports_reason_abuse}</option>
                            <option value="privacy" ${search.reason=='privacy' ? 'selected':''}>${msg_admin_reports_reason_privacy}</option>
                            <option value="adult"   ${search.reason=='adult'   ? 'selected':''}>${msg_admin_reports_reason_adult}</option>
                            <option value="illegal" ${search.reason=='illegal' ? 'selected':''}>${msg_admin_reports_reason_illegal}</option>
                            <option value="user"    ${search.reason=='user'    ? 'selected':''}>${msg_admin_reports_reason_user}</option>
                            <option value="other"   ${search.reason=='other'   ? 'selected':''}>${msg_admin_reports_reason_other}</option>
                        </select>
                    </div>

                    <div style="flex:1;min-width:200px;">
                        <div class="adm-filter-label">${msg_admin_reports_searchLabel}</div>
                        <div class="adm-search-box">
                            <span class="adm-search-ico">🔍</span>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="${msg_admin_reports_searchPlaceholder}">
                        </div>
                    </div>

                    <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_searchButton}</button>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_reports_listTitle}</div>
            <div style="font-size:12px;color:#64748b;">${msg_admin_common_totalCount}</div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th>${msg_admin_common_id}</th>
                    <th>${msg_admin_reports_reportCount}</th>
                    <th>${msg_admin_common_target}</th>
                    <th>${msg_admin_reports_reporter}</th>
                    <th>${msg_admin_common_reason}</th>
                    <th>${msg_admin_reports_reportedAt}</th>
                    <th>${msg_admin_reports_resolvedAt}</th>
                    <th>${msg_admin_common_status}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${reportList}" var="r">
                    <tr class="rpt-admin-row" data-id="${r.reportId}" style="cursor:pointer;"
                        onmouseenter="this.style.background='rgba(255,255,255,.04)'"
                        onmouseleave="this.style.background=''"
                    >
                        <td>#${r.reportId}</td>

                        <%-- 신고수: 3건 이상이면 빨간 강조 --%>
                        <td>
                            <c:choose>
                                <c:when test="${r.targetReportCount >= 3}">
                                    <span style="color:#f87171;font-weight:700;">🔴 ${r.targetReportCount}${msg_admin_common_countSuffix}</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#94a3b8;">${r.targetReportCount}${msg_admin_common_countSuffix}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 대상 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/reports/${r.reportId}?${fn:escapeXml(listParams)}"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <span class="mem-name">
                                <c:choose>
                                    <c:when test="${r.targetType eq 'post'}">
                                        ${msg_admin_reports_target_post}<span class="adm-module-badge adm-module-community">${msg_admin_layout_menu_community}</span>
                                    </c:when>
                                    <c:when test="${r.targetType eq 'comment'}">
                                        ${msg_admin_reports_target_comment}<span class="adm-module-badge adm-module-community">${msg_admin_layout_menu_community}</span>
                                    </c:when>
                                    <c:when test="${r.targetType eq 'review'}">
                                        ${msg_admin_reports_target_review}<span class="adm-module-badge adm-module-explore">${msg_admin_layout_menu_explore}</span>
                                    </c:when>
                                    <c:when test="${r.targetType eq 'user'}">
                                        ${msg_admin_reports_target_user}<span class="adm-module-badge adm-module-user">${msg_admin_common_member}</span>
                                    </c:when>
                                    <c:otherwise>${r.targetType}</c:otherwise>
                                </c:choose>
                                <c:if test="${r.targetStatus eq 'DELETED'}">
                                    <span class="adm-inline-danger" style="margin-left:4px;">
                                        <c:choose>
                                            <c:when test="${r.targetType eq 'review'}">(${msg_admin_reports_targetBlocked})</c:when>
                                            <c:otherwise>(${msg_admin_reports_targetDeleted})</c:otherwise>
                                        </c:choose>
                                    </span>
                                </c:if>
                            </span>
                                <span class="mem-uid">#${r.targetId}</span>
                                <span class="adm-cell-link-note">${msg_admin_common_viewDetail}</span>
                            </a>
                        </td>

                        <%-- 신고자 닉네임 (SYSTEM 봇 user_idx=18 은 AI 자동감지 배지 노출) --%>
                        <td>
                            <c:if test="${r.userIdx == 18}">
                                <div>
                                    <span style="display:inline-block;padding:2px 8px;background:#ede9fe;color:#6d28d9;border-radius:999px;font-size:11px;font-weight:600;margin-bottom:4px;"
                                          title="Perspective API 민감도 분석에 의해 자동 감지된 신고">
                                        🤖 AI 자동감지
                                    </span>
                                </div>
                            </c:if>
                            <button type="button"
                                    class="adm-cell-link js-open-member-context"
                                    data-user-idx="${r.userIdx}"
                                    onclick="event.stopPropagation();">
                                <span style="font-weight:700;color:#93c5fd;">${r.nickname}</span>
                                <span class="adm-cell-link-note">@${r.userId}</span>
                                <c:if test="${r.accountStatus == 'BLOCKED'}">
                                    <span class="adm-cell-link-note" style="color:#fca5a5;">${msg_admin_reports_accountBlocked}</span>
                                </c:if>
                            </button>
                        </td>

                        <%-- 사유 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/reports/${r.reportId}?${fn:escapeXml(listParams)}&jump=report-processing-actions"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <span style="font-size:12px;">
                                    <c:choose>
                                        <c:when test="${r.reason eq 'spam'}">${msg_admin_reports_reason_spam}</c:when>
                                        <c:when test="${r.reason eq 'abuse'}">${msg_admin_reports_reason_abuse}</c:when>
                                        <c:when test="${r.reason eq 'privacy'}">${msg_admin_reports_reason_privacy}</c:when>
                                        <c:when test="${r.reason eq 'adult'}">${msg_admin_reports_reason_adult}</c:when>
                                        <c:when test="${r.reason eq 'illegal'}">${msg_admin_reports_reason_illegal}</c:when>
                                        <c:when test="${r.reason eq 'other'}">${msg_admin_reports_reason_other}</c:when>
                                        <c:when test="${r.reason eq 'user'}">${msg_admin_reports_reason_user}</c:when>
                                        <c:when test="${not empty r.reason}">${r.reason}</c:when>
                                        <c:otherwise><span style="color:#64748b;">—</span></c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-cell-link-note">${msg_admin_common_viewDetail}</span>
                            </a>
                        </td>

                        <%-- 신고일 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/reports/${r.reportId}?${fn:escapeXml(listParams)}"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <span><fmt:formatDate value="${r.createdAtDate}" type="both" dateStyle="short" timeStyle="short"/></span>
                            </a>
                        </td>

                        <%-- 처리일 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/reports/${r.reportId}?${fn:escapeXml(listParams)}&jump=report-processing-actions"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <span>
                                    <c:choose>
                                        <c:when test="${not empty r.resolvedAt}">
                                            <fmt:formatDate value="${r.resolvedAt}" type="both" dateStyle="short" timeStyle="short"/>
                                        </c:when>
                                        <c:otherwise><span style="color:#64748b;">—</span></c:otherwise>
                                    </c:choose>
                                </span>
                            </a>
                        </td>

                        <%-- 상태 배지 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/reports/${r.reportId}?${fn:escapeXml(listParams)}&jump=report-processing-actions"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <span class="status-badge ${r.status}">
                                    <c:choose>
                                        <c:when test="${r.status eq 'IN_REVIEW'}">${msg_admin_reports_status_inReview}</c:when>
                                        <c:when test="${r.status eq 'RESOLVED'}">${msg_admin_reports_status_resolved}</c:when>
                                        <c:when test="${r.status eq 'DISMISSED'}">${msg_admin_reports_status_dismissed}</c:when>
                                        <c:otherwise>${r.status}</c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-cell-link-note">${msg_admin_reports_detail_processingTitle}</span>
                            </a>
                        </td>

                    </tr>
                </c:forEach>
                <c:if test="${empty reportList}">
                    <tr><td colspan="8" style="text-align:center;padding:40px;color:#475569;">${msg_admin_common_noResults}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <%-- 페이지네이션 --%>
        <c:if test="${totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${search.page > 1}">
                    <button class="adm-page-btn" onclick="goPage(${search.page - 1})">‹</button>
                </c:if>
                <c:forEach begin="1" end="${totalPage}" var="p">
                    <button class="adm-page-btn ${p == search.page ? 'active' : ''}" onclick="goPage(${p})">${p}</button>
                </c:forEach>
                <c:if test="${search.page < totalPage}">
                    <button class="adm-page-btn" onclick="goPage(${search.page + 1})">›</button>
                </c:if>
                <span class="adm-page-info">${msg_admin_common_pageStatus}</span>
            </div>
        </c:if>
    </div>

    <%-- ── 유저 화면 바로가기 ── --%>
    <div style="margin-top:16px;padding:0 10px;">
        <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/report/list" target="_blank">
            <span class="adm-nav-icon">↗️</span> ${msg_admin_reports_viewSite}
        </a>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var listParams = 'page=${search.page}&status=${search.status}&targetType=${search.targetType}&reason=${search.reason}&keyword=' + encodeURIComponent('${search.keyword}');
// 행 클릭 시 어드민 신고 상세 페이지 이동
document.querySelectorAll('.rpt-admin-row[data-id]').forEach(function (tr) {
    tr.addEventListener('click', function (e) {
        if (e.target.closest('button, a')) return;
        location.href = ctx + '/admin/reports/' + this.getAttribute('data-id') + '?' + listParams;
    });
});
function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = ctx + '/admin/reports?' + params.toString();
}

function applyReportKeywordFilter(button) {
    var params = new URLSearchParams(window.location.search);
    params.set('keyword', button.dataset.keyword || '');
    params.set('page', '1');
    location.href = ctx + '/admin/reports?' + params.toString();
}
</script>

<%@ include file="../layout-close.jsp" %>
