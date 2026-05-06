<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_translation_label_communityPostTitle" code="admin.translation.label.communityPostTitle"/>
<spring:message var="msg_admin_translation_label_communityPostContent" code="admin.translation.label.communityPostContent"/>
<spring:message var="msg_admin_translation_label_communityCommentContent" code="admin.translation.label.communityCommentContent"/>
<spring:message var="msg_admin_community_action_block_js" code="admin.community.action.block" javaScriptEscape="true"/>
<spring:message var="msg_admin_community_action_delete_js" code="admin.community.action.delete" javaScriptEscape="true"/>
<spring:message var="msg_admin_community_detail_pageTitle" code="admin.community.detail.pageTitle"/>
<spring:message var="msg_admin_community_detail_backToList" code="admin.community.detail.backToList"/>
<spring:message var="msg_admin_community_detail_notFound" code="admin.community.detail.notFound"/>
<spring:message var="msg_admin_community_detail_warning30d" code="admin.community.detail.warning30d"/>
<spring:message var="msg_admin_community_detail_viewOriginal" code="admin.community.detail.viewOriginal"/>
<spring:message var="msg_admin_community_detail_reportHistory" code="admin.community.detail.reportHistory"/>
<spring:message var="msg_admin_community_detail_noReports" code="admin.community.detail.noReports"/>
<spring:message var="msg_admin_community_detail_noComments" code="admin.community.detail.noComments"/>
<spring:message var="msg_admin_community_detail_noIp" code="admin.community.detail.noIp"/>
<spring:message var="msg_admin_community_detail_authorInfoTitle" code="admin.community.detail.authorInfoTitle"/>
<spring:message var="msg_admin_community_detail_lastIp" code="admin.community.detail.lastIp"/>
<spring:message var="msg_admin_community_detail_noRecord" code="admin.community.detail.noRecord"/>
<spring:message var="msg_admin_community_detail_accountStatus" code="admin.community.detail.accountStatus"/>
<spring:message var="msg_admin_community_detail_recentResolvedTitle" code="admin.community.detail.recentResolvedTitle"/>
<spring:message var="msg_admin_community_detail_blockAuthorAccount" code="admin.community.detail.blockAuthorAccount"/>
<spring:message var="msg_admin_community_detail_confirmPostAction" code="admin.community.detail.confirmPostAction"/>
<spring:message var="msg_admin_community_detail_confirmCommentAction" code="admin.community.detail.confirmCommentAction"/>
<spring:message var="msg_admin_community_detail_confirmBlockAuthor" code="admin.community.detail.confirmBlockAuthor"/>
<spring:message var="msg_admin_community_detail_actionFailed" code="admin.community.detail.actionFailed"/>
<spring:message var="msg_admin_community_detail_postTitle" code="admin.community.detail.postTitle"/>
<spring:message var="msg_admin_community_status_active" code="admin.community.status.active"/>
<spring:message var="msg_admin_community_status_blocked" code="admin.community.status.blocked"/>
<spring:message var="msg_admin_community_status_deleted" code="admin.community.status.deleted"/>
<spring:message var="msg_admin_community_action_block" code="admin.community.action.block"/>
<spring:message var="msg_admin_community_action_delete" code="admin.community.action.delete"/>
<spring:message var="msg_admin_community_postType_review" code="admin.community.postType.review"/>
<spring:message var="msg_admin_community_postType_photo" code="admin.community.postType.photo"/>
<spring:message var="msg_admin_community_postType_tip" code="admin.community.postType.tip"/>
<spring:message var="msg_admin_community_postType_question" code="admin.community.postType.question"/>
<spring:message var="msg_admin_community_column_reportCount" code="admin.community.column.reportCount"/>
<spring:message var="msg_admin_common_countSuffix" code="admin.common.countSuffix"/>
<spring:message var="msg_admin_community_detail_reportId" code="admin.community.detail.reportId"/>
<spring:message var="msg_admin_reports_reporter" code="admin.reports.reporter"/>
<spring:message var="msg_admin_common_reason" code="admin.common.reason"/>
<spring:message var="msg_admin_reports_reportedAt" code="admin.reports.reportedAt"/>
<spring:message var="msg_admin_common_status" code="admin.common.status"/>
<spring:message var="msg_admin_reports_resolvedAt" code="admin.reports.resolvedAt"/>
<spring:message var="msg_admin_reports_reason_spam" code="admin.reports.reason.spam"/>
<spring:message var="msg_admin_reports_reason_abuse" code="admin.reports.reason.abuse"/>
<spring:message var="msg_admin_reports_reason_privacy" code="admin.reports.reason.privacy"/>
<spring:message var="msg_admin_reports_reason_adult" code="admin.reports.reason.adult"/>
<spring:message var="msg_admin_reports_reason_illegal" code="admin.reports.reason.illegal"/>
<spring:message var="msg_admin_reports_status_resolved" code="admin.reports.status.resolved"/>
<spring:message var="msg_admin_reports_status_dismissed" code="admin.reports.status.dismissed"/>
<spring:message var="msg_admin_community_detail_reportStatusPending" code="admin.community.detail.reportStatusPending"/>
<spring:message var="msg_admin_community_detail_commentsTitle" code="admin.community.detail.commentsTitle"/>
<spring:message var="msg_admin_community_accountBlocked" code="admin.community.accountBlocked"/>
<spring:message var="msg_admin_community_rowResolved30d" code="admin.community.rowResolved30d"/>
<spring:message var="msg_admin_community_kind_reply" code="admin.community.kind.reply"/>
<spring:message var="msg_admin_common_userId" code="admin.common.userId"/>
<spring:message var="msg_admin_common_nickname" code="admin.common.nickname"/>
<spring:message var="msg_admin_community_detail_accountStatus_active" code="admin.community.detail.accountStatus.active"/>
<spring:message var="msg_admin_community_detail_accountStatus_blocked" code="admin.community.detail.accountStatus.blocked"/>
<spring:message var="msg_admin_community_detail_accountStatus_dormant" code="admin.community.detail.accountStatus.dormant"/>
<spring:message var="msg_admin_community_detail_accountStatus_deleted" code="admin.community.detail.accountStatus.deleted"/>
<spring:message var="msg_admin_community_detail_recentResolvedCount" code="admin.community.detail.recentResolvedCount"/>
<spring:message var="msg_admin_common_memberInfoView" code="admin.common.memberInfoView"/>
<c:set var="activeMenu" value="community"/>


<c:set var="pageTitle" value="${msg_admin_community_detail_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div style="margin-bottom:16px;">
        <a href="${pageContext.request.contextPath}/admin/community"
           class="adm-back-link">← ${msg_admin_community_detail_backToList}</a>
    </div>

    <c:if test="${empty post}">
        <div class="adm-card" style="padding:40px;text-align:center;color:#64748b;">
            ${msg_admin_community_detail_notFound}
        </div>
    </c:if>

    <c:if test="${not empty post}">

        <%-- ── 30일 경고 배너 ── --%>
        <c:if test="${post.authorResolveCount30d > 0}">
            <div class="adm-warning-box" style="margin-bottom:16px;display:flex;align-items:center;gap:10px;">
                <span style="font-size:18px;">⚠️</span>
                <span style="font-size:14px;">
                    <spring:message var="msg_admin_community_detail_warning30d_args_post_authorResolveCount30d" code="admin.community.detail.warning30d" arguments="${post.authorResolveCount30d}"/>${msg_admin_community_detail_warning30d_args_post_authorResolveCount30d}
                </span>
            </div>
        </c:if>

        <div class="adm-split-layout">

            <%-- ── 왼쪽: 게시글 내용 + 신고 목록 + 댓글 ── --%>
            <div>

                <%-- 게시글 카드 --%>
                <div class="adm-card" style="margin-bottom:20px;">
                    <div class="adm-card-head">
                        <div class="adm-card-title">${msg_admin_community_detail_postTitle}</div>
                        <div style="display:flex;gap:8px;align-items:center;">
                            <span class="status-badge ${post.postStatus}">
                                <c:choose>
                                    <c:when test="${post.postStatus == 'ACTIVE'}">${msg_admin_community_status_active}</c:when>
                                    <c:when test="${post.postStatus == 'BLOCKED'}">${msg_admin_community_status_blocked}</c:when>
                                    <c:when test="${post.postStatus == 'DELETED'}">${msg_admin_community_status_deleted}</c:when>
                                    <c:otherwise>${post.postStatus}</c:otherwise>
                                </c:choose>
                            </span>
                            <c:if test="${post.postStatus != 'DELETED'}">
                                <a href="${pageContext.request.contextPath}/community/${post.postId}"
                                   target="_blank"
                                   class="adm-btn adm-btn-ghost"
                                   style="font-size:12px;text-decoration:none;">${msg_admin_community_detail_viewOriginal}</a>
                            </c:if>
                            <c:if test="${post.postStatus != 'BLOCKED'}">
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:12px;color:#f87171;border-color:#f87171;"
                                        data-id="${post.postId}"
                                        onclick="actionPost(this.getAttribute('data-id'), 'block')">${msg_admin_community_action_block}</button>
                            </c:if>
                            <c:if test="${post.postStatus != 'DELETED'}">
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:12px;color:#64748b;"
                                        data-id="${post.postId}"
                                        onclick="actionPost(this.getAttribute('data-id'), 'delete')">${msg_admin_community_action_delete}</button>
                            </c:if>
                        </div>
                    </div>
                    <div class="adm-card-body">
                        <div style="margin-bottom:8px;">
                            <span class="adm-post-type-badge">
                                <c:choose>
                                    <c:when test="${post.postType == 'review'}">${msg_admin_community_postType_review}</c:when>
                                    <c:when test="${post.postType == 'photo'}">${msg_admin_community_postType_photo}</c:when>
                                    <c:when test="${post.postType == 'tip'}">${msg_admin_community_postType_tip}</c:when>
                                    <c:when test="${post.postType == 'question'}">${msg_admin_community_postType_question}</c:when>
                                    <c:otherwise>${post.postType}</c:otherwise>
                                </c:choose>
                            </span>
                            <span style="font-size:11px;color:#64748b;">${post.region}</span>
                        </div>
                        <h3 class="adm-detail-title">${post.title}</h3>
                        <div class="adm-tr-inline js-admin-translation-widget"
                             data-label="${msg_admin_translation_label_communityPostTitle}"
                             data-source-type="COMMUNITY_POST"
                             data-source-idx="${post.postId}"
                             data-field-name="title"
                             data-default-source-lang="ko"
                             data-source-text="${fn:escapeXml(post.title)}"></div>
                        <div class="adm-detail-body">${post.content}</div>
                        <div class="adm-tr-inline js-admin-translation-widget"
                             data-label="${msg_admin_translation_label_communityPostContent}"
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
                                <span style="color:#f87171;">🚨 ${msg_admin_community_column_reportCount} ${post.reportCount}${msg_admin_common_countSuffix}</span>
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
                        <div class="adm-card-title">${msg_admin_community_detail_reportHistory}</div>
                        <div style="font-size:12px;color:#64748b;">${fn:length(reports)}${msg_admin_common_countSuffix}</div>
                    </div>
                    <c:choose>
                        <c:when test="${empty reports}">
                            <div style="padding:24px;text-align:center;color:#475569;font-size:13px;">${msg_admin_community_detail_noReports}</div>
                        </c:when>
                        <c:otherwise>
                            <div class="adm-table-wrap">
                                <table class="adm-table">
                                    <thead>
                                    <tr>
                                        <th>${msg_admin_community_detail_reportId}</th>
                                        <th>${msg_admin_reports_reporter}</th>
                                        <th>${msg_admin_common_reason}</th>
                                        <th>${msg_admin_reports_reportedAt}</th>
                                        <th>${msg_admin_common_status}</th>
                                        <th>${msg_admin_reports_resolvedAt}</th>
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
                                                    <c:when test="${r.reason == 'spam'}">${msg_admin_reports_reason_spam}</c:when>
                                                    <c:when test="${r.reason == 'abuse'}">${msg_admin_reports_reason_abuse}</c:when>
                                                    <c:when test="${r.reason == 'privacy'}">${msg_admin_reports_reason_privacy}</c:when>
                                                    <c:when test="${r.reason == 'adult'}">${msg_admin_reports_reason_adult}</c:when>
                                                    <c:when test="${r.reason == 'illegal'}">${msg_admin_reports_reason_illegal}</c:when>
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
                                                        <c:when test="${r.status == 'RESOLVED'}">${msg_admin_reports_status_resolved}</c:when>
                                                        <c:when test="${r.status == 'DISMISSED'}">${msg_admin_reports_status_dismissed}</c:when>
                                                        <c:otherwise>${msg_admin_community_detail_reportStatusPending}</c:otherwise>
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
                        <div class="adm-card-title">${msg_admin_community_detail_commentsTitle}</div>
                        <div style="font-size:12px;color:#64748b;">${fn:length(comments)}${msg_admin_common_countSuffix}</div>
                    </div>
                    <c:choose>
                        <c:when test="${empty comments}">
                            <div style="padding:24px;text-align:center;color:#475569;font-size:13px;">${msg_admin_community_detail_noComments}</div>
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
                                                        <c:otherwise>${msg_admin_community_detail_noIp}</c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <c:if test="${comment.accountStatus == 'BLOCKED'}">
                                                    <span class="adm-inline-danger">${msg_admin_community_accountBlocked}</span>
                                                </c:if>
                                                <c:if test="${comment.authorResolveCount30d > 0}">
                                                    <span class="adm-inline-warning">
                                                        ⚠ ${msg_admin_community_rowResolved30d}
                                                    </span>
                                                </c:if>
                                                <span class="status-badge ${comment.commentStatus}" style="font-size:10px;">
                                                    <c:choose>
                                                        <c:when test="${comment.commentStatus == 'ACTIVE'}">${msg_admin_community_status_active}</c:when>
                                                        <c:when test="${comment.commentStatus == 'BLOCKED'}">${msg_admin_community_status_blocked}</c:when>
                                                        <c:otherwise>${comment.commentStatus}</c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <c:if test="${comment.reportCount > 0}">
                                                    <span style="font-size:10px;color:#f87171;">🚨 ${comment.reportCount}${msg_admin_common_countSuffix}</span>
                                                </c:if>
                                            </div>
                                            <%-- 댓글 액션 --%>
                                            <c:choose>
                                                <c:when test="${comment.commentStatus != 'BLOCKED'}">
                                                    <div class="adm-row-actions" style="flex-shrink:0;">
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
                                                    <div class="adm-row-actions is-single" style="flex-shrink:0;">
                                                        <button class="adm-row-btn danger"
                                                                type="button"
                                                                data-id="${comment.commentId}"
                                                                onclick="actionComment(this.getAttribute('data-id'), 'delete')">${msg_admin_community_action_delete}</button>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <%-- 댓글 내용 --%>
                                        <div style="font-size:13px;color:#cbd5e1;line-height:1.6;">${comment.content}</div>
                                        <c:if test="${not empty comment.content}">
                                            <div class="adm-tr-inline js-admin-translation-widget"
                                                 data-label="${msg_admin_translation_label_communityCommentContent}"
                                                 data-source-type="COMMUNITY_COMMENT"
                                                 data-source-idx="${comment.commentId}"
                                                 data-field-name="content"
                                                 data-default-source-lang="ko"
                                                 data-source-text="${fn:escapeXml(comment.content)}"></div>
                                        </c:if>
                                        <div style="font-size:11px;color:#475569;margin-top:4px;">
                                            <fmt:formatDate value="${comment.createdAtDate}" type="both" dateStyle="short" timeStyle="short"/>
                                            <c:if test="${not empty comment.parentCommentId}">
                                                <span style="margin-left:8px;color:#334155;">↩ ${msg_admin_community_kind_reply}</span>
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
                        <div class="adm-card-title">${msg_admin_community_detail_authorInfoTitle}</div>
                    </div>
                    <div class="adm-card-body">
                        <div class="adm-side-section">

                            <div>
                                <div style="font-size:11px;color:#64748b;margin-bottom:2px;">${msg_admin_common_userId}</div>
                                <button type="button"
                                        class="adm-inline-link js-open-member-context"
                                        data-user-idx="${post.userIdx}"
                                        style="font-size:14px;font-weight:600;">${post.userId}</button>
                            </div>

                            <div>
                                <div style="font-size:11px;color:#64748b;margin-bottom:2px;">${msg_admin_common_nickname}</div>
                                <button type="button"
                                        class="adm-inline-link js-open-member-context"
                                        data-user-idx="${post.userIdx}"
                                        style="font-size:14px;font-weight:600;">${post.nickname}</button>
                            </div>

                            <div>
                                <div style="font-size:11px;color:#64748b;margin-bottom:2px;">${msg_admin_community_detail_lastIp}</div>
                                <div style="font-size:13px;font-family:monospace;color:#94a3b8;">
                                    <c:choose>
                                        <c:when test="${not empty post.lastIp}">
                                            <button type="button"
                                                    class="adm-inline-link js-open-ip-context"
                                                    data-ip-address="${post.lastIp}"
                                                    data-default-tab="blocks">${post.lastIp}</button>
                                        </c:when>
                                        <c:otherwise><span style="color:#475569;">${msg_admin_community_detail_noRecord}</span></c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div>
                                <div style="font-size:11px;color:#64748b;margin-bottom:2px;">${msg_admin_community_detail_accountStatus}</div>
                                <span class="status-badge ${post.accountStatus}">
                                    <c:choose>
                                        <c:when test="${post.accountStatus == 'ACTIVE'}">${msg_admin_community_detail_accountStatus_active}</c:when>
                                        <c:when test="${post.accountStatus == 'BLOCKED'}">${msg_admin_community_detail_accountStatus_blocked}</c:when>
                                        <c:when test="${post.accountStatus == 'DORMANT'}">${msg_admin_community_detail_accountStatus_dormant}</c:when>
                                        <c:when test="${post.accountStatus == 'DELETED'}">${msg_admin_community_detail_accountStatus_deleted}</c:when>
                                        <c:otherwise>${post.accountStatus}</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <c:if test="${post.authorResolveCount30d > 0}">
                                <div class="adm-warning-box">
                                    <div style="font-size:11px;font-weight:600;margin-bottom:4px;">⚠ ${msg_admin_community_detail_recentResolvedTitle}</div>
                                    <div style="font-size:13px;">${msg_admin_community_detail_recentResolvedCount}</div>
                                </div>
                            </c:if>

                            <div class="adm-meta-actions adm-action-stack">
                                <a href="${pageContext.request.contextPath}/admin/members?searchType=userId&keyword=${post.userId}"
                                   class="adm-btn adm-btn-ghost adm-link-button" style="font-size:12px;">
                                    ${msg_admin_common_memberInfoView}
                                </a>
                                <c:if test="${post.accountStatus != 'BLOCKED'}">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:12px;color:#f87171;border-color:#f87171;"
                                            data-useridx="${post.userIdx}"
                                            onclick="blockUser(this.getAttribute('data-useridx'))">
                                        ${msg_admin_community_detail_blockAuthorAccount}
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
    confirmPostAction: '${fn:escapeXml(msg_admin_community_detail_confirmPostAction)}',
    confirmCommentAction: '${fn:escapeXml(msg_admin_community_detail_confirmCommentAction)}',
    confirmBlockAuthor: '${fn:escapeXml(msg_admin_community_detail_confirmBlockAuthor)}',
    actionFailed: '${fn:escapeXml(msg_admin_community_detail_actionFailed)}',
    block: '${msg_admin_community_action_block_js}',
    delete: '${msg_admin_community_action_delete_js}'
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
