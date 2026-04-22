<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="emailVerifications"/>
<spring:message code="admin.emailRequests.pageTitle" var="adminEmailRequestsPageTitle"/>
<c:set var="pageTitle" value="${adminEmailRequestsPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/email-verifications">
                <div class="adm-filter-bar">
                    <div class="adm-search-box" style="flex:1;min-width:220px;">
                        <div class="adm-filter-label"><spring:message code="admin.common.search"/></div>
                        <span class="adm-search-ico">🔍</span>
                        <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="<spring:message code='admin.emailRequests.searchPlaceholder'/>">
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.emailRequests.purpose"/></div>
                        <select class="adm-select" name="purpose">
                            <option value="ALL" ${search.purpose=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="PROFILE_EMAIL" ${search.purpose=='PROFILE_EMAIL'?'selected':''}><spring:message code="admin.emailRequests.purpose.profileEmail"/></option>
                            <option value="FIND_ID" ${search.purpose=='FIND_ID'?'selected':''}><spring:message code="admin.emailRequests.purpose.findId"/></option>
                            <option value="RESET_PW" ${search.purpose=='RESET_PW'?'selected':''}><spring:message code="admin.emailRequests.purpose.resetPw"/></option>
                            <option value="VERIFY" ${search.purpose=='VERIFY'?'selected':''}><spring:message code="admin.emailRequests.purpose.verify"/></option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.common.status"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="REQUESTED" ${search.status=='REQUESTED'?'selected':''}><spring:message code="admin.emailRequests.status.requested"/></option>
                            <option value="VERIFIED" ${search.status=='VERIFIED'?'selected':''}><spring:message code="admin.emailRequests.status.verified"/></option>
                            <option value="APPLIED" ${search.status=='APPLIED'?'selected':''}><spring:message code="admin.emailRequests.status.applied"/></option>
                            <option value="EXPIRED" ${search.status=='EXPIRED'?'selected':''}><spring:message code="admin.emailRequests.status.expired"/></option>
                            <option value="CANCELLED" ${search.status=='CANCELLED'?'selected':''}><spring:message code="admin.emailRequests.status.cancelled"/></option>
                        </select>
                    </div>
                    <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.emailRequests.historyTitle"/></div>
            <div style="font-size:12px;color:#64748b;"><spring:message code="admin.common.totalCount" arguments="${total}"/></div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th><spring:message code="admin.emailRequests.requestedAt"/></th>
                    <th><spring:message code="admin.common.member"/></th>
                    <th><spring:message code="admin.emailRequests.purpose"/></th>
                    <th><spring:message code="admin.context.requestEmail"/></th>
                    <th><spring:message code="admin.common.status"/></th>
                    <th><spring:message code="admin.emailRequests.verifiedAt"/></th>
                    <th><spring:message code="admin.emailRequests.appliedAt"/></th>
                    <th><spring:message code="admin.context.expiresAt"/></th>
                    <th><spring:message code="admin.common.ip"/></th>
                    <th><spring:message code="admin.context.requestId"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr>
                        <td><fmt:formatDate value="${item.requestedAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.userIdx}">
                                    <button type="button"
                                            class="adm-inline-link js-open-member-context"
                                            data-user-idx="${item.userIdx}"
                                            data-default-tab="emailRequests"
                                            style="font-weight:700;color:#93c5fd;"><c:out value="${item.nickname}"/></button>
                                    <div class="mem-uid">
                                        <button type="button"
                                                class="adm-inline-link js-open-member-context"
                                                data-user-idx="${item.userIdx}"
                                                data-default-tab="emailRequests"
                                                style="color:#94a3b8;">@${item.userId}</button>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="mem-name"><spring:message code="admin.emailRequests.unknownRequest"/></div>
                                    <div class="mem-uid">-</div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.purpose == 'PROFILE_EMAIL'}"><spring:message code="admin.emailRequests.purpose.profileEmail"/></c:when>
                                <c:when test="${item.purpose == 'FIND_ID'}"><spring:message code="admin.emailRequests.purpose.findId"/></c:when>
                                <c:when test="${item.purpose == 'RESET_PW'}"><spring:message code="admin.emailRequests.purpose.resetPw"/></c:when>
                                <c:when test="${item.purpose == 'VERIFY'}"><spring:message code="admin.emailRequests.purpose.verify"/></c:when>
                                <c:otherwise><c:out value="${item.purpose}"/></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div><c:out value="${item.pendingEmail}"/></div>
                            <div class="adm-inline-actions">
                                <button type="button"
                                        class="adm-inline-chip"
                                        data-keyword="${item.pendingEmail}"
                                        onclick="applyKeywordFilter(this)">
                                    <spring:message code="admin.common.sameEmail"/>
                                </button>
                            </div>
                        </td>
                        <td>
                            <span class="status-badge ACTIVE">
                                <c:choose>
                                    <c:when test="${item.status == 'REQUESTED'}"><spring:message code="admin.emailRequests.status.requested"/></c:when>
                                    <c:when test="${item.status == 'VERIFIED'}"><spring:message code="admin.emailRequests.status.verified"/></c:when>
                                    <c:when test="${item.status == 'APPLIED'}"><spring:message code="admin.emailRequests.status.applied"/></c:when>
                                    <c:when test="${item.status == 'EXPIRED'}"><spring:message code="admin.emailRequests.status.expired"/></c:when>
                                    <c:when test="${item.status == 'CANCELLED'}"><spring:message code="admin.emailRequests.status.cancelled"/></c:when>
                                    <c:otherwise><c:out value="${item.status}"/></c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td><c:choose><c:when test="${not empty item.verifiedAtDate}"><fmt:formatDate value="${item.verifiedAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/></c:when><c:otherwise>-</c:otherwise></c:choose></td>
                        <td><c:choose><c:when test="${not empty item.appliedAtDate}"><fmt:formatDate value="${item.appliedAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/></c:when><c:otherwise>-</c:otherwise></c:choose></td>
                        <td><c:choose><c:when test="${not empty item.expiredAtDate}"><fmt:formatDate value="${item.expiredAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/></c:when><c:otherwise>-</c:otherwise></c:choose></td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.ipAddress}">
                                    <div>
                                        <button type="button"
                                                class="adm-inline-link js-open-ip-context"
                                                data-ip-address="${item.ipAddress}"
                                                data-default-tab="emailRequests"
                                                style="color:#93c5fd;"><c:out value="${item.ipAddress}"/></button>
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
                        <td style="font-size:12px;color:#64748b;">
                            <div><c:out value="${item.requestId}"/></div>
                            <div class="adm-inline-actions">
                                <button type="button"
                                        class="adm-inline-chip"
                                        data-keyword="${item.requestId}"
                                        onclick="applyKeywordFilter(this)">
                                    <spring:message code="admin.common.sameRequest"/>
                                </button>
                                <button type="button"
                                        class="adm-inline-chip"
                                        data-keyword="${empty item.flowTraceId ? item.requestId : item.flowTraceId}"
                                        onclick="openRelatedHistory('email-tokens', this)">
                                    <spring:message code="admin.common.sameFlow"/>
                                </button>
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
function goPage(page) {
  const params = new URLSearchParams(window.location.search);
  params.set('page', page);
  location.href = '${pageContext.request.contextPath}/admin/email-verifications?' + params.toString();
}
function applyKeywordFilter(button) {
  const keyword = button.dataset.keyword || '';
  const params = new URLSearchParams(window.location.search);
  params.set('keyword', keyword);
  params.set('page', '1');
  location.href = '${pageContext.request.contextPath}/admin/email-verifications?' + params.toString();
}
function openRelatedHistory(path, button) {
  const params = new URLSearchParams();
  if (button.dataset.keyword) params.set('keyword', button.dataset.keyword);
  params.set('page', '1');
  location.href = '${pageContext.request.contextPath}/admin/' + path + '?' + params.toString();
}
</script>
<%@ include file="../layout-close.jsp" %>
