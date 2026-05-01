<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="community"/>
<spring:message code="admin.community.detail.pageTitle" var="adminCommunityDetailPageTitle"/>
<spring:message code="admin.community.detail.backToList" var="adminCommunityDetailBackToList"/>
<spring:message code="admin.community.detail.notFound" var="adminCommunityDetailNotFound"/>
<spring:message code="admin.community.detail.warning30d" var="adminCommunityDetailWarning30d"/>
<spring:message code="admin.community.detail.viewOriginal" var="adminCommunityDetailViewOriginal"/>
<spring:message code="admin.community.detail.reportHistory" var="adminCommunityDetailReportHistory"/>
<spring:message code="admin.community.detail.noReports" var="adminCommunityDetailNoReports"/>
<spring:message code="admin.community.detail.noComments" var="adminCommunityDetailNoComments"/>
<spring:message code="admin.community.detail.noIp" var="adminCommunityDetailNoIp"/>
<spring:message code="admin.community.detail.authorInfoTitle" var="adminCommunityDetailAuthorInfoTitle"/>
<spring:message code="admin.community.detail.lastIp" var="adminCommunityDetailLastIp"/>
<spring:message code="admin.community.detail.noRecord" var="adminCommunityDetailNoRecord"/>
<spring:message code="admin.community.detail.accountStatus" var="adminCommunityDetailAccountStatus"/>
<spring:message code="admin.community.detail.recentResolvedTitle" var="adminCommunityDetailRecentResolvedTitle"/>
<spring:message code="admin.community.detail.blockAuthorAccount" var="adminCommunityDetailBlockAuthorAccount"/>
<spring:message code="admin.community.detail.confirmPostAction" var="adminCommunityDetailConfirmPostAction"/>
<spring:message code="admin.community.detail.confirmCommentAction" var="adminCommunityDetailConfirmCommentAction"/>
<spring:message code="admin.community.detail.confirmBlockAuthor" var="adminCommunityDetailConfirmBlockAuthor"/>
<spring:message code="admin.community.detail.actionFailed" var="adminCommunityDetailActionFailed"/>
<c:set var="pageTitle" value="${adminCommunityDetailPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div style="margin-bottom:16px;">
        <a href="${pageContext.request.contextPath}/admin/community"
           class="adm-back-link">← ${adminCommunityDetailBackToList}</a>
    </div>

    <c:if test="${empty post}">
        <div class="adm-card" style="padding:40px;text-align:center;color:#64748b;">
            ${adminCommunityDetailNotFound}
        </div>
    </c:if>

    <c:if test="${not empty post}">

        <%-- ── 30일 경고 배너 ── --%>
        <c:if test="${post.authorResolveCount30d > 0}">
            <div class="adm-warning-box" style="margin-bottom:16px;display:flex;align-items:center;gap:10px;">
                <span style="font-size:18px;">⚠️</span>
                <span style="font-size:14px;">
                    <spring:message code="admin.community.detail.warning30d" arguments="${post.authorResolveCount30d}"/>
                </span>
            </div>
        </c:if>

        <div class="adm-split-layout">

            <%-- ── 왼쪽: 게시글 내용 + 신고 목록 + 댓글 ── --%>
            <div>

                <%-- 게시글 카드 --%>
                <div class="adm-card" style="margin-bottom:20px;">
                    <div class="adm-card-head">
                        <div class="adm-card-title"><spring:message code="admin.community.detail.postTitle" arguments="${post.postId}"/></div>
                        <div style="display:flex;gap:8px;align-items:center;">
                            <span class="status-badge ${post.postStatus}">
                                <c:choose>
                                    <c:when test="${post.postStatus == 'ACTIVE'}"><spring:message code="admin.community.status.active"/></c:when>
                                    <c:when test="${post.postStatus == 'BLOCKED'}"><spring:message code="admin.community.status.blocked"/></c:when>
                                    <c:when test="${post.postStatus == 'DELETED'}"><spring:message code="admin.community.status.deleted"/></c:when>
                                    <c:otherwise>${post.postStatus}</c:otherwise>
                                </c:choose>
                            </span>
                            <c:if test="${post.postStatus != 'DELETED'}">
                                <a href="${pageContext.request.contextPath}/community/${post.postId}"
                                   target="_blank"
                                   class="adm-btn adm-btn-ghost"
                                   style="font-size:12px;text-decoration:none;">${adminCommunityDetailViewOriginal}</a>
                            </c:if>
                            <c:if test="${post.postStatus != 'BLOCKED'}">
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:12px;color:#f87171;border-color:#f87171;"
                                        data-id="${post.postId}"
                                        onclick="actionPost(this.getAttribute('data-id'), 'block')"><spring:message code="admin.community.action.block"/></button>
                            </c:if>
                            <c:if test="${post.postStatus != 'DELETED'}">
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:12px;color:#64748b;"
                                        data-id="${post.postId}"
                                        onclick="actionPost(this.getAttribute('data-id'), 'delete')"><spring:message code="admin.community.action.delete"/></button>
                            </c:if>
                        </div>
                    </div>
                    <div class="adm-card-body">
                        <div style="margin-bottom:8px;">
                            <span class="adm-post-type-badge">
                                <c:choose>
                                    <c:when test="${post.postType == 'review'}"><spring:message code="admin.community.postType.review"/></c:when>
                                    <c:when test="${post.postType == 'photo'}"><spring:message code="admin.community.postType.photo"/></c:when>
                                    <c:when test="${post.postType == 'tip'}"><spring:message code="admin.community.postType.tip"/></c:when>
                                    <c:when test="${post.postType == 'question'}"><spring:message code="admin.community.postType.question"/></c:when>
                                    <c:otherwise>${post.postType}</c:otherwise>
                                </c:choose>
                            </span>
                            <span style="font-size:11px;color:#64748b;">${post.region}</span>
                        </div>
                        <h3 class="adm-detail-title">${post.title}</h3>
                        <div class="adm-tr-inline js-admin-translation-widget"
                             data-label="<spring:message code='admin.translation.label.communityPostTitle'/>"
                             data-source-type="COMMUNITY_POST"
                             data-source-idx="${post.postId}"
                             data-field-name="title"
                             data-default-source-lang="ko"
                             data-source-text="${fn:escapeXml(post.title)}"></div>
                        <div class="adm-detail-body">${post.content}</div>
                        <div class="adm-tr-inline js-admin-translation-widget"
                             data-label="<spring:message code='admin.translation.label.communityPostContent'/>"
                             data-source-type="COMMUNITY_POST"
                             data-source-idx="${post.postId}"
                             data-field-name="content"
                             data-default-source-lang="ko"
                             data-source-text="${fn:escapeXml(post.content)}"></div>
                        <div style="margin-top:16px;padding-top:12px;border-top:1px solid #1e2736;
                                    display:flex;gap:20px;font-size:12px;color:#64748b;">
                            <span>👁 ${post.viewCount}</span>
                            <span>❤ ${post.likeCount}</span>
                            <span>💬 ${post.commentCount}</span>
                            <c:if test="${post.reportCount > 0}">
                                <span style="color:#f87171;">🚨 <spring:message code="admin.community.column.reportCount"/> ${post.reportCount}<spring:message code="admin.common.countSuffix"/></span>
                            </c:if>
                            <span>
                                <fmt:formatDate value="${post.createdAtDate}" type="both" dateStyle="short" timeStyle="short"/>
                            </span>
                        </div>
                    </div>
                </div>

                <%-- 신고 내역 카드 --%>
                <div class="adm-card" style="margin-bottom:20px;">
                    <div class="adm-card-head">
                        <div class="adm-card-title">${adminCommunityDetailReportHistory}</div>
                        <div style="font-size:12px;color:#64748b;">${fn:length(reports)}<spring:message code="admin.common.countSuffix"/></div>
                    </div>
                    <c:choose>
                        <c:when test="${empty reports}">
                            <div style="padding:24px;text-align:center;color:#475569;font-size:13px;">${adminCommunityDetailNoReports}</div>
                        </c:when>
                        <c:otherwise>
                            <div class="adm-table-wrap">
                                <table class="adm-table">
                                    <thead>
                                    <tr>
                                        <th><spring:message code="admin.community.detail.reportId"/></th>
                                        <th><spring:message code="admin.reports.reporter"/></th>
                                        <th><spring:message code="admin.common.reason"/></th>
                                        <th><spring:message code="admin.reports.reportedAt"/></th>
                                        <th><spring:message code="admin.common.status"/></th>
                                        <th><spring:message code="admin.reports.resolvedAt"/></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${reports}" var="r">
                                        <tr>
                                            <td style="color:#64748b;font-size:12px;">
                                                <a class="adm-cell-link adm-cell-link--inline"
                                                   href="${pageContext.request.contextPath}/admin/reports/${r.reportId}">#${r.reportId}</a>
                                            </td>
                                            <td>
                                                <button type="button"
                                                        class="adm-cell-link js-open-member-context"
                                                        data-user-idx="${r.reporterIdx}">
                                                    <span style="font-size:13px;">${r.reporterNickname}</span>
                                                    <span style="font-size:11px;color:#64748b;">${r.reporterUserId}</span>
                                                </button>
                                            </td>
                                            <td style="font-size:12px;">
                                                <a class="adm-cell-link adm-cell-link--inline"
                                                   href="${pageContext.request.contextPath}/admin/reports/${r.reportId}">
                                                <c:choose>
                                                    <c:when test="${r.reason == 'spam'}"><spring:message code="admin.reports.reason.spam"/></c:when>
                                                    <c:when test="${r.reason == 'abuse'}"><spring:message code="admin.reports.reason.abuse"/></c:when>
                                                    <c:when test="${r.reason == 'privacy'}"><spring:message code="admin.reports.reason.privacy"/></c:when>
                                                    <c:when test="${r.reason == 'adult'}"><spring:message code="admin.reports.reason.adult"/></c:when>
                                                    <c:when test="${r.reason == 'illegal'}"><spring:message code="admin.reports.reason.illegal"/></c:when>
                                                    <c:otherwise>${r.reason}</c:otherwise>
                                                </c:choose>
                                                </a>
                                            </td>
                                            <td style="font-size:11px;color:#64748b;">
                                                <a class="adm-cell-link adm-cell-link--inline"
                                                   href="${pageContext.request.contextPath}/admin/reports/${r.reportId}">
                                                <fmt:formatDate value="${r.createdAtDate}" type="both" dateStyle="short" timeStyle="short"/>
                                                </a>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/reports/${r.reportId}"
                                                   class="adm-cell-link adm-cell-link--inline status-badge ${r.status}"
                                                   style="font-size:11px;">
                                                    <c:choose>
                                                        <c:when test="${r.status == 'RESOLVED'}"><spring:message code="admin.reports.status.resolved"/></c:when>
                                                        <c:when test="${r.status == 'DISMISSED'}"><spring:message code="admin.reports.status.dismissed"/></c:when>
                                                        <c:otherwise><spring:message code="admin.community.detail.reportStatusPending"/></c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </td>
                                            <td style="font-size:11px;color:#64748b;">
                                                <a class="adm-cell-link adm-cell-link--inline"
                                                   href="${pageContext.request.contextPath}/admin/reports/${r.reportId}">
                                                <c:choose>
                                                    <c:when test="${not empty r.resolvedAt}">
                                                        <fmt:formatDate value="${r.resolvedAt}" type="both" dateStyle="short" timeStyle="short"/>
                                                        <c:if test="${not empty r.resolveAction}">
                                                            <div style="color:#475569;">${r.resolveAction}</div>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>—</c:otherwise>
                                                </c:choose>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%-- 댓글 목록 카드 --%>
                <div class="adm-card">
                    <div class="adm-card-head">
                        <div class="adm-card-title"><spring:message code="admin.community.detail.commentsTitle"/></div>
                        <div style="font-size:12px;color:#64748b;">${fn:length(comments)}<spring:message code="admin.common.countSuffix"/></div>
                    </div>
                    <c:choose>
                        <c:when test="${empty comments}">
                            <div style="padding:24px;text-align:center;color:#475569;font-size:13px;">${adminCommunityDetailNoComments}</div>
                        </c:when>
                        <c:otherwise>
                            <div style="padding:0 16px 16px;">
                                <c:forEach items="${comments}" var="comment">
                                    <div style="border-bottom:1px solid #1e2736;padding:12px 0;
                                                ${not empty comment.parentCommentId ? 'margin-left:24px;border-left:2px solid #1e2736;padding-left:12px;' : ''}">
                                        <%-- 댓글 헤더 --%>
                                        <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:6px;">
                                            <div style="display:flex;gap:12px;align-items:center;flex-wrap:wrap;">
                                                <div>
                                                    <button type="button"
                                                            class="adm-inline-link js-open-member-context"
                                                            data-user-idx="${comment.userIdx}"
                                                            style="font-weight:600;font-size:13px;">${comment.nickname}</button>
                                                    <button type="button"
                                                            class="adm-inline-link js-open-member-context"
                                                            data-user-idx="${comment.userIdx}"
                                                            style="font-size:11px;color:#64748b;margin-left:6px;">${comment.userId}</button>
                                                </div>
                                                <span style="font-size:10px;color:#94a3b8;font-family:monospace;">
                                                    <c:choose>
                                                        <c:when test="${not empty comment.lastIp}">
                                                            <button type="button"
                                                                    class="adm-inline-link js-open-ip-context"
                                                                    data-ip-address="${comment.lastIp}"
                                                                    data-default-tab="blocks"
                                                                    style="font-size:10px;color:#94a3b8;">${comment.lastIp}</button>
                                                        </c:when>
                                                        <c:otherwise>${adminCommunityDetailNoIp}</c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <c:if test="${comment.accountStatus == 'BLOCKED'}">
                                                    <span class="adm-inline-danger"><spring:message code="admin.community.accountBlocked"/></span>
                                                </c:if>
                                                <c:if test="${comment.authorResolveCount30d > 0}">
                                                    <span class="adm-inline-warning">
                                                        ⚠ <spring:message code="admin.community.rowResolved30d" arguments="${comment.authorResolveCount30d}"/>
                                                    </span>
                                                </c:if>
                                                <span class="status-badge ${comment.commentStatus}" style="font-size:10px;">
                                                    <c:choose>
                                                        <c:when test="${comment.commentStatus == 'ACTIVE'}"><spring:message code="admin.community.status.active"/></c:when>
                                                        <c:when test="${comment.commentStatus == 'BLOCKED'}"><spring:message code="admin.community.status.blocked"/></c:when>
                                                        <c:otherwise>${comment.commentStatus}</c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <c:if test="${comment.reportCount > 0}">
                                                    <span style="font-size:10px;color:#f87171;">🚨 ${comment.reportCount}<spring:message code="admin.common.countSuffix"/></span>
                                                </c:if>
                                            </div>
                                            <%-- 댓글 액션 --%>
                                            <c:choose>
                                                <c:when test="${comment.commentStatus != 'BLOCKED'}">
                                                    <div class="adm-row-actions" style="flex-shrink:0;">
                                                        <button class="adm-row-btn danger"
                                                                type="button"
                                                                data-id="${comment.commentId}"
                                                                onclick="actionComment(this.getAttribute('data-id'), 'block')"><spring:message code="admin.community.action.block"/></button>
                                                        <div class="action-menu-wrap">
                                                            <button class="adm-row-btn detail adm-row-btn-more"
                                                                    type="button"
                                                                    onclick="admToggleActionMenu(this)">⋯</button>
                                                            <div class="action-menu">
                                                                <button class="action-menu-item danger"
                                                                        type="button"
                                                                        data-id="${comment.commentId}"
                                                                        onclick="actionComment(this.getAttribute('data-id'), 'delete')"><spring:message code="admin.community.action.delete"/></button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="adm-row-actions is-single" style="flex-shrink:0;">
                                                        <button class="adm-row-btn danger"
                                                                type="button"
                                                                data-id="${comment.commentId}"
                                                                onclick="actionComment(this.getAttribute('data-id'), 'delete')"><spring:message code="admin.community.action.delete"/></button>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <%-- 댓글 내용 --%>
                                        <div style="font-size:13px;color:#cbd5e1;line-height:1.6;">${comment.content}</div>
                                        <c:if test="${not empty comment.content}">
                                            <div class="adm-tr-inline js-admin-translation-widget"
                                                 data-label="<spring:message code='admin.translation.label.communityCommentContent'/>"
                                                 data-source-type="COMMUNITY_COMMENT"
                                                 data-source-idx="${comment.commentId}"
                                                 data-field-name="content"
                                                 data-default-source-lang="ko"
                                                 data-source-text="${fn:escapeXml(comment.content)}"></div>
                                        </c:if>
                                        <div style="font-size:11px;color:#475569;margin-top:4px;">
                                            <fmt:formatDate value="${comment.createdAtDate}" type="both" dateStyle="short" timeStyle="short"/>
                                            <c:if test="${not empty comment.parentCommentId}">
                                                <span style="margin-left:8px;color:#334155;">↩ <spring:message code="admin.community.kind.reply"/></span>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <%-- ── 오른쪽: 작성자 정보 ── --%>
            <div>
                <div class="adm-card adm-side-sticky">
                    <div class="adm-card-head">
                        <div class="adm-card-title">${adminCommunityDetailAuthorInfoTitle}</div>
                    </div>
                    <div class="adm-card-body">
                        <div class="adm-side-section">

                            <div>
                                <div style="font-size:11px;color:#64748b;margin-bottom:2px;"><spring:message code="admin.common.userId"/></div>
                                <button type="button"
                                        class="adm-inline-link js-open-member-context"
                                        data-user-idx="${post.userIdx}"
                                        style="font-size:14px;font-weight:600;">${post.userId}</button>
                            </div>

                            <div>
                                <div style="font-size:11px;color:#64748b;margin-bottom:2px;"><spring:message code="admin.common.nickname"/></div>
                                <button type="button"
                                        class="adm-inline-link js-open-member-context"
                                        data-user-idx="${post.userIdx}"
                                        style="font-size:14px;font-weight:600;">${post.nickname}</button>
                            </div>

                            <div>
                                <div style="font-size:11px;color:#64748b;margin-bottom:2px;">${adminCommunityDetailLastIp}</div>
                                <div style="font-size:13px;font-family:monospace;color:#94a3b8;">
                                    <c:choose>
                                        <c:when test="${not empty post.lastIp}">
                                            <button type="button"
                                                    class="adm-inline-link js-open-ip-context"
                                                    data-ip-address="${post.lastIp}"
                                                    data-default-tab="blocks">${post.lastIp}</button>
                                        </c:when>
                                        <c:otherwise><span style="color:#475569;">${adminCommunityDetailNoRecord}</span></c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div>
                                <div style="font-size:11px;color:#64748b;margin-bottom:2px;">${adminCommunityDetailAccountStatus}</div>
                                <span class="status-badge ${post.accountStatus}">
                                    <c:choose>
                                        <c:when test="${post.accountStatus == 'ACTIVE'}"><spring:message code="admin.community.detail.accountStatus.active"/></c:when>
                                        <c:when test="${post.accountStatus == 'BLOCKED'}"><spring:message code="admin.community.detail.accountStatus.blocked"/></c:when>
                                        <c:when test="${post.accountStatus == 'DORMANT'}"><spring:message code="admin.community.detail.accountStatus.dormant"/></c:when>
                                        <c:when test="${post.accountStatus == 'DELETED'}"><spring:message code="admin.community.detail.accountStatus.deleted"/></c:when>
                                        <c:otherwise>${post.accountStatus}</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <c:if test="${post.authorResolveCount30d > 0}">
                                <div class="adm-warning-box">
                                    <div style="font-size:11px;font-weight:600;margin-bottom:4px;">⚠ ${adminCommunityDetailRecentResolvedTitle}</div>
                                    <div style="font-size:13px;"><spring:message code="admin.community.detail.recentResolvedCount" arguments="${post.authorResolveCount30d}"/></div>
                                </div>
                            </c:if>

                            <div class="adm-meta-actions adm-action-stack">
                                <a href="${pageContext.request.contextPath}/admin/members?searchType=userId&keyword=${post.userId}"
                                   class="adm-btn adm-btn-ghost adm-link-button" style="font-size:12px;">
                                    <spring:message code="admin.common.memberInfoView"/>
                                </a>
                                <c:if test="${post.accountStatus != 'BLOCKED'}">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:12px;color:#f87171;border-color:#f87171;"
                                            data-useridx="${post.userIdx}"
                                            onclick="blockUser(this.getAttribute('data-useridx'))">
                                        ${adminCommunityDetailBlockAuthorAccount}
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </c:if>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var COMMUNITY_DETAIL_MSG = {
    confirmPostAction: '${fn:escapeXml(adminCommunityDetailConfirmPostAction)}',
    confirmCommentAction: '${fn:escapeXml(adminCommunityDetailConfirmCommentAction)}',
    confirmBlockAuthor: '${fn:escapeXml(adminCommunityDetailConfirmBlockAuthor)}',
    actionFailed: '${fn:escapeXml(adminCommunityDetailActionFailed)}',
    block: '<spring:message code="admin.community.action.block" javaScriptEscape="true"/>',
    delete: '<spring:message code="admin.community.action.delete" javaScriptEscape="true"/>'
};

function actionPost(postId, action) {
    var label = action === 'block' ? COMMUNITY_DETAIL_MSG.block : COMMUNITY_DETAIL_MSG.delete;
    if (!confirm(COMMUNITY_DETAIL_MSG.confirmPostAction.replace('{0}', label))) return;
    fetch(ctx + '/admin/community/posts/' + postId + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COMMUNITY_DETAIL_MSG.actionFailed); }
    });
}

function actionComment(commentId, action) {
    var label = action === 'block' ? COMMUNITY_DETAIL_MSG.block : COMMUNITY_DETAIL_MSG.delete;
    if (!confirm(COMMUNITY_DETAIL_MSG.confirmCommentAction.replace('{0}', label))) return;
    fetch(ctx + '/admin/community/comments/' + commentId + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COMMUNITY_DETAIL_MSG.actionFailed); }
    });
}

function blockUser(userIdx) {
    if (!confirm(COMMUNITY_DETAIL_MSG.confirmBlockAuthor)) return;
    fetch(ctx + '/admin/community/users/' + userIdx + '/block', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COMMUNITY_DETAIL_MSG.actionFailed); }
    });
}
</script>

<%@ include file="../layout-close.jsp" %>
