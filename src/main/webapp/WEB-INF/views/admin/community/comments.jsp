<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_37b983678c" code="admin.community.tab.posts"/>
<spring:message var="autoMsg_ee23455f7d" code="admin.community.tab.comments"/>
<spring:message var="autoMsg_f8d2baa75b" code="admin.community.kpi.activeComments"/>
<spring:message var="autoMsg_7ac318f4c6" code="admin.community.kpi.totalComments"/>
<spring:message var="autoMsg_d02f7f181b" code="admin.community.kpi.blockedCommentsLabel"/>
<spring:message var="autoMsg_4d49b5ac35" code="admin.community.kpi.activePosts"/>
<spring:message var="autoMsg_4266f85903" code="admin.community.kpi.totalPosts"/>
<spring:message var="autoMsg_983a35e04f" code="admin.community.kpi.pendingReports"/>
<spring:message var="autoMsg_652f543662" code="admin.community.kpi.resolvedReports30d"/>
<spring:message var="autoMsg_9819de753c" code="admin.community.filter.status"/>
<spring:message var="autoMsg_c3306e1b0d" code="admin.common.all"/>
<spring:message var="autoMsg_3da7db257b" code="admin.community.status.active"/>
<spring:message var="autoMsg_0ee11360c2" code="admin.community.status.blocked"/>
<spring:message var="autoMsg_fc7dab1a0b" code="admin.community.status.deleted"/>
<spring:message var="autoMsg_90b8fda2db" code="admin.community.filter.sort"/>
<spring:message var="autoMsg_86bda87c59" code="admin.community.sort.createdAt"/>
<spring:message var="autoMsg_b1361e7ded" code="admin.community.sort.reportCount"/>
<spring:message var="autoMsg_79408fe691" code="admin.community.filter.flagged"/>
<spring:message var="autoMsg_afa4e11ea3" code="admin.community.flagged.flagged"/>
<spring:message var="autoMsg_964bae08eb" code="admin.common.search"/>
<spring:message var="autoMsg_bcbc3f0502" code="admin.community.searchType.content"/>
<spring:message var="autoMsg_bf7ec6c75e" code="admin.community.searchType.nickname"/>
<spring:message var="autoMsg_be1caa5966" code="admin.community.searchType.userId"/>
<spring:message var="autoMsg_537c62c212" code="admin.community.filter.searchPlaceholder"/>
<spring:message var="autoMsg_48f67981a5" code="admin.common.searchButton"/>
<spring:message var="autoMsg_2e8d1cf278" code="admin.common.reset"/>
<spring:message var="autoMsg_465e76e306" code="admin.community.list.commentsTitle"/>
<spring:message var="autoMsg_3c02b4dd9d" code="admin.common.totalCount"/>
<spring:message var="autoMsg_7d71732d0b" code="admin.community.action.bulkBlock"/>
<spring:message var="autoMsg_578ba68ed4" code="admin.community.action.bulkDelete"/>
<spring:message var="autoMsg_8a621d91cb" code="admin.community.column.id"/>
<spring:message var="autoMsg_31a24f05e1" code="admin.community.column.author"/>
<spring:message var="autoMsg_bfe4bb5e21" code="admin.community.column.ip"/>
<spring:message var="autoMsg_25d67df745" code="admin.community.column.content"/>
<spring:message var="autoMsg_f7eaf58f6a" code="admin.community.column.originalPost"/>
<spring:message var="autoMsg_2f7d00bfab" code="admin.community.column.kind"/>
<spring:message var="autoMsg_8c8a9f2db2" code="admin.community.column.reportCount"/>
<spring:message var="autoMsg_ca5905ef1d" code="admin.common.status"/>
<spring:message var="autoMsg_d35e20522a" code="admin.community.column.createdAt"/>
<spring:message var="autoMsg_a9306c9127" code="admin.common.action"/>
<spring:message var="autoMsg_c6a9c47db1" code="admin.community.accountBlocked"/>
<spring:message var="autoMsg_26779d19c6" code="admin.community.rowResolved30d"/>
<spring:message var="autoMsg_f34a86b1a3" code="admin.community.kind.reply"/>
<spring:message var="autoMsg_a3f5112287" code="admin.community.kind.comment"/>
<spring:message var="autoMsg_6e78920348" code="admin.community.action.block"/>
<spring:message var="autoMsg_aff59f78b9" code="admin.community.action.delete"/>
<spring:message var="autoMsg_477fc6250a" code="admin.common.noResults"/>
<spring:message var="autoMsg_3b49fe0281" code="admin.common.pageStatus"/>
<spring:message var="autoMsg_bad93e93ef" code="admin.community.viewSite"/>
<spring:message var="autoMsg_47cd6888ec" code="admin.community.confirm.commentAction" javaScriptEscape="true"/>
<spring:message var="autoMsg_27fb22bd19" code="admin.community.confirm.bulkAction" javaScriptEscape="true"/>
<spring:message var="autoMsg_9ca27c69c4" code="admin.community.bulk.selectedCount" javaScriptEscape="true"/>
<spring:message var="autoMsg_8ac472be2a" code="admin.community.action.block" javaScriptEscape="true"/>
<spring:message var="autoMsg_b841df8137" code="admin.community.action.delete" javaScriptEscape="true"/>
<spring:message var="autoMsg_09efca1d3f" code="admin.community.label.lastIp" javaScriptEscape="true"/>
<spring:message var="autoMsg_3d2e67c99e" code="admin.community.authorModal.recentResolved" javaScriptEscape="true"/>
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
<spring:message code="admin.community.confirm.commentAction" var="adminCommunityConfirmCommentAction"/>
<spring:message code="admin.community.confirm.bulkAction" var="adminCommunityConfirmBulkAction"/>
<spring:message code="admin.community.bulk.selectedCount" var="adminCommunitySelectedCount"/>
<spring:message code="admin.community.authorModal.recentResolved" var="adminCommunityRecentResolved"/>
<c:set var="pageTitle" value="${adminCommunityPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 탭 바 ── --%>
    <div class="adm-tabs adm-admin-tabs">
        <a class="adm-tab adm-tab-link" href="${pageContext.request.contextPath}/admin/community">📝 ${autoMsg_37b983678c}</a>
        <a class="adm-tab adm-tab-link active" href="${pageContext.request.contextPath}/admin/community/comments">💬 ${autoMsg_ee23455f7d}</a>
    </div>

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_f8d2baa75b}</div>
            <div class="adm-summary-value is-success">${stats.activeComments}</div>
            <div class="adm-summary-sub">${autoMsg_7ac318f4c6}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_d02f7f181b}</div>
            <div class="adm-summary-value is-danger">${stats.blockedComments}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_4d49b5ac35}</div>
            <div class="adm-summary-value is-primary">${stats.activePosts}</div>
            <div class="adm-summary-sub">${autoMsg_4266f85903}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_983a35e04f}</div>
            <div class="adm-summary-value is-warning">${stats.pendingReports}</div>
            <div class="adm-summary-sub">${autoMsg_652f543662}</div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/community/comments">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label">${autoMsg_9819de753c}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ?'selected':''}>${autoMsg_c3306e1b0d}</option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ?'selected':''}>${autoMsg_3da7db257b}</option>
                            <option value="BLOCKED" ${search.status=='BLOCKED' ?'selected':''}>${autoMsg_0ee11360c2}</option>
                            <option value="DELETED" ${search.status=='DELETED' ?'selected':''}>${autoMsg_fc7dab1a0b}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_90b8fda2db}</div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt"   ${search.sortBy=='createdAt'   ?'selected':''}>${autoMsg_86bda87c59}</option>
                            <option value="reportCount" ${search.sortBy=='reportCount' ?'selected':''}>${autoMsg_b1361e7ded}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_79408fe691}</div>
                        <select class="adm-select" name="flagged">
                            <option value="ALL"     ${search.flagged=='ALL'     ?'selected':''}>${autoMsg_c3306e1b0d}</option>
                            <option value="FLAGGED" ${search.flagged=='FLAGGED' ?'selected':''}>${autoMsg_afa4e11ea3}</option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:200px;">
                        <div class="adm-filter-label">${autoMsg_964bae08eb}</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:110px;">
                                <option value="content"  ${search.searchType=='content'  ?'selected':''}>${autoMsg_bcbc3f0502}</option>
                                <option value="nickname" ${search.searchType=='nickname' ?'selected':''}>${autoMsg_bf7ec6c75e}</option>
                                <option value="userId"   ${search.searchType=='userId'   ?'selected':''}>${autoMsg_be1caa5966}</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}"
                                   placeholder="${autoMsg_537c62c212}" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit">${autoMsg_48f67981a5}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/community/comments">${autoMsg_2e8d1cf278}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title">${autoMsg_465e76e306}</div>
                <div class="adm-muted-note">${autoMsg_3c02b4dd9d}</div>
            </div>
            <%-- 일괄 처리 버튼 --%>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" style="font-size:12px;color:#94a3b8;"></span>
                <button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;"
                        onclick="bulkAction('block')">${autoMsg_7d71732d0b}</button>
                <button class="adm-btn adm-btn-ghost" style="color:#64748b;"
                        onclick="bulkAction('delete')">${autoMsg_578ba68ed4}</button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:60px;">${autoMsg_8a621d91cb}</th>
                    <th>${autoMsg_31a24f05e1}</th>
                    <th>${autoMsg_bfe4bb5e21}</th>
                    <th>${autoMsg_25d67df745}</th>
                    <th>${autoMsg_f7eaf58f6a}</th>
                    <th style="width:70px;">${autoMsg_2f7d00bfab}</th>
                    <th style="width:60px;">${autoMsg_8c8a9f2db2}</th>
                    <th style="width:80px;">${autoMsg_ca5905ef1d}</th>
                    <th style="width:90px;">${autoMsg_d35e20522a}</th>
                    <th style="width:100px;">${autoMsg_a9306c9127}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="comment">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${comment.commentId}"></td>
                        <td style="color:#64748b;font-size:12px;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/community/posts/${comment.postId}">#${comment.commentId}</a>
                        </td>

                        <%-- 작성자 --%>
                        <td style="cursor:pointer;"
                            data-useridx="${comment.userIdx}"
                            data-userid="${comment.userId}"
                            data-nickname="${comment.nickname}"
                            data-ip="${comment.lastIp}"
                            data-status="${comment.accountStatus}"
                            data-resolve="${comment.authorResolveCount30d}"
                            onclick="openAuthorModal(this)">
                            <div style="font-weight:600;font-size:13px;color:#7dd3fc;">${comment.nickname}</div>
                            <div style="font-size:11px;color:#64748b;">${comment.userId}</div>
                            <c:if test="${comment.accountStatus == 'BLOCKED'}">
                                <span class="adm-inline-danger">${autoMsg_c6a9c47db1}</span>
                            </c:if>
                        </td>

                        <%-- IP --%>
                        <td style="font-size:11px;color:#94a3b8;font-family:monospace;">
                            <c:choose>
                                <c:when test="${not empty comment.lastIp}">
                                    <button type="button"
                                            class="adm-inline-link js-open-ip-context"
                                            data-ip-address="${comment.lastIp}"
                                            data-default-tab="blocks"
                                            onclick="event.stopPropagation();">${comment.lastIp}</button>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">—</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 댓글 내용 + 30일 배지 --%>
                        <td>
                            <a class="adm-cell-link adm-cell-link--inline adm-cell-ellipsis"
                               href="${pageContext.request.contextPath}/admin/community/posts/${comment.postId}"
                               title="${comment.content}">
                                ${comment.content}
                            </a>
                            <c:if test="${comment.authorResolveCount30d > 0}">
                                <span class="adm-inline-warning">
                                    ⚠ ${autoMsg_26779d19c6}
                                </span>
                            </c:if>
                        </td>

                        <%-- 원글 --%>
                        <td style="max-width:160px;">
                            <a href="${pageContext.request.contextPath}/admin/community/posts/${comment.postId}"
                               class="adm-link-ellipsis"
                               title="${comment.postTitle}">
                                ${comment.postTitle}
                            </a>
                        </td>

                        <%-- 구분: 댓글 / 대댓글 --%>
                        <td style="font-size:12px;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/community/posts/${comment.postId}">
                            <c:choose>
                                <c:when test="${not empty comment.parentCommentId}">
                                    <span style="color:#94a3b8;">↩ ${autoMsg_f34a86b1a3}</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#64748b;">${autoMsg_a3f5112287}</span>
                                </c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 신고 수 --%>
                        <td>
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/community/posts/${comment.postId}">
                            <c:choose>
                                <c:when test="${comment.reportCount >= reportThreshold}">
                                    <span style="color:#f87171;font-weight:700;">🔴 ${comment.reportCount}</span>
                                </c:when>
                                <c:when test="${comment.reportCount > 0}">
                                    <span style="color:#fbbf24;">${comment.reportCount}</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#475569;">0</span>
                                </c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 상태 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/community/posts/${comment.postId}"
                               class="adm-cell-link adm-cell-link--inline status-badge ${comment.commentStatus}">
                                <c:choose>
                                    <c:when test="${comment.commentStatus == 'ACTIVE'}">${autoMsg_3da7db257b}</c:when>
                                    <c:when test="${comment.commentStatus == 'BLOCKED'}">${autoMsg_0ee11360c2}</c:when>
                                    <c:otherwise>${comment.commentStatus}</c:otherwise>
                                </c:choose>
                            </a>
                        </td>

                        <%-- 등록일 --%>
                        <td style="font-size:11px;color:#64748b;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/community/posts/${comment.postId}">
                            <fmt:formatDate value="${comment.createdAtDate}" pattern="yyyy.MM.dd"/>
                            <div><fmt:formatDate value="${comment.createdAtDate}" pattern="HH:mm"/></div>
                            </a>
                        </td>

                        <%-- 액션 --%>
                        <td>
                            <c:choose>
                                <c:when test="${comment.commentStatus != 'BLOCKED'}">
                                    <div class="adm-row-actions">
                                        <button class="adm-row-btn danger"
                                                type="button"
                                                data-id="${comment.commentId}"
                                                onclick="actionComment(this.getAttribute('data-id'), 'block')">${autoMsg_6e78920348}</button>
                                        <div class="action-menu-wrap">
                                            <button class="adm-row-btn detail adm-row-btn-more"
                                                    type="button"
                                                    onclick="admToggleActionMenu(this)">⋯</button>
                                            <div class="action-menu">
                                                <button class="action-menu-item danger"
                                                        type="button"
                                                        data-id="${comment.commentId}"
                                                        onclick="actionComment(this.getAttribute('data-id'), 'delete')">${autoMsg_aff59f78b9}</button>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="adm-row-actions is-single">
                                        <button class="adm-row-btn danger"
                                                type="button"
                                                data-id="${comment.commentId}"
                                                onclick="actionComment(this.getAttribute('data-id'), 'delete')">${autoMsg_aff59f78b9}</button>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="11" style="text-align:center;padding:40px;color:#475569;">${autoMsg_477fc6250a}</td></tr>
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
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
                    <button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}" onclick="goPage(${p})">${p}</button>
                </c:forEach>
                <c:if test="${paging.next}">
                    <button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button>
                </c:if>
                <span class="adm-page-info">${autoMsg_3b49fe0281}</span>
            </div>
        </c:if>
    </div>

    <div style="margin-top:16px;padding:0 10px;">
        <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/community/list" target="_blank">
            <span class="adm-nav-icon">↗️</span> ${autoMsg_bad93e93ef}
        </a>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var COMMUNITY_COMMENT_MSG = {
    noSelection: '${fn:escapeXml(adminCommunityNoSelection)}',
    actionFailed: '${fn:escapeXml(adminCommunityActionFailed)}',
    confirmCommentAction: '${autoMsg_47cd6888ec}',
    confirmBulkAction: '${autoMsg_27fb22bd19}',
    selectedCount: '${autoMsg_9ca27c69c4}',
    block: '${autoMsg_8ac472be2a}',
    delete: '${autoMsg_b841df8137}',
    blocked: '${fn:escapeXml(adminCommonBlockedLabel)}',
    active: '${fn:escapeXml(adminCommonActiveLabel)}',
    nickname: '${fn:escapeXml(adminCommonNickname)}',
    userId: '${fn:escapeXml(adminCommonUserId)}',
    accountStatus: '${fn:escapeXml(adminCommonAccountStatus)}',
    lastIp: '${autoMsg_09efca1d3f}',
    memberInfoView: '${fn:escapeXml(adminCommonMemberInfoView)}',
    blockAccount: '${fn:escapeXml(adminCommonBlockAccount)}',
    confirmBlock: '${fn:escapeXml(adminCommunityConfirmBlockUser)}',
    recentResolved: '${autoMsg_3d2e67c99e}',
    modalTitle: '${fn:escapeXml(adminCommunityAuthorModalTitle)}'
};

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
        document.getElementById('bulkCount').textContent = COMMUNITY_COMMENT_MSG.selectedCount.replace('__count__', checked.length);
    } else {
        bar.style.display = 'none';
    }
}

function actionComment(commentId, action) {
    var label = action === 'block' ? COMMUNITY_COMMENT_MSG.block : COMMUNITY_COMMENT_MSG.delete;
    var message = COMMUNITY_COMMENT_MSG.confirmCommentAction
        .replace('__id__', commentId)
        .replace('__action__', label);
    if (!confirm(message)) return;
    fetch(ctx + '/admin/community/comments/' + commentId + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COMMUNITY_COMMENT_MSG.actionFailed); }
    });
}

function bulkAction(action) {
    var ids = Array.from(document.querySelectorAll('.row-check:checked'))
                   .map(function (cb) { return cb.getAttribute('data-id'); });
    if (ids.length === 0) { alert(COMMUNITY_COMMENT_MSG.noSelection); return; }
    var label = action === 'block' ? COMMUNITY_COMMENT_MSG.block : COMMUNITY_COMMENT_MSG.delete;
    var message = COMMUNITY_COMMENT_MSG.confirmBulkAction
        .replace('__count__', ids.length)
        .replace('__action__', label);
    if (!confirm(message)) return;

    var body = 'action=' + action + '&' + ids.map(function (id) { return 'ids=' + id; }).join('&');
    fetch(ctx + '/admin/community/comments/bulk-action', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: body
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COMMUNITY_COMMENT_MSG.actionFailed); }
    });
}

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = ctx + '/admin/community/comments?' + params.toString();
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
        ? '<span class="status-badge BLOCKED" style="font-size:12px;">' + COMMUNITY_COMMENT_MSG.blocked + '</span>'
        : '<span class="status-badge ACTIVE"  style="font-size:12px;">' + COMMUNITY_COMMENT_MSG.active + '</span>';

    var warnBox = resolve > 0
        ? '<div class="adm-warning-box">⚠ ' + COMMUNITY_COMMENT_MSG.recentResolved.replace('__count__', resolve) + '</div>'
        : '';

    var blockBtn = status !== 'BLOCKED'
        ? '<button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;width:100%;margin-top:4px;" data-idx="' + userIdx + '" onclick="blockUserFromModal(this)">' + COMMUNITY_COMMENT_MSG.blockAccount + '</button>'
        : '';

    document.getElementById('authorModalBody').innerHTML =
        '<div class="adm-modal-stack">'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + COMMUNITY_COMMENT_MSG.nickname + '</span>'
      + '    <span class="adm-modal-nickname">' + escHtml(nickname) + '</span>'
      + '  </div>'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + COMMUNITY_COMMENT_MSG.userId + '</span>'
      + '    <span class="adm-modal-value">' + escHtml(userId) + '</span>'
      + '  </div>'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + COMMUNITY_COMMENT_MSG.lastIp + '</span>'
      + '    <span class="adm-modal-value adm-mono-text">' + escHtml(ip || '—') + '</span>'
      + '  </div>'
      + '  <div class="adm-modal-row">'
      + '    <span class="adm-modal-label">' + COMMUNITY_COMMENT_MSG.accountStatus + '</span>'
      + '    ' + statusBadge
      + '  </div>'
      + '</div>'
      + warnBox
      + '<div class="adm-action-stack">'
      + '  <a href="' + ctx + '/admin/members?searchType=userId&keyword=' + encodeURIComponent(userId) + '" class="adm-btn adm-btn-ghost adm-link-button">' + COMMUNITY_COMMENT_MSG.memberInfoView + '</a>'
      + blockBtn
      + '</div>';

    document.getElementById('authorModal').style.display = 'flex';
}

function closeAuthorModal() {
    document.getElementById('authorModal').style.display = 'none';
}

function blockUserFromModal(btn) {
    var userIdx = btn.getAttribute('data-idx');
    if (!confirm(COMMUNITY_COMMENT_MSG.confirmBlock)) return;
    fetch(ctx + '/admin/community/users/' + userIdx + '/block', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COMMUNITY_COMMENT_MSG.actionFailed); }
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
