<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_mypage_common_status_booked" code="mypage.common.status.booked"/>
<spring:message var="msg_mypage_common_status_cancelled" code="mypage.common.status.cancelled"/>
<spring:message var="msg_mypage_common_status_completed" code="mypage.common.status.completed"/>
<spring:message var="msg_mypage_booking_cancelPlaceholder" code="mypage.booking.cancelPlaceholder"/>
<spring:message var="msg_mypage_items_packageIcon" code="mypage.items.packageIcon"/>
<spring:message var="msg_mypage_none" code="mypage.none"/>
<spring:message var="msg_mypage_card_packageBookings" code="mypage.card.packageBookings"/>
<spring:message var="msg_mypage_common_backToMypage" code="mypage.common.backToMypage"/>
<spring:message var="msg_mypage_empty_packageBookings" code="mypage.empty.packageBookings"/>
<spring:message var="msg_mypage_booking_reservationNo" code="mypage.booking.reservationNo"/>
<spring:message var="msg_mypage_booking_totalPayment" code="mypage.booking.totalPayment"/>
<spring:message var="msg_mypage_booking_peopleReserved" code="mypage.booking.peopleReserved"/>
<spring:message var="msg_mypage_booking_peopleCount" code="mypage.booking.peopleCount"/>
<spring:message var="msg_mypage_booking_people" code="mypage.booking.people"/>
<spring:message var="msg_mypage_booking_unitPrice" code="mypage.booking.unitPrice"/>
<spring:message var="msg_mypage_booking_usedCash" code="mypage.booking.usedCash"/>
<spring:message var="msg_mypage_booking_usedMileage" code="mypage.booking.usedMileage"/>
<spring:message var="msg_mypage_booking_totalAmount" code="mypage.booking.totalAmount"/>
<spring:message var="msg_mypage_booking_bookedAt" code="mypage.booking.bookedAt"/>
<spring:message var="msg_mypage_booking_cancelledAt" code="mypage.booking.cancelledAt"/>
<spring:message var="msg_mypage_booking_cancelReason" code="mypage.booking.cancelReason"/>
<spring:message var="msg_mypage_booking_mockPackage" code="mypage.booking.mockPackage"/>
<spring:message var="msg_mypage_booking_packageCancelReasonLabel" code="mypage.booking.packageCancelReasonLabel"/>
<spring:message var="msg_mypage_booking_cancelAndRefund" code="mypage.booking.cancelAndRefund"/>
<c:set var="pageCSS" value="mypage/mypage.css"/>
<%@ include file="../common/header.jsp" %>
<body>


<main class="mp-container">
    <div class="mp-card">
        <div class="mp-card-head">
            <div class="mp-card-title">
                <span class="mp-card-icon">🎒</span>
                ${msg_mypage_card_packageBookings}
                <span class="mp-card-count">${packageBookingCount}</span>
            </div>
            <a href="${pageContext.request.contextPath}/mypage" class="mp-card-more">${msg_mypage_common_backToMypage}</a>
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
                        ${msg_mypage_empty_packageBookings}
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="mp-flight-booking-grid mp-package-booking-grid">
                        <c:forEach var="packageBooking" items="${packageBookingList}">
                            <c:set var="packageStatusLabel" value="${msg_mypage_common_status_booked}"/>
                            <c:if test="${packageBooking.bookingStatus eq 'CANCELLED'}">
                                <c:set var="packageStatusLabel" value="${msg_mypage_common_status_cancelled}"/>
                            </c:if>
                            <c:if test="${packageBooking.bookingStatus eq 'COMPLETED'}">
                                <c:set var="packageStatusLabel" value="${msg_mypage_common_status_completed}"/>
                            </c:if>

                            <article class="mp-flight-ticket mp-package-ticket">
                                <div class="mp-flight-ticket-head">
                                    <div>
                                        <span class="mp-flight-status mp-package-status">${packageStatusLabel}</span>
                                        <h4>${packageBooking.packageTitle}</h4>
                                        <p>${packageBooking.spotName} &middot; ${msg_mypage_booking_reservationNo}</p>
                                    </div>
                                    <div class="mp-flight-ticket-price">
                                        <span>${msg_mypage_booking_totalPayment}</span>
                                        <strong><fmt:formatNumber value="${packageBooking.totalPrice}" pattern="#,##0"/> C</strong>
                                    </div>
                                </div>

                                <div class="mp-package-summary-box">
                                    <c:if test="${not empty packageBooking.mainImagePath}">
                                        <img src="${fn:escapeXml(packageBooking.mainImagePath)}" alt="${fn:escapeXml(packageBooking.packageTitle)}">
                                    </c:if>
                                    <c:if test="${empty packageBooking.mainImagePath}">
                                        <div class="mp-package-no-image">${msg_mypage_items_packageIcon}</div>
                                    </c:if>
                                    <div>
                                        <strong>${msg_mypage_booking_peopleReserved}</strong>
                                        <span>
                                            <fmt:formatDate value="${packageBooking.startDate}" pattern="yyyy-MM-dd"/>
                                            ~
                                            <fmt:formatDate value="${packageBooking.endDate}" pattern="yyyy-MM-dd"/>
                                        </span>
                                        <p>${packageBooking.packageSummary}</p>
                                    </div>
                                </div>

                                <div class="mp-flight-payment">
                                    <div><span>${msg_mypage_booking_peopleCount}</span><strong>${msg_mypage_booking_people}</strong></div>
                                    <div><span>${msg_mypage_booking_unitPrice}</span><strong><fmt:formatNumber value="${packageBooking.unitPrice}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${msg_mypage_booking_usedCash}</span><strong><fmt:formatNumber value="${packageBooking.usedCash}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${msg_mypage_booking_usedMileage}</span><strong><fmt:formatNumber value="${packageBooking.usedMileage}" pattern="#,##0"/> M</strong></div>
                                    <div class="total"><span>${msg_mypage_booking_totalAmount}</span><strong><fmt:formatNumber value="${packageBooking.totalPrice}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${msg_mypage_booking_bookedAt}</span><strong><fmt:formatDate value="${packageBooking.bookedAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                    <c:if test="${packageBooking.bookingStatus eq 'CANCELLED'}">
                                        <div><span>${msg_mypage_booking_cancelledAt}</span><strong><fmt:formatDate value="${packageBooking.cancelledAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                        <div>
                                            <span>${msg_mypage_booking_cancelReason}</span>
                                            <strong>
                                                    <c:choose>
                                                        <c:when test="${empty packageBooking.cancelReason}">${msg_mypage_none}</c:when>
                                                        <c:otherwise>${packageBooking.cancelReason}</c:otherwise>
                                                    </c:choose>
                                            </strong>
                                        </div>
                                    </c:if>
                                </div>

                                <p class="mp-flight-mock-note">${msg_mypage_booking_mockPackage}</p>
                                <c:if test="${packageBooking.bookingStatus eq 'BOOKED'}">
                                    <form class="mp-package-cancel-form"
                                          action="${pageContext.request.contextPath}/packages/bookings/${packageBooking.packageBookingIdx}/cancel"
                                          method="post">
                                        <label for="package-cancel-reason-${packageBooking.packageBookingIdx}">${msg_mypage_booking_packageCancelReasonLabel}</label>
                                        <textarea id="package-cancel-reason-${packageBooking.packageBookingIdx}"
                                                  name="cancelReason"
                                                  maxlength="500"
                                                  placeholder="${msg_mypage_booking_cancelPlaceholder}"></textarea>
                                        <button type="submit">${msg_mypage_booking_cancelAndRefund}</button>
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
