<%--
  spotCard.jsp  ─  여행지 카드 컴포넌트
  필요 변수: spot (ExploreVO)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="spot-card" data-spot-idx="${spot.spotIdx}">

  <!-- 이미지 영역 -->
  <div class="spot-card__img-wrap">
    <img class="spot-card__img"
         src="${not empty spot.thumbUrl
               ? spot.thumbUrl
               : 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600&q=80'}"
         alt="${fn:escapeXml(spot.name)}"
         loading="lazy"
         onerror="this.src='https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600&q=80'">

    <!-- 찜 / 좋아요 버튼 -->
    <div class="spot-card__actions">
      <%-- 찜 버튼: 별표(⭐/☆) 사용, active 상태면 항상 ⭐ 표시 --%>
      <button class="action-btn fav-btn ${spot.favorited ? 'active' : ''}"
              title="찜하기">
        ${spot.favorited ? '⭐' : '☆'}
      </button>
      <%-- 좋아요 버튼: 하트(❤️/🤍) 사용, active 상태면 항상 ❤️ 표시 --%>
      <button class="action-btn like-btn ${spot.liked ? 'active' : ''}"
              title="좋아요">
        ${spot.liked ? '❤️' : '🤍'}
      </button>
    </div>

    <!-- 지역 뱃지 -->
    <c:if test="${not empty spot.region}">
      <span class="spot-card__region-badge">${fn:escapeXml(spot.region)}</span>
    </c:if>
  </div>

  <!-- 카드 본문 -->
  <div class="spot-card__body">
    <div class="spot-card__top">
      <div class="spot-card__name">${fn:escapeXml(spot.name)}</div>
      <div class="spot-card__rating">
        <span class="star">&#11088;</span>
        <fmt:formatNumber value="${spot.ratingAvg}" pattern="#,##0.0"/>
        <span class="spot-card__review-cnt">(${spot.reviewCount})</span>
      </div>
    </div>

    <c:if test="${not empty spot.description}">
      <p class="spot-card__desc">${fn:escapeXml(spot.description)}</p>
    </c:if>

    <div class="spot-card__tags">
      <c:forEach var="tag" items="${spot.tags}" end="3">
        <span class="spot-tag">${fn:escapeXml(tag)}</span>
      </c:forEach>
      <c:if test="${spot.likeCount > 0}">
        <span class="spot-tag" style="background:#fff0f0;color:#ef4444;">&#10084; ${spot.likeCount}</span>
      </c:if>
    </div>
  </div>
</div>
