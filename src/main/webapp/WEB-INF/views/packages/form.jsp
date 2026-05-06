<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_4fa44b1e4f" code="package.form.eyebrow"/>
<spring:message var="autoMsg_adfd3087e7" code="package.form.revisionTitle"/>
<spring:message var="autoMsg_92098b0e06" code="package.form.editTitle"/>
<spring:message var="autoMsg_dd6771fa52" code="package.form.createTitle"/>
<spring:message var="autoMsg_1892bedcf8" code="package.form.revisionDesc"/>
<spring:message var="autoMsg_804e9c54a2" code="package.form.defaultDesc"/>
<spring:message var="autoMsg_35cee31c94" code="package.form.spot"/>
<spring:message var="autoMsg_ff5ac867bd" code="package.form.spotHelp"/>
<spring:message var="autoMsg_b096ecc5d2" code="package.form.title"/>
<spring:message var="autoMsg_e23b81a7f1" code="package.form.summary"/>
<spring:message var="autoMsg_50e5eb0a65" code="package.form.price"/>
<spring:message var="autoMsg_3113741833" code="package.form.currency"/>
<spring:message var="autoMsg_9dfe9b3da0" code="package.form.startDate"/>
<spring:message var="autoMsg_749d245ba4" code="package.form.endDate"/>
<spring:message var="autoMsg_c0960f66b6" code="package.form.minPeople"/>
<spring:message var="autoMsg_8b272c5200" code="package.form.maxPeople"/>
<spring:message var="autoMsg_003c1dcb21" code="package.form.mainImage"/>
<spring:message var="autoMsg_4dc7cccb04" code="package.form.currentImage"/>
<spring:message var="autoMsg_3fc3e6f505" code="package.form.keepImageHelp"/>
<spring:message var="autoMsg_93ed2cdddc" code="package.form.imageHelp"/>
<spring:message var="autoMsg_81c265ee24" code="package.form.content"/>
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
            <p class="pkg-eyebrow">${autoMsg_4fa44b1e4f}</p>
            <h1>
                <c:choose>
                    <c:when test="${formMode eq 'REVISION'}">${autoMsg_adfd3087e7}</c:when>
                    <c:when test="${formMode eq 'EDIT'}">${autoMsg_92098b0e06}</c:when>
                    <c:otherwise>${autoMsg_dd6771fa52}</c:otherwise>
                </c:choose>
            </h1>
            <p>
                <c:choose>
                    <c:when test="${formMode eq 'REVISION'}">${autoMsg_1892bedcf8}</c:when>
                    <c:otherwise>${autoMsg_804e9c54a2}</c:otherwise>
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
                    <span>${autoMsg_35cee31c94} <em>*</em></span>
                    <select name="spotIdx" required>
                        <option value="">${packageSpotPlaceholder}</option>
                        <c:forEach var="spot" items="${spotOptions}">
                            <option value="${spot.spotIdx}" ${packageForm.spotIdx eq spot.spotIdx ? 'selected' : ''}>
                                [${spot.region}] ${spot.name}
                            </option>
                        </c:forEach>
                    </select>
                    <small>${autoMsg_ff5ac867bd}</small>
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span>${autoMsg_b096ecc5d2} <em>*</em></span>
                    <input type="text" name="packageTitle" maxlength="150" required
                           value="${packageForm.packageTitle}" placeholder="${packageTitlePlaceholder}">
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span>${autoMsg_e23b81a7f1}</span>
                    <input type="text" name="packageSummary" maxlength="300"
                           value="${packageForm.packageSummary}" placeholder="${packageSummaryPlaceholder}">
                </label>

                <label class="pkg-field">
                    <span>${autoMsg_50e5eb0a65} <em>*</em></span>
                    <input type="number" name="packagePrice" min="0" required
                           value="${empty packageForm.packagePrice ? 0 : packageForm.packagePrice}">
                </label>

                <label class="pkg-field">
                    <span>${autoMsg_3113741833}</span>
                    <input type="text" name="currencyCode" maxlength="10"
                           value="${empty packageForm.currencyCode ? 'KRW' : packageForm.currencyCode}">
                </label>

                <label class="pkg-field">
                    <span>${autoMsg_9dfe9b3da0}</span>
                    <input type="date" name="startDate" value="${packageForm.startDate}">
                </label>

                <label class="pkg-field">
                    <span>${autoMsg_749d245ba4}</span>
                    <input type="date" name="endDate" value="${packageForm.endDate}">
                </label>

                <label class="pkg-field">
                    <span>${autoMsg_c0960f66b6} <em>*</em></span>
                    <input type="number" name="minPeople" min="1" required
                           value="${empty packageForm.minPeople ? 1 : packageForm.minPeople}">
                </label>

                <label class="pkg-field">
                    <span>${autoMsg_8b272c5200}</span>
                    <input type="number" name="maxPeople" min="1" value="${packageForm.maxPeople}">
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span>${autoMsg_003c1dcb21}</span>
                    <c:if test="${not empty packageForm.mainImagePath}">
                        <c:set var="mainImagePreviewPath" value="${pageContext.request.contextPath}${packageForm.mainImagePath}"/>
                        <c:if test="${fn:startsWith(packageForm.mainImagePath, 'http://') or fn:startsWith(packageForm.mainImagePath, 'https://')}">
                            <c:set var="mainImagePreviewPath" value="${packageForm.mainImagePath}"/>
                        </c:if>
                        <div class="pkg-current-image">
                            <img src="${mainImagePreviewPath}" alt="${packageCurrentImageLabel}">
                            <div>
                                <strong>${autoMsg_4dc7cccb04}</strong>
                                <small>${autoMsg_3fc3e6f505}</small>
                            </div>
                        </div>
                    </c:if>
                    <input type="hidden" name="mainImagePath" value="${packageForm.mainImagePath}">
                    <input type="file" name="mainImageFile" accept=".jpg,.jpeg,.png,.gif,.webp,image/jpeg,image/png,image/gif,image/webp">
                    <small>${autoMsg_93ed2cdddc}</small>
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span>${autoMsg_81c265ee24} <em>*</em></span>
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
