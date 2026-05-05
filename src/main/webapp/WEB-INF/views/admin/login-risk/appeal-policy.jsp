<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="activeMenu" value="securityAppealPolicy"/>
<spring:message var="pageTitle" code="security.admin.appealPolicy.title"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1><spring:message code="security.admin.appealPolicy.title"/></h1>
            <p class="adm-page-desc"><spring:message code="security.admin.appealPolicy.desc"/></p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/appeals"><spring:message code="security.admin.nav.appeals"/></a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/policies"><spring:message code="security.admin.nav.policies"/></a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/appeal-policy" class="adm-card">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title"><spring:message code="security.admin.appealPolicy.cardTitle"/></div>
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

            <h3 style="margin:4px 0 10px;"><spring:message code="security.admin.appealPolicy.section.channel"/></h3>
            <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr)); gap:12px;">
                <label class="adm-check" style="align-self:end;">
                    <input type="checkbox" name="allowMultipleOpenAppeals" ${policy.allowMultipleOpenAppeals ? 'checked' : ''}>
                    <spring:message code="security.admin.appealPolicy.allowMultipleOpenAppeals"/>
                </label>
                <label><spring:message code="security.admin.appealPolicy.maxOpenAppealsPerCase"/>
                    <input class="adm-input" type="number" min="1" name="maxOpenAppealsPerCase" value="${policy.maxOpenAppealsPerCase}">
                </label>
                <label class="adm-check" style="align-self:end;">
                    <input type="checkbox" name="closedBlocksNewAppeals" ${policy.closedBlocksNewAppeals ? 'checked' : ''}>
                    <spring:message code="security.admin.appealPolicy.closedBlocksNewAppeals"/>
                </label>
            </div>

            <h3 style="margin:22px 0 10px;"><spring:message code="security.admin.appealPolicy.section.cooldown"/></h3>
            <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr)); gap:12px;">
                <label><spring:message code="security.admin.appealPolicy.rejectedCooldownMinutes"/>
                    <input class="adm-input" type="number" min="0" name="rejectedCooldownMinutes" value="${policy.rejectedCooldownMinutes}">
                </label>
                <label><spring:message code="security.admin.appealPolicy.maxRejectedCount"/>
                    <input class="adm-input" type="number" min="1" name="maxRejectedCount" value="${policy.maxRejectedCount}">
                </label>
                <label><spring:message code="security.admin.appealPolicy.ipDailyAppealLimit"/>
                    <input class="adm-input" type="number" min="1" name="ipDailyAppealLimit" value="${policy.ipDailyAppealLimit}">
                </label>
            </div>

            <h3 style="margin:22px 0 10px;"><spring:message code="security.admin.appealPolicy.section.email"/></h3>
            <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr)); gap:12px;">
                <label><spring:message code="security.admin.appealPolicy.verificationWindowMinutes"/>
                    <input class="adm-input" type="number" min="1" name="verificationWindowMinutes" value="${policy.verificationWindowMinutes}">
                </label>
                <label><spring:message code="security.admin.appealPolicy.maxVerificationEmails"/>
                    <input class="adm-input" type="number" min="1" name="maxVerificationEmails" value="${policy.maxVerificationEmails}">
                </label>
                <label><spring:message code="security.admin.appealPolicy.verificationTokenTtlMinutes"/>
                    <input class="adm-input" type="number" min="1" name="verificationTokenTtlMinutes" value="${policy.verificationTokenTtlMinutes}">
                </label>
                <label><spring:message code="security.admin.appealPolicy.protectedAppealTokenTtlDays"/>
                    <input class="adm-input" type="number" min="1" name="protectedAppealTokenTtlDays" value="${policy.protectedAppealTokenTtlDays}">
                </label>
                <label><spring:message code="security.admin.appealPolicy.allowedEmailDomains"/>
                    <input class="adm-input" type="text" name="allowedEmailDomains" value="${fn:escapeXml(policy.allowedEmailDomains)}" placeholder="example.com,*.example.org">
                </label>
                <label><spring:message code="security.admin.appealPolicy.blockedEmailDomains"/>
                    <input class="adm-input" type="text" name="blockedEmailDomains" value="${fn:escapeXml(policy.blockedEmailDomains)}" placeholder="spam.example.com">
                </label>
            </div>

            <h3 style="margin:22px 0 10px;"><spring:message code="security.admin.appealPolicy.section.result"/></h3>
            <div class="adm-form-grid" style="grid-template-columns:repeat(3,minmax(0,1fr)); gap:12px;">
                <label><spring:message code="security.admin.appealPolicy.resultLookupWindowMinutes"/>
                    <input class="adm-input" type="number" min="1" name="resultLookupWindowMinutes" value="${policy.resultLookupWindowMinutes}">
                </label>
                <label><spring:message code="security.admin.appealPolicy.maxResultLookupFailures"/>
                    <input class="adm-input" type="number" min="1" name="maxResultLookupFailures" value="${policy.maxResultLookupFailures}">
                </label>
                <label><spring:message code="security.admin.appealPolicy.resultLookupRetentionDays"/>
                    <input class="adm-input" type="number" min="0" name="resultLookupRetentionDays" value="${policy.resultLookupRetentionDays}">
                </label>
            </div>

            <h3 style="margin:22px 0 10px;"><spring:message code="security.admin.appealPolicy.section.captcha"/></h3>
            <div class="adm-form-grid" style="grid-template-columns:repeat(2,minmax(0,1fr)); gap:12px;">
                <label class="adm-check" style="align-self:end;">
                    <input type="checkbox" name="captchaEnabled" ${policy.captchaEnabled ? 'checked' : ''}>
                    <spring:message code="security.admin.appealPolicy.captchaEnabled"/>
                </label>
                <label><spring:message code="security.admin.appealPolicy.captchaProviderCode"/>
                    <input class="adm-input" type="text" name="captchaProviderCode" value="${fn:escapeXml(policy.captchaProviderCode)}" placeholder="MOCK_TURNSTILE">
                </label>
            </div>
            <p class="adm-muted" style="margin-top:8px;"><spring:message code="security.admin.appealPolicy.captchaNote"/></p>

            <label style="display:block;margin-top:16px;"><spring:message code="security.admin.common.description"/>
                <textarea class="adm-input" name="description" rows="3"><c:out value="${policy.description}"/></textarea>
            </label>

            <div class="adm-actions" style="margin-top:16px;">
                <button type="submit" class="adm-btn primary"><spring:message code="security.admin.common.save"/></button>
            </div>
        </div>
    </form>

    <div class="adm-card" style="margin-top:16px;">
        <div class="adm-card-header">
            <div>
                <div class="adm-card-title"><spring:message code="security.admin.appealPolicy.history.title"/></div>
                <div class="adm-muted"><spring:message code="security.admin.appealPolicy.history.desc"/></div>
            </div>
        </div>
        <div class="adm-card-body">
            <div class="adm-table-wrap">
                <table class="adm-table">
                    <thead>
                    <tr>
                        <th><spring:message code="security.admin.appealPolicy.history.version"/></th>
                        <th><spring:message code="security.admin.appealPolicy.history.changeType"/></th>
                        <th><spring:message code="security.admin.appealPolicy.history.actor"/></th>
                        <th><spring:message code="security.admin.appealPolicy.history.changedAt"/></th>
                        <th><spring:message code="security.admin.appealPolicy.history.snapshot"/></th>
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
                                    <summary><spring:message code="security.admin.appealPolicy.history.showSnapshot"/></summary>
                                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-top:8px;">
                                        <div>
                                            <div class="adm-muted"><spring:message code="security.admin.appealPolicy.history.before"/></div>
                                            <pre style="white-space:pre-wrap;max-height:220px;overflow:auto;"><c:out value="${h.beforeConfigJson}"/></pre>
                                        </div>
                                        <div>
                                            <div class="adm-muted"><spring:message code="security.admin.appealPolicy.history.after"/></div>
                                            <pre style="white-space:pre-wrap;max-height:220px;overflow:auto;"><c:out value="${h.afterConfigJson}"/></pre>
                                        </div>
                                    </div>
                                </details>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty policyHistories}">
                        <tr><td colspan="5" class="adm-empty"><spring:message code="security.admin.appealPolicy.history.empty"/></td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
