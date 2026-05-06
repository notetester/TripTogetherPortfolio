<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_finance_tab_dashboard" code="admin.finance.tab.dashboard"/>
<spring:message var="msg_admin_finance_tab_refund" code="admin.finance.tab.refund"/>
<spring:message var="msg_admin_finance_tab_policy" code="admin.finance.tab.policy"/>
<%-- finance 모듈 공통 탭 fragment.
     모델 속성 ${subTab} 으로 active 결정.
     권한별 노출:
       - hasFinanceAdmin       → 대시보드
       - hasFinanceOperator    → 환불
       - hasFinancePolicyAdmin → 정책
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="adm-card adm-fin-tabs"
     style="padding:0;margin-bottom:16px;display:flex;border-bottom:1px solid #334155;overflow-x:auto;">
    <c:if test="${hasFinanceAdmin}">
        <a href="${pageContext.request.contextPath}/admin/finance"
           class="adm-fin-tab ${subTab eq 'dashboard' ? 'is-active' : ''}"
           style="padding:12px 20px;font-size:13px;font-weight:600;text-decoration:none;
                  border-bottom:2px solid ${subTab eq 'dashboard' ? '#3b82f6' : 'transparent'};
                  color:${subTab eq 'dashboard' ? '#60a5fa' : '#94a3b8'};white-space:nowrap;">
            💰 ${msg_admin_finance_tab_dashboard}
        </a>
    </c:if>
    <c:if test="${hasFinanceOperator}">
        <a href="${pageContext.request.contextPath}/admin/finance/refund"
           class="adm-fin-tab ${subTab eq 'refund' ? 'is-active' : ''}"
           style="padding:12px 20px;font-size:13px;font-weight:600;text-decoration:none;
                  border-bottom:2px solid ${subTab eq 'refund' ? '#3b82f6' : 'transparent'};
                  color:${subTab eq 'refund' ? '#60a5fa' : '#94a3b8'};white-space:nowrap;">
            ↩️ ${msg_admin_finance_tab_refund}
        </a>
    </c:if>
    <c:if test="${hasFinancePolicyAdmin}">
        <a href="${pageContext.request.contextPath}/admin/finance/policy"
           class="adm-fin-tab ${subTab eq 'policy' ? 'is-active' : ''}"
           style="padding:12px 20px;font-size:13px;font-weight:600;text-decoration:none;
                  border-bottom:2px solid ${subTab eq 'policy' ? '#3b82f6' : 'transparent'};
                  color:${subTab eq 'policy' ? '#60a5fa' : '#94a3b8'};white-space:nowrap;">
            ⚙️ ${msg_admin_finance_tab_policy}
        </a>
    </c:if>
</div>
