<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_packages_confirmApprove_js" code="admin.packages.confirmApprove" javaScriptEscape="true"/>
<spring:message var="msg_admin_packages_rejectReasonPlaceholder" code="admin.packages.rejectReasonPlaceholder"/>
<spring:message var="msg_package_admin_title" code="package.admin.title"/>
<spring:message var="msg_package_revision_rejectReason" code="package.revision.rejectReason"/>
<spring:message var="msg_package_admin_approveConfirm" code="package.admin.approveConfirm"/>
<spring:message var="msg_package_admin_rejectPlaceholder" code="package.admin.rejectPlaceholder"/>
<spring:message var="msg_package_admin_desc" code="package.admin.desc"/>
<spring:message var="msg_package_admin_filterStatus" code="package.admin.filterStatus"/>
<spring:message var="msg_package_admin_filterAll" code="package.admin.filterAll"/>
<spring:message var="msg_package_status_pending" code="package.status.pending"/>
<spring:message var="msg_package_status_approved" code="package.status.approved"/>
<spring:message var="msg_package_status_rejected" code="package.status.rejected"/>
<spring:message var="msg_package_status_draft" code="package.status.draft"/>
<spring:message var="msg_package_status_blocked" code="package.status.blocked"/>
<spring:message var="msg_package_admin_search" code="package.admin.search"/>
<spring:message var="msg_package_admin_reset" code="package.admin.reset"/>
<spring:message var="msg_package_revision_adminTitle" code="package.revision.adminTitle"/>
<spring:message var="msg_package_revision_adminDesc" code="package.revision.adminDesc"/>
<spring:message var="msg_package_revision_empty" code="package.revision.empty"/>
<spring:message var="msg_package_revision_beforeAfter" code="package.revision.beforeAfter"/>
<spring:message var="msg_package_revision_sellerSpot" code="package.revision.sellerSpot"/>
<spring:message var="msg_package_revision_pricePeriod" code="package.revision.pricePeriod"/>
<spring:message var="msg_package_revision_requestedAt" code="package.revision.requestedAt"/>
<spring:message var="msg_package_revision_review" code="package.revision.review"/>
<spring:message var="msg_package_revision_current" code="package.revision.current"/>
<spring:message var="msg_package_revision_requested" code="package.revision.requested"/>
<spring:message var="msg_package_common_always" code="package.common.always"/>
<spring:message var="msg_package_common_maxPeople" code="package.common.maxPeople"/>
<spring:message var="msg_package_revision_approve" code="package.revision.approve"/>
<spring:message var="msg_package_revision_reject" code="package.revision.reject"/>
<spring:message var="msg_package_admin_thPackage" code="package.admin.thPackage"/>
<spring:message var="msg_package_admin_thSeller" code="package.admin.thSeller"/>
<spring:message var="msg_package_admin_thSpot" code="package.admin.thSpot"/>
<spring:message var="msg_package_admin_thPriceSchedule" code="package.admin.thPriceSchedule"/>
<spring:message var="msg_package_admin_thStatus" code="package.admin.thStatus"/>
<spring:message var="msg_package_admin_thReview" code="package.admin.thReview"/>
<spring:message var="msg_package_admin_noImage" code="package.admin.noImage"/>
<spring:message var="msg_package_admin_registeredAt" code="package.admin.registeredAt"/>
<spring:message var="msg_package_status_expired" code="package.status.expired"/>
<spring:message var="msg_package_manage_expiredHidden" code="package.manage.expiredHidden"/>
<spring:message var="msg_package_admin_approve" code="package.admin.approve"/>
<spring:message var="msg_package_admin_reject" code="package.admin.reject"/>
<spring:message var="msg_package_admin_notPending" code="package.admin.notPending"/>
<spring:message var="msg_package_admin_noResults" code="package.admin.noResults"/>
<c:set var="activeMenu" value="packages"/>


<c:set var="pageTitle"  value="${msg_package_admin_title}"/>


<%@ include file="../layout.jsp" %>

<div class="adm-content adm-package-page">
    <div class="adm-page-head">
        <div>
            <h1>${msg_package_admin_title}</h1>
            <p>${msg_package_admin_desc}</p>
        </div>
    </div>

    <c:if test="${not empty packageReviewMessage}">
        <div class="adm-alert adm-alert-success">${fn:escapeXml(packageReviewMessage)}</div>
    </c:if>
    <c:if test="${not empty packageReviewError}">
        <div class="adm-alert adm-alert-danger">${fn:escapeXml(packageReviewError)}</div>
    </c:if>

    <div class="adm-card adm-package-filter-card">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/packages">
                <div class="adm-filter-bar adm-package-filterbar">
                    <div>
                        <div class="adm-filter-label">${msg_package_admin_filterStatus}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${status eq 'ALL' ? 'selected' : ''}>${msg_package_admin_filterAll}</option>
                            <option value="PENDING" ${status eq 'PENDING' ? 'selected' : ''}>${msg_package_status_pending}</option>
                            <option value="APPROVED" ${status eq 'APPROVED' ? 'selected' : ''}>${msg_package_status_approved}</option>
                            <option value="REJECTED" ${status eq 'REJECTED' ? 'selected' : ''}>${msg_package_status_rejected}</option>
                            <option value="DRAFT" ${status eq 'DRAFT' ? 'selected' : ''}>${msg_package_status_draft}</option>
                            <option value="BLOCKED" ${status eq 'BLOCKED' ? 'selected' : ''}>${msg_package_status_blocked}</option>
                        </select>
                    </div>
                    <div class="adm-package-filter-actions">
                        <button type="submit" class="adm-btn adm-btn-primary">${msg_package_admin_search}</button>
                        <a href="${pageContext.request.contextPath}/admin/packages"
                           class="adm-btn adm-btn-ghost">${msg_package_admin_reset}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card adm-package-section-card">
        <div class="adm-card-body">
            <div class="adm-package-section-head">
                <div>
                    <h2 class="adm-package-section-title">${msg_package_revision_adminTitle}</h2>
                    <p class="adm-package-section-desc">${msg_package_revision_adminDesc}</p>
                </div>
                <span class="status-badge PENDING">${msg_package_status_pending}</span>
            </div>

            <c:choose>
                <c:when test="${empty revisionList}">
                    <div class="adm-package-empty-box">
                        ${msg_package_revision_empty}
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="adm-table-wrap">
                        <table class="adm-table adm-package-table adm-package-revision-table">
                            <colgroup>
                                <col>
                                <col class="adm-package-col-seller">
                                <col class="adm-package-col-price">
                                <col class="adm-package-col-date">
                                <col class="adm-package-col-action">
                            </colgroup>
                            <thead>
                            <tr>
                                <th>${msg_package_revision_beforeAfter}</th>
                                <th>${msg_package_revision_sellerSpot}</th>
                                <th>${msg_package_revision_pricePeriod}</th>
                                <th>${msg_package_revision_requestedAt}</th>
                                <th>${msg_package_revision_review}</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="revision" items="${revisionList}">
                                <tr>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link"
                                                onclick="focusPackageReviewAction('revision-${revision.packageRevisionIdx}')">
                                            <span class="adm-package-muted-line">${msg_package_revision_current}</span>
                                            <span class="adm-package-strong-line">${fn:escapeXml(revision.currentPackageTitle)}</span>
                                            <span class="adm-package-requested-line">${msg_package_revision_requested}</span>
                                            <span class="adm-package-strong-line">${fn:escapeXml(revision.packageTitle)}</span>
                                            <c:if test="${not empty revision.packageSummary}">
                                                <span class="adm-package-summary-line">
                                                    ${fn:escapeXml(revision.packageSummary)}
                                                </span>
                                            </c:if>
                                        </button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link js-open-member-context"
                                                data-user-idx="${revision.sellerUserIdx}"
                                                data-default-tab="profile">
                                            <span class="mem-name">${fn:escapeXml(revision.sellerNickname)}</span>
                                            <span class="mem-uid">user_idx ${revision.sellerUserIdx}</span>
                                            <span class="adm-package-meta-line is-spaced">
                                                ${fn:escapeXml(revision.spotRegion)} · ${fn:escapeXml(revision.spotName)}
                                            </span>
                                        </button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link"
                                                onclick="focusPackageReviewAction('revision-${revision.packageRevisionIdx}')">
                                            <span class="adm-package-strong-line">
                                                <fmt:formatNumber value="${revision.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(revision.currencyCode)}
                                            </span>
                                            <span class="adm-package-meta-line">
                                                <c:choose>
                                                    <c:when test="${not empty revision.startDate or not empty revision.endDate}">
                                                        ${revision.startDate} ~ ${revision.endDate}
                                                    </c:when>
                                                    <c:otherwise>${msg_package_common_always}</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <span class="adm-package-meta-line">
                                                <spring:message var="msg_package_common_minPeople_args_revision_minPeople" code="package.common.minPeople" arguments="${revision.minPeople}"/>${msg_package_common_minPeople_args_revision_minPeople}
                                                <c:if test="${not empty revision.maxPeople}">
                                                    / ${msg_package_common_maxPeople}
                                                </c:if>
                                            </span>
                                        </button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                onclick="focusPackageReviewAction('revision-${revision.packageRevisionIdx}')">
                                            ${revision.requestedAt}
                                        </button>
                                    </td>
                                    <td>
                                        <div class="adm-row-actions" id="package-action-revision-${revision.packageRevisionIdx}">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/packages/revisions/${revision.packageRevisionIdx}/approve">
                                                <button type="submit" class="adm-row-btn detail">
                                                    ${msg_package_revision_approve}
                                                </button>
                                            </form>
                                            <div class="action-menu-wrap">
                                                <button type="button"
                                                        class="adm-row-btn detail adm-row-btn-more"
                                                        onclick="admToggleActionMenu(this)">⋯</button>
                                                <div class="action-menu action-menu-wide">
                                                    <form class="action-menu-form"
                                                          method="post"
                                                          action="${pageContext.request.contextPath}/admin/packages/revisions/${revision.packageRevisionIdx}/reject">
                                                        <label class="action-menu-head" for="revision-reject-${revision.packageRevisionIdx}">
                                                            ${msg_package_revision_reject}
                                                        </label>
                                                        <input id="revision-reject-${revision.packageRevisionIdx}"
                                                               class="adm-input"
                                                               name="rejectReason"
                                                               maxlength="500"
                                                               placeholder="${msg_package_revision_rejectReason}"
                                                               required>
                                                        <button type="submit" class="action-menu-item danger">
                                                            ${msg_package_revision_reject}
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="adm-card adm-package-list-card">
        <div class="adm-table-wrap">
            <table class="adm-table adm-package-table adm-package-main-table">
                <colgroup>
                    <col>
                    <col class="adm-package-col-seller">
                    <col class="adm-package-col-spot">
                    <col class="adm-package-col-price">
                    <col class="adm-package-col-status">
                    <col class="adm-package-col-action">
                </colgroup>
                <thead>
                <tr>
                    <th>${msg_package_admin_thPackage}</th>
                    <th>${msg_package_admin_thSeller}</th>
                    <th>${msg_package_admin_thSpot}</th>
                    <th>${msg_package_admin_thPriceSchedule}</th>
                    <th>${msg_package_admin_thStatus}</th>
                    <th>${msg_package_admin_thReview}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="pkg" items="${packageList}">
                    <tr>
                        <td>
                            <div class="adm-package-main-cell">
                                <div class="adm-package-thumb">
                                    <c:choose>
                                        <c:when test="${not empty pkg.mainImagePath}">
                                            <img src="${fn:escapeXml(pkg.mainImagePath)}"
                                                 alt="${fn:escapeXml(pkg.packageTitle)}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="adm-package-thumb-empty">${msg_package_admin_noImage}</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <button type="button"
                                            class="adm-cell-link adm-cell-link--inline"
                                            onclick="focusPackageReviewAction('package-${pkg.packageIdx}')">
                                        <span class="adm-package-strong-line">${fn:escapeXml(pkg.packageTitle)}</span>
                                    </button>
                                    <c:if test="${not empty pkg.packageSummary}">
                                        <div class="adm-package-summary-line">
                                            ${fn:escapeXml(pkg.packageSummary)}
                                        </div>
                                    </c:if>
                                    <div class="adm-package-registered-line">${msg_package_admin_registeredAt}</div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-open-member-context"
                                    data-user-idx="${pkg.sellerUserIdx}"
                                    data-default-tab="profile">
                                <span class="mem-name">${fn:escapeXml(pkg.sellerNickname)}</span>
                                <span class="mem-uid">user_idx ${pkg.sellerUserIdx}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link"
                                    onclick="focusPackageReviewAction('package-${pkg.packageIdx}')">
                                <span class="adm-package-spot-name">${fn:escapeXml(pkg.spotName)}</span>
                                <span class="adm-package-meta-line">${fn:escapeXml(pkg.spotRegion)}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link"
                                    onclick="focusPackageReviewAction('package-${pkg.packageIdx}')">
                                <span class="adm-package-strong-line">
                                    <fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(pkg.currencyCode)}
                                </span>
                                <span class="adm-package-meta-line">
                                    <c:choose>
                                        <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">
                                            ${pkg.startDate} ~ ${pkg.endDate}
                                        </c:when>
                                        <c:otherwise>${msg_package_common_always}</c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-package-meta-line">
                                    <spring:message var="msg_package_common_minPeople_args_pkg_minPeople" code="package.common.minPeople" arguments="${pkg.minPeople}"/>${msg_package_common_minPeople_args_pkg_minPeople}
                                    <c:if test="${not empty pkg.maxPeople}"> / ${msg_package_common_maxPeople}</c:if>
                                </span>
                            </button>
                        </td>
                        <td>
                            <c:set var="displayStatusClass" value="${pkg.packageStatus}"/>
                            <c:if test="${pkg.packageStatus eq 'APPROVED' and pkg.expired}">
                                <c:set var="displayStatusClass" value="EXPIRED"/>
                            </c:if>
                            <button type="button"
                                    class="adm-cell-link adm-cell-link--inline"
                                    onclick="focusPackageReviewAction('package-${pkg.packageIdx}')">
                                <span class="status-badge ${displayStatusClass}">
                                    <c:choose>
                                        <c:when test="${displayStatusClass eq 'EXPIRED'}">${msg_package_status_expired}</c:when>
                                        <c:when test="${displayStatusClass eq 'PENDING'}">${msg_package_status_pending}</c:when>
                                        <c:when test="${displayStatusClass eq 'APPROVED'}">${msg_package_status_approved}</c:when>
                                        <c:when test="${displayStatusClass eq 'REJECTED'}">${msg_package_status_rejected}</c:when>
                                        <c:when test="${displayStatusClass eq 'DRAFT'}">${msg_package_status_draft}</c:when>
                                        <c:when test="${displayStatusClass eq 'BLOCKED'}">${msg_package_status_blocked}</c:when>
                                        <c:otherwise>${fn:escapeXml(pkg.packageStatus)}</c:otherwise>
                                    </c:choose>
                                </span>
                            </button>
                            <c:if test="${pkg.packageStatus eq 'APPROVED' and pkg.expired}">
                                <div class="adm-package-status-note is-warning">
                                    ${msg_package_manage_expiredHidden}
                                </div>
                            </c:if>
                            <c:if test="${not empty pkg.rejectReason}">
                                <div class="adm-package-status-note is-danger">
                                    ${fn:escapeXml(pkg.rejectReason)}
                                </div>
                            </c:if>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${pkg.packageStatus eq 'PENDING'}">
                                    <div class="adm-row-actions" id="package-action-package-${pkg.packageIdx}">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/packages/${pkg.packageIdx}/approve">
                                                <button type="submit" class="adm-row-btn detail"
                                                    onclick="return confirm('${msg_admin_packages_confirmApprove_js}');">${msg_package_admin_approve}</button>
                                            </form>
                                        <div class="action-menu-wrap">
                                            <button type="button"
                                                    class="adm-row-btn detail adm-row-btn-more"
                                                    onclick="admToggleActionMenu(this)">⋯</button>
                                            <div class="action-menu action-menu-wide">
                                                <form class="action-menu-form"
                                                      method="post"
                                                      action="${pageContext.request.contextPath}/admin/packages/${pkg.packageIdx}/reject">
                                                    <label class="action-menu-head" for="package-reject-${pkg.packageIdx}">
                                                        ${msg_package_admin_reject}
                                                    </label>
                                                    <input id="package-reject-${pkg.packageIdx}"
                                                           class="adm-input"
                                                           name="rejectReason"
                                                           maxlength="500"
                                                           placeholder="${msg_admin_packages_rejectReasonPlaceholder}"
                                                           required>
                                                    <button type="submit" class="action-menu-item danger">
                                                        ${msg_package_admin_reject}
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <span class="adm-package-not-pending">${msg_package_admin_notPending}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty packageList}">
                    <tr class="adm-local-empty">
                        <td colspan="6" class="adm-local-empty-cell">
                            ${msg_package_admin_noResults}
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
function focusPackageReviewAction(key) {
    var target = document.getElementById('package-action-' + key);
    if (!target) return;
    target.scrollIntoView({ behavior: 'smooth', block: 'center' });
    target.classList.remove('is-focus-flash');
    void target.offsetWidth;
    target.classList.add('is-focus-flash');
    setTimeout(function () {
        target.classList.remove('is-focus-flash');
    }, 1300);
}
</script>

<%@ include file="../layout-close.jsp" %>
