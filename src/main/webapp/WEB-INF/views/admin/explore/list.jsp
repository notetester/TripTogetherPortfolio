<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="explore"/>
<spring:message code="admin.explore.list.pageTitle" var="adminExploreListPageTitle"/>
<c:set var="pageTitle" value="${adminExploreListPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-admin-tabs">
        <a class="adm-tab active" href="${pageContext.request.contextPath}/admin/explore">
            <spring:message code="admin.explore.tabs.spots"/>
        </a>
        <a class="adm-tab" href="${pageContext.request.contextPath}/admin/explore/reviews">
            <spring:message code="admin.explore.tabs.reviews"/>
        </a>
    </div>

    <div class="adm-summary-grid">
        <div class="adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.explore.kpi.totalSpots"/></div>
            <div class="adm-summary-value">${stats.totalSpots}</div>
            <div class="adm-summary-sub">
                <spring:message code="admin.explore.kpi.activeSpots" arguments="${stats.activeSpots}"/>
            </div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.explore.kpi.deletedSpots"/></div>
            <div class="adm-summary-value">${stats.deletedSpots}</div>
            <div class="adm-summary-sub"><spring:message code="admin.explore.kpi.deletedSpotsSub"/></div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.explore.kpi.totalReviews"/></div>
            <div class="adm-summary-value">${stats.totalReviews}</div>
            <div class="adm-summary-sub">
                <spring:message code="admin.explore.kpi.activeReviews" arguments="${stats.activeReviews}"/>
            </div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label"><spring:message code="admin.explore.kpi.blockedReviews"/></div>
            <div class="adm-summary-value">${stats.blockedReviews}</div>
            <div class="adm-summary-sub"><spring:message code="admin.explore.kpi.blockedReviewsSub"/></div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/explore">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.explore.filter.status"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="ACTIVE" ${search.status=='ACTIVE'?'selected':''}><spring:message code="admin.explore.status.active"/></option>
                            <option value="DELETED" ${search.status=='DELETED'?'selected':''}><spring:message code="admin.explore.status.deleted"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.explore.filter.sort"/></div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt" ${search.sortBy=='createdAt'?'selected':''}><spring:message code="admin.explore.sort.createdAt"/></option>
                            <option value="reviewCount" ${search.sortBy=='reviewCount'?'selected':''}><spring:message code="admin.explore.sort.reviewCount"/></option>
                            <option value="likeCount" ${search.sortBy=='likeCount'?'selected':''}><spring:message code="admin.explore.sort.likeCount"/></option>
                            <option value="ratingAvg" ${search.sortBy=='ratingAvg'?'selected':''}><spring:message code="admin.explore.sort.ratingAvg"/></option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label"><spring:message code="admin.explore.filter.search"/></div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:120px;">
                                <option value="all" ${search.searchType=='all'?'selected':''}><spring:message code="admin.common.all"/></option>
                                <option value="name" ${search.searchType=='name'?'selected':''}><spring:message code="admin.explore.searchType.name"/></option>
                                <option value="region" ${search.searchType=='region'?'selected':''}><spring:message code="admin.explore.searchType.region"/></option>
                                <option value="address" ${search.searchType=='address'?'selected':''}><spring:message code="admin.explore.searchType.address"/></option>
                                <option value="description" ${search.searchType=='description'?'selected':''}><spring:message code="admin.explore.searchType.description"/></option>
                                <option value="nickname" ${search.searchType=='nickname'?'selected':''}><spring:message code="admin.explore.searchType.nickname"/></option>
                                <option value="userId" ${search.searchType=='userId'?'selected':''}><spring:message code="admin.explore.searchType.userId"/></option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="<spring:message code='admin.explore.filter.searchPlaceholder'/>" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore"><spring:message code="admin.common.reset"/></a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title"><spring:message code="admin.explore.list.title"/></div>
                <div class="adm-muted-inline"><spring:message code="admin.common.totalCount" arguments="${total}"/></div>
            </div>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" class="adm-muted-inline"></span>
                <button class="adm-btn adm-btn-ghost" type="button" onclick="bulkAction('delete')"><spring:message code="admin.explore.action.bulkDelete"/></button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:70px;"><spring:message code="admin.common.id"/></th>
                    <th style="width:84px;"><spring:message code="admin.explore.table.image"/></th>
                    <th><spring:message code="admin.explore.table.spot"/></th>
                    <th style="width:120px;"><spring:message code="admin.explore.table.author"/></th>
                    <th style="width:130px;"><spring:message code="admin.explore.table.region"/></th>
                    <th style="width:80px;"><spring:message code="admin.explore.table.rating"/></th>
                    <th style="width:70px;"><spring:message code="admin.explore.table.reviews"/></th>
                    <th style="width:70px;"><spring:message code="admin.explore.table.likes"/></th>
                    <th style="width:80px;"><spring:message code="admin.common.status"/></th>
                    <th style="width:140px;"><spring:message code="admin.common.action"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="spot">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${spot.spotIdx}"></td>
                        <td class="adm-muted-inline">#${spot.spotIdx}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty spot.thumbUrl}">
                                    <img src="${spot.thumbUrl}" alt="${fn:escapeXml(spot.name)}" style="width:56px;height:56px;object-fit:cover;border-radius:8px;border:1px solid #cbd5e1;">
                                </c:when>
                                <c:otherwise>
                                    <div class="adm-image-placeholder" style="width:56px;height:56px;border-radius:8px;display:flex;align-items:center;justify-content:center;">
                                        <spring:message code="admin.explore.noImage"/>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:url var="spotReviewsManageUrl" value="/admin/explore/reviews">
                                <c:param name="searchType" value="name"/>
                                <c:param name="keyword" value="${spot.name}"/>
                            </c:url>
                            <a href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}" class="adm-link-title" style="font-weight:600;">${fn:escapeXml(spot.name)}</a>
                            <div class="adm-cell-ellipsis" style="font-size:11px;color:#64748b;margin-top:4px;max-width:260px;">${fn:escapeXml(spot.address)}</div>
                            <div class="adm-inline-actions">
                                <a href="${pageContext.request.contextPath}/detail/${spot.spotIdx}" target="_blank" class="adm-inline-chip"><spring:message code="admin.explore.detail.userView"/></a>
                                <a href="${pageContext.request.contextPath}${spotReviewsManageUrl}" class="adm-inline-chip"><spring:message code="admin.explore.detail.reviewsManageAll"/></a>
                            </div>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-inline-link js-open-member-context"
                                    data-user-idx="${spot.userIdx}"
                                    style="font-size:13px;font-weight:700;color:#93c5fd;">
                                ${fn:escapeXml(spot.nickname)}
                            </button>
                            <div class="adm-muted-inline">
                                <button type="button"
                                        class="adm-inline-link js-open-member-context"
                                        data-user-idx="${spot.userIdx}"
                                        style="font-size:12px;color:#94a3b8;">
                                    ${fn:escapeXml(spot.userId)}
                                </button>
                            </div>
                        </td>
                        <td class="adm-muted-inline">${fn:escapeXml(spot.region)}</td>
                        <td style="font-size:12px;color:#d97706;font-weight:700;"><fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/></td>
                        <td class="adm-muted-inline">${spot.reviewCount}</td>
                        <td class="adm-muted-inline">${spot.likeCount}</td>
                        <td>
                            <span class="status-badge ${spot.displayStatus}">
                                <c:choose>
                                    <c:when test="${spot.displayStatus == 'ACTIVE'}"><spring:message code="admin.explore.status.active"/></c:when>
                                    <c:otherwise><spring:message code="admin.explore.status.deleted"/></c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <div class="adm-row-actions">
                                <a class="adm-row-btn detail" href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}?edit=true"><spring:message code="admin.common.edit"/></a>
                                <c:if test="${spot.displayStatus != 'DELETED'}">
                                    <div class="action-menu-wrap">
                                        <button class="adm-row-btn detail adm-row-btn-more"
                                                type="button"
                                                onclick="admToggleActionMenu(this)">⋯</button>
                                        <div class="action-menu">
                                            <button class="action-menu-item danger"
                                                    type="button"
                                                    data-id="${spot.spotIdx}"
                                                    onclick="actionSpot(this, 'delete')"><spring:message code="admin.common.delete"/></button>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="11" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.explore.list.empty"/></td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}">
                    <button class="adm-page-btn" type="button" onclick="goPage(${paging.startPage - 1})"><spring:message code="admin.common.previous"/></button>
                </c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pg">
                    <button class="adm-page-btn ${pg == paging.currentPage ? 'active' : ''}" type="button" onclick="goPage(${pg})">${pg}</button>
                </c:forEach>
                <c:if test="${paging.next}">
                    <button class="adm-page-btn" type="button" onclick="goPage(${paging.endPage + 1})"><spring:message code="admin.common.next"/></button>
                </c:if>
                <span class="adm-page-info"><spring:message code="admin.common.pageStatus" arguments="${paging.currentPage},${paging.totalPage}"/></span>
            </div>
        </c:if>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var EXPLORE_LIST_MSG = {
    bulkSelectedTemplate: '<spring:message code="admin.explore.bulk.selected" arguments="__COUNT__" javaScriptEscape="true"/>',
    confirmDeleteOne: '<spring:message code="admin.explore.confirm.deleteOne" arguments="__ID__" javaScriptEscape="true"/>',
    confirmDeleteBulk: '<spring:message code="admin.explore.confirm.deleteBulk" arguments="__COUNT__" javaScriptEscape="true"/>',
    requestFailed: '<spring:message code="admin.explore.error.requestFailed" javaScriptEscape="true"/>',
    noSelection: '<spring:message code="admin.explore.error.noSelection" javaScriptEscape="true"/>'
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
        document.getElementById('bulkCount').textContent = EXPLORE_LIST_MSG.bulkSelectedTemplate.replace('__COUNT__', checked.length);
    } else {
        bar.style.display = 'none';
    }
}

function actionSpot(button, action) {
    var spotIdx = button.getAttribute('data-id');
    if (!confirm(EXPLORE_LIST_MSG.confirmDeleteOne.replace('__ID__', spotIdx))) return;
    fetch(ctx + '/admin/explore/spots/' + spotIdx + '/' + action, {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function(r) {
        return r.json();
    }).then(function(d) {
        if (d.success) {
            location.reload();
        } else {
            alert(d.message || EXPLORE_LIST_MSG.requestFailed);
        }
    });
}

function bulkAction(action) {
    var ids = Array.from(document.querySelectorAll('.row-check:checked')).map(function(cb) {
        return cb.getAttribute('data-id');
    });
    if (ids.length === 0) {
        alert(EXPLORE_LIST_MSG.noSelection);
        return;
    }
    if (!confirm(EXPLORE_LIST_MSG.confirmDeleteBulk.replace('__COUNT__', ids.length))) return;

    var body = 'action=' + action + '&' + ids.map(function(id) {
        return 'ids=' + id;
    }).join('&');

    fetch(ctx + '/admin/explore/spots/bulk-action', {
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
            alert(d.message || EXPLORE_LIST_MSG.requestFailed);
        }
    });
}

function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = ctx + '/admin/explore?' + params.toString();
}
</script>

<%@ include file="../layout-close.jsp" %>
