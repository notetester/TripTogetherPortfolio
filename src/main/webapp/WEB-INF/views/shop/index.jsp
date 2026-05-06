<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_shop_hero_eyebrow" code="shop.hero.eyebrow"/>
<spring:message var="msg_shop_title" code="shop.title"/>
<spring:message var="msg_shop_subtitle" code="shop.subtitle"/>
<spring:message var="msg_shop_myPoint" code="shop.myPoint"/>
<spring:message var="msg_shop_loginRequired" code="shop.loginRequired"/>
<spring:message var="msg_shop_preview_kicker" code="shop.preview.kicker"/>
<spring:message var="msg_shop_preview_title" code="shop.preview.title"/>
<spring:message var="msg_shop_button_owned" code="shop.button.owned"/>
<spring:message var="msg_shop_button_buy" code="shop.button.buy"/>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="shop/shop.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<main class="shop-wrap">
    <section class="shop-hero">
        <div class="shop-hero__content">
            <p class="shop-hero__eyebrow">${msg_shop_hero_eyebrow}</p>
            <h1>${msg_shop_title}</h1>
            <p class="shop-hero__desc">${msg_shop_subtitle}</p>

            <div class="shop-point-panel">
                <span>${msg_shop_myPoint}</span>
                <strong>
                    <c:choose>
                        <c:when test="${not empty user}">
                            <fmt:formatNumber value="${user.pointBalance}" pattern="#,##0"/> P
                        </c:when>
                        <c:otherwise>
                            ${msg_shop_loginRequired}
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
                <p class="shop-section-kicker">${msg_shop_preview_kicker}</p>
                <h2>${msg_shop_preview_title}</h2>
            </div>
        </div>

        <div class="shop-section-list">
            <c:forEach var="section" items="${shopSections}">
                <section class="shop-product-section ${section.accentClass}">
                    <div class="shop-product-section__head">
                        <div class="shop-card-icon">${section.iconText}</div>
                        <div>
                            <h3><spring:message var="msg_section_titleMessageCode" code="${section.titleMessageCode}"/>${msg_section_titleMessageCode}</h3>
                            <p><spring:message var="msg_section_descriptionMessageCode" code="${section.descriptionMessageCode}"/>${msg_section_descriptionMessageCode}</p>
                        </div>
                    </div>

                    <div class="shop-product-grid">
                        <c:forEach var="item" items="${section.items}">
                            <article class="shop-product-card">
                                <div class="shop-product-preview ${item.previewClass}">
                                    <span>${item.previewText}</span>
                                </div>
                                <div class="shop-product-meta">
                                    <span class="shop-product-type"><spring:message var="msg_item_itemTypeMessageCode" code="${item.itemTypeMessageCode}"/>${msg_item_itemTypeMessageCode}</span>
                                    <strong><spring:message var="msg_item_nameMessageCode" code="${item.nameMessageCode}"/>${msg_item_nameMessageCode}</strong>
                                    <p><spring:message var="msg_item_descriptionMessageCode" code="${item.descriptionMessageCode}"/>${msg_item_descriptionMessageCode}</p>
                                </div>
                                <div class="shop-product-footer">
                                    <span class="shop-product-price">
                                        <fmt:formatNumber value="${item.pointPrice}" pattern="#,##0"/> P
                                    </span>
                                    <c:choose>
                                        <c:when test="${ownedItemCodeMap[item.itemCode]}">
                                            <button type="button" class="shop-owned-btn" disabled>
                                                ${msg_shop_button_owned}
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <form method="post" action="${pageContext.request.contextPath}/shop/purchase">
                                                <input type="hidden" name="itemCode" value="${item.itemCode}">
                                                <button type="submit" class="shop-buy-btn">
                                                    ${msg_shop_button_buy}
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
