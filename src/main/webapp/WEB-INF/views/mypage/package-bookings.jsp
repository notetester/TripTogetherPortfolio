<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="pageCSS" value="mypage/mypage.css"/>
<%@ include file="../common/header.jsp" %>
<body>
<spring:message code="mypage.common.status.booked" var="statusBooked"/>
<spring:message code="mypage.common.status.cancelled" var="statusCancelled"/>
<spring:message code="mypage.common.status.completed" var="statusCompleted"/>
<spring:message code="mypage.booking.cancelPlaceholder" var="bookingCancelPlaceholder"/>
<spring:message code="mypage.items.packageIcon" var="mypageItemsPackageIconLabel"/>
<spring:message code="mypage.none" var="mypageNoneLabel"/>
<main class="mp-container">
    <div class="mp-card">
        <div class="mp-card-head">
            <div class="mp-card-title">
                <span class="mp-card-icon">🎒</span>
                <spring:message code="mypage.card.packageBookings"/>
                <span class="mp-card-count">${packageBookingCount}</span>
            </div>
            <a href="${pageContext.request.contextPath}/mypage" class="mp-card-more"><spring:message code="mypage.common.backToMypage"/></a>
        </div>
        <div class="mp-card-body">
            <c:if test="${not empty packageBookingMessage}">
                <div class="mp-package-booking-alert success">${packageBookingMessage}</div>
            </c:if>
            <c:if test="${not empty packageBookingError}">
                <div class="mp-package-booking-alert error">${packageBookingError}</div>
            </c:if>

            <c:choose>
                <c:when test="${empty packageBookingList}">
                    <div class="mp-empty">
                        <div class="mp-empty-icon">🎒</div>
                        <spring:message code="mypage.empty.packageBookings"/>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="mp-flight-booking-grid mp-package-booking-grid">
                        <c:forEach var="packageBooking" items="${packageBookingList}">
                            <c:set var="packageStatusLabel" value="${statusBooked}"/>
                            <c:if test="${packageBooking.bookingStatus eq 'CANCELLED'}">
                                <c:set var="packageStatusLabel" value="${statusCancelled}"/>
                            </c:if>
                            <c:if test="${packageBooking.bookingStatus eq 'COMPLETED'}">
                                <c:set var="packageStatusLabel" value="${statusCompleted}"/>
                            </c:if>

                            <article class="mp-flight-ticket mp-package-ticket">
                                <div class="mp-flight-ticket-head">
                                    <div>
                                        <span class="mp-flight-status mp-package-status">${packageStatusLabel}</span>
                                        <h4>${packageBooking.packageTitle}</h4>
                                        <p>${packageBooking.spotName} &middot; <spring:message code="mypage.booking.reservationNo"/></p>
                                    </div>
                                    <div class="mp-flight-ticket-price">
                                        <span><spring:message code="mypage.booking.totalPayment"/></span>
                                        <strong><fmt:formatNumber value="${packageBooking.totalPrice}" pattern="#,##0"/> C</strong>
                                    </div>
                                </div>

                                <div class="mp-package-summary-box">
                                    <c:if test="${not empty packageBooking.mainImagePath}">
                                        <img src="${fn:escapeXml(packageBooking.mainImagePath)}" alt="${fn:escapeXml(packageBooking.packageTitle)}">
                                    </c:if>
                                    <c:if test="${empty packageBooking.mainImagePath}">
                                        <div class="mp-package-no-image">${mypageItemsPackageIconLabel}</div>
                                    </c:if>
                                    <div>
                                        <strong><spring:message code="mypage.booking.peopleReserved"/></strong>
                                        <span>
                                            <fmt:formatDate value="${packageBooking.startDate}" pattern="yyyy-MM-dd"/>
                                            ~
                                            <fmt:formatDate value="${packageBooking.endDate}" pattern="yyyy-MM-dd"/>
                                        </span>
                                        <p>${packageBooking.packageSummary}</p>
                                    </div>
                                </div>

                                <div class="mp-flight-payment">
                                    <div><span><spring:message code="mypage.booking.peopleCount"/></span><strong><spring:message code="mypage.booking.people"/></strong></div>
                                    <div><span><spring:message code="mypage.booking.unitPrice"/></span><strong><fmt:formatNumber value="${packageBooking.unitPrice}" pattern="#,##0"/> C</strong></div>
                                    <div><span><spring:message code="mypage.booking.usedCash"/></span><strong><fmt:formatNumber value="${packageBooking.usedCash}" pattern="#,##0"/> C</strong></div>
                                    <div><span><spring:message code="mypage.booking.usedMileage"/></span><strong><fmt:formatNumber value="${packageBooking.usedMileage}" pattern="#,##0"/> M</strong></div>
                                    <div class="total"><span><spring:message code="mypage.booking.totalAmount"/></span><strong><fmt:formatNumber value="${packageBooking.totalPrice}" pattern="#,##0"/> C</strong></div>
                                    <div><span><spring:message code="mypage.booking.bookedAt"/></span><strong><fmt:formatDate value="${packageBooking.bookedAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                    <c:if test="${packageBooking.bookingStatus eq 'CANCELLED'}">
                                        <div><span><spring:message code="mypage.booking.cancelledAt"/></span><strong><fmt:formatDate value="${packageBooking.cancelledAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                        <div>
                                            <span><spring:message code="mypage.booking.cancelReason"/></span>
                                            <strong>
                                                    <c:choose>
                                                        <c:when test="${empty packageBooking.cancelReason}">${mypageNoneLabel}</c:when>
                                                        <c:otherwise>${packageBooking.cancelReason}</c:otherwise>
                                                    </c:choose>
                                            </strong>
                                        </div>
                                    </c:if>
                                </div>

                                <p class="mp-flight-mock-note"><spring:message code="mypage.booking.mockPackage"/></p>
                                <c:if test="${packageBooking.bookingStatus eq 'BOOKED'}">
                                    <form class="mp-package-cancel-form"
                                          action="${pageContext.request.contextPath}/packages/bookings/${packageBooking.packageBookingIdx}/cancel"
                                          method="post">
                                        <label for="package-cancel-reason-${packageBooking.packageBookingIdx}"><spring:message code="mypage.booking.packageCancelReasonLabel"/></label>
                                        <textarea id="package-cancel-reason-${packageBooking.packageBookingIdx}"
                                                  name="cancelReason"
                                                  maxlength="500"
                                                  placeholder="${bookingCancelPlaceholder}"></textarea>
                                        <button type="submit"><spring:message code="mypage.booking.cancelAndRefund"/></button>
                                    </form>
                                </c:if>
                            </article>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>
<%@ include file="../common/footer.jsp" %>
</body>
</html>
