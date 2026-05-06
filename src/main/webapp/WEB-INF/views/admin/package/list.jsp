<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_81795f2227" code="package.admin.title"/>
<spring:message var="autoMsg_7a64a86225" code="package.admin.desc"/>
<spring:message var="autoMsg_5b8574b1c8" code="package.admin.filterStatus"/>
<spring:message var="autoMsg_1e8be09c49" code="package.admin.filterAll"/>
<spring:message var="autoMsg_38f1e5f2d8" code="package.status.pending"/>
<spring:message var="autoMsg_0c27c049e7" code="package.status.approved"/>
<spring:message var="autoMsg_4bb06cfe16" code="package.status.rejected"/>
<spring:message var="autoMsg_2e797241a3" code="package.status.draft"/>
<spring:message var="autoMsg_c88e991e6c" code="package.status.blocked"/>
<spring:message var="autoMsg_4e95897a13" code="package.admin.search"/>
<spring:message var="autoMsg_47534ba876" code="package.admin.reset"/>
<spring:message var="autoMsg_f86dadab39" code="package.revision.adminTitle"/>
<spring:message var="autoMsg_fcecfdf019" code="package.revision.adminDesc"/>
<spring:message var="autoMsg_983127c227" code="package.revision.beforeAfter"/>
<spring:message var="autoMsg_a09196db66" code="package.revision.sellerSpot"/>
<spring:message var="autoMsg_ce3e9b45f1" code="package.revision.pricePeriod"/>
<spring:message var="autoMsg_a2e5490060" code="package.revision.requestedAt"/>
<spring:message var="autoMsg_eea5590277" code="package.revision.review"/>
<spring:message var="autoMsg_4213d6d07d" code="package.revision.current"/>
<spring:message var="autoMsg_6f12843ca6" code="package.revision.requested"/>
<spring:message var="autoMsg_455e7753dc" code="package.common.always"/>
<spring:message var="autoMsg_9ef749634f" code="package.common.maxPeople"/>
<spring:message var="autoMsg_9113763d55" code="package.admin.thPackage"/>
<spring:message var="autoMsg_800a89a8ee" code="package.admin.thSeller"/>
<spring:message var="autoMsg_ace3212e4c" code="package.admin.thSpot"/>
<spring:message var="autoMsg_248de702ee" code="package.admin.thPriceSchedule"/>
<spring:message var="autoMsg_8caf765f67" code="package.admin.thStatus"/>
<spring:message var="autoMsg_837f8d409f" code="package.admin.thReview"/>
<spring:message var="autoMsg_f2f287a1c9" code="package.admin.noImage"/>
<spring:message var="autoMsg_c73e0310c9" code="package.admin.registeredAt"/>
<spring:message var="autoMsg_8c5544b485" code="package.status.expired"/>
<spring:message var="autoMsg_38fbdf9b75" code="admin.packages.confirmApprove" javaScriptEscape="true"/>
<spring:message var="autoMsg_eefd577c93" code="package.admin.approve"/>
<spring:message var="autoMsg_655c3be121" code="admin.packages.rejectReasonPlaceholder"/>
<spring:message var="autoMsg_5637ef73ea" code="package.admin.notPending"/>
<c:set var="activeMenu" value="packages"/>
<spring:message code="package.admin.title" var="adminPackagesPageTitle"/>
<c:set var="pageTitle"  value="${adminPackagesPageTitle}"/>
<spring:message code="package.revision.rejectReason" var="revisionRejectReasonPlaceholder"/>
<spring:message code="package.admin.approveConfirm" var="packageApproveConfirm"/>
<spring:message code="package.admin.rejectPlaceholder" var="packageRejectPlaceholder"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-page-head">
        <div>
            <h1>${autoMsg_81795f2227}</h1>
            <p>${autoMsg_7a64a86225}</p>
        </div>
    </div>

    <c:if test="${not empty packageReviewMessage}">
        <div class="adm-alert adm-alert-success">${fn:escapeXml(packageReviewMessage)}</div>
    </c:if>
    <c:if test="${not empty packageReviewError}">
        <div class="adm-alert adm-alert-danger">${fn:escapeXml(packageReviewError)}</div>
    </c:if>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/packages">
                <div class="adm-filter-bar">
                    <div>
                        <div class="adm-filter-label">${autoMsg_5b8574b1c8}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${status eq 'ALL' ? 'selected' : ''}>${autoMsg_1e8be09c49}</option>
                            <option value="PENDING" ${status eq 'PENDING' ? 'selected' : ''}>${autoMsg_38f1e5f2d8}</option>
                            <option value="APPROVED" ${status eq 'APPROVED' ? 'selected' : ''}>${autoMsg_0c27c049e7}</option>
                            <option value="REJECTED" ${status eq 'REJECTED' ? 'selected' : ''}>${autoMsg_4bb06cfe16}</option>
                            <option value="DRAFT" ${status eq 'DRAFT' ? 'selected' : ''}>${autoMsg_2e797241a3}</option>
                            <option value="BLOCKED" ${status eq 'BLOCKED' ? 'selected' : ''}>${autoMsg_c88e991e6c}</option>
                        </select>
                    </div>
                    <div style="display:flex;gap:6px;align-items:flex-end;">
                        <button type="submit" class="adm-btn adm-btn-primary">${autoMsg_4e95897a13}</button>
                        <a href="${pageContext.request.contextPath}/admin/packages"
                           class="adm-btn adm-btn-ghost">${autoMsg_47534ba876}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <div style="display:flex;justify-content:space-between;gap:14px;align-items:flex-start;margin-bottom:14px;">
                <div>
                    <h2 style="margin:0;color:#e2e8f0;font-size:18px;">${autoMsg_f86dadab39}</h2>
                    <p style="margin:6px 0 0;color:#94a3b8;font-size:13px;">${autoMsg_fcecfdf019}</p>
                </div>
                <span class="status-badge PENDING">${autoMsg_38f1e5f2d8}</span>
            </div>

            <c:choose>
                <c:when test="${empty revisionList}">
                    <div style="padding:24px;border:1px dashed rgba(148,163,184,.32);border-radius:14px;color:#64748b;text-align:center;">
                        <spring:message code="package.revision.empty"/>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="adm-table-wrap">
                        <table class="adm-table">
                            <thead>
                            <tr>
                                <th>${autoMsg_983127c227}</th>
                                <th>${autoMsg_a09196db66}</th>
                                <th>${autoMsg_ce3e9b45f1}</th>
                                <th>${autoMsg_a2e5490060}</th>
                                <th>${autoMsg_eea5590277}</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="revision" items="${revisionList}">
                                <tr>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link"
                                                onclick="focusPackageReviewAction('revision-${revision.packageRevisionIdx}')">
                                            <span style="font-size:12px;color:#94a3b8;">${autoMsg_4213d6d07d}</span>
                                            <span style="font-weight:800;color:#e2e8f0;">${fn:escapeXml(revision.currentPackageTitle)}</span>
                                            <span style="font-size:12px;color:#38bdf8;margin-top:6px;">${autoMsg_6f12843ca6}</span>
                                            <span style="font-weight:800;color:#e2e8f0;">${fn:escapeXml(revision.packageTitle)}</span>
                                            <c:if test="${not empty revision.packageSummary}">
                                                <span style="font-size:12px;color:#94a3b8;margin-top:4px;max-width:420px;">
                                                    ${fn:escapeXml(revision.packageSummary)}
                                                </span>
                                            </c:if>
                                        </button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link js-open-member-context"
                                                data-user-idx="${revision.sellerUserIdx}"
                                                data-default-tab="profile">
                                            <span class="mem-name">${fn:escapeXml(revision.sellerNickname)}</span>
                                            <span class="mem-uid">user_idx ${revision.sellerUserIdx}</span>
                                            <span style="font-size:12px;color:#94a3b8;margin-top:8px;">
                                                ${fn:escapeXml(revision.spotRegion)} · ${fn:escapeXml(revision.spotName)}
                                            </span>
                                        </button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link"
                                                onclick="focusPackageReviewAction('revision-${revision.packageRevisionIdx}')">
                                            <span style="font-weight:800;color:#e2e8f0;">
                                                <fmt:formatNumber value="${revision.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(revision.currencyCode)}
                                            </span>
                                            <span style="font-size:12px;color:#94a3b8;margin-top:4px;">
                                                <c:choose>
                                                    <c:when test="${not empty revision.startDate or not empty revision.endDate}">
                                                        ${revision.startDate} ~ ${revision.endDate}
                                                    </c:when>
                                                    <c:otherwise>${autoMsg_455e7753dc}</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <span style="font-size:12px;color:#94a3b8;">
                                                <spring:message code="package.common.minPeople" arguments="${revision.minPeople}"/>
                                                <c:if test="${not empty revision.maxPeople}">
                                                    / ${autoMsg_9ef749634f}
                                                </c:if>
                                            </span>
                                        </button>
                                    </td>
                                    <td>
                                        <button type="button"
                                                class="adm-cell-link adm-cell-link--inline"
                                                onclick="focusPackageReviewAction('revision-${revision.packageRevisionIdx}')">
                                            ${revision.requestedAt}
                                        </button>
                                    </td>
                                    <td>
                                        <div class="adm-row-actions" id="package-action-revision-${revision.packageRevisionIdx}">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/packages/revisions/${revision.packageRevisionIdx}/approve">
                                                <button type="submit" class="adm-row-btn detail">
                                                    <spring:message code="package.revision.approve"/>
                                                </button>
                                            </form>
                                            <div class="action-menu-wrap">
                                                <button type="button"
                                                        class="adm-row-btn detail adm-row-btn-more"
                                                        onclick="admToggleActionMenu(this)">⋯</button>
                                                <div class="action-menu action-menu-wide">
                                                    <form class="action-menu-form"
                                                          method="post"
                                                          action="${pageContext.request.contextPath}/admin/packages/revisions/${revision.packageRevisionIdx}/reject">
                                                        <label class="action-menu-head" for="revision-reject-${revision.packageRevisionIdx}">
                                                            <spring:message code="package.revision.reject"/>
                                                        </label>
                                                        <input id="revision-reject-${revision.packageRevisionIdx}"
                                                               class="adm-input"
                                                               name="rejectReason"
                                                               maxlength="500"
                                                               placeholder="${revisionRejectReasonPlaceholder}"
                                                               required>
                                                        <button type="submit" class="action-menu-item danger">
                                                            <spring:message code="package.revision.reject"/>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th>${autoMsg_9113763d55}</th>
                    <th>${autoMsg_800a89a8ee}</th>
                    <th>${autoMsg_ace3212e4c}</th>
                    <th>${autoMsg_248de702ee}</th>
                    <th>${autoMsg_8caf765f67}</th>
                    <th>${autoMsg_837f8d409f}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="pkg" items="${packageList}">
                    <tr>
                        <td>
                            <div style="display:flex;gap:12px;align-items:flex-start;min-width:280px;">
                                <div style="width:82px;height:58px;border-radius:10px;overflow:hidden;background:#1e293b;flex:0 0 auto;">
                                    <c:choose>
                                        <c:when test="${not empty pkg.mainImagePath}">
                                            <img src="${fn:escapeXml(pkg.mainImagePath)}"
                                                 alt="${fn:escapeXml(pkg.packageTitle)}"
                                                 style="width:100%;height:100%;object-fit:cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="height:100%;display:grid;place-items:center;color:#94a3b8;font-size:11px;font-weight:800;">${autoMsg_f2f287a1c9}</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div>
                                    <button type="button"
                                            class="adm-cell-link adm-cell-link--inline"
                                            onclick="focusPackageReviewAction('package-${pkg.packageIdx}')">
                                        <span style="font-weight:800;">${fn:escapeXml(pkg.packageTitle)}</span>
                                    </button>
                                    <c:if test="${not empty pkg.packageSummary}">
                                        <div style="font-size:12px;color:#94a3b8;margin-top:4px;max-width:420px;">
                                            ${fn:escapeXml(pkg.packageSummary)}
                                        </div>
                                    </c:if>
                                    <div style="font-size:11px;color:#64748b;margin-top:4px;">${autoMsg_c73e0310c9}</div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-open-member-context"
                                    data-user-idx="${pkg.sellerUserIdx}"
                                    data-default-tab="profile">
                                <span class="mem-name">${fn:escapeXml(pkg.sellerNickname)}</span>
                                <span class="mem-uid">user_idx ${pkg.sellerUserIdx}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link"
                                    onclick="focusPackageReviewAction('package-${pkg.packageIdx}')">
                                <span style="font-weight:700;color:#e2e8f0;">${fn:escapeXml(pkg.spotName)}</span>
                                <span style="font-size:12px;color:#94a3b8;">${fn:escapeXml(pkg.spotRegion)}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link"
                                    onclick="focusPackageReviewAction('package-${pkg.packageIdx}')">
                                <span style="font-weight:800;color:#e2e8f0;">
                                    <fmt:formatNumber value="${pkg.packagePrice}" pattern="#,##0"/> ${fn:escapeXml(pkg.currencyCode)}
                                </span>
                                <span style="font-size:12px;color:#94a3b8;margin-top:4px;">
                                    <c:choose>
                                        <c:when test="${not empty pkg.startDate or not empty pkg.endDate}">
                                            ${pkg.startDate} ~ ${pkg.endDate}
                                        </c:when>
                                        <c:otherwise>${autoMsg_455e7753dc}</c:otherwise>
                                    </c:choose>
                                </span>
                                <span style="font-size:12px;color:#94a3b8;">
                                    <spring:message code="package.common.minPeople" arguments="${pkg.minPeople}"/>
                                    <c:if test="${not empty pkg.maxPeople}"> / ${autoMsg_9ef749634f}</c:if>
                                </span>
                            </button>
                        </td>
                        <td>
                            <c:set var="displayStatusClass" value="${pkg.packageStatus}"/>
                            <c:if test="${pkg.packageStatus eq 'APPROVED' and pkg.expired}">
                                <c:set var="displayStatusClass" value="EXPIRED"/>
                            </c:if>
                            <button type="button"
                                    class="adm-cell-link adm-cell-link--inline"
                                    onclick="focusPackageReviewAction('package-${pkg.packageIdx}')">
                                <span class="status-badge ${displayStatusClass}">
                                    <c:choose>
                                        <c:when test="${displayStatusClass eq 'EXPIRED'}">${autoMsg_8c5544b485}</c:when>
                                        <c:when test="${displayStatusClass eq 'PENDING'}">${autoMsg_38f1e5f2d8}</c:when>
                                        <c:when test="${displayStatusClass eq 'APPROVED'}">${autoMsg_0c27c049e7}</c:when>
                                        <c:when test="${displayStatusClass eq 'REJECTED'}">${autoMsg_4bb06cfe16}</c:when>
                                        <c:when test="${displayStatusClass eq 'DRAFT'}">${autoMsg_2e797241a3}</c:when>
                                        <c:when test="${displayStatusClass eq 'BLOCKED'}">${autoMsg_c88e991e6c}</c:when>
                                        <c:otherwise>${fn:escapeXml(pkg.packageStatus)}</c:otherwise>
                                    </c:choose>
                                </span>
                            </button>
                            <c:if test="${pkg.packageStatus eq 'APPROVED' and pkg.expired}">
                                <div style="font-size:11px;color:#fbbf24;margin-top:6px;max-width:240px;">
                                    <spring:message code="package.manage.expiredHidden"/>
                                </div>
                            </c:if>
                            <c:if test="${not empty pkg.rejectReason}">
                                <div style="font-size:11px;color:#fca5a5;margin-top:6px;max-width:240px;">
                                    ${fn:escapeXml(pkg.rejectReason)}
                                </div>
                            </c:if>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${pkg.packageStatus eq 'PENDING'}">
                                    <div class="adm-row-actions" id="package-action-package-${pkg.packageIdx}">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/packages/${pkg.packageIdx}/approve">
                                                <button type="submit" class="adm-row-btn detail"
                                                    onclick="return confirm('${autoMsg_38fbdf9b75}');">${autoMsg_eefd577c93}</button>
                                            </form>
                                        <div class="action-menu-wrap">
                                            <button type="button"
                                                    class="adm-row-btn detail adm-row-btn-more"
                                                    onclick="admToggleActionMenu(this)">⋯</button>
                                            <div class="action-menu action-menu-wide">
                                                <form class="action-menu-form"
                                                      method="post"
                                                      action="${pageContext.request.contextPath}/admin/packages/${pkg.packageIdx}/reject">
                                                    <label class="action-menu-head" for="package-reject-${pkg.packageIdx}">
                                                        <spring:message code="package.admin.reject"/>
                                                    </label>
                                                    <input id="package-reject-${pkg.packageIdx}"
                                                           class="adm-input"
                                                           name="rejectReason"
                                                           maxlength="500"
                                                           placeholder="${autoMsg_655c3be121}"
                                                           required>
                                                    <button type="submit" class="action-menu-item danger">
                                                        <spring:message code="package.admin.reject"/>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:#64748b;font-size:12px;">${autoMsg_5637ef73ea}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty packageList}">
                    <tr>
                        <td colspan="6" style="text-align:center;padding:40px;color:#64748b;">
                            <spring:message code="package.admin.noResults"/>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
function focusPackageReviewAction(key) {
    var target = document.getElementById('package-action-' + key);
    if (!target) return;
    target.scrollIntoView({ behavior: 'smooth', block: 'center' });
    target.classList.remove('is-focus-flash');
    void target.offsetWidth;
    target.classList.add('is-focus-flash');
    setTimeout(function () {
        target.classList.remove('is-focus-flash');
    }, 1300);
}
</script>

<%@ include file="../layout-close.jsp" %>
