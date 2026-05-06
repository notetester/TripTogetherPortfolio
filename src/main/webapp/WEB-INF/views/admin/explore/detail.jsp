<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="activeMenu" value="explore"/>
<spring:message var="adminTranslationLabelExploreReviewContentMsg" code="admin.translation.label.exploreReviewContent"/>
<spring:message var="adminExploreDetailMaxTagLimitMsg" code="admin.explore.detail.maxTagLimit" javaScriptEscape="true"/>
<spring:message var="adminExploreDetailConfirmDeleteMsg" code="admin.explore.detail.confirmDelete" javaScriptEscape="true"/>
<spring:message var="adminExploreDetailConfirmBlockReviewMsg" code="admin.explore.detail.confirmBlockReview" javaScriptEscape="true"/>
<spring:message var="adminExploreDetailErrorRequestFailedMsg" code="admin.explore.detail.error.requestFailed" javaScriptEscape="true"/>
<spring:message code="admin.explore.detail.pageTitle" var="adminExploreDetailPageTitle"/>
<c:set var="pageTitle" value="${adminExploreDetailPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <a class="adm-back-link" href="${pageContext.request.contextPath}/admin/explore">
        <spring:message code="admin.explore.detail.backToList"/>
    </a>

    <div class="adm-card" style="margin-top:16px;margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.explore.detail.title"/></div>
            <div style="display:flex;gap:8px;flex-wrap:wrap;">
                <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/detail/${spot.spotIdx}" target="_blank"><spring:message code="admin.explore.detail.userView"/></a>
                <button type="button" class="adm-btn" onclick="toggleEditForm()"><spring:message code="admin.common.edit"/></button>
                <c:if test="${spot.displayStatus != 'DELETED'}">
                    <button class="adm-btn adm-btn-ghost" type="button" data-id="${spot.spotIdx}" onclick="deleteSpot(this)"><spring:message code="admin.common.delete"/></button>
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
                            <spring:message code="admin.explore.detail.imageEmpty"/>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div style="display:grid;gap:12px;">
                <div style="display:flex;justify-content:space-between;gap:16px;align-items:flex-start;">
                    <div>
                        <div class="adm-summary-label"><spring:message code="admin.explore.detail.spotName"/></div>
                        <div class="adm-field-value" style="font-size:22px;font-weight:700;">${fn:escapeXml(spot.name)}</div>
                    </div>
                    <span class="status-badge ${spot.displayStatus}">
                        <c:choose>
                            <c:when test="${spot.displayStatus == 'ACTIVE'}"><spring:message code="admin.explore.status.active"/></c:when>
                            <c:otherwise><spring:message code="admin.explore.status.deleted"/></c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="adm-summary-grid" style="grid-template-columns:repeat(2, minmax(0, 1fr));margin-bottom:0;">
                    <div class="adm-card" style="padding:14px;">
                        <div class="adm-summary-label"><spring:message code="admin.explore.detail.author"/></div>
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
                        <div class="adm-summary-label"><spring:message code="admin.explore.detail.region"/></div>
                        <div class="adm-field-value" style="font-size:14px;margin-top:4px;">${fn:escapeXml(spot.region)}</div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div class="adm-summary-label"><spring:message code="admin.explore.detail.spotId"/></div>
                        <div class="adm-field-value-sub" style="font-size:13px;margin-top:4px;">${fn:escapeXml(spot.spotId)}</div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div class="adm-summary-label"><spring:message code="admin.explore.detail.ratingReviews"/></div>
                        <div class="adm-field-value" style="font-size:14px;margin-top:4px;"><fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/> / <spring:message code="admin.explore.detail.reviewCount"/></div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div class="adm-summary-label"><spring:message code="admin.explore.detail.likeTags"/></div>
                        <div class="adm-field-value" style="font-size:14px;margin-top:4px;"><spring:message code="admin.explore.detail.likeTagsValue"/></div>
                    </div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div class="adm-summary-label"><spring:message code="admin.explore.detail.address"/></div>
                    <div class="adm-field-value" style="font-size:14px;margin-top:4px;">${fn:escapeXml(spot.address)}</div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div class="adm-summary-label"><spring:message code="admin.explore.detail.coordinates"/></div>
                    <div class="adm-field-value-sub" style="font-size:13px;margin-top:4px;"><spring:message code="admin.explore.detail.coordinatesValue"/></div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div class="adm-summary-label"><spring:message code="admin.explore.detail.description"/></div>
                    <div class="adm-field-value" style="font-size:14px;margin-top:4px;line-height:1.7;">${fn:escapeXml(spot.description)}</div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div class="adm-summary-label" style="margin-bottom:8px;"><spring:message code="admin.explore.detail.tags"/></div>
                    <div style="display:flex;gap:8px;flex-wrap:wrap;">
                        <c:forEach items="${tags}" var="tag">
                            <span class="adm-nav-badge adm-tag-badge">${fn:escapeXml(tag)}</span>
                        </c:forEach>
                        <c:if test="${empty tags}">
                            <span class="adm-muted-inline"><spring:message code="admin.explore.detail.tagsEmpty"/></span>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.explore.detail.editTitle"/></div>
            <div class="adm-muted-inline"><spring:message code="admin.explore.detail.editSub"/></div>
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
                        <label for="spotName" class="adm-filter-label"><spring:message code="admin.explore.detail.spotName"/></label>
                        <input type="text" id="spotName" name="name" maxlength="100" value="${fn:escapeXml(adminEditForm.name)}" required class="adm-input">
                    </div>
                    <div>
                        <label for="spotRegion" class="adm-filter-label"><spring:message code="admin.explore.detail.region"/></label>
                        <input type="text" id="spotRegion" name="region" maxlength="100" value="${fn:escapeXml(adminEditForm.region)}" required class="adm-input">
                    </div>
                    <div style="grid-column:1 / -1;">
                        <label for="spotAddress" class="adm-filter-label"><spring:message code="admin.explore.detail.address"/></label>
                        <input type="text" id="spotAddress" name="address" maxlength="255" value="${fn:escapeXml(adminEditForm.address)}" required class="adm-input">
                    </div>
                    <div>
                        <label for="spotLatitude" class="adm-filter-label"><spring:message code="admin.explore.detail.latitude"/></label>
                        <input type="number" id="spotLatitude" name="latitude" step="0.000001" value="${adminEditForm.latitude}" required class="adm-input">
                    </div>
                    <div>
                        <label for="spotLongitude" class="adm-filter-label"><spring:message code="admin.explore.detail.longitude"/></label>
                        <input type="number" id="spotLongitude" name="longitude" step="0.000001" value="${adminEditForm.longitude}" required class="adm-input">
                    </div>
                    <div style="grid-column:1 / -1;">
                        <label for="spotDescription" class="adm-filter-label"><spring:message code="admin.explore.detail.description"/></label>
                        <textarea id="spotDescription" name="description" maxlength="2000" required class="adm-input" style="min-height:140px;resize:vertical;">${fn:escapeXml(adminEditForm.description)}</textarea>
                    </div>
                    <div style="grid-column:1 / -1;">
                        <label for="spotImage" class="adm-filter-label"><spring:message code="admin.explore.detail.imageReplace"/></label>
                        <input type="file" id="spotImage" name="image" accept=".jpg,.jpeg,.png,.gif,.webp" class="adm-input">
                        <div class="adm-muted-note"><spring:message code="admin.explore.detail.imageReplaceSub"/></div>
                    </div>
                    <div style="grid-column:1 / -1;">
                        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px;">
                            <label class="adm-filter-label"><spring:message code="admin.explore.detail.tagSelect"/></label>
                            <span class="adm-muted-inline"><spring:message code="admin.explore.detail.tagLimit"/></span>
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
                    <button type="button" class="adm-btn adm-btn-ghost" onclick="closeEditForm()"><spring:message code="admin.common.cancel"/></button>
                    <button type="submit" class="adm-btn"><spring:message code="admin.common.save"/></button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.explore.detail.reviewsTitle"/></div>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore/reviews?searchType=name&keyword=${spot.name}"><spring:message code="admin.explore.detail.reviewsManageAll"/></a>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:70px;"><spring:message code="admin.explore.detail.reviewId"/></th>
                    <th style="width:120px;"><spring:message code="admin.explore.detail.reviewAuthor"/></th>
                    <th style="width:90px;"><spring:message code="admin.explore.detail.reviewRating"/></th>
                    <th><spring:message code="admin.explore.detail.reviewContent"/></th>
                    <th style="width:90px;"><spring:message code="admin.common.status"/></th>
                    <th style="width:110px;"><spring:message code="admin.explore.detail.reviewCreatedAt"/></th>
                    <th style="width:90px;"><spring:message code="admin.common.action"/></th>
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
                                     data-label="${adminTranslationLabelExploreReviewContentMsg}"
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
                                    <c:when test="${review.displayStatus == 'ACTIVE'}"><spring:message code="admin.explore.reviewStatus.active"/></c:when>
                                    <c:otherwise><spring:message code="admin.explore.reviewStatus.blocked"/></c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td class="adm-muted-inline"><fmt:formatDate value="${review.createdAtDate}" type="date" dateStyle="short"/></td>
                        <td>
                            <c:if test="${review.displayStatus != 'BLOCKED'}">
                                <button class="adm-btn adm-btn-ghost" type="button" style="font-size:11px;padding:3px 8px;" data-id="${review.reviewIdx}" onclick="blockReview(this)"><spring:message code="admin.explore.reviews.action.block"/></button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty reviews}">
                    <tr>
                        <td colspan="7" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.explore.detail.reviewEmpty"/></td>
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
    maxTagLimit: '${adminExploreDetailMaxTagLimitMsg}',
    confirmDelete: '${adminExploreDetailConfirmDeleteMsg}',
    confirmBlockReview: '${adminExploreDetailConfirmBlockReviewMsg}',
    requestFailed: '${adminExploreDetailErrorRequestFailedMsg}'
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
