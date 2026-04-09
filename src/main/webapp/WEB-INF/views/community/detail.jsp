<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  커뮤니티 상세 페이지
  model 필요:
    - post, imageList, tagList, commentList, tipCategory
    - isSolved, isLiked, isOwner, isAdmin, isAdminMode
    - relatedList, acceptedCommentId
--%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="community/community_detail.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<div class="detail-wrap">

  <button class="back-btn" onclick="location.href='${pageContext.request.contextPath}/community/list'">
    &#8592; 목록으로
  </button>

  <div class="detail-container">
    <main class="detail-main">

      <%-- 작성자 바 --%>
      <div class="detail-author-bar">
        <div class="detail-av">
          <c:choose>
            <c:when test="${not empty post.nickname}">${fn:substring(post.nickname, 0, 1)}</c:when>
            <c:otherwise>?</c:otherwise>
          </c:choose>
        </div>
        <div class="detail-author-info">
          <div style="display:flex; align-items:center; gap:6px; flex-wrap:wrap;">
            <span class="detail-author-name">${post.nickname}</span>
            <c:if test="${isAdminMode and not isOwner}">
              <c:choose>
                <c:when test="${post.accountStatus eq 'BLOCKED'}">
                  <button class="block-btn unblock" onclick="unblockUser(${post.userIdx})">👤 유저차단해제</button>
                </c:when>
                <c:otherwise>
                  <button class="block-btn" onclick="blockUser(${post.userIdx})">👤 유저차단</button>
                </c:otherwise>
              </c:choose>
              <c:choose>
                <c:when test="${post.postStatus eq 'BLOCKED'}">
                  <button class="block-btn unblock" onclick="unblockPost(${post.postId})">🚫 글차단해제</button>
                </c:when>
                <c:otherwise>
                  <button class="block-btn" onclick="blockPost(${post.postId})">🚫 글차단</button>
                </c:otherwise>
              </c:choose>
            </c:if>
          </div>
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
        <c:if test="${isOwner or isAdminMode}">
          <div class="detail-actions">
            <button class="action-btn edit-btn"
                    onclick="location.href='${pageContext.request.contextPath}/community/edit/${post.postId}'">수정</button>
            <button class="action-btn delete-btn" onclick="deletePost(${post.postId})">삭제</button>
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
            <c:when test="${isSolved}"><span class="solved-badge solved">&#10003; 해결됨</span></c:when>
            <c:otherwise><span class="solved-badge unsolved">&#8987; 미해결</span></c:otherwise>
          </c:choose>
        </div>
      </c:if>

        <br>
      <%-- 이미지 슬라이더 --%>
      <c:if test="${not empty imageList}">
        <div class="detail-slider">
          <div class="slider-track" id="sliderTrack">
            <c:forEach var="img" items="${imageList}">
              <div class="slide-item">
                <img src="${pageContext.request.contextPath}${img.imageUrl}" alt="${post.title}" loading="lazy"
                     onclick="window.open('${pageContext.request.contextPath}${img.imageUrl}', '_blank')">
              </div>
            </c:forEach>
          </div>
          <c:if test="${fn:length(imageList) > 1}">
            <button class="slider-btn slider-prev" onclick="slideMove(-1)">&#8249;</button>
            <button class="slider-btn slider-next" onclick="slideMove(1)">&#8250;</button>
            <div class="slider-dots" id="sliderDots">
              <c:forEach var="img" items="${imageList}" varStatus="status">
                <span class="dot ${status.first ? 'active' : ''}" onclick="slideTo(${status.index})"></span>
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
            <button class="like-btn ${isLiked ? 'liked' : ''}" id="likeBtn" onclick="toggleLike(${post.postId})">
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
            <button class="like-btn" onclick="location.href='${pageContext.request.contextPath}/auth/login'">
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
              <c:if test="${empty comment.parentCommentId}">
                <c:choose>
                  <%-- 관리자 직접 차단 (report_count < 3): blind --%>
                  <c:when test="${(comment.accountStatus eq 'BLOCKED' or (comment.commentStatus eq 'BLOCKED' and comment.reportCount < 3)) and !isAdminMode}">
                  </c:when>
                  <c:otherwise>
                    <%-- ACTIVE 또는 신고차단(report>=3) 또는 관리자모드 --%>
                    <c:if test="${comment.commentStatus eq 'ACTIVE' or (comment.commentStatus eq 'BLOCKED' and comment.reportCount >= 3) or isAdminMode}">
                      <div class="comment-item" id="comment_${comment.commentId}">
                        <div class="comment-av">
                          <c:choose>
                            <c:when test="${not empty comment.nickname}">${fn:substring(comment.nickname, 0, 1)}</c:when>
                            <c:otherwise>?</c:otherwise>
                          </c:choose>
                        </div>
                        <%-- comment-body-wrap: 신고차단이면 report-blurred-wrap --%>
                        <div class="comment-body-wrap ${comment.reportCount >= 3 and comment.commentStatus eq 'BLOCKED' and !isAdminMode ? 'report-blurred-wrap' : ''}">
                          <%-- comment-body: 신고차단이면 report-blurred --%>
                          <div class="comment-body ${comment.reportCount >= 3 and comment.commentStatus eq 'BLOCKED' and !isAdminMode ? 'report-blurred' : ''}">
                            <div class="comment-top">
                              <span class="comment-author">${comment.nickname}</span>
                              <c:if test="${isAdminMode and sessionScope.loginUser.userIdx ne comment.userIdx}">
                                <c:choose>
                                  <c:when test="${comment.accountStatus eq 'BLOCKED'}">
                                    <button class="block-btn unblock" onclick="unblockUser(${comment.userIdx})">👤 유저차단해제</button>
                                  </c:when>
                                  <c:otherwise>
                                    <button class="block-btn" onclick="blockUser(${comment.userIdx})">👤 유저차단</button>
                                  </c:otherwise>
                                </c:choose>
                                <c:choose>
                                  <c:when test="${comment.commentStatus eq 'BLOCKED'}">
                                    <button class="block-btn unblock" onclick="unblockComment(${comment.commentId})">🚫 댓글차단해제</button>
                                  </c:when>
                                  <c:otherwise>
                                    <button class="block-btn" onclick="blockComment(${comment.commentId})">🚫 댓글차단</button>
                                  </c:otherwise>
                                </c:choose>
                              </c:if>
                              <c:if test="${comment.commentId eq acceptedCommentId}">
                                <span class="accepted-badge">&#10003; 채택됨</span>
                              </c:if>
                              <span class="comment-date">
                                <fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd"/>
                              </span>
                              <c:if test="${isOwner and post.postType eq 'question' and not isSolved and comment.commentId ne acceptedCommentId}">
                                <button class="accept-btn" onclick="acceptComment(${post.postId}, ${comment.commentId})">채택하기</button>
                              </c:if>
                              <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.userIdx ne comment.userIdx and not isAdminMode}">
                                <button class="report-btn" onclick="reportComment(${comment.commentId})">&#9888; 신고</button>
                              </c:if>
                              <c:if test="${not empty sessionScope.loginUser and (sessionScope.loginUser.userIdx eq comment.userIdx or isAdminMode)}">
                                <button class="comment-delete-btn" onclick="deleteComment(${comment.commentId})">삭제</button>
                              </c:if>
                            </div>
                            <div class="comment-text">${comment.content}</div>
                            <%-- 관리자모드: 차단 뱃지 --%>
                            <c:if test="${isAdminMode and (comment.commentStatus eq 'BLOCKED' or comment.accountStatus eq 'BLOCKED')}">
                              <c:choose>
                                <c:when test="${comment.commentStatus eq 'BLOCKED' and comment.reportCount >= 3}">
                                  <span class="blocked-badge">🚨 신고에 의해 차단됨</span>
                                </c:when>
                                <c:when test="${comment.commentStatus eq 'BLOCKED'}">
                                  <span class="blocked-badge">🚫 차단된 댓글</span>
                                </c:when>
                                <c:when test="${comment.accountStatus eq 'BLOCKED'}">
                                  <span class="blocked-badge">🚫 차단된 유저</span>
                                </c:when>
                              </c:choose>
                            </c:if>
                            <div class="comment-actions">
                              <c:choose>
                                <c:when test="${not empty sessionScope.loginUser}">
                                  <button class="comment-like-btn" id="commentLike_${comment.commentId}"
                                          onclick="toggleCommentLike(${comment.commentId}, this)">
                                    &#10084; <span id="commentLikeCount_${comment.commentId}">${comment.likeCount}</span>
                                  </button>
                                  <button class="reply-btn" onclick="toggleReplyInput(${comment.commentId})">&#8618; 답글</button>
                                </c:when>
                                <c:otherwise>
                                  <button class="comment-like-btn"
                                          onclick="location.href='${pageContext.request.contextPath}/auth/login'">
                                    &#10084; ${comment.likeCount}
                                  </button>
                                </c:otherwise>
                              </c:choose>
                            </div>
                            <c:if test="${not empty sessionScope.loginUser}">
                              <div class="reply-input-wrap hidden" id="replyInput_${comment.commentId}">
                                <textarea class="reply-textarea" id="replyText_${comment.commentId}"
                                          placeholder="답글을 입력하세요..." rows="2"
                                          onkeydown="if(event.key==='Enter' && !event.shiftKey){event.preventDefault(); submitReply(${post.postId}, ${comment.commentId});}"></textarea>
                                <div class="reply-input-actions">
                                  <button class="reply-cancel-btn" onclick="toggleReplyInput(${comment.commentId})">취소</button>
                                  <button class="reply-submit-btn" onclick="submitReply(${post.postId}, ${comment.commentId})">등록</button>
                                </div>
                              </div>
                            </c:if>
                          </div><%-- /comment-body --%>
                          <%-- 신고차단 overlay: comment-body 밖, comment-body-wrap 안 --%>
                          <c:if test="${comment.reportCount >= 3 and comment.commentStatus eq 'BLOCKED' and !isAdminMode}">
                            <div class="report-blurred-overlay" onclick="removeReportBlurComment(this)">
                              ⚠️ 신고된 콘텐츠입니다. 클릭하여 확인
                            </div>
                          </c:if>
                          <c:if test="${isAdminMode and (comment.commentStatus eq 'BLOCKED' or comment.accountStatus eq 'BLOCKED')}">
                            <button class="post-admin-delete-btn" onclick="adminDeleteComment(event, ${comment.commentId})">✕</button>
                          </c:if>
                        </div><%-- /comment-body-wrap --%>
                      </div>

                      <%-- 대댓글 --%>
                      <c:forEach var="reply" items="${commentList}">
                        <c:if test="${reply.parentCommentId eq comment.commentId}">
                          <c:choose>
                            <%-- 관리자 직접 차단: blind --%>
                            <c:when test="${(reply.accountStatus eq 'BLOCKED' or (reply.commentStatus eq 'BLOCKED' and reply.reportCount < 3)) and !isAdminMode}">
                            </c:when>
                            <c:otherwise>
                              <c:if test="${reply.commentStatus eq 'ACTIVE' or (reply.commentStatus eq 'BLOCKED' and reply.reportCount >= 3) or isAdminMode}">
                                <div class="comment-item reply-item">
                                  <div class="reply-indent">&#8618;</div>
                                  <div class="comment-av reply-av">
                                    <c:choose>
                                      <c:when test="${not empty reply.nickname}">${fn:substring(reply.nickname, 0, 1)}</c:when>
                                      <c:otherwise>?</c:otherwise>
                                    </c:choose>
                                  </div>
                                  <div class="comment-body-wrap ${reply.reportCount >= 3 and reply.commentStatus eq 'BLOCKED' and !isAdminMode ? 'report-blurred-wrap' : ''}">
                                    <div class="comment-body ${reply.reportCount >= 3 and reply.commentStatus eq 'BLOCKED' and !isAdminMode ? 'report-blurred' : ''}">
                                      <div class="comment-top">
                                        <span class="comment-author">${reply.nickname}</span>
                                        <c:if test="${isAdminMode and sessionScope.loginUser.userIdx ne reply.userIdx}">
                                          <c:choose>
                                            <c:when test="${reply.accountStatus eq 'BLOCKED'}">
                                              <button class="block-btn unblock" onclick="unblockUser(${reply.userIdx})">👤 유저차단해제</button>
                                            </c:when>
                                            <c:otherwise>
                                              <button class="block-btn" onclick="blockUser(${reply.userIdx})">👤 유저차단</button>
                                            </c:otherwise>
                                          </c:choose>
                                          <c:choose>
                                            <c:when test="${reply.commentStatus eq 'BLOCKED'}">
                                              <button class="block-btn unblock" onclick="unblockComment(${reply.commentId})">🚫 댓글차단해제</button>
                                            </c:when>
                                            <c:otherwise>
                                              <button class="block-btn" onclick="blockComment(${reply.commentId})">🚫 댓글차단</button>
                                            </c:otherwise>
                                          </c:choose>
                                        </c:if>
                                        <span class="comment-date">
                                          <fmt:formatDate value="${reply.createdAt}" pattern="yyyy-MM-dd"/>
                                        </span>
                                        <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.userIdx ne reply.userIdx and not isAdminMode}">
                                          <button class="report-btn" onclick="reportComment(${reply.commentId})">&#9888; 신고</button>
                                        </c:if>
                                        <c:if test="${not empty sessionScope.loginUser and (sessionScope.loginUser.userIdx eq reply.userIdx or isAdminMode)}">
                                          <button class="comment-delete-btn" onclick="deleteComment(${reply.commentId})">삭제</button>
                                        </c:if>
                                      </div>
                                      <div class="comment-text">${reply.content}</div>
                                      <%-- 관리자모드: 차단 뱃지 --%>
                                      <c:if test="${isAdminMode and (reply.commentStatus eq 'BLOCKED' or reply.accountStatus eq 'BLOCKED')}">
                                        <c:choose>
                                          <c:when test="${reply.commentStatus eq 'BLOCKED' and reply.reportCount >= 3}">
                                            <span class="blocked-badge">🚨 신고에 의해 차단됨</span>
                                          </c:when>
                                          <c:when test="${reply.commentStatus eq 'BLOCKED'}">
                                            <span class="blocked-badge">🚫 차단된 댓글</span>
                                          </c:when>
                                          <c:when test="${reply.accountStatus eq 'BLOCKED'}">
                                            <span class="blocked-badge">🚫 차단된 유저</span>
                                          </c:when>
                                        </c:choose>
                                      </c:if>
                                      <div class="comment-actions">
                                        <c:choose>
                                          <c:when test="${not empty sessionScope.loginUser}">
                                            <button class="comment-like-btn" id="commentLike_${reply.commentId}"
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
                                    </div><%-- /comment-body --%>
                                    <%-- 신고차단 overlay: comment-body 밖, comment-body-wrap 안 --%>
                                    <c:if test="${reply.reportCount >= 3 and reply.commentStatus eq 'BLOCKED' and !isAdminMode}">
                                      <div class="report-blurred-overlay" onclick="removeReportBlurComment(this)">
                                        ⚠️ 신고된 콘텐츠입니다. 클릭하여 확인
                                      </div>
                                    </c:if>
                                    <c:if test="${isAdminMode and (reply.commentStatus eq 'BLOCKED' or reply.accountStatus eq 'BLOCKED')}">
                                      <button class="post-admin-delete-btn" onclick="adminDeleteComment(event, ${reply.commentId})">✕</button>
                                    </c:if>
                                  </div><%-- /comment-body-wrap --%>
                                </div>
                              </c:if>
                            </c:otherwise>
                          </c:choose>
                        </c:if>
                      </c:forEach>

                    </c:if>
                  </c:otherwise>
                </c:choose>
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
              <button class="comment-submit-btn" onclick="submitComment(${post.postId})">등록</button>
            </div>
          </c:when>
          <c:otherwise>
            <div class="comment-login-notice">
              <p>댓글을 작성하려면
                <a href="${pageContext.request.contextPath}/auth/login" class="login-link">로그인</a>이 필요합니다.
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
                <img class="related-img" src="${pageContext.request.contextPath}${r.thumbUrl}" alt="${r.title}" loading="lazy">
              </c:when>
              <c:otherwise>
                <div class="related-img" style="background:var(--gray-100);display:flex;align-items:center;justify-content:center;font-size:36px;">✈️</div>
              </c:otherwise>
            </c:choose>
            <div class="related-info">
              <div class="related-card-title">${r.title}</div>
              <div class="related-card-author">
                ${r.nickname} · <fmt:formatDate value="${r.createdAt}" pattern="yyyy-MM-dd"/>
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
  document.getElementById('sliderTrack').style.transform = 'translateX(-' + (slideIdx * 100) + '%)';
  document.querySelectorAll('.dot').forEach(function(d, i) { d.classList.toggle('active', i === slideIdx); });
}

function toggleLike(postId) {
  fetch(CTX + '/community/' + postId + '/like', { method: 'POST', headers: { 'X-Requested-With': 'XMLHttpRequest' } })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    var btn = document.getElementById('likeBtn');
    var icon = document.getElementById('likeIcon');
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
    headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
    body: 'content=' + encodeURIComponent(text)
  })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) location.reload();
    else alert(data.message || '댓글 작성에 실패했습니다.');
  });
}

function deleteComment(commentId) {
  if (!confirm('댓글을 삭제하시겠습니까?')) return;
  fetch(CTX + '/community/comment/' + commentId, { method: 'DELETE', headers: { 'X-Requested-With': 'XMLHttpRequest' } })
  .then(function(res) { if (res.ok) location.reload(); });
}

function deletePost(postId) {
  if (!confirm('게시글을 삭제하시겠습니까?')) return;
  fetch(CTX + '/community/' + postId, { method: 'DELETE', headers: { 'X-Requested-With': 'XMLHttpRequest' } })
  .then(function(res) { if (res.ok) location.href = CTX + '/community/list'; });
}

function acceptComment(postId, commentId) {
  if (!confirm('이 댓글을 채택하시겠습니까? 채택 후에는 변경할 수 없어요.')) return;
  fetch(CTX + '/community/' + postId + '/accept/' + commentId, { method: 'POST', headers: { 'X-Requested-With': 'XMLHttpRequest' } })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) location.reload();
    else alert(data.message || '채택 중 오류가 발생했습니다.');
  });
}

function toggleReplyInput(commentId) {
  var wrap = document.getElementById('replyInput_' + commentId);
  wrap.classList.toggle('hidden');
  if (!wrap.classList.contains('hidden')) document.getElementById('replyText_' + commentId).focus();
}

function submitReply(postId, commentId) {
  var text = document.getElementById('replyText_' + commentId).value.trim();
  if (!text) return;
  fetch(CTX + '/community/' + postId + '/comment/' + commentId + '/reply', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
    body: 'content=' + encodeURIComponent(text)
  })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) location.reload();
    else alert(data.message || '답글 작성에 실패했습니다.');
  });
}

function toggleCommentLike(commentId, btn) {
  fetch(CTX + '/community/comment/' + commentId + '/like', { method: 'POST', headers: { 'X-Requested-With': 'XMLHttpRequest' } })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    document.getElementById('commentLikeCount_' + commentId).textContent = data.likeCount;
    btn.style.color = data.liked ? '#ef4444' : '';
  });
}

function reportPost(postId) {
    if (confirm('이 게시글을 신고하시겠습니까?')) {
        fetch(CTX + '/community/' + postId + '/report', {
            method: 'POST',
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
        })
        .then(function(res) { return res.json(); })
        .then(function(data) {
            alert(data.message || '신고가 접수되었습니다.');
        });
    }
}

function blockUser(userIdx) {
  if (!confirm('이 유저를 차단하시겠습니까? 차단해제 시까지 해당 유저의 글/댓글이 블라인드 처리됩니다.')) return;
  fetch(CTX + '/community/user/' + userIdx + '/block', { method: 'POST', headers: { 'X-Requested-With': 'XMLHttpRequest' } })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) { alert('차단되었습니다.'); location.reload(); }
    else alert(data.message || '차단 중 오류가 발생했습니다.');
  });
}

function unblockUser(userIdx) {
  if (!confirm('이 유저의 차단을 해제하시겠습니까?')) return;
  fetch(CTX + '/community/user/' + userIdx + '/unblock', { method: 'POST', headers: { 'X-Requested-With': 'XMLHttpRequest' } })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) { alert('차단이 해제되었습니다.'); location.reload(); }
    else alert(data.message || '차단 해제 중 오류가 발생했습니다.');
  });
}

function blockPost(postId) {
  if (!confirm('이 게시글을 차단하시겠습니까?')) return;
  fetch(CTX + '/community/' + postId + '/block', { method: 'POST', headers: { 'X-Requested-With': 'XMLHttpRequest' } })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) { alert('게시글이 차단되었습니다.'); location.reload(); }
    else alert('차단에 실패했습니다.');
  });
}

function unblockPost(postId) {
  if (!confirm('이 게시글의 차단을 해제하시겠습니까?')) return;
  fetch(CTX + '/community/' + postId + '/unblock', { method: 'POST', headers: { 'X-Requested-With': 'XMLHttpRequest' } })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) { alert('게시글 차단이 해제되었습니다.'); location.reload(); }
    else alert('차단 해제에 실패했습니다.');
  });
}

function blockComment(commentId) {
  if (!confirm('이 댓글을 차단하시겠습니까?')) return;
  fetch(CTX + '/community/comment/' + commentId + '/block', { method: 'POST', headers: { 'X-Requested-With': 'XMLHttpRequest' } })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) { alert('댓글이 차단되었습니다.'); location.reload(); }
    else alert('차단에 실패했습니다.');
  });
}

function unblockComment(commentId) {
  if (!confirm('이 댓글의 차단을 해제하시겠습니까?')) return;
  fetch(CTX + '/community/comment/' + commentId + '/unblock', { method: 'POST', headers: { 'X-Requested-With': 'XMLHttpRequest' } })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.success) { alert('댓글 차단이 해제되었습니다.'); location.reload(); }
    else alert('차단 해제에 실패했습니다.');
  });
}

function adminDeleteComment(event, commentId) {
  event.stopPropagation();
  if (!confirm('이 댓글을 삭제하시겠습니까?')) return;
  fetch(CTX + '/community/comment/' + commentId, {
    method: 'DELETE',
    headers: { 'X-Requested-With': 'XMLHttpRequest' }
  })
  .then(function(res) { if (res.ok) location.reload(); });
}

function reportComment(commentId) {
  if (confirm('이 댓글을 신고하시겠습니까?')) {
    fetch(CTX + '/community/comment/' + commentId + '/report', {
      method: 'POST',
      headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(function(res) { return res.json(); })
    .then(function(data) {
      alert(data.message || '신고가 접수되었습니다.');
    });
  }
}

function removeReportBlurComment(overlay) {
  var wrap = overlay.closest('.report-blurred-wrap');
  wrap.classList.remove('report-blurred-wrap');
  wrap.querySelector('.report-blurred').classList.remove('report-blurred');
  overlay.remove();
}
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.report-blurred-wrap').forEach(function(wrap) {
        wrap.addEventListener('click', function() {
            var overlay = wrap.querySelector('.report-blurred-overlay');
            if (overlay) removeReportBlurComment(overlay);
        });
    });
});
</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
