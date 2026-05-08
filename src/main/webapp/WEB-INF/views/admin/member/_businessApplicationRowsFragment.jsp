<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_translation_label_businessAppDescription" code="admin.translation.label.businessAppDescription"/>
<spring:message var="msg_admin_translation_label_businessAppRejectReason" code="admin.translation.label.businessAppRejectReason"/>
<spring:message var="msg_admin_business_confirmApprove_js" code="admin.business.confirmApprove" javaScriptEscape="true"/>
<spring:message var="msg_admin_business_rejectReasonPlaceholder" code="admin.business.rejectReasonPlaceholder"/>
<spring:message var="msg_admin_business_socialOnly" code="admin.business.socialOnly"/>
<spring:message var="msg_admin_business_currentRole" code="admin.business.currentRole"/>
<spring:message var="msg_admin_business_role_business" code="admin.business.role.business"/>
<spring:message var="msg_admin_business_role_partner" code="admin.business.role.partner"/>
<spring:message var="msg_admin_common_viewDetail" code="admin.common.viewDetail"/>
<spring:message var="msg_admin_business_businessNumber" code="admin.business.businessNumber"/>
<spring:message var="msg_admin_business_status_pending" code="admin.business.status.pending"/>
<spring:message var="msg_admin_business_status_approved" code="admin.business.status.approved"/>
<spring:message var="msg_admin_business_status_rejected" code="admin.business.status.rejected"/>
<spring:message var="msg_admin_business_reviewer" code="admin.business.reviewer"/>
<spring:message var="msg_admin_business_reviewDone" code="admin.business.reviewDone"/>
<spring:message var="msg_admin_business_noResults" code="admin.business.noResults"/>
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
        <td class="adm-business-check-cell">
            <input type="checkbox" class="adm-check js-business-row-check" value="${app.applicationIdx}" onchange="updateBusinessBulkBar()">
        </td>
        <td class="adm-business-action-cell" onclick="openBusinessCellAction(event, this, 'applicant')">
            <button type="button"
                    class="adm-cell-link js-open-member-context"
                    data-user-idx="${app.userIdx}"
                    data-default-tab="actions">
                <span class="mem-name">${fn:escapeXml(app.nickname)}</span>
                <span class="mem-uid">
                    <c:choose>
                        <c:when test="${not empty app.userId}">@${fn:escapeXml(app.userId)}</c:when>
                        <c:otherwise>${msg_admin_business_socialOnly}</c:otherwise>
                    </c:choose>
                </span>
                <span class="adm-cell-link-note">${msg_admin_business_currentRole}</span>
            </button>
        </td>
        <td class="adm-business-action-cell" onclick="openBusinessCellAction(event, this, 'role')">
            <button type="button"
                    class="adm-cell-link js-open-business-detail"
                    data-default-focus="role">
                <span class="role-badge ${app.requestedRole}">
                    <c:choose>
                        <c:when test="${app.requestedRole eq 'BUSINESS'}">${msg_admin_business_role_business}</c:when>
                        <c:when test="${app.requestedRole eq 'PARTNER'}">${msg_admin_business_role_partner}</c:when>
                        <c:otherwise>${fn:escapeXml(app.requestedRole)}</c:otherwise>
                    </c:choose>
                </span>
                <span class="adm-cell-link-note">${msg_admin_common_viewDetail}</span>
            </button>
        </td>
        <td class="adm-business-action-cell" onclick="openBusinessCellAction(event, this, 'company')">
            <button type="button"
                    class="adm-cell-link js-open-business-detail"
                    data-default-focus="company">
                <span class="adm-business-company-name">${fn:escapeXml(app.companyName)}</span>
                <span class="adm-cell-link-note adm-business-company-number">
                    ${msg_admin_business_businessNumber}
                    <c:choose>
                        <c:when test="${not empty app.businessNumber}">${fn:escapeXml(app.businessNumber)}</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </span>
                <span class="adm-cell-link-note">
                    <spring:message var="msg_admin_business_managerInfo_args_fn_escapeXml_app_managerName_fn_escapeXml_app_mana" code="admin.business.managerInfo" arguments="${fn:escapeXml(app.managerName)},${fn:escapeXml(app.managerPhone)}"/>${msg_admin_business_managerInfo_args_fn_escapeXml_app_managerName_fn_escapeXml_app_mana}
                </span>
                <span class="adm-cell-link-note">${msg_admin_common_viewDetail}</span>
            </button>
            <c:if test="${not empty app.description}">
                <div class="adm-business-description-cell">${fn:escapeXml(app.description)}</div>
                <div class="adm-tr-inline js-admin-translation-widget"
                     data-label="${msg_admin_translation_label_businessAppDescription}"
                     data-source-type="BUSINESS_APPLICATION"
                     data-source-idx="${app.applicationIdx}"
                     data-field-name="description"
                     data-default-source-lang="ko"
                     data-source-text="${fn:escapeXml(app.description)}"></div>
            </c:if>
        </td>
        <td class="adm-business-action-cell" onclick="openBusinessCellAction(event, this, 'status')">
            <button type="button"
                    class="adm-cell-link js-open-business-detail"
                    data-default-focus="status"
                    data-application-idx="${app.applicationIdx}">
                <span class="status-badge ${app.applicationStatus}">
                    <c:choose>
                        <c:when test="${app.applicationStatus eq 'PENDING'}">${msg_admin_business_status_pending}</c:when>
                        <c:when test="${app.applicationStatus eq 'APPROVED'}">${msg_admin_business_status_approved}</c:when>
                        <c:when test="${app.applicationStatus eq 'REJECTED'}">${msg_admin_business_status_rejected}</c:when>
                        <c:otherwise>${fn:escapeXml(app.applicationStatus)}</c:otherwise>
                    </c:choose>
                </span>
                <c:if test="${not empty app.rejectReason}">
                    <span class="adm-cell-link-note adm-business-reject-note">${fn:escapeXml(app.rejectReason)}</span>
                </c:if>
                <c:if test="${not empty app.reviewerNickname}">
                    <span class="adm-cell-link-note">${msg_admin_business_reviewer}</span>
                </c:if>
                <span class="adm-cell-link-note">${msg_admin_common_viewDetail}</span>
            </button>
            <c:if test="${not empty app.rejectReason}">
                <div class="adm-tr-inline js-admin-translation-widget"
                     data-label="${msg_admin_translation_label_businessAppRejectReason}"
                     data-source-type="BUSINESS_APPLICATION"
                     data-source-idx="${app.applicationIdx}"
                     data-field-name="reject_reason"
                     data-default-source-lang="ko"
                     data-source-text="${fn:escapeXml(app.rejectReason)}"></div>
            </c:if>
        </td>
        <td class="adm-business-action-cell" onclick="openBusinessCellAction(event, this, 'date')">
            <button type="button"
                    class="adm-cell-link js-open-business-detail"
                    data-default-focus="date"
                    data-application-idx="${app.applicationIdx}">
                <span>${appCreatedAtDisplay}</span>
                <span class="adm-cell-link-note">${msg_admin_common_viewDetail}</span>
            </button>
        </td>
        <td class="adm-business-action-cell" onclick="openBusinessCellAction(event, this, 'review')">
            <c:choose>
                <c:when test="${app.applicationStatus eq 'PENDING'}">
                    <div class="business-review-actions js-business-review-actions" id="business-review-actions-${app.applicationIdx}">
                        <form method="post" class="js-business-review-form" action="${pageContext.request.contextPath}/admin/business-applications/${app.applicationIdx}/approve">
                            <button type="submit" class="adm-row-btn detail"
                                    onclick="return confirm('${msg_admin_business_confirmApprove_js}')">${msg_admin_business_status_approved}</button>
                        </form>
                        <form method="post" class="js-business-review-form" action="${pageContext.request.contextPath}/admin/business-applications/${app.applicationIdx}/reject">
                            <input class="adm-input" name="rejectReason" maxlength="500" placeholder="${msg_admin_business_rejectReasonPlaceholder}" required>
                            <button type="submit" class="adm-row-btn danger">${msg_admin_business_status_rejected}</button>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <span class="adm-business-review-done">${msg_admin_business_reviewDone}</span>
                </c:otherwise>
            </c:choose>
        </td>
    </tr>
</c:forEach>

<c:if test="${empty applicationList}">
    <tr class="adm-local-empty">
        <td colspan="7" class="adm-local-empty-cell">
            ${msg_admin_business_noResults}
        </td>
    </tr>
</c:if>
