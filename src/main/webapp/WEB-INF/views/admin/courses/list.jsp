<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_41cbdf969d" code="admin.courses.list.summary.active"/>
<spring:message var="autoMsg_43299cea89" code="admin.courses.list.summary.total"/>
<spring:message var="autoMsg_3811a826f4" code="admin.common.countSuffix"/>
<spring:message var="autoMsg_e7de437f25" code="admin.courses.list.summary.deleted"/>
<spring:message var="autoMsg_7fbf3237c5" code="admin.courses.list.summary.today"/>
<spring:message var="autoMsg_149cc9153c" code="admin.courses.list.summary.ai"/>
<spring:message var="autoMsg_3920771c97" code="admin.courses.list.summary.manual"/>
<spring:message var="autoMsg_cfb34cf29c" code="admin.courses.list.summary.public"/>
<spring:message var="autoMsg_6a5c0c4000" code="admin.courses.list.summary.private"/>
<spring:message var="autoMsg_eadaac8bdc" code="admin.courses.list.filter.status"/>
<spring:message var="autoMsg_d1393960da" code="admin.common.all"/>
<spring:message var="autoMsg_676cb6b9fe" code="admin.common.active"/>
<spring:message var="autoMsg_f6843608ba" code="admin.courses.status.deleted"/>
<spring:message var="autoMsg_b6c9cfa08e" code="admin.courses.list.filter.source"/>
<spring:message var="autoMsg_8af5de76a7" code="admin.courses.source.manual"/>
<spring:message var="autoMsg_afd456ee62" code="admin.courses.source.ai"/>
<spring:message var="autoMsg_feea42878a" code="admin.courses.list.filter.visibility"/>
<spring:message var="autoMsg_af5fd89dc0" code="admin.courses.visibility.public"/>
<spring:message var="autoMsg_48044814d3" code="admin.courses.visibility.private"/>
<spring:message var="autoMsg_d5c695af83" code="admin.courses.list.filter.sort"/>
<spring:message var="autoMsg_7aeb823049" code="admin.courses.list.sort.createdAt"/>
<spring:message var="autoMsg_b0e8e233a3" code="admin.courses.list.sort.updatedAt"/>
<spring:message var="autoMsg_9c77e258c4" code="admin.courses.list.sort.startDate"/>
<spring:message var="autoMsg_d39500acc7" code="admin.common.search"/>
<spring:message var="autoMsg_22f69ce207" code="admin.courses.list.search.title"/>
<spring:message var="autoMsg_cc34b0771d" code="admin.courses.list.search.destination"/>
<spring:message var="autoMsg_7261fe6c25" code="admin.common.nickname"/>
<spring:message var="autoMsg_d2cd7977f3" code="admin.common.userId"/>
<spring:message var="autoMsg_9557204383" code="admin.courses.list.filter.keywordPlaceholder"/>
<spring:message var="autoMsg_afa2bd3d03" code="admin.common.reset"/>
<spring:message var="autoMsg_5cf4d5ead2" code="admin.courses.list.title"/>
<spring:message var="autoMsg_0d80b010a3" code="admin.courses.list.total"/>
<spring:message var="autoMsg_9c906d6698" code="admin.courses.list.action.bulkDelete"/>
<spring:message var="autoMsg_49026b0b97" code="admin.courses.list.action.bulkRestore"/>
<spring:message var="autoMsg_a6a37470ee" code="admin.courses.list.table.author"/>
<spring:message var="autoMsg_351ee9df46" code="admin.courses.list.table.title"/>
<spring:message var="autoMsg_fd6be906f8" code="admin.courses.list.table.destination"/>
<spring:message var="autoMsg_c2f34e598f" code="admin.courses.list.table.period"/>
<spring:message var="autoMsg_c067e767fc" code="admin.courses.list.table.spots"/>
<spring:message var="autoMsg_1b74208874" code="admin.courses.list.table.source"/>
<spring:message var="autoMsg_f6d33ce1ae" code="admin.courses.list.table.visibility"/>
<spring:message var="autoMsg_dc19263e5d" code="admin.common.accountStatus"/>
<spring:message var="autoMsg_4d6d1e16e9" code="admin.courses.list.table.createdAt"/>
<spring:message var="autoMsg_947ef2742f" code="admin.common.action"/>
<spring:message var="autoMsg_89f767dd8a" code="admin.courses.list.accountBlocked"/>
<spring:message var="autoMsg_8f7e8ae965" code="admin.common.dash"/>
<spring:message var="autoMsg_8d30ace60e" code="admin.common.delete"/>
<spring:message var="autoMsg_30a7607756" code="admin.common.restore"/>
<spring:message var="autoMsg_5281148fd5" code="admin.courses.list.empty"/>
<spring:message var="autoMsg_17ddc9b2b0" code="admin.courses.list.js.bulkSelected" javaScriptEscape="true"/>
<spring:message var="autoMsg_92d1b49e70" code="admin.common.delete" javaScriptEscape="true"/>
<spring:message var="autoMsg_abdea2a2ea" code="admin.common.restore" javaScriptEscape="true"/>
<spring:message var="autoMsg_e4a6d36d04" code="admin.courses.list.js.confirmSingle" javaScriptEscape="true"/>
<spring:message var="autoMsg_e56cd86f35" code="admin.courses.list.js.confirmBulk" javaScriptEscape="true"/>
<spring:message var="autoMsg_52b15e57ef" code="admin.courses.list.js.noSelection" javaScriptEscape="true"/>
<spring:message var="autoMsg_ec62ffccb4" code="admin.common.processError" javaScriptEscape="true"/>
<c:set var="activeMenu" value="courses"/>
<spring:message code="admin.courses.list.pageTitle" var="pageTitle"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_41cbdf969d}</div>
            <div class="adm-summary-value is-primary">${stats.activePlans}</div>
            <div class="adm-summary-sub">${autoMsg_43299cea89} ${stats.totalPlans}${autoMsg_3811a826f4}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_e7de437f25}</div>
            <div class="adm-summary-value is-danger">${stats.deletedPlans}</div>
            <div class="adm-summary-sub">${autoMsg_7fbf3237c5} ${stats.todayPlans}${autoMsg_3811a826f4}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_149cc9153c}</div>
            <div class="adm-summary-value is-success">${stats.aiPlans}</div>
            <div class="adm-summary-sub">${autoMsg_3920771c97} ${stats.manualPlans}${autoMsg_3811a826f4}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_cfb34cf29c}</div>
            <div class="adm-summary-value is-warning">${stats.publicPlans}</div>
            <div class="adm-summary-sub">${autoMsg_6a5c0c4000} ${stats.privatePlans}${autoMsg_3811a826f4}</div>
        </div>
    </div>

    <%-- ── 필터 바 ── --%>
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/courses" id="searchForm">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label">${autoMsg_eadaac8bdc}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL"     ${search.status=='ALL'     ?'selected':''}>${autoMsg_d1393960da}</option>
                            <option value="ACTIVE"  ${search.status=='ACTIVE'  ?'selected':''}>${autoMsg_676cb6b9fe}</option>
                            <option value="DELETED" ${search.status=='DELETED' ?'selected':''}>${autoMsg_f6843608ba}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_b6c9cfa08e}</div>
                        <select class="adm-select" name="planSource">
                            <option value="ALL"    ${search.planSource=='ALL'    ?'selected':''}>${autoMsg_d1393960da}</option>
                            <option value="MANUAL" ${search.planSource=='MANUAL' ?'selected':''}>${autoMsg_8af5de76a7}</option>
                            <option value="AI"     ${search.planSource=='AI'     ?'selected':''}>${autoMsg_afd456ee62}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_feea42878a}</div>
                        <select class="adm-select" name="isPublic">
                            <option value="ALL"     ${search.isPublic=='ALL'     ?'selected':''}>${autoMsg_d1393960da}</option>
                            <option value="PUBLIC"  ${search.isPublic=='PUBLIC'  ?'selected':''}>${autoMsg_af5fd89dc0}</option>
                            <option value="PRIVATE" ${search.isPublic=='PRIVATE' ?'selected':''}>${autoMsg_48044814d3}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_d5c695af83}</div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt" ${search.sortBy=='createdAt' ?'selected':''}>${autoMsg_7aeb823049}</option>
                            <option value="updatedAt" ${search.sortBy=='updatedAt' ?'selected':''}>${autoMsg_b0e8e233a3}</option>
                            <option value="startDate" ${search.sortBy=='startDate' ?'selected':''}>${autoMsg_9c77e258c4}</option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">${autoMsg_d39500acc7}</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:120px;">
                                <option value="all"         ${search.searchType=='all'         ?'selected':''}>${autoMsg_d1393960da}</option>
                                <option value="title"       ${search.searchType=='title'       ?'selected':''}>${autoMsg_22f69ce207}</option>
                                <option value="destination" ${search.searchType=='destination' ?'selected':''}>${autoMsg_cc34b0771d}</option>
                                <option value="nickname"    ${search.searchType=='nickname'    ?'selected':''}>${autoMsg_7261fe6c25}</option>
                                <option value="userId"      ${search.searchType=='userId'      ?'selected':''}>${autoMsg_d2cd7977f3}</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(search.keyword)}"
                                   placeholder="${autoMsg_9557204383}" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit">${autoMsg_d39500acc7}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/courses">${autoMsg_afa2bd3d03}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- ── 목록 테이블 ── --%>
    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title">${autoMsg_5cf4d5ead2}</div>
                <div class="adm-muted-note">${autoMsg_0d80b010a3} ${total}${autoMsg_3811a826f4}</div>
            </div>
            <%-- 일괄 처리 버튼 --%>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" style="font-size:12px;color:#94a3b8;"></span>
                <button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;"
                        onclick="bulkAction('delete')">${autoMsg_9c906d6698}</button>
                <button class="adm-btn adm-btn-ghost" style="color:#34d399;border-color:#34d399;"
                        onclick="bulkAction('restore')">${autoMsg_49026b0b97}</button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:60px;">ID</th>
                    <th>${autoMsg_a6a37470ee}</th>
                    <th>${autoMsg_351ee9df46}</th>
                    <th>${autoMsg_fd6be906f8}</th>
                    <th style="width:145px;">${autoMsg_c2f34e598f}</th>
                    <th style="width:50px;">${autoMsg_c067e767fc}</th>
                    <th style="width:60px;">${autoMsg_1b74208874}</th>
                    <th style="width:60px;">${autoMsg_f6d33ce1ae}</th>
                    <th style="width:70px;">${autoMsg_dc19263e5d}</th>
                    <th style="width:130px;">${autoMsg_4d6d1e16e9}</th>
                    <th style="width:120px;">${autoMsg_947ef2742f}</th>
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
                                <span class="adm-inline-danger">${autoMsg_89f767dd8a}</span>
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
                                <c:otherwise><span style="color:#475569;">${autoMsg_8f7e8ae965}</span></c:otherwise>
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
                                <c:otherwise><span style="color:#475569;">${autoMsg_8f7e8ae965}</span></c:otherwise>
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
                                    <span style="color:#a78bfa;font-weight:600;">${autoMsg_afd456ee62}</span>
                                </c:when>
                                <c:when test="${p.planSource == 'MANUAL'}">
                                    <span style="color:#94a3b8;">${autoMsg_8af5de76a7}</span>
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
                                    <span style="color:#34d399;">${autoMsg_af5fd89dc0}</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#64748b;">${autoMsg_48044814d3}</span>
                                </c:otherwise>
                            </c:choose>
                            </a>
                        </td>

                        <%-- 상태 --%>
                        <td>
                            <c:choose>
                                <c:when test="${p.isDeleted == 0}">
                                    <a href="${pageContext.request.contextPath}/admin/courses/${p.planId}"
                                       class="adm-cell-link adm-cell-link--inline status-badge ACTIVE">${autoMsg_676cb6b9fe}</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/courses/${p.planId}"
                                       class="adm-cell-link adm-cell-link--inline status-badge DELETED">${autoMsg_f6843608ba}</a>
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
                                                onclick="actionPlan(this.getAttribute('data-id'), 'delete')">${autoMsg_8d30ace60e}</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="adm-row-btn success"
                                                type="button"
                                                data-id="${p.planId}"
                                                onclick="actionPlan(this.getAttribute('data-id'), 'restore')">${autoMsg_30a7607756}</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="12" style="text-align:center;padding:40px;color:#475569;">${autoMsg_5281148fd5}</td></tr>
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
    bulkSelected: '${autoMsg_17ddc9b2b0}',
    actionDelete: '${autoMsg_92d1b49e70}',
    actionRestore: '${autoMsg_abdea2a2ea}',
    confirmSingle: '${autoMsg_e4a6d36d04}',
    confirmBulk: '${autoMsg_e56cd86f35}',
    noSelection: '${autoMsg_52b15e57ef}',
    error: '${autoMsg_ec62ffccb4}'
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
