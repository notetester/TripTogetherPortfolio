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
<spring:message var="msg_admin_common_prev" code="admin.common.prev"/>
<spring:message var="msg_admin_common_next" code="admin.common.next"/>
<spring:message var="msg_admin_common_pageSize_20" code="admin.common.pageSize" arguments="20"/>
<spring:message var="msg_admin_common_pageSize_50" code="admin.common.pageSize" arguments="50"/>
<spring:message var="msg_admin_common_pageSize_100" code="admin.common.pageSize" arguments="100"/>
<spring:message var="msg_admin_courses_totalCountDisplay" code="admin.common.totalCountFormat" arguments="${total}"/>
<spring:message var="msg_admin_courses_currentCountDisplay" code="admin.common.currentCountFormat" arguments="${fn:length(list)}"/>
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

<div class="adm-content adm-courses-page">

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
    <div class="adm-card adm-courses-filter-card">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/courses" id="searchForm">
                <input type="hidden" name="size" value="${search.size}"/>
                <div class="adm-filter-bar adm-courses-filterbar">
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
                    <div class="adm-courses-search-field">
                        <div class="adm-filter-label">${msg_admin_common_search}</div>
                        <div class="adm-courses-search-row">
                            <select class="adm-select adm-courses-search-type" name="searchType">
                                <option value="all"         ${search.searchType=='all'         ?'selected':''}>${msg_admin_common_all}</option>
                                <option value="title"       ${search.searchType=='title'       ?'selected':''}>${msg_admin_courses_list_search_title}</option>
                                <option value="destination" ${search.searchType=='destination' ?'selected':''}>${msg_admin_courses_list_search_destination}</option>
                                <option value="nickname"    ${search.searchType=='nickname'    ?'selected':''}>${msg_admin_common_nickname}</option>
                                <option value="userId"      ${search.searchType=='userId'      ?'selected':''}>${msg_admin_common_userId}</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(search.keyword)}"
                                   placeholder="${msg_admin_courses_list_filter_keywordPlaceholder}">
                        </div>
                    </div>
                    <div class="adm-courses-filter-actions">
                        <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_search}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/courses">${msg_admin_common_reset}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card adm-courses-list-card">
        <div class="adm-card-head adm-courses-list-head">
            <div class="adm-card-title">
                ${msg_admin_courses_list_title}
                <span class="adm-section-total-inline">${msg_admin_courses_totalCountDisplay}</span>
            </div>
            <div class="adm-courses-list-controls">
                <select class="adm-select adm-courses-size-select" onchange="goCoursePageSize(this.value)">
                    <option value="20" ${search.size == 20 ? 'selected' : ''}>${msg_admin_common_pageSize_20}</option>
                    <option value="50" ${search.size == 50 ? 'selected' : ''}>${msg_admin_common_pageSize_50}</option>
                    <option value="100" ${search.size == 100 ? 'selected' : ''}>${msg_admin_common_pageSize_100}</option>
                </select>
                <%-- 일괄 처리 버튼 --%>
                <div id="bulkBar" class="adm-courses-bulk-bar" hidden>
                    <span id="bulkCount" class="adm-courses-bulk-count"></span>
                    <button class="adm-btn adm-btn-ghost adm-courses-danger-btn"
                            onclick="bulkAction('delete')">${msg_admin_courses_list_action_bulkDelete}</button>
                    <button class="adm-btn adm-btn-ghost adm-courses-success-btn"
                            onclick="bulkAction('restore')">${msg_admin_courses_list_action_bulkRestore}</button>
                </div>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table adm-courses-table" data-admin-list-ignore="true">
                <colgroup>
                    <col class="adm-courses-col-check">
                    <col class="adm-courses-col-id">
                    <col class="adm-courses-col-author">
                    <col>
                    <col class="adm-courses-col-destination">
                    <col class="adm-courses-col-period">
                    <col class="adm-courses-col-spots">
                    <col class="adm-courses-col-source">
                    <col class="adm-courses-col-visibility">
                    <col class="adm-courses-col-status">
                    <col class="adm-courses-col-date">
                    <col class="adm-courses-col-action">
                </colgroup>
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkAll"></th>
                    <th onclick="coursesThClick(this)">ID</th>
                    <th onclick="coursesThClick(this)">${msg_admin_courses_list_table_author}</th>
                    <th onclick="coursesThClick(this)">${msg_admin_courses_list_table_title}</th>
                    <th onclick="coursesThClick(this)">${msg_admin_courses_list_table_destination}</th>
                    <th onclick="coursesThClick(this)">${msg_admin_courses_list_table_period}</th>
                    <th onclick="coursesThClick(this)">${msg_admin_courses_list_table_spots}</th>
                    <th onclick="coursesThClick(this)">${msg_admin_courses_list_table_source}</th>
                    <th onclick="coursesThClick(this)">${msg_admin_courses_list_table_visibility}</th>
                    <th onclick="coursesThClick(this)">${msg_admin_common_accountStatus}</th>
                    <th onclick="coursesThClick(this)">${msg_admin_courses_list_table_createdAt}</th>
                    <th onclick="coursesThClick(this)">${msg_admin_common_action}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="p">
                    <c:url var="courseDetailUrl" value="/admin/courses/${p.planId}">
                        <c:param name="source" value="list"/>
                        <c:param name="page" value="${paging.currentPage}"/>
                        <c:param name="size" value="${search.size}"/>
                        <c:param name="status" value="${search.status}"/>
                        <c:param name="planSource" value="${search.planSource}"/>
                        <c:param name="isPublic" value="${search.isPublic}"/>
                        <c:param name="sortBy" value="${search.sortBy}"/>
                        <c:param name="searchType" value="${search.searchType}"/>
                        <c:param name="keyword" value="${search.keyword}"/>
                    </c:url>
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${p.planId}"></td>
                        <td class="adm-courses-id-cell">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${courseDetailUrl}">#${p.planId}</a>
                        </td>

                        <%-- 작성자 --%>
                        <td>
                            <button type="button"
                                    class="adm-inline-link adm-courses-author-name js-open-member-context"
                                    data-user-idx="${p.userIdx}">${p.nickname}</button>
                            <div>
                                <button type="button"
                                        class="adm-inline-link adm-courses-author-id js-open-member-context"
                                        data-user-idx="${p.userIdx}">${p.userId}</button>
                            </div>
                            <c:if test="${p.accountStatus == 'BLOCKED'}">
                                <span class="adm-inline-danger">${msg_admin_courses_list_accountBlocked}</span>
                            </c:if>
                        </td>

                        <%-- 제목 --%>
                        <td>
                            <a href="${courseDetailUrl}"
                               class="adm-link-title" title="${p.title}">
                                <c:choose>
                                    <c:when test="${fn:length(p.title) > 24}">${fn:substring(p.title, 0, 24)}…</c:when>
                                    <c:otherwise>${p.title}</c:otherwise>
                                </c:choose>
                            </a>
                        </td>

                        <%-- 여행지 --%>
                        <td class="adm-courses-destination-cell">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${courseDetailUrl}">
                            <c:choose>
                                <c:when test="${not empty p.destination}">${p.destination}</c:when>
                                <c:otherwise><span class="adm-courses-muted">${msg_admin_common_dash}</span></c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 일정 --%>
                        <td class="adm-courses-period-cell">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${courseDetailUrl}">
                            <c:choose>
                                <c:when test="${not empty p.startDate}">
                                    <fmt:formatDate value="${p.startDate}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${p.endDate}" pattern="MM.dd"/>
                                </c:when>
                                <c:otherwise><span class="adm-courses-muted">${msg_admin_common_dash}</span></c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 스팟 수 --%>
                        <td class="adm-courses-spot-count-cell">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${courseDetailUrl}">
                            <c:choose>
                                <c:when test="${p.spotCount > 0}">
                                    <span class="adm-courses-count-value">${p.spotCount}</span>
                                </c:when>
                                <c:otherwise><span class="adm-courses-muted">0</span></c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 유형 --%>
                        <td class="adm-courses-source-cell">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${courseDetailUrl}">
                            <c:choose>
                                <c:when test="${p.planSource == 'AI'}">
                                    <span class="adm-courses-source-ai">${msg_admin_courses_source_ai}</span>
                                </c:when>
                                <c:when test="${p.planSource == 'MANUAL'}">
                                    <span class="adm-courses-source-manual">${msg_admin_courses_source_manual}</span>
                                </c:when>
                                <c:otherwise><span class="adm-courses-muted">${p.planSource}</span></c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 공개 --%>
                        <td class="adm-courses-visibility-cell">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${courseDetailUrl}">
                            <c:choose>
                                <c:when test="${p.isPublic == 1}">
                                    <span class="adm-courses-public">${msg_admin_courses_visibility_public}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="adm-courses-muted">${msg_admin_courses_visibility_private}</span>
                                </c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 상태 --%>
                        <td>
                            <c:choose>
                                <c:when test="${p.isDeleted == 0}">
                                    <a href="${courseDetailUrl}"
                                       class="adm-cell-link adm-cell-link--inline status-badge ACTIVE">${msg_admin_common_active}</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${courseDetailUrl}"
                                       class="adm-cell-link adm-cell-link--inline status-badge DELETED">${msg_admin_courses_status_deleted}</a>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <%-- 등록일 --%>
                        <td class="adm-courses-date-cell">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${courseDetailUrl}">
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
                    <tr class="adm-local-empty"><td colspan="12" class="adm-local-empty-cell">${msg_admin_courses_list_empty}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <%-- 페이지네이션 --%>
        <c:set var="courseTotalPage" value="${paging.totalPage < 1 ? 1 : paging.totalPage}"/>
        <div class="adm-local-pagination adm-courses-local-pagination">
            <div class="adm-local-page-info">
                ${msg_admin_courses_totalCountDisplay} / ${msg_admin_courses_currentCountDisplay}
            </div>
            <div class="adm-local-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost" ${paging.currentPage <= 1 ? 'disabled' : ''} onclick="goPage(${paging.currentPage - 1})">${msg_admin_common_prev}</button>
                <span class="adm-local-page-state">${paging.currentPage} / ${courseTotalPage}</span>
                <button type="button" class="adm-btn adm-btn-ghost" ${paging.currentPage >= courseTotalPage ? 'disabled' : ''} onclick="goPage(${paging.currentPage + 1})">${msg_admin_common_next}</button>
            </div>
        </div>
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
        bar.hidden = false;
        document.getElementById('bulkCount').textContent = formatCourseListMessage(COURSE_LIST_MESSAGES.bulkSelected, checked.length);
    } else {
        bar.hidden = true;
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

function goCoursePageSize(size) {
    var params = new URLSearchParams(window.location.search);
    params.set('size', size);
    params.set('page', '1');
    location.href = ctx + '/admin/courses?' + params.toString();
}

/* ── 헤더 클릭: 첫 행의 같은 컬럼 셀 액션을 트리거 (없으면 행 상세) ── */
function coursesThClick(th) {
    var table = th.closest('table');
    var firstRow = table && table.querySelector('tbody tr');
    if (!firstRow) return;
    var cell = firstRow.children[th.cellIndex];
    var target = cell && cell.querySelector('button:not(.row-check), a[href]');
    if (target) { target.click(); return; }
    var anyLink = firstRow.querySelector('a.adm-cell-link, a.adm-link-title');
    if (anyLink) location.href = anyLink.getAttribute('href');
}
</script>

<%@ include file="../layout-close.jsp" %>
