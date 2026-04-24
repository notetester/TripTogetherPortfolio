<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="community"/>
<spring:message code="admin.community.pageTitle" var="adminCommunityPageTitle"/>
<spring:message code="admin.common.nickname" var="adminCommonNickname"/>
<spring:message code="admin.common.userId" var="adminCommonUserId"/>
<spring:message code="admin.common.accountStatus" var="adminCommonAccountStatus"/>
<spring:message code="admin.common.memberInfoView" var="adminCommonMemberInfoView"/>
<spring:message code="admin.common.blockAccount" var="adminCommonBlockAccount"/>
<spring:message code="admin.common.activeLabel" var="adminCommonActiveLabel"/>
<spring:message code="admin.common.blockedLabel" var="adminCommonBlockedLabel"/>
<spring:message code="admin.community.authorModal.title" var="adminCommunityAuthorModalTitle"/>
<spring:message code="admin.community.confirmBlockUser" var="adminCommunityConfirmBlockUser"/>
<spring:message code="admin.community.message.actionFailed" var="adminCommunityActionFailed"/>
<spring:message code="admin.community.message.noSelection" var="adminCommunityNoSelection"/>
<spring:message code="admin.community.confirm.postAction" var="adminCommunityConfirmPostAction"/>
<spring:message code="admin.community.confirm.bulkAction" var="adminCommunityConfirmBulkAction"/>
<spring:message code="admin.community.bulk.selectedCount" var="adminCommunitySelectedCount"/>
<spring:message code="admin.community.authorModal.recentResolved" var="adminCommunityRecentResolved"/>
<c:set var="pageTitle" value="${adminCommunityPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 탭 바 ── --%>
    <div class="adm-tabs adm-admin-tabs">
        <a class="adm-tab adm-tab-link active" href="${pageContext.request.contextPath}/admin/community">📝 <spring:message code="admin.community.tab.posts"/></a>
        <a class="adm-tab adm-tab-link" href="${pageContext.request.contextPath}/admin/community/comments">💬 <spring:message code="admin.community.tab.comments"/></a>
    </div>

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.community.kpi.activePosts"/></div>
            <div class="adm-summary-value is-primary">${stats.activePosts}</div>
            <div class="adm-summary-sub"><spring:message code="admin.community.kpi.totalPosts" arguments="${stats.totalPosts}"/></div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.community.kpi.blockedPosts"/></div>
            <div class="adm-summary-value is-danger">${stats.blockedPosts}</div>
            <div class="adm-summary-sub"><spring:message code="admin.community.kpi.deletedPosts" arguments="${stats.deletedPosts}"/></div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.community.kpi.activeComments"/></div>
            <div class="adm-summary-value is-success">${stats.activeComments}</div>
            <div class="adm-summary-sub"><spring:message code="admin.community.kpi.blockedComments" arguments="${stats.blockedComments}"/></div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.community.kpi.pendingReports"/></div>
            <div class="adm-summary-value is-warning">${stats.pendingReports}</div>
            <div class="adm-summary-sub"><spring:message code="admin.community.kpi.resolvedReports30d" arguments="${stats.resolvedReports30d}"/></div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/community" id="searchForm">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.community.filter.status"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ?'selected':''}><spring:message code="admin.community.status.active"/></option>
                            <option value="BLOCKED" ${search.status=='BLOCKED' ?'selected':''}><spring:message code="admin.community.status.blocked"/></option>
                            <option value="DELETED" ${search.status=='DELETED' ?'selected':''}><spring:message code="admin.community.status.deleted"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.community.filter.type"/></div>
                        <select class="adm-select" name="postType">
                            <option value="ALL"      ${search.postType=='ALL'      ?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="review"   ${search.postType=='review'   ?'selected':''}><spring:message code="admin.community.postType.review"/></option>
                            <option value="photo"    ${search.postType=='photo'    ?'selected':''}><spring:message code="admin.community.postType.photo"/></option>
                            <option value="tip"      ${search.postType=='tip'      ?'selected':''}><spring:message code="admin.community.postType.tip"/></option>
                            <option value="question" ${search.postType=='question' ?'selected':''}><spring:message code="admin.community.postType.question"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.community.filter.sort"/></div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt"   ${search.sortBy=='createdAt'   ?'selected':''}><spring:message code="admin.community.sort.createdAt"/></option>
                            <option value="reportCount" ${search.sortBy=='reportCount' ?'selected':''}><spring:message code="admin.community.sort.reportCount"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.community.filter.flagged"/></div>
                        <select class="adm-select" name="flagged">
                            <option value="ALL"     ${search.flagged=='ALL'     ?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="FLAGGED" ${search.flagged=='FLAGGED' ?'selected':''}><spring:message code="admin.community.flagged.flagged"/></option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:200px;">
                        <div class="adm-filter-label"><spring:message code="admin.common.search"/></div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:110px;">
                                <option value="all"      ${search.searchType=='all'      ?'selected':''}><spring:message code="admin.common.all"/></option>
                                <option value="title"    ${search.searchType=='title'    ?'selected':''}><spring:message code="admin.community.searchType.title"/></option>
                                <option value="content"  ${search.searchType=='content'  ?'selected':''}><spring:message code="admin.community.searchType.content"/></option>
                                <option value="nickname" ${search.searchType=='nickname' ?'selected':''}><spring:message code="admin.community.searchType.nickname"/></option>
                                <option value="userId"   ${search.searchType=='userId'   ?'selected':''}><spring:message code="admin.community.searchType.userId"/></option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}"
                                   placeholder="<spring:message code='admin.community.filter.searchPlaceholder'/>" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/community"><spring:message code="admin.common.reset"/></a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title"><spring:message code="admin.community.list.postsTitle"/></div>
                <div class="adm-muted-note"><spring:message code="admin.common.totalCount" arguments="${total}"/></div>
            </div>
            <%-- 일괄 처리 버튼 --%>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" style="font-size:12px;color:#94a3b8;"></span>
                <button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;"
                        onclick="bulkAction('block')"><spring:message code="admin.community.action.bulkBlock"/></button>
                <button class="adm-btn adm-btn-ghost" style="color:#64748b;"
                        onclick="bulkAction('delete')"><spring:message code="admin.community.action.bulkDelete"/></button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:60px;"><spring:message code="admin.community.column.id"/></th>
                    <th><spring:message code="admin.community.column.author"/></th>
                    <th><spring:message code="admin.community.column.ip"/></th>
                    <th><spring:message code="admin.community.column.title"/></th>
                    <th style="width:80px;"><spring:message code="admin.community.column.type"/></th>
                    <th style="width:60px;"><spring:message code="admin.community.column.reportCount"/></th>
                    <th style="width:80px;"><spring:message code="admin.common.status"/></th>
                    <th style="width:90px;"><spring:message code="admin.community.column.createdAt"/></th>
                    <th style="width:100px;"><spring:message code="admin.common.action"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="p">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${p.postId}"></td>
                        <td style="color:#64748b;font-size:12px;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/community/posts/${p.postId}">#${p.postId}</a>
                        </td>

                        <%-- 작성자 --%>
                        <td style="cursor:pointer;"
                            data-useridx="${p.userIdx}"
                            data-userid="${p.userId}"
                            data-nickname="${p.nickname}"
                            data-ip="${p.lastIp}"
                            data-status="${p.accountStatus}"
                            data-resolve="${p.authorResolveCount30d}"
                            onclick="openAuthorModal(this)">
                            <div style="font-weight:600;font-size:13px;color:#7dd3fc;">${p.nickname}</div>
                            <div style="font-size:11px;color:#64748b;">${p.userId}</div>
                            <c:if test="${p.accountStatus == 'BLOCKED'}">
                                <span class="adm-inline-danger"><spring:message code="admin.community.accountBlocked"/></span>
                            </c:if>
                        </td>

                        <%-- IP --%>
                        <td style="font-size:11px;color:#94a3b8;font-family:monospace;">
                            <c:choose>
                                <c:when test="${not empty p.lastIp}">
                                    <button type="button"
                                            class="adm-inline-link js-open-ip-context"
                                            data-ip-address="${p.lastIp}"
                                            data-default-tab="blocks"
                                            onclick="event.stopPropagation();">${p.lastIp}</button>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">—</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 제목 + 30일 배지 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/community/posts/${p.postId}"
                               class="adm-link-title"
                               title="${p.title}">
                                    <c:choose>
                                    <c:when test="${fn:length(p.title) > 30}">${fn:substring(p.title, 0, 30)}…</c:when>
                                    <c:otherwise>${p.title}</c:otherwise>
                                </c:choose>
                            </a>
                            <c:if test="${p.authorResolveCount30d > 0}">
                                <span class="adm-inline-warning">
                                    ⚠ <spring:message code="admin.community.rowResolved30d" arguments="${p.authorResolveCount30d}"/>
                                </span>
                            </c:if>
                        </td>

                        <%-- 유형 --%>
                        <td style="font-size:12px;color:#94a3b8;">
                            <button type="button" class="adm-cell-link" data-param-name="postType" data-param-value="${p.postType}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${p.postType == 'review'}"><spring:message code="admin.community.postType.review"/></c:when>
                                    <c:when test="${p.postType == 'photo'}"><spring:message code="admin.community.postType.photo"/></c:when>
                                    <c:when test="${p.postType == 'tip'}"><spring:message code="admin.community.postType.tip"/></c:when>
                                    <c:when test="${p.postType == 'question'}"><spring:message code="admin.community.postType.question"/></c:when>
                                    <c:otherwise>${p.postType}</c:otherwise>
                                </c:choose></span>
                                <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
                            </button>
                        </td>

                        <%-- 신고 수 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/reports?targetType=post&keyword=${p.postId}"
                               class="adm-cell-link adm-cell-link--inline"
                               onclick="event.stopPropagation();">
                                <c:choose>
                                    <c:when test="${p.reportCount >= 3}">
                                        <span style="color:#f87171;font-weight:700;">🔴 ${p.reportCount}</span>
                                    </c:when>
                                    <c:when test="${p.reportCount > 0}">
                                        <span style="color:#fbbf24;">${p.reportCount}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color:#475569;">0</span>
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </td>

                        <%-- 상태 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/community/posts/${p.postId}"
                               class="adm-cell-link adm-cell-link--inline status-badge ${p.postStatus}">
                                <c:choose>
                                    <c:when test="${p.postStatus == 'ACTIVE'}"><spring:message code="admin.community.status.active"/></c:when>
                                    <c:when test="${p.postStatus == 'BLOCKED'}"><spring:message code="admin.community.status.blocked"/></c:when>
                                    <c:when test="${p.postStatus == 'DELETED'}"><spring:message code="admin.community.status.deleted"/></c:when>
                                    <c:otherwise>${p.postStatus}</c:otherwise>
                                </c:choose>
                            </a>
                        </td>

                        <%-- 등록일 --%>
                        <td style="font-size:11px;color:#64748b;">
                            <a href="${pageContext.request.contextPath}/admin/community/posts/${p.postId}"
                               class="adm-cell-link adm-cell-link--inline">
                            <fmt:formatDate value="${p.createdAt}" pattern="yyyy.MM.dd"/>
                            <div><fmt:formatDate value="${p.createdAt}" pattern="HH:mm"/></div>
                            </a>
                        </td>

                        <%-- 액션 --%>
                        <td>
                            <c:choose>
                                <c:when test="${p.postStatus != 'BLOCKED'}">
                                    <div class="adm-row-actions">
                                        <button class="adm-row-btn danger"
                                                type="button"
                                                data-id="${p.postId}"
                                                onclick="actionPost(this.getAttribute('data-id'), 'block')"><spring:message code="admin.community.action.block"/></button>
                                        <c:if test="${p.postStatus != 'DELETED'}">
                                            <div class="action-menu-wrap">
                                                <button class="adm-row-btn detail adm-row-btn-more"
                                                        type="button"
                                                        onclick="admToggleActionMenu(this)">⋯</button>
                                                <div class="action-menu">
                                                    <button class="action-menu-item danger"
                                                            type="button"
                                                            data-id="${p.postId}"
                                                            onclick="actionPost(this.getAttribute('data-id'), 'delete')"><spring:message code="admin.community.action.delete"/></button>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:when>
                                <c:when test="${p.postStatus != 'DELETED'}">
                                    <div class="adm-row-actions is-single">
                                        <button class="adm-row-btn danger"
                                                type="button"
                                                data-id="${p.postId}"
                                                onclick="actionPost(this.getAttribute('data-id'), 'delete')"><spring:message code="admin.community.action.delete"/></button>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <span class="adm-muted-inline">-</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="10" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.common.noResults"/></td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <%-- 페이지네이션 --%>
        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}">
                    <button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button>
                </c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pg">
                    <button class="adm-page-btn ${pg == paging.currentPage ? 'active' : ''}" onclick="goPage(${pg})">${pg}</button>
                </c:forEach>
                <c:if test="${paging.next}">
                    <button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button>
                </c:if>
                <span class="adm-page-info"><spring:message code="admin.common.pageStatus" arguments="${paging.currentPage},${paging.totalPage}"/></span>
            </div>
        </c:if>
    </div>

    <%-- ── 유저 화면 바로가기 ── --%>
    <div style="margin-top:16px;padding:0 10px;">
        <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/community/list" target="_blank">
            <span class="adm-nav-icon">↗️</span> <spring:message code="admin.community.viewSite"/>
        </a>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var COMMUNITY_POST_MSG = {
    noSelection: '${fn:escapeXml(adminCommunityNoSelection)}',
    actionFailed: '${fn:escapeXml(adminCommunityActionFailed)}',
    confirmPostAction: '<spring:message code="admin.community.confirm.postAction" arguments="__id__,__action__" javaScriptEscape="true"/>',
    confirmBulkAction: '<spring:message code="admin.community.confirm.bulkAction" arguments="__count__,__action__" javaScriptEscape="true"/>',
    selectedCount: '<spring:message code="admin.community.bulk.selectedCount" arguments="__count__" javaScriptEscape="true"/>',
    block: '<spring:message code="admin.community.action.block" javaScriptEscape="true"/>',
    delete: '<spring:message code="admin.community.action.delete" javaScriptEscape="true"/>',
    blocked: '${fn:escapeXml(adminCommonBlockedLabel)}',
    active: '${fn:escapeXml(adminCommonActiveLabel)}',
    nickname: '${fn:escapeXml(adminCommonNickname)}',
    userId: '${fn:escapeXml(adminCommonUserId)}',
    accountStatus: '${fn:escapeXml(adminCommonAccountStatus)}',
    lastIp: '<spring:message code="admin.community.label.lastIp" javaScriptEscape="true"/>',
    memberInfoView: '${fn:escapeXml(adminCommonMemberInfoView)}',
    blockAccount: '${fn:escapeXml(adminCommonBlockAccount)}',
    confirmBlock: '${fn:escapeXml(adminCommunityConfirmBlockUser)}',
    recentResolved: '<spring:message code="admin.community.authorModal.recentResolved" arguments="__count__" javaScriptEscape="true"/>',
    modalTitle: '${fn:escapeXml(adminCommunityAuthorModalTitle)}'
};

// ── 전체 선택 ──
document.getElementById('checkAll').addEventListener('change', function () {
    document.querySelectorAll('.row-check').forEach(function (cb) { cb.checked = this.checked; }, this);
    updateBulkBar();
});
document.querySelectorAll('.row-check').forEach(function (cb) {
    cb.addEventListener('change', updateBulkBar);
});

function updateBulkBar() {
    var checked = document.querySelectorAll('.row-check:checked');
    var bar = document.getElementById('bulkBar');
    if (checked.length > 0) {
        bar.style.display = 'flex';
        document.getElementById('bulkCount').textContent = COMMUNITY_POST_MSG.selectedCount.replace('__count__', checked.length);
    } else {
        bar.style.display = 'none';
    }
}

// ── 단건 액션 ──
function actionPost(postId, action) {
    var label = action === 'block' ? COMMUNITY_POST_MSG.block : COMMUNITY_POST_MSG.delete;
    var message = COMMUNITY_POST_MSG.confirmPostAction
        .replace('__id__', postId)
        .replace('__action__', label);
    if (!confirm(message)) return;
    fetch(ctx + '/admin/community/posts/' + postId + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COMMUNITY_POST_MSG.actionFailed); }
    });
}

// ── 일괄 처리 ──
function bulkAction(action) {
    var ids = Array.from(document.querySelectorAll('.row-check:checked'))
                   .map(function (cb) { return cb.getAttribute('data-id'); });
    if (ids.length === 0) { alert(COMMUNITY_POST_MSG.noSelection); return; }
    var label = action === 'block' ? COMMUNITY_POST_MSG.block : COMMUNITY_POST_MSG.delete;
    var message = COMMUNITY_POST_MSG.confirmBulkAction
        .replace('__count__', ids.length)
        .replace('__action__', label);
    if (!confirm(message)) return;

    var body = 'action=' + action + '&' + ids.map(function (id) { return 'ids=' + id; }).join('&');
    fetch(ctx + '/admin/community/posts/bulk-action', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: body
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COMMUNITY_POST_MSG.actionFailed); }
    });
}

function applySelectFilter(button) {
    var paramName = button.getAttribute('data-param-name');
    var paramValue = button.getAttribute('data-param-value');
    if (!paramName || !paramValue) return;
    var params = new URLSearchParams(window.location.search);
    params.set(paramName, paramValue);
    params.set('page', '1');
    location.href = ctx + '/admin/community?' + params.toString();
}

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = ctx + '/admin/community?' + params.toString();
}

// ── 작성자 모달 ──
function openAuthorModal(el) {
    var userIdx  = el.getAttribute('data-useridx');
    var userId   = el.getAttribute('data-userid');
    var nickname = el.getAttribute('data-nickname');
    var ip       = el.getAttribute('data-ip');
    var status   = el.getAttribute('data-status');
    var resolve  = parseInt(el.getAttribute('data-resolve') || '0', 10);

    var statusBadge = status === 'BLOCKED'
        ? '<span class="status-badge BLOCKED" style="font-size:12px;">' + COMMUNITY_POST_MSG.blocked + '</span>'
        : '<span class="status-badge ACTIVE"  style="font-size:12px;">' + COMMUNITY_POST_MSG.active + '</span>';

    var warnBox = resolve > 0
        ? '<div class="adm-warning-box">⚠ ' + COMMUNITY_POST_MSG.recentResolved.replace('__count__', resolve) + '</div>'
        : '';

    var blockBtn = status !== 'BLOCKED'
        ? '<button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;width:100%;margin-top:4px;" data-idx="' + userIdx + '" onclick="blockUserFromModal(this)">' + COMMUNITY_POST_MSG.blockAccount + '</button>'
        : '';

    document.getElementById('authorModalBody').innerHTML =
        '<div class="adm-modal-stack">'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + COMMUNITY_POST_MSG.nickname + '</span>'
      + '    <span class="adm-modal-nickname">' + escHtml(nickname) + '</span>'
      + '  </div>'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + COMMUNITY_POST_MSG.userId + '</span>'
      + '    <span class="adm-modal-value">' + escHtml(userId) + '</span>'
      + '  </div>'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + COMMUNITY_POST_MSG.lastIp + '</span>'
      + '    <span class="adm-modal-value adm-mono-text">' + escHtml(ip || '—') + '</span>'
      + '  </div>'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + COMMUNITY_POST_MSG.accountStatus + '</span>'
      + '    ' + statusBadge
      + '  </div>'
      + '</div>'
      + warnBox
      + '<div class="adm-action-stack">'
      + '  <a href="' + ctx + '/admin/members?searchType=userId&keyword=' + encodeURIComponent(userId) + '" class="adm-btn adm-btn-ghost adm-link-button">' + COMMUNITY_POST_MSG.memberInfoView + '</a>'
      + blockBtn
      + '</div>';

    document.getElementById('authorModal').style.display = 'flex';
}

function closeAuthorModal() {
    document.getElementById('authorModal').style.display = 'none';
}

function blockUserFromModal(btn) {
    var userIdx = btn.getAttribute('data-idx');
    if (!confirm(COMMUNITY_POST_MSG.confirmBlock)) return;
    fetch(ctx + '/admin/community/users/' + userIdx + '/block', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COMMUNITY_POST_MSG.actionFailed); }
    });
}

function escHtml(str) {
    if (!str) return '';
    return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}
</script>

<%-- ── 작성자 정보 모달 ── --%>
    <div id="authorModal" class="adm-modal-overlay" style="display:none;"
     onclick="if(event.target===this)closeAuthorModal()">
    <div class="adm-modal" style="width:360px;">
        <div class="adm-modal-head">
            <span class="adm-modal-title">${adminCommunityAuthorModalTitle}</span>
            <button class="adm-modal-close" onclick="closeAuthorModal()">✕</button>
        </div>
        <div class="adm-modal-body" id="authorModalBody"></div>
    </div>
</div>

<%@ include file="../layout-close.jsp" %>


<script>
/* ── 공통 운영 탭: 헤더 클릭 정렬 + 체크박스 + CSV/Excel 내보내기 ── */
(function enhanceGenericAdminOperationTables() {
    const tables = Array.from(document.querySelectorAll('.adm-table'));
    if (!tables.length) return;

    function cleanText(el) {
        return (el && el.innerText ? el.innerText : '').replace(/[↕▲▼]/g, '').replace(/\s+/g, ' ').trim();
    }
    function rowsOf(table) {
        return Array.from(table.querySelectorAll('tbody tr')).filter(function (row) {
            return row.querySelector('.js-op-row-check');
        });
    }
    function selectedRowsOf(table) {
        return rowsOf(table).filter(function (row) {
            const cb = row.querySelector('.js-op-row-check');
            return cb && cb.checked;
        });
    }
    function csvEscape(value) {
        const s = String(value == null ? '' : value);
        return '"' + s.replace(/"/g, '""') + '"';
    }
    function download(content, filename, type) {
        const blob = new Blob([content], {type: type});
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = filename;
        document.body.appendChild(a);
        a.click();
        a.remove();
        setTimeout(function () { URL.revokeObjectURL(url); }, 1000);
    }
    function updateSelectionUi(table) {
        const wrap = table.closest('.adm-table-wrap') || table.parentElement;
        const selected = selectedRowsOf(table).length;
        const selectedBtn = wrap.parentElement.querySelector('.js-op-export-selected');
        const clearBtn = wrap.parentElement.querySelector('.js-op-clear-selection');
        const all = table.querySelector('.js-op-check-all');
        if (selectedBtn) {
            selectedBtn.disabled = selected === 0;
            selectedBtn.textContent = '선택 내보내기 (' + selected + ')';
        }
        if (clearBtn) clearBtn.style.display = selected > 0 ? '' : 'none';
        if (all) {
            const rows = rowsOf(table);
            all.checked = rows.length > 0 && selected === rows.length;
            all.indeterminate = selected > 0 && selected < rows.length;
        }
    }
    function exportTable(table, scope) {
        let exportRows = scope === 'selected' ? selectedRowsOf(table) : rowsOf(table);
        if (scope === 'selected' && exportRows.length === 0) {
            if (typeof adm_toast === 'function') adm_toast('선택된 항목이 없습니다.', 'error');
            else alert('선택된 항목이 없습니다.');
            return;
        }
        const wrap = table.closest('.adm-table-wrap') || table.parentElement;
        const formatSelect = wrap.parentElement.querySelector('.js-op-export-format');
        const format = formatSelect ? formatSelect.value : 'csv';
        const headers = Array.from(table.querySelectorAll('thead th'))
            .filter(function (_, idx, arr) { return idx !== 0 && idx !== arr.length - 1; })
            .map(cleanText);
        const body = exportRows.map(function (row) {
            return Array.from(row.children)
                .filter(function (_, idx, arr) { return idx !== 0 && idx !== arr.length - 1; })
                .map(cleanText);
        });
        const base = (document.title || 'admin_operation').replace(/[\\/:*?"<>|]+/g, '_') + '_' + scope + '_' + new Date().toISOString().slice(0, 10);
        if (format === 'excel') {
            const html = '<table><thead><tr>' + headers.map(h => '<th>' + h + '</th>').join('') + '</tr></thead><tbody>'
                + body.map(row => '<tr>' + row.map(v => '<td>' + v + '</td>').join('') + '</tr>').join('')
                + '</tbody></table>';
            download('\ufeff' + html, base + '.xls', 'application/vnd.ms-excel;charset=utf-8');
        } else {
            const csv = [headers].concat(body).map(row => row.map(csvEscape).join(',')).join('\n');
            download('\ufeff' + csv, base + '.csv', 'text/csv;charset=utf-8');
        }
    }
    function sortTable(table, colIndex, th) {
        const tbody = table.querySelector('tbody');
        const rows = rowsOf(table);
        const dir = th.dataset.sortDir === 'ASC' ? 'DESC' : 'ASC';
        th.closest('tr').querySelectorAll('th').forEach(function (h) {
            h.dataset.sortDir = '';
            const ico = h.querySelector('.sort-ico-generic');
            if (ico) ico.textContent = '↕';
        });
        th.dataset.sortDir = dir;
        const ico = th.querySelector('.sort-ico-generic');
        if (ico) ico.textContent = dir === 'ASC' ? '▲' : '▼';
        rows.sort(function (a, b) {
            const av = cleanText(a.children[colIndex]);
            const bv = cleanText(b.children[colIndex]);
            const an = Number(av.replace(/[^0-9.-]/g, ''));
            const bn = Number(bv.replace(/[^0-9.-]/g, ''));
            const bothNumeric = !Number.isNaN(an) && !Number.isNaN(bn) && /[0-9]/.test(av + bv);
            const result = bothNumeric ? (an - bn) : av.localeCompare(bv, undefined, {numeric: true, sensitivity: 'base'});
            return dir === 'ASC' ? result : -result;
        });
        rows.forEach(row => tbody.appendChild(row));
    }

    tables.forEach(function (table, tableIndex) {
        if (table.dataset.genericOperationEnhanced === 'true') return;
        table.dataset.genericOperationEnhanced = 'true';
        const wrap = table.closest('.adm-table-wrap') || table.parentElement;

        const toolbar = document.createElement('div');
        toolbar.className = 'adm-local-toolbar';
        toolbar.style.margin = '0 0 12px';
        toolbar.innerHTML =
            '<div class="adm-local-toolbar-group adm-unified-export">'
            + '<div class="adm-export-control">'
            + '<select class="adm-select js-op-export-format"><option value="csv">CSV</option><option value="excel">Excel</option></select>'
            + '<div class="adm-export-menu">'
            + '<button type="button" class="adm-btn adm-btn-ghost js-export-toggle">⬇ 내보내기 ▾</button>'
            + '<div class="adm-export-dropdown">'
            + '<button type="button" class="js-op-export" data-scope="all">📋 전체 내보내기</button>'
            + '<button type="button" class="js-op-export" data-scope="search">🔍 현재 검색 내보내기</button>'
            + '<button type="button" class="js-op-export-selected" data-scope="selected" disabled>☑ 선택 내보내기 (0)</button>'
            + '</div></div></div>'
            + '<button type="button" class="adm-btn adm-btn-ghost js-op-clear-selection" style="display:none;">선택 해제</button>'
            + '</div>';
        wrap.parentElement.insertBefore(toolbar, wrap);

        const headRow = table.querySelector('thead tr');
        if (headRow && !headRow.querySelector('.js-op-check-all')) {
            const th = document.createElement('th');
            th.style.width = '42px';
            th.style.textAlign = 'center';
            th.innerHTML = '<input type="checkbox" class="js-op-check-all adm-check">';
            headRow.insertBefore(th, headRow.firstElementChild);
        }

        table.querySelectorAll('tbody tr').forEach(function (row) {
            if (row.children.length === 1 && row.children[0].hasAttribute('colspan')) return;
            if (row.querySelector('.js-op-row-check')) return;
            const td = document.createElement('td');
            td.style.textAlign = 'center';
            td.innerHTML = '<input type="checkbox" class="js-op-row-check adm-check">';
            row.insertBefore(td, row.firstElementChild);
        });

        Array.from(table.querySelectorAll('thead th')).forEach(function (th, idx, arr) {
            if (idx === 0 || idx === arr.length - 1 || th.querySelector('input')) return;
            if (!th.querySelector('.sort-ico-generic')) {
                th.style.cursor = 'pointer';
                th.style.userSelect = 'none';
                th.insertAdjacentHTML('beforeend', ' <span class="sort-ico-generic" style="font-size:10px;color:#94a3b8;">↕</span>');
                th.addEventListener('click', function () { sortTable(table, idx, th); });
            }
        });

        table.addEventListener('change', function (e) {
            if (e.target.matches('.js-op-check-all')) {
                rowsOf(table).forEach(row => row.querySelector('.js-op-row-check').checked = e.target.checked);
                updateSelectionUi(table);
            }
            if (e.target.matches('.js-op-row-check')) updateSelectionUi(table);
        });
        toolbar.addEventListener('click', function (e) {
            const exportBtn = e.target.closest('.js-op-export, .js-op-export-selected');
            if (exportBtn) {
                exportTable(table, exportBtn.dataset.scope || 'all');
                return;
            }
            const clearBtn = e.target.closest('.js-op-clear-selection');
            if (clearBtn) {
                rowsOf(table).forEach(row => row.querySelector('.js-op-row-check').checked = false);
                updateSelectionUi(table);
            }
        });
    });
})();
</script>

