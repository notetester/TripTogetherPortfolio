<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_courses_list_filter_keywordPlaceholder" code="admin.courses.list.filter.keywordPlaceholder"/>
<spring:message var="msg_admin_courses_list_js_bulkSelected_js" code="admin.courses.list.js.bulkSelected" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_delete_js" code="admin.common.delete" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_restore_js" code="admin.common.restore" javaScriptEscape="true"/>
<spring:message var="msg_admin_courses_list_js_confirmSingle_js" code="admin.courses.list.js.confirmSingle" javaScriptEscape="true"/>
<spring:message var="msg_admin_courses_list_js_confirmBulk_js" code="admin.courses.list.js.confirmBulk" javaScriptEscape="true"/>
<spring:message var="msg_admin_courses_list_js_noSelection_js" code="admin.courses.list.js.noSelection" javaScriptEscape="true"/>
<spring:message var="msg_admin_common_processError_js" code="admin.common.processError" javaScriptEscape="true"/>
<spring:message var="msg_admin_courses_list_pageTitle" code="admin.courses.list.pageTitle"/>
<spring:message var="msg_admin_courses_list_summary_active" code="admin.courses.list.summary.active"/>
<spring:message var="msg_admin_courses_list_summary_total" code="admin.courses.list.summary.total"/>
<spring:message var="msg_admin_common_countSuffix" code="admin.common.countSuffix"/>
<spring:message var="msg_admin_courses_list_summary_deleted" code="admin.courses.list.summary.deleted"/>
<spring:message var="msg_admin_courses_list_summary_today" code="admin.courses.list.summary.today"/>
<spring:message var="msg_admin_courses_list_summary_ai" code="admin.courses.list.summary.ai"/>
<spring:message var="msg_admin_courses_list_summary_manual" code="admin.courses.list.summary.manual"/>
<spring:message var="msg_admin_courses_list_summary_public" code="admin.courses.list.summary.public"/>
<spring:message var="msg_admin_courses_list_summary_private" code="admin.courses.list.summary.private"/>
<spring:message var="msg_admin_courses_list_filter_status" code="admin.courses.list.filter.status"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_common_active" code="admin.common.active"/>
<spring:message var="msg_admin_courses_status_deleted" code="admin.courses.status.deleted"/>
<spring:message var="msg_admin_courses_list_filter_source" code="admin.courses.list.filter.source"/>
<spring:message var="msg_admin_courses_source_manual" code="admin.courses.source.manual"/>
<spring:message var="msg_admin_courses_source_ai" code="admin.courses.source.ai"/>
<spring:message var="msg_admin_courses_list_filter_visibility" code="admin.courses.list.filter.visibility"/>
<spring:message var="msg_admin_courses_visibility_public" code="admin.courses.visibility.public"/>
<spring:message var="msg_admin_courses_visibility_private" code="admin.courses.visibility.private"/>
<spring:message var="msg_admin_courses_list_filter_sort" code="admin.courses.list.filter.sort"/>
<spring:message var="msg_admin_courses_list_sort_createdAt" code="admin.courses.list.sort.createdAt"/>
<spring:message var="msg_admin_courses_list_sort_updatedAt" code="admin.courses.list.sort.updatedAt"/>
<spring:message var="msg_admin_courses_list_sort_startDate" code="admin.courses.list.sort.startDate"/>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_courses_list_search_title" code="admin.courses.list.search.title"/>
<spring:message var="msg_admin_courses_list_search_destination" code="admin.courses.list.search.destination"/>
<spring:message var="msg_admin_common_nickname" code="admin.common.nickname"/>
<spring:message var="msg_admin_common_userId" code="admin.common.userId"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_courses_list_title" code="admin.courses.list.title"/>
<spring:message var="msg_admin_courses_list_total" code="admin.courses.list.total"/>
<spring:message var="msg_admin_courses_list_action_bulkDelete" code="admin.courses.list.action.bulkDelete"/>
<spring:message var="msg_admin_courses_list_action_bulkRestore" code="admin.courses.list.action.bulkRestore"/>
<spring:message var="msg_admin_courses_list_table_author" code="admin.courses.list.table.author"/>
<spring:message var="msg_admin_courses_list_table_title" code="admin.courses.list.table.title"/>
<spring:message var="msg_admin_courses_list_table_destination" code="admin.courses.list.table.destination"/>
<spring:message var="msg_admin_courses_list_table_period" code="admin.courses.list.table.period"/>
<spring:message var="msg_admin_courses_list_table_spots" code="admin.courses.list.table.spots"/>
<spring:message var="msg_admin_courses_list_table_source" code="admin.courses.list.table.source"/>
<spring:message var="msg_admin_courses_list_table_visibility" code="admin.courses.list.table.visibility"/>
<spring:message var="msg_admin_common_accountStatus" code="admin.common.accountStatus"/>
<spring:message var="msg_admin_courses_list_table_createdAt" code="admin.courses.list.table.createdAt"/>
<spring:message var="msg_admin_common_action" code="admin.common.action"/>
<spring:message var="msg_admin_courses_list_accountBlocked" code="admin.courses.list.accountBlocked"/>
<spring:message var="msg_admin_common_dash" code="admin.common.dash"/>
<spring:message var="msg_admin_common_delete" code="admin.common.delete"/>
<spring:message var="msg_admin_common_restore" code="admin.common.restore"/>
<spring:message var="msg_admin_courses_list_empty" code="admin.courses.list.empty"/>
<c:set var="pageTitle" value="${msg_admin_courses_list_pageTitle}"/>
<c:set var="activeMenu" value="courses"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_courses_list_summary_active}</div>
            <div class="adm-summary-value is-primary">${stats.activePlans}</div>
            <div class="adm-summary-sub">${msg_admin_courses_list_summary_total} ${stats.totalPlans}${msg_admin_common_countSuffix}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_courses_list_summary_deleted}</div>
            <div class="adm-summary-value is-danger">${stats.deletedPlans}</div>
            <div class="adm-summary-sub">${msg_admin_courses_list_summary_today} ${stats.todayPlans}${msg_admin_common_countSuffix}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_courses_list_summary_ai}</div>
            <div class="adm-summary-value is-success">${stats.aiPlans}</div>
            <div class="adm-summary-sub">${msg_admin_courses_list_summary_manual} ${stats.manualPlans}${msg_admin_common_countSuffix}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_courses_list_summary_public}</div>
            <div class="adm-summary-value is-warning">${stats.publicPlans}</div>
            <div class="adm-summary-sub">${msg_admin_courses_list_summary_private} ${stats.privatePlans}${msg_admin_common_countSuffix}</div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/courses" id="searchForm">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label">${msg_admin_courses_list_filter_status}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ?'selected':''}>${msg_admin_common_all}</option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ?'selected':''}>${msg_admin_common_active}</option>
                            <option value="DELETED" ${search.status=='DELETED' ?'selected':''}>${msg_admin_courses_status_deleted}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_courses_list_filter_source}</div>
                        <select class="adm-select" name="planSource">
                            <option value="ALL"    ${search.planSource=='ALL'    ?'selected':''}>${msg_admin_common_all}</option>
                            <option value="MANUAL" ${search.planSource=='MANUAL' ?'selected':''}>${msg_admin_courses_source_manual}</option>
                            <option value="AI"     ${search.planSource=='AI'     ?'selected':''}>${msg_admin_courses_source_ai}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_courses_list_filter_visibility}</div>
                        <select class="adm-select" name="isPublic">
                            <option value="ALL"     ${search.isPublic=='ALL'     ?'selected':''}>${msg_admin_common_all}</option>
                            <option value="PUBLIC"  ${search.isPublic=='PUBLIC'  ?'selected':''}>${msg_admin_courses_visibility_public}</option>
                            <option value="PRIVATE" ${search.isPublic=='PRIVATE' ?'selected':''}>${msg_admin_courses_visibility_private}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_courses_list_filter_sort}</div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt" ${search.sortBy=='createdAt' ?'selected':''}>${msg_admin_courses_list_sort_createdAt}</option>
                            <option value="updatedAt" ${search.sortBy=='updatedAt' ?'selected':''}>${msg_admin_courses_list_sort_updatedAt}</option>
                            <option value="startDate" ${search.sortBy=='startDate' ?'selected':''}>${msg_admin_courses_list_sort_startDate}</option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">${msg_admin_common_search}</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:120px;">
                                <option value="all"         ${search.searchType=='all'         ?'selected':''}>${msg_admin_common_all}</option>
                                <option value="title"       ${search.searchType=='title'       ?'selected':''}>${msg_admin_courses_list_search_title}</option>
                                <option value="destination" ${search.searchType=='destination' ?'selected':''}>${msg_admin_courses_list_search_destination}</option>
                                <option value="nickname"    ${search.searchType=='nickname'    ?'selected':''}>${msg_admin_common_nickname}</option>
                                <option value="userId"      ${search.searchType=='userId'      ?'selected':''}>${msg_admin_common_userId}</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(search.keyword)}"
                                   placeholder="${msg_admin_courses_list_filter_keywordPlaceholder}" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_search}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/courses">${msg_admin_common_reset}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title">${msg_admin_courses_list_title}</div>
                <div class="adm-muted-note">${msg_admin_courses_list_total} ${total}${msg_admin_common_countSuffix}</div>
            </div>
            <%-- 일괄 처리 버튼 --%>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" style="font-size:12px;color:#94a3b8;"></span>
                <button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;"
                        onclick="bulkAction('delete')">${msg_admin_courses_list_action_bulkDelete}</button>
                <button class="adm-btn adm-btn-ghost" style="color:#34d399;border-color:#34d399;"
                        onclick="bulkAction('restore')">${msg_admin_courses_list_action_bulkRestore}</button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:60px;">ID</th>
                    <th>${msg_admin_courses_list_table_author}</th>
                    <th>${msg_admin_courses_list_table_title}</th>
                    <th>${msg_admin_courses_list_table_destination}</th>
                    <th style="width:145px;">${msg_admin_courses_list_table_period}</th>
                    <th style="width:50px;">${msg_admin_courses_list_table_spots}</th>
                    <th style="width:60px;">${msg_admin_courses_list_table_source}</th>
                    <th style="width:60px;">${msg_admin_courses_list_table_visibility}</th>
                    <th style="width:70px;">${msg_admin_common_accountStatus}</th>
                    <th style="width:130px;">${msg_admin_courses_list_table_createdAt}</th>
                    <th style="width:120px;">${msg_admin_common_action}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="p">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${p.planId}"></td>
                        <td style="color:#64748b;font-size:12px;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">#${p.planId}</a>
                        </td>

                        <%-- 작성자 --%>
                        <td>
                            <button type="button"
                                    class="adm-inline-link js-open-member-context"
                                    data-user-idx="${p.userIdx}"
                                    style="font-weight:600;font-size:13px;color:#7dd3fc;">${p.nickname}</button>
                            <div>
                                <button type="button"
                                        class="adm-inline-link js-open-member-context"
                                        data-user-idx="${p.userIdx}"
                                        style="font-size:11px;color:#64748b;">${p.userId}</button>
                            </div>
                            <c:if test="${p.accountStatus == 'BLOCKED'}">
                                <span class="adm-inline-danger">${msg_admin_courses_list_accountBlocked}</span>
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
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">
                            <c:choose>
                                <c:when test="${not empty p.destination}">${p.destination}</c:when>
                                <c:otherwise><span style="color:#475569;">${msg_admin_common_dash}</span></c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 일정 --%>
                        <td style="font-size:11px;color:#94a3b8;white-space:nowrap;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">
                            <c:choose>
                                <c:when test="${not empty p.startDate}">
                                    <fmt:formatDate value="${p.startDate}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${p.endDate}" pattern="MM.dd"/>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">${msg_admin_common_dash}</span></c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 스팟 수 --%>
                        <td style="text-align:center;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">
                            <c:choose>
                                <c:when test="${p.spotCount > 0}">
                                    <span style="color:#7dd3fc;font-weight:600;">${p.spotCount}</span>
                                </c:when>
                                <c:otherwise><span style="color:#475569;">0</span></c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 유형 --%>
                        <td style="font-size:12px;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">
                            <c:choose>
                                <c:when test="${p.planSource == 'AI'}">
                                    <span style="color:#a78bfa;font-weight:600;">${msg_admin_courses_source_ai}</span>
                                </c:when>
                                <c:when test="${p.planSource == 'MANUAL'}">
                                    <span style="color:#94a3b8;">${msg_admin_courses_source_manual}</span>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">${p.planSource}</span></c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 공개 --%>
                        <td style="font-size:12px;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">
                            <c:choose>
                                <c:when test="${p.isPublic == 1}">
                                    <span style="color:#34d399;">${msg_admin_courses_visibility_public}</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#64748b;">${msg_admin_courses_visibility_private}</span>
                                </c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 상태 --%>
                        <td>
                            <c:choose>
                                <c:when test="${p.isDeleted == 0}">
                                    <a href="${pageContext.request.contextPath}/admin/courses/${p.planId}"
                                       class="adm-cell-link adm-cell-link--inline status-badge ACTIVE">${msg_admin_common_active}</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/courses/${p.planId}"
                                       class="adm-cell-link adm-cell-link--inline status-badge DELETED">${msg_admin_courses_status_deleted}</a>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 등록일 --%>
                        <td style="font-size:11px;color:#64748b;white-space:nowrap;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/courses/${p.planId}">
                                <fmt:formatDate value="${p.createdAtDate}" pattern="yyyy.MM.dd HH:mm"/>
                            </a>
                        </td>

                        <%-- 액션 --%>
                        <td>
                            <div class="adm-row-actions is-single">
                                <c:choose>
                                    <c:when test="${p.isDeleted == 0}">
                                        <button class="adm-row-btn danger"
                                                type="button"
                                                data-id="${p.planId}"
                                                onclick="actionPlan(this.getAttribute('data-id'), 'delete')">${msg_admin_common_delete}</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="adm-row-btn success"
                                                type="button"
                                                data-id="${p.planId}"
                                                onclick="actionPlan(this.getAttribute('data-id'), 'restore')">${msg_admin_common_restore}</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="12" style="text-align:center;padding:40px;color:#475569;">${msg_admin_courses_list_empty}</td></tr>
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
    bulkSelected: '${msg_admin_courses_list_js_bulkSelected_js}',
    actionDelete: '${msg_admin_common_delete_js}',
    actionRestore: '${msg_admin_common_restore_js}',
    confirmSingle: '${msg_admin_courses_list_js_confirmSingle_js}',
    confirmBulk: '${msg_admin_courses_list_js_confirmBulk_js}',
    noSelection: '${msg_admin_courses_list_js_noSelection_js}',
    error: '${msg_admin_common_processError_js}'
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
