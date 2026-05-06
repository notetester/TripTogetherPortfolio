<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <spring:message var="autoMsg_98481ad526" code="admin.common.sameDate"/>
<spring:message var="autoMsg_ccaf27af2d" code="admin.common.unidentified"/>
<spring:message var="autoMsg_d2d38ac959" code="admin.logs.event.login"/>
<spring:message var="autoMsg_e71dca93b6" code="admin.logs.event.logout"/>
<spring:message var="autoMsg_8ddac932c5" code="admin.logs.authType.password"/>
<spring:message var="autoMsg_fcf2433783" code="admin.logs.authType.social"/>
<spring:message var="autoMsg_9785a5a8df" code="admin.common.sameValue"/>
<spring:message var="autoMsg_763566f96c" code="admin.logs.provider.local"/>
<spring:message var="autoMsg_891d311be0" code="admin.logs.provider.kakao"/>
<spring:message var="autoMsg_9846873aa0" code="admin.logs.provider.naver"/>
<spring:message var="autoMsg_80afedd271" code="admin.logs.provider.google"/>
<spring:message var="autoMsg_07486a6d37" code="admin.logs.authFlow.local"/>
<spring:message var="autoMsg_0b1d4f5f78" code="admin.logs.authFlow.id"/>
<spring:message var="autoMsg_2957e85ab1" code="admin.logs.authFlow.email"/>
<spring:message var="autoMsg_a1663ec5e7" code="admin.logs.authFlow.passwordId"/>
<spring:message var="autoMsg_86d0007f19" code="admin.logs.authFlow.passwordEmail"/>
<spring:message var="autoMsg_8b3467de55" code="admin.logs.authFlow.socialLogin"/>
<spring:message var="autoMsg_c6c8a0647d" code="admin.logs.authFlow.socialRegister"/>
<spring:message var="autoMsg_499b8045d5" code="admin.logs.authFlow.logoutLocal"/>
<spring:message var="autoMsg_6ae7922350" code="admin.logs.authFlow.logoutSocial"/>
<spring:message var="autoMsg_af35bddcac" code="admin.common.success"/>
<spring:message var="autoMsg_160ce91b3d" code="admin.common.fail"/>
<spring:message var="autoMsg_74aaa991b5" code="admin.translation.label.loginFailReason"/>
<spring:message var="autoMsg_781f2a81b1" code="admin.common.sameIp"/>
<spring:message var="autoMsg_2b10d0b306" code="admin.common.trace"/>
<spring:message var="autoMsg_e87be69098" code="admin.common.noResults"/>
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
                                <span class="adm-cell-link-note">${autoMsg_98481ad526}</span>
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
                                <c:otherwise><span style="color:#64748b;">${autoMsg_ccaf27af2d}</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="eventType" data-param-value="${item.eventType}" onclick="applySelectFilter(this)">
                                <span class="status-badge ${item.eventType == 'LOGOUT' ? 'PENDING' : 'ACTIVE'}">
                                    <c:choose>
                                        <c:when test="${item.eventType eq 'LOGIN'}">${autoMsg_d2d38ac959}</c:when>
                                        <c:when test="${item.eventType eq 'LOGOUT'}">${autoMsg_e71dca93b6}</c:when>
                                        <c:otherwise><c:out value="${item.eventType}"/></c:otherwise>
                                    </c:choose>
                                </span>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="authType" data-param-value="${item.authType}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${item.authType eq 'PASSWORD'}">${autoMsg_8ddac932c5}</c:when>
                                    <c:when test="${item.authType eq 'SOCIAL'}">${autoMsg_fcf2433783}</c:when>
                                    <c:otherwise><c:out value="${item.authType}"/></c:otherwise>
                                </c:choose></span>
                                <span class="adm-cell-link-note">${autoMsg_9785a5a8df}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="authProvider" data-param-value="${item.authProvider}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${item.authProvider eq 'LOCAL'}">${autoMsg_763566f96c}</c:when>
                                    <c:when test="${item.authProvider eq 'KAKAO'}">${autoMsg_891d311be0}</c:when>
                                    <c:when test="${item.authProvider eq 'NAVER'}">${autoMsg_9846873aa0}</c:when>
                                    <c:when test="${item.authProvider eq 'GOOGLE'}">${autoMsg_80afedd271}</c:when>
                                    <c:otherwise><c:out value="${item.authProvider}"/></c:otherwise>
                                </c:choose></span>
                                <span class="adm-cell-link-note">${autoMsg_9785a5a8df}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="loginMethod" data-param-value="${item.loginMethod}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'LOCAL'}">${autoMsg_07486a6d37}</c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'ID'}">${autoMsg_0b1d4f5f78}</c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'EMAIL'}">${autoMsg_2957e85ab1}</c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'KAKAO'}">${autoMsg_891d311be0}</c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'NAVER'}">${autoMsg_9846873aa0}</c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'GOOGLE'}">${autoMsg_80afedd271}</c:when>
                                    <c:when test="${item.authFlow eq 'PASSWORD_ID'}">${autoMsg_a1663ec5e7}</c:when>
                                    <c:when test="${item.authFlow eq 'PASSWORD_EMAIL'}">${autoMsg_86d0007f19}</c:when>
                                    <c:when test="${item.authFlow eq 'SOCIAL_LOGIN'}">${autoMsg_8b3467de55}</c:when>
                                    <c:when test="${item.authFlow eq 'SOCIAL_REGISTER'}">${autoMsg_c6c8a0647d}</c:when>
                                    <c:when test="${item.authFlow eq 'LOGOUT_LOCAL'}">${autoMsg_499b8045d5}</c:when>
                                    <c:when test="${item.authFlow eq 'LOGOUT_SOCIAL'}">${autoMsg_6ae7922350}</c:when>
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
                                    <c:when test="${item.success}"><span class="status-badge ACTIVE">${autoMsg_af35bddcac}</span></c:when>
                                    <c:otherwise><span class="status-badge DELETED">${autoMsg_160ce91b3d}</span></c:otherwise>
                                </c:choose>
                            </button>
                        </td>
                        <td style="max-width:280px;white-space:normal;">
                            <c:choose>
                                <c:when test="${not empty item.failReason}">
                                    <button type="button" class="adm-cell-link" data-keyword="${item.failReason}" onclick="applyKeywordFilter(this)">
                                        <span><c:out value="${item.failReason}"/></span>
                                        <span class="adm-cell-link-note">${autoMsg_9785a5a8df}</span>
                                    </button>
                                    <div class="adm-tr-inline js-admin-translation-widget"
                                         data-label="${autoMsg_74aaa991b5}"
                                         data-source-type="LOGIN_AUDIT"
                                         data-source-idx="${item.loginIdx}"
                                         data-field-name="fail_reason"
                                         data-default-source-lang="ko"
                                         data-source-text="${fn:escapeXml(item.failReason)}"></div>
                                </c:when>
                                <c:when test="${item.success and not empty item.authFlow}">
                                    <button type="button" class="adm-cell-link" data-param-name="loginMethod" data-param-value="${item.loginMethod}" onclick="applySelectFilter(this)">
                                        <span style="color:#64748b;font-size:12px;"><c:out value="${item.authFlow}"/></span>
                                        <span class="adm-cell-link-note">${autoMsg_9785a5a8df}</span>
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
                                        <span class="adm-cell-link-note">${autoMsg_781f2a81b1}</span>
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
                                            <span class="adm-cell-link-note">${autoMsg_2b10d0b306}: <c:out value="${item.flowTraceId}"/></span>
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
                                <spring:message code="admin.common.viewDetail"/>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="13" style="text-align:center;padding:40px;color:#475569;">${autoMsg_e87be69098}</td></tr>
                </c:if>
