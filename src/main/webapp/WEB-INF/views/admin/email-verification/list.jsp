<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_a2f5c5ab35" code="admin.common.search"/>
<spring:message var="autoMsg_a22208483c" code="admin.emailRequests.searchPlaceholder"/>
<spring:message var="autoMsg_ccff41e706" code="admin.emailRequests.purpose"/>
<spring:message var="autoMsg_3632b98ad4" code="admin.common.all"/>
<spring:message var="autoMsg_194f4c73a6" code="admin.emailRequests.purpose.profileEmail"/>
<spring:message var="autoMsg_4dc0671620" code="admin.emailRequests.purpose.findId"/>
<spring:message var="autoMsg_ada0fde9fd" code="admin.emailRequests.purpose.resetPw"/>
<spring:message var="autoMsg_907209bab9" code="admin.emailRequests.purpose.verify"/>
<spring:message var="autoMsg_da67a6473d" code="admin.common.status"/>
<spring:message var="autoMsg_e894ead4f4" code="admin.emailRequests.status.requested"/>
<spring:message var="autoMsg_85827f86c1" code="admin.emailRequests.status.verified"/>
<spring:message var="autoMsg_9d2db72e75" code="admin.emailRequests.status.applied"/>
<spring:message var="autoMsg_83c6d27440" code="admin.emailRequests.status.expired"/>
<spring:message var="autoMsg_b5098ff9c0" code="admin.emailRequests.status.cancelled"/>
<spring:message var="autoMsg_8db61b7eec" code="admin.common.searchButton"/>
<spring:message var="autoMsg_509ab4470c" code="admin.common.reset"/>
<spring:message var="autoMsg_ae847fda2c" code="admin.emailRequests.historyTitle"/>
<spring:message var="autoMsg_da413d3280" code="admin.common.totalCount"/>
<spring:message var="autoMsg_993b398649" code="admin.emailRequests.requestedAt"/>
<spring:message var="autoMsg_e7842b3e88" code="admin.common.member"/>
<spring:message var="autoMsg_8ece2719e2" code="admin.context.requestEmail"/>
<spring:message var="autoMsg_472f3f6555" code="admin.emailRequests.verifiedAt"/>
<spring:message var="autoMsg_ca0232122e" code="admin.emailRequests.appliedAt"/>
<spring:message var="autoMsg_61d3c126ed" code="admin.context.expiresAt"/>
<spring:message var="autoMsg_3d653816d3" code="admin.common.ip"/>
<spring:message var="autoMsg_a069dca5bf" code="admin.context.requestId"/>
<spring:message var="autoMsg_903e88c9dd" code="admin.common.sameDate"/>
<spring:message var="autoMsg_e99f68c7db" code="admin.emailRequests.unknownRequest"/>
<spring:message var="autoMsg_f77a805140" code="admin.common.sameValue"/>
<spring:message var="autoMsg_cd8d8b4c4f" code="admin.common.sameEmail"/>
<spring:message var="autoMsg_328d6f9bec" code="admin.common.sameIp"/>
<spring:message var="autoMsg_02ef6dfc54" code="admin.common.trace"/>
<spring:message var="autoMsg_97c8d67e97" code="admin.common.noResults"/>
<spring:message var="autoMsg_62aa1ae2c7" code="admin.common.pageStatus"/>
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
                        <div class="adm-filter-label">${autoMsg_a2f5c5ab35}</div>
                        <span class="adm-search-ico">🔍</span>
                        <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="${autoMsg_a22208483c}">
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_ccff41e706}</div>
                        <select class="adm-select" name="purpose">
                            <option value="ALL" ${search.purpose=='ALL'?'selected':''}>${autoMsg_3632b98ad4}</option>
                            <option value="PROFILE_EMAIL" ${search.purpose=='PROFILE_EMAIL'?'selected':''}>${autoMsg_194f4c73a6}</option>
                            <option value="FIND_ID" ${search.purpose=='FIND_ID'?'selected':''}>${autoMsg_4dc0671620}</option>
                            <option value="RESET_PW" ${search.purpose=='RESET_PW'?'selected':''}>${autoMsg_ada0fde9fd}</option>
                            <option value="VERIFY" ${search.purpose=='VERIFY'?'selected':''}>${autoMsg_907209bab9}</option>
                        </select>
                    </div>
                    <div>
                        <div class="adm-filter-label">${autoMsg_da67a6473d}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL" ${search.status=='ALL'?'selected':''}>${autoMsg_3632b98ad4}</option>
                            <option value="REQUESTED" ${search.status=='REQUESTED'?'selected':''}>${autoMsg_e894ead4f4}</option>
                            <option value="VERIFIED" ${search.status=='VERIFIED'?'selected':''}>${autoMsg_85827f86c1}</option>
                            <option value="APPLIED" ${search.status=='APPLIED'?'selected':''}>${autoMsg_9d2db72e75}</option>
                            <option value="EXPIRED" ${search.status=='EXPIRED'?'selected':''}>${autoMsg_83c6d27440}</option>
                            <option value="CANCELLED" ${search.status=='CANCELLED'?'selected':''}>${autoMsg_b5098ff9c0}</option>
                        </select>
                    </div>
                    <div style="display:flex;align-items:flex-end;gap:8px;">
                        <button class="adm-btn adm-btn-primary" type="submit">${autoMsg_8db61b7eec}</button>
                        <a class="adm-btn adm-btn-ghost" href="${pageContext.request.contextPath}/admin/email-verifications">${autoMsg_509ab4470c}</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${autoMsg_ae847fda2c}</div>
            <div style="font-size:12px;color:#64748b;">${autoMsg_da413d3280}</div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th data-sort="time" onclick="sortBy('time')">${autoMsg_993b398649}<span class="sort-ico">▼</span></th>
                    <th data-sort="member" onclick="sortBy('member')">${autoMsg_e7842b3e88}<span class="sort-ico">▼</span></th>
                    <th data-sort="purpose" onclick="sortBy('purpose')">${autoMsg_ccff41e706}<span class="sort-ico">▼</span></th>
                    <th data-sort="requestEmail" onclick="sortBy('requestEmail')">${autoMsg_8ece2719e2}<span class="sort-ico">▼</span></th>
                    <th data-sort="status" onclick="sortBy('status')">${autoMsg_da67a6473d}<span class="sort-ico">▼</span></th>
                    <th data-sort="verifiedAt" onclick="sortBy('verifiedAt')">${autoMsg_472f3f6555}<span class="sort-ico">▼</span></th>
                    <th data-sort="appliedAt" onclick="sortBy('appliedAt')">${autoMsg_ca0232122e}<span class="sort-ico">▼</span></th>
                    <th data-sort="expiresAt" onclick="sortBy('expiresAt')">${autoMsg_61d3c126ed}<span class="sort-ico">▼</span></th>
                    <th data-sort="ip" onclick="sortBy('ip')">${autoMsg_3d653816d3}<span class="sort-ico">▼</span></th>
                    <th data-sort="requestId" onclick="sortBy('requestId')">${autoMsg_a069dca5bf}<span class="sort-ico">▼</span></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <fmt:formatDate var="itemDateFilter" value="${item.requestedAtDate}" pattern="yyyy-MM-dd"/>
                    <fmt:formatDate var="itemTimeDisplay" value="${item.requestedAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
                    <fmt:formatDate var="itemVerifiedAtDisplay" value="${item.verifiedAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
                    <fmt:formatDate var="itemVerifiedAtFilter" value="${item.verifiedAtDate}" pattern="yyyy-MM-dd"/>
                    <fmt:formatDate var="itemAppliedAtDisplay" value="${item.appliedAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
                    <fmt:formatDate var="itemAppliedAtFilter" value="${item.appliedAtDate}" pattern="yyyy-MM-dd"/>
                    <fmt:formatDate var="itemExpiredAtDisplay" value="${item.expiredAtDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
                    <fmt:formatDate var="itemExpiredAtFilter" value="${item.expiredAtDate}" pattern="yyyy-MM-dd"/>
                    <tr>
                        <td>
                            <button type="button" class="adm-cell-link"
                                    data-date="${itemDateFilter}"
                                    onclick="filterByDate(this.dataset.date)">
                                <span>${itemTimeDisplay}</span>
                                <span class="adm-cell-link-note">${autoMsg_903e88c9dd}</span>
                            </button>
                        </td>
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
                                    <div class="mem-name">${autoMsg_e99f68c7db}</div>
                                    <div class="mem-uid">-</div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="purpose" data-param-value="${item.purpose}" onclick="applySelectFilter(this)">
                                <span><c:choose>
                                    <c:when test="${item.purpose == 'PROFILE_EMAIL'}">${autoMsg_194f4c73a6}</c:when>
                                    <c:when test="${item.purpose == 'FIND_ID'}">${autoMsg_4dc0671620}</c:when>
                                    <c:when test="${item.purpose == 'RESET_PW'}">${autoMsg_ada0fde9fd}</c:when>
                                    <c:when test="${item.purpose == 'VERIFY'}">${autoMsg_907209bab9}</c:when>
                                    <c:otherwise><c:out value="${item.purpose}"/></c:otherwise>
                                </c:choose></span>
                                <span class="adm-cell-link-note">${autoMsg_f77a805140}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-keyword="${item.pendingEmail}" onclick="applyKeywordFilter(this)">
                                <span><c:out value="${item.pendingEmail}"/></span>
                                <span class="adm-cell-link-note">${autoMsg_cd8d8b4c4f}</span>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-cell-link" data-param-name="status" data-param-value="${item.status}" onclick="applySelectFilter(this)">
                                <span class="status-badge ${item.status}">
                                    <c:choose>
                                        <c:when test="${item.status == 'REQUESTED'}">${autoMsg_e894ead4f4}</c:when>
                                        <c:when test="${item.status == 'VERIFIED'}">${autoMsg_85827f86c1}</c:when>
                                        <c:when test="${item.status == 'APPLIED'}">${autoMsg_9d2db72e75}</c:when>
                                        <c:when test="${item.status == 'EXPIRED'}">${autoMsg_83c6d27440}</c:when>
                                        <c:when test="${item.status == 'CANCELLED'}">${autoMsg_b5098ff9c0}</c:when>
                                        <c:otherwise><c:out value="${item.status}"/></c:otherwise>
                                    </c:choose>
                                </span>
                            </button>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.verifiedAtDate}">
                                    <button type="button" class="adm-cell-link"
                                            data-date="${itemVerifiedAtFilter}"
                                            onclick="filterByDate(this.dataset.date)">
                                        <span>${itemVerifiedAtDisplay}</span>
                                        <span class="adm-cell-link-note">${autoMsg_903e88c9dd}</span>
                                    </button>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.appliedAtDate}">
                                    <button type="button" class="adm-cell-link"
                                            data-date="${itemAppliedAtFilter}"
                                            onclick="filterByDate(this.dataset.date)">
                                        <span>${itemAppliedAtDisplay}</span>
                                        <span class="adm-cell-link-note">${autoMsg_903e88c9dd}</span>
                                    </button>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.expiredAtDate}">
                                    <button type="button" class="adm-cell-link"
                                            data-date="${itemExpiredAtFilter}"
                                            onclick="filterByDate(this.dataset.date)">
                                        <span>${itemExpiredAtDisplay}</span>
                                        <span class="adm-cell-link-note">${autoMsg_903e88c9dd}</span>
                                    </button>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.ipAddress}">
                                    <button type="button"
                                            class="adm-cell-link js-open-ip-context"
                                            data-ip-address="${item.ipAddress}"
                                            data-default-tab="emailRequests">
                                        <span style="color:#93c5fd;"><c:out value="${item.ipAddress}"/></span>
                                        <span class="adm-cell-link-note">${autoMsg_328d6f9bec}</span>
                                    </button>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link"
                                    data-keyword="${empty item.flowTraceId ? item.requestId : item.flowTraceId}"
                                    onclick="openRelatedHistory('email-tokens', this)">
                                <span style="font-size:12px;color:#64748b;"><c:out value="${item.requestId}"/></span>
                                <c:if test="${not empty item.flowTraceId}">
                                    <span class="adm-cell-link-note">${autoMsg_02ef6dfc54}: <c:out value="${item.flowTraceId}"/></span>
                                </c:if>
                            </button>
                        </td>
                        <td>
                            <button type="button" class="adm-row-btn detail"
                                    data-time="${itemTimeDisplay}"
                                    data-user="${fn:escapeXml(item.nickname)} (@${fn:escapeXml(item.userId)})"
                                    data-purpose="${fn:escapeXml(item.purpose)}"
                                    data-email="${fn:escapeXml(item.pendingEmail)}"
                                    data-status="${fn:escapeXml(item.status)}"
                                    data-verified-at="${itemVerifiedAtDisplay}"
                                    data-applied-at="${itemAppliedAtDisplay}"
                                    data-expires-at="${itemExpiredAtDisplay}"
                                    data-ip="${fn:escapeXml(item.ipAddress)}"
                                    data-request-id="${fn:escapeXml(item.requestId)}"
                                    data-flow-trace="${fn:escapeXml(item.flowTraceId)}"
                                    onclick="openVerificationDetail(this)">
                                <spring:message code="admin.common.viewDetail"/>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="11" style="text-align:center;padding:40px;color:#475569;">${autoMsg_97c8d67e97}</td></tr>
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
                <span class="adm-page-info">${autoMsg_62aa1ae2c7}</span>
            </div>
        </c:if>
    </div>
</div>

<div id="rowDetailModal" class="adm-modal-overlay" onclick="this.classList.remove('open')">
    <div class="adm-modal" style="max-width:560px;width:100%;" onclick="event.stopPropagation()">
        <div class="adm-modal-head">
            <div class="adm-modal-title" id="rowDetailModalTitle"></div>
            <button class="adm-modal-close" onclick="document.getElementById('rowDetailModal').classList.remove('open')">✕</button>
        </div>
        <div class="adm-modal-body" style="padding:20px 24px;max-height:72vh;overflow-y:auto;">
            <dl id="rowDetailModalContent" style="margin:0;"></dl>
        </div>
    </div>
</div>

<script>
var BASE_URL = '${pageContext.request.contextPath}/admin/email-verifications';
var curSortField = '${search.sortField}';
var curSortDir = '${search.sortDir}';

document.querySelectorAll('th[data-sort]').forEach(function(th) {
    if (th.getAttribute('data-sort') === curSortField) {
        th.classList.add('sorted');
        var ico = th.querySelector('.sort-ico');
        if (ico) ico.textContent = curSortDir === 'ASC' ? '▲' : '▼';
    }
});

function sortBy(field) {
    var params = new URLSearchParams(window.location.search);
    var dir = (params.get('sortField') === field && params.get('sortDir') !== 'ASC') ? 'ASC' : 'DESC';
    params.set('sortField', field); params.set('sortDir', dir); params.set('page', '1');
    location.href = BASE_URL + '?' + params.toString();
}
function filterByDate(dateStr) {
    var params = new URLSearchParams(window.location.search);
    params.set('dateFilter', dateStr); params.set('page', '1');
    location.href = BASE_URL + '?' + params.toString();
}
function applyKeywordFilter(button) {
    var keyword = button.getAttribute('data-keyword');
    if (!keyword) return;
    var params = new URLSearchParams(window.location.search);
    params.set('keyword', keyword); params.set('page', '1');
    location.href = BASE_URL + '?' + params.toString();
}
function applySelectFilter(button) {
    var paramName = button.getAttribute('data-param-name');
    var paramValue = button.getAttribute('data-param-value');
    if (!paramName || !paramValue) return;
    var params = new URLSearchParams(window.location.search);
    params.set(paramName, paramValue); params.set('page', '1');
    location.href = BASE_URL + '?' + params.toString();
}
function goPage(page) {
    var params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = BASE_URL + '?' + params.toString();
}
function openRelatedHistory(path, button) {
    var params = new URLSearchParams();
    if (button.dataset.keyword) params.set('keyword', button.dataset.keyword);
    params.set('page', '1');
    location.href = '${pageContext.request.contextPath}/admin/' + path + '?' + params.toString();
}
function openVerificationDetail(btn) {
    var d = btn.dataset;
    showRowDetail('${autoMsg_ae847fda2c}', [
        ['요청 시각', d.time],
        ['회원', d.user],
        ['목적', d.purpose],
        ['요청 이메일', d.email],
        ['상태', d.status],
        ['인증 시각', d.verifiedAt],
        ['반영 시각', d.appliedAt],
        ['만료 시각', d.expiresAt],
        ['IP', d.ip],
        ['요청 ID', d.requestId],
        ['흐름 추적 ID', d.flowTrace]
    ]);
}
function showRowDetail(title, fields) {
    var modal = document.getElementById('rowDetailModal');
    document.getElementById('rowDetailModalTitle').textContent = title;
    var content = document.getElementById('rowDetailModalContent');
    content.innerHTML = '';
    fields.forEach(function(pair) {
        var label = pair[0], value = pair[1];
        if (!value || value === '' || value === '-') return;
        var dt = document.createElement('dt');
        dt.style.cssText = 'font-size:11px;color:#64748b;margin-top:12px;margin-bottom:2px;font-weight:600;text-transform:uppercase;letter-spacing:.5px;';
        dt.textContent = label;
        var dd = document.createElement('dd');
        dd.style.cssText = 'font-size:13px;color:#e2e8f0;word-break:break-all;margin:0;padding:6px 10px;background:#0f1520;border-radius:4px;';
        dd.textContent = value;
        content.appendChild(dt);
        content.appendChild(dd);
    });
    modal.classList.add('open');
}
</script>
<%@ include file="../layout-close.jsp" %>
