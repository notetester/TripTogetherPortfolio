<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_finance_policy_title" code="admin.finance.policy.title"/>
<spring:message var="msg_admin_finance_policy_limit_placeholder_unlimited" code="admin.finance.policy.limit.placeholder.unlimited"/>
<spring:message var="msg_admin_finance_policy_tab_limit" code="admin.finance.policy.tab.limit"/>
<spring:message var="msg_admin_finance_policy_tab_reward" code="admin.finance.policy.tab.reward"/>
<spring:message var="msg_admin_finance_policy_limit_guide" code="admin.finance.policy.limit.guide"/>
<spring:message var="msg_admin_finance_policy_limit_col_grade" code="admin.finance.policy.limit.col.grade"/>
<spring:message var="msg_admin_finance_policy_limit_col_single" code="admin.finance.policy.limit.col.single"/>
<spring:message var="msg_admin_finance_policy_limit_col_daily" code="admin.finance.policy.limit.col.daily"/>
<spring:message var="msg_admin_finance_policy_limit_col_monthly" code="admin.finance.policy.limit.col.monthly"/>
<spring:message var="msg_admin_finance_policy_limit_col_active" code="admin.finance.policy.limit.col.active"/>
<spring:message var="msg_admin_finance_policy_limit_col_action" code="admin.finance.policy.limit.col.action"/>
<spring:message var="msg_admin_finance_policy_limit_toggle_on" code="admin.finance.policy.limit.toggle.on"/>
<spring:message var="msg_admin_finance_policy_limit_save" code="admin.finance.policy.limit.save"/>
<spring:message var="msg_admin_finance_policy_limit_note_title" code="admin.finance.policy.limit.note.title"/>
<spring:message var="msg_admin_finance_policy_limit_note_empty" code="admin.finance.policy.limit.note.empty"/>
<spring:message var="msg_admin_finance_policy_limit_note_failopen" code="admin.finance.policy.limit.note.failopen"/>
<spring:message var="msg_admin_finance_policy_limit_note_aop" code="admin.finance.policy.limit.note.aop"/>
<spring:message var="msg_admin_finance_policy_reward_guide" code="admin.finance.policy.reward.guide"/>
<spring:message var="msg_admin_finance_policy_reward_col_event" code="admin.finance.policy.reward.col.event"/>
<spring:message var="msg_admin_finance_policy_reward_col_grade" code="admin.finance.policy.reward.col.grade"/>
<spring:message var="msg_admin_finance_policy_reward_col_rewardType" code="admin.finance.policy.reward.col.rewardType"/>
<spring:message var="msg_admin_finance_policy_reward_col_rate" code="admin.finance.policy.reward.col.rate"/>
<spring:message var="msg_admin_finance_policy_reward_col_fixed" code="admin.finance.policy.reward.col.fixed"/>
<spring:message var="msg_admin_finance_policy_reward_col_description" code="admin.finance.policy.reward.col.description"/>
<spring:message var="msg_admin_finance_policy_reward_col_active" code="admin.finance.policy.reward.col.active"/>
<spring:message var="msg_admin_finance_policy_reward_empty" code="admin.finance.policy.reward.empty"/>
<spring:message var="msg_admin_finance_policy_reward_active_on" code="admin.finance.policy.reward.active.on"/>
<spring:message var="msg_admin_finance_policy_reward_active_off" code="admin.finance.policy.reward.active.off"/>
<spring:message var="msg_admin_finance_policy_reward_upsert_title" code="admin.finance.policy.reward.upsert.title"/>
<spring:message var="msg_admin_finance_policy_reward_upsert_button" code="admin.finance.policy.reward.upsert.button"/>
<spring:message var="msg_admin_finance_policy_reward_note_title" code="admin.finance.policy.reward.note.title"/>
<spring:message var="msg_admin_finance_policy_reward_note_either" code="admin.finance.policy.reward.note.either"/>
<spring:message var="msg_admin_finance_policy_reward_note_fallback" code="admin.finance.policy.reward.note.fallback"/>
<spring:message var="msg_admin_finance_policy_reward_note_phased" code="admin.finance.policy.reward.note.phased"/>
<c:set var="activeMenu" value="finance"/>
<c:set var="pageTitle">${msg_admin_finance_policy_title}</c:set>
<%@ include file="../layout.jsp" %>


<div class="adm-content adm-finance-page">

    <%-- 공통 탭바 --%>
    <%@ include file="_tabs.jsp" %>

    <%-- 메시지 토스트 --%>
    <c:if test="${not empty policyMessage}">
        <div class="adm-card adm-finance-alert is-success">
            <c:out value="${policyMessage}"/>
        </div>
    </c:if>
    <c:if test="${not empty policyError}">
        <div class="adm-card adm-finance-alert is-error">
            <c:out value="${policyError}"/>
        </div>
    </c:if>

    <%-- 탭 (한도 / 적립률) --%>
    <div class="adm-card adm-finance-policy-tabs-card adm-overflow-visible">
        <div class="adm-finance-policy-tabs">
            <button type="button" class="adm-finance-policy-tab"
                    id="adm-fin-tab-limit"
                    onclick="admFinSwitchPolicyTab('limit')">
                💰 ${msg_admin_finance_policy_tab_limit}
            </button>
            <button type="button" class="adm-finance-policy-tab"
                    id="adm-fin-tab-reward"
                    onclick="admFinSwitchPolicyTab('reward')">
                ✨ ${msg_admin_finance_policy_tab_reward}
            </button>
        </div>
    </div>

    <%-- 한도 정책 탭 --%>
    <section data-tab-panel="limit">

        <div class="adm-card adm-fin-guide adm-finance-guide-card">
            ${msg_admin_finance_policy_limit_guide}
        </div>

        <div class="adm-card adm-finance-table-card adm-finance-policy-table-card adm-finance-managed-card adm-overflow-visible">
            <div class="adm-card-head">
                <div class="adm-card-title">${msg_admin_finance_policy_tab_limit}</div>
            </div>
            <div class="adm-table-wrap">
            <table class="adm-table adm-finance-policy-limit-table" data-admin-list-ignore="true">
                <colgroup>
                    <col class="adm-finance-col-grade-wide">
                    <col class="adm-finance-col-policy-number">
                    <col class="adm-finance-col-policy-number">
                    <col class="adm-finance-col-policy-number">
                    <col class="adm-finance-col-status">
                    <col class="adm-finance-col-action-wide">
                </colgroup>
                <thead>
                <tr>
                    <th>${msg_admin_finance_policy_limit_col_grade}</th>
                    <th class="adm-align-right">${msg_admin_finance_policy_limit_col_single}</th>
                    <th class="adm-align-right">${msg_admin_finance_policy_limit_col_daily}</th>
                    <th class="adm-align-right">${msg_admin_finance_policy_limit_col_monthly}</th>
                    <th>${msg_admin_finance_policy_limit_col_active}</th>
                    <th>${msg_admin_finance_policy_limit_col_action}</th>
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
                                <span class="adm-badge"><spring:message var="msg_admin_finance_grade_g" code="admin.finance.grade.${g}"/>${msg_admin_finance_grade_g}</span>
                            </td>
                            <td class="adm-align-right">
                                <input type="number" name="singleLimit" min="0" step="1"
                                       value="${row != null ? row.singleLimit : ''}"
                                       placeholder="${msg_admin_finance_policy_limit_placeholder_unlimited}"
                                       class="adm-input adm-finance-policy-number-input"/>
                            </td>
                            <td class="adm-align-right">
                                <input type="number" name="dailyLimit" min="0" step="1"
                                       value="${row != null ? row.dailyLimit : ''}"
                                       placeholder="${msg_admin_finance_policy_limit_placeholder_unlimited}"
                                       class="adm-input adm-finance-policy-number-input"/>
                            </td>
                            <td class="adm-align-right">
                                <input type="number" name="monthlyLimit" min="0" step="1"
                                       value="${row != null ? row.monthlyLimit : ''}"
                                       placeholder="${msg_admin_finance_policy_limit_placeholder_unlimited}"
                                       class="adm-input adm-finance-policy-number-input"/>
                            </td>
                            <td>
                                <label class="adm-finance-check-inline">
                                    <input type="checkbox" name="isActive" value="true"
                                           ${row == null or row.isActive ? 'checked' : ''}/>
                                    <span>${msg_admin_finance_policy_limit_toggle_on}</span>
                                </label>
                            </td>
                            <td>
                                <button type="submit" class="adm-btn adm-btn-primary adm-finance-save-btn">
                                    ${msg_admin_finance_policy_limit_save}
                                </button>
                            </td>
                        </form>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            </div>
        </div>

        <div class="adm-finance-policy-note">
            <strong>※ ${msg_admin_finance_policy_limit_note_title}</strong><br/>
            - ${msg_admin_finance_policy_limit_note_empty}<br/>
            - ${msg_admin_finance_policy_limit_note_failopen}<br/>
            - ${msg_admin_finance_policy_limit_note_aop}
        </div>
    </section>

    <%-- 적립률 정책 탭 --%>
    <section data-tab-panel="reward" hidden>

        <div class="adm-card adm-fin-guide adm-finance-guide-card">
            ${msg_admin_finance_policy_reward_guide}
        </div>

        <div class="adm-card adm-finance-table-card adm-finance-policy-reward-table-card adm-finance-managed-card adm-overflow-visible">
            <div class="adm-card-head">
                <div class="adm-card-title">${msg_admin_finance_policy_tab_reward}</div>
            </div>
            <div class="adm-table-wrap">
            <table class="adm-table adm-finance-policy-reward-table" data-admin-list-ignore="true">
                <colgroup>
                    <col class="adm-finance-col-event">
                    <col class="adm-finance-col-grade">
                    <col class="adm-finance-col-method">
                    <col class="adm-finance-col-policy-small">
                    <col class="adm-finance-col-policy-small">
                    <col>
                    <col class="adm-finance-col-status">
                </colgroup>
                <thead>
                <tr>
                    <th>${msg_admin_finance_policy_reward_col_event}</th>
                    <th>${msg_admin_finance_policy_reward_col_grade}</th>
                    <th>${msg_admin_finance_policy_reward_col_rewardType}</th>
                    <th class="adm-align-right">${msg_admin_finance_policy_reward_col_rate}</th>
                    <th class="adm-align-right">${msg_admin_finance_policy_reward_col_fixed}</th>
                    <th>${msg_admin_finance_policy_reward_col_description}</th>
                    <th>${msg_admin_finance_policy_reward_col_active}</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty rewardPolicies}">
                        <tr class="adm-local-empty"><td colspan="7" class="adm-local-empty-cell">
                            ${msg_admin_finance_policy_reward_empty}
                        </td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="r" items="${rewardPolicies}">
                            <tr>
                                <td class="adm-finance-event-cell">
                                    <span class="adm-finance-event-name">
                                        <spring:message var="msg_admin_finance_rewardEvent_r_eventType_text_r_eventType" code="admin.finance.rewardEvent.${r.eventType}" text="${r.eventType}"/>${msg_admin_finance_rewardEvent_r_eventType_text_r_eventType}
                                    </span>
                                    <div class="adm-finance-event-code">${r.eventType}</div>
                                </td>
                                <td><span class="adm-badge"><spring:message var="msg_admin_finance_grade_r_memberGrade" code="admin.finance.grade.${r.memberGrade}"/>${msg_admin_finance_grade_r_memberGrade}</span></td>
                                <td><spring:message var="msg_admin_finance_rewardType_r_rewardType" code="admin.finance.rewardType.${r.rewardType}"/>${msg_admin_finance_rewardType_r_rewardType}</td>
                                <td class="adm-align-right">
                                    <c:if test="${r.rewardRate != null}"><fmt:formatNumber value="${r.rewardRate}" pattern="#,##0.00"/>%</c:if>
                                </td>
                                <td class="adm-align-right">
                                    <c:if test="${r.rewardFixed != null}"><fmt:formatNumber value="${r.rewardFixed}" pattern="#,###"/></c:if>
                                </td>
                                <td class="adm-finance-desc-cell"><c:out value="${r.description}"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.isActive}"><span class="adm-badge adm-badge-green">${msg_admin_finance_policy_reward_active_on}</span></c:when>
                                        <c:otherwise><span class="adm-badge">${msg_admin_finance_policy_reward_active_off}</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
            </div>
        </div>

        <%-- 신규 등록 / 갱신 폼 --%>
        <div class="adm-card adm-finance-reward-form-card adm-finance-managed-card adm-overflow-visible">
            <div class="adm-card-head">
                <div class="adm-card-title">${msg_admin_finance_policy_reward_upsert_title}</div>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/admin/finance/policy/reward"
                  class="adm-finance-reward-form">
                <div>
                    <label class="adm-finance-field-label">${msg_admin_finance_policy_reward_col_event}</label>
                    <input type="text" name="eventType" required maxlength="50"
                           class="adm-input adm-finance-compact-input" placeholder="CASH_CHARGE_BONUS"/>
                </div>
                <div>
                    <label class="adm-finance-field-label">${msg_admin_finance_policy_reward_col_grade}</label>
                    <select name="memberGrade" class="adm-select adm-finance-compact-input">
                        <c:forEach var="g" items="${['ALL','BRONZE','SILVER','GOLD','DIAMOND','PLATINUM']}">
                            <option value="${g}"><spring:message var="msg_admin_finance_grade_g" code="admin.finance.grade.${g}"/>${msg_admin_finance_grade_g}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label class="adm-finance-field-label">${msg_admin_finance_policy_reward_col_rewardType}</label>
                    <select name="rewardType" required class="adm-select adm-finance-compact-input">
                        <c:forEach var="t" items="${['MILEAGE','POINT']}">
                            <option value="${t}"><spring:message var="msg_admin_finance_rewardType_t" code="admin.finance.rewardType.${t}"/>${msg_admin_finance_rewardType_t}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label class="adm-finance-field-label">${msg_admin_finance_policy_reward_col_rate} (%)</label>
                    <input type="number" name="rewardRate" step="0.01" min="0" max="100"
                           class="adm-input adm-finance-compact-input adm-align-right"/>
                </div>
                <div>
                    <label class="adm-finance-field-label">${msg_admin_finance_policy_reward_col_fixed}</label>
                    <input type="number" name="rewardFixed" step="1" min="0"
                           class="adm-input adm-finance-compact-input adm-align-right"/>
                </div>
                <div class="adm-finance-reward-actions">
                    <label class="adm-finance-check-inline">
                        <input type="checkbox" name="isActive" value="true" checked/>
                        ${msg_admin_finance_policy_reward_active_on}
                    </label>
                    <button type="submit" class="adm-btn adm-btn-primary adm-finance-save-btn">
                        ${msg_admin_finance_policy_reward_upsert_button}
                    </button>
                </div>
                <div class="adm-finance-reward-description-field">
                    <label class="adm-finance-field-label">${msg_admin_finance_policy_reward_col_description}</label>
                    <input type="text" name="description" maxlength="255"
                           class="adm-input adm-finance-compact-input"/>
                </div>
            </form>
        </div>

        <div class="adm-finance-policy-note">
            <strong>※ ${msg_admin_finance_policy_reward_note_title}</strong><br/>
            - ${msg_admin_finance_policy_reward_note_either}<br/>
            - ${msg_admin_finance_policy_reward_note_fallback}<br/>
            - ${msg_admin_finance_policy_reward_note_phased}
        </div>
    </section>

    <script>
    (function(){
        var KEY = 'adm-fin-policy-tab';
        function show(tab){
            document.querySelectorAll('[data-tab-panel]').forEach(function(p){
                p.hidden = p.getAttribute('data-tab-panel') !== tab;
            });
            ['limit','reward'].forEach(function(t){
                var btn = document.getElementById('adm-fin-tab-' + t);
                if (!btn) return;
                btn.classList.toggle('is-active', t === tab);
            });
            try { localStorage.setItem(KEY, tab); } catch(e) {}
        }
        window.admFinSwitchPolicyTab = show;
        var initial = 'limit';
        try { initial = localStorage.getItem(KEY) || 'limit'; } catch(e) {}
        show(initial);
    })();
    </script>

</div>

<%@ include file="../layout-close.jsp" %>
