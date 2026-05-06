<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<spring:message var="autoMsg_b2f69ffbc9" code="community.detail.comments.empty"/>
<spring:message var="autoMsg_423eccac45" code="community.detail.user.unblock"/>
<spring:message var="autoMsg_581e7174dc" code="community.detail.user.block"/>
<spring:message var="autoMsg_760c830a0f" code="community.detail.comment.unblock"/>
<spring:message var="autoMsg_e9d5c4ffeb" code="community.detail.comment.block"/>
<spring:message var="autoMsg_230fb6d09e" code="community.detail.comment.accepted"/>
<spring:message var="autoMsg_483ea0ba90" code="community.detail.comment.accept"/>
<spring:message var="autoMsg_50a5dc8152" code="community.detail.userReport"/>
<spring:message var="autoMsg_9c0344d9f4" code="community.detail.report"/>
<spring:message var="autoMsg_268c026214" code="community.detail.comment.delete"/>
<spring:message var="autoMsg_a1917c9cdc" code="community.badge.ai"/>
<spring:message var="autoMsg_2183f80782" code="community.badge.report"/>
<spring:message var="autoMsg_3501f49113" code="community.detail.badge.comment.blocked"/>
<spring:message var="autoMsg_9807026f4f" code="community.badge.user"/>
<spring:message var="autoMsg_b908d7c311" code="community.detail.reply"/>
<spring:message var="autoMsg_1ad82f64fe" code="community.detail.reply.placeholder"/>
<spring:message var="autoMsg_6937e532b6" code="community.detail.cancel"/>
<spring:message var="autoMsg_6d702a2a02" code="community.detail.submit"/>
<spring:message var="autoMsg_9311aaff61" code="community.blocked.ai"/>
<spring:message var="autoMsg_1a6f6f47e8" code="community.blocked.report"/>
<%--
  댓글 목록 AJAX 프래그먼트
  model 필요: post, commentList, acceptedCommentId, isOwner, isAdminMode (interceptor 자동 주입)
--%>
<span id="ajaxCommentCount" style="display:none">${fn:length(commentList)}</span>

<div class="comment-list">
  <c:choose>
    <c:when test="${empty commentList}">
      <div class="comment-empty">${autoMsg_b2f69ffbc9}</div>
    </c:when>
    <c:otherwise>
      <c:forEach var="comment" items="${commentList}">
        <c:if test="${empty comment.parentCommentId}">
          <c:choose>
            <%-- 관리자 직접 차단: blind --%>
            <c:when test="${(comment.accountStatus eq 'BLOCKED' or comment.commentStatus eq 'BLOCKED') and !isAdminMode}">
            </c:when>
            <c:otherwise>
              <c:if test="${comment.commentStatus eq 'ACTIVE' or isAdminMode}">
                <div class="comment-item" id="comment_${comment.commentId}">
                  <div class="comment-av">
                    <c:choose>
                      <c:when test="${not empty comment.nickname}">${fn:substring(comment.nickname, 0, 1)}</c:when>
                      <c:otherwise>?</c:otherwise>
                    </c:choose>
                  </div>
                  <c:set var="cmtBlurred" value="${(comment.reportCount >= reportThreshold or comment.aiFlagged) and !isAdminMode}"/>
                  <div class="comment-body-wrap ${cmtBlurred ? 'report-blurred-wrap' : ''}">
                    <div class="comment-body ${comment.bubbleClass} ${cmtBlurred ? 'report-blurred' : ''}">
                      <div class="comment-top">
                        <span class="comment-author tt-nickname ${comment.nicknameColorClass} ${comment.nicknameEffectClass}"><c:out value="${comment.nickname}"/></span>
                        <c:if test="${not empty comment.profileBadgeLabel}">
                          <c:choose>
                            <c:when test="${fn:startsWith(comment.profileBadgeClass, 'badge-level-')}">
                              <c:set var="lvlTier" value="${fn:substringAfter(comment.profileBadgeClass, 'badge-level-')}"/>
                              <img src="${pageContext.request.contextPath}/resources/data/level-badge-${lvlTier}-sm.svg"
                                   alt="${comment.profileBadgeLabel}"
                                   title="${comment.profileBadgeLabel}"
                                   class="tt-level-badge-img"/>
                            </c:when>
                            <c:otherwise>
                              <span class="tt-profile-badge ${comment.profileBadgeClass}">${comment.profileBadgeLabel}</span>
                            </c:otherwise>
                          </c:choose>
                        </c:if>
                        <c:if test="${isAdminMode and sessionScope.loginUser.userIdx ne comment.userIdx}">
                          <c:choose>
                            <c:when test="${comment.accountStatus eq 'BLOCKED'}">
                              <button class="block-btn unblock" onclick="unblockUser(${comment.userIdx})">${autoMsg_423eccac45}</button>
                            </c:when>
                            <c:otherwise>
                              <button class="block-btn" onclick="blockUser(${comment.userIdx})">${autoMsg_581e7174dc}</button>
                            </c:otherwise>
                          </c:choose>
                          <c:choose>
                            <c:when test="${comment.commentStatus eq 'BLOCKED'}">
                              <button class="block-btn unblock" onclick="unblockComment(${comment.commentId})">${autoMsg_760c830a0f}</button>
                            </c:when>
                            <c:otherwise>
                              <button class="block-btn" onclick="blockComment(${comment.commentId})">${autoMsg_e9d5c4ffeb}</button>
                            </c:otherwise>
                          </c:choose>
                        </c:if>
                        <c:if test="${comment.commentId eq acceptedCommentId}">
                          <span class="accepted-badge">${autoMsg_230fb6d09e}</span>
                        </c:if>
                        <span class="comment-date">
                          <fmt:formatDate value="${comment.createdAtDate}" pattern="yyyy-MM-dd"/>
                        </span>
                        <c:if test="${isOwner and post.postType eq 'question' and not isSolved and comment.commentId ne acceptedCommentId}">
                          <button class="accept-btn" onclick="acceptComment(${post.postId}, ${comment.commentId})">${autoMsg_483ea0ba90}</button>
                        </c:if>
                        <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.userIdx ne comment.userIdx and not isAdminMode}">
                          <span class="comment-author-link rpt-user-link" data-user-idx="${comment.userIdx}" data-source-type="comment" data-source-id="${comment.commentId}" style="font-size:11px;color:var(--gray-400);cursor:pointer;text-decoration:underline;margin-right:2px;">${autoMsg_50a5dc8152}</span>
                          <button class="report-btn" data-comment-id="${comment.commentId}" onclick="openReportModal('comment', this.getAttribute('data-comment-id'))">${autoMsg_9c0344d9f4}</button>
                        </c:if>
                        <c:if test="${not empty sessionScope.loginUser and (sessionScope.loginUser.userIdx eq comment.userIdx or isAdminMode)}">
                          <button class="comment-delete-btn" onclick="deleteComment(${comment.commentId})">${autoMsg_268c026214}</button>
                        </c:if>
                      </div>
                      <div class="comment-text"><c:out value="${comment.content}"/></div>
                      <c:if test="${isAdminMode and (comment.commentStatus eq 'BLOCKED' or comment.accountStatus eq 'BLOCKED' or comment.reportCount >= reportThreshold or comment.aiFlagged)}">
                        <c:choose>
                          <c:when test="${comment.aiFlagged}">
                            <span class="blocked-badge">${autoMsg_a1917c9cdc}</span>
                          </c:when>
                          <c:when test="${comment.commentStatus eq 'ACTIVE' and comment.reportCount >= reportThreshold}">
                            <span class="blocked-badge">${autoMsg_2183f80782}</span>
                          </c:when>
                          <c:when test="${comment.commentStatus eq 'BLOCKED'}">
                            <span class="blocked-badge">${autoMsg_3501f49113}</span>
                          </c:when>
                          <c:when test="${comment.accountStatus eq 'BLOCKED'}">
                            <span class="blocked-badge">${autoMsg_9807026f4f}</span>
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
                            <button class="reply-btn" onclick="toggleReplyInput(${comment.commentId})">${autoMsg_b908d7c311}</button>
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
                                    placeholder="${autoMsg_1ad82f64fe}" rows="2"
                                    onkeydown="if(event.key==='Enter' && !event.shiftKey)\u007Bevent.preventDefault(); submitReply(${post.postId}, ${comment.commentId});\u007D"></textarea>
                          <div class="reply-input-actions">
                            <button class="reply-cancel-btn" onclick="toggleReplyInput(${comment.commentId})">${autoMsg_6937e532b6}</button>
                            <button class="reply-submit-btn" onclick="submitReply(${post.postId}, ${comment.commentId})">${autoMsg_6d702a2a02}</button>
                          </div>
                        </div>
                      </c:if>
                    </div><%-- /comment-body --%>
                    <c:if test="${cmtBlurred}">
                      <div class="report-blurred-overlay" onclick="removeReportBlurComment(this)">
                        <c:choose>
                          <c:when test="${comment.aiFlagged}">${autoMsg_9311aaff61}</c:when>
                          <c:otherwise>${autoMsg_1a6f6f47e8}</c:otherwise>
                        </c:choose>
                      </div>
                    </c:if>
                    <c:if test="${isAdminMode and (comment.commentStatus eq 'BLOCKED' or comment.accountStatus eq 'BLOCKED' or comment.reportCount >= reportThreshold or comment.aiFlagged)}">
                      <button class="post-admin-delete-btn" onclick="adminDeleteComment(event, ${comment.commentId})">&#10005;</button>
                    </c:if>
                    <c:if test="${isAdminMode and (comment.aiFlagged or comment.reportCount >= reportThreshold)}">
                      <button class="post-admin-clear-blur-btn" onclick="adminClearCommentBlur(event, ${comment.commentId})">
                        <spring:message code="community.admin.clearBlur"/>
                      </button>
                    </c:if>
                  </div><%-- /comment-body-wrap --%>
                </div>

                <%-- 대댓글 --%>
                <c:forEach var="reply" items="${commentList}">
                  <c:if test="${reply.parentCommentId eq comment.commentId}">
                    <c:choose>
                      <c:when test="${(reply.accountStatus eq 'BLOCKED' or reply.commentStatus eq 'BLOCKED') and !isAdminMode}">
                      </c:when>
                      <c:otherwise>
                        <c:if test="${reply.commentStatus eq 'ACTIVE' or isAdminMode}">
                          <div class="comment-item reply-item">
                            <div class="reply-indent">&#8618;</div>
                            <div class="comment-av reply-av">
                              <c:choose>
                                <c:when test="${not empty reply.nickname}">${fn:substring(reply.nickname, 0, 1)}</c:when>
                                <c:otherwise>?</c:otherwise>
                              </c:choose>
                            </div>
                            <c:set var="rplBlurred" value="${(reply.reportCount >= reportThreshold or reply.aiFlagged) and !isAdminMode}"/>
                            <div class="comment-body-wrap ${rplBlurred ? 'report-blurred-wrap' : ''}">
                              <div class="comment-body ${reply.bubbleClass} ${rplBlurred ? 'report-blurred' : ''}">
                                <div class="comment-top">
                                  <span class="comment-author tt-nickname ${reply.nicknameColorClass} ${reply.nicknameEffectClass}"><c:out value="${reply.nickname}"/></span>
                                  <c:if test="${not empty reply.profileBadgeLabel}">
                                    <c:choose>
                                      <c:when test="${fn:startsWith(reply.profileBadgeClass, 'badge-level-')}">
                                        <c:set var="rplTier" value="${fn:substringAfter(reply.profileBadgeClass, 'badge-level-')}"/>
                                        <img src="${pageContext.request.contextPath}/resources/data/level-badge-${rplTier}-sm.svg"
                                             alt="${reply.profileBadgeLabel}"
                                             title="${reply.profileBadgeLabel}"
                                             class="tt-level-badge-img"/>
                                      </c:when>
                                      <c:otherwise>
                                        <span class="tt-profile-badge ${reply.profileBadgeClass}">${reply.profileBadgeLabel}</span>
                                      </c:otherwise>
                                    </c:choose>
                                  </c:if>
                                  <c:if test="${isAdminMode and sessionScope.loginUser.userIdx ne reply.userIdx}">
                                    <c:choose>
                                      <c:when test="${reply.accountStatus eq 'BLOCKED'}">
                                        <button class="block-btn unblock" onclick="unblockUser(${reply.userIdx})">${autoMsg_423eccac45}</button>
                                      </c:when>
                                      <c:otherwise>
                                        <button class="block-btn" onclick="blockUser(${reply.userIdx})">${autoMsg_581e7174dc}</button>
                                      </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                      <c:when test="${reply.commentStatus eq 'BLOCKED'}">
                                        <button class="block-btn unblock" onclick="unblockComment(${reply.commentId})">${autoMsg_760c830a0f}</button>
                                      </c:when>
                                      <c:otherwise>
                                        <button class="block-btn" onclick="blockComment(${reply.commentId})">${autoMsg_e9d5c4ffeb}</button>
                                      </c:otherwise>
                                    </c:choose>
                                  </c:if>
                                  <span class="comment-date">
                                    <fmt:formatDate value="${reply.createdAtDate}" pattern="yyyy-MM-dd"/>
                                  </span>
                                  <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.userIdx ne reply.userIdx and not isAdminMode}">
                                    <span class="comment-author-link rpt-user-link" data-user-idx="${reply.userIdx}" data-source-type="comment" data-source-id="${reply.commentId}" style="font-size:11px;color:var(--gray-400);cursor:pointer;text-decoration:underline;margin-right:2px;">${autoMsg_50a5dc8152}</span>
                                    <button class="report-btn" data-comment-id="${reply.commentId}" onclick="openReportModal('comment', this.getAttribute('data-comment-id'))">${autoMsg_9c0344d9f4}</button>
                                  </c:if>
                                  <c:if test="${not empty sessionScope.loginUser and (sessionScope.loginUser.userIdx eq reply.userIdx or isAdminMode)}">
                                    <button class="comment-delete-btn" onclick="deleteComment(${reply.commentId})">${autoMsg_268c026214}</button>
                                  </c:if>
                                </div>
                                <div class="comment-text"><c:out value="${reply.content}"/></div>
                                <c:if test="${isAdminMode and (reply.commentStatus eq 'BLOCKED' or reply.accountStatus eq 'BLOCKED' or reply.reportCount >= reportThreshold or reply.aiFlagged)}">
                                  <c:choose>
                                    <c:when test="${reply.aiFlagged}">
                                      <span class="blocked-badge">${autoMsg_a1917c9cdc}</span>
                                    </c:when>
                                    <c:when test="${reply.commentStatus eq 'ACTIVE' and reply.reportCount >= reportThreshold}">
                                      <span class="blocked-badge">${autoMsg_2183f80782}</span>
                                    </c:when>
                                    <c:when test="${reply.commentStatus eq 'BLOCKED'}">
                                      <span class="blocked-badge">${autoMsg_3501f49113}</span>
                                    </c:when>
                                    <c:when test="${reply.accountStatus eq 'BLOCKED'}">
                                      <span class="blocked-badge">${autoMsg_9807026f4f}</span>
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
                              <c:if test="${rplBlurred}">
                                <div class="report-blurred-overlay" onclick="removeReportBlurComment(this)">
                                  <c:choose>
                                    <c:when test="${reply.aiFlagged}">${autoMsg_9311aaff61}</c:when>
                                    <c:otherwise>${autoMsg_1a6f6f47e8}</c:otherwise>
                                  </c:choose>
                                </div>
                              </c:if>
                              <c:if test="${isAdminMode and (reply.commentStatus eq 'BLOCKED' or reply.accountStatus eq 'BLOCKED' or reply.reportCount >= reportThreshold or reply.aiFlagged)}">
                                <button class="post-admin-delete-btn" onclick="adminDeleteComment(event, ${reply.commentId})">&#10005;</button>
                              </c:if>
                              <c:if test="${isAdminMode and (reply.aiFlagged or reply.reportCount >= reportThreshold)}">
                                <button class="post-admin-clear-blur-btn" onclick="adminClearCommentBlur(event, ${reply.commentId})">
                                  <spring:message code="community.admin.clearBlur"/>
                                </button>
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
