<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_package_manage_submitConfirm" code="package.manage.submitConfirm"/>
<spring:message var="msg_package_manage_eyebrow" code="package.manage.eyebrow"/>
<spring:message var="msg_package_manage_title" code="package.manage.title"/>
<spring:message var="msg_package_manage_desc" code="package.manage.desc"/>
<spring:message var="msg_package_manage_newPackage" code="package.manage.newPackage"/>
<spring:message var="msg_package_manage_productsEyebrow" code="package.manage.productsEyebrow"/>
<spring:message var="msg_package_manage_myProducts" code="package.manage.myProducts"/>
<spring:message var="msg_package_manage_editNotice" code="package.manage.editNotice"/>
<spring:message var="msg_package_manage_empty" code="package.manage.empty"/>
<spring:message var="msg_package_manage_emptyDesc" code="package.manage.emptyDesc"/>
<spring:message var="msg_package_manage_createLink" code="package.manage.createLink"/>
<spring:message var="msg_package_status_expired" code="package.status.expired"/>
<spring:message var="msg_package_status_approved" code="package.status.approved"/>
<spring:message var="msg_package_status_pending" code="package.status.pending"/>
<spring:message var="msg_package_status_rejected" code="package.status.rejected"/>
<spring:message var="msg_package_status_draft" code="package.status.draft"/>
<spring:message var="msg_package_status_blocked" code="package.status.blocked"/>
<spring:message var="msg_package_manage_noSummary" code="package.manage.noSummary"/>
<spring:message var="msg_package_common_priceLabel" code="package.common.priceLabel"/>
<spring:message var="msg_package_common_operationDate" code="package.common.operationDate"/>
<spring:message var="msg_package_common_always" code="package.common.always"/>
<spring:message var="msg_package_common_peopleLabel" code="package.common.peopleLabel"/>
<spring:message var="msg_package_common_maxPeople" code="package.common.maxPeople"/>
<spring:message var="msg_package_manage_rejectReasonLabel" code="package.manage.rejectReasonLabel"/>
<spring:message var="msg_package_manage_edit" code="package.manage.edit"/>
<spring:message var="msg_package_manage_submitRequest" code="package.manage.submitRequest"/>
<spring:message var="msg_package_manage_pendingReview" code="package.manage.pendingReview"/>
<spring:message var="msg_package_manage_expiredHidden" code="package.manage.expiredHidden"/>
<spring:message var="msg_package_manage_approvedVisible" code="package.manage.approvedVisible"/>
<spring:message var="msg_package_revision_pending" code="package.revision.pending"/>
<spring:message var="msg_package_revision_request" code="package.revision.request"/>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<c:set var="pageCSS" value="packages/packages.css"/>

<%@ include file="../common/header.jsp" %>
<body>

<main class="pkg-wrap">
    <section class="pkg-hero">
        <div>
            <p class="pkg-eyebrow">${msg_package_manage_eyebrow}</p>
            <h1>${msg_package_manage_title}</h1>
            <p>${msg_package_manage_desc}</p>
        </div>
        <a class="pkg-primary-link" href="${pageContext.request.contextPath}/packages/manage/write">
            ${msg_package_manage_newPackage}
        </a>
    </section>

    <section class="pkg-panel">
        <c:if test="${not empty packageMessage}">
            <div class="pkg-alert pkg-alert--success">${fn:escapeXml(packageMessage)}</div>
        </c:if>
        <c:if test="${not empty packageError}">
            <div class="pkg-alert pkg-alert--error">${fn:escapeXml(packageError)}</div>
        </c:if>

        <div class="pkg-section-title">
            <div>
                <span>${msg_package_manage_productsEyebrow}</span>
                <h2>${msg_package_manage_myProducts}</h2>
            </div>
            <p>${msg_package_manage_editNotice}</p>
        </div>

        <c:choose>
            <c:when test="${empty packageList}">
                <div class="pkg-empty">
                    <strong>${msg_package_manage_empty}</strong>
                    <p>${msg_package_manage_emptyDesc}</p>
                    <a href="${pageContext.request.contextPath}/packages/manage/write">
                        ${msg_package_manage_createLink}
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="pkg-card-grid">
                    <c:forEach var="pkg" items="${packageList}">
                        <article class="pkg-card">
                            <div class="pkg-card__top">
                                <c:set var="displayStatusClass" value="${pkg.packageStatus}"/>
                                <c:if test="${pkg.packageStatus eq 'APPROVED' and pkg.expired}">
                                    <c:set var="displayStatusClass" value="EXPIRED"/>
                                </c:if>
                                <span class="pkg-status pkg-status--${displayStatusClass}">
                                    <c:choose>
                                        <c:when test="${displayStatusClass eq 'EXPIRED'}">${msg_package_status_expired}</c:when>
                                        <c:when test="${displayStatusClass eq 'APPROVED'}">${msg_package_status_approved}</c:when>
                                        <c:when test="${displayStatusClass eq 'PENDING'}">${msg_package_status_pending}</c:when>
                                        <c:when test="${displayStatusClass eq 'REJECTED'}">${msg_package_status_rejected}</c:when>
                                        <c:when test="${displayStatusClass eq 'DRAFT'}">${msg_package_status_draft}</c:when>
                                        <c:when test="${displayStatusClass eq 'BLOCKED'}">${msg_package_status_blocked}</c:when>
                                        <c:otherwise>${fn:escapeXml(pkg.packageStatus)}</c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="pkg-date">${pkg.createdAt}</span>
                            </div>

                            <div class="pkg-thumb">
                                <c:choose>
                                    <c:when test="${not empty pkg.mainImagePath}">
                                        <img src="${fn:escapeXml(pkg.mainImagePath)}" alt="${fn:escapeXml(pkg.packageTitle)}">
                                    </c:when>
                                    <c:otherwise>
                                        <span>TripTogether</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="pkg-card__body">
                                <p class="pkg-spot">${fn:escapeXml(pkg.spotRegion)} · ${fn:escapeXml(pkg.spotName)}</p>
                                <h3>${fn:escapeXml(pkg.packageTitle)}</h3>
                                <p class="pkg-summary">
                                    <c:choose>
                                        <c:when test="${not empty pkg.packageSummary}">${fn:escapeXml(pkg.packageSummary)}</c:when>
                                        <c:otherwise>${msg_package_manage_noSummary}</c:otherwise>
                                    </c:choose>
                                </p>

                                <dl class="pkg-meta">
                                    <div>
                                        <dt>${msg_package_common_priceLabel}</dt>
                                        <dd><fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(pkg.currencyCode)}</dd>
                                    </div>
                                    <div>
                                        <dt>${msg_package_common_operationDate}</dt>
                                        <dd>
                                            <c:choose>
                                                <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">
                                                    ${pkg.startDate} ~ ${pkg.endDate}
                                                </c:when>
                                                <c:otherwise>${msg_package_common_always}</c:otherwise>
                                            </c:choose>
                                        </dd>
                                    </div>
                                    <div>
                                        <dt>${msg_package_common_peopleLabel}</dt>
                                        <dd>
                                            <spring:message var="msg_package_common_minPeople_args_pkg_minPeople" code="package.common.minPeople" arguments="${pkg.minPeople}"/>${msg_package_common_minPeople_args_pkg_minPeople}
                                            <c:if test="${not empty pkg.maxPeople}">
                                                / ${msg_package_common_maxPeople}
                                            </c:if>
                                        </dd>
                                    </div>
                                </dl>

                                <c:if test="${pkg.packageStatus eq 'REJECTED' and not empty pkg.rejectReason}">
                                    <div class="pkg-reject">
                                        <strong>${msg_package_manage_rejectReasonLabel}</strong>
                                        <p>${fn:escapeXml(pkg.rejectReason)}</p>
                                    </div>
                                </c:if>
                            </div>

                            <div class="pkg-card__actions">
                                <c:if test="${pkg.packageStatus eq 'DRAFT' or pkg.packageStatus eq 'REJECTED'}">
                                    <a href="${pageContext.request.contextPath}/packages/manage/${pkg.packageIdx}/edit">
                                        ${msg_package_manage_edit}
                                    </a>
                                    <form method="post" action="${pageContext.request.contextPath}/packages/manage/${pkg.packageIdx}/submit"
                                          data-confirm="${msg_package_manage_submitConfirm}">
                                        <button type="submit">${msg_package_manage_submitRequest}</button>
                                    </form>
                                </c:if>
                                <c:if test="${pkg.packageStatus eq 'PENDING'}">
                                    <span class="pkg-waiting">${msg_package_manage_pendingReview}</span>
                                </c:if>
                                <c:if test="${pkg.packageStatus eq 'APPROVED'}">
                                    <c:choose>
                                        <c:when test="${pkg.expired}">
                                            <span class="pkg-expired">${msg_package_manage_expiredHidden}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="pkg-approved">${msg_package_manage_approvedVisible}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${pkg.revisionPending}">
                                            <span class="pkg-waiting">${msg_package_revision_pending}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/packages/manage/${pkg.packageIdx}/edit">
                                                ${msg_package_revision_request}
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </section>
</main>

<%@ include file="../common/footer.jsp" %>

<script>
document.querySelectorAll('form[data-confirm]').forEach(function (form) {
    form.addEventListener('submit', function (event) {
        if (!window.confirm(form.dataset.confirm)) {
            event.preventDefault();
        }
    });
});
</script>

</body>
</html>
