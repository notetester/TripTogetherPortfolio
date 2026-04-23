<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="activeMenu" value="inquiries"/>
<spring:message code="admin.inquiry.detail.pageTitle" var="adminInquiryDetailPageTitle"/>
<spring:message code="admin.inquiry.detail.backToList" var="adminInquiryDetailBackToList"/>
<spring:message code="admin.inquiry.detail.authorInfoTitle" var="adminInquiryDetailAuthorInfoTitle"/>
<spring:message code="admin.inquiry.detail.answerTitle" var="adminInquiryDetailAnswerTitle"/>
<spring:message code="admin.inquiry.detail.answerEdit" var="adminInquiryDetailAnswerEdit"/>
<spring:message code="admin.inquiry.detail.answerDelete" var="adminInquiryDetailAnswerDelete"/>
<spring:message code="admin.inquiry.detail.answerPlaceholder" var="adminInquiryDetailAnswerPlaceholder"/>
<spring:message code="admin.inquiry.detail.answerRegister" var="adminInquiryDetailAnswerRegister"/>
<spring:message code="admin.inquiry.detail.save" var="adminInquiryDetailSave"/>
<spring:message code="admin.common.cancel" var="adminCommonCancel"/>
<spring:message code="admin.inquiry.detail.statusChange" var="adminInquiryDetailStatusChange"/>
<spring:message code="admin.inquiry.detail.deleteInquiry" var="adminInquiryDetailDeleteInquiry"/>
<spring:message code="admin.inquiry.detail.deleteRequestPending" var="adminInquiryDetailDeleteRequestPending"/>
<spring:message code="admin.inquiry.detail.approveDeleteRequest" var="adminInquiryDetailApproveDeleteRequest"/>
<spring:message code="admin.inquiry.detail.rejectDeleteRequest" var="adminInquiryDetailRejectDeleteRequest"/>
<spring:message code="admin.inquiry.detail.enterAnswer" var="adminInquiryDetailEnterAnswer"/>
<spring:message code="admin.inquiry.detail.processFailed" var="adminInquiryDetailProcessFailed"/>
<spring:message code="admin.inquiry.detail.confirmDeleteAnswer" var="adminInquiryDetailConfirmDeleteAnswer"/>
<spring:message code="admin.inquiry.detail.confirmDeleteInquiry" var="adminInquiryDetailConfirmDeleteInquiry"/>
<spring:message code="admin.inquiry.detail.confirmApproveDeleteRequest" var="adminInquiryDetailConfirmApproveDeleteRequest"/>
<spring:message code="admin.inquiry.detail.confirmRejectDeleteRequest" var="adminInquiryDetailConfirmRejectDeleteRequest"/>
<spring:message code="admin.inquiry.detail.confirmChangeStatus" var="adminInquiryDetailConfirmChangeStatus"/>
<spring:message code="admin.inquiry.detail.viewOriginal" var="adminInquiryDetailViewOriginal"/>
<spring:message code="admin.inquiry.detail.id" var="adminInquiryDetailId"/>
<c:set var="pageTitle" value="${adminInquiryDetailPageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content">
    <div style="margin-bottom:16px;">
        <a href="javascript:goBackToList()" class="adm-back-link">← ${adminInquiryDetailBackToList}</a>
    </div>

    <div class="adm-split-layout">

        <%-- ── 왼쪽 ── --%>
        <div>

            <%-- 문의 내용 카드 --%>
            <div class="adm-card" style="margin-bottom:20px;">
                <div class="adm-card-head">
                    <div class="adm-card-title"><spring:message code="admin.inquiry.detail.title" arguments="${inquiry.inquiryId}"/></div>
                    <div style="display:flex;gap:8px;align-items:center;">
                        <span class="status-badge ${inquiry.status}">
                            <c:choose>
                                <c:when test="${inquiry.status eq 'PENDING'}"><spring:message code="admin.inquiry.status.pending"/></c:when>
                                <c:when test="${inquiry.status eq 'IN_PROGRESS'}"><spring:message code="admin.inquiry.status.inProgress"/></c:when>
                                <c:when test="${inquiry.status eq 'COMPLETED'}"><spring:message code="admin.inquiry.status.completed"/></c:when>
                                <c:when test="${inquiry.status eq 'USER_COMPLETED'}"><spring:message code="admin.inquiry.status.userCompleted"/></c:when>
                                <c:when test="${inquiry.status eq 'CANCELLED'}"><spring:message code="admin.inquiry.status.cancelled"/></c:when>
                                <c:when test="${inquiry.status eq 'DELETE_REQUESTED'}"><spring:message code="admin.inquiry.status.deleteRequested"/></c:when>
                                <c:otherwise>${inquiry.status}</c:otherwise>
                            </c:choose>
                        </span>
                        <a href="${pageContext.request.contextPath}/inquiry/${inquiry.inquiryId}"
                           target="_blank"
                           class="adm-btn adm-btn-ghost"
                           style="font-size:12px;text-decoration:none;">${adminInquiryDetailViewOriginal}</a>
                    </div>
                </div>
                <div class="adm-card-body">
                    <div style="margin-bottom:10px;">
                        <span class="adm-post-type-badge">
                            <c:choose>
                                <c:when test="${inquiry.category eq 'service'}"><spring:message code="admin.inquiry.category.service"/></c:when>
                                <c:when test="${inquiry.category eq 'payment'}"><spring:message code="admin.inquiry.category.payment"/></c:when>
                                <c:when test="${inquiry.category eq 'account'}"><spring:message code="admin.inquiry.category.account"/></c:when>
                                <c:when test="${inquiry.category eq 'bug'}"><spring:message code="admin.inquiry.category.bug"/></c:when>
                                <c:otherwise><spring:message code="admin.inquiry.category.etc"/></c:otherwise>
                            </c:choose>
                        </span>
                        <button type="button"
                                class="adm-inline-chip"
                                data-category="${inquiry.category}"
                                onclick="applyInquiryFilter(this)">
                            <spring:message code="admin.common.sameCategory"/>
                        </button>
                        <c:if test="${inquiry.privateFlag}">
                            <span style="font-size:11px;color:#94a3b8;">🔒 <spring:message code="admin.inquiry.privateFlag"/></span>
                        </c:if>
                    </div>
                    <h3 class="adm-detail-title">${inquiry.title}</h3>
                    <div class="adm-tr-inline js-admin-translation-widget"
                         data-label="문의 제목 번역"
                         data-source-type="INQUIRY_POST"
                         data-source-idx="${inquiry.inquiryId}"
                         data-field-name="title"
                         data-default-source-lang="ko"
                         data-source-text="${fn:escapeXml(inquiry.title)}"></div>
                    <div class="adm-detail-body">${inquiry.content}</div>
                    <div class="adm-tr-inline js-admin-translation-widget"
                         data-label="문의 본문 번역"
                         data-source-type="INQUIRY_POST"
                         data-source-idx="${inquiry.inquiryId}"
                         data-field-name="content"
                         data-default-source-lang="ko"
                         data-source-text="${fn:escapeXml(inquiry.content)}"></div>
                    <div style="margin-top:16px;padding-top:12px;border-top:1px solid #1e2736;
                                display:flex;gap:20px;font-size:12px;color:#64748b;">
                        <span><spring:message code="admin.inquiry.viewCount" arguments="${inquiry.viewCount}"/></span>
                        <span><fmt:formatDate value="${inquiry.createdAt}" type="both" dateStyle="short" timeStyle="short"/></span>
                    </div>
                </div>
            </div>

            <%-- 답변 카드 --%>
            <div class="adm-card">
                <div class="adm-card-head">
                    <div class="adm-card-title">${adminInquiryDetailAnswerTitle}</div>
                    <c:if test="${not empty inquiry.answerId}">
                        <div style="font-size:12px;color:#64748b;">
                            ${inquiry.answerAdminNickname} ·
                            <fmt:formatDate value="${inquiry.answeredAt}" type="both" dateStyle="short" timeStyle="short"/>
                        </div>
                    </c:if>
                </div>
                <div class="adm-card-body">

                    <%-- 기존 답변 표시 --%>
                    <c:if test="${not empty inquiry.answerId}">
                        <div id="answerView">
                            <div class="adm-inquiry-answer" id="answerText">${inquiry.answerContent}</div>
                            <div class="adm-tr-inline js-admin-translation-widget"
                                 data-label="문의 답변 번역"
                                 data-source-type="INQUIRY_ANSWER"
                                 data-source-idx="${inquiry.answerId}"
                                 data-field-name="content"
                                 data-default-source-lang="ko"
                                 data-source-text="${fn:escapeXml(inquiry.answerContent)}"></div>
                            <div style="display:flex;gap:8px;">
                                <button class="adm-btn adm-btn-ghost" style="font-size:12px;"
                                        onclick="showEditForm()">${adminInquiryDetailAnswerEdit}</button>
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:12px;color:#f87171;border-color:#f87171;"
                                        onclick="deleteAnswer()">${adminInquiryDetailAnswerDelete}</button>
                            </div>
                        </div>
                        <div id="answerEditForm" style="display:none;">
                            <textarea id="answerEditContent" class="adm-input"
                                      style="width:100%;height:150px;resize:vertical;padding:10px;font-size:13px;"
                                      >${inquiry.answerContent}</textarea>
                            <div style="display:flex;gap:8px;margin-top:8px;">
                                <button class="adm-btn adm-btn-primary" style="font-size:12px;"
                                        onclick="saveAnswer(true)">${adminInquiryDetailSave}</button>
                                <button class="adm-btn adm-btn-ghost" style="font-size:12px;"
                                        onclick="hideEditForm()">${adminCommonCancel}</button>
                            </div>
                        </div>
                    </c:if>

                    <%-- 답변 없을 때 작성 폼 --%>
                    <c:if test="${empty inquiry.answerId}">
                        <div id="answerWriteForm">
                            <textarea id="answerNewContent" class="adm-input"
                                      style="width:100%;height:150px;resize:vertical;padding:10px;font-size:13px;"
                                      placeholder="${fn:escapeXml(adminInquiryDetailAnswerPlaceholder)}"></textarea>
                            <div style="display:flex;gap:8px;margin-top:8px;">
                                <button class="adm-btn adm-btn-primary" style="font-size:12px;"
                                        onclick="saveAnswer(false)">${adminInquiryDetailAnswerRegister}</button>
                            </div>
                        </div>
                    </c:if>

                </div>
            </div>

        </div>

        <%-- ── 오른쪽: 작성자 정보 + 액션 ── --%>
        <div>
            <div class="adm-card adm-side-sticky">
                <div class="adm-card-head">
                    <div class="adm-card-title">${adminInquiryDetailAuthorInfoTitle}</div>
                </div>
                <div class="adm-card-body">
                    <div class="adm-side-section">

                        <div>
                            <div style="font-size:11px;color:#64748b;margin-bottom:2px;">${adminCommonUserId}</div>
                            <div style="font-size:14px;font-weight:600;">${inquiry.userId}</div>
                        </div>
                        <div>
                            <div style="font-size:11px;color:#64748b;margin-bottom:2px;"><spring:message code="admin.common.nickname"/></div>
                            <div style="font-size:14px;font-weight:600;">${inquiry.nickname}</div>
                        </div>

                        <div class="adm-meta-actions">
                            <c:choose>
                                <c:when test="${not empty inquiry.userIdx}">
                                    <button type="button"
                                            class="adm-btn adm-btn-ghost js-open-member-context"
                                            data-user-idx="${inquiry.userIdx}"
                                            style="width:100%;text-align:center;font-size:12px;display:block;">
                                        <spring:message code="admin.common.memberInfoView"/>
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/members?searchType=userId&keyword=${inquiry.userId}"
                                       class="adm-btn adm-btn-ghost"
                                       style="text-align:center;font-size:12px;text-decoration:none;display:block;">
                                        <spring:message code="admin.common.memberInfoView"/>
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="adm-inline-actions">
                            <button type="button"
                                    class="adm-inline-chip"
                                    data-search-type="userId"
                                    data-keyword="${inquiry.userId}"
                                    onclick="applyInquiryFilter(this)">
                                <spring:message code="admin.common.sameAuthor"/>
                            </button>
                            <button type="button"
                                    class="adm-inline-chip"
                                    data-category="${inquiry.category}"
                                    onclick="applyInquiryFilter(this)">
                                <spring:message code="admin.common.sameCategory"/>
                            </button>
                        </div>

                        <%-- 상태 변경 --%>
                        <div class="adm-meta-actions">
                            <div style="font-size:11px;color:#64748b;margin-bottom:8px;">${adminInquiryDetailStatusChange}</div>
                            <div style="display:flex;gap:6px;flex-wrap:wrap;">
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:11px;padding:4px 10px;color:#fbbf24;border-color:#fbbf24;"
                                        data-status="PENDING"
                                        onclick="changeStatus(this.getAttribute('data-status'))"><spring:message code="admin.inquiry.status.pending"/></button>
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:11px;padding:4px 10px;color:#fb923c;border-color:#fb923c;"
                                        data-status="IN_PROGRESS"
                                        onclick="changeStatus(this.getAttribute('data-status'))"><spring:message code="admin.inquiry.status.inProgress"/></button>
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:11px;padding:4px 10px;color:#34d399;border-color:#34d399;"
                                        data-status="COMPLETED"
                                        onclick="changeStatus(this.getAttribute('data-status'))"><spring:message code="admin.inquiry.status.completed"/></button>
                            </div>
                        </div>

                        <%-- 삭제 요청 처리: DELETE_REQUESTED 상태일 때만 --%>
                        <c:if test="${inquiry.status eq 'DELETE_REQUESTED'}">
                            <div class="adm-meta-actions">
                                <div style="font-size:11px;color:#fbbf24;margin-bottom:8px;">⚠ ${adminInquiryDetailDeleteRequestPending}</div>
                                <div style="display:flex;flex-direction:column;gap:6px;">
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:12px;color:#ef4444;border-color:#ef4444;"
                                            onclick="approveDeleteRequest()">🗑️ ${adminInquiryDetailApproveDeleteRequest}</button>
                                    <button class="adm-btn adm-btn-ghost"
                                            style="font-size:12px;color:#94a3b8;border-color:#94a3b8;"
                                            onclick="rejectDeleteRequest()">✖ ${adminInquiryDetailRejectDeleteRequest}</button>
                                </div>
                            </div>
                        </c:if>

                        <%-- 삭제: DELETE_REQUESTED가 아닐 때만 (중복 방지) --%>
                        <c:if test="${inquiry.status ne 'DELETE_REQUESTED'}">
                            <div class="adm-meta-actions">
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:12px;color:#f87171;border-color:#f87171;width:100%;"
                                        onclick="deleteInquiry()">${adminInquiryDetailDeleteInquiry}</button>
                            </div>
                        </c:if>

                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script>
var ctx       = '${pageContext.request.contextPath}';
var inquiryId = ${inquiry.inquiryId};
var INQUIRY_DETAIL_MSG = {
    enterAnswer: '${fn:escapeXml(adminInquiryDetailEnterAnswer)}',
    processFailed: '${fn:escapeXml(adminInquiryDetailProcessFailed)}',
    confirmDeleteAnswer: '${fn:escapeXml(adminInquiryDetailConfirmDeleteAnswer)}',
    confirmDeleteInquiry: '${fn:escapeXml(adminInquiryDetailConfirmDeleteInquiry)}',
    confirmApproveDeleteRequest: '${fn:escapeXml(adminInquiryDetailConfirmApproveDeleteRequest)}',
    confirmRejectDeleteRequest: '${fn:escapeXml(adminInquiryDetailConfirmRejectDeleteRequest)}',
    confirmChangeStatus: '<spring:message code="admin.inquiry.detail.confirmChangeStatus" arguments="__status__" javaScriptEscape="true"/>',
    statusPending: '<spring:message code="admin.inquiry.status.pending" javaScriptEscape="true"/>',
    statusInProgress: '<spring:message code="admin.inquiry.status.inProgress" javaScriptEscape="true"/>',
    statusCompleted: '<spring:message code="admin.inquiry.status.completed" javaScriptEscape="true"/>'
};

function goBackToList() {
    var params = new URLSearchParams(window.location.search);
    var page       = params.get('page')       || '1';
    var status     = params.get('status')     || '';
    var category   = params.get('category')   || '';
    var answered   = params.get('answered')   || '';
    var searchType = params.get('searchType') || '';
    var keyword    = params.get('keyword')    || '';
    var url = ctx + '/admin/inquiries?page=' + page;
    if (status)     url += '&status='     + encodeURIComponent(status);
    if (category)   url += '&category='   + encodeURIComponent(category);
    if (answered)   url += '&answered='   + encodeURIComponent(answered);
    if (searchType) url += '&searchType=' + encodeURIComponent(searchType);
    if (keyword)    url += '&keyword='    + encodeURIComponent(keyword);
    location.href = url;
}

function applyInquiryFilter(button) {
    var params = new URLSearchParams();
    params.set('page', '1');
    if (button.dataset.category) {
        params.set('category', button.dataset.category);
    }
    if (button.dataset.searchType) {
        params.set('searchType', button.dataset.searchType);
    }
    if (button.dataset.keyword) {
        params.set('keyword', button.dataset.keyword);
    }
    location.href = ctx + '/admin/inquiries?' + params.toString();
}

function saveAnswer(isEdit) {
    var contentId = isEdit ? 'answerEditContent' : 'answerNewContent';
    var content = document.getElementById(contentId).value.trim();
    if (!content) { alert(INQUIRY_DETAIL_MSG.enterAnswer); return; }
    fetch(ctx + '/admin/inquiries/' + inquiryId + '/answer', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: 'content=' + encodeURIComponent(content)
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || INQUIRY_DETAIL_MSG.processFailed); }
    });
}

function deleteAnswer() {
    if (!confirm(INQUIRY_DETAIL_MSG.confirmDeleteAnswer)) return;
    fetch(ctx + '/admin/inquiries/' + inquiryId + '/answer/delete', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || INQUIRY_DETAIL_MSG.processFailed); }
    });
}

function changeStatus(status) {
    var labels = {
        PENDING: INQUIRY_DETAIL_MSG.statusPending,
        IN_PROGRESS: INQUIRY_DETAIL_MSG.statusInProgress,
        COMPLETED: INQUIRY_DETAIL_MSG.statusCompleted
    };
    var message = INQUIRY_DETAIL_MSG.confirmChangeStatus.replace('__status__', labels[status] || status);
    if (!confirm(message)) return;
    fetch(ctx + '/admin/inquiries/' + inquiryId + '/status', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: 'status=' + encodeURIComponent(status)
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || INQUIRY_DETAIL_MSG.processFailed); }
    });
}

function deleteInquiry() {
    if (!confirm(INQUIRY_DETAIL_MSG.confirmDeleteInquiry)) return;
    fetch(ctx + '/admin/inquiries/' + inquiryId + '/delete', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.href = ctx + '/admin/inquiries'; }
        else { alert(d.message || INQUIRY_DETAIL_MSG.processFailed); }
    });
}

function approveDeleteRequest() {
    if (!confirm(INQUIRY_DETAIL_MSG.confirmApproveDeleteRequest)) return;
    fetch(ctx + '/admin/inquiries/' + inquiryId + '/delete', {
        method: 'POST',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.href = ctx + '/admin/inquiries'; }
        else { alert(d.message || INQUIRY_DETAIL_MSG.processFailed); }
    });
}

function rejectDeleteRequest() {
    if (!confirm(INQUIRY_DETAIL_MSG.confirmRejectDeleteRequest)) return;
    fetch(ctx + '/admin/inquiries/' + inquiryId + '/status', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: 'status=COMPLETED'
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.success) { location.reload(); }
        else { alert(d.message || INQUIRY_DETAIL_MSG.processFailed); }
    });
}

function showEditForm() {
    document.getElementById('answerView').style.display = 'none';
    document.getElementById('answerEditForm').style.display = 'block';
}

function hideEditForm() {
    document.getElementById('answerEditForm').style.display = 'none';
    document.getElementById('answerView').style.display = 'block';
}
</script>
<%@ include file="../layout-close.jsp" %>
