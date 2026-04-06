<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="pageCSS" value="explore/explore.css"/>
<%@ include file="../common/header.jsp" %>

<body>

<!-- ============================================================
     페이지 헤더 + 검색창
     ============================================================ -->
<div class="exp-header">
  <div class="exp-header-inner">
    <h1>&#128205; 여행지 탐색</h1>

    <div class="search-wrap">
      <span class="search-icon">&#128269;</span>
      <input type="text"
             id="searchInput"
             class="search-input"
             placeholder="도시명, 지역명으로 검색..."
             value="${fn:escapeXml(search.keyword)}"
             autocomplete="off"/>
      <button class="search-clear ${not empty search.keyword ? 'visible' : ''}"
              id="searchClear"
              title="검색어 지우기">&#215;</button>
    </div>

    <!-- 탭 바 -->
    <div class="exp-tab-bar" role="tablist">
      <button class="exp-tab-btn ${search.tab == 'all'    ? 'active' : ''}"
              data-tab="all"    role="tab">&#10024; 전체</button>
      <button class="exp-tab-btn ${search.tab == 'region' ? 'active' : ''}"
              data-tab="region" role="tab">&#128205; 지역별</button>
      <button class="exp-tab-btn ${search.tab == 'theme'  ? 'active' : ''}"
              data-tab="theme"  role="tab">&#128506; 테마별</button>
      <button class="exp-tab-btn ${search.tab == 'rating' ? 'active' : ''}"
              data-tab="rating" role="tab">&#11088; 평점순</button>
      <button class="exp-tab-btn ${search.tab == 'likes'  ? 'active' : ''}"
              data-tab="likes"  role="tab">&#10084; 좋아요순</button>
      <c:if test="${not empty sessionScope.loginUser}">
      <button class="exp-tab-btn ${search.tab == 'ai' ? 'active' : ''}"
              data-tab="ai"     role="tab">&#x1F916; AI 맞춤추천</button>
      </c:if>
    </div>
  </div>
</div>

<!-- ============================================================
     탭 콘텐츠
     ============================================================ -->
<div class="exp-body">

  <!-- ── 전체 탭 ── -->
  <div id="tab-all" class="tab-panel ${search.tab == 'all' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count">
        전체 <strong>${totalCount}</strong>개의 여행지
        <c:if test="${not empty search.keyword}">
          — "<strong>${fn:escapeXml(search.keyword)}</strong>" 검색 결과
        </c:if>
      </p>
    </div>
    <div class="spot-grid" id="grid-all">
      <c:choose>
        <c:when test="${not empty spotList}">
          <c:forEach var="spot" items="${spotList}">
            <%@ include file="spotCard.jsp" %>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="empty-state" style="grid-column:1/-1">
            <div class="empty-icon">&#128205;</div>
            <p>검색 결과가 없습니다.<br>다른 검색어를 시도해 보세요.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- ── 지역별 탭 ── -->
  <div id="tab-region" class="tab-panel ${search.tab == 'region' ? 'active' : ''}">
    <div class="filter-row" id="regionFilters">
      <button class="filter-btn ${empty search.region ? 'active' : ''}"
              data-region="">전체</button>
      <c:forEach var="r" items="${regionList}">
        <button class="filter-btn ${search.region == r ? 'active' : ''}"
                data-region="${r}">${r}</button>
      </c:forEach>
    </div>
    <div class="result-bar">
      <p class="result-count">
        <c:choose>
          <c:when test="${not empty search.region}">
            <strong>${fn:escapeXml(search.region)}</strong> 지역
          </c:when>
          <c:otherwise>전체 지역</c:otherwise>
        </c:choose>
        — <strong>${totalCount}</strong>개
      </p>
    </div>
    <div class="spot-grid" id="grid-region">
      <c:choose>
        <c:when test="${not empty spotList}">
          <c:forEach var="spot" items="${spotList}">
            <%@ include file="spotCard.jsp" %>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="empty-state" style="grid-column:1/-1">
            <div class="empty-icon">&#127758;</div>
            <p>해당 지역의 여행지가 없습니다.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- ── 테마별 탭 ── -->
  <div id="tab-theme" class="tab-panel ${search.tab == 'theme' ? 'active' : ''}">
    <div class="filter-row" id="themeFilters">
      <button class="filter-btn ${empty search.theme ? 'active' : ''}"
              data-theme="">전체</button>
      <c:forEach var="tag" items="${tagList}">
        <button class="filter-btn ${search.theme == tag ? 'active' : ''}"
                data-theme="${tag}">${tag}</button>
      </c:forEach>
    </div>
    <div class="result-bar">
      <p class="result-count">
        <c:choose>
          <c:when test="${not empty search.theme}">
            테마: <strong>${fn:escapeXml(search.theme)}</strong>
          </c:when>
          <c:otherwise>전체 테마</c:otherwise>
        </c:choose>
        — <strong>${totalCount}</strong>개
      </p>
    </div>
    <div class="spot-grid" id="grid-theme">
      <c:choose>
        <c:when test="${not empty spotList}">
          <c:forEach var="spot" items="${spotList}">
            <%@ include file="spotCard.jsp" %>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="empty-state" style="grid-column:1/-1">
            <div class="empty-icon">&#127914;</div>
            <p>해당 테마의 여행지가 없습니다.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- ── 평점순 탭 ── -->
  <div id="tab-rating" class="tab-panel ${search.tab == 'rating' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count">
        &#11088; 리뷰 평점 높은 순 — <strong>${totalCount}</strong>개
      </p>
    </div>
    <div class="spot-grid" id="grid-rating">
      <c:choose>
        <c:when test="${not empty spotList}">
          <c:forEach var="spot" items="${spotList}">
            <%@ include file="spotCard.jsp" %>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="empty-state" style="grid-column:1/-1">
            <div class="empty-icon">&#11088;</div>
            <p>아직 평점이 등록된 여행지가 없습니다.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- ── 좋아요순 탭 ── -->
  <div id="tab-likes" class="tab-panel ${search.tab == 'likes' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count">
        &#10084; 좋아요 많은 순 — <strong>${totalCount}</strong>개
      </p>
    </div>
    <div class="spot-grid" id="grid-likes">
      <c:choose>
        <c:when test="${not empty spotList}">
          <c:forEach var="spot" items="${spotList}">
            <%@ include file="spotCard.jsp" %>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="empty-state" style="grid-column:1/-1">
            <div class="empty-icon">&#10084;</div>
            <p>아직 좋아요가 등록된 여행지가 없습니다.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- ── AI 맞춤 추천 탭 (로그인 사용자만) ── -->
  <c:if test="${not empty sessionScope.loginUser}">
  <div id="tab-ai" class="tab-panel ${search.tab == 'ai' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count">
        &#x1F916; 회원님의 관심사를 분석한 <strong>AI 맞춤 추천</strong>
      </p>
    </div>
    <!-- 로딩 상태 -->
    <div id="aiLoadingMsg" style="text-align:center;padding:60px 24px;color:var(--gray-400);">
      <div style="font-size:40px;margin-bottom:12px;">&#x1F916;</div>
      <p style="font-size:15px;">AI가 회원님의 여행 취향을 분석 중입니다...</p>
    </div>
    <!-- 추천 카드 그리드 -->
    <div class="spot-grid" id="aiGrid" style="display:none;"></div>
    <!-- 빈 상태 -->
    <div id="aiEmptyMsg" style="display:none;text-align:center;padding:60px 24px;color:var(--gray-400);">
      <div style="font-size:40px;margin-bottom:12px;">✈️</div>
      <p style="font-size:15px;">
        아직 방문 기록이 부족합니다.<br>
        여행지 상세 페이지를 더 둘러보시면 맞춤 추천을 드릴게요!
      </p>
      <button class="exp-tab-btn" style="margin-top:16px;background:#fff;border:1.5px solid var(--blue);color:var(--blue);"
              onclick="document.querySelector('[data-tab=all]').click()">
        전체 여행지 보기
      </button>
    </div>
  </div>
  </c:if>

  <!-- ── 페이지네이션 ── -->
  <c:if test="${totalPage > 1}">
    <div class="pagination" id="pagination">
      <!-- 이전 -->
      <button class="page-btn"
              data-page="${currentPage - 1}"
              ${currentPage <= 1 ? 'disabled' : ''}
              title="이전">&#8592;</button>

      <!-- 페이지 번호 -->
      <c:set var="startPage" value="${currentPage - 2 > 1 ? currentPage - 2 : 1}"/>
      <c:set var="endPage"   value="${startPage + 4 < totalPage ? startPage + 4 : totalPage}"/>

      <c:if test="${startPage > 1}">
        <button class="page-btn" data-page="1">1</button>
        <c:if test="${startPage > 2}"><span style="color:var(--gray-400);padding:0 4px">…</span></c:if>
      </c:if>

      <c:forEach begin="${startPage}" end="${endPage}" var="pg">
        <button class="page-btn ${pg == currentPage ? 'active' : ''}"
                data-page="${pg}">${pg}</button>
      </c:forEach>

      <c:if test="${endPage < totalPage}">
        <c:if test="${endPage < totalPage - 1}"><span style="color:var(--gray-400);padding:0 4px">…</span></c:if>
        <button class="page-btn" data-page="${totalPage}">${totalPage}</button>
      </c:if>

      <!-- 다음 -->
      <button class="page-btn"
              data-page="${currentPage + 1}"
              ${currentPage >= totalPage ? 'disabled' : ''}
              title="다음">&#8594;</button>
    </div>
  </c:if>

</div><!-- /exp-body -->

<!-- 로딩 오버레이 -->
<div class="loading-overlay" id="loadingOverlay">
  <div class="spinner"></div>
</div>

<!-- 토스트 알림 -->
<div class="toast" id="toast"></div>

<%@ include file="../common/footer.jsp" %>

<!-- ============================================================
     JavaScript
     ============================================================ -->
<script>
  (function () {
    'use strict';

    const ctx          = '${pageContext.request.contextPath}';
    const currentTab   = '${search.tab}';
    const savedRegion  = '${search.region}';
    const savedTheme   = '${search.theme}';

    const overlay      = document.getElementById('loadingOverlay');
    const searchInput  = document.getElementById('searchInput');
    const searchClear  = document.getElementById('searchClear');

    /* ── 로딩 ── */
    function showLoading(on) { overlay.classList.toggle('show', on); }

    /* ★ 뒤로가기 / bfcache 복원 시 로딩 오버레이 즉시 제거 */
    window.addEventListener('pageshow', function () { showLoading(false); });

    /* ── 토스트 ── */
    function showToast(msg) {
      const t = document.getElementById('toast');
      t.textContent = msg;
      t.classList.add('show');
      setTimeout(() => t.classList.remove('show'), 2500);
    }

    /* ── navigate : URLSearchParams 직접 생성 ── */
    function navigate(params) {
      showLoading(true);
      const q = new URLSearchParams();
      /* tab은 항상 포함 */
      q.set('tab', params.tab || 'all');
      if (params.keyword && params.keyword !== '') q.set('keyword', params.keyword);
      if (params.region  && params.region  !== '') q.set('region',  params.region);
      if (params.theme   && params.theme   !== '') q.set('theme',   params.theme);
      if (params.page    && params.page    >  1)   q.set('page',    params.page);
      window.location.href = ctx + '/explore?' + q.toString();
    }

    /* ── 현재 상태로 params 합성 ── */
    function mergedParams(overrides) {
      return Object.assign({
        tab:    currentTab,
        keyword: searchInput.value.trim(),
        region:  savedRegion,
        theme:   savedTheme
      }, overrides);
    }

    /* ── 탭 전환 (지역·테마 필터는 초기화) ── */
    document.querySelectorAll('.exp-tab-btn').forEach(btn => {
      btn.addEventListener('click', function () {
        const tab = this.dataset.tab;
        if (tab === currentTab) return;
        navigate({ tab: tab, keyword: searchInput.value.trim() });
      });
    });

    /* ── 검색 (디바운스 500ms) ── */
    let searchTimer;
    searchInput.addEventListener('input', function () {
      searchClear.classList.toggle('visible', this.value.length > 0);
      clearTimeout(searchTimer);
      searchTimer = setTimeout(() => {
        navigate(mergedParams({ keyword: this.value.trim(), page: 1 }));
      }, 500);
    });
    searchInput.addEventListener('keydown', function (e) {
      if (e.key === 'Enter') {
        clearTimeout(searchTimer);
        navigate(mergedParams({ keyword: this.value.trim(), page: 1 }));
      }
    });
    searchClear.addEventListener('click', function () {
      searchInput.value = '';
      searchClear.classList.remove('visible');
      navigate(mergedParams({ keyword: '', page: 1 }));
    });

    /* ── 지역별 소분류 필터 ── */
    document.querySelectorAll('#regionFilters .filter-btn').forEach(btn => {
      btn.addEventListener('click', function () {
        navigate({ tab: 'region', region: this.dataset.region,
                   keyword: searchInput.value.trim(), page: 1 });
      });
    });

    /* ── 테마별 소분류 필터 ── */
    document.querySelectorAll('#themeFilters .filter-btn').forEach(btn => {
      btn.addEventListener('click', function () {
        navigate({ tab: 'theme', theme: this.dataset.theme,
                   keyword: searchInput.value.trim(), page: 1 });
      });
    });

    /* ── 페이지네이션 ── */
    document.querySelectorAll('#pagination .page-btn:not(:disabled)').forEach(btn => {
      btn.addEventListener('click', function () {
        const p = parseInt(this.dataset.page, 10);
        if (!isNaN(p)) navigate(mergedParams({ page: p }));
      });
    });

    /* ── 카드 클릭 → /detail/{spotIdx} ── */
    document.querySelectorAll('.spot-card[data-spot-idx]').forEach(card => {
      card.addEventListener('click', function (e) {
        if (e.target.closest('.action-btn')) return;
        window.location.href = ctx + '/detail/' + this.dataset.spotIdx;
      });
    });

    /* ── 찜 토글 ── */
    document.querySelectorAll('.fav-btn').forEach(btn => {
      btn.addEventListener('click', function (e) {
        e.stopPropagation();
        const idx = this.closest('.spot-card').dataset.spotIdx;
        toggleAction('/explore/favorite/' + idx, this,
                     '💛', '🤍', '찜 추가됨', '찜 취소됨', 'favorited');
      });
    });

    /* ── 좋아요 토글 ── */
    document.querySelectorAll('.like-btn').forEach(btn => {
      btn.addEventListener('click', function (e) {
        e.stopPropagation();
        const idx = this.closest('.spot-card').dataset.spotIdx;
        toggleAction('/explore/like/' + idx, this,
                     '❤️', '🤍', '좋아요!', '좋아요 취소됨', 'liked');
      });
    });

    function toggleAction(endpoint, btn, onIcon, offIcon, onMsg, offMsg, key) {
      fetch(ctx + endpoint, { method: 'POST' })
        .then(r => r.json())
        .then(data => {
          if (!data.success) {
            showToast('로그인이 필요합니다 🔐');
            setTimeout(() => { window.location.href = ctx + '/auth/login'; }, 1500);
            return;
          }
          const active = data[key];
          btn.textContent = active ? onIcon : offIcon;
          btn.classList.toggle('active', active);
          showToast(active ? onMsg : offMsg);
        })
        .catch(() => showToast('처리 중 오류가 발생했습니다.'));
    }

  })();
</script>

<%-- AI 맞춤 추천 탭 로직 (로그인 사용자만) --%>
<c:if test="${not empty sessionScope.loginUser}">
<script>
(function() {
  var CTX_AI = '${pageContext.request.contextPath}';
  var aiLoaded = false;

  function escHtml(str) {
    if (!str) return '';
    return String(str)
      .replace(/&/g,'&amp;').replace(/</g,'&lt;')
      .replace(/>/g,'&gt;').replace(/"/g,'&quot;');
  }

  function buildAiCard(spot) {
    var thumb = spot.thumbUrl ||
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600&q=80';
    var tags = (spot.tags || []).slice(0, 3).map(function(t) {
      return '<span class="spot-tag">' + escHtml(t) + '</span>';
    }).join('');
    var rating = (spot.ratingAvg || 0).toFixed(1);
    var reason = spot.recReason
      ? '<p style="font-size:12px;color:var(--blue);margin:6px 0 0;">&#x1F916; ' + escHtml(spot.recReason) + '</p>'
      : '';

    return '<div class="spot-card" style="cursor:pointer;"' +
      ' onclick="location.href=\'' + CTX_AI + '/detail/' + spot.spotIdx + '\'">' +
      '<div class="spot-card__img-wrap">' +
        '<img class="spot-card__img" src="' + escHtml(thumb) + '"' +
          ' alt="' + escHtml(spot.spotName) + '"' +
          ' onerror="this.src=\'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600&q=80\'">' +
        (spot.region ? '<span class="spot-card__region-badge">' + escHtml(spot.region) + '</span>' : '') +
      '</div>' +
      '<div class="spot-card__body">' +
        '<div class="spot-card__top">' +
          '<div class="spot-card__name">' + escHtml(spot.spotName) + '</div>' +
          '<div class="spot-card__rating"><span class="star">&#11088;</span>' + rating +
            '<span class="spot-card__review-cnt">(' + (spot.reviewCount || 0) + ')</span></div>' +
        '</div>' +
        reason +
        '<div class="spot-card__tags" style="margin-top:8px;">' + tags + '</div>' +
      '</div>' +
    '</div>';
  }

  function loadAiRecommendations() {
    if (aiLoaded) return;
    aiLoaded = true;

    fetch(CTX_AI + '/recommend/spots')
      .then(function(r) { return r.json(); })
      .then(function(data) {
        var loading = document.getElementById('aiLoadingMsg');
        var grid    = document.getElementById('aiGrid');
        var empty   = document.getElementById('aiEmptyMsg');

        if (!data.success || !data.spots || data.spots.length === 0) {
          if (loading) loading.style.display = 'none';
          if (empty)   empty.style.display   = 'block';
          return;
        }
        if (grid) {
          grid.innerHTML   = data.spots.map(buildAiCard).join('');
          grid.style.display = '';
        }
        if (loading) loading.style.display = 'none';
      })
      .catch(function() {
        var loading = document.getElementById('aiLoadingMsg');
        if (loading) loading.textContent = '추천 정보를 불러오지 못했습니다.';
      });
  }

  /* AI 탭 클릭 시 추천 로드 */
  var aiTabBtn = document.querySelector('[data-tab="ai"]');
  if (aiTabBtn) {
    aiTabBtn.addEventListener('click', function() {
      /* 탭 전환은 기존 navigate()가 처리하지만,
         AI 탭은 서버 렌더링 없이 프론트에서 직접 처리 */
      document.querySelectorAll('.exp-tab-btn').forEach(function(b) {
        b.classList.remove('active');
      });
      aiTabBtn.classList.add('active');

      document.querySelectorAll('.tab-panel').forEach(function(p) {
        p.classList.remove('active');
      });
      var aiPanel = document.getElementById('tab-ai');
      if (aiPanel) aiPanel.classList.add('active');

      /* 로딩 오버레이 없이 패널 내에서 로딩 표시 */
      loadAiRecommendations();

      /* URL에 tab=ai 반영 (뒤로가기 지원) */
      history.pushState(null, '', window.location.pathname + '?tab=ai');
    });
  }

  /* 페이지 진입 시 tab=ai면 자동 로드 */
  if (new URLSearchParams(window.location.search).get('tab') === 'ai') {
    loadAiRecommendations();
  }
})();
</script>
</c:if>

</body>
</html>
