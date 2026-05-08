<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_translation_label_exploreReviewContent" code="admin.translation.label.exploreReviewContent"/>
<spring:message var="msg_admin_explore_detail_maxTagLimit_js" code="admin.explore.detail.maxTagLimit" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_detail_confirmDelete_js" code="admin.explore.detail.confirmDelete" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_detail_confirmBlockReview_js" code="admin.explore.detail.confirmBlockReview" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_detail_error_requestFailed_js" code="admin.explore.detail.error.requestFailed" javaScriptEscape="true"/>
<spring:message var="msg_admin_explore_detail_pageTitle" code="admin.explore.detail.pageTitle"/>
<spring:message var="msg_admin_explore_detail_backToList" code="admin.explore.detail.backToList"/>
<spring:message var="msg_admin_explore_detail_title" code="admin.explore.detail.title"/>
<spring:message var="msg_admin_explore_detail_userView" code="admin.explore.detail.userView"/>
<spring:message var="msg_admin_common_edit" code="admin.common.edit"/>
<spring:message var="msg_admin_common_delete" code="admin.common.delete"/>
<spring:message var="msg_admin_explore_detail_imageEmpty" code="admin.explore.detail.imageEmpty"/>
<spring:message var="msg_admin_explore_detail_spotName" code="admin.explore.detail.spotName"/>
<spring:message var="msg_admin_explore_status_active" code="admin.explore.status.active"/>
<spring:message var="msg_admin_explore_status_deleted" code="admin.explore.status.deleted"/>
<spring:message var="msg_admin_explore_detail_author" code="admin.explore.detail.author"/>
<spring:message var="msg_admin_explore_detail_region" code="admin.explore.detail.region"/>
<spring:message var="msg_admin_explore_detail_spotId" code="admin.explore.detail.spotId"/>
<spring:message var="msg_admin_explore_detail_ratingReviews" code="admin.explore.detail.ratingReviews"/>
<spring:message var="msg_admin_explore_detail_reviewCount" code="admin.explore.detail.reviewCount"/>
<spring:message var="msg_admin_explore_detail_likeTags" code="admin.explore.detail.likeTags"/>
<spring:message var="msg_admin_explore_detail_likeTagsValue" code="admin.explore.detail.likeTagsValue"/>
<spring:message var="msg_admin_explore_detail_address" code="admin.explore.detail.address"/>
<spring:message var="msg_admin_explore_detail_coordinates" code="admin.explore.detail.coordinates"/>
<spring:message var="msg_admin_explore_detail_coordinatesValue" code="admin.explore.detail.coordinatesValue"/>
<spring:message var="msg_admin_explore_detail_description" code="admin.explore.detail.description"/>
<spring:message var="msg_admin_explore_detail_tags" code="admin.explore.detail.tags"/>
<spring:message var="msg_admin_explore_detail_tagsEmpty" code="admin.explore.detail.tagsEmpty"/>
<spring:message var="msg_admin_explore_detail_editTitle" code="admin.explore.detail.editTitle"/>
<spring:message var="msg_admin_explore_detail_editSub" code="admin.explore.detail.editSub"/>
<spring:message var="msg_admin_explore_detail_latitude" code="admin.explore.detail.latitude"/>
<spring:message var="msg_admin_explore_detail_longitude" code="admin.explore.detail.longitude"/>
<spring:message var="msg_admin_explore_detail_imageReplace" code="admin.explore.detail.imageReplace"/>
<spring:message var="msg_admin_explore_detail_imageReplaceSub" code="admin.explore.detail.imageReplaceSub"/>
<spring:message var="msg_admin_explore_detail_tagSelect" code="admin.explore.detail.tagSelect"/>
<spring:message var="msg_admin_explore_detail_tagLimit" code="admin.explore.detail.tagLimit"/>
<spring:message var="msg_admin_common_cancel" code="admin.common.cancel"/>
<spring:message var="msg_admin_common_save" code="admin.common.save"/>
<spring:message var="msg_admin_explore_detail_reviewsTitle" code="admin.explore.detail.reviewsTitle"/>
<spring:message var="msg_admin_explore_detail_reviewsManageAll" code="admin.explore.detail.reviewsManageAll"/>
<spring:message var="msg_admin_explore_detail_reviewId" code="admin.explore.detail.reviewId"/>
<spring:message var="msg_admin_explore_detail_reviewAuthor" code="admin.explore.detail.reviewAuthor"/>
<spring:message var="msg_admin_explore_detail_reviewRating" code="admin.explore.detail.reviewRating"/>
<spring:message var="msg_admin_explore_detail_reviewContent" code="admin.explore.detail.reviewContent"/>
<spring:message var="msg_admin_common_status" code="admin.common.status"/>
<spring:message var="msg_admin_explore_detail_reviewCreatedAt" code="admin.explore.detail.reviewCreatedAt"/>
<spring:message var="msg_admin_common_action" code="admin.common.action"/>
<spring:message var="msg_admin_explore_reviewStatus_active" code="admin.explore.reviewStatus.active"/>
<spring:message var="msg_admin_explore_reviewStatus_blocked" code="admin.explore.reviewStatus.blocked"/>
<spring:message var="msg_admin_explore_reviews_action_block" code="admin.explore.reviews.action.block"/>
<spring:message var="msg_admin_explore_detail_reviewEmpty" code="admin.explore.detail.reviewEmpty"/>
<c:set var="activeMenu" value="explore"/>


<c:set var="pageTitle" value="${msg_admin_explore_detail_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content adm-explore-page adm-explore-detail-page">
    <c:choose>
        <c:when test="${param.source == 'reviews'}">
            <c:url var="exploreBackUrl" value="/admin/explore/reviews">
                <c:if test="${not empty param.page}"><c:param name="page" value="${param.page}"/></c:if>
                <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}"/></c:if>
                <c:if test="${not empty param.reviewStatus}"><c:param name="reviewStatus" value="${param.reviewStatus}"/></c:if>
                <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}"/></c:if>
                <c:if test="${not empty param.keyword}"><c:param name="keyword" value="${param.keyword}"/></c:if>
            </c:url>
        </c:when>
        <c:otherwise>
            <c:url var="exploreBackUrl" value="/admin/explore">
                <c:if test="${not empty param.page}"><c:param name="page" value="${param.page}"/></c:if>
                <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}"/></c:if>
                <c:if test="${not empty param.status}"><c:param name="status" value="${param.status}"/></c:if>
                <c:if test="${not empty param.sortBy}"><c:param name="sortBy" value="${param.sortBy}"/></c:if>
                <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}"/></c:if>
                <c:if test="${not empty param.keyword}"><c:param name="keyword" value="${param.keyword}"/></c:if>
            </c:url>
        </c:otherwise>
    </c:choose>
    <c:url var="spotUpdateUrl" value="/admin/explore/spots/${spot.spotIdx}/update">
        <c:if test="${not empty param.source}"><c:param name="source" value="${param.source}"/></c:if>
        <c:if test="${not empty param.page}"><c:param name="page" value="${param.page}"/></c:if>
        <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}"/></c:if>
        <c:if test="${not empty param.status}"><c:param name="status" value="${param.status}"/></c:if>
        <c:if test="${not empty param.reviewStatus}"><c:param name="reviewStatus" value="${param.reviewStatus}"/></c:if>
        <c:if test="${not empty param.sortBy}"><c:param name="sortBy" value="${param.sortBy}"/></c:if>
        <c:if test="${not empty param.searchType}"><c:param name="searchType" value="${param.searchType}"/></c:if>
        <c:if test="${not empty param.keyword}"><c:param name="keyword" value="${param.keyword}"/></c:if>
    </c:url>
    <c:url var="detailReviewsManageUrl" value="/admin/explore/reviews">
        <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}"/></c:if>
        <c:param name="searchType" value="name"/>
        <c:param name="keyword" value="${spot.name}"/>
    </c:url>
    <div class="adm-explore-detail-backrow">
        <a class="adm-back-link" href="${exploreBackUrl}">
            ${msg_admin_explore_detail_backToList}
        </a>
    </div>

    <div class="adm-card adm-explore-detail-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_explore_detail_title}</div>
            <div class="adm-explore-detail-actions">
                <a class="adm-btn adm-btn-ghost adm-link-button adm-explore-detail-btn" href="${pageContext.request.contextPath}/detail/${spot.spotIdx}" target="_blank">${msg_admin_explore_detail_userView}</a>
                <button type="button" class="adm-btn adm-explore-detail-btn" onclick="toggleEditForm()">${msg_admin_common_edit}</button>
                <c:if test="${spot.displayStatus != 'DELETED'}">
                    <button class="adm-btn adm-btn-ghost adm-explore-detail-btn adm-explore-danger-btn" type="button" data-id="${spot.spotIdx}" onclick="deleteSpot(this)">${msg_admin_common_delete}</button>
                </c:if>
            </div>
        </div>
        <div class="adm-card-body adm-explore-detail-overview">
            <div class="adm-explore-detail-media">
                <c:choose>
                    <c:when test="${not empty spot.thumbUrl}">
                        <img class="adm-explore-detail-image" src="${spot.thumbUrl}" alt="${fn:escapeXml(spot.name)}">
                    </c:when>
                    <c:otherwise>
                        <div class="adm-image-placeholder adm-explore-detail-image adm-explore-detail-image-empty">
                            ${msg_admin_explore_detail_imageEmpty}
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="adm-explore-detail-info">
                <div class="adm-explore-detail-title-row">
                    <div>
                        <div class="adm-summary-label">${msg_admin_explore_detail_spotName}</div>
                        <div class="adm-field-value adm-explore-detail-name">${fn:escapeXml(spot.name)}</div>
                    </div>
                    <span class="status-badge ${spot.displayStatus}">
                        <c:choose>
                            <c:when test="${spot.displayStatus == 'ACTIVE'}">${msg_admin_explore_status_active}</c:when>
                            <c:otherwise>${msg_admin_explore_status_deleted}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="adm-explore-detail-field-grid">
                    <div class="adm-explore-detail-field">
                        <div class="adm-summary-label">${msg_admin_explore_detail_author}</div>
                        <button type="button"
                                class="adm-inline-link adm-explore-author-name js-open-member-context"
                                data-user-idx="${spot.userIdx}">
                            ${fn:escapeXml(spot.nickname)}
                        </button>
                        <div class="adm-explore-author-sub">
                            <button type="button"
                                    class="adm-inline-link adm-explore-author-id js-open-member-context"
                                    data-user-idx="${spot.userIdx}">
                                ${fn:escapeXml(spot.userId)}
                            </button>
                        </div>
                    </div>
                    <div class="adm-explore-detail-field">
                        <div class="adm-summary-label">${msg_admin_explore_detail_region}</div>
                        <div class="adm-field-value adm-explore-field-value">${fn:escapeXml(spot.region)}</div>
                    </div>
                    <div class="adm-explore-detail-field">
                        <div class="adm-summary-label">${msg_admin_explore_detail_spotId}</div>
                        <div class="adm-field-value-sub adm-explore-field-sub">${fn:escapeXml(spot.spotId)}</div>
                    </div>
                    <div class="adm-explore-detail-field">
                        <div class="adm-summary-label">${msg_admin_explore_detail_ratingReviews}</div>
                        <div class="adm-field-value adm-explore-field-value"><fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/> / ${msg_admin_explore_detail_reviewCount}</div>
                    </div>
                    <div class="adm-explore-detail-field">
                        <div class="adm-summary-label">${msg_admin_explore_detail_likeTags}</div>
                        <div class="adm-field-value adm-explore-field-value">${msg_admin_explore_detail_likeTagsValue}</div>
                    </div>
                </div>
                <div class="adm-explore-detail-field">
                    <div class="adm-summary-label">${msg_admin_explore_detail_address}</div>
                    <div class="adm-field-value adm-explore-field-value">${fn:escapeXml(spot.address)}</div>
                </div>
                <div class="adm-explore-detail-field">
                    <div class="adm-summary-label">${msg_admin_explore_detail_coordinates}</div>
                    <div class="adm-field-value-sub adm-explore-field-sub">${msg_admin_explore_detail_coordinatesValue}</div>
                </div>
                <div class="adm-explore-detail-field">
                    <div class="adm-summary-label">${msg_admin_explore_detail_description}</div>
                    <div class="adm-field-value adm-explore-field-value adm-explore-description-value">${fn:escapeXml(spot.description)}</div>
                </div>
                <div class="adm-explore-detail-field">
                    <div class="adm-summary-label adm-explore-tags-label">${msg_admin_explore_detail_tags}</div>
                    <div class="adm-explore-tags">
                        <c:forEach items="${tags}" var="tag">
                            <span class="adm-nav-badge adm-tag-badge">${fn:escapeXml(tag)}</span>
                        </c:forEach>
                        <c:if test="${empty tags}">
                            <span class="adm-muted-inline">${msg_admin_explore_detail_tagsEmpty}</span>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card adm-explore-detail-card" id="spotEditCard" hidden>
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_explore_detail_editTitle}</div>
            <div class="adm-muted-inline">${msg_admin_explore_detail_editSub}</div>
        </div>
        <div class="adm-card-body">
            <c:if test="${not empty adminEditError}">
                <div class="adm-warning-box adm-explore-edit-alert">
                    ${fn:escapeXml(adminEditError)}
                </div>
            </c:if>
            <c:if test="${not empty adminEditSuccess}">
                <div class="adm-explore-success-box">
                    ${fn:escapeXml(adminEditSuccess)}
                </div>
            </c:if>

            <form id="spotEditForm"
                  method="post"
                  action="${spotUpdateUrl}"
                  enctype="multipart/form-data"
                  class="adm-explore-edit-form">
                <div class="adm-explore-edit-grid">
                    <div>
                        <label for="spotName" class="adm-filter-label">${msg_admin_explore_detail_spotName}</label>
                        <input type="text" id="spotName" name="name" maxlength="100" value="${fn:escapeXml(adminEditForm.name)}" required class="adm-input">
                    </div>
                    <div>
                        <label for="spotRegion" class="adm-filter-label">${msg_admin_explore_detail_region}</label>
                        <input type="text" id="spotRegion" name="region" maxlength="100" value="${fn:escapeXml(adminEditForm.region)}" required class="adm-input">
                    </div>
                    <div class="adm-explore-edit-full">
                        <label for="spotAddress" class="adm-filter-label">${msg_admin_explore_detail_address}</label>
                        <input type="text" id="spotAddress" name="address" maxlength="255" value="${fn:escapeXml(adminEditForm.address)}" required class="adm-input">
                    </div>
                    <div>
                        <label for="spotLatitude" class="adm-filter-label">${msg_admin_explore_detail_latitude}</label>
                        <input type="number" id="spotLatitude" name="latitude" step="0.000001" value="${adminEditForm.latitude}" required class="adm-input">
                    </div>
                    <div>
                        <label for="spotLongitude" class="adm-filter-label">${msg_admin_explore_detail_longitude}</label>
                        <input type="number" id="spotLongitude" name="longitude" step="0.000001" value="${adminEditForm.longitude}" required class="adm-input">
                    </div>
                    <div class="adm-explore-edit-full">
                        <label for="spotDescription" class="adm-filter-label">${msg_admin_explore_detail_description}</label>
                        <textarea id="spotDescription" name="description" maxlength="2000" required class="adm-input adm-explore-edit-textarea">${fn:escapeXml(adminEditForm.description)}</textarea>
                    </div>
                    <div class="adm-explore-edit-full">
                        <label for="spotImage" class="adm-filter-label">${msg_admin_explore_detail_imageReplace}</label>
                        <input type="file" id="spotImage" name="image" accept=".jpg,.jpeg,.png,.gif,.webp" class="adm-input">
                        <div class="adm-muted-note">${msg_admin_explore_detail_imageReplaceSub}</div>
                    </div>
                    <div class="adm-explore-edit-full">
                        <div class="adm-explore-edit-section-head">
                            <label class="adm-filter-label">${msg_admin_explore_detail_tagSelect}</label>
                            <span class="adm-muted-inline">${msg_admin_explore_detail_tagLimit}</span>
                        </div>
                        <div class="adm-explore-tag-options">
                            <c:forEach var="tag" items="${writeTagList}">
                                <label class="adm-explore-tag-option">
                                    <input type="checkbox" name="tags" value="${fn:escapeXml(tag)}"
                                           <c:forEach var="selectedTag" items="${adminEditForm.tags}"><c:if test="${selectedTag == tag}">checked</c:if></c:forEach>>
                                    <span>${fn:escapeXml(tag)}</span>
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="adm-explore-edit-actions">
                    <button type="button" class="adm-btn adm-btn-ghost" onclick="closeEditForm()">${msg_admin_common_cancel}</button>
                    <button type="submit" class="adm-btn">${msg_admin_common_save}</button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_explore_detail_reviewsTitle}</div>
            <a class="adm-btn adm-btn-ghost" href="${detailReviewsManageUrl}">${msg_admin_explore_detail_reviewsManageAll}</a>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table adm-explore-table adm-explore-detail-reviews-table" data-admin-list-ignore="true">
                <colgroup>
                    <col class="adm-explore-col-id">
                    <col class="adm-explore-col-author">
                    <col class="adm-explore-col-rating">
                    <col>
                    <col class="adm-explore-col-status">
                    <col class="adm-explore-col-date-wide">
                    <col class="adm-explore-col-review-action">
                </colgroup>
                <thead>
                <tr>
                    <th onclick="exploreDetailThClick(this)">${msg_admin_explore_detail_reviewId}</th>
                    <th onclick="exploreDetailThClick(this)">${msg_admin_explore_detail_reviewAuthor}</th>
                    <th onclick="exploreDetailThClick(this)">${msg_admin_explore_detail_reviewRating}</th>
                    <th onclick="exploreDetailThClick(this)">${msg_admin_explore_detail_reviewContent}</th>
                    <th onclick="exploreDetailThClick(this)">${msg_admin_common_status}</th>
                    <th onclick="exploreDetailThClick(this)">${msg_admin_explore_detail_reviewCreatedAt}</th>
                    <th onclick="exploreDetailThClick(this)">${msg_admin_common_action}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${reviews}" var="review">
                    <tr>
                        <td class="adm-muted-inline">#${review.reviewIdx}</td>
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
                        <td><span class="adm-explore-rating-value">${review.rating}/5</span></td>
                        <td class="adm-explore-review-content-cell">
                            ${fn:escapeXml(review.content)}
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
                            <span class="status-badge ${review.displayStatus}">
                                <c:choose>
                                    <c:when test="${review.displayStatus == 'ACTIVE'}">${msg_admin_explore_reviewStatus_active}</c:when>
                                    <c:otherwise>${msg_admin_explore_reviewStatus_blocked}</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td class="adm-muted-inline"><fmt:formatDate value="${review.createdAtDate}" type="date" dateStyle="short"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${review.displayStatus != 'BLOCKED'}">
                                    <button class="adm-row-btn danger" type="button" data-id="${review.reviewIdx}" onclick="blockReview(this)">${msg_admin_explore_reviews_action_block}</button>
                                </c:when>
                                <c:otherwise>
                                    <span class="adm-muted-inline">-</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty reviews}">
                    <tr class="adm-local-empty">
                        <td colspan="7" class="adm-local-empty-cell">${msg_admin_explore_detail_reviewEmpty}</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
var ctx = '${pageContext.request.contextPath}';
var EXPLORE_DETAIL_MSG = {
    maxTagLimit: '${msg_admin_explore_detail_maxTagLimit_js}',
    confirmDelete: '${msg_admin_explore_detail_confirmDelete_js}',
    confirmBlockReview: '${msg_admin_explore_detail_confirmBlockReview_js}',
    requestFailed: '${msg_admin_explore_detail_error_requestFailed_js}'
};
var spotEditCard = document.getElementById('spotEditCard');
var spotEditForm = document.getElementById('spotEditForm');
var hasEditMessage = ${not empty adminEditError or not empty adminEditSuccess ? 'true' : 'false'};
var shouldOpenEditForm = ${openEditForm ? 'true' : 'false'};

if (spotEditCard && (hasEditMessage || shouldOpenEditForm)) {
    spotEditCard.hidden = false;
}

function toggleEditForm() {
    if (!spotEditCard) return;
    spotEditCard.hidden = !spotEditCard.hidden;
    if (!spotEditCard.hidden) {
        spotEditCard.scrollIntoView({behavior: 'smooth', block: 'start'});
    }
}

function closeEditForm() {
    if (!spotEditCard) return;
    spotEditCard.hidden = true;
}

if (spotEditForm) {
    spotEditForm.querySelectorAll('input[name="tags"]').forEach(function(checkbox) {
        checkbox.addEventListener('change', function() {
            var checked = spotEditForm.querySelectorAll('input[name="tags"]:checked');
            if (checked.length > 4) {
                this.checked = false;
                alert(EXPLORE_DETAIL_MSG.maxTagLimit);
            }
        });
    });
}

function deleteSpot(button) {
    var spotIdx = button.getAttribute('data-id');
    if (!confirm(EXPLORE_DETAIL_MSG.confirmDelete)) return;
    fetch(ctx + '/admin/explore/spots/' + spotIdx + '/delete', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function(r) {
        return r.json();
    }).then(function(d) {
        if (d.success) {
            location.reload();
        } else {
            alert(d.message || EXPLORE_DETAIL_MSG.requestFailed);
        }
    });
}

function blockReview(button) {
    var reviewIdx = button.getAttribute('data-id');
    if (!confirm(EXPLORE_DETAIL_MSG.confirmBlockReview)) return;
    fetch(ctx + '/admin/explore/reviews/' + reviewIdx + '/block', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function(r) {
        return r.json();
    }).then(function(d) {
        if (d.success) {
            location.reload();
        } else {
            alert(d.message || EXPLORE_DETAIL_MSG.requestFailed);
        }
    });
}

/* ── 헤더 클릭: 첫 행의 같은 컬럼 셀 액션을 트리거 ── */
function exploreDetailThClick(th) {
    var table = th.closest('table');
    var firstRow = table && table.querySelector('tbody tr');
    if (!firstRow) return;
    var cell = firstRow.children[th.cellIndex];
    if (!cell) return;
    var target = cell.querySelector('button, a[href]');
    if (target) { target.click(); return; }
    var anyLink = firstRow.querySelector('button.js-open-member-context, a[href]');
    if (anyLink) anyLink.click();
}
</script>

<%@ include file="../layout-close.jsp" %>
