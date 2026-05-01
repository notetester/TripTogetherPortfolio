<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="courses"/>
<spring:message code="admin.courses.detail.pageTitle" var="pageTitle"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div style="margin-bottom:16px;">
        <a href="${pageContext.request.contextPath}/admin/courses" class="adm-back-link"><spring:message code="admin.courses.detail.backToList"/></a>
    </div>

    <c:if test="${empty plan}">
        <div class="adm-card" style="padding:40px;text-align:center;color:#64748b;">
            <spring:message code="admin.courses.detail.notFound"/>
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
                            <span class="status-badge ACTIVE"><spring:message code="admin.common.active"/></span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge DELETED"><spring:message code="admin.courses.status.deleted"/></span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="display:flex;gap:6px;">
                    <c:choose>
                        <c:when test="${plan.isDeleted == 0}">
                            <button class="adm-btn adm-btn-ghost"
                                    style="color:#f87171;border-color:#f87171;"
                                    onclick="actionPlan('delete')"><spring:message code="admin.common.delete"/></button>
                        </c:when>
                        <c:otherwise>
                            <button class="adm-btn adm-btn-ghost"
                                    style="color:#34d399;border-color:#34d399;"
                                    onclick="actionPlan('restore')"><spring:message code="admin.common.restore"/></button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="adm-card-body">
                <div style="display:grid;grid-template-columns:repeat(4, minmax(0, 1fr));gap:14px;">
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.detail.field.author"/></div>
                        <div style="font-weight:600;color:#7dd3fc;">${plan.nickname}</div>
                        <div style="font-size:11px;color:#64748b;">${plan.userId}</div>
                        <c:if test="${plan.accountStatus == 'BLOCKED'}">
                            <span class="adm-inline-danger"><spring:message code="admin.courses.detail.accountBlocked"/></span>
                        </c:if>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.detail.field.destination"/></div>
                        <div style="font-size:13px;color:#cbd5e1;">
                            <c:choose>
                                <c:when test="${not empty plan.destination}">${plan.destination}</c:when>
                                <c:otherwise><span style="color:#475569;"><spring:message code="admin.common.dash"/></span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.detail.field.period"/></div>
                        <div style="font-size:12px;color:#94a3b8;">
                            <c:choose>
                                <c:when test="${not empty plan.startDate}">
                                    <fmt:formatDate value="${plan.startDate}" pattern="yyyy.MM.dd"/>
                                    ~ <fmt:formatDate value="${plan.endDate}" pattern="yyyy.MM.dd"/>
                                </c:when>
                                <c:otherwise><span style="color:#475569;"><spring:message code="admin.common.dash"/></span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.detail.field.spotCount"/></div>
                        <div style="color:#7dd3fc;font-weight:600;">${plan.spotCount}<spring:message code="admin.common.countSuffix"/></div>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.detail.field.source"/></div>
                        <div style="font-size:13px;">
                            <c:choose>
                                <c:when test="${plan.planSource == 'AI'}">
                                    <span style="color:#a78bfa;font-weight:600;"><spring:message code="admin.courses.detail.source.aiGenerated"/></span>
                                </c:when>
                                <c:when test="${plan.planSource == 'MANUAL'}">
                                    <span style="color:#94a3b8;"><spring:message code="admin.courses.detail.source.manualCreated"/></span>
                                </c:when>
                                <c:otherwise>${plan.planSource}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.detail.field.visibility"/></div>
                        <div style="font-size:13px;">
                            <c:choose>
                                <c:when test="${plan.isPublic == 1}"><span style="color:#34d399;"><spring:message code="admin.courses.visibility.public"/></span></c:when>
                                <c:otherwise><span style="color:#64748b;"><spring:message code="admin.courses.visibility.private"/></span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.detail.field.createdAt"/></div>
                        <div style="font-size:12px;color:#94a3b8;">
                            <fmt:formatDate value="${plan.createdAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.detail.field.updatedAt"/></div>
                        <div style="font-size:12px;color:#94a3b8;">
                            <c:choose>
                                <c:when test="${not empty plan.updatedAt}">
                                    <fmt:formatDate value="${plan.updatedAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                                </c:when>
                                <c:otherwise><span style="color:#475569;"><spring:message code="admin.common.dash"/></span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- ── 스팟 목록 ── --%>
        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title"><spring:message code="admin.courses.detail.spots.title"/></div>
                <div class="adm-muted-note"><spring:message code="admin.courses.detail.spots.total"/> ${fn:length(spots)}<spring:message code="admin.common.countSuffix"/></div>
            </div>

            <c:if test="${empty spots}">
                <div style="padding:40px;text-align:center;color:#475569;"><spring:message code="admin.courses.detail.spots.empty"/></div>
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
                                        <c:otherwise><span style="color:#64748b;"><spring:message code="admin.courses.detail.spots.noName"/></span></c:otherwise>
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
    actionDelete: '<spring:message code="admin.common.delete" javaScriptEscape="true"/>',
    actionRestore: '<spring:message code="admin.common.restore" javaScriptEscape="true"/>',
    confirmAction: '<spring:message code="admin.courses.detail.js.confirmAction" javaScriptEscape="true"/>',
    error: '<spring:message code="admin.common.processError" javaScriptEscape="true"/>'
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
