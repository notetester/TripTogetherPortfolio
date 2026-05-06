<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_9d708285de" code="package.manage.eyebrow"/>
<spring:message var="autoMsg_d23c63b50d" code="package.manage.title"/>
<spring:message var="autoMsg_e585f0e557" code="package.manage.desc"/>
<spring:message var="autoMsg_39adf077eb" code="package.manage.productsEyebrow"/>
<spring:message var="autoMsg_8f8eac8af5" code="package.manage.myProducts"/>
<spring:message var="autoMsg_ee8c5a44fa" code="package.manage.editNotice"/>
<spring:message var="autoMsg_5c953f1a59" code="package.manage.empty"/>
<spring:message var="autoMsg_edcfd685ac" code="package.manage.emptyDesc"/>
<spring:message var="autoMsg_165e6590da" code="package.status.expired"/>
<spring:message var="autoMsg_e1970540d9" code="package.status.approved"/>
<spring:message var="autoMsg_e52690a20a" code="package.status.pending"/>
<spring:message var="autoMsg_9fb3816ed7" code="package.status.rejected"/>
<spring:message var="autoMsg_f8427debd2" code="package.status.draft"/>
<spring:message var="autoMsg_2032aa9f6f" code="package.status.blocked"/>
<spring:message var="autoMsg_3393af786f" code="package.manage.noSummary"/>
<spring:message var="autoMsg_3d8d122c83" code="package.common.priceLabel"/>
<spring:message var="autoMsg_716c76c8ad" code="package.common.operationDate"/>
<spring:message var="autoMsg_a89496e116" code="package.common.always"/>
<spring:message var="autoMsg_0c422480d7" code="package.common.peopleLabel"/>
<spring:message var="autoMsg_f1121e1ede" code="package.common.maxPeople"/>
<spring:message var="autoMsg_8f9bd2c551" code="package.manage.rejectReasonLabel"/>
<spring:message var="autoMsg_39a3c893c9" code="package.manage.submitRequest"/>
<spring:message var="autoMsg_21f65c7f0e" code="package.manage.pendingReview"/>
<spring:message var="autoMsg_4cd242b13f" code="package.manage.expiredHidden"/>
<spring:message var="autoMsg_517d45a628" code="package.manage.approvedVisible"/>
<spring:message var="autoMsg_6199a6af61" code="package.revision.pending"/>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<c:set var="pageCSS" value="packages/packages.css"/>
<spring:message code="package.manage.submitConfirm" var="packageSubmitConfirm"/>
<%@ include file="../common/header.jsp" %>
<body>

<main class="pkg-wrap">
    <section class="pkg-hero">
        <div>
            <p class="pkg-eyebrow">${autoMsg_9d708285de}</p>
            <h1>${autoMsg_d23c63b50d}</h1>
            <p>${autoMsg_e585f0e557}</p>
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
                <span>${autoMsg_39adf077eb}</span>
                <h2>${autoMsg_8f8eac8af5}</h2>
            </div>
            <p>${autoMsg_ee8c5a44fa}</p>
        </div>

        <c:choose>
            <c:when test="${empty packageList}">
                <div class="pkg-empty">
                    <strong>${autoMsg_5c953f1a59}</strong>
                    <p>${autoMsg_edcfd685ac}</p>
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
                                        <c:when test="${displayStatusClass eq 'EXPIRED'}">${autoMsg_165e6590da}</c:when>
                                        <c:when test="${displayStatusClass eq 'APPROVED'}">${autoMsg_e1970540d9}</c:when>
                                        <c:when test="${displayStatusClass eq 'PENDING'}">${autoMsg_e52690a20a}</c:when>
                                        <c:when test="${displayStatusClass eq 'REJECTED'}">${autoMsg_9fb3816ed7}</c:when>
                                        <c:when test="${displayStatusClass eq 'DRAFT'}">${autoMsg_f8427debd2}</c:when>
                                        <c:when test="${displayStatusClass eq 'BLOCKED'}">${autoMsg_2032aa9f6f}</c:when>
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
                                        <c:otherwise>${autoMsg_3393af786f}</c:otherwise>
                                    </c:choose>
                                </p>

                                <dl class="pkg-meta">
                                    <div>
                                        <dt>${autoMsg_3d8d122c83}</dt>
                                        <dd><fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(pkg.currencyCode)}</dd>
                                    </div>
                                    <div>
                                        <dt>${autoMsg_716c76c8ad}</dt>
                                        <dd>
                                            <c:choose>
                                                <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">
                                                    ${pkg.startDate} ~ ${pkg.endDate}
                                                </c:when>
                                                <c:otherwise>${autoMsg_a89496e116}</c:otherwise>
                                            </c:choose>
                                        </dd>
                                    </div>
                                    <div>
                                        <dt>${autoMsg_0c422480d7}</dt>
                                        <dd>
                                            <spring:message code="package.common.minPeople" arguments="${pkg.minPeople}"/>
                                            <c:if test="${not empty pkg.maxPeople}">
                                                / ${autoMsg_f1121e1ede}
                                            </c:if>
                                        </dd>
                                    </div>
                                </dl>

                                <c:if test="${pkg.packageStatus eq 'REJECTED' and not empty pkg.rejectReason}">
                                    <div class="pkg-reject">
                                        <strong>${autoMsg_8f9bd2c551}</strong>
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
                                        <button type="submit">${autoMsg_39a3c893c9}</button>
                                    </form>
                                </c:if>
                                <c:if test="${pkg.packageStatus eq 'PENDING'}">
                                    <span class="pkg-waiting">${autoMsg_21f65c7f0e}</span>
                                </c:if>
                                <c:if test="${pkg.packageStatus eq 'APPROVED'}">
                                    <c:choose>
                                        <c:when test="${pkg.expired}">
                                            <span class="pkg-expired">${autoMsg_4cd242b13f}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="pkg-approved">${autoMsg_517d45a628}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${pkg.revisionPending}">
                                            <span class="pkg-waiting">${autoMsg_6199a6af61}</span>
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
