<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_10ef2e73a1" code="admin.inquiry.kpi.total"/>
<spring:message var="autoMsg_68443fa327" code="admin.inquiry.status.pending"/>
<spring:message var="autoMsg_51953987c6" code="admin.inquiry.status.inProgress"/>
<spring:message var="autoMsg_f964d8e05b" code="admin.inquiry.status.completed"/>
<spring:message var="autoMsg_893eae7d2a" code="admin.common.status"/>
<spring:message var="autoMsg_31e4d49179" code="admin.common.all"/>
<spring:message var="autoMsg_e35ae23152" code="admin.inquiry.status.userCompleted"/>
<spring:message var="autoMsg_e3d22557db" code="admin.inquiry.status.cancelled"/>
<spring:message var="autoMsg_69cd7f44dc" code="admin.inquiry.status.deleteRequested"/>
<spring:message var="autoMsg_5d3194d1c2" code="admin.inquiry.status.privateRequested"/>
<spring:message var="autoMsg_f8f2e9dd51" code="admin.inquiry.status.publicRequested"/>
<spring:message var="autoMsg_7cad0c2705" code="admin.inquiry.category"/>
<spring:message var="autoMsg_9dbf4c09ea" code="admin.inquiry.category.service"/>
<spring:message var="autoMsg_99530daba4" code="admin.inquiry.category.payment"/>
<spring:message var="autoMsg_55420894f6" code="admin.inquiry.category.account"/>
<spring:message var="autoMsg_89603fd98e" code="admin.inquiry.category.bug"/>
<spring:message var="autoMsg_cfc25a605b" code="admin.inquiry.category.etc"/>
<spring:message var="autoMsg_64812f61b4" code="admin.inquiry.answerState"/>
<spring:message var="autoMsg_aa8ef17f67" code="admin.inquiry.answered"/>
<spring:message var="autoMsg_3e58d0bc59" code="admin.inquiry.unanswered"/>
<spring:message var="autoMsg_9b1c225216" code="admin.common.search"/>
<spring:message var="autoMsg_3f412cd5d1" code="admin.inquiry.searchType.inquiryId"/>
<spring:message var="autoMsg_fadc756dc4" code="admin.inquiry.searchType.title"/>
<spring:message var="autoMsg_0507906958" code="admin.inquiry.searchType.content"/>
<spring:message var="autoMsg_0376c0c4a5" code="admin.inquiry.searchType.nickname"/>
<spring:message var="autoMsg_357d583bd4" code="admin.inquiry.searchType.userId"/>
<spring:message var="autoMsg_5e0ba80d68" code="admin.inquiry.searchPlaceholder"/>
<spring:message var="autoMsg_61f526c74b" code="admin.common.searchButton"/>
<spring:message var="autoMsg_f2fc4d43e5" code="admin.inquiry.listTitle"/>
<spring:message var="autoMsg_8518d6c6f8" code="admin.common.totalCount"/>
<spring:message var="autoMsg_17def5e57e" code="admin.inquiry.author"/>
<spring:message var="autoMsg_cf2a2526a1" code="admin.inquiry.title"/>
<spring:message var="autoMsg_35b1b39fff" code="admin.inquiry.answer"/>
<spring:message var="autoMsg_d03c07a2cd" code="admin.inquiry.createdAt"/>
<spring:message var="autoMsg_d2ebccafe3" code="admin.reports.accountBlocked"/>
<spring:message var="autoMsg_927f11b8df" code="admin.inquiry.privateFlag"/>
<spring:message var="autoMsg_3a3edb3a87" code="admin.common.sameCategory"/>
<spring:message var="autoMsg_3aae8cd133" code="admin.inquiry.detail.statusChange"/>
<spring:message var="autoMsg_60442c2722" code="admin.common.noResults"/>
<spring:message var="autoMsg_b56a3cfa51" code="admin.common.pageStatus"/>
<spring:message var="autoMsg_4be288ae7d" code="admin.inquiry.viewSite"/>
<c:set var="activeMenu" value="inquiries"/>
<spring:message code="admin.inquiry.pageTitle" var="adminInquiryPageTitle"/>
<spring:message code="admin.common.id" var="adminCommonId"/>
<c:set var="pageTitle" value="${adminInquiryPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 통계 카드 ── --%>
    <div class="adm-summary-grid">
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_10ef2e73a1}</div>
            <div class="adm-summary-value is-primary">${stats.totalInquiries}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_68443fa327}</div>
            <div class="adm-summary-value is-warning">${stats.pendingInquiries}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_51953987c6}</div>
            <div class="adm-summary-value is-accent">${stats.inProgressInquiries}</div>
        </div>
        <div class="adm-card adm-summary-card">
            <div class="adm-summary-label">${autoMsg_f964d8e05b}</div>
            <div class="adm-summary-value is-success">${stats.completedInquiries}</div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/inquiries">
                <div class="adm-filter-bar">
                    <div>
                        <div class="adm-filter-label">${autoMsg_893eae7d2a}</div>
                        <select class="adm-select" name="status">
                            <option value="ALL"              ${search.status=='ALL'?'selected':''}>${autoMsg_31e4d49179}</option>
                            <option value="PENDING"          ${search.status=='PENDING'?'selected':''}>${autoMsg_68443fa327}</option>
                            <option value="IN_PROGRESS"      ${search.status=='IN_PROGRESS'?'selected':''}>${autoMsg_51953987c6}</option>
                            <option value="COMPLETED"        ${search.status=='COMPLETED'?'selected':''}>${autoMsg_f964d8e05b}</option>
                            <option value="USER_COMPLETED"   ${search.status=='USER_COMPLETED'?'selected':''}>${autoMsg_e35ae23152}</option>
                            <option value="CANCELLED"        ${search.status=='CANCELLED'?'selected':''}>${autoMsg_e3d22557db}</option>
                            <option value="DELETE_REQUESTED" ${search.status=='DELETE_REQUESTED'?'selected':''}>${autoMsg_69cd7f44dc}</option>
                            <option value="PRIVATE_REQUESTED"${search.status=='PRIVATE_REQUESTED'?'selected':''}>${autoMsg_5d3194d1c2}</option>
                            <option value="PUBLIC_REQUESTED" ${search.status=='PUBLIC_REQUESTED'?'selected':''}>${autoMsg_f8f2e9dd51}</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">${autoMsg_7cad0c2705}</div>
                        <select class="adm-select" name="category">
                            <option value="ALL" ${search.category=='ALL'?'selected':''}>${autoMsg_31e4d49179}</option>
                            <option value="service" ${search.category=='service'?'selected':''}>${autoMsg_9dbf4c09ea}</option>
                            <option value="payment" ${search.category=='payment'?'selected':''}>${autoMsg_99530daba4}</option>
                            <option value="account" ${search.category=='account'?'selected':''}>${autoMsg_55420894f6}</option>
                            <option value="bug" ${search.category=='bug'?'selected':''}>${autoMsg_89603fd98e}</option>
                            <option value="etc" ${search.category=='etc'?'selected':''}>${autoMsg_cfc25a605b}</option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label">${autoMsg_64812f61b4}</div>
                        <select class="adm-select" name="answered">
                            <option value="ALL" ${search.answered=='ALL'?'selected':''}>${autoMsg_31e4d49179}</option>
                            <option value="ANSWERED" ${search.answered=='ANSWERED'?'selected':''}>${autoMsg_aa8ef17f67}</option>
                            <option value="UNANSWERED" ${search.answered=='UNANSWERED'?'selected':''}>${autoMsg_3e58d0bc59}</option>
                        </select>
                    </div>

                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label">${autoMsg_9b1c225216}</div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:110px;">
                                <option value="all" ${search.searchType=='all'?'selected':''}>${autoMsg_31e4d49179}</option>
                                <option value="inquiryId" ${search.searchType=='inquiryId'?'selected':''}>${autoMsg_3f412cd5d1}</option>
                                <option value="title" ${search.searchType=='title'?'selected':''}>${autoMsg_fadc756dc4}</option>
                                <option value="content" ${search.searchType=='content'?'selected':''}>${autoMsg_0507906958}</option>
                                <option value="nickname" ${search.searchType=='nickname'?'selected':''}>${autoMsg_0376c0c4a5}</option>
                                <option value="userId" ${search.searchType=='userId'?'selected':''}>${autoMsg_357d583bd4}</option>
                            </select>
                            <div class="adm-search-box" style="flex:1;">
                                <span class="adm-search-ico">🔍</span>
                                <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="${autoMsg_5e0ba80d68}">
                            </div>
                        </div>
                    </div>

                    <button class="adm-btn adm-btn-primary" type="submit">${autoMsg_61f526c74b}</button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title">${autoMsg_f2fc4d43e5}</div>
            <div style="font-size:12px;color:#64748b;">${autoMsg_8518d6c6f8}</div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th>${adminCommonId}</th>
                    <th>${autoMsg_17def5e57e}</th>
                    <th>${autoMsg_cf2a2526a1}</th>
                    <th>${autoMsg_7cad0c2705}</th>
                    <th>${autoMsg_893eae7d2a}</th>
                    <th>${autoMsg_35b1b39fff}</th>
                    <th>${autoMsg_d03c07a2cd}</th>
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
                                    <span class="adm-cell-link-note" style="color:#fca5a5;">${autoMsg_d2ebccafe3}</span>
                                </c:if>
                            </button>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/inquiries/${item.inquiryId}?${fn:escapeXml(listParams)}"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <span class="mem-name">${item.title}</span>
                                <span class="adm-cell-link-note">
                                    <c:if test="${item.privateFlag}">🔒 ${autoMsg_927f11b8df} · </c:if>
                                    <spring:message code="admin.inquiry.viewCount" arguments="${item.viewCount}"/>
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
                                        <c:when test="${item.category eq 'service'}">${autoMsg_9dbf4c09ea}</c:when>
                                        <c:when test="${item.category eq 'payment'}">${autoMsg_99530daba4}</c:when>
                                        <c:when test="${item.category eq 'account'}">${autoMsg_55420894f6}</c:when>
                                        <c:when test="${item.category eq 'bug'}">${autoMsg_89603fd98e}</c:when>
                                        <c:otherwise>${autoMsg_cfc25a605b}</c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-cell-link-note">${autoMsg_3a3edb3a87}</span>
                            </button>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/inquiries/${item.inquiryId}?${fn:escapeXml(listParams)}&jump=inquiry-status-actions"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <span class="status-badge ${item.status}">
                                    <c:choose>
                                        <c:when test="${item.status eq 'PENDING'}">${autoMsg_68443fa327}</c:when>
                                        <c:when test="${item.status eq 'IN_PROGRESS'}">${autoMsg_51953987c6}</c:when>
                                        <c:when test="${item.status eq 'COMPLETED'}">${autoMsg_f964d8e05b}</c:when>
                                        <c:when test="${item.status eq 'USER_COMPLETED'}">${autoMsg_e35ae23152}</c:when>
                                        <c:when test="${item.status eq 'CANCELLED'}">${autoMsg_e3d22557db}</c:when>
                                        <c:when test="${item.status eq 'DELETE_REQUESTED'}">${autoMsg_69cd7f44dc}</c:when>
                                        <c:when test="${item.status eq 'PRIVATE_REQUESTED'}">${autoMsg_5d3194d1c2}</c:when>
                                        <c:when test="${item.status eq 'PUBLIC_REQUESTED'}">${autoMsg_f8f2e9dd51}</c:when>
                                        <c:otherwise>${item.status}</c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="adm-cell-link-note">${autoMsg_3aae8cd133}</span>
                            </a>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/inquiries/${item.inquiryId}?${fn:escapeXml(listParams)}&jump=inquiry-answer-card"
                               class="adm-cell-link"
                               onclick="event.stopPropagation();">
                                <c:choose>
                                    <c:when test="${not empty item.answerId}">
                                        <span class="mem-name">${autoMsg_aa8ef17f67}</span>
                                        <span class="adm-cell-link-note">${item.answerAdminNickname}</span>
                                    </c:when>
                                    <c:otherwise><span style="color:#64748b;">${autoMsg_3e58d0bc59}</span></c:otherwise>
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
                    <tr><td colspan="7" style="text-align:center;padding:40px;color:#475569;">${autoMsg_60442c2722}</td></tr>
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
                <span class="adm-page-info">${autoMsg_b56a3cfa51}</span>
            </div>
        </c:if>
    </div>

    <%-- ── 유저 화면 바로가기 ── --%>
    <div style="margin-top:16px;padding:0 10px;">
        <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/inquiry/list" target="_blank">
            <span class="adm-nav-icon">↗️</span> ${autoMsg_4be288ae7d}
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
