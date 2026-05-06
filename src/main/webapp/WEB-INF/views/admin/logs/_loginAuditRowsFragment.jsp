<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_translation_label_loginFailReason" code="admin.translation.label.loginFailReason"/>
<spring:message var="msg_admin_common_sameDate" code="admin.common.sameDate"/>
<spring:message var="msg_admin_common_unidentified" code="admin.common.unidentified"/>
<spring:message var="msg_admin_logs_event_login" code="admin.logs.event.login"/>
<spring:message var="msg_admin_logs_event_logout" code="admin.logs.event.logout"/>
<spring:message var="msg_admin_logs_authType_password" code="admin.logs.authType.password"/>
<spring:message var="msg_admin_logs_authType_social" code="admin.logs.authType.social"/>
<spring:message var="msg_admin_common_sameValue" code="admin.common.sameValue"/>
<spring:message var="msg_admin_logs_provider_local" code="admin.logs.provider.local"/>
<spring:message var="msg_admin_logs_provider_kakao" code="admin.logs.provider.kakao"/>
<spring:message var="msg_admin_logs_provider_naver" code="admin.logs.provider.naver"/>
<spring:message var="msg_admin_logs_provider_google" code="admin.logs.provider.google"/>
<spring:message var="msg_admin_logs_authFlow_local" code="admin.logs.authFlow.local"/>
<spring:message var="msg_admin_logs_authFlow_id" code="admin.logs.authFlow.id"/>
<spring:message var="msg_admin_logs_authFlow_email" code="admin.logs.authFlow.email"/>
<spring:message var="msg_admin_logs_authFlow_passwordId" code="admin.logs.authFlow.passwordId"/>
<spring:message var="msg_admin_logs_authFlow_passwordEmail" code="admin.logs.authFlow.passwordEmail"/>
<spring:message var="msg_admin_logs_authFlow_socialLogin" code="admin.logs.authFlow.socialLogin"/>
<spring:message var="msg_admin_logs_authFlow_socialRegister" code="admin.logs.authFlow.socialRegister"/>
<spring:message var="msg_admin_logs_authFlow_logoutLocal" code="admin.logs.authFlow.logoutLocal"/>
<spring:message var="msg_admin_logs_authFlow_logoutSocial" code="admin.logs.authFlow.logoutSocial"/>
<spring:message var="msg_admin_common_success" code="admin.common.success"/>
<spring:message var="msg_admin_common_fail" code="admin.common.fail"/>
<spring:message var="msg_admin_common_sameIp" code="admin.common.sameIp"/>
<spring:message var="msg_admin_common_trace" code="admin.common.trace"/>
<spring:message var="msg_admin_common_viewDetail" code="admin.common.viewDetail"/>
<spring:message var="msg_admin_common_noResults" code="admin.common.noResults"/>
<c:forEach items="${list}" var="item">
                    <fmt:formatDate var="itemDateFilter" value="${item.loginAtDate}" pattern="yyyy-MM-dd"/>
                    <fmt:formatDate var="itemTimeDisplay" value="${item.loginAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
                    <tr class="js-login-row"
                        data-time="${item.loginAt.time}"
                        data-member="${fn:escapeXml(item.nickname)} ${fn:escapeXml(item.userId)} ${item.userIdx}"
                        data-event-type="${fn:escapeXml(item.eventType)}"
                        data-auth-type="${fn:escapeXml(item.authType)}"
                        data-provider="${fn:escapeXml(item.authProvider)}"
                        data-login-method="${fn:escapeXml(empty item.authFlow ? item.loginMethod : item.authFlow)}"
                        data-input="${fn:escapeXml(item.loginIdentifier)}"
                        data-success="${item.success ? '1' : '0'}"
                        data-reason="${fn:escapeXml(item.failReason)}"
                        data-ip="${fn:escapeXml(item.ipAddress)}"
                        data-request-id="${fn:escapeXml(empty item.requestId ? item.flowTraceId : item.requestId)}">
                        <td class="adm-check-cell">
                            <input type="checkbox" class="adm-check js-login-row-check" value="${item.loginIdx}" onchange="updateLoginSelectionState()">
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link"
                                    data-date="${itemDateFilter}"
                                    onclick="filterByDate(this.dataset.date)">
                                <span>${itemTimeDisplay}</span>
                                <span class="adm-cell-link-note">${msg_admin_common_sameDate}</span>
                            </button>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.userIdx}">
                                    <button type="button"
                                            class="adm-inline-link js-open-member-context"
                                            data-user-idx="${item.userIdx}"
                                            data-default-tab="logins"
                                            style="font-weight:700;color:#93c5fd;">${item.nickname}</button>
                                    <div class="mem-uid">
                                        <button type="button"
                                                class="adm-inline-link js-open-member-context"
                                                data-user-idx="${item.userIdx}"
                                                data-default-tab="logins"
                                                style="color:#94a3b8;">@${item.userId}</button>
                                    </div>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">${msg_admin_common_unidentified}</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="eventType" data-param-value="${item.eventType}" onclick="applySelectFilter(this)">
                                <span class="status-badge ${item.eventType == 'LOGOUT' ? 'PENDING' : 'ACTIVE'}">
                                    <c:choose>
                                        <c:when test="${item.eventType eq 'LOGIN'}">${msg_admin_logs_event_login}</c:when>
                                        <c:when test="${item.eventType eq 'LOGOUT'}">${msg_admin_logs_event_logout}</c:when>
                                        <c:otherwise><c:out value="${item.eventType}"/></c:otherwise>
                                    </c:choose>
                                </span>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="authType" data-param-value="${item.authType}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${item.authType eq 'PASSWORD'}">${msg_admin_logs_authType_password}</c:when>
                                    <c:when test="${item.authType eq 'SOCIAL'}">${msg_admin_logs_authType_social}</c:when>
                                    <c:otherwise><c:out value="${item.authType}"/></c:otherwise>
                                </c:choose></span>
                                <span class="adm-cell-link-note">${msg_admin_common_sameValue}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="authProvider" data-param-value="${item.authProvider}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${item.authProvider eq 'LOCAL'}">${msg_admin_logs_provider_local}</c:when>
                                    <c:when test="${item.authProvider eq 'KAKAO'}">${msg_admin_logs_provider_kakao}</c:when>
                                    <c:when test="${item.authProvider eq 'NAVER'}">${msg_admin_logs_provider_naver}</c:when>
                                    <c:when test="${item.authProvider eq 'GOOGLE'}">${msg_admin_logs_provider_google}</c:when>
                                    <c:otherwise><c:out value="${item.authProvider}"/></c:otherwise>
                                </c:choose></span>
                                <span class="adm-cell-link-note">${msg_admin_common_sameValue}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="loginMethod" data-param-value="${item.loginMethod}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'LOCAL'}">${msg_admin_logs_authFlow_local}</c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'ID'}">${msg_admin_logs_authFlow_id}</c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'EMAIL'}">${msg_admin_logs_authFlow_email}</c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'KAKAO'}">${msg_admin_logs_provider_kakao}</c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'NAVER'}">${msg_admin_logs_provider_naver}</c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'GOOGLE'}">${msg_admin_logs_provider_google}</c:when>
                                    <c:when test="${item.authFlow eq 'PASSWORD_ID'}">${msg_admin_logs_authFlow_passwordId}</c:when>
                                    <c:when test="${item.authFlow eq 'PASSWORD_EMAIL'}">${msg_admin_logs_authFlow_passwordEmail}</c:when>
                                    <c:when test="${item.authFlow eq 'SOCIAL_LOGIN'}">${msg_admin_logs_authFlow_socialLogin}</c:when>
                                    <c:when test="${item.authFlow eq 'SOCIAL_REGISTER'}">${msg_admin_logs_authFlow_socialRegister}</c:when>
                                    <c:when test="${item.authFlow eq 'LOGOUT_LOCAL'}">${msg_admin_logs_authFlow_logoutLocal}</c:when>
                                    <c:when test="${item.authFlow eq 'LOGOUT_SOCIAL'}">${msg_admin_logs_authFlow_logoutSocial}</c:when>
                                    <c:otherwise><c:out value="${empty item.authFlow ? item.loginMethod : item.authFlow}"/></c:otherwise>
                                </c:choose></span>
                                <c:if test="${not empty item.requestUri}">
                                    <span class="adm-cell-link-note"><c:out value="${item.requestUri}"/></span>
                                </c:if>
                            </button>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.loginIdentifier}">
                                    <button type="button"
                                            class="adm-cell-link"
                                            data-keyword="${item.loginIdentifier}"
                                            onclick="applyKeywordFilter(this)">
                                        <span><c:out value="${item.loginIdentifier}"/></span>
                                        <c:if test="${not empty item.requestUri}">
                                            <span class="adm-cell-link-note"><c:out value="${item.requestUri}"/></span>
                                        </c:if>
                                    </button>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;">-</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="success" data-param-value="${item.success ? 'SUCCESS' : 'FAIL'}" onclick="applySelectFilter(this)">
                                <c:choose>
                                    <c:when test="${item.success}"><span class="status-badge ACTIVE">${msg_admin_common_success}</span></c:when>
                                    <c:otherwise><span class="status-badge DELETED">${msg_admin_common_fail}</span></c:otherwise>
                                </c:choose>
                            </button>
                        </td>
                        <td style="max-width:280px;white-space:normal;">
                            <c:choose>
                                <c:when test="${not empty item.failReason}">
                                    <button type="button" class="adm-cell-link" data-keyword="${item.failReason}" onclick="applyKeywordFilter(this)">
                                        <span><c:out value="${item.failReason}"/></span>
                                        <span class="adm-cell-link-note">${msg_admin_common_sameValue}</span>
                                    </button>
                                    <div class="adm-tr-inline js-admin-translation-widget"
                                         data-label="${msg_admin_translation_label_loginFailReason}"
                                         data-source-type="LOGIN_AUDIT"
                                         data-source-idx="${item.loginIdx}"
                                         data-field-name="fail_reason"
                                         data-default-source-lang="ko"
                                         data-source-text="${fn:escapeXml(item.failReason)}"></div>
                                </c:when>
                                <c:when test="${item.success and not empty item.authFlow}">
                                    <button type="button" class="adm-cell-link" data-param-name="loginMethod" data-param-value="${item.loginMethod}" onclick="applySelectFilter(this)">
                                        <span style="color:#64748b;font-size:12px;"><c:out value="${item.authFlow}"/></span>
                                        <span class="adm-cell-link-note">${msg_admin_common_sameValue}</span>
                                    </button>
                                </c:when>
                                <c:otherwise><div style="color:#475569;">-</div></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.ipAddress}">
                                    <button type="button"
                                            class="adm-cell-link js-open-ip-context"
                                            data-ip-address="${item.ipAddress}"
                                            data-default-tab="logins">
                                        <span style="color:#93c5fd;">${item.ipAddress}</span>
                                        <span class="adm-cell-link-note">${msg_admin_common_sameIp}</span>
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
                                            data-keyword="${not empty item.requestId ? item.requestId : item.flowTraceId}"
                                            onclick="applyKeywordFilter(this)">
                                        <span><c:out value="${empty item.requestId ? '-' : item.requestId}"/></span>
                                        <c:if test="${not empty item.flowTraceId}">
                                            <span class="adm-cell-link-note">${msg_admin_common_trace}: <c:out value="${item.flowTraceId}"/></span>
                                        </c:if>
                                    </button>
                                </c:when>
                                <c:otherwise><div style="font-size:12px;color:#64748b;">-</div></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button" class="adm-row-btn detail"
                                    data-time="${itemTimeDisplay}"
                                    data-user="${fn:escapeXml(item.nickname)} (@${fn:escapeXml(item.userId)})"
                                    data-event="${fn:escapeXml(item.eventType)}"
                                    data-auth-type="${fn:escapeXml(item.authType)}"
                                    data-provider="${fn:escapeXml(item.authProvider)}"
                                    data-auth-flow="${fn:escapeXml(item.authFlow)}"
                                    data-login-method="${fn:escapeXml(item.loginMethod)}"
                                    data-identifier="${fn:escapeXml(item.loginIdentifier)}"
                                    data-success="${item.success ? 'SUCCESS' : 'FAIL'}"
                                    data-fail-reason="${fn:escapeXml(item.failReason)}"
                                    data-ip="${fn:escapeXml(item.ipAddress)}"
                                    data-request-id="${fn:escapeXml(item.requestId)}"
                                    data-flow-trace="${fn:escapeXml(item.flowTraceId)}"
                                    data-user-agent="${fn:escapeXml(item.userAgent)}"
                                    data-request-uri="${fn:escapeXml(item.requestUri)}"
                                    data-session-id="${fn:escapeXml(item.sessionId)}"
                                    onclick="openLoginDetail(this)">
                                ${msg_admin_common_viewDetail}
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="13" style="text-align:center;padding:40px;color:#475569;">${msg_admin_common_noResults}</td></tr>
                </c:if>
