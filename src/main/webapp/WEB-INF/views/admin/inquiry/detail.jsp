<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_admin_translation_label_inquiryTitle" code="admin.translation.label.inquiryTitle"/>
<spring:message var="msg_admin_translation_label_inquiryContent" code="admin.translation.label.inquiryContent"/>
<spring:message var="msg_admin_translation_label_inquiryAnswer" code="admin.translation.label.inquiryAnswer"/>
<spring:message var="msg_admin_inquiry_detail_confirmChangeStatus_js" code="admin.inquiry.detail.confirmChangeStatus" javaScriptEscape="true"/>
<spring:message var="msg_admin_inquiry_status_pending_js" code="admin.inquiry.status.pending" javaScriptEscape="true"/>
<spring:message var="msg_admin_inquiry_status_inProgress_js" code="admin.inquiry.status.inProgress" javaScriptEscape="true"/>
<spring:message var="msg_admin_inquiry_status_completed_js" code="admin.inquiry.status.completed" javaScriptEscape="true"/>
<spring:message var="msg_admin_inquiry_detail_pageTitle" code="admin.inquiry.detail.pageTitle"/>
<spring:message var="msg_admin_inquiry_detail_backToList" code="admin.inquiry.detail.backToList"/>
<spring:message var="msg_admin_inquiry_detail_authorInfoTitle" code="admin.inquiry.detail.authorInfoTitle"/>
<spring:message var="msg_admin_inquiry_detail_answerTitle" code="admin.inquiry.detail.answerTitle"/>
<spring:message var="msg_admin_inquiry_detail_answerEdit" code="admin.inquiry.detail.answerEdit"/>
<spring:message var="msg_admin_inquiry_detail_answerDelete" code="admin.inquiry.detail.answerDelete"/>
<spring:message var="msg_admin_inquiry_detail_answerPlaceholder" code="admin.inquiry.detail.answerPlaceholder"/>
<spring:message var="msg_admin_inquiry_detail_answerRegister" code="admin.inquiry.detail.answerRegister"/>
<spring:message var="msg_admin_inquiry_detail_save" code="admin.inquiry.detail.save"/>
<spring:message var="msg_admin_common_cancel" code="admin.common.cancel"/>
<spring:message var="msg_admin_inquiry_detail_statusChange" code="admin.inquiry.detail.statusChange"/>
<spring:message var="msg_admin_inquiry_detail_deleteInquiry" code="admin.inquiry.detail.deleteInquiry"/>
<spring:message var="msg_admin_inquiry_detail_deleteRequestPending" code="admin.inquiry.detail.deleteRequestPending"/>
<spring:message var="msg_admin_inquiry_detail_approveDeleteRequest" code="admin.inquiry.detail.approveDeleteRequest"/>
<spring:message var="msg_admin_inquiry_detail_rejectDeleteRequest" code="admin.inquiry.detail.rejectDeleteRequest"/>
<spring:message var="msg_admin_inquiry_detail_enterAnswer" code="admin.inquiry.detail.enterAnswer"/>
<spring:message var="msg_admin_inquiry_detail_processFailed" code="admin.inquiry.detail.processFailed"/>
<spring:message var="msg_admin_inquiry_detail_confirmDeleteAnswer" code="admin.inquiry.detail.confirmDeleteAnswer"/>
<spring:message var="msg_admin_inquiry_detail_confirmDeleteInquiry" code="admin.inquiry.detail.confirmDeleteInquiry"/>
<spring:message var="msg_admin_inquiry_detail_confirmApproveDeleteRequest" code="admin.inquiry.detail.confirmApproveDeleteRequest"/>
<spring:message var="msg_admin_inquiry_detail_confirmRejectDeleteRequest" code="admin.inquiry.detail.confirmRejectDeleteRequest"/>
<spring:message var="msg_admin_inquiry_detail_confirmChangeStatus" code="admin.inquiry.detail.confirmChangeStatus"/>
<spring:message var="msg_admin_inquiry_detail_viewOriginal" code="admin.inquiry.detail.viewOriginal"/>
<spring:message var="msg_admin_inquiry_detail_id" code="admin.inquiry.detail.id"/>
<spring:message var="msg_admin_inquiry_detail_title" code="admin.inquiry.detail.title" arguments="${inquiry.inquiryId}"/>
<spring:message var="msg_admin_inquiry_status_pending" code="admin.inquiry.status.pending"/>
<spring:message var="msg_admin_inquiry_status_inProgress" code="admin.inquiry.status.inProgress"/>
<spring:message var="msg_admin_inquiry_status_completed" code="admin.inquiry.status.completed"/>
<spring:message var="msg_admin_inquiry_status_userCompleted" code="admin.inquiry.status.userCompleted"/>
<spring:message var="msg_admin_inquiry_status_cancelled" code="admin.inquiry.status.cancelled"/>
<spring:message var="msg_admin_inquiry_status_deleteRequested" code="admin.inquiry.status.deleteRequested"/>
<spring:message var="msg_admin_inquiry_category_service" code="admin.inquiry.category.service"/>
<spring:message var="msg_admin_inquiry_category_payment" code="admin.inquiry.category.payment"/>
<spring:message var="msg_admin_inquiry_category_account" code="admin.inquiry.category.account"/>
<spring:message var="msg_admin_inquiry_category_bug" code="admin.inquiry.category.bug"/>
<spring:message var="msg_admin_inquiry_category_etc" code="admin.inquiry.category.etc"/>
<spring:message var="msg_admin_common_sameCategory" code="admin.common.sameCategory"/>
<spring:message var="msg_admin_inquiry_privateFlag" code="admin.inquiry.privateFlag"/>
<spring:message var="msg_admin_inquiry_viewCount" code="admin.inquiry.viewCount" arguments="${inquiry.viewCount}"/>
<spring:message var="msg_admin_common_nickname" code="admin.common.nickname"/>
<spring:message var="msg_admin_common_memberInfoView" code="admin.common.memberInfoView"/>
<spring:message var="msg_admin_common_sameAuthor" code="admin.common.sameAuthor"/>
<c:set var="activeMenu" value="inquiries"/>


<c:set var="pageTitle" value="${msg_admin_inquiry_detail_pageTitle}"/>
<%@ include file="../layout.jsp" %>

<div class="adm-content adm-inquiry-page">
    <div class="adm-inquiry-back-row">
        <a href="javascript:goBackToList()" class="adm-back-link">← ${msg_admin_inquiry_detail_backToList}</a>
    </div>

    <div class="adm-split-layout">

        <%-- ── 왼쪽 ── --%>
        <div>

            <%-- 문의 내용 카드 --%>
            <div class="adm-card adm-inquiry-detail-card">
                <div class="adm-card-head">
                    <div class="adm-card-title">${msg_admin_inquiry_detail_title}</div>
                    <div class="adm-inquiry-detail-head-actions">
                        <span class="status-badge ${inquiry.status}">
                            <c:choose>
                                <c:when test="${inquiry.status eq 'PENDING'}">${msg_admin_inquiry_status_pending}</c:when>
                                <c:when test="${inquiry.status eq 'IN_PROGRESS'}">${msg_admin_inquiry_status_inProgress}</c:when>
                                <c:when test="${inquiry.status eq 'COMPLETED'}">${msg_admin_inquiry_status_completed}</c:when>
                                <c:when test="${inquiry.status eq 'USER_COMPLETED'}">${msg_admin_inquiry_status_userCompleted}</c:when>
                                <c:when test="${inquiry.status eq 'CANCELLED'}">${msg_admin_inquiry_status_cancelled}</c:when>
                                <c:when test="${inquiry.status eq 'DELETE_REQUESTED'}">${msg_admin_inquiry_status_deleteRequested}</c:when>
                                <c:otherwise>${inquiry.status}</c:otherwise>
                            </c:choose>
                        </span>
                        <a href="${pageContext.request.contextPath}/inquiry/${inquiry.inquiryId}"
                           target="_blank"
                           class="adm-btn adm-btn-ghost adm-inquiry-small-btn">${msg_admin_inquiry_detail_viewOriginal}</a>
                    </div>
                </div>
                <div class="adm-card-body">
                    <div class="adm-inquiry-detail-tags">
                        <span class="adm-post-type-badge">
                            <c:choose>
                                <c:when test="${inquiry.category eq 'service'}">${msg_admin_inquiry_category_service}</c:when>
                                <c:when test="${inquiry.category eq 'payment'}">${msg_admin_inquiry_category_payment}</c:when>
                                <c:when test="${inquiry.category eq 'account'}">${msg_admin_inquiry_category_account}</c:when>
                                <c:when test="${inquiry.category eq 'bug'}">${msg_admin_inquiry_category_bug}</c:when>
                                <c:otherwise>${msg_admin_inquiry_category_etc}</c:otherwise>
                            </c:choose>
                        </span>
                        <button type="button"
                                class="adm-inline-chip"
                                data-category="${inquiry.category}"
                                onclick="applyInquiryFilter(this)">
                            ${msg_admin_common_sameCategory}
                        </button>
                        <c:if test="${inquiry.privateFlag}">
                            <span class="adm-inquiry-private-note">🔒 ${msg_admin_inquiry_privateFlag}</span>
                        </c:if>
                    </div>
                    <h3 class="adm-detail-title">${inquiry.title}</h3>
                    <div class="adm-tr-inline js-admin-translation-widget"
                         data-label="${msg_admin_translation_label_inquiryTitle}"
                         data-source-type="INQUIRY_POST"
                         data-source-idx="${inquiry.inquiryId}"
                         data-field-name="title"
                         data-default-source-lang="ko"
                         data-source-text="${fn:escapeXml(inquiry.title)}"></div>
                    <div class="adm-detail-body">${inquiry.content}</div>
                    <div class="adm-tr-inline js-admin-translation-widget"
                         data-label="${msg_admin_translation_label_inquiryContent}"
                         data-source-type="INQUIRY_POST"
                         data-source-idx="${inquiry.inquiryId}"
                         data-field-name="content"
                         data-default-source-lang="ko"
                         data-source-text="${fn:escapeXml(inquiry.content)}"></div>
                    <div class="adm-inquiry-detail-meta">
                        <span>${msg_admin_inquiry_viewCount}</span>
                        <span><fmt:formatDate value="${inquiry.createdAtDate}" type="both" dateStyle="short" timeStyle="short"/></span>
                    </div>
                </div>
            </div>

            <%-- 답변 카드 --%>
            <div class="adm-card adm-inquiry-answer-card" id="inquiry-answer-card">
                <div class="adm-card-head">
                    <div class="adm-card-title">${msg_admin_inquiry_detail_answerTitle}</div>
                    <c:if test="${not empty inquiry.answerId}">
                        <div class="adm-inquiry-answer-meta">
                            ${inquiry.answerAdminNickname} ·
                            <fmt:formatDate value="${inquiry.answeredAtDate}" type="both" dateStyle="short" timeStyle="short"/>
                        </div>
                    </c:if>
                </div>
                <div class="adm-card-body">

                    <%-- 기존 답변 표시 --%>
                    <c:if test="${not empty inquiry.answerId}">
                        <div id="answerView">
                            <div class="adm-inquiry-answer" id="answerText">${inquiry.answerContent}</div>
                            <div class="adm-tr-inline js-admin-translation-widget"
                                 data-label="${msg_admin_translation_label_inquiryAnswer}"
                                 data-source-type="INQUIRY_ANSWER"
                                 data-source-idx="${inquiry.answerId}"
                                 data-field-name="content"
                                 data-default-source-lang="ko"
                                 data-source-text="${fn:escapeXml(inquiry.answerContent)}"></div>
                            <div class="adm-inquiry-answer-actions">
                                <button class="adm-btn adm-btn-ghost adm-inquiry-small-btn"
                                        onclick="showEditForm()">${msg_admin_inquiry_detail_answerEdit}</button>
                                <button class="adm-btn adm-btn-ghost adm-inquiry-small-btn adm-inquiry-danger-btn"
                                        onclick="deleteAnswer()">${msg_admin_inquiry_detail_answerDelete}</button>
                            </div>
                        </div>
                        <div id="answerEditForm" hidden>
                            <textarea id="answerEditContent"
                                      class="adm-input adm-inquiry-answer-textarea"
                                      >${inquiry.answerContent}</textarea>
                            <div class="adm-inquiry-answer-actions">
                                <button class="adm-btn adm-btn-primary adm-inquiry-small-btn"
                                        onclick="saveAnswer(true)">${msg_admin_inquiry_detail_save}</button>
                                <button class="adm-btn adm-btn-ghost adm-inquiry-small-btn"
                                        onclick="hideEditForm()">${msg_admin_common_cancel}</button>
                            </div>
                        </div>
                    </c:if>

                    <%-- 답변 없을 때 작성 폼 --%>
                    <c:if test="${empty inquiry.answerId}">
                        <div id="answerWriteForm">
                            <textarea id="answerNewContent"
                                      class="adm-input adm-inquiry-answer-textarea"
                                      placeholder="${fn:escapeXml(msg_admin_inquiry_detail_answerPlaceholder)}"></textarea>
                            <div class="adm-inquiry-answer-actions">
                                <button class="adm-btn adm-btn-primary adm-inquiry-small-btn"
                                        onclick="saveAnswer(false)">${msg_admin_inquiry_detail_answerRegister}</button>
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
                    <div class="adm-card-title">${msg_admin_inquiry_detail_authorInfoTitle}</div>
                </div>
                <div class="adm-card-body">
                    <div class="adm-side-section">

                        <div>
                            <div class="adm-inquiry-side-label">${adminCommonUserId}</div>
                            <div class="adm-inquiry-side-value">${inquiry.userId}</div>
                        </div>
                        <div>
                            <div class="adm-inquiry-side-label">${msg_admin_common_nickname}</div>
                            <div class="adm-inquiry-side-value">${inquiry.nickname}</div>
                        </div>

                        <div class="adm-meta-actions">
                            <c:choose>
                                <c:when test="${not empty inquiry.userIdx}">
                                    <button type="button"
                                            class="adm-btn adm-btn-ghost adm-inquiry-side-full-btn js-open-member-context"
                                            data-user-idx="${inquiry.userIdx}">
                                        ${msg_admin_common_memberInfoView}
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/members?searchType=userId&keyword=${inquiry.userId}"
                                       class="adm-btn adm-btn-ghost adm-inquiry-side-full-btn">
                                        ${msg_admin_common_memberInfoView}
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
                                ${msg_admin_common_sameAuthor}
                            </button>
                            <button type="button"
                                    class="adm-inline-chip"
                                    data-category="${inquiry.category}"
                                    onclick="applyInquiryFilter(this)">
                                ${msg_admin_common_sameCategory}
                            </button>
                        </div>

                        <%-- 상태 변경 --%>
                        <div class="adm-meta-actions" id="inquiry-status-actions">
                            <div class="adm-inquiry-side-label is-spaced">${msg_admin_inquiry_detail_statusChange}</div>
                            <div class="adm-inquiry-status-actions">
                                <button class="adm-btn adm-btn-ghost adm-inquiry-status-btn is-pending"
                                        data-status="PENDING"
                                        ${inquiry.status eq 'PENDING' ? 'disabled' : ''}
                                        onclick="changeStatus(this.getAttribute('data-status'))">${msg_admin_inquiry_status_pending}</button>
                                <button class="adm-btn adm-btn-ghost adm-inquiry-status-btn is-progress"
                                        data-status="IN_PROGRESS"
                                        ${inquiry.status eq 'IN_PROGRESS' ? 'disabled' : ''}
                                        onclick="changeStatus(this.getAttribute('data-status'))">${msg_admin_inquiry_status_inProgress}</button>
                                <button class="adm-btn adm-btn-ghost adm-inquiry-status-btn is-complete"
                                        data-status="COMPLETED"
                                        ${inquiry.status eq 'COMPLETED' ? 'disabled' : ''}
                                        onclick="changeStatus(this.getAttribute('data-status'))">${msg_admin_inquiry_status_completed}</button>
                            </div>
                        </div>

                        <%-- 삭제 요청 처리: DELETE_REQUESTED 상태일 때만 --%>
                        <c:if test="${inquiry.status eq 'DELETE_REQUESTED'}">
                            <div class="adm-meta-actions">
                                <div class="adm-inquiry-delete-warning">⚠ ${msg_admin_inquiry_detail_deleteRequestPending}</div>
                                <div class="adm-inquiry-side-stack">
                                    <button class="adm-btn adm-btn-ghost adm-inquiry-danger-btn"
                                            onclick="approveDeleteRequest()">${msg_admin_inquiry_detail_approveDeleteRequest}</button>
                                    <button class="adm-btn adm-btn-ghost adm-inquiry-muted-btn"
                                            onclick="rejectDeleteRequest()">${msg_admin_inquiry_detail_rejectDeleteRequest}</button>
                                </div>
                            </div>
                        </c:if>

                        <%-- 삭제: DELETE_REQUESTED가 아닐 때만 (중복 방지) --%>
                        <c:if test="${inquiry.status ne 'DELETE_REQUESTED'}">
                            <div class="adm-meta-actions">
                                <button class="adm-btn adm-btn-ghost adm-inquiry-danger-btn adm-inquiry-side-full-btn"
                                        onclick="deleteInquiry()">${msg_admin_inquiry_detail_deleteInquiry}</button>
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
    enterAnswer: '${fn:escapeXml(msg_admin_inquiry_detail_enterAnswer)}',
    processFailed: '${fn:escapeXml(msg_admin_inquiry_detail_processFailed)}',
    confirmDeleteAnswer: '${fn:escapeXml(msg_admin_inquiry_detail_confirmDeleteAnswer)}',
    confirmDeleteInquiry: '${fn:escapeXml(msg_admin_inquiry_detail_confirmDeleteInquiry)}',
    confirmApproveDeleteRequest: '${fn:escapeXml(msg_admin_inquiry_detail_confirmApproveDeleteRequest)}',
    confirmRejectDeleteRequest: '${fn:escapeXml(msg_admin_inquiry_detail_confirmRejectDeleteRequest)}',
    confirmChangeStatus: '${msg_admin_inquiry_detail_confirmChangeStatus_js}',
    statusPending: '${msg_admin_inquiry_status_pending_js}',
    statusInProgress: '${msg_admin_inquiry_status_inProgress_js}',
    statusCompleted: '${msg_admin_inquiry_status_completed_js}'
};


(function () {
    var jump = new URLSearchParams(window.location.search).get('jump');
    if (!jump) return;
    var target = document.getElementById(jump);
    if (!target) return;
    target.classList.add('is-focus-flash');
    target.scrollIntoView({ behavior: 'smooth', block: 'center' });
    var focusable = target.querySelector('textarea, input, select, button, a');
    if (focusable) {
        try { focusable.focus({ preventScroll: true }); } catch (e) { focusable.focus(); }
    }
    setTimeout(function(){ target.classList.remove('is-focus-flash'); }, 2400);
})();

function goBackToList() {
    var params = new URLSearchParams(window.location.search);
    var page       = params.get('page')       || '1';
    var size       = params.get('size')       || '';
    var status     = params.get('status')     || '';
    var category   = params.get('category')   || '';
    var answered   = params.get('answered')   || '';
    var searchType = params.get('searchType') || '';
    var keyword    = params.get('keyword')    || '';
    var url = ctx + '/admin/inquiries?page=' + page;
    if (size)       url += '&size='       + encodeURIComponent(size);
    if (status)     url += '&status='     + encodeURIComponent(status);
    if (category)   url += '&category='   + encodeURIComponent(category);
    if (answered)   url += '&answered='   + encodeURIComponent(answered);
    if (searchType) url += '&searchType=' + encodeURIComponent(searchType);
    if (keyword)    url += '&keyword='    + encodeURIComponent(keyword);
    location.href = url;
}

function applyInquiryFilter(button) {
    var current = new URLSearchParams(window.location.search);
    var params = new URLSearchParams();
    params.set('page', '1');
    if (current.get('size')) {
        params.set('size', current.get('size'));
    }
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
        if (d.success) { goBackToList(); }
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
        if (d.success) { goBackToList(); }
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
    document.getElementById('answerView').hidden = true;
    document.getElementById('answerEditForm').hidden = false;
}

function hideEditForm() {
    document.getElementById('answerEditForm').hidden = true;
    document.getElementById('answerView').hidden = false;
}
</script>
<%@ include file="../layout-close.jsp" %>
