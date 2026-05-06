<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<spring:message var="autoMsg_597c740713" code="security.admin.wafSync.title"/>
<spring:message var="autoMsg_bdc22a65b0" code="security.admin.wafSync.desc"/>
<spring:message var="autoMsg_f5ddd5ebfd" code="security.admin.nav.providerConfigs"/>
<spring:message var="autoMsg_c6d752a0eb" code="security.admin.nav.securityAssessments"/>
<spring:message var="autoMsg_5c1e4128f7" code="admin.layout.menu.policyHistory"/>
<spring:message var="autoMsg_96a83934e4" code="security.admin.common.status"/>
<spring:message var="autoMsg_7df69f7633" code="security.admin.common.all"/>
<spring:message var="autoMsg_7cd4e4f03e" code="security.admin.common.targetType"/>
<spring:message var="autoMsg_2e0584a850" code="security.admin.common.search"/>
<spring:message var="autoMsg_99f30f2f99" code="security.admin.wafSync.source"/>
<spring:message var="autoMsg_6db345329a" code="security.admin.wafSync.action"/>
<spring:message var="autoMsg_c22a83fba1" code="security.admin.common.target"/>
<spring:message var="autoMsg_f80a90cd98" code="security.admin.common.description"/>
<spring:message var="autoMsg_9766a62e94" code="security.admin.common.createdAt"/>
<spring:message var="autoMsg_7cf50e6404" code="security.admin.wafSync.lastResultAt"/>
<spring:message var="autoMsg_0d8f390ec3" code="security.admin.common.action"/>
<spring:message var="autoMsg_2eb24da3bd" code="security.admin.wafSync.updatedAt"/>
<spring:message var="autoMsg_7b18ad7aae" code="security.admin.wafSync.syncedAt"/>
<spring:message var="autoMsg_c157dfa7b1" code="security.admin.wafSync.retry"/>
<spring:message var="autoMsg_f3a9937b15" code="security.admin.wafSync.detailTitle"/>
<spring:message var="autoMsg_d793837292" code="security.admin.common.close"/>
<spring:message var="autoMsg_52624fa1f3" code="security.admin.empty.wafSync"/>
<c:set var="activeMenu" value="securityWafSync"/>
<spring:message var="pageTitle" code="security.admin.wafSync.title"/>
<spring:message var="keywordPlaceholder" code="security.admin.placeholder.wafSync"/>
<spring:message var="targetTypePlaceholder" code="security.admin.placeholder.wafTargetType"/>
<%@ include file="../layout.jsp" %>
<style>
    .sync-detail { white-space: pre-wrap; max-width: 520px; line-height: 1.55; }
    .sync-meta { display:block; color:#64748b; font-size:12px; margin-top:6px; }
    .waf-detail-modal[hidden] { display:none; }
    .waf-detail-modal { position:fixed; inset:0; z-index:2000; background:rgba(15,23,42,.55); display:flex; align-items:center; justify-content:center; padding:24px; }
    .waf-detail-card { width:min(920px,96vw); max-height:88vh; overflow:auto; background:#fff; border-radius:20px; box-shadow:0 24px 70px rgba(15,23,42,.28); border:1px solid #e2e8f0; }
    .waf-detail-head { display:flex; justify-content:space-between; gap:12px; align-items:flex-start; padding:20px 22px; border-bottom:1px solid #e2e8f0; }
    .waf-detail-body { padding:20px 22px; }
    .waf-detail-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:12px; }
    .waf-detail-item { border:1px solid #e2e8f0; border-radius:14px; padding:12px; background:#f8fafc; }
    .waf-detail-label { font-size:12px; color:#64748b; font-weight:700; margin-bottom:6px; }
    .waf-detail-value { white-space:pre-wrap; word-break:break-word; color:#0f172a; }
    .waf-detail-close { border:0; background:#e2e8f0; border-radius:10px; padding:8px 12px; cursor:pointer; font-weight:800; }
    @media (max-width:720px) { .waf-detail-grid { grid-template-columns:1fr; } }
</style>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${autoMsg_597c740713}</h1>
            <p class="adm-page-desc">${autoMsg_bdc22a65b0}</p>
        </div>
        <div class="adm-actions">
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/provider-configs">${autoMsg_f5ddd5ebfd}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/login-risk/security-assessments">${autoMsg_c6d752a0eb}</a>
            <a class="adm-btn" href="${pageContext.request.contextPath}/admin/policy-history?sourceType=PROVIDER_CONFIG">${autoMsg_5c1e4128f7}</a>
        </div>
    </div>

    <c:if test="${not empty message}">
        <div class="adm-alert success"><c:out value="${message}"/></div>
    </c:if>

    <form method="get" class="adm-card" style="margin-bottom:16px;">
        <div class="adm-form-grid" style="grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;">
            <label>${autoMsg_96a83934e4}
                <select class="adm-input" name="status">
                    <option value="">${autoMsg_7df69f7633}</option>
                    <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                    <option value="EXTERNAL_PROVIDER_PENDING" ${status == 'EXTERNAL_PROVIDER_PENDING' ? 'selected' : ''}>EXTERNAL_PROVIDER_PENDING</option>
                    <option value="SYNCED" ${status == 'SYNCED' ? 'selected' : ''}>SYNCED</option>
                    <option value="FAILED" ${status == 'FAILED' ? 'selected' : ''}>FAILED</option>
                </select>
            </label>
            <label>${autoMsg_7cd4e4f03e}
                <input class="adm-input" type="text" name="targetType" value="${fn:escapeXml(targetType)}" placeholder="${targetTypePlaceholder}">
            </label>
            <label>${autoMsg_2e0584a850}
                <input class="adm-input" type="text" name="keyword" value="${fn:escapeXml(keyword)}" placeholder="${keywordPlaceholder}">
            </label>
            <div style="align-self:end;">
                <button class="adm-btn primary" type="submit">${autoMsg_2e0584a850}</button>
            </div>
        </div>
    </form>

    <div class="adm-table-wrap">
        <table class="adm-table">
            <thead>
            <tr>
                <th>${autoMsg_96a83934e4}</th>
                <th>${autoMsg_99f30f2f99}</th>
                <th>${autoMsg_6db345329a}</th>
                <th>${autoMsg_c22a83fba1}</th>
                <th>${autoMsg_f80a90cd98}</th>
                <th>${autoMsg_9766a62e94}</th>
                <th>${autoMsg_7cf50e6404}</th>
                <th>${autoMsg_0d8f390ec3}</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="i" items="${items}">
                <tr>
                    <td><span class="adm-badge"><c:out value="${i.status}"/></span></td>
                    <td><c:out value="${i.sourceType}"/> #<c:out value="${i.sourceId}"/></td>
                    <td><c:out value="${i.syncAction}"/></td>
                    <td><c:out value="${i.targetType}"/>: <c:out value="${i.targetValue}"/></td>
                    <td><div class="sync-detail"><c:out value="${i.detailMessage}"/></div></td>
                    <td><fmt:formatDate value="${i.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <span class="sync-meta">${autoMsg_2eb24da3bd}: <fmt:formatDate value="${i.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                        <span class="sync-meta">${autoMsg_7b18ad7aae}: <fmt:formatDate value="${i.syncedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                    </td>
                    <td>
                        <button class="adm-btn js-waf-modal-open" type="button" data-modal-id="waf-detail-${i.syncIdx}">
                            <spring:message code="security.admin.common.detail"/>
                        </button>
                        <form method="post" action="${pageContext.request.contextPath}/admin/login-risk/waf-sync/${i.syncIdx}/retry" style="display:inline;">
                            <button class="adm-btn" type="submit">${autoMsg_c157dfa7b1}</button>
                        </form>
                    </td>
                </tr>
                <tr style="display:none;"><td colspan="8">
                    <div class="waf-detail-modal" id="waf-detail-${i.syncIdx}" hidden>
                        <div class="waf-detail-card" role="dialog" aria-modal="true" aria-labelledby="waf-detail-title-${i.syncIdx}">
                            <div class="waf-detail-head">
                                <div>
                                    <h2 id="waf-detail-title-${i.syncIdx}" style="margin:0;">${autoMsg_f3a9937b15}</h2>
                                    <div class="adm-muted">#<c:out value="${i.syncIdx}"/> · <c:out value="${i.status}"/></div>
                                </div>
                                <button class="waf-detail-close js-waf-modal-close" type="button">${autoMsg_d793837292}</button>
                            </div>
                            <div class="waf-detail-body">
                                <div class="waf-detail-grid">
                                    <div class="waf-detail-item">
                                        <div class="waf-detail-label">${autoMsg_96a83934e4}</div>
                                        <div class="waf-detail-value"><c:out value="${i.status}" default="-"/></div>
                                    </div>
                                    <div class="waf-detail-item">
                                        <div class="waf-detail-label">${autoMsg_99f30f2f99}</div>
                                        <div class="waf-detail-value"><c:out value="${i.sourceType}" default="-"/> #<c:out value="${i.sourceId}" default="-"/></div>
                                    </div>
                                    <div class="waf-detail-item">
                                        <div class="waf-detail-label">${autoMsg_6db345329a}</div>
                                        <div class="waf-detail-value"><c:out value="${i.syncAction}" default="-"/></div>
                                    </div>
                                    <div class="waf-detail-item">
                                        <div class="waf-detail-label">${autoMsg_c22a83fba1}</div>
                                        <div class="waf-detail-value"><c:out value="${i.targetType}" default="-"/>: <c:out value="${i.targetValue}" default="-"/></div>
                                    </div>
                                    <div class="waf-detail-item">
                                        <div class="waf-detail-label">${autoMsg_9766a62e94}</div>
                                        <div class="waf-detail-value"><fmt:formatDate value="${i.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                                    </div>
                                    <div class="waf-detail-item">
                                        <div class="waf-detail-label">${autoMsg_7cf50e6404}</div>
                                        <div class="waf-detail-value">
                                            ${autoMsg_2eb24da3bd}: <fmt:formatDate value="${i.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/><br>
                                            <spring:message code="security.admin.wafSync.syncedAt"/>: <fmt:formatDate value="${i.syncedAtDate}" pattern="yyyy-MM-dd HH:mm"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="waf-detail-item" style="margin-top:12px;">
                                    <div class="waf-detail-label">${autoMsg_f80a90cd98}</div>
                                    <div class="waf-detail-value"><c:out value="${i.detailMessage}" default="-"/></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </td></tr>
            </c:forEach>
            <c:if test="${empty items}">
                <tr><td colspan="8" class="adm-empty">${autoMsg_52624fa1f3}</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<script>
(function () {
    const closeModal = function (modal) { if (modal) modal.hidden = true; };
    const openModal = function (modal) { if (modal) modal.hidden = false; };
    document.querySelectorAll('.js-waf-modal-open').forEach(function (button) {
        button.addEventListener('click', function () {
            openModal(document.getElementById(button.dataset.modalId));
        });
    });
    document.querySelectorAll('.js-waf-modal-close').forEach(function (button) {
        button.addEventListener('click', function () {
            closeModal(button.closest('.waf-detail-modal'));
        });
    });
    document.querySelectorAll('.waf-detail-modal').forEach(function (modal) {
        modal.addEventListener('click', function (event) {
            if (event.target === modal) closeModal(modal);
        });
    });
    document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') {
            document.querySelectorAll('.waf-detail-modal:not([hidden])').forEach(closeModal);
        }
    });
})();
</script>
