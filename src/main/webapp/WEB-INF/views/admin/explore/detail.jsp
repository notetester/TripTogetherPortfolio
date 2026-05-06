<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_a9d09227da" code="admin.explore.detail.title"/>
<spring:message var="autoMsg_b610ffdbe0" code="admin.explore.detail.userView"/>
<spring:message var="autoMsg_51644af0e8" code="admin.common.edit"/>
<spring:message var="autoMsg_47b3230804" code="admin.common.delete"/>
<spring:message var="autoMsg_530fc5c5ca" code="admin.explore.detail.spotName"/>
<spring:message var="autoMsg_7e05c6c918" code="admin.explore.status.active"/>
<spring:message var="autoMsg_d595950855" code="admin.explore.status.deleted"/>
<spring:message var="autoMsg_04ed1013f0" code="admin.explore.detail.author"/>
<spring:message var="autoMsg_69effa60c4" code="admin.explore.detail.region"/>
<spring:message var="autoMsg_cf27446b88" code="admin.explore.detail.spotId"/>
<spring:message var="autoMsg_4db6f420b1" code="admin.explore.detail.ratingReviews"/>
<spring:message var="autoMsg_c3253063b4" code="admin.explore.detail.reviewCount"/>
<spring:message var="autoMsg_56051ef3d3" code="admin.explore.detail.likeTags"/>
<spring:message var="autoMsg_369443d3af" code="admin.explore.detail.likeTagsValue"/>
<spring:message var="autoMsg_5e9a6c81cc" code="admin.explore.detail.address"/>
<spring:message var="autoMsg_01f0b89421" code="admin.explore.detail.coordinates"/>
<spring:message var="autoMsg_fc8ec330d4" code="admin.explore.detail.coordinatesValue"/>
<spring:message var="autoMsg_2837805ed3" code="admin.explore.detail.description"/>
<spring:message var="autoMsg_cdf7e4747c" code="admin.explore.detail.tags"/>
<spring:message var="autoMsg_c6d7a7d557" code="admin.explore.detail.tagsEmpty"/>
<spring:message var="autoMsg_4908919cd5" code="admin.explore.detail.editTitle"/>
<spring:message var="autoMsg_ef7f6abb46" code="admin.explore.detail.editSub"/>
<spring:message var="autoMsg_a6273fdc3f" code="admin.explore.detail.latitude"/>
<spring:message var="autoMsg_3c9c2ce54c" code="admin.explore.detail.longitude"/>
<spring:message var="autoMsg_5dbe059256" code="admin.explore.detail.imageReplace"/>
<spring:message var="autoMsg_d3115daddb" code="admin.explore.detail.imageReplaceSub"/>
<spring:message var="autoMsg_9ac9ec2015" code="admin.explore.detail.tagSelect"/>
<spring:message var="autoMsg_1d79d0625d" code="admin.explore.detail.tagLimit"/>
<spring:message var="autoMsg_650e649503" code="admin.common.cancel"/>
<spring:message var="autoMsg_d4d8661c17" code="admin.common.save"/>
<spring:message var="autoMsg_ea34de0329" code="admin.explore.detail.reviewsTitle"/>
<spring:message var="autoMsg_4c421ea73d" code="admin.explore.detail.reviewsManageAll"/>
<spring:message var="autoMsg_0d53b4d07d" code="admin.explore.detail.reviewId"/>
<spring:message var="autoMsg_fcf945e4d5" code="admin.explore.detail.reviewAuthor"/>
<spring:message var="autoMsg_cd0e284486" code="admin.explore.detail.reviewRating"/>
<spring:message var="autoMsg_20e9878f81" code="admin.explore.detail.reviewContent"/>
<spring:message var="autoMsg_9f710e94da" code="admin.common.status"/>
<spring:message var="autoMsg_b0e4e13e56" code="admin.explore.detail.reviewCreatedAt"/>
<spring:message var="autoMsg_994d922bcf" code="admin.common.action"/>
<spring:message var="autoMsg_6097ab20c5" code="admin.translation.label.exploreReviewContent"/>
<spring:message var="autoMsg_1aecbe423d" code="admin.explore.reviewStatus.active"/>
<spring:message var="autoMsg_e082f0fa67" code="admin.explore.reviewStatus.blocked"/>
<spring:message var="autoMsg_b5a9f49b1d" code="admin.explore.reviews.action.block"/>
<spring:message var="autoMsg_283f8e5f80" code="admin.explore.detail.reviewEmpty"/>
<spring:message var="autoMsg_b59b3e044b" code="admin.explore.detail.maxTagLimit" javaScriptEscape="true"/>
<spring:message var="autoMsg_ffa4ec0631" code="admin.explore.detail.confirmDelete" javaScriptEscape="true"/>
<spring:message var="autoMsg_5f341efd04" code="admin.explore.detail.confirmBlockReview" javaScriptEscape="true"/>
<spring:message var="autoMsg_b07e4e35ed" code="admin.explore.detail.error.requestFailed" javaScriptEscape="true"/>
<c:set var="activeMenu" value="explore"/>
<spring:message code="admin.explore.detail.pageTitle" var="adminExploreDetailPageTitle"/>
<c:set var="pageTitle" value="${adminExploreDetailPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <a class="adm-back-link" href="${pageContext.request.contextPath}/admin/explore">
        <spring:message code="admin.explore.detail.backToList"/>
    </a>

    <div class="adm-card" style="margin-top:16px;margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title">${autoMsg_a9d09227da}</div>
            <div style="display:flex;gap:8px;flex-wrap:wrap;">
                <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/detail/${spot.spotIdx}" target="_blank">${autoMsg_b610ffdbe0}</a>
                <button type="button" class="adm-btn" onclick="toggleEditForm()">${autoMsg_51644af0e8}</button>
                <c:if test="${spot.displayStatus != 'DELETED'}">
                    <button class="adm-btn adm-btn-ghost" type="button" data-id="${spot.spotIdx}" onclick="deleteSpot(this)">${autoMsg_47b3230804}</button>
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
                        <div class="adm-summary-label">${autoMsg_530fc5c5ca}</div>
                        <div class="adm-field-value" style="font-size:22px;font-weight:700;">${fn:escapeXml(spot.name)}</div>
                    </div>
                    <span class="status-badge ${spot.displayStatus}">
                        <c:choose>
                            <c:when test="${spot.displayStatus == 'ACTIVE'}">${autoMsg_7e05c6c918}</c:when>
                            <c:otherwise>${autoMsg_d595950855}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="adm-summary-grid" style="grid-template-columns:repeat(2, minmax(0, 1fr));margin-bottom:0;">
                    <div class="adm-card" style="padding:14px;">
                        <div class="adm-summary-label">${autoMsg_04ed1013f0}</div>
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
                        <div class="adm-summary-label">${autoMsg_69effa60c4}</div>
                        <div class="adm-field-value" style="font-size:14px;margin-top:4px;">${fn:escapeXml(spot.region)}</div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div class="adm-summary-label">${autoMsg_cf27446b88}</div>
                        <div class="adm-field-value-sub" style="font-size:13px;margin-top:4px;">${fn:escapeXml(spot.spotId)}</div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div class="adm-summary-label">${autoMsg_4db6f420b1}</div>
                        <div class="adm-field-value" style="font-size:14px;margin-top:4px;"><fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/> / ${autoMsg_c3253063b4}</div>
                    </div>
                    <div class="adm-card" style="padding:14px;">
                        <div class="adm-summary-label">${autoMsg_56051ef3d3}</div>
                        <div class="adm-field-value" style="font-size:14px;margin-top:4px;">${autoMsg_369443d3af}</div>
                    </div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div class="adm-summary-label">${autoMsg_5e9a6c81cc}</div>
                    <div class="adm-field-value" style="font-size:14px;margin-top:4px;">${fn:escapeXml(spot.address)}</div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div class="adm-summary-label">${autoMsg_01f0b89421}</div>
                    <div class="adm-field-value-sub" style="font-size:13px;margin-top:4px;">${autoMsg_fc8ec330d4}</div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div class="adm-summary-label">${autoMsg_2837805ed3}</div>
                    <div class="adm-field-value" style="font-size:14px;margin-top:4px;line-height:1.7;">${fn:escapeXml(spot.description)}</div>
                </div>
                <div class="adm-card" style="padding:14px;">
                    <div class="adm-summary-label" style="margin-bottom:8px;">${autoMsg_cdf7e4747c}</div>
                    <div style="display:flex;gap:8px;flex-wrap:wrap;">
                        <c:forEach items="${tags}" var="tag">
                            <span class="adm-nav-badge adm-tag-badge">${fn:escapeXml(tag)}</span>
                        </c:forEach>
                        <c:if test="${empty tags}">
                            <span class="adm-muted-inline">${autoMsg_c6d7a7d557}</span>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-head">
            <div class="adm-card-title">${autoMsg_4908919cd5}</div>
            <div class="adm-muted-inline">${autoMsg_ef7f6abb46}</div>
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
                        <label for="spotName" class="adm-filter-label">${autoMsg_530fc5c5ca}</label>
                        <input type="text" id="spotName" name="name" maxlength="100" value="${fn:escapeXml(adminEditForm.name)}" required class="adm-input">
                    </div>
                    <div>
                        <label for="spotRegion" class="adm-filter-label">${autoMsg_69effa60c4}</label>
                        <input type="text" id="spotRegion" name="region" maxlength="100" value="${fn:escapeXml(adminEditForm.region)}" required class="adm-input">
                    </div>
                    <div style="grid-column:1 / -1;">
                        <label for="spotAddress" class="adm-filter-label">${autoMsg_5e9a6c81cc}</label>
                        <input type="text" id="spotAddress" name="address" maxlength="255" value="${fn:escapeXml(adminEditForm.address)}" required class="adm-input">
                    </div>
                    <div>
                        <label for="spotLatitude" class="adm-filter-label">${autoMsg_a6273fdc3f}</label>
                        <input type="number" id="spotLatitude" name="latitude" step="0.000001" value="${adminEditForm.latitude}" required class="adm-input">
                    </div>
                    <div>
                        <label for="spotLongitude" class="adm-filter-label">${autoMsg_3c9c2ce54c}</label>
                        <input type="number" id="spotLongitude" name="longitude" step="0.000001" value="${adminEditForm.longitude}" required class="adm-input">
                    </div>
                    <div style="grid-column:1 / -1;">
                        <label for="spotDescription" class="adm-filter-label">${autoMsg_2837805ed3}</label>
                        <textarea id="spotDescription" name="description" maxlength="2000" required class="adm-input" style="min-height:140px;resize:vertical;">${fn:escapeXml(adminEditForm.description)}</textarea>
                    </div>
                    <div style="grid-column:1 / -1;">
                        <label for="spotImage" class="adm-filter-label">${autoMsg_5dbe059256}</label>
                        <input type="file" id="spotImage" name="image" accept=".jpg,.jpeg,.png,.gif,.webp" class="adm-input">
                        <div class="adm-muted-note">${autoMsg_d3115daddb}</div>
                    </div>
                    <div style="grid-column:1 / -1;">
                        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:8px;">
                            <label class="adm-filter-label">${autoMsg_9ac9ec2015}</label>
                            <span class="adm-muted-inline">${autoMsg_1d79d0625d}</span>
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
                    <button type="button" class="adm-btn adm-btn-ghost" onclick="closeEditForm()">${autoMsg_650e649503}</button>
                    <button type="submit" class="adm-btn">${autoMsg_d4d8661c17}</button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${autoMsg_ea34de0329}</div>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/explore/reviews?searchType=name&keyword=${spot.name}">${autoMsg_4c421ea73d}</a>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th style="width:70px;">${autoMsg_0d53b4d07d}</th>
                    <th style="width:120px;">${autoMsg_fcf945e4d5}</th>
                    <th style="width:90px;">${autoMsg_cd0e284486}</th>
                    <th>${autoMsg_20e9878f81}</th>
                    <th style="width:90px;">${autoMsg_9f710e94da}</th>
                    <th style="width:110px;">${autoMsg_b0e4e13e56}</th>
                    <th style="width:90px;">${autoMsg_994d922bcf}</th>
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
                                     data-label="${autoMsg_6097ab20c5}"
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
                                    <c:when test="${review.displayStatus == 'ACTIVE'}">${autoMsg_1aecbe423d}</c:when>
                                    <c:otherwise>${autoMsg_e082f0fa67}</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td class="adm-muted-inline"><fmt:formatDate value="${review.createdAtDate}" type="date" dateStyle="short"/></td>
                        <td>
                            <c:if test="${review.displayStatus != 'BLOCKED'}">
                                <button class="adm-btn adm-btn-ghost" type="button" style="font-size:11px;padding:3px 8px;" data-id="${review.reviewIdx}" onclick="blockReview(this)">${autoMsg_b5a9f49b1d}</button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty reviews}">
                    <tr>
                        <td colspan="7" style="text-align:center;padding:40px;color:#475569;">${autoMsg_283f8e5f80}</td>
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
    maxTagLimit: '${autoMsg_b59b3e044b}',
    confirmDelete: '${autoMsg_ffa4ec0631}',
    confirmBlockReview: '${autoMsg_5f341efd04}',
    requestFailed: '${autoMsg_b07e4e35ed}'
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
