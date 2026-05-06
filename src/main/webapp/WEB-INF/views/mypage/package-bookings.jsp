<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_5c4049332f" code="mypage.common.backToMypage"/>
<spring:message var="autoMsg_dee1874577" code="mypage.booking.reservationNo"/>
<spring:message var="autoMsg_700fe4c9cf" code="mypage.booking.totalPayment"/>
<spring:message var="autoMsg_c47d3d2af9" code="mypage.booking.peopleReserved"/>
<spring:message var="autoMsg_b09701181a" code="mypage.booking.peopleCount"/>
<spring:message var="autoMsg_0fcd0ed679" code="mypage.booking.people"/>
<spring:message var="autoMsg_87598e1919" code="mypage.booking.unitPrice"/>
<spring:message var="autoMsg_8e1e267e34" code="mypage.booking.usedCash"/>
<spring:message var="autoMsg_40e0d54d4b" code="mypage.booking.usedMileage"/>
<spring:message var="autoMsg_4190f15acf" code="mypage.booking.totalAmount"/>
<spring:message var="autoMsg_2e288fc1bd" code="mypage.booking.bookedAt"/>
<spring:message var="autoMsg_e29975ad22" code="mypage.booking.cancelledAt"/>
<spring:message var="autoMsg_42d31bcfa9" code="mypage.booking.cancelReason"/>
<spring:message var="autoMsg_ddbe5aba5e" code="mypage.booking.mockPackage"/>
<spring:message var="autoMsg_5ece318b93" code="mypage.booking.packageCancelReasonLabel"/>
<spring:message var="autoMsg_f0d1abaacc" code="mypage.booking.cancelAndRefund"/>
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
            <a href="${pageContext.request.contextPath}/mypage" class="mp-card-more">${autoMsg_5c4049332f}</a>
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
                                        <p>${packageBooking.spotName} &middot; ${autoMsg_dee1874577}</p>
                                    </div>
                                    <div class="mp-flight-ticket-price">
                                        <span>${autoMsg_700fe4c9cf}</span>
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
                                        <strong>${autoMsg_c47d3d2af9}</strong>
                                        <span>
                                            <fmt:formatDate value="${packageBooking.startDate}" pattern="yyyy-MM-dd"/>
                                            ~
                                            <fmt:formatDate value="${packageBooking.endDate}" pattern="yyyy-MM-dd"/>
                                        </span>
                                        <p>${packageBooking.packageSummary}</p>
                                    </div>
                                </div>

                                <div class="mp-flight-payment">
                                    <div><span>${autoMsg_b09701181a}</span><strong>${autoMsg_0fcd0ed679}</strong></div>
                                    <div><span>${autoMsg_87598e1919}</span><strong><fmt:formatNumber value="${packageBooking.unitPrice}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${autoMsg_8e1e267e34}</span><strong><fmt:formatNumber value="${packageBooking.usedCash}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${autoMsg_40e0d54d4b}</span><strong><fmt:formatNumber value="${packageBooking.usedMileage}" pattern="#,##0"/> M</strong></div>
                                    <div class="total"><span>${autoMsg_4190f15acf}</span><strong><fmt:formatNumber value="${packageBooking.totalPrice}" pattern="#,##0"/> C</strong></div>
                                    <div><span>${autoMsg_2e288fc1bd}</span><strong><fmt:formatDate value="${packageBooking.bookedAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                    <c:if test="${packageBooking.bookingStatus eq 'CANCELLED'}">
                                        <div><span>${autoMsg_e29975ad22}</span><strong><fmt:formatDate value="${packageBooking.cancelledAtDate}" pattern="yyyy-MM-dd HH:mm"/></strong></div>
                                        <div>
                                            <span>${autoMsg_42d31bcfa9}</span>
                                            <strong>
                                                    <c:choose>
                                                        <c:when test="${empty packageBooking.cancelReason}">${mypageNoneLabel}</c:when>
                                                        <c:otherwise>${packageBooking.cancelReason}</c:otherwise>
                                                    </c:choose>
                                            </strong>
                                        </div>
                                    </c:if>
                                </div>

                                <p class="mp-flight-mock-note">${autoMsg_ddbe5aba5e}</p>
                                <c:if test="${packageBooking.bookingStatus eq 'BOOKED'}">
                                    <form class="mp-package-cancel-form"
                                          action="${pageContext.request.contextPath}/packages/bookings/${packageBooking.packageBookingIdx}/cancel"
                                          method="post">
                                        <label for="package-cancel-reason-${packageBooking.packageBookingIdx}">${autoMsg_5ece318b93}</label>
                                        <textarea id="package-cancel-reason-${packageBooking.packageBookingIdx}"
                                                  name="cancelReason"
                                                  maxlength="500"
                                                  placeholder="${bookingCancelPlaceholder}"></textarea>
                                        <button type="submit">${autoMsg_f0d1abaacc}</button>
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
