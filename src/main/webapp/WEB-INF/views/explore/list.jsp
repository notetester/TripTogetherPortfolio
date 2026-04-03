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

</body>
</html>
