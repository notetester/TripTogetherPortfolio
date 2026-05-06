<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_f959d9029e" code="mypage.common.backToMypage"/>
<spring:message var="autoMsg_20fe795003" code="mypage.booking.flightRoundTrip"/>
<spring:message var="autoMsg_109a24887e" code="mypage.booking.purchaseNo"/>
<spring:message var="autoMsg_4d411b93e7" code="mypage.booking.finalPayment"/>
<spring:message var="autoMsg_82b05e752e" code="mypage.booking.outbound"/>
<spring:message var="autoMsg_f1c2964638" code="mypage.booking.departure"/>
<spring:message var="autoMsg_228552077a" code="mypage.booking.arrival"/>
<spring:message var="autoMsg_6f06480681" code="mypage.booking.return"/>
<spring:message var="autoMsg_01cd747c51" code="mypage.booking.originalAmount"/>
<spring:message var="autoMsg_cdc240b92a" code="mypage.booking.gradeDiscount"/>
<spring:message var="autoMsg_dec42b3d16" code="mypage.booking.usedCash"/>
<spring:message var="autoMsg_e300d39ddd" code="mypage.booking.usedMileage"/>
<spring:message var="autoMsg_d0bc2b37ca" code="mypage.booking.finalAmount"/>
<spring:message var="autoMsg_d7abb197fc" code="mypage.booking.paidAt"/>
<spring:message var="autoMsg_d95cabae0d" code="mypage.booking.cancelReason"/>
<spring:message var="autoMsg_a4eaeaaae8" code="mypage.booking.mockFlight"/>
<spring:message var="autoMsg_c9d619f456" code="mypage.booking.flightCancelReasonLabel"/>
<spring:message var="autoMsg_b43aadbbda" code="mypage.booking.cancelFlightAndRefund"/>
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
            <a href="${pageContext.request.contextPath}/mypage" class="mp-card-more">${autoMsg_f959d9029e}</a>
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
                                        <h4>${autoMsg_20fe795003}</h4>
                                        <p>${autoMsg_109a24887e}</p>
                                    </div>
                                    <div class="mp-flight-ticket-price">
                                        <span>${autoMsg_4d411b93e7}</span>
                                        <strong><fmt:formatNumber value="${booking.finalAmount}" pattern="#,##0"/> C</strong>
                                    </div>
                                </div>

                                <div class="mp-flight-itinerary">
                                    <div class="mp-flight-itinerary-item">
                                        <span class="mp-flight-route-tag">${autoMsg_82b05e752e}</span>
                                        <strong>${booking.originAirportCode} → ${booking.destinationAirportCode}</strong>
                                        <p>${booking.airlineName} · ${booking.flightNo}</p>
                                        <dl>
                                            <dt>${autoMsg_f1c2964638}</dt>
                                            <dd><fmt:formatDate value="${booking.departureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                            <dt>${autoMsg_228552077a}</dt>
                                            <dd><fmt:formatDate value="${booking.arrivalTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                        </dl>
                                    </div>
                                    <div class="mp-flight-itinerary-item">
                                        <span class="mp-flight-route-tag return">${autoMsg_6f06480681}</span>
                                        <strong>${booking.returnOriginAirportCode} → ${booking.returnDestinationAirportCode}</strong>
                                        <p>${booking.returnAirlineName} · ${booking.returnFlightNo}</p>
                                        <dl>
                                            <dt>${autoMsg_f1c2964638}</dt>
                                            <dd><fmt:formatDate value="${booking.returnDepartureTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                            <dt>${autoMsg_228552077a}</dt>
                                            <dd><fmt:formatDate value="${booking.returnArrivalTimeDate}" pattern="yyyy-MM-dd HH:mm"/></dd>
                                        </dl>
                                    </div>
                                </div>

                                <div class="mp-flight-payment">
                                    <div><span>${autoMsg_01cd747c51}</span><strong><fmt:formatNumber value="${booking.originalAmount}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${autoMsg_cdc240b92a}</span><strong>${booking.discountRate}% · -<fmt:formatNumber value="${booking.discountAmount}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${autoMsg_dec42b3d16}</span><strong><fmt:formatNumber value="${booking.usedCash}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${autoMsg_e300d39ddd}</span><strong><fmt:formatNumber value="${booking.usedMileage}" pattern="#,##0"/> M</strong></div>
                                    <div class="total"><span>${autoMsg_d0bc2b37ca}</span><strong><fmt:formatNumber value="${booking.finalAmount}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${autoMsg_d7abb197fc}</span><strong><fmt:formatDate value="${booking.paidAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                    <c:if test="${booking.status eq 'CANCELLED'}">
                                        <div>
                                            <span>${autoMsg_d95cabae0d}</span>
                                            <strong>
                                                <c:choose>
                                                    <c:when test="${empty booking.cancelReason}">${mypageNoneLabel}</c:when>
                                                    <c:otherwise>${booking.cancelReason}</c:otherwise>
                                                </c:choose>
                                            </strong>
                                        </div>
                                    </c:if>
                                </div>

                                <p class="mp-flight-mock-note">${autoMsg_a4eaeaaae8}</p>
                                <c:if test="${booking.status eq 'COMPLETED'}">
                                    <form class="mp-package-cancel-form"
                                          action="${pageContext.request.contextPath}/flight/purchases/${booking.flightPurchaseIdx}/cancel"
                                          method="post">
                                        <label for="flight-cancel-reason-${booking.flightPurchaseIdx}">${autoMsg_c9d619f456}</label>
                                        <textarea id="flight-cancel-reason-${booking.flightPurchaseIdx}"
                                                  name="cancelReason"
                                                  maxlength="500"
                                                  placeholder="${bookingCancelPlaceholder}"></textarea>
                                        <button type="submit">${autoMsg_b43aadbbda}</button>
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
