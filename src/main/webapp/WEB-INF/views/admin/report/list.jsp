<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="reports"/>
<spring:message code="admin.reports.pageTitle" var="adminReportsPageTitle"/>
<spring:message code="admin.common.nickname" var="adminCommonNickname"/>
<spring:message code="admin.common.userId" var="adminCommonUserId"/>
<spring:message code="admin.common.id" var="adminCommonId"/>
<spring:message code="admin.common.accountStatus" var="adminCommonAccountStatus"/>
<spring:message code="admin.common.memberInfoView" var="adminCommonMemberInfoView"/>
<spring:message code="admin.common.blockAccount" var="adminCommonBlockAccount"/>
<spring:message code="admin.common.activeLabel" var="adminCommonActiveLabel"/>
<spring:message code="admin.common.blockedLabel" var="adminCommonBlockedLabel"/>
<spring:message code="admin.reports.authorInfoTitle" var="adminReportsAuthorInfoTitle"/>
<spring:message code="admin.reports.confirmBlockUser" var="adminReportsConfirmBlockUser"/>
<spring:message code="admin.reports.blockFailed" var="adminReportsBlockFailed"/>
<c:set var="pageTitle" value="${adminReportsPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.reports.kpi.total"/></div>
            <div class="adm-summary-value is-primary">${stats.totalReports}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.reports.status.inReview"/></div>
            <div class="adm-summary-value is-warning">${stats.inReviewReports}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.reports.status.resolved"/></div>
            <div class="adm-summary-value is-success">${stats.resolvedReports}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.reports.status.dismissed"/></div>
            <div class="adm-summary-value is-accent">${stats.dismissedReports}</div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/reports">
                <div class="adm-filter-bar">

                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.common.status"/></div>
                        <select class="adm-select" name="status">
                            <option value=""           ${empty search.status         ? 'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="IN_REVIEW"  ${search.status=='IN_REVIEW'  ? 'selected':''}><spring:message code="admin.reports.status.inReview"/></option>
                            <option value="RESOLVED"   ${search.status=='RESOLVED'   ? 'selected':''}><spring:message code="admin.reports.status.resolved"/></option>
                            <option value="DISMISSED"  ${search.status=='DISMISSED'  ? 'selected':''}><spring:message code="admin.reports.status.dismissed"/></option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.reports.targetType"/></div>
                        <select class="adm-select" name="targetType">
                            <option value=""        ${empty search.targetType      ? 'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="post"    ${search.targetType=='post'    ? 'selected':''}><spring:message code="admin.reports.target.post"/></option>
                            <option value="comment" ${search.targetType=='comment' ? 'selected':''}><spring:message code="admin.reports.target.comment"/></option>
                            <option value="review"  ${search.targetType=='review'  ? 'selected':''}><spring:message code="admin.reports.target.review"/></option>
                            <option value="user"    ${search.targetType=='user'    ? 'selected':''}><spring:message code="admin.reports.target.user"/></option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.common.reason"/></div>
                        <select class="adm-select" name="reason">
                            <option value=""        ${empty search.reason          ? 'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="spam"    ${search.reason=='spam'    ? 'selected':''}><spring:message code="admin.reports.reason.spam"/></option>
                            <option value="abuse"   ${search.reason=='abuse'   ? 'selected':''}><spring:message code="admin.reports.reason.abuse"/></option>
                            <option value="privacy" ${search.reason=='privacy' ? 'selected':''}><spring:message code="admin.reports.reason.privacy"/></option>
                            <option value="adult"   ${search.reason=='adult'   ? 'selected':''}><spring:message code="admin.reports.reason.adult"/></option>
                            <option value="illegal" ${search.reason=='illegal' ? 'selected':''}><spring:message code="admin.reports.reason.illegal"/></option>
                            <option value="user"    ${search.reason=='user'    ? 'selected':''}><spring:message code="admin.reports.reason.user"/></option>
                            <option value="other"   ${search.reason=='other'   ? 'selected':''}><spring:message code="admin.reports.reason.other"/></option>
                        </select>
                    </div>

                    <div style="flex:1;min-width:200px;">
                        <div class="adm-filter-label"><spring:message code="admin.reports.searchLabel"/></div>
                        <div class="adm-search-box">
                            <span class="adm-search-ico">🔍</span>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="<spring:message code='admin.reports.searchPlaceholder'/>">
                        </div>
                    </div>

                    <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.reports.listTitle"/></div>
            <div style="font-size:12px;color:#64748b;"><spring:message code="admin.common.totalCount" arguments="${totalCount}"/></div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th>${adminCommonId}</th>
                    <th><spring:message code="admin.reports.reportCount"/></th>
                    <th><spring:message code="admin.common.target"/></th>
                    <th><spring:message code="admin.reports.reporter"/></th>
                    <th><spring:message code="admin.common.reason"/></th>
                    <th><spring:message code="admin.reports.reportedAt"/></th>
                    <th><spring:message code="admin.reports.resolvedAt"/></th>
                    <th><spring:message code="admin.common.status"/></th>
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
                                    <span style="color:#f87171;font-weight:700;">🔴 ${r.targetReportCount}<spring:message code="admin.common.countSuffix"/></span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#94a3b8;">${r.targetReportCount}<spring:message code="admin.common.countSuffix"/></span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 대상 --%>
                        <td>
                            <div class="mem-name">
                                <c:choose>
                                    <c:when test="${r.targetType eq 'post'}">
                                        <spring:message code="admin.reports.target.post"/><span class="adm-module-badge adm-module-community"><spring:message code="admin.layout.menu.community"/></span>
                                    </c:when>
                                    <c:when test="${r.targetType eq 'comment'}">
                                        <spring:message code="admin.reports.target.comment"/><span class="adm-module-badge adm-module-community"><spring:message code="admin.layout.menu.community"/></span>
                                    </c:when>
                                    <c:when test="${r.targetType eq 'review'}">
                                        <spring:message code="admin.reports.target.review"/><span class="adm-module-badge adm-module-explore"><spring:message code="admin.layout.menu.explore"/></span>
                                    </c:when>
                                    <c:when test="${r.targetType eq 'user'}">
                                        <spring:message code="admin.reports.target.user"/><span class="adm-module-badge adm-module-user"><spring:message code="admin.common.member"/></span>
                                    </c:when>
                                    <c:otherwise>${r.targetType}</c:otherwise>
                                </c:choose>
                                <c:if test="${r.targetStatus eq 'DELETED'}">
                                    <span class="adm-inline-danger" style="margin-left:4px;">
                                        <c:choose>
                                            <c:when test="${r.targetType eq 'review'}">(<spring:message code="admin.reports.targetBlocked"/>)</c:when>
                                            <c:otherwise>(<spring:message code="admin.reports.targetDeleted"/>)</c:otherwise>
                                        </c:choose>
                                    </span>
                                </c:if>
                            </div>
                            <div class="mem-uid">#${r.targetId}</div>
                        </td>

                        <%-- 신고자 닉네임 --%>
                        <td style="cursor:pointer;"
                            data-useridx="${r.userIdx}"
                            data-userid="${r.userId}"
                            data-nickname="${r.nickname}"
                            data-status="${r.accountStatus}"
                            data-userrole="${r.userRole}"
                            onclick="openAuthorModal(this)">
                            <div class="adm-modal-nickname">${r.nickname}</div>
                            <div class="adm-modal-value">${r.userId}</div>
                            <c:if test="${r.accountStatus == 'BLOCKED'}">
                                <span class="adm-inline-danger"><spring:message code="admin.reports.accountBlocked"/></span>
                            </c:if>
                        </td>

                        <%-- 사유 --%>
                        <td>
                            <span style="font-size:12px;">
                                <c:choose>
                                    <c:when test="${r.reason eq 'spam'}"><spring:message code="admin.reports.reason.spam"/></c:when>
                                    <c:when test="${r.reason eq 'abuse'}"><spring:message code="admin.reports.reason.abuse"/></c:when>
                                    <c:when test="${r.reason eq 'privacy'}"><spring:message code="admin.reports.reason.privacy"/></c:when>
                                    <c:when test="${r.reason eq 'adult'}"><spring:message code="admin.reports.reason.adult"/></c:when>
                                    <c:when test="${r.reason eq 'illegal'}"><spring:message code="admin.reports.reason.illegal"/></c:when>
                                    <c:when test="${r.reason eq 'other'}"><spring:message code="admin.reports.reason.other"/></c:when>
                                    <c:when test="${r.reason eq 'user'}"><spring:message code="admin.reports.reason.user"/></c:when>
                                    <c:when test="${not empty r.reason}">${r.reason}</c:when>
                                    <c:otherwise><span style="color:#64748b;">—</span></c:otherwise>
                                </c:choose>
                            </span>
                        </td>

                        <%-- 신고일 --%>
                        <td>
                            <fmt:formatDate value="${r.createdAt}" type="both" dateStyle="short" timeStyle="short"/>
                        </td>

                        <%-- 처리일 --%>
                        <td>
                            <c:choose>
                                <c:when test="${not empty r.resolvedAt}">
                                    <fmt:formatDate value="${r.resolvedAt}" type="both" dateStyle="short" timeStyle="short"/>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">—</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 상태 배지 --%>
                        <td>
                            <span class="status-badge ${r.status}">
                                <c:choose>
                                    <c:when test="${r.status eq 'IN_REVIEW'}"><spring:message code="admin.reports.status.inReview"/></c:when>
                                    <c:when test="${r.status eq 'RESOLVED'}"><spring:message code="admin.reports.status.resolved"/></c:when>
                                    <c:when test="${r.status eq 'DISMISSED'}"><spring:message code="admin.reports.status.dismissed"/></c:when>
                                    <c:otherwise>${r.status}</c:otherwise>
                                </c:choose>
                            </span>
                        </td>

                    </tr>
                </c:forEach>
                <c:if test="${empty reportList}">
                    <tr><td colspan="8" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.common.noResults"/></td></tr>
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
                <span class="adm-page-info"><spring:message code="admin.common.pageStatus" arguments="${search.page},${totalPage}"/></span>
            </div>
        </c:if>
    </div>

    <%-- ── 유저 화면 바로가기 ── --%>
    <div style="margin-top:16px;padding:0 10px;">
        <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/report/list" target="_blank">
            <span class="adm-nav-icon">↗️</span> <spring:message code="admin.reports.viewSite"/>
        </a>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var listParams = 'page=${search.page}&status=${search.status}&targetType=${search.targetType}&reason=${search.reason}&keyword=' + encodeURIComponent('${search.keyword}');
var REPORT_AUTHOR_MSG = {
    blocked: '${fn:escapeXml(adminCommonBlockedLabel)}',
    active: '${fn:escapeXml(adminCommonActiveLabel)}',
    nickname: '${fn:escapeXml(adminCommonNickname)}',
    userId: '${fn:escapeXml(adminCommonUserId)}',
    accountStatus: '${fn:escapeXml(adminCommonAccountStatus)}',
    memberInfoView: '${fn:escapeXml(adminCommonMemberInfoView)}',
    blockAccount: '${fn:escapeXml(adminCommonBlockAccount)}',
    confirmBlock: '${fn:escapeXml(adminReportsConfirmBlockUser)}',
    blockFailed: '${fn:escapeXml(adminReportsBlockFailed)}',
    title: '${fn:escapeXml(adminReportsAuthorInfoTitle)}'
};

// 행 클릭 시 어드민 신고 상세 페이지 이동
document.querySelectorAll('.rpt-admin-row[data-id]').forEach(function (tr) {
    tr.addEventListener('click', function (e) {
        if (e.target.closest('td[data-useridx]')) return;
        location.href = ctx + '/admin/reports/' + this.getAttribute('data-id') + '?' + listParams;
    });
});

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = ctx + '/admin/reports?' + params.toString();
}

// ── 신고자 모달 ──
function openAuthorModal(el) {
    var userIdx  = el.getAttribute('data-useridx');
    var userId   = el.getAttribute('data-userid');
    var nickname = el.getAttribute('data-nickname');
    var status   = el.getAttribute('data-status');
    var userRole = el.getAttribute('data-userrole');

    var statusBadge = status === 'BLOCKED'
        ? '<span class="status-badge BLOCKED" style="font-size:12px;">' + escHtml(REPORT_AUTHOR_MSG.blocked) + '</span>'
        : '<span class="status-badge ACTIVE"  style="font-size:12px;">' + escHtml(REPORT_AUTHOR_MSG.active) + '</span>';

    var blockBtn = (status !== 'BLOCKED' && userRole !== 'SYSTEM')
        ? '<button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;width:100%;" data-idx="' + userIdx + '" onclick="blockUserFromModal(this)">' + escHtml(REPORT_AUTHOR_MSG.blockAccount) + '</button>'
        : '';

    document.getElementById('authorModalBody').innerHTML =
        '<div class="adm-modal-stack">'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + escHtml(REPORT_AUTHOR_MSG.nickname) + '</span>'
      + '    <span class="adm-modal-nickname">' + escHtml(nickname) + '</span>'
      + '  </div>'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + escHtml(REPORT_AUTHOR_MSG.userId) + '</span>'
      + '    <span class="adm-modal-value">' + escHtml(userId) + '</span>'
      + '  </div>'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + escHtml(REPORT_AUTHOR_MSG.accountStatus) + '</span>'
      + '    ' + statusBadge
      + '  </div>'
      + '</div>'
      + '<div class="adm-action-stack">'
      + '  <a href="' + ctx + '/admin/members?searchType=userId&keyword=' + encodeURIComponent(userId) + '" class="adm-btn adm-btn-ghost adm-link-button">' + escHtml(REPORT_AUTHOR_MSG.memberInfoView) + '</a>'
      + blockBtn
      + '</div>';

    document.querySelector('#authorModal .adm-modal-title').textContent = REPORT_AUTHOR_MSG.title;
    document.getElementById('authorModal').style.display = 'flex';
}

function closeAuthorModal() {
    document.getElementById('authorModal').style.display = 'none';
}

function blockUserFromModal(btn) {
    var userIdx = btn.getAttribute('data-idx');
    if (!confirm(REPORT_AUTHOR_MSG.confirmBlock)) return;
    fetch(ctx + '/admin/community/users/' + userIdx + '/block', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || REPORT_AUTHOR_MSG.blockFailed); }
    });
}

function escHtml(str) {
    if (!str) return '';
    return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}
</script>

<%-- ── 신고자 정보 모달 ── --%>
<div id="authorModal" class="adm-modal-overlay" style="display:none;"
     onclick="if(event.target===this)closeAuthorModal()">
    <div class="adm-modal" style="width:360px;">
        <div class="adm-modal-head">
            <span class="adm-modal-title">${adminReportsAuthorInfoTitle}</span>
            <button class="adm-modal-close" onclick="closeAuthorModal()">✕</button>
        </div>
        <div class="adm-modal-body" id="authorModalBody"></div>
    </div>
</div>

<%@ include file="../layout-close.jsp" %>
