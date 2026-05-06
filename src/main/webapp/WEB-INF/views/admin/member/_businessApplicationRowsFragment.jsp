<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message var="adminTranslationLabelBusinessAppDescriptionMsg" code="admin.translation.label.businessAppDescription"/>
<spring:message var="adminTranslationLabelBusinessAppRejectReasonMsg" code="admin.translation.label.businessAppRejectReason"/>
<spring:message var="adminBusinessConfirmApproveMsg" code="admin.business.confirmApprove" javaScriptEscape="true"/>
<spring:message var="adminBusinessRejectReasonPlaceholderMsg" code="admin.business.rejectReasonPlaceholder"/>
<c:forEach var="app" items="${applicationList}" varStatus="st">
    <fmt:formatDate var="appCreatedAtDisplay" value="${app.createdAtDate}" type="both" dateStyle="short" timeStyle="short"/>
    <fmt:formatDate var="appReviewedAtDisplay" value="${app.reviewedAtDate}" type="both" dateStyle="short" timeStyle="short"/>
    <tr class="js-business-row"
        data-application-idx="${app.applicationIdx}"
        data-user-idx="${app.userIdx}"
        data-nickname="${fn:escapeXml(app.nickname)}"
        data-user-id="${fn:escapeXml(app.userId)}"
        data-user-email="${fn:escapeXml(app.userEmail)}"
        data-current-role="${fn:escapeXml(app.currentUserRole)}"
        data-applicant="${fn:escapeXml(app.nickname)} ${fn:escapeXml(app.userId)} ${fn:escapeXml(app.userEmail)}"
        data-requested-role="${fn:escapeXml(app.requestedRole)}"
        data-company-name="${fn:escapeXml(app.companyName)}"
        data-business-number="${fn:escapeXml(app.businessNumber)}"
        data-manager-name="${fn:escapeXml(app.managerName)}"
        data-manager-phone="${fn:escapeXml(app.managerPhone)}"
        data-description="${fn:escapeXml(app.description)}"
        data-company="${fn:escapeXml(app.companyName)} ${fn:escapeXml(app.businessNumber)}"
        data-status="${fn:escapeXml(app.applicationStatus)}"
        data-reviewer="${fn:escapeXml(app.reviewerNickname)}"
        data-reject-reason="${fn:escapeXml(app.rejectReason)}"
        data-created-at="${app.createdAt}"
        data-created-at-display="${appCreatedAtDisplay}"
        data-reviewed-at="${app.reviewedAt}"
        data-reviewed-at-display="${appReviewedAtDisplay}"
        data-original-index="${st.index}">
        <td style="width:40px;text-align:center;">
            <input type="checkbox" class="adm-check js-business-row-check" value="${app.applicationIdx}" onchange="updateBusinessBulkBar()">
        </td>
        <td>
            <button type="button"
                    class="adm-cell-link js-open-member-context"
                    data-user-idx="${app.userIdx}"
                    data-default-tab="actions">
                <span class="mem-name">${fn:escapeXml(app.nickname)}</span>
                <span class="mem-uid">
                    <c:choose>
                        <c:when test="${not empty app.userId}">@${fn:escapeXml(app.userId)}</c:when>
                        <c:otherwise><spring:message code="admin.business.socialOnly"/></c:otherwise>
                    </c:choose>
                </span>
                <span class="adm-cell-link-note"><spring:message code="admin.business.currentRole"/></span>
            </button>
        </td>
        <td>
            <button type="button"
                    class="adm-cell-link js-open-business-detail"
                    data-default-focus="role">
                <span class="role-badge ${app.requestedRole}">
                    <c:choose>
                        <c:when test="${app.requestedRole eq 'BUSINESS'}"><spring:message code="admin.business.role.business"/></c:when>
                        <c:when test="${app.requestedRole eq 'PARTNER'}"><spring:message code="admin.business.role.partner"/></c:when>
                        <c:otherwise>${fn:escapeXml(app.requestedRole)}</c:otherwise>
                    </c:choose>
                </span>
                <span class="adm-cell-link-note"><spring:message code="admin.common.viewDetail"/></span>
            </button>
        </td>
        <td>
            <button type="button"
                    class="adm-cell-link js-open-business-detail"
                    data-default-focus="company">
                <span style="font-weight:700;color:#e2e8f0;">${fn:escapeXml(app.companyName)}</span>
                <span class="adm-cell-link-note" style="margin-top:3px;">
                    <spring:message code="admin.business.businessNumber"/>
                    <c:choose>
                        <c:when test="${not empty app.businessNumber}">${fn:escapeXml(app.businessNumber)}</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </span>
                <span class="adm-cell-link-note">
                    <spring:message code="admin.business.managerInfo" arguments="${fn:escapeXml(app.managerName)},${fn:escapeXml(app.managerPhone)}"/>
                </span>
                <span class="adm-cell-link-note"><spring:message code="admin.common.viewDetail"/></span>
            </button>
            <c:if test="${not empty app.description}">
                <div style="font-size:12px;color:#cbd5e1;margin-top:6px;max-width:420px;white-space:pre-wrap;">${fn:escapeXml(app.description)}</div>
                <div class="adm-tr-inline js-admin-translation-widget"
                     data-label="${adminTranslationLabelBusinessAppDescriptionMsg}"
                     data-source-type="BUSINESS_APPLICATION"
                     data-source-idx="${app.applicationIdx}"
                     data-field-name="description"
                     data-default-source-lang="ko"
                     data-source-text="${fn:escapeXml(app.description)}"></div>
            </c:if>
        </td>
        <td>
            <button type="button"
                    class="adm-cell-link js-open-business-detail"
                    data-default-focus="status"
                    data-application-idx="${app.applicationIdx}">
                <span class="status-badge ${app.applicationStatus}">
                    <c:choose>
                        <c:when test="${app.applicationStatus eq 'PENDING'}"><spring:message code="admin.business.status.pending"/></c:when>
                        <c:when test="${app.applicationStatus eq 'APPROVED'}"><spring:message code="admin.business.status.approved"/></c:when>
                        <c:when test="${app.applicationStatus eq 'REJECTED'}"><spring:message code="admin.business.status.rejected"/></c:when>
                        <c:otherwise>${fn:escapeXml(app.applicationStatus)}</c:otherwise>
                    </c:choose>
                </span>
                <c:if test="${not empty app.rejectReason}">
                    <span class="adm-cell-link-note" style="color:#fca5a5;">${fn:escapeXml(app.rejectReason)}</span>
                </c:if>
                <c:if test="${not empty app.reviewerNickname}">
                    <span class="adm-cell-link-note"><spring:message code="admin.business.reviewer"/></span>
                </c:if>
                <span class="adm-cell-link-note"><spring:message code="admin.common.viewDetail"/></span>
            </button>
            <c:if test="${not empty app.rejectReason}">
                <div class="adm-tr-inline js-admin-translation-widget"
                     data-label="${adminTranslationLabelBusinessAppRejectReasonMsg}"
                     data-source-type="BUSINESS_APPLICATION"
                     data-source-idx="${app.applicationIdx}"
                     data-field-name="reject_reason"
                     data-default-source-lang="ko"
                     data-source-text="${fn:escapeXml(app.rejectReason)}"></div>
            </c:if>
        </td>
        <td>
            <button type="button"
                    class="adm-cell-link js-open-business-detail"
                    data-default-focus="date"
                    data-application-idx="${app.applicationIdx}">
                <span>${appCreatedAtDisplay}</span>
                <span class="adm-cell-link-note"><spring:message code="admin.common.viewDetail"/></span>
            </button>
        </td>
        <td>
            <c:choose>
                <c:when test="${app.applicationStatus eq 'PENDING'}">
                    <div class="business-review-actions js-business-review-actions" id="business-review-actions-${app.applicationIdx}">
                        <form method="post" class="js-business-review-form" action="${pageContext.request.contextPath}/admin/business-applications/${app.applicationIdx}/approve">
                            <button type="submit" class="adm-row-btn detail"
                                    onclick="return confirm('${adminBusinessConfirmApproveMsg}')"><spring:message code="admin.business.status.approved"/></button>
                        </form>
                        <form method="post" class="js-business-review-form" action="${pageContext.request.contextPath}/admin/business-applications/${app.applicationIdx}/reject">
                            <input class="adm-input" name="rejectReason" maxlength="500" placeholder="${adminBusinessRejectReasonPlaceholderMsg}" required>
                            <button type="submit" class="adm-row-btn danger"><spring:message code="admin.business.status.rejected"/></button>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <span style="color:#64748b;font-size:12px;"><spring:message code="admin.business.reviewDone"/></span>
                </c:otherwise>
            </c:choose>
        </td>
    </tr>
</c:forEach>

<c:if test="${empty applicationList}">
    <tr class="adm-local-empty">
        <td colspan="7" style="text-align:center;padding:40px;color:#64748b;">
            <spring:message code="admin.business.noResults"/>
        </td>
    </tr>
</c:if>
