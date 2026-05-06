<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_baca51856f" code="admin.finance.policy.title"/>
<spring:message var="autoMsg_b6ed905fae" code="admin.finance.policy.tab.limit"/>
<spring:message var="autoMsg_0754281340" code="admin.finance.policy.tab.reward"/>
<spring:message var="autoMsg_fd9a6d5198" code="admin.finance.policy.limit.col.grade"/>
<spring:message var="autoMsg_224800c8bd" code="admin.finance.policy.limit.col.single"/>
<spring:message var="autoMsg_ac1ff7cdf2" code="admin.finance.policy.limit.col.daily"/>
<spring:message var="autoMsg_087030b060" code="admin.finance.policy.limit.col.monthly"/>
<spring:message var="autoMsg_97f7a5ecc7" code="admin.finance.policy.limit.col.active"/>
<spring:message var="autoMsg_be27555dc9" code="admin.finance.policy.limit.col.action"/>
<spring:message var="autoMsg_5175cd04a8" code="admin.finance.grade.${g}"/>
<spring:message var="autoMsg_fbfbe44323" code="admin.finance.policy.limit.placeholder.unlimited"/>
<spring:message var="autoMsg_90b8e67db1" code="admin.finance.policy.limit.toggle.on"/>
<spring:message var="autoMsg_d8f9021c0f" code="admin.finance.policy.limit.note.title"/>
<spring:message var="autoMsg_52b280cae2" code="admin.finance.policy.limit.note.empty"/>
<spring:message var="autoMsg_f2e68f0d11" code="admin.finance.policy.limit.note.failopen"/>
<spring:message var="autoMsg_9a2e0a94e1" code="admin.finance.policy.limit.note.aop"/>
<spring:message var="autoMsg_ec1a151900" code="admin.finance.policy.reward.col.event"/>
<spring:message var="autoMsg_af2378fc95" code="admin.finance.policy.reward.col.grade"/>
<spring:message var="autoMsg_5828d4a02a" code="admin.finance.policy.reward.col.rewardType"/>
<spring:message var="autoMsg_17ec8c8c51" code="admin.finance.policy.reward.col.rate"/>
<spring:message var="autoMsg_6084832356" code="admin.finance.policy.reward.col.fixed"/>
<spring:message var="autoMsg_576700237b" code="admin.finance.policy.reward.col.description"/>
<spring:message var="autoMsg_5621f4f628" code="admin.finance.policy.reward.col.active"/>
<spring:message var="autoMsg_278b562f9c" code="admin.finance.grade.${r.memberGrade}"/>
<spring:message var="autoMsg_9eed3c560a" code="admin.finance.rewardType.${r.rewardType}"/>
<spring:message var="autoMsg_4cfeb7a5e0" code="admin.finance.policy.reward.active.on"/>
<spring:message var="autoMsg_599d28a3d6" code="admin.finance.policy.reward.active.off"/>
<spring:message var="autoMsg_fb5446158b" code="admin.finance.policy.reward.upsert.title"/>
<spring:message var="autoMsg_5c449f46e5" code="admin.finance.rewardType.${t}"/>
<spring:message var="autoMsg_3634030521" code="admin.finance.policy.reward.note.title"/>
<spring:message var="autoMsg_10cb921296" code="admin.finance.policy.reward.note.either"/>
<spring:message var="autoMsg_80e1e8953a" code="admin.finance.policy.reward.note.fallback"/>
<spring:message var="autoMsg_5ce0c9695a" code="admin.finance.policy.reward.note.phased"/>
<c:set var="activeMenu" value="finance"/>
<c:set var="pageTitle">${autoMsg_baca51856f}</c:set>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- 공통 탭바 --%>
    <%@ include file="_tabs.jsp" %>

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

    <%-- 탭 (한도 / 적립률) --%>
    <div class="adm-card" style="padding:0;margin-bottom:16px;">
        <div style="display:flex;border-bottom:1px solid #334155;">
            <button type="button" class="adm-btn adm-btn-ghost adm-fin-policy-tab"
                    id="adm-fin-tab-limit"
                    style="border:0;border-radius:0;padding:12px 20px;border-bottom:2px solid transparent;"
                    onclick="admFinSwitchPolicyTab('limit')">
                💰 ${autoMsg_b6ed905fae}
            </button>
            <button type="button" class="adm-btn adm-btn-ghost adm-fin-policy-tab"
                    id="adm-fin-tab-reward"
                    style="border:0;border-radius:0;padding:12px 20px;border-bottom:2px solid transparent;"
                    onclick="admFinSwitchPolicyTab('reward')">
                ✨ ${autoMsg_0754281340}
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
                    <th style="width:120px;">${autoMsg_fd9a6d5198}</th>
                    <th style="width:160px;text-align:right;">${autoMsg_224800c8bd}</th>
                    <th style="width:160px;text-align:right;">${autoMsg_ac1ff7cdf2}</th>
                    <th style="width:160px;text-align:right;">${autoMsg_087030b060}</th>
                    <th style="width:90px;">${autoMsg_97f7a5ecc7}</th>
                    <th style="width:120px;">${autoMsg_be27555dc9}</th>
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
                                <span class="adm-badge">${autoMsg_5175cd04a8}</span>
                            </td>
                            <td style="text-align:right;">
                                <input type="number" name="singleLimit" min="0" step="1"
                                       value="${row != null ? row.singleLimit : ''}"
                                       placeholder="${autoMsg_fbfbe44323}"
                                       class="adm-input" style="width:140px;text-align:right;padding:6px 8px;font-size:13px;"/>
                            </td>
                            <td style="text-align:right;">
                                <input type="number" name="dailyLimit" min="0" step="1"
                                       value="${row != null ? row.dailyLimit : ''}"
                                       placeholder="${autoMsg_fbfbe44323}"
                                       class="adm-input" style="width:140px;text-align:right;padding:6px 8px;font-size:13px;"/>
                            </td>
                            <td style="text-align:right;">
                                <input type="number" name="monthlyLimit" min="0" step="1"
                                       value="${row != null ? row.monthlyLimit : ''}"
                                       placeholder="${autoMsg_fbfbe44323}"
                                       class="adm-input" style="width:140px;text-align:right;padding:6px 8px;font-size:13px;"/>
                            </td>
                            <td>
                                <label style="display:inline-flex;align-items:center;gap:6px;">
                                    <input type="checkbox" name="isActive" value="true"
                                           ${row == null or row.isActive ? 'checked' : ''}/>
                                    <span style="font-size:12px;">${autoMsg_90b8e67db1}</span>
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
            <strong>※ ${autoMsg_d8f9021c0f}</strong><br/>
            - ${autoMsg_52b280cae2}<br/>
            - ${autoMsg_f2e68f0d11}<br/>
            - ${autoMsg_9a2e0a94e1}
        </div>
    </section>

    <%-- 적립률 정책 탭 --%>
    <section data-tab-panel="reward" style="display:none;">

        <div class="adm-card adm-fin-guide" style="padding:14px 18px;margin-bottom:16px;font-size:13px;">
            <spring:message code="admin.finance.policy.reward.guide"/>
        </div>

        <div class="adm-card" style="padding:0;overflow-x:auto;margin-bottom:14px;">
            <table class="adm-table" style="width:100%;">
                <thead>
                <tr>
                    <th style="width:200px;white-space:nowrap;">${autoMsg_ec1a151900}</th>
                    <th style="width:90px;">${autoMsg_af2378fc95}</th>
                    <th style="width:90px;">${autoMsg_5828d4a02a}</th>
                    <th style="width:110px;text-align:right;">${autoMsg_17ec8c8c51}</th>
                    <th style="width:110px;text-align:right;">${autoMsg_6084832356}</th>
                    <th>${autoMsg_576700237b}</th>
                    <th style="width:70px;">${autoMsg_5621f4f628}</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty rewardPolicies}">
                        <tr><td colspan="7" style="text-align:center;padding:36px;color:#94a3b8;">
                            <spring:message code="admin.finance.policy.reward.empty"/>
                        </td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="r" items="${rewardPolicies}">
                            <tr>
                                <td style="white-space:nowrap;">
                                    <span style="font-size:13px;">
                                        <spring:message code="admin.finance.rewardEvent.${r.eventType}" text="${r.eventType}"/>
                                    </span>
                                    <div style="font-size:10px;color:#94a3b8;font-family:monospace;">${r.eventType}</div>
                                </td>
                                <td><span class="adm-badge">${autoMsg_278b562f9c}</span></td>
                                <td>${autoMsg_9eed3c560a}</td>
                                <td style="text-align:right;">
                                    <c:if test="${r.rewardRate != null}"><fmt:formatNumber value="${r.rewardRate}" pattern="#,##0.00"/>%</c:if>
                                </td>
                                <td style="text-align:right;">
                                    <c:if test="${r.rewardFixed != null}"><fmt:formatNumber value="${r.rewardFixed}" pattern="#,###"/></c:if>
                                </td>
                                <td style="font-size:12px;color:#94a3b8;"><c:out value="${r.description}"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.isActive}"><span class="adm-badge adm-badge-green">${autoMsg_4cfeb7a5e0}</span></c:when>
                                        <c:otherwise><span class="adm-badge">${autoMsg_599d28a3d6}</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>

        <%-- 신규 등록 / 갱신 폼 --%>
        <div class="adm-card" style="padding:16px 18px;">
            <h4 style="margin:0 0 12px 0;font-size:14px;">${autoMsg_fb5446158b}</h4>
            <form method="post" action="${pageContext.request.contextPath}/admin/finance/policy/reward"
                  style="display:grid;grid-template-columns:repeat(6, 1fr);gap:10px;align-items:end;">
                <div>
                    <label style="font-size:11px;display:block;margin-bottom:4px;">${autoMsg_ec1a151900}</label>
                    <input type="text" name="eventType" required maxlength="50"
                           class="adm-input" placeholder="CASH_CHARGE_BONUS"
                           style="width:100%;padding:6px 8px;font-size:12px;"/>
                </div>
                <div>
                    <label style="font-size:11px;display:block;margin-bottom:4px;">${autoMsg_af2378fc95}</label>
                    <select name="memberGrade" class="adm-input" style="width:100%;padding:6px 8px;font-size:12px;">
                        <c:forEach var="g" items="${['ALL','BRONZE','SILVER','GOLD','DIAMOND','PLATINUM']}">
                            <option value="${g}">${autoMsg_5175cd04a8}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label style="font-size:11px;display:block;margin-bottom:4px;">${autoMsg_5828d4a02a}</label>
                    <select name="rewardType" required class="adm-input" style="width:100%;padding:6px 8px;font-size:12px;">
                        <c:forEach var="t" items="${['MILEAGE','POINT']}">
                            <option value="${t}">${autoMsg_5c449f46e5}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <label style="font-size:11px;display:block;margin-bottom:4px;">${autoMsg_17ec8c8c51} (%)</label>
                    <input type="number" name="rewardRate" step="0.01" min="0" max="100"
                           class="adm-input" style="width:100%;padding:6px 8px;font-size:12px;text-align:right;"/>
                </div>
                <div>
                    <label style="font-size:11px;display:block;margin-bottom:4px;">${autoMsg_6084832356}</label>
                    <input type="number" name="rewardFixed" step="1" min="0"
                           class="adm-input" style="width:100%;padding:6px 8px;font-size:12px;text-align:right;"/>
                </div>
                <div style="display:flex;align-items:center;gap:10px;justify-content:center;">
                    <label style="display:inline-flex;align-items:center;gap:4px;font-size:12px;">
                        <input type="checkbox" name="isActive" value="true" checked/>
                        <spring:message code="admin.finance.policy.reward.active.on"/>
                    </label>
                    <button type="submit" class="adm-btn adm-btn-primary" style="padding:6px 18px;font-size:12px;">
                        <spring:message code="admin.finance.policy.reward.upsert.button"/>
                    </button>
                </div>
                <div style="grid-column:1/-1;">
                    <label style="font-size:11px;display:block;margin-bottom:4px;">${autoMsg_576700237b}</label>
                    <input type="text" name="description" maxlength="255"
                           class="adm-input" style="width:100%;padding:6px 8px;font-size:12px;"/>
                </div>
            </form>
        </div>

        <div style="font-size:12px;color:#94a3b8;padding:12px 4px;line-height:1.6;">
            <strong>※ ${autoMsg_3634030521}</strong><br/>
            - ${autoMsg_10cb921296}<br/>
            - ${autoMsg_80e1e8953a}<br/>
            - ${autoMsg_5ce0c9695a}
        </div>
    </section>

    <script>
    (function(){
        var KEY = 'adm-fin-policy-tab';
        function show(tab){
            document.querySelectorAll('[data-tab-panel]').forEach(function(p){
                p.style.display = p.getAttribute('data-tab-panel') === tab ? '' : 'none';
            });
            ['limit','reward'].forEach(function(t){
                var btn = document.getElementById('adm-fin-tab-' + t);
                if (!btn) return;
                btn.style.borderBottomColor = (t === tab) ? '#3b82f6' : 'transparent';
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
