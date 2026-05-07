<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_common_delete_js" code="admin.common.delete" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_restore_js" code="admin.common.restore" javaScriptEscape="true"/>
<spring:message var="msg_admin_courses_detail_js_confirmAction_js" code="admin.courses.detail.js.confirmAction" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_processError_js" code="admin.common.processError" javaScriptEscape="true"/>
<spring:message var="msg_admin_courses_detail_pageTitle" code="admin.courses.detail.pageTitle"/>
<spring:message var="msg_admin_courses_detail_backToList" code="admin.courses.detail.backToList"/>
<spring:message var="msg_admin_courses_detail_notFound" code="admin.courses.detail.notFound"/>
<spring:message var="msg_admin_common_active" code="admin.common.active"/>
<spring:message var="msg_admin_courses_status_deleted" code="admin.courses.status.deleted"/>
<spring:message var="msg_admin_common_delete" code="admin.common.delete"/>
<spring:message var="msg_admin_common_restore" code="admin.common.restore"/>
<spring:message var="msg_admin_courses_detail_field_author" code="admin.courses.detail.field.author"/>
<spring:message var="msg_admin_courses_detail_accountBlocked" code="admin.courses.detail.accountBlocked"/>
<spring:message var="msg_admin_courses_detail_field_destination" code="admin.courses.detail.field.destination"/>
<spring:message var="msg_admin_common_dash" code="admin.common.dash"/>
<spring:message var="msg_admin_courses_detail_field_period" code="admin.courses.detail.field.period"/>
<spring:message var="msg_admin_courses_detail_field_spotCount" code="admin.courses.detail.field.spotCount"/>
<spring:message var="msg_admin_common_countSuffix" code="admin.common.countSuffix"/>
<spring:message var="msg_admin_courses_detail_field_source" code="admin.courses.detail.field.source"/>
<spring:message var="msg_admin_courses_detail_source_aiGenerated" code="admin.courses.detail.source.aiGenerated"/>
<spring:message var="msg_admin_courses_detail_source_manualCreated" code="admin.courses.detail.source.manualCreated"/>
<spring:message var="msg_admin_courses_detail_field_visibility" code="admin.courses.detail.field.visibility"/>
<spring:message var="msg_admin_courses_visibility_public" code="admin.courses.visibility.public"/>
<spring:message var="msg_admin_courses_visibility_private" code="admin.courses.visibility.private"/>
<spring:message var="msg_admin_courses_detail_field_createdAt" code="admin.courses.detail.field.createdAt"/>
<spring:message var="msg_admin_courses_detail_field_updatedAt" code="admin.courses.detail.field.updatedAt"/>
<spring:message var="msg_admin_courses_detail_spots_title" code="admin.courses.detail.spots.title"/>
<spring:message var="msg_admin_courses_detail_spots_empty" code="admin.courses.detail.spots.empty"/>
<spring:message var="msg_admin_courses_detail_spots_noName" code="admin.courses.detail.spots.noName"/>
<spring:message var="msg_admin_courses_detail_spotsTotalCountDisplay" code="admin.common.totalCountFormat" arguments="${fn:length(spots)}"/>
<c:set var="pageTitle" value="${msg_admin_courses_detail_pageTitle}"/>
<c:set var="activeMenu" value="courses"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-courses-page adm-courses-detail-page">
    <c:url var="courseBackUrl" value="/admin/courses">
        <c:if test="${not empty param.page}"><c:param name="page" value="${param.page}"/></c:if>
        <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}"/></c:if>
        <c:if test="${not empty param.status}"><c:param name="status" value="${param.status}"/></c:if>
        <c:if test="${not empty param.planSource}"><c:param name="planSource" value="${param.planSource}"/></c:if>
        <c:if test="${not empty param.isPublic}"><c:param name="isPublic" value="${param.isPublic}"/></c:if>
        <c:if test="${not empty param.sortBy}"><c:param name="sortBy" value="${param.sortBy}"/></c:if>
        <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}"/></c:if>
        <c:if test="${not empty param.keyword}"><c:param name="keyword" value="${param.keyword}"/></c:if>
    </c:url>
    <div class="adm-courses-detail-backrow">
        <a href="${courseBackUrl}" class="adm-back-link">${msg_admin_courses_detail_backToList}</a>
    </div>

    <c:if test="${empty plan}">
        <div class="adm-card adm-courses-empty-state">
            ${msg_admin_courses_detail_notFound}
        </div>
    </c:if>

    <c:if test="${not empty plan}">

        <%-- ── 코스 헤더 ── --%>
        <div class="adm-card adm-courses-detail-card">
            <div class="adm-card-head">
                <div class="adm-courses-detail-title-row">
                    <span class="adm-card-title adm-courses-detail-title">#${plan.planId} · ${plan.title}</span>
                    <c:choose>
                        <c:when test="${plan.isDeleted == 0}">
                            <span class="status-badge ACTIVE">${msg_admin_common_active}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge DELETED">${msg_admin_courses_status_deleted}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="adm-courses-detail-actions">
                    <c:choose>
                        <c:when test="${plan.isDeleted == 0}">
                            <button class="adm-btn adm-btn-ghost adm-courses-danger-btn"
                                    onclick="actionPlan('delete')">${msg_admin_common_delete}</button>
                        </c:when>
                        <c:otherwise>
                            <button class="adm-btn adm-btn-ghost adm-courses-success-btn"
                                    onclick="actionPlan('restore')">${msg_admin_common_restore}</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="adm-card-body">
                <div class="adm-courses-detail-info-grid">
                    <div class="adm-courses-detail-field">
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_author}</div>
                        <button type="button"
                                class="adm-inline-link adm-courses-author-name js-open-member-context"
                                data-user-idx="${plan.userIdx}">${plan.nickname}</button>
                        <div>
                            <button type="button"
                                    class="adm-inline-link adm-courses-author-id js-open-member-context"
                                    data-user-idx="${plan.userIdx}">${plan.userId}</button>
                        </div>
                        <c:if test="${plan.accountStatus == 'BLOCKED'}">
                            <span class="adm-inline-danger">${msg_admin_courses_detail_accountBlocked}</span>
                        </c:if>
                    </div>
                    <div class="adm-courses-detail-field">
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_destination}</div>
                        <div class="adm-courses-detail-value">
                            <c:choose>
                                <c:when test="${not empty plan.destination}">${plan.destination}</c:when>
                                <c:otherwise><span class="adm-courses-muted">${msg_admin_common_dash}</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="adm-courses-detail-field">
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_period}</div>
                        <div class="adm-courses-detail-subvalue">
                            <c:choose>
                                <c:when test="${not empty plan.startDate}">
                                    <fmt:formatDate value="${plan.startDate}" pattern="yyyy.MM.dd"/>
                                    ~ <fmt:formatDate value="${plan.endDate}" pattern="yyyy.MM.dd"/>
                                </c:when>
                                <c:otherwise><span class="adm-courses-muted">${msg_admin_common_dash}</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="adm-courses-detail-field">
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_spotCount}</div>
                        <div class="adm-courses-count-value">${plan.spotCount}${msg_admin_common_countSuffix}</div>
                    </div>
                    <div class="adm-courses-detail-field">
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_source}</div>
                        <div class="adm-courses-detail-value">
                            <c:choose>
                                <c:when test="${plan.planSource == 'AI'}">
                                    <span class="adm-courses-source-ai">${msg_admin_courses_detail_source_aiGenerated}</span>
                                </c:when>
                                <c:when test="${plan.planSource == 'MANUAL'}">
                                    <span class="adm-courses-source-manual">${msg_admin_courses_detail_source_manualCreated}</span>
                                </c:when>
                                <c:otherwise>${plan.planSource}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="adm-courses-detail-field">
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_visibility}</div>
                        <div class="adm-courses-detail-value">
                            <c:choose>
                                <c:when test="${plan.isPublic == 1}"><span class="adm-courses-public">${msg_admin_courses_visibility_public}</span></c:when>
                                <c:otherwise><span class="adm-courses-muted">${msg_admin_courses_visibility_private}</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="adm-courses-detail-field">
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_createdAt}</div>
                        <div class="adm-courses-detail-subvalue">
                            <fmt:formatDate value="${plan.createdAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                        </div>
                    </div>
                    <div class="adm-courses-detail-field">
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_updatedAt}</div>
                        <div class="adm-courses-detail-subvalue">
                            <c:choose>
                                <c:when test="${not empty plan.updatedAt}">
                                    <fmt:formatDate value="${plan.updatedAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                                </c:when>
                                <c:otherwise><span class="adm-courses-muted">${msg_admin_common_dash}</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- ── 스팟 목록 ── --%>
        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title">
                    ${msg_admin_courses_detail_spots_title}
                    <span class="adm-section-total-inline">${msg_admin_courses_detail_spotsTotalCountDisplay}</span>
                </div>
            </div>

            <c:if test="${empty spots}">
                <div class="adm-courses-empty-state">${msg_admin_courses_detail_spots_empty}</div>
            </c:if>

            <c:if test="${not empty spots}">
                <c:set var="prevDate" value=""/>
                <div class="adm-courses-spots-list">
                <c:forEach items="${spots}" var="s">
                    <fmt:formatDate value="${s.visitDate}" pattern="yyyy-MM-dd" var="curDate"/>
                    <c:if test="${curDate != prevDate}">
                        <c:if test="${prevDate != ''}"></div></c:if>
                        <div class="adm-courses-visit-date">
                            <fmt:formatDate value="${s.visitDate}" pattern="yyyy.MM.dd (E)"/>
                        </div>
                        <div class="adm-courses-spot-timeline">
                        <c:set var="prevDate" value="${curDate}"/>
                    </c:if>
                    <div class="adm-courses-spot-row">
                        <div class="adm-courses-spot-inner">
                            <span class="adm-courses-spot-order">${s.visitOrder}</span>
                            <div class="adm-courses-spot-body">
                                <div class="adm-courses-spot-name">
                                    <c:choose>
                                        <c:when test="${not empty s.placeName}">${s.placeName}</c:when>
                                        <c:when test="${not empty s.spotName}">${s.spotName}</c:when>
                                        <c:otherwise><span class="adm-courses-muted">${msg_admin_courses_detail_spots_noName}</span></c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="adm-courses-spot-meta">
                                    <c:if test="${not empty s.spotRegion}">${s.spotRegion} · </c:if>
                                    <c:if test="${not empty s.spotId}">spot_id: ${s.spotId}</c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                </div>
                </div>
            </c:if>
        </div>
    </c:if>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var PLAN_ID = '${plan.planId}';
var COURSE_DETAIL_MESSAGES = {
    actionDelete: '${msg_admin_common_delete_js}',
    actionRestore: '${msg_admin_common_restore_js}',
    confirmAction: '${msg_admin_courses_detail_js_confirmAction_js}',
    error: '${msg_admin_common_processError_js}'
};

function formatCourseDetailMessage(template) {
    var args = Array.prototype.slice.call(arguments, 1);
    return template.replace(/\{(\d+)\}/g, function (_, idx) {
        return typeof args[idx] !== 'undefined' ? args[idx] : '';
    });
}

function actionPlan(action) {
    var label = action === 'delete' ? COURSE_DETAIL_MESSAGES.actionDelete : COURSE_DETAIL_MESSAGES.actionRestore;
    if (!confirm(formatCourseDetailMessage(COURSE_DETAIL_MESSAGES.confirmAction, label))) return;
    fetch(ctx + '/admin/courses/' + PLAN_ID + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COURSE_DETAIL_MESSAGES.error); }
    });
}
</script>

<%@ include file="../layout-close.jsp" %>
