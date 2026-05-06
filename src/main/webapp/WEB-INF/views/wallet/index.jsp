<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_b1a85f437b" code="wallet.hero.eyebrow"/>
<spring:message var="autoMsg_6b8feba10d" code="wallet.title"/>
<spring:message var="autoMsg_d1593b62d8" code="wallet.subtitle"/>
<spring:message var="autoMsg_075081910a" code="wallet.summary.title"/>
<spring:message var="autoMsg_9390744832" code="wallet.summary.desc"/>
<spring:message var="autoMsg_3c641e60e6" code="wallet.stat.cash"/>
<spring:message var="autoMsg_0a8108cb73" code="wallet.stat.unit.cash"/>
<spring:message var="autoMsg_6c0d985cca" code="wallet.stat.mileage"/>
<spring:message var="autoMsg_beb206d713" code="wallet.stat.unit.mileage"/>
<spring:message var="autoMsg_b16d5c48da" code="wallet.stat.point"/>
<spring:message var="autoMsg_3a3ee1ecd1" code="wallet.stat.unit.point"/>
<spring:message var="autoMsg_7a609429bc" code="wallet.stat.grade"/>
<spring:message var="autoMsg_786ae3237f" code="wallet.grade.BRONZE"/>
<spring:message var="autoMsg_82be17362b" code="wallet.grade.SILVER"/>
<spring:message var="autoMsg_f2ab2f3614" code="wallet.grade.GOLD"/>
<spring:message var="autoMsg_f7a7e30e3a" code="wallet.grade.DIAMOND"/>
<spring:message var="autoMsg_0d602f149d" code="wallet.grade.PLATINUM"/>
<spring:message var="autoMsg_99d63b8624" code="wallet.stat.level"/>
<spring:message var="autoMsg_2df8da4f42" code="wallet.stat.exp"/>
<spring:message var="autoMsg_0ca06b34b8" code="wallet.stat.unit.exp"/>
<spring:message var="autoMsg_0865d7ef76" code="wallet.charge.title"/>
<spring:message var="autoMsg_9d8f3e02e1" code="wallet.charge.toss.desc"/>
<spring:message var="autoMsg_d1d608510a" code="wallet.charge.desc"/>
<spring:message var="autoMsg_80c6f32022" code="wallet.charge.amount"/>
<spring:message var="autoMsg_96ce44ee30" code="wallet.charge.currency"/>
<spring:message var="autoMsg_a77bcc476a" code="wallet.charge.preview.cash"/>
<spring:message var="autoMsg_79fae20512" code="wallet.charge.preview.mileage"/>
<spring:message var="autoMsg_167eda03e5" code="wallet.charge.toss.notice"/>
<spring:message var="autoMsg_4b93fb4d22" code="wallet.notice.mileage"/>
<spring:message var="autoMsg_31920a4442" code="wallet.notice.history"/>
<spring:message var="autoMsg_0da68098bf" code="wallet.charge.submit"/>
<spring:message var="autoMsg_7bc0d357c4" code="wallet.notice.simulation"/>
<spring:message var="autoMsg_79718a2264" code="wallet.payment.title"/>
<spring:message var="autoMsg_cb0d91dcde" code="wallet.payment.desc"/>
<spring:message var="autoMsg_4b44f9f44a" code="wallet.payment.empty"/>
<spring:message var="autoMsg_3caa7735d6" code="wallet.payment.amount"/>
<spring:message var="autoMsg_c9320ba37b" code="wallet.payment.mileage"/>
<spring:message var="autoMsg_316c3d64e5" code="wallet.paymentStatus.COMPLETED"/>
<spring:message var="autoMsg_0c03b341ab" code="wallet.paymentStatus.READY"/>
<spring:message var="autoMsg_89689bb5fe" code="wallet.paymentStatus.CANCELLED"/>
<spring:message var="autoMsg_48d293c247" code="wallet.paymentStatus.REFUNDED"/>
<spring:message var="autoMsg_440dc16467" code="wallet.pagination.prev"/>
<spring:message var="autoMsg_a3a432dc93" code="wallet.pagination.next"/>
<spring:message var="autoMsg_d1c1a399c0" code="wallet.history.title"/>
<spring:message var="autoMsg_ec16adff42" code="wallet.history.desc"/>
<spring:message var="autoMsg_dec8cfbb0c" code="wallet.history.empty"/>
<spring:message var="autoMsg_62ad5bc79f" code="wallet.history.col.date"/>
<spring:message var="autoMsg_af88002b80" code="wallet.history.col.asset"/>
<spring:message var="autoMsg_73b5a84dc5" code="wallet.history.col.type"/>
<spring:message var="autoMsg_84ae511d73" code="wallet.history.col.amount"/>
<spring:message var="autoMsg_96afa6c7f5" code="wallet.history.col.balance"/>
<spring:message var="autoMsg_fb82e77b2d" code="wallet.history.col.detail"/>
<spring:message var="autoMsg_840513d3e8" code="wallet.assetType.CASH"/>
<spring:message var="autoMsg_3bea7830eb" code="wallet.assetType.MILEAGE"/>
<spring:message var="autoMsg_c316da6450" code="wallet.changeType.CHARGE"/>
<spring:message var="autoMsg_06d274e0ec" code="wallet.changeType.EARN"/>
<spring:message var="autoMsg_76a1c2899e" code="wallet.changeType.USE"/>
<spring:message var="autoMsg_570379d053" code="wallet.changeType.REFUND"/>
<spring:message var="autoMsg_17af56a0d4" code="wallet.changeType.ADJUST"/>
<spring:message var="autoMsg_a1c3287c0a" code="wallet.benefit.title"/>
<spring:message var="autoMsg_20e3c3d3c7" code="wallet.benefit.desc"/>
<spring:message var="autoMsg_9e8aee4870" code="wallet.benefit.banner.badge"/>
<spring:message var="autoMsg_93eb5f6a73" code="wallet.benefit.banner.line1"/>
<spring:message var="autoMsg_dd53942558" code="wallet.benefit.col.grade"/>
<spring:message var="autoMsg_b6a4c7d8d9" code="wallet.benefit.col.monthlyPayment"/>
<spring:message var="autoMsg_68e983ea4f" code="wallet.benefit.col.discountRate"/>
<spring:message var="autoMsg_2831d5d9a7" code="wallet.benefit.col.description"/>
<spring:message var="autoMsg_354134b6bf" code="wallet.benefit.empty"/>
<spring:message var="autoMsg_406f961687" code="wallet.benefit.current"/>
<spring:message var="autoMsg_fba88bc16d" code="wallet.benefit.amountUnit"/>
<spring:message var="autoMsg_422b2b6ab9" code="wallet.charge.limitMessage" javaScriptEscape="true"/>
<spring:message var="autoMsg_0c95cedc23" code="wallet.charge.error.min" javaScriptEscape="true"/>
<spring:message var="autoMsg_9ddfef77f3" code="wallet.charge.error.step" javaScriptEscape="true"/>
<spring:message var="autoMsg_c5a59fabd9" code="wallet.charge.toss.prepareError" javaScriptEscape="true"/>
<spring:message var="autoMsg_94fda74c36" code="wallet.charge.toss.requestError" javaScriptEscape="true"/>
<spring:message var="autoMsg_018ad2c6bf" code="wallet.charge.toss.sdkUnavailable" javaScriptEscape="true"/>
<spring:message var="autoMsg_fbca989720" code="wallet.payment.order.tossCharge" javaScriptEscape="true"/>
<spring:message var="autoMsg_ca6c210e07" code="wallet.charge.toss.unavailable" javaScriptEscape="true"/>
<spring:message var="autoMsg_a0b34eac97" code="wallet.benefit.toggle.show" javaScriptEscape="true"/>
<spring:message var="autoMsg_41b76b8240" code="wallet.benefit.toggle.hide" javaScriptEscape="true"/>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<c:set var="pageCSS" value="wallet/wallet.css"/>
<spring:message code="wallet.charge.limit" var="walletChargeLimitMessage"/>
<%@ include file="../common/header.jsp" %>
<body>

<div class="wallet-wrap">
    <div class="wallet-hero">
        <div class="wallet-hero__content">
            <p class="wallet-hero__eyebrow">${autoMsg_b1a85f437b}</p>
            <h1>${autoMsg_6b8feba10d}</h1>
            <p class="wallet-hero__desc">${autoMsg_d1593b62d8}</p>
        </div>
    </div>

    <div class="wallet-container">
        <c:if test="${not empty walletMessage}">
            <div class="wallet-alert wallet-alert--success">${walletMessage}</div>
        </c:if>
        <c:if test="${not empty walletError}">
            <div class="wallet-alert wallet-alert--error">${walletError}</div>
        </c:if>

        <section class="wallet-card">
            <div class="wallet-card__head">
                <h2>${autoMsg_075081910a}</h2>
                <p>${autoMsg_9390744832}</p>
            </div>
            <div class="wallet-summary-grid">
                <div class="wallet-stat wallet-stat--cash">
                    <div class="wallet-stat__label">${autoMsg_3c641e60e6}</div>
                    <div class="wallet-stat__value"><fmt:formatNumber value="${user.cashBalance}" pattern="#,##0"/> ${autoMsg_0a8108cb73}</div>
                </div>
                <div class="wallet-stat wallet-stat--mileage">
                    <div class="wallet-stat__label">${autoMsg_6c0d985cca}</div>
                    <div class="wallet-stat__value"><fmt:formatNumber value="${user.mileageBalance}" pattern="#,##0"/> ${autoMsg_beb206d713}</div>
                </div>
                <div class="wallet-stat wallet-stat--point">
                    <div class="wallet-stat__label">${autoMsg_b16d5c48da}</div>
                    <div class="wallet-stat__value"><fmt:formatNumber value="${user.pointBalance}" pattern="#,##0"/> ${autoMsg_3a3ee1ecd1}</div>
                </div>
                <div class="wallet-stat wallet-stat--grade">
                    <div class="wallet-stat__label">${autoMsg_7a609429bc}</div>
                    <div class="wallet-stat__value">
                        <c:choose>
                            <c:when test="${user.memberGrade eq 'BRONZE'}">${autoMsg_786ae3237f}</c:when>
                            <c:when test="${user.memberGrade eq 'SILVER'}">${autoMsg_82be17362b}</c:when>
                            <c:when test="${user.memberGrade eq 'GOLD'}">${autoMsg_f2ab2f3614}</c:when>
                            <c:when test="${user.memberGrade eq 'DIAMOND'}">${autoMsg_f7a7e30e3a}</c:when>
                            <c:when test="${user.memberGrade eq 'PLATINUM'}">${autoMsg_0d602f149d}</c:when>
                            <c:otherwise>${user.memberGrade}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="wallet-stat wallet-stat--level">
                    <div class="wallet-stat__label">${autoMsg_99d63b8624}</div>
                    <div class="wallet-stat__value">Lv.${user.levelNo}</div>
                </div>
                <div class="wallet-stat wallet-stat--exp">
                    <div class="wallet-stat__label">${autoMsg_2df8da4f42}</div>
                    <div class="wallet-stat__value"><fmt:formatNumber value="${user.expPoints}" pattern="#,##0"/> ${autoMsg_0ca06b34b8}</div>
                </div>
            </div>
        </section>

        <div class="wallet-two-col">
            <section class="wallet-card">
                <div class="wallet-card__head">
                    <h2>${autoMsg_0865d7ef76}</h2>
                    <c:choose>
                        <c:when test="${tossEnabled}">
                            <p>${autoMsg_9d8f3e02e1}</p>
                        </c:when>
                        <c:otherwise>
                            <p>${autoMsg_d1d608510a}</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="wallet-charge-presets">
                    <button type="button" class="wallet-preset-btn" onclick="setChargeAmount(10000)">10,000</button>
                    <button type="button" class="wallet-preset-btn" onclick="setChargeAmount(30000)">30,000</button>
                    <button type="button" class="wallet-preset-btn" onclick="setChargeAmount(50000)">50,000</button>
                    <button type="button" class="wallet-preset-btn" onclick="setChargeAmount(100000)">100,000</button>
                </div>

                <label for="amount">${autoMsg_80c6f32022}</label>
                <div class="wallet-charge-input">
                    <input id="amount" name="amount" type="number" min="1000" max="1000000" step="100" value="10000" required>
                    <span>${autoMsg_96ce44ee30}</span>
                </div>
                <p class="wallet-charge-limit" id="chargeLimitMessage">${walletChargeLimitMessage}</p>

                <div class="wallet-charge-preview">
                    <div>
                        <span>${autoMsg_a77bcc476a}</span>
                        <strong id="chargeCashPreview">10,000 C</strong>
                    </div>
                    <div>
                        <span>${autoMsg_79fae20512}</span>
                        <strong id="chargeMileagePreview">1,000 M</strong>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${tossEnabled}">
                        <button type="button" id="walletTossChargeButton" class="wallet-submit-btn" onclick="requestTossCharge()">
                            <spring:message code="wallet.charge.toss.button"/>
                        </button>
                        <ul class="wallet-notice-list">
                            <li>${autoMsg_167eda03e5}</li>
                            <li>${autoMsg_4b93fb4d22}</li>
                            <li>${autoMsg_31920a4442}</li>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <form class="wallet-charge-form" method="post" action="${pageContext.request.contextPath}/wallet/charge">
                            <button type="submit" class="wallet-submit-btn">${autoMsg_0da68098bf}</button>
                        </form>
                        <ul class="wallet-notice-list">
                            <li>${autoMsg_7bc0d357c4}</li>
                            <li>${autoMsg_4b93fb4d22}</li>
                            <li>${autoMsg_31920a4442}</li>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </section>

            <section class="wallet-card">
                <div class="wallet-card__head">
                    <h2>${autoMsg_79718a2264}</h2>
                    <p>${autoMsg_cb0d91dcde}</p>
                </div>

                <c:choose>
                    <c:when test="${empty paymentHistory}">
                        <div class="wallet-empty">${autoMsg_4b44f9f44a}</div>
                    </c:when>
                    <c:otherwise>
                        <div class="wallet-history-list">
                            <c:forEach var="payment" items="${paymentHistory}">
                                <div class="wallet-history-item wallet-pay-item">
                                    <div class="wallet-history-item__main">
                                        <strong>
                                        <c:choose>
                                                <c:when test="${payment.sourceType eq 'MANUAL_CHARGE'}">
                                                    <spring:message code="wallet.payment.order.manualCharge"/>
                                                </c:when>
                                                <c:when test="${payment.sourceType eq 'TOSS_CHARGE'}">
                                                    <spring:message code="wallet.payment.order.tossCharge"/>
                                                </c:when>
                                                <c:otherwise>
                                                    ${payment.orderName}
                                                </c:otherwise>
                                            </c:choose>
                                        </strong>
                                        <span>${fn:replace(fn:substring(payment.createdAt, 0, 16), 'T', ' ')}</span>
                                    </div>
                                    <div class="wallet-history-item__sub">
                                        <span>${autoMsg_3caa7735d6} <fmt:formatNumber value="${payment.finalAmount}" pattern="#,##0"/> C</span>
                                        <span>${autoMsg_c9320ba37b} +<fmt:formatNumber value="${payment.earnedMileage}" pattern="#,##0"/> M</span>
                                        <span class="wallet-status">
                                            <c:choose>
                                                <c:when test="${payment.paymentStatus eq 'COMPLETED'}">${autoMsg_316c3d64e5}</c:when>
                                                <c:when test="${payment.paymentStatus eq 'READY'}">${autoMsg_0c03b341ab}</c:when>
                                                <c:when test="${payment.paymentStatus eq 'CANCELLED'}">${autoMsg_89689bb5fe}</c:when>
                                                <c:when test="${payment.paymentStatus eq 'REFUNDED'}">${autoMsg_48d293c247}</c:when>
                                                <c:otherwise>${payment.paymentStatus}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="wallet-pagination" id="paymentPagination" style="display:none;">
                            <button type="button" class="wallet-page-btn" id="paymentPrevBtn">${autoMsg_440dc16467}</button>
                            <span class="wallet-page-info" id="paymentPageInfo"></span>
                            <button type="button" class="wallet-page-btn" id="paymentNextBtn">${autoMsg_a3a432dc93}</button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
        </div>

        <section class="wallet-card">
            <div class="wallet-card__head">
                <h2>${autoMsg_d1c1a399c0}</h2>
                <p>${autoMsg_ec16adff42}</p>
            </div>
            <c:choose>
                <c:when test="${empty walletHistory}">
                    <div class="wallet-empty">${autoMsg_dec8cfbb0c}</div>
                </c:when>
                <c:otherwise>
                    <div class="wallet-table-wrap">
                        <table class="wallet-table">
                            <thead>
                            <tr>
                                <th>${autoMsg_62ad5bc79f}</th>
                                <th>${autoMsg_af88002b80}</th>
                                <th>${autoMsg_73b5a84dc5}</th>
                                <th>${autoMsg_84ae511d73}</th>
                                <th>${autoMsg_96afa6c7f5}</th>
                                <th>${autoMsg_fb82e77b2d}</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="history" items="${walletHistory}">
                                <tr class="wallet-hist-row">
                                    <td>${fn:replace(fn:substring(history.createdAt, 0, 16), 'T', ' ')}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${history.assetType eq 'CASH'}">${autoMsg_840513d3e8}</c:when>
                                            <c:when test="${history.assetType eq 'MILEAGE'}">${autoMsg_3bea7830eb}</c:when>
                                            <c:otherwise>${history.assetType}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${history.changeType eq 'CHARGE'}">${autoMsg_c316da6450}</c:when>
                                            <c:when test="${history.changeType eq 'EARN'}">${autoMsg_06d274e0ec}</c:when>
                                            <c:when test="${history.changeType eq 'USE'}">${autoMsg_76a1c2899e}</c:when>
                                            <c:when test="${history.changeType eq 'REFUND'}">${autoMsg_570379d053}</c:when>
                                            <c:when test="${history.changeType eq 'ADJUST'}">${autoMsg_17af56a0d4}</c:when>
                                            <c:otherwise>${history.changeType}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${history.amount gt 0}">
                                                +<fmt:formatNumber value="${history.amount}" pattern="#,##0"/>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${history.amount}" pattern="#,##0"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><fmt:formatNumber value="${history.balanceAfter}" pattern="#,##0"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${history.assetType eq 'CASH' and history.changeType eq 'CHARGE' and not empty history.relatedPaymentIdx}">
                                                <spring:message code="wallet.history.detail.cashCharge"/>
                                            </c:when>
                                            <c:when test="${history.assetType eq 'MILEAGE' and history.changeType eq 'EARN' and not empty history.relatedPaymentIdx}">
                                                <spring:message code="wallet.history.detail.mileageReward"/>
                                            </c:when>
                                            <c:otherwise>
                                                ${history.detailMessage}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="wallet-pagination" id="historyPagination" style="display:none;">
                        <button type="button" class="wallet-page-btn" id="historyPrevBtn">${autoMsg_440dc16467}</button>
                        <span class="wallet-page-info" id="historyPageInfo"></span>
                        <button type="button" class="wallet-page-btn" id="historyNextBtn">${autoMsg_a3a432dc93}</button>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>

        <section class="wallet-card">
            <div class="wallet-card__head wallet-benefit-head">
                <div>
                <h2>${autoMsg_a1c3287c0a}</h2>
                <p>${autoMsg_20e3c3d3c7}</p>
                </div>
                <button type="button" class="wallet-benefit-toggle" id="walletBenefitToggle">
                    <spring:message code="wallet.benefit.toggle.hide"/>
                </button>
            </div>

            <div class="wallet-benefit-body" id="walletBenefitBody">
            <div class="wallet-benefit-banner">
                <span class="wallet-benefit-banner__badge">${autoMsg_9e8aee4870}</span>
                <p>
                    ${autoMsg_93eb5f6a73}<br>
                    <spring:message code="wallet.benefit.banner.line2"/>
                </p>
            </div>

            <div class="wallet-benefit-table-wrap">
                <table class="wallet-benefit-table">
                    <thead>
                    <tr>
                        <th>${autoMsg_dd53942558}</th>
                        <th>${autoMsg_b6a4c7d8d9}</th>
                        <th>${autoMsg_68e983ea4f}</th>
                        <th>${autoMsg_2831d5d9a7}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty gradePolicies}">
                            <tr>
                                <td colspan="4">${autoMsg_354134b6bf}</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="policy" items="${gradePolicies}">
                                <tr class="${user.memberGrade eq policy.memberGrade ? 'is-current-grade' : ''}">
                                    <td>
                                        <strong>
                                            <c:choose>
                                                <c:when test="${policy.memberGrade eq 'BRONZE'}">${autoMsg_786ae3237f}</c:when>
                                                <c:when test="${policy.memberGrade eq 'SILVER'}">${autoMsg_82be17362b}</c:when>
                                                <c:when test="${policy.memberGrade eq 'GOLD'}">${autoMsg_f2ab2f3614}</c:when>
                                                <c:when test="${policy.memberGrade eq 'DIAMOND'}">${autoMsg_f7a7e30e3a}</c:when>
                                                <c:when test="${policy.memberGrade eq 'PLATINUM'}">${autoMsg_0d602f149d}</c:when>
                                                <c:otherwise>${policy.memberGrade}</c:otherwise>
                                            </c:choose>
                                        </strong>
                                        <c:if test="${user.memberGrade eq policy.memberGrade}">
                                            <span class="wallet-current-badge">${autoMsg_406f961687}</span>
                                        </c:if>
                                    </td>
                                    <td><fmt:formatNumber value="${policy.minMonthlyPayment}" pattern="#,##0"/> ${autoMsg_fba88bc16d}</td>
                                    <td><fmt:formatNumber value="${policy.discountRate}" pattern="#,##0.##"/>%</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${policy.memberGrade eq 'BRONZE'}">
                                                <spring:message code="wallet.benefit.policy.bronze"/>
                                            </c:when>
                                            <c:when test="${policy.memberGrade eq 'SILVER'}">
                                                <spring:message code="wallet.benefit.policy.silver"/>
                                            </c:when>
                                            <c:when test="${policy.memberGrade eq 'GOLD'}">
                                                <spring:message code="wallet.benefit.policy.gold"/>
                                            </c:when>
                                            <c:when test="${policy.memberGrade eq 'DIAMOND'}">
                                                <spring:message code="wallet.benefit.policy.diamond"/>
                                            </c:when>
                                            <c:when test="${policy.memberGrade eq 'PLATINUM'}">
                                                <spring:message code="wallet.benefit.policy.platinum"/>
                                            </c:when>
                                            <c:otherwise>
                                                ${policy.description}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
            </div><%-- wallet-benefit-body --%>
        </section>
    </div>
</div>

<c:if test="${tossEnabled}">
    <script
            id="walletTossSdkScript"
            src="https://js.tosspayments.com/v2/standard"
            onload="window.walletTossSdkLoaded && window.walletTossSdkLoaded()"
            onerror="window.walletTossSdkFailed && window.walletTossSdkFailed()"></script>
</c:if>
<script>
  const WALLET_MESSAGES = {
    chargeLimitMessage: '${autoMsg_422b2b6ab9}',
    chargeMinMessage: '${autoMsg_0c95cedc23}',
    chargeStepMessage: '${autoMsg_9ddfef77f3}',
    tossPrepareError: '${autoMsg_c5a59fabd9}',
    tossRequestError: '${autoMsg_94fda74c36}',
    tossSdkUnavailable: '${autoMsg_018ad2c6bf}'
  };

  function formatNumber(value) {
    return Number(value || 0).toLocaleString();
  }

  var TOSS_ENABLED = ${tossEnabled};
  var TOSS_CLIENT_KEY = '${tossClientKey}';
  var TOSS_SUCCESS_URL = '${tossSuccessUrl}';
  var TOSS_FAIL_URL = '${tossFailUrl}';
  var TOSS_PREPARE_URL = '${pageContext.request.contextPath}/wallet/charge/prepare';
  var TOSS_ORDER_NAME = '${autoMsg_fbca989720}';
  var TOSS_SDK_READY = typeof window.TossPayments === 'function';

  function updateChargePreview() {
    var input = document.getElementById('amount');
    var cashPreview = document.getElementById('chargeCashPreview');
    var mileagePreview = document.getElementById('chargeMileagePreview');
    var limitMessage = document.getElementById('chargeLimitMessage');
    if (!input || !cashPreview || !mileagePreview) return;

    var amount = Number(input.value || 0);
    var mileage = Math.floor(amount / 10);
    cashPreview.textContent = formatNumber(amount) + ' C';
    mileagePreview.textContent = formatNumber(mileage) + ' M';
    if (limitMessage) {
      limitMessage.classList.toggle('is-error', amount > 1000000);
    }
  }

  function setChargeAmount(amount) {
    var input = document.getElementById('amount');
    if (!input) return;
    input.value = amount;
    updateChargePreview();
  }

  function validateChargeAmount(amount) {
    if (amount < 1000) {
      return WALLET_MESSAGES.chargeMinMessage;
    }
    if (amount > 1000000) {
      return WALLET_MESSAGES.chargeLimitMessage;
    }
    if (amount % 100 !== 0) {
      return WALLET_MESSAGES.chargeStepMessage;
    }
    return '';
  }

  window.walletTossSdkLoaded = function() {
    TOSS_SDK_READY = typeof window.TossPayments === 'function';
  };

  window.walletTossSdkFailed = function() {
    TOSS_SDK_READY = false;
  };

  async function requestTossCharge() {
    var input = document.getElementById('amount');
    if (!input) return;

    if (!TOSS_ENABLED) {
      alert('${autoMsg_ca6c210e07}');
      return;
    }

    if (!TOSS_SDK_READY || typeof window.TossPayments !== 'function') {
      alert(WALLET_MESSAGES.tossSdkUnavailable);
      return;
    }

    var amount = Number(input.value || 0);
    var validationMessage = validateChargeAmount(amount);
    if (validationMessage) {
      alert(validationMessage);
      input.focus();
      return;
    }

    try {
      var response = await fetch(TOSS_PREPARE_URL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
          'Accept': 'application/json'
        },
        body: 'amount=' + encodeURIComponent(amount)
      });

      if (!response.ok) {
        throw new Error(WALLET_MESSAGES.tossPrepareError);
      }

      var payload = await response.json();
      var tossPayments = window.TossPayments(TOSS_CLIENT_KEY);
      var payment = tossPayments.payment({
        customerKey: payload.customerKey
      });

      payment.requestPayment({
        method: 'CARD',
        amount: {
          currency: 'KRW',
          value: payload.amount
        },
        orderId: payload.orderId,
        orderName: payload.orderName || TOSS_ORDER_NAME,
        successUrl: payload.successUrl || TOSS_SUCCESS_URL,
        failUrl: payload.failUrl || TOSS_FAIL_URL
      });
    } catch (error) {
      console.error(error);
      alert(error.message || WALLET_MESSAGES.tossRequestError);
    }
  }

  (function() {
    var input = document.getElementById('amount');
    if (!input) return;
    var form = input.closest('form');
    input.addEventListener('input', updateChargePreview);
    if (form) {
      form.addEventListener('submit', function(event) {
        if (TOSS_ENABLED) {
          return;
        }
        var amount = Number(input.value || 0);
        var validationMessage = validateChargeAmount(amount);
        if (validationMessage) {
          event.preventDefault();
          alert(validationMessage);
          input.focus();
        }
      });
    }
    updateChargePreview();
  })();

  // ===== 클라이언트 페이징 =====
  (function() {
    var PAYMENT_PAGE_SIZE = 4;
    var HISTORY_PAGE_SIZE = 5;

    function initClientPaging(selector, pageSize, prevId, nextId, infoId, paginationId) {
      var items = Array.prototype.slice.call(document.querySelectorAll(selector));
      var pagination = document.getElementById(paginationId);
      if (!items.length || items.length <= pageSize) {
        if (pagination) pagination.style.display = 'none';
        return;
      }
      if (pagination) pagination.style.display = '';
      var totalPages = Math.ceil(items.length / pageSize);
      var currentPage = 1;
      function render() {
        items.forEach(function(item, idx) {
          item.style.display = (idx >= (currentPage - 1) * pageSize && idx < currentPage * pageSize) ? '' : 'none';
        });
        var info = document.getElementById(infoId);
        if (info) info.textContent = currentPage + ' / ' + totalPages;
        var prev = document.getElementById(prevId);
        var next = document.getElementById(nextId);
        if (prev) prev.disabled = currentPage <= 1;
        if (next) next.disabled = currentPage >= totalPages;
      }
      var prev = document.getElementById(prevId);
      var next = document.getElementById(nextId);
      if (prev) prev.addEventListener('click', function() { if (currentPage > 1) { currentPage--; render(); } });
      if (next) next.addEventListener('click', function() { if (currentPage < totalPages) { currentPage++; render(); } });
      render();
    }

    initClientPaging('.wallet-pay-item', PAYMENT_PAGE_SIZE, 'paymentPrevBtn', 'paymentNextBtn', 'paymentPageInfo', 'paymentPagination');
    initClientPaging('.wallet-hist-row', HISTORY_PAGE_SIZE, 'historyPrevBtn', 'historyNextBtn', 'historyPageInfo', 'historyPagination');

    // ===== 등급 혜택 아코디언 =====
    var benefitToggle = document.getElementById('walletBenefitToggle');
    var benefitBody   = document.getElementById('walletBenefitBody');
    var BENEFIT_SHOW  = '${autoMsg_a0b34eac97}';
    var BENEFIT_HIDE  = '${autoMsg_41b76b8240}';
    if (benefitToggle && benefitBody) {
      benefitToggle.addEventListener('click', function() {
        var hidden = benefitBody.style.display === 'none';
        benefitBody.style.display = hidden ? '' : 'none';
        benefitToggle.textContent = hidden ? BENEFIT_HIDE : BENEFIT_SHOW;
      });
    }
  })();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
