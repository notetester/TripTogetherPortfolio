<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_inquiry_searchPlaceholder" code="admin.inquiry.searchPlaceholder"/>
<spring:message var="msg_admin_inquiry_pageTitle" code="admin.inquiry.pageTitle"/>
<spring:message var="msg_admin_common_id" code="admin.common.id"/>
<spring:message var="msg_admin_inquiry_kpi_total" code="admin.inquiry.kpi.total"/>
<spring:message var="msg_admin_inquiry_status_pending" code="admin.inquiry.status.pending"/>
<spring:message var="msg_admin_inquiry_status_inProgress" code="admin.inquiry.status.inProgress"/>
<spring:message var="msg_admin_inquiry_status_completed" code="admin.inquiry.status.completed"/>
<spring:message var="msg_admin_common_status" code="admin.common.status"/>
<spring:message var="msg_admin_common_all" code="admin.common.all"/>
<spring:message var="msg_admin_inquiry_status_userCompleted" code="admin.inquiry.status.userCompleted"/>
<spring:message var="msg_admin_inquiry_status_cancelled" code="admin.inquiry.status.cancelled"/>
<spring:message var="msg_admin_inquiry_status_deleteRequested" code="admin.inquiry.status.deleteRequested"/>
<spring:message var="msg_admin_inquiry_status_privateRequested" code="admin.inquiry.status.privateRequested"/>
<spring:message var="msg_admin_inquiry_status_publicRequested" code="admin.inquiry.status.publicRequested"/>
<spring:message var="msg_admin_inquiry_category" code="admin.inquiry.category"/>
<spring:message var="msg_admin_inquiry_category_service" code="admin.inquiry.category.service"/>
<spring:message var="msg_admin_inquiry_category_payment" code="admin.inquiry.category.payment"/>
<spring:message var="msg_admin_inquiry_category_account" code="admin.inquiry.category.account"/>
<spring:message var="msg_admin_inquiry_category_bug" code="admin.inquiry.category.bug"/>
<spring:message var="msg_admin_inquiry_category_etc" code="admin.inquiry.category.etc"/>
<spring:message var="msg_admin_inquiry_answerState" code="admin.inquiry.answerState"/>
<spring:message var="msg_admin_inquiry_answered" code="admin.inquiry.answered"/>
<spring:message var="msg_admin_inquiry_unanswered" code="admin.inquiry.unanswered"/>
<spring:message var="msg_admin_common_search" code="admin.common.search"/>
<spring:message var="msg_admin_inquiry_searchType_inquiryId" code="admin.inquiry.searchType.inquiryId"/>
<spring:message var="msg_admin_inquiry_searchType_title" code="admin.inquiry.searchType.title"/>
<spring:message var="msg_admin_inquiry_searchType_content" code="admin.inquiry.searchType.content"/>
<spring:message var="msg_admin_inquiry_searchType_nickname" code="admin.inquiry.searchType.nickname"/>
<spring:message var="msg_admin_inquiry_searchType_userId" code="admin.inquiry.searchType.userId"/>
<spring:message var="msg_admin_common_searchButton" code="admin.common.searchButton"/>
<spring:message var="msg_admin_inquiry_listTitle" code="admin.inquiry.listTitle"/>
<spring:message var="msg_admin_common_totalCount" code="admin.common.totalCount"/>
<spring:message var="msg_admin_inquiry_author" code="admin.inquiry.author"/>
<spring:message var="msg_admin_inquiry_title" code="admin.inquiry.title"/>
<spring:message var="msg_admin_inquiry_answer" code="admin.inquiry.answer"/>
<spring:message var="msg_admin_inquiry_createdAt" code="admin.inquiry.createdAt"/>
<spring:message var="msg_admin_reports_accountBlocked" code="admin.reports.accountBlocked"/>
<spring:message var="msg_admin_inquiry_privateFlag" code="admin.inquiry.privateFlag"/>
<spring:message var="msg_admin_common_sameCategory" code="admin.common.sameCategory"/>
<spring:message var="msg_admin_inquiry_detail_statusChange" code="admin.inquiry.detail.statusChange"/>
<spring:message var="msg_admin_common_noResults" code="admin.common.noResults"/>
<spring:message var="msg_admin_common_pageStatus" code="admin.common.pageStatus"/>
<spring:message var="msg_admin_inquiry_viewSite" code="admin.inquiry.viewSite"/>
<c:set var="activeMenu" value="inquiries"/>


<c:set var="pageTitle" value="${msg_admin_inquiry_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_inquiry_kpi_total}</div>
            <div class="adm-summary-value is-primary">${stats.totalInquiries}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_inquiry_status_pending}</div>
            <div class="adm-summary-value is-warning">${stats.pendingInquiries}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_inquiry_status_inProgress}</div>
            <div class="adm-summary-value is-accent">${stats.inProgressInquiries}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${msg_admin_inquiry_status_completed}</div>
            <div class="adm-summary-value is-success">${stats.completedInquiries}</div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/inquiries">
                <div class="adm-filter-bar">
                    <div>
                        <div class="adm-filter-label">${msg_admin_common_status}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL"              ${search.status=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="PENDING"          ${search.status=='PENDING'?'selected':''}>${msg_admin_inquiry_status_pending}</option>
                            <option value="IN_PROGRESS"      ${search.status=='IN_PROGRESS'?'selected':''}>${msg_admin_inquiry_status_inProgress}</option>
                            <option value="COMPLETED"        ${search.status=='COMPLETED'?'selected':''}>${msg_admin_inquiry_status_completed}</option>
                            <option value="USER_COMPLETED"   ${search.status=='USER_COMPLETED'?'selected':''}>${msg_admin_inquiry_status_userCompleted}</option>
                            <option value="CANCELLED"        ${search.status=='CANCELLED'?'selected':''}>${msg_admin_inquiry_status_cancelled}</option>
                            <option value="DELETE_REQUESTED" ${search.status=='DELETE_REQUESTED'?'selected':''}>${msg_admin_inquiry_status_deleteRequested}</option>
                            <option value="PRIVATE_REQUESTED"${search.status=='PRIVATE_REQUESTED'?'selected':''}>${msg_admin_inquiry_status_privateRequested}</option>
                            <option value="PUBLIC_REQUESTED" ${search.status=='PUBLIC_REQUESTED'?'selected':''}>${msg_admin_inquiry_status_publicRequested}</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">${msg_admin_inquiry_category}</div>
                        <select class="adm-select" name="category">
                            <option value="ALL" ${search.category=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="service" ${search.category=='service'?'selected':''}>${msg_admin_inquiry_category_service}</option>
                            <option value="payment" ${search.category=='payment'?'selected':''}>${msg_admin_inquiry_category_payment}</option>
                            <option value="account" ${search.category=='account'?'selected':''}>${msg_admin_inquiry_category_account}</option>
                            <option value="bug" ${search.category=='bug'?'selected':''}>${msg_admin_inquiry_category_bug}</option>
                            <option value="etc" ${search.category=='etc'?'selected':''}>${msg_admin_inquiry_category_etc}</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">${msg_admin_inquiry_answerState}</div>
                        <select class="adm-select" name="answered">
                            <option value="ALL" ${search.answered=='ALL'?'selected':''}>${msg_admin_common_all}</option>
                            <option value="ANSWERED" ${search.answered=='ANSWERED'?'selected':''}>${msg_admin_inquiry_answered}</option>
                            <option value="UNANSWERED" ${search.answered=='UNANSWERED'?'selected':''}>${msg_admin_inquiry_unanswered}</option>
                        </select>
                    </div>

                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">${msg_admin_common_search}</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:110px;">
                                <option value="all" ${search.searchType=='all'?'selected':''}>${msg_admin_common_all}</option>
                                <option value="inquiryId" ${search.searchType=='inquiryId'?'selected':''}>${msg_admin_inquiry_searchType_inquiryId}</option>
                                <option value="title" ${search.searchType=='title'?'selected':''}>${msg_admin_inquiry_searchType_title}</option>
                                <option value="content" ${search.searchType=='content'?'selected':''}>${msg_admin_inquiry_searchType_content}</option>
                                <option value="nickname" ${search.searchType=='nickname'?'selected':''}>${msg_admin_inquiry_searchType_nickname}</option>
                                <option value="userId" ${search.searchType=='userId'?'selected':''}>${msg_admin_inquiry_searchType_userId}</option>
                            </select>
                            <div class="adm-search-box" style="flex:1;">
                                <span class="adm-search-ico">🔍</span>
                                <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="${msg_admin_inquiry_searchPlaceholder}">
                            </div>
                        </div>
                    </div>

                    <button class="adm-btn adm-btn-primary" type="submit">${msg_admin_common_searchButton}</button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${msg_admin_inquiry_listTitle}</div>
            <div style="font-size:12px;color:#64748b;">${msg_admin_common_totalCount}</div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th>${msg_admin_common_id}</th>
                    <th>${msg_admin_inquiry_author}</th>
                    <th>${msg_admin_inquiry_title}</th>
                    <th>${msg_admin_inquiry_category}</th>
                    <th>${msg_admin_common_status}</th>
                    <th>${msg_admin_inquiry_answer}</th>
                    <th>${msg_admin_inquiry_createdAt}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr class="adm-inq-row" data-id="${item.inquiryId}" style="cursor:pointer;">
                        <td>#${item.inquiryId}</td>
                        <%-- 작성자 --%>
                        <td>
                            <button type="button"
                                    class="adm-cell-link js-open-member-context"
                                    data-user-idx="${item.userIdx}"
                                    onclick="event.stopPropagation();">
                                <span style="font-weight:700;color:#93c5fd;">${item.nickname}</span>
                                <span class="adm-cell-link-note">@${item.userId}</span>
                                <c:if test="${item.accountStatus == 'BLOCKED'}">
                                    <span class="adm-cell-link-note" style="color:#fca5a5;">${msg_admin_reports_accountBlocked}</span>
                                </c:if>
                            </button>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/inquiries/${item.inquiryId}?${fn:escapeXml(listParams)}"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <span class="mem-name">${item.title}</span>
                                <span class="adm-cell-link-note">
                                    <c:if test="${item.privateFlag}">🔒 ${msg_admin_inquiry_privateFlag} · </c:if>
                                    <spring:message var="msg_admin_inquiry_viewCount_args_item_viewCount" code="admin.inquiry.viewCount" arguments="${item.viewCount}"/>${msg_admin_inquiry_viewCount_args_item_viewCount}
                                </span>
                            </a>
                        </td>
                        <td>
                            <button type="button"
                                    class="adm-cell-link"
                                    data-category="${item.category}"
                                    onclick="event.stopPropagation(); applyInquiryFilter(this);">
                                <span>
                                    <c:choose>
                                        <c:when test="${item.category eq 'service'}">${msg_admin_inquiry_category_service}</c:when>
                                        <c:when test="${item.category eq 'payment'}">${msg_admin_inquiry_category_payment}</c:when>
                                        <c:when test="${item.category eq 'account'}">${msg_admin_inquiry_category_account}</c:when>
                                        <c:when test="${item.category eq 'bug'}">${msg_admin_inquiry_category_bug}</c:when>
                                        <c:otherwise>${msg_admin_inquiry_category_etc}</c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-cell-link-note">${msg_admin_common_sameCategory}</span>
                            </button>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/inquiries/${item.inquiryId}?${fn:escapeXml(listParams)}&jump=inquiry-status-actions"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <span class="status-badge ${item.status}">
                                    <c:choose>
                                        <c:when test="${item.status eq 'PENDING'}">${msg_admin_inquiry_status_pending}</c:when>
                                        <c:when test="${item.status eq 'IN_PROGRESS'}">${msg_admin_inquiry_status_inProgress}</c:when>
                                        <c:when test="${item.status eq 'COMPLETED'}">${msg_admin_inquiry_status_completed}</c:when>
                                        <c:when test="${item.status eq 'USER_COMPLETED'}">${msg_admin_inquiry_status_userCompleted}</c:when>
                                        <c:when test="${item.status eq 'CANCELLED'}">${msg_admin_inquiry_status_cancelled}</c:when>
                                        <c:when test="${item.status eq 'DELETE_REQUESTED'}">${msg_admin_inquiry_status_deleteRequested}</c:when>
                                        <c:when test="${item.status eq 'PRIVATE_REQUESTED'}">${msg_admin_inquiry_status_privateRequested}</c:when>
                                        <c:when test="${item.status eq 'PUBLIC_REQUESTED'}">${msg_admin_inquiry_status_publicRequested}</c:when>
                                        <c:otherwise>${item.status}</c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-cell-link-note">${msg_admin_inquiry_detail_statusChange}</span>
                            </a>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/inquiries/${item.inquiryId}?${fn:escapeXml(listParams)}&jump=inquiry-answer-card"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <c:choose>
                                    <c:when test="${not empty item.answerId}">
                                        <span class="mem-name">${msg_admin_inquiry_answered}</span>
                                        <span class="adm-cell-link-note">${item.answerAdminNickname}</span>
                                    </c:when>
                                    <c:otherwise><span style="color:#64748b;">${msg_admin_inquiry_unanswered}</span></c:otherwise>
                                </c:choose>
                            </a>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/inquiries/${item.inquiryId}?${fn:escapeXml(listParams)}"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <span><fmt:formatDate value="${item.createdAtDate}" type="both" dateStyle="short" timeStyle="short"/></span>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="7" style="text-align:center;padding:40px;color:#475569;">${msg_admin_common_noResults}</td></tr>
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
                <span class="adm-page-info">${msg_admin_common_pageStatus}</span>
            </div>
        </c:if>
    </div>

    <%-- ── 유저 화면 바로가기 ── --%>
    <div style="margin-top:16px;padding:0 10px;">
        <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/inquiry/list" target="_blank">
            <span class="adm-nav-icon">↗️</span> ${msg_admin_inquiry_viewSite}
        </a>
    </div>
</div>

<script>
function goPage(page) {
    const params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = '${pageContext.request.contextPath}/admin/inquiries?' + params.toString();
}

function applyInquiryFilter(button) {
    const params = new URLSearchParams(window.location.search);
    params.set('page', '1');

    if (button.dataset.category !== undefined) {
        if (button.dataset.category) params.set('category', button.dataset.category);
        else params.delete('category');
        params.delete('searchType');
        params.delete('keyword');
    }

    if (button.dataset.searchType !== undefined) {
        if (button.dataset.searchType) params.set('searchType', button.dataset.searchType);
        else params.delete('searchType');
    }

    if (button.dataset.keyword !== undefined) {
        if (button.dataset.keyword) params.set('keyword', button.dataset.keyword);
        else params.delete('keyword');
    }

    location.href = '${pageContext.request.contextPath}/admin/inquiries?' + params.toString();
}

var ctx = '${pageContext.request.contextPath}';

// 행 클릭 시 어드민 문의 상세 페이지 이동
var listParams = 'page=${search.page}&status=${search.status}&category=${search.category}&answered=${search.answered}&searchType=${search.searchType}&keyword=' + encodeURIComponent('${search.keyword}');
document.querySelectorAll('.adm-inq-row[data-id]').forEach(function (tr) {
    tr.addEventListener('click', function (e) {
        if (e.target.closest('button, a')) return;
        location.href = '${pageContext.request.contextPath}/admin/inquiries/' + this.getAttribute('data-id') + '?' + listParams;
    });
});
</script>

<%@ include file="../layout-close.jsp" %>
