<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_explore_filter_searchPlaceholder" code="admin.explore.filter.searchPlaceholder"/>
<spring:message var="msg_admin_translation_label_exploreReviewContent" code="admin.translation.label.exploreReviewContent"/>
<spring:message var="msg_admin_explore_reviews_bulk_selected_js" code="admin.explore.reviews.bulk.selected" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_reviews_confirm_blockOne_js" code="admin.explore.reviews.confirm.blockOne" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_reviews_confirm_blockBulk_js" code="admin.explore.reviews.confirm.blockBulk" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_reviews_error_requestFailed_js" code="admin.explore.reviews.error.requestFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_reviews_error_noSelection_js" code="admin.explore.reviews.error.noSelection" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_reviews_pageTitle" code="admin.explore.reviews.pageTitle"/>
<spring:message var="msg_admin_explore_tabs_spots" code="admin.explore.tabs.spots"/>
<spring:message var="msg_admin_explore_tabs_reviews" code="admin.explore.tabs.reviews"/>
<spring:message var="msg_admin_explore_reviews_kpi_total" code="admin.explore.reviews.kpi.total"/>
<spring:message var="msg_admin_explore_reviews_kpi_activeCount" code="admin.explore.reviews.kpi.activeCount"/>
<spring:message var="msg_admin_explore_reviews_kpi_blocked" code="admin.explore.reviews.kpi.blocked"/>
<spring:message var="msg_admin_explore_reviews_kpi_blockedSub" code="admin.explore.reviews.kpi.blockedSub"/>
<spring:message var="msg_admin_explore_filter_status" code="admin.explore.filter.status"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_explore_reviewStatus_active" code="admin.explore.reviewStatus.active"/>
<spring:message var="msg_admin_explore_reviewStatus_blocked" code="admin.explore.reviewStatus.blocked"/>
<spring:message var="msg_admin_explore_filter_search" code="admin.explore.filter.search"/>
<spring:message var="msg_admin_explore_searchType_name" code="admin.explore.searchType.name"/>
<spring:message var="msg_admin_explore_searchType_nickname" code="admin.explore.searchType.nickname"/>
<spring:message var="msg_admin_explore_searchType_content" code="admin.explore.searchType.content"/>
<spring:message var="msg_admin_common_searchButton" code="admin.common.searchButton"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_explore_reviews_listTitle" code="admin.explore.reviews.listTitle"/>
<spring:message var="msg_admin_explore_reviews_action_bulkBlock" code="admin.explore.reviews.action.bulkBlock"/>
<spring:message var="msg_admin_explore_detail_reviewId" code="admin.explore.detail.reviewId"/>
<spring:message var="msg_admin_explore_reviews_table_spot" code="admin.explore.reviews.table.spot"/>
<spring:message var="msg_admin_explore_reviews_table_author" code="admin.explore.reviews.table.author"/>
<spring:message var="msg_admin_explore_reviews_table_rating" code="admin.explore.reviews.table.rating"/>
<spring:message var="msg_admin_explore_reviews_table_content" code="admin.explore.reviews.table.content"/>
<spring:message var="msg_admin_common_status" code="admin.common.status"/>
<spring:message var="msg_admin_explore_reviews_table_createdAt" code="admin.explore.reviews.table.createdAt"/>
<spring:message var="msg_admin_common_action" code="admin.common.action"/>
<spring:message var="msg_admin_explore_detail_userView" code="admin.explore.detail.userView"/>
<spring:message var="msg_admin_common_actionLabel" code="admin.common.actionLabel"/>
<spring:message var="msg_admin_explore_reviews_action_block" code="admin.explore.reviews.action.block"/>
<spring:message var="msg_admin_common_viewDetail" code="admin.common.viewDetail"/>
<spring:message var="msg_admin_explore_reviews_empty" code="admin.explore.reviews.empty"/>
<spring:message var="msg_admin_common_prev" code="admin.common.prev"/>
<spring:message var="msg_admin_common_next" code="admin.common.next"/>
<spring:message var="msg_admin_common_pageSize_20" code="admin.common.pageSize" arguments="20"/>
<spring:message var="msg_admin_common_pageSize_50" code="admin.common.pageSize" arguments="50"/>
<spring:message var="msg_admin_common_pageSize_100" code="admin.common.pageSize" arguments="100"/>
<spring:message var="msg_admin_explore_reviews_totalCountDisplay" code="admin.common.totalCountFormat" arguments="${total}"/>
<spring:message var="msg_admin_explore_reviews_currentCountDisplay" code="admin.common.currentCountFormat" arguments="${fn:length(list)}"/>
<c:set var="activeMenu" value="explore"/>


<c:set var="pageTitle" value="${msg_admin_explore_reviews_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content adm-explore-page">
    <div class="adm-admin-tabs">
        <a class="adm-tab adm-tab-link" href="${pageContext.request.contextPath}/admin/explore">
            ${msg_admin_explore_tabs_spots}
        </a>
        <a class="adm-tab adm-tab-link active" href="${pageContext.request.contextPath}/admin/explore/reviews">
            ${msg_admin_explore_tabs_reviews}
        </a>
    </div>

    <div class="adm-summary-grid adm-explore-summary-two">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_explore_reviews_kpi_total}</div>
            <div class="adm-summary-value is-success">${stats.totalReviews}</div>
            <div class="adm-summary-sub">${msg_admin_explore_reviews_kpi_activeCount}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_explore_reviews_kpi_blocked}</div>
            <div class="adm-summary-value is-warning">${stats.blockedReviews}</div>
            <div class="adm-summary-sub">${msg_admin_explore_reviews_kpi_blockedSub}</div>
        </div>
    </div>

    <div class="adm-card adm-explore-filter-card">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/explore/reviews">
                <input type="hidden" name="size" value="${search.size}"/>
                <div class="adm-filter-bar adm-explore-filterbar adm-explore-review-filterbar">
                    <div>
                        <div class="adm-filter-label">${msg_admin_explore_filter_status}</div>
                        <select class="adm-select" name="reviewStatus">
                            <option value="ALL" ${search.reviewStatus=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="ACTIVE" ${search.reviewStatus=='ACTIVE'?'selected':''}>${msg_admin_explore_reviewStatus_active}</option>
                            <option value="BLOCKED" ${search.reviewStatus=='BLOCKED'?'selected':''}>${msg_admin_explore_reviewStatus_blocked}</option>
                        </select>
                    </div>
                    <div class="adm-explore-search-field">
                        <div class="adm-filter-label">${msg_admin_explore_filter_search}</div>
                        <div class="adm-explore-search-row">
                            <select class="adm-select adm-explore-search-type" name="searchType">
                                <option value="all" ${search.searchType=='all'?'selected':''}>${msg_admin_common_all}</option>
                                <option value="name" ${search.searchType=='name'?'selected':''}>${msg_admin_explore_searchType_name}</option>
                                <option value="nickname" ${search.searchType=='nickname'?'selected':''}>${msg_admin_explore_searchType_nickname}</option>
                                <option value="content" ${search.searchType=='content'?'selected':''}>${msg_admin_explore_searchType_content}</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="${msg_admin_explore_filter_searchPlaceholder}">
                        </div>
                    </div>
                    <div class="adm-explore-filter-actions">
                        <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_searchButton}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore/reviews">${msg_admin_common_reset}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card adm-explore-list-card">
        <div class="adm-card-head adm-explore-list-head">
            <div class="adm-card-title">
                ${msg_admin_explore_reviews_listTitle}
                <span class="adm-section-total-inline">${msg_admin_explore_reviews_totalCountDisplay}</span>
            </div>
            <div class="adm-explore-list-controls">
                <select class="adm-select adm-explore-size-select" onchange="goExploreReviewPageSize(this.value)">
                    <option value="20" ${search.size == 20 ? 'selected' : ''}>${msg_admin_common_pageSize_20}</option>
                    <option value="50" ${search.size == 50 ? 'selected' : ''}>${msg_admin_common_pageSize_50}</option>
                    <option value="100" ${search.size == 100 ? 'selected' : ''}>${msg_admin_common_pageSize_100}</option>
                </select>
                <div id="bulkBar" class="adm-explore-bulk-bar" hidden>
                    <span id="bulkCount" class="adm-muted-inline"></span>
                    <button class="adm-btn adm-btn-ghost adm-explore-danger-btn" type="button" onclick="bulkAction('block')">${msg_admin_explore_reviews_action_bulkBlock}</button>
                </div>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table adm-explore-table adm-explore-reviews-table" data-admin-list-ignore="true">
                <colgroup>
                    <col class="adm-explore-col-check">
                    <col class="adm-explore-col-id">
                    <col class="adm-explore-col-source">
                    <col class="adm-explore-col-author">
                    <col class="adm-explore-col-rating-small">
                    <col>
                    <col class="adm-explore-col-status">
                    <col class="adm-explore-col-date">
                    <col class="adm-explore-col-review-action">
                </colgroup>
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkAll"></th>
                    <th onclick="exploreReviewsThClick(this)">${msg_admin_explore_detail_reviewId}</th>
                    <th onclick="exploreReviewsThClick(this)">${msg_admin_explore_reviews_table_spot}</th>
                    <th onclick="exploreReviewsThClick(this)">${msg_admin_explore_reviews_table_author}</th>
                    <th onclick="exploreReviewsThClick(this)">${msg_admin_explore_reviews_table_rating}</th>
                    <th onclick="exploreReviewsThClick(this)">${msg_admin_explore_reviews_table_content}</th>
                    <th onclick="exploreReviewsThClick(this)">${msg_admin_common_status}</th>
                    <th onclick="exploreReviewsThClick(this)">${msg_admin_explore_reviews_table_createdAt}</th>
                    <th onclick="exploreReviewsThClick(this)">${msg_admin_common_action}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="review">
                    <c:url var="reviewSpotDetailUrl" value="/admin/explore/spots/${review.spotIdx}">
                        <c:param name="source" value="reviews"/>
                        <c:param name="page" value="${paging.currentPage}"/>
                        <c:param name="size" value="${search.size}"/>
                        <c:param name="reviewStatus" value="${search.reviewStatus}"/>
                        <c:param name="searchType" value="${search.searchType}"/>
                        <c:param name="keyword" value="${search.keyword}"/>
                    </c:url>
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${review.reviewIdx}"></td>
                        <td class="adm-muted-inline">#${review.reviewIdx}</td>
                        <td>
                            <a href="${reviewSpotDetailUrl}" class="adm-cell-link">
                                <span class="adm-explore-spot-name">${fn:escapeXml(review.spotName)}</span>
                                <span class="adm-cell-link-note">${msg_admin_explore_detail_userView}</span>
                            </a>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-inline-link adm-explore-author-name js-open-member-context"
                                    data-user-idx="${review.userIdx}">
                                ${fn:escapeXml(review.nickname)}
                            </button>
                            <div class="adm-muted-inline">
                                <button type="button"
                                        class="adm-inline-link adm-explore-author-id js-open-member-context"
                                        data-user-idx="${review.userIdx}">
                                    ${fn:escapeXml(review.userId)}
                                </button>
                            </div>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-focus-review-action"
                                    data-review-idx="${review.reviewIdx}">
                                <span class="adm-explore-rating-value">${review.rating}/5</span>
                                <span class="adm-cell-link-note">${msg_admin_common_actionLabel}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-focus-review-action"
                                    data-review-idx="${review.reviewIdx}">
                                <span class="adm-review-content">
                                    <c:choose>
                                        <c:when test="${fn:length(review.content) > 60}">${fn:escapeXml(fn:substring(review.content, 0, 60))}…</c:when>
                                        <c:otherwise>${fn:escapeXml(review.content)}</c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-cell-link-note">${msg_admin_common_actionLabel}</span>
                            </button>
                            <c:if test="${not empty review.content}">
                                <div class="adm-tr-inline js-admin-translation-widget"
                                     data-label="${msg_admin_translation_label_exploreReviewContent}"
                                     data-source-type="EXPLORE_REVIEW"
                                     data-source-idx="${review.reviewIdx}"
                                     data-field-name="content"
                                     data-default-source-lang="ko"
                                     data-source-text="${fn:escapeXml(review.content)}"></div>
                            </c:if>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-focus-review-action"
                                    data-review-idx="${review.reviewIdx}">
                                <span class="status-badge ${review.displayStatus}">
                                    <c:choose>
                                        <c:when test="${review.displayStatus == 'ACTIVE'}">${msg_admin_explore_reviewStatus_active}</c:when>
                                        <c:otherwise>${msg_admin_explore_reviewStatus_blocked}</c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-cell-link-note">${msg_admin_common_actionLabel}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-focus-review-action"
                                    data-review-idx="${review.reviewIdx}">
                                <span class="adm-muted-inline"><fmt:formatDate value="${review.createdAtDate}" type="date" dateStyle="short"/></span>
                                <span class="adm-cell-link-note">${msg_admin_common_actionLabel}</span>
                            </button>
                        </td>
                        <td>
                            <div id="review-action-${review.reviewIdx}" class="adm-row-actions adm-explore-review-actions">
                                <c:if test="${review.displayStatus != 'BLOCKED'}">
                                    <button class="adm-row-btn danger" type="button" data-id="${review.reviewIdx}" onclick="actionReview(this, 'block')">${msg_admin_explore_reviews_action_block}</button>
                                </c:if>
                                <a class="adm-row-btn detail" href="${reviewSpotDetailUrl}">${msg_admin_common_viewDetail}</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr class="adm-local-empty"><td colspan="9" class="adm-local-empty-cell">${msg_admin_explore_reviews_empty}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <c:set var="exploreReviewTotalPage" value="${paging.totalPage < 1 ? 1 : paging.totalPage}"/>
        <div class="adm-local-pagination adm-explore-local-pagination">
            <div class="adm-local-page-info">
                ${msg_admin_explore_reviews_totalCountDisplay} / ${msg_admin_explore_reviews_currentCountDisplay}
            </div>
            <div class="adm-local-page-actions">
                <button type="button" class="adm-btn adm-btn-ghost" ${paging.currentPage <= 1 ? 'disabled' : ''} onclick="goPage(${paging.currentPage - 1})">${msg_admin_common_prev}</button>
                <span class="adm-local-page-state">${paging.currentPage} / ${exploreReviewTotalPage}</span>
                <button type="button" class="adm-btn adm-btn-ghost" ${paging.currentPage >= exploreReviewTotalPage ? 'disabled' : ''} onclick="goPage(${paging.currentPage + 1})">${msg_admin_common_next}</button>
            </div>
        </div>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var EXPLORE_REVIEW_MSG = {
    bulkSelectedTemplate: '${msg_admin_explore_reviews_bulk_selected_js}',
    confirmBlockOne: '${msg_admin_explore_reviews_confirm_blockOne_js}',
    confirmBlockBulk: '${msg_admin_explore_reviews_confirm_blockBulk_js}',
    requestFailed: '${msg_admin_explore_reviews_error_requestFailed_js}',
    noSelection: '${msg_admin_explore_reviews_error_noSelection_js}'
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
        bar.hidden = false;
        document.getElementById('bulkCount').textContent = EXPLORE_REVIEW_MSG.bulkSelectedTemplate.replace('__COUNT__', checked.length);
    } else {
        bar.hidden = true;
    }
}


(function() {
    document.addEventListener('click', function(event) {
        var trigger = event.target.closest('.js-focus-review-action');
        if (!trigger) return;
        var target = document.getElementById('review-action-' + trigger.getAttribute('data-review-idx'));
        if (!target) return;
        target.scrollIntoView({behavior: 'smooth', block: 'center'});
        target.classList.remove('is-focus-flash');
        void target.offsetWidth;
        target.classList.add('is-focus-flash');
        var focusable = target.querySelector('button, a, input, textarea, select');
        if (focusable) {
            try { focusable.focus({preventScroll: true}); } catch (e) { focusable.focus(); }
        }
    });
})();

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

function goExploreReviewPageSize(size) {
    var params = new URLSearchParams(window.location.search);
    params.set('size', size);
    params.set('page', '1');
    location.href = ctx + '/admin/explore/reviews?' + params.toString();
}

/* ── 헤더 클릭: 첫 행의 같은 컬럼 셀 액션을 트리거 ── */
function exploreReviewsThClick(th) {
    var table = th.closest('table');
    var firstRow = table && table.querySelector('tbody tr');
    if (!firstRow) return;
    var cell = firstRow.children[th.cellIndex];
    if (!cell) return;
    var target = cell.querySelector('button:not(.row-check), a[href]');
    if (target) { target.click(); return; }
    var anyLink = firstRow.querySelector('a.adm-cell-link');
    if (anyLink) location.href = anyLink.getAttribute('href');
}
</script>

<%@ include file="../layout-close.jsp" %>
