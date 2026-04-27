<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="finance"/>
<c:set var="pageTitle"><spring:message code="admin.finance.policy.title"/></c:set>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- 메시지 토스트 --%>
    <c:if test="${not empty policyMessage}">
        <div class="adm-card" style="padding:12px 16px;margin-bottom:12px;border-left:4px solid #22c55e;">
            <c:out value="${policyMessage}"/>
        </div>
    </c:if>
    <c:if test="${not empty policyError}">
        <div class="adm-card" style="padding:12px 16px;margin-bottom:12px;border-left:4px solid #ef4444;">
            <c:out value="${policyError}"/>
        </div>
    </c:if>

    <%-- 탭 (한도 / 적립률 — 적립률은 Phase 13에서 활성화) --%>
    <div class="adm-card" style="padding:0;margin-bottom:16px;">
        <div style="display:flex;border-bottom:1px solid #334155;">
            <button type="button" class="adm-btn adm-btn-ghost adm-fin-policy-tab is-active"
                    style="border:0;border-radius:0;padding:12px 20px;border-bottom:2px solid #3b82f6;"
                    data-tab="limit">
                💰 <spring:message code="admin.finance.policy.tab.limit"/>
            </button>
            <button type="button" class="adm-btn adm-btn-ghost adm-fin-policy-tab"
                    style="border:0;border-radius:0;padding:12px 20px;opacity:.55;"
                    data-tab="reward" disabled>
                ✨ <spring:message code="admin.finance.policy.tab.reward"/> <span style="font-size:11px;">(Phase 13)</span>
            </button>
        </div>
    </div>

    <%-- 한도 정책 탭 --%>
    <section data-tab-panel="limit">

        <div class="adm-card adm-fin-guide" style="padding:14px 18px;margin-bottom:16px;font-size:13px;">
            <spring:message code="admin.finance.policy.limit.guide"/>
        </div>

        <div class="adm-card" style="padding:0;overflow-x:auto;">
            <table class="adm-table" style="width:100%;">
                <thead>
                <tr>
                    <th style="width:120px;"><spring:message code="admin.finance.policy.limit.col.grade"/></th>
                    <th style="width:160px;text-align:right;"><spring:message code="admin.finance.policy.limit.col.single"/></th>
                    <th style="width:160px;text-align:right;"><spring:message code="admin.finance.policy.limit.col.daily"/></th>
                    <th style="width:160px;text-align:right;"><spring:message code="admin.finance.policy.limit.col.monthly"/></th>
                    <th style="width:90px;"><spring:message code="admin.finance.policy.limit.col.active"/></th>
                    <th style="width:120px;"><spring:message code="admin.finance.policy.limit.col.action"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="g" items="${['BRONZE','SILVER','GOLD','DIAMOND','PLATINUM']}">
                    <c:set var="row" value="${null}"/>
                    <c:forEach var="p" items="${limitPolicies}">
                        <c:if test="${p.memberGrade eq g}"><c:set var="row" value="${p}"/></c:if>
                    </c:forEach>
                    <tr>
                        <form method="post" action="${pageContext.request.contextPath}/admin/finance/policy/limit">
                            <td>
                                <input type="hidden" name="memberGrade" value="${g}"/>
                                <span class="adm-badge">${g}</span>
                            </td>
                            <td style="text-align:right;">
                                <input type="number" name="singleLimit" min="0" step="1"
                                       value="${row != null ? row.singleLimit : ''}"
                                       placeholder="<spring:message code='admin.finance.policy.limit.placeholder.unlimited'/>"
                                       class="adm-input" style="width:140px;text-align:right;padding:6px 8px;font-size:13px;"/>
                            </td>
                            <td style="text-align:right;">
                                <input type="number" name="dailyLimit" min="0" step="1"
                                       value="${row != null ? row.dailyLimit : ''}"
                                       placeholder="<spring:message code='admin.finance.policy.limit.placeholder.unlimited'/>"
                                       class="adm-input" style="width:140px;text-align:right;padding:6px 8px;font-size:13px;"/>
                            </td>
                            <td style="text-align:right;">
                                <input type="number" name="monthlyLimit" min="0" step="1"
                                       value="${row != null ? row.monthlyLimit : ''}"
                                       placeholder="<spring:message code='admin.finance.policy.limit.placeholder.unlimited'/>"
                                       class="adm-input" style="width:140px;text-align:right;padding:6px 8px;font-size:13px;"/>
                            </td>
                            <td>
                                <label style="display:inline-flex;align-items:center;gap:6px;">
                                    <input type="checkbox" name="isActive" value="true"
                                           ${row == null or row.isActive ? 'checked' : ''}/>
                                    <span style="font-size:12px;"><spring:message code="admin.finance.policy.limit.toggle.on"/></span>
                                </label>
                            </td>
                            <td>
                                <button type="submit" class="adm-btn adm-btn-primary" style="padding:6px 12px;font-size:12px;">
                                    <spring:message code="admin.finance.policy.limit.save"/>
                                </button>
                            </td>
                        </form>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div style="font-size:12px;color:#94a3b8;padding:12px 4px;line-height:1.6;">
            <strong>※ <spring:message code="admin.finance.policy.limit.note.title"/></strong><br/>
            - <spring:message code="admin.finance.policy.limit.note.empty"/><br/>
            - <spring:message code="admin.finance.policy.limit.note.failopen"/><br/>
            - <spring:message code="admin.finance.policy.limit.note.aop"/>
        </div>
    </section>

</div>

<%@ include file="../layout-close.jsp" %>
