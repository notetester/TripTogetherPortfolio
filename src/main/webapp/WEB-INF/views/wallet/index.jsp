<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<c:set var="pageCSS" value="wallet/wallet.css"/>
<spring:message code="wallet.charge.limit" var="walletChargeLimitMessage"/>
<%@ include file="../common/header.jsp" %>
<body>

<div class="wallet-wrap">
    <div class="wallet-hero">
        <div class="wallet-hero__content">
            <p class="wallet-hero__eyebrow"><spring:message code="wallet.hero.eyebrow"/></p>
            <h1><spring:message code="wallet.title"/></h1>
            <p class="wallet-hero__desc"><spring:message code="wallet.subtitle"/></p>
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
                <h2><spring:message code="wallet.summary.title"/></h2>
                <p><spring:message code="wallet.summary.desc"/></p>
            </div>
            <div class="wallet-summary-grid">
                <div class="wallet-stat wallet-stat--cash">
                    <div class="wallet-stat__label"><spring:message code="wallet.stat.cash"/></div>
                    <div class="wallet-stat__value"><fmt:formatNumber value="${user.cashBalance}" pattern="#,##0"/> <spring:message code="wallet.stat.unit.cash"/></div>
                </div>
                <div class="wallet-stat wallet-stat--mileage">
                    <div class="wallet-stat__label"><spring:message code="wallet.stat.mileage"/></div>
                    <div class="wallet-stat__value"><fmt:formatNumber value="${user.mileageBalance}" pattern="#,##0"/> <spring:message code="wallet.stat.unit.mileage"/></div>
                </div>
                <div class="wallet-stat wallet-stat--point">
                    <div class="wallet-stat__label"><spring:message code="wallet.stat.point"/></div>
                    <div class="wallet-stat__value"><fmt:formatNumber value="${user.pointBalance}" pattern="#,##0"/> <spring:message code="wallet.stat.unit.point"/></div>
                </div>
                <div class="wallet-stat wallet-stat--grade">
                    <div class="wallet-stat__label"><spring:message code="wallet.stat.grade"/></div>
                    <div class="wallet-stat__value">
                        <c:choose>
                            <c:when test="${user.memberGrade eq 'BRONZE'}"><spring:message code="wallet.grade.BRONZE"/></c:when>
                            <c:when test="${user.memberGrade eq 'SILVER'}"><spring:message code="wallet.grade.SILVER"/></c:when>
                            <c:when test="${user.memberGrade eq 'GOLD'}"><spring:message code="wallet.grade.GOLD"/></c:when>
                            <c:when test="${user.memberGrade eq 'DIAMOND'}"><spring:message code="wallet.grade.DIAMOND"/></c:when>
                            <c:when test="${user.memberGrade eq 'PLATINUM'}"><spring:message code="wallet.grade.PLATINUM"/></c:when>
                            <c:otherwise>${user.memberGrade}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="wallet-stat wallet-stat--level">
                    <div class="wallet-stat__label"><spring:message code="wallet.stat.level"/></div>
                    <div class="wallet-stat__value">Lv.${user.levelNo}</div>
                </div>
                <div class="wallet-stat wallet-stat--exp">
                    <div class="wallet-stat__label"><spring:message code="wallet.stat.exp"/></div>
                    <div class="wallet-stat__value"><fmt:formatNumber value="${user.expPoints}" pattern="#,##0"/> <spring:message code="wallet.stat.unit.exp"/></div>
                </div>
            </div>
        </section>

        <div class="wallet-two-col">
            <section class="wallet-card">
                <div class="wallet-card__head">
                    <h2><spring:message code="wallet.charge.title"/></h2>
                    <c:choose>
                        <c:when test="${tossEnabled}">
                            <p><spring:message code="wallet.charge.toss.desc"/></p>
                        </c:when>
                        <c:otherwise>
                            <p><spring:message code="wallet.charge.desc"/></p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="wallet-charge-presets">
                    <button type="button" class="wallet-preset-btn" onclick="setChargeAmount(10000)">10,000</button>
                    <button type="button" class="wallet-preset-btn" onclick="setChargeAmount(30000)">30,000</button>
                    <button type="button" class="wallet-preset-btn" onclick="setChargeAmount(50000)">50,000</button>
                    <button type="button" class="wallet-preset-btn" onclick="setChargeAmount(100000)">100,000</button>
                </div>

                <label for="amount"><spring:message code="wallet.charge.amount"/></label>
                <div class="wallet-charge-input">
                    <input id="amount" name="amount" type="number" min="1000" max="1000000" step="100" value="10000" required>
                    <span><spring:message code="wallet.charge.currency"/></span>
                </div>
                <p class="wallet-charge-limit" id="chargeLimitMessage">${walletChargeLimitMessage}</p>

                <div class="wallet-charge-preview">
                    <div>
                        <span><spring:message code="wallet.charge.preview.cash"/></span>
                        <strong id="chargeCashPreview">10,000 C</strong>
                    </div>
                    <div>
                        <span><spring:message code="wallet.charge.preview.mileage"/></span>
                        <strong id="chargeMileagePreview">1,000 M</strong>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${tossEnabled}">
                        <button type="button" id="walletTossChargeButton" class="wallet-submit-btn" onclick="requestTossCharge()">
                            <spring:message code="wallet.charge.toss.button"/>
                        </button>
                        <ul class="wallet-notice-list">
                            <li><spring:message code="wallet.charge.toss.notice"/></li>
                            <li><spring:message code="wallet.notice.mileage"/></li>
                            <li><spring:message code="wallet.notice.history"/></li>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <form class="wallet-charge-form" method="post" action="${pageContext.request.contextPath}/wallet/charge">
                            <button type="submit" class="wallet-submit-btn"><spring:message code="wallet.charge.submit"/></button>
                        </form>
                        <ul class="wallet-notice-list">
                            <li><spring:message code="wallet.notice.simulation"/></li>
                            <li><spring:message code="wallet.notice.mileage"/></li>
                            <li><spring:message code="wallet.notice.history"/></li>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </section>

            <section class="wallet-card">
                <div class="wallet-card__head">
                    <h2><spring:message code="wallet.payment.title"/></h2>
                    <p><spring:message code="wallet.payment.desc"/></p>
                </div>

                <c:choose>
                    <c:when test="${empty paymentHistory}">
                        <div class="wallet-empty"><spring:message code="wallet.payment.empty"/></div>
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
                                        <span><spring:message code="wallet.payment.amount"/> <fmt:formatNumber value="${payment.finalAmount}" pattern="#,##0"/> C</span>
                                        <span><spring:message code="wallet.payment.mileage"/> +<fmt:formatNumber value="${payment.earnedMileage}" pattern="#,##0"/> M</span>
                                        <span class="wallet-status">
                                            <c:choose>
                                                <c:when test="${payment.paymentStatus eq 'COMPLETED'}"><spring:message code="wallet.paymentStatus.COMPLETED"/></c:when>
                                                <c:when test="${payment.paymentStatus eq 'READY'}"><spring:message code="wallet.paymentStatus.READY"/></c:when>
                                                <c:when test="${payment.paymentStatus eq 'CANCELLED'}"><spring:message code="wallet.paymentStatus.CANCELLED"/></c:when>
                                                <c:when test="${payment.paymentStatus eq 'REFUNDED'}"><spring:message code="wallet.paymentStatus.REFUNDED"/></c:when>
                                                <c:otherwise>${payment.paymentStatus}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="wallet-pagination" id="paymentPagination" style="display:none;">
                            <button type="button" class="wallet-page-btn" id="paymentPrevBtn"><spring:message code="wallet.pagination.prev"/></button>
                            <span class="wallet-page-info" id="paymentPageInfo"></span>
                            <button type="button" class="wallet-page-btn" id="paymentNextBtn"><spring:message code="wallet.pagination.next"/></button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
        </div>

        <section class="wallet-card">
            <div class="wallet-card__head">
                <h2><spring:message code="wallet.history.title"/></h2>
                <p><spring:message code="wallet.history.desc"/></p>
            </div>
            <c:choose>
                <c:when test="${empty walletHistory}">
                    <div class="wallet-empty"><spring:message code="wallet.history.empty"/></div>
                </c:when>
                <c:otherwise>
                    <div class="wallet-table-wrap">
                        <table class="wallet-table">
                            <thead>
                            <tr>
                                <th><spring:message code="wallet.history.col.date"/></th>
                                <th><spring:message code="wallet.history.col.asset"/></th>
                                <th><spring:message code="wallet.history.col.type"/></th>
                                <th><spring:message code="wallet.history.col.amount"/></th>
                                <th><spring:message code="wallet.history.col.balance"/></th>
                                <th><spring:message code="wallet.history.col.detail"/></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="history" items="${walletHistory}">
                                <tr class="wallet-hist-row">
                                    <td>${fn:replace(fn:substring(history.createdAt, 0, 16), 'T', ' ')}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${history.assetType eq 'CASH'}"><spring:message code="wallet.assetType.CASH"/></c:when>
                                            <c:when test="${history.assetType eq 'MILEAGE'}"><spring:message code="wallet.assetType.MILEAGE"/></c:when>
                                            <c:otherwise>${history.assetType}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${history.changeType eq 'CHARGE'}"><spring:message code="wallet.changeType.CHARGE"/></c:when>
                                            <c:when test="${history.changeType eq 'EARN'}"><spring:message code="wallet.changeType.EARN"/></c:when>
                                            <c:when test="${history.changeType eq 'USE'}"><spring:message code="wallet.changeType.USE"/></c:when>
                                            <c:when test="${history.changeType eq 'REFUND'}"><spring:message code="wallet.changeType.REFUND"/></c:when>
                                            <c:when test="${history.changeType eq 'ADJUST'}"><spring:message code="wallet.changeType.ADJUST"/></c:when>
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
                        <button type="button" class="wallet-page-btn" id="historyPrevBtn"><spring:message code="wallet.pagination.prev"/></button>
                        <span class="wallet-page-info" id="historyPageInfo"></span>
                        <button type="button" class="wallet-page-btn" id="historyNextBtn"><spring:message code="wallet.pagination.next"/></button>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>

        <section class="wallet-card">
            <div class="wallet-card__head wallet-benefit-head">
                <div>
                <h2><spring:message code="wallet.benefit.title"/></h2>
                <p><spring:message code="wallet.benefit.desc"/></p>
                </div>
                <button type="button" class="wallet-benefit-toggle" id="walletBenefitToggle">
                    <spring:message code="wallet.benefit.toggle.hide"/>
                </button>
            </div>

            <div class="wallet-benefit-body" id="walletBenefitBody">
            <div class="wallet-benefit-banner">
                <span class="wallet-benefit-banner__badge"><spring:message code="wallet.benefit.banner.badge"/></span>
                <p>
                    <spring:message code="wallet.benefit.banner.line1"/><br>
                    <spring:message code="wallet.benefit.banner.line2"/>
                </p>
            </div>

            <div class="wallet-benefit-table-wrap">
                <table class="wallet-benefit-table">
                    <thead>
                    <tr>
                        <th><spring:message code="wallet.benefit.col.grade"/></th>
                        <th><spring:message code="wallet.benefit.col.monthlyPayment"/></th>
                        <th><spring:message code="wallet.benefit.col.discountRate"/></th>
                        <th><spring:message code="wallet.benefit.col.description"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty gradePolicies}">
                            <tr>
                                <td colspan="4"><spring:message code="wallet.benefit.empty"/></td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="policy" items="${gradePolicies}">
                                <tr class="${user.memberGrade eq policy.memberGrade ? 'is-current-grade' : ''}">
                                    <td>
                                        <strong>
                                            <c:choose>
                                                <c:when test="${policy.memberGrade eq 'BRONZE'}"><spring:message code="wallet.grade.BRONZE"/></c:when>
                                                <c:when test="${policy.memberGrade eq 'SILVER'}"><spring:message code="wallet.grade.SILVER"/></c:when>
                                                <c:when test="${policy.memberGrade eq 'GOLD'}"><spring:message code="wallet.grade.GOLD"/></c:when>
                                                <c:when test="${policy.memberGrade eq 'DIAMOND'}"><spring:message code="wallet.grade.DIAMOND"/></c:when>
                                                <c:when test="${policy.memberGrade eq 'PLATINUM'}"><spring:message code="wallet.grade.PLATINUM"/></c:when>
                                                <c:otherwise>${policy.memberGrade}</c:otherwise>
                                            </c:choose>
                                        </strong>
                                        <c:if test="${user.memberGrade eq policy.memberGrade}">
                                            <span class="wallet-current-badge"><spring:message code="wallet.benefit.current"/></span>
                                        </c:if>
                                    </td>
                                    <td><fmt:formatNumber value="${policy.minMonthlyPayment}" pattern="#,##0"/> <spring:message code="wallet.benefit.amountUnit"/></td>
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
    chargeLimitMessage: '<spring:message code="wallet.charge.limitMessage" javaScriptEscape="true"/>',
    chargeMinMessage: '<spring:message code="wallet.charge.error.min" arguments="1000" javaScriptEscape="true"/>',
    chargeStepMessage: '<spring:message code="wallet.charge.error.step" javaScriptEscape="true"/>',
    tossPrepareError: '<spring:message code="wallet.charge.toss.prepareError" javaScriptEscape="true"/>',
    tossRequestError: '<spring:message code="wallet.charge.toss.requestError" javaScriptEscape="true"/>',
    tossSdkUnavailable: '<spring:message code="wallet.charge.toss.sdkUnavailable" javaScriptEscape="true"/>'
  };

  function formatNumber(value) {
    return Number(value || 0).toLocaleString();
  }

  var TOSS_ENABLED = ${tossEnabled};
  var TOSS_CLIENT_KEY = '${tossClientKey}';
  var TOSS_SUCCESS_URL = '${tossSuccessUrl}';
  var TOSS_FAIL_URL = '${tossFailUrl}';
  var TOSS_PREPARE_URL = '${pageContext.request.contextPath}/wallet/charge/prepare';
  var TOSS_ORDER_NAME = '<spring:message code="wallet.payment.order.tossCharge" javaScriptEscape="true"/>';
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
      alert('<spring:message code="wallet.charge.toss.unavailable" javaScriptEscape="true"/>');
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
    var BENEFIT_SHOW  = '<spring:message code="wallet.benefit.toggle.show" javaScriptEscape="true"/>';
    var BENEFIT_HIDE  = '<spring:message code="wallet.benefit.toggle.hide" javaScriptEscape="true"/>';
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
