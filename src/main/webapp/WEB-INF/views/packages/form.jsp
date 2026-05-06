<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="packages/packages.css"/>
<spring:message code="package.form.spotPlaceholder" var="packageSpotPlaceholder"/>
<spring:message code="package.form.titlePlaceholder" var="packageTitlePlaceholder"/>
<spring:message code="package.form.summaryPlaceholder" var="packageSummaryPlaceholder"/>
<spring:message code="package.form.contentPlaceholder" var="packageContentPlaceholder"/>
<spring:message code="package.form.currentImage" var="packageCurrentImageLabel"/>
<%@ include file="../common/header.jsp" %>
<body>

<main class="pkg-wrap">
    <section class="pkg-hero pkg-hero--form">
        <div>
            <p class="pkg-eyebrow"><spring:message code="package.form.eyebrow"/></p>
            <h1>
                <c:choose>
                    <c:when test="${formMode eq 'REVISION'}"><spring:message code="package.form.revisionTitle"/></c:when>
                    <c:when test="${formMode eq 'EDIT'}"><spring:message code="package.form.editTitle"/></c:when>
                    <c:otherwise><spring:message code="package.form.createTitle"/></c:otherwise>
                </c:choose>
            </h1>
            <p>
                <c:choose>
                    <c:when test="${formMode eq 'REVISION'}"><spring:message code="package.form.revisionDesc"/></c:when>
                    <c:otherwise><spring:message code="package.form.defaultDesc"/></c:otherwise>
                </c:choose>
            </p>
        </div>
        <a class="pkg-ghost-link" href="${pageContext.request.contextPath}/packages/manage">
            <spring:message code="package.form.backToList"/>
        </a>
    </section>

    <section class="pkg-panel pkg-form-panel">
        <c:if test="${not empty packageError}">
            <div class="pkg-alert pkg-alert--error">${packageError}</div>
        </c:if>

        <c:choose>
            <c:when test="${formMode eq 'EDIT'}">
                <c:set var="formAction" value="${pageContext.request.contextPath}/packages/manage/${packageForm.packageIdx}/edit"/>
            </c:when>
            <c:otherwise>
                <c:set var="formAction" value="${pageContext.request.contextPath}/packages/manage/write"/>
            </c:otherwise>
        </c:choose>

        <form class="pkg-form" method="post" action="${formAction}" enctype="multipart/form-data">
            <div class="pkg-form-grid">
                <label class="pkg-field pkg-field--wide">
                    <span><spring:message code="package.form.spot"/> <em>*</em></span>
                    <select name="spotIdx" required>
                        <option value="">${packageSpotPlaceholder}</option>
                        <c:forEach var="spot" items="${spotOptions}">
                            <option value="${spot.spotIdx}" ${packageForm.spotIdx eq spot.spotIdx ? 'selected' : ''}>
                                [${spot.region}] ${spot.name}
                            </option>
                        </c:forEach>
                    </select>
                    <small><spring:message code="package.form.spotHelp"/></small>
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span><spring:message code="package.form.title"/> <em>*</em></span>
                    <input type="text" name="packageTitle" maxlength="150" required
                           value="${packageForm.packageTitle}" placeholder="${packageTitlePlaceholder}">
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span><spring:message code="package.form.summary"/></span>
                    <input type="text" name="packageSummary" maxlength="300"
                           value="${packageForm.packageSummary}" placeholder="${packageSummaryPlaceholder}">
                </label>

                <label class="pkg-field">
                    <span><spring:message code="package.form.price"/> <em>*</em></span>
                    <input type="number" name="packagePrice" min="0" required
                           value="${empty packageForm.packagePrice ? 0 : packageForm.packagePrice}">
                </label>

                <label class="pkg-field">
                    <span><spring:message code="package.form.currency"/></span>
                    <input type="text" name="currencyCode" maxlength="10"
                           value="${empty packageForm.currencyCode ? 'KRW' : packageForm.currencyCode}">
                </label>

                <label class="pkg-field">
                    <span><spring:message code="package.form.startDate"/></span>
                    <input type="date" name="startDate" value="${packageForm.startDate}">
                </label>

                <label class="pkg-field">
                    <span><spring:message code="package.form.endDate"/></span>
                    <input type="date" name="endDate" value="${packageForm.endDate}">
                </label>

                <label class="pkg-field">
                    <span><spring:message code="package.form.minPeople"/> <em>*</em></span>
                    <input type="number" name="minPeople" min="1" required
                           value="${empty packageForm.minPeople ? 1 : packageForm.minPeople}">
                </label>

                <label class="pkg-field">
                    <span><spring:message code="package.form.maxPeople"/></span>
                    <input type="number" name="maxPeople" min="1" value="${packageForm.maxPeople}">
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span><spring:message code="package.form.mainImage"/></span>
                    <c:if test="${not empty packageForm.mainImagePath}">
                        <c:set var="mainImagePreviewPath" value="${pageContext.request.contextPath}${packageForm.mainImagePath}"/>
                        <c:if test="${fn:startsWith(packageForm.mainImagePath, 'http://') or fn:startsWith(packageForm.mainImagePath, 'https://')}">
                            <c:set var="mainImagePreviewPath" value="${packageForm.mainImagePath}"/>
                        </c:if>
                        <div class="pkg-current-image">
                            <img src="${mainImagePreviewPath}" alt="${packageCurrentImageLabel}">
                            <div>
                                <strong><spring:message code="package.form.currentImage"/></strong>
                                <small><spring:message code="package.form.keepImageHelp"/></small>
                            </div>
                        </div>
                    </c:if>
                    <input type="hidden" name="mainImagePath" value="${packageForm.mainImagePath}">
                    <input type="file" name="mainImageFile" accept=".jpg,.jpeg,.png,.gif,.webp,image/jpeg,image/png,image/gif,image/webp">
                    <small><spring:message code="package.form.imageHelp"/></small>
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span><spring:message code="package.form.content"/> <em>*</em></span>
                    <textarea name="packageContent" rows="12" required
                              placeholder="${packageContentPlaceholder}">${packageForm.packageContent}</textarea>
                </label>
            </div>

            <div class="pkg-form-actions">
                <c:choose>
                    <c:when test="${formMode eq 'REVISION'}">
                        <button type="submit" name="action" value="PENDING" class="pkg-primary-btn">
                            <spring:message code="package.revision.request"/>
                        </button>
                    </c:when>
                    <c:otherwise>
                        <button type="submit" name="action" value="DRAFT" class="pkg-secondary-btn">
                            <spring:message code="package.form.saveDraft"/>
                        </button>
                        <button type="submit" name="action" value="PENDING" class="pkg-primary-btn">
                            <spring:message code="package.form.submitApproval"/>
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>
        </form>
    </section>
</main>

</body>
</html>
