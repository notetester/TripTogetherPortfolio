<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="pageCSS" value="explore/explore.css"/>
<%@ include file="../common/header.jsp" %>

<body>
<style>
html { scrollbar-gutter: stable; }
/* 히어로 영역 */
.det-hero { position:relative; height:420px; overflow:hidden; background:var(--gray-200); }
.det-hero img { width:100%; height:100%; object-fit:cover; display:block; }
.det-hero-ov { position:absolute; inset:0; background:linear-gradient(to bottom,rgba(0,0,0,.1),rgba(0,0,0,.55)); }
.det-hero-content { position:absolute; bottom:36px; left:36px; right:36px; color:#fff; }
.det-hero-content h1 { font-size:2.4rem; font-weight:700; text-shadow:0 2px 8px rgba(0,0,0,.4); margin-bottom:8px; }
.det-hero-meta { display:flex; align-items:center; gap:16px; font-size:15px; font-weight:500; text-shadow:0 1px 4px rgba(0,0,0,.4); }
.det-hero-rat .star { color:#fbbf24; font-size:18px; }

/* 본문 레이아웃 */
.det-body {
  max-width:960px;
  width:100%;
  margin:0 auto;
  padding:40px 24px 80px;
  box-sizing:border-box;
}

/* 액션 버튼 영역 */
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
.det-action-icon { font-size:18px; line-height:1; color:var(--gray-400); }
.det-action-label { line-height:1.2; }
.det-action-btn.active .det-action-icon { color:var(--blue); }
.det-action-btn.fav-btn.active .det-action-icon { color:#f59e0b; }
.det-action-btn.like-btn.active .det-action-icon { color:#ef4444; }
.det-back-btn {
  background:none; border:none; color:var(--gray-500); font-family:inherit;
  font-size:14px; font-weight:500; cursor:pointer; padding:0;
  display:flex; align-items:center; gap:4px; margin-bottom:24px; transition:color .15s;
}
.det-back-btn:hover { color:var(--blue); }

/* 섹션 카드 공통 */
.det-section {
  background:#fff; border-radius:var(--radius);
  padding:28px 32px; margin-bottom:24px;
  box-shadow:var(--shadow-sm); border:1px solid var(--gray-100);
  width:100%;
  box-sizing:border-box;
}
.det-section h2 {
  font-size:1.1rem; font-weight:700; color:var(--gray-800);
  margin-bottom:16px; padding-bottom:12px; border-bottom:1px solid var(--gray-100);
}

/* 기본 정보 그리드 */
.info-grid { display:grid; gap:14px; }
.info-row { display:flex; align-items:flex-start; gap:12px; font-size:14px; }
.info-label { width:70px; flex-shrink:0; color:var(--gray-500); font-weight:500; }
.info-value { color:var(--gray-700); line-height:1.6; }
.det-desc { font-size:15px; color:var(--gray-700); line-height:1.8; }
.det-tags { display:flex; flex-wrap:wrap; gap:8px; }

/* 지도 플레이스홀더 */
.map-placeholder {
  width:100%; height:220px;
  background:linear-gradient(135deg,var(--blue-light),#f5f3ff);
  border-radius:10px; display:flex; align-items:center; justify-content:center;
  font-size:14px; color:var(--gray-500); flex-direction:column; gap:8px;
}
.map-placeholder .map-icon { font-size:36px; }

/* 리뷰 요약 헤더 */
.review-summary-wrap {
  display:flex; align-items:center; gap:32px;
  padding-bottom:24px; margin-bottom:24px;
  border-bottom:1px solid var(--gray-100); flex-wrap:wrap;
}
.review-big-score { font-size:3.2rem; font-weight:800; color:var(--blue); line-height:1; }
.review-stars-big { font-size:22px; letter-spacing:3px; margin:6px 0 4px; }
.review-sub { font-size:13px; color:var(--gray-400); }

/* 별점 선택기 */
.star-picker { display:flex; gap:6px; margin-bottom:12px; }
.star-picker .sp { font-size:28px; cursor:pointer; color:var(--gray-200); transition:color .1s; }
.star-picker .sp.on { color:#f59e0b; }

/* 리뷰 작성 폼 */
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

/* 로그인 유도 박스 */
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

/* 리뷰 카드 목록 */
.review-list { display:flex; flex-direction:column; gap:16px; }
.review-admin-tools {
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:12px;
  margin-bottom:16px;
  padding:12px 14px;
  border:1px solid #fed7aa;
  border-radius:10px;
  background:#fff7ed;
  flex-wrap:wrap;
}
.review-admin-left {
  display:flex;
  align-items:center;
  gap:10px;
  flex-wrap:wrap;
}
.review-admin-select-all {
  display:inline-flex;
  align-items:center;
  gap:8px;
  font-size:13px;
  font-weight:600;
  color:#9a3412;
}
.review-admin-bulk-btn {
  padding:8px 14px;
  border-radius:8px;
  border:1px solid #fdba74;
  background:#fff;
  color:#c2410c;
  font-family:inherit;
  font-size:13px;
  font-weight:700;
  cursor:pointer;
}
.review-admin-bulk-btn:disabled {
  opacity:.5;
  cursor:not-allowed;
}
.review-card {
  padding:18px 20px; border-radius:10px;
  background:var(--gray-50); border:1px solid var(--gray-200);
}
.review-card.admin-selecting {
  border-color:#fdba74;
  background:#fff7ed;
}
.review-card-top { display:flex; align-items:center; justify-content:space-between; margin-bottom:8px; flex-wrap:wrap; gap:8px; }
.review-author-info { display:flex; align-items:center; gap:10px; }
.review-admin-check {
  width:18px;
  height:18px;
  accent-color:#ea580c;
  cursor:pointer;
}
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
.ai-rec-content {
  min-height: 420px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
.ai-rec-state {
  text-align: center;
  padding: 32px;
  color: var(--gray-400);
  font-size: 14px;
}

/* 관리자 편집 영역 */
.det-admin-bar {
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:12px;
  padding:16px 18px;
  margin-bottom:24px;
  border:1px solid #bfdbfe;
  border-radius:14px;
  background:#eff6ff;
  flex-wrap:wrap;
}
.det-admin-copy { font-size:13px; color:#1d4ed8; line-height:1.6; }
.det-admin-actions { display:flex; gap:10px; flex-wrap:wrap; }
.det-admin-btn {
  padding:10px 16px;
  border-radius:10px;
  border:1px solid #93c5fd;
  background:#fff;
  color:#1d4ed8;
  font-family:inherit;
  font-size:13px;
  font-weight:700;
  cursor:pointer;
}
.det-admin-btn.danger {
  border-color:#fecaca;
  color:#dc2626;
}
.det-admin-review-btn {
  background:#fff7ed;
  border:1px solid #fdba74;
  color:#c2410c;
  font-size:12px;
  cursor:pointer;
  padding:5px 9px;
  border-radius:6px;
}
.det-admin-modal {
  position:fixed;
  inset:0;
  display:none;
  align-items:center;
  justify-content:center;
  background:rgba(15, 23, 42, .56);
  z-index:1200;
  padding:20px;
}
.det-admin-modal.show { display:flex; }
.det-admin-dialog {
  width:min(920px, 100%);
  max-height:calc(100vh - 40px);
  overflow-y:auto;
  background:#fff;
  border-radius:20px;
  box-shadow:0 24px 60px rgba(15, 23, 42, .28);
  padding:24px;
}
.det-admin-head {
  display:flex;
  align-items:flex-start;
  justify-content:space-between;
  gap:16px;
  margin-bottom:18px;
}
.det-admin-head h3 { margin:0 0 6px; font-size:1.2rem; color:var(--gray-800); }
.det-admin-head p { margin:0; font-size:13px; color:var(--gray-500); }
.det-admin-close {
  width:36px; height:36px; border:none; border-radius:50%;
  background:var(--gray-100); color:var(--gray-600); font-size:22px; cursor:pointer;
}
.det-admin-alert {
  padding:12px 14px;
  border-radius:12px;
  margin-bottom:16px;
  font-size:13px;
}
.det-admin-alert.error {
  background:#fef2f2;
  color:#b91c1c;
  border:1px solid #fecaca;
}
.det-admin-grid {
  display:grid;
  grid-template-columns:1fr 1fr;
  gap:14px;
}
.det-admin-field {
  display:grid;
  gap:8px;
}
.det-admin-field.full { grid-column:1 / -1; }
.det-admin-field label {
  font-size:13px;
  font-weight:700;
  color:var(--gray-700);
}
.det-admin-field input[type="text"],
.det-admin-field input[type="number"],
.det-admin-field textarea,
.det-admin-field input[type="file"] {
  width:100%;
  border:1.5px solid var(--gray-200);
  border-radius:12px;
  padding:12px 13px;
  font-family:inherit;
  font-size:14px;
  color:var(--gray-800);
  background:#fff;
  box-sizing:border-box;
}
.det-admin-field textarea {
  min-height:160px;
  resize:vertical;
}
.det-admin-tag-box {
  display:flex;
  flex-wrap:wrap;
  gap:10px;
  padding:14px;
  border:1.5px solid var(--gray-200);
  border-radius:14px;
  background:var(--gray-50);
}
.det-admin-tag {
  display:inline-flex;
  align-items:center;
  gap:8px;
  padding:8px 12px;
  background:#fff;
  border:1px solid var(--gray-200);
  border-radius:999px;
  font-size:13px;
  color:var(--gray-700);
}
.det-admin-foot {
  display:flex;
  justify-content:flex-end;
  gap:10px;
  margin-top:22px;
  flex-wrap:wrap;
}

/* 반응형 대응 */
@media (max-width:640px) {
  .det-hero { height:280px; }
  .det-hero-content h1 { font-size:1.6rem; }
  .det-hero-content { left:20px; right:20px; bottom:20px; }
  .det-body { padding:24px 16px 60px; }
  .det-section { padding:20px; }
  .det-admin-grid { grid-template-columns:1fr; }
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
        <span style="font-size:13px;opacity:.8">(${spot.reviewCount}<spring:message code="detail.review.countSuffix"/>)</span>
      </span>
      <span>&#10084; ${spot.likeCount} <spring:message code="detail.like.count"/></span>
    </div>
  </div>
</div>

<!-- 상세 본문 -->
<div class="det-body">

  <button class="det-back-btn" onclick="history.back()">
    &#8592; <spring:message code="detail.back"/>
  </button>

  <!-- 액션 버튼 -->
  <div class="det-actions">
    <button class="det-action-btn fav-btn ${spot.favorited ? 'active' : ''}"
            data-spot-idx="${spot.spotIdx}">
      <span class="det-action-icon">${spot.favorited ? '⭐' : '☆'}</span>
      <span class="det-action-label">
        <c:choose>
          <c:when test="${spot.favorited}"><spring:message code="detail.fav.done"/></c:when>
          <c:otherwise><spring:message code="detail.fav.do"/></c:otherwise>
        </c:choose>
      </span>
    </button>
    <button class="det-action-btn like-btn ${spot.liked ? 'active' : ''}"
            data-spot-idx="${spot.spotIdx}">
      <span class="det-action-icon">${spot.liked ? '❤️' : '🤍'}</span>
      <span class="det-action-label">
        <c:choose>
          <c:when test="${spot.liked}"><spring:message code="detail.like.done"/></c:when>
          <c:otherwise><spring:message code="detail.like.do"/></c:otherwise>
        </c:choose>
      </span>
    </button>
    <button class="det-action-btn"
            onclick="location.href='${pageContext.request.contextPath}/assistant'">
      &#10024; <spring:message code="detail.ai.plan"/>
    </button>
  </div>

  <c:if test="${canEditSpot}">
    <div class="det-admin-bar">
      <div class="det-admin-copy">
        <strong>
          ${isAdminMode ? '🛡️ ' : '✏️ '}
          <c:choose>
            <c:when test="${isAdminMode}"><spring:message code="detail.edit.admin"/></c:when>
            <c:otherwise><spring:message code="detail.edit.mine"/></c:otherwise>
          </c:choose>
        </strong><br>
        <c:choose>
          <c:when test="${isAdminMode}"><spring:message code="detail.edit.admin.desc"/></c:when>
          <c:otherwise><spring:message code="detail.edit.user.desc"/></c:otherwise>
        </c:choose>
      </div>
      <div class="det-admin-actions">
        <button type="button" class="det-admin-btn" id="openAdminEditBtn"><spring:message code="detail.edit.open"/></button>
        <c:if test="${isAdminMode}">
          <form method="post" action="${pageContext.request.contextPath}/detail/${spot.spotIdx}/admin/delete"
                onsubmit="return confirm('<spring:message code="detail.delete.confirm" javaScriptEscape="true"/>');">
            <button type="submit" class="det-admin-btn danger"><spring:message code="detail.delete"/></button>
          </form>
        </c:if>
      </div>
    </div>
  </c:if>

  <c:if test="${canEditSpot}">
    <div class="det-admin-modal ${openAdminEditModal ? 'show' : ''}" id="adminEditModal">
      <div class="det-admin-dialog">
        <div class="det-admin-head">
          <div>
            <h3><spring:message code="detail.edit.title"/></h3>
            <p><spring:message code="detail.edit.subtitle"/></p>
          </div>
          <button type="button" class="det-admin-close" id="closeAdminEditBtn">&#215;</button>
        </div>

        <c:if test="${not empty adminEditError}">
          <div class="det-admin-alert error">${fn:escapeXml(adminEditError)}</div>
        </c:if>

        <form method="post"
              action="${pageContext.request.contextPath}/detail/${spot.spotIdx}/admin/update"
              enctype="multipart/form-data"
              id="adminEditForm">
          <div class="det-admin-grid">
            <div class="det-admin-field">
              <label for="adminSpotName"><spring:message code="explore.form.name"/></label>
              <input type="text" id="adminSpotName" name="name" maxlength="100"
                     value="${fn:escapeXml(adminEditForm.name)}" required>
            </div>
            <div class="det-admin-field">
              <label for="adminSpotRegion"><spring:message code="detail.info.region"/></label>
              <input type="text" id="adminSpotRegion" name="region" maxlength="100"
                     value="${fn:escapeXml(adminEditForm.region)}" required>
            </div>
            <div class="det-admin-field full">
              <label for="adminSpotAddress"><spring:message code="detail.info.address"/></label>
              <input type="text" id="adminSpotAddress" name="address" maxlength="255"
                     value="${fn:escapeXml(adminEditForm.address)}" required>
            </div>
            <div class="det-admin-field">
              <label for="adminSpotLat"><spring:message code="explore.form.lat"/></label>
              <input type="number" id="adminSpotLat" name="latitude" step="0.000001"
                     value="${adminEditForm.latitude}" required>
            </div>
            <div class="det-admin-field">
              <label for="adminSpotLng"><spring:message code="explore.form.lng"/></label>
              <input type="number" id="adminSpotLng" name="longitude" step="0.000001"
                     value="${adminEditForm.longitude}" required>
            </div>
            <div class="det-admin-field full">
              <label for="adminSpotDesc"><spring:message code="explore.form.description"/></label>
              <textarea id="adminSpotDesc" name="description" maxlength="2000" required>${fn:escapeXml(adminEditForm.description)}</textarea>
            </div>
            <div class="det-admin-field full">
              <label for="adminSpotImage"><spring:message code="explore.form.image"/></label>
              <input type="file" id="adminSpotImage" name="image" accept=".jpg,.jpeg,.png,.gif,.webp">
            </div>
            <div class="det-admin-field full">
              <label><spring:message code="explore.form.tags"/></label>
              <div class="det-admin-tag-box">
                <c:forEach var="tag" items="${writeTagList}">
                  <label class="det-admin-tag">
                    <input type="checkbox" name="tags" value="${fn:escapeXml(tag)}"
                           <c:forEach var="selectedTag" items="${adminEditForm.tags}">
                             <c:if test="${selectedTag == tag}">checked</c:if>
                           </c:forEach>>
                    <span>${fn:escapeXml(tag)}</span>
                  </label>
                </c:forEach>
              </div>
            </div>
          </div>
          <div class="det-admin-foot">
            <button type="button" class="det-action-btn" id="cancelAdminEditBtn"><spring:message code="explore.cancel"/></button>
            <button type="submit" class="det-action-btn active"><spring:message code="explore.save"/></button>
          </div>
        </form>
      </div>
    </div>
  </c:if>

  <!-- 기본 정보 -->
  <div class="det-section">
    <h2>&#127760; <spring:message code="detail.info.title"/></h2>
    <div class="info-grid">
      <c:if test="${not empty spot.region}">
        <div class="info-row">
          <span class="info-label"><spring:message code="detail.info.region"/></span>
          <span class="info-value">${fn:escapeXml(spot.region)}</span>
        </div>
      </c:if>
      <c:if test="${not empty spot.address}">
        <div class="info-row">
          <span class="info-label"><spring:message code="detail.info.address"/></span>
          <span class="info-value">${fn:escapeXml(spot.address)}</span>
        </div>
      </c:if>
      <div class="info-row">
        <span class="info-label"><spring:message code="detail.info.rating"/></span>
        <span class="info-value">
          &#11088;
          <c:choose>
            <c:when test="${spot.reviewCount > 0}">
              <fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/> / 5.0
              &nbsp;(<spring:message code="detail.review.title"/> ${spot.reviewCount}<spring:message code="explore.count"/>)
            </c:when>
            <c:otherwise><spring:message code="detail.info.noReview"/></c:otherwise>
          </c:choose>
        </span>
      </div>
      <div class="info-row">
        <span class="info-label"><spring:message code="detail.info.like"/></span>
        <span class="info-value">&#10084; ${spot.likeCount}<spring:message code="explore.count"/></span>
      </div>
    </div>
  </div>

  <!-- 소개 -->
  <c:if test="${not empty spot.description}">
    <div class="det-section">
      <h2>&#128214; <spring:message code="detail.intro.title"/></h2>
      <p class="det-desc">${fn:escapeXml(spot.description)}</p>
    </div>
  </c:if>

  <!-- 태그 -->
  <c:if test="${not empty spot.tags}">
    <div class="det-section">
      <h2>&#127914; <spring:message code="detail.tags.title"/></h2>
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
      <h2>&#128506; <spring:message code="detail.location.title"/></h2>

      <!-- 지도 컨테이너 -->
      <div id="googleMap" style="
          width:100%; height:420px;
          border-radius:10px; overflow:hidden;
          border:1px solid var(--gray-200);
          background:var(--gray-100);">
      </div>

    </div>
  </c:if>

  <!-- 리뷰 섹션 -->
  <div class="det-section">
    <h2>&#128172; <spring:message code="detail.review.title"/></h2>

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
        <div class="review-sub"><spring:message code="detail.review.total" arguments="${spot.reviewCount}"/></div>
      </div>
    </div>

    <!-- 리뷰 작성 영역 -->
    <div id="reviewWriteArea">
    <c:choose>
      <%-- 로그인했고 아직 리뷰를 작성하지 않은 경우 작성 폼 표시 --%>
      <c:when test="${canWrite}">
        <div class="review-form-box" id="reviewFormBox">
          <h3>&#9997; <spring:message code="detail.review.write"/></h3>
          <div class="star-picker" id="starPicker">
            <span class="sp" data-v="1">&#9733;</span>
            <span class="sp" data-v="2">&#9733;</span>
            <span class="sp" data-v="3">&#9733;</span>
            <span class="sp" data-v="4">&#9733;</span>
            <span class="sp" data-v="5">&#9733;</span>
          </div>
          <textarea class="review-textarea" id="reviewContent"
                    maxlength="500" placeholder="<spring:message code="detail.review.placeholder"/>"></textarea>
          <div class="review-form-foot">
            <span class="review-char"><span id="charCount">0</span> / 500</span>
            <button class="review-submit-btn" id="reviewSubmitBtn" disabled><spring:message code="detail.review.submit"/></button>
          </div>
        </div>
      </c:when>
      <%-- 로그인했고 이미 리뷰를 작성한 경우 안내 문구 --%>
      <c:when test="${isLoggedIn and not canWrite}">
        <div id="alreadyReviewBox"
             style="background:var(--gray-50);border-radius:10px;padding:16px 20px;margin-bottom:28px;
                    font-size:14px;color:var(--gray-500);border:1px solid var(--gray-200);">
          &#10003; <spring:message code="detail.review.written"/>
        </div>
      </c:when>
      <%-- 비로그인 시 로그인 유도 --%>
      <c:otherwise>
        <div class="review-login-box">
          <p>&#128172; <spring:message code="detail.review.login.need"/></p>
          <a href="${pageContext.request.contextPath}/auth/login" class="review-login-link"><spring:message code="detail.review.login"/></a>
        </div>
      </c:otherwise>
    </c:choose>
    </div><%-- /reviewWriteArea --%>

    <!-- 리뷰 목록 -->
    <c:if test="${isAdminMode and not empty reviewList}">
      <div class="review-admin-tools">
        <div class="review-admin-left">
          <label class="review-admin-select-all">
            <input type="checkbox" id="reviewSelectAll">
            <span><spring:message code="detail.review.admin.selectAll"/></span>
          </label>
          <span class="review-sub"><spring:message code="detail.review.admin.help"/></span>
        </div>
        <button type="button" class="review-admin-bulk-btn" id="blockSelectedReviewsBtn" disabled>
          <spring:message code="detail.review.admin.blockSelected"/>
        </button>
      </div>
    </c:if>

    <div class="review-list" id="reviewList">
      <c:choose>
        <c:when test="${not empty reviewList}">
          <c:forEach var="rv" items="${reviewList}">
            <div class="review-card" id="rv-${rv.reviewIdx}">
              <div class="review-card-top">
                <div class="review-author-info">
                  <c:if test="${isAdminMode}">
                    <input type="checkbox"
                           class="review-admin-check"
                           data-review-select="${rv.reviewIdx}">
                  </c:if>
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
                  <c:if test="${isAdminMode}">
                    <button class="det-admin-review-btn"
                            type="button"
                            data-block-review-idx="${rv.reviewIdx}"
                            data-block-spot-idx="${spot.spotIdx}"><spring:message code="detail.review.block"/></button>
                  </c:if>
                </div>
              </div>
              <p class="review-content">${fn:escapeXml(rv.content)}</p>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <div class="review-empty" id="reviewEmpty">
            <spring:message code="detail.review.empty"/>
          </div>
        </c:otherwise>
      </c:choose>
    </div>

  </div><!-- /리뷰 섹션 -->

  <!-- AI 맞춤 여행지 추천 섹션 <로그인 사용자만> -->
  <c:if test="${isLoggedIn}">
  <div class="det-section" id="aiRecommendSection">
    <h2 id="aiRecTitle"><spring:message code="detail.ai.title"/></h2>
    <p id="aiRecDesc" style="font-size:13px;color:var(--gray-500);margin-bottom:20px;">
      <spring:message code="detail.ai.desc"/>
    </p>
    <div class="ai-rec-content">
      <div id="recLoadingMsg" class="ai-rec-state">
        <span style="font-size:24px;display:block;margin-bottom:8px;">&#x1F916;</span>
        <spring:message code="detail.ai.loading"/>
      </div>
      <div class="spot-grid" id="recGrid" style="display:none;"></div>
      <div id="recEmptyMsg" class="ai-rec-state" style="display:none;">
        <spring:message code="detail.ai.empty"/>
      </div>
    </div>
  </div>
  </c:if>

  <!-- 탐색 버튼 -->
  <div style="text-align:center;margin-top:32px;">
    <button class="det-action-btn"
            onclick="location.href='${pageContext.request.contextPath}/explore'"
            style="margin:0 auto;">
      &#128269; <spring:message code="detail.explore.more"/>
    </button>
  </div>

</div>

<!-- 토스트 -->
<div class="toast" id="toast"></div>
<div id="adminEditSuccessMsg" data-message="${fn:escapeXml(adminEditSuccess)}" style="display:none;"></div>

<%@ include file="../common/footer.jsp" %>

<script>
(function () {
  'use strict';

  const ctx      = '${pageContext.request.contextPath}';
  const spotIdx  = '${spot.spotIdx}';
  const loginUserIdx = '${loginUserIdx}';
  const adminEditModal = document.getElementById('adminEditModal');
  if (adminEditModal && adminEditModal.classList.contains('show')) {
    document.body.classList.add('modal-open');
  }

  /* 토스트 */
  function showToast(msg) {
    const t = document.getElementById('toast');
    t.textContent = msg;
    t.classList.add('show');
    setTimeout(() => t.classList.remove('show'), 2500);
  }

  const successMsg = document.getElementById('adminEditSuccessMsg');
  if (successMsg && successMsg.dataset.message) {
    showToast(successMsg.dataset.message);
  }

  /* 관리자 여행지 수정 모달 */
  function openAdminModal() {
    if (!adminEditModal) return;
    adminEditModal.classList.add('show');
    document.body.classList.add('modal-open');
  }

  function closeAdminModal() {
    if (!adminEditModal) return;
    adminEditModal.classList.remove('show');
    document.body.classList.remove('modal-open');
  }

  const openAdminEditBtn = document.getElementById('openAdminEditBtn');
  const closeAdminEditBtn = document.getElementById('closeAdminEditBtn');
  const cancelAdminEditBtn = document.getElementById('cancelAdminEditBtn');

  openAdminEditBtn && openAdminEditBtn.addEventListener('click', openAdminModal);
  closeAdminEditBtn && closeAdminEditBtn.addEventListener('click', closeAdminModal);
  cancelAdminEditBtn && cancelAdminEditBtn.addEventListener('click', closeAdminModal);

  adminEditModal && adminEditModal.addEventListener('click', function (e) {
    if (e.target === adminEditModal) {
      closeAdminModal();
    }
  });

  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && adminEditModal && adminEditModal.classList.contains('show')) {
      closeAdminModal();
    }
  });

  const adminTagCheckboxes = document.querySelectorAll('#adminEditForm input[name="tags"]');
  adminTagCheckboxes.forEach(function (checkbox) {
    checkbox.addEventListener('change', function () {
      const checked = document.querySelectorAll('#adminEditForm input[name="tags"]:checked');
      if (checked.length > 4) {
        this.checked = false;
        showToast('태그는 최대 4개까지 선택할 수 있습니다.');
      }
    });
  });

  /* 찜 / 좋아요 토글 */
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
        btn.querySelector('.det-action-label').textContent = active ? onText : offText;
        btn.querySelector('.det-action-icon').textContent =
            active ? (key === 'favorited' ? '⭐' : '❤️') : (key === 'favorited' ? '☆' : '🤍');
        showToast(active ? onMsg : offMsg);
      })
      .catch(() => showToast('처리 중 오류가 발생했습니다.'));
  }

  const favBtn  = document.querySelector('.fav-btn');
  const likeBtn = document.querySelector('.like-btn');

  favBtn && favBtn.addEventListener('click', function () {
    toggleAction('/explore/favorite/' + spotIdx, this,
                 '찜 완료', '찜하기', '⭐ 찜 추가', '찜 취소', 'favorited');
  });

  likeBtn && likeBtn.addEventListener('click', function () {
    toggleAction('/explore/like/' + spotIdx, this,
                 '좋아요 완료', '좋아요', '❤️ 좋아요', '좋아요 취소', 'liked');
  });

  /* 별점 선택기 */
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

  /* 리뷰 등록 */
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
        showToast('리뷰가 등록되었습니다.');
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

  /* 리뷰 삭제 */
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

            // 2. 리뷰 목록이 비었으면 빈 상태 메시지 표시
            const list = document.getElementById('reviewList');
            if (list && list.querySelectorAll('.review-card').length === 0) {
              list.innerHTML = '<div class="review-empty">아직 작성된 리뷰가 없습니다. 첫 번째 리뷰를 남겨보세요! 😊</div>';
            }

            // 3. "이미 작성" 안내 박스를 지우고 작성 폼 복원
            const alreadyBox = document.getElementById('alreadyReviewBox');
            if (alreadyBox) alreadyBox.remove();
            showWriteForm();
          })
          .catch(() => showToast('처리 중 오류가 발생했습니다.'));
      });
    });
  }

  /* 관리자 리뷰 차단 */
  function bindBlockBtns() {
    document.querySelectorAll('[data-block-review-idx]').forEach(btn => {
      btn.addEventListener('click', function () {
        if (!confirm('이 리뷰를 차단하시겠습니까? 차단 후 상세 화면에서 더 이상 노출되지 않습니다.')) return;

        const reviewIdx = this.dataset.blockReviewIdx;
        const currentSpotIdx = this.dataset.blockSpotIdx;

        fetch(ctx + '/detail/' + currentSpotIdx + '/review/' + reviewIdx + '/block', {
          method: 'POST'
        })
          .then(r => r.json())
          .then(data => {
            if (!data.success) {
              showToast(data.message || '차단 실패');
              return;
            }

            const card = document.getElementById('rv-' + reviewIdx);
            card && card.remove();
            showToast('리뷰가 차단되었습니다.');

            const list = document.getElementById('reviewList');
            if (list && list.querySelectorAll('.review-card').length === 0) {
              list.innerHTML = '<div class="review-empty">현재 노출 가능한 리뷰가 없습니다.</div>';
            }
          })
          .catch(() => showToast('처리 중 오류가 발생했습니다.'));
      });
    });
  }

  /* 관리자 리뷰 선택 / 전체선택 / 선택 차단 */
  const reviewSelectAll = document.getElementById('reviewSelectAll');
  const blockSelectedReviewsBtn = document.getElementById('blockSelectedReviewsBtn');

  function getSelectedReviewCheckboxes() {
    return Array.from(document.querySelectorAll('[data-review-select]:checked'));
  }

  function syncReviewSelectionUi() {
    const allCheckboxes = Array.from(document.querySelectorAll('[data-review-select]'));
    const checkedCheckboxes = getSelectedReviewCheckboxes();

    allCheckboxes.forEach(function (checkbox) {
      const card = checkbox.closest('.review-card');
      if (card) {
        card.classList.toggle('admin-selecting', checkbox.checked);
      }
    });

    if (reviewSelectAll) {
      reviewSelectAll.checked = allCheckboxes.length > 0 && checkedCheckboxes.length === allCheckboxes.length;
      reviewSelectAll.indeterminate = checkedCheckboxes.length > 0 && checkedCheckboxes.length < allCheckboxes.length;
    }

    if (blockSelectedReviewsBtn) {
      blockSelectedReviewsBtn.disabled = checkedCheckboxes.length === 0;
      blockSelectedReviewsBtn.textContent = checkedCheckboxes.length > 0
        ? '선택 차단 (' + checkedCheckboxes.length + ')'
        : '선택 차단';
    }
  }

  function bindReviewSelection() {
    document.querySelectorAll('[data-review-select]').forEach(function (checkbox) {
      checkbox.addEventListener('change', syncReviewSelectionUi);
    });

    reviewSelectAll && reviewSelectAll.addEventListener('change', function () {
      const checked = this.checked;
      document.querySelectorAll('[data-review-select]').forEach(function (checkbox) {
        checkbox.checked = checked;
      });
      syncReviewSelectionUi();
    });

    blockSelectedReviewsBtn && blockSelectedReviewsBtn.addEventListener('click', function () {
      const selectedIds = getSelectedReviewCheckboxes().map(function (checkbox) {
        return Number(checkbox.dataset.reviewSelect);
      });

      if (selectedIds.length === 0) {
        showToast('차단할 리뷰를 선택해주세요.');
        return;
      }

      const isAllSelected = document.querySelectorAll('[data-review-select]').length === selectedIds.length;
      const confirmMessage = isAllSelected
        ? '현재 보이는 리뷰를 모두 차단하시겠습니까?'
        : '선택한 리뷰를 차단하시겠습니까?';
      if (!confirm(confirmMessage)) return;

      fetch(ctx + '/detail/' + spotIdx + '/review/block-bulk', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ reviewIdxList: selectedIds })
      })
        .then(function (r) { return r.json(); })
        .then(function (data) {
          if (!data.success) {
            showToast(data.message || '차단 실패');
            return;
          }

          selectedIds.forEach(function (reviewId) {
            const card = document.getElementById('rv-' + reviewId);
            card && card.remove();
          });

          if (reviewSelectAll) {
            reviewSelectAll.checked = false;
            reviewSelectAll.indeterminate = false;
          }

          syncReviewSelectionUi();
          showToast((data.blockedCount || selectedIds.length) + '개의 리뷰가 차단되었습니다.');

          const list = document.getElementById('reviewList');
          if (list && list.querySelectorAll('.review-card').length === 0) {
            const tools = document.querySelector('.review-admin-tools');
            tools && tools.remove();
            list.innerHTML = '<div class="review-empty">현재 노출 가능한 리뷰가 없습니다.</div>';
          }
        })
        .catch(function () {
          showToast('처리 중 오류가 발생했습니다.');
        });
    });

    syncReviewSelectionUi();
  }

  /* 리뷰 작성 폼을 #reviewWriteArea 안에 동적으로 생성 */
  function showWriteForm() {
    const area = document.getElementById('reviewWriteArea');
    if (!area) return;
    // 이미 폼이 있으면 중복 생성 방지
    if (area.querySelector('#reviewFormBox')) return;

    area.innerHTML = `
      <div class="review-form-box" id="reviewFormBox">
        <h3>✍ 리뷰 작성</h3>
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
  bindBlockBtns();
  bindReviewSelection();

})();
</script>

<%-- Google Maps: 위도/경도가 있는 경우만 로드 --%>
<c:if test="${not empty spot.latitude and not empty spot.longitude and spot.latitude != 0 and spot.longitude != 0}">
<script>
/* 여행지 좌표와 이름 */
var SPOT_LAT  = parseFloat('<fmt:formatNumber value="${spot.latitude}"  pattern="0.######" groupingUsed="false"/>');
var SPOT_LNG  = parseFloat('<fmt:formatNumber value="${spot.longitude}" pattern="0.######" groupingUsed="false"/>');
var SPOT_NAME = '${fn:escapeXml(spot.name)}';

/* 서울 기준 좌표 */
var SEOUL_LAT = 37.5665;
var SEOUL_LNG = 126.9780;

var googleMap, destinationMarker, seoulMarker, routeLine, labelOverlay;
var lineVisible = false;

/* 1. 도시명 라벨 (OverlayView 커스텀 표시) */
function CityLabel(position, map) {
  this.position_ = position;
  this.div_      = null;
  this.setMap(map);
}

function cityLabel_onAdd() {
  var div = document.createElement('div');
  div.style.cssText = [
    'position:absolute',
    'background:#fff',
    'border:1.5px solid #ef4444',
    'border-radius:7px',
    'padding:4px 10px',
    'box-shadow:0 2px 6px rgba(0,0,0,.20)',
    'pointer-events:none',
    'white-space:nowrap',
    'text-align:center',
    'transform:translateX(-50%)',
    'font-size:13px',
    'font-weight:700',
    'color:#1f2937',
    'font-family:"Noto Sans KR",sans-serif'
  ].join(';');
  div.textContent = SPOT_NAME;

  /* 말풍선 꼬리 */
  var tail = document.createElement('div');
  tail.style.cssText = [
    'position:absolute',
    'bottom:-7px',
    'left:50%',
    'transform:translateX(-50%)',
    'width:0',
    'height:0',
    'border-left:5px solid transparent',
    'border-right:5px solid transparent',
    'border-top:7px solid #ef4444'
  ].join(';');
  div.appendChild(tail);

  this.div_ = div;
  this.getPanes().floatPane.appendChild(div);
}

function cityLabel_draw() {
  var pos = this.getProjection().fromLatLngToDivPixel(this.position_);
  if (pos && this.div_) {
    this.div_.style.left = pos.x + 'px';
    this.div_.style.top  = (pos.y - 48) + 'px';
  }
}

function cityLabel_onRemove() {
  if (this.div_ && this.div_.parentNode) {
    this.div_.parentNode.removeChild(this.div_);
    this.div_ = null;
  }
}

/* 2. Google Maps 초기화 */
function initMap() {
  if (isNaN(SPOT_LAT) || isNaN(SPOT_LNG)) {
    document.getElementById('googleMap').innerHTML =
      '<div style="display:flex;align-items:center;justify-content:center;height:100%;color:#6b7280;font-size:14px;">'
      + '\uc88c\ud45c \uc815\ubcf4\uac00 \uc5c6\uc2b5\ub2c8\ub2e4.</div>';
    return;
  }

  /* google.maps 로드 후 OverlayView 연결 */
  CityLabel.prototype = Object.create(google.maps.OverlayView.prototype);
  CityLabel.prototype.constructor = CityLabel;
  CityLabel.prototype.onAdd    = cityLabel_onAdd;
  CityLabel.prototype.draw     = cityLabel_draw;
  CityLabel.prototype.onRemove = cityLabel_onRemove;

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

  /* 목적지 포함 Bounds */
  var bounds = new google.maps.LatLngBounds();
  bounds.extend(new google.maps.LatLng(SPOT_LAT,  SPOT_LNG));
  bounds.extend(new google.maps.LatLng(SEOUL_LAT, SEOUL_LNG));
  googleMap.fitBounds(bounds, { top: 100, right: 60, bottom: 60, left: 60 });

  /* 목적지 여행지 마커 (빨간 핀) */
  destinationMarker = new google.maps.Marker({
    position:  destLatLng,
    map:       googleMap,
    title:     SPOT_NAME,
    icon: {
      path:         google.maps.SymbolPath.CIRCLE,
      scale:        8,
      fillColor:    '#ef4444',
      fillOpacity:  1,
      strokeColor:  '#ffffff',
      strokeWeight: 2
    },
    zIndex:    10,
    animation: google.maps.Animation.DROP
  });

  /* 서울 기준 마커 (파란 핀) */
  seoulMarker = new google.maps.Marker({
    position:  seoulLatLng,
    map:       googleMap,
    title:     '\uc11c\uc6b8',
    icon: {
      path:         google.maps.SymbolPath.CIRCLE,
      scale:        7,
      fillColor:    '#2563eb',
      fillOpacity:  1,
      strokeColor:  '#ffffff',
      strokeWeight: 2
    },
    zIndex:    9,
    animation: google.maps.Animation.DROP
  });

  /* 서울 라벨 */
  new google.maps.Marker({
    position: { lat: SEOUL_LAT + 1.6, lng: SEOUL_LNG },
    map:      googleMap,
    icon:     { path: google.maps.SymbolPath.CIRCLE, scale: 0 },
    label: {
      text:       '\uc11c\uc6b8',
      color:      '#1e40af',
      fontSize:   '12px',
      fontWeight: '700'
    }
  });

  /* 목적지 도시명 라벨 (항상 표시) */
  labelOverlay = new CityLabel(
    new google.maps.LatLng(SPOT_LAT, SPOT_LNG),
    googleMap
  );

  /* 목적지 연결선 Polyline (초기 숨김) */
  routeLine = new google.maps.Polyline({
    path:          [seoulLatLng, destLatLng],
    geodesic:      true,
    strokeColor:   '#2563eb',
    strokeOpacity: 0,
    strokeWeight:  2,
    icons: [{
      icon:   { path: 'M 0,-1 0,1', strokeOpacity: 1, scale: 3 },
      offset: '0',
      repeat: '16px'
    }],
    map: googleMap
  });

  /* 여행지 마커 클릭: 연결선 토글 */
  destinationMarker.addListener('click', function () {
    if (lineVisible) {
      routeLine.setOptions({ strokeOpacity: 0 });
      lineVisible = false;
    } else {
      var opacity = 0;
      var fadeIn = setInterval(function() {
        opacity += 0.1;
        routeLine.setOptions({ strokeOpacity: Math.min(opacity, 0.85) });
        if (opacity >= 0.85) clearInterval(fadeIn);
      }, 25);
      lineVisible = true;
    }
    destinationMarker.setAnimation(google.maps.Animation.BOUNCE);
    setTimeout(function() { destinationMarker.setAnimation(null); }, 1200);
  });

  /* 지도 클릭 시 연결선 닫기 */
  googleMap.addListener('click', function () {
    routeLine.setOptions({ strokeOpacity: 0 });
    lineVisible = false;
  });
}
</script>

<!-- Google Maps JavaScript API -->
<script
  src="https://maps.googleapis.com/maps/api/js?key=${mapsApiKey}&callback=initMap&loading=async&language=ko&region=KR"
  async defer></script>
</c:if>

<%-- 체류 시간 기록 + AI 추천 (로그인 사용자만) --%>
<c:if test="${isLoggedIn}">
<script>
(function() {
  var CTX_REC      = '${pageContext.request.contextPath}';
  var SPOT_IDX_REC = '${spot.spotIdx}';
  var pageEnter    = Date.now();
  var logSent      = false;

  /* 체류 시간 전송: fetch + keepalive 사용 */
  function sendViewLog() {
    if (logSent) return;
    var staySeconds = Math.round((Date.now() - pageEnter) / 1000);
    if (staySeconds < 2) return;
    logSent = true;
    fetch(CTX_REC + '/recommend/view-log', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ spotIdx: SPOT_IDX_REC, staySeconds: staySeconds }),
      keepalive: true
    }).then(function() {
      /* 체류 시간 전송 완료 후 추천 섹션 즉시 새로고침 */
      refreshRecommendations();
    }).catch(function() { /* 무시 */ });
  }
  window.addEventListener('beforeunload', sendViewLog);
  document.addEventListener('visibilitychange', function() {
    if (document.visibilityState === 'hidden') sendViewLog();
  });

  /* 추천 카드 HTML 생성 */
  function buildRecCard(spot) {
    var thumb = spot.thumbUrl ||
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600&q=80';
    var tags  = (spot.tags || []).slice(0, 3).map(function(t) {
      return '<span class="spot-tag">' + escHtml(t) + '</span>';
    }).join('');
    var rating = (spot.ratingAvg || 0).toFixed(1);
    var reason = spot.recReason ? '<p style="font-size:12px;color:var(--blue);margin-top:6px;">&#x1F916; ' + escHtml(spot.recReason) + '</p>' : '';

    return '<div class="spot-card" style="cursor:pointer;" onclick="location.href=\'' +
           CTX_REC + '/detail/' + spot.spotIdx + '\'">' +
      '<div class="spot-card__img-wrap">' +
        '<img class="spot-card__img" src="' + escHtml(thumb) + '" alt="' + escHtml(spot.spotName) + '"' +
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

  function escHtml(str) {
    if (!str) return '';
    return String(str)
      .replace(/&/g, '&amp;').replace(/</g, '&lt;')
      .replace(/>/g, '&gt;').replace(/"/g, '&quot;');
  }

  /* AI 추천 조회 (최초 로드) */
  function loadRecommendations() {
    fetch(CTX_REC + '/recommend/spots?currentSpotIdx=' + SPOT_IDX_REC)
      .then(function(r) { return r.json(); })
      .then(function(data) {
        var loadMsg  = document.getElementById('recLoadingMsg');
        var grid     = document.getElementById('recGrid');
        var emptyMsg = document.getElementById('recEmptyMsg');

        if (!data.success || !data.spots || data.spots.length === 0) {
          if (loadMsg)  loadMsg.style.display  = 'none';
          if (emptyMsg) emptyMsg.style.display = 'block';
          return;
        }
        /* 인기 추천 응답이면 섹션 제목 변경 */
        var title = document.getElementById('aiRecTitle');
        var desc  = document.getElementById('aiRecDesc');
        if (data.isTrending) {
          if (title) title.textContent = '\uD83D\uDD25 ?붿쬁 ?⑤뒗 ?ы뻾吏 異붿쿇';
          if (desc)  desc.textContent  = '理쒓렐 媛??留롮? 愿?ъ쓣 諛쏄퀬 ?덈뒗 ?ы뻾吏瑜??뚭컻?대뱶由쎈땲??';
        } else {
          if (title) title.innerHTML = '&#x1F916; AI 맞춤 추천 여행지';
          if (desc)  desc.textContent = '회원님의 관심 여행지를 분석해 비슷한 취향의 여행지를 추천해드립니다.';
        }
        if (grid) {
          grid.innerHTML     = data.spots.map(buildRecCard).join('');
          grid.style.display = '';
        }
        if (loadMsg) loadMsg.style.display = 'none';
        if (emptyMsg) emptyMsg.style.display = 'none';
      })
      .catch(function() {
        var loadMsg = document.getElementById('recLoadingMsg');
        if (loadMsg) loadMsg.textContent = '異붿쿇 ?뺣낫瑜?遺덈윭?ㅼ? 紐삵뻽?듬땲??';
      });
  }

  /* 추천만 조용히 새로고침 (체류 기록 전송 후) */
  function refreshRecommendations() {
    fetch(CTX_REC + '/recommend/spots?currentSpotIdx=' + SPOT_IDX_REC)
      .then(function(r) { return r.json(); })
      .then(function(data) {
        var grid     = document.getElementById('recGrid');
        var emptyMsg = document.getElementById('recEmptyMsg');
        if (!data.success || !data.spots || data.spots.length === 0) return;
        if (grid) {
          grid.innerHTML     = data.spots.map(buildRecCard).join('');
          grid.style.display = '';
        }
        if (emptyMsg) emptyMsg.style.display = 'none';
      })
      .catch(function() { /* 새로고침 실패는 조용히 무시 */ });
  }

  /* 페이지 로드 후 1초 뒤 최초 추천 조회 */
  setTimeout(loadRecommendations, 1000);
})();
</script>
</c:if>

</body>
</html>





