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
    &#8592; <spring:message code="community.detail.back"/>
  </button>

  <main class="detail-main">

      <%-- 제목 --%>
      <h1 class="detail-title">${post.title}</h1>

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
            <c:if test="${not empty sessionScope.loginUser and not isOwner and not isAdminMode}">
              <span class="detail-author-name rpt-user-link" data-user-idx="${post.userIdx}" data-source-type="post" data-source-id="${post.postId}">${post.nickname}</span>
              <span class="comment-author-link rpt-user-link" data-user-idx="${post.userIdx}" data-source-type="post" data-source-id="${post.postId}" style="font-size:11px;color:var(--gray-400);cursor:pointer;text-decoration:underline;margin-right:2px;"><spring:message code="community.detail.userReport"/></span>
            </c:if>
            <c:if test="${empty sessionScope.loginUser or isOwner or isAdminMode}">
              <span class="detail-author-name">${post.nickname}</span>
            </c:if>
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
            <c:when test="${post.postType eq 'review'}"><spring:message code="community.type.review"/></c:when>
            <c:when test="${post.postType eq 'photo'}"><spring:message code="community.type.photo"/></c:when>
            <c:when test="${post.postType eq 'tip'}"><spring:message code="community.type.tip"/></c:when>
            <c:when test="${post.postType eq 'question'}"><spring:message code="community.type.question"/></c:when>
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

      <%-- 유형별 추가 정보 --%>
      <c:if test="${post.postType eq 'tip' and not empty tipCategory}">
        <div class="detail-type-extra">
          <span class="type-extra-label">팁카테고리</span>
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
            <c:otherwise><span class="solved-badge unsolved">&#8987; 해결중</span></c:otherwise>
          </c:choose>
        </div>
      </c:if>

      <%-- 이미지 세로 나열 --%>
      <c:if test="${not empty imageList}">
        <div class="detail-image-list">
          <c:forEach var="img" items="${imageList}">
            <div class="detail-image-item">
              <c:choose>
                <c:when test="${fn:startsWith(img.imageUrl, 'http')}">
                  <img src="${img.imageUrl}" alt="${post.title}" loading="lazy"
                       onclick="window.open('${img.imageUrl}', '_blank')">
                </c:when>
                <c:otherwise>
                  <img src="${pageContext.request.contextPath}${img.imageUrl}" alt="${post.title}" loading="lazy"
                       onclick="window.open('${pageContext.request.contextPath}${img.imageUrl}', '_blank')">
                </c:otherwise>
              </c:choose>
            </div>
          </c:forEach>
        </div>
        <c:if test="${imageList[0].autoImage}">
          <p class="comm-auto-image-caption">해시태그 기반 대륙별 자동추천 이미지입니다. PixaBay 제공</p>
        </c:if>
      </c:if>

      <%-- 태그 --%>
      <c:if test="${not empty tagList}">
        <div class="detail-tags">
          <c:forEach var="tag" items="${tagList}">
            <span class="detail-tag"
                  onclick="location.href='${pageContext.request.contextPath}/community/list?keyword=${tag}'">#${tag}</span>
          </c:forEach>
        </div>
      </c:if>

      <%-- 본문 --%>
      <div class="detail-content">${post.content}</div>

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
          <button class="report-btn" data-post-id="${post.postId}" onclick="openReportModal('post', this.getAttribute('data-post-id'))">&#9888; 신고</button>
        </c:if>
      </div>

  </main>

  <%-- 댓글 섹션 --%>
  <section class="detail-comment-section">

      <%-- 댓글 상단 툴바 --%>
      <div class="comm-comment-toolbar" id="commentToolbarTop">
        <div class="comm-toolbar-left">
          <span class="comm-comment-total"><spring:message code="community.detail.comments.total" arguments="${post.commentCount}"/></span>
          <div class="comm-sort-btns">
            <button class="comm-sort-btn active" data-sort="created" onclick="sortComments('created')"><spring:message code="community.detail.comments.sort.created"/></button>
            <button class="comm-sort-btn" data-sort="latest" onclick="sortComments('latest')"><spring:message code="community.detail.comments.sort.latest"/></button>
            <button class="comm-sort-btn" data-sort="replies" onclick="sortComments('replies')"><spring:message code="community.detail.comments.sort.replies"/></button>
          </div>
        </div>
        <div class="comm-toolbar-right">
          <button class="comm-tool-btn" onclick="scrollToPost()"><spring:message code="community.detail.comments.viewPost"/></button>
          <button class="comm-tool-btn" id="commToggleBtnTop" onclick="toggleCommentSection()"><spring:message code="community.detail.comments.close"/></button>
          <button class="comm-tool-btn" onclick="refreshComments()"><spring:message code="community.detail.comments.refresh"/></button>
        </div>
      </div>

      <%-- 어드민 댓글 일괄 처리 툴바 --%>
      <c:if test="${isAdminMode}">
        <div class="comm-admin-toolbar" id="adminCommentToolbar">
          <label class="comm-admin-chk-all">
            <input type="checkbox" id="chkAllComment"> 전체선택
          </label>
          <span class="comm-admin-selected-count" id="selectedCommentCount">0개 선택됨</span>
          <div class="comm-admin-actions">
            <button class="comm-admin-btn btn-delete" onclick="doBulkCommentAction('delete')">삭제</button>
            <div class="comm-admin-dropdown">
              <button class="comm-admin-btn btn-block-user">차단 ▾</button>
              <div class="comm-admin-dropdown-menu">
                <button onclick="doBulkCommentAction('blockUser')">아이디 차단</button>
                <button onclick="doBulkCommentAction('blockIp')">아이피 차단</button>
                <button onclick="doBulkCommentAction('blockBoth')">아이디+아이피 차단</button>
              </div>
            </div>
            <div class="comm-admin-dropdown">
              <button class="comm-admin-btn btn-block-delete">차단+삭제 ▾</button>
              <div class="comm-admin-dropdown-menu">
                <button onclick="doBulkCommentAction('blockUserAndDelete')">아이디 차단+삭제</button>
                <button onclick="doBulkCommentAction('blockIpAndDelete')">아이피 차단+삭제</button>
                <button onclick="doBulkCommentAction('blockAndDelete')">아이디+아이피+삭제</button>
              </div>
            </div>
          </div>
        </div>
      </c:if>

      <%-- 댓글 목록 컨테이너 (AJAX 교체 대상) --%>
      <div id="commentListContainer">
        <div class="comment-list">
          <c:choose>
            <c:when test="${empty commentList}">
              <div class="comment-empty"><spring:message code="community.detail.comments.empty"/></div>
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
                          <c:if test="${isAdminMode}">
                            <input type="checkbox" class="comm-admin-comment-chk" data-id="${comment.commentId}"
                                   onclick="event.stopPropagation()">
                          </c:if>
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
                                      <button class="block-btn unblock" onclick="unblockComment(${comment.commentId})"><spring:message code="community.detail.comment.unblock"/></button>
                                    </c:when>
                                    <c:otherwise>
                                      <button class="block-btn" onclick="blockComment(${comment.commentId})"><spring:message code="community.detail.comment.block"/></button>
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
                                  <span class="comment-author-link rpt-user-link" data-user-idx="${comment.userIdx}" data-source-type="comment" data-source-id="${comment.commentId}" style="font-size:11px;color:var(--gray-400);cursor:pointer;text-decoration:underline;margin-right:2px;"><spring:message code="community.detail.userReport"/></span>
                                  <button class="report-btn" data-comment-id="${comment.commentId}" onclick="openReportModal('comment', this.getAttribute('data-comment-id'))">&#9888; 신고</button>
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
                                            placeholder="<spring:message code='community.detail.reply.placeholder'/>" rows="2"
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
                                    <c:if test="${isAdminMode}">
                                      <input type="checkbox" class="comm-admin-comment-chk" data-id="${reply.commentId}"
                                             onclick="event.stopPropagation()">
                                    </c:if>
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
                                                <button class="block-btn unblock" onclick="unblockComment(${reply.commentId})"><spring:message code="community.detail.comment.unblock"/></button>
                                              </c:when>
                                              <c:otherwise>
                                                <button class="block-btn" onclick="blockComment(${reply.commentId})"><spring:message code="community.detail.comment.block"/></button>
                                              </c:otherwise>
                                            </c:choose>
                                          </c:if>
                                          <span class="comment-date">
                                            <fmt:formatDate value="${reply.createdAt}" pattern="yyyy-MM-dd"/>
                                          </span>
                                          <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.userIdx ne reply.userIdx and not isAdminMode}">
                                            <span class="comment-author-link rpt-user-link" data-user-idx="${reply.userIdx}" data-source-type="comment" data-source-id="${reply.commentId}" style="font-size:11px;color:var(--gray-400);cursor:pointer;text-decoration:underline;margin-right:2px;"><spring:message code="community.detail.userReport"/></span>
                                            <button class="report-btn" data-comment-id="${reply.commentId}" onclick="openReportModal('comment', this.getAttribute('data-comment-id'))">&#9888; 신고</button>
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
        </div><%-- /comment-list --%>
      </div><%-- /commentListContainer --%>

      <%-- 페이지네이션 --%>
      <div class="comm-comment-pagination" id="commentPagination"></div>

      <%-- 댓글 하단 툴바 --%>
      <div class="comm-comment-toolbar comm-comment-toolbar-bottom" id="commentToolbarBottom">
        <div class="comm-toolbar-left">
          <span class="comm-comment-total"><spring:message code="community.detail.comments.total" arguments="${post.commentCount}"/></span>
          <div class="comm-sort-btns">
            <button class="comm-sort-btn active" data-sort="created" onclick="sortComments('created')"><spring:message code="community.detail.comments.sort.created"/></button>
            <button class="comm-sort-btn" data-sort="latest" onclick="sortComments('latest')"><spring:message code="community.detail.comments.sort.latest"/></button>
            <button class="comm-sort-btn" data-sort="replies" onclick="sortComments('replies')"><spring:message code="community.detail.comments.sort.replies"/></button>
          </div>
        </div>
        <div class="comm-toolbar-right">
          <button class="comm-tool-btn" onclick="scrollToPost()"><spring:message code="community.detail.comments.viewPost"/></button>
          <button class="comm-tool-btn" id="commToggleBtnBottom" onclick="toggleCommentSection()"><spring:message code="community.detail.comments.close"/></button>
          <button class="comm-tool-btn" onclick="refreshComments()"><spring:message code="community.detail.comments.refresh"/></button>
        </div>
      </div>

      <%-- 댓글 입력 --%>
      <div class="comment-input-wrap">
        <c:choose>
          <c:when test="${not empty sessionScope.loginUser}">
            <div class="comment-input-box">
              <textarea class="comment-textarea" id="commentText"
                        placeholder="<spring:message code='community.detail.comment.placeholder'/>" rows="3"
                        onkeydown="if(event.key==='Enter' && !event.shiftKey){event.preventDefault(); submitComment(${post.postId});}"></textarea>
              <button class="comment-submit-btn" onclick="submitComment(${post.postId})"><spring:message code="community.detail.reply.submit"/></button>
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
  </section>

  <%-- 추천 여행 이야기 --%>
  <c:if test="${not empty relatedList}">
    <div class="detail-bottom-section">
      <h3 class="detail-bottom-title"><spring:message code="community.detail.related.title"/></h3>
      <c:if test="${isAdminMode}">
        <div class="comm-admin-toolbar" id="adminRelatedToolbar">
          <label class="comm-admin-chk-all">
            <input type="checkbox" id="chkAllRelated"> 전체선택
          </label>
          <span class="comm-admin-selected-count" id="selectedRelatedCount">0개 선택됨</span>
          <div class="comm-admin-actions">
            <button class="comm-admin-btn btn-delete" onclick="doBulkPostAction('related','delete')">삭제</button>
            <div class="comm-admin-dropdown">
              <button class="comm-admin-btn btn-block-user">차단 ▾</button>
              <div class="comm-admin-dropdown-menu">
                <button onclick="doBulkPostAction('related','blockUser')">아이디 차단</button>
                <button onclick="doBulkPostAction('related','blockIp')">아이피 차단</button>
                <button onclick="doBulkPostAction('related','blockBoth')">아이디+아이피 차단</button>
              </div>
            </div>
            <div class="comm-admin-dropdown">
              <button class="comm-admin-btn btn-block-delete">차단+삭제 ▾</button>
              <div class="comm-admin-dropdown-menu">
                <button onclick="doBulkPostAction('related','blockUserAndDelete')">아이디 차단+삭제</button>
                <button onclick="doBulkPostAction('related','blockIpAndDelete')">아이피 차단+삭제</button>
                <button onclick="doBulkPostAction('related','blockAndDelete')">아이디+아이피+삭제</button>
              </div>
            </div>
          </div>
        </div>
      </c:if>
      <div class="detail-post-list">
        <c:forEach var="r" items="${relatedList}">
          <div class="post-card-wrap" data-id="${r.postId}" data-href="${pageContext.request.contextPath}/community/${r.postId}">
            <c:if test="${isAdminMode}">
              <input type="checkbox" class="comm-admin-related-chk comm-admin-post-chk" data-id="${r.postId}" onclick="event.stopPropagation()">
              <button class="post-admin-delete-btn" onclick="adminDeletePost(event, ${r.postId})">✕</button>
            </c:if>
            <div class="post-card">
              <div class="post-card-img-wrap">
                <c:choose>
                  <c:when test="${not empty r.thumbUrl}">
                    <c:choose>
                      <c:when test="${fn:startsWith(r.thumbUrl, 'http')}">
                        <img class="post-card-img" src="${r.thumbUrl}" alt="${r.title}" loading="lazy">
                      </c:when>
                      <c:otherwise>
                        <img class="post-card-img" src="${pageContext.request.contextPath}${r.thumbUrl}" alt="${r.title}" loading="lazy">
                      </c:otherwise>
                    </c:choose>
                  </c:when>
                  <c:otherwise>
                    <div class="post-card-img" style="background:var(--gray-100);display:flex;align-items:center;justify-content:center;font-size:36px;min-height:140px;">&#9992;&#65039;</div>
                  </c:otherwise>
                </c:choose>
                <span class="post-type-badge type-${r.postType}">
                  <c:choose>
                    <c:when test="${r.postType eq 'review'}"><spring:message code="community.type.review"/></c:when>
                    <c:when test="${r.postType eq 'photo'}"><spring:message code="community.type.photo"/></c:when>
                    <c:when test="${r.postType eq 'tip'}"><spring:message code="community.type.tip"/></c:when>
                    <c:when test="${r.postType eq 'question'}"><spring:message code="community.type.question"/></c:when>
                  </c:choose>
                </span>
              </div>
              <div class="post-card-body">
                <div class="post-card-author">
                  <div class="post-av">
                    <c:choose>
                      <c:when test="${not empty r.nickname}">${fn:substring(r.nickname, 0, 1)}</c:when>
                      <c:otherwise>?</c:otherwise>
                    </c:choose>
                  </div>
                  <span class="post-author-name">${r.nickname}</span>
                  <span class="post-date"><fmt:formatDate value="${r.createdAt}" pattern="yyyy-MM-dd"/></span>
                </div>
                <div class="post-card-title">${r.title}</div>
                <div class="post-card-content">${r.content}</div>
                <div class="post-card-footer">
                  <span class="post-stat like-stat">&#10084; ${r.likeCount}</span>
                  <span class="post-stat">&#128172; ${r.commentCount}</span>
                  <span class="post-stat">&#128065; ${r.viewCount}</span>
                </div>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </c:if>

  <%-- 최신글 목록 --%>
  <div class="detail-bottom-section">
    <h3 class="detail-bottom-title"><spring:message code="community.latest.title"/></h3>
    <c:if test="${isAdminMode}">
      <div class="comm-admin-toolbar" id="adminLatestToolbar">
        <label class="comm-admin-chk-all">
          <input type="checkbox" id="chkAllLatest"> 전체선택
        </label>
        <span class="comm-admin-selected-count" id="selectedLatestCount">0개 선택됨</span>
        <div class="comm-admin-actions">
          <button class="comm-admin-btn btn-delete" onclick="doBulkPostAction('latest','delete')">삭제</button>
          <div class="comm-admin-dropdown">
            <button class="comm-admin-btn btn-block-user">차단 ▾</button>
            <div class="comm-admin-dropdown-menu">
              <button onclick="doBulkPostAction('latest','blockUser')">아이디 차단</button>
              <button onclick="doBulkPostAction('latest','blockIp')">아이피 차단</button>
              <button onclick="doBulkPostAction('latest','blockBoth')">아이디+아이피 차단</button>
            </div>
          </div>
          <div class="comm-admin-dropdown">
            <button class="comm-admin-btn btn-block-delete">차단+삭제 ▾</button>
            <div class="comm-admin-dropdown-menu">
              <button onclick="doBulkPostAction('latest','blockUserAndDelete')">아이디 차단+삭제</button>
              <button onclick="doBulkPostAction('latest','blockIpAndDelete')">아이피 차단+삭제</button>
              <button onclick="doBulkPostAction('latest','blockAndDelete')">아이디+아이피+삭제</button>
            </div>
          </div>
        </div>
      </div>
    </c:if>
    <c:choose>
      <c:when test="${empty latestList}">
        <div style="text-align:center;padding:24px;font-size:13px;color:var(--gray-400);">게시글이 없습니다.</div>
      </c:when>
      <c:otherwise>
        <div class="detail-post-list">
          <c:forEach var="l" items="${latestList}">
            <div class="post-card-wrap" data-id="${l.postId}" data-href="${pageContext.request.contextPath}/community/${l.postId}">
              <c:if test="${isAdminMode}">
                <input type="checkbox" class="comm-admin-latest-chk comm-admin-post-chk" data-id="${l.postId}" onclick="event.stopPropagation()">
                <button class="post-admin-delete-btn" onclick="adminDeletePost(event, ${l.postId})">✕</button>
              </c:if>
              <div class="post-card">
                <div class="post-card-img-wrap">
                  <c:choose>
                    <c:when test="${not empty l.thumbUrl}">
                      <c:choose>
                        <c:when test="${fn:startsWith(l.thumbUrl, 'http')}">
                          <img class="post-card-img" src="${l.thumbUrl}" alt="${l.title}" loading="lazy">
                        </c:when>
                        <c:otherwise>
                          <img class="post-card-img" src="${pageContext.request.contextPath}${l.thumbUrl}" alt="${l.title}" loading="lazy">
                        </c:otherwise>
                      </c:choose>
                    </c:when>
                    <c:otherwise>
                      <div class="post-card-img" style="background:var(--gray-100);display:flex;align-items:center;justify-content:center;font-size:36px;min-height:140px;">&#9992;&#65039;</div>
                    </c:otherwise>
                  </c:choose>
                  <span class="post-type-badge type-${l.postType}">
                    <c:choose>
                      <c:when test="${l.postType eq 'review'}"><spring:message code="community.type.review"/></c:when>
                      <c:when test="${l.postType eq 'photo'}"><spring:message code="community.type.photo"/></c:when>
                      <c:when test="${l.postType eq 'tip'}"><spring:message code="community.type.tip"/></c:when>
                      <c:when test="${l.postType eq 'question'}"><spring:message code="community.type.question"/></c:when>
                    </c:choose>
                  </span>
                </div>
                <div class="post-card-body">
                  <div class="post-card-author">
                    <div class="post-av">
                      <c:choose>
                        <c:when test="${not empty l.nickname}">${fn:substring(l.nickname, 0, 1)}</c:when>
                        <c:otherwise>?</c:otherwise>
                      </c:choose>
                    </div>
                    <span class="post-author-name">${l.nickname}</span>
                    <span class="post-date"><fmt:formatDate value="${l.createdAt}" pattern="yyyy-MM-dd"/></span>
                  </div>
                  <div class="post-card-title">${l.title}</div>
                  <div class="post-card-content">${l.content}</div>
                  <div class="post-card-footer">
                    <span class="post-stat like-stat">&#10084; ${l.likeCount}</span>
                    <span class="post-stat">&#128172; ${l.commentCount}</span>
                    <span class="post-stat">&#128065; ${l.viewCount}</span>
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>

        <%-- 최신글 페이지네이션 --%>
        <c:if test="${latestTotalPage > 1}">
          <div class="latest-pagination">
            <c:if test="${latestPage > 1}">
              <a href="${pageContext.request.contextPath}/community/list?page=${latestPage - 1}"
                 class="latest-page-btn">&#8249;</a>
            </c:if>
            <c:forEach begin="1" end="${latestTotalPage}" var="p">
              <a href="${pageContext.request.contextPath}/community/list?page=${p}"
                 class="latest-page-btn ${p eq latestPage ? 'active' : ''}">${p}</a>
            </c:forEach>
            <c:if test="${latestPage < latestTotalPage}">
              <a href="${pageContext.request.contextPath}/community/list?page=${latestPage + 1}"
                 class="latest-page-btn">&#8250;</a>
            </c:if>
          </div>
        </c:if>
      </c:otherwise>
    </c:choose>
  </div>

  <%-- 검색바 --%>
  <div class="detail-search-wrap">
    <form action="${pageContext.request.contextPath}/community/list" method="get">
      <div class="detail-search-box">
        <select name="searchType" class="detail-search-select">
          <option value="all">제목+내용+해시태그</option>
          <option value="title">제목</option>
          <option value="content">내용</option>
          <option value="tag">해시태그</option>
          <option value="author">글쓴이</option>
          <option value="comment">댓글</option>
        </select>
        <span class="detail-search-divider"></span>
        <input type="text" name="keyword" class="detail-search-input"
               placeholder="<spring:message code='community.search.placeholder'/>">
        <button type="submit" class="detail-search-btn">&#128269;</button>
      </div>
    </form>
  </div>

</div>

<script>
var CTX = '${pageContext.request.contextPath}';
var COMMENT_CLOSE_LABEL = '<spring:message code="community.detail.comments.close" javaScriptEscape="true"/>';
var COMMENT_OPEN_LABEL = '<spring:message code="community.detail.comments.open" javaScriptEscape="true"/>';

/* ===== 하단 카드 클릭 이동 ===== */
document.addEventListener('click', function(e) {
  var card = e.target.closest('.post-card-wrap[data-href]');
  if (card) location.href = card.getAttribute('data-href');
});

/* ===== 댓글 툴바 ===== */
var COMMENT_SORT = 'created';
var COMMENT_PAGE = 1;
var COMMENT_PAGE_SIZE = 10;
var COMMENT_SECTION_OPEN = true;

function sortComments(sort) {
  COMMENT_SORT = sort;
  COMMENT_PAGE = 1;
  document.querySelectorAll('.comm-sort-btn').forEach(function(btn) {
    btn.classList.toggle('active', btn.dataset.sort === sort);
  });
  refreshComments();
}

function refreshComments() {
  fetch(CTX + '/community/${post.postId}/comments?sort=' + COMMENT_SORT, {
    headers: { 'X-Requested-With': 'XMLHttpRequest' }
  })
  .then(function(res) { return res.text(); })
  .then(function(html) {
    document.getElementById('commentListContainer').innerHTML = html;
    var countEl = document.getElementById('ajaxCommentCount');
    if (countEl) {
      var n = countEl.textContent.trim();
      document.querySelectorAll('.comm-comment-count-val').forEach(function(el) { el.textContent = n; });
    }
    COMMENT_PAGE = 1;
    initCommentPagination();
  });
}

function toggleCommentSection() {
  var container = document.getElementById('commentListContainer');
  var pagination = document.getElementById('commentPagination');
  COMMENT_SECTION_OPEN = !COMMENT_SECTION_OPEN;
  container.style.display = COMMENT_SECTION_OPEN ? '' : 'none';
  if (pagination) pagination.style.display = COMMENT_SECTION_OPEN ? '' : 'none';
  var label = COMMENT_SECTION_OPEN ? '댓글 닫기' : '댓글 열기';
  label = COMMENT_SECTION_OPEN ? COMMENT_CLOSE_LABEL : COMMENT_OPEN_LABEL;
  document.getElementById('commToggleBtnTop').textContent = label;
  document.getElementById('commToggleBtnBottom').textContent = label;
}

function scrollToPost() {
  var main = document.querySelector('.detail-main');
  if (main) main.scrollIntoView({ behavior: 'smooth' });
}

function initCommentPagination() {
  var container = document.querySelector('#commentListContainer .comment-list');
  if (!container) return;
  var allChildren = Array.from(container.children);
  var groups = [];
  var currentGroup = null;
  allChildren.forEach(function(el) {
    if (el.classList.contains('comment-item') && !el.classList.contains('reply-item')) {
      currentGroup = [el];
      groups.push(currentGroup);
    } else if (el.classList.contains('reply-item') && currentGroup) {
      currentGroup.push(el);
    }
  });
  var total = groups.length;
  var totalPages = Math.max(1, Math.ceil(total / COMMENT_PAGE_SIZE));
  allChildren.forEach(function(el) { el.style.display = 'none'; });
  var start = (COMMENT_PAGE - 1) * COMMENT_PAGE_SIZE;
  var end = Math.min(start + COMMENT_PAGE_SIZE, total);
  groups.slice(start, end).forEach(function(group) {
    group.forEach(function(el) { el.style.display = ''; });
  });
  if (total === 0) {
    var emptyEl = container.querySelector('.comment-empty');
    if (emptyEl) emptyEl.style.display = '';
  }
  renderCommentPagination(totalPages);
}

function renderCommentPagination(totalPages) {
  var html = '';
  if (totalPages > 1) {
    if (COMMENT_PAGE > 1) html += '<button class="comm-page-btn" onclick="goCommentPage(' + (COMMENT_PAGE - 1) + ')">&#8249;</button>';
    for (var i = 1; i <= totalPages; i++) {
      html += '<button class="comm-page-btn' + (i === COMMENT_PAGE ? ' active' : '') + '" onclick="goCommentPage(' + i + ')">' + i + '</button>';
    }
    if (COMMENT_PAGE < totalPages) html += '<button class="comm-page-btn" onclick="goCommentPage(' + (COMMENT_PAGE + 1) + ')">&#8250;</button>';
  }
  document.getElementById('commentPagination').innerHTML = html;
}

function goCommentPage(page) {
  COMMENT_PAGE = page;
  initCommentPagination();
  document.getElementById('commentToolbarTop').scrollIntoView({ behavior: 'smooth', block: 'start' });
}

document.addEventListener('DOMContentLoaded', function() { initCommentPagination(); });


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

function submitComment(postId, forceSubmit) {
  var text = document.getElementById('commentText').value.trim();
  if (!text) return;
  var body = 'content=' + encodeURIComponent(text);
  if (forceSubmit) body += '&forceSubmit=true';
  fetch(CTX + '/community/' + postId + '/comment', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
    body: body
  })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.toxicityDetected) {
      if (confirm(data.message || '부적절한 표현이 감지되었습니다. 그래도 등록하시겠습니까?')) {
        submitComment(postId, true);
      }
      return;
    }
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

function submitReply(postId, commentId, forceSubmit) {
  var text = document.getElementById('replyText_' + commentId).value.trim();
  if (!text) return;
  var body = 'content=' + encodeURIComponent(text);
  if (forceSubmit) body += '&forceSubmit=true';
  fetch(CTX + '/community/' + postId + '/comment/' + commentId + '/reply', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
    body: body
  })
  .then(function(res) { return res.json(); })
  .then(function(data) {
    if (data.toxicityDetected) {
      if (confirm(data.message || '부적절한 표현이 감지되었습니다. 그래도 등록하시겠습니까?')) {
        submitReply(postId, commentId, true);
      }
      return;
    }
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

function openReportModal(targetType, targetId) {
    document.getElementById('rptTargetType').value = targetType;
    document.getElementById('rptTargetId').value   = targetId;
    document.getElementById('rptReason').value      = '';
    document.getElementById('rptDescription').value = '';
    document.getElementById('rptReasonMsg').textContent = '';
    document.getElementById('rpt-modal').style.display = 'flex';
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

/* ===== 어드민 댓글 일괄 처리 ===== */
(function () {
    var chkAll     = document.getElementById('chkAllComment');
    var countLabel = document.getElementById('selectedCommentCount');
    if (!chkAll) return;

    function getChecked() {
        return Array.from(document.querySelectorAll('.comm-admin-comment-chk:checked'));
    }

    function updateCount() {
        countLabel.textContent = getChecked().length + '개 선택됨';
    }

    chkAll.addEventListener('change', function () {
        document.querySelectorAll('.comm-admin-comment-chk').forEach(function (c) {
            c.checked = chkAll.checked;
        });
        updateCount();
    });

    document.addEventListener('change', function (e) {
        if (e.target.classList.contains('comm-admin-comment-chk')) {
            if (!e.target.checked) chkAll.checked = false;
            updateCount();
        }
    });

})();

window.doBulkCommentAction = function (action) {
    var checked = Array.from(document.querySelectorAll('.comm-admin-comment-chk:checked'));
    if (checked.length === 0) { alert('선택된 댓글이 없습니다.'); return; }

    var labels = {
        'delete':              '삭제',
        'blockUser':           '아이디 차단',
        'blockIp':             '아이피 차단',
        'blockBoth':           '아이디+아이피 차단',
        'blockUserAndDelete':  '아이디 차단+삭제',
        'blockIpAndDelete':    '아이피 차단+삭제',
        'blockAndDelete':      '아이디+아이피+삭제'
    };
    if (!confirm(checked.length + '개 댓글에 대해 [' + labels[action] + '] 을(를) 실행하시겠습니까?')) return;

    var commentIds = checked.map(function (c) { return c.getAttribute('data-id'); });
    var params     = new URLSearchParams();
    params.append('action', action);
    commentIds.forEach(function (id) { params.append('commentIds', id); });

    fetch(CTX + '/community/admin/bulk/comment', {
        method:  'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest' },
        body:    params.toString()
    })
    .then(function (res) { return res.json(); })
    .then(function (data) {
        if (data.success) { alert('처리가 완료되었습니다.'); location.reload(); }
        else alert('처리 중 오류가 발생했습니다: ' + (data.message || ''));
    })
    .catch(function () { alert('요청 중 오류가 발생했습니다.'); });
};

/* ===== 추천/최신 섹션 어드민 ===== */
function adminDeletePost(event, postId) {
  event.stopPropagation();
  if (!confirm('이 게시글을 삭제하시겠습니까?')) return;
  fetch(CTX + '/community/' + postId, {
    method: 'DELETE', headers: {'X-Requested-With': 'XMLHttpRequest'}
  }).then(function(res) {
    if (res.ok) location.reload();
    else alert('삭제에 실패했습니다.');
  });
}

(function() {
  var sections = [
    { chkAllId: 'chkAllRelated', cls: '.comm-admin-related-chk', countId: 'selectedRelatedCount' },
    { chkAllId: 'chkAllLatest',  cls: '.comm-admin-latest-chk',  countId: 'selectedLatestCount'  }
  ];
  sections.forEach(function(s) {
    var chkAll = document.getElementById(s.chkAllId);
    if (!chkAll) return;
    var countLabel = document.getElementById(s.countId);
    function updateCount() {
      countLabel.textContent = document.querySelectorAll(s.cls + ':checked').length + '개 선택됨';
    }
    chkAll.addEventListener('change', function() {
      document.querySelectorAll(s.cls).forEach(function(c) { c.checked = chkAll.checked; });
      updateCount();
    });
    document.addEventListener('change', function(e) {
      if (e.target.matches(s.cls)) {
        if (!e.target.checked) chkAll.checked = false;
        updateCount();
      }
    });
  });
})();

window.doBulkPostAction = function(section, action) {
  var cls = section === 'related' ? '.comm-admin-related-chk' : '.comm-admin-latest-chk';
  var checked = Array.from(document.querySelectorAll(cls + ':checked'));
  if (checked.length === 0) { alert('선택된 게시글이 없습니다.'); return; }
  var labels = {
    'delete': '삭제', 'blockUser': '아이디 차단', 'blockIp': '아이피 차단',
    'blockBoth': '아이디+아이피 차단', 'blockUserAndDelete': '아이디 차단+삭제',
    'blockIpAndDelete': '아이피 차단+삭제', 'blockAndDelete': '아이디+아이피+삭제'
  };
  if (!confirm(checked.length + '개 게시글에 대해 [' + labels[action] + '] 을(를) 실행하시겠습니까?')) return;
  var params = new URLSearchParams();
  params.append('action', action);
  checked.forEach(function(c) { params.append('postIds', c.getAttribute('data-id')); });
  fetch(CTX + '/community/admin/bulk', {
    method: 'POST',
    headers: {'Content-Type': 'application/x-www-form-urlencoded', 'X-Requested-With': 'XMLHttpRequest'},
    body: params.toString()
  }).then(function(res) { return res.json(); })
    .then(function(data) {
      if (data.success) { alert('처리가 완료되었습니다.'); location.reload(); }
      else alert('처리 중 오류가 발생했습니다: ' + (data.message || ''));
    }).catch(function() { alert('요청 중 오류가 발생했습니다.'); });
};

function adminDeleteComment(event, commentId) {
  event.stopPropagation();
  if (!confirm('이 댓글을 삭제하시겠습니까?')) return;
  fetch(CTX + '/community/comment/' + commentId, {
    method: 'DELETE',
    headers: { 'X-Requested-With': 'XMLHttpRequest' }
  })
  .then(function(res) { if (res.ok) location.reload(); });
}

function openUserReportModal(targetUserIdx, sourceType, sourceId) {
    document.getElementById('rptUserTargetIdx').value    = targetUserIdx;
    document.getElementById('rptUserSourceType').value   = sourceType || '';
    document.getElementById('rptUserSourceId').value     = sourceId   || '';
    document.getElementById('rptUserDescription').value  = '';
    document.getElementById('rptUserDescMsg').textContent = '';
    document.getElementById('rpt-user-modal').style.display = 'flex';
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

/* =============================================
   신고 모달 / 유저 신고 모달 초기화
   (모달 HTML이 스크립트 아래에 있으므로 DOMContentLoaded 후 바인딩)
   ============================================= */
document.addEventListener('DOMContentLoaded', function () {

    /* ── 신고 모달 (게시글/댓글) ── */
    var rptModal     = document.getElementById('rpt-modal');
    var rptSubmitBtn = document.getElementById('rptSubmitBtn');
    var rptCancelBtn = document.getElementById('rptCancelBtn');
    var rptReasonSel = document.getElementById('rptReason');
    var rptReasonMsg = document.getElementById('rptReasonMsg');

    if (rptModal) {
        rptCancelBtn.addEventListener('click', function () {
            rptModal.style.display = 'none';
        });
        rptModal.addEventListener('click', function (e) {
            if (e.target === rptModal) rptModal.style.display = 'none';
        });
        rptSubmitBtn.addEventListener('click', function () {
            var targetType  = document.getElementById('rptTargetType').value;
            var targetId    = document.getElementById('rptTargetId').value;
            var reason      = rptReasonSel.value;
            var description = document.getElementById('rptDescription').value.trim();

            if (!reason) {
                rptReasonMsg.textContent = '신고 사유를 선택해주세요.';
                rptReasonMsg.style.color = '#ef4444';
                return;
            }
            rptReasonMsg.textContent = '';

            rptSubmitBtn.disabled = true;
            fetch(CTX + '/report/' + targetType + '/' + targetId, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'reason=' + encodeURIComponent(reason) + '&description=' + encodeURIComponent(description)
            })
            .then(function (res) { return res.json(); })
            .then(function (data) {
                rptModal.style.display = 'none';
                alert(data.message || '신고가 접수되었습니다.');
            })
            .catch(function () { alert('오류가 발생했습니다.'); })
            .finally(function () { rptSubmitBtn.disabled = false; });
        });
    }

    /* ── 유저 신고 모달 ── */
    var rptUserModal     = document.getElementById('rpt-user-modal');
    var rptUserSubmitBtn = document.getElementById('rptUserSubmitBtn');
    var rptUserCancelBtn = document.getElementById('rptUserCancelBtn');
    var rptUserDescArea  = document.getElementById('rptUserDescription');
    var rptUserDescMsg   = document.getElementById('rptUserDescMsg');

    if (rptUserModal) {
        rptUserCancelBtn.addEventListener('click', function () {
            rptUserModal.style.display = 'none';
        });
        rptUserModal.addEventListener('click', function (e) {
            if (e.target === rptUserModal) rptUserModal.style.display = 'none';
        });
        rptUserSubmitBtn.addEventListener('click', function () {
            var targetUserIdx = document.getElementById('rptUserTargetIdx').value;
            var sourceType    = document.getElementById('rptUserSourceType').value;
            var sourceId      = document.getElementById('rptUserSourceId').value;
            var description   = rptUserDescArea.value.trim();

            if (description.length < 10) {
                rptUserDescMsg.textContent = '신고 사유를 10자 이상 입력해주세요.';
                rptUserDescMsg.style.color = '#ef4444';
                return;
            }
            rptUserDescMsg.textContent = '';

            var body = 'description=' + encodeURIComponent(description);
            if (sourceType) body += '&sourceType=' + encodeURIComponent(sourceType);
            if (sourceId)   body += '&sourceId='   + encodeURIComponent(sourceId);

            rptUserSubmitBtn.disabled = true;
            fetch(CTX + '/report/user/' + targetUserIdx, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: body
            })
            .then(function (res) { return res.json(); })
            .then(function (data) {
                rptUserModal.style.display = 'none';
                alert(data.message || '신고가 접수되었습니다.');
            })
            .catch(function () { alert('오류가 발생했습니다.'); })
            .finally(function () { rptUserSubmitBtn.disabled = false; });
        });
    }

    /* ── 유저 신고 링크 클릭 핸들러 (이벤트 위임 — AJAX 교체 후에도 동작) ── */
    document.addEventListener('click', function (e) {
        var el = e.target.closest('.rpt-user-link[data-user-idx]');
        if (!el) return;
        e.stopPropagation();
        openUserReportModal(
            el.getAttribute('data-user-idx'),
            el.getAttribute('data-source-type'),
            el.getAttribute('data-source-id')
        );
    });

});
</script>

<%-- =============================================
     신고 모달 (게시글/댓글)
     ============================================= --%>
<div id="rpt-modal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,.5);z-index:9999;align-items:center;justify-content:center;">
  <div style="background:#fff;border-radius:16px;padding:28px 32px;min-width:320px;max-width:460px;width:90%;box-shadow:0 8px 32px rgba(0,0,0,.18);">
    <div style="font-size:16px;font-weight:700;color:var(--gray-800);margin-bottom:20px;">&#9888; 신고하기</div>
    <input type="hidden" id="rptTargetType" value="">
    <input type="hidden" id="rptTargetId"   value="">

    <div style="margin-bottom:16px;">
      <label style="display:block;font-size:13px;font-weight:600;color:var(--gray-700);margin-bottom:6px;">신고 사유 <span style="color:#ef4444;">*</span></label>
      <select id="rptReason" style="width:100%;padding:10px 12px;border:1px solid var(--gray-200);border-radius:8px;font-family:inherit;font-size:14px;color:var(--gray-800);outline:none;">
        <option value="">선택해주세요</option>
        <option value="spam">스팸/광고</option>
        <option value="abuse">욕설/비방</option>
        <option value="privacy">개인정보 노출</option>
        <option value="adult">음란물</option>
        <option value="illegal">불법 정보</option>
        <option value="other">기타</option>
      </select>
      <div id="rptReasonMsg" style="font-size:12px;min-height:16px;margin-top:4px;"></div>
    </div>

    <div style="margin-bottom:20px;">
      <label style="display:block;font-size:13px;font-weight:600;color:var(--gray-700);margin-bottom:6px;">상세 사유 (선택)</label>
      <textarea id="rptDescription" rows="4"
                placeholder="상세 사유를 입력해주세요..."
                style="width:100%;box-sizing:border-box;padding:10px 12px;border:1px solid var(--gray-200);border-radius:8px;font-family:inherit;font-size:14px;color:var(--gray-800);outline:none;resize:vertical;"></textarea>
    </div>

    <div style="display:flex;justify-content:flex-end;gap:10px;">
      <button id="rptCancelBtn" style="padding:9px 20px;border-radius:8px;background:var(--gray-100);color:var(--gray-600);border:none;font-family:inherit;font-size:14px;font-weight:500;cursor:pointer;">취소</button>
      <button id="rptSubmitBtn" style="padding:9px 20px;border-radius:8px;background:#ef4444;color:#fff;border:none;font-family:inherit;font-size:14px;font-weight:600;cursor:pointer;">신고하기</button>
    </div>
  </div>
</div>

<%-- =============================================
     유저 신고 모달
     ============================================= --%>
<div id="rpt-user-modal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,.5);z-index:9999;align-items:center;justify-content:center;">
  <div style="background:#fff;border-radius:16px;padding:28px 32px;min-width:320px;max-width:460px;width:90%;box-shadow:0 8px 32px rgba(0,0,0,.18);">
    <div style="font-size:16px;font-weight:700;color:var(--gray-800);margin-bottom:8px;">&#128683; 유저 신고</div>
    <div style="font-size:13px;color:var(--gray-500);margin-bottom:20px;">신고 사유를 상세히 적어주세요 (최소 10자)</div>
    <input type="hidden" id="rptUserTargetIdx"  value="">
    <input type="hidden" id="rptUserSourceType" value="">
    <input type="hidden" id="rptUserSourceId"   value="">

    <div style="margin-bottom:20px;">
      <textarea id="rptUserDescription" rows="5"
                placeholder="신고 사유를 입력해주세요..."
                style="width:100%;box-sizing:border-box;padding:10px 12px;border:1px solid var(--gray-200);border-radius:8px;font-family:inherit;font-size:14px;color:var(--gray-800);outline:none;resize:vertical;"></textarea>
      <div id="rptUserDescMsg" style="font-size:12px;min-height:16px;margin-top:4px;"></div>
    </div>

    <div style="display:flex;justify-content:flex-end;gap:10px;">
      <button id="rptUserCancelBtn" style="padding:9px 20px;border-radius:8px;background:var(--gray-100);color:var(--gray-600);border:none;font-family:inherit;font-size:14px;font-weight:500;cursor:pointer;">취소</button>
      <button id="rptUserSubmitBtn" style="padding:9px 20px;border-radius:8px;background:#ef4444;color:#fff;border:none;font-family:inherit;font-size:14px;font-weight:600;cursor:pointer;">신고하기</button>
    </div>
  </div>
</div>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
