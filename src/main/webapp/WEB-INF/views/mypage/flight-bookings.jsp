<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_mypage_common_status_reserved" code="mypage.common.status.reserved"/>
<spring:message var="msg_mypage_common_status_cancelled" code="mypage.common.status.cancelled"/>
<spring:message var="msg_mypage_booking_cancelPlaceholder" code="mypage.booking.cancelPlaceholder"/>
<spring:message var="msg_mypage_none" code="mypage.none"/>
<spring:message var="msg_mypage_card_flightBookings" code="mypage.card.flightBookings"/>
<spring:message var="msg_mypage_common_backToMypage" code="mypage.common.backToMypage"/>
<spring:message var="msg_mypage_empty_flightBookings" code="mypage.empty.flightBookings"/>
<spring:message var="msg_mypage_booking_flightRoundTrip" code="mypage.booking.flightRoundTrip"/>
<spring:message var="msg_mypage_booking_purchaseNo" code="mypage.booking.purchaseNo"/>
<spring:message var="msg_mypage_booking_finalPayment" code="mypage.booking.finalPayment"/>
<spring:message var="msg_mypage_booking_outbound" code="mypage.booking.outbound"/>
<spring:message var="msg_mypage_booking_departure" code="mypage.booking.departure"/>
<spring:message var="msg_mypage_booking_arrival" code="mypage.booking.arrival"/>
<spring:message var="msg_mypage_booking_return" code="mypage.booking.return"/>
<spring:message var="msg_mypage_booking_originalAmount" code="mypage.booking.originalAmount"/>
<spring:message var="msg_mypage_booking_gradeDiscount" code="mypage.booking.gradeDiscount"/>
<spring:message var="msg_mypage_booking_usedCash" code="mypage.booking.usedCash"/>
<spring:message var="msg_mypage_booking_usedMileage" code="mypage.booking.usedMileage"/>
<spring:message var="msg_mypage_booking_finalAmount" code="mypage.booking.finalAmount"/>
<spring:message var="msg_mypage_booking_paidAt" code="mypage.booking.paidAt"/>
<spring:message var="msg_mypage_booking_cancelReason" code="mypage.booking.cancelReason"/>
<spring:message var="msg_mypage_booking_mockFlight" code="mypage.booking.mockFlight"/>
<spring:message var="msg_mypage_booking_flightCancelReasonLabel" code="mypage.booking.flightCancelReasonLabel"/>
<spring:message var="msg_mypage_booking_cancelFlightAndRefund" code="mypage.booking.cancelFlightAndRefund"/>
<c:set var="pageCSS" value="mypage/mypage.css"/>
<%@ include file="../common/header.jsp" %>
<body>


<main class="mp-container">
    <div class="mp-card">
        <div class="mp-card-head">
            <div class="mp-card-title">
                <span class="mp-card-icon">✈️</span>
                ${msg_mypage_card_flightBookings}
                <span class="mp-card-count">${flightBookingCount}</span>
            </div>
            <a href="${pageContext.request.contextPath}/mypage" class="mp-card-more">${msg_mypage_common_backToMypage}</a>
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
                        ${msg_mypage_empty_flightBookings}
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="mp-flight-booking-grid">
                        <c:forEach var="booking" items="${flightBookingList}">
                            <c:set var="bookingStatusLabel" value="${msg_mypage_common_status_reserved}"/>
                            <c:if test="${booking.status eq 'CANCELLED'}">
                                <c:set var="bookingStatusLabel" value="${msg_mypage_common_status_cancelled}"/>
                            </c:if>

                            <article class="mp-flight-ticket">
                                <div class="mp-flight-ticket-head">
                                    <div>
                                        <span class="mp-flight-status">${bookingStatusLabel}</span>
                                        <h4>${msg_mypage_booking_flightRoundTrip}</h4>
                                        <p>${msg_mypage_booking_purchaseNo}</p>
                                    </div>
                                    <div class="mp-flight-ticket-price">
                                        <span>${msg_mypage_booking_finalPayment}</span>
                                        <strong><fmt:formatNumber value="${booking.finalAmount}" pattern="#,##0"/> C</strong>
                                    </div>
                                </div>

                                <div class="mp-flight-itinerary">
                                    <div class="mp-flight-itinerary-item">
                                        <span class="mp-flight-route-tag">${msg_mypage_booking_outbound}</span>
                                        <strong>${booking.originAirportCode} → ${booking.destinationAirportCode}</strong>
                                        <p>${booking.airlineName} · ${booking.flightNo}</p>
                                        <dl>
                                            <dt>${msg_mypage_booking_departure}</dt>
                                            <dd><fmt:formatDate value="${booking.departureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                            <dt>${msg_mypage_booking_arrival}</dt>
                                            <dd><fmt:formatDate value="${booking.arrivalTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                        </dl>
                                    </div>
                                    <div class="mp-flight-itinerary-item">
                                        <span class="mp-flight-route-tag return">${msg_mypage_booking_return}</span>
                                        <strong>${booking.returnOriginAirportCode} → ${booking.returnDestinationAirportCode}</strong>
                                        <p>${booking.returnAirlineName} · ${booking.returnFlightNo}</p>
                                        <dl>
                                            <dt>${msg_mypage_booking_departure}</dt>
                                            <dd><fmt:formatDate value="${booking.returnDepartureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                            <dt>${msg_mypage_booking_arrival}</dt>
                                            <dd><fmt:formatDate value="${booking.returnArrivalTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                        </dl>
                                    </div>
                                </div>

                                <div class="mp-flight-payment">
                                    <div><span>${msg_mypage_booking_originalAmount}</span><strong><fmt:formatNumber value="${booking.originalAmount}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${msg_mypage_booking_gradeDiscount}</span><strong>${booking.discountRate}% · -<fmt:formatNumber value="${booking.discountAmount}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${msg_mypage_booking_usedCash}</span><strong><fmt:formatNumber value="${booking.usedCash}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${msg_mypage_booking_usedMileage}</span><strong><fmt:formatNumber value="${booking.usedMileage}" pattern="#,##0"/> M</strong></div>
                                    <div class="total"><span>${msg_mypage_booking_finalAmount}</span><strong><fmt:formatNumber value="${booking.finalAmount}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${msg_mypage_booking_paidAt}</span><strong><fmt:formatDate value="${booking.paidAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                    <c:if test="${booking.status eq 'CANCELLED'}">
                                        <div>
                                            <span>${msg_mypage_booking_cancelReason}</span>
                                            <strong>
                                                <c:choose>
                                                    <c:when test="${empty booking.cancelReason}">${msg_mypage_none}</c:when>
                                                    <c:otherwise>${booking.cancelReason}</c:otherwise>
                                                </c:choose>
                                            </strong>
                                        </div>
                                    </c:if>
                                </div>

                                <p class="mp-flight-mock-note">${msg_mypage_booking_mockFlight}</p>
                                <c:if test="${booking.status eq 'COMPLETED'}">
                                    <form class="mp-package-cancel-form"
                                          action="${pageContext.request.contextPath}/flight/purchases/${booking.flightPurchaseIdx}/cancel"
                                          method="post">
                                        <label for="flight-cancel-reason-${booking.flightPurchaseIdx}">${msg_mypage_booking_flightCancelReasonLabel}</label>
                                        <textarea id="flight-cancel-reason-${booking.flightPurchaseIdx}"
                                                  name="cancelReason"
                                                  maxlength="500"
                                                  placeholder="${msg_mypage_booking_cancelPlaceholder}"></textarea>
                                        <button type="submit">${msg_mypage_booking_cancelFlightAndRefund}</button>
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
