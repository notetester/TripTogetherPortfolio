<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="courses"/>
<spring:message code="admin.courses.list.pageTitle" var="pageTitle"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.courses.list.summary.active"/></div>
            <div class="adm-summary-value is-primary">${stats.activePlans}</div>
            <div class="adm-summary-sub"><spring:message code="admin.courses.list.summary.total"/> ${stats.totalPlans}<spring:message code="admin.common.countSuffix"/></div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.courses.list.summary.deleted"/></div>
            <div class="adm-summary-value is-danger">${stats.deletedPlans}</div>
            <div class="adm-summary-sub"><spring:message code="admin.courses.list.summary.today"/> ${stats.todayPlans}<spring:message code="admin.common.countSuffix"/></div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.courses.list.summary.ai"/></div>
            <div class="adm-summary-value is-success">${stats.aiPlans}</div>
            <div class="adm-summary-sub"><spring:message code="admin.courses.list.summary.manual"/> ${stats.manualPlans}<spring:message code="admin.common.countSuffix"/></div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.courses.list.summary.public"/></div>
            <div class="adm-summary-value is-warning">${stats.publicPlans}</div>
            <div class="adm-summary-sub"><spring:message code="admin.courses.list.summary.private"/> ${stats.privatePlans}<spring:message code="admin.common.countSuffix"/></div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/courses" id="searchForm">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.list.filter.status"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ?'selected':''}><spring:message code="admin.common.active"/></option>
                            <option value="DELETED" ${search.status=='DELETED' ?'selected':''}><spring:message code="admin.courses.status.deleted"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.list.filter.source"/></div>
                        <select class="adm-select" name="planSource">
                            <option value="ALL"    ${search.planSource=='ALL'    ?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="MANUAL" ${search.planSource=='MANUAL' ?'selected':''}><spring:message code="admin.courses.source.manual"/></option>
                            <option value="AI"     ${search.planSource=='AI'     ?'selected':''}><spring:message code="admin.courses.source.ai"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.list.filter.visibility"/></div>
                        <select class="adm-select" name="isPublic">
                            <option value="ALL"     ${search.isPublic=='ALL'     ?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="PUBLIC"  ${search.isPublic=='PUBLIC'  ?'selected':''}><spring:message code="admin.courses.visibility.public"/></option>
                            <option value="PRIVATE" ${search.isPublic=='PRIVATE' ?'selected':''}><spring:message code="admin.courses.visibility.private"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.courses.list.filter.sort"/></div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt" ${search.sortBy=='createdAt' ?'selected':''}><spring:message code="admin.courses.list.sort.createdAt"/></option>
                            <option value="updatedAt" ${search.sortBy=='updatedAt' ?'selected':''}><spring:message code="admin.courses.list.sort.updatedAt"/></option>
                            <option value="startDate" ${search.sortBy=='startDate' ?'selected':''}><spring:message code="admin.courses.list.sort.startDate"/></option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label"><spring:message code="admin.common.search"/></div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:120px;">
                                <option value="all"         ${search.searchType=='all'         ?'selected':''}><spring:message code="admin.common.all"/></option>
                                <option value="title"       ${search.searchType=='title'       ?'selected':''}><spring:message code="admin.courses.list.search.title"/></option>
                                <option value="destination" ${search.searchType=='destination' ?'selected':''}><spring:message code="admin.courses.list.search.destination"/></option>
                                <option value="nickname"    ${search.searchType=='nickname'    ?'selected':''}><spring:message code="admin.common.nickname"/></option>
                                <option value="userId"      ${search.searchType=='userId'      ?'selected':''}><spring:message code="admin.common.userId"/></option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(search.keyword)}"
                                   placeholder="<spring:message code='admin.courses.list.filter.keywordPlaceholder'/>" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.search"/></button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/courses"><spring:message code="admin.common.reset"/></a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title"><spring:message code="admin.courses.list.title"/></div>
                <div class="adm-muted-note"><spring:message code="admin.courses.list.total"/> ${total}<spring:message code="admin.common.countSuffix"/></div>
            </div>
            <%-- 일괄 처리 버튼 --%>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" style="font-size:12px;color:#94a3b8;"></span>
                <button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;"
                        onclick="bulkAction('delete')"><spring:message code="admin.courses.list.action.bulkDelete"/></button>
                <button class="adm-btn adm-btn-ghost" style="color:#34d399;border-color:#34d399;"
                        onclick="bulkAction('restore')"><spring:message code="admin.courses.list.action.bulkRestore"/></button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:60px;">ID</th>
                    <th><spring:message code="admin.courses.list.table.author"/></th>
                    <th><spring:message code="admin.courses.list.table.title"/></th>
                    <th><spring:message code="admin.courses.list.table.destination"/></th>
                    <th style="width:120px;"><spring:message code="admin.courses.list.table.period"/></th>
                    <th style="width:50px;"><spring:message code="admin.courses.list.table.spots"/></th>
                    <th style="width:60px;"><spring:message code="admin.courses.list.table.source"/></th>
                    <th style="width:60px;"><spring:message code="admin.courses.list.table.visibility"/></th>
                    <th style="width:70px;"><spring:message code="admin.common.accountStatus"/></th>
                    <th style="width:90px;"><spring:message code="admin.courses.list.table.createdAt"/></th>
                    <th style="width:120px;"><spring:message code="admin.common.action"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="p">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${p.planId}"></td>
                        <td style="color:#64748b;font-size:12px;">#${p.planId}</td>

                        <%-- 작성자 --%>
                        <td>
                            <div style="font-weight:600;font-size:13px;color:#7dd3fc;">${p.nickname}</div>
                            <div style="font-size:11px;color:#64748b;">${p.userId}</div>
                            <c:if test="${p.accountStatus == 'BLOCKED'}">
                                <span class="adm-inline-danger"><spring:message code="admin.courses.list.accountBlocked"/></span>
                            </c:if>
                        </td>

                        <%-- 제목 --%>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/courses/${p.planId}"
                               class="adm-link-title" title="${p.title}">
                                <c:choose>
                                    <c:when test="${fn:length(p.title) > 24}">${fn:substring(p.title, 0, 24)}…</c:when>
                                    <c:otherwise>${p.title}</c:otherwise>
                                </c:choose>
                            </a>
                        </td>

                        <%-- 여행지 --%>
                        <td style="font-size:12px;color:#cbd5e1;">
                            <c:choose>
                                <c:when test="${not empty p.destination}">${p.destination}</c:when>
                                <c:otherwise><span style="color:#475569;"><spring:message code="admin.common.dash"/></span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 일정 --%>
                        <td style="font-size:11px;color:#94a3b8;">
                            <c:choose>
                                <c:when test="${not empty p.startDate}">
                                    <fmt:formatDate value="${p.startDate}" pattern="yyyy.MM.dd"/>
                                    <div>~ <fmt:formatDate value="${p.endDate}" pattern="MM.dd"/></div>
                                </c:when>
                                <c:otherwise><span style="color:#475569;"><spring:message code="admin.common.dash"/></span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 스팟 수 --%>
                        <td style="text-align:center;">
                            <c:choose>
                                <c:when test="${p.spotCount > 0}">
                                    <span style="color:#7dd3fc;font-weight:600;">${p.spotCount}</span>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">0</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 유형 --%>
                        <td style="font-size:12px;">
                            <c:choose>
                                <c:when test="${p.planSource == 'AI'}">
                                    <span style="color:#a78bfa;font-weight:600;"><spring:message code="admin.courses.source.ai"/></span>
                                </c:when>
                                <c:when test="${p.planSource == 'MANUAL'}">
                                    <span style="color:#94a3b8;"><spring:message code="admin.courses.source.manual"/></span>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">${p.planSource}</span></c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 공개 --%>
                        <td style="font-size:12px;">
                            <c:choose>
                                <c:when test="${p.isPublic == 1}">
                                    <span style="color:#34d399;"><spring:message code="admin.courses.visibility.public"/></span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#64748b;"><spring:message code="admin.courses.visibility.private"/></span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 상태 --%>
                        <td>
                            <c:choose>
                                <c:when test="${p.isDeleted == 0}">
                                    <span class="status-badge ACTIVE"><spring:message code="admin.common.active"/></span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge DELETED"><spring:message code="admin.courses.status.deleted"/></span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 등록일 --%>
                        <td style="font-size:11px;color:#64748b;">
                            <fmt:formatDate value="${p.createdAt}" pattern="yyyy.MM.dd"/>
                            <div><fmt:formatDate value="${p.createdAt}" pattern="HH:mm"/></div>
                        </td>

                        <%-- 액션 --%>
                        <td>
                            <div class="adm-row-actions is-single">
                                <c:choose>
                                    <c:when test="${p.isDeleted == 0}">
                                        <button class="adm-row-btn danger"
                                                type="button"
                                                data-id="${p.planId}"
                                                onclick="actionPlan(this.getAttribute('data-id'), 'delete')"><spring:message code="admin.common.delete"/></button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="adm-row-btn success"
                                                type="button"
                                                data-id="${p.planId}"
                                                onclick="actionPlan(this.getAttribute('data-id'), 'restore')"><spring:message code="admin.common.restore"/></button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="12" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.courses.list.empty"/></td></tr>
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
                <span class="adm-page-info">${paging.currentPage} / ${paging.totalPage}</span>
            </div>
        </c:if>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var COURSE_LIST_MESSAGES = {
    bulkSelected: '<spring:message code="admin.courses.list.js.bulkSelected" javaScriptEscape="true"/>',
    actionDelete: '<spring:message code="admin.common.delete" javaScriptEscape="true"/>',
    actionRestore: '<spring:message code="admin.common.restore" javaScriptEscape="true"/>',
    confirmSingle: '<spring:message code="admin.courses.list.js.confirmSingle" javaScriptEscape="true"/>',
    confirmBulk: '<spring:message code="admin.courses.list.js.confirmBulk" javaScriptEscape="true"/>',
    noSelection: '<spring:message code="admin.courses.list.js.noSelection" javaScriptEscape="true"/>',
    error: '<spring:message code="admin.common.processError" javaScriptEscape="true"/>'
};

function formatCourseListMessage(template) {
    var args = Array.prototype.slice.call(arguments, 1);
    return template.replace(/\{(\d+)\}/g, function (_, idx) {
        return typeof args[idx] !== 'undefined' ? args[idx] : '';
    });
}

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
        document.getElementById('bulkCount').textContent = formatCourseListMessage(COURSE_LIST_MESSAGES.bulkSelected, checked.length);
    } else {
        bar.style.display = 'none';
    }
}

// ── 단건 액션 ──
function actionPlan(planId, action) {
    var label = action === 'delete' ? COURSE_LIST_MESSAGES.actionDelete : COURSE_LIST_MESSAGES.actionRestore;
    if (!confirm(formatCourseListMessage(COURSE_LIST_MESSAGES.confirmSingle, planId, label))) return;
    fetch(ctx + '/admin/courses/' + planId + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COURSE_LIST_MESSAGES.error); }
    });
}

// ── 일괄 처리 ──
function bulkAction(action) {
    var ids = Array.from(document.querySelectorAll('.row-check:checked'))
                   .map(function (cb) { return cb.getAttribute('data-id'); });
    if (ids.length === 0) { alert(COURSE_LIST_MESSAGES.noSelection); return; }
    var label = action === 'delete' ? COURSE_LIST_MESSAGES.actionDelete : COURSE_LIST_MESSAGES.actionRestore;
    if (!confirm(formatCourseListMessage(COURSE_LIST_MESSAGES.confirmBulk, ids.length, label))) return;

    var body = 'action=' + action + '&' + ids.map(function (id) { return 'ids=' + id; }).join('&');
    fetch(ctx + '/admin/courses/bulk-action', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: body
    }).then(function (r) { return r.json(); })
      .then(function (d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || COURSE_LIST_MESSAGES.error); }
    });
}

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = ctx + '/admin/courses?' + params.toString();
}
</script>

<%@ include file="../layout-close.jsp" %>
