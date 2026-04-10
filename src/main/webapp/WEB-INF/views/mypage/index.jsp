<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  마이페이지 메인
  Controller : GET /mypage
  Model 필요 :
    - user           : UsersVO
    - communityList  : List<MyPageCommunityDto>
    - communityCount : int
    - inquiryList    : List<MyPageInquiryDto>
    - inquiryCount   : int
--%>
<!DOCTYPE html>
<html lang="ko">
<c:set var="pageCSS" value="mypage/mypage.css"/>
<%@ include file="../common/header.jsp" %>
<body>

<div class="mp-wrap">

    <%-- ══════════════════════════════════════════
         프로필 배너
    ══════════════════════════════════════════ --%>
    <div class="mp-banner">
        <div class="mp-banner-inner">
            <div class="mp-avatar">👤</div>
            <div class="mp-banner-info">
                <div class="mp-banner-nick">${user.nickname}</div>
                <div class="mp-banner-meta">
                    <span>
                        <c:choose>
                            <c:when test="${user.nationality eq 'KR'}">🇰🇷 대한민국</c:when>
                            <c:when test="${user.nationality eq 'US'}">🇺🇸 미국</c:when>
                            <c:when test="${user.nationality eq 'JP'}">🇯🇵 일본</c:when>
                            <c:when test="${user.nationality eq 'CN'}">🇨🇳 중국</c:when>
                            <c:when test="${user.nationality eq 'GB'}">🇬🇧 영국</c:when>
                            <c:when test="${user.nationality eq 'FR'}">🇫🇷 프랑스</c:when>
                            <c:when test="${user.nationality eq 'DE'}">🇩🇪 독일</c:when>
                            <c:when test="${user.nationality eq 'AU'}">🇦🇺 호주</c:when>
                            <c:when test="${user.nationality eq 'CA'}">🇨🇦 캐나다</c:when>
                            <c:otherwise>🌍 ${user.nationality}</c:otherwise>
                        </c:choose>
                    </span>
                    <span>
                        <c:choose>
                            <c:when test="${user.preferredLang eq 'ko'}">🇰🇷 한국어</c:when>
                            <c:when test="${user.preferredLang eq 'en'}">🇺🇸 English</c:when>
                            <c:when test="${user.preferredLang eq 'ja'}">🇯🇵 日本語</c:when>
                            <c:when test="${user.preferredLang eq 'zh'}">🇨🇳 中文</c:when>
                            <c:otherwise>${user.preferredLang}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
            <button class="mp-banner-edit"
                    onclick="location.href='${pageContext.request.contextPath}/mypage/edit-confirm'">
                ✏️ 정보 수정
            </button>
        </div>
    </div>

    <div class="mp-inner" style="padding-top: 48px;">

        <%-- ══════════════════════════════════════════
             내 정보
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🪪</span> 내 정보
                </div>
            </div>
            <div class="mp-info-grid">
                <div class="mp-info-item">
                    <div class="mp-info-label">닉네임</div>
                    <div class="mp-info-value">${user.nickname}</div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">아이디</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${not empty user.userId}">${user.userId}</c:when>
                            <c:otherwise><span style="color:var(--gray-400);">소셜 로그인 전용</span></c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">국적</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.nationality eq 'KR'}">🇰🇷 대한민국</c:when>
                            <c:when test="${user.nationality eq 'US'}">🇺🇸 미국</c:when>
                            <c:when test="${user.nationality eq 'JP'}">🇯🇵 일본</c:when>
                            <c:when test="${user.nationality eq 'CN'}">🇨🇳 중국</c:when>
                            <c:when test="${user.nationality eq 'GB'}">🇬🇧 영국</c:when>
                            <c:when test="${user.nationality eq 'FR'}">🇫🇷 프랑스</c:when>
                            <c:when test="${user.nationality eq 'DE'}">🇩🇪 독일</c:when>
                            <c:when test="${user.nationality eq 'AU'}">🇦🇺 호주</c:when>
                            <c:when test="${user.nationality eq 'CA'}">🇨🇦 캐나다</c:when>
                            <c:otherwise>🌍 ${user.nationality}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">선호 언어</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.preferredLang eq 'ko'}">🇰🇷 한국어</c:when>
                            <c:when test="${user.preferredLang eq 'en'}">🇺🇸 English</c:when>
                            <c:when test="${user.preferredLang eq 'ja'}">🇯🇵 日本語</c:when>
                            <c:when test="${user.preferredLang eq 'zh'}">🇨🇳 中文</c:when>
                            <c:otherwise>${user.preferredLang}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">이메일</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${not empty user.userEmail}">
                                ${user.userEmail}
                                <c:if test="${user.emailVerified}">
                                    <span style="font-size:11px;color:#15803d;margin-left:4px;">✓ 인증됨</span>
                                </c:if>
                            </c:when>
                            <c:otherwise><span style="color:var(--gray-400);">미등록</span></c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mp-info-item">
                    <div class="mp-info-label">계정 상태</div>
                    <div class="mp-info-value">
                        <c:choose>
                            <c:when test="${user.accountStatus eq 'ACTIVE'}">
                                <span style="color:#15803d;">● 정상</span>
                            </c:when>
                            <c:otherwise>${user.accountStatus}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <%-- 알림 카드 --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">📬</span> 새 알림
                    <c:if test="${not empty notifications}">
                        <span class="mp-notif-count">${totalNotificationCount}</span>
                    </c:if>
                </div>
            </div>
            <div class="mp-notif-list">
                <c:choose>
                    <c:when test="${empty notifications}">
                        <div class="mp-notif-empty">새로운 알림이 없어요.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="noti" items="${notifications}">
                            <div class="mp-notif-item" data-notification-id="${noti.notificationId}"
             onclick="deleteNotification('${noti.notificationId}', '${noti.sourceType}', '${noti.sourceId}')">
                        <span class="mp-notif-type">
                            <c:choose>
                                <c:when test="${noti.sourceType eq 'community'}">[커뮤니티]</c:when>
                                <c:when test="${noti.sourceType eq 'inquiry'}">[문의게시판]</c:when>
                                <c:otherwise>[알림]</c:otherwise>
                            </c:choose>
                        </span>
                                <span class="mp-notif-msg">${noti.message}</span>
                                <span class="mp-notif-date">
                            <fmt:formatDate value="${noti.createdAt}" pattern="yyyy-MM-dd"/>
                        </span>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="mp-notif-footer">
                새 알림은 최신순으로 최대 10개까지만 표시됩니다.
            </div>
        </div>

        <%-- ══════════════════════════════════════════
             내 리뷰 (가칭)
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">⭐</span> 내 리뷰 (가칭)
                </div>
            </div>
            <div class="mp-placeholder">
                <div class="mp-placeholder-icon">🚧</div>
                <div class="mp-placeholder-msg">추후 구현 예정</div>
                <div class="mp-placeholder-sub">기능이 완성되면 여기서 확인할 수 있어요</div>
            </div>
        </div>


        <%-- ══════════════════════════════════════════
             내 여행 일정 (가칭)
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🗺️</span> 내 여행 일정 (가칭)
                </div>
            </div>
            <div class="mp-placeholder">
                <div class="mp-placeholder-icon">🚧</div>
                <div class="mp-placeholder-msg">추후 구현 예정</div>
                <div class="mp-placeholder-sub">기능이 완성되면 여기서 확인할 수 있어요</div>
            </div>
        </div>


        <%-- ══════════════════════════════════════════
             내가 작성한 커뮤니티 글
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">✍️</span>
                    내 커뮤니티 글
                    <span class="mp-card-count">${communityCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/community/list?userIdx=${user.userIdx}"
                   class="mp-card-more">전체보기 →</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty communityList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">📝</div>
                            작성한 게시글이 없습니다
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="post" items="${communityList}">
                            <a href="${pageContext.request.contextPath}/community/${post.postId}"
                               class="mp-list-item">
                                <div class="mp-list-icon">
                                    <c:choose>
                                        <c:when test="${post.postType eq 'review'}">⭐</c:when>
                                        <c:when test="${post.postType eq 'photo'}">📷</c:when>
                                        <c:when test="${post.postType eq 'tip'}">💡</c:when>
                                        <c:when test="${post.postType eq 'question'}">❓</c:when>
                                        <c:otherwise>📄</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="mp-list-content">
                                    <div class="mp-list-title">${post.title}</div>
                                    <div class="mp-list-meta">
                                        <span><fmt:formatDate value="${post.createdAt}" pattern="yyyy-MM-dd"/></span>
                                        <span>👁 ${post.viewCount}</span>
                                        <span>❤️ ${post.likeCount}</span>
                                        <span>💬 ${post.commentCount}</span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-type">
                                        <c:choose>
                                            <c:when test="${post.postType eq 'review'}">후기</c:when>
                                            <c:when test="${post.postType eq 'photo'}">사진</c:when>
                                            <c:when test="${post.postType eq 'tip'}">팁</c:when>
                                            <c:when test="${post.postType eq 'question'}">질문</c:when>
                                            <c:otherwise>${post.postType}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <%-- ══════════════════════════════════════════
             내 문의 글
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">📬</span>
                    내 문의
                    <span class="mp-card-count">${inquiryCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/inquiry/list"
                   class="mp-card-more">전체보기 →</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty inquiryList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">📭</div>
                            작성한 문의가 없습니다
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="inq" items="${inquiryList}">
                            <a href="${pageContext.request.contextPath}/inquiry/${inq.inquiryId}"
                               class="mp-list-item">
                                <div class="mp-list-icon">
                                    <c:choose>
                                        <c:when test="${inq.isPrivate == 1}">🔒</c:when>
                                        <c:otherwise>📩</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="mp-list-content">
                                    <div class="mp-list-title">${inq.title}</div>
                                    <div class="mp-list-meta">
                                        <span><fmt:formatDate value="${inq.createdAt}" pattern="yyyy-MM-dd"/></span>
                                        <span>
                                            <c:choose>
                                                <c:when test="${inq.category eq 'service'}">서비스</c:when>
                                                <c:when test="${inq.category eq 'payment'}">결제</c:when>
                                                <c:when test="${inq.category eq 'account'}">계정</c:when>
                                                <c:when test="${inq.category eq 'bug'}">오류신고</c:when>
                                                <c:otherwise>기타</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-${inq.status}">
                                        <c:choose>
                                            <c:when test="${inq.status eq 'PENDING'}">대기중</c:when>
                                            <c:when test="${inq.status eq 'IN_PROGRESS'}">처리중</c:when>
                                            <c:when test="${inq.status eq 'COMPLETED'}">✓ 답변완료</c:when>
                                        </c:choose>
                                    </span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>


    </div>
    <%-- /mp-inner --%>
</div>
<%-- /mp-wrap --%>

<script>
    /**
     * 단일 알림 삭제
     */
    function deleteNotification(notificationId, sourceType, sourceId) {
        fetch('${pageContext.request.contextPath}/mypage/notification/' + notificationId + '/read', {
            method: 'POST',
            headers: {'X-Requested-With': 'XMLHttpRequest'}
        }).then(r => r.json())
          .then(data => {
              if (data.success && data.redirectUrl) {
                  // redirectUrl은 /community/123 형태이므로 contextPath 추가
                  location.href = '${pageContext.request.contextPath}' + data.redirectUrl;
              } else {
                  alert('알림 처리 중 오류가 발생했습니다.');
              }
          })
          .catch(err => {
              console.error('알림 처리 오류:', err);
              alert('알림 처리 중 오류가 발생했습니다.');
          });
    }

    /**
     * 날짜 포맷팅 (YYYY-MM-DD)
     */
    function formatDate(dateString) {
        const date = new Date(dateString);
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

</script>

<%@ include file="../common/footer.jsp" %>
</body>
</html>
