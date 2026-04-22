<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="logins"/>
<spring:message code="admin.logs.pageTitle" var="adminLogsPageTitle"/>
<c:set var="pageTitle" value="${adminLogsPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/logins">
                <div class="adm-filter-bar">
                    <div class="adm-search-box" style="flex:1;min-width:220px;">
                        <div class="adm-filter-label"><spring:message code="admin.common.search"/></div>
                        <span class="adm-search-ico">🔍</span>
                        <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="<spring:message code='admin.logs.searchPlaceholder'/>">
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.logs.event"/></div>
                        <select class="adm-select" name="eventType">
                            <option value="ALL" ${search.eventType=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="LOGIN" ${search.eventType=='LOGIN'?'selected':''}><spring:message code="admin.logs.event.login"/></option>
                            <option value="LOGOUT" ${search.eventType=='LOGOUT'?'selected':''}><spring:message code="admin.logs.event.logout"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.logs.success"/></div>
                        <select class="adm-select" name="success">
                            <option value="ALL" ${search.success=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="SUCCESS" ${search.success=='SUCCESS'?'selected':''}><spring:message code="admin.common.success"/></option>
                            <option value="FAIL" ${search.success=='FAIL'?'selected':''}><spring:message code="admin.common.fail"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.logs.authType"/></div>
                        <select class="adm-select" name="authType">
                            <option value="ALL" ${search.authType=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="PASSWORD" ${search.authType=='PASSWORD'?'selected':''}><spring:message code="admin.logs.authType.password"/></option>
                            <option value="SOCIAL" ${search.authType=='SOCIAL'?'selected':''}><spring:message code="admin.logs.authType.social"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.logs.provider"/></div>
                        <select class="adm-select" name="authProvider">
                            <option value="ALL" ${search.authProvider=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="LOCAL" ${search.authProvider=='LOCAL'?'selected':''}><spring:message code="admin.logs.provider.local"/></option>
                            <option value="KAKAO" ${search.authProvider=='KAKAO'?'selected':''}><spring:message code="admin.logs.provider.kakao"/></option>
                            <option value="NAVER" ${search.authProvider=='NAVER'?'selected':''}><spring:message code="admin.logs.provider.naver"/></option>
                            <option value="GOOGLE" ${search.authProvider=='GOOGLE'?'selected':''}><spring:message code="admin.logs.provider.google"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.logs.authFlow"/></div>
                        <select class="adm-select" name="loginMethod">
                            <option value="ALL" ${search.loginMethod=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="LOCAL" ${search.loginMethod=='LOCAL'?'selected':''}><spring:message code="admin.logs.authFlow.local"/></option>
                            <option value="ID" ${search.loginMethod=='ID'?'selected':''}><spring:message code="admin.logs.authFlow.id"/></option>
                            <option value="EMAIL" ${search.loginMethod=='EMAIL'?'selected':''}><spring:message code="admin.logs.authFlow.email"/></option>
                            <option value="KAKAO" ${search.loginMethod=='KAKAO'?'selected':''}><spring:message code="admin.logs.provider.kakao"/></option>
                            <option value="NAVER" ${search.loginMethod=='NAVER'?'selected':''}><spring:message code="admin.logs.provider.naver"/></option>
                            <option value="GOOGLE" ${search.loginMethod=='GOOGLE'?'selected':''}><spring:message code="admin.logs.provider.google"/></option>
                        </select>
                    </div>
                    <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.logs.historyTitle"/></div>
            <div style="font-size:12px;color:#64748b;"><spring:message code="admin.common.totalCount" arguments="${total}"/></div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th><spring:message code="admin.common.time"/></th>
                    <th><spring:message code="admin.common.member"/></th>
                    <th><spring:message code="admin.logs.event"/></th>
                    <th><spring:message code="admin.logs.authType"/></th>
                    <th><spring:message code="admin.logs.provider"/></th>
                    <th><spring:message code="admin.logs.authFlow"/></th>
                    <th><spring:message code="admin.context.inputValue"/></th>
                    <th><spring:message code="admin.common.result"/></th>
                    <th><spring:message code="admin.common.reason"/></th>
                    <th><spring:message code="admin.common.ip"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr>
                        <td><fmt:formatDate value="${item.loginAt}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
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
                                <c:otherwise><span style="color:#64748b;"><spring:message code="admin.common.unidentified"/></span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="status-badge ${item.eventType == 'LOGOUT' ? 'PENDING' : 'ACTIVE'}">
                                <c:choose>
                                    <c:when test="${item.eventType eq 'LOGIN'}"><spring:message code="admin.logs.event.login"/></c:when>
                                    <c:when test="${item.eventType eq 'LOGOUT'}"><spring:message code="admin.logs.event.logout"/></c:when>
                                    <c:otherwise><c:out value="${item.eventType}"/></c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.authType eq 'PASSWORD'}"><spring:message code="admin.logs.authType.password"/></c:when>
                                <c:when test="${item.authType eq 'SOCIAL'}"><spring:message code="admin.logs.authType.social"/></c:when>
                                <c:otherwise><c:out value="${item.authType}"/></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.authProvider eq 'LOCAL'}"><spring:message code="admin.logs.provider.local"/></c:when>
                                <c:when test="${item.authProvider eq 'KAKAO'}"><spring:message code="admin.logs.provider.kakao"/></c:when>
                                <c:when test="${item.authProvider eq 'NAVER'}"><spring:message code="admin.logs.provider.naver"/></c:when>
                                <c:when test="${item.authProvider eq 'GOOGLE'}"><spring:message code="admin.logs.provider.google"/></c:when>
                                <c:otherwise><c:out value="${item.authProvider}"/></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div>
                                <c:choose>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'LOCAL'}"><spring:message code="admin.logs.authFlow.local"/></c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'ID'}"><spring:message code="admin.logs.authFlow.id"/></c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'EMAIL'}"><spring:message code="admin.logs.authFlow.email"/></c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'KAKAO'}"><spring:message code="admin.logs.provider.kakao"/></c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'NAVER'}"><spring:message code="admin.logs.provider.naver"/></c:when>
                                    <c:when test="${empty item.authFlow and item.loginMethod eq 'GOOGLE'}"><spring:message code="admin.logs.provider.google"/></c:when>
                                    <c:when test="${item.authFlow eq 'PASSWORD_ID'}"><spring:message code="admin.logs.authFlow.passwordId"/></c:when>
                                    <c:when test="${item.authFlow eq 'PASSWORD_EMAIL'}"><spring:message code="admin.logs.authFlow.passwordEmail"/></c:when>
                                    <c:when test="${item.authFlow eq 'SOCIAL_LOGIN'}"><spring:message code="admin.logs.authFlow.socialLogin"/></c:when>
                                    <c:when test="${item.authFlow eq 'SOCIAL_REGISTER'}"><spring:message code="admin.logs.authFlow.socialRegister"/></c:when>
                                    <c:when test="${item.authFlow eq 'LOGOUT_LOCAL'}"><spring:message code="admin.logs.authFlow.logoutLocal"/></c:when>
                                    <c:when test="${item.authFlow eq 'LOGOUT_SOCIAL'}"><spring:message code="admin.logs.authFlow.logoutSocial"/></c:when>
                                    <c:otherwise><c:out value="${empty item.authFlow ? item.loginMethod : item.authFlow}"/></c:otherwise>
                                </c:choose>
                            </div>
                            <c:if test="${not empty item.requestUri}">
                                <div style="margin-top:4px;font-size:11px;color:#64748b;max-width:220px;word-break:break-all;">
                                    <c:out value="${item.requestUri}"/>
                                </div>
                            </c:if>
                        </td>
                        <td>
                            <div><c:out value="${empty item.loginIdentifier ? '-' : item.loginIdentifier}"/></div>
                            <div class="adm-inline-actions">
                                <c:if test="${not empty item.loginIdentifier}">
                                    <button type="button"
                                            class="adm-inline-chip"
                                            data-keyword="${item.loginIdentifier}"
                                            onclick="applyKeywordFilter(this)">
                                        <spring:message code="admin.common.sameValue"/>
                                    </button>
                                </c:if>
                                <c:if test="${not empty item.requestUri}">
                                    <button type="button"
                                            class="adm-inline-chip"
                                            data-keyword="${item.requestUri}"
                                            onclick="applyKeywordFilter(this)">
                                        <spring:message code="admin.common.uri"/>
                                    </button>
                                </c:if>
                            </div>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.success}"><span class="status-badge ACTIVE"><spring:message code="admin.common.success"/></span></c:when>
                                <c:otherwise><span class="status-badge DELETED"><spring:message code="admin.common.fail"/></span></c:otherwise>
                            </c:choose>
                        </td>
                        <td><c:out value="${empty item.failReason ? '-' : item.failReason}"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.ipAddress}">
                                    <div>
                                        <button type="button"
                                                class="adm-inline-link js-open-ip-context"
                                                data-ip-address="${item.ipAddress}"
                                                data-default-tab="logins"
                                                style="color:#93c5fd;">${item.ipAddress}</button>
                                    </div>
                                    <div class="adm-inline-actions">
                                        <button type="button"
                                                class="adm-inline-chip"
                                                data-keyword="${item.ipAddress}"
                                                onclick="applyKeywordFilter(this)">
                                            <spring:message code="admin.common.sameIp"/>
                                        </button>
                                    </div>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div style="font-size:12px;color:#64748b;">
                                <c:if test="${not empty item.flowTraceId}">
                                    <div><spring:message code="admin.common.trace"/>: <c:out value="${item.flowTraceId}"/></div>
                                </c:if>
                                <c:if test="${empty item.flowTraceId}">
                                    <div>-</div>
                                </c:if>
                                <c:if test="${not empty item.requestId}">
                                    <div style="margin-top:4px;"><c:out value="${item.requestId}"/></div>
                                </c:if>
                            </div>
                            <div class="adm-inline-actions">
                                <c:if test="${not empty item.requestId}">
                                    <button type="button"
                                            class="adm-inline-chip"
                                            data-keyword="${item.requestId}"
                                            onclick="applyKeywordFilter(this)">
                                        <spring:message code="admin.common.sameRequest"/>
                                    </button>
                                </c:if>
                                <c:if test="${not empty item.flowTraceId}">
                                    <button type="button"
                                            class="adm-inline-chip"
                                            data-keyword="${item.flowTraceId}"
                                            onclick="applyKeywordFilter(this)">
                                        <spring:message code="admin.common.sameFlow"/>
                                    </button>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="10" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.common.noResults"/></td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <c:if test="${paging.totalPage > 1}">
            <div class="adm-paging">
                <c:if test="${paging.prev}"><button class="adm-page-btn" onclick="goPage(${paging.startPage - 1})">‹</button></c:if>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
                    <button class="adm-page-btn ${p == paging.currentPage ? 'active' : ''}" onclick="goPage(${p})">${p}</button>
                </c:forEach>
                <c:if test="${paging.next}"><button class="adm-page-btn" onclick="goPage(${paging.endPage + 1})">›</button></c:if>
                <span class="adm-page-info"><spring:message code="admin.common.pageStatus" arguments="${paging.currentPage},${paging.totalPage}"/></span>
            </div>
        </c:if>
    </div>
</div>

<%@ include file="../common/context-modal.jspf" %>

<script>
function applyKeywordFilter(button) {
    var keyword = button.getAttribute('data-keyword');
    if (!keyword) return;
    const params = new URLSearchParams(window.location.search);
    params.set('keyword', keyword);
    params.set('page', '1');
    location.href = '${pageContext.request.contextPath}/admin/logins?' + params.toString();
}

function goPage(page) {
    const params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = '${pageContext.request.contextPath}/admin/logins?' + params.toString();
}
</script>

<%@ include file="../layout-close.jsp" %>
