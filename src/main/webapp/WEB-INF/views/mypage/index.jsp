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
    - reviewList     : List<MyPageReviewDto>
    - reviewCount    : int
    - planList       : List<MyPagePlanDto>
    - planCount      : int
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


        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title"><span class="mp-card-icon">🏷️</span> 등급 · 자산 · 레벨</div>
            </div>
            <div class="mp-info-grid">
                <div class="mp-info-item"><div class="mp-info-label">회원 등급</div><div class="mp-info-value">${user.memberGrade}</div></div>
                <div class="mp-info-item"><div class="mp-info-label">인증 회원</div><div class="mp-info-value"><c:choose><c:when test="${user.verifiedMember}"><span style="color:#15803d;">● 인증 회원</span></c:when><c:otherwise><span style="color:#64748b;">○ 비인증 회원</span></c:otherwise></c:choose></div></div>
                <div class="mp-info-item"><div class="mp-info-label">캐쉬</div><div class="mp-info-value"><fmt:formatNumber value="${user.cashBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label">마일리지</div><div class="mp-info-value"><fmt:formatNumber value="${user.mileageBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label">포인트</div><div class="mp-info-value"><fmt:formatNumber value="${user.pointBalance}" pattern="#,##0"/></div></div>
                <div class="mp-info-item"><div class="mp-info-label">레벨 / 경험치</div><div class="mp-info-value">Lv.${user.levelNo} / <fmt:formatNumber value="${user.expPoints}" pattern="#,##0"/> EXP</div></div>
                <div class="mp-info-item"><div class="mp-info-label">게시글 수</div><div class="mp-info-value">${user.totalPostCount}</div></div>
                <div class="mp-info-item"><div class="mp-info-label">댓글 수</div><div class="mp-info-value">${user.totalCommentCount}</div></div>
            </div>
        </div>

        <%-- ══════════════════════════════════════════
             내 등급 & 재화
             TODO: UsersVO 필드 추가 후 EL 교체
               - 등급: ${user.memberGrade}       (BRONZE/SILVER/GOLD/DIAMOND/PLATINUM)
               - 인증: ${user.isVerifiedMember}  (boolean)
               - 레벨: ${user.levelNo}
               - 경험치: ${user.expPoints}
               - 포인트: ${user.pointBalance}
               - 마일리지: ${user.mileageBalance}
               - 캐시: ${user.cashBalance}
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🏅</span> 내 등급 &amp; 재화
                </div>
            </div>
            <%-- 등급 + 레벨/경험치 --%>
            <div class="mp-grade-section">
                <div class="mp-grade-badge-wrap">
                    <span class="mp-grade-badge mp-grade-BRONZE">🥉 BRONZE</span>
                    <span class="mp-grade-verified">✓ 인증 회원</span>
                </div>
                <div class="mp-level-wrap">
                    <div class="mp-level-header">
                        <span class="mp-level-label">Lv. 1</span>
                        <span class="mp-level-xp">0 / 500 XP</span>
                    </div>
                    <div class="mp-xp-bar">
                        <div class="mp-xp-fill" style="width: 0%;"></div>
                    </div>
                </div>
            </div>
            <%-- 재화 --%>
            <div class="mp-currency-grid">
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-point.svg" alt="포인트" width="40" height="40"></div>
                    <div class="mp-currency-label">포인트</div>
                    <div class="mp-currency-value">0</div>
                </div>
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-mileage.svg" alt="마일리지" width="40" height="40"></div>
                    <div class="mp-currency-label">마일리지</div>
                    <div class="mp-currency-value">0</div>
                </div>
                <div class="mp-currency-item">
                    <div class="mp-currency-icon"><img src="${pageContext.request.contextPath}/resources/data/coin-cash.svg" alt="캐시" width="40" height="40"></div>
                    <div class="mp-currency-label">캐시</div>
                    <div class="mp-currency-value">0</div>
                </div>
            </div>
            <%-- 활동 통계
                 TODO: UsersVO 필드 추가 후 EL 교체
                   - 작성글:    ${user.totalPostCount}
                   - 작성댓글:  ${user.totalCommentCount}
                   - 리뷰:      ${user.totalReviewCount}    (explore 팀 구현 후)
                   - 여행코스:  ${user.totalCourseCount}    (courses 팀 구현 후)
            --%>
            <div class="mp-stats-grid">
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-community">커뮤니티</span>
                    <div class="mp-stats-value">0</div>
                    <div class="mp-stats-label">작성 글</div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-community">커뮤니티</span>
                    <div class="mp-stats-value">0</div>
                    <div class="mp-stats-label">작성 댓글</div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-explore">여행지탐색</span>
                    <div class="mp-stats-value">0</div>
                    <div class="mp-stats-label">리뷰</div>
                </div>
                <div class="mp-stats-item">
                    <span class="mp-stats-source mp-stats-src-courses">여행코스</span>
                    <div class="mp-stats-value">0</div>
                    <div class="mp-stats-label">여행코스</div>
                </div>
            </div>
        </div>

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
                                <c:when test="${noti.sourceType eq 'report'}">[신고게시판]</c:when>
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
             내 리뷰
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">⭐</span>
                    내 리뷰
                    <span class="mp-card-count">${reviewCount}</span>
                </div>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty reviewList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">⭐</div>
                            작성한 리뷰가 없습니다
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="review" items="${reviewList}">
                            <a href="${pageContext.request.contextPath}/detail/${review.spotIdx}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">${review.spotName}</div>
                                    <div class="mp-list-meta">
                                        <span class="mp-review-stars">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= review.rating}">★</c:when>
                                                    <c:otherwise>☆</c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </span>
                                        <c:if test="${not empty review.content}">
                                            <span class="mp-review-excerpt">${fn:substring(review.content, 0, 40)}<c:if test="${fn:length(review.content) > 40}">…</c:if></span>
                                        </c:if>
                                        <span><fmt:formatDate value="${review.createdAt}" pattern="yyyy-MM-dd"/></span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-rating">${review.rating}점</span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>


        <%-- ══════════════════════════════════════════
             내 여행 일정
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🗺️</span>
                    내 여행 일정
                    <span class="mp-card-count">${planCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/courses/list"
                   class="mp-card-more">전체보기 →</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty planList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">🗺️</div>
                            등록된 여행 일정이 없습니다
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="plan" items="${planList}">
                            <a href="${pageContext.request.contextPath}/courses/detail?planId=${plan.planId}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">${plan.title}</div>
                                    <div class="mp-list-meta">
                                        <c:if test="${not empty plan.destination}">
                                            <span>${plan.destination}</span>
                                        </c:if>
                                        <span>
                                            <fmt:formatDate value="${plan.startDate}" pattern="yyyy-MM-dd"/>
                                            ~
                                            <fmt:formatDate value="${plan.endDate}" pattern="yyyy-MM-dd"/>
                                        </span>
                                        <span><fmt:formatDate value="${plan.createdAt}" pattern="yyyy-MM-dd"/></span>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <c:choose>
                                        <c:when test="${plan.isPublic}">
                                            <span class="mp-badge mp-badge-public">공개</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="mp-badge mp-badge-private">비공개</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${plan.planSource eq 'AI'}">
                                        <span class="mp-badge mp-badge-ai">AI</span>
                                    </c:if>
                                </div>
                            </a>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
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
                                    <span class="mp-badge mp-badge-type-${post.postType}">
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


        <%-- ══════════════════════════════════════════
             내 신고내역
        ══════════════════════════════════════════ --%>
        <div class="mp-card">
            <div class="mp-card-head">
                <div class="mp-card-title">
                    <span class="mp-card-icon">🚨</span>
                    내 신고내역
                    <span class="mp-card-count">${reportCount}</span>
                </div>
                <a href="${pageContext.request.contextPath}/report/list"
                   class="mp-card-more">전체보기 →</a>
            </div>
            <div class="mp-card-body">
                <c:choose>
                    <c:when test="${empty reportList}">
                        <div class="mp-empty">
                            <div class="mp-empty-icon">📭</div>
                            접수한 신고가 없습니다
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="rpt" items="${reportList}">
                            <a href="${pageContext.request.contextPath}/report/${rpt.reportId}"
                               class="mp-list-item">
                                <div class="mp-list-content">
                                    <div class="mp-list-title">
                                        <c:choose>
                                            <c:when test="${rpt.targetType eq 'post'}">게시글 신고</c:when>
                                            <c:when test="${rpt.targetType eq 'comment'}">댓글 신고</c:when>
                                            <c:when test="${rpt.targetType eq 'user'}">유저 신고</c:when>
                                            <c:otherwise>신고</c:otherwise>
                                        </c:choose>
                                        <span style="color:var(--gray-400);font-size:12px;margin-left:4px;">#${rpt.targetId}</span>
                                    </div>
                                    <div class="mp-list-meta">
                                        <span><fmt:formatDate value="${rpt.createdAt}" pattern="yyyy-MM-dd"/></span>
                                        <c:if test="${not empty rpt.reason}">
                                            <span>
                                                <c:choose>
                                                    <c:when test="${rpt.reason eq 'spam'}">스팸/광고</c:when>
                                                    <c:when test="${rpt.reason eq 'abuse'}">욕설/비방</c:when>
                                                    <c:when test="${rpt.reason eq 'privacy'}">개인정보 노출</c:when>
                                                    <c:when test="${rpt.reason eq 'adult'}">음란물</c:when>
                                                    <c:when test="${rpt.reason eq 'illegal'}">불법 정보</c:when>
                                                    <c:when test="${rpt.reason eq 'other'}">기타</c:when>
                                                    <c:otherwise>${rpt.reason}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="mp-list-badges">
                                    <span class="mp-badge mp-badge-${rpt.status}">
                                        <c:choose>
                                            <c:when test="${rpt.status eq 'IN_REVIEW'}">검토중</c:when>
                                            <c:when test="${rpt.status eq 'RESOLVED'}">처리완료</c:when>
                                            <c:when test="${rpt.status eq 'DISMISSED'}">반려</c:when>
                                            <c:otherwise>${rpt.status}</c:otherwise>
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
    /* ===== 뒤로가기 캐시 새로고침 ===== */
    window.addEventListener('pageshow', function(e) {
        if (e.persisted) location.reload();
    });

    function deleteNotification(notificationId, sourceType, sourceId) {
        var ctx = '${pageContext.request.contextPath}';
        var fallbackUrl = ctx + (
            sourceType === 'community' ? '/community/' + sourceId :
            sourceType === 'inquiry'   ? '/inquiry/'   + sourceId :
            sourceType === 'report'    ? '/report/'    + sourceId : '/mypage'
        );

        fetch(ctx + '/mypage/notification/' + notificationId + '/read', {
            method: 'POST',
            headers: {'X-Requested-With': 'XMLHttpRequest'}
        }).then(r => r.json())
          .then(data => {
              location.href = (data.success && data.redirectUrl)
                  ? ctx + data.redirectUrl
                  : fallbackUrl;
          })
          .catch(function() {
              location.href = fallbackUrl;
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
