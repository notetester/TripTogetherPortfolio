<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_49e143a0c3" code="admin.courses.detail.backToList"/>
<spring:message var="autoMsg_522d88bf1d" code="admin.common.active"/>
<spring:message var="autoMsg_98c1417ea2" code="admin.courses.status.deleted"/>
<spring:message var="autoMsg_83f4f2911c" code="admin.common.delete"/>
<spring:message var="autoMsg_5fe2e11d09" code="admin.common.restore"/>
<spring:message var="autoMsg_e4ae7a8f73" code="admin.courses.detail.field.author"/>
<spring:message var="autoMsg_4fe47c2c1b" code="admin.courses.detail.accountBlocked"/>
<spring:message var="autoMsg_2dccf54b28" code="admin.courses.detail.field.destination"/>
<spring:message var="autoMsg_79b60138a7" code="admin.common.dash"/>
<spring:message var="autoMsg_320cd09d9d" code="admin.courses.detail.field.period"/>
<spring:message var="autoMsg_9f5bc5a093" code="admin.courses.detail.field.spotCount"/>
<spring:message var="autoMsg_b0c331f1c7" code="admin.common.countSuffix"/>
<spring:message var="autoMsg_45272a9119" code="admin.courses.detail.field.source"/>
<spring:message var="autoMsg_f25fa26e4c" code="admin.courses.detail.source.aiGenerated"/>
<spring:message var="autoMsg_fdd0202b89" code="admin.courses.detail.source.manualCreated"/>
<spring:message var="autoMsg_b28fc1bdf9" code="admin.courses.detail.field.visibility"/>
<spring:message var="autoMsg_0e7c426335" code="admin.courses.visibility.public"/>
<spring:message var="autoMsg_6c76ab0510" code="admin.courses.visibility.private"/>
<spring:message var="autoMsg_7571899b26" code="admin.courses.detail.field.createdAt"/>
<spring:message var="autoMsg_e3501c9b55" code="admin.courses.detail.field.updatedAt"/>
<spring:message var="autoMsg_5b0c4b0a08" code="admin.courses.detail.spots.title"/>
<spring:message var="autoMsg_38ce291a23" code="admin.courses.detail.spots.total"/>
<spring:message var="autoMsg_2466273637" code="admin.courses.detail.spots.empty"/>
<spring:message var="autoMsg_85cfca7bef" code="admin.courses.detail.spots.noName"/>
<spring:message var="autoMsg_44d69b97f7" code="admin.common.delete" javaScriptEscape="true"/>
<spring:message var="autoMsg_b923334623" code="admin.common.restore" javaScriptEscape="true"/>
<spring:message var="autoMsg_be3a9a734d" code="admin.courses.detail.js.confirmAction" javaScriptEscape="true"/>
<spring:message var="autoMsg_6b58a881c7" code="admin.common.processError" javaScriptEscape="true"/>
<c:set var="activeMenu" value="courses"/>
<spring:message code="admin.courses.detail.pageTitle" var="pageTitle"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div style="margin-bottom:16px;">
        <a href="${pageContext.request.contextPath}/admin/courses" class="adm-back-link">${autoMsg_49e143a0c3}</a>
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
                            <span class="status-badge ACTIVE">${autoMsg_522d88bf1d}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge DELETED">${autoMsg_98c1417ea2}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div style="display:flex;gap:6px;">
                    <c:choose>
                        <c:when test="${plan.isDeleted == 0}">
                            <button class="adm-btn adm-btn-ghost"
                                    style="color:#f87171;border-color:#f87171;"
                                    onclick="actionPlan('delete')">${autoMsg_83f4f2911c}</button>
                        </c:when>
                        <c:otherwise>
                            <button class="adm-btn adm-btn-ghost"
                                    style="color:#34d399;border-color:#34d399;"
                                    onclick="actionPlan('restore')">${autoMsg_5fe2e11d09}</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="adm-card-body">
                <div style="display:grid;grid-template-columns:repeat(4, minmax(0, 1fr));gap:14px;">
                    <div>
                        <div class="adm-filter-label">${autoMsg_e4ae7a8f73}</div>
                        <div style="font-weight:600;color:#7dd3fc;">${plan.nickname}</div>
                        <div style="font-size:11px;color:#64748b;">${plan.userId}</div>
                        <c:if test="${plan.accountStatus == 'BLOCKED'}">
                            <span class="adm-inline-danger">${autoMsg_4fe47c2c1b}</span>
                        </c:if>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_2dccf54b28}</div>
                        <div style="font-size:13px;color:#cbd5e1;">
                            <c:choose>
                                <c:when test="${not empty plan.destination}">${plan.destination}</c:when>
                                <c:otherwise><span style="color:#475569;">${autoMsg_79b60138a7}</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_320cd09d9d}</div>
                        <div style="font-size:12px;color:#94a3b8;">
                            <c:choose>
                                <c:when test="${not empty plan.startDate}">
                                    <fmt:formatDate value="${plan.startDate}" pattern="yyyy.MM.dd"/>
                                    ~ <fmt:formatDate value="${plan.endDate}" pattern="yyyy.MM.dd"/>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">${autoMsg_79b60138a7}</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_9f5bc5a093}</div>
                        <div style="color:#7dd3fc;font-weight:600;">${plan.spotCount}${autoMsg_b0c331f1c7}</div>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_45272a9119}</div>
                        <div style="font-size:13px;">
                            <c:choose>
                                <c:when test="${plan.planSource == 'AI'}">
                                    <span style="color:#a78bfa;font-weight:600;">${autoMsg_f25fa26e4c}</span>
                                </c:when>
                                <c:when test="${plan.planSource == 'MANUAL'}">
                                    <span style="color:#94a3b8;">${autoMsg_fdd0202b89}</span>
                                </c:when>
                                <c:otherwise>${plan.planSource}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_b28fc1bdf9}</div>
                        <div style="font-size:13px;">
                            <c:choose>
                                <c:when test="${plan.isPublic == 1}"><span style="color:#34d399;">${autoMsg_0e7c426335}</span></c:when>
                                <c:otherwise><span style="color:#64748b;">${autoMsg_6c76ab0510}</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_7571899b26}</div>
                        <div style="font-size:12px;color:#94a3b8;">
                            <fmt:formatDate value="${plan.createdAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                        </div>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_e3501c9b55}</div>
                        <div style="font-size:12px;color:#94a3b8;">
                            <c:choose>
                                <c:when test="${not empty plan.updatedAt}">
                                    <fmt:formatDate value="${plan.updatedAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">${autoMsg_79b60138a7}</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- ── 스팟 목록 ── --%>
        <div class="adm-card">
            <div class="adm-card-head">
                <div class="adm-card-title">${autoMsg_5b0c4b0a08}</div>
                <div class="adm-muted-note">${autoMsg_38ce291a23} ${fn:length(spots)}${autoMsg_b0c331f1c7}</div>
            </div>

            <c:if test="${empty spots}">
                <div style="padding:40px;text-align:center;color:#475569;">${autoMsg_2466273637}</div>
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
                                        <c:otherwise><span style="color:#64748b;">${autoMsg_85cfca7bef}</span></c:otherwise>
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
    actionDelete: '${autoMsg_44d69b97f7}',
    actionRestore: '${autoMsg_b923334623}',
    confirmAction: '${autoMsg_be3a9a734d}',
    error: '${autoMsg_6b58a881c7}'
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
