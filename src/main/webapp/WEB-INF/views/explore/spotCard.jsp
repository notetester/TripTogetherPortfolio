
<%-- i18n message declarations: var names are derived from message codes. --%>
<spring:message var="msg_explore_card_favorite" code="explore.card.favorite"/>
<spring:message var="msg_explore_card_like" code="explore.card.like"/>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="spot-card" data-spot-idx="${spot.spotIdx}">

  <div class="spot-card__img-wrap">
    <img class="spot-card__img"
         src="${not empty spot.thumbUrl ? spot.thumbUrl : 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600&q=80'}"
         alt="${fn:escapeXml(spot.name)}"
         loading="lazy"
         onerror="this.src='https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600&q=80'">

    <div class="spot-card__actions">
      <button class="action-btn fav-btn ${spot.favorited ? 'active' : ''}"
              type="button"
              title="${msg_explore_card_favorite}"
              aria-label="${msg_explore_card_favorite}">
        <c:out value="${spot.favorited ? '⭐' : '☆'}"/>
      </button>
      <button class="action-btn like-btn ${spot.liked ? 'active' : ''}"
              type="button"
              title="${msg_explore_card_like}"
              aria-label="${msg_explore_card_like}">
        <c:out value="${spot.liked ? '❤️' : '🤍'}"/>
      </button>
    </div>

    <c:if test="${not empty spot.region}">
      <span class="spot-card__region-badge">${fn:escapeXml(spot.region)}</span>
    </c:if>
  </div>

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
