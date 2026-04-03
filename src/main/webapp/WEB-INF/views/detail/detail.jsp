<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="pageCSS" value="explore/explore.css"/>
<%@ include file="../common/header.jsp" %>

<body>
<style>
/* ── 히어로 ── */
.det-hero { position:relative; height:420px; overflow:hidden; background:var(--gray-200); }
.det-hero img { width:100%; height:100%; object-fit:cover; display:block; }
.det-hero-ov { position:absolute; inset:0; background:linear-gradient(to bottom,rgba(0,0,0,.1),rgba(0,0,0,.55)); }
.det-hero-content { position:absolute; bottom:36px; left:36px; right:36px; color:#fff; }
.det-hero-content h1 { font-size:2.4rem; font-weight:700; text-shadow:0 2px 8px rgba(0,0,0,.4); margin-bottom:8px; }
.det-hero-meta { display:flex; align-items:center; gap:16px; font-size:15px; font-weight:500; text-shadow:0 1px 4px rgba(0,0,0,.4); }
.det-hero-rat .star { color:#fbbf24; font-size:18px; }

/* ── 본문 ── */
.det-body { max-width:960px; margin:0 auto; padding:40px 24px 80px; }

/* ── 액션 버튼 ── */
.det-actions { display:flex; gap:12px; margin-bottom:36px; flex-wrap:wrap; }
.det-action-btn {
  display:flex; align-items:center; gap:8px;
  padding:10px 20px; border-radius:10px;
  border:1.5px solid var(--gray-200); background:#fff;
  font-family:inherit; font-size:14px; font-weight:500; color:var(--gray-700);
  cursor:pointer; transition:all .2s; box-shadow:var(--shadow-sm);
}
.det-action-btn:hover { border-color:var(--blue); color:var(--blue); }
.det-action-btn.active { background:var(--blue-light); color:var(--blue); border-color:var(--blue); }
.det-back-btn {
  background:none; border:none; color:var(--gray-500); font-family:inherit;
  font-size:14px; font-weight:500; cursor:pointer; padding:0;
  display:flex; align-items:center; gap:4px; margin-bottom:24px; transition:color .15s;
}
.det-back-btn:hover { color:var(--blue); }

/* ── 섹션 카드 ── */
.det-section {
  background:#fff; border-radius:var(--radius);
  padding:28px 32px; margin-bottom:24px;
  box-shadow:var(--shadow-sm); border:1px solid var(--gray-100);
}
.det-section h2 {
  font-size:1.1rem; font-weight:700; color:var(--gray-800);
  margin-bottom:16px; padding-bottom:12px; border-bottom:1px solid var(--gray-100);
}

/* ── 정보 그리드 ── */
.info-grid { display:grid; gap:14px; }
.info-row { display:flex; align-items:flex-start; gap:12px; font-size:14px; }
.info-label { width:70px; flex-shrink:0; color:var(--gray-500); font-weight:500; }
.info-value { color:var(--gray-700); line-height:1.6; }
.det-desc { font-size:15px; color:var(--gray-700); line-height:1.8; }
.det-tags { display:flex; flex-wrap:wrap; gap:8px; }

/* ── 지도 플레이스홀더 ── */
.map-placeholder {
  width:100%; height:220px;
  background:linear-gradient(135deg,var(--blue-light),#f5f3ff);
  border-radius:10px; display:flex; align-items:center; justify-content:center;
  font-size:14px; color:var(--gray-500); flex-direction:column; gap:8px;
}
.map-placeholder .map-icon { font-size:36px; }

/* ── 리뷰 요약 헤더 ── */
.review-summary-wrap {
  display:flex; align-items:center; gap:32px;
  padding-bottom:24px; margin-bottom:24px;
  border-bottom:1px solid var(--gray-100); flex-wrap:wrap;
}
.review-big-score { font-size:3.2rem; font-weight:800; color:var(--blue); line-height:1; }
.review-stars-big { font-size:22px; letter-spacing:3px; margin:6px 0 4px; }
.review-sub { font-size:13px; color:var(--gray-400); }

/* ── 별점 선택기 (리뷰 작성) ── */
.star-picker { display:flex; gap:6px; margin-bottom:12px; }
.star-picker .sp { font-size:28px; cursor:pointer; color:var(--gray-200); transition:color .1s; }
.star-picker .sp.on { color:#f59e0b; }

/* ── 리뷰 작성 폼 ── */
.review-form-box {
  background:var(--gray-50); border-radius:10px;
  padding:20px; margin-bottom:28px;
  border:1.5px solid var(--gray-200);
}
.review-form-box h3 { font-size:15px; font-weight:700; margin-bottom:14px; color:var(--gray-800); }
.review-textarea {
  width:100%; min-height:90px;
  padding:12px 14px; border:1.5px solid var(--gray-200);
  border-radius:9px; font-family:inherit; font-size:14px;
  resize:vertical; outline:none; transition:border-color .2s;
  background:#fff;
}
.review-textarea:focus { border-color:var(--blue); }
.review-form-foot { display:flex; justify-content:space-between; align-items:center; margin-top:10px; flex-wrap:wrap; gap:8px; }
.review-char { font-size:12px; color:var(--gray-400); }
.review-submit-btn {
  padding:9px 22px; border-radius:9px; border:none;
  background:var(--blue); color:#fff; font-family:inherit;
  font-size:14px; font-weight:600; cursor:pointer; transition:background .2s;
}
.review-submit-btn:hover { background:#1d4ed8; }
.review-submit-btn:disabled { opacity:.5; cursor:not-allowed; }

/* ── 로그인 유도 박스 ── */
.review-login-box {
  background:var(--blue-light); border-radius:10px;
  padding:20px 24px; margin-bottom:28px;
  display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:12px;
  border:1.5px solid #bfdbfe;
}
.review-login-box p { font-size:14px; color:var(--blue); font-weight:500; margin:0; }
.review-login-link {
  padding:8px 18px; border-radius:8px;
  background:var(--blue); color:#fff; font-size:14px; font-weight:600;
  text-decoration:none; transition:background .2s;
  white-space:nowrap;
}
.review-login-link:hover { background:#1d4ed8; }

/* ── 리뷰 카드 목록 ── */
.review-list { display:flex; flex-direction:column; gap:16px; }
.review-card {
  padding:18px 20px; border-radius:10px;
  background:var(--gray-50); border:1px solid var(--gray-200);
}
.review-card-top { display:flex; align-items:center; justify-content:space-between; margin-bottom:8px; flex-wrap:wrap; gap:8px; }
.review-author-info { display:flex; align-items:center; gap:10px; }
.review-avatar {
  width:36px; height:36px; border-radius:50%;
  background:linear-gradient(135deg,var(--blue),var(--purple));
  display:flex; align-items:center; justify-content:center;
  color:#fff; font-weight:700; font-size:14px; flex-shrink:0;
}
.review-nickname { font-size:14px; font-weight:600; color:var(--gray-800); }
.review-date { font-size:12px; color:var(--gray-400); margin-top:1px; }
.review-stars-small { font-size:14px; letter-spacing:1px; }
.review-content { font-size:14px; color:var(--gray-700); line-height:1.65; margin-top:8px; }
.review-delete-btn {
  background:none; border:none; color:var(--gray-400);
  font-size:12px; cursor:pointer; padding:4px 8px;
  border-radius:6px; transition:all .15s;
}
.review-delete-btn:hover { background:#fee2e2; color:#ef4444; }
.review-empty { text-align:center; padding:36px; color:var(--gray-400); font-size:14px; }

/* ── 반응형 ── */
@media (max-width:640px) {
  .det-hero { height:280px; }
  .det-hero-content h1 { font-size:1.6rem; }
  .det-hero-content { left:20px; right:20px; bottom:20px; }
  .det-body { padding:24px 16px 60px; }
  .det-section { padding:20px; }
}
</style>

<!-- 히어로 이미지 -->
<div class="det-hero">
  <img src="${not empty spot.thumbUrl
             ? spot.thumbUrl
             : 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=1200&q=80'}"
       alt="${fn:escapeXml(spot.name)}"
       onerror="this.src='https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=1200&q=80'">
  <div class="det-hero-ov"></div>
  <div class="det-hero-content">
    <h1>${fn:escapeXml(spot.name)}</h1>
    <div class="det-hero-meta">
      <c:if test="${not empty spot.region}">
        <span>${fn:escapeXml(spot.region)}</span>
      </c:if>
      <span class="det-hero-rat">
        <span class="star">&#11088;</span>
        <fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/>
        <span style="font-size:13px;opacity:.8">(${spot.reviewCount}개 리뷰)</span>
      </span>
      <span>&#10084; ${spot.likeCount}</span>
    </div>
  </div>
</div>

<!-- 상세 본문 -->
<div class="det-body">

  <button class="det-back-btn" onclick="history.back()">
    &#8592; 여행지 목록으로 돌아가기
  </button>

  <!-- 액션 버튼 -->
  <div class="det-actions">
    <button class="det-action-btn fav-btn ${spot.favorited ? 'active' : ''}"
            data-spot-idx="${spot.spotIdx}">
      <span>${spot.favorited ? '💛' : '🤍'}</span>
      <span>${spot.favorited ? '찜 완료' : '찜하기'}</span>
    </button>
    <button class="det-action-btn like-btn ${spot.liked ? 'active' : ''}"
            data-spot-idx="${spot.spotIdx}">
      <span>${spot.liked ? '❤️' : '🤍'}</span>
      <span>${spot.liked ? '좋아요 완료' : '좋아요'}</span>
    </button>
    <button class="det-action-btn"
            onclick="location.href='${pageContext.request.contextPath}/assistant'">
      &#10024; AI에게 여행 계획 짜기
    </button>
  </div>

  <!-- 기본 정보 -->
  <div class="det-section">
    <h2>&#127760; 기본 정보</h2>
    <div class="info-grid">
      <c:if test="${not empty spot.region}">
        <div class="info-row">
          <span class="info-label">지역</span>
          <span class="info-value">${fn:escapeXml(spot.region)}</span>
        </div>
      </c:if>
      <c:if test="${not empty spot.address}">
        <div class="info-row">
          <span class="info-label">주소</span>
          <span class="info-value">${fn:escapeXml(spot.address)}</span>
        </div>
      </c:if>
      <div class="info-row">
        <span class="info-label">평점</span>
        <span class="info-value">
          &#11088;
          <c:choose>
            <c:when test="${spot.reviewCount > 0}">
              <fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/> / 5.0
              &nbsp;(리뷰 ${spot.reviewCount}개)
            </c:when>
            <c:otherwise>아직 리뷰가 없습니다.</c:otherwise>
          </c:choose>
        </span>
      </div>
      <div class="info-row">
        <span class="info-label">좋아요</span>
        <span class="info-value">&#10084; ${spot.likeCount}개</span>
      </div>
    </div>
  </div>

  <!-- 소개 -->
  <c:if test="${not empty spot.description}">
    <div class="det-section">
      <h2>&#128214; 여행지 소개</h2>
      <p class="det-desc">${fn:escapeXml(spot.description)}</p>
    </div>
  </c:if>

  <!-- 태그 -->
  <c:if test="${not empty spot.tags}">
    <div class="det-section">
      <h2>&#127914; 테마 태그</h2>
      <div class="det-tags">
        <c:forEach var="tag" items="${spot.tags}">
          <span class="spot-tag">${fn:escapeXml(tag)}</span>
        </c:forEach>
      </div>
    </div>
  </c:if>

  <!-- 위치 -->
  <c:if test="${not empty spot.latitude and not empty spot.longitude and spot.latitude != 0 and spot.longitude != 0}">
    <div class="det-section">
      <h2>&#128506; 위치 &amp; 항공권</h2>

      <!-- 항공권 가격 배너 -->
      <div id="flightBanner" style="
          display:flex; align-items:center; gap:10px;
          background:linear-gradient(135deg,var(--blue-light),#f5f3ff);
          border:1.5px solid #c7d2fe; border-radius:10px;
          padding:12px 18px; margin-bottom:16px; font-size:14px;">
        <span style="font-size:20px;">✈️</span>
        <span id="flightText" style="color:var(--blue);font-weight:600;">
          서울(ICN) → ${fn:escapeXml(spot.name)} 항공권 최저가 조회 중...
        </span>
      </div>

      <!-- 지도 컨테이너 -->
      <div id="googleMap" style="
          width:100%; height:420px;
          border-radius:10px; overflow:hidden;
          border:1px solid var(--gray-200);
          background:var(--gray-100);">
      </div>
      <p style="font-size:12px;color:var(--gray-400);margin-top:8px;text-align:right;">
        마커를 클릭하면 서울에서의 항공 노선이 표시됩니다
      </p>
    </div>
  </c:if>

  <!-- ════════════════════════════════════════
       리뷰 섹션
       ════════════════════════════════════════ -->
  <div class="det-section">
    <h2>&#128172; 리뷰</h2>

    <!-- 리뷰 요약 -->
    <div class="review-summary-wrap">
      <div>
        <div class="review-big-score">
          <c:choose>
            <c:when test="${spot.reviewCount > 0}">
              <fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/>
            </c:when>
            <c:otherwise>-</c:otherwise>
          </c:choose>
        </div>
        <div class="review-stars-big">
          <c:choose>
            <c:when test="${spot.ratingAvg >= 4.5}">⭐⭐⭐⭐⭐</c:when>
            <c:when test="${spot.ratingAvg >= 3.5}">⭐⭐⭐⭐☆</c:when>
            <c:when test="${spot.ratingAvg >= 2.5}">⭐⭐⭐☆☆</c:when>
            <c:when test="${spot.ratingAvg >= 1.5}">⭐⭐☆☆☆</c:when>
            <c:when test="${spot.reviewCount > 0}">⭐☆☆☆☆</c:when>
            <c:otherwise>☆☆☆☆☆</c:otherwise>
          </c:choose>
        </div>
        <div class="review-sub">총 ${spot.reviewCount}개의 리뷰</div>
      </div>
    </div>

    <!-- 리뷰 작성 영역 -->
    <div id="reviewWriteArea">
    <c:choose>
      <%-- ① 로그인 O + 아직 리뷰 미작성 → 작성 폼 표시 --%>
      <c:when test="${canWrite}">
        <div class="review-form-box" id="reviewFormBox">
          <h3>&#9997; 리뷰 작성</h3>
          <div class="star-picker" id="starPicker">
            <span class="sp" data-v="1">&#9733;</span>
            <span class="sp" data-v="2">&#9733;</span>
            <span class="sp" data-v="3">&#9733;</span>
            <span class="sp" data-v="4">&#9733;</span>
            <span class="sp" data-v="5">&#9733;</span>
          </div>
          <textarea class="review-textarea" id="reviewContent"
                    maxlength="500" placeholder="여행지에 대한 솔직한 후기를 남겨주세요. (최대 500자)"></textarea>
          <div class="review-form-foot">
            <span class="review-char"><span id="charCount">0</span> / 500</span>
            <button class="review-submit-btn" id="reviewSubmitBtn" disabled>등록하기</button>
          </div>
        </div>
      </c:when>
      <%-- ② 로그인 O + 이미 리뷰 작성함 → 안내 문구 --%>
      <c:when test="${isLoggedIn and not canWrite}">
        <div id="alreadyReviewBox"
             style="background:var(--gray-50);border-radius:10px;padding:16px 20px;margin-bottom:28px;
                    font-size:14px;color:var(--gray-500);border:1px solid var(--gray-200);">
          &#10003; 이미 리뷰를 작성하셨습니다.
        </div>
      </c:when>
      <%-- ③ 비로그인 → 로그인 유도 --%>
      <c:otherwise>
        <div class="review-login-box">
          <p>&#128172; 리뷰를 작성하려면 로그인이 필요합니다.</p>
          <a href="${pageContext.request.contextPath}/auth/login" class="review-login-link">로그인하기</a>
        </div>
      </c:otherwise>
    </c:choose>
    </div><%-- /reviewWriteArea --%>

    <!-- 리뷰 목록 -->
    <div class="review-list" id="reviewList">
      <c:choose>
        <c:when test="${not empty reviewList}">
          <c:forEach var="rv" items="${reviewList}">
            <div class="review-card" id="rv-${rv.reviewIdx}">
              <div class="review-card-top">
                <div class="review-author-info">
                  <div class="review-avatar">
                    ${fn:substring(rv.nickname, 0, 1)}
                  </div>
                  <div>
                    <div class="review-nickname">${fn:escapeXml(rv.nickname)}</div>
                    <div class="review-date">
                      <fmt:formatDate value="${rv.createdAt}" pattern="yyyy.MM.dd" type="date"/>
                    </div>
                  </div>
                </div>
                <div style="display:flex;align-items:center;gap:10px;">
                  <span class="review-stars-small">
                    <c:forEach begin="1" end="5" var="i">
                      <c:choose>
                        <c:when test="${i <= rv.rating}">⭐</c:when>
                        <c:otherwise>☆</c:otherwise>
                      </c:choose>
                    </c:forEach>
                    (${rv.rating}/5)
                  </span>
                  <c:if test="${rv.userIdx == loginUserIdx}">
                    <button class="review-delete-btn"
                            data-review-idx="${rv.reviewIdx}"
                            data-spot-idx="${spot.spotIdx}">삭제</button>
                  </c:if>
                </div>
              </div>
              <p class="review-content">${fn:escapeXml(rv.content)}</p>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="review-empty" id="reviewEmpty">
            아직 작성된 리뷰가 없습니다. 첫 번째 리뷰를 남겨보세요! &#128512;
          </div>
        </c:otherwise>
      </c:choose>
    </div>

  </div><!-- /리뷰 섹션 -->

  <!-- 탐색 버튼 -->
  <div style="text-align:center;margin-top:32px;">
    <button class="det-action-btn"
            onclick="location.href='${pageContext.request.contextPath}/explore'"
            style="margin:0 auto;">
      &#128269; 다른 여행지 탐색하기
    </button>
  </div>

</div>

<!-- 토스트 -->
<div class="toast" id="toast"></div>

<%@ include file="../common/footer.jsp" %>

<script>
(function () {
  'use strict';

  const ctx      = '${pageContext.request.contextPath}';
  const spotIdx  = '${spot.spotIdx}';
  const loginUserIdx = '${loginUserIdx}';

  /* ── 토스트 ── */
  function showToast(msg) {
    const t = document.getElementById('toast');
    t.textContent = msg;
    t.classList.add('show');
    setTimeout(() => t.classList.remove('show'), 2500);
  }

  /* ══════════════════════════════════════
     찜 / 좋아요 토글
     ══════════════════════════════════════ */
  function toggleAction(endpoint, btn, onText, offText, onMsg, offMsg, key) {
    fetch(ctx + endpoint, { method: 'POST' })
      .then(r => r.json())
      .then(data => {
        if (!data.success) {
          showToast('로그인이 필요합니다 🔐');
          setTimeout(() => { window.location.href = ctx + '/auth/login'; }, 1500);
          return;
        }
        const active = data[key];
        btn.classList.toggle('active', active);
        btn.querySelector('span:last-child').textContent = active ? onText : offText;
        btn.querySelector('span:first-child').textContent =
            active ? (key === 'favorited' ? '💛' : '❤️') : '🤍';
        showToast(active ? onMsg : offMsg);
      })
      .catch(() => showToast('처리 중 오류가 발생했습니다.'));
  }

  const favBtn  = document.querySelector('.fav-btn');
  const likeBtn = document.querySelector('.like-btn');

  favBtn && favBtn.addEventListener('click', function () {
    toggleAction('/explore/favorite/' + spotIdx, this,
                 '찜 완료', '찜하기', '💛 찜 추가됨', '찜 취소됨', 'favorited');
  });

  likeBtn && likeBtn.addEventListener('click', function () {
    toggleAction('/explore/like/' + spotIdx, this,
                 '좋아요 완료', '좋아요', '❤️ 좋아요!', '좋아요 취소됨', 'liked');
  });

  /* ══════════════════════════════════════
     별점 선택기
     ══════════════════════════════════════ */
  let selectedRating = 0;

  function bindStarPicker() {
    const stars = document.querySelectorAll('#starPicker .sp');
    function renderStars(n) {
      stars.forEach(s => s.classList.toggle('on', parseInt(s.dataset.v) <= n));
    }
    stars.forEach(s => {
      s.addEventListener('mouseover', function () { renderStars(parseInt(this.dataset.v)); });
      s.addEventListener('mouseout',  function () { renderStars(selectedRating); });
      s.addEventListener('click',     function () {
        selectedRating = parseInt(this.dataset.v);
        renderStars(selectedRating);
        checkSubmit();
      });
    });
  }

  function checkSubmit() {
    const btn  = document.getElementById('reviewSubmitBtn');
    const area = document.getElementById('reviewContent');
    if (!btn || !area) return;
    btn.disabled = !(selectedRating > 0 && area.value.trim().length > 0);
  }

  /* ══════════════════════════════════════
     리뷰 등록
     ══════════════════════════════════════ */
  function bindSubmitBtn() {
    const textarea  = document.getElementById('reviewContent');
    const submitBtn = document.getElementById('reviewSubmitBtn');
    const charCount = document.getElementById('charCount');

    textarea && textarea.addEventListener('input', function () {
      if (charCount) charCount.textContent = this.value.length;
      checkSubmit();
    });

    submitBtn && submitBtn.addEventListener('click', function () {
      const content = textarea ? textarea.value.trim() : '';
      if (selectedRating === 0 || !content) return;

      submitBtn.disabled = true;
      submitBtn.textContent = '등록 중...';

      fetch(ctx + '/detail/' + spotIdx + '/review', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ rating: selectedRating, content: content })
      })
      .then(r => r.json())
      .then(data => {
        if (!data.success) {
          showToast(data.message || '등록 실패');
          submitBtn.disabled = false;
          submitBtn.textContent = '등록하기';
          return;
        }
        showToast('리뷰가 등록되었습니다 ✅');
        setTimeout(() => location.reload(), 800);
      })
      .catch(() => {
        showToast('처리 중 오류가 발생했습니다.');
        submitBtn.disabled = false;
        submitBtn.textContent = '등록하기';
      });
    });
  }

  // 페이지 최초 로드 시 폼이 있으면 바인딩
  if (document.getElementById('starPicker'))   bindStarPicker();
  if (document.getElementById('reviewSubmitBtn')) bindSubmitBtn();

  /* ══════════════════════════════════════
     리뷰 삭제
     ══════════════════════════════════════ */
  function bindDeleteBtns() {
    document.querySelectorAll('.review-delete-btn').forEach(btn => {
      btn.addEventListener('click', function () {
        if (!confirm('리뷰를 삭제하시겠습니까?')) return;
        const rIdx = this.dataset.reviewIdx;
        const sIdx = this.dataset.spotIdx;

        fetch(ctx + '/detail/' + sIdx + '/review/' + rIdx, { method: 'DELETE' })
          .then(r => r.json())
          .then(data => {
            if (!data.success) { showToast(data.message || '삭제 실패'); return; }

            // 1. 카드 제거
            const card = document.getElementById('rv-' + rIdx);
            card && card.remove();
            showToast('리뷰가 삭제되었습니다.');

            // 2. 리뷰 목록이 비었으면 빈 상태 메시지
            const list = document.getElementById('reviewList');
            if (list && list.querySelectorAll('.review-card').length === 0) {
              list.innerHTML = '<div class="review-empty">아직 작성된 리뷰가 없습니다. 첫 번째 리뷰를 남겨보세요! 😊</div>';
            }

            // 3. "이미 작성" 안내 박스 제거 → 작성 폼 복원
            const alreadyBox = document.getElementById('alreadyReviewBox');
            if (alreadyBox) alreadyBox.remove();
            showWriteForm();
          })
          .catch(() => showToast('처리 중 오류가 발생했습니다.'));
      });
    });
  }

  /* 리뷰 작성 폼을 #reviewWriteArea 안에 동적으로 생성 */
  function showWriteForm() {
    const area = document.getElementById('reviewWriteArea');
    if (!area) return;
    // 이미 폼이 있으면 중복 방지
    if (area.querySelector('#reviewFormBox')) return;

    area.innerHTML = `
      <div class="review-form-box" id="reviewFormBox">
        <h3>✏️ 리뷰 작성</h3>
        <div class="star-picker" id="starPicker">
          <span class="sp" data-v="1">★</span>
          <span class="sp" data-v="2">★</span>
          <span class="sp" data-v="3">★</span>
          <span class="sp" data-v="4">★</span>
          <span class="sp" data-v="5">★</span>
        </div>
        <textarea class="review-textarea" id="reviewContent"
                  maxlength="500" placeholder="여행지에 대한 솔직한 후기를 남겨주세요. (최대 500자)"></textarea>
        <div class="review-form-foot">
          <span class="review-char"><span id="charCount">0</span> / 500</span>
          <button class="review-submit-btn" id="reviewSubmitBtn" disabled>등록하기</button>
        </div>
      </div>`;

    // 새로 생성된 폼에 이벤트 재바인딩
    selectedRating = 0;
    bindStarPicker();
    bindSubmitBtn();
  }

  bindDeleteBtns();

})();
</script>

<%-- ═══════════════════════════════════════════════════════
     Google Maps + 항공권 가격 (위도/경도가 있는 경우만 로드)
     ═══════════════════════════════════════════════════════ --%>
<c:if test="${not empty spot.latitude and not empty spot.longitude and spot.latitude != 0 and spot.longitude != 0}">
<script>
/* ── 여행지 좌표 & 정보 (서버 → JS)
     fmt:formatNumber 으로 로케일 독립적인 숫자 문자열 생성 후 parseFloat ── */
const SPOT_LAT  = parseFloat('<fmt:formatNumber value="${spot.latitude}"  pattern="0.######" groupingUsed="false"/>');
const SPOT_LNG  = parseFloat('<fmt:formatNumber value="${spot.longitude}" pattern="0.######" groupingUsed="false"/>');
const SPOT_NAME = '<c:out value="${spot.name}" escapeXml="false"/>'.replace(/'/g, "\\'");
const SPOT_IDX  = '${spot.spotIdx}';
const CTX       = '${pageContext.request.contextPath}';

/* 서울 (인천, 출발지) */
const SEOUL_LAT = 37.5665;
const SEOUL_LNG = 126.9780;

let googleMap, destinationMarker, seoulMarker, routeLine, infoWindow;
let flightPrice = null;

/* ══════════════════════════════════════
   1. 항공권 가격 비동기 조회
   ══════════════════════════════════════ */
function fetchFlightPrice() {
  fetch(CTX + '/detail/' + SPOT_IDX + '/flight-price')
    .then(function(r) { return r.json(); })
    .then(function(data) {
      var banner = document.getElementById('flightText');
      if (!banner) return;
      if (data.success && data.price) {
        flightPrice = data.price;
        banner.textContent = '\u2708\uFE0F \uc11c\uc6b8(ICN) \u2192 ' + SPOT_NAME
                           + ' \ud56d\uacf5\uad8c \ucd5c\uc800\uac00: ' + flightPrice;
        if (infoWindow && destinationMarker) {
          infoWindow.setContent(buildInfoContent(flightPrice));
        }
      } else if (data.success && data.iata) {
        banner.textContent = '\u2708\uFE0F ' + SPOT_NAME + ' (' + data.iata
                           + ') \ud56d\uacf5\uad8c \uac00\uaca9 \uc815\ubcf4\ub97c \ucc3e\uc744 \uc218 \uc5c6\uc2b5\ub2c8\ub2e4.';
      } else {
        banner.textContent = '\u2708\uFE0F ' + SPOT_NAME
                           + ' \u2014 \ud56d\uacf5\uad8c \uc815\ubcf4\ub97c \ubd88\ub7ec\uc62c \uc218 \uc5c6\uc2b5\ub2c8\ub2e4.';
      }
    })
    .catch(function() {
      var banner = document.getElementById('flightText');
      if (banner) banner.textContent = '\u2708\uFE0F \ud56d\uacf5\uad8c \uc815\ubcf4\ub97c \ubd88\ub7ec\uc62c \uc218 \uc5c6\uc2b5\ub2c8\ub2e4.';
    });
}

/* ══════════════════════════════════════
   2. 마커 InfoWindow 내용
      ※ JSP EL 간섭을 피하기 위해 template literal 대신 문자열 연결 사용
   ══════════════════════════════════════ */
function buildInfoContent(price) {
  var priceHtml = price
    ? '<div style="font-size:14px;font-weight:600;color:#2563eb;">\ucd5c\uc800\uac00 ' + price + '</div>'
      + '<div style="font-size:11px;color:#6b7280;margin-top:2px;">\uc11c\uc6b8(ICN) \ucd9c\ubc1c \uae30\uc900</div>'
    : '<div style="font-size:13px;color:#6b7280;">\ud56d\uacf5\uad8c \uac00\uaca9 \uc870\ud68c \uc911...</div>';

  return '<div style="font-family:\'Noto Sans KR\',sans-serif;padding:8px 6px;min-width:170px;">'
       + '<div style="font-size:15px;font-weight:700;color:#1f2937;margin-bottom:6px;">'
       + '\u2708\uFE0F ' + SPOT_NAME
       + '</div>'
       + priceHtml
       + '</div>';
}

/* ══════════════════════════════════════
   3. Google Maps 초기화 콜백 (async defer 로드 완료 후 호출됨)
   ══════════════════════════════════════ */
function initMap() {
  /* 좌표 유효성 최종 확인 */
  if (isNaN(SPOT_LAT) || isNaN(SPOT_LNG)) {
    document.getElementById('googleMap').innerHTML =
      '<div style="display:flex;align-items:center;justify-content:center;height:100%;color:#6b7280;font-size:14px;">'
      + '\uc88c\ud45c \uc815\ubcf4\uac00 \uc5c6\uc2b5\ub2c8\ub2e4.</div>';
    return;
  }

  var destLatLng  = { lat: SPOT_LAT,  lng: SPOT_LNG  };
  var seoulLatLng = { lat: SEOUL_LAT, lng: SEOUL_LNG };

  /* 지도 생성 */
  googleMap = new google.maps.Map(document.getElementById('googleMap'), {
    center:            destLatLng,
    zoom:              5,
    mapTypeId:         'roadmap',
    zoomControl:       true,
    mapTypeControl:    false,
    streetViewControl: false,
    fullscreenControl: true
  });

  /* 두 지점 모두 포함하는 Bounds */
  var bounds = new google.maps.LatLngBounds();
  bounds.extend(new google.maps.LatLng(SPOT_LAT,  SPOT_LNG));
  bounds.extend(new google.maps.LatLng(SEOUL_LAT, SEOUL_LNG));
  googleMap.fitBounds(bounds, { top: 80, right: 60, bottom: 60, left: 60 });

  /* InfoWindow */
  infoWindow = new google.maps.InfoWindow({
    content: buildInfoContent(flightPrice)
  });

  /* ── 여행지 마커 (빨간 원) ── */
  destinationMarker = new google.maps.Marker({
    position:  destLatLng,
    map:       googleMap,
    title:     SPOT_NAME,
    icon: {
      path:         google.maps.SymbolPath.CIRCLE,
      scale:        14,
      fillColor:    '#ef4444',
      fillOpacity:  1,
      strokeColor:  '#ffffff',
      strokeWeight: 3
    },
    zIndex:    10,
    animation: google.maps.Animation.DROP
  });

  /* ── 서울 마커 (파란 원) ── */
  seoulMarker = new google.maps.Marker({
    position:  seoulLatLng,
    map:       googleMap,
    title:     '\uc11c\uc6b8 (\ucd9c\ubc1c\uc9c0)',
    icon: {
      path:         google.maps.SymbolPath.CIRCLE,
      scale:        11,
      fillColor:    '#2563eb',
      fillOpacity:  1,
      strokeColor:  '#ffffff',
      strokeWeight: 3
    },
    zIndex:    9,
    animation: google.maps.Animation.DROP
  });

  /* 서울 라벨 마커 */
  new google.maps.Marker({
    position: { lat: SEOUL_LAT + 1.8, lng: SEOUL_LNG },
    map:      googleMap,
    icon:     { path: google.maps.SymbolPath.CIRCLE, scale: 0 },
    label: {
      text:       '\uc11c\uc6b8',
      color:      '#1e40af',
      fontSize:   '13px',
      fontWeight: '700'
    }
  });

  /* ── 대권 노선 Polyline (초기 투명) ── */
  routeLine = new google.maps.Polyline({
    path:          [seoulLatLng, destLatLng],
    geodesic:      true,
    strokeColor:   '#2563eb',
    strokeOpacity: 0,
    strokeWeight:  2.5,
    icons: [{
      icon:   { path: 'M 0,-1 0,1', strokeOpacity: 1, scale: 3 },
      offset: '0',
      repeat: '18px'
    }],
    map: googleMap
  });

  /* ── 여행지 마커 클릭: InfoWindow + 노선 페이드인 ── */
  destinationMarker.addListener('click', function () {
    infoWindow.open(googleMap, destinationMarker);

    routeLine.setOptions({ strokeOpacity: 0 });
    var opacity = 0;
    var fadeIn = setInterval(function() {
      opacity += 0.08;
      routeLine.setOptions({ strokeOpacity: Math.min(opacity, 0.85) });
      if (opacity >= 0.85) clearInterval(fadeIn);
    }, 30);

    destinationMarker.setAnimation(google.maps.Animation.BOUNCE);
    setTimeout(function() { destinationMarker.setAnimation(null); }, 1400);
  });

  /* 지도 클릭: InfoWindow 닫기 + 노선 숨김 */
  googleMap.addListener('click', function () {
    infoWindow.close();
    routeLine.setOptions({ strokeOpacity: 0 });
  });
}
</script>

<!-- Google Maps JavaScript API (callback=initMap) -->
<script
  src="https://maps.googleapis.com/maps/api/js?key=${mapsApiKey}&callback=initMap&loading=async&language=ko&region=KR"
  async defer></script>

<script>
/* 항공권 가격 조회는 Maps 로드와 병렬 실행 */
fetchFlightPrice();
</script>
</c:if>

</body>
</html>
