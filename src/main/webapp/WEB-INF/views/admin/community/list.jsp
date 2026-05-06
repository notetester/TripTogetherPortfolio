<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_community_filter_searchPlaceholder" code="admin.community.filter.searchPlaceholder"/>
<spring:message var="msg_admin_community_confirm_postAction_js" code="admin.community.confirm.postAction" javaScriptEscape="true"/>
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
<spring:message var="msg_admin_community_confirm_postAction" code="admin.community.confirm.postAction"/>
<spring:message var="msg_admin_community_confirm_bulkAction" code="admin.community.confirm.bulkAction"/>
<spring:message var="msg_admin_community_bulk_selectedCount" code="admin.community.bulk.selectedCount"/>
<spring:message var="msg_admin_community_authorModal_recentResolved" code="admin.community.authorModal.recentResolved"/>
<spring:message var="msg_admin_community_tab_posts" code="admin.community.tab.posts"/>
<spring:message var="msg_admin_community_tab_comments" code="admin.community.tab.comments"/>
<spring:message var="msg_admin_community_kpi_activePosts" code="admin.community.kpi.activePosts"/>
<spring:message var="msg_admin_community_kpi_totalPosts" code="admin.community.kpi.totalPosts"/>
<spring:message var="msg_admin_community_kpi_blockedPosts" code="admin.community.kpi.blockedPosts"/>
<spring:message var="msg_admin_community_kpi_deletedPosts" code="admin.community.kpi.deletedPosts"/>
<spring:message var="msg_admin_community_kpi_activeComments" code="admin.community.kpi.activeComments"/>
<spring:message var="msg_admin_community_kpi_blockedComments" code="admin.community.kpi.blockedComments"/>
<spring:message var="msg_admin_community_kpi_pendingReports" code="admin.community.kpi.pendingReports"/>
<spring:message var="msg_admin_community_kpi_resolvedReports30d" code="admin.community.kpi.resolvedReports30d"/>
<spring:message var="msg_admin_community_filter_status" code="admin.community.filter.status"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_community_status_active" code="admin.community.status.active"/>
<spring:message var="msg_admin_community_status_blocked" code="admin.community.status.blocked"/>
<spring:message var="msg_admin_community_status_deleted" code="admin.community.status.deleted"/>
<spring:message var="msg_admin_community_filter_type" code="admin.community.filter.type"/>
<spring:message var="msg_admin_community_postType_review" code="admin.community.postType.review"/>
<spring:message var="msg_admin_community_postType_photo" code="admin.community.postType.photo"/>
<spring:message var="msg_admin_community_postType_tip" code="admin.community.postType.tip"/>
<spring:message var="msg_admin_community_postType_question" code="admin.community.postType.question"/>
<spring:message var="msg_admin_community_filter_sort" code="admin.community.filter.sort"/>
<spring:message var="msg_admin_community_sort_createdAt" code="admin.community.sort.createdAt"/>
<spring:message var="msg_admin_community_sort_reportCount" code="admin.community.sort.reportCount"/>
<spring:message var="msg_admin_community_filter_flagged" code="admin.community.filter.flagged"/>
<spring:message var="msg_admin_community_flagged_flagged" code="admin.community.flagged.flagged"/>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_community_searchType_title" code="admin.community.searchType.title"/>
<spring:message var="msg_admin_community_searchType_content" code="admin.community.searchType.content"/>
<spring:message var="msg_admin_community_searchType_nickname" code="admin.community.searchType.nickname"/>
<spring:message var="msg_admin_community_searchType_userId" code="admin.community.searchType.userId"/>
<spring:message var="msg_admin_common_searchButton" code="admin.common.searchButton"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_community_list_postsTitle" code="admin.community.list.postsTitle"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount"/>
<spring:message var="msg_admin_community_action_bulkBlock" code="admin.community.action.bulkBlock"/>
<spring:message var="msg_admin_community_action_bulkDelete" code="admin.community.action.bulkDelete"/>
<spring:message var="msg_admin_community_column_id" code="admin.community.column.id"/>
<spring:message var="msg_admin_community_column_author" code="admin.community.column.author"/>
<spring:message var="msg_admin_community_column_ip" code="admin.community.column.ip"/>
<spring:message var="msg_admin_community_column_title" code="admin.community.column.title"/>
<spring:message var="msg_admin_community_column_type" code="admin.community.column.type"/>
<spring:message var="msg_admin_community_column_reportCount" code="admin.community.column.reportCount"/>
<spring:message var="msg_admin_common_status" code="admin.common.status"/>
<spring:message var="msg_admin_community_column_createdAt" code="admin.community.column.createdAt"/>
<spring:message var="msg_admin_common_action" code="admin.common.action"/>
<spring:message var="msg_admin_community_accountBlocked" code="admin.community.accountBlocked"/>
<spring:message var="msg_admin_community_rowResolved30d" code="admin.community.rowResolved30d"/>
<spring:message var="msg_admin_common_sameValue" code="admin.common.sameValue"/>
<spring:message var="msg_admin_community_action_block" code="admin.community.action.block"/>
<spring:message var="msg_admin_community_action_delete" code="admin.community.action.delete"/>
<spring:message var="msg_admin_common_noResults" code="admin.common.noResults"/>
<spring:message var="msg_admin_common_pageStatus" code="admin.common.pageStatus"/>
<spring:message var="msg_admin_community_viewSite" code="admin.community.viewSite"/>
<c:set var="activeMenu" value="community"/>


<c:set var="pageTitle" value="${msg_admin_community_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 탭 바 ── --%>
    <div class="adm-tabs adm-admin-tabs">
        <a class="adm-tab adm-tab-link active" href="${pageContext.request.contextPath}/admin/community">📝 ${msg_admin_community_tab_posts}</a>
        <a class="adm-tab adm-tab-link" href="${pageContext.request.contextPath}/admin/community/comments">💬 ${msg_admin_community_tab_comments}</a>
    </div>

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_community_kpi_activePosts}</div>
            <div class="adm-summary-value is-primary">${stats.activePosts}</div>
            <div class="adm-summary-sub">${msg_admin_community_kpi_totalPosts}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_community_kpi_blockedPosts}</div>
            <div class="adm-summary-value is-danger">${stats.blockedPosts}</div>
            <div class="adm-summary-sub">${msg_admin_community_kpi_deletedPosts}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_community_kpi_activeComments}</div>
            <div class="adm-summary-value is-success">${stats.activeComments}</div>
            <div class="adm-summary-sub">${msg_admin_community_kpi_blockedComments}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_community_kpi_pendingReports}</div>
            <div class="adm-summary-value is-warning">${stats.pendingReports}</div>
            <div class="adm-summary-sub">${msg_admin_community_kpi_resolvedReports30d}</div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/community" id="searchForm">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
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
                        <div class="adm-filter-label">${msg_admin_community_filter_type}</div>
                        <select class="adm-select" name="postType">
                            <option value="ALL"      ${search.postType=='ALL'      ?'selected':''}>${msg_admin_common_all}</option>
                            <option value="review"   ${search.postType=='review'   ?'selected':''}>${msg_admin_community_postType_review}</option>
                            <option value="photo"    ${search.postType=='photo'    ?'selected':''}>${msg_admin_community_postType_photo}</option>
                            <option value="tip"      ${search.postType=='tip'      ?'selected':''}>${msg_admin_community_postType_tip}</option>
                            <option value="question" ${search.postType=='question' ?'selected':''}>${msg_admin_community_postType_question}</option>
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
                    <div style="flex:1;min-width:200px;">
                        <div class="adm-filter-label">${msg_admin_common_search}</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:110px;">
                                <option value="all"      ${search.searchType=='all'      ?'selected':''}>${msg_admin_common_all}</option>
                                <option value="title"    ${search.searchType=='title'    ?'selected':''}>${msg_admin_community_searchType_title}</option>
                                <option value="content"  ${search.searchType=='content'  ?'selected':''}>${msg_admin_community_searchType_content}</option>
                                <option value="nickname" ${search.searchType=='nickname' ?'selected':''}>${msg_admin_community_searchType_nickname}</option>
                                <option value="userId"   ${search.searchType=='userId'   ?'selected':''}>${msg_admin_community_searchType_userId}</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}"
                                   placeholder="${msg_admin_community_filter_searchPlaceholder}" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_searchButton}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/community">${msg_admin_common_reset}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title">${msg_admin_community_list_postsTitle}</div>
                <div class="adm-muted-note">${msg_admin_common_totalCount}</div>
            </div>
            <%-- 일괄 처리 버튼 --%>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" style="font-size:12px;color:#94a3b8;"></span>
                <button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;"
                        onclick="bulkAction('block')">${msg_admin_community_action_bulkBlock}</button>
                <button class="adm-btn adm-btn-ghost" style="color:#64748b;"
                        onclick="bulkAction('delete')">${msg_admin_community_action_bulkDelete}</button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:60px;">${msg_admin_community_column_id}</th>
                    <th>${msg_admin_community_column_author}</th>
                    <th>${msg_admin_community_column_ip}</th>
                    <th>${msg_admin_community_column_title}</th>
                    <th style="width:80px;">${msg_admin_community_column_type}</th>
                    <th style="width:60px;">${msg_admin_community_column_reportCount}</th>
                    <th style="width:80px;">${msg_admin_common_status}</th>
                    <th style="width:130px;">${msg_admin_community_column_createdAt}</th>
                    <th style="width:100px;">${msg_admin_common_action}</th>
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
                                <span class="adm-inline-danger">${msg_admin_community_accountBlocked}</span>
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
                                    ⚠ ${msg_admin_community_rowResolved30d}
                                </span>
                            </c:if>
                        </td>

                        <%-- 유형 --%>
                        <td style="font-size:12px;color:#94a3b8;white-space:nowrap;">
                            <button type="button" class="adm-cell-link" data-param-name="postType" data-param-value="${p.postType}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${p.postType == 'review'}">${msg_admin_community_postType_review}</c:when>
                                    <c:when test="${p.postType == 'photo'}">${msg_admin_community_postType_photo}</c:when>
                                    <c:when test="${p.postType == 'tip'}">${msg_admin_community_postType_tip}</c:when>
                                    <c:when test="${p.postType == 'question'}">${msg_admin_community_postType_question}</c:when>
                                    <c:otherwise>${p.postType}</c:otherwise>
                                </c:choose></span>
                                <span class="adm-cell-link-note">${msg_admin_common_sameValue}</span>
                            </button>
                        </td>

                        <%-- 신고 수 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/reports?targetType=post&keyword=${p.postId}"
                               class="adm-cell-link adm-cell-link--inline"
                               onclick="event.stopPropagation();">
                                <c:choose>
                                    <c:when test="${p.reportCount >= reportThreshold}">
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
                                    <c:when test="${p.postStatus == 'ACTIVE'}">${msg_admin_community_status_active}</c:when>
                                    <c:when test="${p.postStatus == 'BLOCKED'}">${msg_admin_community_status_blocked}</c:when>
                                    <c:when test="${p.postStatus == 'DELETED'}">${msg_admin_community_status_deleted}</c:when>
                                    <c:otherwise>${p.postStatus}</c:otherwise>
                                </c:choose>
                            </a>
                        </td>

                        <%-- 등록일 --%>
                        <td style="font-size:11px;color:#64748b;white-space:nowrap;">
                            <a href="${pageContext.request.contextPath}/admin/community/posts/${p.postId}"
                               class="adm-cell-link adm-cell-link--inline">
                                <fmt:formatDate value="${p.createdAtDate}" pattern="yyyy.MM.dd HH:mm"/>
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
                                                onclick="actionPost(this.getAttribute('data-id'), 'block')">${msg_admin_community_action_block}</button>
                                        <c:if test="${p.postStatus != 'DELETED'}">
                                            <div class="action-menu-wrap">
                                                <button class="adm-row-btn detail adm-row-btn-more"
                                                        type="button"
                                                        onclick="admToggleActionMenu(this)">⋯</button>
                                                <div class="action-menu">
                                                    <button class="action-menu-item danger"
                                                            type="button"
                                                            data-id="${p.postId}"
                                                            onclick="actionPost(this.getAttribute('data-id'), 'delete')">${msg_admin_community_action_delete}</button>
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
                                                onclick="actionPost(this.getAttribute('data-id'), 'delete')">${msg_admin_community_action_delete}</button>
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
                    <tr><td colspan="10" style="text-align:center;padding:40px;color:#475569;">${msg_admin_common_noResults}</td></tr>
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
                <span class="adm-page-info">${msg_admin_common_pageStatus}</span>
            </div>
        </c:if>
    </div>

    <%-- ── 유저 화면 바로가기 ── --%>
    <div style="margin-top:16px;padding:0 10px;">
        <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/community/list" target="_blank">
            <span class="adm-nav-icon">↗️</span> ${msg_admin_community_viewSite}
        </a>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var COMMUNITY_POST_MSG = {
    noSelection: '${fn:escapeXml(msg_admin_community_message_noSelection)}',
    actionFailed: '${fn:escapeXml(msg_admin_community_message_actionFailed)}',
    confirmPostAction: '${msg_admin_community_confirm_postAction_js}',
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
            <span class="adm-modal-title">${msg_admin_community_authorModal_title}</span>
            <button class="adm-modal-close" onclick="closeAuthorModal()">✕</button>
        </div>
        <div class="adm-modal-body" id="authorModalBody"></div>
    </div>
</div>

<%@ include file="../layout-close.jsp" %>
