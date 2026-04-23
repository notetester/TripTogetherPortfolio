<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<c:set var="pageCSS" value="packages/packages.css"/>
<spring:message code="package.manage.submitConfirm" var="packageSubmitConfirm"/>
<%@ include file="../common/header.jsp" %>
<body>

<main class="pkg-wrap">
    <section class="pkg-hero">
        <div>
            <p class="pkg-eyebrow"><spring:message code="package.manage.eyebrow"/></p>
            <h1><spring:message code="package.manage.title"/></h1>
            <p><spring:message code="package.manage.desc"/></p>
        </div>
        <a class="pkg-primary-link" href="${pageContext.request.contextPath}/packages/manage/write">
            <spring:message code="package.manage.newPackage"/>
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
                <span><spring:message code="package.manage.productsEyebrow"/></span>
                <h2><spring:message code="package.manage.myProducts"/></h2>
            </div>
            <p><spring:message code="package.manage.editNotice"/></p>
        </div>

        <c:choose>
            <c:when test="${empty packageList}">
                <div class="pkg-empty">
                    <strong><spring:message code="package.manage.empty"/></strong>
                    <p><spring:message code="package.manage.emptyDesc"/></p>
                    <a href="${pageContext.request.contextPath}/packages/manage/write">
                        <spring:message code="package.manage.createLink"/>
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
                                        <c:when test="${displayStatusClass eq 'EXPIRED'}"><spring:message code="package.status.expired"/></c:when>
                                        <c:when test="${displayStatusClass eq 'APPROVED'}"><spring:message code="package.status.approved"/></c:when>
                                        <c:when test="${displayStatusClass eq 'PENDING'}"><spring:message code="package.status.pending"/></c:when>
                                        <c:when test="${displayStatusClass eq 'REJECTED'}"><spring:message code="package.status.rejected"/></c:when>
                                        <c:when test="${displayStatusClass eq 'DRAFT'}"><spring:message code="package.status.draft"/></c:when>
                                        <c:when test="${displayStatusClass eq 'BLOCKED'}"><spring:message code="package.status.blocked"/></c:when>
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
                                        <c:otherwise><spring:message code="package.manage.noSummary"/></c:otherwise>
                                    </c:choose>
                                </p>

                                <dl class="pkg-meta">
                                    <div>
                                        <dt><spring:message code="package.common.priceLabel"/></dt>
                                        <dd><fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(pkg.currencyCode)}</dd>
                                    </div>
                                    <div>
                                        <dt><spring:message code="package.common.operationDate"/></dt>
                                        <dd>
                                            <c:choose>
                                                <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">
                                                    ${pkg.startDate} ~ ${pkg.endDate}
                                                </c:when>
                                                <c:otherwise><spring:message code="package.common.always"/></c:otherwise>
                                            </c:choose>
                                        </dd>
                                    </div>
                                    <div>
                                        <dt><spring:message code="package.common.peopleLabel"/></dt>
                                        <dd>
                                            <spring:message code="package.common.minPeople" arguments="${pkg.minPeople}"/>
                                            <c:if test="${not empty pkg.maxPeople}">
                                                / <spring:message code="package.common.maxPeople" arguments="${pkg.maxPeople}"/>
                                            </c:if>
                                        </dd>
                                    </div>
                                </dl>

                                <c:if test="${pkg.packageStatus eq 'REJECTED' and not empty pkg.rejectReason}">
                                    <div class="pkg-reject">
                                        <strong><spring:message code="package.manage.rejectReasonLabel"/></strong>
                                        <p>${fn:escapeXml(pkg.rejectReason)}</p>
                                    </div>
                                </c:if>
                            </div>

                            <div class="pkg-card__actions">
                                <c:if test="${pkg.packageStatus eq 'DRAFT' or pkg.packageStatus eq 'REJECTED'}">
                                    <a href="${pageContext.request.contextPath}/packages/manage/${pkg.packageIdx}/edit">
                                        <spring:message code="package.manage.edit"/>
                                    </a>
                                    <form method="post" action="${pageContext.request.contextPath}/packages/manage/${pkg.packageIdx}/submit"
                                          data-confirm="${packageSubmitConfirm}">
                                        <button type="submit"><spring:message code="package.manage.submitRequest"/></button>
                                    </form>
                                </c:if>
                                <c:if test="${pkg.packageStatus eq 'PENDING'}">
                                    <span class="pkg-waiting"><spring:message code="package.manage.pendingReview"/></span>
                                </c:if>
                                <c:if test="${pkg.packageStatus eq 'APPROVED'}">
                                    <c:choose>
                                        <c:when test="${pkg.expired}">
                                            <span class="pkg-expired"><spring:message code="package.manage.expiredHidden"/></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="pkg-approved"><spring:message code="package.manage.approvedVisible"/></span>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${pkg.revisionPending}">
                                            <span class="pkg-waiting"><spring:message code="package.revision.pending"/></span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/packages/manage/${pkg.packageIdx}/edit">
                                                <spring:message code="package.revision.request"/>
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
