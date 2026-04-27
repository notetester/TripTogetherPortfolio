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

    <%-- 탭 (한도 / 적립률) --%>
    <div class="adm-card" style="padding:0;margin-bottom:16px;">
        <div style="display:flex;border-bottom:1px solid #334155;">
            <button type="button" class="adm-btn adm-btn-ghost adm-fin-policy-tab"
                    id="adm-fin-tab-limit"
                    style="border:0;border-radius:0;padding:12px 20px;border-bottom:2px solid transparent;"
                    onclick="admFinSwitchPolicyTab('limit')">
                💰 <spring:message code="admin.finance.policy.tab.limit"/>
            </button>
            <button type="button" class="adm-btn adm-btn-ghost adm-fin-policy-tab"
                    id="adm-fin-tab-reward"
                    style="border:0;border-radius:0;padding:12px 20px;border-bottom:2px solid transparent;"
                    onclick="admFinSwitchPolicyTab('reward')">
                ✨ <spring:message code="admin.finance.policy.tab.reward"/>
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

    <%-- 적립률 정책 탭 --%>
    <section data-tab-panel="reward" style="display:none;">

        <div class="adm-card adm-fin-guide" style="padding:14px 18px;margin-bottom:16px;font-size:13px;">
            <spring:message code="admin.finance.policy.reward.guide"/>
        </div>

        <div class="adm-card" style="padding:0;overflow-x:auto;margin-bottom:14px;">
            <table class="adm-table" style="width:100%;">
                <thead>
                <tr>
                    <th style="width:100px;"><spring:message code="admin.finance.policy.reward.col.event"/></th>
                    <th style="width:90px;"><spring:message code="admin.finance.policy.reward.col.grade"/></th>
                    <th style="width:90px;"><spring:message code="admin.finance.policy.reward.col.rewardType"/></th>
                    <th style="width:110px;text-align:right;"><spring:message code="admin.finance.policy.reward.col.rate"/></th>
                    <th style="width:110px;text-align:right;"><spring:message code="admin.finance.policy.reward.col.fixed"/></th>
                    <th><spring:message code="admin.finance.policy.reward.col.description"/></th>
                    <th style="width:70px;"><spring:message code="admin.finance.policy.reward.col.active"/></th>
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
                                <td><span style="font-size:11px;font-family:monospace;">${r.eventType}</span></td>
                                <td><span class="adm-badge">${r.memberGrade}</span></td>
                                <td>${r.rewardType}</td>
                                <td style="text-align:right;">
                                    <c:if test="${r.rewardRate != null}"><fmt:formatNumber value="${r.rewardRate}" pattern="#,##0.00"/>%</c:if>
                                </td>
                                <td style="text-align:right;">
                                    <c:if test="${r.rewardFixed != null}"><fmt:formatNumber value="${r.rewardFixed}" pattern="#,###"/></c:if>
                                </td>
                                <td style="font-size:12px;color:#94a3b8;"><c:out value="${r.description}"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.isActive}"><span class="adm-badge adm-badge-green"><spring:message code="admin.finance.policy.reward.active.on"/></span></c:when>
                                        <c:otherwise><span class="adm-badge"><spring:message code="admin.finance.policy.reward.active.off"/></span></c:otherwise>
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
            <h4 style="margin:0 0 12px 0;font-size:14px;"><spring:message code="admin.finance.policy.reward.upsert.title"/></h4>
            <form method="post" action="${pageContext.request.contextPath}/admin/finance/policy/reward"
                  style="display:grid;grid-template-columns:repeat(6, 1fr);gap:10px;align-items:end;">
                <div>
                    <label style="font-size:11px;display:block;margin-bottom:4px;"><spring:message code="admin.finance.policy.reward.col.event"/></label>
                    <input type="text" name="eventType" required maxlength="50"
                           class="adm-input" placeholder="CASH_CHARGE_BONUS"
                           style="width:100%;padding:6px 8px;font-size:12px;"/>
                </div>
                <div>
                    <label style="font-size:11px;display:block;margin-bottom:4px;"><spring:message code="admin.finance.policy.reward.col.grade"/></label>
                    <select name="memberGrade" class="adm-input" style="width:100%;padding:6px 8px;font-size:12px;">
                        <option value="ALL">ALL</option>
                        <option value="BRONZE">BRONZE</option>
                        <option value="SILVER">SILVER</option>
                        <option value="GOLD">GOLD</option>
                        <option value="DIAMOND">DIAMOND</option>
                        <option value="PLATINUM">PLATINUM</option>
                    </select>
                </div>
                <div>
                    <label style="font-size:11px;display:block;margin-bottom:4px;"><spring:message code="admin.finance.policy.reward.col.rewardType"/></label>
                    <select name="rewardType" required class="adm-input" style="width:100%;padding:6px 8px;font-size:12px;">
                        <option value="MILEAGE">MILEAGE</option>
                        <option value="POINT">POINT</option>
                    </select>
                </div>
                <div>
                    <label style="font-size:11px;display:block;margin-bottom:4px;"><spring:message code="admin.finance.policy.reward.col.rate"/> (%)</label>
                    <input type="number" name="rewardRate" step="0.01" min="0" max="100"
                           class="adm-input" style="width:100%;padding:6px 8px;font-size:12px;text-align:right;"/>
                </div>
                <div>
                    <label style="font-size:11px;display:block;margin-bottom:4px;"><spring:message code="admin.finance.policy.reward.col.fixed"/></label>
                    <input type="number" name="rewardFixed" step="1" min="0"
                           class="adm-input" style="width:100%;padding:6px 8px;font-size:12px;text-align:right;"/>
                </div>
                <div style="display:flex;align-items:end;gap:8px;">
                    <label style="display:inline-flex;align-items:center;gap:4px;font-size:12px;flex:0 0 auto;">
                        <input type="checkbox" name="isActive" value="true" checked/>
                        <spring:message code="admin.finance.policy.reward.active.on"/>
                    </label>
                    <button type="submit" class="adm-btn adm-btn-primary" style="padding:6px 12px;font-size:12px;flex:1 1 auto;">
                        <spring:message code="admin.finance.policy.reward.upsert.button"/>
                    </button>
                </div>
                <div style="grid-column:1/-1;">
                    <label style="font-size:11px;display:block;margin-bottom:4px;"><spring:message code="admin.finance.policy.reward.col.description"/></label>
                    <input type="text" name="description" maxlength="255"
                           class="adm-input" style="width:100%;padding:6px 8px;font-size:12px;"/>
                </div>
            </form>
        </div>

        <div style="font-size:12px;color:#94a3b8;padding:12px 4px;line-height:1.6;">
            <strong>※ <spring:message code="admin.finance.policy.reward.note.title"/></strong><br/>
            - <spring:message code="admin.finance.policy.reward.note.either"/><br/>
            - <spring:message code="admin.finance.policy.reward.note.fallback"/><br/>
            - <spring:message code="admin.finance.policy.reward.note.phased"/>
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
