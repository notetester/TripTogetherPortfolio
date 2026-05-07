<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_community_filter_searchPlaceholder" code="admin.community.filter.searchPlaceholder"/>
<spring:message var="msg_admin_community_confirm_commentAction_js" code="admin.community.confirm.commentAction" javaScriptEscape="true"/>
<spring:message var="msg_admin_community_confirm_bulkAction_js" code="admin.community.confirm.bulkAction" javaScriptEscape="true"/>
<spring:message var="msg_admin_community_bulk_selectedCount_js" code="admin.community.bulk.selectedCount" javaScriptEscape="true"/>
<spring:message var="msg_admin_community_action_block_js" code="admin.community.action.block" javaScriptEscape="true"/>
<spring:message var="msg_admin_community_action_delete_js" code="admin.community.action.delete" javaScriptEscape="true"/>
<spring:message var="msg_admin_community_label_lastIp_js" code="admin.community.label.lastIp" javaScriptEscape="true"/>
<spring:message var="msg_admin_community_authorModal_recentResolved_js" code="admin.community.authorModal.recentResolved" javaScriptEscape="true"/>
<spring:message var="msg_admin_community_pageTitle" code="admin.community.pageTitle"/>
<spring:message var="msg_admin_common_nickname" code="admin.common.nickname"/>
<spring:message var="msg_admin_common_userId" code="admin.common.userId"/>
<spring:message var="msg_admin_common_accountStatus" code="admin.common.accountStatus"/>
<spring:message var="msg_admin_common_memberInfoView" code="admin.common.memberInfoView"/>
<spring:message var="msg_admin_common_blockAccount" code="admin.common.blockAccount"/>
<spring:message var="msg_admin_common_activeLabel" code="admin.common.activeLabel"/>
<spring:message var="msg_admin_common_blockedLabel" code="admin.common.blockedLabel"/>
<spring:message var="msg_admin_community_authorModal_title" code="admin.community.authorModal.title"/>
<spring:message var="msg_admin_community_confirmBlockUser" code="admin.community.confirmBlockUser"/>
<spring:message var="msg_admin_community_message_actionFailed" code="admin.community.message.actionFailed"/>
<spring:message var="msg_admin_community_message_noSelection" code="admin.community.message.noSelection"/>
<spring:message var="msg_admin_community_confirm_commentAction" code="admin.community.confirm.commentAction"/>
<spring:message var="msg_admin_community_confirm_bulkAction" code="admin.community.confirm.bulkAction"/>
<spring:message var="msg_admin_community_bulk_selectedCount" code="admin.community.bulk.selectedCount"/>
<spring:message var="msg_admin_community_authorModal_recentResolved" code="admin.community.authorModal.recentResolved"/>
<spring:message var="msg_admin_community_tab_posts" code="admin.community.tab.posts"/>
<spring:message var="msg_admin_community_tab_comments" code="admin.community.tab.comments"/>
<spring:message var="msg_admin_community_kpi_activeComments" code="admin.community.kpi.activeComments"/>
<spring:message var="msg_admin_community_kpi_totalComments" code="admin.community.kpi.totalComments"/>
<spring:message var="msg_admin_community_kpi_blockedCommentsLabel" code="admin.community.kpi.blockedCommentsLabel"/>
<spring:message var="msg_admin_community_kpi_activePosts" code="admin.community.kpi.activePosts"/>
<spring:message var="msg_admin_community_kpi_totalPosts" code="admin.community.kpi.totalPosts"/>
<spring:message var="msg_admin_community_kpi_pendingReports" code="admin.community.kpi.pendingReports"/>
<spring:message var="msg_admin_community_kpi_resolvedReports30d" code="admin.community.kpi.resolvedReports30d"/>
<spring:message var="msg_admin_community_filter_status" code="admin.community.filter.status"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_community_status_active" code="admin.community.status.active"/>
<spring:message var="msg_admin_community_status_blocked" code="admin.community.status.blocked"/>
<spring:message var="msg_admin_community_status_deleted" code="admin.community.status.deleted"/>
<spring:message var="msg_admin_community_filter_sort" code="admin.community.filter.sort"/>
<spring:message var="msg_admin_community_sort_createdAt" code="admin.community.sort.createdAt"/>
<spring:message var="msg_admin_community_sort_reportCount" code="admin.community.sort.reportCount"/>
<spring:message var="msg_admin_community_filter_flagged" code="admin.community.filter.flagged"/>
<spring:message var="msg_admin_community_flagged_flagged" code="admin.community.flagged.flagged"/>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_community_searchType_content" code="admin.community.searchType.content"/>
<spring:message var="msg_admin_community_searchType_nickname" code="admin.community.searchType.nickname"/>
<spring:message var="msg_admin_community_searchType_userId" code="admin.community.searchType.userId"/>
<spring:message var="msg_admin_common_searchButton" code="admin.common.searchButton"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_community_list_commentsTitle" code="admin.community.list.commentsTitle"/>
<spring:message var="msg_admin_community_action_bulkBlock" code="admin.community.action.bulkBlock"/>
<spring:message var="msg_admin_community_action_bulkDelete" code="admin.community.action.bulkDelete"/>
<spring:message var="msg_admin_community_column_id" code="admin.community.column.id"/>
<spring:message var="msg_admin_community_column_author" code="admin.community.column.author"/>
<spring:message var="msg_admin_community_column_ip" code="admin.community.column.ip"/>
<spring:message var="msg_admin_community_column_content" code="admin.community.column.content"/>
<spring:message var="msg_admin_community_column_originalPost" code="admin.community.column.originalPost"/>
<spring:message var="msg_admin_community_column_kind" code="admin.community.column.kind"/>
<spring:message var="msg_admin_community_column_reportCount" code="admin.community.column.reportCount"/>
<spring:message var="msg_admin_common_status" code="admin.common.status"/>
<spring:message var="msg_admin_community_column_createdAt" code="admin.community.column.createdAt"/>
<spring:message var="msg_admin_common_action" code="admin.common.action"/>
<spring:message var="msg_admin_community_accountBlocked" code="admin.community.accountBlocked"/>
<spring:message var="msg_admin_community_rowResolved30d" code="admin.community.rowResolved30d"/>
<spring:message var="msg_admin_community_kind_reply" code="admin.community.kind.reply"/>
<spring:message var="msg_admin_community_kind_comment" code="admin.community.kind.comment"/>
<spring:message var="msg_admin_community_action_block" code="admin.community.action.block"/>
<spring:message var="msg_admin_community_action_delete" code="admin.community.action.delete"/>
<spring:message var="msg_admin_common_noResults" code="admin.common.noResults"/>
<spring:message var="msg_admin_community_viewSite" code="admin.community.viewSite"/>
<spring:message var="msg_admin_common_prev" code="admin.common.prev"/>
<spring:message var="msg_admin_common_next" code="admin.common.next"/>
<spring:message var="msg_admin_common_pageSize_20" code="admin.common.pageSize" arguments="20"/>
<spring:message var="msg_admin_common_pageSize_50" code="admin.common.pageSize" arguments="50"/>
<spring:message var="msg_admin_common_pageSize_100" code="admin.common.pageSize" arguments="100"/>
<spring:message var="msg_admin_community_totalCountDisplay" code="admin.common.totalCountFormat" arguments="${total}"/>
<spring:message var="msg_admin_community_currentCountDisplay" code="admin.common.currentCountFormat" arguments="${fn:length(list)}"/>
<c:set var="activeMenu" value="community"/>


<c:set var="pageTitle" value="${msg_admin_community_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content adm-community-page">

    <%-- ── 탭 바 ── --%>
    <div class="adm-tabs adm-admin-tabs">
        <a class="adm-tab adm-tab-link" href="${pageContext.request.contextPath}/admin/community">📝 ${msg_admin_community_tab_posts}</a>
        <a class="adm-tab adm-tab-link active" href="${pageContext.request.contextPath}/admin/community/comments">💬 ${msg_admin_community_tab_comments}</a>
    </div>

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_community_kpi_activeComments}</div>
            <div class="adm-summary-value is-success">${stats.activeComments}</div>
            <div class="adm-summary-sub">${msg_admin_community_kpi_totalComments}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_community_kpi_blockedCommentsLabel}</div>
            <div class="adm-summary-value is-danger">${stats.blockedComments}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_community_kpi_activePosts}</div>
            <div class="adm-summary-value is-primary">${stats.activePosts}</div>
            <div class="adm-summary-sub">${msg_admin_community_kpi_totalPosts}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_community_kpi_pendingReports}</div>
            <div class="adm-summary-value is-warning">${stats.pendingReports}</div>
            <div class="adm-summary-sub">${msg_admin_community_kpi_resolvedReports30d}</div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card adm-community-filter-card">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/community/comments">
                <input type="hidden" name="size" value="${search.size}"/>
                <div class="adm-filter-bar adm-community-filterbar adm-community-comment-filterbar">
                    <div>
                        <div class="adm-filter-label">${msg_admin_community_filter_status}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ?'selected':''}>${msg_admin_common_all}</option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ?'selected':''}>${msg_admin_community_status_active}</option>
                            <option value="BLOCKED" ${search.status=='BLOCKED' ?'selected':''}>${msg_admin_community_status_blocked}</option>
                            <option value="DELETED" ${search.status=='DELETED' ?'selected':''}>${msg_admin_community_status_deleted}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_community_filter_sort}</div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt"   ${search.sortBy=='createdAt'   ?'selected':''}>${msg_admin_community_sort_createdAt}</option>
                            <option value="reportCount" ${search.sortBy=='reportCount' ?'selected':''}>${msg_admin_community_sort_reportCount}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_community_filter_flagged}</div>
                        <select class="adm-select" name="flagged">
                            <option value="ALL"     ${search.flagged=='ALL'     ?'selected':''}>${msg_admin_common_all}</option>
                            <option value="FLAGGED" ${search.flagged=='FLAGGED' ?'selected':''}>${msg_admin_community_flagged_flagged}</option>
                        </select>
                    </div>
                    <div class="adm-community-search-field">
                        <div class="adm-filter-label">${msg_admin_common_search}</div>
                        <div class="adm-community-search-row">
                            <select class="adm-select adm-community-search-type" name="searchType">
                                <option value="content"  ${search.searchType=='content'  ?'selected':''}>${msg_admin_community_searchType_content}</option>
                                <option value="nickname" ${search.searchType=='nickname' ?'selected':''}>${msg_admin_community_searchType_nickname}</option>
                                <option value="userId"   ${search.searchType=='userId'   ?'selected':''}>${msg_admin_community_searchType_userId}</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}"
                                   placeholder="${msg_admin_community_filter_searchPlaceholder}">
                        </div>
                    </div>
                    <div class="adm-community-filter-actions">
                        <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_searchButton}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/community/comments">${msg_admin_common_reset}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card adm-community-list-card">
        <div class="adm-card-head adm-community-list-head">
            <div class="adm-card-title">
                ${msg_admin_community_list_commentsTitle}
                <span class="adm-section-total-inline">${msg_admin_community_totalCountDisplay}</span>
            </div>
            <div class="adm-community-list-controls">
                <select class="adm-select adm-community-size-select" onchange="goCommunityCommentPageSize(this.value)">
                    <option value="20" ${search.size == 20 ? 'selected' : ''}>${msg_admin_common_pageSize_20}</option>
                    <option value="50" ${search.size == 50 ? 'selected' : ''}>${msg_admin_common_pageSize_50}</option>
                    <option value="100" ${search.size == 100 ? 'selected' : ''}>${msg_admin_common_pageSize_100}</option>
                </select>
                <%-- 일괄 처리 버튼 --%>
                <div id="bulkBar" class="adm-community-bulk-bar" hidden>
                    <span id="bulkCount" class="adm-community-bulk-count"></span>
                    <button class="adm-btn adm-btn-ghost adm-community-danger-btn"
                            onclick="bulkAction('block')">${msg_admin_community_action_bulkBlock}</button>
                    <button class="adm-btn adm-btn-ghost adm-community-muted-btn"
                            onclick="bulkAction('delete')">${msg_admin_community_action_bulkDelete}</button>
                </div>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table adm-community-table adm-community-comment-table" data-admin-list-ignore="true">
                <colgroup>
                    <col class="adm-community-col-check">
                    <col class="adm-community-col-id">
                    <col class="adm-community-col-author">
                    <col class="adm-community-col-ip">
                    <col>
                    <col class="adm-community-col-source">
                    <col class="adm-community-col-type">
                    <col class="adm-community-col-count">
                    <col class="adm-community-col-status">
                    <col class="adm-community-col-date-small">
                    <col class="adm-community-col-action">
                </colgroup>
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkAll"></th>
                    <th>${msg_admin_community_column_id}</th>
                    <th>${msg_admin_community_column_author}</th>
                    <th>${msg_admin_community_column_ip}</th>
                    <th>${msg_admin_community_column_content}</th>
                    <th>${msg_admin_community_column_originalPost}</th>
                    <th>${msg_admin_community_column_kind}</th>
                    <th>${msg_admin_community_column_reportCount}</th>
                    <th>${msg_admin_common_status}</th>
                    <th>${msg_admin_community_column_createdAt}</th>
                    <th>${msg_admin_common_action}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="comment">
                    <c:url var="communityCommentPostUrl" value="/admin/community/posts/${comment.postId}">
                        <c:param name="page" value="${paging.currentPage}"/>
                        <c:param name="size" value="${search.size}"/>
                        <c:param name="status" value="${search.status}"/>
                        <c:param name="flagged" value="${search.flagged}"/>
                        <c:param name="sortBy" value="${search.sortBy}"/>
                        <c:param name="searchType" value="${search.searchType}"/>
                        <c:param name="keyword" value="${search.keyword}"/>
                    </c:url>
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${comment.commentId}"></td>
                        <td class="adm-community-id-cell">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${communityCommentPostUrl}">#${comment.commentId}</a>
                        </td>

                        <%-- 작성자 --%>
                        <td class="adm-community-author-cell"
                            data-useridx="${comment.userIdx}"
                            data-userid="${comment.userId}"
                            data-nickname="${comment.nickname}"
                            data-ip="${comment.lastIp}"
                            data-status="${comment.accountStatus}"
                            data-resolve="${comment.authorResolveCount30d}"
                            onclick="openAuthorModal(this)">
                            <div class="adm-community-author-name">${comment.nickname}</div>
                            <div class="adm-community-author-id">${comment.userId}</div>
                            <c:if test="${comment.accountStatus == 'BLOCKED'}">
                                <span class="adm-inline-danger">${msg_admin_community_accountBlocked}</span>
                            </c:if>
                        </td>

                        <%-- IP --%>
                        <td class="adm-community-ip-cell">
                            <c:choose>
                                <c:when test="${not empty comment.lastIp}">
                                    <button type="button"
                                            class="adm-inline-link js-open-ip-context"
                                            data-ip-address="${comment.lastIp}"
                                            data-default-tab="blocks"
                                            onclick="event.stopPropagation();">${comment.lastIp}</button>
                                </c:when>
                                <c:otherwise><span class="adm-community-muted">—</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 댓글 내용 + 30일 배지 --%>
                        <td>
                            <a class="adm-cell-link adm-cell-link--inline adm-cell-ellipsis"
                               href="${communityCommentPostUrl}"
                               title="${comment.content}">
                                ${comment.content}
                            </a>
                            <c:if test="${comment.authorResolveCount30d > 0}">
                                <span class="adm-inline-warning">
                                    ⚠ ${msg_admin_community_rowResolved30d}
                                </span>
                            </c:if>
                        </td>

                        <%-- 원글 --%>
                        <td class="adm-community-source-cell">
                            <a href="${communityCommentPostUrl}"
                               class="adm-link-ellipsis"
                               title="${comment.postTitle}">
                                ${comment.postTitle}
                            </a>
                        </td>

                        <%-- 구분: 댓글 / 대댓글 --%>
                        <td class="adm-community-kind-cell">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${communityCommentPostUrl}">
                            <c:choose>
                                <c:when test="${not empty comment.parentCommentId}">
                                    <span class="adm-community-kind-reply">↩ ${msg_admin_community_kind_reply}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="adm-community-muted">${msg_admin_community_kind_comment}</span>
                                </c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 신고 수 --%>
                        <td>
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${communityCommentPostUrl}">
                            <c:choose>
                                <c:when test="${comment.reportCount >= reportThreshold}">
                                    <span class="adm-community-report-count is-hot">🔴 ${comment.reportCount}</span>
                                </c:when>
                                <c:when test="${comment.reportCount > 0}">
                                    <span class="adm-community-report-count is-warn">${comment.reportCount}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="adm-community-muted">0</span>
                                </c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 상태 --%>
                        <td>
                            <a href="${communityCommentPostUrl}"
                               class="adm-cell-link adm-cell-link--inline status-badge ${comment.commentStatus}">
                                <c:choose>
                                    <c:when test="${comment.commentStatus == 'ACTIVE'}">${msg_admin_community_status_active}</c:when>
                                    <c:when test="${comment.commentStatus == 'BLOCKED'}">${msg_admin_community_status_blocked}</c:when>
                                    <c:otherwise>${comment.commentStatus}</c:otherwise>
                                </c:choose>
                            </a>
                        </td>

                        <%-- 등록일 --%>
                        <td class="adm-community-date-cell">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${communityCommentPostUrl}">
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
                                                onclick="actionComment(this.getAttribute('data-id'), 'block')">${msg_admin_community_action_block}</button>
                                        <div class="action-menu-wrap">
                                            <button class="adm-row-btn detail adm-row-btn-more"
                                                    type="button"
                                                    onclick="admToggleActionMenu(this)">⋯</button>
                                            <div class="action-menu">
                                                <button class="action-menu-item danger"
                                                        type="button"
                                                        data-id="${comment.commentId}"
                                                        onclick="actionComment(this.getAttribute('data-id'), 'delete')">${msg_admin_community_action_delete}</button>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="adm-row-actions is-single">
                                        <button class="adm-row-btn danger"
                                                type="button"
                                                data-id="${comment.commentId}"
                                                onclick="actionComment(this.getAttribute('data-id'), 'delete')">${msg_admin_community_action_delete}</button>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr class="adm-local-empty"><td colspan="11" class="adm-local-empty-cell">${msg_admin_common_noResults}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <%-- 페이지네이션 --%>
        <c:set var="communityTotalPage" value="${paging.totalPage < 1 ? 1 : paging.totalPage}"/>
        <div class="adm-local-pagination adm-community-local-pagination">
            <div class="adm-local-page-info">
                ${msg_admin_community_totalCountDisplay} / ${msg_admin_community_currentCountDisplay}
            </div>
            <div class="adm-local-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost" ${paging.currentPage <= 1 ? 'disabled' : ''} onclick="goPage(${paging.currentPage - 1})">${msg_admin_common_prev}</button>
                <span class="adm-local-page-state">${paging.currentPage} / ${communityTotalPage}</span>
                <button type="button" class="adm-btn adm-btn-ghost" ${paging.currentPage >= communityTotalPage ? 'disabled' : ''} onclick="goPage(${paging.currentPage + 1})">${msg_admin_common_next}</button>
            </div>
        </div>
    </div>

    <div class="adm-community-site-link">
        <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/community/list" target="_blank">
            <span class="adm-nav-icon">↗️</span> ${msg_admin_community_viewSite}
        </a>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var COMMUNITY_COMMENT_MSG = {
    noSelection: '${fn:escapeXml(msg_admin_community_message_noSelection)}',
    actionFailed: '${fn:escapeXml(msg_admin_community_message_actionFailed)}',
    confirmCommentAction: '${msg_admin_community_confirm_commentAction_js}',
    confirmBulkAction: '${msg_admin_community_confirm_bulkAction_js}',
    selectedCount: '${msg_admin_community_bulk_selectedCount_js}',
    block: '${msg_admin_community_action_block_js}',
    delete: '${msg_admin_community_action_delete_js}',
    blocked: '${fn:escapeXml(msg_admin_common_blockedLabel)}',
    active: '${fn:escapeXml(msg_admin_common_activeLabel)}',
    nickname: '${fn:escapeXml(msg_admin_common_nickname)}',
    userId: '${fn:escapeXml(msg_admin_common_userId)}',
    accountStatus: '${fn:escapeXml(msg_admin_common_accountStatus)}',
    lastIp: '${msg_admin_community_label_lastIp_js}',
    memberInfoView: '${fn:escapeXml(msg_admin_common_memberInfoView)}',
    blockAccount: '${fn:escapeXml(msg_admin_common_blockAccount)}',
    confirmBlock: '${fn:escapeXml(msg_admin_community_confirmBlockUser)}',
    recentResolved: '${msg_admin_community_authorModal_recentResolved_js}',
    modalTitle: '${fn:escapeXml(msg_admin_community_authorModal_title)}'
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
        bar.hidden = false;
        document.getElementById('bulkCount').textContent = COMMUNITY_COMMENT_MSG.selectedCount.replace('__count__', checked.length);
    } else {
        bar.hidden = true;
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

function goCommunityCommentPageSize(size) {
    var params = new URLSearchParams(window.location.search);
    params.set('size', size);
    params.set('page', '1');
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
        ? '<span class="status-badge BLOCKED adm-community-modal-status">' + COMMUNITY_COMMENT_MSG.blocked + '</span>'
        : '<span class="status-badge ACTIVE adm-community-modal-status">' + COMMUNITY_COMMENT_MSG.active + '</span>';

    var warnBox = resolve > 0
        ? '<div class="adm-warning-box">⚠ ' + COMMUNITY_COMMENT_MSG.recentResolved.replace('__count__', resolve) + '</div>'
        : '';

    var blockBtn = status !== 'BLOCKED'
        ? '<button class="adm-btn adm-btn-ghost adm-community-modal-block-btn" data-idx="' + userIdx + '" onclick="blockUserFromModal(this)">' + COMMUNITY_COMMENT_MSG.blockAccount + '</button>'
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

    document.getElementById('authorModal').hidden = false;
}

function closeAuthorModal() {
    document.getElementById('authorModal').hidden = true;
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
<div id="authorModal" class="adm-modal-overlay" hidden
     onclick="if(event.target===this)closeAuthorModal()">
        <div class="adm-modal adm-community-author-modal">
        <div class="adm-modal-head">
            <span class="adm-modal-title">${msg_admin_community_authorModal_title}</span>
            <button class="adm-modal-close" onclick="closeAuthorModal()">✕</button>
        </div>
        <div class="adm-modal-body" id="authorModalBody"></div>
    </div>
</div>

<%@ include file="../layout-close.jsp" %>
