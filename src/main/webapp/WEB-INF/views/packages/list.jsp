<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="packages/packages.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<main class="pkg-wrap">
    <section class="pkg-hero">
        <div>
            <p class="pkg-eyebrow"><spring:message code="package.list.eyebrow"/></p>
            <h1><spring:message code="package.list.title"/></h1>
            <p><spring:message code="package.list.desc"/></p>
        </div>
    </section>

    <section class="pkg-panel">
        <div class="pkg-section-title">
            <div>
                <span><spring:message code="package.list.approvedEyebrow"/></span>
                <h2><spring:message code="package.list.approvedTitle"/></h2>
            </div>
            <p><spring:message code="package.list.approvedDesc"/></p>
        </div>

        <c:choose>
            <c:when test="${empty packageList}">
                <div class="pkg-empty">
                    <strong><spring:message code="package.list.empty"/></strong>
                    <p><spring:message code="package.list.emptyDesc"/></p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="pkg-card-grid">
                    <c:forEach var="pkg" items="${packageList}">
                        <article class="pkg-card pkg-public-card">
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
                                        <c:otherwise><spring:message code="package.list.noSummary"/></c:otherwise>
                                    </c:choose>
                                </p>
                                <dl class="pkg-meta">
                                    <div>
                                        <dt><spring:message code="package.common.priceLabel"/></dt>
                                        <dd><fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(pkg.currencyCode)}</dd>
                                    </div>
                                    <div>
                                        <dt><spring:message code="package.common.spotLabel"/></dt>
                                        <dd>${fn:escapeXml(pkg.spotName)}</dd>
                                    </div>
                                    <div>
                                        <dt><spring:message code="package.common.scheduleLabel"/></dt>
                                        <dd>
                                            <c:choose>
                                                <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">
                                                    ${pkg.startDate} ~ ${pkg.endDate}
                                                </c:when>
                                                <c:otherwise><spring:message code="package.common.always"/></c:otherwise>
                                            </c:choose>
                                        </dd>
                                    </div>
                                </dl>
                            </div>
                            <div class="pkg-card__actions">
                                <a href="${pageContext.request.contextPath}/detail/${pkg.spotIdx}">
                                    <spring:message code="package.list.viewAtSpot"/>
                                </a>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </section>
</main>

<%@ include file="../common/footer.jsp" %>

</body>
</html>
