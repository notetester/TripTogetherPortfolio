<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="packages/packages.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<main class="pkg-wrap">
    <section class="pkg-hero">
        <div>
            <p class="pkg-eyebrow">BUSINESS PACKAGE</p>
            <h1>패키지 상품 관리</h1>
            <p>여행지와 연결되는 패키지 상품을 등록하고 관리자 승인 요청까지 진행할 수 있습니다.</p>
        </div>
        <a class="pkg-primary-link" href="${pageContext.request.contextPath}/packages/manage/write">새 패키지 등록</a>
    </section>

    <section class="pkg-panel">
        <c:if test="${not empty packageMessage}">
            <div class="pkg-alert pkg-alert--success">${packageMessage}</div>
        </c:if>
        <c:if test="${not empty packageError}">
            <div class="pkg-alert pkg-alert--error">${packageError}</div>
        </c:if>

        <div class="pkg-section-title">
            <div>
                <span>MY PRODUCTS</span>
                <h2>내가 등록한 패키지</h2>
            </div>
            <p>승인 전에는 임시저장/반려 상태만 수정할 수 있습니다.</p>
        </div>

        <c:choose>
            <c:when test="${empty packageList}">
                <div class="pkg-empty">
                    <strong>등록한 패키지 상품이 없습니다.</strong>
                    <p>여행지와 연결되는 첫 번째 패키지 상품을 만들어보세요.</p>
                    <a href="${pageContext.request.contextPath}/packages/manage/write">패키지 등록하기</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="pkg-card-grid">
                    <c:forEach var="pkg" items="${packageList}">
                        <article class="pkg-card">
                            <div class="pkg-card__top">
                                <span class="pkg-status pkg-status--${pkg.packageStatus}">${pkg.packageStatus}</span>
                                <span class="pkg-date">${pkg.createdAt}</span>
                            </div>

                            <div class="pkg-thumb">
                                <c:choose>
                                    <c:when test="${not empty pkg.mainImagePath}">
                                        <img src="${pkg.mainImagePath}" alt="${pkg.packageTitle}">
                                    </c:when>
                                    <c:otherwise>
                                        <span>TripTogether</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="pkg-card__body">
                                <p class="pkg-spot">${pkg.spotRegion} · ${pkg.spotName}</p>
                                <h3>${pkg.packageTitle}</h3>
                                <p class="pkg-summary">
                                    <c:choose>
                                        <c:when test="${not empty pkg.packageSummary}">${pkg.packageSummary}</c:when>
                                        <c:otherwise>짧은 소개가 아직 등록되지 않았습니다.</c:otherwise>
                                    </c:choose>
                                </p>

                                <dl class="pkg-meta">
                                    <div>
                                        <dt>가격</dt>
                                        <dd><fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0"/> ${pkg.currencyCode}</dd>
                                    </div>
                                    <div>
                                        <dt>운영일</dt>
                                        <dd>
                                            <c:choose>
                                                <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">
                                                    ${pkg.startDate} ~ ${pkg.endDate}
                                                </c:when>
                                                <c:otherwise>상시/미정</c:otherwise>
                                            </c:choose>
                                        </dd>
                                    </div>
                                    <div>
                                        <dt>인원</dt>
                                        <dd>
                                            최소 ${pkg.minPeople}명
                                            <c:if test="${not empty pkg.maxPeople}"> / 최대 ${pkg.maxPeople}명</c:if>
                                        </dd>
                                    </div>
                                </dl>

                                <c:if test="${pkg.packageStatus eq 'REJECTED' and not empty pkg.rejectReason}">
                                    <div class="pkg-reject">
                                        <strong>반려 사유</strong>
                                        <p>${pkg.rejectReason}</p>
                                    </div>
                                </c:if>
                            </div>

                            <div class="pkg-card__actions">
                                <c:if test="${pkg.packageStatus eq 'DRAFT' or pkg.packageStatus eq 'REJECTED'}">
                                    <a href="${pageContext.request.contextPath}/packages/manage/${pkg.packageIdx}/edit">수정</a>
                                    <form method="post" action="${pageContext.request.contextPath}/packages/manage/${pkg.packageIdx}/submit"
                                          onsubmit="return confirm('관리자 승인 요청을 진행할까요?');">
                                        <button type="submit">승인 요청</button>
                                    </form>
                                </c:if>
                                <c:if test="${pkg.packageStatus eq 'PENDING'}">
                                    <span class="pkg-waiting">관리자 검토 대기 중</span>
                                </c:if>
                                <c:if test="${pkg.packageStatus eq 'APPROVED'}">
                                    <span class="pkg-approved">승인 완료</span>
                                </c:if>
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
