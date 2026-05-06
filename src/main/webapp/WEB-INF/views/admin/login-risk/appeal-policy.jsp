<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<spring:message var="autoMsg_55a40d7407" code="security.admin.appealPolicy.title"/>
<spring:message var="autoMsg_94e7232439" code="security.admin.appealPolicy.desc"/>
<spring:message var="autoMsg_82564e7691" code="security.admin.nav.appeals"/>
<spring:message var="autoMsg_409891afa7" code="security.admin.nav.policies"/>
<spring:message var="autoMsg_dd6b89110d" code="security.admin.appealPolicy.cardTitle"/>
<spring:message var="autoMsg_f6ee708105" code="security.admin.appealPolicy.section.channel"/>
<spring:message var="autoMsg_88e2b83e6f" code="security.admin.appealPolicy.maxOpenAppealsPerCase"/>
<spring:message var="autoMsg_6b5c6cdf30" code="security.admin.appealPolicy.section.cooldown"/>
<spring:message var="autoMsg_26fa039cb2" code="security.admin.appealPolicy.rejectedCooldownMinutes"/>
<spring:message var="autoMsg_1d419db561" code="security.admin.appealPolicy.maxRejectedCount"/>
<spring:message var="autoMsg_f4a8e4a12e" code="security.admin.appealPolicy.ipDailyAppealLimit"/>
<spring:message var="autoMsg_836ad80a68" code="security.admin.appealPolicy.section.email"/>
<spring:message var="autoMsg_b782ebe6ee" code="security.admin.appealPolicy.verificationWindowMinutes"/>
<spring:message var="autoMsg_5d5ee5e889" code="security.admin.appealPolicy.maxVerificationEmails"/>
<spring:message var="autoMsg_f37bb0b2a0" code="security.admin.appealPolicy.verificationTokenTtlMinutes"/>
<spring:message var="autoMsg_32f08071a2" code="security.admin.appealPolicy.protectedAppealTokenTtlDays"/>
<spring:message var="autoMsg_f813f62844" code="security.admin.appealPolicy.allowedEmailDomains"/>
<spring:message var="autoMsg_8bdd4e3e49" code="security.admin.appealPolicy.blockedEmailDomains"/>
<spring:message var="autoMsg_49cf4daf70" code="security.admin.appealPolicy.section.result"/>
<spring:message var="autoMsg_2192a7f9be" code="security.admin.appealPolicy.resultLookupWindowMinutes"/>
<spring:message var="autoMsg_e8cb429434" code="security.admin.appealPolicy.maxResultLookupFailures"/>
<spring:message var="autoMsg_4ea19b17c4" code="security.admin.appealPolicy.resultLookupRetentionDays"/>
<spring:message var="autoMsg_3ca4faf40c" code="security.admin.appealPolicy.section.captcha"/>
<spring:message var="autoMsg_3196dcbac0" code="security.admin.appealPolicy.captchaProviderCode"/>
<spring:message var="autoMsg_44eb8e22c2" code="security.admin.appealPolicy.captchaNote"/>
<spring:message var="autoMsg_5a75e7c1b1" code="security.admin.common.description"/>
<spring:message var="autoMsg_ddcf0df3be" code="security.admin.common.save"/>
<spring:message var="autoMsg_db55f279b1" code="security.admin.appealPolicy.history.title"/>
<spring:message var="autoMsg_daeefbda30" code="security.admin.appealPolicy.history.desc"/>
<spring:message var="autoMsg_eb8fdc9fec" code="security.admin.appealPolicy.history.version"/>
<spring:message var="autoMsg_d9679e1e0a" code="security.admin.appealPolicy.history.changeType"/>
<spring:message var="autoMsg_ca540a1534" code="security.admin.appealPolicy.history.actor"/>
<spring:message var="autoMsg_6e1ca2094d" code="security.admin.appealPolicy.history.changedAt"/>
<spring:message var="autoMsg_692119d092" code="security.admin.appealPolicy.history.snapshot"/>
<spring:message var="autoMsg_a0e9b9f905" code="security.admin.appealPolicy.history.showSnapshot"/>
<spring:message var="autoMsg_94f7854241" code="security.admin.appealPolicy.history.before"/>
<spring:message var="autoMsg_ad69c9ef1a" code="security.admin.appealPolicy.history.after"/>
<spring:message var="autoMsg_4983b87e4c" code="security.admin.appealPolicy.history.empty"/>
<c:set var="activeMenu" value="securityAppealPolicy"/>
<spring:message var="pageTitle" code="security.admin.appealPolicy.title"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${autoMsg_55a40d7407}</h1>
            <p class="adm-page-desc">${autoMsg_94e7232439}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/appeals">${autoMsg_82564e7691}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies">${autoMsg_409891afa7}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeal-policy" class="adm-card">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">${autoMsg_dd6b89110d}</div>
                <div class="adm-muted"><c:out value="${policy.policyCode}" default="DEFAULT"/></div>
            </div>
            <label class="adm-check">
                <input type="checkbox" name="active" ${policy.active ? 'checked' : ''}>
                <spring:message code="security.admin.common.enabled"/>
            </label>
        </div>

        <div class="adm-card-body">
            <input type="hidden" name="policyIdx" value="${policy.policyIdx}">
            <input type="hidden" name="policyCode" value="${fn:escapeXml(policy.policyCode)}">

            <h3 style="margin:4px 0 10px;">${autoMsg_f6ee708105}</h3>
            <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr)); gap:12px;">
                <label class="adm-check" style="align-self:end;">
                    <input type="checkbox" name="allowMultipleOpenAppeals" ${policy.allowMultipleOpenAppeals ? 'checked' : ''}>
                    <spring:message code="security.admin.appealPolicy.allowMultipleOpenAppeals"/>
                </label>
                <label>${autoMsg_88e2b83e6f}
                    <input class="adm-input" type="number" min="1" name="maxOpenAppealsPerCase" value="${policy.maxOpenAppealsPerCase}">
                </label>
                <label class="adm-check" style="align-self:end;">
                    <input type="checkbox" name="closedBlocksNewAppeals" ${policy.closedBlocksNewAppeals ? 'checked' : ''}>
                    <spring:message code="security.admin.appealPolicy.closedBlocksNewAppeals"/>
                </label>
            </div>

            <h3 style="margin:22px 0 10px;">${autoMsg_6b5c6cdf30}</h3>
            <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr)); gap:12px;">
                <label>${autoMsg_26fa039cb2}
                    <input class="adm-input" type="number" min="0" name="rejectedCooldownMinutes" value="${policy.rejectedCooldownMinutes}">
                </label>
                <label>${autoMsg_1d419db561}
                    <input class="adm-input" type="number" min="1" name="maxRejectedCount" value="${policy.maxRejectedCount}">
                </label>
                <label>${autoMsg_f4a8e4a12e}
                    <input class="adm-input" type="number" min="1" name="ipDailyAppealLimit" value="${policy.ipDailyAppealLimit}">
                </label>
            </div>

            <h3 style="margin:22px 0 10px;">${autoMsg_836ad80a68}</h3>
            <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr)); gap:12px;">
                <label>${autoMsg_b782ebe6ee}
                    <input class="adm-input" type="number" min="1" name="verificationWindowMinutes" value="${policy.verificationWindowMinutes}">
                </label>
                <label>${autoMsg_5d5ee5e889}
                    <input class="adm-input" type="number" min="1" name="maxVerificationEmails" value="${policy.maxVerificationEmails}">
                </label>
                <label>${autoMsg_f37bb0b2a0}
                    <input class="adm-input" type="number" min="1" name="verificationTokenTtlMinutes" value="${policy.verificationTokenTtlMinutes}">
                </label>
                <label>${autoMsg_32f08071a2}
                    <input class="adm-input" type="number" min="1" name="protectedAppealTokenTtlDays" value="${policy.protectedAppealTokenTtlDays}">
                </label>
                <label>${autoMsg_f813f62844}
                    <input class="adm-input" type="text" name="allowedEmailDomains" value="${fn:escapeXml(policy.allowedEmailDomains)}" placeholder="example.com,*.example.org">
                </label>
                <label>${autoMsg_8bdd4e3e49}
                    <input class="adm-input" type="text" name="blockedEmailDomains" value="${fn:escapeXml(policy.blockedEmailDomains)}" placeholder="spam.example.com">
                </label>
            </div>

            <h3 style="margin:22px 0 10px;">${autoMsg_49cf4daf70}</h3>
            <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr)); gap:12px;">
                <label>${autoMsg_2192a7f9be}
                    <input class="adm-input" type="number" min="1" name="resultLookupWindowMinutes" value="${policy.resultLookupWindowMinutes}">
                </label>
                <label>${autoMsg_e8cb429434}
                    <input class="adm-input" type="number" min="1" name="maxResultLookupFailures" value="${policy.maxResultLookupFailures}">
                </label>
                <label>${autoMsg_4ea19b17c4}
                    <input class="adm-input" type="number" min="0" name="resultLookupRetentionDays" value="${policy.resultLookupRetentionDays}">
                </label>
            </div>

            <h3 style="margin:22px 0 10px;">${autoMsg_3ca4faf40c}</h3>
            <div class="adm-form-grid" style="grid-template-columns:repeat(2,minmax(0,1fr)); gap:12px;">
                <label class="adm-check" style="align-self:end;">
                    <input type="checkbox" name="captchaEnabled" ${policy.captchaEnabled ? 'checked' : ''}>
                    <spring:message code="security.admin.appealPolicy.captchaEnabled"/>
                </label>
                <label>${autoMsg_3196dcbac0}
                    <input class="adm-input" type="text" name="captchaProviderCode" value="${fn:escapeXml(policy.captchaProviderCode)}" placeholder="MOCK_TURNSTILE">
                </label>
            </div>
            <p class="adm-muted" style="margin-top:8px;">${autoMsg_44eb8e22c2}</p>

            <label style="display:block;margin-top:16px;">${autoMsg_5a75e7c1b1}
                <textarea class="adm-input" name="description" rows="3"><c:out value="${policy.description}"/></textarea>
            </label>

            <div class="adm-actions" style="margin-top:16px;">
                <button type="submit" class="adm-btn primary">${autoMsg_ddcf0df3be}</button>
            </div>
        </div>
    </form>

    <div class="adm-card" style="margin-top:16px;">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title">${autoMsg_db55f279b1}</div>
                <div class="adm-muted">${autoMsg_daeefbda30}</div>
            </div>
        </div>
        <div class="adm-card-body">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr>
                        <th>${autoMsg_eb8fdc9fec}</th>
                        <th>${autoMsg_d9679e1e0a}</th>
                        <th>${autoMsg_ca540a1534}</th>
                        <th>${autoMsg_6e1ca2094d}</th>
                        <th>${autoMsg_692119d092}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="h" items="${policyHistories}">
                        <tr>
                            <td><c:out value="${h.versionNo}"/></td>
                            <td><span class="adm-badge"><c:out value="${h.changeType}"/></span></td>
                            <td><c:out value="${h.actorUserIdx}" default="-"/></td>
                            <td><fmt:formatDate value="${h.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <details>
                                    <summary>${autoMsg_a0e9b9f905}</summary>
                                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-top:8px;">
                                        <div>
                                            <div class="adm-muted">${autoMsg_94f7854241}</div>
                                            <pre style="white-space:pre-wrap;max-height:220px;overflow:auto;"><c:out value="${h.beforeConfigJson}"/></pre>
                                        </div>
                                        <div>
                                            <div class="adm-muted">${autoMsg_ad69c9ef1a}</div>
                                            <pre style="white-space:pre-wrap;max-height:220px;overflow:auto;"><c:out value="${h.afterConfigJson}"/></pre>
                                        </div>
                                    </div>
                                </details>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty policyHistories}">
                        <tr><td colspan="5" class="adm-empty">${autoMsg_4983b87e4c}</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
