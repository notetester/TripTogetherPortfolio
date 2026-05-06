<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_package_list_eyebrow" code="package.list.eyebrow"/>
<spring:message var="msg_package_list_title" code="package.list.title"/>
<spring:message var="msg_package_list_approvedEyebrow" code="package.list.approvedEyebrow"/>
<spring:message var="msg_package_list_empty" code="package.list.empty"/>
<spring:message var="msg_package_list_emptyDesc" code="package.list.emptyDesc"/>
<spring:message var="msg_package_list_noSummary" code="package.list.noSummary"/>
<spring:message var="msg_package_common_priceLabel" code="package.common.priceLabel"/>
<spring:message var="msg_package_common_spotLabel" code="package.common.spotLabel"/>
<spring:message var="msg_package_common_scheduleLabel" code="package.common.scheduleLabel"/>
<spring:message var="msg_package_common_always" code="package.common.always"/>
<spring:message var="msg_package_list_viewAtSpot" code="package.list.viewAtSpot"/>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<c:set var="pageCSS" value="packages/packages.css"/>
<c:set var="localeLanguage" value="${pageContext.response.locale.language}"/>
<c:choose>
    <c:when test="${localeLanguage eq 'en'}">
        <c:set var="packageSearchPlaceholder" value="Search by package title, summary, or destination"/>
        <c:set var="packageSearchButtonText" value="Search"/>
        <c:set var="packageResetButtonText" value="Reset"/>
        <c:set var="packagePrevText" value="Previous"/>
        <c:set var="packageNextText" value="Next"/>
        <c:set var="packageResultCountText" value="results"/>
    </c:when>
    <c:when test="${localeLanguage eq 'ja'}">
        <c:set var="packageSearchPlaceholder" value="パッケージ名・概要・旅行先で検索"/>
        <c:set var="packageSearchButtonText" value="検索"/>
        <c:set var="packageResetButtonText" value="リセット"/>
        <c:set var="packagePrevText" value="前へ"/>
        <c:set var="packageNextText" value="次へ"/>
        <c:set var="packageResultCountText" value="件"/>
    </c:when>
    <c:when test="${localeLanguage eq 'zh'}">
        <c:set var="packageSearchPlaceholder" value="按套餐名称、简介或目的地搜索"/>
        <c:set var="packageSearchButtonText" value="搜索"/>
        <c:set var="packageResetButtonText" value="重置"/>
        <c:set var="packagePrevText" value="上一页"/>
        <c:set var="packageNextText" value="下一页"/>
        <c:set var="packageResultCountText" value="条结果"/>
    </c:when>
    <c:otherwise>
        <c:set var="packageSearchPlaceholder" value="패키지명, 요약, 여행지명으로 검색"/>
        <c:set var="packageSearchButtonText" value="검색"/>
        <c:set var="packageResetButtonText" value="초기화"/>
        <c:set var="packagePrevText" value="이전"/>
        <c:set var="packageNextText" value="다음"/>
        <c:set var="packageResultCountText" value="개"/>
    </c:otherwise>
</c:choose>
<%@ include file="../common/header.jsp" %>
<body>

<main class="pkg-wrap">
    <section class="pkg-hero">
        <div>
            <p class="pkg-eyebrow">${msg_package_list_eyebrow}</p>
            <h1>${msg_package_list_title}</h1>
        </div>
    </section>

    <section class="pkg-panel">
        <div class="pkg-section-title">
            <div>
                <span>${msg_package_list_approvedEyebrow}</span>
                <h2>
                    <c:choose>
                        <c:when test="${localeLanguage eq 'en'}">Travel Packages</c:when>
                        <c:when test="${localeLanguage eq 'ja'}">旅行パッケージ</c:when>
                        <c:when test="${localeLanguage eq 'zh'}">旅行套餐</c:when>
                        <c:otherwise>여행 패키지</c:otherwise>
                    </c:choose>
                </h2>
            </div>
            <c:if test="${totalCount gt 0}">
                <p>${totalCount} ${packageResultCountText}</p>
            </c:if>
        </div>

        <div class="pkg-toolbar">
            <form class="pkg-search-form" method="get" action="${pageContext.request.contextPath}/packages">
                <input type="text"
                       name="keyword"
                       value="${fn:escapeXml(keyword)}"
                       placeholder="${fn:escapeXml(packageSearchPlaceholder)}">
                <button type="submit">${packageSearchButtonText}</button>
            </form>
            <c:if test="${not empty keyword}">
                <a class="pkg-search-reset" href="${pageContext.request.contextPath}/packages">${packageResetButtonText}</a>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${empty packageList}">
                <div class="pkg-empty">
                    <strong>${msg_package_list_empty}</strong>
                    <p>${msg_package_list_emptyDesc}</p>
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
                                        <c:otherwise>${msg_package_list_noSummary}</c:otherwise>
                                    </c:choose>
                                </p>
                                <dl class="pkg-meta">
                                    <div>
                                        <dt>${msg_package_common_priceLabel}</dt>
                                        <dd><fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(pkg.currencyCode)}</dd>
                                    </div>
                                    <div>
                                        <dt>${msg_package_common_spotLabel}</dt>
                                        <dd>${fn:escapeXml(pkg.spotName)}</dd>
                                    </div>
                                    <div>
                                        <dt>${msg_package_common_scheduleLabel}</dt>
                                        <dd>
                                            <c:choose>
                                                <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">
                                                    ${pkg.startDate} ~ ${pkg.endDate}
                                                </c:when>
                                                <c:otherwise>${msg_package_common_always}</c:otherwise>
                                            </c:choose>
                                        </dd>
                                    </div>
                                </dl>
                            </div>
                            <div class="pkg-card__actions">
                                <a href="${pageContext.request.contextPath}/detail/${pkg.spotIdx}">
                                    ${msg_package_list_viewAtSpot}
                                </a>
                            </div>
                        </article>
                    </c:forEach>
                </div>

                <c:if test="${totalPages gt 1}">
                    <nav class="pkg-pagination" aria-label="Package pagination">
                        <c:if test="${currentPage gt 1}">
                            <c:url var="packagePrevUrl" value="/packages">
                                <c:param name="page" value="${currentPage - 1}"/>
                                <c:if test="${not empty keyword}">
                                    <c:param name="keyword" value="${keyword}"/>
                                </c:if>
                            </c:url>
                            <a class="pkg-page-link pkg-page-link--nav" href="${packagePrevUrl}">${packagePrevText}</a>
                        </c:if>

                        <c:forEach var="pageNo" begin="${startPage}" end="${endPage}">
                            <c:url var="packagePageUrl" value="/packages">
                                <c:param name="page" value="${pageNo}"/>
                                <c:if test="${not empty keyword}">
                                    <c:param name="keyword" value="${keyword}"/>
                                </c:if>
                            </c:url>
                            <a class="pkg-page-link ${pageNo eq currentPage ? 'is-current' : ''}" href="${packagePageUrl}">${pageNo}</a>
                        </c:forEach>

                        <c:if test="${currentPage lt totalPages}">
                            <c:url var="packageNextUrl" value="/packages">
                                <c:param name="page" value="${currentPage + 1}"/>
                                <c:if test="${not empty keyword}">
                                    <c:param name="keyword" value="${keyword}"/>
                                </c:if>
                            </c:url>
                            <a class="pkg-page-link pkg-page-link--nav" href="${packageNextUrl}">${packageNextText}</a>
                        </c:if>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>
    </section>
</main>

<%@ include file="../common/footer.jsp" %>

</body>
</html>
