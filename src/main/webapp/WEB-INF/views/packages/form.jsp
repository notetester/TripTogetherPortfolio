<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_package_form_spotPlaceholder" code="package.form.spotPlaceholder"/>
<spring:message var="msg_package_form_titlePlaceholder" code="package.form.titlePlaceholder"/>
<spring:message var="msg_package_form_summaryPlaceholder" code="package.form.summaryPlaceholder"/>
<spring:message var="msg_package_form_contentPlaceholder" code="package.form.contentPlaceholder"/>
<spring:message var="msg_package_form_currentImage" code="package.form.currentImage"/>
<spring:message var="msg_package_form_eyebrow" code="package.form.eyebrow"/>
<spring:message var="msg_package_form_revisionTitle" code="package.form.revisionTitle"/>
<spring:message var="msg_package_form_editTitle" code="package.form.editTitle"/>
<spring:message var="msg_package_form_createTitle" code="package.form.createTitle"/>
<spring:message var="msg_package_form_revisionDesc" code="package.form.revisionDesc"/>
<spring:message var="msg_package_form_defaultDesc" code="package.form.defaultDesc"/>
<spring:message var="msg_package_form_backToList" code="package.form.backToList"/>
<spring:message var="msg_package_form_spot" code="package.form.spot"/>
<spring:message var="msg_package_form_spotHelp" code="package.form.spotHelp"/>
<spring:message var="msg_package_form_title" code="package.form.title"/>
<spring:message var="msg_package_form_summary" code="package.form.summary"/>
<spring:message var="msg_package_form_price" code="package.form.price"/>
<spring:message var="msg_package_form_currency" code="package.form.currency"/>
<spring:message var="msg_package_form_startDate" code="package.form.startDate"/>
<spring:message var="msg_package_form_endDate" code="package.form.endDate"/>
<spring:message var="msg_package_form_minPeople" code="package.form.minPeople"/>
<spring:message var="msg_package_form_maxPeople" code="package.form.maxPeople"/>
<spring:message var="msg_package_form_mainImage" code="package.form.mainImage"/>
<spring:message var="msg_package_form_keepImageHelp" code="package.form.keepImageHelp"/>
<spring:message var="msg_package_form_imageHelp" code="package.form.imageHelp"/>
<spring:message var="msg_package_form_content" code="package.form.content"/>
<spring:message var="msg_package_revision_request" code="package.revision.request"/>
<spring:message var="msg_package_form_saveDraft" code="package.form.saveDraft"/>
<spring:message var="msg_package_form_submitApproval" code="package.form.submitApproval"/>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="packages/packages.css"/>


<%@ include file="../common/header.jsp" %>
<body>

<main class="pkg-wrap">
    <section class="pkg-hero pkg-hero--form">
        <div>
            <p class="pkg-eyebrow">${msg_package_form_eyebrow}</p>
            <h1>
                <c:choose>
                    <c:when test="${formMode eq 'REVISION'}">${msg_package_form_revisionTitle}</c:when>
                    <c:when test="${formMode eq 'EDIT'}">${msg_package_form_editTitle}</c:when>
                    <c:otherwise>${msg_package_form_createTitle}</c:otherwise>
                </c:choose>
            </h1>
            <p>
                <c:choose>
                    <c:when test="${formMode eq 'REVISION'}">${msg_package_form_revisionDesc}</c:when>
                    <c:otherwise>${msg_package_form_defaultDesc}</c:otherwise>
                </c:choose>
            </p>
        </div>
        <a class="pkg-ghost-link" href="${pageContext.request.contextPath}/packages/manage">
            ${msg_package_form_backToList}
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
                    <span>${msg_package_form_spot} <em>*</em></span>
                    <select name="spotIdx" required>
                        <option value="">${msg_package_form_spotPlaceholder}</option>
                        <c:forEach var="spot" items="${spotOptions}">
                            <option value="${spot.spotIdx}" ${packageForm.spotIdx eq spot.spotIdx ? 'selected' : ''}>
                                [${spot.region}] ${spot.name}
                            </option>
                        </c:forEach>
                    </select>
                    <small>${msg_package_form_spotHelp}</small>
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span>${msg_package_form_title} <em>*</em></span>
                    <input type="text" name="packageTitle" maxlength="150" required
                           value="${packageForm.packageTitle}" placeholder="${msg_package_form_titlePlaceholder}">
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span>${msg_package_form_summary}</span>
                    <input type="text" name="packageSummary" maxlength="300"
                           value="${packageForm.packageSummary}" placeholder="${msg_package_form_summaryPlaceholder}">
                </label>

                <label class="pkg-field">
                    <span>${msg_package_form_price} <em>*</em></span>
                    <input type="number" name="packagePrice" min="0" required
                           value="${empty packageForm.packagePrice ? 0 : packageForm.packagePrice}">
                </label>

                <label class="pkg-field">
                    <span>${msg_package_form_currency}</span>
                    <input type="text" name="currencyCode" maxlength="10"
                           value="${empty packageForm.currencyCode ? 'KRW' : packageForm.currencyCode}">
                </label>

                <label class="pkg-field">
                    <span>${msg_package_form_startDate}</span>
                    <input type="date" name="startDate" value="${packageForm.startDate}">
                </label>

                <label class="pkg-field">
                    <span>${msg_package_form_endDate}</span>
                    <input type="date" name="endDate" value="${packageForm.endDate}">
                </label>

                <label class="pkg-field">
                    <span>${msg_package_form_minPeople} <em>*</em></span>
                    <input type="number" name="minPeople" min="1" required
                           value="${empty packageForm.minPeople ? 1 : packageForm.minPeople}">
                </label>

                <label class="pkg-field">
                    <span>${msg_package_form_maxPeople}</span>
                    <input type="number" name="maxPeople" min="1" value="${packageForm.maxPeople}">
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span>${msg_package_form_mainImage}</span>
                    <c:if test="${not empty packageForm.mainImagePath}">
                        <c:set var="mainImagePreviewPath" value="${pageContext.request.contextPath}${packageForm.mainImagePath}"/>
                        <c:if test="${fn:startsWith(packageForm.mainImagePath, 'http://') or fn:startsWith(packageForm.mainImagePath, 'https://')}">
                            <c:set var="mainImagePreviewPath" value="${packageForm.mainImagePath}"/>
                        </c:if>
                        <div class="pkg-current-image">
                            <img src="${mainImagePreviewPath}" alt="${msg_package_form_currentImage}">
                            <div>
                                <strong>${msg_package_form_currentImage}</strong>
                                <small>${msg_package_form_keepImageHelp}</small>
                            </div>
                        </div>
                    </c:if>
                    <input type="hidden" name="mainImagePath" value="${packageForm.mainImagePath}">
                    <input type="file" name="mainImageFile" accept=".jpg,.jpeg,.png,.gif,.webp,image/jpeg,image/png,image/gif,image/webp">
                    <small>${msg_package_form_imageHelp}</small>
                </label>

                <label class="pkg-field pkg-field--wide">
                    <span>${msg_package_form_content} <em>*</em></span>
                    <textarea name="packageContent" rows="12" required
                              placeholder="${msg_package_form_contentPlaceholder}">${packageForm.packageContent}</textarea>
                </label>
            </div>

            <div class="pkg-form-actions">
                <c:choose>
                    <c:when test="${formMode eq 'REVISION'}">
                        <button type="submit" name="action" value="PENDING" class="pkg-primary-btn">
                            ${msg_package_revision_request}
                        </button>
                    </c:when>
                    <c:otherwise>
                        <button type="submit" name="action" value="DRAFT" class="pkg-secondary-btn">
                            ${msg_package_form_saveDraft}
                        </button>
                        <button type="submit" name="action" value="PENDING" class="pkg-primary-btn">
                            ${msg_package_form_submitApproval}
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>
        </form>
    </section>
</main>

</body>
</html>
