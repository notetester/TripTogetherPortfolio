<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="reports"/>
<spring:message code="admin.reports.detail.pageTitle" var="adminReportsDetailPageTitle"/>
<spring:message code="admin.reports.detail.backToList" var="adminReportsDetailBackToList"/>
<spring:message code="admin.reports.detail.reporterInfoTitle" var="adminReportsDetailReporterInfoTitle"/>
<spring:message code="admin.reports.detail.processingTitle" var="adminReportsDetailProcessingTitle"/>
<spring:message code="admin.reports.detail.confirmRejected" var="adminReportsDetailConfirmRejected"/>
<spring:message code="admin.reports.detail.confirmDeleteContent" var="adminReportsDetailConfirmDeleteContent"/>
<spring:message code="admin.reports.detail.confirmBlockAuthor" var="adminReportsDetailConfirmBlockAuthor"/>
<spring:message code="admin.reports.detail.confirmBlockUser" var="adminReportsDetailConfirmBlockUser"/>
<spring:message code="admin.reports.detail.confirmDeleteAndBlock" var="adminReportsDetailConfirmDeleteAndBlock"/>
<spring:message code="admin.reports.detail.confirmDeleteAndBlockReview" var="adminReportsDetailConfirmDeleteAndBlockReview"/>
<spring:message code="admin.reports.detail.confirmDeleteReview" var="adminReportsDetailConfirmDeleteReview"/>
<spring:message code="admin.reports.detail.confirmRevert" var="adminReportsDetailConfirmRevert"/>
<spring:message code="admin.reports.detail.processFailed" var="adminReportsDetailProcessFailed"/>
<c:set var="pageTitle" value="${adminReportsDetailPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div style="margin-bottom:16px;">
        <a href="javascript:goBackToList()" class="adm-back-link">← ${adminReportsDetailBackToList}</a>
    </div>

    <div class="adm-split-layout">

        <%-- ── 왼쪽: 신고 내용 ── --%>
        <div>
            <div class="adm-card">
                <div class="adm-card-head">
                    <div class="adm-card-title"><spring:message code="admin.reports.detail.title" arguments="${report.reportId}"/></div>
                    <div style="display:flex;gap:8px;align-items:center;">
                        <span class="status-badge ${report.status}">
                            <c:choose>
                                <c:when test="${report.status eq 'IN_REVIEW'}"><spring:message code="admin.reports.status.inReview"/></c:when>
                                <c:when test="${report.status eq 'RESOLVED'}"><spring:message code="admin.reports.status.resolved"/></c:when>
                                <c:when test="${report.status eq 'DISMISSED'}"><spring:message code="admin.reports.status.dismissed"/></c:when>
                                <c:otherwise>${report.status}</c:otherwise>
                            </c:choose>
                        </span>
                        <%-- post: 게시글 / comment: 원글 게시글 / review: 스팟 상세 --%>
                        <%-- 원글이 삭제된 경우(targetStatus=DELETED) 링크 숨김 --%>
                        <c:if test="${report.targetType eq 'post' and report.targetStatus ne 'DELETED'}">
                            <a href="${pageContext.request.contextPath}/community/${report.targetId}"
                               target="_blank"
                               class="adm-btn adm-btn-ghost"
                               style="font-size:12px;text-decoration:none;"><spring:message code="admin.reports.detail.viewOriginal"/></a>
                        </c:if>
                        <c:if test="${report.targetType eq 'comment' and report.targetStatus ne 'DELETED'}">
                            <a href="${pageContext.request.contextPath}/community/${empty report.sourceId ? report.targetPostId : report.sourceId}"
                               target="_blank"
                               class="adm-btn adm-btn-ghost"
                               style="font-size:12px;text-decoration:none;"><spring:message code="admin.reports.detail.viewOriginal"/></a>
                        </c:if>
                        <c:if test="${report.targetType eq 'review' and report.targetStatus ne 'DELETED' and not empty report.targetSpotIdx}">
                            <a href="${pageContext.request.contextPath}/detail/${report.targetSpotIdx}"
                               target="_blank"
                               class="adm-btn adm-btn-ghost"
                               style="font-size:12px;text-decoration:none;"><spring:message code="admin.reports.detail.viewSpot"/></a>
                        </c:if>
                    </div>
                </div>
                <div class="adm-card-body">

                    <%-- 대상 정보 --%>
                    <div style="display:flex;flex-direction:column;gap:14px;">
                        <div class="adm-meta-row">
                            <div class="adm-meta-key"><spring:message code="admin.reports.detail.reportTarget"/></div>
                            <div class="adm-detail-value">
                                <c:choose>
                                    <c:when test="${report.targetType eq 'post'}">
                                        <spring:message code="admin.reports.target.post"/><span class="adm-module-badge adm-module-community"><spring:message code="admin.layout.menu.community"/></span>
                                    </c:when>
                                    <c:when test="${report.targetType eq 'comment'}">
                                        <spring:message code="admin.reports.target.comment"/><span class="adm-module-badge adm-module-community"><spring:message code="admin.layout.menu.community"/></span>
                                    </c:when>
                                    <c:when test="${report.targetType eq 'review'}">
                                        <spring:message code="admin.reports.target.review"/><span class="adm-module-badge adm-module-explore"><spring:message code="admin.layout.menu.explore"/></span>
                                    </c:when>
                                    <c:when test="${report.targetType eq 'user'}">
                                        <spring:message code="admin.reports.target.user"/><span class="adm-module-badge adm-module-user"><spring:message code="admin.common.member"/></span>
                                    </c:when>
                                    <c:otherwise>${report.targetType}</c:otherwise>
                                </c:choose>
                                <span style="color:#64748b;margin-left:4px;">#${report.targetId}</span>
                                <c:if test="${report.targetStatus eq 'DELETED'}">
                                    <span style="margin-left:8px;font-size:11px;background:#450a0a;color:#fca5a5;padding:2px 8px;border-radius:4px;">
                                        <c:choose>
                                            <c:when test="${report.targetType eq 'review'}">🗑 <spring:message code="admin.reports.targetBlocked"/></c:when>
                                            <c:otherwise>🗑 <spring:message code="admin.reports.targetDeleted"/></c:otherwise>
                                        </c:choose>
                                    </span>
                                </c:if>
                                <span class="adm-inline-actions" style="margin-left:8px;">
                                    <c:if test="${report.targetType eq 'user' and not empty report.targetId}">
                                        <button type="button"
                                                class="adm-inline-chip js-open-member-context"
                                                data-user-idx="${report.targetId}">
                                            <spring:message code="admin.common.viewTarget"/>
                                        </button>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/admin/reports?targetType=${report.targetType}&amp;keyword=${report.targetId}"
                                       class="adm-inline-chip">
                                        <spring:message code="admin.common.sameTarget"/>
                                    </a>
                                    <c:if test="${report.targetType eq 'post' and report.targetStatus ne 'DELETED'}">
                                        <a href="${pageContext.request.contextPath}/community/${report.targetId}"
                                           target="_blank"
                                           class="adm-inline-chip">
                                            <spring:message code="admin.common.viewDetail"/>
                                        </a>
                                    </c:if>
                                    <c:if test="${report.targetType eq 'comment' and report.targetStatus ne 'DELETED'}">
                                        <a href="${pageContext.request.contextPath}/community/${empty report.sourceId ? report.targetPostId : report.sourceId}"
                                           target="_blank"
                                           class="adm-inline-chip">
                                            <spring:message code="admin.common.viewDetail"/>
                                        </a>
                                    </c:if>
                                    <c:if test="${report.targetType eq 'review' and report.targetStatus ne 'DELETED' and not empty report.targetSpotIdx}">
                                        <a href="${pageContext.request.contextPath}/admin/explore/spots/${report.targetSpotIdx}"
                                           class="adm-inline-chip">
                                            <spring:message code="admin.common.viewSpot"/>
                                        </a>
                                    </c:if>
                                </span>
                            </div>
                        </div>

                        <%-- 컨텍스트 조각: 제목 / 본문 / 스팟명 --%>
                        <c:if test="${report.targetType eq 'post' and not empty report.targetTitle}">
                            <div class="adm-meta-row">
                                <div class="adm-meta-key"><spring:message code="admin.common.title"/></div>
                                <div class="adm-detail-value" style="font-weight:600;">${fn:escapeXml(report.targetTitle)}</div>
                                <div class="adm-tr-inline js-admin-translation-widget"
                                     data-label="<spring:message code='admin.translation.label.reportTargetTitle'/>"
                                     data-source-type="REPORT_TARGET"
                                     data-source-idx="${report.targetId}"
                                     data-field-name="target_title"
                                     data-default-source-lang="ko"
                                     data-source-text="${fn:escapeXml(report.targetTitle)}"></div>
                            </div>
                        </c:if>
                        <c:if test="${report.targetType eq 'comment' and not empty report.targetContent}">
                            <div class="adm-meta-row">
                                <div class="adm-meta-key"><spring:message code="admin.reports.detail.commentBody"/></div>
                                <div class="adm-detail-value" style="white-space:pre-wrap;word-break:break-word;">
                                    <c:choose>
                                        <c:when test="${fn:length(report.targetContent) > 200}">${fn:escapeXml(fn:substring(report.targetContent, 0, 200))}…</c:when>
                                        <c:otherwise>${fn:escapeXml(report.targetContent)}</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="adm-tr-inline js-admin-translation-widget"
                                     data-label="<spring:message code='admin.translation.label.reportTargetContent'/>"
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
                                    <div class="adm-meta-key"><spring:message code="admin.reports.detail.spot"/></div>
                                    <div class="adm-detail-value" style="font-weight:600;">
                                        ${fn:escapeXml(report.targetSpotName)}
                                        <span style="color:#64748b;margin-left:4px;font-weight:400;">#${report.targetSpotIdx}</span>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${not empty report.targetContent}">
                                <div class="adm-meta-row">
                                    <div class="adm-meta-key"><spring:message code="admin.reports.detail.reviewBody"/></div>
                                    <div class="adm-detail-value" style="white-space:pre-wrap;word-break:break-word;">
                                        <c:choose>
                                            <c:when test="${fn:length(report.targetContent) > 200}">${fn:escapeXml(fn:substring(report.targetContent, 0, 200))}…</c:when>
                                            <c:otherwise>${fn:escapeXml(report.targetContent)}</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="adm-tr-inline js-admin-translation-widget"
                                         data-label="<spring:message code='admin.translation.label.reportReviewContent'/>"
                                         data-source-type="REPORT_TARGET"
                                         data-source-idx="${report.targetId}"
                                         data-field-name="target_content"
                                         data-default-source-lang="ko"
                                         data-source-text="${fn:escapeXml(report.targetContent)}"></div>
                                </div>
                            </c:if>
                        </c:if>

                        <div class="adm-meta-row">
                            <div class="adm-meta-key"><spring:message code="admin.common.reason"/></div>
                            <div class="adm-detail-value">
                                <c:choose>
                                    <c:when test="${report.reason eq 'spam'}"><spring:message code="admin.reports.reason.spam"/></c:when>
                                    <c:when test="${report.reason eq 'abuse'}"><spring:message code="admin.reports.reason.abuse"/></c:when>
                                    <c:when test="${report.reason eq 'privacy'}"><spring:message code="admin.reports.reason.privacy"/></c:when>
                                    <c:when test="${report.reason eq 'adult'}"><spring:message code="admin.reports.reason.adult"/></c:when>
                                    <c:when test="${report.reason eq 'illegal'}"><spring:message code="admin.reports.reason.illegal"/></c:when>
                                    <c:when test="${report.reason eq 'other'}"><spring:message code="admin.reports.reason.other"/></c:when>
                                    <c:when test="${report.reason eq 'user'}"><spring:message code="admin.reports.reason.user"/></c:when>
                                    <c:when test="${not empty report.reason}">${report.reason}</c:when>
                                    <c:otherwise><span style="color:#64748b;">—</span></c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <c:if test="${not empty report.description}">
                        <div class="adm-meta-row">
                            <div class="adm-meta-key"><spring:message code="admin.common.description"/></div>
                            <div class="adm-report-desc">${report.description}</div>
                            <div class="adm-tr-inline js-admin-translation-widget"
                                 data-label="<spring:message code='admin.translation.label.reportDescription'/>"
                                 data-source-type="REPORT"
                                 data-source-idx="${report.reportId}"
                                 data-field-name="description"
                                 data-default-source-lang="ko"
                                 data-source-text="${fn:escapeXml(report.description)}"></div>
                        </div>
                    </c:if>

                        <div class="adm-meta-row">
                            <div class="adm-meta-key"><spring:message code="admin.reports.detail.sameTargetReports"/></div>
                            <div style="font-size:13px;">
                                <c:choose>
                                    <c:when test="${report.targetReportCount >= 3}">
                                        <span style="color:#f87171;font-weight:700;">🔴 ${report.targetReportCount}<spring:message code="admin.common.countSuffix"/></span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color:#94a3b8;">${report.targetReportCount}<spring:message code="admin.common.countSuffix"/></span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div style="border-top:1px solid #1e2736;padding-top:12px;
                                    display:flex;gap:20px;font-size:12px;color:#64748b;">
                            <span><spring:message code="admin.reports.reportedAt"/> <fmt:formatDate value="${report.createdAtDate}" type="both" dateStyle="short" timeStyle="short"/></span>
                            <c:if test="${not empty report.resolvedAt}">
                                <span><spring:message code="admin.reports.resolvedAt"/> <fmt:formatDate value="${report.resolvedAt}" type="both" dateStyle="short" timeStyle="short"/></span>
                            </c:if>
                            <c:if test="${not empty report.resolveAction}">
                                <span><spring:message code="admin.reports.detail.resolveAction"/> ${report.resolveAction}</span>
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
                    <div class="adm-card-title">${adminReportsDetailReporterInfoTitle}</div>
                </div>
                <div class="adm-card-body">
                    <div class="adm-side-section">

                        <c:if test="${report.userIdx == 18}">
                            <div>
                                <span style="display:inline-block;padding:3px 10px;background:#ede9fe;color:#6d28d9;border-radius:999px;font-size:11px;font-weight:600;"
                                      title="Perspective API 민감도 분석에 의해 자동 감지된 신고">
                                    🤖 AI 자동감지
                                </span>
                            </div>
                        </c:if>
                        <div>
                            <div style="font-size:11px;color:#64748b;margin-bottom:2px;"><spring:message code="admin.common.userId"/></div>
                            <div style="font-size:14px;font-weight:600;">${report.userId}</div>
                        </div>
                        <div>
                            <div style="font-size:11px;color:#64748b;margin-bottom:2px;"><spring:message code="admin.common.nickname"/></div>
                            <div style="font-size:14px;font-weight:600;">${report.nickname}</div>
                        </div>

                        <div class="adm-meta-actions">
                            <c:choose>
                                <c:when test="${not empty report.userIdx}">
                                    <button type="button"
                                            class="adm-btn adm-btn-ghost js-open-member-context"
                                            data-user-idx="${report.userIdx}"
                                            style="width:100%;text-align:center;font-size:12px;display:block;">
                                        <spring:message code="admin.common.memberInfoView"/>
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/members?searchType=userId&keyword=${report.userId}"
                                       class="adm-btn adm-btn-ghost"
                                       style="text-align:center;font-size:12px;text-decoration:none;display:block;">
                                        <spring:message code="admin.common.memberInfoView"/>
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="adm-meta-actions" style="margin-top:8px;">
                            <button type="button"
                                    class="adm-btn adm-btn-ghost"
                                    data-keyword="${report.userId}"
                                    onclick="openReportFilter(this)"
                                    style="width:100%;text-align:center;font-size:12px;">
                                <spring:message code="admin.common.sameReporter"/>
                            </button>
                        </div>

                        <%-- 처리 버튼: targetType에 따라 조건부 --%>
                        <div class="adm-meta-actions" id="report-processing-actions">
                            <div style="font-size:11px;color:#64748b;margin-bottom:8px;">${adminReportsDetailProcessingTitle}</div>
                            <div style="display:flex;flex-direction:column;gap:6px;">

                                <%-- post / comment / review 공통 버튼 --%>
                                <c:if test="${report.targetType eq 'post' or report.targetType eq 'comment' or report.targetType eq 'review'}">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:11px;color:#94a3b8;border-color:#94a3b8;"
                                            onclick="resolve('REJECTED')"><spring:message code="admin.reports.detail.rejectKeepContent"/></button>
                                    <%-- 이미 삭제/차단된 콘텐츠면 삭제 계열 버튼 숨김 --%>
                                    <c:if test="${report.targetStatus ne 'DELETED'}">
                                        <button class="adm-btn adm-btn-ghost"
                                                style="font-size:11px;color:#fb923c;border-color:#fb923c;"
                                                onclick="resolve('DELETE_CONTENT')">
                                                <c:choose>
                                                    <c:when test="${report.targetType eq 'review'}"><spring:message code="admin.reports.detail.blockReview"/></c:when>
                                                    <c:otherwise><spring:message code="admin.reports.detail.deleteContent"/></c:otherwise>
                                                </c:choose>
                                            </button>
                                        </c:if>
                                    <c:if test="${report.targetUserRole ne 'SYSTEM'}">
                                        <button class="adm-btn adm-btn-ghost"
                                                style="font-size:11px;color:#f87171;border-color:#f87171;"
                                                onclick="resolve('BLOCK_AUTHOR')"><spring:message code="admin.reports.detail.blockAuthor"/></button>
                                        <c:if test="${report.targetStatus ne 'DELETED'}">
                                            <button class="adm-btn adm-btn-ghost"
                                                    style="font-size:11px;color:#dc2626;border-color:#dc2626;"
                                                    onclick="resolve('DELETE_AND_BLOCK')">
                                                <c:choose>
                                                    <c:when test="${report.targetType eq 'review'}"><spring:message code="admin.reports.detail.blockReviewAndAuthor"/></c:when>
                                                    <c:otherwise><spring:message code="admin.reports.detail.deleteAndBlockAuthor"/></c:otherwise>
                                                </c:choose>
                                            </button>
                                        </c:if>
                                    </c:if>
                                </c:if>

                                <%-- user 대상 버튼 --%>
                                <c:if test="${report.targetType eq 'user'}">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:11px;color:#94a3b8;border-color:#94a3b8;"
                                            onclick="resolve('REJECTED')"><spring:message code="admin.reports.detail.rejectKeepUser"/></button>
                                    <c:if test="${report.targetUserRole ne 'SYSTEM'}">
                                        <button class="adm-btn adm-btn-ghost"
                                                style="font-size:11px;color:#f87171;border-color:#f87171;"
                                                onclick="resolve('BLOCK_USER')"><spring:message code="admin.reports.detail.blockUser"/></button>
                                    </c:if>
                                </c:if>

                                <%-- 처리된 신고: 검토중 복원 버튼 --%>
                                <c:if test="${report.status eq 'RESOLVED' or report.status eq 'DISMISSED'}">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:11px;color:#7dd3fc;border-color:#7dd3fc;margin-top:4px;"
                                            onclick="resolve('REVERT_TO_PENDING')"><spring:message code="admin.reports.detail.revertToPending"/></button>
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
    rejected: '${fn:escapeXml(adminReportsDetailConfirmRejected)}',
    deleteContent: '${fn:escapeXml(adminReportsDetailConfirmDeleteContent)}',
    blockAuthor: '${fn:escapeXml(adminReportsDetailConfirmBlockAuthor)}',
    blockUser: '${fn:escapeXml(adminReportsDetailConfirmBlockUser)}',
    deleteAndBlock: '${fn:escapeXml(adminReportsDetailConfirmDeleteAndBlock)}',
    deleteAndBlockReview: '${fn:escapeXml(adminReportsDetailConfirmDeleteAndBlockReview)}',
    deleteReview: '${fn:escapeXml(adminReportsDetailConfirmDeleteReview)}',
    revert: '${fn:escapeXml(adminReportsDetailConfirmRevert)}',
    processFailed: '${fn:escapeXml(adminReportsDetailProcessFailed)}'
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
