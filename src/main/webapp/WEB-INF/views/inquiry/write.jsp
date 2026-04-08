<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  =============================================
  문의 게시판 작성 페이지
  URL: GET  /inquiry/write → 폼 표시
       POST /inquiry/write → 등록 처리 (@ResponseBody JSON 반환)
  =============================================
  [페이지 구성]
  1. 페이지 헤더 (뒤로가기 + 제목)
  2. 폼 카드
     2-1. 문의 유형 선택
     2-2. 제목 입력
     2-3. 내용 입력 (글자수 카운터)
     2-4. 비공개 여부 토글
     2-5. 취소/등록 버튼
  3. 스크립트 (유효성 검사 + 등록 처리)
  =============================================
--%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="inquiry/inquiry.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<div class="inq-write-wrap">
  <div class="inq-write-inner">

    <%-- =============================================
         1. 페이지 헤더
         ============================================= --%>
    <div class="inq-write-header">
      <button class="inq-back-btn"
              onclick="location.href='${pageContext.request.contextPath}/inquiry/list'">
        &#8592; 목록으로
      </button>
      <h1>문의하기</h1>
      <p>최대한 빠르게 답변 드리겠습니다</p>
    </div>

    <%-- =============================================
         2. 폼 카드
         ============================================= --%>
    <div class="inq-write-card">

      <%-- 2-1. 문의 유형 선택 --%>
      <div class="inq-form-group">
        <label class="inq-form-label" for="category">
          문의 유형 <span class="inq-required">*</span>
        </label>
        <select class="inq-form-select" id="category" name="category">
          <option value="">유형을 선택해주세요</option>
          <option value="service">서비스 이용</option>
          <option value="payment">결제 / 환불</option>
          <option value="account">계정 / 로그인</option>
          <option value="bug">오류 신고</option>
          <option value="etc">기타</option>
        </select>
        <%-- 유효성 검사 메시지 출력 영역 --%>
        <div class="inq-field-msg" id="categoryMsg"></div>
      </div>

      <%-- 2-2. 제목 입력 --%>
      <div class="inq-form-group">
        <label class="inq-form-label" for="title">
          제목 <span class="inq-required">*</span>
        </label>
        <input class="inq-form-input" type="text" id="title" name="title"
               placeholder="문의 제목을 입력해주세요" maxlength="200">
        <div class="inq-field-msg" id="titleMsg"></div>
      </div>

      <%-- 2-3. 내용 입력 + 글자수 카운터 --%>
      <div class="inq-form-group">
        <label class="inq-form-label" for="content">
          내용 <span class="inq-required">*</span>
        </label>
        <textarea class="inq-form-textarea" id="content" name="content"
                  placeholder="문의 내용을 자세히 입력해주세요&#10;&#10;• 발생한 문제나 궁금한 점을 구체적으로 작성해주세요&#10;• 스크린샷이 있다면 내용에 상황을 자세히 설명해주세요"
                  rows="10" maxlength="5000"></textarea>
        <div class="inq-textarea-footer">
          <div class="inq-field-msg" id="contentMsg"></div>
          <%-- 현재 글자수 / 최대 글자수 표시 --%>
          <span class="inq-char-count"><span id="contentCount">0</span> / 5000</span>
        </div>
      </div>

      <%-- 2-4. 비공개 여부 토글
               - 체크 시 본인과 운영진만 열람 가능 --%>
      <div class="inq-form-group">
        <label class="inq-private-toggle">
          <input type="checkbox" id="isPrivate">
          <span class="inq-toggle-slider"></span>
          <span class="inq-toggle-label">비공개로 등록</span>
        </label>
        <div class="inq-private-hint">비공개 설정 시 본인과 운영진만 열람할 수 있습니다</div>
      </div>

      <%-- 2-5. 취소 / 등록 버튼 --%>
      <div class="inq-write-actions">
        <button class="inq-btn-cancel"
                onclick="location.href='${pageContext.request.contextPath}/inquiry/list'">
          취소
        </button>
        <button class="inq-btn-submit" id="submitBtn">
          문의 등록
        </button>
      </div>

    </div><%-- /inq-write-card --%>
  </div>
</div>

<%-- =============================================
     3. 스크립트
     ============================================= --%>
<script>
(function () {
  const ctx = '${pageContext.request.contextPath}';

  // 2-3. 글자수 카운터: 내용 입력할 때마다 현재 글자수 업데이트
  const contentEl = document.getElementById('content');
  const countEl   = document.getElementById('contentCount');
  contentEl.addEventListener('input', function () {
    countEl.textContent = this.value.length;
  });

  // 2-5. 등록 버튼 클릭 시 처리
  document.getElementById('submitBtn').addEventListener('click', async function () {
    const category  = document.getElementById('category').value;
    const title     = document.getElementById('title').value.trim();
    const content   = contentEl.value.trim();
    // 체크박스 체크 여부에 따라 1 또는 0 전달
    const isPrivate = document.getElementById('isPrivate').checked ? 1 : 0;

    // 유효성 검사: 모든 필수값 확인
    let valid = true;

    if (!category) {
      setMsg('categoryMsg', '문의 유형을 선택해주세요.', 'error'); valid = false;
    } else { clearMsg('categoryMsg'); }

    if (!title) {
      setMsg('titleMsg', '제목을 입력해주세요.', 'error'); valid = false;
    } else if (title.length < 5) {
      setMsg('titleMsg', '제목은 5자 이상 입력해주세요.', 'error'); valid = false;
    } else { clearMsg('titleMsg'); }

    if (!content) {
      setMsg('contentMsg', '내용을 입력해주세요.', 'error'); valid = false;
    } else if (content.length < 10) {
      setMsg('contentMsg', '내용은 10자 이상 입력해주세요.', 'error'); valid = false;
    } else { clearMsg('contentMsg'); }

    if (!valid) return;

    // 중복 클릭 방지 + 로딩 스피너 표시
    this.disabled = true;
    this.classList.add('loading');

    try {
      // POST /inquiry/write 로 폼 데이터 전송
      const res  = await fetch(ctx + '/inquiry/write', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({ category, title, content, isPrivate })
      });
      const data = await res.json();

      if (data.success) {
        // 등록 성공 시 상세 페이지로 이동
        location.href = ctx + '/inquiry/' + data.inquiryId;
      } else {
        alert('등록에 실패했습니다. 다시 시도해주세요.');
        this.disabled = false;
        this.classList.remove('loading');
      }
    } catch (e) {
      alert('오류가 발생했습니다. 다시 시도해주세요.');
      this.disabled = false;
      this.classList.remove('loading');
    }
  });

  // 유효성 메시지 표시 함수
  function setMsg(id, msg, type) {
    const el = document.getElementById(id);
    el.textContent = msg;
    el.className = 'inq-field-msg ' + type;
  }

  // 유효성 메시지 초기화 함수
  function clearMsg(id) {
    const el = document.getElementById(id);
    el.textContent = '';
    el.className = 'inq-field-msg';
  }
})();
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
