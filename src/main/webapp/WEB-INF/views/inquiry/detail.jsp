<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<div class="inq-detail-wrap">
  <div class="inq-detail-inner">

    <%-- 뒤로가기 버튼 --%>
    <button class="inq-back-btn" onclick="goBackToList()">
      &#8592; 목록으로
    </button>

    <%-- =============================================
         1. 문의 본문 카드
         ============================================= --%>
    <div class="inq-detail-card">

      <%-- 카드 헤더: 카테고리 + 상태 뱃지 + 비공개 태그 --%>
      <div class="inq-detail-head">
        <div class="inq-detail-meta">
          <%-- 카테고리 태그 --%>
          <span class="inq-category-tag">${inquiry.category eq 'service' ? '서비스' :
            inquiry.category eq 'payment' ? '결제' :
            inquiry.category eq 'account' ? '계정' :
            inquiry.category eq 'bug'     ? '오류신고' : '기타'}</span>

          <%-- 상태 뱃지: CSS 클래스명이 status 값과 일치 (PENDING/IN_PROGRESS/COMPLETED) --%>
          <span class="inq-status-badge ${inquiry.status}">
            <c:choose>
              <c:when test="${inquiry.status eq 'PENDING'}">대기중</c:when>
              <c:when test="${inquiry.status eq 'IN_PROGRESS'}">처리중</c:when>
              <c:when test="${inquiry.status eq 'COMPLETED'}">✓ 답변완료</c:when>
              <c:when test="${inquiry.status eq 'CANCELLED'}">취소됨</c:when>
              <c:when test="${inquiry.status eq 'USER_COMPLETED'}">해결됨</c:when>
              <c:when test="${inquiry.status eq 'DELETE_REQUESTED'}">삭제요청</c:when>
              <c:when test="${inquiry.status eq 'PRIVATE_REQUESTED'}">비공개요청</c:when>
              <c:when test="${inquiry.status eq 'PUBLIC_REQUESTED'}">공개요청</c:when>
            </c:choose>
          </span>

          <%-- 비공개 태그 --%>
          <c:if test="${inquiry.isPrivate == 1}">
            <span class="inq-private-tag">🔒 비공개</span>
          </c:if>
        </div>

        <%-- 제목 (BLUR 대상 아님 — 본문만 블러) --%>
        <h1 class="inq-detail-title">${inquiry.title}</h1>

        <%-- 관리자 전용 AI 감지 배지 + BLUR 해제 버튼 --%>
        <c:if test="${isAdmin and inquiry.aiFlagged}">
          <div style="margin:8px 0;">
            <span class="inq-ai-badge">AI 감지됨</span>
            <button type="button" class="inq-admin-clear-blur-btn"
                    id="postClearBlurBtn" data-id="${inquiry.inquiryId}">
              BLUR 해제
            </button>
          </div>
        </c:if>

        <%-- 작성자 / 날짜 / 조회수 --%>
        <div class="inq-detail-info">
          <span class="inq-detail-nick">
            <%-- 비공개 글이고 어드민이 아니면 익명 표시 --%>
            <c:choose>
              <c:when test="${inquiry.isPrivate == 1 and !isAdmin}">익명</c:when>
              <c:otherwise>${inquiry.nickname}</c:otherwise>
            </c:choose>
          </span>
          <span class="inq-detail-divider">·</span>
          <span class="inq-detail-date">
            <fmt:formatDate value="${inquiry.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
          </span>
          <span class="inq-detail-divider">·</span>
          <span class="inq-detail-views">조회 ${inquiry.viewCount}</span>
          <c:if test="${inquiry.updatedAt != null and inquiry.updatedAt.time != inquiry.createdAt.time}">
            <span class="inq-detail-divider">·</span>
            <span class="inq-detail-edited">수정됨 <fmt:formatDate value="${inquiry.updatedAt}" pattern="yyyy-MM-dd HH:mm"/></span>
          </c:if>
        </div>
      </div>

      <%-- 카드 본문: 문의 내용 (목록에서 BLUR 오버레이로 권한 확인 완료 → 상세는 일반 노출) --%>
      <div class="inq-detail-body">
        <pre class="inq-detail-content">${inquiry.content}</pre>
      </div>

      <%-- 첨부파일 목록 --%>
      <c:if test="${not empty attachmentList}">
        <div class="inq-attachment-list">
          <div class="inq-attachment-title">📎 첨부파일</div>
          <c:forEach var="att" items="${attachmentList}">
            <div class="inq-attachment-item">
              <a href="${att.fileUrl}" target="_blank">
                <img src="${att.fileUrl}"
                     alt="${att.fileName}"
                     class="inq-attachment-img"/>
              </a>
              <span class="inq-attachment-name">${att.fileName}</span>
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
              <div class="inq-answer-title">운영진 답변</div>
              <div class="inq-answer-meta">
                ${answer.adminNickname} ·
                <fmt:formatDate value="${answer.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                <c:if test="${answer.updatedAt != null and answer.updatedAt.time != answer.createdAt.time}">
                  · <span class="inq-detail-edited">수정됨 <fmt:formatDate value="${answer.updatedAt}" pattern="yyyy-MM-dd HH:mm"/></span>
                </c:if>
              </div>
            </div>
          </div>
          <div class="inq-answer-body">
            <pre class="inq-detail-content">${answer.content}</pre>
          </div>
        </div>
      </c:when>

      <%-- 답변 대기 중 --%>
      <c:otherwise>
        <div class="inq-no-answer">
          <div class="inq-no-answer-icon">⏳</div>
          <div class="inq-no-answer-msg">답변을 준비 중입니다</div>
          <div class="inq-no-answer-sub">빠른 시일 내에 답변 드리겠습니다</div>
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
        <div class="inq-admin-form-title">🛡️ 관리자 패널</div>

        <%-- 상태 변경 버튼 영역 --%>
        <div class="inq-admin-status-bar">
          <span class="inq-admin-status-label">상태 변경:</span>
          <button class="inq-btn-status inq-btn-status-pending" id="btnStatusPending">🔔 대기중</button>
          <button class="inq-btn-status" id="btnStatusInProgress">🔄 처리중</button>
          <button class="inq-btn-status inq-btn-status-complete" id="btnStatusCompleted">✅ 답변완료</button>
        </div>

        <%-- 삭제 요청 수락 버튼 (DELETE_REQUESTED 상태일 때만 표시) --%>
        <c:if test="${inquiry.status eq 'DELETE_REQUESTED'}">
          <div class="inq-admin-status-bar">
            <span class="inq-admin-status-label">삭제 요청 대기중:</span>
            <button class="inq-btn-submit" id="btnApproveDelete"
                    style="background:#ef4444;">🗑️ 삭제 수락</button>
          </div>
        </c:if>

        <%-- 공개/비공개 요청 수락 버튼 (해당 상태일 때만 표시) --%>
        <c:if test="${inquiry.status eq 'PUBLIC_REQUESTED'}">
          <div class="inq-admin-status-bar">
            <span class="inq-admin-status-label">공개 요청 대기중:</span>
            <button class="inq-btn-submit" id="btnApprovePublic">🔓 공개 수락</button>
          </div>
        </c:if>
        <c:if test="${inquiry.status eq 'PRIVATE_REQUESTED'}">
          <div class="inq-admin-status-bar">
            <span class="inq-admin-status-label">비공개 요청 대기중:</span>
            <button class="inq-btn-submit" id="btnApprovePrivate">🔒 비공개 수락</button>
          </div>
        </c:if>

        <%-- 답변 작성/수정 영역 --%>
        <textarea class="inq-form-textarea" id="adminContent" rows="6"
                  placeholder="답변 내용을 입력해주세요..."
                  <c:if test="${not empty answer}">disabled</c:if>
        ><c:if test="${not empty answer}">${answer.content}</c:if></textarea>
        <div class="inq-admin-form-actions">
          <c:choose>
            <%-- 답변 있을 때: 답변 수정 버튼 --%>
            <c:when test="${not empty answer}">
              <button class="inq-btn-cancel" id="answerEditToggleBtn">✏️ 답변 수정</button>
              <button class="inq-btn-submit" id="answerEditSaveBtn" style="display:none;">저장</button>
              <button class="inq-btn-cancel" id="answerEditCancelBtn" style="display:none;">취소</button>
            </c:when>
            <%-- 답변 없을 때: AI 초안 / 등록 / 답변+완료 동시처리 버튼 --%>
            <c:otherwise>
              <button class="inq-btn-cancel" id="aiDraftBtn">AI 초안</button>
              <button class="inq-btn-cancel" id="answerBtn">답변 등록</button>
              <button class="inq-btn-submit" id="answerAndCompleteBtn">답변 + 완료 처리</button>
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
            <label class="inq-form-label">문의 유형</label>
            <select class="inq-form-select" id="editCategory">
              <option value="service" ${inquiry.category eq 'service' ? 'selected' : ''}>서비스 이용</option>
              <option value="payment" ${inquiry.category eq 'payment' ? 'selected' : ''}>결제 / 환불</option>
              <option value="account" ${inquiry.category eq 'account' ? 'selected' : ''}>계정 / 로그인</option>
              <option value="bug"     ${inquiry.category eq 'bug'     ? 'selected' : ''}>오류 신고</option>
              <option value="etc"     ${inquiry.category eq 'etc'     ? 'selected' : ''}>기타</option>
            </select>
          </div>
          <%-- 제목 --%>
          <div class="inq-form-group">
            <label class="inq-form-label">제목</label>
            <input class="inq-form-input" type="text" id="editTitle" value="${inquiry.title}">
          </div>
          <%-- 내용 --%>
          <div class="inq-form-group">
            <label class="inq-form-label">내용</label>
            <textarea class="inq-form-textarea" id="editContent" rows="10">${inquiry.content}</textarea>
          </div>
          <%-- 비공개 여부 --%>
          <div class="inq-form-group">
            <label class="inq-private-toggle">
              <input type="checkbox" id="editIsPrivate" ${inquiry.isPrivate == 1 ? 'checked' : ''}>
              <span class="inq-toggle-slider"></span>
              <span class="inq-toggle-label">비공개</span>
            </label>
          </div>
          <%-- 첨부파일 업로드 --%>
          <div class="inq-form-group">
            <label class="inq-form-label">첨부파일 추가</label>
            <input type="file" class="inq-form-input" id="editAttachFile" multiple
                   accept=".jpg,.jpeg,.png,.gif,.webp,.pdf,.zip">
            <c:if test="${not empty attachmentList}">
              <div class="inq-attachment-edit-list">
                <c:forEach var="att" items="${attachmentList}">
                  <div class="inq-attachment-edit-item" data-id="${att.attachmentId}">
                    <span>${att.fileName}</span>
                    <button type="button" class="inq-attach-delete-btn"
                            data-id="${att.attachmentId}">✕</button>
                  </div>
                </c:forEach>
              </div>
            </c:if>
          </div>
          <%-- 취소 / 저장 버튼 --%>
          <div class="inq-write-actions">
            <button class="inq-btn-cancel" id="editCancelBtn">취소</button>
            <button class="inq-btn-submit" id="editSaveBtn">저장</button>
          </div>
        </div>
      </div>
    </c:if>

    <%-- 수정 불가 안내 --%>
    <c:if test="${(isOwner or isAdmin) and (inquiry.status eq 'COMPLETED' or inquiry.status eq 'IN_PROGRESS' or inquiry.status eq 'USER_COMPLETED' or inquiry.status eq 'CANCELLED')}">
      <div style="font-size:13px; color:var(--gray-400); margin-bottom:8px;">
        ⚠️ 현재 상태에서는 문의를 수정할 수 없습니다.
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
        목록으로
      </button>

      <%-- PENDING: 수정 + 삭제 --%>
      <c:if test="${(isOwner or isAdmin) and inquiry.status eq 'PENDING'}">
        <button class="inq-btn-cancel" id="editBtn">✏️ 수정</button>
        <button class="inq-btn-submit" id="deleteBtn"
                style="background:#ef4444;">🗑️ 삭제</button>
      </c:if>

      <%-- CANCELLED: 삭제만 --%>
      <c:if test="${(isOwner or isAdmin) and inquiry.status eq 'CANCELLED'}">
        <button class="inq-btn-submit" id="deleteBtn"
                style="background:#ef4444;">🗑️ 삭제</button>
      </c:if>

      <%-- 유저 전용: 문의 취소 버튼 (PENDING/IN_PROGRESS일 때) --%>
      <c:if test="${isOwner and (inquiry.status eq 'PENDING' or inquiry.status eq 'IN_PROGRESS')}">
        <button class="inq-btn-submit" id="cancelInquiryBtn"
                style="background:#f59e0b;">✖ 문의 취소</button>
      </c:if>

      <%-- 유저 전용: 해결됐어요 버튼 (IN_PROGRESS 또는 COMPLETED일 때) --%>
      <c:if test="${isOwner and (inquiry.status eq 'IN_PROGRESS' or inquiry.status eq 'COMPLETED')}">
        <button class="inq-btn-submit" id="userCompleteBtn"
                style="background:#10b981;">해결됐어요 ✓</button>
      </c:if>

      <%-- 유저 전용: COMPLETED일 때 삭제요청 / 비공개 요청 --%>
      <c:if test="${isOwner and inquiry.status eq 'COMPLETED'}">
        <button class="inq-btn-submit" id="deleteRequestBtn"
                style="background:#ef4444;">🗑️ 삭제 요청</button>
        <c:if test="${inquiry.isPrivate == 0}">
          <button class="inq-btn-cancel" id="privateRequestBtn">🔒 비공개 요청</button>
        </c:if>
      </c:if>

      <%-- 유저 전용: USER_COMPLETED일 때 삭제요청만 --%>
      <c:if test="${isOwner and inquiry.status eq 'USER_COMPLETED'}">
        <button class="inq-btn-submit" id="deleteRequestBtn"
                style="background:#ef4444;">🗑️ 삭제 요청</button>
      </c:if>

      <%-- 유저 전용: 비공개 상태일 때 공개 요청 (CANCELLED/USER_COMPLETED 제외) --%>
      <c:if test="${isOwner and inquiry.isPrivate == 1
                   and inquiry.status ne 'CANCELLED'
                   and inquiry.status ne 'USER_COMPLETED'}">
        <button class="inq-btn-cancel" id="publicRequestBtn">🔓 공개 요청</button>
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
     관리자: BLUR 해제 버튼
     ============================================= */
  var postClearBlurBtn = document.getElementById('postClearBlurBtn');
  if (postClearBlurBtn) {
    postClearBlurBtn.addEventListener('click', async function () {
      if (!confirm('BLUR을 해제하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/clear-blur', {});
        if (data.success) { location.reload(); }
        else { alert(data.message || 'BLUR 해제에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
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
      if (!confirm('상태를 "대기중"으로 변경하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/status', { status: 'PENDING' });
        if (data.success) { location.reload(); }
        else { alert(data.message || '상태 변경에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
    });
  }

  if (btnInProgress) {
    btnInProgress.addEventListener('click', async function () {
      if (!confirm('상태를 "처리중"으로 변경하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/status', { status: 'IN_PROGRESS' });
        if (data.success) { location.reload(); }
        else { alert(data.message || '상태 변경에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
    });
  }

  if (btnCompleted) {
    btnCompleted.addEventListener('click', async function () {
      if (!confirm('상태를 "답변완료"로 변경하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/status', { status: 'COMPLETED' });
        if (data.success) { location.reload(); }
        else { alert(data.message || '상태 변경에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
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
      btn.textContent = '⏳ 생성 중...';
      try {
        var res  = await fetch(ctx + '/inquiry/' + inquiryId + '/ai-draft', { method: 'POST' });
        var data = await res.json();
        if (data.success) {
          document.getElementById('adminContent').value = data.draft;
        } else {
          alert(data.message || 'AI 초안 생성에 실패했습니다.');
        }
      } catch (e) {
        alert('오류가 발생했습니다. 다시 시도해주세요.');
      } finally {
        btn.disabled = false;
        btn.textContent = 'AI 초안';
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
      if (!content) { alert('답변 내용을 입력해주세요.'); return; }
      this.disabled = true;
      this.classList.add('loading');
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/answer', { content: content, complete: 'false' });
        if (data.success) { location.reload(); }
        else { alert(data.message || '답변 등록에 실패했습니다.'); this.disabled = false; this.classList.remove('loading'); }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; this.classList.remove('loading'); }
    });
  }

  /* =============================================
     어드민: 답변 + 완료 동시 처리
     ============================================= */
  var answerAndCompleteBtn = document.getElementById('answerAndCompleteBtn');
  if (answerAndCompleteBtn) {
    answerAndCompleteBtn.addEventListener('click', async function () {
      var content = document.getElementById('adminContent').value.trim();
      if (!content) { alert('답변 내용을 입력해주세요.'); return; }
      this.disabled = true;
      this.classList.add('loading');
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/answer', { content: content, complete: 'true' });
        if (data.success) { location.reload(); }
        else { alert(data.message || '처리에 실패했습니다.'); this.disabled = false; this.classList.remove('loading'); }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; this.classList.remove('loading'); }
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
      if (!confirm('삭제 요청을 수락하고 문의를 삭제하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/delete-approve', {});
        if (data.success) { location.href = ctx + '/inquiry/list'; }
        else { alert(data.message || '처리에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
    });
  }

  if (btnApprovePublic) {
    btnApprovePublic.addEventListener('click', async function () {
      if (!confirm('공개 요청을 수락하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/visibility-approve', { type: 'public' });
        if (data.success) { location.reload(); }
        else { alert(data.message || '처리에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
    });
  }

  if (btnApprovePrivate) {
    btnApprovePrivate.addEventListener('click', async function () {
      if (!confirm('비공개 요청을 수락하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/visibility-approve', { type: 'private' });
        if (data.success) { location.reload(); }
        else { alert(data.message || '처리에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
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
      if (!content) { alert('답변 내용을 입력해주세요.'); return; }
      this.disabled = true;
      this.classList.add('loading');
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/answer/edit', { content: content });
        if (data.success) { location.reload(); }
        else { alert(data.message || '답변 수정에 실패했습니다.'); this.disabled = false; this.classList.remove('loading'); }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; this.classList.remove('loading'); }
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
      editBtn.textContent = isShown ? '✏️ 수정' : '✏️ 취소';
    });

    editCancel.addEventListener('click', function () {
      editForm.style.display = 'none';
      editBtn.textContent = '✏️ 수정';
    });

    editSave.addEventListener('click', async function () {
      var title     = document.getElementById('editTitle').value.trim();
      var content   = document.getElementById('editContent').value.trim();
      var category  = document.getElementById('editCategory').value;
      var isPrivate = document.getElementById('editIsPrivate').checked ? 1 : 0;
      if (!title)   { alert('제목을 입력해주세요.'); return; }
      if (!content) { alert('내용을 입력해주세요.'); return; }
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
        else { alert(data.message || '수정에 실패했습니다.'); this.disabled = false; this.classList.remove('loading'); }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; this.classList.remove('loading'); }
    });

    // 첨부파일 개별 삭제 버튼
    document.querySelectorAll('.inq-attach-delete-btn').forEach(function (btn) {
      btn.addEventListener('click', async function () {
        var attachmentId = this.getAttribute('data-id');
        if (!confirm('첨부파일을 삭제하시겠습니까?')) return;
        try {
          var data = await postJson('/inquiry/attachment/' + attachmentId + '/delete', {});
          if (data.success) { this.closest('.inq-attachment-edit-item').remove(); }
          else { alert(data.message || '삭제에 실패했습니다.'); }
        } catch (e) { alert('오류가 발생했습니다.'); }
      });
    });
  }

  if (deleteBtn) {
    deleteBtn.addEventListener('click', async function () {
      if (!confirm('정말 삭제하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/delete', {});
        if (data.success) { location.href = ctx + '/inquiry/list'; }
        else { alert(data.message || '삭제에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
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
      if (!confirm('문의가 해결되었나요? 완료 처리하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/user-complete', {});
        if (data.success) { location.reload(); }
        else { alert(data.message || '처리에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
    });
  }

  /* =============================================
     유저: 문의 취소
     ============================================= */
  var cancelInquiryBtn = document.getElementById('cancelInquiryBtn');
  if (cancelInquiryBtn) {
    cancelInquiryBtn.addEventListener('click', async function () {
      if (!confirm('문의를 취소하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/cancel', {});
        if (data.success) { location.reload(); }
        else { alert(data.message || '취소에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
    });
  }

  /* =============================================
     유저: 삭제 요청
     ============================================= */
  var deleteRequestBtn = document.getElementById('deleteRequestBtn');
  if (deleteRequestBtn) {
    deleteRequestBtn.addEventListener('click', async function () {
      if (!confirm('삭제를 요청하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/delete-request', {});
        if (data.success) { location.reload(); }
        else { alert(data.message || '삭제 요청에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
    });
  }

  /* =============================================
     유저: 비공개 / 공개 요청
     ============================================= */
  var privateRequestBtn = document.getElementById('privateRequestBtn');
  var publicRequestBtn  = document.getElementById('publicRequestBtn');

  if (privateRequestBtn) {
    privateRequestBtn.addEventListener('click', async function () {
      if (!confirm('비공개로 전환을 요청하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/visibility-request', { type: 'private' });
        if (data.success) { location.reload(); }
        else { alert(data.message || '요청에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
    });
  }

  if (publicRequestBtn) {
    publicRequestBtn.addEventListener('click', async function () {
      if (!confirm('공개로 전환을 요청하시겠습니까?')) return;
      this.disabled = true;
      try {
        var data = await postJson('/inquiry/' + inquiryId + '/visibility-request', { type: 'public' });
        if (data.success) { location.reload(); }
        else { alert(data.message || '요청에 실패했습니다.'); this.disabled = false; }
      } catch (e) { alert('오류가 발생했습니다.'); this.disabled = false; }
    });
  }

})();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
