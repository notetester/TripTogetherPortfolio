<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="shop/shop.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<main class="shop-wrap">
    <section class="shop-hero">
        <div class="shop-hero__content">
            <p class="shop-hero__eyebrow"><spring:message code="shop.hero.eyebrow"/></p>
            <h1><spring:message code="shop.title"/></h1>
            <p class="shop-hero__desc"><spring:message code="shop.subtitle"/></p>

            <div class="shop-point-panel">
                <span><spring:message code="shop.myPoint"/></span>
                <strong>
                    <c:choose>
                        <c:when test="${not empty user}">
                            <fmt:formatNumber value="${user.pointBalance}" pattern="#,##0"/> P
                        </c:when>
                        <c:otherwise>
                            <spring:message code="shop.loginRequired"/>
                        </c:otherwise>
                    </c:choose>
                </strong>
            </div>
        </div>
    </section>

    <section class="shop-container">
        <c:if test="${not empty shopMessage}">
            <div class="shop-alert shop-alert--success">${shopMessage}</div>
        </c:if>
        <c:if test="${not empty shopError}">
            <div class="shop-alert shop-alert--error">${shopError}</div>
        </c:if>

        <div class="shop-section-head">
            <div>
                <p class="shop-section-kicker"><spring:message code="shop.preview.kicker"/></p>
                <h2><spring:message code="shop.preview.title"/></h2>
            </div>
        </div>

        <div class="shop-section-list">
            <c:forEach var="section" items="${shopSections}">
                <section class="shop-product-section ${section.accentClass}">
                    <div class="shop-product-section__head">
                        <div class="shop-card-icon">${section.iconText}</div>
                        <div>
                            <h3><spring:message code="${section.titleMessageCode}"/></h3>
                            <p><spring:message code="${section.descriptionMessageCode}"/></p>
                        </div>
                    </div>

                    <div class="shop-product-grid">
                        <c:forEach var="item" items="${section.items}">
                            <article class="shop-product-card">
                                <div class="shop-product-preview ${item.previewClass}">
                                    <span>${item.previewText}</span>
                                </div>
                                <div class="shop-product-meta">
                                    <span class="shop-product-type"><spring:message code="${item.itemTypeMessageCode}"/></span>
                                    <strong><spring:message code="${item.nameMessageCode}"/></strong>
                                    <p><spring:message code="${item.descriptionMessageCode}"/></p>
                                </div>
                                <div class="shop-product-footer">
                                    <span class="shop-product-price">
                                        <fmt:formatNumber value="${item.pointPrice}" pattern="#,##0"/> P
                                    </span>
                                    <c:choose>
                                        <c:when test="${ownedItemCodeMap[item.itemCode]}">
                                            <button type="button" class="shop-owned-btn" disabled>
                                                <spring:message code="shop.button.owned"/>
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <form method="post" action="${pageContext.request.contextPath}/shop/purchase">
                                                <input type="hidden" name="itemCode" value="${item.itemCode}">
                                                <button type="submit" class="shop-buy-btn">
                                                    <spring:message code="shop.button.buy"/>
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                </section>
            </c:forEach>
        </div>

    </section>
</main>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
