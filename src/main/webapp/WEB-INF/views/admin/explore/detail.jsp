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

<div class="adm-content">
    <a class="adm-back-link" href="${pageContext.request.contextPath}/admin/explore">
        ${msg_admin_explore_detail_backToList}
    </a>

    <div class="adm-card" style="margin-top:16px;margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_explore_detail_title}</div>
            <div style="display:flex;gap:8px;flex-wrap:wrap;">
                <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/detail/${spot.spotIdx}" target="_blank">${msg_admin_explore_detail_userView}</a>
                <button type="button" class="adm-btn" onclick="toggleEditForm()">${msg_admin_common_edit}</button>
                <c:if test="${spot.displayStatus != 'DELETED'}">
                    <button class="adm-btn adm-btn-ghost" type="button" data-id="${spot.spotIdx}" onclick="deleteSpot(this)">${msg_admin_common_delete}</button>
                </c:if>
            </div>
        </div>
        <div class="adm-card-body" style="display:grid;grid-template-columns:280px 1fr;gap:24px;">
            <div>
                <c:choose>
                    <c:when test="${not empty spot.thumbUrl}">
                        <img src="${spot.thumbUrl}" alt="${fn:escapeXml(spot.name)}" style="width:100%;height:220px;object-fit:cover;border-radius:14px;border:1px solid #cbd5e1;">
                    </c:when>
                    <c:otherwise>
                        <div class="adm-image-placeholder" style="width:100%;height:220px;border-radius:14px;display:flex;align-items:center;justify-content:center;">
                            ${msg_admin_explore_detail_imageEmpty}
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div style="display:grid;gap:12px;">
                <div style="display:flex;justify-content:space-between;gap:16px;align-items:flex-start;">
                    <div>
                        <div class="adm-summary-label">${msg_admin_explore_detail_spotName}</div>
                        <div class="adm-field-value" style="font-size:22px;font-weight:700;">${fn:escapeXml(spot.name)}</div>
                    </div>
                    <span class="status-badge ${spot.displayStatus}">
                        <c:choose>
                            <c:when test="${spot.displayStatus == 'ACTIVE'}">${msg_admin_explore_status_active}</c:when>
                            <c:otherwise>${msg_admin_explore_status_deleted}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="adm-summary-grid" style="grid-template-columns:repeat(2, minmax(0, 1fr));margin-bottom:0;">
                    <div class="adm-card" style="padding:14px;">
                        <div class="adm-summary-label">${msg_admin_explore_detail_author}</div>
                        <button type="button"
                                class="adm-inline-link js-open-member-context"
                                data-user-idx="${spot.userIdx}"
                                style="font-size:14px;margin-top:4px;font-weight:700;color:#93c5fd;">
                            ${fn:escapeXml(spot.nickname)}
                        </button>
                        <div class="adm-muted-inline" style="margin-top:2px;">
                            <button type="button"
                                    class="adm-inline-link js-open-member-context"
                                    data-user-idx="${spot.userIdx}"
                                    style="font-size:12px;color:#94a3b8;">
                                ${fn:escapeXml(spot.userId)}
                            </button>
                        </div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div class="adm-summary-label">${msg_admin_explore_detail_region}</div>
                        <div class="adm-field-value" style="font-size:14px;margin-top:4px;">${fn:escapeXml(spot.region)}</div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div class="adm-summary-label">${msg_admin_explore_detail_spotId}</div>
                        <div class="adm-field-value-sub" style="font-size:13px;margin-top:4px;">${fn:escapeXml(spot.spotId)}</div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div class="adm-summary-label">${msg_admin_explore_detail_ratingReviews}</div>
                        <div class="adm-field-value" style="font-size:14px;margin-top:4px;"><fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/> / ${msg_admin_explore_detail_reviewCount}</div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div class="adm-summary-label">${msg_admin_explore_detail_likeTags}</div>
                        <div class="adm-field-value" style="font-size:14px;margin-top:4px;">${msg_admin_explore_detail_likeTagsValue}</div>
                    </div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div class="adm-summary-label">${msg_admin_explore_detail_address}</div>
                    <div class="adm-field-value" style="font-size:14px;margin-top:4px;">${fn:escapeXml(spot.address)}</div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div class="adm-summary-label">${msg_admin_explore_detail_coordinates}</div>
                    <div class="adm-field-value-sub" style="font-size:13px;margin-top:4px;">${msg_admin_explore_detail_coordinatesValue}</div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div class="adm-summary-label">${msg_admin_explore_detail_description}</div>
                    <div class="adm-field-value" style="font-size:14px;margin-top:4px;line-height:1.7;">${fn:escapeXml(spot.description)}</div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div class="adm-summary-label" style="margin-bottom:8px;">${msg_admin_explore_detail_tags}</div>
                    <div style="display:flex;gap:8px;flex-wrap:wrap;">
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

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_explore_detail_editTitle}</div>
            <div class="adm-muted-inline">${msg_admin_explore_detail_editSub}</div>
        </div>
        <div class="adm-card-body">
            <c:if test="${not empty adminEditError}">
                <div class="adm-warning-box" style="margin-bottom:16px;">
                    ${fn:escapeXml(adminEditError)}
                </div>
            </c:if>
            <c:if test="${not empty adminEditSuccess}">
                <div class="adm-card" style="margin-bottom:16px;padding:12px 14px;background:#ecfdf5;border:1px solid #86efac;color:#166534;">
                    ${fn:escapeXml(adminEditSuccess)}
                </div>
            </c:if>

            <form id="spotEditForm"
                  method="post"
                  action="${pageContext.request.contextPath}/admin/explore/spots/${spot.spotIdx}/update"
                  enctype="multipart/form-data"
                  style="display:none;">
                <div style="display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:16px;">
                    <div>
                        <label for="spotName" class="adm-filter-label">${msg_admin_explore_detail_spotName}</label>
                        <input type="text" id="spotName" name="name" maxlength="100" value="${fn:escapeXml(adminEditForm.name)}" required class="adm-input">
                    </div>
                    <div>
                        <label for="spotRegion" class="adm-filter-label">${msg_admin_explore_detail_region}</label>
                        <input type="text" id="spotRegion" name="region" maxlength="100" value="${fn:escapeXml(adminEditForm.region)}" required class="adm-input">
                    </div>
                    <div style="grid-column:1 / -1;">
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
                    <div style="grid-column:1 / -1;">
                        <label for="spotDescription" class="adm-filter-label">${msg_admin_explore_detail_description}</label>
                        <textarea id="spotDescription" name="description" maxlength="2000" required class="adm-input" style="min-height:140px;resize:vertical;">${fn:escapeXml(adminEditForm.description)}</textarea>
                    </div>
                    <div style="grid-column:1 / -1;">
                        <label for="spotImage" class="adm-filter-label">${msg_admin_explore_detail_imageReplace}</label>
                        <input type="file" id="spotImage" name="image" accept=".jpg,.jpeg,.png,.gif,.webp" class="adm-input">
                        <div class="adm-muted-note">${msg_admin_explore_detail_imageReplaceSub}</div>
                    </div>
                    <div style="grid-column:1 / -1;">
                        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px;">
                            <label class="adm-filter-label">${msg_admin_explore_detail_tagSelect}</label>
                            <span class="adm-muted-inline">${msg_admin_explore_detail_tagLimit}</span>
                        </div>
                        <div style="display:flex;gap:10px;flex-wrap:wrap;">
                            <c:forEach var="tag" items="${writeTagList}">
                                <label style="display:inline-flex;align-items:center;gap:6px;padding:8px 10px;border-radius:999px;border:1px solid #cbd5e1;background:#fff;color:#334155;">
                                    <input type="checkbox" name="tags" value="${fn:escapeXml(tag)}"
                                           <c:forEach var="selectedTag" items="${adminEditForm.tags}"><c:if test="${selectedTag == tag}">checked</c:if></c:forEach>>
                                    <span>${fn:escapeXml(tag)}</span>
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div style="display:flex;justify-content:flex-end;gap:8px;margin-top:20px;">
                    <button type="button" class="adm-btn adm-btn-ghost" onclick="closeEditForm()">${msg_admin_common_cancel}</button>
                    <button type="submit" class="adm-btn">${msg_admin_common_save}</button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_explore_detail_reviewsTitle}</div>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore/reviews?searchType=name&keyword=${spot.name}">${msg_admin_explore_detail_reviewsManageAll}</a>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:70px;">${msg_admin_explore_detail_reviewId}</th>
                    <th style="width:120px;">${msg_admin_explore_detail_reviewAuthor}</th>
                    <th style="width:90px;">${msg_admin_explore_detail_reviewRating}</th>
                    <th>${msg_admin_explore_detail_reviewContent}</th>
                    <th style="width:90px;">${msg_admin_common_status}</th>
                    <th style="width:110px;">${msg_admin_explore_detail_reviewCreatedAt}</th>
                    <th style="width:90px;">${msg_admin_common_action}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${reviews}" var="review">
                    <tr>
                        <td class="adm-muted-inline">#${review.reviewIdx}</td>
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
                        <td style="font-size:13px;line-height:1.6;">
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
                            <c:if test="${review.displayStatus != 'BLOCKED'}">
                                <button class="adm-btn adm-btn-ghost" type="button" style="font-size:11px;padding:3px 8px;" data-id="${review.reviewIdx}" onclick="blockReview(this)">${msg_admin_explore_reviews_action_block}</button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty reviews}">
                    <tr>
                        <td colspan="7" style="text-align:center;padding:40px;color:#475569;">${msg_admin_explore_detail_reviewEmpty}</td>
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
var spotEditForm = document.getElementById('spotEditForm');
var hasEditMessage = ${not empty adminEditError or not empty adminEditSuccess ? 'true' : 'false'};
var shouldOpenEditForm = ${openEditForm ? 'true' : 'false'};

if (spotEditForm && (hasEditMessage || shouldOpenEditForm)) {
    spotEditForm.style.display = 'block';
}

function toggleEditForm() {
    if (!spotEditForm) return;
    spotEditForm.style.display = spotEditForm.style.display === 'none' ? 'block' : 'none';
}

function closeEditForm() {
    if (!spotEditForm) return;
    spotEditForm.style.display = 'none';
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
</script>

<%@ include file="../layout-close.jsp" %>
