<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="${pageContext.response.locale.language}">
<c:set var="pageCSS" value="wallet/wallet.css"/>
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
                    <div class="wallet-stat__value"><fmt:formatNumber value="${user.cashBalance}" pattern="#,##0"/> C</div>
                </div>
                <div class="wallet-stat wallet-stat--mileage">
                    <div class="wallet-stat__label"><spring:message code="wallet.stat.mileage"/></div>
                    <div class="wallet-stat__value"><fmt:formatNumber value="${user.mileageBalance}" pattern="#,##0"/> M</div>
                </div>
                <div class="wallet-stat wallet-stat--point">
                    <div class="wallet-stat__label"><spring:message code="wallet.stat.point"/></div>
                    <div class="wallet-stat__value"><fmt:formatNumber value="${user.pointBalance}" pattern="#,##0"/> P</div>
                </div>
                <div class="wallet-stat wallet-stat--grade">
                    <div class="wallet-stat__label"><spring:message code="wallet.stat.grade"/></div>
                    <div class="wallet-stat__value">${user.memberGrade}</div>
                </div>
                <div class="wallet-stat wallet-stat--level">
                    <div class="wallet-stat__label"><spring:message code="wallet.stat.level"/></div>
                    <div class="wallet-stat__value">Lv.${user.levelNo}</div>
                </div>
                <div class="wallet-stat wallet-stat--exp">
                    <div class="wallet-stat__label"><spring:message code="wallet.stat.exp"/></div>
                    <div class="wallet-stat__value"><fmt:formatNumber value="${user.expPoints}" pattern="#,##0"/> EXP</div>
                </div>
            </div>
        </section>

        <div class="wallet-two-col">
            <section class="wallet-card">
                <div class="wallet-card__head">
                    <h2><spring:message code="wallet.charge.title"/></h2>
                    <p><spring:message code="wallet.charge.desc"/></p>
                </div>

                <div class="wallet-charge-presets">
                    <button type="button" class="wallet-preset-btn" onclick="setChargeAmount(10000)">10,000</button>
                    <button type="button" class="wallet-preset-btn" onclick="setChargeAmount(30000)">30,000</button>
                    <button type="button" class="wallet-preset-btn" onclick="setChargeAmount(50000)">50,000</button>
                    <button type="button" class="wallet-preset-btn" onclick="setChargeAmount(100000)">100,000</button>
                </div>

                <form class="wallet-charge-form" method="post" action="${pageContext.request.contextPath}/wallet/charge">
                    <label for="amount"><spring:message code="wallet.charge.amount"/></label>
                    <div class="wallet-charge-input">
                        <input id="amount" name="amount" type="number" min="1000" max="1000000" step="100" value="10000" required>
                        <span><spring:message code="wallet.charge.currency"/></span>
                    </div>
                    <p class="wallet-charge-limit" id="chargeLimitMessage"><spring:message code="wallet.charge.limitMessage"/></p>

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

                    <button type="submit" class="wallet-submit-btn"><spring:message code="wallet.charge.submit"/></button>
                </form>

                <ul class="wallet-notice-list">
                    <li><spring:message code="wallet.notice.simulation"/></li>
                    <li><spring:message code="wallet.notice.mileage"/></li>
                    <li><spring:message code="wallet.notice.history"/></li>
                </ul>
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
                                <div class="wallet-history-item">
                                    <div class="wallet-history-item__main">
                                        <strong>
                                            <c:choose>
                                                <c:when test="${payment.sourceType eq 'MANUAL_CHARGE'}">
                                                    <spring:message code="wallet.payment.order.manualCharge"/>
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
                                        <span class="wallet-status">${payment.paymentStatus}</span>
                                    </div>
                                </div>
                            </c:forEach>
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
                                <tr>
                                    <td>${fn:replace(fn:substring(history.createdAt, 0, 16), 'T', ' ')}</td>
                                    <td>${history.assetType}</td>
                                    <td>${history.changeType}</td>
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
                </c:otherwise>
            </c:choose>
        </section>

        <section class="wallet-card">
            <div class="wallet-card__head">
                <h2><spring:message code="wallet.benefit.title"/></h2>
                <p><spring:message code="wallet.benefit.desc"/></p>
            </div>

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
                                        <strong>${policy.memberGrade}</strong>
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
        </section>
    </div>
</div>

<script>
  const WALLET_MESSAGES = {
    chargeLimitMessage: '<spring:message code="wallet.charge.limitMessage" javaScriptEscape="true"/>'
  };

  function formatNumber(value) {
    return Number(value || 0).toLocaleString();
  }

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

  (function() {
    var input = document.getElementById('amount');
    if (!input) return;
    var form = input.closest('form');
    input.addEventListener('input', updateChargePreview);
    if (form) {
      form.addEventListener('submit', function(event) {
        var amount = Number(input.value || 0);
        if (amount > 1000000) {
          event.preventDefault();
          alert(WALLET_MESSAGES.chargeLimitMessage);
          input.focus();
        }
      });
    }
    updateChargePreview();
  })();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
