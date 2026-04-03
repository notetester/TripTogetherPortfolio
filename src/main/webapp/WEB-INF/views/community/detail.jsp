<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  커뮤니티 상세 페이지
  Controller: GET /community/{postId}
  model 필요:
    - post             : CommunityPostDto
    - imageList        : List<CommunityPostImageDto>
    - tagList          : List<String>
    - commentList      : List<CommunityCommentDto>
    - tipCategory      : String (tip일 때만)
    - isSolved         : Boolean (question일 때만)
    - isLiked          : Boolean
    - isOwner          : Boolean
    - relatedList      : List<CommunityPostDto>
    - acceptedCommentId: Long (question일 때만)
--%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="community/community_detail.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<div class="detail-wrap">

  <button class="back-btn"
          onclick="location.href='${pageContext.request.contextPath}/community/list'">
    &#8592; 목록으로
  </button>

  <div class="detail-container">

    <%-- 메인 --%>
    <main class="detail-main">

      <%-- 작성자 바 --%>
      <div class="detail-author-bar">
        <div class="detail-av">
          <c:choose>
            <c:when test="${not empty post.nickname}">
              ${fn:substring(post.nickname, 0, 1)}
            </c:when>
            <c:otherwise>?</c:otherwise>
          </c:choose>
        </div>
        <div class="detail-author-info">
          <span class="detail-author-name">${post.nickname}</span>
          <span class="detail-date">
            <fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
          </span>
        </div>
        <span class="detail-type-badge type-${post.postType}">
          <c:choose>
            <c:when test="${post.postType eq 'review'}">여행후기</c:when>
            <c:when test="${post.postType eq 'photo'}">사진</c:when>
            <c:when test="${post.postType eq 'tip'}">여행팁</c:when>
            <c:when test="${post.postType eq 'question'}">질문</c:when>
          </c:choose>
        </span>
        <c:if test="${isOwner}">
          <div class="detail-actions">
            <button class="action-btn edit-btn"
                    onclick="location.href='${pageContext.request.contextPath}/community/edit/${post.postId}'">
              수정
            </button>
            <button class="action-btn delete-btn"
                    onclick="deletePost(${post.postId})">삭제</button>
          </div>
        </c:if>
      </div>

      <%-- 제목 --%>
      <h1 class="detail-title">${post.title}</h1>

      <%-- 유형별 추가 정보 --%>
      <c:if test="${post.postType eq 'tip' and not empty tipCategory}">
        <div class="detail-type-extra">
          <span class="type-extra-label">카테고리</span>
          <span class="type-extra-value">
            <c:choose>
              <c:when test="${tipCategory eq 'transport'}">&#9992; 교통</c:when>
              <c:when test="${tipCategory eq 'accom'}">&#127968; 숙소</c:when>
              <c:when test="${tipCategory eq 'food'}">&#127869; 맛집</c:when>
              <c:when test="${tipCategory eq 'money'}">&#128176; 환전·예산</c:when>
              <c:when test="${tipCategory eq 'safety'}">&#128737; 안전</c:when>
              <c:otherwise>&#128161; 기타</c:otherwise>
            </c:choose>
          </span>
        </div>
      </c:if>
      <c:if test="${post.postType eq 'question'}">
        <div class="detail-type-extra">
          <c:choose>
            <c:when test="${isSolved}">
              <span class="solved-badge solved">&#10003; 해결됨</span>
            </c:when>
            <c:otherwise>
              <span class="solved-badge unsolved">&#8987; 미해결</span>
            </c:otherwise>
          </c:choose>
        </div>
      </c:if>

      <%-- 이미지 슬라이더 --%>
      <c:if test="${not empty imageList}">
        <div class="detail-slider">
          <div class="slider-track" id="sliderTrack">
            <c:forEach var="img" items="${imageList}">
              <div class="slide-item">
                <img src="${img.imageUrl}" alt="${post.title}" loading="lazy"
                     onclick="window.open('${img.imageUrl}', '_blank')">
              </div>
            </c:forEach>
          </div>
          <c:if test="${fn:length(imageList) > 1}">
            <button class="slider-btn slider-prev" onclick="slideMove(-1)">&#8249;</button>
            <button class="slider-btn slider-next" onclick="slideMove(1)">&#8250;</button>
            <div class="slider-dots" id="sliderDots">
              <c:forEach var="img" items="${imageList}" varStatus="status">
                <span class="dot ${status.first ? 'active' : ''}"
                      onclick="slideTo(${status.index})"></span>
              </c:forEach>
            </div>
          </c:if>
        </div>
      </c:if>

      <%-- 본문 --%>
      <div class="detail-content">${post.content}</div>

      <%-- 태그 --%>
      <c:if test="${not empty tagList}">
        <div class="detail-tags">
          <c:forEach var="tag" items="${tagList}">
            <span class="detail-tag"
                  onclick="location.href='${pageContext.request.contextPath}/community/list?keyword=${tag}'">#${tag}</span>
          </c:forEach>
        </div>
      </c:if>

      <%-- 액션 바 --%>
      <div class="detail-action-bar">
        <c:choose>
          <c:when test="${not empty sessionScope.loginUser}">
            <button class="like-btn ${isLiked ? 'liked' : ''}"
                    id="likeBtn" onclick="toggleLike(${post.postId})">
              <span class="like-icon" id="likeIcon">
                <c:choose>
                  <c:when test="${isLiked}">&#10084;</c:when>
                  <c:otherwise>&#9825;</c:otherwise>
                </c:choose>
              </span>
              <span id="likeCount">${post.likeCount}</span>
            </button>
          </c:when>
          <c:otherwise>
            <button class="like-btn"
                    onclick="location.href='${pageContext.request.contextPath}/auth/login'">
              <span class="like-icon">&#9825;</span>
              <span>${post.likeCount}</span>
            </button>
          </c:otherwise>
        </c:choose>
        <span class="comment-count-badge">&#128172; ${post.commentCount}</span>
        <span class="view-count-badge">&#128065; ${post.viewCount}</span>
        <c:if test="${not empty sessionScope.loginUser and not isOwner}">
          <button class="report-btn" onclick="reportPost(${post.postId})">&#9888; 신고</button>
        </c:if>
      </div>

    </main>

    <%-- 댓글 사이드바 --%>
    <aside class="detail-comment-wrap">
      <div class="comment-header">
        <span class="comment-title">댓글 <span>${post.commentCount}</span></span>
      </div>

      <div class="comment-list">
        <c:choose>
          <c:when test="${empty commentList}">
            <div class="comment-empty">아직 댓글이 없어요. 첫 댓글을 남겨보세요!</div>
          </c:when>
          <c:otherwise>
            <c:forEach var="comment" items="${commentList}">
              <%-- 일반 댓글만 (대댓글 제외) --%>
              <c:if test="${comment.commentStatus eq 'ACTIVE' and empty comment.parentCommentId}">
                <div class="comment-item" id="comment_${comment.commentId}">
                  <div class="comment-av">
                    <c:choose>
                      <c:when test="${not empty comment.nickname}">
                        ${fn:substring(comment.nickname, 0, 1)}
                      </c:when>
                      <c:otherwise>?</c:otherwise>
                    </c:choose>
                  </div>
                  <div class="comment-body">
                    <div class="comment-top">
                      <span class="comment-author">${comment.nickname}</span>
                      <c:if test="${comment.commentId eq acceptedCommentId}">
                        <span class="accepted-badge">&#10003; 채택됨</span>
                      </c:if>
                      <span class="comment-date">
                        <fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd"/>
                      </span>
                      <c:if test="${isOwner and post.postType eq 'question'
                                   and not isSolved
                                   and comment.commentId ne acceptedCommentId}">
                        <button class="accept-btn"
                                onclick="acceptComment(${post.postId}, ${comment.commentId})">채택하기</button>
                      </c:if>
                      <c:if test="${not empty sessionScope.loginUser
                                    and sessionScope.loginUser.userIdx eq comment.userIdx}">
                        <button class="comment-delete-btn"
                                onclick="deleteComment(${comment.commentId})">삭제</button>
                      </c:if>
                    </div>
                    <div class="comment-text">${comment.content}</div>
                    <div class="comment-actions">
                      <c:choose>
                        <c:when test="${not empty sessionScope.loginUser}">
                          <button class="comment-like-btn"
                                  id="commentLike_${comment.commentId}"
                                  onclick="toggleCommentLike(${comment.commentId}, this)">
                            &#10084; <span id="commentLikeCount_${comment.commentId}">${comment.likeCount}</span>
                          </button>
                          <button class="reply-btn"
                                  onclick="toggleReplyInput(${comment.commentId})">&#8618; 답글</button>
                        </c:when>
                        <c:otherwise>
                          <button class="comment-like-btn"
                                  onclick="location.href='${pageContext.request.contextPath}/auth/login'">
                            &#10084; ${comment.likeCount}
                          </button>
                        </c:otherwise>
                      </c:choose>
                    </div>
                    <%-- 답글 입력창 (기본 숨김) --%>
                    <c:if test="${not empty sessionScope.loginUser}">
                      <div class="reply-input-wrap hidden" id="replyInput_${comment.commentId}">
<textarea class="reply-textarea"
          id="replyText_${comment.commentId}"
          placeholder="답글을 입력하세요..." rows="2"
          onkeydown="if(event.key==='Enter' && !event.shiftKey){event.preventDefault(); submitReply(${post.postId}, ${comment.commentId});}"></textarea>
                        <div class="reply-input-actions">
                          <button class="reply-cancel-btn"
                                  onclick="toggleReplyInput(${comment.commentId})">취소</button>
                          <button class="reply-submit-btn"
                                  onclick="submitReply(${post.postId}, ${comment.commentId})">등록</button>
                        </div>
                      </div>
                    </c:if>
                  </div>
                </div>

                <%-- 대댓글 (해당 댓글의 자식만) --%>
                <c:forEach var="reply" items="${commentList}">
                  <c:if test="${reply.commentStatus eq 'ACTIVE'
                                and reply.parentCommentId eq comment.commentId}">
                    <div class="comment-item reply-item">
                      <div class="reply-indent">&#8618;</div>
                      <div class="comment-av reply-av">
                        <c:choose>
                          <c:when test="${not empty reply.nickname}">
                            ${fn:substring(reply.nickname, 0, 1)}
                          </c:when>
                          <c:otherwise>?</c:otherwise>
                        </c:choose>
                      </div>
                      <div class="comment-body">
                        <div class="comment-top">
                          <span class="comment-author">${reply.nickname}</span>
                          <span class="comment-date">
                            <fmt:formatDate value="${reply.createdAt}" pattern="yyyy-MM-dd"/>
                          </span>
                          <c:if test="${not empty sessionScope.loginUser
                                        and sessionScope.loginUser.userIdx eq reply.userIdx}">
                            <button class="comment-delete-btn"
                                    onclick="deleteComment(${reply.commentId})">삭제</button>
                          </c:if>
                        </div>
                        <div class="comment-text">${reply.content}</div>
                        <div class="comment-actions">
                          <c:choose>
                            <c:when test="${not empty sessionScope.loginUser}">
                              <button class="comment-like-btn"
                                      id="commentLike_${reply.commentId}"
                                      onclick="toggleCommentLike(${reply.commentId}, this)">
                                &#10084; <span id="commentLikeCount_${reply.commentId}">${reply.likeCount}</span>
                              </button>
                            </c:when>
                            <c:otherwise>
                              <button class="comment-like-btn"
                                      onclick="location.href='${pageContext.request.contextPath}/auth/login'">
                                &#10084; ${reply.likeCount}
                              </button>
                            </c:otherwise>
                          </c:choose>
                        </div>
                      </div>
                    </div>
                  </c:if>
                </c:forEach>

              </c:if>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </div>

      <%-- 댓글 입력 --%>
      <div class="comment-input-wrap">
        <c:choose>
          <c:when test="${not empty sessionScope.loginUser}">
            <div class="comment-input-box">
<textarea class="comment-textarea" id="commentText"
          placeholder="여행 이야기를 댓글로 나눠보세요..." rows="3"
          onkeydown="if(event.key==='Enter' && !event.shiftKey){event.preventDefault(); submitComment(${post.postId});}"></textarea>
              <button class="comment-submit-btn"
                      onclick="submitComment(${post.postId})">등록</button>
            </div>
          </c:when>
          <c:otherwise>
            <div class="comment-login-notice">
              <p>댓글을 작성하려면
                <a href="${pageContext.request.contextPath}/auth/login" class="login-link">로그인</a>
                이 필요합니다.
              </p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </aside>

  </div>

  <%-- 관련 글 --%>
  <c:if test="${not empty relatedList}">
    <div class="related-wrap">
      <h3 class="related-title">다른 여행 이야기</h3>
      <div class="related-grid">
        <c:forEach var="r" items="${relatedList}">
          <div class="related-card"
               onclick="location.href='${pageContext.request.contextPath}/community/${r.postId}'">
            <c:choose>
              <c:when test="${not empty r.thumbUrl}">
                <img class="related-img" src="${r.thumbUrl}" alt="${r.title}" loading="lazy">
              </c:when>
              <c:otherwise>
                <div class="related-img-placeholder"></div>
              </c:otherwise>
            </c:choose>
            <div class="related-info">
              <div class="related-card-title">${r.title}</div>
              <div class="related-card-author">
                ${r.nickname} ·
                <fmt:formatDate value="${r.createdAt}" pattern="yyyy-MM-dd"/>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </c:if>

</div>

<script>
var CTX = '${pageContext.request.contextPath}';
var slideIdx = 0;
var slideTotal = ${fn:length(imageList)};

function slideMove(dir) {
  slideIdx = (slideIdx + dir + slideTotal) % slideTotal;
  updateSlider();
}
function slideTo(idx) {
  slideIdx = idx;
  updateSlider();
}
function updateSlider() {
  document.getElementById('sliderTrack').style.transform =
      'translateX(-' + (slideIdx * 100) + '%)';
  document.querySelectorAll('.dot').forEach(function(d, i) {
    d.classList.toggle('active', i === slideIdx);
  });
}

function toggleLike(postId) {
  fetch(CTX + '/community/' + postId + '/like', {
    method: 'POST',
    headers: { 'X-Requested-With': 'XMLHttpRequest' }
  })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    var btn   = document.getElementById('likeBtn');
    var icon  = document.getElementById('likeIcon');
    var count = document.getElementById('likeCount');
    btn.classList.toggle('liked', data.liked);
    icon.innerHTML = data.liked ? '&#10084;' : '&#9825;';
    count.textContent = data.likeCount;
  });
}

function submitComment(postId) {
  var text = document.getElementById('commentText').value.trim();
  if (!text) return;
  fetch(CTX + '/community/' + postId + '/comment', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest'
    },
    body: 'content=' + encodeURIComponent(text)
  })
  .then(function(res) { if (res.ok) location.reload(); });
}

function deleteComment(commentId) {
  if (!confirm('댓글을 삭제하시겠습니까?')) return;
  fetch(CTX + '/community/comment/' + commentId, {
    method: 'DELETE',
    headers: { 'X-Requested-With': 'XMLHttpRequest' }
  })
  .then(function(res) { if (res.ok) location.reload(); });
}

function deletePost(postId) {
  if (!confirm('게시글을 삭제하시겠습니까?')) return;
  fetch(CTX + '/community/' + postId, {
    method: 'DELETE',
    headers: { 'X-Requested-With': 'XMLHttpRequest' }
  })
  .then(function(res) {
    if (res.ok) location.href = CTX + '/community/list';
  });
}

function acceptComment(postId, commentId) {
  if (!confirm('이 댓글을 채택하시겠습니까? 채택 후에는 변경할 수 없어요.')) return;
  fetch(CTX + '/community/' + postId + '/accept/' + commentId, {
    method: 'POST',
    headers: { 'X-Requested-With': 'XMLHttpRequest' }
  })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) {
      location.reload();
    } else {
      alert(data.message || '채택 중 오류가 발생했습니다.');
    }
  });
}

function toggleReplyInput(commentId) {
  var wrap = document.getElementById('replyInput_' + commentId);
  wrap.classList.toggle('hidden');
  if (!wrap.classList.contains('hidden')) {
    document.getElementById('replyText_' + commentId).focus();
  }
}

function submitReply(postId, commentId) {
  var text = document.getElementById('replyText_' + commentId).value.trim();
  if (!text) return;
  fetch(CTX + '/community/' + postId + '/comment/' + commentId + '/reply', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'X-Requested-With': 'XMLHttpRequest'
    },
    body: 'content=' + encodeURIComponent(text)
  })
  .then(function(res) { if (res.ok) location.reload(); });
}

function toggleCommentLike(commentId, btn) {
  fetch(CTX + '/community/comment/' + commentId + '/like', {
    method: 'POST',
    headers: { 'X-Requested-With': 'XMLHttpRequest' }
  })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    var countEl = document.getElementById('commentLikeCount_' + commentId);
    countEl.textContent = data.likeCount;
    btn.style.color = data.liked ? '#ef4444' : '';
  });
}

function reportPost(postId) {
  if (confirm('이 게시글을 신고하시겠습니까?')) {
    fetch(CTX + '/community/' + postId + '/report', {
      method: 'POST',
      headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(function() { alert('신고가 접수되었습니다.'); });
  }
}
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
