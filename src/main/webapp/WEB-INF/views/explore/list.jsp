<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="pageCSS" value="explore/explore.css"/>
<%@ include file="../common/header.jsp" %>

<body>
<div class="exp-header">
  <div class="exp-header-inner">
    <h1>&#128205; <spring:message code="explore.title"/></h1>

    <div class="search-wrap">
      <span class="search-icon">&#128269;</span>
      <input type="text"
             id="searchInput"
             class="search-input"
             placeholder="<spring:message code="explore.search.placeholder"/>"
             value="${fn:escapeXml(search.keyword)}"
             autocomplete="off"/>
      <button class="search-clear ${not empty search.keyword ? 'visible' : ''}"
              id="searchClear"
              title="<spring:message code="explore.search.clear"/>">&#215;</button>
      <%-- ★ 자동완성 드롭다운: 검색어 입력 시 AJAX로 후보 목록을 받아 표시 --%>
      <ul class="suggest-dropdown" id="suggestDropdown"></ul>
    </div>

    <div class="exp-header-actions">
      <p class="exp-header-note"><spring:message code="explore.note"/></p>
      <c:if test="${not empty sessionScope.loginUser}">
        <button type="button" class="exp-primary-btn" id="openSpotWriteBtn">
          &#9998; <spring:message code="explore.add"/>
        </button>
      </c:if>
    </div>

    <div class="exp-tab-bar" role="tablist">
      <button class="exp-tab-btn ${search.tab == 'all' ? 'active' : ''}" data-tab="all" role="tab">&#10024; <spring:message code="explore.tab.all"/></button>
      <button class="exp-tab-btn ${search.tab == 'region' ? 'active' : ''}" data-tab="region" role="tab">&#128205; <spring:message code="explore.tab.region"/></button>
      <button class="exp-tab-btn ${search.tab == 'theme' ? 'active' : ''}" data-tab="theme" role="tab">&#128506; <spring:message code="explore.tab.theme"/></button>
      <button class="exp-tab-btn ${search.tab == 'rating' ? 'active' : ''}" data-tab="rating" role="tab">&#11088; <spring:message code="explore.tab.rating"/></button>
      <button class="exp-tab-btn ${search.tab == 'likes' ? 'active' : ''}" data-tab="likes" role="tab">&#10084; <spring:message code="explore.tab.likes"/></button>
      <%-- ★ 찜한 여행지 탭: 로그인 사용자에게만 노출 --%>
      <c:if test="${not empty sessionScope.loginUser}">
        <button class="exp-tab-btn ${search.tab == 'favorite' ? 'active' : ''}" data-tab="favorite" role="tab">&#x1F4CC; <spring:message code="explore.tab.favorite"/></button>
      </c:if>
      <c:if test="${not empty sessionScope.loginUser}">
        <button class="exp-tab-btn ${search.tab == 'ai' ? 'active' : ''}" data-tab="ai" role="tab">&#x1F916; <spring:message code="explore.tab.ai"/></button>
      </c:if>
    </div>
  </div>
</div>

<c:if test="${not empty sessionScope.loginUser}">
<div class="spot-write-modal ${openWriteModal ? 'show' : ''}" id="spotWriteModal">
  <div class="spot-write-dialog">
    <div class="spot-write-head">
      <div>
        <h2><spring:message code="explore.modal.title"/></h2>
        <p><spring:message code="explore.modal.subtitle"/></p>
      </div>
      <button type="button" class="spot-write-close" id="closeSpotWriteBtn" aria-label="<spring:message code="explore.modal.close"/>">&#215;</button>
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
        <label class="spot-write-label"><spring:message code="explore.form.location"/></label>
          <%-- 새 Google Places API: PlaceAutocompleteElement가 여기에 삽입됩니다 --%>
          <div id="spotLocationSearchWrap"></div>
          <p class="spot-write-help"><spring:message code="explore.form.location.help"/></p>

          <label class="spot-write-label" for="spotName"><spring:message code="explore.form.name"/></label>
          <input type="text" id="spotName" name="name" maxlength="100"
                 value="${fn:escapeXml(writeForm.name)}" placeholder="<spring:message code="explore.form.name.placeholder"/>" required>

          <label class="spot-write-label" for="spotRegion"><spring:message code="explore.form.region"/></label>
          <input type="text" id="spotRegion" name="region" maxlength="100"
                 value="${fn:escapeXml(writeForm.region)}" placeholder="<spring:message code="explore.form.region.placeholder"/>" required>

          <label class="spot-write-label" for="spotAddress"><spring:message code="explore.form.address"/></label>
          <input type="text" id="spotAddress" name="address" maxlength="255"
                 value="${fn:escapeXml(writeForm.address)}" placeholder="<spring:message code="explore.form.address.placeholder"/>" required>

          <div class="spot-write-coords">
            <div>
              <label class="spot-write-label" for="spotLatitude"><spring:message code="explore.form.lat"/></label>
              <input type="text" id="spotLatitude" value="${writeForm.latitude}" readonly>
            </div>
            <div>
              <label class="spot-write-label" for="spotLongitude"><spring:message code="explore.form.lng"/></label>
              <input type="text" id="spotLongitude" value="${writeForm.longitude}" readonly>
            </div>
          </div>

          <input type="hidden" id="spotLatitudeHidden" name="latitude" value="${writeForm.latitude}">
          <input type="hidden" id="spotLongitudeHidden" name="longitude" value="${writeForm.longitude}">

          <label class="spot-write-label" for="spotDescription"><spring:message code="explore.form.description"/></label>
          <textarea id="spotDescription" name="description" maxlength="2000"
                    placeholder="<spring:message code="explore.form.description.placeholder"/>" required>${fn:escapeXml(writeForm.description)}</textarea>
          <label class="spot-write-label"><spring:message code="explore.form.tags"/></label>
          <div class="spot-write-tag-picker">
            <c:forEach var="tag" items="${writeTagList}">
              <label class="spot-write-tag-option">
                <input type="checkbox" name="tags" value="${fn:escapeXml(tag)}"
                       <c:if test="${fn:contains(selectedWriteTags, tag)}">checked</c:if>>
                <span>${fn:escapeXml(tag)}</span>
              </label>
            </c:forEach>
          </div>
          <p class="spot-write-help"><spring:message code="explore.form.tags.help"/></p>
        </div>

        <%-- ── 이미지 업로드 영역 (기존 지도 영역 대체) ── --%>
        <div class="spot-write-image-wrap">
          <label class="spot-write-label"><spring:message code="explore.form.image"/></label>
          <div class="spot-image-upload-area" id="spotImageDropZone">
            <div class="spot-image-preview" id="spotImagePreview" style="display:none;">
              <img id="spotPreviewImg" src="" alt="미리보기">
              <button type="button" class="spot-image-remove-btn" id="spotImageRemoveBtn">&#215;</button>
            </div>
            <div class="spot-image-placeholder" id="spotImagePlaceholder">
              <span style="font-size:48px;">&#128247;</span>
              <p><spring:message code="explore.form.image.placeholder"/></p>
              <p class="spot-write-help"><spring:message code="explore.form.image.help"/></p>
            </div>
            <input type="file" id="spotImageFile" name="image"
                   accept=".jpg,.jpeg,.png,.gif,.webp" style="display:none;">
          </div>
        </div>
      </div>

      <div class="spot-write-actions">
        <button type="button" class="exp-secondary-btn" id="cancelSpotWriteBtn"><spring:message code="explore.cancel"/></button>
        <button type="submit" class="exp-primary-btn"><spring:message code="explore.save"/></button>
      </div>
    </form>
  </div>
</div>
</c:if>

<div class="exp-body">
  <div id="tab-all" class="tab-panel ${search.tab == 'all' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count">
        <strong>${totalCount}</strong><spring:message code="explore.count"/>
        <c:if test="${not empty search.keyword}">
          "<strong>${fn:escapeXml(search.keyword)}</strong>" <spring:message code="explore.search.result"/>
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
            <p><spring:message code="explore.empty.search"/></p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div id="tab-region" class="tab-panel ${search.tab == 'region' ? 'active' : ''}">
    <div class="filter-row" id="regionFilters">
      <button class="filter-btn ${empty search.region ? 'active' : ''}" data-region=""><spring:message code="explore.tab.all"/></button>
      <c:forEach var="r" items="${regionList}">
        <button class="filter-btn ${search.region == r ? 'active' : ''}" data-region="${r}">${r}</button>
      </c:forEach>
    </div>
    <div class="result-bar">
      <p class="result-count">
        <c:choose>
          <c:when test="${not empty search.region}">
            <spring:message code="explore.filter.region"/> <strong>${fn:escapeXml(search.region)}</strong>
          </c:when>
          <c:otherwise><spring:message code="explore.filter.allRegion"/></c:otherwise>
        </c:choose>
        , <strong>${totalCount}</strong><spring:message code="explore.count"/>
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
            <p><spring:message code="explore.empty.region"/></p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div id="tab-theme" class="tab-panel ${search.tab == 'theme' ? 'active' : ''}">
    <div class="filter-row" id="themeFilters">
      <button class="filter-btn ${empty search.theme ? 'active' : ''}" data-theme=""><spring:message code="explore.tab.all"/></button>
      <c:forEach var="tag" items="${tagList}">
        <button class="filter-btn ${search.theme == tag ? 'active' : ''}" data-theme="${tag}">${tag}</button>
      </c:forEach>
    </div>
    <div class="result-bar">
      <p class="result-count">
        <c:choose>
          <c:when test="${not empty search.theme}">
            <spring:message code="explore.filter.theme"/> <strong>${fn:escapeXml(search.theme)}</strong>
          </c:when>
          <c:otherwise><spring:message code="explore.filter.allTheme"/></c:otherwise>
        </c:choose>
        , <strong>${totalCount}</strong><spring:message code="explore.count"/>
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
            <p><spring:message code="explore.empty.theme"/></p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div id="tab-rating" class="tab-panel ${search.tab == 'rating' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count"><spring:message code="explore.rating.top"/>: <strong>${totalCount}</strong><spring:message code="explore.count"/></p>
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
            <div class="empty-icon">&#x1F4CC;</div>
            <p><spring:message code="explore.empty.rating"/></p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <div id="tab-likes" class="tab-panel ${search.tab == 'likes' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count"><spring:message code="explore.likes.top"/>: <strong>${totalCount}</strong><spring:message code="explore.count"/></p>
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
            <p><spring:message code="explore.empty.likes"/></p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <%-- ★ 찜한 여행지 탭 패널: 로그인 사용자에게만 노출 --%>
  <c:if test="${not empty sessionScope.loginUser}">
  <div id="tab-favorite" class="tab-panel ${search.tab == 'favorite' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count">&#x1F4CC; <spring:message code="explore.favorite.mine"/>: <strong>${totalCount}</strong><spring:message code="explore.count"/></p>
    </div>
    <div class="spot-grid" id="grid-favorite">
      <c:choose>
        <%-- 찜한 여행지가 있으면 spotCard.jsp를 이용해 카드 목록 출력 --%>
        <c:when test="${not empty spotList}">
          <c:forEach var="spot" items="${spotList}">
            <%@ include file="spotCard.jsp" %>
          </c:forEach>
        </c:when>
        <%-- 찜한 여행지가 없으면 안내 메시지 출력 --%>
        <c:otherwise>
          <div class="empty-state" style="grid-column:1/-1">
            <div class="empty-icon">&#x1F4CC;</div>
            <p><spring:message code="explore.empty.favorite"/></p>
            <p style="font-size:14px;color:var(--gray-400);margin-top:8px;">
              <spring:message code="explore.empty.favorite.help"/>
            </p>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
  </c:if>

  <c:if test="${not empty sessionScope.loginUser}">
  <div id="tab-ai" class="tab-panel ${search.tab == 'ai' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count">
        <span id="aiResultLabel"><spring:message code="explore.ai.title"/></span>
      </p>
    </div>
    <div id="aiLoadingMsg" style="text-align:center;padding:60px 24px;color:var(--gray-400);">
      <div style="font-size:40px;margin-bottom:12px;">&#x1F916;</div>
      <p style="font-size:15px;"><spring:message code="explore.ai.loading"/></p>
    </div>
    <div class="spot-grid" id="aiGrid" style="display:none;"></div>
    <div id="aiEmptyMsg" style="display:none;text-align:center;padding:60px 24px;color:var(--gray-400);">
      <div style="font-size:40px;margin-bottom:12px;">&#x1F4CC;</div>
      <p style="font-size:15px;">
        <spring:message code="explore.ai.empty"/><br>
        <spring:message code="explore.ai.empty.help"/>
      </p>
      <button class="exp-tab-btn" style="margin-top:16px;background:#fff;border:1.5px solid var(--blue);color:var(--blue);"
              onclick="document.querySelector('[data-tab=all]').click()">
        <spring:message code="explore.ai.browse"/>
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

    /* ══════════════════════════════════════════════════════════
       자동완성(Suggest) 기능
       - 사용자가 검색창에 2글자 이상 입력하면 서버에 AJAX 요청
       - /explore/suggest?q=키워드 → 최대 7건의 후보를 드롭다운으로 표시
       - 후보를 클릭하면 해당 키워드로 즉시 검색 실행
       ══════════════════════════════════════════════════════════ */
    const suggestDropdown = document.getElementById('suggestDropdown');
    let searchTimer;      // 검색 실행용 디바운스 타이머
    let suggestTimer;     // 자동완성 요청용 디바운스 타이머
    let selectedSuggestIdx = -1;  // 키보드 화살표로 선택 중인 항목 인덱스

    /**
     * 서버에서 자동완성 후보를 가져와 드롭다운에 렌더링
     * @param {string} keyword - 사용자가 입력한 검색어
     */
    function fetchSuggestions(keyword) {
      // 2글자 미만이면 드롭다운 숨김 (너무 광범위한 결과 방지)
      if (!keyword || keyword.length < 2) {
        suggestDropdown.innerHTML = '';
        suggestDropdown.classList.remove('show');
        return;
      }

      // 서버에 자동완성 API 요청
      fetch(ctx + '/explore/suggest?q=' + encodeURIComponent(keyword))
        .then(r => r.json())
        .then(data => {
          // 키보드 선택 인덱스 초기화
          selectedSuggestIdx = -1;

          // 결과가 없으면 드롭다운 숨김
          if (!data || data.length === 0) {
            suggestDropdown.innerHTML = '';
            suggestDropdown.classList.remove('show');
            return;
          }

          // 각 후보를 <li> 요소로 만들어 드롭다운에 렌더링
          suggestDropdown.innerHTML = data.map(function(item, idx) {
            // name에서 검색어와 매칭되는 부분을 <mark>로 하이라이트
            var name = escapeHtml(item.name || '');
            var region = escapeHtml(item.region || '');
            var address = escapeHtml(item.address || '');
            var highlighted = highlightMatch(name, keyword);

            return '<li class="suggest-item" data-idx="' + idx + '" data-name="' + name + '">'
              + '<span class="suggest-name">' + highlighted + '</span>'
              + '<span class="suggest-region">' + region + (address ? ' · ' + address : '') + '</span>'
              + '</li>';
          }).join('');

          suggestDropdown.classList.add('show');

          // 각 후보 항목에 클릭 이벤트 등록
          suggestDropdown.querySelectorAll('.suggest-item').forEach(function(li) {
            li.addEventListener('mousedown', function(e) {
              // mousedown 사용 (blur보다 먼저 발생하므로 클릭이 정상 동작)
              e.preventDefault();
              var selectedName = this.dataset.name;
              searchInput.value = selectedName;
              suggestDropdown.classList.remove('show');
              // 선택한 항목으로 즉시 검색 실행
              clearTimeout(searchTimer);
              navigate(mergedParams({ keyword: selectedName, page: 1 }));
            });
          });
        })
        .catch(function() {
          suggestDropdown.classList.remove('show');
        });
    }

    /**
     * HTML 특수문자 이스케이프 (XSS 방지)
     */
    function escapeHtml(str) {
      if (!str) return '';
      return str.replace(/&/g,'&amp;').replace(/</g,'&lt;')
                .replace(/>/g,'&gt;').replace(/"/g,'&quot;');
    }

    /**
     * 텍스트에서 keyword와 매칭되는 부분을 <mark>로 감싸서 하이라이트
     * @param {string} text - 원본 텍스트
     * @param {string} keyword - 하이라이트할 키워드
     * @returns {string} 하이라이트된 HTML 문자열
     */
    function highlightMatch(text, keyword) {
  if (!keyword) return text;
  var escaped = keyword.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
  var regex = new RegExp('(' + escaped + ')', 'gi');
  return text.replace(regex, '<mark>$1</mark>');
}

    // 검색창 입력 이벤트: 자동완성 드롭다운만 업데이트 (검색 실행은 하지 않음)
    // ※ 실제 검색은 드롭다운 항목 클릭 또는 Enter 키를 눌러야만 실행됨
    searchInput.addEventListener('input', function () {
      var val = this.value.trim();
      // X 버튼 표시/숨김 토글
      searchClear.classList.toggle('visible', this.value.length > 0);

      // 자동완성 드롭다운 업데이트 (300ms 디바운스: 빠른 타이핑 시 요청 최소화)
      clearTimeout(suggestTimer);
      suggestTimer = setTimeout(function() { fetchSuggestions(val); }, 300);
    });

    // 키보드 이벤트: Enter, 위/아래 화살표, Escape 처리
    searchInput.addEventListener('keydown', function (e) {
      var items = suggestDropdown.querySelectorAll('.suggest-item');

      if (e.key === 'ArrowDown') {
        // ▼ 아래 화살표: 다음 항목 선택
        e.preventDefault();
        selectedSuggestIdx = Math.min(selectedSuggestIdx + 1, items.length - 1);
        updateSuggestHighlight(items);
      } else if (e.key === 'ArrowUp') {
        // ▲ 위 화살표: 이전 항목 선택
        e.preventDefault();
        selectedSuggestIdx = Math.max(selectedSuggestIdx - 1, 0);
        updateSuggestHighlight(items);
      } else if (e.key === 'Enter') {
        // Enter: 선택된 항목이 있으면 해당 항목으로, 없으면 현재 입력값으로 검색
        e.preventDefault();
        clearTimeout(searchTimer);
        clearTimeout(suggestTimer);
        if (selectedSuggestIdx >= 0 && items[selectedSuggestIdx]) {
          var selectedName = items[selectedSuggestIdx].dataset.name;
          searchInput.value = selectedName;
          suggestDropdown.classList.remove('show');
          navigate(mergedParams({ keyword: selectedName, page: 1 }));
        } else {
          suggestDropdown.classList.remove('show');
          navigate(mergedParams({ keyword: this.value.trim(), page: 1 }));
        }
      } else if (e.key === 'Escape') {
        // Escape: 드롭다운 닫기
        suggestDropdown.classList.remove('show');
        selectedSuggestIdx = -1;
      }
    });

    /**
     * 키보드 화살표로 선택 중인 항목에 하이라이트 클래스 적용
     * @param {NodeList} items - 드롭다운 내 모든 <li> 요소
     */
    function updateSuggestHighlight(items) {
      items.forEach(function(li, i) {
        li.classList.toggle('highlighted', i === selectedSuggestIdx);
      });
      // 선택된 항목의 텍스트를 검색창에 미리보기
      if (selectedSuggestIdx >= 0 && items[selectedSuggestIdx]) {
        searchInput.value = items[selectedSuggestIdx].dataset.name;
      }
    }

    // 검색창에서 포커스가 벗어나면 드롭다운 닫기
    searchInput.addEventListener('blur', function () {
      // 약간의 딜레이를 줘서 mousedown 클릭이 먼저 처리되도록 함
      setTimeout(function() {
        suggestDropdown.classList.remove('show');
      }, 200);
    });

    // 검색창에 포커스가 돌아오면 입력값이 있으면 다시 자동완성 표시
    searchInput.addEventListener('focus', function () {
      if (this.value.trim().length >= 2) {
        fetchSuggestions(this.value.trim());
      }
    });

    // X 버튼 클릭: 검색어 초기화 + 드롭다운 닫기
    searchClear.addEventListener('click', function () {
      searchInput.value = '';
      searchClear.classList.remove('visible');
      suggestDropdown.classList.remove('show');
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

    /**
     * 찜/좋아요 토글 공통 함수
     * - 서버에 POST 요청 후 버튼 상태 업데이트
     * - 현재 "찜한 여행지" 탭에서 찜 해제 시, 해당 카드를 DOM에서 즉시 제거
     */
    function toggleAction(endpoint, btn, onIcon, offIcon, onMsg, offMsg, key) {
      // 토글 요청을 보내기 전에, 해당 카드의 참조를 미리 저장해둠
      const card = btn.closest('.spot-card');

      fetch(ctx + endpoint, { method: 'POST' })
        .then(r => r.json())
        .then(data => {
          if (!data.success) {
            showToast('로그인이 필요합니다.');
            setTimeout(() => { window.location.href = ctx + '/auth/login'; }, 1500);
            return;
          }

          // 서버 응답에서 현재 상태(true=활성, false=비활성) 가져오기
          const active = data[key];
          // 버튼 아이콘과 active 클래스를 업데이트
          btn.textContent = active ? onIcon : offIcon;
          btn.classList.toggle('active', active);
          showToast(active ? onMsg : offMsg);

          /* ── 찜한 여행지 탭에서 찜 해제 시, 카드를 DOM에서 즉시 제거 ── */
          // key === 'favorited': 찜 버튼을 눌렀을 때만 해당
          // !active: 찜이 해제된 상태일 때만 해당
          // currentTab === 'favorite': 현재 "찜한 여행지" 탭에 있을 때만 해당
          if (key === 'favorited' && !active && currentTab === 'favorite' && card) {
            // 카드를 부드럽게 사라지게 하는 CSS 트랜지션 적용
            card.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
            card.style.opacity = '0';
            card.style.transform = 'scale(0.95)';

            // 트랜지션 완료 후 DOM에서 카드 요소 제거
            setTimeout(() => {
              card.remove();

              // 남은 카드 개수를 세어 카운트 텍스트 업데이트
              const grid = document.getElementById('grid-favorite');
              const remaining = grid ? grid.querySelectorAll('.spot-card').length : 0;

              // 결과 카운트 업데이트 ("📌 내가 찜한 여행지: N개")
              const countEl = document.querySelector('#tab-favorite .result-count strong');
              if (countEl) countEl.textContent = remaining;

              // 카드가 0개가 되면 빈 상태 안내 메시지 표시
              if (remaining === 0 && grid) {
                grid.innerHTML =
                  '<div class="empty-state" style="grid-column:1/-1">' +
                    '<div class="empty-icon">\u{1F4CC}</div>' +
                    '<p>아직 찜한 여행지가 없습니다.</p>' +
                    '<p style="font-size:14px;color:var(--gray-400);margin-top:8px;">' +
                      '여행지 카드의 ☆ 버튼을 눌러 찜해보세요!' +
                    '</p>' +
                  '</div>';
              }
            }, 300);
          }
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
