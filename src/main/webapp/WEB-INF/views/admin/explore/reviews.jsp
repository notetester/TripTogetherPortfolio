<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_260c6d24ee" code="admin.explore.reviews.kpi.total"/>
<spring:message var="autoMsg_5e6a9dc28b" code="admin.explore.reviews.kpi.activeCount"/>
<spring:message var="autoMsg_aab3db60c6" code="admin.explore.reviews.kpi.blocked"/>
<spring:message var="autoMsg_77563de209" code="admin.explore.reviews.kpi.blockedSub"/>
<spring:message var="autoMsg_845afd0f3a" code="admin.explore.filter.status"/>
<spring:message var="autoMsg_55e4530dbb" code="admin.common.all"/>
<spring:message var="autoMsg_5b19f026f3" code="admin.explore.reviewStatus.active"/>
<spring:message var="autoMsg_0b41edb71e" code="admin.explore.reviewStatus.blocked"/>
<spring:message var="autoMsg_d5a1393999" code="admin.explore.filter.search"/>
<spring:message var="autoMsg_092022ef1e" code="admin.explore.searchType.name"/>
<spring:message var="autoMsg_4505e2f17d" code="admin.explore.searchType.nickname"/>
<spring:message var="autoMsg_fc2e2bf1a8" code="admin.explore.searchType.content"/>
<spring:message var="autoMsg_f36c72281f" code="admin.explore.filter.searchPlaceholder"/>
<spring:message var="autoMsg_e0948362a7" code="admin.common.searchButton"/>
<spring:message var="autoMsg_7db80b238a" code="admin.common.reset"/>
<spring:message var="autoMsg_1f71a8d245" code="admin.explore.reviews.listTitle"/>
<spring:message var="autoMsg_e09dc29116" code="admin.common.totalCount"/>
<spring:message var="autoMsg_74a1e690b8" code="admin.explore.reviews.action.bulkBlock"/>
<spring:message var="autoMsg_18b5b16224" code="admin.explore.detail.reviewId"/>
<spring:message var="autoMsg_61ffe92508" code="admin.explore.reviews.table.spot"/>
<spring:message var="autoMsg_c011c8fe23" code="admin.explore.reviews.table.author"/>
<spring:message var="autoMsg_cd6fd68c3b" code="admin.explore.reviews.table.rating"/>
<spring:message var="autoMsg_6332d99417" code="admin.explore.reviews.table.content"/>
<spring:message var="autoMsg_507049e3b8" code="admin.common.status"/>
<spring:message var="autoMsg_b782543b3e" code="admin.explore.reviews.table.createdAt"/>
<spring:message var="autoMsg_79c9e8813d" code="admin.common.action"/>
<spring:message var="autoMsg_1ea813c1da" code="admin.explore.detail.userView"/>
<spring:message var="autoMsg_61a02fb94c" code="admin.common.actionLabel"/>
<spring:message var="autoMsg_3283be2b04" code="admin.translation.label.exploreReviewContent"/>
<spring:message var="autoMsg_237b4dd8b8" code="admin.explore.reviews.action.block"/>
<spring:message var="autoMsg_1cdd01a2b2" code="admin.common.viewDetail"/>
<spring:message var="autoMsg_e00f70f1fd" code="admin.explore.reviews.empty"/>
<spring:message var="autoMsg_ef62d2ec73" code="admin.common.previous"/>
<spring:message var="autoMsg_d838622d57" code="admin.common.next"/>
<spring:message var="autoMsg_240e8a88d1" code="admin.common.pageStatus"/>
<spring:message var="autoMsg_207442f011" code="admin.explore.reviews.bulk.selected" javaScriptEscape="true"/>
<spring:message var="autoMsg_dfe0c8648a" code="admin.explore.reviews.confirm.blockOne" javaScriptEscape="true"/>
<spring:message var="autoMsg_042123602a" code="admin.explore.reviews.confirm.blockBulk" javaScriptEscape="true"/>
<spring:message var="autoMsg_971975bb25" code="admin.explore.reviews.error.requestFailed" javaScriptEscape="true"/>
<spring:message var="autoMsg_b56236b4e2" code="admin.explore.reviews.error.noSelection" javaScriptEscape="true"/>
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
            <div class="adm-summary-label">${autoMsg_260c6d24ee}</div>
            <div class="adm-summary-value">${stats.totalReviews}</div>
            <div class="adm-summary-sub">${autoMsg_5e6a9dc28b}</div>
        </div>
        <div class="adm-summary-card">
            <div class="adm-summary-label">${autoMsg_aab3db60c6}</div>
            <div class="adm-summary-value">${stats.blockedReviews}</div>
            <div class="adm-summary-sub">${autoMsg_77563de209}</div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/explore/reviews">
                <div class="adm-filter-bar" style="flex-wrap:wrap;gap:12px;">
                    <div>
                        <div class="adm-filter-label">${autoMsg_845afd0f3a}</div>
                        <select class="adm-select" name="reviewStatus">
                            <option value="ALL" ${search.reviewStatus=='ALL'?'selected':''}>${autoMsg_55e4530dbb}</option>
                            <option value="ACTIVE" ${search.reviewStatus=='ACTIVE'?'selected':''}>${autoMsg_5b19f026f3}</option>
                            <option value="BLOCKED" ${search.reviewStatus=='BLOCKED'?'selected':''}>${autoMsg_0b41edb71e}</option>
                        </select>
                    </div>
                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">${autoMsg_d5a1393999}</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:120px;">
                                <option value="all" ${search.searchType=='all'?'selected':''}>${autoMsg_55e4530dbb}</option>
                                <option value="name" ${search.searchType=='name'?'selected':''}>${autoMsg_092022ef1e}</option>
                                <option value="nickname" ${search.searchType=='nickname'?'selected':''}>${autoMsg_4505e2f17d}</option>
                                <option value="content" ${search.searchType=='content'?'selected':''}>${autoMsg_fc2e2bf1a8}</option>
                            </select>
                            <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="${autoMsg_f36c72281f}" style="flex:1;">
                        </div>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:6px;">
                        <button class="adm-btn adm-btn-primary" type="submit">${autoMsg_e0948362a7}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore/reviews">${autoMsg_7db80b238a}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div style="display:flex;align-items:center;gap:12px;">
                <div class="adm-card-title">${autoMsg_1f71a8d245}</div>
                <div class="adm-muted-inline">${autoMsg_e09dc29116}</div>
            </div>
            <div id="bulkBar" style="display:none;gap:8px;align-items:center;">
                <span id="bulkCount" class="adm-muted-inline"></span>
                <button class="adm-btn adm-btn-ghost" type="button" onclick="bulkAction('block')">${autoMsg_74a1e690b8}</button>
            </div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:36px;"><input type="checkbox" id="checkAll"></th>
                    <th style="width:70px;">${autoMsg_18b5b16224}</th>
                    <th style="width:180px;">${autoMsg_61ffe92508}</th>
                    <th style="width:120px;">${autoMsg_c011c8fe23}</th>
                    <th style="width:70px;">${autoMsg_cd6fd68c3b}</th>
                    <th>${autoMsg_6332d99417}</th>
                    <th style="width:80px;">${autoMsg_507049e3b8}</th>
                    <th style="width:90px;">${autoMsg_b782543b3e}</th>
                    <th style="width:90px;">${autoMsg_79c9e8813d}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="review">
                    <tr>
                        <td><input type="checkbox" class="row-check" data-id="${review.reviewIdx}"></td>
                        <td class="adm-muted-inline">#${review.reviewIdx}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/explore/spots/${review.spotIdx}" class="adm-cell-link">
                                <span style="font-weight:700;color:#e2e8f0;">${fn:escapeXml(review.spotName)}</span>
                                <span class="adm-cell-link-note">${autoMsg_1ea813c1da}</span>
                            </a>
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
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-focus-review-action"
                                    data-review-idx="${review.reviewIdx}">
                                <span style="font-size:12px;color:#d97706;">${review.rating}/5</span>
                                <span class="adm-cell-link-note">${autoMsg_61a02fb94c}</span>
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
                                <span class="adm-cell-link-note">${autoMsg_61a02fb94c}</span>
                            </button>
                            <c:if test="${not empty review.content}">
                                <div class="adm-tr-inline js-admin-translation-widget"
                                     data-label="${autoMsg_3283be2b04}"
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
                                        <c:when test="${review.displayStatus == 'ACTIVE'}">${autoMsg_5b19f026f3}</c:when>
                                        <c:otherwise>${autoMsg_0b41edb71e}</c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-cell-link-note">${autoMsg_61a02fb94c}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-focus-review-action"
                                    data-review-idx="${review.reviewIdx}">
                                <span class="adm-muted-inline"><fmt:formatDate value="${review.createdAtDate}" type="date" dateStyle="short"/></span>
                                <span class="adm-cell-link-note">${autoMsg_61a02fb94c}</span>
                            </button>
                        </td>
                        <td>
                            <div id="review-action-${review.reviewIdx}" class="adm-row-actions" style="justify-content:flex-start;">
                                <c:if test="${review.displayStatus != 'BLOCKED'}">
                                    <button class="adm-btn adm-btn-ghost" type="button" style="font-size:11px;padding:3px 8px;" data-id="${review.reviewIdx}" onclick="actionReview(this, 'block')">${autoMsg_237b4dd8b8}</button>
                                </c:if>
                                <a class="adm-row-btn more" href="${pageContext.request.contextPath}/admin/explore/spots/${review.spotIdx}">${autoMsg_1cdd01a2b2}</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="9" style="text-align:center;padding:40px;color:#475569;">${autoMsg_e00f70f1fd}</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}"><button class="adm-page-btn" type="button" onclick="goPage(${paging.startPage - 1})">${autoMsg_ef62d2ec73}</button></c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pg"><button class="adm-page-btn ${pg == paging.currentPage ? 'active' : ''}" type="button" onclick="goPage(${pg})">${pg}</button></c:forEach>
                <c:if test="${paging.next}"><button class="adm-page-btn" type="button" onclick="goPage(${paging.endPage + 1})">${autoMsg_d838622d57}</button></c:if>
                <span class="adm-page-info">${autoMsg_240e8a88d1}</span>
            </div>
        </c:if>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var EXPLORE_REVIEW_MSG = {
    bulkSelectedTemplate: '${autoMsg_207442f011}',
    confirmBlockOne: '${autoMsg_dfe0c8648a}',
    confirmBlockBulk: '${autoMsg_042123602a}',
    requestFailed: '${autoMsg_971975bb25}',
    noSelection: '${autoMsg_b56236b4e2}'
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
</script>

<%@ include file="../layout-close.jsp" %>
