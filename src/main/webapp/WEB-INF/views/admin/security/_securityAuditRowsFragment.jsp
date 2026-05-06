<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_3879d8fad1" code="admin.common.sameDate"/>
<spring:message var="autoMsg_b514098ad9" code="admin.common.unidentified"/>
<spring:message var="autoMsg_0e42231833" code="admin.security.actorSystem"/>
<spring:message var="autoMsg_8259a3af01" code="admin.security.eventType.findId"/>
<spring:message var="autoMsg_73f138dc69" code="admin.security.eventType.findPassword"/>
<spring:message var="autoMsg_7c6576c3fc" code="admin.security.eventType.resetPassword"/>
<spring:message var="autoMsg_6a84d8b75a" code="admin.security.eventType.passwordChange"/>
<spring:message var="autoMsg_e13a916257" code="admin.security.eventType.emailVerify"/>
<spring:message var="autoMsg_740aad6433" code="admin.security.eventType.emailLoginToggle"/>
<spring:message var="autoMsg_cd6c98baa3" code="admin.common.sameValue"/>
<spring:message var="autoMsg_34859d5ff0" code="admin.security.stage.request"/>
<spring:message var="autoMsg_5a36057eff" code="admin.security.stage.issue"/>
<spring:message var="autoMsg_83f9e2e8c5" code="admin.security.stage.verify"/>
<spring:message var="autoMsg_8bddbfd2d3" code="admin.security.stage.complete"/>
<spring:message var="autoMsg_aad4d7be48" code="admin.common.sameEmail"/>
<spring:message var="autoMsg_aa1f4c0e8c" code="admin.common.success"/>
<spring:message var="autoMsg_60c250bc35" code="admin.common.fail"/>
<spring:message var="autoMsg_d204ac79e6" code="admin.translation.label.securityFailReason"/>
<spring:message var="autoMsg_b18b44d3d3" code="admin.translation.label.securityDetailMessage"/>
<spring:message var="autoMsg_f858019b0c" code="admin.common.sameIp"/>
<spring:message var="autoMsg_381b3591ff" code="admin.common.trace"/>
<spring:message var="autoMsg_f9419147cc" code="admin.common.noResults"/>
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
                <span class="adm-cell-link-note">${autoMsg_3879d8fad1}</span>
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
                <c:otherwise><span style="color:#64748b;">${autoMsg_b514098ad9}</span></c:otherwise>
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
                <c:otherwise><span style="color:#64748b;">${autoMsg_0e42231833}</span></c:otherwise>
            </c:choose>
        </td>
        <td>
            <button type="button" class="adm-cell-link" data-param-name="eventType" data-param-value="${item.eventType}" onclick="applySecuritySelectFilter(this)">
                <span><c:choose>
                    <c:when test="${item.eventType eq 'FIND_ID'}">${autoMsg_8259a3af01}</c:when>
                    <c:when test="${item.eventType eq 'FIND_PASSWORD'}">${autoMsg_73f138dc69}</c:when>
                    <c:when test="${item.eventType eq 'RESET_PASSWORD'}">${autoMsg_7c6576c3fc}</c:when>
                    <c:when test="${item.eventType eq 'PASSWORD_CHANGE'}">${autoMsg_6a84d8b75a}</c:when>
                    <c:when test="${item.eventType eq 'EMAIL_VERIFY'}">${autoMsg_e13a916257}</c:when>
                    <c:when test="${item.eventType eq 'EMAIL_LOGIN_TOGGLE'}">${autoMsg_740aad6433}</c:when>
                    <c:otherwise><c:out value="${item.eventType}"/></c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note">${autoMsg_cd6c98baa3}</span>
            </button>
        </td>
        <td>
            <button type="button" class="adm-cell-link" data-param-name="eventStage" data-param-value="${item.eventStage}" onclick="applySecuritySelectFilter(this)">
                <span><c:choose>
                    <c:when test="${item.eventStage eq 'REQUEST'}">${autoMsg_34859d5ff0}</c:when>
                    <c:when test="${item.eventStage eq 'ISSUE'}">${autoMsg_5a36057eff}</c:when>
                    <c:when test="${item.eventStage eq 'VERIFY'}">${autoMsg_83f9e2e8c5}</c:when>
                    <c:when test="${item.eventStage eq 'COMPLETE'}">${autoMsg_8bddbfd2d3}</c:when>
                    <c:otherwise><c:out value="${item.eventStage}"/></c:otherwise>
                </c:choose></span>
                <span class="adm-cell-link-note">${autoMsg_cd6c98baa3}</span>
            </button>
        </td>
        <td>
            <c:choose>
                <c:when test="${not empty item.inputIdentifier}">
                    <button type="button" class="adm-cell-link" data-keyword="${fn:escapeXml(item.inputIdentifier)}" onclick="applySecurityKeywordFilter(this)">
                        <span><c:out value="${item.inputIdentifier}"/></span>
                        <span class="adm-cell-link-note">${autoMsg_cd6c98baa3}</span>
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
                        <span class="adm-cell-link-note">${autoMsg_aad4d7be48}</span>
                    </button>
                </c:when>
                <c:otherwise>-</c:otherwise>
            </c:choose>
        </td>
        <td>
            <button type="button" class="adm-cell-link" data-param-name="success" data-param-value="${item.success ? 'SUCCESS' : 'FAIL'}" onclick="applySecuritySelectFilter(this)">
                <c:choose>
                    <c:when test="${item.success}"><span class="status-badge ACTIVE">${autoMsg_aa1f4c0e8c}</span></c:when>
                    <c:otherwise><span class="status-badge DELETED">${autoMsg_60c250bc35}</span></c:otherwise>
                </c:choose>
            </button>
        </td>
        <td>
            <div class="adm-ellipsis-block">
                <c:choose>
                    <c:when test="${not empty item.failReason}">
                        <button type="button" class="adm-cell-link" data-keyword="${fn:escapeXml(item.failReason)}" onclick="applySecurityKeywordFilter(this)">
                            <span><c:out value="${item.failReason}"/></span>
                            <span class="adm-cell-link-note">${autoMsg_cd6c98baa3}</span>
                        </button>
                        <div class="adm-tr-inline js-admin-translation-widget"
                             data-label="${autoMsg_d204ac79e6}"
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
                         data-label="${autoMsg_b18b44d3d3}"
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
                        <span class="adm-cell-link-note">${autoMsg_f858019b0c}</span>
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
                                <span class="adm-cell-link-note adm-ellipsis-line">${autoMsg_381b3591ff}</span>
                            </c:when>
                            <c:when test="${not empty item.requestId and not empty item.flowTraceId and item.requestId ne item.flowTraceId}">
                                <span class="adm-cell-link-note adm-ellipsis-line">${autoMsg_381b3591ff}: <c:out value="${item.flowTraceId}"/></span>
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
    <tr class="adm-local-empty"><td colspan="13" style="text-align:center;padding:40px;color:#64748b;">${autoMsg_f9419147cc}</td></tr>
</c:if>
