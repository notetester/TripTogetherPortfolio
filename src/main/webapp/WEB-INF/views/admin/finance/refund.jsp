<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_finance_refund_title" code="admin.finance.refund.title"/>
<spring:message var="msg_admin_finance_refund_searchPlaceholder" code="admin.finance.refund.searchPlaceholder"/>
<spring:message var="msg_admin_finance_refund_modal_reasonPlaceholder" code="admin.finance.refund.modal.reasonPlaceholder"/>
<spring:message var="msg_admin_finance_refund_guide" code="admin.finance.refund.guide"/>
<spring:message var="msg_admin_finance_refund_applyFilter" code="admin.finance.refund.applyFilter"/>
<spring:message var="msg_admin_finance_refund_candidatesTitle" code="admin.finance.refund.candidatesTitle"/>
<spring:message var="msg_admin_finance_refund_col_user" code="admin.finance.refund.col.user"/>
<spring:message var="msg_admin_finance_refund_col_order" code="admin.finance.refund.col.order"/>
<spring:message var="msg_admin_finance_refund_col_amount" code="admin.finance.refund.col.amount"/>
<spring:message var="msg_admin_finance_refund_col_method" code="admin.finance.refund.col.method"/>
<spring:message var="msg_admin_finance_refund_col_paidAt" code="admin.finance.refund.col.paidAt"/>
<spring:message var="msg_admin_finance_refund_col_action" code="admin.finance.refund.col.action"/>
<spring:message var="msg_admin_finance_refund_empty" code="admin.finance.refund.empty"/>
<spring:message var="msg_admin_finance_refund_action_refund" code="admin.finance.refund.action.refund"/>
<spring:message var="msg_admin_finance_refund_recentLogs" code="admin.finance.refund.recentLogs"/>
<spring:message var="msg_admin_finance_refund_col_paymentId" code="admin.finance.refund.col.paymentId"/>
<spring:message var="msg_admin_finance_refund_col_userNick" code="admin.finance.refund.col.userNick"/>
<spring:message var="msg_admin_finance_refund_col_reason" code="admin.finance.refund.col.reason"/>
<spring:message var="msg_admin_finance_refund_col_tossStatus" code="admin.finance.refund.col.tossStatus"/>
<spring:message var="msg_admin_finance_refund_col_refundedAt" code="admin.finance.refund.col.refundedAt"/>
<spring:message var="msg_admin_finance_refund_col_admin" code="admin.finance.refund.col.admin"/>
<spring:message var="msg_admin_finance_refund_logsEmpty" code="admin.finance.refund.logsEmpty"/>
<spring:message var="msg_admin_finance_refund_modal_title" code="admin.finance.refund.modal.title"/>
<spring:message var="msg_admin_finance_refund_modal_reasonLabel" code="admin.finance.refund.modal.reasonLabel"/>
<spring:message var="msg_admin_finance_refund_modal_cancel" code="admin.finance.refund.modal.cancel"/>
<spring:message var="msg_admin_finance_refund_modal_confirm" code="admin.finance.refund.modal.confirm"/>
<spring:message var="msg_admin_common_reset" code="admin.common.reset"/>
<spring:message var="msg_admin_finance_refund_logsCountDisplay" code="admin.common.currentCountFormat" arguments="${fn:length(recentLogs)}"/>
<c:set var="activeMenu" value="finance"/>
<c:set var="pageTitle">${msg_admin_finance_refund_title}</c:set>
<%@ include file="../layout.jsp" %>


<div class="adm-content adm-finance-page">

    <%-- 공통 탭바 --%>
    <%@ include file="_tabs.jsp" %>

    <c:if test="${not empty refundMessage}">
        <div class="adm-card adm-finance-alert is-success">
            <c:out value="${refundMessage}"/>
        </div>
    </c:if>
    <c:if test="${not empty refundError}">
        <div class="adm-card adm-finance-alert is-error">
            <c:out value="${refundError}"/>
        </div>
    </c:if>

    <div class="adm-card adm-fin-guide adm-finance-guide-card">
        ${msg_admin_finance_refund_guide}
    </div>

    <%-- 검색 --%>
    <div class="adm-card adm-finance-filter-card adm-finance-refund-filter-card adm-overflow-visible">
        <form method="get" action="${pageContext.request.contextPath}/admin/finance/refund"
              class="adm-finance-refund-filterbar">
            <input type="text" name="keyword" value="${fn:escapeXml(keyword)}"
                   class="adm-input"
                   placeholder="${msg_admin_finance_refund_searchPlaceholder}"/>
            <button type="submit" class="adm-btn adm-btn-primary">${msg_admin_finance_refund_applyFilter}</button>
            <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/finance/refund">${msg_admin_common_reset}</a>
            <span class="adm-finance-filter-total">
                <c:set var="fn_size" value="${candidates != null ? candidates.size() : 0}"/>
                <spring:message var="msg_admin_finance_refund_candidatesCount_args_fn_size" code="admin.finance.refund.candidatesCount" arguments="${fn_size}"/>${msg_admin_finance_refund_candidatesCount_args_fn_size}
            </span>
        </form>
    </div>

    <%-- 환불 후보 테이블 --%>
    <div class="adm-card adm-finance-table-card adm-finance-refund-table-card adm-finance-managed-card adm-overflow-visible">
        <div class="adm-card-head">
            <div class="adm-card-title">
                ${msg_admin_finance_refund_candidatesTitle}
                <span class="adm-section-total-inline">${msg_admin_finance_refund_candidatesCount_args_fn_size}</span>
            </div>
        </div>
        <div class="adm-table-wrap">
        <table class="adm-table adm-finance-refund-table" data-admin-list-ignore="true">
            <colgroup>
                <col class="adm-finance-col-id">
                <col class="adm-finance-col-user">
                <col>
                <col class="adm-finance-col-amount">
                <col class="adm-finance-col-method">
                <col class="adm-finance-col-time">
                <col class="adm-finance-col-action-wide">
            </colgroup>
            <thead>
            <tr>
                <th onclick="financeRefundThClick(this)">ID</th>
                <th onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_user}</th>
                <th onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_order}</th>
                <th class="adm-align-right" onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_amount}</th>
                <th onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_method}</th>
                <th onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_paidAt}</th>
                <th onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_action}</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty candidates}">
                    <tr class="adm-local-empty"><td colspan="7" class="adm-local-empty-cell">
                        ${msg_admin_finance_refund_empty}
                    </td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="p" items="${candidates}">
                        <tr>
                            <td>${p.paymentIdx}</td>
                            <td>${p.userIdx}</td>
                            <td><c:out value="${p.orderName}"/></td>
                            <td class="adm-align-right adm-finance-amount-strong"><fmt:formatNumber value="${p.finalAmount}" pattern="#,###"/></td>
                            <td>${p.paymentMethod}</td>
                            <td class="adm-finance-time-cell"><fmt:formatDate value="${p.paidAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <button type="button" class="adm-btn adm-btn-primary adm-fin-refund-btn adm-finance-refund-btn"
                                        data-payment-idx="${p.paymentIdx}"
                                        data-amount="${p.finalAmount}"
                                        data-order="${fn:escapeXml(p.orderName)}">
                                    ${msg_admin_finance_refund_action_refund}
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
        </div>
    </div>

    <%-- 최근 환불 audit 로그 --%>
    <div class="adm-card adm-finance-table-card adm-finance-managed-card adm-overflow-visible">
        <div class="adm-card-head">
            <div class="adm-card-title">
                ${msg_admin_finance_refund_recentLogs}
                <span class="adm-section-total-inline">${msg_admin_finance_refund_logsCountDisplay}</span>
            </div>
        </div>
        <div class="adm-table-wrap">
        <table class="adm-table adm-finance-refund-log-table" data-admin-list-ignore="true">
            <colgroup>
                <col class="adm-finance-col-index">
                <col class="adm-finance-col-id">
                <col class="adm-finance-col-user">
                <col>
                <col class="adm-finance-col-amount">
                <col>
                <col class="adm-finance-col-status-wide">
                <col class="adm-finance-col-time">
                <col class="adm-finance-col-admin">
            </colgroup>
            <thead>
            <tr>
                <th onclick="financeRefundThClick(this)">#</th>
                <th onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_paymentId}</th>
                <th onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_userNick}</th>
                <th onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_order}</th>
                <th class="adm-align-right" onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_amount}</th>
                <th onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_reason}</th>
                <th onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_tossStatus}</th>
                <th onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_refundedAt}</th>
                <th onclick="financeRefundThClick(this)">${msg_admin_finance_refund_col_admin}</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty recentLogs}">
                    <tr class="adm-local-empty"><td colspan="9" class="adm-local-empty-cell">
                        ${msg_admin_finance_refund_logsEmpty}
                    </td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="log" items="${recentLogs}" varStatus="st">
                        <tr>
                            <td>${st.index + 1}</td>
                            <td>${log.paymentIdx}</td>
                            <td><c:out value="${log.userNickname}"/></td>
                            <td><c:out value="${log.orderName}"/></td>
                            <td class="adm-align-right"><fmt:formatNumber value="${log.refundAmount}" pattern="#,###"/></td>
                            <td class="adm-finance-reason-cell"><c:out value="${log.refundReason}"/></td>
                            <td><span class="adm-badge">${log.tossCancelStatus}</span></td>
                            <td class="adm-finance-time-cell"><fmt:formatDate value="${log.refundedAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td><c:out value="${log.adminNickname}"/></td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
        </div>
    </div>

</div>

<%-- 환불 모달 (간단 inline form) --%>
<div id="adm-fin-refund-modal" class="adm-card adm-finance-refund-modal" hidden>
    <h3 class="adm-finance-refund-modal-title">${msg_admin_finance_refund_modal_title}</h3>
    <div id="adm-fin-refund-info" class="adm-finance-refund-modal-info"></div>
    <form id="adm-fin-refund-form" method="post">
        <label class="adm-finance-refund-reason-label">
            ${msg_admin_finance_refund_modal_reasonLabel}
            <span class="adm-finance-required">*</span>
        </label>
        <textarea name="reason" required minlength="3" maxlength="500"
                  class="adm-input adm-finance-refund-reason"
                  placeholder="${msg_admin_finance_refund_modal_reasonPlaceholder}"></textarea>
        <div class="adm-finance-modal-actions">
            <button type="button" class="adm-btn adm-btn-ghost" onclick="admFinRefundClose()">
                ${msg_admin_finance_refund_modal_cancel}
            </button>
            <button type="submit" class="adm-btn adm-btn-primary">
                ${msg_admin_finance_refund_modal_confirm}
            </button>
        </div>
    </form>
</div>
<div id="adm-fin-refund-backdrop" class="adm-finance-refund-backdrop" hidden
     onclick="admFinRefundClose()"></div>

<script>
(function(){
    var ctxPath = '${pageContext.request.contextPath}';
    function fmt(n){ return Number(n).toLocaleString(); }
    document.querySelectorAll('.adm-fin-refund-btn').forEach(function(btn){
        btn.addEventListener('click', function(){
            var idx = btn.getAttribute('data-payment-idx');
            var amt = btn.getAttribute('data-amount');
            var ord = btn.getAttribute('data-order');
            document.getElementById('adm-fin-refund-info').innerHTML =
                'paymentIdx <strong>' + idx + '</strong> / ' +
                ord + ' / ' +
                '<strong>' + fmt(amt) + '</strong>원';
            var form = document.getElementById('adm-fin-refund-form');
            form.action = ctxPath + '/admin/finance/refund/' + idx;
            document.getElementById('adm-fin-refund-modal').hidden = false;
            document.getElementById('adm-fin-refund-backdrop').hidden = false;
        });
    });
    window.admFinRefundClose = function(){
        document.getElementById('adm-fin-refund-modal').hidden = true;
        document.getElementById('adm-fin-refund-backdrop').hidden = true;
    };
})();

/* ── 헤더 클릭: 첫 행의 같은 컬럼 셀 액션을 트리거 ── */
function financeRefundThClick(th) {
    var table = th.closest('table');
    var firstRow = table && table.querySelector('tbody tr:not(.adm-local-empty)');
    if (!firstRow) return;
    var cell = firstRow.children[th.cellIndex];
    if (!cell) return;
    var target = cell.querySelector('button, a[href]');
    if (target) { target.click(); return; }
    var anyBtn = firstRow.querySelector('button, a[href]');
    if (anyBtn) anyBtn.click();
}
</script>

<%@ include file="../layout-close.jsp" %>
