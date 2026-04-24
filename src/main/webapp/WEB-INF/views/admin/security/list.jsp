<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="security"/>
<spring:message code="admin.security.pageTitle" var="adminSecurityPageTitle"/>
<c:set var="pageTitle" value="${adminSecurityPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/security">
                <div class="adm-filter-bar">
                    <div class="adm-search-box" style="flex:1;min-width:220px;">
                        <div class="adm-filter-label"><spring:message code="admin.common.search"/></div>
                        <span class="adm-search-ico">🔍</span>
                        <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="<spring:message code='admin.security.searchPlaceholder'/>">
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
                        <div class="adm-filter-label"><spring:message code="admin.security.eventType"/></div>
                        <select class="adm-select" name="eventType">
                            <option value="ALL" ${search.eventType=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="FIND_ID" ${search.eventType=='FIND_ID'?'selected':''}><spring:message code="admin.security.eventType.findId"/></option>
                            <option value="FIND_PASSWORD" ${search.eventType=='FIND_PASSWORD'?'selected':''}><spring:message code="admin.security.eventType.findPassword"/></option>
                            <option value="RESET_PASSWORD" ${search.eventType=='RESET_PASSWORD'?'selected':''}><spring:message code="admin.security.eventType.resetPassword"/></option>
                            <option value="PASSWORD_CHANGE" ${search.eventType=='PASSWORD_CHANGE'?'selected':''}><spring:message code="admin.security.eventType.passwordChange"/></option>
                            <option value="EMAIL_VERIFY" ${search.eventType=='EMAIL_VERIFY'?'selected':''}><spring:message code="admin.security.eventType.emailVerify"/></option>
                            <option value="EMAIL_LOGIN_TOGGLE" ${search.eventType=='EMAIL_LOGIN_TOGGLE'?'selected':''}><spring:message code="admin.security.eventType.emailLoginToggle"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.security.stage"/></div>
                        <select class="adm-select" name="eventStage">
                            <option value="ALL" ${search.eventStage=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="REQUEST" ${search.eventStage=='REQUEST'?'selected':''}><spring:message code="admin.security.stage.request"/></option>
                            <option value="ISSUE" ${search.eventStage=='ISSUE'?'selected':''}><spring:message code="admin.security.stage.issue"/></option>
                            <option value="VERIFY" ${search.eventStage=='VERIFY'?'selected':''}><spring:message code="admin.security.stage.verify"/></option>
                            <option value="COMPLETE" ${search.eventStage=='COMPLETE'?'selected':''}><spring:message code="admin.security.stage.complete"/></option>
                        </select>
                    </div>
                    <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.security.historyTitle"/></div>
            <div style="font-size:12px;color:#64748b;"><spring:message code="admin.common.totalCount" arguments="${total}"/></div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th><spring:message code="admin.common.time"/></th>
                    <th><spring:message code="admin.security.targetMember"/></th>
                    <th><spring:message code="admin.security.actor"/></th>
                    <th><spring:message code="admin.security.eventType"/></th>
                    <th><spring:message code="admin.security.stage"/></th>
                    <th><spring:message code="admin.context.inputValue"/></th>
                    <th><spring:message code="admin.context.targetEmail"/></th>
                    <th><spring:message code="admin.common.result"/></th>
                    <th><spring:message code="admin.common.reason"/></th>
                    <th><spring:message code="admin.common.ip"/></th>
                    <th><spring:message code="admin.context.requestId"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr>
                        <td><fmt:formatDate value="${item.occurredAt}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.userIdx}">
                                    <button type="button"
                                            class="adm-inline-link js-open-member-context"
                                            data-user-idx="${item.userIdx}"
                                            data-default-tab="security"
                                            style="font-weight:700;color:#93c5fd;">${item.nickname}</button>
                                    <div class="mem-uid">
                                        <button type="button"
                                                class="adm-inline-link js-open-member-context"
                                                data-user-idx="${item.userIdx}"
                                                data-default-tab="security"
                                                style="color:#94a3b8;">@${item.userId}</button>
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
                                            style="font-weight:700;color:#93c5fd;">${item.actorNickname}</button>
                                    <div class="mem-uid">
                                        <button type="button"
                                                class="adm-inline-link js-open-member-context"
                                                data-user-idx="${item.actorUserIdx}"
                                                data-default-tab="security"
                                                style="color:#94a3b8;">@${item.actorUserId}</button>
                                    </div>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;"><spring:message code="admin.security.actorSystem"/></span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="eventType" data-param-value="${item.eventType}" onclick="applySelectFilter(this)">
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
                            <button type="button" class="adm-cell-link" data-param-name="eventStage" data-param-value="${item.eventStage}" onclick="applySelectFilter(this)">
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
                                    <button type="button"
                                            class="adm-cell-link"
                                            data-keyword="${item.inputIdentifier}"
                                            onclick="applyKeywordFilter(this)">
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
                                    <button type="button"
                                            class="adm-cell-link"
                                            data-keyword="${item.targetEmail}"
                                            onclick="applyKeywordFilter(this)">
                                        <span><c:out value="${item.targetEmail}"/></span>
                                        <span class="adm-cell-link-note"><spring:message code="admin.common.sameEmail"/></span>
                                    </button>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="success" data-param-value="${item.success ? 'SUCCESS' : 'FAIL'}" onclick="applySelectFilter(this)">
                                <c:choose>
                                    <c:when test="${item.success}"><span class="status-badge ACTIVE"><spring:message code="admin.common.success"/></span></c:when>
                                    <c:otherwise><span class="status-badge DELETED"><spring:message code="admin.common.fail"/></span></c:otherwise>
                                </c:choose>
                            </button>
                        </td>
                        <td style="max-width:280px;white-space:normal;">
                            <c:choose>
                                <c:when test="${not empty item.failReason}">
                                    <button type="button" class="adm-cell-link" data-keyword="${item.failReason}" onclick="applyKeywordFilter(this)">
                                        <span><c:out value="${item.failReason}"/></span>
                                        <span class="adm-cell-link-note"><spring:message code="admin.common.sameValue"/></span>
                                    </button>
                                    <div class="adm-tr-inline js-admin-translation-widget"
                                         data-label="<spring:message code='admin.translation.label.securityFailReason'/>"
                                         data-source-type="SECURITY_AUDIT"
                                         data-source-idx="${item.securityIdx}"
                                         data-field-name="fail_reason"
                                         data-default-source-lang="ko"
                                         data-source-text="${fn:escapeXml(item.failReason)}"></div>
                                </c:when>
                                <c:otherwise><div>-</div></c:otherwise>
                            </c:choose>
                            <c:if test="${not empty item.detailMessage}">
                                <div style="margin-top:8px;font-size:12px;color:#94a3b8;"><c:out value="${item.detailMessage}"/></div>
                                <div class="adm-tr-inline js-admin-translation-widget"
                                     data-label="<spring:message code='admin.translation.label.securityDetailMessage'/>"
                                     data-source-type="SECURITY_AUDIT"
                                     data-source-idx="${item.securityIdx}"
                                     data-field-name="detail_message"
                                     data-default-source-lang="ko"
                                     data-source-text="${fn:escapeXml(item.detailMessage)}"></div>
                            </c:if>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.ipAddress}">
                                    <button type="button"
                                            class="adm-cell-link js-open-ip-context"
                                            data-ip-address="${item.ipAddress}"
                                            data-default-tab="security">
                                        <span style="color:#93c5fd;">${item.ipAddress}</span>
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
                                            data-keyword="${not empty item.requestId ? item.requestId : item.flowTraceId}"
                                            onclick="openRelatedActivity(this)">
                                        <span style="font-size:12px;color:#64748b;"><c:out value="${empty item.requestId ? '-' : item.requestId}"/></span>
                                        <c:if test="${not empty item.flowTraceId}">
                                            <span class="adm-cell-link-note"><spring:message code="admin.common.trace"/>: <c:out value="${item.flowTraceId}"/></span>
                                        </c:if>
                                    </button>
                                </c:when>
                                <c:otherwise><div style="font-size:12px;color:#64748b;">-</div></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="11" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.common.noResults"/></td></tr>
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

<script>
function applyKeywordFilter(button) {
    var keyword = button.getAttribute('data-keyword');
    if (!keyword) return;
    const params = new URLSearchParams(window.location.search);
    params.set('keyword', keyword);
    params.set('page', '1');
    location.href = '${pageContext.request.contextPath}/admin/security?' + params.toString();
}

function applySelectFilter(button) {
    var paramName = button.getAttribute('data-param-name');
    var paramValue = button.getAttribute('data-param-value');
    if (!paramName || !paramValue) return;
    var params = new URLSearchParams(window.location.search);
    params.set(paramName, paramValue);
    params.set('page', '1');
    location.href = '${pageContext.request.contextPath}/admin/security?' + params.toString();
}

function openRelatedActivity(button) {
    var keyword = button.getAttribute('data-keyword');
    if (!keyword) return;
    var params = new URLSearchParams();
    params.set('keyword', keyword);
    params.set('page', '1');
    location.href = '${pageContext.request.contextPath}/admin/activity-logs?' + params.toString();
}

function goPage(page) {
    const params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = '${pageContext.request.contextPath}/admin/security?' + params.toString();
}
</script>

<%@ include file="../layout-close.jsp" %>
