<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:message var="adminTranslationLabelSecurityFailReasonMsg" code="admin.translation.label.securityFailReason"/>
<spring:message var="adminTranslationLabelSecurityDetailMessageMsg" code="admin.translation.label.securityDetailMessage"/>
<c:forEach items="${list}" var="item" varStatus="st">
    <fmt:formatDate var="itemDateFilter" value="${item.occurredAtDate}" pattern="yyyy-MM-dd"/>
    <fmt:formatDate var="itemTimeDisplay" value="${item.occurredAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
    <c:set var="securityRequestKey" value="${not empty item.requestId ? item.requestId : item.flowTraceId}"/>
    <c:set var="securityActorDisplay" value="${empty item.actorUserIdx ? 'SYSTEM' : item.actorNickname}"/>
    <tr class="js-security-row"
        data-time="${item.occurredAt != null ? item.occurredAt.time : 0}"
        data-target-member="${fn:escapeXml(item.nickname)} ${fn:escapeXml(item.userId)} ${item.userIdx}"
        data-actor="${fn:escapeXml(item.actorNickname)} ${fn:escapeXml(item.actorUserId)} ${item.actorUserIdx}"
        data-event-type="${fn:escapeXml(item.eventType)}"
        data-event-stage="${fn:escapeXml(item.eventStage)}"
        data-input="${fn:escapeXml(item.inputIdentifier)}"
        data-target-email="${fn:escapeXml(item.targetEmail)}"
        data-success="${item.success ? '1' : '0'}"
        data-reason="${fn:escapeXml(item.failReason)}"
        data-ip="${fn:escapeXml(item.ipAddress)}"
        data-request-id="${fn:escapeXml(empty item.requestId ? item.flowTraceId : item.requestId)}"
        data-original-index="${st.index}">
        <td class="adm-check-cell">
            <input type="checkbox" class="adm-check js-security-row-check" value="${item.securityIdx}" onchange="updateSecuritySelectionState()">
        </td>
        <td>
            <button type="button" class="adm-cell-link"
                    data-date="${itemDateFilter}"
                    onclick="filterSecurityByDate(this.dataset.date)">
                <span>${itemTimeDisplay}</span>
                <span class="adm-cell-link-note"><spring:message code="admin.common.sameDate"/></span>
            </button>
        </td>
        <td>
            <c:choose>
                <c:when test="${not empty item.userIdx}">
                    <button type="button"
                            class="adm-inline-link js-open-member-context"
                            data-user-idx="${item.userIdx}"
                            data-default-tab="security"
                            style="font-weight:700;color:#93c5fd;">${fn:escapeXml(item.nickname)}</button>
                    <div class="mem-uid">
                        <button type="button"
                                class="adm-inline-link js-open-member-context"
                                data-user-idx="${item.userIdx}"
                                data-default-tab="security"
                                style="color:#94a3b8;">@${fn:escapeXml(item.userId)}</button>
                    </div>
                </c:when>
                <c:otherwise><span style="color:#64748b;"><spring:message code="admin.common.unidentified"/></span></c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:choose>
                <c:when test="${not empty item.actorUserIdx}">
                    <button type="button"
                            class="adm-inline-link js-open-member-context"
                            data-user-idx="${item.actorUserIdx}"
                            data-default-tab="security"
                            style="font-weight:700;color:#93c5fd;">${fn:escapeXml(item.actorNickname)}</button>
                    <div class="mem-uid">
                        <button type="button"
                                class="adm-inline-link js-open-member-context"
                                data-user-idx="${item.actorUserIdx}"
                                data-default-tab="security"
                                style="color:#94a3b8;">@${fn:escapeXml(item.actorUserId)}</button>
                    </div>
                </c:when>
                <c:otherwise><span style="color:#64748b;"><spring:message code="admin.security.actorSystem"/></span></c:otherwise>
            </c:choose>
        </td>
        <td>
            <button type="button" class="adm-cell-link" data-param-name="eventType" data-param-value="${item.eventType}" onclick="applySecuritySelectFilter(this)">
                <span><c:choose>
                    <c:when test="${item.eventType eq 'FIND_ID'}"><spring:message code="admin.security.eventType.findId"/></c:when>
                    <c:when test="${item.eventType eq 'FIND_PASSWORD'}"><spring:message code="admin.security.eventType.findPassword"/></c:when>
                    <c:when test="${item.eventType eq 'RESET_PASSWORD'}"><spring:message code="admin.security.eventType.resetPassword"/></c:when>
                    <c:when test="${item.eventType eq 'PASSWORD_CHANGE'}"><spring:message code="admin.security.eventType.passwordChange"/></c:when>
                    <c:when test="${item.eventType eq 'EMAIL_VERIFY'}"><spring:message code="admin.security.eventType.emailVerify"/></c:when>
                    <c:when test="${item.eventType eq 'EMAIL_LOGIN_TOGGLE'}"><spring:message code="admin.security.eventType.emailLoginToggle"/></c:when>
                    <c:otherwise><c:out value="${item.eventType}"/></c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
            </button>
        </td>
        <td>
            <button type="button" class="adm-cell-link" data-param-name="eventStage" data-param-value="${item.eventStage}" onclick="applySecuritySelectFilter(this)">
                <span><c:choose>
                    <c:when test="${item.eventStage eq 'REQUEST'}"><spring:message code="admin.security.stage.request"/></c:when>
                    <c:when test="${item.eventStage eq 'ISSUE'}"><spring:message code="admin.security.stage.issue"/></c:when>
                    <c:when test="${item.eventStage eq 'VERIFY'}"><spring:message code="admin.security.stage.verify"/></c:when>
                    <c:when test="${item.eventStage eq 'COMPLETE'}"><spring:message code="admin.security.stage.complete"/></c:when>
                    <c:otherwise><c:out value="${item.eventStage}"/></c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
            </button>
        </td>
        <td>
            <c:choose>
                <c:when test="${not empty item.inputIdentifier}">
                    <button type="button" class="adm-cell-link" data-keyword="${fn:escapeXml(item.inputIdentifier)}" onclick="applySecurityKeywordFilter(this)">
                        <span><c:out value="${item.inputIdentifier}"/></span>
                        <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
                    </button>
                </c:when>
                <c:otherwise>-</c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:choose>
                <c:when test="${not empty item.targetEmail}">
                    <button type="button" class="adm-cell-link" data-keyword="${fn:escapeXml(item.targetEmail)}" onclick="applySecurityKeywordFilter(this)">
                        <span><c:out value="${item.targetEmail}"/></span>
                        <span class="adm-cell-link-note"><spring:message code="admin.common.sameEmail"/></span>
                    </button>
                </c:when>
                <c:otherwise>-</c:otherwise>
            </c:choose>
        </td>
        <td>
            <button type="button" class="adm-cell-link" data-param-name="success" data-param-value="${item.success ? 'SUCCESS' : 'FAIL'}" onclick="applySecuritySelectFilter(this)">
                <c:choose>
                    <c:when test="${item.success}"><span class="status-badge ACTIVE"><spring:message code="admin.common.success"/></span></c:when>
                    <c:otherwise><span class="status-badge DELETED"><spring:message code="admin.common.fail"/></span></c:otherwise>
                </c:choose>
            </button>
        </td>
        <td>
            <div class="adm-ellipsis-block">
                <c:choose>
                    <c:when test="${not empty item.failReason}">
                        <button type="button" class="adm-cell-link" data-keyword="${fn:escapeXml(item.failReason)}" onclick="applySecurityKeywordFilter(this)">
                            <span><c:out value="${item.failReason}"/></span>
                            <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
                        </button>
                        <div class="adm-tr-inline js-admin-translation-widget"
                             data-label="${adminTranslationLabelSecurityFailReasonMsg}"
                             data-source-type="SECURITY_AUDIT"
                             data-source-idx="${item.securityIdx}"
                             data-field-name="fail_reason"
                             data-default-source-lang="ko"
                             data-source-text="${fn:escapeXml(item.failReason)}"></div>
                    </c:when>
                    <c:otherwise><span>-</span></c:otherwise>
                </c:choose>
                <c:if test="${not empty item.detailMessage}">
                    <div class="adm-cell-link-note adm-ellipsis-line" style="margin-top:6px;"><c:out value="${item.detailMessage}"/></div>
                    <div class="adm-tr-inline js-admin-translation-widget"
                         data-label="${adminTranslationLabelSecurityDetailMessageMsg}"
                         data-source-type="SECURITY_AUDIT"
                         data-source-idx="${item.securityIdx}"
                         data-field-name="detail_message"
                         data-default-source-lang="ko"
                         data-source-text="${fn:escapeXml(item.detailMessage)}"></div>
                </c:if>
            </div>
        </td>
        <td>
            <c:choose>
                <c:when test="${not empty item.ipAddress}">
                    <button type="button"
                            class="adm-cell-link js-open-ip-context"
                            data-ip-address="${fn:escapeXml(item.ipAddress)}"
                            data-default-tab="security">
                        <span style="color:#93c5fd;">${fn:escapeXml(item.ipAddress)}</span>
                        <span class="adm-cell-link-note"><spring:message code="admin.common.sameIp"/></span>
                    </button>
                </c:when>
                <c:otherwise>-</c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:choose>
                <c:when test="${not empty item.requestId or not empty item.flowTraceId}">
                    <button type="button"
                            class="adm-cell-link"
                            data-request-key="${fn:escapeXml(securityRequestKey)}"
                            onclick="applySecurityRequestFlowFilter(this)">
                        <span class="adm-ellipsis-line" style="font-size:12px;color:#cbd5e1;"><c:out value="${securityRequestKey}"/></span>
                        <c:choose>
                            <c:when test="${empty item.requestId and not empty item.flowTraceId}">
                                <span class="adm-cell-link-note adm-ellipsis-line"><spring:message code="admin.common.trace"/></span>
                            </c:when>
                            <c:when test="${not empty item.requestId and not empty item.flowTraceId and item.requestId ne item.flowTraceId}">
                                <span class="adm-cell-link-note adm-ellipsis-line"><spring:message code="admin.common.trace"/>: <c:out value="${item.flowTraceId}"/></span>
                            </c:when>
                        </c:choose>
                    </button>
                </c:when>
                <c:otherwise><div style="font-size:12px;color:#64748b;">-</div></c:otherwise>
            </c:choose>
        </td>
        <td>
            <button type="button" class="adm-row-btn detail"
                    data-time="${itemTimeDisplay}"
                    data-target-user="${fn:escapeXml(item.nickname)} (@${fn:escapeXml(item.userId)})"
                    data-actor="${fn:escapeXml(securityActorDisplay)}${not empty item.actorUserIdx ? ' (@' : ''}${fn:escapeXml(item.actorUserId)}${not empty item.actorUserIdx ? ')' : ''}"
                    data-event-type="${fn:escapeXml(item.eventType)}"
                    data-event-stage="${fn:escapeXml(item.eventStage)}"
                    data-identifier="${fn:escapeXml(item.inputIdentifier)}"
                    data-target-email="${fn:escapeXml(item.targetEmail)}"
                    data-success="${item.success ? 'SUCCESS' : 'FAIL'}"
                    data-fail-reason="${fn:escapeXml(item.failReason)}"
                    data-detail-msg="${fn:escapeXml(item.detailMessage)}"
                    data-ip="${fn:escapeXml(item.ipAddress)}"
                    data-request-id="${fn:escapeXml(item.requestId)}"
                    data-request-key="${fn:escapeXml(securityRequestKey)}"
                    data-flow-trace="${fn:escapeXml(item.flowTraceId)}"
                    data-user-agent="${fn:escapeXml(item.userAgent)}"
                    onclick="openSecurityDetail(this)">
                <spring:message code="admin.common.viewDetail"/>
            </button>
        </td>
    </tr>
</c:forEach>
<c:if test="${empty list}">
    <tr class="adm-local-empty"><td colspan="13" style="text-align:center;padding:40px;color:#64748b;"><spring:message code="admin.common.noResults"/></td></tr>
</c:if>
