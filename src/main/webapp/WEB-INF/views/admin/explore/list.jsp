<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_6388cc3f63" code="admin.explore.kpi.totalSpots"/>
<spring:message var="autoMsg_352186d9fb" code="admin.explore.kpi.deletedSpots"/>
<spring:message var="autoMsg_3449746175" code="admin.explore.kpi.deletedSpotsSub"/>
<spring:message var="autoMsg_9e11b546b5" code="admin.explore.kpi.totalReviews"/>
<spring:message var="autoMsg_9d84f52349" code="admin.explore.kpi.blockedReviews"/>
<spring:message var="autoMsg_590cf1e027" code="admin.explore.kpi.blockedReviewsSub"/>
<spring:message var="autoMsg_1df8c7b9fd" code="admin.explore.filter.status"/>
<spring:message var="autoMsg_ea55659189" code="admin.common.all"/>
<spring:message var="autoMsg_00c4efcf34" code="admin.explore.status.active"/>
<spring:message var="autoMsg_e665617fbf" code="admin.explore.status.deleted"/>
<spring:message var="autoMsg_c15fef9ed2" code="admin.explore.filter.sort"/>
<spring:message var="autoMsg_de08eb5217" code="admin.explore.sort.createdAt"/>
<spring:message var="autoMsg_f962a78488" code="admin.explore.sort.reviewCount"/>
<spring:message var="autoMsg_d496607bb0" code="admin.explore.sort.likeCount"/>
<spring:message var="autoMsg_c0c40d10cd" code="admin.explore.sort.ratingAvg"/>
<spring:message var="autoMsg_7f9f992daa" code="admin.explore.filter.search"/>
<spring:message var="autoMsg_7addeb3341" code="admin.explore.searchType.name"/>
<spring:message var="autoMsg_395b543ab1" code="admin.explore.searchType.region"/>
<spring:message var="autoMsg_b745da2b5c" code="admin.explore.searchType.address"/>
<spring:message var="autoMsg_a4ff9647e7" code="admin.explore.searchType.description"/>
<spring:message var="autoMsg_7877c2ac8b" code="admin.explore.searchType.nickname"/>
<spring:message var="autoMsg_fb14a3e5ce" code="admin.explore.searchType.userId"/>
<spring:message var="autoMsg_ccb9f67e95" code="admin.explore.filter.searchPlaceholder"/>
<spring:message var="autoMsg_98a95c450b" code="admin.common.searchButton"/>
<spring:message var="autoMsg_a4771ce8e8" code="admin.common.reset"/>
<spring:message var="autoMsg_65d9f48625" code="admin.explore.list.title"/>
<spring:message var="autoMsg_e17609d4e8" code="admin.common.totalCount"/>
<spring:message var="autoMsg_c2cd452002" code="admin.explore.action.bulkDelete"/>
<spring:message var="autoMsg_718dd80b81" code="admin.common.id"/>
<spring:message var="autoMsg_a5f5727330" code="admin.explore.table.image"/>
<spring:message var="autoMsg_8719b96d4d" code="admin.explore.table.spot"/>
<spring:message var="autoMsg_e64a49802f" code="admin.explore.table.author"/>
<spring:message var="autoMsg_54f6586016" code="admin.explore.table.region"/>
<spring:message var="autoMsg_b64b81f1c7" code="admin.explore.table.rating"/>
<spring:message var="autoMsg_ddce242d85" code="admin.explore.table.reviews"/>
<spring:message var="autoMsg_46b0c3d814" code="admin.explore.table.likes"/>
<spring:message var="autoMsg_c6c739ae39" code="admin.common.status"/>
<spring:message var="autoMsg_e0dee22814" code="admin.common.action"/>
<spring:message var="autoMsg_99dc4fa85e" code="admin.explore.detail.userView"/>
<spring:message var="autoMsg_d60c101c84" code="admin.explore.detail.reviewsManageAll"/>
<spring:message var="autoMsg_b4146ee35d" code="admin.common.edit"/>
<spring:message var="autoMsg_317189ffb8" code="admin.common.delete"/>
<spring:message var="autoMsg_475645b59e" code="admin.explore.list.empty"/>
<spring:message var="autoMsg_2a1aa903e9" code="admin.common.previous"/>
<spring:message var="autoMsg_72dce68a9d" code="admin.common.next"/>
<spring:message var="autoMsg_754994d1e2" code="admin.common.pageStatus"/>
<spring:message var="autoMsg_b36552c04c" code="admin.explore.bulk.selected" javaScriptEscape="true"/>
<spring:message var="autoMsg_e24d6bc861" code="admin.explore.confirm.deleteOne" javaScriptEscape="true"/>
<spring:message var="autoMsg_c1aa2cbb56" code="admin.explore.confirm.deleteBulk" javaScriptEscape="true"/>
<spring:message var="autoMsg_a4fc383abd" code="admin.explore.error.requestFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_417989b925" code="admin.explore.error.noSelection" javaScriptEscape="true"/>
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
            <div class="adm-summary-label">${autoMsg_6388cc3f63}</div>
            <div class="adm-summary-value">${stats.totalSpots}</div>
            <div class="adm-summary-sub">
                <spring:message code="admin.explore.kpi.activeSpots" arguments="${stats.activeSpots}"/>
            </div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label">${autoMsg_352186d9fb}</div>
            <div class="adm-summary-value">${stats.deletedSpots}</div>
            <div class="adm-summary-sub">${autoMsg_3449746175}</div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label">${autoMsg_9e11b546b5}</div>
            <div class="adm-summary-value">${stats.totalReviews}</div>
            <div class="adm-summary-sub">
                <spring:message code="admin.explore.kpi.activeReviews" arguments="${stats.activeReviews}"/>
            </div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label">${autoMsg_9d84f52349}</div>
            <div class="adm-summary-value">${stats.blockedReviews}</div>
            <div class="adm-summary-sub">${autoMsg_590cf1e027}</div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/explore">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label">${autoMsg_1df8c7b9fd}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status=='ALL'?'selected':''}>${autoMsg_ea55659189}</option>
                            <option value="ACTIVE" ${search.status=='ACTIVE'?'selected':''}>${autoMsg_00c4efcf34}</option>
                            <option value="DELETED" ${search.status=='DELETED'?'selected':''}>${autoMsg_e665617fbf}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_c15fef9ed2}</div>
                        <select class="adm-select" name="sortBy">
                            <option value="createdAt" ${search.sortBy=='createdAt'?'selected':''}>${autoMsg_de08eb5217}</option>
                            <option value="reviewCount" ${search.sortBy=='reviewCount'?'selected':''}>${autoMsg_f962a78488}</option>
                            <option value="likeCount" ${search.sortBy=='likeCount'?'selected':''}>${autoMsg_d496607bb0}</option>
                            <option value="ratingAvg" ${search.sortBy=='ratingAvg'?'selected':''}>${autoMsg_c0c40d10cd}</option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">${autoMsg_7f9f992daa}</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:120px;">
                                <option value="all" ${search.searchType=='all'?'selected':''}>${autoMsg_ea55659189}</option>
                                <option value="name" ${search.searchType=='name'?'selected':''}>${autoMsg_7addeb3341}</option>
                                <option value="region" ${search.searchType=='region'?'selected':''}>${autoMsg_395b543ab1}</option>
                                <option value="address" ${search.searchType=='address'?'selected':''}>${autoMsg_b745da2b5c}</option>
                                <option value="description" ${search.searchType=='description'?'selected':''}>${autoMsg_a4ff9647e7}</option>
                                <option value="nickname" ${search.searchType=='nickname'?'selected':''}>${autoMsg_7877c2ac8b}</option>
                                <option value="userId" ${search.searchType=='userId'?'selected':''}>${autoMsg_fb14a3e5ce}</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="${autoMsg_ccb9f67e95}" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit">${autoMsg_98a95c450b}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore">${autoMsg_a4771ce8e8}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title">${autoMsg_65d9f48625}</div>
                <div class="adm-muted-inline">${autoMsg_e17609d4e8}</div>
            </div>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" class="adm-muted-inline"></span>
                <button class="adm-btn adm-btn-ghost" type="button" onclick="bulkAction('delete')">${autoMsg_c2cd452002}</button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:70px;">${autoMsg_718dd80b81}</th>
                    <th style="width:84px;">${autoMsg_a5f5727330}</th>
                    <th>${autoMsg_8719b96d4d}</th>
                    <th style="width:120px;">${autoMsg_e64a49802f}</th>
                    <th style="width:130px;">${autoMsg_54f6586016}</th>
                    <th style="width:80px;">${autoMsg_b64b81f1c7}</th>
                    <th style="width:70px;">${autoMsg_ddce242d85}</th>
                    <th style="width:70px;">${autoMsg_46b0c3d814}</th>
                    <th style="width:80px;">${autoMsg_c6c739ae39}</th>
                    <th style="width:140px;">${autoMsg_e0dee22814}</th>
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
                            <a class="adm-cell-link adm-cell-link--inline adm-cell-ellipsis"
                               href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}"
                               style="font-size:11px;color:#64748b;margin-top:4px;max-width:260px;">${fn:escapeXml(spot.address)}</a>
                            <div class="adm-inline-actions">
                                <a href="${pageContext.request.contextPath}/detail/${spot.spotIdx}" target="_blank" class="adm-inline-chip">${autoMsg_99dc4fa85e}</a>
                                <a href="${pageContext.request.contextPath}${spotReviewsManageUrl}" class="adm-inline-chip">${autoMsg_d60c101c84}</a>
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
                                    <c:when test="${spot.displayStatus == 'ACTIVE'}">${autoMsg_00c4efcf34}</c:when>
                                    <c:otherwise>${autoMsg_e665617fbf}</c:otherwise>
                                </c:choose>
                            </a>
                        </td>
                        <td>
                            <div class="adm-row-actions">
                                <a class="adm-row-btn detail" href="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}?edit=true">${autoMsg_b4146ee35d}</a>
                                <c:if test="${spot.displayStatus != 'DELETED'}">
                                    <div class="action-menu-wrap">
                                        <button class="adm-row-btn detail adm-row-btn-more"
                                                type="button"
                                                onclick="admToggleActionMenu(this)">⋯</button>
                                        <div class="action-menu">
                                            <button class="action-menu-item danger"
                                                    type="button"
                                                    data-id="${spot.spotIdx}"
                                                    onclick="actionSpot(this, 'delete')">${autoMsg_317189ffb8}</button>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="11" style="text-align:center;padding:40px;color:#475569;">${autoMsg_475645b59e}</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}">
                    <button class="adm-page-btn" type="button" onclick="goPage(${paging.startPage - 1})">${autoMsg_2a1aa903e9}</button>
                </c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pg">
                    <button class="adm-page-btn ${pg == paging.currentPage ? 'active' : ''}" type="button" onclick="goPage(${pg})">${pg}</button>
                </c:forEach>
                <c:if test="${paging.next}">
                    <button class="adm-page-btn" type="button" onclick="goPage(${paging.endPage + 1})">${autoMsg_72dce68a9d}</button>
                </c:if>
                <span class="adm-page-info">${autoMsg_754994d1e2}</span>
            </div>
        </c:if>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var EXPLORE_LIST_MSG = {
    bulkSelectedTemplate: '${autoMsg_b36552c04c}',
    confirmDeleteOne: '${autoMsg_e24d6bc861}',
    confirmDeleteBulk: '${autoMsg_c1aa2cbb56}',
    requestFailed: '${autoMsg_a4fc383abd}',
    noSelection: '${autoMsg_417989b925}'
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
