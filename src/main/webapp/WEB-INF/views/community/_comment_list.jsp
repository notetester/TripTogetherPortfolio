<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  댓글 목록 AJAX 프래그먼트
  model 필요: post, commentList, acceptedCommentId, isOwner, isAdminMode (interceptor 자동 주입)
--%>
<span id="ajaxCommentCount" style="display:none">${fn:length(commentList)}</span>

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
              <c:if test="${comment.commentStatus eq 'ACTIVE' or (comment.commentStatus eq 'BLOCKED' and comment.reportCount >= 3) or isAdminMode}">
                <div class="comment-item" id="comment_${comment.commentId}">
                  <div class="comment-av">
                    <c:choose>
                      <c:when test="${not empty comment.nickname}">${fn:substring(comment.nickname, 0, 1)}</c:when>
                      <c:otherwise>?</c:otherwise>
                    </c:choose>
                  </div>
                  <div class="comment-body-wrap ${comment.reportCount >= 3 and comment.commentStatus eq 'BLOCKED' and !isAdminMode ? 'report-blurred-wrap' : ''}">
                    <div class="comment-body ${comment.bubbleClass} ${comment.reportCount >= 3 and comment.commentStatus eq 'BLOCKED' and !isAdminMode ? 'report-blurred' : ''}">
                      <div class="comment-top">
                        <span class="comment-author tt-nickname ${comment.nicknameColorClass} ${comment.nicknameEffectClass}">${comment.nickname}</span>
                        <c:if test="${not empty comment.profileBadgeLabel}">
                          <span class="tt-profile-badge ${comment.profileBadgeClass}">${comment.profileBadgeLabel}</span>
                        </c:if>
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
                                    onkeydown="if(event.key==='Enter' && !event.shiftKey)\u007Bevent.preventDefault(); submitReply(${post.postId}, ${comment.commentId});\u007D"></textarea>
                          <div class="reply-input-actions">
                            <button class="reply-cancel-btn" onclick="toggleReplyInput(${comment.commentId})">취소</button>
                            <button class="reply-submit-btn" onclick="submitReply(${post.postId}, ${comment.commentId})">등록</button>
                          </div>
                        </div>
                      </c:if>
                    </div><%-- /comment-body --%>
                    <c:if test="${comment.reportCount >= 3 and comment.commentStatus eq 'BLOCKED' and !isAdminMode}">
                      <div class="report-blurred-overlay" onclick="removeReportBlurComment(this)">
                        &#9888; 신고된 콘텐츠입니다. 클릭하여 확인
                      </div>
                    </c:if>
                    <c:if test="${isAdminMode and (comment.commentStatus eq 'BLOCKED' or comment.accountStatus eq 'BLOCKED')}">
                      <button class="post-admin-delete-btn" onclick="adminDeleteComment(event, ${comment.commentId})">&#10005;</button>
                    </c:if>
                  </div><%-- /comment-body-wrap --%>
                </div>

                <%-- 대댓글 --%>
                <c:forEach var="reply" items="${commentList}">
                  <c:if test="${reply.parentCommentId eq comment.commentId}">
                    <c:choose>
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
                              <div class="comment-body ${reply.bubbleClass} ${reply.reportCount >= 3 and reply.commentStatus eq 'BLOCKED' and !isAdminMode ? 'report-blurred' : ''}">
                                <div class="comment-top">
                                  <span class="comment-author tt-nickname ${reply.nicknameColorClass} ${reply.nicknameEffectClass}">${reply.nickname}</span>
                                  <c:if test="${not empty reply.profileBadgeLabel}">
                                    <span class="tt-profile-badge ${reply.profileBadgeClass}">${reply.profileBadgeLabel}</span>
                                  </c:if>
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
                              <c:if test="${reply.reportCount >= 3 and reply.commentStatus eq 'BLOCKED' and !isAdminMode}">
                                <div class="report-blurred-overlay" onclick="removeReportBlurComment(this)">
                                  &#9888; 신고된 콘텐츠입니다. 클릭하여 확인
                                </div>
                              </c:if>
                              <c:if test="${isAdminMode and (reply.commentStatus eq 'BLOCKED' or reply.accountStatus eq 'BLOCKED')}">
                                <button class="post-admin-delete-btn" onclick="adminDeleteComment(event, ${reply.commentId})">&#10005;</button>
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
