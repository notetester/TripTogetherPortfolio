<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageCSS" value="mypage/mypage.css"/>
<%@ include file="../common/header.jsp" %>
<body>
<spring:message code="mypage.common.status.reserved" var="statusReserved"/>
<spring:message code="mypage.common.status.cancelled" var="statusCancelled"/>
<spring:message code="mypage.booking.cancelPlaceholder" var="bookingCancelPlaceholder"/>
<spring:message code="mypage.none" var="mypageNoneLabel"/>
<main class="mp-container">
    <div class="mp-card">
        <div class="mp-card-head">
            <div class="mp-card-title">
                <span class="mp-card-icon">✈️</span>
                <spring:message code="mypage.card.flightBookings"/>
                <span class="mp-card-count">${flightBookingCount}</span>
            </div>
            <a href="${pageContext.request.contextPath}/mypage" class="mp-card-more"><spring:message code="mypage.common.backToMypage"/></a>
        </div>
        <div class="mp-card-body">
            <c:if test="${not empty flightBookingMessage}">
                <div class="mp-package-booking-alert success">${flightBookingMessage}</div>
            </c:if>
            <c:if test="${not empty flightBookingError}">
                <div class="mp-package-booking-alert error">${flightBookingError}</div>
            </c:if>

            <c:choose>
                <c:when test="${empty flightBookingList}">
                    <div class="mp-empty">
                        <div class="mp-empty-icon">✈️</div>
                        <spring:message code="mypage.empty.flightBookings"/>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="mp-flight-booking-grid">
                        <c:forEach var="booking" items="${flightBookingList}">
                            <c:set var="bookingStatusLabel" value="${statusReserved}"/>
                            <c:if test="${booking.status eq 'CANCELLED'}">
                                <c:set var="bookingStatusLabel" value="${statusCancelled}"/>
                            </c:if>

                            <article class="mp-flight-ticket">
                                <div class="mp-flight-ticket-head">
                                    <div>
                                        <span class="mp-flight-status">${bookingStatusLabel}</span>
                                        <h4><spring:message code="mypage.booking.flightRoundTrip" arguments="${booking.spotName}"/></h4>
                                        <p><spring:message code="mypage.booking.purchaseNo" arguments="${booking.purchaseNo}"/></p>
                                    </div>
                                    <div class="mp-flight-ticket-price">
                                        <span><spring:message code="mypage.booking.finalPayment"/></span>
                                        <strong><fmt:formatNumber value="${booking.finalAmount}" pattern="#,##0"/> C</strong>
                                    </div>
                                </div>

                                <div class="mp-flight-itinerary">
                                    <div class="mp-flight-itinerary-item">
                                        <span class="mp-flight-route-tag"><spring:message code="mypage.booking.outbound"/></span>
                                        <strong>${booking.originAirportCode} → ${booking.destinationAirportCode}</strong>
                                        <p>${booking.airlineName} · ${booking.flightNo}</p>
                                        <dl>
                                            <dt><spring:message code="mypage.booking.departure"/></dt>
                                            <dd><fmt:formatDate value="${booking.departureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                            <dt><spring:message code="mypage.booking.arrival"/></dt>
                                            <dd><fmt:formatDate value="${booking.arrivalTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                        </dl>
                                    </div>
                                    <div class="mp-flight-itinerary-item">
                                        <span class="mp-flight-route-tag return"><spring:message code="mypage.booking.return"/></span>
                                        <strong>${booking.returnOriginAirportCode} → ${booking.returnDestinationAirportCode}</strong>
                                        <p>${booking.returnAirlineName} · ${booking.returnFlightNo}</p>
                                        <dl>
                                            <dt><spring:message code="mypage.booking.departure"/></dt>
                                            <dd><fmt:formatDate value="${booking.returnDepartureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                            <dt><spring:message code="mypage.booking.arrival"/></dt>
                                            <dd><fmt:formatDate value="${booking.returnArrivalTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                        </dl>
                                    </div>
                                </div>

                                <div class="mp-flight-payment">
                                    <div><span><spring:message code="mypage.booking.originalAmount"/></span><strong><fmt:formatNumber value="${booking.originalAmount}" pattern="#,##0"/> C</strong></div>
                                    <div><span><spring:message code="mypage.booking.gradeDiscount"/></span><strong>${booking.discountRate}% · -<fmt:formatNumber value="${booking.discountAmount}" pattern="#,##0"/> C</strong></div>
                                    <div><span><spring:message code="mypage.booking.usedCash"/></span><strong><fmt:formatNumber value="${booking.usedCash}" pattern="#,##0"/> C</strong></div>
                                    <div><span><spring:message code="mypage.booking.usedMileage"/></span><strong><fmt:formatNumber value="${booking.usedMileage}" pattern="#,##0"/> M</strong></div>
                                    <div class="total"><span><spring:message code="mypage.booking.finalAmount"/></span><strong><fmt:formatNumber value="${booking.finalAmount}" pattern="#,##0"/> C</strong></div>
                                    <div><span><spring:message code="mypage.booking.paidAt"/></span><strong><fmt:formatDate value="${booking.paidAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                    <c:if test="${booking.status eq 'CANCELLED'}">
                                        <div>
                                            <span><spring:message code="mypage.booking.cancelReason"/></span>
                                            <strong>
                                                <c:choose>
                                                    <c:when test="${empty booking.cancelReason}">${mypageNoneLabel}</c:when>
                                                    <c:otherwise>${booking.cancelReason}</c:otherwise>
                                                </c:choose>
                                            </strong>
                                        </div>
                                    </c:if>
                                </div>

                                <p class="mp-flight-mock-note"><spring:message code="mypage.booking.mockFlight"/></p>
                                <c:if test="${booking.status eq 'COMPLETED'}">
                                    <form class="mp-package-cancel-form"
                                          action="${pageContext.request.contextPath}/flight/purchases/${booking.flightPurchaseIdx}/cancel"
                                          method="post">
                                        <label for="flight-cancel-reason-${booking.flightPurchaseIdx}"><spring:message code="mypage.booking.flightCancelReasonLabel"/></label>
                                        <textarea id="flight-cancel-reason-${booking.flightPurchaseIdx}"
                                                  name="cancelReason"
                                                  maxlength="500"
                                                  placeholder="${bookingCancelPlaceholder}"></textarea>
                                        <button type="submit"><spring:message code="mypage.booking.cancelFlightAndRefund"/></button>
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
