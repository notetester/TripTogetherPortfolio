<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_35820e276a" code="shop.hero.eyebrow"/>
<spring:message var="autoMsg_55a1963de8" code="shop.title"/>
<spring:message var="autoMsg_bc817bc067" code="shop.subtitle"/>
<spring:message var="autoMsg_9c16a873b3" code="shop.myPoint"/>
<spring:message var="autoMsg_d50604ff81" code="shop.preview.kicker"/>
<spring:message var="autoMsg_54e4067ef9" code="shop.preview.title"/>
<spring:message var="autoMsg_5c107b7a0f" code="${section.titleMessageCode}"/>
<spring:message var="autoMsg_cec3d77786" code="${section.descriptionMessageCode}"/>
<spring:message var="autoMsg_fe86a0e94f" code="${item.itemTypeMessageCode}"/>
<spring:message var="autoMsg_35528b2479" code="${item.nameMessageCode}"/>
<spring:message var="autoMsg_e6023bb5a5" code="${item.descriptionMessageCode}"/>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="shop/shop.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<main class="shop-wrap">
    <section class="shop-hero">
        <div class="shop-hero__content">
            <p class="shop-hero__eyebrow">${autoMsg_35820e276a}</p>
            <h1>${autoMsg_55a1963de8}</h1>
            <p class="shop-hero__desc">${autoMsg_bc817bc067}</p>

            <div class="shop-point-panel">
                <span>${autoMsg_9c16a873b3}</span>
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
                <p class="shop-section-kicker">${autoMsg_d50604ff81}</p>
                <h2>${autoMsg_54e4067ef9}</h2>
            </div>
        </div>

        <div class="shop-section-list">
            <c:forEach var="section" items="${shopSections}">
                <section class="shop-product-section ${section.accentClass}">
                    <div class="shop-product-section__head">
                        <div class="shop-card-icon">${section.iconText}</div>
                        <div>
                            <h3>${autoMsg_5c107b7a0f}</h3>
                            <p>${autoMsg_cec3d77786}</p>
                        </div>
                    </div>

                    <div class="shop-product-grid">
                        <c:forEach var="item" items="${section.items}">
                            <article class="shop-product-card">
                                <div class="shop-product-preview ${item.previewClass}">
                                    <span>${item.previewText}</span>
                                </div>
                                <div class="shop-product-meta">
                                    <span class="shop-product-type">${autoMsg_fe86a0e94f}</span>
                                    <strong>${autoMsg_35528b2479}</strong>
                                    <p>${autoMsg_e6023bb5a5}</p>
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
