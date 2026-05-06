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
<spring:message var="msg_admin_courses_detail_spots_total" code="admin.courses.detail.spots.total"/>
<spring:message var="msg_admin_courses_detail_spots_empty" code="admin.courses.detail.spots.empty"/>
<spring:message var="msg_admin_courses_detail_spots_noName" code="admin.courses.detail.spots.noName"/>
<c:set var="pageTitle" value="${msg_admin_courses_detail_pageTitle}"/>
<c:set var="activeMenu" value="courses"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div style="margin-bottom:16px;">
        <a href="${pageContext.request.contextPath}/admin/courses" class="adm-back-link">${msg_admin_courses_detail_backToList}</a>
    </div>

    <c:if test="${empty plan}">
        <div class="adm-card" style="padding:40px;text-align:center;color:#64748b;">
            ${msg_admin_courses_detail_notFound}
        </div>
    </c:if>

    <c:if test="${not empty plan}">

        <%-- ── 코스 헤더 ── --%>
        <div class="adm-card" style="margin-bottom:20px;">
            <div class="adm-card-head">
                <div style="display:flex;align-items:center;gap:12px;">
                    <span class="adm-card-title" style="font-size:16px;">#${plan.planId} · ${plan.title}</span>
                    <c:choose>
                        <c:when test="${plan.isDeleted == 0}">
                            <span class="status-badge ACTIVE">${msg_admin_common_active}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge DELETED">${msg_admin_courses_status_deleted}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="display:flex;gap:6px;">
                    <c:choose>
                        <c:when test="${plan.isDeleted == 0}">
                            <button class="adm-btn adm-btn-ghost"
                                    style="color:#f87171;border-color:#f87171;"
                                    onclick="actionPlan('delete')">${msg_admin_common_delete}</button>
                        </c:when>
                        <c:otherwise>
                            <button class="adm-btn adm-btn-ghost"
                                    style="color:#34d399;border-color:#34d399;"
                                    onclick="actionPlan('restore')">${msg_admin_common_restore}</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="adm-card-body">
                <div style="display:grid;grid-template-columns:repeat(4, minmax(0, 1fr));gap:14px;">
                    <div>
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_author}</div>
                        <div style="font-weight:600;color:#7dd3fc;">${plan.nickname}</div>
                        <div style="font-size:11px;color:#64748b;">${plan.userId}</div>
                        <c:if test="${plan.accountStatus == 'BLOCKED'}">
                            <span class="adm-inline-danger">${msg_admin_courses_detail_accountBlocked}</span>
                        </c:if>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_destination}</div>
                        <div style="font-size:13px;color:#cbd5e1;">
                            <c:choose>
                                <c:when test="${not empty plan.destination}">${plan.destination}</c:when>
                                <c:otherwise><span style="color:#475569;">${msg_admin_common_dash}</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_period}</div>
                        <div style="font-size:12px;color:#94a3b8;">
                            <c:choose>
                                <c:when test="${not empty plan.startDate}">
                                    <fmt:formatDate value="${plan.startDate}" pattern="yyyy.MM.dd"/>
                                    ~ <fmt:formatDate value="${plan.endDate}" pattern="yyyy.MM.dd"/>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">${msg_admin_common_dash}</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_spotCount}</div>
                        <div style="color:#7dd3fc;font-weight:600;">${plan.spotCount}${msg_admin_common_countSuffix}</div>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_source}</div>
                        <div style="font-size:13px;">
                            <c:choose>
                                <c:when test="${plan.planSource == 'AI'}">
                                    <span style="color:#a78bfa;font-weight:600;">${msg_admin_courses_detail_source_aiGenerated}</span>
                                </c:when>
                                <c:when test="${plan.planSource == 'MANUAL'}">
                                    <span style="color:#94a3b8;">${msg_admin_courses_detail_source_manualCreated}</span>
                                </c:when>
                                <c:otherwise>${plan.planSource}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_visibility}</div>
                        <div style="font-size:13px;">
                            <c:choose>
                                <c:when test="${plan.isPublic == 1}"><span style="color:#34d399;">${msg_admin_courses_visibility_public}</span></c:when>
                                <c:otherwise><span style="color:#64748b;">${msg_admin_courses_visibility_private}</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_createdAt}</div>
                        <div style="font-size:12px;color:#94a3b8;">
                            <fmt:formatDate value="${plan.createdAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_courses_detail_field_updatedAt}</div>
                        <div style="font-size:12px;color:#94a3b8;">
                            <c:choose>
                                <c:when test="${not empty plan.updatedAt}">
                                    <fmt:formatDate value="${plan.updatedAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">${msg_admin_common_dash}</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- ── 스팟 목록 ── --%>
        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${msg_admin_courses_detail_spots_title}</div>
                <div class="adm-muted-note">${msg_admin_courses_detail_spots_total} ${fn:length(spots)}${msg_admin_common_countSuffix}</div>
            </div>

            <c:if test="${empty spots}">
                <div style="padding:40px;text-align:center;color:#475569;">${msg_admin_courses_detail_spots_empty}</div>
            </c:if>

            <c:if test="${not empty spots}">
                <c:set var="prevDate" value=""/>
                <div style="padding:10px 20px 20px;">
                <c:forEach items="${spots}" var="s">
                    <fmt:formatDate value="${s.visitDate}" pattern="yyyy-MM-dd" var="curDate"/>
                    <c:if test="${curDate != prevDate}">
                        <c:if test="${prevDate != ''}"></div></c:if>
                        <div style="margin-top:16px;padding:8px 12px;background:#1e293b;border-radius:6px;
                                    font-weight:600;font-size:13px;color:#7dd3fc;">
                            <fmt:formatDate value="${s.visitDate}" pattern="yyyy.MM.dd (E)"/>
                        </div>
                        <div style="border-left:2px solid #334155;margin-left:12px;padding-left:14px;margin-top:6px;">
                        <c:set var="prevDate" value="${curDate}"/>
                    </c:if>
                    <div style="padding:10px 0;border-bottom:1px dashed #334155;">
                        <div style="display:flex;align-items:center;gap:10px;">
                            <span style="display:inline-block;min-width:28px;height:28px;line-height:28px;
                                         text-align:center;background:#334155;color:#cbd5e1;border-radius:50%;
                                         font-size:12px;font-weight:600;">${s.visitOrder}</span>
                            <div style="flex:1;">
                                <div style="font-weight:600;font-size:14px;color:#e2e8f0;">
                                    <c:choose>
                                        <c:when test="${not empty s.placeName}">${s.placeName}</c:when>
                                        <c:when test="${not empty s.spotName}">${s.spotName}</c:when>
                                        <c:otherwise><span style="color:#64748b;">${msg_admin_courses_detail_spots_noName}</span></c:otherwise>
                                    </c:choose>
                                </div>
                                <div style="font-size:11px;color:#64748b;margin-top:2px;">
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
