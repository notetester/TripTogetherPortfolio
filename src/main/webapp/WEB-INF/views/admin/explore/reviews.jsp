<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="explore"/>
<spring:message code="admin.explore.reviews.pageTitle" var="adminExploreReviewsPageTitle"/>
<c:set var="pageTitle" value="${adminExploreReviewsPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-admin-tabs">
        <a class="adm-tab" href="${pageContext.request.contextPath}/admin/explore">
            <spring:message code="admin.explore.tabs.spots"/>
        </a>
        <a class="adm-tab active" href="${pageContext.request.contextPath}/admin/explore/reviews">
            <spring:message code="admin.explore.tabs.reviews"/>
        </a>
    </div>

    <div class="adm-summary-grid" style="grid-template-columns:repeat(2, minmax(0, 1fr));">
        <div class="adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.explore.reviews.kpi.total"/></div>
            <div class="adm-summary-value">${stats.totalReviews}</div>
            <div class="adm-summary-sub"><spring:message code="admin.explore.reviews.kpi.activeCount" arguments="${stats.activeReviews}"/></div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.explore.reviews.kpi.blocked"/></div>
            <div class="adm-summary-value">${stats.blockedReviews}</div>
            <div class="adm-summary-sub"><spring:message code="admin.explore.reviews.kpi.blockedSub"/></div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/explore/reviews">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.explore.filter.status"/></div>
                        <select class="adm-select" name="reviewStatus">
                            <option value="ALL" ${search.reviewStatus=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="ACTIVE" ${search.reviewStatus=='ACTIVE'?'selected':''}><spring:message code="admin.explore.reviewStatus.active"/></option>
                            <option value="BLOCKED" ${search.reviewStatus=='BLOCKED'?'selected':''}><spring:message code="admin.explore.reviewStatus.blocked"/></option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label"><spring:message code="admin.explore.filter.search"/></div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:120px;">
                                <option value="all" ${search.searchType=='all'?'selected':''}><spring:message code="admin.common.all"/></option>
                                <option value="name" ${search.searchType=='name'?'selected':''}><spring:message code="admin.explore.searchType.name"/></option>
                                <option value="nickname" ${search.searchType=='nickname'?'selected':''}><spring:message code="admin.explore.searchType.nickname"/></option>
                                <option value="content" ${search.searchType=='content'?'selected':''}><spring:message code="admin.explore.searchType.content"/></option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="<spring:message code='admin.explore.filter.searchPlaceholder'/>" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore/reviews"><spring:message code="admin.common.reset"/></a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title"><spring:message code="admin.explore.reviews.listTitle"/></div>
                <div class="adm-muted-inline"><spring:message code="admin.common.totalCount" arguments="${total}"/></div>
            </div>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" class="adm-muted-inline"></span>
                <button class="adm-btn adm-btn-ghost" type="button" onclick="bulkAction('block')"><spring:message code="admin.explore.reviews.action.bulkBlock"/></button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:70px;"><spring:message code="admin.explore.detail.reviewId"/></th>
                    <th style="width:180px;"><spring:message code="admin.explore.reviews.table.spot"/></th>
                    <th style="width:120px;"><spring:message code="admin.explore.reviews.table.author"/></th>
                    <th style="width:70px;"><spring:message code="admin.explore.reviews.table.rating"/></th>
                    <th><spring:message code="admin.explore.reviews.table.content"/></th>
                    <th style="width:80px;"><spring:message code="admin.common.status"/></th>
                    <th style="width:90px;"><spring:message code="admin.explore.reviews.table.createdAt"/></th>
                    <th style="width:90px;"><spring:message code="admin.common.action"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="review">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${review.reviewIdx}"></td>
                        <td class="adm-muted-inline">#${review.reviewIdx}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/explore/spots/${review.spotIdx}" class="adm-link-title" style="font-weight:600;">${fn:escapeXml(review.spotName)}</a>
                            <div class="adm-inline-actions">
                                <a href="${pageContext.request.contextPath}/detail/${review.spotIdx}" target="_blank" class="adm-inline-chip"><spring:message code="admin.explore.detail.userView"/></a>
                            </div>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-inline-link js-open-member-context"
                                    data-user-idx="${review.userIdx}"
                                    style="font-size:13px;font-weight:700;color:#93c5fd;">
                                ${fn:escapeXml(review.nickname)}
                            </button>
                            <div class="adm-muted-inline">
                                <button type="button"
                                        class="adm-inline-link js-open-member-context"
                                        data-user-idx="${review.userIdx}"
                                        style="font-size:12px;color:#94a3b8;">
                                    ${fn:escapeXml(review.userId)}
                                </button>
                            </div>
                        </td>
                        <td style="font-size:12px;color:#d97706;">${review.rating}/5</td>
                        <td class="adm-review-content">
                            <c:choose>
                                <c:when test="${fn:length(review.content) > 60}">${fn:escapeXml(fn:substring(review.content, 0, 60))}…</c:when>
                                <c:otherwise>${fn:escapeXml(review.content)}</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="status-badge ${review.displayStatus}">
                                <c:choose>
                                    <c:when test="${review.displayStatus == 'ACTIVE'}"><spring:message code="admin.explore.reviewStatus.active"/></c:when>
                                    <c:otherwise><spring:message code="admin.explore.reviewStatus.blocked"/></c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td class="adm-muted-inline"><fmt:formatDate value="${review.createdAt}" type="date" dateStyle="short"/></td>
                        <td>
                            <c:if test="${review.displayStatus != 'BLOCKED'}">
                                <button class="adm-btn adm-btn-ghost" type="button" style="font-size:11px;padding:3px 8px;" data-id="${review.reviewIdx}" onclick="actionReview(this, 'block')"><spring:message code="admin.explore.reviews.action.block"/></button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="9" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.explore.reviews.empty"/></td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}"><button class="adm-page-btn" type="button" onclick="goPage(${paging.startPage - 1})"><spring:message code="admin.common.previous"/></button></c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pg"><button class="adm-page-btn ${pg == paging.currentPage ? 'active' : ''}" type="button" onclick="goPage(${pg})">${pg}</button></c:forEach>
                <c:if test="${paging.next}"><button class="adm-page-btn" type="button" onclick="goPage(${paging.endPage + 1})"><spring:message code="admin.common.next"/></button></c:if>
                <span class="adm-page-info"><spring:message code="admin.common.pageStatus" arguments="${paging.currentPage},${paging.totalPage}"/></span>
            </div>
        </c:if>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var EXPLORE_REVIEW_MSG = {
    bulkSelectedTemplate: '<spring:message code="admin.explore.reviews.bulk.selected" arguments="__COUNT__" javaScriptEscape="true"/>',
    confirmBlockOne: '<spring:message code="admin.explore.reviews.confirm.blockOne" arguments="__ID__" javaScriptEscape="true"/>',
    confirmBlockBulk: '<spring:message code="admin.explore.reviews.confirm.blockBulk" arguments="__COUNT__" javaScriptEscape="true"/>',
    requestFailed: '<spring:message code="admin.explore.reviews.error.requestFailed" javaScriptEscape="true"/>',
    noSelection: '<spring:message code="admin.explore.reviews.error.noSelection" javaScriptEscape="true"/>'
};

document.getElementById('checkAll').addEventListener('change', function() {
    document.querySelectorAll('.row-check').forEach(function(cb) {
        cb.checked = document.getElementById('checkAll').checked;
    });
    updateBulkBar();
});

document.querySelectorAll('.row-check').forEach(function(cb) {
    cb.addEventListener('change', updateBulkBar);
});

function updateBulkBar() {
    var checked = document.querySelectorAll('.row-check:checked');
    var bar = document.getElementById('bulkBar');
    if (checked.length > 0) {
        bar.style.display = 'flex';
        document.getElementById('bulkCount').textContent = EXPLORE_REVIEW_MSG.bulkSelectedTemplate.replace('__COUNT__', checked.length);
    } else {
        bar.style.display = 'none';
    }
}

function actionReview(button, action) {
    var reviewIdx = button.getAttribute('data-id');
    if (!confirm(EXPLORE_REVIEW_MSG.confirmBlockOne.replace('__ID__', reviewIdx))) return;
    fetch(ctx + '/admin/explore/reviews/' + reviewIdx + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function(r) {
        return r.json();
    }).then(function(d) {
        if (d.success) {
            location.reload();
        } else {
            alert(d.message || EXPLORE_REVIEW_MSG.requestFailed);
        }
    });
}

function bulkAction(action) {
    var ids = Array.from(document.querySelectorAll('.row-check:checked')).map(function(cb) {
        return cb.getAttribute('data-id');
    });
    if (ids.length === 0) {
        alert(EXPLORE_REVIEW_MSG.noSelection);
        return;
    }
    if (!confirm(EXPLORE_REVIEW_MSG.confirmBlockBulk.replace('__COUNT__', ids.length))) return;
    var body = 'action=' + action + '&' + ids.map(function(id) { return 'ids=' + id; }).join('&');
    fetch(ctx + '/admin/explore/reviews/bulk-action', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: body
    }).then(function(r) {
        return r.json();
    }).then(function(d) {
        if (d.success) {
            location.reload();
        } else {
            alert(d.message || EXPLORE_REVIEW_MSG.requestFailed);
        }
    });
}

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = ctx + '/admin/explore/reviews?' + params.toString();
}
</script>

<%@ include file="../layout-close.jsp" %>
