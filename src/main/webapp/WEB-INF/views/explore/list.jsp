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
      <%-- Suggest dropdown rendered via AJAX --%>
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
      <%-- Favorite tab is shown only to logged-in users --%>
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
          <%-- Google Places API injects PlaceAutocompleteElement here --%>
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

        <%-- Image upload area --%>
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

  <%-- Favorite list panel is shown only to logged-in users --%>
  <c:if test="${not empty sessionScope.loginUser}">
  <div id="tab-favorite" class="tab-panel ${search.tab == 'favorite' ? 'active' : ''}">
    <div class="result-bar">
      <p class="result-count">&#x1F4CC; <spring:message code="explore.favorite.mine"/>: <strong>${totalCount}</strong><spring:message code="explore.count"/></p>
    </div>
    <div class="spot-grid" id="grid-favorite">
      <c:choose>
        <%-- Render favorite spot cards --%>
        <c:when test="${not empty spotList}">
          <c:forEach var="spot" items="${spotList}">
            <%@ include file="spotCard.jsp" %>
          </c:forEach>
        </c:when>
        <%-- Empty state for favorites --%>
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
      <button class="page-btn" data-page="${currentPage - 1}" ${currentPage <= 1 ? 'disabled' : ''} title="&#xC774;&#xC804;">&#8592;</button>

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

      <button class="page-btn" data-page="${currentPage + 1}" ${currentPage >= totalPage ? 'disabled' : ''} title="&#xB2E4;&#xC74C;">&#8594;</button>
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
        alert("\uD0DC\uADF8\uB294 \uCD5C\uB300 4\uAC1C\uAE4C\uC9C0 \uC120\uD0DD\uD560 \uC218 \uC788\uC2B5\uB2C8\uB2E4.");
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

    /* ------------------------------------------------------------
       Suggest dropdown logic
       - Send AJAX request when keyword length is 2 or more
       - Render up to 7 suggestions from /explore/suggest
       - Search immediately when the user picks a suggestion
       ------------------------------------------------------------ */
    const suggestDropdown = document.getElementById('suggestDropdown');
    let searchTimer;      // debounce timer for search
    let suggestTimer;     // debounce timer for suggestions
    let selectedSuggestIdx = -1;  // highlighted suggestion index

    /**
     * Fetch suggestions from the server and render the dropdown.
     * @param {string} keyword - current search keyword
     */
    function fetchSuggestions(keyword) {
      // Close dropdown when the keyword is shorter than 2 characters.
      if (!keyword || keyword.length < 2) {
        suggestDropdown.innerHTML = '';
        suggestDropdown.classList.remove('show');
        return;
      }

      // Request suggestions from the server.
      fetch(ctx + '/explore/suggest?q=' + encodeURIComponent(keyword))
        .then(r => r.json())
        .then(data => {
          // Reset highlighted suggestion index.
          selectedSuggestIdx = -1;

          // Hide dropdown when there are no results.
          if (!data || data.length === 0) {
            suggestDropdown.innerHTML = '';
            suggestDropdown.classList.remove('show');
            return;
          }

          // Build suggestion items.
          suggestDropdown.innerHTML = data.map(function(item, idx) {
            // Highlight the matching part in the suggestion name.
            var name = escapeHtml(item.name || '');
            var region = escapeHtml(item.region || '');
            var address = escapeHtml(item.address || '');
            var highlighted = highlightMatch(name, keyword);

            return '<li class="suggest-item" data-idx="' + idx + '" data-name="' + name + '">'
              + '<span class="suggest-name">' + highlighted + '</span>'
              + '<span class="suggest-region">' + region + (address ? ' / ' + address : '') + '</span>'
              + '</li>';
          }).join('');

          suggestDropdown.classList.add('show');

          // Register click handler for each suggestion item.
          suggestDropdown.querySelectorAll('.suggest-item').forEach(function(li) {
            li.addEventListener('mousedown', function(e) {
              // Use mousedown so it runs before blur.
              e.preventDefault();
              var selectedName = this.dataset.name;
              searchInput.value = selectedName;
              suggestDropdown.classList.remove('show');
              // Run search immediately with the selected keyword.
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
     * Escape HTML special characters to prevent XSS.
     */
    function escapeHtml(str) {
      if (!str) return '';
      return str.replace(/&/g,'&amp;').replace(/</g,'&lt;')
                .replace(/>/g,'&gt;').replace(/"/g,'&quot;');
    }

    /**
     * Highlight the matching keyword with <mark> tags.
     * @param {string} text - source text
     * @param {string} keyword - keyword to highlight
     * @returns {string} highlighted HTML string
     */
    function highlightMatch(text, keyword) {
  if (!keyword) return text;
  var escaped = keyword.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
  var regex = new RegExp('(' + escaped + ')', 'gi');
  return text.replace(regex, '<mark>$1</mark>');
}

    // Update suggestions on input, but do not search immediately.
    // Search runs only on Enter or suggestion click.
    searchInput.addEventListener('input', function () {
      var val = this.value.trim();
      // X 버튼 표시/숨김 토글
      searchClear.classList.toggle('visible', this.value.length > 0);

      // Refresh suggestions with a 300ms debounce.
      clearTimeout(suggestTimer);
      suggestTimer = setTimeout(function() { fetchSuggestions(val); }, 300);
    });

    // Handle keyboard interaction for the suggestion dropdown.
    searchInput.addEventListener('keydown', function (e) {
      var items = suggestDropdown.querySelectorAll('.suggest-item');

      if (e.key === 'ArrowDown') {
        // ArrowDown: move to the next suggestion.
        e.preventDefault();
        selectedSuggestIdx = Math.min(selectedSuggestIdx + 1, items.length - 1);
        updateSuggestHighlight(items);
      } else if (e.key === 'ArrowUp') {
        // ArrowUp: move to the previous suggestion.
        e.preventDefault();
        selectedSuggestIdx = Math.max(selectedSuggestIdx - 1, 0);
        updateSuggestHighlight(items);
      } else if (e.key === 'Enter') {
        // Enter: use selected suggestion or current input value.
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
        // Escape: close the suggestion dropdown.
        suggestDropdown.classList.remove('show');
        selectedSuggestIdx = -1;
      }
    });

    /**
     * Apply highlight class to the currently selected suggestion.
     * @param {NodeList} items - all dropdown <li> elements
     */
    function updateSuggestHighlight(items) {
      items.forEach(function(li, i) {
        li.classList.toggle('highlighted', i === selectedSuggestIdx);
      });
      // Preview selected suggestion text in the search input.
      if (selectedSuggestIdx >= 0 && items[selectedSuggestIdx]) {
        searchInput.value = items[selectedSuggestIdx].dataset.name;
      }
    }

    // Close dropdown when the search input loses focus.
    searchInput.addEventListener('blur', function () {
      // Delay to allow suggestion click handling first.
      setTimeout(function() {
        suggestDropdown.classList.remove('show');
      }, 200);
    });

    // Show suggestions again on focus when the keyword is long enough.
    searchInput.addEventListener('focus', function () {
      if (this.value.trim().length >= 2) {
        fetchSuggestions(this.value.trim());
      }
    });

    // Clear search keyword and hide the suggestion dropdown.
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
        toggleAction('/explore/favorite/' + idx, this, '\uD83D\uDCCC', '\uD83D\uDCCD', '\uCC1C \uCD94\uAC00', '\uCC1C \uCDE8\uC18C', 'favorited');
      });
    });

    document.querySelectorAll('.like-btn').forEach(btn => {
      btn.addEventListener('click', function (e) {
        e.stopPropagation();
        const idx = this.closest('.spot-card').dataset.spotIdx;
        toggleAction('/explore/like/' + idx, this, '\u2764', '\u2661', '\uC88B\uC544\uC694', '\uC88B\uC544\uC694 \uCDE8\uC18C', 'liked');
      });
    });

    /**
     * Shared handler for favorite and like actions.
     * - Sends POST request and updates button state.
     * - Removes a card immediately after favorite cancellation in the favorite tab.
     */
    function toggleAction(endpoint, btn, onIcon, offIcon, onMsg, offMsg, key) {
      // Keep a reference to the current card before sending the request.
      const card = btn.closest('.spot-card');

      fetch(ctx + endpoint, { method: 'POST' })
        .then(r => r.json())
        .then(data => {
          if (!data.success) {
            showToast('\uB85C\uADF8\uC778\uC774 \uD544\uC694\uD569\uB2C8\uB2E4.');
            setTimeout(() => { window.location.href = ctx + '/auth/login'; }, 1500);
            return;
          }

          // Read the current active state from the server response.
          const active = data[key];
          // Update button icon and active class.
          btn.textContent = active ? onIcon : offIcon;
          btn.classList.toggle('active', active);
          showToast(active ? onMsg : offMsg);

          /* Remove a card immediately when favorite is canceled in the favorite tab. */
          // key === 'favorited': favorite button action only
          // !active: only when favorite has been canceled
          // currentTab === 'favorite': only inside the favorite tab
          if (key === 'favorited' && !active && currentTab === 'favorite' && card) {
            // Apply a fade-out transition before removal.
            card.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
            card.style.opacity = '0';
            card.style.transform = 'scale(0.95)';

            // Remove the card after the transition finishes.
            setTimeout(() => {
              card.remove();

              // Update the result count with remaining cards.
              const grid = document.getElementById('grid-favorite');
              const remaining = grid ? grid.querySelectorAll('.spot-card').length : 0;

              // Refresh the result count label.
              const countEl = document.querySelector('#tab-favorite .result-count strong');
              if (countEl) countEl.textContent = remaining;

              // Show the empty state when there are no cards left.
              if (remaining === 0 && grid) {
                grid.innerHTML =
                  '<div class="empty-state" style="grid-column:1/-1">' +
                    '<div class="empty-icon">\u{1F4CC}</div>' +
                    '<p>\uC544\uC9C1 \uCC1C\uD55C \uC5EC\uD589\uC9C0\uAC00 \uC5C6\uC2B5\uB2C8\uB2E4.</p>' +
                    '<p style="font-size:14px;color:var(--gray-400);margin-top:8px;">' +
                      '\uC5EC\uD589\uC9C0 \uCE74\uB4DC\uC758 \uD540 \uBC84\uD2BC\uC744 \uB20C\uB7EC \uCC1C\uD574\uBCF4\uC138\uC694.' +
                    '</p>' +
                  '</div>';
              }
            }, 300);
          }
        })
        .catch(() => showToast('\uC694\uCCAD \uCC98\uB9AC \uC911 \uC624\uB958\uAC00 \uBC1C\uC0DD\uD588\uC2B5\uB2C8\uB2E4.'));
    }
  })();
</script>

<c:if test="${not empty sessionScope.loginUser}">
<script>
  (function () {
    /* ------------------------------------------------------------
       Spot write modal script
       - Uses Google Places API and gmp-select event
       - Supports drag and drop image upload
       ------------------------------------------------------------ */

    /* Modal-related DOM references */
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

    /* Image upload DOM references */
    var dropZone    = document.getElementById('spotImageDropZone');
    var fileInput   = document.getElementById('spotImageFile');
    var previewWrap = document.getElementById('spotImagePreview');
    var previewImg  = document.getElementById('spotPreviewImg');
    var placeholder = document.getElementById('spotImagePlaceholder');
    var removeBtn   = document.getElementById('spotImageRemoveBtn');

    /* Coordinate sync ------------------------------------------------
       Keep visible inputs and hidden fields in sync.
       ------------------------------------------------------------ */
    function syncCoords(lat, lng) {
      var latValue = typeof lat === 'number' ? lat.toFixed(6) : '';
      var lngValue = typeof lng === 'number' ? lng.toFixed(6) : '';
      latInput.value       = latValue;
      lngInput.value       = lngValue;
      latHiddenInput.value = latValue;
      lngHiddenInput.value = lngValue;
    }

    /* Extract region name from address components --------------------
       Country > admin area > locality fallback order.
       ------------------------------------------------------------ */
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

    /* Apply selected place data to the form fields -------------------
       Fill name, address, region, latitude, and longitude.
       ------------------------------------------------------------ */
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

    /* Image upload: drag-and-drop / click upload ---------------------
       Validate file size and MIME type first.
       ------------------------------------------------------------ */
    function showPreview(file) {
      if (file.size > 10 * 1024 * 1024) {
        alert('\uC774\uBBF8\uC9C0 \uD06C\uAE30\uB294 10MB \uC774\uD558\uB9CC \uAC00\uB2A5\uD569\uB2C8\uB2E4.');
        return;
      }
      var allowed = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
      if (allowed.indexOf(file.type) === -1) {
        alert('JPG, PNG, GIF, WEBP \uD615\uC2DD\uB9CC \uC5C5\uB85C\uB4DC \uAC00\uB2A5\uD569\uB2C8\uB2E4.');
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

    /* Modal open / close ---------------------------------------------
       Support buttons, backdrop click, and ESC key.
       ------------------------------------------------------------ */
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

    /* Validate coordinates before submit -----------------------------
       Block submission when the user has not selected a place.
       ------------------------------------------------------------ */
    if (form) {
      form.addEventListener('submit', function (e) {
        if (!latHiddenInput.value || !lngHiddenInput.value) {
          e.preventDefault();
          alert('\uC704\uCE58 \uAC80\uC0C9\uC5D0\uC11C \uC7A5\uC18C\uB97C \uC120\uD0DD\uD574 \uC8FC\uC18C\uC640 \uC88C\uD45C\uB97C \uC785\uB825\uD574\uC8FC\uC138\uC694.');
        }
      });
    }

    /* ------------------------------------------------------------
       Initialize Google Maps Places API
       - Use gmp-select and event.placePrediction.toPlace()
       ------------------------------------------------------------ */
    window.initExploreWriteMap = async function () {
      if (!window.google || !window.google.maps) return;

      try {
        var { PlaceAutocompleteElement } = await google.maps.importLibrary('places');

        var placeAutocomplete = new PlaceAutocompleteElement();
        placeAutocomplete.style.width = '100%';

        var searchWrap = document.getElementById('spotLocationSearchWrap');
        if (searchWrap) searchWrap.appendChild(placeAutocomplete);

        /* Convert gmp-select prediction into a Place object. */
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
        console.warn('PlaceAutocompleteElement unavailable, fallback to Autocomplete:', err);

        var fallbackInput = document.createElement('input');
        fallbackInput.type = 'text';
        fallbackInput.placeholder = '\uC7A5\uC18C\uBA85 \uB610\uB294 \uC8FC\uC18C\uB85C \uAC80\uC0C9';
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
            alert('\uAC80\uC0C9 \uACB0\uACFC\uC5D0\uC11C \uC62C\uBC14\uB978 \uC7A5\uC18C\uB97C \uC120\uD0DD\uD574\uC8FC\uC138\uC694.');
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
  var AI_DEFAULT_TITLE = '<spring:message code="explore.ai.title"/>';

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
          label.innerHTML = data.isTrending ? '&#x1F525; \uC9C0\uAE08 \uB728\uB294 \uC778\uAE30 \uC5EC\uD589\uC9C0 \uCD94\uCC9C' : escHtml(AI_DEFAULT_TITLE);
        }


        if (grid) {
          grid.innerHTML = data.spots.map(buildAiCard).join('');
          grid.style.display = '';
        }
        if (loading) loading.style.display = 'none';
      })
      .catch(function() {
        var loading = document.getElementById('aiLoadingMsg');
        if (loading) loading.textContent = '\u0041\u0049 \uCD94\uCC9C \uC815\uBCF4\uB97C \uBD88\uB7EC\uC624\uC9C0 \uBABB\uD588\uC2B5\uB2C8\uB2E4.';
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
