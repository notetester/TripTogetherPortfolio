<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_14baba2b2f" code="admin.reports.detail.title"/>
<spring:message var="autoMsg_9310d097e2" code="admin.reports.status.inReview"/>
<spring:message var="autoMsg_fb7594cf97" code="admin.reports.status.resolved"/>
<spring:message var="autoMsg_0f276f5fc5" code="admin.reports.status.dismissed"/>
<spring:message var="autoMsg_2075ec882e" code="admin.reports.detail.viewOriginal"/>
<spring:message var="autoMsg_9819fc6981" code="admin.reports.detail.viewSpot"/>
<spring:message var="autoMsg_15ef98892c" code="admin.reports.detail.reportTarget"/>
<spring:message var="autoMsg_a0b4594406" code="admin.reports.target.post"/>
<spring:message var="autoMsg_7314c908f1" code="admin.layout.menu.community"/>
<spring:message var="autoMsg_91bfd813d8" code="admin.reports.target.comment"/>
<spring:message var="autoMsg_b945e8646d" code="admin.reports.target.review"/>
<spring:message var="autoMsg_7d2164b4ba" code="admin.layout.menu.explore"/>
<spring:message var="autoMsg_beb05df08d" code="admin.reports.target.user"/>
<spring:message var="autoMsg_64217a9ce0" code="admin.common.member"/>
<spring:message var="autoMsg_953be2c6ce" code="admin.reports.targetBlocked"/>
<spring:message var="autoMsg_2ebba6df4b" code="admin.reports.targetDeleted"/>
<spring:message var="autoMsg_7181cd24a6" code="admin.common.title"/>
<spring:message var="autoMsg_0f4d0198d8" code="admin.translation.label.reportTargetTitle"/>
<spring:message var="autoMsg_e72e76de7d" code="admin.reports.detail.commentBody"/>
<spring:message var="autoMsg_9608b9bc19" code="admin.translation.label.reportTargetContent"/>
<spring:message var="autoMsg_5a999d2f67" code="admin.reports.detail.spot"/>
<spring:message var="autoMsg_a8e91f9fb5" code="admin.reports.detail.reviewBody"/>
<spring:message var="autoMsg_f669bbf26a" code="admin.translation.label.reportReviewContent"/>
<spring:message var="autoMsg_60efa8ab05" code="admin.common.reason"/>
<spring:message var="autoMsg_97b28a15cb" code="admin.reports.reason.spam"/>
<spring:message var="autoMsg_a6492c4c43" code="admin.reports.reason.abuse"/>
<spring:message var="autoMsg_b3d40fdf46" code="admin.reports.reason.privacy"/>
<spring:message var="autoMsg_f250dd1d72" code="admin.reports.reason.adult"/>
<spring:message var="autoMsg_91b019e6c4" code="admin.reports.reason.illegal"/>
<spring:message var="autoMsg_5dc3bc420d" code="admin.reports.reason.other"/>
<spring:message var="autoMsg_70bf1b6407" code="admin.reports.reason.user"/>
<spring:message var="autoMsg_f7a12f4c53" code="admin.common.description"/>
<spring:message var="autoMsg_c1b9645381" code="admin.translation.label.reportDescription"/>
<spring:message var="autoMsg_40a18bfa31" code="admin.reports.detail.sameTargetReports"/>
<spring:message var="autoMsg_6df20713cb" code="admin.common.countSuffix"/>
<spring:message var="autoMsg_21f5bbd399" code="admin.reports.reportedAt"/>
<spring:message var="autoMsg_4a13fbcea1" code="admin.reports.resolvedAt"/>
<spring:message var="autoMsg_49198fa3f4" code="admin.reports.detail.resolveAction"/>
<spring:message var="autoMsg_a2edd9daf5" code="admin.common.userId"/>
<spring:message var="autoMsg_b92cd9cde8" code="admin.common.nickname"/>
<spring:message var="autoMsg_d3bb09febe" code="admin.reports.detail.rejectKeepContent"/>
<spring:message var="autoMsg_61487994cc" code="admin.reports.detail.blockReview"/>
<spring:message var="autoMsg_3b21512010" code="admin.reports.detail.deleteContent"/>
<spring:message var="autoMsg_2a59960f6a" code="admin.reports.detail.blockAuthor"/>
<spring:message var="autoMsg_5447e38977" code="admin.reports.detail.blockReviewAndAuthor"/>
<spring:message var="autoMsg_b6d1101470" code="admin.reports.detail.deleteAndBlockAuthor"/>
<spring:message var="autoMsg_51fd416db0" code="admin.reports.detail.rejectKeepUser"/>
<spring:message var="autoMsg_16ecfeb5be" code="admin.reports.detail.blockUser"/>
<spring:message var="autoMsg_5fb80b29ec" code="admin.reports.detail.revertToPending"/>
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
                    <div class="adm-card-title">${autoMsg_14baba2b2f}</div>
                    <div style="display:flex;gap:8px;align-items:center;">
                        <span class="status-badge ${report.status}">
                            <c:choose>
                                <c:when test="${report.status eq 'IN_REVIEW'}">${autoMsg_9310d097e2}</c:when>
                                <c:when test="${report.status eq 'RESOLVED'}">${autoMsg_fb7594cf97}</c:when>
                                <c:when test="${report.status eq 'DISMISSED'}">${autoMsg_0f276f5fc5}</c:when>
                                <c:otherwise>${report.status}</c:otherwise>
                            </c:choose>
                        </span>
                        <%-- post: 게시글 / comment: 원글 게시글 / review: 스팟 상세 --%>
                        <%-- 원글이 삭제된 경우(targetStatus=DELETED) 링크 숨김 --%>
                        <c:if test="${report.targetType eq 'post' and report.targetStatus ne 'DELETED'}">
                            <a href="${pageContext.request.contextPath}/community/${report.targetId}"
                               target="_blank"
                               class="adm-btn adm-btn-ghost"
                               style="font-size:12px;text-decoration:none;">${autoMsg_2075ec882e}</a>
                        </c:if>
                        <c:if test="${report.targetType eq 'comment' and report.targetStatus ne 'DELETED'}">
                            <a href="${pageContext.request.contextPath}/community/${empty report.sourceId ? report.targetPostId : report.sourceId}"
                               target="_blank"
                               class="adm-btn adm-btn-ghost"
                               style="font-size:12px;text-decoration:none;">${autoMsg_2075ec882e}</a>
                        </c:if>
                        <c:if test="${report.targetType eq 'review' and report.targetStatus ne 'DELETED' and not empty report.targetSpotIdx}">
                            <a href="${pageContext.request.contextPath}/detail/${report.targetSpotIdx}"
                               target="_blank"
                               class="adm-btn adm-btn-ghost"
                               style="font-size:12px;text-decoration:none;">${autoMsg_9819fc6981}</a>
                        </c:if>
                    </div>
                </div>
                <div class="adm-card-body">

                    <%-- 대상 정보 --%>
                    <div style="display:flex;flex-direction:column;gap:14px;">
                        <div class="adm-meta-row">
                            <div class="adm-meta-key">${autoMsg_15ef98892c}</div>
                            <div class="adm-detail-value">
                                <c:choose>
                                    <c:when test="${report.targetType eq 'post'}">
                                        ${autoMsg_a0b4594406}<span class="adm-module-badge adm-module-community">${autoMsg_7314c908f1}</span>
                                    </c:when>
                                    <c:when test="${report.targetType eq 'comment'}">
                                        ${autoMsg_91bfd813d8}<span class="adm-module-badge adm-module-community">${autoMsg_7314c908f1}</span>
                                    </c:when>
                                    <c:when test="${report.targetType eq 'review'}">
                                        ${autoMsg_b945e8646d}<span class="adm-module-badge adm-module-explore">${autoMsg_7d2164b4ba}</span>
                                    </c:when>
                                    <c:when test="${report.targetType eq 'user'}">
                                        ${autoMsg_beb05df08d}<span class="adm-module-badge adm-module-user">${autoMsg_64217a9ce0}</span>
                                    </c:when>
                                    <c:otherwise>${report.targetType}</c:otherwise>
                                </c:choose>
                                <span style="color:#64748b;margin-left:4px;">#${report.targetId}</span>
                                <c:if test="${report.targetStatus eq 'DELETED'}">
                                    <span style="margin-left:8px;font-size:11px;background:#450a0a;color:#fca5a5;padding:2px 8px;border-radius:4px;">
                                        <c:choose>
                                            <c:when test="${report.targetType eq 'review'}">🗑 ${autoMsg_953be2c6ce}</c:when>
                                            <c:otherwise>🗑 ${autoMsg_2ebba6df4b}</c:otherwise>
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
                                <div class="adm-meta-key">${autoMsg_7181cd24a6}</div>
                                <div class="adm-detail-value" style="font-weight:600;">${fn:escapeXml(report.targetTitle)}</div>
                                <div class="adm-tr-inline js-admin-translation-widget"
                                     data-label="${autoMsg_0f4d0198d8}"
                                     data-source-type="REPORT_TARGET"
                                     data-source-idx="${report.targetId}"
                                     data-field-name="target_title"
                                     data-default-source-lang="ko"
                                     data-source-text="${fn:escapeXml(report.targetTitle)}"></div>
                            </div>
                        </c:if>
                        <c:if test="${report.targetType eq 'comment' and not empty report.targetContent}">
                            <div class="adm-meta-row">
                                <div class="adm-meta-key">${autoMsg_e72e76de7d}</div>
                                <div class="adm-detail-value" style="white-space:pre-wrap;word-break:break-word;">
                                    <c:choose>
                                        <c:when test="${fn:length(report.targetContent) > 200}">${fn:escapeXml(fn:substring(report.targetContent, 0, 200))}…</c:when>
                                        <c:otherwise>${fn:escapeXml(report.targetContent)}</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="adm-tr-inline js-admin-translation-widget"
                                     data-label="${autoMsg_9608b9bc19}"
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
                                    <div class="adm-meta-key">${autoMsg_5a999d2f67}</div>
                                    <div class="adm-detail-value" style="font-weight:600;">
                                        ${fn:escapeXml(report.targetSpotName)}
                                        <span style="color:#64748b;margin-left:4px;font-weight:400;">#${report.targetSpotIdx}</span>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${not empty report.targetContent}">
                                <div class="adm-meta-row">
                                    <div class="adm-meta-key">${autoMsg_a8e91f9fb5}</div>
                                    <div class="adm-detail-value" style="white-space:pre-wrap;word-break:break-word;">
                                        <c:choose>
                                            <c:when test="${fn:length(report.targetContent) > 200}">${fn:escapeXml(fn:substring(report.targetContent, 0, 200))}…</c:when>
                                            <c:otherwise>${fn:escapeXml(report.targetContent)}</c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="adm-tr-inline js-admin-translation-widget"
                                         data-label="${autoMsg_f669bbf26a}"
                                         data-source-type="REPORT_TARGET"
                                         data-source-idx="${report.targetId}"
                                         data-field-name="target_content"
                                         data-default-source-lang="ko"
                                         data-source-text="${fn:escapeXml(report.targetContent)}"></div>
                                </div>
                            </c:if>
                        </c:if>

                        <div class="adm-meta-row">
                            <div class="adm-meta-key">${autoMsg_60efa8ab05}</div>
                            <div class="adm-detail-value">
                                <c:choose>
                                    <c:when test="${report.reason eq 'spam'}">${autoMsg_97b28a15cb}</c:when>
                                    <c:when test="${report.reason eq 'abuse'}">${autoMsg_a6492c4c43}</c:when>
                                    <c:when test="${report.reason eq 'privacy'}">${autoMsg_b3d40fdf46}</c:when>
                                    <c:when test="${report.reason eq 'adult'}">${autoMsg_f250dd1d72}</c:when>
                                    <c:when test="${report.reason eq 'illegal'}">${autoMsg_91b019e6c4}</c:when>
                                    <c:when test="${report.reason eq 'other'}">${autoMsg_5dc3bc420d}</c:when>
                                    <c:when test="${report.reason eq 'user'}">${autoMsg_70bf1b6407}</c:when>
                                    <c:when test="${not empty report.reason}">${report.reason}</c:when>
                                    <c:otherwise><span style="color:#64748b;">—</span></c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <c:if test="${not empty report.description}">
                        <div class="adm-meta-row">
                            <div class="adm-meta-key">${autoMsg_f7a12f4c53}</div>
                            <div class="adm-report-desc">${report.description}</div>
                            <div class="adm-tr-inline js-admin-translation-widget"
                                 data-label="${autoMsg_c1b9645381}"
                                 data-source-type="REPORT"
                                 data-source-idx="${report.reportId}"
                                 data-field-name="description"
                                 data-default-source-lang="ko"
                                 data-source-text="${fn:escapeXml(report.description)}"></div>
                        </div>
                    </c:if>

                        <div class="adm-meta-row">
                            <div class="adm-meta-key">${autoMsg_40a18bfa31}</div>
                            <div style="font-size:13px;">
                                <c:choose>
                                    <c:when test="${report.targetReportCount >= 3}">
                                        <span style="color:#f87171;font-weight:700;">🔴 ${report.targetReportCount}${autoMsg_6df20713cb}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color:#94a3b8;">${report.targetReportCount}${autoMsg_6df20713cb}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div style="border-top:1px solid #1e2736;padding-top:12px;
                                    display:flex;gap:20px;font-size:12px;color:#64748b;">
                            <span>${autoMsg_21f5bbd399} <fmt:formatDate value="${report.createdAtDate}" type="both" dateStyle="short" timeStyle="short"/></span>
                            <c:if test="${not empty report.resolvedAt}">
                                <span>${autoMsg_4a13fbcea1} <fmt:formatDate value="${report.resolvedAt}" type="both" dateStyle="short" timeStyle="short"/></span>
                            </c:if>
                            <c:if test="${not empty report.resolveAction}">
                                <span>${autoMsg_49198fa3f4} ${report.resolveAction}</span>
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
                            <div style="font-size:11px;color:#64748b;margin-bottom:2px;">${autoMsg_a2edd9daf5}</div>
                            <div style="font-size:14px;font-weight:600;">${report.userId}</div>
                        </div>
                        <div>
                            <div style="font-size:11px;color:#64748b;margin-bottom:2px;">${autoMsg_b92cd9cde8}</div>
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
                                            onclick="resolve('REJECTED')">${autoMsg_d3bb09febe}</button>
                                    <%-- 이미 삭제/차단된 콘텐츠면 삭제 계열 버튼 숨김 --%>
                                    <c:if test="${report.targetStatus ne 'DELETED'}">
                                        <button class="adm-btn adm-btn-ghost"
                                                style="font-size:11px;color:#fb923c;border-color:#fb923c;"
                                                onclick="resolve('DELETE_CONTENT')">
                                                <c:choose>
                                                    <c:when test="${report.targetType eq 'review'}">${autoMsg_61487994cc}</c:when>
                                                    <c:otherwise>${autoMsg_3b21512010}</c:otherwise>
                                                </c:choose>
                                            </button>
                                        </c:if>
                                    <c:if test="${report.targetUserRole ne 'SYSTEM'}">
                                        <button class="adm-btn adm-btn-ghost"
                                                style="font-size:11px;color:#f87171;border-color:#f87171;"
                                                onclick="resolve('BLOCK_AUTHOR')">${autoMsg_2a59960f6a}</button>
                                        <c:if test="${report.targetStatus ne 'DELETED'}">
                                            <button class="adm-btn adm-btn-ghost"
                                                    style="font-size:11px;color:#dc2626;border-color:#dc2626;"
                                                    onclick="resolve('DELETE_AND_BLOCK')">
                                                <c:choose>
                                                    <c:when test="${report.targetType eq 'review'}">${autoMsg_5447e38977}</c:when>
                                                    <c:otherwise>${autoMsg_b6d1101470}</c:otherwise>
                                                </c:choose>
                                            </button>
                                        </c:if>
                                    </c:if>
                                </c:if>

                                <%-- user 대상 버튼 --%>
                                <c:if test="${report.targetType eq 'user'}">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:11px;color:#94a3b8;border-color:#94a3b8;"
                                            onclick="resolve('REJECTED')">${autoMsg_51fd416db0}</button>
                                    <c:if test="${report.targetUserRole ne 'SYSTEM'}">
                                        <button class="adm-btn adm-btn-ghost"
                                                style="font-size:11px;color:#f87171;border-color:#f87171;"
                                                onclick="resolve('BLOCK_USER')">${autoMsg_16ecfeb5be}</button>
                                    </c:if>
                                </c:if>

                                <%-- 처리된 신고: 검토중 복원 버튼 --%>
                                <c:if test="${report.status eq 'RESOLVED' or report.status eq 'DISMISSED'}">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:11px;color:#7dd3fc;border-color:#7dd3fc;margin-top:4px;"
                                            onclick="resolve('REVERT_TO_PENDING')">${autoMsg_5fb80b29ec}</button>
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
