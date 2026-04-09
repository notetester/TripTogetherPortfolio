<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="pageCSS" value="explore/explore.css"/>
<%@ include file="../common/header.jsp" %>

<body>
<div class="exp-header">
  <div class="exp-header-inner">
    <h1>&#128205; 여행지 탐색</h1>

    <div class="search-wrap">
      <span class="search-icon">&#128269;</span>
      <input type="text"
             id="searchInput"
             class="search-input"
             placeholder="도시, 지역, 주소로 검색"
             value="${fn:escapeXml(search.keyword)}"
             autocomplete="off"/>
      <button class="search-clear ${not empty search.keyword ? 'visible' : ''}"
              id="searchClear"
              title="검색 초기화">&#215;</button>
    </div>

    <div class="exp-header-actions">
      <p class="exp-header-note">찾는 여행지가 없다면, 새로운 여행지를 커뮤니티와 공유해보세요.</p>
      <c:if test="${not empty sessionScope.loginUser}">
        <button type="button" class="exp-primary-btn" id="openSpotWriteBtn">
          &#9998; 여행지 추가
        </button>
      </c:if>
    </div>

    <div class="exp-tab-bar" role="tablist">
      <button class="exp-tab-btn ${search.tab == 'all' ? 'active' : ''}" data-tab="all" role="tab">&#10024; 전체</button>
      <button class="exp-tab-btn ${search.tab == 'region' ? 'active' : ''}" data-tab="region" role="tab">&#128205; 지역별</button>
      <button class="exp-tab-btn ${search.tab == 'theme' ? 'active' : ''}" data-tab="theme" role="tab">&#128506; 테마별</button>
      <button class="exp-tab-btn ${search.tab == 'rating' ? 'active' : ''}" data-tab="rating" role="tab">&#11088; 평점순</button>
      <button class="exp-tab-btn ${search.tab == 'likes' ? 'active' : ''}" data-tab="likes" role="tab">&#10084; 좋아요순</button>
      <c:if test="${not empty sessionScope.loginUser}">
        <button class="exp-tab-btn ${search.tab == 'ai' ? 'active' : ''}" data-tab="ai" role="tab">&#x1F916; AI 추천</button>
      </c:if>
    </div>
  </div>
</div>

<c:if test="${not empty sessionScope.loginUser}">
<div class="spot-write-modal ${openWriteModal ? 'show' : ''}" id="spotWriteModal">
  <div class="spot-write-dialog">
    <div class="spot-write-head">
      <div>
        <h2>여행지 추가</h2>
        <p>위치를 검색한 후, 여행지 정보를 입력해주세요.</p>
      </div>
      <button type="button" class="spot-write-close" id="closeSpotWriteBtn" aria-label="닫기">&#215;</button>
    </div>

    <c:if test="${not empty writeError}">
      <div class="spot-write-alert">${fn:escapeXml(writeError)}</div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/explore/write"
          enctype="multipart/form-data"
          class="spot-write-form" id="spotWriteForm">
      <c:set var="selectedWriteTags" value="${empty writeForm.tags ? '' : fn:join(writeForm.tags, '|')}"/>
      <div class="spot-write-grid">
        <div class="spot-write-fields">
        <label class="spot-write-label">위치 검색</label>
          <%-- 새 Google Places API: PlaceAutocompleteElement가 여기에 삽입됩니다 --%>
          <div id="spotLocationSearchWrap"></div>
          <p class="spot-write-help">검색 결과를 선택하면 주소와 좌표가 자동으로 입력됩니다.</p>

          <label class="spot-write-label" for="spotName">여행지 이름</label>
          <input type="text" id="spotName" name="name" maxlength="100"
                 value="${fn:escapeXml(writeForm.name)}" placeholder="예) N서울타워" required>

          <label class="spot-write-label" for="spotRegion">지역</label>
          <input type="text" id="spotRegion" name="region" maxlength="100"
                 value="${fn:escapeXml(writeForm.region)}" placeholder="예) 대한민국" required>

          <label class="spot-write-label" for="spotAddress">주소</label>
          <input type="text" id="spotAddress" name="address" maxlength="255"
                 value="${fn:escapeXml(writeForm.address)}" placeholder="선택된 주소" required>

          <div class="spot-write-coords">
            <div>
              <label class="spot-write-label" for="spotLatitude">위도</label>
              <input type="text" id="spotLatitude" value="${writeForm.latitude}" readonly>
            </div>
            <div>
              <label class="spot-write-label" for="spotLongitude">경도</label>
              <input type="text" id="spotLongitude" value="${writeForm.longitude}" readonly>
            </div>
          </div>

          <input type="hidden" id="spotLatitudeHidden" name="latitude" value="${writeForm.latitude}">
          <input type="hidden" id="spotLongitudeHidden" name="longitude" value="${writeForm.longitude}">

          <label class="spot-write-label" for="spotDescription">설명</label>
          <textarea id="spotDescription" name="description" maxlength="2000"
                    placeholder="여행지의 분위기, 볼거리, 방문 팁 등을 작성해주세요." required>${fn:escapeXml(writeForm.description)}</textarea>
          <label class="spot-write-label">태그 선택</label>
          <div class="spot-write-tag-picker">
            <c:forEach var="tag" items="${writeTagList}">
              <label class="spot-write-tag-option">
                <input type="checkbox" name="tags" value="${fn:escapeXml(tag)}"
                       <c:if test="${fn:contains(selectedWriteTags, tag)}">checked</c:if>>
                <span>${fn:escapeXml(tag)}</span>
              </label>
            </c:forEach>
          </div>
          <p class="spot-write-help">최대 4개의 태그를 선택 할 수 있습니다.</p>
        </div>

        <%-- ── 이미지 업로드 영역 (기존 지도 영역 대체) ── --%>
        <div class="spot-write-image-wrap">
          <label class="spot-write-label">여행지 이미지</label>
          <div class="spot-image-upload-area" id="spotImageDropZone">
            <div class="spot-image-preview" id="spotImagePreview" style="display:none;">
              <img id="spotPreviewImg" src="" alt="미리보기">
              <button type="button" class="spot-image-remove-btn" id="spotImageRemoveBtn">&#215;</button>
            </div>
            <div class="spot-image-placeholder" id="spotImagePlaceholder">
              <span style="font-size:48px;">&#128247;</span>
              <p>클릭하거나 이미지를 드래그하여 업로드</p>
              <p class="spot-write-help">JPG, PNG, GIF, WEBP (최대 10MB)</p>
            </div>
            <input type="file" id="spotImageFile" name="image"
                   accept=".jpg,.jpeg,.png,.gif,.webp" style="display:none;">
          </div>
        </div>
      </div>

      <div class="spot-write-actions">
        <button type="button" class="exp-secondary-btn" id="cancelSpotWriteBtn">취소</button>
        <button type="submit" class="exp-primary-btn">여행지 저장</button>
      </div>
    </form>
  </div>
</div>
</c:if>

<div class="exp-body">
  <div id="tab-all" class="tab-panel ${search.tab == 'all' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count">
        <strong>${totalCount}</strong>개의 여행지
        <c:if test="${not empty search.keyword}">
          "<strong>${fn:escapeXml(search.keyword)}</strong>" 검색 결과
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
            <p>검색 결과에 해당하는 여행지가 없습니다.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div id="tab-region" class="tab-panel ${search.tab == 'region' ? 'active' : ''}">
    <div class="filter-row" id="regionFilters">
      <button class="filter-btn ${empty search.region ? 'active' : ''}" data-region="">전체</button>
      <c:forEach var="r" items="${regionList}">
        <button class="filter-btn ${search.region == r ? 'active' : ''}" data-region="${r}">${r}</button>
      </c:forEach>
    </div>
    <div class="result-bar">
      <p class="result-count">
        <c:choose>
          <c:when test="${not empty search.region}">
            지역 <strong>${fn:escapeXml(search.region)}</strong>
          </c:when>
          <c:otherwise>전체 지역</c:otherwise>
        </c:choose>
        , <strong>${totalCount}</strong>개의 여행지
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
            <p>이 지역에 해당하는 여행지가 없습니다.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div id="tab-theme" class="tab-panel ${search.tab == 'theme' ? 'active' : ''}">
    <div class="filter-row" id="themeFilters">
      <button class="filter-btn ${empty search.theme ? 'active' : ''}" data-theme="">전체</button>
      <c:forEach var="tag" items="${tagList}">
        <button class="filter-btn ${search.theme == tag ? 'active' : ''}" data-theme="${tag}">${tag}</button>
      </c:forEach>
    </div>
    <div class="result-bar">
      <p class="result-count">
        <c:choose>
          <c:when test="${not empty search.theme}">
            테마 <strong>${fn:escapeXml(search.theme)}</strong>
          </c:when>
          <c:otherwise>전체 테마</c:otherwise>
        </c:choose>
        , <strong>${totalCount}</strong>개의 여행지
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
            <p>이 테마에 해당하는 여행지가 없습니다.</p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div id="tab-rating" class="tab-panel ${search.tab == 'rating' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count">평점 높은 여행지: <strong>${totalCount}</strong>개</p>
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

  <div id="tab-likes" class="tab-panel ${search.tab == 'likes' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count">좋아요 많은 여행지: <strong>${totalCount}</strong>개</p>
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

  <c:if test="${not empty sessionScope.loginUser}">
  <div id="tab-ai" class="tab-panel ${search.tab == 'ai' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count">
        <span id="aiResultLabel">&#x1F916; 맞춤 <strong>AI 여행지 추천</strong></span>
      </p>
    </div>
    <div id="aiLoadingMsg" style="text-align:center;padding:60px 24px;color:var(--gray-400);">
      <div style="font-size:40px;margin-bottom:12px;">&#x1F916;</div>
      <p style="font-size:15px;">AI가 회원님의 여행 취향을 분석 중입니다...</p>
    </div>
    <div class="spot-grid" id="aiGrid" style="display:none;"></div>
    <div id="aiEmptyMsg" style="display:none;text-align:center;padding:60px 24px;color:var(--gray-400);">
      <div style="font-size:40px;margin-bottom:12px;">&#x1F4CC;</div>
      <p style="font-size:15px;">
        아직 방문 기록이 충분하지 않습니다.<br>
        여행지 상세 페이지를 더 둘러보시면 더 정확한 AI 추천을 받을 수 있어요.
      </p>
      <button class="exp-tab-btn" style="margin-top:16px;background:#fff;border:1.5px solid var(--blue);color:var(--blue);"
              onclick="document.querySelector('[data-tab=all]').click()">
        전체 여행지 둘러보기
      </button>
    </div>
  </div>
  </c:if>

  <c:if test="${totalPage > 1}">
    <div class="pagination" id="pagination">
      <button class="page-btn" data-page="${currentPage - 1}" ${currentPage <= 1 ? 'disabled' : ''} title="이전">&#8592;</button>

      <c:set var="startPage" value="${currentPage - 2 > 1 ? currentPage - 2 : 1}"/>
      <c:set var="endPage" value="${startPage + 4 < totalPage ? startPage + 4 : totalPage}"/>

      <c:if test="${startPage > 1}">
        <button class="page-btn" data-page="1">1</button>
        <c:if test="${startPage > 2}"><span style="color:var(--gray-400);padding:0 4px">...</span></c:if>
      </c:if>

      <c:forEach begin="${startPage}" end="${endPage}" var="pg">
        <button class="page-btn ${pg == currentPage ? 'active' : ''}" data-page="${pg}">${pg}</button>
      </c:forEach>

      <c:if test="${endPage < totalPage}">
        <c:if test="${endPage < totalPage - 1}"><span style="color:var(--gray-400);padding:0 4px">...</span></c:if>
        <button class="page-btn" data-page="${totalPage}">${totalPage}</button>
      </c:if>

      <button class="page-btn" data-page="${currentPage + 1}" ${currentPage >= totalPage ? 'disabled' : ''} title="다음">&#8594;</button>
    </div>
  </c:if>
</div>

<div class="loading-overlay" id="loadingOverlay">
  <div class="spinner"></div>
</div>

<div class="toast" id="toast"></div>

<%@ include file="../common/footer.jsp" %>

<script>
document.addEventListener("DOMContentLoaded", function () {
  const checkboxes = document.querySelectorAll('input[name="tags"]');
  const max = 4;

  checkboxes.forEach(cb => {
    cb.addEventListener("change", function () {
      const checked = document.querySelectorAll('input[name="tags"]:checked');

      if (checked.length > max) {
        this.checked = false;
        alert("태그는 최대 4개까지 선택할 수 있습니다.");
      }
    });
  });
});

  (function () {
    'use strict';

    const ctx = '${pageContext.request.contextPath}';
    const currentTab = '${search.tab}';
    const savedRegion = '${search.region}';
    const savedTheme = '${search.theme}';
    const overlay = document.getElementById('loadingOverlay');
    const searchInput = document.getElementById('searchInput');
    const searchClear = document.getElementById('searchClear');

    function showLoading(on) {
      overlay.classList.toggle('show', on);
    }

    window.addEventListener('pageshow', function () {
      showLoading(false);
    });

    function showToast(msg) {
      const t = document.getElementById('toast');
      t.textContent = msg;
      t.classList.add('show');
      setTimeout(() => t.classList.remove('show'), 2500);
    }

    function navigate(params) {
      showLoading(true);
      const q = new URLSearchParams();
      q.set('tab', params.tab || 'all');
      if (params.keyword && params.keyword !== '') q.set('keyword', params.keyword);
      if (params.region && params.region !== '') q.set('region', params.region);
      if (params.theme && params.theme !== '') q.set('theme', params.theme);
      if (params.page && params.page > 1) q.set('page', params.page);
      window.location.href = ctx + '/explore?' + q.toString();
    }

    function mergedParams(overrides) {
      return Object.assign({
        tab: currentTab,
        keyword: searchInput.value.trim(),
        region: savedRegion,
        theme: savedTheme
      }, overrides);
    }

    document.querySelectorAll('.exp-tab-btn').forEach(btn => {
      btn.addEventListener('click', function () {
        const tab = this.dataset.tab;
        if (tab === currentTab) return;
        navigate({ tab: tab, keyword: searchInput.value.trim() });
      });
    });

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

    document.querySelectorAll('#regionFilters .filter-btn').forEach(btn => {
      btn.addEventListener('click', function () {
        navigate({ tab: 'region', region: this.dataset.region, keyword: searchInput.value.trim(), page: 1 });
      });
    });

    document.querySelectorAll('#themeFilters .filter-btn').forEach(btn => {
      btn.addEventListener('click', function () {
        navigate({ tab: 'theme', theme: this.dataset.theme, keyword: searchInput.value.trim(), page: 1 });
      });
    });

    document.querySelectorAll('#pagination .page-btn:not(:disabled)').forEach(btn => {
      btn.addEventListener('click', function () {
        const p = parseInt(this.dataset.page, 10);
        if (!isNaN(p)) navigate(mergedParams({ page: p }));
      });
    });

    document.querySelectorAll('.spot-card[data-spot-idx]').forEach(card => {
      card.addEventListener('click', function (e) {
        if (e.target.closest('.action-btn')) return;
        window.location.href = ctx + '/detail/' + this.dataset.spotIdx;
      });
    });

    document.querySelectorAll('.fav-btn').forEach(btn => {
      btn.addEventListener('click', function (e) {
        e.stopPropagation();
        const idx = this.closest('.spot-card').dataset.spotIdx;
        toggleAction('/explore/favorite/' + idx, this, '⭐', '☆', '찜 추가됨', '찜 취소됨', 'favorited');
      });
    });

    document.querySelectorAll('.like-btn').forEach(btn => {
      btn.addEventListener('click', function (e) {
        e.stopPropagation();
        const idx = this.closest('.spot-card').dataset.spotIdx;
        toggleAction('/explore/like/' + idx, this, '❤️', '🤍', '좋아요!', '좋아요 취소됨', 'liked');
      });
    });

    function toggleAction(endpoint, btn, onIcon, offIcon, onMsg, offMsg, key) {
      fetch(ctx + endpoint, { method: 'POST' })
        .then(r => r.json())
        .then(data => {
          if (!data.success) {
            showToast('로그인이 필요합니다.');
            setTimeout(() => { window.location.href = ctx + '/auth/login'; }, 1500);
            return;
          }
          const active = data[key];
          btn.textContent = active ? onIcon : offIcon;
          btn.classList.toggle('active', active);
          showToast(active ? onMsg : offMsg);
        })
        .catch(() => showToast('요청 처리 중 오류가 발생했습니다.'));
    }
  })();
</script>

<c:if test="${not empty sessionScope.loginUser}">
<script>
  (function () {
    /* ══════════════════════════════════════════════════════════
       여행지 추가 모달 JS
       - Google Places 새 API (PlaceAutocompleteElement) + gmp-select 이벤트
       - 이미지 업로드 드래그앤드롭 지원
       ══════════════════════════════════════════════════════════ */

    /* ── DOM 요소 참조 ── */
    var modal          = document.getElementById('spotWriteModal');
    var openBtn        = document.getElementById('openSpotWriteBtn');
    var closeBtn       = document.getElementById('closeSpotWriteBtn');
    var cancelBtn      = document.getElementById('cancelSpotWriteBtn');
    var form           = document.getElementById('spotWriteForm');
    var nameInput      = document.getElementById('spotName');
    var regionInput    = document.getElementById('spotRegion');
    var addressInput   = document.getElementById('spotAddress');
    var latInput       = document.getElementById('spotLatitude');
    var lngInput       = document.getElementById('spotLongitude');
    var latHiddenInput = document.getElementById('spotLatitudeHidden');
    var lngHiddenInput = document.getElementById('spotLongitudeHidden');
    var shouldOpenOnLoad = '${openWriteModal}' === 'true';

    /* ── 이미지 업로드 관련 DOM ── */
    var dropZone    = document.getElementById('spotImageDropZone');
    var fileInput   = document.getElementById('spotImageFile');
    var previewWrap = document.getElementById('spotImagePreview');
    var previewImg  = document.getElementById('spotPreviewImg');
    var placeholder = document.getElementById('spotImagePlaceholder');
    var removeBtn   = document.getElementById('spotImageRemoveBtn');

    /* ══════════════════════════════════════
       위도/경도 동기화
       ══════════════════════════════════════ */
    function syncCoords(lat, lng) {
      var latValue = typeof lat === 'number' ? lat.toFixed(6) : '';
      var lngValue = typeof lng === 'number' ? lng.toFixed(6) : '';
      latInput.value       = latValue;
      lngInput.value       = lngValue;
      latHiddenInput.value = latValue;
      lngHiddenInput.value = lngValue;
    }

    /* ══════════════════════════════════════
       address_components에서 시/도 추출
       ══════════════════════════════════════ */
    function extractRegionFromComponents(components) {
      if (!components || !components.length) return '';
      for (var i = 0; i < components.length; i++) {
        var comp = components[i];
        if (comp.types.indexOf('country') > -1) {
          return comp.longText || comp.long_name || '';
        }
      }
      for (var j = 0; j < components.length; j++) {
        var admin = components[j];
        if (admin.types.indexOf('administrative_area_level_1') > -1) {
          return admin.longText || admin.long_name || '';
        }
      }
      for (var k = 0; k < components.length; k++) {
        var fb = components[k];
        if (fb.types.indexOf('locality') > -1 || fb.types.indexOf('sublocality') > -1) {
          return fb.longText || fb.long_name || '';
        }
      }
      return '';
    }

    /* ══════════════════════════════════════
       선택된 장소를 폼 필드에 자동 입력
       ══════════════════════════════════════ */
    function applyPlace(place) {
      if (!place || !place.location) return;

      var lat = typeof place.location.lat === 'function'
                ? place.location.lat() : place.location.lat;
      var lng = typeof place.location.lng === 'function'
                ? place.location.lng() : place.location.lng;

      syncCoords(lat, lng);
      addressInput.value = place.formattedAddress || place.formatted_address || addressInput.value;

      if (!nameInput.value.trim() && place.displayName) {
        nameInput.value = typeof place.displayName === 'string'
                          ? place.displayName : (place.displayName.text || '');
      }

      var region = extractRegionFromComponents(place.addressComponents || place.address_components);
      if (region) regionInput.value = region;
    }

    /* ══════════════════════════════════════
       이미지 업로드 - 드래그앤드롭 / 클릭
       ══════════════════════════════════════ */
    function showPreview(file) {
      if (file.size > 10 * 1024 * 1024) {
        alert('이미지 크기는 10MB 이하만 가능합니다.');
        return;
      }
      var allowed = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
      if (allowed.indexOf(file.type) === -1) {
        alert('JPG, PNG, GIF, WEBP 형식만 업로드 가능합니다.');
        return;
      }
      var reader = new FileReader();
      reader.onload = function (e) {
        previewImg.src = e.target.result;
        previewWrap.style.display = 'block';
        placeholder.style.display = 'none';
      };
      reader.readAsDataURL(file);
    }

    if (dropZone) {
      dropZone.addEventListener('click', function (e) {
        if (e.target === removeBtn || e.target.closest('.spot-image-remove-btn')) return;
        fileInput.click();
      });
    }

    if (fileInput) {
      fileInput.addEventListener('change', function () {
        if (this.files && this.files[0]) showPreview(this.files[0]);
      });
    }

    if (dropZone) {
      dropZone.addEventListener('dragover', function (e) {
        e.preventDefault();
        this.classList.add('drag-over');
      });
      dropZone.addEventListener('dragleave', function () {
        this.classList.remove('drag-over');
      });
      dropZone.addEventListener('drop', function (e) {
        e.preventDefault();
        this.classList.remove('drag-over');
        if (e.dataTransfer.files && e.dataTransfer.files[0]) {
          fileInput.files = e.dataTransfer.files;
          showPreview(e.dataTransfer.files[0]);
        }
      });
    }

    if (removeBtn) {
      removeBtn.addEventListener('click', function (e) {
        e.stopPropagation();
        fileInput.value = '';
        previewImg.src = '';
        previewWrap.style.display = 'none';
        placeholder.style.display = '';
      });
    }

    /* ══════════════════════════════════════
       모달 열기 / 닫기
       ══════════════════════════════════════ */
    function openModal() {
      if (!modal) return;
      modal.classList.add('show');
      document.body.classList.add('modal-open');
    }

    function closeModal() {
      if (!modal) return;
      modal.classList.remove('show');
      document.body.classList.remove('modal-open');
    }

    if (openBtn)  openBtn.addEventListener('click', openModal);
    if (closeBtn) closeBtn.addEventListener('click', closeModal);
    if (cancelBtn) cancelBtn.addEventListener('click', closeModal);

    if (modal) {
      modal.addEventListener('click', function (e) {
        if (e.target === modal) closeModal();
      });
    }

    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && modal && modal.classList.contains('show')) {
        closeModal();
      }
    });

    /* ══════════════════════════════════════
       폼 제출 전 좌표 미입력 검증
       ══════════════════════════════════════ */
    if (form) {
      form.addEventListener('submit', function (e) {
        if (!latHiddenInput.value || !lngHiddenInput.value) {
          e.preventDefault();
          alert('위치 검색에서 장소를 선택하여 주소와 좌표를 입력해주세요.');
        }
      });
    }

    /* ══════════════════════════════════════════════════════════
       Google Maps Places API 초기화
       - gmp-select 이벤트 + event.placePrediction.toPlace() 사용
       ══════════════════════════════════════════════════════════ */
    window.initExploreWriteMap = async function () {
      if (!window.google || !window.google.maps) return;

      try {
        var { PlaceAutocompleteElement } = await google.maps.importLibrary('places');

        var placeAutocomplete = new PlaceAutocompleteElement();
        placeAutocomplete.style.width = '100%';

        var searchWrap = document.getElementById('spotLocationSearchWrap');
        if (searchWrap) searchWrap.appendChild(placeAutocomplete);

        /* gmp-select 이벤트: placePrediction.toPlace()로 Place 객체 획득 */
        placeAutocomplete.addEventListener('gmp-select', async function (event) {
          var prediction = event.placePrediction;
          if (!prediction) return;

          var place = prediction.toPlace();
          await place.fetchFields({
            fields: ['displayName', 'formattedAddress', 'location', 'addressComponents']
          });
          applyPlace(place);
        });

      } catch (err) {
        console.warn('PlaceAutocompleteElement 사용 불가, 기존 Autocomplete로 폴백:', err);

        var fallbackInput = document.createElement('input');
        fallbackInput.type = 'text';
        fallbackInput.placeholder = '장소명 또는 주소로 검색';
        fallbackInput.autocomplete = 'off';
        fallbackInput.className = 'spot-write-fallback-input';

        var searchWrap = document.getElementById('spotLocationSearchWrap');
        if (searchWrap) searchWrap.appendChild(fallbackInput);

        var autocomplete = new google.maps.places.Autocomplete(fallbackInput, {
          fields: ['address_components', 'formatted_address', 'geometry', 'name']
        });

        autocomplete.addListener('place_changed', function () {
          var p = autocomplete.getPlace();
          if (!p || !p.geometry) {
            alert('검색 결과에서 올바른 장소를 선택해주세요.');
            return;
          }
          applyPlace({
            location: p.geometry.location,
            formattedAddress: p.formatted_address,
            displayName: p.name,
            addressComponents: p.address_components
          });
        });
      }

      var initialLat = parseFloat(latHiddenInput.value);
      var initialLng = parseFloat(lngHiddenInput.value);
      if (isNaN(initialLat) || isNaN(initialLng)) {
        syncCoords(null, null);
      }

      if (shouldOpenOnLoad) openModal();
    };
  })();
</script>
<script async
        src="https://maps.googleapis.com/maps/api/js?key=${mapsApiKey}&libraries=places&callback=initExploreWriteMap"></script>
</c:if>

<c:if test="${not empty sessionScope.loginUser}">
<script>
(function() {
  var CTX_AI = '${pageContext.request.contextPath}';

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
    var loading = document.getElementById('aiLoadingMsg');
    var grid = document.getElementById('aiGrid');
    if (loading) loading.style.display = 'block';
    if (grid) grid.style.display = 'none';

    fetch(CTX_AI + '/recommend/spots')
      .then(function(r) { return r.json(); })
      .then(function(data) {
        var loading = document.getElementById('aiLoadingMsg');
        var grid = document.getElementById('aiGrid');
        var empty = document.getElementById('aiEmptyMsg');
        var label = document.getElementById('aiResultLabel');

        if (!data.success || !data.spots || data.spots.length === 0) {
          if (loading) loading.style.display = 'none';
          if (empty) empty.style.display = 'block';
          return;
        }

        if (label) {
          label.innerHTML = data.isTrending
            ? '&#x1F525; 요즘 뜨는 여행지 추천'
            : '&#x1F916; 맞춤 <strong>AI 여행지 추천</strong>';
        }
        if (grid) {
          grid.innerHTML = data.spots.map(buildAiCard).join('');
          grid.style.display = '';
        }
        if (loading) loading.style.display = 'none';
      })
      .catch(function() {
        var loading = document.getElementById('aiLoadingMsg');
        if (loading) loading.textContent = 'AI 추천 정보를 불러오지 못했습니다.';
      });
  }

  var aiTabBtn = document.querySelector('[data-tab="ai"]');
  if (aiTabBtn) {
    aiTabBtn.addEventListener('click', function() {
      document.querySelectorAll('.exp-tab-btn').forEach(function(b) {
        b.classList.remove('active');
      });
      aiTabBtn.classList.add('active');

      document.querySelectorAll('.tab-panel').forEach(function(p) {
        p.classList.remove('active');
      });
      var aiPanel = document.getElementById('tab-ai');
      if (aiPanel) aiPanel.classList.add('active');

      loadAiRecommendations();
      history.pushState(null, '', window.location.pathname + '?tab=ai');
    });
  }

  if (new URLSearchParams(window.location.search).get('tab') === 'ai') {
    loadAiRecommendations();
  }
})();
</script>
</c:if>

</body>
</html>
