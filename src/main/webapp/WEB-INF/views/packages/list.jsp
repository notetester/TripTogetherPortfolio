<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="packages/packages.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<main class="pkg-wrap">
    <section class="pkg-hero">
        <div>
            <p class="pkg-eyebrow">TRAVEL PACKAGE</p>
            <h1>여행 패키지 상품</h1>
            <p>관리자 검토를 통과한 공식 패키지 상품만 모아서 보여줍니다.</p>
        </div>
    </section>

    <section class="pkg-panel">
        <div class="pkg-section-title">
            <div>
                <span>APPROVED PRODUCTS</span>
                <h2>승인된 패키지</h2>
            </div>
            <p>여행지와 연결된 패키지만 노출됩니다.</p>
        </div>

        <c:choose>
            <c:when test="${empty packageList}">
                <div class="pkg-empty">
                    <strong>현재 노출 중인 패키지 상품이 없습니다.</strong>
                    <p>관리자 승인이 완료된 상품이 생기면 이곳에 표시됩니다.</p>
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
                                        <c:otherwise>상세 설명에서 패키지 정보를 확인해보세요.</c:otherwise>
                                    </c:choose>
                                </p>
                                <dl class="pkg-meta">
                                    <div>
                                        <dt>가격</dt>
                                        <dd><fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(pkg.currencyCode)}</dd>
                                    </div>
                                    <div>
                                        <dt>여행지</dt>
                                        <dd>${fn:escapeXml(pkg.spotName)}</dd>
                                    </div>
                                    <div>
                                        <dt>일정</dt>
                                        <dd>
                                            <c:choose>
                                                <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">
                                                    ${pkg.startDate} ~ ${pkg.endDate}
                                                </c:when>
                                                <c:otherwise>상시/미정</c:otherwise>
                                            </c:choose>
                                        </dd>
                                    </div>
                                </dl>
                            </div>
                            <div class="pkg-card__actions">
                                <a href="${pageContext.request.contextPath}/detail/${pkg.spotIdx}">여행지에서 보기</a>
                                <span class="pkg-approved">승인 상품</span>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </section>
</main>

</body>
</html>
