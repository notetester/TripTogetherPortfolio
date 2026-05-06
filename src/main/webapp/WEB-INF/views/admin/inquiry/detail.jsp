<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_be85c35d67" code="admin.inquiry.detail.title"/>
<spring:message var="autoMsg_758e7ff4ac" code="admin.inquiry.status.pending"/>
<spring:message var="autoMsg_bf75ee1a3d" code="admin.inquiry.status.inProgress"/>
<spring:message var="autoMsg_dae12236cd" code="admin.inquiry.status.completed"/>
<spring:message var="autoMsg_4322c34604" code="admin.inquiry.status.userCompleted"/>
<spring:message var="autoMsg_3e30ff2017" code="admin.inquiry.status.cancelled"/>
<spring:message var="autoMsg_19ec19336e" code="admin.inquiry.status.deleteRequested"/>
<spring:message var="autoMsg_d3b6f673e1" code="admin.inquiry.category.service"/>
<spring:message var="autoMsg_27c681f5b0" code="admin.inquiry.category.payment"/>
<spring:message var="autoMsg_9a6aed0964" code="admin.inquiry.category.account"/>
<spring:message var="autoMsg_fb3b4ccd83" code="admin.inquiry.category.bug"/>
<spring:message var="autoMsg_975e93b422" code="admin.inquiry.category.etc"/>
<spring:message var="autoMsg_cc61021232" code="admin.inquiry.privateFlag"/>
<spring:message var="autoMsg_91f14f3495" code="admin.translation.label.inquiryTitle"/>
<spring:message var="autoMsg_bd3f49875a" code="admin.translation.label.inquiryContent"/>
<spring:message var="autoMsg_47b75128e5" code="admin.inquiry.viewCount"/>
<spring:message var="autoMsg_1fe05b3983" code="admin.translation.label.inquiryAnswer"/>
<spring:message var="autoMsg_6cac9d0ac0" code="admin.common.nickname"/>
<spring:message var="autoMsg_280bcc700d" code="admin.inquiry.detail.confirmChangeStatus" javaScriptEscape="true"/>
<spring:message var="autoMsg_92acdd1b19" code="admin.inquiry.status.pending" javaScriptEscape="true"/>
<spring:message var="autoMsg_6dd6a5b369" code="admin.inquiry.status.inProgress" javaScriptEscape="true"/>
<spring:message var="autoMsg_f4ed6656d7" code="admin.inquiry.status.completed" javaScriptEscape="true"/>
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
                    <div class="adm-card-title">${autoMsg_be85c35d67}</div>
                    <div style="display:flex;gap:8px;align-items:center;">
                        <span class="status-badge ${inquiry.status}">
                            <c:choose>
                                <c:when test="${inquiry.status eq 'PENDING'}">${autoMsg_758e7ff4ac}</c:when>
                                <c:when test="${inquiry.status eq 'IN_PROGRESS'}">${autoMsg_bf75ee1a3d}</c:when>
                                <c:when test="${inquiry.status eq 'COMPLETED'}">${autoMsg_dae12236cd}</c:when>
                                <c:when test="${inquiry.status eq 'USER_COMPLETED'}">${autoMsg_4322c34604}</c:when>
                                <c:when test="${inquiry.status eq 'CANCELLED'}">${autoMsg_3e30ff2017}</c:when>
                                <c:when test="${inquiry.status eq 'DELETE_REQUESTED'}">${autoMsg_19ec19336e}</c:when>
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
                                <c:when test="${inquiry.category eq 'service'}">${autoMsg_d3b6f673e1}</c:when>
                                <c:when test="${inquiry.category eq 'payment'}">${autoMsg_27c681f5b0}</c:when>
                                <c:when test="${inquiry.category eq 'account'}">${autoMsg_9a6aed0964}</c:when>
                                <c:when test="${inquiry.category eq 'bug'}">${autoMsg_fb3b4ccd83}</c:when>
                                <c:otherwise>${autoMsg_975e93b422}</c:otherwise>
                            </c:choose>
                        </span>
                        <button type="button"
                                class="adm-inline-chip"
                                data-category="${inquiry.category}"
                                onclick="applyInquiryFilter(this)">
                            <spring:message code="admin.common.sameCategory"/>
                        </button>
                        <c:if test="${inquiry.privateFlag}">
                            <span style="font-size:11px;color:#94a3b8;">🔒 ${autoMsg_cc61021232}</span>
                        </c:if>
                    </div>
                    <h3 class="adm-detail-title">${inquiry.title}</h3>
                    <div class="adm-tr-inline js-admin-translation-widget"
                         data-label="${autoMsg_91f14f3495}"
                         data-source-type="INQUIRY_POST"
                         data-source-idx="${inquiry.inquiryId}"
                         data-field-name="title"
                         data-default-source-lang="ko"
                         data-source-text="${fn:escapeXml(inquiry.title)}"></div>
                    <div class="adm-detail-body">${inquiry.content}</div>
                    <div class="adm-tr-inline js-admin-translation-widget"
                         data-label="${autoMsg_bd3f49875a}"
                         data-source-type="INQUIRY_POST"
                         data-source-idx="${inquiry.inquiryId}"
                         data-field-name="content"
                         data-default-source-lang="ko"
                         data-source-text="${fn:escapeXml(inquiry.content)}"></div>
                    <div style="margin-top:16px;padding-top:12px;border-top:1px solid #1e2736;
                                display:flex;gap:20px;font-size:12px;color:#64748b;">
                        <span>${autoMsg_47b75128e5}</span>
                        <span><fmt:formatDate value="${inquiry.createdAtDate}" type="both" dateStyle="short" timeStyle="short"/></span>
                    </div>
                </div>
            </div>

            <%-- 답변 카드 --%>
            <div class="adm-card" id="inquiry-answer-card">
                <div class="adm-card-head">
                    <div class="adm-card-title">${adminInquiryDetailAnswerTitle}</div>
                    <c:if test="${not empty inquiry.answerId}">
                        <div style="font-size:12px;color:#64748b;">
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
                                 data-label="${autoMsg_1fe05b3983}"
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
                            <div style="font-size:11px;color:#64748b;margin-bottom:2px;">${autoMsg_6cac9d0ac0}</div>
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
                        <div class="adm-meta-actions" id="inquiry-status-actions">
                            <div style="font-size:11px;color:#64748b;margin-bottom:8px;">${adminInquiryDetailStatusChange}</div>
                            <div style="display:flex;gap:6px;flex-wrap:wrap;">
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:11px;padding:4px 10px;color:#fbbf24;border-color:#fbbf24;"
                                        data-status="PENDING"
                                        onclick="changeStatus(this.getAttribute('data-status'))">${autoMsg_758e7ff4ac}</button>
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:11px;padding:4px 10px;color:#fb923c;border-color:#fb923c;"
                                        data-status="IN_PROGRESS"
                                        onclick="changeStatus(this.getAttribute('data-status'))">${autoMsg_bf75ee1a3d}</button>
                                <button class="adm-btn adm-btn-ghost"
                                        style="font-size:11px;padding:4px 10px;color:#34d399;border-color:#34d399;"
                                        data-status="COMPLETED"
                                        onclick="changeStatus(this.getAttribute('data-status'))">${autoMsg_dae12236cd}</button>
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
    confirmChangeStatus: '${autoMsg_280bcc700d}',
    statusPending: '${autoMsg_92acdd1b19}',
    statusInProgress: '${autoMsg_6dd6a5b369}',
    statusCompleted: '${autoMsg_f4ed6656d7}'
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
