<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  고객지원 - 문의 상세 페이지
  Controller : GET /inquiry/{inquiryId}
  Model 필요 :
    - inquiry : InquiryPostDto
    - answer  : InquiryAnswerDto  (null 이면 미답변)
    - isAdmin : boolean
    - isOwner : boolean
--%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="inquiry/inquiry.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<div class="inq-detail-wrap">
  <div class="inq-detail-inner">

    <%-- 뒤로가기 --%>
    <button class="inq-back-btn"
            onclick="location.href='${pageContext.request.contextPath}/inquiry/list'">
      &#8592; 목록으로
    </button>

    <%-- ══════════════════════════════════════════
         문의 본문 카드
    ══════════════════════════════════════════ --%>
    <div class="inq-detail-card">

      <%-- 카드 헤더 --%>
      <div class="inq-detail-head">
        <div class="inq-detail-meta">
          <span class="inq-category-tag">${inquiry.category eq 'service' ? '서비스' :
            inquiry.category eq 'payment' ? '결제' :
            inquiry.category eq 'account' ? '계정' :
            inquiry.category eq 'bug'     ? '오류신고' : '기타'}</span>
          <span class="inq-status-badge ${inquiry.status}">
            <c:choose>
              <c:when test="${inquiry.status eq 'PENDING'}">대기중</c:when>
              <c:when test="${inquiry.status eq 'IN_PROGRESS'}">처리중</c:when>
              <c:when test="${inquiry.status eq 'COMPLETED'}">✓ 답변완료</c:when>
            </c:choose>
          </span>
          <c:if test="${inquiry.isPrivate == 1}">
            <span class="inq-private-tag">🔒 비공개</span>
          </c:if>
        </div>

        <h1 class="inq-detail-title">${inquiry.title}</h1>

        <div class="inq-detail-info">
          <span class="inq-detail-nick">
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
        </div>
      </div>

      <%-- 카드 본문 --%>
      <div class="inq-detail-body">
        <pre class="inq-detail-content">${inquiry.content}</pre>
      </div>

    </div><%-- /inq-detail-card --%>

    <%-- ══════════════════════════════════════════
         답변 영역
    ══════════════════════════════════════════ --%>
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

    <%-- ══════════════════════════════════════════
         어드민 답변 입력 폼
    ══════════════════════════════════════════ --%>
    <c:if test="${isAdmin}">
      <div class="inq-admin-form">
        <div class="inq-admin-form-title">
          🛡️ 운영진 답변 작성
        </div>
        <textarea class="inq-form-textarea" id="adminContent" rows="6"
                  placeholder="답변 내용을 입력해주세요..."
                  <c:if test="${not empty answer}">disabled</c:if>
        ><c:if test="${not empty answer}">${answer.content}</c:if></textarea>
        <div class="inq-admin-form-actions">
          <c:choose>
            <c:when test="${not empty answer}">
              <span style="font-size:13px;color:var(--gray-400);">이미 답변이 등록되었습니다</span>
            </c:when>
            <c:otherwise>
              <button class="inq-btn-submit" id="answerBtn">답변 등록</button>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </c:if>

    <%-- 하단 액션 버튼 --%>
    <div class="inq-detail-actions">
      <button class="inq-btn-cancel"
              onclick="location.href='${pageContext.request.contextPath}/inquiry/list'">
        목록으로
      </button>
      <c:if test="${isOwner and empty answer}">
        <%-- 본인 & 미답변이면 삭제 추후 구현 가능 --%>
      </c:if>
    </div>

  </div><%-- /inq-detail-inner --%>
</div><%-- /inq-detail-wrap --%>

<c:if test="${isAdmin and empty answer}">
<script>
(function () {
  const ctx = '${pageContext.request.contextPath}';
  const inquiryId = ${inquiry.inquiryId};

  document.getElementById('answerBtn').addEventListener('click', async function () {
    const content = document.getElementById('adminContent').value.trim();
    if (!content) { alert('답변 내용을 입력해주세요.'); return; }

    this.disabled = true;
    this.classList.add('loading');

    try {
      const res  = await fetch(ctx + '/inquiry/' + inquiryId + '/answer', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ content })
      });
      const data = await res.json();

      if (data.success) {
        location.reload();
      } else {
        alert(data.message || '답변 등록에 실패했습니다.');
        this.disabled = false;
        this.classList.remove('loading');
      }
    } catch (e) {
      alert('오류가 발생했습니다.');
      this.disabled = false;
      this.classList.remove('loading');
    }
  });
})();
</script>
</c:if>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
