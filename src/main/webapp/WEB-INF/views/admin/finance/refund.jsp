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
<c:set var="activeMenu" value="finance"/>
<c:set var="pageTitle">${msg_admin_finance_refund_title}</c:set>
<%@ include file="../layout.jsp" %>


<div class="adm-content">

    <%-- 공통 탭바 --%>
    <%@ include file="_tabs.jsp" %>

    <c:if test="${not empty refundMessage}">
        <div class="adm-card" style="padding:12px 16px;margin-bottom:12px;border-left:4px solid #22c55e;">
            <c:out value="${refundMessage}"/>
        </div>
    </c:if>
    <c:if test="${not empty refundError}">
        <div class="adm-card" style="padding:12px 16px;margin-bottom:12px;border-left:4px solid #ef4444;">
            <c:out value="${refundError}"/>
        </div>
    </c:if>

    <div class="adm-card adm-fin-guide" style="padding:14px 18px;margin-bottom:16px;font-size:13px;">
        ${msg_admin_finance_refund_guide}
    </div>

    <%-- 검색 --%>
    <div class="adm-card" style="padding:14px 16px;margin-bottom:16px;">
        <form method="get" action="${pageContext.request.contextPath}/admin/finance/refund"
              style="display:flex;gap:8px;align-items:center;flex-wrap:wrap;">
            <input type="text" name="keyword" value="${fn:escapeXml(keyword)}"
                   class="adm-input"
                   placeholder="${msg_admin_finance_refund_searchPlaceholder}"
                   style="padding:8px 12px;font-size:13px;width:300px;"/>
            <button type="submit" class="adm-btn adm-btn-ghost">${msg_admin_finance_refund_applyFilter}</button>
            <span style="margin-left:auto;font-size:12px;color:#94a3b8;">
                <spring:message var="msg_admin_finance_refund_candidatesCount_args_fn_size" code="admin.finance.refund.candidatesCount" arguments="${fn_size}"/>${msg_admin_finance_refund_candidatesCount_args_fn_size}
                <c:set var="fn_size" value="${candidates != null ? candidates.size() : 0}"/>
                <c:out value="${fn_size}"/>
            </span>
        </form>
    </div>

    <%-- 환불 후보 테이블 --%>
    <div class="adm-card" style="padding:0;overflow-x:auto;margin-bottom:24px;">
        <table class="adm-table" style="width:100%;">
            <thead>
            <tr>
                <th style="width:80px;">ID</th>
                <th>${msg_admin_finance_refund_col_user}</th>
                <th>${msg_admin_finance_refund_col_order}</th>
                <th style="width:130px;text-align:right;">${msg_admin_finance_refund_col_amount}</th>
                <th style="width:110px;">${msg_admin_finance_refund_col_method}</th>
                <th style="width:160px;">${msg_admin_finance_refund_col_paidAt}</th>
                <th style="width:130px;">${msg_admin_finance_refund_col_action}</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty candidates}">
                    <tr><td colspan="7" style="text-align:center;padding:48px;color:#94a3b8;">
                        ${msg_admin_finance_refund_empty}
                    </td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="p" items="${candidates}">
                        <tr>
                            <td>${p.paymentIdx}</td>
                            <td>${p.userIdx}</td>
                            <td><c:out value="${p.orderName}"/></td>
                            <td style="text-align:right;font-weight:600;"><fmt:formatNumber value="${p.finalAmount}" pattern="#,###"/></td>
                            <td>${p.paymentMethod}</td>
                            <td style="font-size:12px;color:#94a3b8;"><fmt:formatDate value="${p.paidAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <button type="button" class="adm-btn adm-btn-primary adm-fin-refund-btn"
                                        style="padding:5px 12px;font-size:12px;"
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

    <%-- 최근 환불 audit 로그 --%>
    <h3 style="font-size:15px;margin:8px 0 10px 0;">${msg_admin_finance_refund_recentLogs}</h3>
    <div class="adm-card" style="padding:0;overflow-x:auto;">
        <table class="adm-table" style="width:100%;">
            <thead>
            <tr>
                <th style="width:60px;">#</th>
                <th style="width:80px;">${msg_admin_finance_refund_col_paymentId}</th>
                <th>${msg_admin_finance_refund_col_userNick}</th>
                <th>${msg_admin_finance_refund_col_order}</th>
                <th style="width:130px;text-align:right;">${msg_admin_finance_refund_col_amount}</th>
                <th>${msg_admin_finance_refund_col_reason}</th>
                <th style="width:120px;">${msg_admin_finance_refund_col_tossStatus}</th>
                <th style="width:160px;">${msg_admin_finance_refund_col_refundedAt}</th>
                <th style="width:140px;">${msg_admin_finance_refund_col_admin}</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty recentLogs}">
                    <tr><td colspan="9" style="text-align:center;padding:36px;color:#94a3b8;">
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
                            <td style="text-align:right;"><fmt:formatNumber value="${log.refundAmount}" pattern="#,###"/></td>
                            <td style="font-size:12px;"><c:out value="${log.refundReason}"/></td>
                            <td><span class="adm-badge">${log.tossCancelStatus}</span></td>
                            <td style="font-size:12px;color:#94a3b8;"><fmt:formatDate value="${log.refundedAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td><c:out value="${log.adminNickname}"/></td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

</div>

<%-- 환불 모달 (간단 inline form) --%>
<div id="adm-fin-refund-modal" class="adm-card"
     style="display:none;position:fixed;z-index:1000;left:50%;top:30%;transform:translate(-50%,-30%);
            width:480px;padding:20px 22px;box-shadow:0 8px 32px rgba(0,0,0,.5);">
    <h3 style="margin:0 0 12px 0;font-size:16px;">${msg_admin_finance_refund_modal_title}</h3>
    <div id="adm-fin-refund-info" style="font-size:13px;margin-bottom:12px;line-height:1.6;color:#94a3b8;"></div>
    <form id="adm-fin-refund-form" method="post">
        <label style="display:block;font-size:12px;margin-bottom:6px;">
            ${msg_admin_finance_refund_modal_reasonLabel}
            <span style="color:#ef4444;">*</span>
        </label>
        <textarea name="reason" required minlength="3" maxlength="500"
                  style="width:100%;min-height:96px;padding:10px;font-size:13px;border:1px solid #334155;border-radius:6px;background:transparent;color:inherit;"
                  placeholder="${msg_admin_finance_refund_modal_reasonPlaceholder}"></textarea>
        <div style="display:flex;gap:8px;justify-content:flex-end;margin-top:14px;">
            <button type="button" class="adm-btn adm-btn-ghost" onclick="admFinRefundClose()">
                ${msg_admin_finance_refund_modal_cancel}
            </button>
            <button type="submit" class="adm-btn adm-btn-primary">
                ${msg_admin_finance_refund_modal_confirm}
            </button>
        </div>
    </form>
</div>
<div id="adm-fin-refund-backdrop"
     style="display:none;position:fixed;z-index:999;inset:0;background:rgba(0,0,0,.5);"
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
            document.getElementById('adm-fin-refund-modal').style.display = 'block';
            document.getElementById('adm-fin-refund-backdrop').style.display = 'block';
        });
    });
    window.admFinRefundClose = function(){
        document.getElementById('adm-fin-refund-modal').style.display = 'none';
        document.getElementById('adm-fin-refund-backdrop').style.display = 'none';
    };
})();
</script>

<%@ include file="../layout-close.jsp" %>
