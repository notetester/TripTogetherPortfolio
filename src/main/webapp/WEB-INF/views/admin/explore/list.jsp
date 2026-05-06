<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_explore_filter_searchPlaceholder" code="admin.explore.filter.searchPlaceholder"/>
<spring:message var="msg_admin_explore_bulk_selected_js" code="admin.explore.bulk.selected" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_confirm_deleteOne_js" code="admin.explore.confirm.deleteOne" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_confirm_deleteBulk_js" code="admin.explore.confirm.deleteBulk" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_error_requestFailed_js" code="admin.explore.error.requestFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_error_noSelection_js" code="admin.explore.error.noSelection" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_list_pageTitle" code="admin.explore.list.pageTitle"/>
<spring:message var="msg_admin_explore_tabs_spots" code="admin.explore.tabs.spots"/>
<spring:message var="msg_admin_explore_tabs_reviews" code="admin.explore.tabs.reviews"/>
<spring:message var="msg_admin_explore_kpi_totalSpots" code="admin.explore.kpi.totalSpots"/>
<spring:message var="msg_admin_explore_kpi_deletedSpots" code="admin.explore.kpi.deletedSpots"/>
<spring:message var="msg_admin_explore_kpi_deletedSpotsSub" code="admin.explore.kpi.deletedSpotsSub"/>
<spring:message var="msg_admin_explore_kpi_totalReviews" code="admin.explore.kpi.totalReviews"/>
<spring:message var="msg_admin_explore_kpi_blockedReviews" code="admin.explore.kpi.blockedReviews"/>
<spring:message var="msg_admin_explore_kpi_blockedReviewsSub" code="admin.explore.kpi.blockedReviewsSub"/>
<spring:message var="msg_admin_explore_filter_status" code="admin.explore.filter.status"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_explore_status_active" code="admin.explore.status.active"/>
<spring:message var="msg_admin_explore_status_deleted" code="admin.explore.status.deleted"/>
<spring:message var="msg_admin_explore_filter_sort" code="admin.explore.filter.sort"/>
<spring:message var="msg_admin_explore_sort_createdAt" code="admin.explore.sort.createdAt"/>
<spring:message var="msg_admin_explore_sort_reviewCount" code="admin.explore.sort.reviewCount"/>
<spring:message var="msg_admin_explore_sort_likeCount" code="admin.explore.sort.likeCount"/>
<spring:message var="msg_admin_explore_sort_ratingAvg" code="admin.explore.sort.ratingAvg"/>
<spring:message var="msg_admin_explore_filter_search" code="admin.explore.filter.search"/>
<spring:message var="msg_admin_explore_searchType_name" code="admin.explore.searchType.name"/>
<spring:message var="msg_admin_explore_searchType_region" code="admin.explore.searchType.region"/>
<spring:message var="msg_admin_explore_searchType_address" code="admin.explore.searchType.address"/>
<spring:message var="msg_admin_explore_searchType_description" code="admin.explore.searchType.description"/>
<spring:message var="msg_admin_explore_searchType_nickname" code="admin.explore.searchType.nickname"/>
<spring:message var="msg_admin_explore_searchType_userId" code="admin.explore.searchType.userId"/>
<spring:message var="msg_admin_common_searchButton" code="admin.common.searchButton"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_explore_list_title" code="admin.explore.list.title"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount"/>
<spring:message var="msg_admin_explore_action_bulkDelete" code="admin.explore.action.bulkDelete"/>
<spring:message var="msg_admin_common_id" code="admin.common.id"/>
<spring:message var="msg_admin_explore_table_image" code="admin.explore.table.image"/>
<spring:message var="msg_admin_explore_table_spot" code="admin.explore.table.spot"/>
<spring:message var="msg_admin_explore_table_author" code="admin.explore.table.author"/>
<spring:message var="msg_admin_explore_table_region" code="admin.explore.table.region"/>
<spring:message var="msg_admin_explore_table_rating" code="admin.explore.table.rating"/>
<spring:message var="msg_admin_explore_table_reviews" code="admin.explore.table.reviews"/>
<spring:message var="msg_admin_explore_table_likes" code="admin.explore.table.likes"/>
<spring:message var="msg_admin_common_status" code="admin.common.status"/>
<spring:message var="msg_admin_common_action" code="admin.common.action"/>
<spring:message var="msg_admin_explore_noImage" code="admin.explore.noImage"/>
<spring:message var="msg_admin_explore_detail_userView" code="admin.explore.detail.userView"/>
<spring:message var="msg_admin_explore_detail_reviewsManageAll" code="admin.explore.detail.reviewsManageAll"/>
<spring:message var="msg_admin_common_edit" code="admin.common.edit"/>
<spring:message var="msg_admin_common_delete" code="admin.common.delete"/>
<spring:message var="msg_admin_explore_list_empty" code="admin.explore.list.empty"/>
<spring:message var="msg_admin_common_previous" code="admin.common.previous"/>
<spring:message var="msg_admin_common_next" code="admin.common.next"/>
<spring:message var="msg_admin_common_pageStatus" code="admin.common.pageStatus"/>
<c:set var="activeMenu" value="explore"/>


<c:set var="pageTitle" value="${msg_admin_explore_list_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-admin-tabs">
        <a class="adm-tab active" href="${pageContext.request.contextPath}/admin/explore">
            ${msg_admin_explore_tabs_spots}
        </a>
        <a class="adm-tab" href="${pageContext.request.contextPath}/admin/explore/reviews">
            ${msg_admin_explore_tabs_reviews}
        </a>
    </div>

    <div class="adm-summary-grid">
        <div class="adm-summary-card">
            <div class="adm-summary-label">${msg_admin_explore_kpi_totalSpots}</div>
            <div class="adm-summary-value">${stats.totalSpots}</div>
            <div class="adm-summary-sub">
                <spring:message var="msg_admin_explore_kpi_activeSpots_args_stats_activeSpots" code="admin.explore.kpi.activeSpots" arguments="${stats.activeSpots}"/>${msg_admin_explore_kpi_activeSpots_args_stats_activeSpots}
            </div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label">${msg_admin_explore_kpi_deletedSpots}</div>
            <div class="adm-summary-value">${stats.deletedSpots}</div>
            <div class="adm-summary-sub">${msg_admin_explore_kpi_deletedSpotsSub}</div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label">${msg_admin_explore_kpi_totalReviews}</div>
            <div class="adm-summary-value">${stats.totalReviews}</div>
            <div class="adm-summary-sub">
                <spring:message var="msg_admin_explore_kpi_activeReviews_args_stats_activeReviews" code="admin.explore.kpi.activeReviews" arguments="${stats.activeReviews}"/>${msg_admin_explore_kpi_activeReviews_args_stats_activeReviews}
            </div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label">${msg_admin_explore_kpi_blockedReviews}</div>
            <div class="adm-summary-value">${stats.blockedReviews}</div>
            <div class="adm-summary-sub">${msg_admin_explore_kpi_blockedReviewsSub}</div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/explore">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label">${msg_admin_explore_filter_status}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="ACTIVE" ${search.status=='ACTIVE'?'selected':''}>${msg_admin_explore_status_active}</option>
                            <option value="DELETED" ${search.status=='DELETED'?'selected':''}>${msg_admin_explore_status_deleted}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${msg_admin_explore_filter_sort}</div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt" ${search.sortBy=='createdAt'?'selected':''}>${msg_admin_explore_sort_createdAt}</option>
                            <option value="reviewCount" ${search.sortBy=='reviewCount'?'selected':''}>${msg_admin_explore_sort_reviewCount}</option>
                            <option value="likeCount" ${search.sortBy=='likeCount'?'selected':''}>${msg_admin_explore_sort_likeCount}</option>
                            <option value="ratingAvg" ${search.sortBy=='ratingAvg'?'selected':''}>${msg_admin_explore_sort_ratingAvg}</option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">${msg_admin_explore_filter_search}</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:120px;">
                                <option value="all" ${search.searchType=='all'?'selected':''}>${msg_admin_common_all}</option>
                                <option value="name" ${search.searchType=='name'?'selected':''}>${msg_admin_explore_searchType_name}</option>
                                <option value="region" ${search.searchType=='region'?'selected':''}>${msg_admin_explore_searchType_region}</option>
                                <option value="address" ${search.searchType=='address'?'selected':''}>${msg_admin_explore_searchType_address}</option>
                                <option value="description" ${search.searchType=='description'?'selected':''}>${msg_admin_explore_searchType_description}</option>
                                <option value="nickname" ${search.searchType=='nickname'?'selected':''}>${msg_admin_explore_searchType_nickname}</option>
                                <option value="userId" ${search.searchType=='userId'?'selected':''}>${msg_admin_explore_searchType_userId}</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="${msg_admin_explore_filter_searchPlaceholder}" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_searchButton}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore">${msg_admin_common_reset}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title">${msg_admin_explore_list_title}</div>
                <div class="adm-muted-inline">${msg_admin_common_totalCount}</div>
            </div>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" class="adm-muted-inline"></span>
                <button class="adm-btn adm-btn-ghost" type="button" onclick="bulkAction('delete')">${msg_admin_explore_action_bulkDelete}</button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:70px;">${msg_admin_common_id}</th>
                    <th style="width:84px;">${msg_admin_explore_table_image}</th>
                    <th>${msg_admin_explore_table_spot}</th>
                    <th style="width:120px;">${msg_admin_explore_table_author}</th>
                    <th style="width:130px;">${msg_admin_explore_table_region}</th>
                    <th style="width:80px;">${msg_admin_explore_table_rating}</th>
                    <th style="width:70px;">${msg_admin_explore_table_reviews}</th>
                    <th style="width:70px;">${msg_admin_explore_table_likes}</th>
                    <th style="width:80px;">${msg_admin_common_status}</th>
                    <th style="width:140px;">${msg_admin_common_action}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="spot">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${spot.spotIdx}"></td>
                        <td class="adm-muted-inline">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}">#${spot.spotIdx}</a>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty spot.thumbUrl}">
                                    <img src="${spot.thumbUrl}" alt="${fn:escapeXml(spot.name)}" style="width:56px;height:56px;object-fit:cover;border-radius:8px;border:1px solid #cbd5e1;">
                                </c:when>
                                <c:otherwise>
                                    <div class="adm-image-placeholder" style="width:56px;height:56px;border-radius:8px;display:flex;align-items:center;justify-content:center;">
                                        ${msg_admin_explore_noImage}
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
                            <a class="adm-cell-link adm-cell-link--inline adm-cell-ellipsis"
                               href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}"
                               style="font-size:11px;color:#64748b;margin-top:4px;max-width:260px;">${fn:escapeXml(spot.address)}</a>
                            <div class="adm-inline-actions">
                                <a href="${pageContext.request.contextPath}/detail/${spot.spotIdx}" target="_blank" class="adm-inline-chip">${msg_admin_explore_detail_userView}</a>
                                <a href="${pageContext.request.contextPath}${spotReviewsManageUrl}" class="adm-inline-chip">${msg_admin_explore_detail_reviewsManageAll}</a>
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
                        <td class="adm-muted-inline">
                            <c:url var="spotRegionSearchUrl" value="/admin/explore">
                                <c:param name="searchType" value="region"/>
                                <c:param name="keyword" value="${spot.region}"/>
                            </c:url>
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}${spotRegionSearchUrl}">${fn:escapeXml(spot.region)}</a>
                        </td>
                        <td style="font-size:12px;color:#d97706;font-weight:700;">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}${spotReviewsManageUrl}"><fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/></a>
                        </td>
                        <td class="adm-muted-inline">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}${spotReviewsManageUrl}">${spot.reviewCount}</a>
                        </td>
                        <td class="adm-muted-inline">
                            <a class="adm-cell-link adm-cell-link--inline"
                               href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}">${spot.likeCount}</a>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}?edit=true"
                               class="adm-cell-link adm-cell-link--inline status-badge ${spot.displayStatus}">
                                <c:choose>
                                    <c:when test="${spot.displayStatus == 'ACTIVE'}">${msg_admin_explore_status_active}</c:when>
                                    <c:otherwise>${msg_admin_explore_status_deleted}</c:otherwise>
                                </c:choose>
                            </a>
                        </td>
                        <td>
                            <div class="adm-row-actions">
                                <a class="adm-row-btn detail" href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}?edit=true">${msg_admin_common_edit}</a>
                                <c:if test="${spot.displayStatus != 'DELETED'}">
                                    <div class="action-menu-wrap">
                                        <button class="adm-row-btn detail adm-row-btn-more"
                                                type="button"
                                                onclick="admToggleActionMenu(this)">⋯</button>
                                        <div class="action-menu">
                                            <button class="action-menu-item danger"
                                                    type="button"
                                                    data-id="${spot.spotIdx}"
                                                    onclick="actionSpot(this, 'delete')">${msg_admin_common_delete}</button>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="11" style="text-align:center;padding:40px;color:#475569;">${msg_admin_explore_list_empty}</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}">
                    <button class="adm-page-btn" type="button" onclick="goPage(${paging.startPage - 1})">${msg_admin_common_previous}</button>
                </c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pg">
                    <button class="adm-page-btn ${pg == paging.currentPage ? 'active' : ''}" type="button" onclick="goPage(${pg})">${pg}</button>
                </c:forEach>
                <c:if test="${paging.next}">
                    <button class="adm-page-btn" type="button" onclick="goPage(${paging.endPage + 1})">${msg_admin_common_next}</button>
                </c:if>
                <span class="adm-page-info">${msg_admin_common_pageStatus}</span>
            </div>
        </c:if>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var EXPLORE_LIST_MSG = {
    bulkSelectedTemplate: '${msg_admin_explore_bulk_selected_js}',
    confirmDeleteOne: '${msg_admin_explore_confirm_deleteOne_js}',
    confirmDeleteBulk: '${msg_admin_explore_confirm_deleteBulk_js}',
    requestFailed: '${msg_admin_explore_error_requestFailed_js}',
    noSelection: '${msg_admin_explore_error_noSelection_js}'
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
