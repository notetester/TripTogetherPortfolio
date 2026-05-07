<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_translation_label_reportTargetTitle" code="admin.translation.label.reportTargetTitle"/>
<spring:message var="msg_admin_translation_label_reportTargetContent" code="admin.translation.label.reportTargetContent"/>
<spring:message var="msg_admin_translation_label_reportReviewContent" code="admin.translation.label.reportReviewContent"/>
<spring:message var="msg_admin_translation_label_reportDescription" code="admin.translation.label.reportDescription"/>
<spring:message var="msg_admin_reports_detail_pageTitle" code="admin.reports.detail.pageTitle"/>
<spring:message var="msg_admin_reports_detail_backToList" code="admin.reports.detail.backToList"/>
<spring:message var="msg_admin_reports_detail_reporterInfoTitle" code="admin.reports.detail.reporterInfoTitle"/>
<spring:message var="msg_admin_reports_detail_processingTitle" code="admin.reports.detail.processingTitle"/>
<spring:message var="msg_admin_reports_detail_confirmRejected" code="admin.reports.detail.confirmRejected"/>
<spring:message var="msg_admin_reports_detail_confirmDeleteContent" code="admin.reports.detail.confirmDeleteContent"/>
<spring:message var="msg_admin_reports_detail_confirmBlockAuthor" code="admin.reports.detail.confirmBlockAuthor"/>
<spring:message var="msg_admin_reports_detail_confirmBlockUser" code="admin.reports.detail.confirmBlockUser"/>
<spring:message var="msg_admin_reports_detail_confirmDeleteAndBlock" code="admin.reports.detail.confirmDeleteAndBlock"/>
<spring:message var="msg_admin_reports_detail_confirmDeleteAndBlockReview" code="admin.reports.detail.confirmDeleteAndBlockReview"/>
<spring:message var="msg_admin_reports_detail_confirmDeleteReview" code="admin.reports.detail.confirmDeleteReview"/>
<spring:message var="msg_admin_reports_detail_confirmRevert" code="admin.reports.detail.confirmRevert"/>
<spring:message var="msg_admin_reports_detail_processFailed" code="admin.reports.detail.processFailed"/>
<spring:message var="msg_admin_reports_detail_title" code="admin.reports.detail.title"/>
<spring:message var="msg_admin_reports_status_inReview" code="admin.reports.status.inReview"/>
<spring:message var="msg_admin_reports_status_resolved" code="admin.reports.status.resolved"/>
<spring:message var="msg_admin_reports_status_dismissed" code="admin.reports.status.dismissed"/>
<spring:message var="msg_admin_reports_detail_viewOriginal" code="admin.reports.detail.viewOriginal"/>
<spring:message var="msg_admin_reports_detail_viewSpot" code="admin.reports.detail.viewSpot"/>
<spring:message var="msg_admin_reports_detail_reportTarget" code="admin.reports.detail.reportTarget"/>
<spring:message var="msg_admin_reports_target_post" code="admin.reports.target.post"/>
<spring:message var="msg_admin_layout_menu_community" code="admin.layout.menu.community"/>
<spring:message var="msg_admin_reports_target_comment" code="admin.reports.target.comment"/>
<spring:message var="msg_admin_reports_target_review" code="admin.reports.target.review"/>
<spring:message var="msg_admin_layout_menu_explore" code="admin.layout.menu.explore"/>
<spring:message var="msg_admin_reports_target_user" code="admin.reports.target.user"/>
<spring:message var="msg_admin_common_member" code="admin.common.member"/>
<spring:message var="msg_admin_reports_targetBlocked" code="admin.reports.targetBlocked"/>
<spring:message var="msg_admin_reports_targetDeleted" code="admin.reports.targetDeleted"/>
<spring:message var="msg_admin_common_viewTarget" code="admin.common.viewTarget"/>
<spring:message var="msg_admin_common_sameTarget" code="admin.common.sameTarget"/>
<spring:message var="msg_admin_common_viewDetail" code="admin.common.viewDetail"/>
<spring:message var="msg_admin_common_viewSpot" code="admin.common.viewSpot"/>
<spring:message var="msg_admin_common_title" code="admin.common.title"/>
<spring:message var="msg_admin_reports_detail_commentBody" code="admin.reports.detail.commentBody"/>
<spring:message var="msg_admin_reports_detail_spot" code="admin.reports.detail.spot"/>
<spring:message var="msg_admin_reports_detail_reviewBody" code="admin.reports.detail.reviewBody"/>
<spring:message var="msg_admin_common_reason" code="admin.common.reason"/>
<spring:message var="msg_admin_reports_reason_spam" code="admin.reports.reason.spam"/>
<spring:message var="msg_admin_reports_reason_abuse" code="admin.reports.reason.abuse"/>
<spring:message var="msg_admin_reports_reason_privacy" code="admin.reports.reason.privacy"/>
<spring:message var="msg_admin_reports_reason_adult" code="admin.reports.reason.adult"/>
<spring:message var="msg_admin_reports_reason_illegal" code="admin.reports.reason.illegal"/>
<spring:message var="msg_admin_reports_reason_other" code="admin.reports.reason.other"/>
<spring:message var="msg_admin_reports_reason_user" code="admin.reports.reason.user"/>
<spring:message var="msg_admin_common_description" code="admin.common.description"/>
<spring:message var="msg_admin_reports_detail_sameTargetReports" code="admin.reports.detail.sameTargetReports"/>
<spring:message var="msg_admin_common_countSuffix" code="admin.common.countSuffix"/>
<spring:message var="msg_admin_reports_reportedAt" code="admin.reports.reportedAt"/>
<spring:message var="msg_admin_reports_resolvedAt" code="admin.reports.resolvedAt"/>
<spring:message var="msg_admin_reports_detail_resolveAction" code="admin.reports.detail.resolveAction"/>
<spring:message var="msg_admin_common_userId" code="admin.common.userId"/>
<spring:message var="msg_admin_common_nickname" code="admin.common.nickname"/>
<spring:message var="msg_admin_common_memberInfoView" code="admin.common.memberInfoView"/>
<spring:message var="msg_admin_common_sameReporter" code="admin.common.sameReporter"/>
<spring:message var="msg_admin_reports_detail_rejectKeepContent" code="admin.reports.detail.rejectKeepContent"/>
<spring:message var="msg_admin_reports_detail_blockReview" code="admin.reports.detail.blockReview"/>
<spring:message var="msg_admin_reports_detail_deleteContent" code="admin.reports.detail.deleteContent"/>
<spring:message var="msg_admin_reports_detail_blockAuthor" code="admin.reports.detail.blockAuthor"/>
<spring:message var="msg_admin_reports_detail_blockReviewAndAuthor" code="admin.reports.detail.blockReviewAndAuthor"/>
<spring:message var="msg_admin_reports_detail_deleteAndBlockAuthor" code="admin.reports.detail.deleteAndBlockAuthor"/>
<spring:message var="msg_admin_reports_detail_rejectKeepUser" code="admin.reports.detail.rejectKeepUser"/>
<spring:message var="msg_admin_reports_detail_blockUser" code="admin.reports.detail.blockUser"/>
<spring:message var="msg_admin_reports_detail_revertToPending" code="admin.reports.detail.revertToPending"/>
<c:set var="activeMenu" value="reports"/>


<c:set var="pageTitle" value="${msg_admin_reports_detail_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content adm-report-page">
    <div class="adm-report-back-row">
        <a href="javascript:goBackToList()" class="adm-back-link">← ${msg_admin_reports_detail_backToList}</a>
    </div>

    <div class="adm-split-layout">

        <%-- ── 왼쪽: 신고 내용 ── --%>
        <div>
            <div class="adm-card">
                <div class="adm-card-head">
                    <div class="adm-card-title">${msg_admin_reports_detail_title}</div>
                    <div class="adm-report-detail-head-actions">
                        <span class="status-badge ${report.status}">
                            <c:choose>
                                <c:when test="${report.status eq 'IN_REVIEW'}">${msg_admin_reports_status_inReview}</c:when>
                                <c:when test="${report.status eq 'RESOLVED'}">${msg_admin_reports_status_resolved}</c:when>
                                <c:when test="${report.status eq 'DISMISSED'}">${msg_admin_reports_status_dismissed}</c:when>
                                <c:otherwise>${report.status}</c:otherwise>
                            </c:choose>
                        </span>
                        <%-- post: 게시글 / comment: 원글 게시글 / review: 스팟 상세 --%>
                        <%-- 원글이 삭제된 경우(targetStatus=DELETED) 링크 숨김 --%>
                        <c:if test="${report.targetType eq 'post' and report.targetStatus ne 'DELETED'}">
                            <a href="${pageContext.request.contextPath}/community/${report.targetId}"
                               target="_blank"
                               class="adm-btn adm-btn-ghost adm-report-small-btn">${msg_admin_reports_detail_viewOriginal}</a>
                        </c:if>
                        <c:if test="${report.targetType eq 'comment' and report.targetStatus ne 'DELETED'}">
                            <a href="${pageContext.request.contextPath}/community/${empty report.sourceId ? report.targetPostId : report.sourceId}"
                               target="_blank"
                               class="adm-btn adm-btn-ghost adm-report-small-btn">${msg_admin_reports_detail_viewOriginal}</a>
                        </c:if>
                        <c:if test="${report.targetType eq 'review' and report.targetStatus ne 'DELETED' and not empty report.targetSpotIdx}">
                            <a href="${pageContext.request.contextPath}/detail/${report.targetSpotIdx}"
                               target="_blank"
                               class="adm-btn adm-btn-ghost adm-report-small-btn">${msg_admin_reports_detail_viewSpot}</a>
                        </c:if>
                    </div>
                </div>
                <div class="adm-card-body">

                    <%-- 대상 정보 --%>
                    <div class="adm-report-meta-stack">
                        <div class="adm-meta-row">
                            <div class="adm-meta-key">${msg_admin_reports_detail_reportTarget}</div>
                            <div class="adm-detail-value">
                                <c:choose>
                                    <c:when test="${report.targetType eq 'post'}">
                                        ${msg_admin_reports_target_post}<span class="adm-module-badge adm-module-community">${msg_admin_layout_menu_community}</span>
                                    </c:when>
                                    <c:when test="${report.targetType eq 'comment'}">
                                        ${msg_admin_reports_target_comment}<span class="adm-module-badge adm-module-community">${msg_admin_layout_menu_community}</span>
                                    </c:when>
                                    <c:when test="${report.targetType eq 'review'}">
                                        ${msg_admin_reports_target_review}<span class="adm-module-badge adm-module-explore">${msg_admin_layout_menu_explore}</span>
                                    </c:when>
                                    <c:when test="${report.targetType eq 'user'}">
                                        ${msg_admin_reports_target_user}<span class="adm-module-badge adm-module-user">${msg_admin_common_member}</span>
                                    </c:when>
                                    <c:otherwise>${report.targetType}</c:otherwise>
                                </c:choose>
                                <span class="adm-report-target-id">#${report.targetId}</span>
                                <c:if test="${report.targetStatus eq 'DELETED'}">
                                    <span class="adm-report-deleted-badge">
                                        <c:choose>
                                            <c:when test="${report.targetType eq 'review'}">🗑 ${msg_admin_reports_targetBlocked}</c:when>
                                            <c:otherwise>🗑 ${msg_admin_reports_targetDeleted}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </c:if>
                                <span class="adm-inline-actions adm-report-target-actions">
                                    <c:if test="${report.targetType eq 'user' and not empty report.targetId}">
                                        <button type="button"
                                                class="adm-inline-chip js-open-member-context"
                                                data-user-idx="${report.targetId}">
                                            ${msg_admin_common_viewTarget}
                                        </button>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/admin/reports?targetType=${report.targetType}&amp;keyword=${report.targetId}"
                                       class="adm-inline-chip">
                                        ${msg_admin_common_sameTarget}
                                    </a>
                                    <c:if test="${report.targetType eq 'post' and report.targetStatus ne 'DELETED'}">
                                        <a href="${pageContext.request.contextPath}/community/${report.targetId}"
                                           target="_blank"
                                           class="adm-inline-chip">
                                            ${msg_admin_common_viewDetail}
                                        </a>
                                    </c:if>
                                    <c:if test="${report.targetType eq 'comment' and report.targetStatus ne 'DELETED'}">
                                        <a href="${pageContext.request.contextPath}/community/${empty report.sourceId ? report.targetPostId : report.sourceId}"
                                           target="_blank"
                                           class="adm-inline-chip">
                                            ${msg_admin_common_viewDetail}
                                        </a>
                                    </c:if>
                                    <c:if test="${report.targetType eq 'review' and report.targetStatus ne 'DELETED' and not empty report.targetSpotIdx}">
                                        <a href="${pageContext.request.contextPath}/admin/explore/spots/${report.targetSpotIdx}"
                                           class="adm-inline-chip">
                                            ${msg_admin_common_viewSpot}
                                        </a>
                                    </c:if>
                                </span>
                            </div>
                        </div>

                        <%-- 컨텍스트 조각: 제목 / 본문 / 스팟명 --%>
                        <c:if test="${report.targetType eq 'post' and not empty report.targetTitle}">
                            <div class="adm-meta-row">
                                <div class="adm-meta-key">${msg_admin_common_title}</div>
                                <div class="adm-detail-value adm-report-strong-value">${fn:escapeXml(report.targetTitle)}</div>
                                <div class="adm-tr-inline js-admin-translation-widget"
                                     data-label="${msg_admin_translation_label_reportTargetTitle}"
                                     data-source-type="REPORT_TARGET"
                                     data-source-idx="${report.targetId}"
                                     data-field-name="target_title"
                                     data-default-source-lang="ko"
                                     data-source-text="${fn:escapeXml(report.targetTitle)}"></div>
                            </div>
                        </c:if>
                        <c:if test="${report.targetType eq 'comment' and not empty report.targetContent}">
                            <div class="adm-meta-row">
                                <div class="adm-meta-key">${msg_admin_reports_detail_commentBody}</div>
                                <div class="adm-detail-value adm-report-prewrap-value">
                                    <c:choose>
                                        <c:when test="${fn:length(report.targetContent) > 200}">${fn:escapeXml(fn:substring(report.targetContent, 0, 200))}…</c:when>
                                        <c:otherwise>${fn:escapeXml(report.targetContent)}</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="adm-tr-inline js-admin-translation-widget"
                                     data-label="${msg_admin_translation_label_reportTargetContent}"
                                     data-source-type="REPORT_TARGET"
                                     data-source-idx="${report.targetId}"
                                     data-field-name="target_content"
                                     data-default-source-lang="ko"
                                     data-source-text="${fn:escapeXml(report.targetContent)}"></div>
                            </div>
                        </c:if>
                        <c:if test="${report.targetType eq 'review'}">
                            <c:if test="${not empty report.targetSpotName}">
                                <div class="adm-meta-row">
                                    <div class="adm-meta-key">${msg_admin_reports_detail_spot}</div>
                                    <div class="adm-detail-value adm-report-strong-value">
                                        ${fn:escapeXml(report.targetSpotName)}
                                        <span class="adm-report-spot-id">#${report.targetSpotIdx}</span>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${not empty report.targetContent}">
                                <div class="adm-meta-row">
                                    <div class="adm-meta-key">${msg_admin_reports_detail_reviewBody}</div>
                                    <div class="adm-detail-value adm-report-prewrap-value">
                                        <c:choose>
                                            <c:when test="${fn:length(report.targetContent) > 200}">${fn:escapeXml(fn:substring(report.targetContent, 0, 200))}…</c:when>
                                            <c:otherwise>${fn:escapeXml(report.targetContent)}</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="adm-tr-inline js-admin-translation-widget"
                                         data-label="${msg_admin_translation_label_reportReviewContent}"
                                         data-source-type="REPORT_TARGET"
                                         data-source-idx="${report.targetId}"
                                         data-field-name="target_content"
                                         data-default-source-lang="ko"
                                         data-source-text="${fn:escapeXml(report.targetContent)}"></div>
                                </div>
                            </c:if>
                        </c:if>

                        <div class="adm-meta-row">
                            <div class="adm-meta-key">${msg_admin_common_reason}</div>
                            <div class="adm-detail-value">
                                <c:choose>
                                    <c:when test="${report.reason eq 'spam'}">${msg_admin_reports_reason_spam}</c:when>
                                    <c:when test="${report.reason eq 'abuse'}">${msg_admin_reports_reason_abuse}</c:when>
                                    <c:when test="${report.reason eq 'privacy'}">${msg_admin_reports_reason_privacy}</c:when>
                                    <c:when test="${report.reason eq 'adult'}">${msg_admin_reports_reason_adult}</c:when>
                                    <c:when test="${report.reason eq 'illegal'}">${msg_admin_reports_reason_illegal}</c:when>
                                    <c:when test="${report.reason eq 'other'}">${msg_admin_reports_reason_other}</c:when>
                                    <c:when test="${report.reason eq 'user'}">${msg_admin_reports_reason_user}</c:when>
                                    <c:when test="${not empty report.reason}">${report.reason}</c:when>
                                    <c:otherwise><span class="adm-report-muted">—</span></c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <c:if test="${not empty report.description}">
                        <div class="adm-meta-row">
                            <div class="adm-meta-key">${msg_admin_common_description}</div>
                            <div class="adm-report-desc">${report.description}</div>
                            <div class="adm-tr-inline js-admin-translation-widget"
                                 data-label="${msg_admin_translation_label_reportDescription}"
                                 data-source-type="REPORT"
                                 data-source-idx="${report.reportId}"
                                 data-field-name="description"
                                 data-default-source-lang="ko"
                                 data-source-text="${fn:escapeXml(report.description)}"></div>
                        </div>
                    </c:if>

                        <div class="adm-meta-row">
                            <div class="adm-meta-key">${msg_admin_reports_detail_sameTargetReports}</div>
                            <div class="adm-report-count-wrap">
                                <c:choose>
                                    <c:when test="${report.targetReportCount >= 3}">
                                        <span class="adm-report-count is-hot">🔴 ${report.targetReportCount}${msg_admin_common_countSuffix}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="adm-report-count">${report.targetReportCount}${msg_admin_common_countSuffix}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="adm-report-detail-meta">
                            <span>${msg_admin_reports_reportedAt} <fmt:formatDate value="${report.createdAtDate}" type="both" dateStyle="short" timeStyle="short"/></span>
                            <c:if test="${not empty report.resolvedAt}">
                                <span>${msg_admin_reports_resolvedAt} <fmt:formatDate value="${report.resolvedAt}" type="both" dateStyle="short" timeStyle="short"/></span>
                            </c:if>
                            <c:if test="${not empty report.resolveAction}">
                                <span>${msg_admin_reports_detail_resolveAction} ${report.resolveAction}</span>
                            </c:if>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <%-- ── 오른쪽: 신고자 정보 + 처리 버튼 ── --%>
        <div>
            <div class="adm-card adm-side-sticky">
                <div class="adm-card-head">
                    <div class="adm-card-title">${msg_admin_reports_detail_reporterInfoTitle}</div>
                </div>
                <div class="adm-card-body">
                    <div class="adm-side-section">

                        <c:if test="${report.userIdx == 18}">
                            <div>
                                <span class="adm-report-ai-badge"
                                      title="Perspective API 민감도 분석에 의해 자동 감지된 신고">
                                    🤖 AI 자동감지
                                </span>
                            </div>
                        </c:if>
                        <div>
                            <div class="adm-report-side-label">${msg_admin_common_userId}</div>
                            <div class="adm-report-side-value">${report.userId}</div>
                        </div>
                        <div>
                            <div class="adm-report-side-label">${msg_admin_common_nickname}</div>
                            <div class="adm-report-side-value">${report.nickname}</div>
                        </div>

                        <div class="adm-meta-actions">
                            <c:choose>
                                <c:when test="${not empty report.userIdx}">
                                    <button type="button"
                                            class="adm-btn adm-btn-ghost adm-report-side-full-btn js-open-member-context"
                                            data-user-idx="${report.userIdx}">
                                        ${msg_admin_common_memberInfoView}
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/members?searchType=userId&keyword=${report.userId}"
                                       class="adm-btn adm-btn-ghost adm-report-side-full-btn">
                                        ${msg_admin_common_memberInfoView}
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="adm-meta-actions adm-report-meta-actions-spaced">
                            <button type="button"
                                    class="adm-btn adm-btn-ghost adm-report-side-full-btn"
                                    data-keyword="${report.userId}"
                                    onclick="openReportFilter(this)">
                                ${msg_admin_common_sameReporter}
                            </button>
                        </div>

                        <%-- 처리 버튼: targetType에 따라 조건부 --%>
                        <div class="adm-meta-actions" id="report-processing-actions">
                            <div class="adm-report-side-label is-spaced">${msg_admin_reports_detail_processingTitle}</div>
                            <div class="adm-report-action-stack">

                                <%-- post / comment / review 공통 버튼 --%>
                                <c:if test="${report.targetType eq 'post' or report.targetType eq 'comment' or report.targetType eq 'review'}">
                                    <button class="adm-btn adm-btn-ghost adm-report-action-btn is-muted"
                                            onclick="resolve('REJECTED')">${msg_admin_reports_detail_rejectKeepContent}</button>
                                    <%-- 이미 삭제/차단된 콘텐츠면 삭제 계열 버튼 숨김 --%>
                                    <c:if test="${report.targetStatus ne 'DELETED'}">
                                        <button class="adm-btn adm-btn-ghost adm-report-action-btn is-warning"
                                                onclick="resolve('DELETE_CONTENT')">
                                                <c:choose>
                                                    <c:when test="${report.targetType eq 'review'}">${msg_admin_reports_detail_blockReview}</c:when>
                                                    <c:otherwise>${msg_admin_reports_detail_deleteContent}</c:otherwise>
                                                </c:choose>
                                            </button>
                                        </c:if>
                                    <c:if test="${report.targetUserRole ne 'SYSTEM'}">
                                        <button class="adm-btn adm-btn-ghost adm-report-action-btn is-danger"
                                                onclick="resolve('BLOCK_AUTHOR')">${msg_admin_reports_detail_blockAuthor}</button>
                                        <c:if test="${report.targetStatus ne 'DELETED'}">
                                            <button class="adm-btn adm-btn-ghost adm-report-action-btn is-critical"
                                                    onclick="resolve('DELETE_AND_BLOCK')">
                                                <c:choose>
                                                    <c:when test="${report.targetType eq 'review'}">${msg_admin_reports_detail_blockReviewAndAuthor}</c:when>
                                                    <c:otherwise>${msg_admin_reports_detail_deleteAndBlockAuthor}</c:otherwise>
                                                </c:choose>
                                            </button>
                                        </c:if>
                                    </c:if>
                                </c:if>

                                <%-- user 대상 버튼 --%>
                                <c:if test="${report.targetType eq 'user'}">
                                    <button class="adm-btn adm-btn-ghost adm-report-action-btn is-muted"
                                            onclick="resolve('REJECTED')">${msg_admin_reports_detail_rejectKeepUser}</button>
                                    <c:if test="${report.targetUserRole ne 'SYSTEM'}">
                                        <button class="adm-btn adm-btn-ghost adm-report-action-btn is-danger"
                                                onclick="resolve('BLOCK_USER')">${msg_admin_reports_detail_blockUser}</button>
                                    </c:if>
                                </c:if>

                                <%-- 처리된 신고: 검토중 복원 버튼 --%>
                                <c:if test="${report.status eq 'RESOLVED' or report.status eq 'DISMISSED'}">
                                    <button class="adm-btn adm-btn-ghost adm-report-action-btn is-info"
                                            onclick="resolve('REVERT_TO_PENDING')">${msg_admin_reports_detail_revertToPending}</button>
                                </c:if>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script>
var ctx        = '${pageContext.request.contextPath}';
var reportId   = ${report.reportId};
var targetType = '${report.targetType}';
var REPORT_DETAIL_MSG = {
    rejected: '${fn:escapeXml(msg_admin_reports_detail_confirmRejected)}',
    deleteContent: '${fn:escapeXml(msg_admin_reports_detail_confirmDeleteContent)}',
    blockAuthor: '${fn:escapeXml(msg_admin_reports_detail_confirmBlockAuthor)}',
    blockUser: '${fn:escapeXml(msg_admin_reports_detail_confirmBlockUser)}',
    deleteAndBlock: '${fn:escapeXml(msg_admin_reports_detail_confirmDeleteAndBlock)}',
    deleteAndBlockReview: '${fn:escapeXml(msg_admin_reports_detail_confirmDeleteAndBlockReview)}',
    deleteReview: '${fn:escapeXml(msg_admin_reports_detail_confirmDeleteReview)}',
    revert: '${fn:escapeXml(msg_admin_reports_detail_confirmRevert)}',
    processFailed: '${fn:escapeXml(msg_admin_reports_detail_processFailed)}'
};


(function () {
    var jump = new URLSearchParams(window.location.search).get('jump');
    if (!jump) return;
    var target = document.getElementById(jump);
    if (!target) return;
    target.classList.add('is-focus-flash');
    target.scrollIntoView({ behavior: 'smooth', block: 'center' });
    var focusable = target.querySelector('textarea, input, select, button, a');
    if (focusable) {
        try { focusable.focus({ preventScroll: true }); } catch (e) { focusable.focus(); }
    }
    setTimeout(function(){ target.classList.remove('is-focus-flash'); }, 2400);
})();

function goBackToList() {
    var params = new URLSearchParams(window.location.search);
    var page       = params.get('page')       || '1';
    var status     = params.get('status')     || '';
    var targetType = params.get('targetType') || '';
    var reason     = params.get('reason')     || '';
    var keyword    = params.get('keyword')    || '';
    var url = ctx + '/admin/reports?page=' + page;
    if (status)     url += '&status='     + encodeURIComponent(status);
    if (targetType) url += '&targetType=' + encodeURIComponent(targetType);
    if (reason)     url += '&reason='     + encodeURIComponent(reason);
    if (keyword)    url += '&keyword='    + encodeURIComponent(keyword);
    location.href = url;
}

function openReportFilter(button) {
    var params = new URLSearchParams();
    params.set('page', '1');
    if (button.dataset.keyword) {
        params.set('keyword', button.dataset.keyword);
    }
    location.href = ctx + '/admin/reports?' + params.toString();
}

var isReview = (targetType === 'review');
var actionLabels = {
    REJECTED:         REPORT_DETAIL_MSG.rejected,
    DELETE_CONTENT:   isReview ? REPORT_DETAIL_MSG.deleteReview : REPORT_DETAIL_MSG.deleteContent,
    BLOCK_AUTHOR:     REPORT_DETAIL_MSG.blockAuthor,
    BLOCK_USER:       REPORT_DETAIL_MSG.blockUser,
    DELETE_AND_BLOCK: isReview ? REPORT_DETAIL_MSG.deleteAndBlockReview : REPORT_DETAIL_MSG.deleteAndBlock,
    REVERT_TO_PENDING: REPORT_DETAIL_MSG.revert
};

function resolve(action) {
    if (!confirm(actionLabels[action] || REPORT_DETAIL_MSG.processFailed)) return;
    fetch(ctx + '/admin/report/' + reportId + '/resolve', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: 'action=' + encodeURIComponent(action)
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || REPORT_DETAIL_MSG.processFailed); }
    });
}
</script>
<%@ include file="../layout-close.jsp" %>
