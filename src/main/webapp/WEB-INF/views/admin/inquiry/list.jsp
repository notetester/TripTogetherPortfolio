<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="inquiries"/>
<spring:message code="admin.inquiry.pageTitle" var="adminInquiryPageTitle"/>
<spring:message code="admin.common.nickname" var="adminCommonNickname"/>
<spring:message code="admin.common.userId" var="adminCommonUserId"/>
<spring:message code="admin.common.accountStatus" var="adminCommonAccountStatus"/>
<spring:message code="admin.common.memberInfoView" var="adminCommonMemberInfoView"/>
<spring:message code="admin.common.blockAccount" var="adminCommonBlockAccount"/>
<spring:message code="admin.common.activeLabel" var="adminCommonActiveLabel"/>
<spring:message code="admin.common.blockedLabel" var="adminCommonBlockedLabel"/>
<spring:message code="admin.inquiry.authorInfoTitle" var="adminInquiryAuthorInfoTitle"/>
<spring:message code="admin.inquiry.confirmBlockUser" var="adminInquiryConfirmBlockUser"/>
<spring:message code="admin.inquiry.blockFailed" var="adminInquiryBlockFailed"/>
<c:set var="pageTitle" value="${adminInquiryPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">

    <%-- ── 통계 카드 ── --%>
    <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:20px;">
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;"><spring:message code="admin.inquiry.kpi.total"/></div>
            <div style="font-size:24px;font-weight:700;color:#38bdf8;">${stats.totalInquiries}</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;"><spring:message code="admin.inquiry.status.pending"/></div>
            <div style="font-size:24px;font-weight:700;color:#fbbf24;">${stats.pendingInquiries}</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;"><spring:message code="admin.inquiry.status.inProgress"/></div>
            <div style="font-size:24px;font-weight:700;color:#fb923c;">${stats.inProgressInquiries}</div>
        </div>
        <div class="adm-card" style="padding:20px;">
            <div style="font-size:12px;color:#64748b;margin-bottom:6px;"><spring:message code="admin.inquiry.status.completed"/></div>
            <div style="font-size:24px;font-weight:700;color:#34d399;">${stats.completedInquiries}</div>
        </div>
    </div>

    <div class="adm-card" style="margin-bottom:20px;">
        <div class="adm-card-body">
            <form method="get" action="${pageContext.request.contextPath}/admin/inquiries">
                <div class="adm-filter-bar">
                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.common.status"/></div>
                        <select class="adm-select" name="status">
                            <option value="ALL"              ${search.status=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="PENDING"          ${search.status=='PENDING'?'selected':''}><spring:message code="admin.inquiry.status.pending"/></option>
                            <option value="IN_PROGRESS"      ${search.status=='IN_PROGRESS'?'selected':''}><spring:message code="admin.inquiry.status.inProgress"/></option>
                            <option value="COMPLETED"        ${search.status=='COMPLETED'?'selected':''}><spring:message code="admin.inquiry.status.completed"/></option>
                            <option value="USER_COMPLETED"   ${search.status=='USER_COMPLETED'?'selected':''}><spring:message code="admin.inquiry.status.userCompleted"/></option>
                            <option value="CANCELLED"        ${search.status=='CANCELLED'?'selected':''}><spring:message code="admin.inquiry.status.cancelled"/></option>
                            <option value="DELETE_REQUESTED" ${search.status=='DELETE_REQUESTED'?'selected':''}><spring:message code="admin.inquiry.status.deleteRequested"/></option>
                            <option value="PRIVATE_REQUESTED"${search.status=='PRIVATE_REQUESTED'?'selected':''}><spring:message code="admin.inquiry.status.privateRequested"/></option>
                            <option value="PUBLIC_REQUESTED" ${search.status=='PUBLIC_REQUESTED'?'selected':''}><spring:message code="admin.inquiry.status.publicRequested"/></option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.inquiry.category"/></div>
                        <select class="adm-select" name="category">
                            <option value="ALL" ${search.category=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="service" ${search.category=='service'?'selected':''}><spring:message code="admin.inquiry.category.service"/></option>
                            <option value="payment" ${search.category=='payment'?'selected':''}><spring:message code="admin.inquiry.category.payment"/></option>
                            <option value="account" ${search.category=='account'?'selected':''}><spring:message code="admin.inquiry.category.account"/></option>
                            <option value="bug" ${search.category=='bug'?'selected':''}><spring:message code="admin.inquiry.category.bug"/></option>
                            <option value="etc" ${search.category=='etc'?'selected':''}><spring:message code="admin.inquiry.category.etc"/></option>
                        </select>
                    </div>

                    <div>
                        <div class="adm-filter-label"><spring:message code="admin.inquiry.answerState"/></div>
                        <select class="adm-select" name="answered">
                            <option value="ALL" ${search.answered=='ALL'?'selected':''}><spring:message code="admin.common.all"/></option>
                            <option value="ANSWERED" ${search.answered=='ANSWERED'?'selected':''}><spring:message code="admin.inquiry.answered"/></option>
                            <option value="UNANSWERED" ${search.answered=='UNANSWERED'?'selected':''}><spring:message code="admin.inquiry.unanswered"/></option>
                        </select>
                    </div>

                    <div style="flex:1;min-width:220px;">
                        <div class="adm-filter-label"><spring:message code="admin.common.search"/></div>
                        <div style="display:flex;gap:6px;">
                            <select class="adm-select" name="searchType" style="width:110px;">
                                <option value="all" ${search.searchType=='all'?'selected':''}><spring:message code="admin.common.all"/></option>
                                <option value="title" ${search.searchType=='title'?'selected':''}><spring:message code="admin.inquiry.searchType.title"/></option>
                                <option value="content" ${search.searchType=='content'?'selected':''}><spring:message code="admin.inquiry.searchType.content"/></option>
                                <option value="nickname" ${search.searchType=='nickname'?'selected':''}><spring:message code="admin.inquiry.searchType.nickname"/></option>
                            </select>
                            <div class="adm-search-box" style="flex:1;">
                                <span class="adm-search-ico">🔍</span>
                                <input class="adm-input" type="text" name="keyword" value="${search.keyword}" placeholder="<spring:message code='admin.inquiry.searchPlaceholder'/>">
                            </div>
                        </div>
                    </div>

                    <button class="adm-btn adm-btn-primary" type="submit"><spring:message code="admin.common.searchButton"/></button>
                </div>
            </form>
        </div>
    </div>

    <div class="adm-card">
        <div class="adm-card-head">
            <div class="adm-card-title"><spring:message code="admin.inquiry.listTitle"/></div>
            <div style="font-size:12px;color:#64748b;"><spring:message code="admin.common.totalCount" arguments="${total}"/></div>
        </div>
        <div class="adm-table-wrap">
            <table class="adm-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th><spring:message code="admin.inquiry.author"/></th>
                    <th><spring:message code="admin.inquiry.title"/></th>
                    <th><spring:message code="admin.inquiry.category"/></th>
                    <th><spring:message code="admin.common.status"/></th>
                    <th><spring:message code="admin.inquiry.answer"/></th>
                    <th><spring:message code="admin.inquiry.createdAt"/></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="item">
                    <tr class="adm-inq-row" data-id="${item.inquiryId}" style="cursor:pointer;">
                        <td>#${item.inquiryId}</td>
                        <%-- 작성자 --%>
                        <td style="cursor:pointer;"
                            data-useridx="${item.userIdx}"
                            data-userid="${item.userId}"
                            data-nickname="${item.nickname}"
                            data-status="${item.accountStatus}"
                            onclick="openAuthorModal(this)">
                            <div style="font-weight:600;font-size:13px;color:#7dd3fc;">${item.nickname}</div>
                            <div style="font-size:11px;color:#64748b;">${item.userId}</div>
                            <c:if test="${item.accountStatus == 'BLOCKED'}">
                                <span style="font-size:10px;background:#7f1d1d;color:#fca5a5;padding:1px 5px;border-radius:3px;"><spring:message code="admin.reports.accountBlocked"/></span>
                            </c:if>
                        </td>
                        <td>
                            <div class="mem-name">${item.title}</div>
                            <div class="mem-uid">
                                <c:if test="${item.privateFlag}">🔒 <spring:message code="admin.inquiry.privateFlag"/> · </c:if>
                                <spring:message code="admin.inquiry.viewCount" arguments="${item.viewCount}"/>
                            </div>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${item.category eq 'service'}"><spring:message code="admin.inquiry.category.service"/></c:when>
                                <c:when test="${item.category eq 'payment'}"><spring:message code="admin.inquiry.category.payment"/></c:when>
                                <c:when test="${item.category eq 'account'}"><spring:message code="admin.inquiry.category.account"/></c:when>
                                <c:when test="${item.category eq 'bug'}"><spring:message code="admin.inquiry.category.bug"/></c:when>
                                <c:otherwise><spring:message code="admin.inquiry.category.etc"/></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="status-badge ${item.status}">
                                <c:choose>
                                    <c:when test="${item.status eq 'PENDING'}"><spring:message code="admin.inquiry.status.pending"/></c:when>
                                    <c:when test="${item.status eq 'IN_PROGRESS'}"><spring:message code="admin.inquiry.status.inProgress"/></c:when>
                                    <c:when test="${item.status eq 'COMPLETED'}"><spring:message code="admin.inquiry.status.completed"/></c:when>
                                    <c:when test="${item.status eq 'USER_COMPLETED'}"><spring:message code="admin.inquiry.status.userCompleted"/></c:when>
                                    <c:when test="${item.status eq 'CANCELLED'}"><spring:message code="admin.inquiry.status.cancelled"/></c:when>
                                    <c:when test="${item.status eq 'DELETE_REQUESTED'}"><spring:message code="admin.inquiry.status.deleteRequested"/></c:when>
                                    <c:when test="${item.status eq 'PRIVATE_REQUESTED'}"><spring:message code="admin.inquiry.status.privateRequested"/></c:when>
                                    <c:when test="${item.status eq 'PUBLIC_REQUESTED'}"><spring:message code="admin.inquiry.status.publicRequested"/></c:when>
                                    <c:otherwise>${item.status}</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.answerId}">
                                    <div class="mem-name"><spring:message code="admin.inquiry.answered"/></div>
                                    <div class="mem-uid">${item.answerAdminNickname}</div>
                                </c:when>
                                <c:otherwise><span style="color:#64748b;"><spring:message code="admin.inquiry.unanswered"/></span></c:otherwise>
                            </c:choose>
                        </td>
                        <td><fmt:formatDate value="${item.createdAt}" pattern="yyyy.MM.dd HH:mm"/></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="7" style="text-align:center;padding:40px;color:#475569;"><spring:message code="admin.common.noResults"/></td></tr>
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

    <%-- ── 유저 화면 바로가기 ── --%>
    <div style="margin-top:16px;padding:0 10px;">
        <a class="adm-nav-item adm-nav-ext" href="${pageContext.request.contextPath}/inquiry/list" target="_blank">
            <span class="adm-nav-icon">↗️</span> <spring:message code="admin.inquiry.viewSite"/>
        </a>
    </div>
</div>

<script>
var INQUIRY_AUTHOR_MSG = {
    blocked: '${fn:escapeXml(adminCommonBlockedLabel)}',
    active: '${fn:escapeXml(adminCommonActiveLabel)}',
    nickname: '${fn:escapeXml(adminCommonNickname)}',
    userId: '${fn:escapeXml(adminCommonUserId)}',
    accountStatus: '${fn:escapeXml(adminCommonAccountStatus)}',
    memberInfoView: '${fn:escapeXml(adminCommonMemberInfoView)}',
    blockAccount: '${fn:escapeXml(adminCommonBlockAccount)}',
    confirmBlock: '${fn:escapeXml(adminInquiryConfirmBlockUser)}',
    blockFailed: '${fn:escapeXml(adminInquiryBlockFailed)}',
    title: '${fn:escapeXml(adminInquiryAuthorInfoTitle)}'
};

function goPage(page) {
    const params = new URLSearchParams(window.location.search);
    params.set('page', page);
    location.href = '${pageContext.request.contextPath}/admin/inquiries?' + params.toString();
}

var ctx = '${pageContext.request.contextPath}';

// 행 클릭 시 어드민 문의 상세 페이지 이동
var listParams = 'page=${search.page}&status=${search.status}&category=${search.category}&answered=${search.answered}&searchType=${search.searchType}&keyword=' + encodeURIComponent('${search.keyword}');
document.querySelectorAll('.adm-inq-row[data-id]').forEach(function (tr) {
    tr.addEventListener('click', function (e) {
        if (e.target.closest('td[data-useridx]')) return; // 작성자 셀 클릭은 모달로 처리
        location.href = '${pageContext.request.contextPath}/admin/inquiries/' + this.getAttribute('data-id') + '?' + listParams;
    });
});

// ── 작성자 모달 ──
function openAuthorModal(el) {
    var userIdx  = el.getAttribute('data-useridx');
    var userId   = el.getAttribute('data-userid');
    var nickname = el.getAttribute('data-nickname');
    var status   = el.getAttribute('data-status');

    var statusBadge = status === 'BLOCKED'
        ? '<span class="status-badge BLOCKED" style="font-size:12px;">' + escHtml(INQUIRY_AUTHOR_MSG.blocked) + '</span>'
        : '<span class="status-badge ACTIVE"  style="font-size:12px;">' + escHtml(INQUIRY_AUTHOR_MSG.active) + '</span>';

    var blockBtn = status !== 'BLOCKED'
        ? '<button class="adm-btn adm-btn-ghost" style="color:#f87171;border-color:#f87171;width:100%;margin-top:4px;" data-idx="' + userIdx + '" onclick="blockUserFromModal(this)">' + escHtml(INQUIRY_AUTHOR_MSG.blockAccount) + '</button>'
        : '';

    document.getElementById('authorModalBody').innerHTML =
        '<div style="display:flex;flex-direction:column;gap:10px;">'
      + '  <div style="display:flex;justify-content:space-between;align-items:center;">'
      + '    <span style="color:#64748b;font-size:12px;">' + escHtml(INQUIRY_AUTHOR_MSG.nickname) + '</span>'
      + '    <span class="adm-modal-nickname">' + escHtml(nickname) + '</span>'
      + '  </div>'
      + '  <div style="display:flex;justify-content:space-between;align-items:center;">'
      + '    <span style="color:#64748b;font-size:12px;">' + escHtml(INQUIRY_AUTHOR_MSG.userId) + '</span>'
      + '    <span style="color:#94a3b8;font-size:13px;">' + escHtml(userId) + '</span>'
      + '  </div>'
      + '  <div style="display:flex;justify-content:space-between;align-items:center;">'
      + '    <span style="color:#64748b;font-size:12px;">' + escHtml(INQUIRY_AUTHOR_MSG.accountStatus) + '</span>'
      + '    ' + statusBadge
      + '  </div>'
      + '</div>'
      + '<div style="margin-top:16px;display:flex;flex-direction:column;gap:6px;">'
      + '  <a href="' + ctx + '/admin/members?searchType=userId&keyword=' + encodeURIComponent(userId) + '" class="adm-btn adm-btn-ghost" style="text-align:center;text-decoration:none;">' + escHtml(INQUIRY_AUTHOR_MSG.memberInfoView) + '</a>'
      + blockBtn
      + '</div>';

    document.querySelector('#authorModal .adm-modal-title').textContent = INQUIRY_AUTHOR_MSG.title;
    document.getElementById('authorModal').style.display = 'flex';
}

function closeAuthorModal() {
    document.getElementById('authorModal').style.display = 'none';
}

function blockUserFromModal(btn) {
    var userIdx = btn.getAttribute('data-idx');
    if (!confirm(INQUIRY_AUTHOR_MSG.confirmBlock)) return;
    fetch(ctx + '/admin/community/users/' + userIdx + '/block', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || INQUIRY_AUTHOR_MSG.blockFailed); }
    });
}

function escHtml(str) {
    if (!str) return '';
    return String(str).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}
</script>

<%-- ── 작성자 정보 모달 ── --%>
<div id="authorModal" class="adm-modal-overlay" style="display:none;"
     onclick="if(event.target===this)closeAuthorModal()">
    <div class="adm-modal" style="width:360px;">
        <div class="adm-modal-head">
            <span class="adm-modal-title">${adminInquiryAuthorInfoTitle}</span>
            <button class="adm-modal-close" onclick="closeAuthorModal()">✕</button>
        </div>
        <div class="adm-modal-body" id="authorModalBody"></div>
    </div>
</div>

<%@ include file="../layout-close.jsp" %>
