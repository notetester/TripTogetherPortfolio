<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_f66ac392b7" code="inquiry.category.service"/>
<spring:message var="autoMsg_087b6adf17" code="inquiry.category.payment"/>
<spring:message var="autoMsg_948e4bbf4f" code="inquiry.category.account"/>
<spring:message var="autoMsg_b4c6a42f84" code="inquiry.category.bug"/>
<spring:message var="autoMsg_e4257c5261" code="inquiry.category.etc"/>
<spring:message var="autoMsg_4a46ee4489" code="inquiry.status.pending"/>
<spring:message var="autoMsg_66ba3d2b69" code="inquiry.status.inProgress"/>
<spring:message var="autoMsg_195cec174e" code="inquiry.status.answerDone"/>
<spring:message var="autoMsg_b31cbd48b6" code="inquiry.status.cancelled"/>
<spring:message var="autoMsg_26b87902f6" code="inquiry.status.userCompleted"/>
<spring:message var="autoMsg_e66bd731a0" code="inquiry.status.deleteRequested"/>
<spring:message var="autoMsg_0641e3dcae" code="inquiry.status.privateRequested"/>
<spring:message var="autoMsg_1161fd4649" code="inquiry.status.publicRequested"/>
<spring:message var="autoMsg_5bc5d8f4ce" code="inquiry.detail.admin.deleteApprove"/>
<spring:message var="autoMsg_b0bfb8f91a" code="inquiry.detail.admin.publicApprove"/>
<spring:message var="autoMsg_372b9f587d" code="inquiry.detail.admin.privateApprove"/>
<spring:message var="autoMsg_9e4f2c4d6c" code="inquiry.write.cancel"/>
<spring:message var="autoMsg_f566f47cbe" code="inquiry.write.type"/>
<spring:message var="autoMsg_3acdbfaa02" code="inquiry.write.type.service"/>
<spring:message var="autoMsg_5cd1ef46dc" code="inquiry.write.type.payment"/>
<spring:message var="autoMsg_11a10966a2" code="inquiry.write.type.account"/>
<spring:message var="autoMsg_1964074e27" code="inquiry.write.type.bug"/>
<spring:message var="autoMsg_7313eacbaa" code="inquiry.write.type.etc"/>
<spring:message var="autoMsg_1b3af5bf07" code="inquiry.write.subject"/>
<spring:message var="autoMsg_1e2f127ba5" code="inquiry.write.content"/>
<spring:message var="autoMsg_c18609d689" code="inquiry.write.private"/>
<spring:message var="autoMsg_567ce4e195" code="inquiry.detail.attachAdd"/>
<spring:message var="autoMsg_8bbf087251" code="inquiry.admin.clearBlur.confirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_640c557f02" code="inquiry.admin.clearBlur.fail" javaScriptEscape="true"/>
<spring:message var="autoMsg_fb65c78523" code="inquiry.write.server" javaScriptEscape="true"/>
<spring:message var="autoMsg_ecd768bbdd" code="inquiry.detail.requestFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_55ef90a42e" code="inquiry.detail.admin.status.pendingConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_9c17844ec7" code="inquiry.detail.admin.status.inProgressConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_03c923dc23" code="inquiry.detail.admin.status.completedConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_989f250f27" code="inquiry.detail.admin.status.changeFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_5f3440035a" code="inquiry.detail.admin.aiDraft.loading" javaScriptEscape="true"/>
<spring:message var="autoMsg_9807968c33" code="inquiry.detail.admin.aiDraft.fail" javaScriptEscape="true"/>
<spring:message var="autoMsg_7c23f114d1" code="inquiry.detail.admin.answerRequired" javaScriptEscape="true"/>
<spring:message var="autoMsg_cbe9ca0c7a" code="inquiry.detail.admin.answerRegisterFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_0a5111066c" code="inquiry.detail.admin.answerCompleteFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_cd53c8847e" code="inquiry.detail.admin.deleteApproveConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_6f8f4376a7" code="inquiry.detail.admin.deleteApproveFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_dad571c603" code="inquiry.detail.admin.publicApproveConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_078b2759ce" code="inquiry.detail.admin.publicApproveFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_08ce40b07c" code="inquiry.detail.admin.privateApproveConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_90c95d20d1" code="inquiry.detail.admin.privateApproveFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_09c1b5834c" code="inquiry.detail.admin.answerEdit.fail" javaScriptEscape="true"/>
<spring:message var="autoMsg_caaa0a16c5" code="inquiry.detail.edit" javaScriptEscape="true"/>
<spring:message var="autoMsg_6377605aa3" code="inquiry.write.cancel" javaScriptEscape="true"/>
<spring:message var="autoMsg_4d6aacccd2" code="inquiry.detail.edit.fail" javaScriptEscape="true"/>
<spring:message var="autoMsg_040fbd9aa9" code="inquiry.detail.attachDeleteConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_14cb5fe71c" code="inquiry.detail.attachDeleteFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_4e05c3c6f5" code="inquiry.detail.deleteConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_a701e9f616" code="inquiry.detail.deleteFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_f86d86a604" code="inquiry.detail.user.completeConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_baa787db19" code="inquiry.detail.user.completeFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_86296b1444" code="inquiry.detail.user.cancelConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_59a922144d" code="inquiry.detail.user.cancelFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_ab80e3cb72" code="inquiry.detail.user.deleteRequestConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_8ff7ddf557" code="inquiry.detail.user.deleteRequestFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_48080de817" code="inquiry.detail.user.deleteCancelConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_b10373c6b1" code="inquiry.detail.user.deleteCancelFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_35ed20e941" code="inquiry.detail.user.privateRequestConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_13da52dcc3" code="inquiry.detail.user.privateRequestFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_2e360091cb" code="inquiry.detail.user.publicRequestConfirm" javaScriptEscape="true"/>
<spring:message var="autoMsg_e3e773edcb" code="inquiry.detail.user.publicRequestFail" javaScriptEscape="true"/>
<spring:message var="autoMsg_17e3e8d3d9" code="inquiry.write.error.title" javaScriptEscape="true"/>
<spring:message var="autoMsg_79e918e8cd" code="inquiry.write.error.content" javaScriptEscape="true"/>
<spring:message var="autoMsg_32ed14734b" code="inquiry.answer.history.toggle" javaScriptEscape="true"/>
<spring:message var="autoMsg_22e420c2db" code="inquiry.answer.history.title" javaScriptEscape="true"/>
<spring:message var="autoMsg_84c462e8bf" code="inquiry.answer.history.empty" javaScriptEscape="true"/>
<spring:message var="autoMsg_de2d442ef6" code="inquiry.answer.history.type.UPDATE" javaScriptEscape="true"/>
<spring:message var="autoMsg_4ef17367fc" code="inquiry.answer.history.type.DELETE" javaScriptEscape="true"/>
<spring:message var="autoMsg_b2c5a1fb3c" code="inquiry.answer.history.changedBy" javaScriptEscape="true"/>
<spring:message var="autoMsg_641e4dac86" code="inquiry.answer.history.prevContent" javaScriptEscape="true"/>
<spring:message var="autoMsg_6075b371ad" code="inquiry.answer.history.loadFail" javaScriptEscape="true"/>
<%--
  =============================================
  문의 게시판 상세 페이지
  URL: GET /inquiry/{inquiryId}
  =============================================
  [model 필요]
  - inquiry     : InquiryPostDto   - 문의 내용
  - answer      : InquiryAnswerDto - 운영진 답변 (없으면 null)
  - isAdmin     : boolean          - 운영진 여부
  - isOwner     : boolean          - 작성자 본인 여부
  - isAdminMode : boolean          - 관리자모드 여부 (AdminModeInterceptor 자동 주입)
                                     false(유저경험모드)이면 관리자 패널 숨김

  [페이지 구성]
  1. 문의 본문 카드 (제목, 카테고리, 상태, 내용)
  2. 답변 영역 (답변 있으면 답변 카드, 없으면 대기 안내)
  3. 어드민 전용 답변 입력 폼 (관리자모드일 때만 표시)
  4. 수정 폼 (PENDING + 본인/어드민만 표시)
  5. 하단 액션 버튼 (목록/수정/삭제)
  6. 스크립트 (답변 등록 + 수정 + 삭제)
  =============================================
--%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="inquiry/inquiry.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<spring:message code="inquiry.write.back" var="inquiryBackLabel"/>
<spring:message code="inquiry.private.tag" var="inquiryPrivateTagLabel"/>
<spring:message code="inquiry.badge.ai" var="inquiryAiBadgeLabel"/>
<spring:message code="inquiry.anonymous" var="inquiryAnonymousLabel"/>
<spring:message code="inquiry.detail.views" var="inquiryViewsLabel"/>
<spring:message code="inquiry.detail.edited" var="inquiryEditedLabel"/>
<spring:message code="inquiry.detail.attachments" var="inquiryAttachmentsLabel"/>
<spring:message code="inquiry.detail.answer.title" var="inquiryAnswerTitleLabel"/>
<spring:message code="inquiry.detail.answer.pending" var="inquiryAnswerPendingLabel"/>
<spring:message code="inquiry.detail.answer.pendingSub" var="inquiryAnswerPendingSubLabel"/>
<spring:message code="inquiry.detail.admin.panel" var="inquiryAdminPanelLabel"/>
<spring:message code="inquiry.detail.admin.status.label" var="inquiryAdminStatusLabel"/>
<spring:message code="inquiry.detail.admin.deleteWaiting" var="inquiryAdminDeleteWaitingLabel"/>
<spring:message code="inquiry.detail.admin.publicWaiting" var="inquiryAdminPublicWaitingLabel"/>
<spring:message code="inquiry.detail.admin.privateWaiting" var="inquiryAdminPrivateWaitingLabel"/>
<spring:message code="inquiry.detail.admin.answer.placeholder" var="inquiryAdminAnswerPlaceholder"/>
<spring:message code="inquiry.detail.admin.answerEdit" var="inquiryAdminAnswerEditLabel"/>
<spring:message code="inquiry.detail.admin.aiDraft" var="inquiryAdminAiDraftLabel"/>
<spring:message code="inquiry.detail.admin.answerRegister" var="inquiryAdminAnswerRegisterLabel"/>
<spring:message code="inquiry.detail.admin.answerComplete" var="inquiryAdminAnswerCompleteLabel"/>
<spring:message code="inquiry.detail.save" var="inquirySaveLabel"/>
<spring:message code="inquiry.detail.edit.disabled" var="inquiryEditDisabledLabel"/>
<spring:message code="inquiry.detail.actions.list" var="inquiryActionListLabel"/>
<spring:message code="inquiry.detail.edit" var="inquiryEditLabel"/>
<spring:message code="inquiry.detail.delete" var="inquiryDeleteLabel"/>
<spring:message code="inquiry.detail.user.cancel" var="inquiryUserCancelLabel"/>
<spring:message code="inquiry.detail.user.complete" var="inquiryUserCompleteLabel"/>
<spring:message code="inquiry.detail.user.deleteRequest" var="inquiryUserDeleteRequestLabel"/>
<spring:message code="inquiry.detail.user.privateRequest" var="inquiryUserPrivateRequestLabel"/>
<spring:message code="inquiry.detail.user.deleteCancel" var="inquiryUserDeleteCancelLabel"/>
<spring:message code="inquiry.detail.user.publicRequest" var="inquiryUserPublicRequestLabel"/>

<div class="inq-detail-wrap">
  <div class="inq-detail-inner">

    <%-- 뒤로가기 버튼 --%>
    <button class="inq-back-btn" onclick="goBackToList()">
      ${inquiryBackLabel}
    </button>

    <%-- =============================================
         1. 문의 본문 카드
         ============================================= --%>
    <div class="inq-detail-card">

      <%-- 카드 헤더: 카테고리 + 상태 뱃지 + 비공개 태그 --%>
      <div class="inq-detail-head">
        <div class="inq-detail-meta">
          <%-- 카테고리 태그 --%>
          <span class="inq-category-tag">
            <c:choose>
              <c:when test="${inquiry.category eq 'service'}">${autoMsg_f66ac392b7}</c:when>
              <c:when test="${inquiry.category eq 'payment'}">${autoMsg_087b6adf17}</c:when>
              <c:when test="${inquiry.category eq 'account'}">${autoMsg_948e4bbf4f}</c:when>
              <c:when test="${inquiry.category eq 'bug'}">${autoMsg_b4c6a42f84}</c:when>
              <c:otherwise>${autoMsg_e4257c5261}</c:otherwise>
            </c:choose>
          </span>

          <%-- 상태 뱃지: CSS 클래스명이 status 값과 일치 (PENDING/IN_PROGRESS/COMPLETED) --%>
          <span class="inq-status-badge ${inquiry.status}">
            <c:choose>
              <c:when test="${inquiry.status eq 'PENDING'}">${autoMsg_4a46ee4489}</c:when>
              <c:when test="${inquiry.status eq 'IN_PROGRESS'}">${autoMsg_66ba3d2b69}</c:when>
              <c:when test="${inquiry.status eq 'COMPLETED'}">${autoMsg_195cec174e}</c:when>
              <c:when test="${inquiry.status eq 'CANCELLED'}">${autoMsg_b31cbd48b6}</c:when>
              <c:when test="${inquiry.status eq 'USER_COMPLETED'}">${autoMsg_26b87902f6}</c:when>
              <c:when test="${inquiry.status eq 'DELETE_REQUESTED'}">${autoMsg_e66bd731a0}</c:when>
              <c:when test="${inquiry.status eq 'PRIVATE_REQUESTED'}">${autoMsg_0641e3dcae}</c:when>
              <c:when test="${inquiry.status eq 'PUBLIC_REQUESTED'}">${autoMsg_1161fd4649}</c:when>
            </c:choose>
          </span>

          <%-- 비공개 태그 --%>
          <c:if test="${inquiry.isPrivate == 1}">
            <span class="inq-private-tag">${inquiryPrivateTagLabel}</span>
          </c:if>
        </div>

        <%-- 제목 (BLUR 대상 아님 — 본문만 블러) --%>
        <h1 class="inq-detail-title"><c:out value="${inquiry.title}"/></h1>

        <%-- 관리자 전용 AI 감지 배지 + BLUR 해제 버튼 --%>
        <c:if test="${isAdmin and inquiry.aiFlagged}">
          <div style="margin:8px 0;">
            <span class="inq-ai-badge">${inquiryAiBadgeLabel}</span>
            <button type="button" class="inq-admin-clear-blur-btn"
                    id="postClearBlurBtn" data-id="${inquiry.inquiryId}">
              <spring:message code="inquiry.admin.clearBlur"/>
            </button>
          </div>
        </c:if>

        <%-- 작성자 / 날짜 / 조회수 --%>
        <div class="inq-detail-info">
          <span class="inq-detail-nick">
            <%-- 비공개 글이고 어드민이 아니면 익명 표시 --%>
            <c:choose>
              <c:when test="${inquiry.isPrivate == 1 and !isAdmin}">${inquiryAnonymousLabel}</c:when>
              <c:otherwise><c:out value="${inquiry.nickname}"/></c:otherwise>
            </c:choose>
          </span>
          <span class="inq-detail-divider">·</span>
          <span class="inq-detail-date">
            <fmt:formatDate value="${inquiry.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/>
          </span>
          <span class="inq-detail-divider">·</span>
          <span class="inq-detail-views">${inquiryViewsLabel} ${inquiry.viewCount}</span>
          <c:if test="${inquiry.updatedAt != null and inquiry.updatedAt.time != inquiry.createdAt.time}">
            <span class="inq-detail-divider">·</span>
            <span class="inq-detail-edited">${inquiryEditedLabel} <fmt:formatDate value="${inquiry.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
          </c:if>
        </div>
      </div>

      <%-- 카드 본문: 문의 내용 (목록에서 BLUR 오버레이로 권한 확인 완료 → 상세는 일반 노출) --%>
      <div class="inq-detail-body">
        <pre class="inq-detail-content"><c:out value="${inquiry.content}"/></pre>
      </div>

      <%-- 첨부파일 목록 --%>
      <c:if test="${not empty attachmentList}">
        <div class="inq-attachment-list">
          <div class="inq-attachment-title">${inquiryAttachmentsLabel}</div>
          <c:forEach var="att" items="${attachmentList}">
            <div class="inq-attachment-item">
              <a href="${att.fileUrl}" target="_blank">
                <img src="${att.fileUrl}"
                     alt="<c:out value='${att.fileName}'/>"
                     class="inq-attachment-img"/>
              </a>
              <span class="inq-attachment-name"><c:out value="${att.fileName}"/></span>
            </div>
          </c:forEach>
        </div>
      </c:if>

    </div><%-- /inq-detail-card --%>

    <%-- =============================================
         2. 답변 영역
         - 답변이 있으면 답변 카드 표시
         - 없으면 대기 중 안내 표시
         ============================================= --%>
    <c:choose>
      <%-- 답변이 있을 때 --%>
      <c:when test="${not empty answer}">
        <div class="inq-answer-card">
          <div class="inq-answer-head">
            <span class="inq-answer-icon">✅</span>
            <div>
              <div class="inq-answer-title">${inquiryAnswerTitleLabel}</div>
              <div class="inq-answer-meta">
                <c:out value="${answer.adminNickname}"/> ·
                <fmt:formatDate value="${answer.createdAtDate}" pattern="yyyy-MM-dd HH:mm"/>
                <c:if test="${answer.updatedAt != null and answer.updatedAt.time != answer.createdAt.time}">
                  · <span class="inq-detail-edited">${inquiryEditedLabel} <fmt:formatDate value="${answer.updatedAtDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                </c:if>
              </div>
            </div>
          </div>
          <div class="inq-answer-body">
            <pre class="inq-detail-content"><c:out value="${answer.content}"/></pre>
          </div>
          <%-- 어드민 전용: 답변 수정/삭제 이력 토글 --%>
          <c:if test="${isAdmin}">
            <div class="inq-answer-history-section">
              <button type="button" class="inq-btn-cancel"
                      id="answerHistoryToggleBtn"
                      data-id="${inquiry.inquiryId}">
                <spring:message code="inquiry.answer.history.toggle"/>
              </button>
              <div class="inq-answer-history-list" id="answerHistoryList" hidden></div>
            </div>
          </c:if>
        </div>
      </c:when>

      <%-- 답변 대기 중 --%>
      <c:otherwise>
        <div class="inq-no-answer">
          <div class="inq-no-answer-icon">⏳</div>
          <div class="inq-no-answer-msg">${inquiryAnswerPendingLabel}</div>
          <div class="inq-no-answer-sub">${inquiryAnswerPendingSubLabel}</div>
        </div>
      </c:otherwise>
    </c:choose>

    <%-- =============================================
         3. 어드민 전용 답변 입력 폼
         - 어드민이고 관리자모드일 때만 표시 (유저경험모드 시 숨김)
         - 이미 답변이 있으면 textarea 비활성화
         ============================================= --%>
    <c:if test="${isAdmin and isAdminMode}">
      <div class="inq-admin-form">
        <div class="inq-admin-form-title">${inquiryAdminPanelLabel}</div>

        <%-- 상태 변경 버튼 영역 --%>
        <div class="inq-admin-status-bar">
          <span class="inq-admin-status-label">${inquiryAdminStatusLabel}</span>
          <button class="inq-btn-status inq-btn-status-pending" id="btnStatusPending">🔔 ${autoMsg_4a46ee4489}</button>
          <button class="inq-btn-status" id="btnStatusInProgress">🔄 ${autoMsg_66ba3d2b69}</button>
          <button class="inq-btn-status inq-btn-status-complete" id="btnStatusCompleted">✅ ${autoMsg_195cec174e}</button>
        </div>

        <%-- 삭제 요청 수락 버튼 (DELETE_REQUESTED 상태일 때만 표시) --%>
        <c:if test="${inquiry.status eq 'DELETE_REQUESTED'}">
          <div class="inq-admin-status-bar">
            <span class="inq-admin-status-label">${inquiryAdminDeleteWaitingLabel}</span>
            <button class="inq-btn-submit" id="btnApproveDelete"
                    style="background:#ef4444;">${autoMsg_5bc5d8f4ce}</button>
          </div>
        </c:if>

        <%-- 공개/비공개 요청 수락 버튼 (해당 상태일 때만 표시) --%>
        <c:if test="${inquiry.status eq 'PUBLIC_REQUESTED'}">
          <div class="inq-admin-status-bar">
            <span class="inq-admin-status-label">${inquiryAdminPublicWaitingLabel}</span>
            <button class="inq-btn-submit" id="btnApprovePublic">${autoMsg_b0bfb8f91a}</button>
          </div>
        </c:if>
        <c:if test="${inquiry.status eq 'PRIVATE_REQUESTED'}">
          <div class="inq-admin-status-bar">
            <span class="inq-admin-status-label">${inquiryAdminPrivateWaitingLabel}</span>
            <button class="inq-btn-submit" id="btnApprovePrivate">${autoMsg_372b9f587d}</button>
          </div>
        </c:if>

        <%-- 답변 작성/수정 영역 --%>
        <textarea class="inq-form-textarea" id="adminContent" rows="6"
                  placeholder="${inquiryAdminAnswerPlaceholder}"
                  <c:if test="${not empty answer}">disabled</c:if>
        ><c:if test="${not empty answer}"><c:out value="${answer.content}"/></c:if></textarea>
        <div class="inq-admin-form-actions">
          <c:choose>
            <%-- 답변 있을 때: 답변 수정 버튼 --%>
            <c:when test="${not empty answer}">
              <button class="inq-btn-cancel" id="answerEditToggleBtn">${inquiryAdminAnswerEditLabel}</button>
              <button class="inq-btn-submit" id="answerEditSaveBtn" style="display:none;">${inquirySaveLabel}</button>
              <button class="inq-btn-cancel" id="answerEditCancelBtn" style="display:none;">${autoMsg_9e4f2c4d6c}</button>
            </c:when>
            <%-- 답변 없을 때: AI 초안 / 등록 / 답변+완료 동시처리 버튼 --%>
            <c:otherwise>
              <button class="inq-btn-cancel" id="aiDraftBtn">${inquiryAdminAiDraftLabel}</button>
              <button class="inq-btn-cancel" id="answerBtn">${inquiryAdminAnswerRegisterLabel}</button>
              <button class="inq-btn-submit" id="answerAndCompleteBtn">${inquiryAdminAnswerCompleteLabel}</button>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </c:if>

    <%-- =============================================
         4. 수정 폼
         - PENDING 상태이고 본인 또는 어드민만 표시
         - 기본값은 숨겨져 있고 수정 버튼 클릭 시 표시
         ============================================= --%>
    <c:if test="${(isOwner or isAdmin) and inquiry.status eq 'PENDING'}">
      <div class="inq-edit-form" id="editForm" style="display:none;">
        <div class="inq-write-card">
          <%-- 문의 유형 --%>
          <div class="inq-form-group">
            <label class="inq-form-label">${autoMsg_f566f47cbe}</label>
            <select class="inq-form-select" id="editCategory">
              <option value="service" ${inquiry.category eq 'service' ? 'selected' : ''}>${autoMsg_3acdbfaa02}</option>
              <option value="payment" ${inquiry.category eq 'payment' ? 'selected' : ''}>${autoMsg_5cd1ef46dc}</option>
              <option value="account" ${inquiry.category eq 'account' ? 'selected' : ''}>${autoMsg_11a10966a2}</option>
              <option value="bug"     ${inquiry.category eq 'bug'     ? 'selected' : ''}>${autoMsg_1964074e27}</option>
              <option value="etc"     ${inquiry.category eq 'etc'     ? 'selected' : ''}>${autoMsg_7313eacbaa}</option>
            </select>
          </div>
          <%-- 제목 --%>
          <div class="inq-form-group">
            <label class="inq-form-label">${autoMsg_1b3af5bf07}</label>
            <input class="inq-form-input" type="text" id="editTitle" value="${fn:escapeXml(inquiry.title)}">
          </div>
          <%-- 내용 --%>
          <div class="inq-form-group">
            <label class="inq-form-label">${autoMsg_1e2f127ba5}</label>
            <textarea class="inq-form-textarea" id="editContent" rows="10"><c:out value="${inquiry.content}"/></textarea>
          </div>
          <%-- 비공개 여부 --%>
          <div class="inq-form-group">
            <label class="inq-private-toggle">
              <input type="checkbox" id="editIsPrivate" ${inquiry.isPrivate == 1 ? 'checked' : ''}>
              <span class="inq-toggle-slider"></span>
              <span class="inq-toggle-label">${autoMsg_c18609d689}</span>
            </label>
          </div>
          <%-- 첨부파일 업로드 --%>
          <div class="inq-form-group">
            <label class="inq-form-label">${autoMsg_567ce4e195}</label>
            <input type="file" class="inq-form-input" id="editAttachFile" multiple
                   accept=".jpg,.jpeg,.png,.gif,.webp,.pdf,.zip">
            <c:if test="${not empty attachmentList}">
              <div class="inq-attachment-edit-list">
                <c:forEach var="att" items="${attachmentList}">
                  <div class="inq-attachment-edit-item" data-id="${att.attachmentId}">
                    <span><c:out value="${att.fileName}"/></span>
                    <button type="button" class="inq-attach-delete-btn"
                            data-id="${att.attachmentId}">✕</button>
                  </div>
                </c:forEach>
              </div>
            </c:if>
          </div>
          <%-- 취소 / 저장 버튼 --%>
          <div class="inq-write-actions">
            <button class="inq-btn-cancel" id="editCancelBtn">${autoMsg_9e4f2c4d6c}</button>
            <button class="inq-btn-submit" id="editSaveBtn">${inquirySaveLabel}</button>
          </div>
        </div>
      </div>
    </c:if>

    <%-- 수정 불가 안내 --%>
    <c:if test="${(isOwner or isAdmin) and (inquiry.status eq 'COMPLETED' or inquiry.status eq 'IN_PROGRESS' or inquiry.status eq 'USER_COMPLETED' or inquiry.status eq 'CANCELLED')}">
      <div style="font-size:13px; color:var(--gray-400); margin-bottom:8px;">
        ${inquiryEditDisabledLabel}
      </div>
    </c:if>

    <%-- =============================================
         5. 하단 액션 버튼
         - 목록으로: 모든 유저
         - 수정/삭제: PENDING 상태이고 본인 또는 어드민만
         ============================================= --%>
    <div class="inq-detail-actions">
      <%-- 목록으로 버튼 --%>
      <button class="inq-btn-cancel" onclick="goBackToList()">
        ${inquiryActionListLabel}
      </button>

      <%-- PENDING: 수정 + 삭제 --%>
      <c:if test="${(isOwner or isAdmin) and inquiry.status eq 'PENDING'}">
        <button class="inq-btn-cancel" id="editBtn">${inquiryEditLabel}</button>
        <button class="inq-btn-submit" id="deleteBtn"
                style="background:#ef4444;">${inquiryDeleteLabel}</button>
      </c:if>

      <%-- CANCELLED: 삭제만 --%>
      <c:if test="${(isOwner or isAdmin) and inquiry.status eq 'CANCELLED'}">
        <button class="inq-btn-submit" id="deleteBtn"
                style="background:#ef4444;">${inquiryDeleteLabel}</button>
      </c:if>

      <%-- 유저 전용: 문의 취소 버튼 (PENDING/IN_PROGRESS일 때) --%>
      <c:if test="${isOwner and (inquiry.status eq 'PENDING' or inquiry.status eq 'IN_PROGRESS')}">
        <button class="inq-btn-submit" id="cancelInquiryBtn"
                style="background:#f59e0b;">${inquiryUserCancelLabel}</button>
      </c:if>

      <%-- 유저 전용: 해결됐어요 버튼 (IN_PROGRESS 또는 COMPLETED일 때) --%>
      <c:if test="${isOwner and (inquiry.status eq 'IN_PROGRESS' or inquiry.status eq 'COMPLETED')}">
        <button class="inq-btn-submit" id="userCompleteBtn"
                style="background:#10b981;">${inquiryUserCompleteLabel}</button>
      </c:if>

      <%-- 유저 전용: COMPLETED일 때 삭제요청 / 비공개 요청 --%>
      <c:if test="${isOwner and inquiry.status eq 'COMPLETED'}">
        <button class="inq-btn-submit" id="deleteRequestBtn"
                style="background:#ef4444;">${inquiryUserDeleteRequestLabel}</button>
        <c:if test="${inquiry.isPrivate == 0}">
          <button class="inq-btn-cancel" id="privateRequestBtn">${inquiryUserPrivateRequestLabel}</button>
        </c:if>
      </c:if>

      <%-- 유저 전용: USER_COMPLETED일 때 삭제요청만 --%>
      <c:if test="${isOwner and inquiry.status eq 'USER_COMPLETED'}">
        <button class="inq-btn-submit" id="deleteRequestBtn"
                style="background:#ef4444;">${inquiryUserDeleteRequestLabel}</button>
      </c:if>

      <%-- 유저 전용: DELETE_REQUESTED일 때 삭제 요청 취소 --%>
      <c:if test="${isOwner and inquiry.status eq 'DELETE_REQUESTED'}">
        <button class="inq-btn-submit" id="deleteCancelBtn"
                style="background:#f59e0b;">${inquiryUserDeleteCancelLabel}</button>
      </c:if>

      <%-- 유저 전용: 비공개 상태일 때 공개 요청 (CANCELLED/USER_COMPLETED 제외) --%>
      <c:if test="${isOwner and inquiry.isPrivate == 1
                   and inquiry.status ne 'CANCELLED'
                   and inquiry.status ne 'USER_COMPLETED'}">
        <button class="inq-btn-cancel" id="publicRequestBtn">${inquiryUserPublicRequestLabel}</button>
      </c:if>
    </div>

  </div><%-- /inq-detail-inner --%>
</div><%-- /inq-detail-wrap --%>

<%-- =============================================
     6. 스크립트
     ============================================= --%>

<script>
var ctx = '${pageContext.request.contextPath}';
function goBackToList() {
    var params   = new URLSearchParams(window.location.search);
    var page     = params.get('page')     || '1';
    var category = params.get('category') || '';
    var status   = params.get('status')   || '';
    var keyword  = params.get('keyword')  || '';
    location.href = ctx + '/inquiry/list?page=' + page
        + (category ? '&category=' + encodeURIComponent(category) : '')
        + (status   ? '&status='   + encodeURIComponent(status)   : '')
        + (keyword  ? '&keyword='  + encodeURIComponent(keyword)  : '');
}
</script>

<script>
(function () {
  var ctx = '${pageContext.request.contextPath}';
  var inquiryId = ${inquiry.inquiryId};
  var inquiryMessages = {
    clearBlurConfirm: '${autoMsg_8bbf087251}',
    clearBlurFail: '${autoMsg_640c557f02}',
    genericError: '${autoMsg_fb65c78523}',
    requestFail: '${autoMsg_ecd768bbdd}',
    statusPendingConfirm: '${autoMsg_55ef90a42e}',
    statusInProgressConfirm: '${autoMsg_9c17844ec7}',
    statusCompletedConfirm: '${autoMsg_03c923dc23}',
    statusChangeFail: '${autoMsg_989f250f27}',
    aiDraftLoading: '${autoMsg_5f3440035a}',
    aiDraftFail: '${autoMsg_9807968c33}',
    answerRequired: '${autoMsg_7c23f114d1}',
    answerRegisterFail: '${autoMsg_cbe9ca0c7a}',
    answerCompleteFail: '${autoMsg_0a5111066c}',
    deleteApproveConfirm: '${autoMsg_cd53c8847e}',
    deleteApproveFail: '${autoMsg_6f8f4376a7}',
    publicApproveConfirm: '${autoMsg_dad571c603}',
    publicApproveFail: '${autoMsg_078b2759ce}',
    privateApproveConfirm: '${autoMsg_08ce40b07c}',
    privateApproveFail: '${autoMsg_90c95d20d1}',
    answerEditFail: '${autoMsg_09c1b5834c}',
    editOpen: '${autoMsg_caaa0a16c5}',
    editClose: '${autoMsg_6377605aa3}',
    editFail: '${autoMsg_4d6aacccd2}',
    attachmentDeleteConfirm: '${autoMsg_040fbd9aa9}',
    attachmentDeleteFail: '${autoMsg_14cb5fe71c}',
    deleteConfirm: '${autoMsg_4e05c3c6f5}',
    deleteFail: '${autoMsg_a701e9f616}',
    userCompleteConfirm: '${autoMsg_f86d86a604}',
    userCompleteFail: '${autoMsg_baa787db19}',
    cancelConfirm: '${autoMsg_86296b1444}',
    cancelFail: '${autoMsg_59a922144d}',
    deleteRequestConfirm: '${autoMsg_ab80e3cb72}',
    deleteRequestFail: '${autoMsg_8ff7ddf557}',
    deleteCancelConfirm: '${autoMsg_48080de817}',
    deleteCancelFail: '${autoMsg_b10373c6b1}',
    privateRequestConfirm: '${autoMsg_35ed20e941}',
    privateRequestFail: '${autoMsg_13da52dcc3}',
    publicRequestConfirm: '${autoMsg_2e360091cb}',
    publicRequestFail: '${autoMsg_e3e773edcb}',
    titleRequired: '${autoMsg_17e3e8d3d9}',
    contentRequired: '${autoMsg_79e918e8cd}',
    historyToggle: '${autoMsg_32ed14734b}',
    historyTitle: '${autoMsg_22e420c2db}',
    historyEmpty: '${autoMsg_84c462e8bf}',
    historyTypeUpdate: '${autoMsg_de2d442ef6}',
    historyTypeDelete: '${autoMsg_4ef17367fc}',
    historyChangedBy: '${autoMsg_b2c5a1fb3c}',
    historyPrevContent: '${autoMsg_641e4dac86}',
    historyLoadFail: '${autoMsg_6075b371ad}'
  };

  /* =============================================
     공통 유틸: POST fetch
     ============================================= */
  async function postJson(url, params) {
    var res = await fetch(ctx + url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams(params)
    });
    return res.json();
  }

  /* =============================================
     어드민: 답변 수정/삭제 이력 토글
     - 정책: ADR-0008 / answer 변경 추적 (INQUIRY_ANSWER_HISTORY)
     ============================================= */
  var historyBtn = document.getElementById('answerHistoryToggleBtn');
  var historyList = document.getElementById('answerHistoryList');
  if (historyBtn && historyList) {
    historyBtn.addEventListener('click', async function () {
      if (!historyList.hidden) {
        historyList.hidden = true;
        return;
      }
      try {
        var res = await fetch(ctx + '/inquiry/' + inquiryId + '/answer/history');
        var data = await res.json();
        if (!data.success) { alert(inquiryMessages.historyLoadFail); return; }
        renderAnswerHistory(historyList, data.list);
        historyList.hidden = false;
      } catch (e) {
        alert(inquiryMessages.historyLoadFail);
      }
    });
  }

  function inqEscape(s) {
    return String(s == null ? '' : s)
        .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;').replace(/'/g, '&#39;');
  }

  function inqFormatDate(s) {
    if (!s) return '';
    var d = new Date(s);
    if (isNaN(d.getTime())) return s;
    var pad = function (n) { return String(n).padStart(2, '0'); };
    return d.getFullYear() + '-' + pad(d.getMonth() + 1) + '-' + pad(d.getDate())
        + ' ' + pad(d.getHours()) + ':' + pad(d.getMinutes());
  }

  function renderAnswerHistory(target, list) {
    if (!list || list.length === 0) {
      target.innerHTML = '<div class="inq-answer-history-empty">'
          + inqEscape(inquiryMessages.historyEmpty) + '</div>';
      return;
    }
    var html = '<div class="inq-answer-history-title">' + inqEscape(inquiryMessages.historyTitle) + '</div>';
    list.forEach(function (item) {
      var typeLabel = item.changeType === 'UPDATE'
          ? inquiryMessages.historyTypeUpdate
          : inquiryMessages.historyTypeDelete;
      html += '<div class="inq-answer-history-item">'
          + '<div class="inq-answer-history-meta">'
          + '<span class="inq-answer-history-type inq-answer-history-type-' + inqEscape(item.changeType) + '">'
          + inqEscape(typeLabel) + '</span> · '
          + inqEscape(inquiryMessages.historyChangedBy) + ': ' + inqEscape(item.changedByNickname) + ' · '
          + inqEscape(inqFormatDate(item.changedAt))
          + '</div>'
          + '<div class="inq-answer-history-prev-label">' + inqEscape(inquiryMessages.historyPrevContent) + '</div>'
          + '<pre class="inq-answer-history-prev">' + inqEscape(item.prevContent) + '</pre>'
          + '</div>';
    });
    target.innerHTML = html;
  }

  /* =============================================
     관리자: BLUR 해제 버튼
     ============================================= */
  var postClearBlurBtn = document.getElementById('postClearBlurBtn');
  if (postClearBlurBtn) {
    postClearBlurBtn.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.clearBlurConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/clear-blur', {});
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.clearBlurFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

  /* =============================================
     어드민: 상태 변경 (대기중 / 처리중 / 답변완료)
     ============================================= */
  var btnPending    = document.getElementById('btnStatusPending');
  var btnInProgress = document.getElementById('btnStatusInProgress');
  var btnCompleted  = document.getElementById('btnStatusCompleted');

  if (btnPending) {
    btnPending.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.statusPendingConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/status', { status: 'PENDING' });
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.statusChangeFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

  if (btnInProgress) {
    btnInProgress.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.statusInProgressConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/status', { status: 'IN_PROGRESS' });
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.statusChangeFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

  if (btnCompleted) {
    btnCompleted.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.statusCompletedConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/status', { status: 'COMPLETED' });
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.statusChangeFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

  /* =============================================
     어드민: AI 답변 초안 생성
     ============================================= */
  var aiDraftBtn = document.getElementById('aiDraftBtn');
  if (aiDraftBtn) {
    aiDraftBtn.addEventListener('click', async function () {
      var btn = this;
      btn.disabled = true;
      btn.textContent = inquiryMessages.aiDraftLoading;
      try {
        var res  = await fetch(ctx + '/inquiry/' + inquiryId + '/ai-draft', { method: 'POST' });
        var data = await res.json();
        if (data.success) {
          document.getElementById('adminContent').value = data.draft;
        } else {
          alert(data.message || inquiryMessages.aiDraftFail);
        }
      } catch (e) {
        alert(inquiryMessages.genericError);
      } finally {
        btn.disabled = false;
        btn.textContent = '${inquiryAdminAiDraftLabel}';
      }
    });
  }

  /* =============================================
     어드민: 답변 등록
     ============================================= */
  var answerBtn = document.getElementById('answerBtn');
  if (answerBtn) {
    answerBtn.addEventListener('click', async function () {
      var content = document.getElementById('adminContent').value.trim();
      if (!content) { alert(inquiryMessages.answerRequired); return; }
      this.disabled = true;
      this.classList.add('loading');
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/answer', { content: content, complete: 'false' });
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.answerRegisterFail); this.disabled = false; this.classList.remove('loading'); }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; this.classList.remove('loading'); }
    });
  }

  /* =============================================
     어드민: 답변 + 완료 동시 처리
     ============================================= */
  var answerAndCompleteBtn = document.getElementById('answerAndCompleteBtn');
  if (answerAndCompleteBtn) {
    answerAndCompleteBtn.addEventListener('click', async function () {
      var content = document.getElementById('adminContent').value.trim();
      if (!content) { alert(inquiryMessages.answerRequired); return; }
      this.disabled = true;
      this.classList.add('loading');
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/answer', { content: content, complete: 'true' });
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.answerCompleteFail); this.disabled = false; this.classList.remove('loading'); }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; this.classList.remove('loading'); }
    });
  }

  /* =============================================
     어드민: 공개/비공개 요청 수락
     ============================================= */
  var btnApproveDelete  = document.getElementById('btnApproveDelete');
  var btnApprovePublic  = document.getElementById('btnApprovePublic');
  var btnApprovePrivate = document.getElementById('btnApprovePrivate');

  if (btnApproveDelete) {
    btnApproveDelete.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.deleteApproveConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/delete-approve', {});
        if (data.success) { location.href = ctx + '/inquiry/list'; }
        else { alert(data.message || inquiryMessages.deleteApproveFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

  if (btnApprovePublic) {
    btnApprovePublic.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.publicApproveConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/visibility-approve', { type: 'public' });
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.publicApproveFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

  if (btnApprovePrivate) {
    btnApprovePrivate.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.privateApproveConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/visibility-approve', { type: 'private' });
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.privateApproveFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

  /* =============================================
     어드민: 답변 수정 토글
     ============================================= */
  var answerEditToggleBtn = document.getElementById('answerEditToggleBtn');
  var answerEditSaveBtn   = document.getElementById('answerEditSaveBtn');
  var answerEditCancelBtn = document.getElementById('answerEditCancelBtn');
  var adminContent        = document.getElementById('adminContent');

  if (answerEditToggleBtn) {
    answerEditToggleBtn.addEventListener('click', function () {
      adminContent.disabled = false;
      adminContent.focus();
      answerEditToggleBtn.style.display = 'none';
      answerEditSaveBtn.style.display   = 'inline-block';
      answerEditCancelBtn.style.display = 'inline-block';
    });

    answerEditCancelBtn.addEventListener('click', function () {
      adminContent.disabled = true;
      answerEditToggleBtn.style.display = 'inline-block';
      answerEditSaveBtn.style.display   = 'none';
      answerEditCancelBtn.style.display = 'none';
    });

    answerEditSaveBtn.addEventListener('click', async function () {
      var content = adminContent.value.trim();
      if (!content) { alert(inquiryMessages.answerRequired); return; }
      this.disabled = true;
      this.classList.add('loading');
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/answer/edit', { content: content });
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.answerEditFail); this.disabled = false; this.classList.remove('loading'); }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; this.classList.remove('loading'); }
    });
  }

  /* =============================================
     수정 / 삭제 (본인 또는 어드민 + PENDING)
     ============================================= */
  var editBtn    = document.getElementById('editBtn');
  var deleteBtn  = document.getElementById('deleteBtn');
  var editForm   = document.getElementById('editForm');

  if (editBtn) {
    var editCancel = document.getElementById('editCancelBtn');
    var editSave   = document.getElementById('editSaveBtn');

    editBtn.addEventListener('click', function () {
      var isShown = editForm.style.display !== 'none';
      editForm.style.display = isShown ? 'none' : 'block';
      editBtn.textContent = isShown ? inquiryMessages.editOpen : inquiryMessages.editClose;
    });

    editCancel.addEventListener('click', function () {
      editForm.style.display = 'none';
      editBtn.textContent = inquiryMessages.editOpen;
    });

    editSave.addEventListener('click', async function () {
      var title     = document.getElementById('editTitle').value.trim();
      var content   = document.getElementById('editContent').value.trim();
      var category  = document.getElementById('editCategory').value;
      var isPrivate = document.getElementById('editIsPrivate').checked ? 1 : 0;
      if (!title)   { alert(inquiryMessages.titleRequired); return; }
      if (!content) { alert(inquiryMessages.contentRequired); return; }
      this.disabled = true;
      this.classList.add('loading');
      try {
        // FormData로 텍스트 + 새 파일 동시 전송
        var formData = new FormData();
        formData.append('title',     title);
        formData.append('content',   content);
        formData.append('category',  category);
        formData.append('isPrivate', isPrivate);

        var fileInput = document.getElementById('editAttachFile');
        if (fileInput) {
          Array.from(fileInput.files).forEach(function (file) {
            formData.append('images', file);
          });
        }

        var res = await fetch(ctx + '/inquiry/' + inquiryId + '/edit', {
          method: 'POST',
          body: formData
        });
        var data = await res.json();
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.editFail); this.disabled = false; this.classList.remove('loading'); }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; this.classList.remove('loading'); }
    });

    // 첨부파일 개별 삭제 버튼
    document.querySelectorAll('.inq-attach-delete-btn').forEach(function (btn) {
      btn.addEventListener('click', async function () {
        var attachmentId = this.getAttribute('data-id');
        if (!confirm(inquiryMessages.attachmentDeleteConfirm)) return;
        try {
          var data = await postJson('/inquiry/attachment/' + attachmentId + '/delete', {});
          if (data.success) { this.closest('.inq-attachment-edit-item').remove(); }
          else { alert(data.message || inquiryMessages.attachmentDeleteFail); }
        } catch (e) { alert(inquiryMessages.genericError); }
      });
    });
  }

  if (deleteBtn) {
    deleteBtn.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.deleteConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/delete', {});
        if (data.success) { location.href = ctx + '/inquiry/list'; }
        else { alert(data.message || inquiryMessages.deleteFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

  /* =============================================
     유저: 문의 취소
     ============================================= */
  /* =============================================
     유저: 해결됐어요 (직접 완료 처리)
     ============================================= */
  var userCompleteBtn = document.getElementById('userCompleteBtn');
  if (userCompleteBtn) {
    userCompleteBtn.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.userCompleteConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/user-complete', {});
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.userCompleteFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

  /* =============================================
     유저: 문의 취소
     ============================================= */
  var cancelInquiryBtn = document.getElementById('cancelInquiryBtn');
  if (cancelInquiryBtn) {
    cancelInquiryBtn.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.cancelConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/cancel', {});
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.cancelFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

  /* =============================================
     유저: 삭제 요청
     ============================================= */
  var deleteRequestBtn = document.getElementById('deleteRequestBtn');
  if (deleteRequestBtn) {
    deleteRequestBtn.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.deleteRequestConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/delete-request', {});
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.deleteRequestFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

  /* =============================================
     유저: 삭제 요청 취소
     ============================================= */
  var deleteCancelBtn = document.getElementById('deleteCancelBtn');
  if (deleteCancelBtn) {
    deleteCancelBtn.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.deleteCancelConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/delete-cancel', {});
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.deleteCancelFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

  /* =============================================
     유저: 비공개 / 공개 요청
     ============================================= */
  var privateRequestBtn = document.getElementById('privateRequestBtn');
  var publicRequestBtn  = document.getElementById('publicRequestBtn');

  if (privateRequestBtn) {
    privateRequestBtn.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.privateRequestConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/visibility-request', { type: 'private' });
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.privateRequestFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

  if (publicRequestBtn) {
    publicRequestBtn.addEventListener('click', async function () {
      if (!confirm(inquiryMessages.publicRequestConfirm)) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/visibility-request', { type: 'public' });
        if (data.success) { location.reload(); }
        else { alert(data.message || inquiryMessages.publicRequestFail); this.disabled = false; }
      } catch (e) { alert(inquiryMessages.genericError); this.disabled = false; }
    });
  }

})();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
